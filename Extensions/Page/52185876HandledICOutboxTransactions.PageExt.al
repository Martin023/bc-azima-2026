#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185876 pageextension52185876 extends "Handled IC Outbox Transactions" 
{
    Caption = 'Handled IC Outbox Transactions';
    layout
    {
        modify("Transaction No.")
        {
            ApplicationArea = Basic;
        }
        modify("IC Partner Code")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Source Type")
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
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Transaction Source")
        {
            ApplicationArea = Basic;
        }
        modify("Document Date")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""IC Partner Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Type"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction Source"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 18)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Details)
        {
            ApplicationArea = Basic;
        }
        modify(Comments)
        {
            ApplicationArea = Basic;
        }
        modify("Re-create Outbox Transaction")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Details(Action 21)".


        //Unsupported feature: Property Deletion (Promoted) on "Details(Action 21)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Details(Action 21)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Details(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comments(Action 23)".


        //Unsupported feature: Property Deletion (Promoted) on "Comments(Action 23)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Comments(Action 23)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Comments(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Re-create Outbox Transaction"(Action 26)".


        //Unsupported feature: Property Deletion (Promoted) on ""Re-create Outbox Transaction"(Action 26)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Re-create Outbox Transaction"(Action 26)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Re-create Outbox Transaction"(Action 26)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
