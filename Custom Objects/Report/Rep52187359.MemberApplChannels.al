report 52187359 "Member Appl Channels"
{
    ApplicationArea = All;
    Caption = 'Member Appl Channels';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Member Appl Channels.rdl';
    dataset
    {
        dataitem(CompanyHeader; "Company Information")
        {
            DataItemTableView = sorting("Primary Key");
            MaxIteration = 1;
 
            column(CompanyInformation_Name; Name)
            {
            }
            column(CompanyInformation_Picture; Picture)
            {
            }
 
            trigger OnPreDataItem()
            begin
                CalcFields(Picture);  // load BLOB here, once
            end;
        }
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Source Aplication";
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(RegistrationDate; "Registration Date")
            {
            }
            column(SourceApplication; "Source Aplication")
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
        if CompanyInformation.Get then begin
            CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
            CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
            CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
        end;
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
