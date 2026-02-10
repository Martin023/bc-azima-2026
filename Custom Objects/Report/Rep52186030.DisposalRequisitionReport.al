namespace ALProject.ALProject;
using Microsoft.Foundation.Company;

report 52186030 "Disposal Requisition Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Disposal Requisition Report.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(DisposalLines; "Disposal Lines")
        {
            column(HeaderNo; "Header No")
            {
            }
            column(ItemNo; "Item No")
            {
            }
            column(ItemName; "Item Name")
            {
            }
            column(Expiry; Expiry)
            {
            }
            column(Inventory; Inventory)
            {
            }
            column(ItemLocation; "Item Location")
            {
            }
            column(DisposalReason; "Disposal Reason")
            {
            }
            column(DisposalMethod; "Disposal Method")
            {
            }
            column(Conditon; Conditon)
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
            dataitem("Stock Keeping"; "Stock Keeping")
            {
                DataItemLink = No = field("Header No");
                DataItemTableView = where(types = filter(Disposal));
                RequestFilterFields = Status;
                column(Status; Status)
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
