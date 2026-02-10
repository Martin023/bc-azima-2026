namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52185763 "Closed Insurance Claims"
{
    ApplicationArea = All;
    Caption = 'Closed Insurance Claims';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Closed Insurance Claims.rdl';
    dataset
    {
        dataitem(InsuranceClaims; "Insurance Claims")
        {
            RequestFilterFields = Status, Closed, "Asset No.";
            DataItemTableView = where(Status = const(Approved), Closed = const(TRUE));
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
            column(ClosedBy; "Closed By")
            {
            }
            column(CreatedBy; "Created By")
            {
            }
            column(CreatedDate; "Created Date")
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
