#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187218 pageextension52187218 extends "User Setup FactBox" 
{

    //Unsupported feature: Property Modification (Name) on ""User Setup FactBox"(Page 9819)".

    Caption = 'User Setup Factbox';
    layout
    {
        modify("Allow Posting From")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Posting To")
        {
            ApplicationArea = Basic;
        }
        modify("Register Time")
        {
            ApplicationArea = Basic;
        }
        modify("Time Sheet Admin.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Posting From"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Posting To"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Register Time"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Time Sheet Admin."(Control 3)".

    }
}
