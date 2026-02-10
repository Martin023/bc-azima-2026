namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52185778 "Members with Incomplete Data"
{
    ApplicationArea = All;
    Caption = 'Members with Incomplete Data';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Members with Incomplete Data.rdl';
    dataset
    {
        dataitem(MemberApplication; "Member Application")
        {
            RequestFilterFields = "No.", Status, Name, "E-Mail", "Primary Identification", "Phone No.", Gender, "Date of Birth", "Employer Code", "Employer Name", "P.I.N Number";
            DataItemTableView = WHERE(Status = CONST(Pending), Status = CONST(Open), Status = CONST(Rejected));
            column(No; "No.")
            {
            }
            column(Status; Status)
            {
            }
            column(Name; Name)
            {
            }
            column(Email; "E-Mail")
            {
            }
            column(PhoneNo; "Phone No.")
            {
            }
            column(Gender; Gender)
            {
            }
            column(DOB; "Date of Birth")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            column(EmployerName; "Employer Name")
            {
            }
            column(KRAPIN; "P.I.N Number")
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
            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
            end;
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
