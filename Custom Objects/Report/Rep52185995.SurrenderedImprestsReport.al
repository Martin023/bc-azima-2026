
report 52186038 "Surrendered Imprests Report"
{
    ApplicationArea = All;
    Caption = 'Surrendered Imprests Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/Surrendered Imprests Report.rdl';
    dataset
    {
        dataitem(ImprestSurrenderHeader; "Imprest Surrender Header")
        {
            requestfilterfields = Status, Posted, "Global Dimension 1 Code", "Global Dimension 2 Code", "Account No.", "Payment Release Date";
            DataItemTableView = where(Posted = filter(true));
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
            column(EmployeeName; EmployeeName)
            {
            }
            column(EmployeeNo; EmployeeNo)
            {
            }
            trigger OnAfterGetRecord()
            begin
                UserSetUp.reset;
                UserSetUp.SetRange("User ID", ImprestSurrenderHeader."User ID");
                if UserSetUp.FindFirst then begin
                    HrEmployees.reset;
                    HrEmployees.SetRange("Employee UserID", UserSetUp."User ID");
                    if HrEmployees.FindFirst then
                        EmployeeName := HrEmployees."Full Name";
                    EmployeeNo := HREmployees."No."
                end;
            end;
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
        HREmployees: Record "HR Employees";
        UserSetUp: Record "User Setup";
        EmployeeName: Text;
        EmployeeNo: Code[20];
}


