#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185934 pageextension52185934 extends "Error Messages"
{
    layout
    {
        modify("Message Type")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Context Field Name")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Context Field Name"(Control 8)".


            //Unsupported feature: Property Modification (Name) on ""Context Field Name"(Control 8)".

        }
        // modify(Source)
        // {

        //     //Unsupported feature: Property Modification (Name) on "Source(Control 4)".

        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on "Source(Control 4)".

        // }
        modify("Additional Information")
        {
            ApplicationArea = Basic;
        }
        modify("Support Url")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Message Type"(Control 3)".


        //Unsupported feature: Code Modification on "Description(Control 5).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        HandleDrillDown(FIELDNO("Context Record ID"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PageManagement.PageRun("Record ID");
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 5)".

        modify(Context)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (DrillDown) on ""Context Field Name"(Control 8)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Context Field Name"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Context Field Name"(Control 8)".

        // modify(Source)
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (CaptionML) on "Source(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Source(Control 4)".

        modify("Field Name")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Additional Information"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Support Url"(Control 7)".

        moveafter(Description; Source)
    }
    actions
    {
        modify(OpenRelatedRecord)
        {
            ApplicationArea = Basic;
        }


        //Unsupported feature: Code Modification on "OpenRelatedRecord(Action 1003).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        OnOpenRelatedRecord(Rec,IsHandled);
        IF NOT IsHandled THEN
          PageManagement.PageRun("Record ID");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PageManagement.PageRun("Record ID");
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "OpenRelatedRecord(Action 1003)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetRecords(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "SetRecords(PROCEDURE 1)".

    //procedure SetRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF TempErrorMessage.FINDFIRST THEN;
    IF TempErrorMessage.ISTEMPORARY THEN
      COPY(TempErrorMessage,TRUE)
    ELSE
      TempErrorMessage.CopyToTemp(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF TempErrorMessage.FINDFIRST THEN;
    COPY(TempErrorMessage,TRUE);
    */
    //end;
}
