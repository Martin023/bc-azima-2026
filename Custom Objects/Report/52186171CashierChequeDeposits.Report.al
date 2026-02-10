#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186171 "Cashier Cheque Deposits"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Cashier Cheque Deposits Report.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Cashier Transactions"; "Cashier Transactions")
        {
            RequestFilterFields = "Date Posted", "Account No", Type, "Cheque Type", "Cheque Date";
            DataItemTableView = where(Type = filter("Cheque Deposit"), Posted = filter(true));
            column(No; No)
            {

            }
            column(Date_Posted; "Date Posted")
            {

            }
            column(Account_No; "Account No")
            {

            }
            column(Account_Name; "Account Name")
            {

            }
            column(Cheque_Type; "Cheque Type")
            {

            }
            column(Cheque_No; "Cheque No")
            {

            }
            column(Cheque_Date; "Cheque Date")
            {

            }
            column(Amount; Amount)
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

            end;

            trigger OnPreDataItem()
            begin
                "Cashier Transactions".SetFilter("Date Posted", '>%1', "Cashier Transactions"."Date Posted");
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
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        CalcRunningAccBalance: Codeunit "Calc. Running Acc. Balance";
        BankAcc: Record "Bank Account";
        CashierTrans: Record "Cashier Transactions";
        AccountNo: Code[100];
        AccountName: Text[100];
        TransType: Enum "Fosa Transaction Types";

}
