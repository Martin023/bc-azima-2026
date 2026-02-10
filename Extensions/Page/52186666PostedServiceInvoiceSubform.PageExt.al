#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186666 pageextension52186666 extends "Posted Service Invoice Subform" 
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
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Return Reason Code")
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
        modify("Unit Cost (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Price")
        {
            ApplicationArea = Basic;
        }
        modify("Line Discount %")
        {
            ApplicationArea = Basic;
        }
        modify("Line Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Line Discount Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Appl.-to Item Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 1 Code"(Control 72)".

        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 2 Code"(Control 70)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Reason Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Price"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount %"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Amount"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount Amount"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-to Item Entry"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item No."(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 70)".

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
        moveafter("Unit Price";"Line Amount")
    }
    actions
    {
        modify(Dimenions)
        {

            //Unsupported feature: Property Modification (Name) on "Dimenions(Action 1901314304)".

            ApplicationArea = Basic;
        }
        modify(ItemTrackingEntries)
        {

            //Unsupported feature: Property Modification (Name) on "ItemTrackingEntries(Action 1905987604)".

            ApplicationArea = Basic;
        }
        modify(ItemShipmentLines)
        {

            //Unsupported feature: Property Modification (Name) on "ItemShipmentLines(Action 1901742204)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimenions(Action 1901314304)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemTrackingEntries(Action 1905987604)".


        //Unsupported feature: Code Modification on "ItemShipmentLines(Action 1901742204).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            PageShowItemShipmentLines;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ShowItemShipmentLines;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ItemShipmentLines(Action 1901742204)".

    }

    //Unsupported feature: Property Deletion (Local) on "PageShowItemShipmentLines(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Name) on "PageShowItemShipmentLines(PROCEDURE 1)".

}
