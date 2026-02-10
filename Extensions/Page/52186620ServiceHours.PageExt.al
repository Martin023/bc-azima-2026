#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186620 pageextension52186620 extends "Service Hours" 
{
    layout
    {
        modify("Service Contract No.")
        {
            ApplicationArea = Basic;
        }
        modify("Starting Date")
        {
            ApplicationArea = Basic;
        }
        modify(Day)
        {
            ApplicationArea = Basic;
        }
        modify("Starting Time")
        {
            ApplicationArea = Basic;
        }
        modify("Ending Time")
        {
            ApplicationArea = Basic;
        }
        modify("Valid on Holidays")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Contract No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Date"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Day(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Time"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Time"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Valid on Holidays"(Control 15)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("&Copy Default Service Hours")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Copy Default Service Hours"(Action 17)".

    }
}
