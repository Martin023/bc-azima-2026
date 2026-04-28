report 52186018 "Generate Bulk Refunds"
{
    Caption = 'Generate Bulk Refunds';
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

                // CheckoffHeaderR.Reset();
                // CheckoffHeaderR.SetRange(CheckoffHeaderR."No.", CheckoffHeader);
                // CheckoffHeaderR.setrange(Posted, true);
                // CheckoffHeaderR.SetRange("CheckOff Type", CheckoffHeaderR."CheckOff Type"::Loans);
                // if CheckoffHeaderR.FindFirst() then begin
                //     checkofflines.Reset();
                //     checkofflines.SetRange("Checkoff Header", CheckoffHeader);
                //     checkofflines.SetRange("Savings Account", true);
                //     checkofflines.SetFilter(Amount, '>0');
                //     if checkofflines.FindFirst()
                //     then begin
                //         repeat
                //             if SavingsAccounts.get(checkofflines."Account No.") then begin
                //                 LoansInterest.Init();
                //                 LoansInterest."Refund Header No." := "Interest Header"."No";
                //                 LoansInterest."Member No." := SavingsAccounts."Member No.";
                //                 LoansInterest."No." += 1;
                //                 LoansInterest."Source Account" := SavingsAccounts."No.";
                //                 if checkofflines.Amount > SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.") then
                //                     LoansInterest.Amount := SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.")
                //                 else
                //                     LoansInterest.Amount := checkofflines.Amount;
                //                 LoansInterest."Destination Account" := '';
                //                 LoansInterest."Loan No." := '';
                //                 LoansInterest.Description := "Interest Header".Description;
                //                 if LoansInterest.Amount > 0 then
                //                     LoansInterest.Insert(true);
                //             end;
                //         until checkofflines.Next() = 0
                //     end;
                // end;

                SavingsAccounts.Reset();
                SavingsAccounts.SetRange("Employer Code", EmployerCode);
                SavingsAccounts.setrange(SavingsAccounts."Product Type", 'UFS');
                //SavingsAccounts.SetRange("CheckOff Type", CheckoffHeaderR."CheckOff Type"::Loans);
                if SavingsAccounts.FindFirst() then begin
                    // checkofflines.Reset();
                    // checkofflines.SetRange("Checkoff Header", CheckoffHeader);
                    // checkofflines.SetRange("Savings Account", true);
                    // checkofflines.SetFilter(Amount, '>0');
                    // if checkofflines.FindFirst()
                    // then begin
                    repeat
                        SavingsAccounts.CalcFields("Balance (LCY)");
                        if SavingsAccounts."Balance (LCY)" > 0 then begin
                            LoansInterest.Init();
                            LoansInterest."Refund Header No." := "Interest Header"."No";
                            LoansInterest."Member No." := SavingsAccounts."Member No.";
                            LoansInterest."No." += 1;
                            LoansInterest."Source Account" := SavingsAccounts."No.";
                            // if checkofflines.Amount > SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.") then
                            //     LoansInterest.Amount := SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.")
                            // else
                            LoansInterest.Amount := SavingsAccounts."Balance (LCY)";
                            LoansInterest."Destination Account" := '';
                            LoansInterest."Loan No." := '';
                            LoansInterest."Source Description" := "Interest Header".Description;
                            if LoansInterest.Amount > 0 then
                                LoansInterest.Insert(true);
                        end;
                    until SavingsAccounts.Next() = 0
                    // end;
                end;

            end;

            // if not loans.Find('-') then begin
            //     FosaAcc.reset;
            //     FosaAcc.SetRange("Member No.", SavingsAccounts."Member No.");
            //     FosaAcc.SetRange("Loan Disbursement Account", true);
            //     FosaAcc.SetRange(Blocked, Blocked::" ");
            //     if FosaAcc.Find('-') then begin
            //         LoansInterest.Init();
            //         LoansInterest."Refund Header No." := "Interest Header"."No";
            //         LoansInterest."Member No." := SavingsAccounts."Member No.";
            //         LoansInterest."No." += 1;
            //         LoansInterest."Source Account" := SavingsAccounts."No.";
            //         LoansInterest.Validate("Source Account");
            //         LoansInterest.Amount := SavingsAccounts.GetAvailableBalance(SavingsAccounts."No.");
            //         LoansInterest.Validate(Amount);
            //         LoansInterest."Destination Account" := FosaAcc."No.";
            //         LoansInterest.Validate("Destination Account");
            //         LoansInterest.Description := "Interest Header".Description;
            //         LoansInterest.Insert(true);
            //     end;
            // end;
            //end;

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
                    // field(CheckoffHeader; CheckoffHeader)
                    // {
                    //     Caption = 'Checkoff Header No.';
                    //     tablerelation = "Checkoff Header" where(Posted = filter(true), "CheckOff Type" = const(Loans));
                    // }
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
        FosaAcc: Record "Savings Accounts";
        members: Record Members;
        RefundHeader: Record "Refund,Account Transfer Header";
        GettheFilters: Text;
        // checkofflines: record "Checkoff Lines";
        // CheckoffHeader: code[50];
        SavingsAccounts: record "Savings Accounts";
        // CheckoffHeaderR: record "Checkoff Header";
        EmployerCode: Code[50];
}
