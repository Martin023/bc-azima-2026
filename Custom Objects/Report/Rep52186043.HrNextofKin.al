report 52186044 HrNextofKin
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/HR Next Of Kin Report.rdl';


    dataset
    {
        dataitem(Hremployees; "HR Employees")
        {
            RequestFilterFields = "No.";
            column(No_; "No.")
            {

            }
            column(FullName; FullName)
            {

            }

            dataitem(HREmployeeKin; "HR Employee Kin")
            {
                DataItemLink = "Employee Code" = field("No.");

                column(RelationshipK; HREmployeeKin.Relationship)
                {
                }

                column(OtherNamesK; HREmployeeKin."Other Names")
                {
                }
                column(IDNoPassportNoK; HREmployeeKin."ID No/Passport No")
                {
                }
                column(AddressK; HREmployeeKin.Address)
                {
                }
                column(HomeTelNoK; HREmployeeKin."Home Tel No")
                {
                }
                column(TypeK; HREmployeeKin.Type)
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
