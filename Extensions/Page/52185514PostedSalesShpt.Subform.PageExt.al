#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185514 pageextension52185514 extends "Posted Sales Shpt. Subform"
{
    layout
    {
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        // modify("Cross-Reference No.")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Return Reason Code")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity Invoiced")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. Shipped Not Invoiced")
        {
            ApplicationArea = Basic;
        }
        modify("Requested Delivery Date")
        {
            ApplicationArea = Basic;
        }
        modify("Promised Delivery Date")
        {
            ApplicationArea = Basic;
        }
        modify("Planned Delivery Date")
        {
            ApplicationArea = Basic;
        }
        modify("Planned Shipment Date")
        {
            ApplicationArea = Basic;
        }
        modify("Shipment Date")
        {
            ApplicationArea = Basic;
        }
        modify("Shipping Time")
        {
            ApplicationArea = Basic;
        }
        modify("Job No.")
        {
            ApplicationArea = Basic;
        }
        modify("Outbound Whse. Handling Time")
        {
            ApplicationArea = Basic;
        }
        modify("Appl.-to Item Entry")
        {
            ApplicationArea = Basic;
        }
        modify(Correction)
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 1 Code"(Control 50)".

        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 2 Code"(Control 48)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 2)".

        modify(FilteredTypeField)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cross-Reference No."(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Reason Code"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity Invoiced"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Shipped Not Invoiced"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Requested Delivery Date"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Promised Delivery Date"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Planned Delivery Date"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Planned Shipment Date"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Date"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Time"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 38)".

        modify("Job Task No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Outbound Whse. Handling Time"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-to Item Entry"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Correction(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 48)".

        modify("ShortcutDimCode[3]")
        {
            Visible = false;
        }
        modify("ShortcutDimCode[4]")
        {
            Visible = false;
        }
        modify("ShortcutDimCode[5]")
        {
            Visible = false;
        }
        modify("ShortcutDimCode[6]")
        {
            Visible = false;
        }
        modify("ShortcutDimCode[7]")
        {
            Visible = false;
        }
        modify("ShortcutDimCode[8]")
        {
            Visible = false;
        }
        moveafter("Appl.-to Item Entry"; "Shortcut Dimension 1 Code")
    }
    actions
    {
        modify("Order Tra&cking")
        {
            ApplicationArea = Basic;
        }
        modify(UndoShipment)
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(Comments)
        {

            //Unsupported feature: Property Modification (Name) on "Comments(Action 1901092104)".

            ApplicationArea = Basic;
        }
        modify(ItemTrackingEntries)
        {
            ApplicationArea = Basic;
        }
        modify("Assemble-to-Order")
        {
            ApplicationArea = Basic;
        }
        modify(ItemInvoiceLines)
        {

            //Unsupported feature: Property Modification (Name) on "ItemInvoiceLines(Action 1900609704)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Tra&cking"(Action 1903098504)".


        //Unsupported feature: Property Deletion (ToolTipML) on "UndoShipment(Action 1902740304)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1903100004)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comments(Action 1901092104)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemTrackingEntries(Action 1905987604)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assemble-to-Order"(Action 3)".


        //Unsupported feature: Code Modification on "ItemInvoiceLines(Action 1900609704).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PageShowItemSalesInvLines;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ShowItemSalesInvLines;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ItemInvoiceLines(Action 1900609704)".

        modify(DocumentLineTracking)
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Modification (Name) on "PageShowItemSalesInvLines(PROCEDURE 4)".

}
