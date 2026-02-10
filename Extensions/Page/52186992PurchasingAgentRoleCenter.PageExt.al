#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186992 pageextension52186992 extends "Purchasing Agent Role Center"
{
    Caption = 'Role Center';
    layout
    {

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1907662708(Control 1907662708)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1902476008(Control 1902476008)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control25(Control 25)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control37(Control 37)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control21(Control 21)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control44(Control 44)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control45(Control 45)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control35(Control 35)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905989608(Control 1905989608)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control43(Control 43)".

        addafter(Control1905989608)
        {
            part(Control1903012608; "Copy Profile")
            {
                Visible = false;
            }
        }
    }
    actions
    {
        // modify("Vendor - T&op 10 List")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Vendor/&Item Purchases")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Inventory - &Availability Plan")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Inventory &Purchase Orders")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Inventory - &Vendor Purchases")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Inventory &Cost and Price List")
        // {
        //     ApplicationArea = Basic;
        // }
        modify(PurchaseOrders)
        {

            //Unsupported feature: Property Modification (Name) on "PurchaseOrders(Action 7)".

            ApplicationArea = Basic;
        }
        modify(PurchaseOrdersPendConf)
        {

            //Unsupported feature: Property Modification (Name) on "PurchaseOrdersPendConf(Action 3)".

            ApplicationArea = Basic;
        }
        modify(PurchaseOrdersPartDeliv)
        {

            //Unsupported feature: Property Modification (Name) on "PurchaseOrdersPartDeliv(Action 23)".

            ApplicationArea = Basic;
        }
        modify("Purchase Quotes")
        {
            ApplicationArea = Basic;
        }
        modify("Blanket Purchase Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase Invoices")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase Return Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase Credit Memos")
        {
            ApplicationArea = Basic;
        }
        modify("Assembly Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Orders")
        {
            ApplicationArea = Basic;
        }
        modify(Vendors)
        {
            ApplicationArea = Basic;
        }
        modify(Items)
        {
            ApplicationArea = Basic;
        }
        modify("Catalog Items")
        {
            Caption = 'Nonstock Items';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Catalog Items"(Action 91)".

        }
        modify("Stockkeeping Units")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase Analysis Reports")
        {
            ApplicationArea = Basic;
        }
        modify("Inventory Analysis Reports")
        {
            ApplicationArea = Basic;
        }
        modify("Item Journals")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase Journals")
        {
            ApplicationArea = Basic;
        }
        modify(RequisitionWorksheets)
        {

            //Unsupported feature: Property Modification (Name) on "RequisitionWorksheets(Action 19)".

            ApplicationArea = Basic;
        }
        modify(SubcontractingWorksheets)
        {

            //Unsupported feature: Property Modification (Name) on "SubcontractingWorksheets(Action 20)".

            ApplicationArea = Basic;
        }
        modify("Standard Cost Worksheets")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Purchase Receipts")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Purchase Invoices")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Return Shipments")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Purchase Credit Memos")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Assembly Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase &Quote")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase &Invoice")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Image) on ""Purchase &Invoice"(Action 16)".

        }
        modify("Purchase &Order")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase &Return Order")
        {
            ApplicationArea = Basic;
        }
        modify("&Purchase Journal")
        {
            ApplicationArea = Basic;
        }
        modify("Item &Journal")
        {
            ApplicationArea = Basic;
        }
        modify("Order Plan&ning")
        {
            ApplicationArea = Basic;
        }
        modify("Requisition &Worksheet")
        {
            ApplicationArea = Basic;
        }
        modify("Pur&chase Prices")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase &Line Discounts")
        {
            ApplicationArea = Basic;
        }
        modify("Navi&gate")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor - T&op 10 List"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor/&Item Purchases"(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory - &Availability Plan"(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory &Purchase Orders"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory - &Vendor Purchases"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory &Cost and Price List"(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PurchaseOrders(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PurchaseOrdersPendConf(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PurchaseOrdersPartDeliv(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Quotes"(Action 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Purchase Orders"(Action 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Invoices"(Action 82)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Return Orders"(Action 83)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Credit Memos"(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assembly Orders"(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Orders"(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Vendors(Action 85)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Items(Action 88)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Catalog Items"(Action 91)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Stockkeeping Units"(Action 94)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Analysis Reports"(Action 95)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory Analysis Reports"(Action 96)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item Journals"(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Journals"(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RequisitionWorksheets(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SubcontractingWorksheets(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Standard Cost Worksheets"(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Purchase Receipts"(Action 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Purchase Invoices"(Action 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Return Shipments"(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Purchase Credit Memos"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Assembly Orders"(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase &Quote"(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase &Invoice"(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase &Order"(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase &Return Order"(Action 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Purchase Journal"(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Journal"(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Plan&ning"(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Requisition &Worksheet"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pur&chase Prices"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase &Line Discounts"(Action 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Navi&gate"(Action 46)".

    }
}
