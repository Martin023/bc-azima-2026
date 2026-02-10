#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186274 pageextension52186274 extends "Campaign Entries" 
{
    layout
    {
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify(Canceled)
        {
            ApplicationArea = Basic;
        }
        modify(Date)
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Cost (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Duration (Min.)")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Interactions")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Canceled(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Date(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost (LCY)"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Duration (Min.)"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Interactions"(Control 12)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Interaction Log E&ntry")
        {
            ApplicationArea = Basic;
        }
        modify("Switch Check&mark in Canceled")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Interaction Log E&ntry"(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Switch Check&mark in Canceled"(Action 20)".

        modify("Delete Canceled Entries")
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
