#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185785 "Store Requisition"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Store Requisition.rdl';

    dataset
    {

        dataitem("Store Requistion Header"; "Store Requistion Header")
        {
            RequestFilterFields = "Global Dimension 1 Code", "Shortcut Dimension 2 Code", Posted, Status;

            column(No_StoreRequistionHeader; "No.")
            {
            }
            column(GlobalDimension1Code_StoreRequistionHeader; "Global Dimension 1 Code")
            {
            }
            column(QuantityIssued_StoreRequistionHeader; "Quantity Issued")
            {
            }
            column(Requestdate_StoreRequistionHeader; "Request date")
            {
            }
            column(RequiredDate_StoreRequistionHeader; "Required Date")
            {
            }
            column(Status_StoreRequistionHeader; Status)
            {
            }
            column(IssuingStore_StoreRequistionHeader; "Store Description")
            {
            }
            column(Posted_StoreRequistionHeader; Posted)
            {
            }
            column(RequesterID_StoreRequistionHeader; "Requester ID")
            {
            }
            column(RequestDescription_StoreRequistionHeader; "Request Description")
            {
            }
            column(UserID_StoreRequistionHeader; "User ID")
            {
            }
            column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
            {

            }
            column(Shortcut_Dimension_3_Code; "Shortcut Dimension 3 Code")
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
            column(Requestor; "User ID")
            {

            }
            dataitem("Store Requistion Lines"; "Store Requistion Lines")
            {
                DataItemTableView = where(type = filter(item));
                RequestFilterFields = "No.";

                DataItemLink = "Requistion No" = field("No.");
                column(No_; "No.")
                {

                }
                column(Description; Description)
                {

                }
                column(Quantity_Requested; "Quantity Requested")
                {

                }
                column(Qty_in_store; "Qty in store")
                {

                }
                column(Unit_Cost; "Unit Cost")
                {

                }
                column(Line_Amount; "Line Amount")
                {

                }
                trigger OnAfterGetRecord()
                begin
                    if "Store Requistion Lines".GetFilters = '' then
                        error('Please select a record in the request page');
                end;

                trigger OnPreDataItem()
                begin
                    "Store Requistion Lines".SetRange(Type, Type::Item);
                end;

            }
            trigger OnPreDataItem()
            begin
                if StartDate = 0D then
                    StartDate := 19900101D;
                if EndDate = 0D then
                    EndDate := Today;
                "Store Requistion Header".SetRange("Request date", StartDate, EndDate);
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
                group("Date Filter")
                {
                    field("Start Date"; StartDate)
                    {
                        ShowMandatory = true;
                    }
                    field("End Date"; EndDate)
                    {
                        ShowMandatory = true;
                    }
                }
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
        ItemNo: code[50];
        StartDate: Date;
        EndDate: Date;
}
