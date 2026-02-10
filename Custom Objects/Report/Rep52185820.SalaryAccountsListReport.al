report 52185820 "Salary Accounts List Report"
{
    ApplicationArea = All;
    Caption = 'Salary Accounts List Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/Salary Accounts List.rdl';
    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            DataItemTableView = where("Product Category" = filter("FOSA Account"));
            column(No_SavingsAccounts; "Savings Accounts"."No.")
            {
            }
            column(Name_SavingsAccounts; "Savings Accounts".Name)
            {
            }
            column(PhoneNo_SavingsAccounts; "Savings Accounts"."Phone No.")
            {
            }
            column(GlobalDimension1Code_SavingsAccounts; "Savings Accounts"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_SavingsAccounts; "Savings Accounts"."Global Dimension 2 Code")
            {
            }
            column(Balance_SavingsAccounts; "Savings Accounts".Balance)
            {
            }
            column(Member_No_; "Savings Accounts"."Member No.")
            {
            }
            column(Product_Type; "Savings Accounts"."Product Type")
            {
            }
            column(Product_Name; "Savings Accounts"."Product Name")
            {
            }
            column(Status; "Savings Accounts".Status)
            {
            }
            column(Last_Transaction_Date; "Savings Accounts"."Last Transaction Date")
            {
            }
            column(SalaryReceived; "Savings Accounts"."Salary Received")
            {
            }
            column(PayrollStaffNo_SavingsAccounts; "Savings Accounts"."Payroll/Staff No.")
            {
            }
            column(IDNo_SavingsAccounts; "Savings Accounts"."ID No.")
            {
            }
            column(ATMTransactions_SavingsAccounts; "Savings Accounts"."ATM Transactions")
            {
            }
            column(ATMNo_SavingsAccounts; "Savings Accounts"."ATM No.")
            {
            }
            column(AccNo; "Savings Accounts".Balance)
            {
            }
            column(sno; SNo)
            {
            }
            column(ShowTotoDetail; ShowTotoDetail)
            {
            }
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

            trigger OnAfterGetRecord()
            begin
                SNo += 1;
            end;

            trigger OnPreDataItem()
            begin
                "Savings Accounts".calcfields("Salary Received");
                "Savings Accounts".SetFilter("Salary Received", '>%1', 0);
            end;

        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
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
        SNo: Integer;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        ShowTotoDetail: Boolean;
}