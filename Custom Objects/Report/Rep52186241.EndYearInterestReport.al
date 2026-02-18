namespace KenpipeCBS.KenpipeCBS;
using Microsoft.Foundation.Company;

report 52186241 "End Year Interest Report"
{
    ApplicationArea = All;
    Caption = 'End Year Interest Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/End Year Account Interest.rdl';
    dataset
    {
        dataitem(EndYearTransferHeader; "End Year Transfer Header")
        {
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
            column(No; "No.")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(DistributedAmount; "Distributed Amount")
            {
            }
            column(Description; Description)
            {
            }
            column(ProductName; "Product Name")
            {
            }
            column(ProductType; "Product Type")
            {
            }
            dataitem(EndYearTransferLine; "End Year Interest Buffer")
            {
                DataItemLink = No = field("No.");
                column(Account_No; "Account No")
                {
                }
                column(Name; Name)
                {
                }
                column(Account_Balance; "Account Balance")
                {
                }
                column(Interest_Amount; "Interest Amount")
                {
                }
                column(Wtax; Wtax)
                {
                }
                column(Interest_Date; "Interest Date")
                {
                }
                column(Net_Interest; "Net Interest")
                {
                }
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
