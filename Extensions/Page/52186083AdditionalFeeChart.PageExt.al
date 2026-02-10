#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186083 pageextension52186083 extends "Additional Fee Chart" 
{
    layout
    {
        modify(ChargePerLine)
        {
            ApplicationArea = Basic;
        }
        modify(Currency)
        {
            ApplicationArea = Basic;
        }
        modify("Max. Remaining Amount")
        {
            ApplicationArea = Basic;
        }
        modify(BusinessChart)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ChargePerLine(Control 1001)".


        //Unsupported feature: Property Deletion (CaptionML) on "Currency(Control 1003)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Currency(Control 1003)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Max. Remaining Amount"(Control 1004)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Max. Remaining Amount"(Control 1004)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetViewMode(PROCEDURE 1000)".

}
