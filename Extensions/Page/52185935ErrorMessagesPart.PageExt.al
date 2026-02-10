#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185935 pageextension52185935 extends "Error Messages Part" 
{
    layout
    {
        modify("Message Type")
        {
            ApplicationArea = Basic;
        }
        modify("Table Name")
        {
            ApplicationArea = Basic;
        }
        modify("Field Name")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Message Type"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Table Name"(Control 6)".


        //Unsupported feature: Property Deletion (Width) on ""Field Name"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Field Name"(Control 4)".


        //Unsupported feature: Code Modification on "Description(Control 2).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF NOT DisableOpenRelatedEntity THEN
              PageManagement.PageRun("Record ID");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            PageManagement.PageRun("Record ID");
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 2)".

    }
    actions
    {
        modify(OpenRelatedRecord)
        {
            ApplicationArea = Basic;
        }
        modify(ViewDetails)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "OpenRelatedRecord(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ViewDetails(Action 11)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetRecords(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "GetStyleOfRecord(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "GetStyleOfRecord(PROCEDURE 2)".

    //procedure GetStyleOfRecord();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT RecordVariant.ISRECORD THEN
          EXIT;

        RecordRef.GETTABLE(RecordVariant);
        RecordIDToHighlight := RecordRef.RECORDID;

        IF HasErrorMessagesRelatedTo(RecordVariant) THEN
          StyleExpression := 'Attention'
        ELSE
          StyleExpression := 'None';
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5
        CurrPage.ACTIVATE(TRUE);
        #6..10
        */
    //end;


    //Unsupported feature: Code Modification on "EnableActions(PROCEDURE 3)".

    //procedure EnableActions();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        RecID := "Record ID";
        IF DisableOpenRelatedEntity THEN
          EnableOpenRelatedEntity := FALSE
        ELSE
          EnableOpenRelatedEntity := RecID.TABLENO <> 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        RecID := "Record ID";
        EnableOpenRelatedEntity := RecID.TABLENO <> 0;
        */
    //end;
}
