namespace MNS.MNS;
using System.Environment;
using Microsoft.Foundation.Company;

report 52185762 "Pending Insurance Claims"
{
    ApplicationArea = All;
    Caption = 'Pending Insurance Claims';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Pending Insurance Claims.rdl';
    dataset
    {
        dataitem(InsuranceClaims; "Insurance Claims")
        {
            RequestFilterFields = "Claim No.", "Asset No.", "Status", "Closed";
            DataItemTableView = WHERE(Closed = CONST(False));
            column(AmountinClaims; "Amount in Claims")
            {
            }
            column(AmountinCompensation; "Amount in Compensation")
            {
            }
            column(AssetDescription; "Asset Description")
            {
            }
            column(AssetNo; "Asset No.")
            {
            }
            column(ClaimNo; "Claim No.")
            {
            }
            column(Closed; Closed)
            {
            }
            column(DateofClaim; "Date of Claim")
            {
            }
            column(DateofClosure; "Date of Closure")
            {
            }
            column(DateofIncident; "Date of Incident")
            {
            }
            column(DateofReporting; "Date of Reporting")
            {
            }
            column(InsuranceNo; "Insurance No.")
            {
            }
            column(NatureoftheClaim; "Nature of the Claim")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(PolicyAmount; "Policy Amount")
            {
            }
            column(PolicyNo; "Policy No.")
            {
            }
            column(StaffResponsibleName; "Staff Responsible Name")
            {
            }
            column(StaffResponsiblePFNo; "Staff Responsible PF. No.")
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
        EmployerName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
