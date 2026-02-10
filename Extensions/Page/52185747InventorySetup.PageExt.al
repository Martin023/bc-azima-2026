#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185747 pageextension52185747 extends "Inventory Setup"
{
    layout
    {
        modify("Automatic Cost Posting")
        {
            ApplicationArea = Basic;
        }
        modify("Expected Cost Posting to G/L")
        {
            ApplicationArea = Basic;
        }
        modify("Automatic Cost Adjustment")
        {
            ApplicationArea = Basic;
        }
        modify("Average Cost Calc. Type")
        {
            ApplicationArea = Basic;
        }
        modify("Average Cost Period")
        {
            ApplicationArea = Basic;
        }
        modify("Copy Comments Order to Shpt.")
        {
            ApplicationArea = Basic;
        }
        modify("Copy Comments Order to Rcpt.")
        {
            ApplicationArea = Basic;
        }
        modify("Outbound Whse. Handling Time")
        {
            ApplicationArea = Basic;
        }
        modify("Inbound Whse. Handling Time")
        {
            ApplicationArea = Basic;
        }
        modify("Prevent Negative Inventory")
        {
            ApplicationArea = Basic;
        }
        modify("Location Mandatory")
        {
            ApplicationArea = Basic;
        }
        modify("Item Group Dimension Code")
        {
            ApplicationArea = Basic;
        }
        modify("Item Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Nonstock Item Nos.")
        {
            Caption = 'Non-stock Item Nos.';
            ApplicationArea = Basic;
        }
        modify("Transfer Order Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Transfer Shpt. Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Transfer Rcpt. Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Inventory Put-away Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Invt. Put-away Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Inventory Pick Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Invt. Pick Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Inventory Movement Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Registered Invt. Movement Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Internal Movement Nos.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Automatic Cost Posting"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expected Cost Posting to G/L"(Control 24)".


        //Unsupported feature: Property Deletion (Importance) on ""Expected Cost Posting to G/L"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Automatic Cost Adjustment"(Control 36)".

        modify("Default Costing Method")
        {
            Visible = false;
        }
        addlast(General)
        {
            field("Item Jnl Template"; rec."Item Jnl Template")
            {

            }
            field("Item Jnl Batch"; Rec."Item Jnl Batch")
            {

            }

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Average Cost Calc. Type"(Control 22)".


        //Unsupported feature: Property Deletion (Importance) on ""Average Cost Calc. Type"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Average Cost Period"(Control 38)".


        //Unsupported feature: Property Deletion (Importance) on ""Average Cost Period"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Copy Comments Order to Shpt."(Control 12)".


        //Unsupported feature: Property Deletion (Importance) on ""Copy Comments Order to Shpt."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Copy Comments Order to Rcpt."(Control 14)".


        //Unsupported feature: Property Deletion (Importance) on ""Copy Comments Order to Rcpt."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outbound Whse. Handling Time"(Control 26)".


        //Unsupported feature: Property Deletion (Importance) on ""Outbound Whse. Handling Time"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inbound Whse. Handling Time"(Control 28)".


        //Unsupported feature: Property Deletion (Importance) on ""Inbound Whse. Handling Time"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prevent Negative Inventory"(Control 3)".

        modify("Skip Prompt to Create Item")
        {
            Visible = false;
        }
        modify("Copy Item Descr. to Entries")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Mandatory"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item Group Dimension Code"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item Nos."(Control 81)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Nonstock Item Nos."(Control 16)".


        //Unsupported feature: Property Deletion (Importance) on ""Nonstock Item Nos."(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer Order Nos."(Control 6)".


        //Unsupported feature: Property Deletion (Importance) on ""Transfer Order Nos."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Transfer Shpt. Nos."(Control 8)".


        //Unsupported feature: Property Deletion (Importance) on ""Posted Transfer Shpt. Nos."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Transfer Rcpt. Nos."(Control 10)".


        //Unsupported feature: Property Deletion (Importance) on ""Posted Transfer Rcpt. Nos."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory Put-away Nos."(Control 18)".


        //Unsupported feature: Property Deletion (Importance) on ""Inventory Put-away Nos."(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Invt. Put-away Nos."(Control 30)".


        //Unsupported feature: Property Deletion (Importance) on ""Posted Invt. Put-away Nos."(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory Pick Nos."(Control 20)".


        //Unsupported feature: Property Deletion (Importance) on ""Inventory Pick Nos."(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Invt. Pick Nos."(Control 32)".


        //Unsupported feature: Property Deletion (Importance) on ""Posted Invt. Pick Nos."(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory Movement Nos."(Control 40)".


        //Unsupported feature: Property Deletion (Importance) on ""Inventory Movement Nos."(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Registered Invt. Movement Nos."(Control 42)".


        //Unsupported feature: Property Deletion (Importance) on ""Registered Invt. Movement Nos."(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Internal Movement Nos."(Control 44)".


        //Unsupported feature: Property Deletion (Importance) on ""Internal Movement Nos."(Control 44)".

        modify("Phys. Invt. Order Nos.")
        {
            Visible = false;
        }
        modify("Posted Phys. Invt. Order Nos.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter("Internal Movement Nos.")
        {
            field("Stock Keeping Nos."; rec."Stock Keeping Nos.")
            {

            }
            field("Disposal Nos."; Rec."Disposal Nos.")
            {

            }
            field("Item Expiry Notification"; Rec."Item Expiry Notification")
            {

            }

            // field("Item Jnl Templat e";"Item Jnl Template")
            // {
            //     ApplicationArea = Basic;
            // }
            // field("Item Jnl Batc h";"Item Jnl Batch")
            // {
            //     ApplicationArea = Basic;
            // }
        }
    }
    actions
    {
        // modify(ActionContainer21)
        // {
        //     Visible = false;
        // }
        modify("Inventory Periods")
        {
            Visible = false;
        }
        modify("Units of Measure")
        {
            Visible = false;
        }
        modify("Item Discount Groups")
        {
            Visible = false;
        }
        modify("Import Item Pictures")
        {
            Visible = false;
        }
        modify(Posting)
        {
            Visible = false;
        }
        modify("Inventory Posting Setup")
        {
            Visible = false;
        }
        modify("Inventory Posting Groups")
        {
            Visible = false;
        }
        modify("Journal Templates")
        {
            Visible = false;
        }
        modify("Item Journal Templates")
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
