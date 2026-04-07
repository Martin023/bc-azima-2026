report 52186237 "Recover Arrears"
{
    Caption = 'Recover Arrears ';
    ProcessingOnly = true;
    dataset
    {
        dataitem("Interest Header"; "Refund,Account Transfer Header")
        {
            RequestFilterFields = No;
            trigger OnAfterGetRecord()
            begin
                LoansInterest.reset();
                LoansInterest.setrange("Refund Header No.", "Interest Header"."No");
                if LoansInterest.findset then
                    LoansInterest.DeleteAll();

                SavingsAccounts.Reset();
                if EmployerCode <> '' then
                    SavingsAccounts.SetRange("Employer Code", EmployerCode);
                if Product <> '' then
                    SavingsAccounts.SetRange("Product Type", Product)
                else
                    SavingsAccounts.setrange(SavingsAccounts."Product Type", '191');
                if SavingsAccounts.FindFirst() then begin
                    repeat
                        SavingsAccounts.CalcFields("Balance (LCY)");
                        if SavingsAccounts."Balance (LCY)" > 0 then begin
                            //calculate loan arrears
                            AsAtDate := Today;

                            loans.Reset();
                            loans.SetRange("Member No.", SavingsAccounts."Member No.");
                            loans.CalcFields("Total Loan Balance");
                            loans.SetFilter("Total Loan Balance", '>0');
                            if loans.FindSet() then begin
                                repeat
                                    loansProcess.CalculateLoanArrears(loans, SASRAarr, SASRAarr, AsAtDate, true);
                                until loans.next = 0;
                            end;
                            //end of calculate loan arrears
                            RunBal := SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");

                            //Search for loans with arrears
                            loans.Reset();
                            loans.setRange("Member No.", SavingsAccounts."Member No.");
                            loans.SetFilter("Loan Product Type", '<>FGL&<>BGL');
                            loans.CalcFields("Total Balance", "Amount In Arreas SASRA");
                            loans.SetFilter("Total Balance", '>0');
                            if ArrearsAmt > 0 then
                                loans.setfilter("Amount In Arreas SASRA", '1..%1', ArrearsAmt);
                            if loans.findset() then begin
                                repeat
                                    MaxAmt := 0;
                                    AmtDeducted := 0;
                                    loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Total Loan Balance", "Amount In Arreas SASRA");
                                    MaxAmt := loans."Amount In Arreas SASRA";
                                    if RunBal > 0 then begin
                                        // if RunBal <= MaxAmt then begin
                                        if (loans."Total Loan Balance") > 0 then begin
                                            LoansInterest.Init();
                                            LoansInterest."Refund Header No." := "Interest Header"."No";
                                            LoansInterest."Member No." := SavingsAccounts."Member No.";
                                            LoansInterest."No." += 1;
                                            LoansInterest."Source Account" := SavingsAccounts."No.";
                                            LoansInterest.Name := SavingsAccounts.Name;
                                            LoansInterest."Loan No." := loans."Loan No.";
                                            LoansInterest."Total Destination Loan Balance" := loans."Total Loan Balance";
                                            LoansInterest."Recover Arrears" := true;
                                            // LoansInterest.Amount := SavingsAccounts."Balance (LCY)";                        
                                            if MaxAmt >= RunBal then begin
                                                LoansInterest.Amount := RunBal;
                                                AmtDeducted += RunBal;
                                                RunBal := 0;
                                            end
                                            else begin
                                                LoansInterest.Amount := MaxAmt;
                                                RunBal -= Abs(MaxAmt);
                                                AmtDeducted += Abs(MaxAmt);
                                            end;
                                            LoansInterest.Description := "Interest Header".Description;
                                            if "Interest Header"."Send SMS" then begin
                                                if LoansInterest.Amount > 100 then
                                                    LoansInterest.Message := 'Dear ' + LoansInterest.Name + ', arrears of ' + Format(LoansInterest.Amount) + ' has been recovered for ' + Loans."Loan Product Type Name" + ': ' + Loans."Loan No." + ' on ' + Format(Today) + ' ' + Format(Time)
                                                else
                                                    LoansInterest.Message := 'No SMS sent, amount is below minimum threshold of 100.';
                                            end;
                                            if LoansInterest.Amount > 0 then
                                                LoansInterest.Insert(true);

                                            // end;


                                        end;


                                    end;
                                until loans.next = 0;
                            end;
                            //Post Excess to ordinary acc.
                            if (Product <> '') and (Product = '10') then begin
                                SavingAccII.reset();
                                SavingAccII.setRange("Product Type", '191');
                                SavingAccII.SetRange("Member No.", SavingsAccounts."Member No.");
                                if SavingAccII.FindFirst() then begin
                                    LoansInterest.Reset();
                                    LoansInterest.setrange("Refund Header No.", "Interest Header"."No");
                                    if LoansInterest.findlast() then
                                        Entr := LoansInterest."No.";
                                    LoansInterest.Init();
                                    LoansInterest."Refund Header No." := "Interest Header"."No";
                                    LoansInterest."Member No." := SavingAccII."Member No.";
                                    LoansInterest."No." := Entr + 1;
                                    LoansInterest."Source Account" := SavingsAccounts."No.";
                                    LoansInterest.Name := SavingsAccounts.Name;
                                    LoansInterest."Loan No." := '';
                                    LoansInterest."Total Destination Loan Balance" := 0;
                                    LoansInterest."Destination Account" := SavingAccII."No.";
                                    LoansInterest."Recover Arrears" := true;
                                    // LoansInterest.Amount := SavingsAccounts."Balance (LCY)";                        
                                    if RunBal > 0 then
                                        LoansInterest.Amount := RunBal;
                                    LoansInterest.Description := "Interest Header".Description;
                                    if LoansInterest.Amount > 0 then
                                        LoansInterest.Insert(true);
                                end;
                            end;

                        end;
                    until SavingsAccounts.Next() = 0;
                    // end;

                end;

            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                Message('Process Complete');
            end;
        }

    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(Product; Product)
                    {
                        Caption = 'From Product';
                        tablerelation = "Product Factory"."Product ID" where("Product Class Type" = const(Savings));
                        ApplicationArea = Basic, Suite;
                    }
                    field(ArrearsAmt; ArrearsAmt)
                    {
                        Caption = 'Arrears Amount.';
                        MinValue = 0;
                        MaxValue = 10000000;
                    }
                    field(EmployerCode; EmployerCode)
                    {
                        Caption = 'Employer Code';
                        tablerelation = Customer where("Account Type" = const(Employer));
                    }
                }
            }
        }



    }
    trigger OnPreReport()
    var
        SeriesSetup: Record "Credit Nos. Series";
    begin
        LoansInterest.Reset();
        LoansInterest.SetRange(LoansInterest."Refund Header No.", "Interest Header"."No");
        LoansInterest.DeleteAll();


        //if CheckoffHeader = '' then Error('Please Insert checkoff Header before proceeding');
        if EmployerCode = '' then Error('Please Insert Employer Code before proceeding');
    end;


    var
        LoansInterest: Record "refund,Account Transfer lines";
        loans: Record Loans;
        RunBal: Decimal;
        // checkofflines: record "Checkoff Lines";
        // CheckoffHeader: code[50];
        SavingsAccounts: record "Savings Accounts";
        // CheckoffHeaderR: record "Checkoff Header";
        EmployerCode: Code[50];
        SASRAarr: Decimal;
        AsAtDate: Date;
        loansProcess: Codeunit "Loans Process";
        MaxAmt, AmtDeducted, ArrearsAmt : Decimal;
        Product: Code[20];
        SavingAccII: record "Savings Accounts";
        Entr: Integer;
}
