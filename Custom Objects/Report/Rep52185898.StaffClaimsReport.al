report 52185898 "Staff Claims Report"
{
    ApplicationArea = All;
    Caption = 'Staff Claims Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/Staff Claims Report.rdl';
    dataset
    {
        dataitem(StaffClaimsHeader; "Staff Claims Header")
        {
            RequestFilterFields = Status, Posted, "Posted By", "Date Posted", "Payment Release Date", "No.", Cashier, "Current Status", "Global Dimension 1 Code", "Shortcut Dimension 2 Code";
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
            column(AccountNo; "Account No.")
            {
            }
            column(No; "No.")
            {
            }
            column(Payee; Payee)
            {
            }
            column(Cashier; Cashier)
            {
            }
            column(PaymentReleaseDate; "Payment Release Date")
            {
            }
            column(DatePosted; "Date Posted")
            {
            }
            column(TotalPaymentAmount; "Total Payment Amount")
            {
            }
            column(TotalNetAmount; "Total Net Amount")
            {
            }
            column(PayingBankAccount; "Paying Bank Account")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; "Shortcut Dimension 2 Code")
            {
            }
            column(Status; Status)
            {
            }
            column(SurrenderStatus; "Surrender Status")
            {
            }
            column(PaymentType; "Payment Type")
            {
            }
            column(Posted_By; "Posted By")
            {
            }
            column(Posted; Posted)
            {
            }
            column(Total_Net_Amount_LCY; "Total Net Amount LCY")
            {
            }
            column(Paying_Bank_Account; "Paying Bank Account")
            {
            }
            columN(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
            }
            column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
            {
            }
            column(Payment_Type; "Payment Type")
            {
            }
            column(Account_No_; "Account No.")
            {
            }
            column(Account_Type; "Account Type")
            {
            }
            column(purpose; "Purpose")
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
