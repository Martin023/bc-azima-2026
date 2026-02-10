#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186046 pageextension52186046 extends "Time Sheet Line Service Detail" 
{
    layout
    {
        modify("Service Order No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Work Type Code")
        {
            ApplicationArea = Basic;
        }
        modify(Chargeable)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Order No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Type Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Chargeable(Control 7)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetParameters(PROCEDURE 2)".

}
