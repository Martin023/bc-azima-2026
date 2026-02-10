#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186302 pageextension52186302 extends "Sales Cycle Stages" 
{
    layout
    {
        modify(Stage)
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Completed %")
        {
            ApplicationArea = Basic;
        }
        modify("Activity Code")
        {
            ApplicationArea = Basic;
        }
        modify("Quote Required")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Skip")
        {
            ApplicationArea = Basic;
        }
        modify("Date Formula")
        {
            ApplicationArea = Basic;
        }
        modify(Comment)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Stage(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Completed %"(Control 6)".

        modify("Chances of Success %")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Activity Code"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quote Required"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Skip"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date Formula"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comment(Control 14)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Statistics)
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 21)".

    }
}
