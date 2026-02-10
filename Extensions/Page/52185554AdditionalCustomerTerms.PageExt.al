#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185554 pageextension52185554 extends "Additional Customer Terms" 
{
    layout
    {
        modify(PleaseReadLbl)
        {
            ApplicationArea = Basic;
        }
        modify(Control3)
        {
            ApplicationArea = Basic;
        }
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

        //Unsupported feature: Property Deletion (ToolTipML) on "Accepted(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Accepted By"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Accepted On"(Control 14)".

    }
    actions
    {
        modify("Read the Additional Customer Terms")
        {
            ApplicationArea = Basic;
        }
        modify("&Accept the Additional Customer Terms")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Read the Additional Customer Terms"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Accept the Additional Customer Terms"(Action 11)".

    }
}
