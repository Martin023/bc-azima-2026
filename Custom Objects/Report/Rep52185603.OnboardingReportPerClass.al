report 52185603 "Onboarding Report Per Class"
{
    ApplicationArea = All;
    Caption = 'Member Onboarding Report Per Class';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Onboarding Report Per Class.rdl';
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", Status, "Member Class", "Registration Date", Age, "Branch Name", County, "Sub-County";
            column(No; "No.")
            {
            }
            column(MemberClass; "Member Class")
            {
            }
            column(MemberSegment; "Member Segment")
            {
            }
            column(Name; Name)
            {
            }
            column(PrimaryIdentificationType; "Primary Identification Type")
            {
            }
            column(PrimaryIdentification; "Primary Identification")
            {
            }
            column(RegistrationDate; "Registration Date")
            {
            }
            column(DateApproved; "Date Approved")
            {
            }
            column(AccountType; "Account Type")
            {
            }
            column(AccountProfile; "Account Profile")
            {
            }
            column(AccountCategory; "Account Category")
            {
            }
            column(Gender; Gender)
            {
            }
            column(Status; Status)
            {
            }
            column(Subflag; Subflag)
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


    Var
        CompanyInformation: Record "Company Information";

        EmployerName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
