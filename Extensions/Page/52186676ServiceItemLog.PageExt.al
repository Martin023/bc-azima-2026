#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186676 pageextension52186676 extends "Service Item Log"
{
    layout
    {
        modify("Service Item No.")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Service Item No."(Control 2)".

        }
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("ServLogMgt.ServItemEventDescription(""Event No."")")
        {
            ApplicationArea = Basic;
        }
        modify(After)
        {
            ApplicationArea = Basic;
        }
        modify(Before)
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
        modify("Change Date")
        {
            ApplicationArea = Basic;
        }
        modify("Change Time")
        {
            ApplicationArea = Basic;
        }
        modify("User ID")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ServLogMgt.ServItemEventDescription(""Event No."")"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "After(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Before(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Change Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Change Time"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 12)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Delete Service Item Log")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Insertion (VariableCollection) on ""Delete Service Item Log"(Action 20).OnAction".

        //trigger (Variable: DeleteServItemLog)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Delete Service Item Log"(Action 20).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        REPORT.RUNMODAL(REPORT::"Delete Service Item Log",TRUE,FALSE,Rec);
        CurrPage.UPDATE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        DeleteServItemLog.SETTABLEVIEW(Rec);
        DeleteServItemLog.RUNMODAL;
        CurrPage.UPDATE;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Delete Service Item Log"(Action 20)".

    }

    var
        DeleteServItemLog: Report "Delete Service Item Log";

    var

        "Service Item No.Visible": Boolean;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ServiceItemNoVisible := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Service Item No.Visible" := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "GetCaptionHeader(PROCEDURE 1)".

    //procedure GetCaptionHeader();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF GETFILTER("Service Item No.") <> '' THEN BEGIN
      ServiceItemNoVisible := FALSE;
      IF ServItem.GET("Service Item No.") THEN
        EXIT("Service Item No." + ' ' + ServItem.Description);

      EXIT("Service Item No.");
    END;

    ServiceItemNoVisible := TRUE;
    EXIT('');
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF GETFILTER("Service Item No.") <> '' THEN BEGIN
      "Service Item No.Visible" := FALSE;
    #3..8
    "Service Item No.Visible" := TRUE;
    EXIT('');
    */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
