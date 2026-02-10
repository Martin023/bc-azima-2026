report 52186051 "Staff Welfare Claims"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Staff Welfare Report.rdl';
    dataset
    {
        dataitem(StaffWelfare; "Staff Welfare")
        {
            RequestFilterFields = status;
            column(EmployeeCode; "Employee Code")
            {
            }
            column(EmployeeName; "Employee Name")
            {
            }
            column(MemberNo; "Member No")
            {
            }
            column(PayrollNo; "Payroll No")
            {
            }
            column(Beneficiary; Beneficiary)
            {
            }
            column(Relationship; Relationship)
            {
            }
            column(No; No)
            {
            }
            column(Claimreason; "Claim reason")
            {
            }
            column(ClaimAmount; "Claim Amount")
            {
            }
            column(Date; "Date")
            {
            }
            column(PinNo; "Pin No")
            {
            }
            column(Status; Status)
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
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
