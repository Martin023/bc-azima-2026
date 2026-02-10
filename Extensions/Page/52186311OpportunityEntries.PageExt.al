#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186311 pageextension52186311 extends "Opportunity Entries" 
{
    layout
    {
        modify("Opportunity No.")
        {
            ApplicationArea = Basic;
        }
        modify("Action Taken")
        {
            ApplicationArea = Basic;
        }
        modify(Active)
        {
            ApplicationArea = Basic;
        }
        modify("Date of Change")
        {
            ApplicationArea = Basic;
        }
        modify("Date Closed")
        {
            ApplicationArea = Basic;
        }
        modify("Days Open")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Cycle Code")
        {
            ApplicationArea = Basic;
        }
        modify("Previous Sales Cycle Stage")
        {
            ApplicationArea = Basic;
        }
        modify("Estimated Value (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Calcd. Current Value (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Completed %")
        {
            ApplicationArea = Basic;
        }
        modify("Chances of Success %")
        {
            ApplicationArea = Basic;
        }
        modify("Probability %")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Opportunity No."(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Action Taken"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Active(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date of Change"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date Closed"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Days Open"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Cycle Code"(Control 12)".

        modify("Sales Cycle Stage Description")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Previous Sales Cycle Stage"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Estimated Value (LCY)"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Calcd. Current Value (LCY)"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Completed %"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Chances of Success %"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Probability %"(Control 26)".

        modify("Close Opportunity Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter("Sales Cycle Code")
        {
            field("Sales Cycle Stage";Rec."Sales Cycle Stage")
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        // modify(ActionContainer3)
        // {
        //     Visible = false;
        // }
        modify("Show Opportunity Card")
        {
            Visible = false;
        }
        modify("Delete Closed")
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
