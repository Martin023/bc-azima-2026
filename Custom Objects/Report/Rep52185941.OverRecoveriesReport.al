report 52185941 "Over Recoveries Report"
{
    ApplicationArea = All;
    Caption = 'Over Recoveries Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/Over Recoveries Report.rdl';
    dataset
    {
        dataitem(CheckoffLines; "Checkoff Lines")
        {
            DataItemTableView = where(Posted = const(true), "Refundable Amount" = filter(> 0));
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
            column(Amount; Amount)
            {
            }
            column(ClearsLoan; "Clears Loan")
            {
            }
            column(LoanNo; "Loan No.")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(Name; Name)
            {
            }
            column(PayrollNo; "Payroll No.")
            {
            }
            column(Posted; Posted)
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(RefundableAmount; "Refundable Amount")
            {
            }
            column(CheckoffHeader; "Checkoff Header")
            {
            }
            column(Type; "Type")
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
        CompanyAddress: Text[250];
        CompanyTelephone: Text[250];
        CommunicationOnline: Text[250];
}
