#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185917 pageextension52185917 extends "Job Queue Entries" 
{
    layout
    {
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Object Type to Run")
        {
            ApplicationArea = Basic;
        }
        modify("Object ID to Run")
        {
            ApplicationArea = Basic;
        }
        modify("Object Caption to Run")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Job Queue Category Code")
        {
            ApplicationArea = Basic;
        }
        modify("User Session Started")
        {
            ApplicationArea = Basic;
        }
        modify("Parameter String")
        {
            ApplicationArea = Basic;
        }
        modify("Earliest Start Date/Time")
        {
            ApplicationArea = Basic;
        }
        modify(Scheduled)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "Scheduled(Control 16)".


            //Unsupported feature: Property Modification (Name) on "Scheduled(Control 16)".


            //Unsupported feature: Property Insertion (Visible) on "Scheduled(Control 16)".

        }
        modify("Recurring Job")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Minutes between Runs")
        {
            ApplicationArea = Basic;
        }
        modify("Run on Mondays")
        {
            ApplicationArea = Basic;
        }
        modify("Run on Tuesdays")
        {
            ApplicationArea = Basic;
        }
        modify("Run on Wednesdays")
        {
            ApplicationArea = Basic;
        }
        modify("Run on Thursdays")
        {
            ApplicationArea = Basic;
        }
        modify("Run on Fridays")
        {
            ApplicationArea = Basic;
        }
        modify("Run on Saturdays")
        {
            ApplicationArea = Basic;
        }
        modify("Run on Sundays")
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

        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 2)".


        //Unsupported feature: Property Deletion (Style) on ""User ID"(Control 2)".


        //Unsupported feature: Property Deletion (StyleExpr) on ""User ID"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Object Type to Run"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Object ID to Run"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Object Caption to Run"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Queue Category Code"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User Session Started"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Parameter String"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Earliest Start Date/Time"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Scheduled(Control 16)".


        //Unsupported feature: Property Deletion (Style) on "Scheduled(Control 16)".


        //Unsupported feature: Property Deletion (StyleExpr) on "Scheduled(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Recurring Job"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Minutes between Runs"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Run on Mondays"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Run on Tuesdays"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Run on Wednesdays"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Run on Thursdays"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Run on Fridays"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Run on Saturdays"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Run on Sundays"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Time"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Time"(Control 38)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(ResetStatus)
        {
            ApplicationArea = Basic;
        }
        modify(Suspend)
        {
            ApplicationArea = Basic;
        }
        modify(ShowError)
        {
            ApplicationArea = Basic;
        }
        modify(Restart)
        {
            ApplicationArea = Basic;
        }
        modify(LogEntries)
        {
            ApplicationArea = Basic;
        }
        modify(ShowRecord)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ResetStatus(Action 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Suspend(Action 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowError(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Restart(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LogEntries(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowRecord(Action 21)".

        modify(RemoveError)
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
