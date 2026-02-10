#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185553 pageextension52185553 extends "Additional Cust. Terms Setup" 
{
    layout
    {
        modify(Accepted)
        {
            ApplicationArea = Basic;
        }
        modify("Accepted By")
        {
            ApplicationArea = Basic;
        }
        modify("Accepted On")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Accepted(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Accepted By"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Accepted On"(Control 14)".

    }
    actions
    {
        modify(Activate)
        {
            ApplicationArea = Basic;
        }
        modify(Deactivate)
        {
            ApplicationArea = Basic;
        }
        modify(Reset)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Activate(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Deactivate(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reset(Action 3)".

    }
}
