#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186622 pageextension52186622 extends "Service Document Log"
{
    layout
    {
        modify("Document Type")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Document Type"(Control 12)".

        }
        modify("Document No.")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Document No."(Control 29)".

        }
        modify("Service Item Line No.")
        {
            ApplicationArea = Basic;
        }
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("ServLogMgt.ServOrderEventDescription(""Event No."")")
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item Line No."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ServLogMgt.ServOrderEventDescription(""Event No."")"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on "After(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Before(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Change Date"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Change Time"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 10)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("&Delete Service Document Log")
        {
            ApplicationArea = Basic;
        }
        modify("&Show")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Delete Service Document Log"(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Show"(Action 18)".

    }
    var

        "Document TypeVisible": Boolean;

        "Document No.Visible": Boolean;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DocumentNoVisible := TRUE;
    DocumentTypeVisible := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Document No.Visible" := TRUE;
    "Document TypeVisible" := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "GetCaptionHeader(PROCEDURE 1)".

    //procedure GetCaptionHeader();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF GETFILTER("Document No.") <> '' THEN BEGIN
      DocumentTypeVisible := FALSE;
      DocumentNoVisible := FALSE;
      IF ServHeader.GET("Document Type","Document No.") THEN
        EXIT(FORMAT("Document Type") + ' ' + "Document No." + ' ' + ServHeader.Description);

      EXIT(FORMAT("Document Type") + ' ' + "Document No.");
    END;

    DocumentTypeVisible := TRUE;
    DocumentNoVisible := TRUE;
    EXIT('');
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF GETFILTER("Document No.") <> '' THEN BEGIN
      "Document TypeVisible" := FALSE;
      "Document No.Visible" := FALSE;
    #4..9
    "Document TypeVisible" := TRUE;
    "Document No.Visible" := TRUE;
    EXIT('');
    */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
