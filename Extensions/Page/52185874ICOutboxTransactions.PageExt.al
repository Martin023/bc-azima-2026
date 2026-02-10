#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185874 pageextension52185874 extends "IC Outbox Transactions" 
{
    Caption = 'IC Outbox Transactions';
    layout
    {
        modify(PartnerFilter)
        {
            ApplicationArea = Basic;
        }
        modify(ShowLines)
        {
            ApplicationArea = Basic;
        }
        modify(ShowAction)
        {
            ApplicationArea = Basic;
        }
        modify("Transaction No.")
        {
            ApplicationArea = Basic;
        }
        modify("IC Partner Code")
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
        modify("Line Action")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "PartnerFilter(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowLines(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowAction(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""IC Partner Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Type"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transaction Source"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Action"(Control 20)".


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
        modify("No Action")
        {
            ApplicationArea = Basic;
        }
        modify(SendToICPartner)
        {
            ApplicationArea = Basic;
        }
        modify("Return to Inbox")
        {
            ApplicationArea = Basic;
        }
        modify(Cancel)
        {
            ApplicationArea = Basic;
        }
        modify("Complete Line Actions")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Details(Action 34)".


        //Unsupported feature: Property Deletion (Promoted) on "Details(Action 34)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Details(Action 34)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Details(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comments(Action 35)".


        //Unsupported feature: Property Deletion (Promoted) on "Comments(Action 35)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Comments(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No Action"(Action 8)".


        //Unsupported feature: Property Deletion (Promoted) on ""No Action"(Action 8)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""No Action"(Action 8)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""No Action"(Action 8)".


        //Unsupported feature: Code Modification on "SendToICPartner(Action 37).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(ICOutboxTransaction);
            IF ICOutboxTransaction.FIND('-') THEN
              REPEAT
                ICOutboxTransaction.VALIDATE("Line Action",ICOutboxTransaction."Line Action"::"Send to IC Partner");
                ICOutboxTransaction.MODIFY;
              UNTIL ICOutboxTransaction.NEXT = 0;
            ICOutboxExport.RunOutboxTransactions(ICOutboxTransaction);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..6
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "SendToICPartner(Action 37)".


        //Unsupported feature: Property Deletion (Promoted) on "SendToICPartner(Action 37)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "SendToICPartner(Action 37)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "SendToICPartner(Action 37)".



        //Unsupported feature: Code Modification on ""Return to Inbox"(Action 38).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(ICOutboxTransaction);
            IF ICOutboxTransaction.FIND('-') THEN
              REPEAT
                TESTFIELD("Transaction Source",ICOutboxTransaction."Transaction Source"::"Rejected by Current Company");
                ICOutboxTransaction."Line Action" := ICOutboxTransaction."Line Action"::"Return to Inbox";
                ICOutboxTransaction.MODIFY;
              UNTIL ICOutboxTransaction.NEXT = 0;
            ICOutboxExport.RunOutboxTransactions(ICOutboxTransaction);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..7
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Return to Inbox"(Action 38)".


        //Unsupported feature: Property Deletion (Promoted) on ""Return to Inbox"(Action 38)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Return to Inbox"(Action 38)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Return to Inbox"(Action 38)".



        //Unsupported feature: Code Modification on "Cancel(Action 39).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(ICOutboxTransaction);
            IF ICOutboxTransaction.FIND('-') THEN
              REPEAT
                ICOutboxTransaction."Line Action" := ICOutboxTransaction."Line Action"::Cancel;
                ICOutboxTransaction.MODIFY;
              UNTIL ICOutboxTransaction.NEXT = 0;
            ICOutboxExport.RunOutboxTransactions(ICOutboxTransaction);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..6
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Cancel(Action 39)".


        //Unsupported feature: Property Deletion (Promoted) on "Cancel(Action 39)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Cancel(Action 39)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Cancel(Action 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Complete Line Actions"(Action 40)".


        //Unsupported feature: Property Deletion (Promoted) on ""Complete Line Actions"(Action 40)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Complete Line Actions"(Action 40)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Complete Line Actions"(Action 40)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
