table 52185532 "HR Leave Application"
{
    DrillDownPageID = "HR Leave Applications List1";
    LookupPageID = "HR Leave Applications List1";

    fields
    {
        field(1; "Application Code"; Code[20])
        {

            trigger OnValidate()
            begin
                //TEST IF MANUAL NOs ARE ALLOWED
                if "Application Code" <> xRec."Application Code" then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Leave Application Nos.");
                    "No series" := '';
                end;
            end;
        }
        field(3; "Leave Type"; Code[30])
        {
            TableRelation = "HR Leave Types".Code;
            //WHERE(Active = FILTER(true));

            trigger OnValidate()
            begin
                HRLeaveTypes.Reset;
                HRLeaveTypes.SetRange(Active, true);
                HRLeaveTypes.SetRange(HRLeaveTypes.Code, "Leave Type");
                if HRLeaveTypes.Find('-') then begin
                    "Is for annual leave" := HRLeaveTypes."Is Annual Leave";
                    HREmp.Reset;
                    HREmp.SetRange(HREmp."No.", "Applicant Staff No.");
                    HREmp.SetRange(HREmp.Gender, HRLeaveTypes.Gender);
                    if HREmp.Find('-') then
                        exit
                    else
                        if HRLeaveTypes.Gender <> HRLeaveTypes.Gender::Both then
                            Error('This leave type is restricted to the ' + Format(HRLeaveTypes.Gender) + ' gender');
                end;
                "Days Applied" := 0;
            end;
        }
        field(4; "Days Applied"; Decimal)
        {
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            var
                Max2: Integer;
                Days: Decimal;
                hrleaveCalendar: record "HR Leave Calendar";
            begin
                TestField("Leave Type");
                "Start Date" := 0D;
                "Return Date" := 0D;


                if "Days Applied" >= 15 then "Request Leave Allowance" := true;
                if "Days Applied" < 15 then "Request Leave Allowance" := false;


                if "Days Applied" < 1 then Error('Days applied cannot be less than 1');
                IF HRLeaveTypes.get("Leave Type") THEN BEGIN
                    IF HRLeaveTypes.Gender = HRLeaveTypes.Gender::Female then
                        IF "Days Applied" < HRLeaveTypes.Days THEN Error('Days Applied Cannot be less than' + ' ' + Format(HRLeaveTypes.Days));
                END;
            end;
        }
        field(5; "Start Date"; Date)
        {
            trigger OnValidate()
            begin
                testfield(rec."Days Applied");
                //IF "Start Date" < TODAY THEN ERROR('You cannot postdate your application. Please contact the HR/IT Department');

                if "Start Date" = 0D then begin
                    "Return Date" := 0D;
                    "End Date" := 0D;
                end else begin
                    if DetermineIfIsNonWorking("Start Date") = true then begin
                        Error('Start date must be a working day');
                    end;
                end;
                if ("Days Applied" <> 0) and ("Start Date" <> 0D) then begin
                    "Return Date" := DetermineLeaveReturnDate("Start Date", "Days Applied");
                    "End Date" := DeterminethisLeaveEndDate("Return Date");

                    // if Date2DMY(Today, 3) < Date2DMY("Return Date", 3) then
                    //     Error('Leave appllication must be done within the current year %1', Format(Date2DMY(Today, 3)));
                    // Modify;
                    if Date2DMY("End Date", 3) <> Date2DMY(Today, 3) then
                        Error('You cannot apply leave for a different year other than %1', Format(Date2DMY(Today, 3)));
                end;
                //check for overlap
                HRLeaveApp.Reset;
                HRLeaveApp.SetRange(HRLeaveApp."Applicant Staff No.", "Applicant Staff No.");
                HRLeaveApp.SetRange(HRLeaveApp.Status, HRLeaveApp.Status::Approved);
                if HRLeaveApp.FindLast() then begin
                    if (rec."Start Date" >= HRLeaveApp."Start Date") and (rec."Start Date" <= HRLeaveApp."End Date") then
                        ERROR('You already have an active leave application!');
                end;
            end;
        }
        field(6; "Return Date"; Date)
        {
            Caption = 'Return Date';
            Editable = true;
        }
        field(7; "Application Date"; Date)
        {
        }
        field(12; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved,Rejected,Cancelled';
            OptionMembers = New,"Pending Approval",Approved,Rejected,Cancelled;

            trigger OnValidate()
            var
                HrLeaveTypes: record "HR Leave Types";
            begin
                if Status = Status::Approved then begin
                    // if Date2DMY(Today, 3) < Date2DMY("Return Date", 3) then
                    //     Error('Leave appllication must be done within the current year %1', Format(Date2DMY(Today, 3)));

                    intEntryNo := 0;
                    HRLeaveCal.Reset;
                    HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
                    if not HRLeaveCal.Find('-') then Error('Leave Calendar not setup');


                    HRLeaveEntries.Reset;
                    //HRLeaveEntries.SetRange(HRLeaveEntries."Entry No.");
                    if HRLeaveEntries.Find('+') then intEntryNo := HRLeaveEntries."Entry No.";

                    intEntryNo := intEntryNo + 1;
                    HRLeaveEntries.Init;
                    HRLeaveEntries."Entry No." := intEntryNo;
                    HRLeaveEntries."Staff No." := "Applicant Staff No.";
                    HRLeaveEntries."Staff Name" := Names;
                    HRLeaveEntries."Leave Calendar Code" := HRLeaveCal."Calendar Code";
                    HRLeaveEntries."Posting Date" := Today;
                    HRLeaveEntries."Leave Entry Type" := HRLeaveEntries."Leave Entry Type"::Negative;
                    HRLeaveEntries."Leave Approval Date" := "Application Date";
                    HRLeaveEntries."Document No." := "Application Code";
                    HRLeaveEntries."External Document No." := "Applicant Staff No.";
                    HRLeaveEntries."Job ID" := "Job Tittle";
                    HRLeaveEntries."No. of days" := -"Days Applied";
                    HRLeaveEntries."Leave Start Date" := "Start Date";
                    HRLeaveEntries."Leave Posting Description" := 'Leave';
                    HRLeaveEntries."Leave End Date" := "Return Date";
                    HRLeaveEntries."Leave Return Date" := "Return Date";
                    HRLeaveEntries."User ID" := "Applicant User ID";
                    HRLeaveEntries."Leave Type" := "Leave Type";
                    if HrLeaveTypes.get(rec."Leave Type") then
                        if HrLeaveTypes."Is Annual Leave" = true then
                            HRLeaveEntries."Is For Annual Leave" := true;
                    HRLeaveEntries."Leave Type Enum" := HrLeaveTypes."Leave type Enum";
                    HRLeaveEntries.Insert(true);
                    Posted := true;
                    "Posted By" := UserId;
                    "Date Posted" := Today;
                    "Time Posted" := Time;
                    Rec.Modify(true);

                end;


                if (Rec.Status = Status::Rejected) then
                    GlobalFunctions.CommentsManagement(Rec."Application Code");

            end;

        }
        field(15; "Applicant Comments"; Text[250])
        {
        }
        field(17; "No series"; Code[30])
        {
        }
        field(18; Gender; Option)
        {
            Editable = false;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(28; Selected; Boolean)
        {
        }
        field(31; "Current Balance"; Decimal)
        {
            FieldClass = Normal;
        }
        field(32; Posted; Boolean)
        {

        }
        field(33; "Posted By"; Text[250])
        {
        }
        field(34; "Date Posted"; Date)
        {
        }
        field(35; "Time Posted"; Time)
        {
        }
        field(36; Reimbursed; Boolean)
        {
        }
        field(37; "Days Reimbursed"; Decimal)
        {
        }
        field(3900; "End Date"; Date)
        {
            Editable = true;
        }
        field(3901; "Total Taken"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }

        field(3921; "E-mail Address"; Text[60])
        {
            Editable = false;
            ExtendedDatatype = EMail;
            //     trigger OnValidate()
            //         var
            //             MailManagement: Codeunit "Mail Management";


            //    // MailManagement.CheckValidEmailAddresses("E-mail Address");
            //     GlobalFunctions.CheckEmailHasADot("E-mail Address");

        }
        field(3924; "Entry No"; Integer)
        {
        }
        field(3929; "Start Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(3936; "Cell Phone Number"; Code[15])
        {

            NotBlank = true;
            trigger OnValidate()
            var
                Characters: Text;
                NewMob: code[20];
            begin
                // Characters := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';

                // if not ValidateShouldNotHaves("Cell Phone Number", Characters) then Error('Phone number has invalid characters');


                // NewMob := '';
                // NewMob := CopyStr("Cell Phone Number", 1, 4);
                // if (CopyStr("Cell Phone Number", 1, 4)) <> '+254' then
                //     Error('The Mobile phone No. should take the format of ' + '+254');
                // if StrLen("Cell Phone Number") <> 13 then
                //     Error('Phone No. should be equal to 13 characters');
            end;
        }
        field(3937; "Request Leave Allowance"; Boolean)
        {
        }
        field(3939; Picture; BLOB)
        {
        }
        field(3940; Names; Text[100])
        {
        }
        field(3942; "Leave Allowance Entittlement"; Boolean)
        {
        }
        field(3943; "Leave Allowance Amount"; Decimal)
        {
        }
        field(3945; "Details of Examination"; Text[200])
        {
        }
        field(3947; "Date of Exam"; Date)
        {
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                if rec."Date of Exam" < "Start Date" then error('Date of Exam Must be greater than Today');

            end;
        }
        field(3949; Reliever; Code[50])
        {
            TableRelation = "HR Employees"."No." WHERE(Status = CONST(Active), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"));
            //"Global Dimension 2 Code" = FIELD("Global Dimension 2 Code"));

            trigger OnValidate()
            begin
                //  if Reliever = "Applicant Staff No." then
                //      Error('Employee cannot relieve him/herself');

                if HREmp.Get(Reliever) then begin
                    "Reliever Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                end else begin
                    "Reliever Name" := '';
                end;
            end;
        }
        field(3950; "Reliever Name"; Text[100])
        {
        }
        field(3952; Description; Text[30])
        {
        }
        field(3955; "Supervisor Email"; Text[50])
        {
        }
        field(3956; "Number of Previous Attempts"; Text[200])
        {
        }
        field(3958; "Job Tittle"; Text[50])
        {
        }
        field(3959; "Applicant User ID"; Code[50])
        {
        }
        field(3961; "Applicant Staff No."; Code[20])
        {
            TableRelation = "HR Employees"."No.";
            trigger OnValidate()
            var
                HrLeave: record "HR Leave Ledger Entries";
                HrCalendar: record "HR Leave Calendar";


            begin
                HREmp.Reset;
                if HREmp.Get(Rec."Applicant Staff No.") then begin

                    HRLeaveCal.Reset;
                    HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
                    if not HRLeaveCal.Find('-') then Error('Leave Calendar has not been setup');

                    //Filter by Leave Period from HR Setup
                    HRLeave.Reset;
                    HRLeave.SetRange(HRLeave."Staff No.", Rec."Applicant Staff No.");

                    HRLeave.SetRange(HRLeave."Leave Calendar Code", HRLeaveCal."Calendar Code");

                    if HRLeave.Find('-') then begin


                        Days := Today - HRLeaveCal."Start Date";
                        DaysWorked := Days * (HrLeave."No. of days" / 365);
                        Rec."Days To Apply" := DaysWorked + HrEmp."Reimbursed Leave Days";
                    end;
                end;
            end;

        }
        field(3962; "Applicant Supervisor"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(3969; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility CenterBR".Code WHERE(Code = FILTER(<> ''));
        }
        field(3970; "Approved days"; Integer)
        {

            trigger OnValidate()
            begin
                if "Approved days" > "Days Applied" then
                    Error(TEXT001);
            end;
        }
        field(3971; Attachments; Integer)
        {
            Editable = false;
        }
        field(3972; Emergency; Boolean)
        {
            Description = 'This is used to ensure one can apply annual leave which is emergency';
        }
        field(3973; "Approver Comments"; Text[200])
        {
        }
        field(3974; "Employee Name"; Text[100])
        {
        }
        field(3975; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                "Global Dimension 1 Name" := '';
                DimValue.Reset;
                DimValue.SetRange(DimValue.Code, "Global Dimension 1 Code");
                if DimValue.Find('-') then begin
                    "Global Dimension 1 Name" := DimValue.Name;
                end;
            end;
        }
        field(3976; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                "Global Dimension 2 Name" := '';
                DimValue.Reset;
                DimValue.SetRange(DimValue.Code, "Global Dimension 2 Code");
                if DimValue.Find('-') then begin
                    "Global Dimension 2 Name" := DimValue.Name;
                end;
            end;
        }
        field(3977; "Global Dimension 1 Name"; Text[60])
        {
            Editable = false;
        }
        field(3978; "Global Dimension 2 Name"; Text[60])
        {
            Editable = false;
        }
        field(3979; Address; Code[50])
        {
        }
        field(3980; "Alternative CellPhone No."; Integer)
        {
        }
        field(3981; "Sent Online"; Boolean)
        {
        }
        field(3982; "Recall Date"; Date)
        {
        }
        field(3983; "New End Date"; Date)
        {
        }
        field(3984; "Salary Grade"; code[40])
        {
            TableRelation = "Salary Grades"."Salary Grade";
        }
        field(3985; "Days To Apply"; Decimal)
        {


        }
        field(3986; "Days Approved"; Decimal)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Rec."Days Applied" := "Days Approved";
                Validate(rec."Days Applied");
            end;


        }

        field(4000; "Source of Application"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "BC","Staff Portal";
        }
        field(4001; "Is for annual leave"; boolean)
        {

        }
        field(4002; "Allocated Leave Days"; Decimal)
        {
            Caption = 'Allocated Annual Leave Days';
        }
        field(4003; "Total Leave Days"; Decimal)
        {
            Caption = 'Total Annual Leave Days';
        }
        field(4004; "Total Leave Taken"; Decimal)
        {
            Caption = 'Total Annual Leave Taken';
        }
        field(4005; "Leave Days Balance"; Decimal)
        {
            Caption = 'Annual Leave Days Balance';
        }
    }

    keys
    {
        key(Key1; "Application Code")
        {
            Clustered = true;
        }
        key(Key2; "Start Date", "End Date", "Leave Type")
        {
            SumIndexFields = "Days Approved";
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Application Code", Names)
        {
        }
    }

    trigger OnDelete()
    begin
        //ERROR('Please edit document instead of deleting');
    end;

    trigger OnInsert()
    var
        LeaveApplication: Record "HR Leave Application";
    begin
        //No. Series
        if "Application Code" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Leave Application Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Leave Application Nos.", xRec."No series", 0D, "Application Code", "No series");
        end;

        if "Source of Application" = "Source of Application"::BC then begin
            // if UserId <> 'KENPIPE' then begin
            HREmp.Reset;
            HREmp.SetRange(HREmp."User ID", UserId);
            if HREmp.Find('-') then begin
                HREmp.TestField(HREmp."Date Of Join");

                Calendar.Reset;
                Calendar.SetRange("Period Type", Calendar."Period Type"::Month);
                Calendar.SetRange("Period Start", HREmp."Date Of Join", Today);
                empMonths := Calendar.Count;


                //Populate fields
                UserSetUp.Get(UserId);
                "Applicant Staff No." := HREmp."No.";
                Names := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                Gender := HREmp.Gender;
                "Cell Phone Number" := HREmp."Cellular Phone Number";
                "Application Date" := Today;
                "Applicant User ID" := UserId;
                "Job Tittle" := HREmp."Job Title";
                "E-mail Address" := HREmp."E-Mail";
                HREmp.CalcFields(HREmp.Picture);
                "Global Dimension 1 Code" := HREmp."Global Dimension 1 Code";
                "Global Dimension 2 Code" := HREmp."Global Dimension 2 Code";
                "Cell Phone Number" := HREmp."Cell Phone Number";
                "Responsibility Center" := UserSetUp."Responsibility Centre";

                Picture := HREmp.Picture;
                //"Responsibility Center":=HREmp."Responsibility Center";
                //Approver details
                // GetApplicantSupervisor(UserId);

            end else begin
                ERROR('UserID' + ' ' + '[' + USERID + ']' + ' has not been assigned to any employee. Please consult the HR officer for assistance')
            end;
            // end;




            xRec.Reset;
            xRec.SetRange(xRec."Applicant User ID", UserId);
            xRec.SetRange(xRec.Status, xRec.Status::"Pending Approval");
            if xRec.Find('-') then begin
                ERROR('You your leave application no' + ' ' + xRec."Application Code" + 'is still  pending Approval. Kindy Contact the HR department to have it approved first');
                REPEAT
                    IF "Start Date" < HRLeaveApp."Return Date" THEN
                        ERROR('You already have an active leave application!');
                UNTIL HRLeaveApp.NEXT = 0;
            END;
        end;

        if "Source of Application" = "Source of Application"::"Staff Portal" then begin
            HREmp.Reset;
            HREmp.SetRange("No.", Rec."Applicant Staff No.");
            if HREmp.Find('-') then begin
                HREmp.TestField(HREmp."Date Of Join");

                Calendar.Reset;
                Calendar.SetRange("Period Type", Calendar."Period Type"::Month);
                Calendar.SetRange("Period Start", HREmp."Date Of Join", Today);
                empMonths := Calendar.Count;


                //Populate fields
                // UserSetUp.Get(HREmp."User ID");
                "Applicant Staff No." := HREmp."No.";
                Names := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                Gender := HREmp.Gender;
                "Application Date" := Today;
                "Applicant User ID" := HREmp."User ID";
                "Job Tittle" := HREmp."Job Title";
                "E-mail Address" := HREmp."E-Mail";
                HREmp.CalcFields(HREmp.Picture);
                "Global Dimension 1 Code" := HREmp."Global Dimension 1 Code";
                "Global Dimension 2 Code" := HREmp."Global Dimension 2 Code";
                "Cell Phone Number" := HREmp."Cell Phone Number";
                // "Responsibility Center" := UserSetUp."Responsibility Centre";
                "Responsibility Center" := HREmp."Global Dimension 2 Code";

                Picture := HREmp.Picture;
                //"Responsibility Center":=HREmp."Responsibility Center";
                //Approver details
                // GetApplicantSupervisor(UserId);

            end;

            LeaveApplication.Reset;
            LeaveApplication.SetRange(LeaveApplication."Applicant Staff No.", HREmp."No.");
            LeaveApplication.SetFilter(LeaveApplication."Application Code", '<>%1', Rec."Application Code");
            LeaveApplication.SetFilter(LeaveApplication.Status, '=%1|%2', LeaveApplication.Status::"Pending Approval", LeaveApplication.Status::New);
            if LeaveApplication.Find('-') then begin
                ERROR('Your leave application no' + ' ' + LeaveApplication."Application Code" + ' is still  pending Approval. Kindy Contact the HR department to have it approved first');
                REPEAT
                    IF "Start Date" < HRLeaveApp."Return Date" THEN
                        ERROR('You already have an active leave application!');
                UNTIL HRLeaveApp.NEXT = 0;
            END;
        end;
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HREmp: Record "HR Employees";
        varDaysApplied: Integer;
        HRLeaveTypes: Record "HR Leave Types";
        BaseCalendarChange: Record "Base Calendar Change";
        ReturnDateLoop: Boolean;
        mSubject: Text[250];
        ApplicantsEmail: Text[30];
        // SMTP: Codeunit "SMTP Mail";
        HRJournalLine: Record "HR Leave Journal Line";
        "LineNo.": Integer;
        ApprovalComments: Record "Approval Comment Line";
        URL: Text[500];
        sDate: Record Date;
        ApprovedDays: boolean;
        HRLeaveCal: Record "HR Leave Calendar";
        Customized: Record "HR Leave Calendar Lines";
        HREmailParameters: Record "HR E-Mail Parameters";
        HRJournalBatch: Record "HR Leave Journal Batch";
        TEXT001: Label 'Days Approved cannot be more than applied days';
        HRLeaveEntries: Record "HR Leave Ledger Entries";
        intEntryNo: Integer;
        Calendar: Record Date;
        empMonths: Integer;
        HRLeaveApp: Record "HR Leave Application";
        mWeekDay: Integer;
        empGender: Option Female;
        Days: Integer;
        DaysWorked: Decimal;
        mMinDays: Integer;
        Text002: Label 'You cannot apply for leave until your are over [%1] months old in the company';
        Text003: Label 'UserID [%1] does not exist in [%2]';
        DimValue: Record "Dimension Value";
        LeaveAllowances: Record "Leave Allowances";
        prVitalSetup: Record "PR Vital Setup Info";
        PRSalCard: Record "PR Salary Card";
        UserSetUp: Record "User Setup";
        HRLeavePeriods: Record "HR Leave Periods";
        Characters: code[100];
        GlobalFunctions: Codeunit "Global Functions";

    // [Scope('OnPrem')]
    procedure DetermineLeaveReturnDate(var fBeginDate: Date; var fDays: Decimal) fReturnDate: Date
    begin
        varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        repeat
            if DetermineIfIncludesNonWorking("Leave Type") = false then begin
                fReturnDate := CalcDate('1D', fReturnDate);
                if DetermineIfIsNonWorking(fReturnDate) then
                    varDaysApplied := varDaysApplied + 1
                else
                    varDaysApplied := varDaysApplied;
                varDaysApplied := varDaysApplied - 1
            end
            else begin
                fReturnDate := CalcDate('1D', fReturnDate);
                varDaysApplied := varDaysApplied - 1;
            end;
        until varDaysApplied = 0;
        exit(fReturnDate);
    end;

    // [Scope('OnPrem')]
    procedure DetermineIfIncludesNonWorking(var fLeaveCode: Code[10]): Boolean
    begin
        if HRLeaveTypes.Get(fLeaveCode) then begin
            if HRLeaveTypes."Inclusive of Non Working Days" = true then
                exit(true);
        end;
    end;

    // [Scope('OnPrem')]
    procedure DetermineIfIsNonWorking(var bcDate: Date) Isnonworking: Boolean
    var
        LeaveCalendar: record "HR Leave Calendar";
    begin
        LeaveCalendar.reset();
        LeaveCalendar.SetRange("Current Leave Calendar", true);
        If LeaveCalendar.FindFirst then begin
            HRLeavePeriods.Reset;
            //HRLeavePeriods.SetRange(Closed, false);
            HRLeavePeriods.setrange("Period Code", LeaveCalendar."Calendar Code");
            if HRLeavePeriods.Find('-') then begin
                Customized.Reset;
                Customized.SetRange(Customized.Date, bcDate);
                Customized.SetRange(Code, HRLeavePeriods."Period Code");
                if Customized.Find('-') then begin
                    if Customized."Non Working" = true then
                        exit(true)
                    else
                        exit(false);
                end;
            end else
                Error('No Period Available for the current Calendar');
        End
        else
            error('No active Calendar');


        /*
        Customized.RESET;
        Customized.SETRANGE(Customized.Date,bcDate);
        IF Customized.FIND('-') THEN BEGIN
            IF Customized."Non Working" = TRUE THEN
            EXIT(TRUE)
            ELSE
            EXIT(FALSE);
        END;
        */

    end;

    // [Scope('OnPrem')]
    procedure DeterminethisLeaveEndDate(var fDate: Date) fEndDate: Date
    begin
        ReturnDateLoop := true;
        fEndDate := fDate;
        if fEndDate <> 0D then begin
            fEndDate := CalcDate('-1D', fEndDate);
            while (ReturnDateLoop) do begin
                if DetermineIfIsNonWorking(fEndDate) then
                    fEndDate := CalcDate('-1D', fEndDate)
                else
                    ReturnDateLoop := false;
            end
        end;
        exit(fEndDate);
    end;

    // [Scope('OnPrem')]
    procedure CreateLeaveLedgerEntries()
    begin
        //GET OPEN LEAVE PERIOD
        HRLeaveCal.Reset;
        HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
        HRLeaveCal.Find('-');

        HRJournalBatch.Reset;
        HRSetup.Get;
        HRSetup.TestField(HRSetup."Default Leave Posting Template");
        HRSetup.TestField(HRSetup."Negative Leave Posting Batch");

        HRJournalBatch.Get(HRSetup."Default Leave Posting Template", HRSetup."Negative Leave Posting Batch");

        //POPULATE JOURNAL LINES
        HRJournalLine.Reset;
        HRJournalLine.SetRange(HRJournalLine."Journal Template Name", HRSetup."Default Leave Posting Template");
        HRJournalLine.SetRange(HRJournalLine."Journal Batch Name", HRSetup."Negative Leave Posting Batch");
        if not HRJournalLine.Find('-') then
            HRJournalLine."Line No." := 1000
        else
            HRJournalLine.DeleteAll;
        HRJournalLine."Line No." := HRJournalLine."Line No." + 1000;

        "LineNo." := HRJournalLine."Line No.";

        HRJournalLine.Init;
        HRJournalLine."Journal Template Name" := HRSetup."Default Leave Posting Template";
        HRJournalLine."Journal Batch Name" := HRSetup."Negative Leave Posting Batch";
        HRJournalLine."Line No." := "LineNo.";
        HRJournalLine."Leave Calendar Code" := HRLeaveCal."Calendar Code";
        HRJournalLine."Document No." := "Application Code";
        HRJournalLine."Staff No." := "Applicant Staff No.";
        HRJournalLine.Validate(HRJournalLine."Staff No.");
        HRJournalLine."Posting Date" := Today;
        HRJournalLine."Leave Entry Type" := HRJournalLine."Leave Entry Type"::Negative;
        HRJournalLine."Leave Approval Date" := Today;
        HRJournalLine.Description := 'Leave Taken [' + "Application Code" + ']';
        HRJournalLine."Leave Type" := "Leave Type";
        HRJournalLine."Leave Period Start Date" := HRLeaveCal."Start Date";
        HRJournalLine."Leave Period End Date" := HRLeaveCal."End Date";
        HRJournalLine."No. of Days" := -"Days Approved";  //"Days Applied";

        HRJournalLine.Insert(true);

        //Post Journal
        HRJournalLine.Reset;
        HRJournalLine.SetRange("Journal Template Name", HRSetup."Default Leave Posting Template");
        HRJournalLine.SetRange("Journal Batch Name", HRSetup."Negative Leave Posting Batch");
        if HRJournalLine.Find('-') then begin
            CODEUNIT.Run(CODEUNIT::"HR Leave Jnl.-Post", HRJournalLine);
            //Notify Leave Applicant

            // NotifyApplicant;
            // NotifyReliever;

            // if ("Days Applied" >= 5) and ("Days Applied" < 15) then
            //     NotifyICT;

            // if "Days Applied" >= 15 then begin
            //     NotifyICT;
            //     NotifyHR;
            // end;



        end;
        //Mark document as posted




        //Insert into Leave allowance table
        if "Request Leave Allowance" = true then begin
            prVitalSetup.Reset;
            prVitalSetup.Get;
            //Mandatory fields
            // prVitalSetup.TESTFIELD(prVitalSetup."Leave Allowance Percentage");
            // prVitalSetup.TESTFIELD(prVitalSetup."Leave Allowance Based On");
            // prVitalSetup.TESTFIELD(prVitalSetup."Max. Leave Allowance");

            if prVitalSetup."Leave Allowance Based On" = prVitalSetup."Leave Allowance Based On"::"Basic Pay" then          //Based on BPAY
            begin
                //Get Basic Pay
                PRSalCard.Reset;
                if not PRSalCard.Find('-') then begin
                    Error('Enter BPAY for Staff');
                end;
            end;

            //Insert entry

            LeaveAllowances.Init;
            LeaveAllowances."Application No." := "Application Code";
            LeaveAllowances."Employee No." := "Applicant Staff No.";
            LeaveAllowances."Employee Name" := Names;
            LeaveAllowances."Start Date" := "Start Date";
            LeaveAllowances."End Date" := "End Date";
            LeaveAllowances."Date Posted" := Today;
            LeaveAllowances.Year := Date2DMY(LeaveAllowances."Date Posted", 3);
            LeaveAllowances.Amount := prVitalSetup."Leave Allowance Percentage" * PRSalCard."Basic Pay";
            //Not Exceed 50000
            if LeaveAllowances.Amount > prVitalSetup."Max. Leave Allowance" then LeaveAllowances.Amount := prVitalSetup."Max. Leave Allowance";

            LeaveAllowances.Insert
        end;
    end;

    [Scope('OnPrem')]
    procedure NotifyApplicant()
    begin
        /*//NOTIFY APPLICANT DERRICK
        HREmp.GET("Applicant Staff No.");
        HREmp.TESTFIELD(HREmp."Company E-Mail");
        
        HREmailParameters.RESET;
        HREmailParameters.GET(HREmailParameters."Associate With"::"Leave Notifications");
        SMTP.CreateMessage(HREmailParameters."Sender Name",HREmailParameters."Sender Address",HREmp."Company E-Mail",
        HREmailParameters.Subject,'Dear'+' '+ HREmp."First Name" +' '+
        HREmailParameters.Body+' '+"Application Code"+' '+'for'+' '+FORMAT("Days Applied")+' '+'Days starting on'+' '+FORMAT("Start Date")+' '+'and ending on'+' '+FORMAT("End Date")+'.'+ HREmailParameters."Body 2",TRUE);
        SMTP.Send();
        MESSAGE('Leave applicant has been notified successfully');
        */


        HREmp.Get("Applicant Staff No.");
        HREmp.TestField(HREmp."Company E-Mail");
        // SMTP.CreateMessage(
        //                     'HARAMBEE SACCO HRMS',
        //                     'no-reply@harambeesacco.com',
        //                     HREmp."Company E-Mail",
        //                     'Leave Approval Notification',
        //                     '<br>''Dear' + ' ' + HREmp."First Name" +
        //                     '<br>' + 'Your leave application no.' + "Application Code" + '  ' + 'has been fully approved:<br><br>' +
        //                     '<br>Employee No. ' + "Applicant Staff No." + ' - ' + UpperCase(Names) +
        //                     '<br>Application No - ' + "Application Code" +
        //                     '<br>Start Date - ' + Format("Start Date") +
        //                     '<br>End Date - ' + Format("End Date") +
        //                     '<br>Return Date - ' + Format("Return Date") +
        //                     '<br>Days Applied - ' + Format("Days Applied") +
        //                     '<br><br>Kind Regards',
        //                     true
        //                   );
        //  SMTP.AddCC("Supervisor Email");
        //  SMTP.AddCC('fdgdgd');
        //  SMTP.AddAttachment('C:\Leave\'+"Application Code"+'.Excel',"Application Code");


        // SMTP.Send();
        // Message('Leave applicant has been notified successfully');

    end;

    [Scope('OnPrem')]
    procedure GetApplicantSupervisor(EmpUserID: Code[50]) SupervisorID: Code[10]
    var
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        HREmp2: Record "HR Employees";
    begin
        SupervisorID := '';

        UserSetup.Reset;
        if UserSetup.Get(EmpUserID) then begin
            UserSetup.TestField(UserSetup."Approver ID");

            //Get supervisor e-mail
            UserSetup2.Reset;
            if UserSetup2.Get(UserSetup."Approver ID") then begin
                UserSetup2.TestField(UserSetup2."E-Mail");
                "Applicant Supervisor" := UserSetup."Approver ID";
                "Supervisor Email" := UserSetup2."E-Mail";
            end;

        end else begin
            Error(Text003, EmpUserID, UserSetup.TableCaption);
        end;
    end;

    //[Scope('OnPrem')]
    procedure NotifyReliever()
    begin
        HREmp.Get(Reliever);
        HREmp.TestField(HREmp."Company E-Mail");

        HREmailParameters.Reset;
        HREmailParameters.Get(HREmailParameters."Associate With"::"Leave Notifications");
        // SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", HREmp."Company E-Mail",

        // 'Leave Reliever Notification', 'Dear' + '<br>' + HREmp."First Name" +
        // 'You are hereby notified that you''ve' + ' ' + 'been appointed as a Leave Reliever for' + ' ' + Names + ' ' + 'for a period of' + ' ' + Format("Days Applied") +
        // ' ' + 'days' + ' ' + 'from' + ' ' + Format("Start Date") + ' ' + 'to' + ' ' + Format("End Date") + '.' + ' ' + 'Please ensure that you understand the responsibilities given to you for that duration.', true);
        // SMTP.Send();
        // Message('Leave Reliever has been notified successfully');
        //DERRICK NOTIFY RELIVER.
    end;

    //[Scope('OnPrem')]
    procedure NotifyICT()
    begin
        //HREmp.GET(Reliever);
        //HREmp.TESTFIELD(HREmp."Company E-Mail");

        HREmailParameters.Reset;
        HREmailParameters.Get(HREmailParameters."Associate With"::"Leave Notifications");
        // SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", HREmailParameters."ICT mail",

        // 'Leave Notification', 'Dear' + '<br>' + 'ICT Department' + ' ' + ' <br>' +
        // 'You are hereby notified that the leave application for' + ' ' + Names + ' ' + ' has been fully approved for' + ' ' + Format("Days Applied") +
        // ' ' + 'days' + ' ' + 'from' + ' ' + Format("Start Date") + ' ' + 'to' + ' ' + Format("End Date") + '.' + ' ', true);
        // SMTP.Send();
        Message('ICT has been notified successfully');
        //DERRICK NOTIFY RELIVER.
    end;

    procedure ValidateShouldNotHaves(Number: Text; CharactersToCheck: Text): Boolean
    var
        i: Integer;

    begin
        FOR i := 1 TO STRLEN(Number) DO
            IF STRPOS(CharactersToCheck, Number[i]) > 0 THEN
                exit(false);

        exit(true);
    end;

    procedure NotifyHR()
    begin
        //HREmp.GET(Reliever);
        //HREmp.TESTFIELD(HREmp."Company E-Mail");

        HREmailParameters.Reset;
        HREmailParameters.Get(HREmailParameters."Associate With"::"Leave Notifications");
        // sSMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", HREmailParameters."HR Email",

        // 'Leave Notification', 'Dear' + '<br>' + 'HR Department' + ' ' + ' <br>' +
        // 'You are hereby notified that' + ' ' + Names + ' ' + ' has been fully approved for' + ' ' + Format("Days Applied") +
        // ' ' + 'days' + ' ' + 'from' + ' ' + Format("Start Date") + ' ' + 'to' + ' ' + Format("End Date") + ' and hence qualifies for leave allowance.' + ' ', true);
        // SMTP.Send();
        Message('HR has been notified successfully');
        //DERRICK NOTIFY RELIVER.
    end;

    [Scope('OnPrem')]
    procedure ModifyUserDate()
    var
        User: Record User;
    begin
        User.Reset;
        User.SetRange("User Name", "Applicant User ID");
        if User.Find('-') then begin
            if "Days Applied" > 3 then
                User."Expiry Date" := CreateDateTime("Start Date", 0T);
            User.Modify
        end
    end;
}

