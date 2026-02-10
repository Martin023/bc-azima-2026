report 52186130 "AML Report Transactions"
{
    ApplicationArea = All;
    Caption = 'AML Report Transactions';
    UsageCategory = ReportsAndAnalysis;
    RDLClayout = './bc-azima-2026/Layout/AML Report (ALL).rdl';
    dataset
    {
        dataitem(Savings_Ledger_Entry; "Savings Ledger Entry")
        {
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
            column(Customer_No; "Customer No.")
            {
            }
            column(Debit_Amount; "Debit Amount")
            {
            }
            column(Credit_Amount; "Credit Amount")
            {
            }
            column(Document_No_; "Document No.")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Description; "Description")
            {
            }
            column(MemberName; MemberName)
            {
            }
            column(MemberNo; MemberNo)
            {
            }
            column(MaxTransAmt; MaxTransAmt)
            {
            }
            column(User_ID; "User ID")
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            trigger OnPreDataItem()
            begin
                Savings_Ledger_Entry.SetFilter("Amount (LCY)", '>%1|<%2', GenSetUp."AML Transaction Limit", -GenSetUp."AML Transaction Limit");
                if StartDate = 0D then
                    Savings_Ledger_Entry.SetFilter("Date Filter", '..%1', EndDate)
                else
                    Savings_Ledger_Entry.SetRange("Date Filter", StartDate, EndDate);

            end;

            trigger onaftergetrecord()
            begin
                if Savings_Ledger_Entry."Member No." = '' then begin
                    if Savingsaccount.GET(Savings_Ledger_Entry."Customer No.") then begin
                        MemberName := Savingsaccount.Name;
                        MemberNo := Savingsaccount."Member No.";
                    end;
                end
                else begin
                    MemberName := Savings_Ledger_Entry."Member Name";
                    MemberNo := Savings_Ledger_Entry."Member No."
                end;
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
                Group(Period)
                {
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date';
                    }
                }

            }
        }

    }

    trigger OnPreReport()
    begin
        GenSetUp.GET;
        GenSetUp.Testfield("AML Transaction Limit");
        MaxTransAmt := GenSetUp."AML Transaction Limit";

        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";

        If EndDate = 0D then
            EndDate := Today;
    end;

    var
        GenSetUp: record "General Set-Up";
        CompanyInformation: Record "Company Information";
        MaxTransAmt: Decimal;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Savingsaccount: Record "Savings Accounts";
        MemberName: text[150];
        MemberNo: Code[20];
        StartDate: Date;
        EndDate: Date;
        Members: Record "Members";
}