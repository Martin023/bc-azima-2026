#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185685 pageextension52185685 extends "Phys. Inventory Ledger Entries" 
{
    Caption = 'Phys. Inventory Ledger Entries';
    layout
    {
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Entry Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Item No.")
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
        modify("Global Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. (Calculated)")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. (Phys. Inventory)")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Unit Amount")
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify("Unit Cost")
        {
            ApplicationArea = Basic;
        }
        modify("User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Source Code")
        {
            ApplicationArea = Basic;
        }
        modify("Reason Code")
        {
            ApplicationArea = Basic;
        }
        modify("Last Item Ledger Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry Type"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 1 Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 2 Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. (Calculated)"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. (Phys. Inventory)"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Amount"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Code"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Code"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Item Ledger Entry No."(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 40)".

        modify("Dimension Set ID")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("&Navigate")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 53)".

        modify(SetDimensionFilter)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 45)".

        modify("Delete Entries")
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
