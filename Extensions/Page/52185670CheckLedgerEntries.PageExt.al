#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185670 pageextension52185670 extends "Check Ledger Entries" 
{
    layout
    {
        modify("Check Date")
        {
            ApplicationArea = Basic;
        }
        modify("Check No.")
        {
            ApplicationArea = Basic;
        }
        modify("Bank Account No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Account Type")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("Entry Status")
        {
            ApplicationArea = Basic;
        }
        modify("Original Entry Status")
        {
            ApplicationArea = Basic;
        }
        modify("Bank Payment Type")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Check Date"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Check No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Account No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account Type"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Account No."(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry Status"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Original Entry Status"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Payment Type"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 31)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Void Check")
        {
            ApplicationArea = Basic;
        }
        modify("&Navigate")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Navigate"(Action 33)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Void Check"(Action 36)".


        //Unsupported feature: Property Deletion (Promoted) on ""Void Check"(Action 36)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Void Check"(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 33)".

        modify("Delete Entries")
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (SourceTableView).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
