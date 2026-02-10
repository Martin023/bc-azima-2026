#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186362 pageextension52186362 extends "Attendee Scheduling"
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Location)
        {
            ApplicationArea = Basic;
        }
        modify("Salesperson Code")
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify(Priority)
        {
            ApplicationArea = Basic;
        }
        modify("Interaction Template Code")
        {
            ApplicationArea = Basic;
        }
        modify("Language Code")
        {
            ApplicationArea = Basic;
            Enabled = "Language CodeEnable";
        }
        modify(Subject)
        {
            ApplicationArea = Basic;
        }
        modify(Attachment)
        {
            ApplicationArea = Basic;
        }
        modify("Unit Cost (LCY)")
        {
            ApplicationArea = Basic;
            Enabled = "Unit Cost (LCY)Enable";
        }
        modify("Unit Duration (Min.)")
        {
            ApplicationArea = Basic;
            Enabled = "Unit Duration (Min.)Enable";
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Priority(Control 14)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "AttendeeSubform(Control 29)".


        //Unsupported feature: Property Deletion (PartType) on "AttendeeSubform(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Interaction Template Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Language Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Subject(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Attachment(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Duration (Min.)"(Control 24)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Open)
        {
            ApplicationArea = Basic;
        }
        modify(Create)
        {
            ApplicationArea = Basic;
        }
        modify(Import)
        {
            ApplicationArea = Basic;
        }
        modify(Export)
        {
            ApplicationArea = Basic;
        }
        modify(Remove)
        {
            ApplicationArea = Basic;
        }
        modify("Send Invitations")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Open(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Create(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Import(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Export(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Remove(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Send Invitations"(Action 43)".

    }
    var

        FunctionsEnable: Boolean;

        "Language CodeEnable": Boolean;

    var

        "Unit Cost (LCY)Enable": Boolean;

        "Unit Duration (Min.)Enable": Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "No." <> "Organizer To-do No." THEN
      CurrPage.EDITABLE := FALSE;

    IF Closed THEN
      CurrPage.EDITABLE := FALSE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "No." <> "Organizer To-do No." THEN BEGIN
      CurrPage.EDITABLE := FALSE;
      FunctionsEnable := FALSE;
    END;
    #3..5
    */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UnitDurationMinEnable := TRUE;
    UnitCostLCYEnable := TRUE;
    AttachmentEnable := TRUE;
    SubjectEnable := TRUE;
    LanguageCodeEnable := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Unit Duration (Min.)Enable" := TRUE;
    "Unit Cost (LCY)Enable" := TRUE;
    AttachmentEnable := TRUE;
    SubjectEnable := TRUE;
    "Language CodeEnable" := TRUE;
    FunctionsEnable := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "EnableFields(PROCEDURE 1)".

    //procedure EnableFields();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    LanguageCodeEnable := "Interaction Template Code" <> '';
    SubjectEnable := "Interaction Template Code" <> '';
    AttachmentEnable := "Interaction Template Code" <> '';
    UnitCostLCYEnable := "Interaction Template Code" <> '';
    UnitDurationMinEnable := "Interaction Template Code" <> ''
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Language CodeEnable" := "Interaction Template Code" <> '';
    SubjectEnable := "Interaction Template Code" <> '';
    AttachmentEnable := "Interaction Template Code" <> '';
    "Unit Cost (LCY)Enable" := "Interaction Template Code" <> '';
    "Unit Duration (Min.)Enable" := "Interaction Template Code" <> ''
    */
    //end;
}
