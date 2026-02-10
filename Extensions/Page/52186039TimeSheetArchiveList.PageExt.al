#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186039 pageextension52186039 extends "Time Sheet Archive List" 
{
    Caption = 'Time Sheet Archive List';
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Starting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Ending Date")
        {
            ApplicationArea = Basic;
        }
        modify("Resource No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Date"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Date"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource No."(Control 6)".

    }
    actions
    {
        modify("&View Time Sheet")
        {
            ApplicationArea = Basic;
        }
        modify(Comments)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&View Time Sheet"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comments(Action 9)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
