namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52185810 "Surety Report"
{
    ApplicationArea = All;
    Caption = 'Surety Report';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Surety Report.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(SuretyManagement; "Surety Management")
        {
            RequestFilterFields = "Surety No", Date, Signatory, Posted;
            column(SuretyNo; SuretyManagement."Surety No")
            {
            }
            column(Date; Date)
            {
            }
            column(Member_Nos; "Account No")
            {
            }
            column(Member_Name; "Member Name")
            {
            }
            column(BOSA_Acc_No_; "BOSA Acc No.")
            {
            }
            Column(BOSABal; Amount)
            {
            }
            column(Liabilities; "Outstanding Balance")
            {
            }
            column(Accused; Accused)
            {
            }
            column(Court_Name; "Court Name")
            {
            }
            column(Court_Address; "Court Address")
            {
            }
            column(Court_Physical_Address; "Court Physical Address")
            {
            }
            column(Case_No; "Case No")
            {
            }
            column(Surety_Amount; "Surety Amount")
            {
            }
            column(Signatory; Signatory)
            {
            }
            column(Posted; Posted)
            {
            }
            COlumn(Status; Status)
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
