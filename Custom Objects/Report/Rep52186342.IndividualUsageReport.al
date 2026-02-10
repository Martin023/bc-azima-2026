report 52186342 "Individual Usage Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Individual Usage Report.rdl';

    dataset
    {
        dataitem(itemledgerentry; "item ledger entry")
        {
            column(ItemNo; "Item No.")
            {
            }
            column(Document_No_; "Document No.")
            {

            }

            column(EntryType; "Entry Type")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            {

            }
            column(Quantity; Quantity)
            {
            }
            column(RemainingQuantity; RemainQuantity)
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
            column(ReqDate; "Posting Date")
            {

            }

            dataitem(items; Item)
            {
                DataItemLink = "No." = field("Item No.");
                column(Description; Description)
                {
                }
                column(Inventory; Inventory)
                {

                }

            }



            trigger OnAfterGetRecord()
            var
                StoreReqHeader: record "Store Requistion Header";
            begin
                LedgerEntry.reset;
                LedgerEntry.SetRange("Item No.", itemledgerentry."Item No.");
                LedgerEntry.SetFilter("Entry No.", '<=%1', itemledgerentry."Entry No.");
                if LedgerEntry.find('-') then begin
                    LedgerEntry.CalcSums(Quantity);
                    RemainQuantity := LedgerEntry.Quantity;
                end;

            end;






            trigger OnPreDataItem()
            begin

                if startDate = 0D then
                    startDate := 19900101D;

                if Enddate = 0D then
                    Enddate := Today;
                itemledgerentry.SetRange("Posting Date", startDate, Enddate);

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

        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        ReqDate: Date;
        Branch: Code[20];
        Activity: code[30];
        startDate: date;
        Enddate: date;
        RemainQuantity: Decimal;
        InventoryQty: decimal;
        LedgerEntry: record "Item Ledger Entry";


}
