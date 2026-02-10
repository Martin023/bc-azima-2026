#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185871 pageextension52185871 extends "IC Partner List"
{
    Caption = 'IC Partner List';
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Inbox Type")
        {
            ApplicationArea = Basic;
        }
        modify("Inbox Details")
        {
            ApplicationArea = Basic;
        }
        modify("Receivables Account")
        {
            ApplicationArea = Basic;
        }
        modify("Payables Account")
        {
            ApplicationArea = Basic;
        }
        modify(Blocked)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inbox Type"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inbox Details"(Control 10)".

        modify("Auto. Accept Transactions")
        {
            Visible = false;
        }
        modify("Customer No.")
        {
            Visible = false;
        }
        modify("Vendor No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Receivables Account"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payables Account"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Blocked(Control 20)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Dimensions-Single")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimensions-Single"(Action 27)".


        //Unsupported feature: Property Deletion (Promoted) on ""Dimensions-Single"(Action 27)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Dimensions-Single"(Action 27)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Dimensions-Single"(Action 27)".

        // modify(ActionContainer9)
        // {
        //     Visible = false;
        // }
        modify("Intercompany Setup")
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Deletion (Attributes) on "GetSelectionFilter(PROCEDURE 4)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
