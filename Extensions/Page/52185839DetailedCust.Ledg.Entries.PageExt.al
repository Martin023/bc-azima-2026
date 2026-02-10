#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185839 pageextension52185839 extends "Detailed Cust. Ledg. Entries" 
{
    Caption = 'Detailed Cust. Ledg. Entries';
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
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Initial Entry Global Dim. 1")
        {
            ApplicationArea = Basic;
        }
        modify("Initial Entry Global Dim. 2")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify("Amount (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Initial Entry Due Date")
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
        modify(Unapplied)
        {
            ApplicationArea = Basic;
        }
        modify("Unapplied by Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Cust. Ledger Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry Type"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Initial Entry Global Dim. 1"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Initial Entry Global Dim. 2"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 14)".


        //Unsupported feature: Property Deletion (Visible) on "Amount(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount (LCY)"(Control 16)".


        //Unsupported feature: Property Deletion (Visible) on ""Amount (LCY)"(Control 16)".

        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Debit Amount (LCY)")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }
        modify("Credit Amount (LCY)")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Initial Entry Due Date"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Code"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Code"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Unapplied(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unapplied by Entry No."(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cust. Ledger Entry No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 2)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Unapply Entries")
        {
            ApplicationArea = Basic;
        }
        modify("&Navigate")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Navigate"(Action 26)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Unapply Entries"(Action 28)".


        //Unsupported feature: Property Deletion (Promoted) on ""Unapply Entries"(Action 28)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Unapply Entries"(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 26)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
