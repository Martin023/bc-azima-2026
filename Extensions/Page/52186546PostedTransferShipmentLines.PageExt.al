#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186546 pageextension52186546 extends "Posted Transfer Shipment Lines"
{
    layout
    {
        modify("Document No.")
        {
            ApplicationArea = Basic;
            HideValue = "Document No.HideValue";
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure")
        {
            ApplicationArea = Basic;
        }
        modify("Shipment Date")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Date"(Control 12)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        // modify("Show Document")
        // {
        //     ApplicationArea = Basic;
        // }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Show Document"(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 19)".

    }
    var

        "Document No.HideValue": Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DocumentNoHideValue := FALSE;
    DocumentNoOnFormat;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Document No.HideValue" := FALSE;
    DocumentNoOnFormat;
    */
    //end;


    //Unsupported feature: Code Modification on "DocumentNoOnFormat(PROCEDURE 19001080)".

    //procedure DocumentNoOnFormat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT IsFirstLine("Document No.","Line No.") THEN
      DocumentNoHideValue := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NOT IsFirstLine("Document No.","Line No.") THEN
      "Document No.HideValue" := TRUE;
    */
    //end;
}
