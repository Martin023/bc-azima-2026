#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185547 pageextension52185547 extends "Standard Customer Sales Codes" 
{
    Caption = 'Standard Customer Sales Codes';
    layout
    {
        modify("Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Valid From Date")
        {
            ApplicationArea = Basic;
        }
        modify("Valid To date")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Method Code")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Terms Code")
        {
            ApplicationArea = Basic;
        }
        modify("Direct Debit Mandate ID")
        {
            ApplicationArea = Basic;
        }
        modify(Blocked)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Valid From Date"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Valid To date"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Method Code"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Terms Code"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Direct Debit Mandate ID"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Blocked(Control 10)".

        modify("Insert Rec. Lines On Quotes")
        {
            Visible = false;
        }
        modify("Insert Rec. Lines On Orders")
        {
            Visible = false;
        }
        modify("Insert Rec. Lines On Invoices")
        {
            Visible = false;
        }
        modify("Insert Rec. Lines On Cr. Memos")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {

        //Unsupported feature: Property Modification (ActionContainerType) on "ActionContainer1900000003(Action 1900000003)".


        //Unsupported feature: Property Insertion (Level) on "ActionContainer1900000003(Action 1900000003)".

        modify(Card)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 13)".


        //Unsupported feature: Property Deletion (Promoted) on "Card(Action 13)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Card(Action 13)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Card(Action 13)".


        //Unsupported feature: Property Deletion (Scope) on "Card(Action 13)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "GetSelected(PROCEDURE 3)".

}
