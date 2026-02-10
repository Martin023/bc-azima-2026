#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185922 pageextension52185922 extends "Report Inbox Part" 
{
    layout
    {
        modify("User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Created Date-Time")
        {
            ApplicationArea = Basic;
        }
        modify("Report ID")
        {
            ApplicationArea = Basic;
        }
        modify("Report Name")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Output Type")
        {
            ApplicationArea = Basic;
        }
        // modify(PingPong)
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Created Date-Time"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Report ID"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Report Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Output Type"(Control 10)".

    }
    actions
    {
        modify(Show)
        {
            ApplicationArea = Basic;
        }
        modify(Unread)
        {
            ApplicationArea = Basic;
        }
        modify(All)
        {
            ApplicationArea = Basic;
        }
        modify(Delete)
        {
            ApplicationArea = Basic;
        }
        modify(ShowQueue)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Show(Action 8)".


        //Unsupported feature: Property Deletion (Enabled) on "Show(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Unread(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "All(Action 13)".


        //Unsupported feature: Code Modification on "Delete(Action 9).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(ReportInbox);
            ReportInbox.DELETEALL;
            UpdateVisibility;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(ReportInbox);
            ReportInbox.DELETEALL;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Delete(Action 9)".


        //Unsupported feature: Property Deletion (Enabled) on "Delete(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowQueue(Action 19)".

    }


    //Unsupported feature: Code Modification on "UpdateVisibility(PROCEDURE 1)".

    //procedure UpdateVisibility();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ShowAll THEN
          SETRANGE(Read)
        ELSE
          SETRANGE(Read,FALSE);
        ActionsEnabled := FINDFIRST;
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        IF FINDFIRST THEN;
        CurrPage.UPDATE(FALSE);
        */
    //end;

    //Unsupported feature: Property Deletion (InsertAllowed).


    //Unsupported feature: Property Deletion (DeleteAllowed).


    //Unsupported feature: Property Deletion (ModifyAllowed).


    //Unsupported feature: Property Deletion (RefreshOnActivate).

}
