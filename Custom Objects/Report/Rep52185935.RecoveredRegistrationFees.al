report 52185935 "Recovered Registration Fees"
{
    ApplicationArea = All;
    Caption = 'Recovered Registration Fees';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-kenpipe-2024/Layout/Recovered Registration Fees.rdl';
    dataset
    {
        dataitem(Members; Members)
        {
            DataItemTableView = where(status = filter(<> New));
            RequestFilterFields = "Registration Date", "Rejoinig Date";
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
            column(No; "No.")
            {
            }
            column(PayrollStaffNo; "Payroll/Staff No.")
            {
            }
            column(Name; Name)
            {
            }
            column(RegistrationDate; "Registration Date")
            {
            }
            column(MemberClass; "Member Class")
            {
            }
            column(PhoneNo; "Phone No.")
            {
            }
            column(ExpectedAmounts; ExpectedAmounts)
            {
            }
            column(AmountPaid; AmountPaid)
            {
            }

            trigger OnAfterGetRecord()
            begin
                MemberClass.GET(Members."Member Class");
                ExpectedAmounts := MemberClass."Entrance Fee";

                SavingsAccount.Reset();
                SavingsAccount.SetRange("Member No.", Members."No.");
                SavingsAccount.SETRANGE("Product Category", SavingsAccount."Product Category"::"Entrance Fee");
                if SavingsAccount.FINDFIRST then begin
                    SavingsLedgerEntry.RESET;
                    SavingsLedgerEntry.SETRANGE("Customer No.", SavingsAccount."No.");
                    SavingsLedgerEntry.setrange("Reversed", FALSE);
                    SavingsLedgerEntry.setrange("Posting Date", StartDate, EndDate);
                    if SavingsLedgerEntry.FindFirst() then begin
                        SavingsLedgerEntry.CalcSums("Credit Amount (LCY)");
                        AmountPaid := SavingsLedgerEntry."Credit Amount (LCY)";
                    end
                    else
                        currReport.Skip;
                end;
                // else begin
                //     ProductSetUp.reset;
                //     ProductSetUp.SetRange("Product Category", ProductSetUp."Product Category"::"Entrance Fee");
                //     if ProductSetUp.FINDFIRST then begin
                //         AccNo := RegistrationProcessCU.CreateSavingsAccountNo(ProductSetUp."Product ID", Members."Global Dimension 1 Code", Members."No.");
                //     RegistrationProcessCU.AutoCreateSavingsAccount(AccNo, Members."No.", ProductSetUp."Product ID");
                // end;
            end;

            trigger OnPreDataItem()
            begin
                if StartDate = 0D then
                    StartDate := 19900101D;
                if EndDate = 0D then
                    EndDate := Today;
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
                    field("Start date"; StartDate)
                    {
                    }
                    field("End Date"; EndDate)
                    {
                    }
                }
            }
        }
        // actions
        // {
        //     area(processing)
        //     {
        //     }
        // }
    }
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;


    var
        SavingsAccount: Record "Savings Accounts";
        MemberClass: Record "Member Classes";
        ExpectedAmounts: Decimal;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text[250];
        CompanyTelephone: Text[250];
        CommunicationOnline: Text[250];
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        AmountPaid: Decimal;
        StartDate: Date;
        EndDate: Date;

}
