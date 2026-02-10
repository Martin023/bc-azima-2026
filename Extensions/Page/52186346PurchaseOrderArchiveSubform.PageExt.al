#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186346 pageextension52186346 extends "Purchase Order Archive Subform" 
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
        
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify(Nonstock)
        {
            ApplicationArea = Basic;
        }
        modify("VAT Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Drop Shipment")
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
        modify("Direct Unit Cost")
        {
            ApplicationArea = Basic;
        }
        modify("Indirect Cost %")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Cost (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Price (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Line Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Line Discount %")
        {
            ApplicationArea = Basic;
        }
        modify("Line Discount Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Invoice Disc.")
        {
            ApplicationArea = Basic;
        }
        modify("Inv. Discount Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. to Receive")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity Received")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. to Invoice")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity Invoiced")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Item Charge Assignment")
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
        modify("Planning Flexibility")
        {
            ApplicationArea = Basic;
        }
        modify("Prod. Order Line No.")
        {
            ApplicationArea = Basic;
        }
        modify("Prod. Order No.")
        {
            ApplicationArea = Basic;
        }
        modify("Operation No.")
        {
            ApplicationArea = Basic;
        }
        modify("Work Center No.")
        {
            ApplicationArea = Basic;
        }
        modify(Finished)
        {
            ApplicationArea = Basic;
        }
        modify("Inbound Whse. Handling Time")
        {
            ApplicationArea = Basic;
        }
        modify("Blanket Order No.")
        {
            ApplicationArea = Basic;
        }
        modify("Blanket Order Line No.")
        {
            ApplicationArea = Basic;
        }
        modify("Appl.-to Item Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Deferral Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 1 Code"(Control 98)".

        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 2 Code"(Control 100)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cross-Reference No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Nonstock(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Prod. Posting Group"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Drop Shipment"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Reason Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Direct Unit Cost"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Indirect Cost %"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Price (LCY)"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Amount"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount %"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount Amount"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Invoice Disc."(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inv. Discount Amount"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Receive"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity Received"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Invoice"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity Invoiced"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Item Charge Assignment"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Requested Receipt Date"(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Promised Receipt Date"(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Planned Receipt Date"(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expected Receipt Date"(Control 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Date"(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Lead Time Calculation"(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Planning Flexibility"(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prod. Order Line No."(Control 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prod. Order No."(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Operation No."(Control 82)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Center No."(Control 84)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Finished(Control 86)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inbound Whse. Handling Time"(Control 90)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order No."(Control 92)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order Line No."(Control 94)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-to Item Entry"(Control 96)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Deferral Code"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 98)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 100)".

        modify(ShortcutDimCode3)
        {
            Visible = false;
        }
        modify(ShortcutDimCode4)
        {
            Visible = false;
        }
        modify(ShortcutDimCode5)
        {
            Visible = false;
        }
        modify(ShortcutDimCode6)
        {
            Visible = false;
        }
        modify(ShortcutDimCode7)
        {
            Visible = false;
        }
        modify(ShortcutDimCode8)
        {
            Visible = false;
        }
    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify(DeferralSchedule)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1906874004)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 1907838004)".

        modify("Document &LineTracking")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "DeferralSchedule(Action 3)".

    }
}
