#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186280 pageextension52186280 extends "Task List"
{

    //Unsupported feature: Property Modification (Name) on ""Task List"(Page 5096)".

    Caption = 'To-do List';

    //Unsupported feature: Property Modification (CardPageID) on ""Task List"(Page 5096)".

    layout
    {
        modify(Closed)
        {
            ApplicationArea = Basic;
        }
        modify(Date)
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Priority)
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Organizer To-do No.")
        {
            ApplicationArea = Basic;
        }
        modify("Date Closed")
        {
            ApplicationArea = Basic;
        }
        modify(Canceled)
        {
            ApplicationArea = Basic;
        }
        modify(Comment)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on "Comment(Control 18)".

        }
        modify("Contact No.")
        {
            ApplicationArea = Basic;
        }
        modify("Contact Company No.")
        {
            ApplicationArea = Basic;
        }
        modify("Salesperson Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Salesperson Code"(Control 24)".

        }
        modify("Team Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Team Code"(Control 22)".

        }
        modify("Campaign No.")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Campaign No."(Control 26)".

        }
        modify("Opportunity No.")
        {
            ApplicationArea = Basic;
        }
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Contact Name")
        {
            ApplicationArea = Basic;
        }
        modify("Contact Company Name")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Closed(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Date(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 6)".


        //Unsupported feature: Property Deletion (OptionCaptionML) on "Type(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Priority(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Organizer To-do No."(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date Closed"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Canceled(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comment(Control 18)".


        //Unsupported feature: Code Insertion (VariableCollection) on ""Contact No."(Control 20).OnLookup".

        //trigger (Variable: Todo)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Contact No."(Control 20).OnLookup".

        //trigger "(Control 20)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Type = Type::Meeting THEN BEGIN
          Task.SETRANGE("No.","No.");
          PAGE.RUNMODAL(PAGE::"Attendee Scheduling",Task);
        END ELSE BEGIN
          IF Cont.GET("Contact No.") THEN;
          IF PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK THEN;
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
        #4..7
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact No."(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Company No."(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Team Code"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign No."(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Opportunity No."(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Name"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contact Company Name"(Control 58)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Task)
        {

            //Unsupported feature: Property Modification (Name) on "Task(Action 31)".

            Caption = 'To-&do';
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

            //Unsupported feature: Property Modification (Name) on "MakePhoneCall(Action 42)".

            ApplicationArea = Basic;
        }
        modify("&Create Task")
        {
            Caption = '&Create To-do';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""&Create Task"(Action 33)".

        }
        modify("Edit Organizer Task")
        {
            Caption = 'Edit Organizer To-Do';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Edit Organizer Task"(Action 1034)".


            //Unsupported feature: Property Insertion (PromotedCategory) on ""Edit Organizer Task"(Action 1034)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mment"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Interaction Log E&ntries"(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Postponed &Interactions"(Action 50)".



        //Unsupported feature: Code Insertion (VariableCollection) on ""A&ttendee Scheduling"(Action 52).OnAction".

        //trigger (Variable: Todo)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""A&ttendee Scheduling"(Action 52).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Task.GET("Organizer To-do No.");
        PAGE.RUNMODAL(PAGE::"Attendee Scheduling",Task);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        Todo.GET("Organizer To-do No.");
        PAGE.RUNMODAL(PAGE::"Attendee Scheduling",Todo)
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""A&ttendee Scheduling"(Action 52)".



        //Unsupported feature: Code Insertion (VariableCollection) on ""Assign Activities"(Action 46).OnAction".

        //trigger (Variable: TempToDo)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Assign Activities"(Action 46).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TempTask.AssignActivityFromTask(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TempToDo.AssignActivityFromToDo(Rec);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Assign Activities"(Action 46)".



        //Unsupported feature: Code Insertion (VariableCollection) on ""Make &Phone Call"(Action 42).OnAction".

        //trigger (Variable: SegLine)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "MakePhoneCall(Action 42).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Contact No." <> '' THEN
          ContactNo := "Contact No."
        ELSE
        #4..10
            ERROR(Text004);
          ERROR(Text005);
        END;
        TempSegmentLine."To-do No." := "No.";
        TempSegmentLine."Contact No." := ContactNo;
        TempSegmentLine."Contact Company No." := ContCompanyNo;
        TempSegmentLine."Campaign No." := "Campaign No.";
        TempSegmentLine."Salesperson Code" := "Salesperson Code";
        TempSegmentLine.CreatePhoneCall;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..13
        SegLine."To-do No." := "No.";
        SegLine."Contact No." := ContactNo;
        SegLine."Contact Company No." := ContCompanyNo;
        SegLine."Campaign No." := "Campaign No.";

        SegLine.CreateCall;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "MakePhoneCall(Action 42)".

        modify("Delete Canceled Tasks")
        {
            Visible = false;
        }


        //Unsupported feature: Code Insertion (VariableCollection) on ""&Create To-do"(Action 33).OnAction".

        //trigger (Variable: TempToDo)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""&Create Task"(Action 33).OnAction".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Create Task"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Edit Organizer Task"(Action 1034)".

    }

    var
    // Todo: Record "To-do";

    var
    // TempToDo: Record "To-do" temporary;

    var
        SegLine: Record "Segment Line";

    var
        TempToDo: Record "To-do" temporary;

    var
        Todo: Record "To-do";
        AttendeesScheduling: Page "Attendee Scheduling";


    //Unsupported feature: Property Modification (TextConstString) on "Text004(Variable 1010)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=The Make Phone Call function for this task is available only on the Attendee Scheduling window.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=The Make Phone Call function for this to-do is available only on the Attendee Scheduling window.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text005(Variable 1011)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=You must select a task with a contact assigned to it before you can use the Make Phone Call function.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=You must select a to-do with a contact assigned to it before you can use the Make Phone Call function.;
    //Variable type has not been exported.

    var
        SalesPurchPerson: Record "Salesperson/Purchaser";

    var

        TodoEnable: Boolean;


    //Unsupported feature: Code Modification on "OnFindRecord".

    //trigger OnFindRecord()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RecordsFound := FIND(Which);
    EXIT(RecordsFound);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    RecordsFound := FIND(Which);
    TodoEnable := RecordsFound;
    EXIT(RecordsFound);
    */
    //end;


    //Unsupported feature: Code Insertion on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //begin
    /*
    TodoEnable := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "Caption(PROCEDURE 1)".

    //procedure Caption();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Cont.GET(GETFILTER("Contact Company No.")) THEN BEGIN
      Contact1.GET(GETFILTER("Contact Company No."));
      IF Contact1."No." <> Cont."No." THEN
        CaptionStr := COPYSTR(Cont."No." + ' ' + Cont.Name,1,MAXSTRLEN(CaptionStr));
    END;
    IF Cont.GET(GETFILTER("Contact No.")) THEN
      CaptionStr := COPYSTR(CaptionStr + ' ' + Cont."No." + ' ' + Cont.Name,1,MAXSTRLEN(CaptionStr));
    IF Salesperson.GET(GETFILTER("Salesperson Code")) THEN
      CaptionStr := COPYSTR(CaptionStr + ' ' + Salesperson.Code + ' ' + Salesperson.Name,1,MAXSTRLEN(CaptionStr));
    IF Team.GET(GETFILTER("Team Code")) THEN
      CaptionStr := COPYSTR(CaptionStr + ' ' + Team.Code + ' ' + Team.Name,1,MAXSTRLEN(CaptionStr));
    IF Campaign.GET(GETFILTER("Campaign No.")) THEN
    #13..18
      CaptionStr := Text001;

    EXIT(CaptionStr);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    IF SalesPurchPerson.GET(GETFILTER("Salesperson Code")) THEN
      CaptionStr := COPYSTR(CaptionStr + ' ' + SalesPurchPerson.Code + ' ' + SalesPurchPerson.Name,1,MAXSTRLEN(CaptionStr));
    #10..21
    */
    //end;
}
