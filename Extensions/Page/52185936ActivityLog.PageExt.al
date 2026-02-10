#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185936 pageextension52185936 extends "Activity Log" 
{
    layout
    {
        modify("Activity Date")
        {
            ApplicationArea = Basic;
        }
        modify("User ID")
        {
            ApplicationArea = Basic;
        }
        modify(Context)
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Activity Message")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Activity Date"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Context(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Activity Message"(Control 7)".

        modify(HasDetailedInfo)
        {
            Visible = false;
        }
    }
    actions
    {
        modify(OpenRelatedRecord)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on "OpenRelatedRecord(Action 8).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF NOT PageManagement.PageRun("Record ID") THEN
              MESSAGE(NoRelatedRecordMsg);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            PageManagement.PageRun("Record ID");
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "OpenRelatedRecord(Action 8)".

        modify(ViewDetails)
        {
            Visible = false;
        }
        modify(Delete7days)
        {
            Visible = false;
        }
        modify(Delete0days)
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Deletion (SourceTableView).

}
