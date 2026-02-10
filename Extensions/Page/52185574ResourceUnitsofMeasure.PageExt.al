#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185574 pageextension52185574 extends "Resource Units of Measure" 
{
    layout
    {
        modify("Resource No.")
        {
            ApplicationArea = Basic;
        }
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. per Unit of Measure")
        {
            ApplicationArea = Basic;
        }
        modify("Related to Base Unit of Meas.")
        {
            ApplicationArea = Basic;
        }
        modify(ResUnitOfMeasure)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource No."(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. per Unit of Measure"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Related to Base Unit of Meas."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ResUnitOfMeasure(Control 3)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Res.GET("Resource No.") THEN
          ResBaseUOM := Res."Base Unit of Measure";
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        Res.GET("Resource No.");
        ResBaseUOM := Res."Base Unit of Measure";
        */
    //end;
}
