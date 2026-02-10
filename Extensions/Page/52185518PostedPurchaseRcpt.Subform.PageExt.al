#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185518 pageextension52185518 extends "Posted Purchase Rcpt. Subform" 
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
        modify("Qty. Rcd. Not Invoiced")
        {
            ApplicationArea = Basic;
        }
        modify("Requested Receipt Date")
        {
            ApplicationArea = Basic;
        }
        modify("Promised Receipt Date")
        {
            ApplicationArea = Basic;
        }
        modify("Planned Receipt Date")
        {
            ApplicationArea = Basic;
        }
        modify("Expected Receipt Date")
        {
            ApplicationArea = Basic;
        }
        modify("Order Date")
        {
            ApplicationArea = Basic;
        }
        modify("Lead Time Calculation")
        {
            ApplicationArea = Basic;
        }
        modify("Job No.")
        {
            ApplicationArea = Basic;
        }
        modify("Prod. Order No.")
        {
            ApplicationArea = Basic;
        }
        modify("Inbound Whse. Handling Time")
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

        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 2)".

        modify(FilteredTypeField)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cross-Reference No."(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Reason Code"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity Invoiced"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Rcd. Not Invoiced"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Requested Receipt Date"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Promised Receipt Date"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Planned Receipt Date"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expected Receipt Date"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Date"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Lead Time Calculation"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 32)".

        modify("Job Task No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Prod. Order No."(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inbound Whse. Handling Time"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-to Item Entry"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Correction(Control 52)".

        // modify("Shortcut Dimension 1 Code")
        // {
        //     Visible = false;
        // }
        // modify("Shortcut Dimension 2 Code")
        // {
        //     Visible = false;
        // }
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
        addafter("Appl.-to Item Entry")
        {
            // field("Shortcut Dimension 1 Code";Rec."Shortcut Dimension 1 Code")
            // {
            //     ApplicationArea = Basic;
            //     Visible = false;
            // }
            // field("Shortcut Dimension 2 Code";Rec."Shortcut Dimension 2 Code")
            // {
            //     ApplicationArea = Basic;
            //     Visible = false;
            // }
        }
    }
    actions
    {
        modify(OrderTracking)
        {
            ApplicationArea = Basic;
        }
        modify("&Undo Receipt")
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(Comments)
        {

            //Unsupported feature: Property Modification (Name) on "Comments(Action 1902740304)".

            ApplicationArea = Basic;
        }
        modify(ItemTrackingEntries)
        {

            //Unsupported feature: Property Modification (Name) on "ItemTrackingEntries(Action 1905987604)".

            ApplicationArea = Basic;
        }
        modify(ItemInvoiceLines)
        {

            //Unsupported feature: Property Modification (Name) on "ItemInvoiceLines(Action 1903645704)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "OrderTracking(Action 1900544904)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Undo Receipt"(Action 1900546304)".


        //Unsupported feature: Property Deletion (Image) on ""&Undo Receipt"(Action 1900546304)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1901741704)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comments(Action 1902740304)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemTrackingEntries(Action 1905987604)".



        //Unsupported feature: Code Modification on "ItemInvoiceLines(Action 1903645704).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            PageShowItemPurchInvLines;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ShowItemPurchInvLines;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ItemInvoiceLines(Action 1903645704)".

        modify(DocumentLineTracking)
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Modification (Name) on "PageShowItemPurchInvLines(PROCEDURE 4)".

}
