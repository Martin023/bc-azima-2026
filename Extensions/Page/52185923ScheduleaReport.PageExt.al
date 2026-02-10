#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185923 pageextension52185923 extends "Schedule a Report" 
{
    layout
    {
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
        modify("Report Request Page Options")
        {
            ApplicationArea = Basic;
        }
        modify("Report Output Type")
        {
            ApplicationArea = Basic;
        }
        modify("Printer Name")
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Object ID to Run"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Object Caption to Run"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Report Request Page Options"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Report Output Type"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Printer Name"(Control 7)".

        modify("Next Run Date Formula")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Earliest Start Date/Time"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expiration Date/Time"(Control 9)".

        addfirst(Content)
        {
            field(WarningMsg;WarningMsg)
            {
                ApplicationArea = Basic;
                Enabled = false;
                ShowCaption = false;
                Style = Attention;
                StyleExpr = true;
                Visible = WarningMsg <> '';
                Width = 100;
            }
        }
    }

    var
        JobQueueEnqueue: Codeunit "Job Queue - Enqueue";

    var
        WarningMsg: Text;
        NoRunningJobQueueMsg: label 'There is no running job queue for scheduled reports.';


    //Unsupported feature: Code Insertion (VariableCollection) on "OnOpenPage".

    //trigger (Variable: JobQueueEnqueue)()
    //Parameters and return type have not been exported.
    //begin
        /*
        */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT FINDFIRST THEN BEGIN
          INIT;
          ReportEditable := TRUE;
        #4..6
          INSERT(TRUE);
        END ELSE
          OutPutEditable := REPORT.DEFAULTLAYOUT("Object ID to Run") <> DEFAULTLAYOUT::None; // Processing Only
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..9

        IF NOT JobQueueEnqueue.JobQueueIsRunning('') THEN
          WarningMsg := NoRunningJobQueueMsg;
        */
    //end;


    //Unsupported feature: Code Modification on "OnQueryClosePage".

    //trigger OnQueryClosePage(CloseAction: Action): Boolean
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF CloseAction <> ACTION::OK THEN
          EXIT(TRUE);

        #4..7

        CALCFIELDS(XML);
        JobQueueEntry := Rec;
        CLEAR(JobQueueEntry.ID); // "Job Queue - Enqueue" defines it on the real record insert
        JobQueueEntry."Run in User Session" := NOT JobQueueEntry.IsNextRunDateFormulaSet;
        IF JobQueueEntry.Description = '' THEN
          JobQueueEntry.Description := COPYSTR("Object Caption to Run",1,MAXSTRLEN(JobQueueEntry.Description));
        CODEUNIT.RUN(CODEUNIT::"Job Queue - Enqueue",JobQueueEntry);
        IF JobQueueEntry.IsToReportInbox THEN
          MESSAGE(ReportScheduledMsg);
        EXIT(TRUE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..10
        JobQueueEntry."Run in User Session" := TRUE;
        #13..15
        EXIT(TRUE);
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "ScheduleAReport(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "SetParameters(PROCEDURE 2)".

}
