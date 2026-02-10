#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186415 pageextension52186415 extends "Integration Synch. Job List" 
{
    layout
    {
        modify("Start Date/Time")
        {
            ApplicationArea = Basic;
        }
        modify("Finish Date/Time")
        {
            ApplicationArea = Basic;
        }
        modify(Duration)
        {
            ApplicationArea = Basic;
        }
        modify("Integration Table Mapping Name")
        {
            ApplicationArea = Basic;
        }
        modify(Inserted)
        {
            ApplicationArea = Basic;
        }
        modify(Modified)
        {
            ApplicationArea = Basic;
        }
        modify(Unchanged)
        {
            ApplicationArea = Basic;
        }
        modify(Failed)
        {
            ApplicationArea = Basic;
        }
        modify(Direction)
        {
            ApplicationArea = Basic;
        }
        modify(Message)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Start Date/Time"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Finish Date/Time"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Duration(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Integration Table Mapping Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Inserted(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Modified(Control 8)".

        modify(Deleted)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Unchanged(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Failed(Control 11)".

        modify(Skipped)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Direction(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Message(Control 13)".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "Delete7days(Action 15)".


        //Unsupported feature: Property Deletion (Enabled) on "Delete7days(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Delete0days(Action 14)".


        //Unsupported feature: Property Deletion (Enabled) on "Delete0days(Action 14)".

    }

    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF IntegrationTableMapping.GET("Integration Table Mapping Name") THEN BEGIN
          TableMetadata.GET(IntegrationTableMapping."Table ID");
          IF "Synch. Direction" = "Synch. Direction"::ToIntegrationTable THEN
            SynchDirection :=
              STRSUBSTNO(SynchDirectionTxt,TableMetadata.Caption,IntegrationTableMapping.GetExtendedIntegrationTableCaption)
          ELSE
            SynchDirection :=
              STRSUBSTNO(SynchDirectionTxt,IntegrationTableMapping.GetExtendedIntegrationTableCaption,TableMetadata.Caption);
        END;
        DoHideDuration := "Finish Date/Time" < "Start Date/Time";
        IF DoHideDuration THEN
          CLEAR(Duration)
        ELSE
          Duration := "Finish Date/Time" - "Start Date/Time";

        HasRecords := NOT ISEMPTY;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IntegrationTableMapping.GET("Integration Table Mapping Name");
        TableMetadata.GET(IntegrationTableMapping."Table ID");
        IF "Synch. Direction" = "Synch. Direction"::ToIntegrationTable THEN
          SynchDirection := STRSUBSTNO(SynchDirectionTxt,TableMetadata.Caption,IntegrationTableMapping.GetExtendedIntegrationTableCaption)
        ELSE
          SynchDirection :=
            STRSUBSTNO(SynchDirectionTxt,IntegrationTableMapping.GetExtendedIntegrationTableCaption,TableMetadata.Caption);

        #10..14
        */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (DataCaptionExpr).


    //Unsupported feature: Property Deletion (UsageCategory).

}
