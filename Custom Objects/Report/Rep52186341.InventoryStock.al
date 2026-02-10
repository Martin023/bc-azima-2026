report 52186341 InventoryStock
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Inventory Stock.rdl';
    dataset
    {
        dataitem(Item; Item)
        {
            column(ItemNo; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Inventory; Inventory)
            {
            }
            column(UnitCost; "Unit Cost")
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
            column(Last_Requisition_Date; "Last Requisition Date")
            {

            }
            column(Responsibility_Center; Department)
            {

            }
            column(Date_Received; "Date Received")
            {

            }
            column(Physical_Count; "Physical Count")
            {

            }
            // dataitem(SRLine;"Store Requistion Lines")
            // {
            //     DataItemLink="No."=field("No.");
            //     column( "Last Requisition Date";"Last Date of Issue")
            // }

            trigger OnAfterGetRecord()
            var
                SRHeader: record "Store Requistion Header";
            begin
                "Date Received" := 0D;
                "Last Requisition Date" := 0D;
                Department := '';

                SRLines.reset();

                SRLines.setrange("No.", Item."No.");
                SRLines.setrange("Last Date of Issue", startDate, Enddate);
                SRLines.SetCurrentKey("Last Date of Issue");
                SRLines.Ascending(true);
                if SRLines.FindLast() then begin
                    SRHeader.reset;
                    SRHeader.SetRange("No.", SRLines."Requistion No");

                    if SRHeader.Find('-') then begin
                        "Last Requisition Date" := SRLines."Last Date of Issue";
                        Department := SRHeader."shortcut Dimension 2 Code";
                        "Date Received" := SRHeader."Required Date";
                    end;
                end; //else CurrReport.skip;
            end;

            trigger OnPreDataItem()
            begin
                if startDate = 0D then
                    startDate := 19900101D;

                if Enddate = 0D then
                    Enddate := Today;

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
                    field(startDate; startDate)
                    {
                        Caption = 'Start Date';
                        ShowMandatory = true;

                    }
                    field(Enddate; Enddate)
                    {
                        Caption = 'End Date';
                        ShowMandatory = true;
                    }
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
        "Last Requisition Date": date;
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Department: code[20];
        "Date Received": date;
        SRLines: record "Store Requistion Lines";
        startDate: date;
        Enddate: date;

}
