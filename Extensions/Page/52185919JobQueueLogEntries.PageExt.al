#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185919 pageextension52185919 extends "Job Queue Log Entries" 
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
        modify(Description)
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
        modify("Start Date/Time")
        {
            ApplicationArea = Basic;
        }
        modify(Duration)
        {

            //Unsupported feature: Property Modification (Name) on "Duration(Control 13)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "Duration(Control 13)".


            //Unsupported feature: Property Insertion (Visible) on "Duration(Control 13)".

        }
        modify("End Date/Time")
        {
            ApplicationArea = Basic;
        }
        // modify(GetErrorMessage)
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Job Queue Category Code")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Object Type to Run"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Object ID to Run"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Object Caption to Run"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Start Date/Time"(Control 4)".


        //Unsupported feature: Property Deletion (CaptionML) on "Duration(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Duration(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""End Date/Time"(Control 6)".


        //Unsupported feature: Property Deletion (Visible) on ""End Date/Time"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GetErrorMessage(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Processed by User ID"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Queue Category Code"(Control 17)".

        addfirst(factboxes)
        {
            systempart(Control1900383207;Links)
            {
                Visible = false;
            }
            systempart(Control1905767507;Notes)
            {
                Visible = false;
            }
        }
        moveafter("Start Date/Time";"End Date/Time")
    }
    actions
    {
        modify(Delete7days)
        {
            ApplicationArea = Basic;
        }
        modify(Delete0days)
        {
            ApplicationArea = Basic;
        }
        modify("Show Error Message")
        {
            ApplicationArea = Basic;
        }
        modify(SetStatusToError)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Delete7days(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Delete0days(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Show Error Message"(Action 3)".


        //Unsupported feature: Property Deletion (Enabled) on ""Show Error Message"(Action 3)".

        modify("Show Error Call Stack")
        {
            Visible = false;
        }


        //Unsupported feature: Code Modification on "SetStatusToError(Action 18).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF CONFIRM(JobQueueEntryRunningQst,FALSE) THEN
              MarkAsError;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF CONFIRM(Text001,FALSE) THEN
              MarkAsError;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "SetStatusToError(Action 18)".

        // modify(ActionContainer19)
        // {
        //     Visible = false;
        // }
        modify(Details)
        {
            Visible = false;
        }
    }

    var
        Text001: label 'This Job Queue Entry may be still running. If you set status to Error, it may keep running in background. Are you sure you want to set status to Error?';

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (LinksAllowed).


    //Unsupported feature: Property Deletion (UsageCategory).

}
