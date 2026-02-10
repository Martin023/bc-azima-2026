report 52185892 "Imprest Surrender Report"
{
    ApplicationArea = All;
    Caption = 'Imprest Surrender Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-kenpipe-2024/Layout/Imprest Surrender Report.rdl';
    dataset
    {
        dataitem(ImprestSurrenderHeader; "Imprest Surrender Header")
        {
            RequestFilterFields = Status, Posted, "Account No.", "Date Posted", "Global Dimension 1 Code", "Global Dimension 2 Code", "Payment Release Date";
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
            column(No; No)
            {
            }
            column(Payee; Payee)
            {
            }
            column(AccountName; "Account Name")
            {
            }
            column(AccountNo; "Account No.")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(AmountSurrenderedLCY; "Amount Surrendered LCY")
            {
            }
            column(NetAmount; "Net Amount")
            {
            }
            column(TransactionName; "Transaction Name")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Apply_to_ID; "Apply to ID")
            {
            }
            column(Payment_Release_Date; "Payment Release Date")
            {
            }
            column(Actual_Spent; "Actual Spent")
            {
            }
        }
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

}
