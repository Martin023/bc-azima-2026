#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186064 "Posted Invoices"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Posted Invoices.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("Posting Date") order(ascending);
            column(CompanyInformation_Name;
            CompanyInformation.Name)
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
            column(SCount; SNo)
            {
            }
            column(No_; "No.")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {
            }
            column(Due_Date; "Due Date")
            {
            }
            column(Work_Description; "Work Description")
            {
            }
            column(User_ID; "User ID")
            {

            }
            column(Pre_Assigned_No_; "Pre-Assigned No.")
            {

            }


            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(Description; Description)
                {
                }
                column(Narration; Narration)
                {

                }
                column(Quantity; Quantity)
                {
                }
                column(Amount; Amount)
                {
                }
                column(Amount_Including_VAT; "Amount Including VAT")
                {
                }
                column(Unit_Price; "Unit Price")
                {
                }
                column(VATAmount; VATAmount)
                {

                }
                trigger OnAfterGetRecord()
                begin
                    SalesLine.Reset();
                    SalesLine.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                    if SalesLine.FindFirst() then begin
                        VATAmount := SalesLine."Amount Including VAT" - SalesLine.Amount;
                    end;
                end;


            }
            trigger OnAfterGetRecord()
            begin
                SNo += 1;
            end;

            trigger OnPreDataItem()
            begin
                if StartDate = 0D then StartDate := 19900101D;
                if EndDate = 0D then EndDate := Today;
                "Sales Invoice Header".SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
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

    labels
    {
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
        SNo: Integer;
        ShowTotoDetail: Boolean;
        VATAmount: Decimal;
        SalesLine: Record "Sales Invoice Line";
        StartDate: Date;
        EndDate: Date;
}
