#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185872 pageextension52185872 extends "IC Partner Card" 
{
    Caption = 'IC Partner Card';
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
        // modify("Inbox Type")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Inbox Details")
        {
            ApplicationArea = Basic;
        }
        modify(Blocked)
        {
            ApplicationArea = Basic;
        }
        modify("Sales Transaction")
        {
            Caption = 'Posting';

            //Unsupported feature: Property Modification (Name) on ""Sales Transaction"(Control 1904784501)".

        }
        modify("Receivables Account")
        {
            ApplicationArea = Basic;
        }
        modify("Outbound Sales Item No. Type")
        {
            ApplicationArea = Basic;
        }
        modify("Payables Account")
        {
            ApplicationArea = Basic;
        }
        modify("Outbound Purch. Item No. Type")
        {
            ApplicationArea = Basic;
        }
        modify("Cost Distribution in LCY")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Modification (Visible) on "Control1905767507(Control 1905767507)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 6)".

        modify("Inbox Type")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Inbox Type"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inbox Type"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inbox Details"(Control 10)".


        //Unsupported feature: Property Deletion (CaptionClass) on ""Inbox Details"(Control 10)".


        //Unsupported feature: Property Deletion (Enabled) on ""Inbox Details"(Control 10)".


        //Unsupported feature: Property Deletion (Editable) on ""Inbox Details"(Control 10)".

        modify("Auto. Accept Transactions")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Blocked(Control 16)".


        //Unsupported feature: Property Deletion (GroupType) on ""Sales Transaction"(Control 1904784501)".

        modify("Customer No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Receivables Account"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outbound Sales Item No. Type"(Control 26)".

        modify("Purchase Transaction")
        {
            Visible = false;
        }
        modify("Vendor No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Payables Account"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outbound Purch. Item No. Type"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Distribution in LCY"(Control 15)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        moveafter("Receivables Account";"Payables Account")
    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 28)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 28)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 28)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Dimensions(Action 28)".

    }
}
