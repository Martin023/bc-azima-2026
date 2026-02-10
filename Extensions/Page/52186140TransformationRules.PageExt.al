#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186140 pageextension52186140 extends "Transformation Rules" 
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Transformation Type")
        {
            ApplicationArea = Basic;
        }
        modify("Find Value")
        {
            ApplicationArea = Basic;
        }
        modify("Replace Value")
        {
            ApplicationArea = Basic;
        }
        modify("Start Position")
        {
            ApplicationArea = Basic;
        }
        modify(Length)
        {
            ApplicationArea = Basic;
        }
        modify("Data Format")
        {
            ApplicationArea = Basic;
        }
        modify("Data Formatting Culture")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transformation Type"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Find Value"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Replace Value"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Start Position"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Length(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Data Format"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Data Formatting Culture"(Control 11)".

    }

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ISEMPTY THEN
          CreateDefaultTransformations;
        OnCreateTransformationRules;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF ISEMPTY THEN
          CreateDefaultTransformations;
        */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
