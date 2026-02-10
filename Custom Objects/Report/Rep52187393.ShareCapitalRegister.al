report 52187385 "Share Capital Register"
{
    ApplicationArea = All;
    Caption = 'Share Capital Register';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Share Capital Register.rdl';
    ///FOR FINANCE
    dataset
    {

        //Member share capital report (Mno, TSC NO, Employer code, Recovered, not recovered, transfers, amount)
        dataitem(Members; Members)
        {
            DataItemTableView = where("Account Type" = filter("Single Member Account"));
            RequestFilterFields = "No.";
            column(MemberNumber; "No.")
            {
            }
            column(Payroll_Staff_No_; "Payroll/Staff No.")
            {
            }
            column(TSC_Number; "TSC Number") { }
            column(ShareCapAccNo; ShareCapAccNo) { }
            column(CummulativeShareCap; CummulativeShareCap) { }
            column(StartDate; StartDate) { }
            column(EndDate; EndDate) { }
            column(AsAt; AsAt) { }
            column(MemberName; Name)
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            column(AmountPaid; AmountPaid)
            {
            }
            column(ActualBal; ActualBal)
            {
            }
            column(ExpectedAmounts; ExpectedAmounts)
            {
            }
            column(Variance; Variance)
            {
            }
            column(NotRecovered; NotRecovered)
            {
            }
            column(TransferedShareCapBal; TransferedShareCapBal)
            {

            }
            /*
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            */
            trigger OnAfterGetRecord()
            var
                myInt: Integer;

            begin
                CummulativeShareCap := 0;
                AmountPaid := 0;
                TransferedShareCapBal := 0;
                NotRecovered := 0;
                ActualBal := 0;
                ShareCapAccNo := '';
                ExpectedAmounts := 0;
                Variance := 0;


                GenSetups.GET;
                //if "Account Category" = "Account Category"::Member THEN
                ExpectedAmounts := GenSetups."Minimum Share Capital";
                //Society Position Field

                if AsAt = 0D then begin
                    SavingsAccount.Reset();
                    SavingsAccount.SetRange("Member No.", Members."No.");
                    SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Share Capital");
                    if SavingsAccount.FIND('-') then begin
                        SavingsLedgerEntry.Reset();
                        SavingsLedgerEntry.SetRange("Member No.", SavingsAccount."Member No.");
                        SavingsLedgerEntry.SetRange("Customer No.", SavingsAccount."No.");
                        SavingsLedgerEntry.SetRange("Reversed", FALSE);
                        SavingsLedgerEntry.SetRange("Customer Posting Group", 'SHARES');//---------to be uncommented
                        SavingsLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                        if SavingsLedgerEntry.Find('-') then begin
                            SavingsLedgerEntry.CalcSums("Amount (LCY)");
                            AmountPaid := SavingsLedgerEntry."Amount (LCY)" * -1;
                        end;

                        SavingsAccount.CalcFields("Balance (LCY)");
                        ActualBal := SavingsAccount."Balance (LCY)";
                        ShareCapAccNo := SavingsAccount."No.";

                    end;
                end
                else
                    if StartDate = 0D then begin
                        SavingsAccount.Reset();
                        SavingsAccount.SetRange("Member No.", Members."No.");
                        SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Share Capital");
                        SavingsAccount.SetFilter("Date Filter", '..' + Format(AsAt));
                        if SavingsAccount.FIND('-') then begin
                            SavingsLedgerEntry.Reset();
                            SavingsLedgerEntry.SetRange("Member No.", SavingsAccount."Member No.");
                            SavingsLedgerEntry.SetRange("Customer No.", SavingsAccount."No.");
                            SavingsLedgerEntry.SetRange("Reversed", FALSE);
                            SavingsLedgerEntry.SetRange("Customer Posting Group", 'SHARES');
                            SavingsLedgerEntry.SetFilter("Posting Date", '..%1', AsAt);
                            if SavingsLedgerEntry.Find('-') then begin
                                SavingsLedgerEntry.CalcSums("Amount (LCY)");
                                AmountPaid := SavingsLedgerEntry."Amount (LCY)" * -1;
                            end;
                            SavingsAccount.CalcFields("Balance (LCY)");
                            ActualBal := SavingsAccount."Balance (LCY)";
                            ShareCapAccNo := SavingsAccount."No.";
                        end;
                    end;


                Variance := ExpectedAmounts - ActualBal;

                // SavingsLedgerEntry.RESET;
                // SavingsLedgerEntry.SETRANGE("Customer No.", SavingsAccount."No.");
                // SavingsLedgerEntry.setrange("Reversed", FALSE);
                // //SavingsLedgerEntry.setrange("Posting Date", StartDate, EndDate);
                // if SavingsLedgerEntry.FindFirst() then begin
                //     SavingsLedgerEntry.CalcSums("Credit Amount (LCY)");
                //     AmountPaid := SavingsLedgerEntry."Credit Amount (LCY)";
                //     NotRecovered := ExpectedAmounts - AmountPaid;
                //     if AmountPaid >= ExpectedAmounts then begin
                //         NotRecovered := 0;
                //     end;
                // end
                // else
                //     currReport.Skip;
                //end;

                SavingsAccount.Reset();
                SavingsAccount.SetRange("Member No.", Members."No.");
                SavingsAccount.SETRANGE("Product Category", SavingsAccount."Product Category"::"Transfered Share Capital");
                SavingsAccount.SetFilter("Date Filter", '..' + Format(AsAt));
                if SavingsAccount.FindFirst() then begin
                    SavingsAccount.CalcFields("Balance (LCY)");
                    TransferedShareCapBal := SavingsAccount."Balance (LCY)";
                end;

                CummulativeShareCap := TransferedShareCapBal + ActualBal;

            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                //SavingsLedger.SetFilter("Posting Date", '%1..%2', StartDate, EndDate, AsAt);
            end;
            // Member share capital report (Mno, TSC NO, Employer code, Recovered, not recovered, transfers, amount)

            //}

            // trigger OnAfterGetRecord()
            // var
            //     myInt: Integer;
            // begin
            //     SavingsAccounts.Reset();
            //     SavingsAccounts.SETRANGE(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"Share Capital");

            //     if SavingsAccounts.Find('-') then
            //         SavingsAccounts.CalcFields("Balance (LCY)");

            //     GenSetups.GET;
            //     if SavingsAccounts."Balance (LCY)" >= GenSetups."Minimum Share Capital" then begin
            //         repeat
            //             Source_Member_No := SavingsAccounts."Member No.";
            //             Source_Member_Name := SavingsAccounts.Name;
            //             if SavingsAccounts."Balance (LCY)" < GenSetups."Minimum Share Capital" then
            //                 CurrReport.Skip();
            //         until SavingsAccounts.Next = 0;
            //     end
            // end;

            // trigger OnPreDataItem()
            // begin
            //     CompanyInformation.Get;
            //     CompanyInformation.CalcFields(Picture);
            // end;
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
                    field(StartDate; StartDate) { }
                    field(EndDate; EndDate) { }
                    field(AsAt; AsAt) { }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    // procedure GetEntryNo(SavingsAcc: Record "Savings Accounts"): Integer
    // begin
    //     SavingsLedger.reset;
    //     SavingsLedger.setrange("Member No.", Members."No.");
    //     SavingsLedger.SetCurrentKey("Entry No.");
    //     SavingsLedger.Ascending(false);
    //     SavingsLedger.SetFilter("Posting Date", '%1..%2', StartDate, EndDate, AsAt);
    //     if SavingsLedger.Find('-') then
    //         exit(SavingsLedger."Entry No.");

    // end;

    trigger OnPreReport()
    begin
        if StartDate <> 0D then
            if EndDate = 0D then
                Error('End Date is required.');
        /*if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    */
    end;

    var
        /*  CompanyInformation: Record "Company Information";
          CompanyAddress: Text;
          CompanyTelephone: Text;
          CommunicationOnline: Text;
          */
        Source_Member_No: Code[20];
        Source_Member_Name: Text[100];
        //Destination_Member_No: Code[20];
        //Destination_Member_Name: Text[100];
        LinesDestination_Member_No: Code[20];
        LinesDestination_Member_Name: Text[100];
        LinesTransfer_Amount: Decimal;
        GenSetups: Record "General Set-up";
        MinShareCap: Decimal;
        SavingsAccount: Record "Savings Accounts";
        MemberClass: Record "Member Classes";
        ExpectedAmounts: Decimal;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        AmountPaid: Decimal;
        NotRecovered: Decimal;
        TransferedShareCapBal: Decimal;
        CummulativeShareCap: Decimal;
        //SavingsLedger: Record "Savings Ledger Entry";
        StartDate: Date;
        EndDate: Date;
        AsAt: Date;
        ActualBal: decimal;
        ShareCapAccNo: Code[20];
        Variance: Decimal;
}
