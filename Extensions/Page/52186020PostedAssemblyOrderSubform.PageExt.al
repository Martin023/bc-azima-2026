#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186020 pageextension52186020 extends "Posted Assembly Order Subform" 
{
    layout
    {
        modify("Order Line No.")
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
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Quantity per")
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
        modify("Qty. per Unit of Measure")
        {
            ApplicationArea = Basic;
        }
        modify("Resource Usage Type")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Shortcut Dimension 1 Code"(Control 15)".


            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 1 Code"(Control 15)".


            //Unsupported feature: Property Modification (Name) on ""Shortcut Dimension 1 Code"(Control 15)".

        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Shortcut Dimension 2 Code"(Control 14)".


            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 2 Code"(Control 14)".


            //Unsupported feature: Property Modification (Name) on ""Shortcut Dimension 2 Code"(Control 14)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Line No."(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Description 2"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity per"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory Posting Group"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Amount"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. per Unit of Measure"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Usage Type"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 14)".

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
        moveafter("Quantity per";"Shortcut Dimension 2 Code")
        //moveafter("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("Item &Tracking Lines")
        {
            ApplicationArea = Basic;
        }
        modify(Comments)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracking Lines"(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comments(Action 30)".

    }
}
