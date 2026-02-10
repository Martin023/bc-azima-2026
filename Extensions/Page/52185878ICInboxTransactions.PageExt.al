#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185878 pageextension52185878 extends "IC Inbox Transactions" 
{
    Caption = 'IC Inbox Transactions';
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

        //Unsupported feature: Property Deletion (ToolTipML) on "PartnerFilter(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowLines(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowAction(Control 31)".


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
        modify(Accept)
        {
            ApplicationArea = Basic;
        }
        modify("Return to IC Partner")
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
        modify("Import Transaction File")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Details(Action 32)".


        //Unsupported feature: Property Deletion (Promoted) on "Details(Action 32)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Details(Action 32)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Details(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comments(Action 33)".


        //Unsupported feature: Property Deletion (Promoted) on "Comments(Action 33)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Comments(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No Action"(Action 8)".


        //Unsupported feature: Property Deletion (Promoted) on ""No Action"(Action 8)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""No Action"(Action 8)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""No Action"(Action 8)".


        //Unsupported feature: Code Modification on "Accept(Action 36).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(ICInboxTransaction);
            IF ICInboxTransaction.FIND('-') THEN
              REPEAT
                TESTFIELD("Transaction Source",ICInboxTransaction."Transaction Source"::"Created by Partner");
                ICInboxTransaction.VALIDATE("Line Action",ICInboxTransaction."Line Action"::Accept);
                ICInboxTransaction.MODIFY;
              UNTIL ICInboxTransaction.NEXT = 0;

            IF ApplicationAreaMgmtFacade.IsFoundationEnabled THEN
              RunInboxTransactions(ICInboxTransaction);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..7
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Accept(Action 36)".


        //Unsupported feature: Property Deletion (Promoted) on "Accept(Action 36)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Accept(Action 36)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Accept(Action 36)".



        //Unsupported feature: Code Modification on ""Return to IC Partner"(Action 37).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(ICInboxTransaction);
            IF ICInboxTransaction.FIND('-') THEN
              REPEAT
                TESTFIELD("Transaction Source",ICInboxTransaction."Transaction Source"::"Created by Partner");
                ICInboxTransaction."Line Action" := ICInboxTransaction."Line Action"::"Return to IC Partner";
                ICInboxTransaction.MODIFY;
              UNTIL ICInboxTransaction.NEXT = 0;

            IF ApplicationAreaMgmtFacade.IsFoundationEnabled THEN
              RunInboxTransactions(ICInboxTransaction);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..7
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Return to IC Partner"(Action 37)".


        //Unsupported feature: Property Deletion (Promoted) on ""Return to IC Partner"(Action 37)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Return to IC Partner"(Action 37)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Return to IC Partner"(Action 37)".



        //Unsupported feature: Code Modification on "Cancel(Action 40).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(ICInboxTransaction);
            IF ICInboxTransaction.FIND('-') THEN
              REPEAT
                ICInboxTransaction."Line Action" := ICInboxTransaction."Line Action"::Cancel;
                ICInboxTransaction.MODIFY;
              UNTIL ICInboxTransaction.NEXT = 0;

            IF ApplicationAreaMgmtFacade.IsFoundationEnabled THEN
              RunInboxTransactions(ICInboxTransaction);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..6
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Cancel(Action 40)".


        //Unsupported feature: Property Deletion (Promoted) on "Cancel(Action 40)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Cancel(Action 40)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Cancel(Action 40)".



        //Unsupported feature: Code Insertion (VariableCollection) on ""Complete Line Actions"(Action 39).OnAction".

        //trigger (Variable: CarryOutICInboxAction)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Complete Line Actions"(Action 39).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            RunInboxTransactions(Rec);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CarryOutICInboxAction.SETTABLEVIEW(Rec);
            CarryOutICInboxAction.RUNMODAL;
            CurrPage.UPDATE(TRUE);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Complete Line Actions"(Action 39)".


        //Unsupported feature: Property Deletion (Promoted) on ""Complete Line Actions"(Action 39)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Complete Line Actions"(Action 39)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Complete Line Actions"(Action 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Import Transaction File"(Action 41)".


        //Unsupported feature: Property Deletion (Promoted) on ""Import Transaction File"(Action 41)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Import Transaction File"(Action 41)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Import Transaction File"(Action 41)".

    }

    var
        CarryOutICInboxAction: Report "Complete IC Inbox Action";

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
