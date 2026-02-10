report 52186339 "Dispatched Nominee Forms"
{
    ApplicationArea = All;
    Caption = 'Dispatched Nominee Forms';
    UsageCategory = ReportsAndAnalysis;
    Defaultlayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Dispatched Nominee Forms.rdl';

    dataset
    {
        dataitem(NomineeFormRequest; "Nominee Form Request")
        {
            RequestFilterFields = Dispatched;
            column(No; "No.")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(IdNumber; "Id Number")
            {
            }
            column(RequestedBy; "Created By")
            {
            }
            column(Dispatched_By; "Dispatched By")
            {
            }
            column(Dispatched_On; "Dispatched On")
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

        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
