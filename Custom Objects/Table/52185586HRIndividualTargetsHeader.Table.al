table 52185586 "HR Individual Targets Header"
{

    fields
    {
        field(1; "Appraisal No"; Code[20])
        {

            trigger OnValidate()
            begin
                /*IF "Appraisal no" <> xRec."Appraisal no" THEN BEGIN
                  HRSetup.GET;
                  NoSeriesMgt.TestManual(HRSetup."Appraisal Nos");
                  "No series" := '';
                END; */




                if "Appraisal No" <> xRec."Appraisal No" then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Appraisal Nos");
                    "No series" := '';
                end;

            end;
        }
        field(2; "Appraisal Period"; Code[20])
        {
            Editable = true;
            TableRelation = "HR Lookup Values".Code WHERE(Type = FILTER("Appraisal Period"));
        }
        field(3; "Appraisal Date"; Date)
        {
        }
        field(4; "Employee No"; Code[20])
        {
            Editable = false;
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                HREmp.Reset;
                if HREmp.Get("Employee No") then
                    "Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name"
                
            end;
        }
        field(5; "Financial Targeted Score"; Decimal)
        {
            CalcFormula = Sum("HR Individual Target Line"."Targeted Score" WHERE("Perspective Type" = FILTER("Financial Stewardship"),
                                                                                  "Appraisal No" = FIELD("Appraisal No")));
            FieldClass = FlowField;
        }
        field(7; "Achieved Financial  Score"; Decimal)
        {
            CalcFormula = Sum("HR Individual Target Line"."Achieved Score" WHERE("Perspective Type" = FILTER("Financial Stewardship"),
                                                                                  "Appraisal No" = FIELD("Appraisal No")));
            FieldClass = FlowField;
        }
        field(8; "Unachieved Targets"; Decimal)
        {
            CalcFormula = Sum("HR Individual Target Line"."Unachieved Targets" WHERE("Appraisal No" = FIELD("Appraisal No")));
            FieldClass = FlowField;
        }
        field(9; "Employee Name"; Text[200])
        {
            Editable = false;
        }
        field(10; "Training Targeted Score"; Decimal)
        {
            CalcFormula = Sum("HR Individual Target Line"."Targeted Score" WHERE("Perspective Type" = FILTER("Training and Development"),
                                                                                  "Appraisal No" = FIELD("Appraisal No")));
            FieldClass = FlowField;
        }
        field(11; "Service Delivery Target Score"; Decimal)
        {
            CalcFormula = Sum("HR Individual Target Line"."Targeted Score" WHERE("Perspective Type" = FILTER("Service Delivery"),
                                                                                  "Appraisal No" = FIELD("Appraisal No")));
            FieldClass = FlowField;
        }
        field(12; "Customer Target Score"; Decimal)
        {
            CalcFormula = Sum("HR Individual Target Line"."Targeted Score" WHERE("Perspective Type" = FILTER("Customer and Sales"),
                                                                                  "Appraisal No" = FIELD("Appraisal No")));
            FieldClass = FlowField;
        }
        field(13; "Customer Achieved  Score"; Decimal)
        {
            CalcFormula = Sum("HR Individual Target Line"."Achieved Score" WHERE("Perspective Type" = FILTER("Customer and Sales"),
                                                                                  "Appraisal No" = FIELD("Appraisal No")));
            FieldClass = FlowField;
        }
        field(14; "Service Delivery Achieved"; Decimal)
        {
            CalcFormula = Sum("HR Individual Target Line"."Achieved Score" WHERE("Perspective Type" = FILTER("Service Delivery"),
                                                                                  "Appraisal No" = FIELD("Appraisal No")));
            FieldClass = FlowField;
        }
        field(15; "Training Achieved  Score"; Decimal)
        {
            CalcFormula = Sum("HR Individual Target Line"."Achieved Score" WHERE("Perspective Type" = FILTER("Training and Development"),
                                                                                  "Appraisal No" = FIELD("Appraisal No")));
            FieldClass = FlowField;
        }
        field(16; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Discussed,Approved,Posted,Closed';
            OptionMembers = Open,"Pending Approval",Discussed,Approved,Posted,Closed;
        }
        field(17; "Responsibility Center"; Code[20])
        {
            Editable = true;
        }
        field(18; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(19; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(20; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(21; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(22; "Appraisal Type"; Option)
        {
            Editable = true;
            OptionCaption = 'Target Setting,Quarter 1,Appraisal Review,Quarter 3,End Year Appraisal';
            OptionMembers = "Target Setting","Quarter 1","Appraisal Review","Quarter 3","End Year Appraisal";
        }
        field(23; "No series"; Code[30])
        {
        }
        field(24; "Appraisal Year"; Integer)
        {
            Editable = true;
        }
        field(25; "Finance Rating"; Decimal)
        {
            CalcFormula = Sum("HR Individual Target Line"."Agreed Rating" WHERE("Appraisal No" = FIELD("Appraisal No"),
                                                                                 "Perspective Code" = CONST(1)));
            FieldClass = FlowField;
            MaxValue = 25;

            trigger OnValidate()
            begin
                // test:=HRIndividualTargetLine.COUNT;
                // MESSAGE('%1',test);
            end;
        }
        field(26; "Customer Rating"; Decimal)
        {
            CalcFormula = Sum("HR Individual Target Line"."Agreed Rating" WHERE("Appraisal No" = FIELD("Appraisal No"),
                                                                                 "Perspective Code" = CONST(2)));
            FieldClass = FlowField;
        }
        field(27; "Training Rating"; Decimal)
        {
            CalcFormula = Sum("HR Individual Target Line"."Agreed Rating" WHERE("Appraisal No" = FIELD("Appraisal No"),
                                                                                 "Perspective Code" = CONST(3)));
            FieldClass = FlowField;
        }
        field(28; "Service Rating"; Decimal)
        {
            CalcFormula = Sum("HR Individual Target Line"."Agreed Rating" WHERE("Appraisal No" = FIELD("Appraisal No"),
                                                                                 "Perspective Code" = CONST(4)));
            FieldClass = FlowField;
        }
        field(29; "Overall Rating"; Decimal)
        {
            CalcFormula = Sum("HR Individual Target Line"."Agreed Rating" WHERE("Appraisal No" = FIELD("Appraisal No")));
            FieldClass = FlowField;
        }
        field(30; "Finance Perc Score"; Decimal)
        {
        }
        field(31; "Customer Perc Score"; Decimal)
        {
        }
        field(32; "Training Perc Score"; Decimal)
        {
        }
        field(33; "Service Perc Score"; Decimal)
        {
        }
        field(34; "Overall Perc Score"; Decimal)
        {
        }
        field(36; Finance; Integer)
        {
            CalcFormula = Count("HR Individual Target Line" WHERE("Appraisal No" = FIELD("Appraisal No"),
                                                                   "Perspective Code" = CONST(1)));
            FieldClass = FlowField;
        }
        field(37; Customer; Integer)
        {
            CalcFormula = Count("HR Individual Target Line" WHERE("Appraisal No" = FIELD("Appraisal No"),
                                                                   "Perspective Code" = CONST(2)));
            FieldClass = FlowField;
        }
        field(38; Training; Integer)
        {
            CalcFormula = Count("HR Individual Target Line" WHERE("Appraisal No" = FIELD("Appraisal No"),
                                                                   "Perspective Code" = CONST(3)));
            FieldClass = FlowField;
        }
        field(39; Service; Integer)
        {
            CalcFormula = Count("HR Individual Target Line" WHERE("Appraisal No" = FIELD("Appraisal No"),
                                                                   "Perspective Code" = CONST(4)));
            FieldClass = FlowField;
        }
        field(40; "User ID"; Code[100])
        {
            Editable = false;
        }
        field(41; "Supervisor ID"; Code[50])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(42; "Supervisor Name"; Text[100])
        {
            Editable = false;
        }
        field(43; "Lock appraisal"; Boolean)
        {
            Editable = false;
        }
        field(44; "Total score"; Decimal)
        {
        }
        field(45; "Initiated By User ID"; Code[50])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(46; "Initiated By Employee No"; Code[20])
        {
            Editable = false;
            TableRelation = "HR Employees"."No.";
        }
        field(47; "Appraisee Submitted"; Boolean)
        {
            Editable = false;
        }
        field(48; "Appraisee Submission Date"; Date)
        {
            Editable = false;
        }
        field(49; "Has Disagreements"; Boolean)
        {
            CalcFormula = Exist("HR Appraisal Discussion Log" WHERE("Appraisal No" = FIELD("Appraisal No"),
                                                                      Resolved = CONST(false)));
            FieldClass = FlowField;
        }
        field(50; "Discussion Log Count"; Integer)
        {
            CalcFormula = Count("HR Appraisal Discussion Log" WHERE("Appraisal No" = FIELD("Appraisal No")));
            FieldClass = FlowField;
        }
        field(51; "Unresolved Discussions"; Integer)
        {
            CalcFormula = Count("HR Appraisal Discussion Log" WHERE("Appraisal No" = FIELD("Appraisal No"),
                                                                      Resolved = CONST(false)));
            FieldClass = FlowField;
        }
        field(52; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = 'Manual Entry,Imported from Department Targets,Copied from Previous Year';
            OptionMembers = "Manual Entry","Imported from Department Targets","Copied from Previous Year";
            Editable = false;
        }
        field(53; "Source Department Target No"; Code[20])
        {
            Caption = 'Source Department Target No';
            TableRelation = "HR Department Targets Header"."Target No";
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Appraisal No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        CurrentEmpNo: Code[50];
    begin
        if "Appraisal No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Appraisal Nos");
            "Appraisal No" := NoSeriesMgt.GetNextNo(HRSetup."Appraisal Nos");
            // NoSeriesMgt.InitSeries(HRSetup."Appraisal Nos", xRec."No series", 0D, "Appraisal No", "No series");
        end;
        /*
         //check if period is for capturing target setting or achievement then fill the necessary fields----
         HRSetup.RESET;
         HRSetup.GET;
        "Appraisal Type":=fnAppraisalType;
        "Appraisal Period":=fnAppraisalDate;
        */

        "Appraisal Date" := Today;

        // NEW: VALIDATE USER IS CREATING APPRAISAL FOR THEMSELVES ONLY
        CurrentEmpNo := CurrentEmployee();

        // IF EMPLOYEE NO IS BLANK, AUTO-POPULATE WITH CURRENT USER'S EMPLOYEE NO
        if "Employee No" = '' then
            "Employee No" := CurrentEmpNo;

        // VALIDATE EMPLOYEE NO MATCHES CURRENT USER - BLOCK IF MISMATCH
        if "Employee No" <> CurrentEmpNo then
            Error('ACCESS DENIED: You can only create appraisals for yourself. Current User Employee No: %1, Attempted Employee No: %2', CurrentEmpNo, "Employee No");

        // RECORD WHO INITIATED THE APPRAISAL
        "Initiated By User ID" := UserId;
        "Initiated By Employee No" := CurrentEmpNo;

        // "Employee No" :=/ CurrentEmployee;
        "User ID" := UserId;
        "Employee Name" := EmployeeNames;
        "Supervisor ID" := SupervisorCode;
        "Supervisor Name" := SupervisorName;

        //Status:=Status::Open;
        //"Appraisal Year":="Appraisal YR";

        //Get the set target for the year and load them----
        //IF "Appraisal Type" <> "Appraisal Type"::"Appraisal Review" THEN loadtheyearsTarget;

    end;

    trigger OnModify()
    begin
        //"Finance Perc Score":=("Finance Rating"*25)/(Finance2*5)
    end;

    var
        HRSetup: Record "HR Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        UserSetup: Record "User Setup";
        HREmp: Record "HR Employees";
        BaseCalendarChange: Record "Base Calendar Change";
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        // SMTP: Codeunit "SMTP Mail";
        HRAppraisalJournalLine: Record "HR Appraisal Journal Line";
        URL: Text[500];
        HREmailParameters: Record "HR E-Mail Parameters";
        HRPeriods: Record "HR Leave Periods";
        HRJournalBatch: Record "HR Leave Journal Batch";
        HRLeaveEntries: Record "HR Appraisal Ledger Entries";
        intEntryNo: Integer;
        "LineNo.": Integer;
        HRIndividualTargetLine: Record "HR Individual Target Line";
        AppraisalPeriod: Record "HR Appraisal Period";
        AppraisalPeriodDate: Date;
        "Appraisal YR": text[50];
        EmployeeNames: Text;
        test: Integer;
        i: Integer;
        HRIndividualTargetsHeader: Record "HR Individual Targets Header";
        HRIndividualTargetLine_2: Record "HR Individual Target Line";
        SupervisorCode: Code[20];
        SupervisorName: Text;

    // [Scope('OnPrem')]
    procedure CreateLedgerEntries()
    begin
        if (Status = Status::Approved) and ("Appraisal Type" = "Appraisal Type"::"Quarter 1") then Error('Appraisal has already been posted');


        HRSetup.Reset;
        if HRSetup.Find('-') then begin
            HRSetup.TestField(HRSetup."Appraisal Template");
            HRSetup.TestField(HRSetup."Appraisal Batch");
            HRSetup.TestField(HRSetup."Appraisal Posting Period[FROM]");
            HRSetup.TestField(HRSetup."Appraisal Posting Period[TO]");

            HRAppraisalJournalLine.Reset;
            HRAppraisalJournalLine.SetRange("Journal Template Name", HRSetup."Appraisal Template");
            HRAppraisalJournalLine.SetRange("Journal Batch Name", HRSetup."Appraisal Batch");
            HRAppraisalJournalLine.DeleteAll;

            HREmp.Reset;
            HREmp.Get("Employee No");

            "LineNo." := 10000;
            //Get the lines
            HRIndividualTargetLine.Reset;
            HRIndividualTargetLine.SetRange(HRIndividualTargetLine."Appraisal No", "Appraisal No");
            if HRIndividualTargetLine.Find('-') then begin
                repeat
                    //Populate Journal
                    "LineNo." := "LineNo." + 10000;
                    HRAppraisalJournalLine.Init;
                    HRAppraisalJournalLine."Journal Template Name" := HRSetup."Appraisal Template";
                    HRAppraisalJournalLine."Journal Batch Name" := HRSetup."Appraisal Batch";
                    HRAppraisalJournalLine."Line No." := "LineNo.";
                    HRAppraisalJournalLine."Appraisal Period" := Format(HRSetup."Appraisal Posting Period[FROM]") + ' '
                                                              + Format(HRSetup."Appraisal Posting Period[TO]");
                    HRAppraisalJournalLine."Appraisal No." := "Appraisal No";
                    HRAppraisalJournalLine."Document No." := "Appraisal No";
                    HRAppraisalJournalLine."Staff No." := "Employee No";
                    HRAppraisalJournalLine.Validate(HRAppraisalJournalLine."Staff No.");
                    HRAppraisalJournalLine."Posting Date" := Today;
                    HRAppraisalJournalLine."Appraisal Approval Date" := Today;
                    HRAppraisalJournalLine.Description := 'BSC';
                    //HRIndividualTargetLine.CALCFIELDS(HRIndividualTargetLine."Perspective Type");
                    HRAppraisalJournalLine."Appraisal Type" := HRIndividualTargetLine."Perspective Type";
                    HRAppraisalJournalLine."Appraisal Period Start Date" := HRSetup."Appraisal Posting Period[FROM]";
                    HRAppraisalJournalLine."Appraisal Period End Date" := HRSetup."Appraisal Posting Period[TO]";
                    HRAppraisalJournalLine.Score := HRIndividualTargetLine."Targeted Score";
                    HRAppraisalJournalLine."Self Rating" := HRIndividualTargetLine."Self Rating";
                    HRAppraisalJournalLine."Supervisor Rating" := HRIndividualTargetLine."Supervisor Rating";
                    HRAppraisalJournalLine."Agreed Rating" := HRIndividualTargetLine."Agreed Rating";
                    HRAppraisalJournalLine.Insert(true);
                until HRIndividualTargetLine.Next = 0;
            end;
            //Post Journal
            HRAppraisalJournalLine.Reset;
            HRAppraisalJournalLine.SetRange("Journal Template Name", HRSetup."Appraisal Template");
            HRAppraisalJournalLine.SetRange("Journal Batch Name", HRSetup."Appraisal Batch");
            if HRAppraisalJournalLine.Find('-') then begin
                CODEUNIT.Run(CODEUNIT::"HR Appraisal Jnl.-Post", HRAppraisalJournalLine);
            end;

            Status := Status::Posted;
            Modify;

        end;
    end;

    // [Scope('OnPrem')]
    procedure fnAppraisalDate() dtBSCdate: Date
    begin
    
        dtBSCdate:=0D;
        //"Appraisal YR":=0;
        AppraisalPeriod.RESET;
        AppraisalPeriod.SETRANGE(AppraisalPeriod.Closed,FALSE);
        IF AppraisalPeriod.FIND('-') THEN
        BEGIN
            dtBSCdate:=AppraisalPeriod."Appraisal Period" ;
            "Appraisal YR":=AppraisalPeriod."Appraisal Year";
        END
        ELSE ERROR('no open period is available please Contact the administrator');
        

    end;

    // [Scope('OnPrem')]
    procedure CurrentEmployee() EmployeeCD: Code[50]
    begin
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.Find('-') then begin
            EmployeeCD := HREmp."No.";
            EmployeeNames := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            SupervisorCode := HREmp."Supervisor Code";
            SupervisorName := HREmp."Supervisor Name";

        end else begin
            Error('The user id or supervisor id has not been setup in the HR offices')
        end;
    end;

    // [Scope('OnPrem')]
    procedure loadtheyearsTarget()
    begin
        i := 0;
        HRIndividualTargetLine.Reset;
        if HRIndividualTargetLine.Find('+') then
            i := HRIndividualTargetLine."Line No" + 1;


        HRIndividualTargetsHeader.Reset;
        HRIndividualTargetsHeader.SetRange(HRIndividualTargetsHeader."Appraisal Year", "Appraisal Year");
        HRIndividualTargetsHeader.SetRange(HRIndividualTargetsHeader."Employee No", "Employee No");
        HRIndividualTargetsHeader.SetRange(HRIndividualTargetsHeader."Appraisal Type", HRIndividualTargetsHeader."Appraisal Type"::"Quarter 1");
        if HRIndividualTargetsHeader.Find('-') then begin
            HRIndividualTargetLine.Reset;
            HRIndividualTargetLine.SetRange(HRIndividualTargetLine."Appraisal No", HRIndividualTargetsHeader."Appraisal No");
            if HRIndividualTargetLine.Find('-') then begin
                repeat
                    HRIndividualTargetLine_2.Init;
                    HRIndividualTargetLine_2."Line No" := i;
                    HRIndividualTargetLine_2."Appraisal No" := "Appraisal No";
                    HRIndividualTargetLine_2."Perspective Code" := HRIndividualTargetLine."Perspective Code";
                    HRIndividualTargetLine_2."Targeted Score" := HRIndividualTargetLine."Targeted Score";
                    HRIndividualTargetLine_2."Unachieved Targets" := HRIndividualTargetLine."Unachieved Targets";
                    HRIndividualTargetLine_2."Appraisee Comments" := HRIndividualTargetLine."Appraisee Comments";
                    HRIndividualTargetLine_2.Objective := HRIndividualTargetLine.Objective;
                    HRIndividualTargetLine_2."Start Date" := HRIndividualTargetLine."Start Date";
                    HRIndividualTargetLine_2."End Date" := HRIndividualTargetLine."End Date";
                    //HRIndividualTargetLine_2."Appraisal Period":="Appraisal Period";
                    HRIndividualTargetLine_2."Perspective Description" := HRIndividualTargetLine."Perspective Description";
                    HRIndividualTargetLine_2."Perspective Type" := HRIndividualTargetLine."Perspective Type";
                    HRIndividualTargetLine_2.Insert;
                    i := i + 1;
                until HRIndividualTargetLine.Next = 0
            end
        end
    end;

    // [Scope('OnPrem')]
    procedure fnAppraisalType() AppraisalType: Integer
    begin
        
        AppraisalPeriod.RESET;
        AppraisalPeriod.SETRANGE(AppraisalPeriod.Closed,FALSE);
        IF AppraisalPeriod.FIND('-') THEN
        BEGIN
            AppraisalType:=AppraisalPeriod."Appraisal Type";
        END ELSE
        BEGIN
            ERROR('NO Open Appraisal Period is available please Contact the administrator');
        END;
        

    end;

    procedure SubmitToSupervisor()
    begin
        TestField(Status, Status::Open);
        TestField("Appraisee Submitted", false);

        ValidateSelfRatingsCompleted();

        "Appraisee Submitted" := true;
        "Appraisee Submission Date" := Today;
        Status := Status::"Pending Approval";
        Modify;

        Message('Appraisal submitted to supervisor: %1', "Supervisor Name");
    end;

    procedure RecordDiscussionPoint(PointText: Text[250]; Category: Integer)
    var
        DiscussionLog: Record "HR Appraisal Discussion Log";
        LineNo: Integer;
    begin
        TestField(Status, Status::Discussed);

        DiscussionLog.Reset;
        if DiscussionLog.FindLast then
            LineNo := DiscussionLog."Line No" + 1
        else
            LineNo := 1;

        DiscussionLog.Init;
        DiscussionLog."Line No" := LineNo;
        DiscussionLog."Appraisal No" := "Appraisal No";
        DiscussionLog."Discussion Date" := Today;
        DiscussionLog."Discussion Time" := Time;
        DiscussionLog."Discussion Point" := PointText;
        DiscussionLog."Point Category" := Category;
        DiscussionLog."Raised By User ID" := UserId;

        if UserId = "User ID" then
            DiscussionLog."Raised By" := DiscussionLog."Raised By"::Appraisee
        else if UserId = "Supervisor ID" then
            DiscussionLog."Raised By" := DiscussionLog."Raised By"::Appraiser;

        DiscussionLog.Insert(true);
    end;

    procedure ValidateSelfRatingsCompleted()
    var
        TargetLine: Record "HR Individual Target Line";
        MissingCount: Integer;
    begin
        MissingCount := 0;
        TargetLine.Reset;
        TargetLine.SetRange("Appraisal No", "Appraisal No");
        if TargetLine.FindSet then begin
            repeat
                if TargetLine."Self Rating" = 0 then
                    MissingCount += 1;
            until TargetLine.Next = 0;
        end;

        if MissingCount > 0 then
            Error('Cannot submit appraisal. %1 target line(s) are missing self-ratings. Please complete all self-ratings before submitting.', MissingCount);
    end;

    procedure CheckUnresolvedDiscussions(): Boolean
    var
        DiscussionLog: Record "HR Appraisal Discussion Log";
    begin
        DiscussionLog.Reset;
        DiscussionLog.SetRange("Appraisal No", "Appraisal No");
        DiscussionLog.SetRange(Resolved, false);
        exit(not DiscussionLog.IsEmpty);
    end;

    procedure ImportFromAssignedTargets(DepartmentTargetNo: Code[20])
    var
        Assignment: Record "HR Employee Target Assignment";
        TargetLine: Record "HR Individual Target Line";
        LineNo: Integer;
        ImportCount: Integer;
    begin
        TestField(Status, Status::Open);
        TestField("Appraisal Type", "Appraisal Type"::"Target Setting");

        TargetLine.Reset;
        TargetLine.SetRange("Appraisal No", "Appraisal No");
        if TargetLine.FindLast then
            LineNo := TargetLine."Line No"
        else
            LineNo := 0;

        Assignment.Reset;
        Assignment.SetRange("Department Target No", DepartmentTargetNo);
        Assignment.SetRange("Employee No", "Employee No");
        Assignment.SetFilter(Status, '%1|%2', Assignment.Status::Assigned, Assignment.Status::Accepted);
        if Assignment.FindSet then begin
            ImportCount := 0;
            repeat
                LineNo += 10000;
                TargetLine.Init;
                TargetLine."Line No" := LineNo;
                TargetLine."Appraisal No" := "Appraisal No";
                TargetLine."Perspective Code" := Assignment."Perspective Code";
                TargetLine.Validate("Perspective Code");
                TargetLine.Objective := Assignment.Objective;
                TargetLine.Strategy := Assignment.Strategy;
                TargetLine.Measures := Assignment.Measures;
                TargetLine.Baseline := Assignment.Baseline;
                TargetLine."Targeted Score" := Assignment."Targeted Score";
                TargetLine.Validate("Targeted Score");
                TargetLine."Appraisal Period" := "Appraisal Period";
                TargetLine."Company Target" := Assignment."Department Target No";
                TargetLine.Insert(true);

                Assignment.Status := Assignment.Status::Incorporated;
                Assignment."Incorporated Into Appraisal No" := "Appraisal No";
                Assignment."Incorporated Date" := Today;
                Assignment.Modify;
                ImportCount += 1;
            until Assignment.Next = 0;

            "Source Type" := "Source Type"::"Imported from Department Targets";
            "Source Department Target No" := DepartmentTargetNo;
            Modify;

            Message('%1 target(s) imported successfully from Department Target %2.', ImportCount, DepartmentTargetNo);
        end else begin
            Error('No assigned targets found for you from Department Target %1. Please contact your HOD.', DepartmentTargetNo);
        end;
    end;
}

