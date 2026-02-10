#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185920 pageextension52185920 extends "My Job Queue" 
{
    layout
    {
        modify("Object Caption to Run")
        {
            ApplicationArea = Basic;
        }
        modify("Parameter String")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Earliest Start Date/Time")
        {
            ApplicationArea = Basic;
        }
        modify("Expiration Date/Time")
        {
            ApplicationArea = Basic;
        }
        modify("Job Queue Category Code")
        {
            ApplicationArea = Basic;
        }
        // modify(PingPong)
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Object Caption to Run"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Parameter String"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Earliest Start Date/Time"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expiration Date/Time"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Queue Category Code"(Control 5)".

    }
    actions
    {
        modify(ShowError)
        {
            ApplicationArea = Basic;
        }
        modify(Cancel)
        {
            ApplicationArea = Basic;
        }
        modify(Restart)
        {
            ApplicationArea = Basic;
        }
        modify(ShowRecord)
        {
            ApplicationArea = Basic;
        }
        modify(ScheduleReport)
        {
            ApplicationArea = Basic;
        }
        modify(EditJob)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowError(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Cancel(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Restart(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowRecord(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ScheduleReport(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "EditJob(Action 14)".

    }
}
