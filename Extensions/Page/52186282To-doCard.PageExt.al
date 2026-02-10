#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186282 pageextension52186282 extends "Task Card"
{

    //Unsupported feature: Property Modification (Name) on ""Task Card"(Page 5098)".

    Caption = 'To-do Card';
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
        modify("No. of Attendees")
        {
            ApplicationArea = Basic;
            Enabled = "No. of AttendeesEnable";
        }
        modify("Attendees Accepted No.")
        {
            ApplicationArea = Basic;
            Enabled = "Attendees Accepted No.Enable";
        }
        modify("Contact No.")
        {
            ApplicationArea = Basic;
            Editable = "Contact No.Editable";
        }
        modify("Contact Name")
        {
            ApplicationArea = Basic;
            HideValue = "Contact NameHideValue";
        }
        modify("Contact Company Name")
        {
            ApplicationArea = Basic;
            HideValue = "Contact Company NameHideValue";
        }
        modify("Team Code")
        {
            ApplicationArea = Basic;
        }
        modify("Completed By")
        {
            ApplicationArea = Basic;
            Enabled = "Completed ByEnable";
            Editable = "Completed ByEditable";
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify(Priority)
        {
            ApplicationArea = Basic;
        }
        modify(TypeSaaS)
        {

            //Unsupported feature: Property Modification (Name) on "TypeSaaS(Control 12)".

            ApplicationArea = Basic;
        }
        modify(AllDayEvent)
        {
            ApplicationArea = Basic;
        }
        modify(Date)
        {
            ApplicationArea = Basic;
        }
        modify(StartTime)
        {
            ApplicationArea = Basic;
        }
        modify(Duration)
        {
            ApplicationArea = Basic;
        }
        modify(EndingDate)
        {
            ApplicationArea = Basic;
        }
        modify(EndingTime)
        {
            ApplicationArea = Basic;
        }
        modify(Canceled)
        {
            ApplicationArea = Basic;
        }
        modify(Closed)
        {
            ApplicationArea = Basic;
        }
        modify("Date Closed")
        {
            ApplicationArea = Basic;
        }
        modify("Campaign No.")
        {
            ApplicationArea = Basic;
        }
        modify("Campaign Description")
        {
            ApplicationArea = Basic;
        }
        modify("Opportunity No.")
        {
            ApplicationArea = Basic;
        }
        modify("Opportunity Description")
        {
            ApplicationArea = Basic;
        }
        modify(Control39)
        {
            ApplicationArea = Basic;
        }
        modify("Recurring Date Interval")
        {
            ApplicationArea = Basic;
            Enabled = "Recurring Date IntervalEnable";
        }
        modify("Calc. Due Date From")
        {
            ApplicationArea = Basic;
            Enabled = "Calc. Due Date FromEnable";
            Editable = "Calc. Due Date FromEditable";
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Control 67)".


        //Unsupported feature: Property Deletion (Visible) on "Location(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Attendees"(Control 71)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Attendees Accepted No."(Control 73)".


        //Unsupported feature: Code Insertion (VariableCollection) on ""Contact No."(Control 10).OnLookup".

        //trigger (Variable: Todo)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Contact No."(Control 10).OnLookup".

        //trigger "(Control 10)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Type = Type::Meeting THEN BEGIN
          Task.SETRANGE("No.","No.");
          PAGE.RUNMODAL(PAGE::"Attendee Scheduling",Task);
        END ELSE BEGIN
          IF Cont.GET("Contact No.") THEN;
          IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN BEGIN
            VALIDATE("Contact No.",Cont."No.");
            CurrPage.UPDATE;
          END;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF Type = Type::Meeting THEN BEGIN
          Todo.SETRANGE("No.","No.");
          AttendeesScheduling.SETTABLEVIEW(Todo);
          AttendeesScheduling.RUNMODAL;
        #4..10
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact No."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Name"(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Company Name"(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Team Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Completed By"(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Priority(Control 18)".


        //Unsupported feature: Property Deletion (CaptionML) on "TypeSaaS(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TypeSaaS(Control 12)".


        //Unsupported feature: Property Deletion (OptionCaptionML) on "TypeSaaS(Control 12)".


        //Unsupported feature: Property Deletion (Visible) on "TypeSaaS(Control 12)".

        modify(TypeOnPrem)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "AllDayEvent(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Date(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "StartTime(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Duration(Control 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on "EndingDate(Control 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on "EndingTime(Control 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Canceled(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Closed(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date Closed"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign Description"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Opportunity No."(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Opportunity Description"(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control39(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Recurring Date Interval"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Calc. Due Date From"(Control 43)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Ta&sk")
        {
            Caption = 'To-&do';

            //Unsupported feature: Property Modification (Name) on ""Ta&sk"(Action 29)".

        }
        modify("Co&mment")
        {
            ApplicationArea = Basic;
        }
        modify("Interaction Log E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("Postponed &Interactions")
        {
            ApplicationArea = Basic;
        }
        modify("A&ttendee Scheduling")
        {
            ApplicationArea = Basic;
        }
        modify("Assign Activities")
        {
            ApplicationArea = Basic;
        }
        modify(MakePhoneCall)
        {

            //Unsupported feature: Property Modification (Name) on "MakePhoneCall(Action 36)".

            ApplicationArea = Basic;
        }
        modify("&Create Task")
        {
            Caption = '&Create To-do';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""&Create Task"(Action 31)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mment"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Interaction Log E&ntries"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Postponed &Interactions"(Action 69)".



        //Unsupported feature: Code Modification on ""A&ttendee Scheduling"(Action 70).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Type <> Type::Meeting THEN
          ERROR(CannotSelectAttendeesErr,FORMAT(Type));

        PAGE.RUNMODAL(PAGE::"Attendee Scheduling",Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF Type <> Type::Meeting THEN
          ERROR(Text003,FORMAT(Type));

        PAGE.RUNMODAL(PAGE::"Attendee Scheduling",Rec);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""A&ttendee Scheduling"(Action 70)".



        //Unsupported feature: Code Insertion (VariableCollection) on ""Assign Activities"(Action 35).OnAction".

        //trigger (Variable: TempToDo)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Assign Activities"(Action 35).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TempTask.AssignActivityFromTask(Rec)
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TempToDo.AssignActivityFromToDo(Rec)
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Assign Activities"(Action 35)".



        //Unsupported feature: Code Insertion (VariableCollection) on ""Make &Phone Call"(Action 36).OnAction".

        //trigger (Variable: SegmentLine)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "MakePhoneCall(Action 36).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Contact No." = '' THEN BEGIN
          IF (Type = Type::Meeting) AND ("Team Code" = '') THEN
            ERROR(MakePhoneCallIsNotAvailableErr);
          ERROR(MustAssignContactErr);
        END;
        TempSegmentLine."To-do No." := "No.";
        TempSegmentLine."Contact No." := "Contact No.";
        TempSegmentLine."Contact Company No." := "Contact Company No.";
        TempSegmentLine."Campaign No." := "Campaign No.";
        TempSegmentLine."Salesperson Code" := "Salesperson Code";
        TempSegmentLine.CreatePhoneCall;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "Contact No." = '' THEN BEGIN
          IF (Type = Type::Meeting) AND ("Team Code" = '') THEN
            ERROR(Text005);
          ERROR(Text006);
        END;
        SegmentLine."To-do No." := "No.";
        SegmentLine."Contact No." := "Contact No.";
        SegmentLine."Contact Company No." := "Contact Company No.";
        SegmentLine."Campaign No." := "Campaign No.";
        SegmentLine.CreateCall;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "MakePhoneCall(Action 36)".



        //Unsupported feature: Code Insertion (VariableCollection) on ""&Create To-do"(Action 31).OnAction".

        //trigger (Variable: TempToDo)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""&Create Task"(Action 31).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TempTask.CreateTaskFromTask(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TempToDo.CreateToDoFromToDo(Rec);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Create Task"(Action 31)".

    }

    var
        TempToDo: Record "To-do" temporary;

    var
        SegmentLine: Record "Segment Line" temporary;

    var
    // TempToDo: Record "To-do" temporary;

    var
        Todo: Record "To-do";
        AttendeesScheduling: Page "Attendee Scheduling";

    var
        Text003: label 'You cannot select attendees for a to-do of the ''%1'' type.';
        Text005: label 'The Make Phone Call function for this to-do is available only in the Attendee Scheduling window.';
        Text006: label 'You must assign a contact to this to-do before you can use the Make Phone Call function.';
        Text007: label '(Multiple)';

        "Contact NameHideValue": Boolean;

        "Contact Company NameHideValue": Boolean;

        "Contact No.Editable": Boolean;

    var

        "Calc. Due Date FromEditable": Boolean;

        "Completed ByEditable": Boolean;

    var

        MakePhoneCallEnable: Boolean;

        "No. of AttendeesEnable": Boolean;

        "Attendees Accepted No.Enable": Boolean;

        "Completed ByEnable": Boolean;

        "Recurring Date IntervalEnable": Boolean;

        "Calc. Due Date FromEnable": Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SwitchCardControls;
    IF "No." <> "Organizer To-do No." THEN
      CurrPage.EDITABLE := FALSE
    ELSE
      CurrPage.EDITABLE := TRUE;
    SetRecurringEditable;
    EnableFields;
    ContactNoOnFormat(FORMAT("Contact No."));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Contact Company NameHideValue" := FALSE;
    "Contact NameHideValue" := FALSE;
    #1..8
    ContactNameOnFormat;
    ContactCompanyNameOnFormat;
    */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CalcDueDateFromEnable := TRUE;
    RecurringDateIntervalEnable := TRUE;
    CompletedByEnable := TRUE;
    AttendeesAcceptedNoEnable := TRUE;
    NoOfAttendeesEnable := TRUE;
    AllDayEventEnable := TRUE;
    LocationEnable := TRUE;
    DurationEnable := TRUE;
    EndingTimeEnable := TRUE;
    StartTimeEnable := TRUE;
    CompletedByEditable := TRUE;
    CalcDueDateFromEditable := TRUE;
    RecurringDateIntervalEditable := TRUE;
    ContactNoEditable := TRUE;
    IsSoftwareAsAService := PermissionManager.SoftwareAsAService;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Calc. Due Date FromEnable" := TRUE;
    "Recurring Date IntervalEnable" := TRUE;
    "Completed ByEnable" := TRUE;
    "Attendees Accepted No.Enable" := TRUE;
    "No. of AttendeesEnable" := TRUE;
    MakePhoneCallEnable := TRUE;
    #6..10
    "Completed ByEditable" := TRUE;
    "Calc. Due Date FromEditable" := TRUE;
    RecurringDateIntervalEditable := TRUE;
    "Contact No.Editable" := TRUE;
    */
    //end;


    //Unsupported feature: Code Insertion on "OnOpenPage".

    //trigger OnOpenPage()
    //begin
    /*
    IF GETFILTER("No.") = '' THEN
      CurrPage.EDITABLE := FALSE;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetRecurringEditable(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "SetRecurringEditable(PROCEDURE 1)".

    //procedure SetRecurringEditable();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RecurringDateIntervalEditable := Recurring;
    CalcDueDateFromEditable := Recurring;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    RecurringDateIntervalEditable := Recurring;
    "Calc. Due Date FromEditable" := Recurring;
    */
    //end;


    //Unsupported feature: Code Modification on "EnableFields(PROCEDURE 2)".

    //procedure EnableFields();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RecurringDateIntervalEnable := Recurring;
    CalcDueDateFromEnable := Recurring;

    IF NOT Recurring THEN BEGIN
      EVALUATE("Recurring Date Interval",'');
    #6..20
    END;

    GetEndDateTime;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Recurring Date IntervalEnable" := Recurring;
    "Calc. Due Date FromEnable" := Recurring;
    #3..23
    */
    //end;


    //Unsupported feature: Code Modification on "SwitchCardControls(PROCEDURE 3)".

    //procedure SwitchCardControls();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Type = Type::Meeting THEN BEGIN
      ContactNoEditable := FALSE;

      NoOfAttendeesEnable := TRUE;
      AttendeesAcceptedNoEnable := TRUE;
    END ELSE BEGIN
      ContactNoEditable := TRUE;

      NoOfAttendeesEnable := FALSE;
      AttendeesAcceptedNoEnable := FALSE;
    END;
    IF "Team Code" = '' THEN
      CompletedByEnable := FALSE
    ELSE BEGIN
      CompletedByEnable := TRUE;
      CompletedByEditable := NOT Closed
    END
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF Type = Type::Meeting THEN BEGIN
      "Contact No.Editable" := FALSE;
      MakePhoneCallEnable := FALSE;

      "No. of AttendeesEnable" := TRUE;
      "Attendees Accepted No.Enable" := TRUE;
    END ELSE BEGIN
      "Contact No.Editable" := TRUE;
      MakePhoneCallEnable := TRUE;

      "No. of AttendeesEnable" := FALSE;
      "Attendees Accepted No.Enable" := FALSE;
    END;
    IF "Team Code" = '' THEN
      "Completed ByEnable" := FALSE
    ELSE BEGIN
      "Completed ByEnable" := TRUE;
      "Completed ByEditable" := NOT Closed
    END
    */
    //end;


    //Unsupported feature: Code Modification on "ContactNoOnFormat(PROCEDURE 19025756)".

    //procedure ContactNoOnFormat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Type = Type::Meeting THEN
      Text := MultipleTxt;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF Type = Type::Meeting THEN
      Text := Text007;
    */
    //end;

    local procedure ContactNameOnFormat()
    begin
        if Rec.Type = Rec.Type::Meeting then
            "Contact NameHideValue" := true;
    end;

    local procedure ContactCompanyNameOnFormat()
    begin
        if Rec.Type = Rec.Type::Meeting then
            "Contact Company NameHideValue" := true;
    end;
}
