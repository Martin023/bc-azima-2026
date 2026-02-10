namespace ALProject.ALProject;
using Microsoft.Foundation.Company;

report 52186986 "Tax Exemption Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Tax Exemption.rdl';
    dataset
    {

        dataitem(Members; Members)
        {
            DataItemTableView = where("Any Physical Disability" = const(true));
            column(No_; "No.")
            {

            }
            column(fullname; Members.Name)
            {

            }
            column(Payroll_Staff_No_; "Payroll/Staff No.")
            {

            }
            column(Any_Physical_Disability; "Any Physical Disability")
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
            dataitem("Certificate Management"; "Certificate Management")
            {
                DataItemLink = "Record ID" = field("No.");
                column(Document_No_; "Document No.")
                {

                }
                column(Start_Date; "Start Date")
                {

                }
                column(End_Date; "End Date")
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
