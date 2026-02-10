#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185551 pageextension52185551 extends "Standard Vendor Purchase Codes" 
{
    Caption = 'Standard Vendor Purchase Codes';
    layout
    {
        modify("Vendor No.")
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".

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
        modify(Card)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 12)".


        //Unsupported feature: Property Deletion (Promoted) on "Card(Action 12)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Card(Action 12)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Card(Action 12)".


        //Unsupported feature: Property Deletion (Scope) on "Card(Action 12)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "GetSelected(PROCEDURE 1)".

}
