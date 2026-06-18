namespace AZIMA.AZIMA;
using Microsoft.Foundation.Company;

report 52185425 "Sales Routes Plan Report"
{
    ApplicationArea = All;
    Caption = 'Sales Routes Plan Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Sales Routes Plan Report.rdl';
    dataset
    {

        dataitem(CompanyInformation; "Company Information")
        {
            DataItemTableView = sorting("Primary Key");
            MaxIteration = 1;

            column(CompanyInformation_Name; Name) { }
            column(CompanyInformation_Picture; Picture) { }  // BLOB emitted only once
            column(CompanyAddress; CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code") { }
            column(CompanyTelephone; 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2") { }
            column(CommunicationOnline; 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page") { }


            trigger OnPreDataItem()
            begin
                CalcFields(Picture);  // load BLOB here, once
            end;
        }
        dataitem(SalesRoutePlans; "Sales Route Plans")
        {
            RequestFilterFields = Status, "Sales Representative", day, "Route Date";
            column(No; No)
            {
            }
            column(RouteDate; "Route Date")
            {
            }
            column(Day; Day)
            {
            }
            column(Target; Target)
            {
            }
            column(Achievements; Achievements)
            {
            }
            column(BDEComments; "BDE Comments")
            {
            }
            column(ApprovedBy; "Approved By")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
