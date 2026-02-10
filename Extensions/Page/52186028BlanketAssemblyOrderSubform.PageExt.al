#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186028 pageextension52186028 extends "Blanket Assembly Order Subform" 
{
    layout
    {
        modify("Avail. Warning")
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Description 2")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity per")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Quantity to Consume")
        {
            ApplicationArea = Basic;
        }
        modify("Consumed Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Remaining Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. Picked")
        {
            ApplicationArea = Basic;
        }
        modify("Pick Qty.")
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Lead-Time Offset")
        {
            ApplicationArea = Basic;
        }
        modify("Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify("Inventory Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Cost")
        {
            ApplicationArea = Basic;
        }
        modify("Cost Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Reserved Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. per Unit of Measure")
        {
            ApplicationArea = Basic;
        }
        modify("Resource Usage Type")
        {
            ApplicationArea = Basic;
        }
        modify("Appl.-to Item Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Appl.-from Item Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Shortcut Dimension 1 Code"(Control 10)".


            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 1 Code"(Control 10)".


            //Unsupported feature: Property Modification (Name) on ""Shortcut Dimension 1 Code"(Control 10)".

        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Shortcut Dimension 2 Code"(Control 9)".


            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 2 Code"(Control 9)".


            //Unsupported feature: Property Modification (Name) on ""Shortcut Dimension 2 Code"(Control 9)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Avail. Warning"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Description 2"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity per"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity to Consume"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Consumed Quantity"(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Quantity"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Picked"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pick Qty."(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Lead-Time Offset"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory Posting Group"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Amount"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reserved Quantity"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. per Unit of Measure"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Usage Type"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-to Item Entry"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-from Item Entry"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 9)".

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
        moveafter("Lead-Time Offset";"Shortcut Dimension 2 Code")
        // moveafter("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
    }
    actions
    {
        modify("Event")
        {
            ApplicationArea = Basic;
        }
        modify(Period)
        {
            ApplicationArea = Basic;
        }
        modify(Variant)
        {
            ApplicationArea = Basic;
        }
        modify(Location)
        {
            ApplicationArea = Basic;
        }
        modify("BOM Level")
        {
            ApplicationArea = Basic;
        }
        modify("Show Warning")
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(Comments)
        {
            ApplicationArea = Basic;
        }
        modify("Assembly BOM")
        {
            ApplicationArea = Basic;
        }
        modify("Select Item Substitution")
        {
            ApplicationArea = Basic;
        }
        modify("Explode BOM")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Event(Action 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BOM Level"(Action 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Show Warning"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comments(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assembly BOM"(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Select Item Substitution"(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Explode BOM"(Action 14)".

    }
}
