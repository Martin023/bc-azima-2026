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
                // TEST IF MANUAL NOS ARE ALLOWED
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
            // WHERE(Active = FILTER(true));

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
                            Error('This leave type is restricted to the %1 gender', Format(HRLeaveTypes.Gender));

                end;
                "Days Applied" := 0;
            end;
        }
        field(4; "Days Applied"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(5; "Start Date"; Date)
        {
            trigger OnValidate()
            var
                CurrentCalendar: Record "HR Leave Calendar";
            begin
                if "Start Date" = 0D then begin
                    "End Date" := 0D;
                    "Return Date" := 0D;
                    "Days Applied" := 0;
                    "Is Morning Half Day" := false;
                    "Is Afternoon Half Day" := false;
                end else begin
                    CurrentCalendar.Reset();
                    CurrentCalendar.SetRange("Current Leave Calendar", true);
                    if CurrentCalendar.FindFirst() then begin
                        if ("Start Date" < CurrentCalendar."Start Date") or ("Start Date" > CurrentCalendar."End Date") then
                            Error('Start Date %1 is outside the current leave calendar range (%2 to %3). Please update the calendar or select a date within range.',
                                "Start Date", CurrentCalendar."Start Date", CurrentCalendar."End Date");
                    end;

                    if DetermineIfIsNonWorking("Start Date") = true then
                        Error('Start date must be a working day');
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
                    // Prevent double-posting if already posted
                    if Posted then
                        Error('This leave application has already been posted (ledger entry exists). Cannot approve again.');

                    // CHECK LEAVE YEAR
                    // if Date2DMY(Today, 3) < Date2DMY("Return Date", 3) then
                    //     Error('Leave appllication must be done within the current year %1', Format(Date2DMY(Today, 3)));

                    intEntryNo := 0;
                    HRLeaveCal.Reset;
                    HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
                    if not HRLeaveCal.Find('-') then Error('Leave Calendar not setup');


                    HRLeaveEntries.Reset;
                    // HRLeaveEntries.SetRange(HRLeaveEntries."Entry No.");
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

                    // SendApprovalEmailToApplicant();
                    // SendApprovalEmailToReliever();
                    SendApprovalSMSToApplicant();
                    SendApprovalSMSToReliever();

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
            trigger OnValidate()
            var
                CurrentCalendar: Record "HR Leave Calendar";
            begin
                TestField("Start Date");
                TestField("Leave Type");

                if "End Date" = 0D then begin
                    "Days Applied" := 0;
                    "Return Date" := 0D;
                    "Is Morning Half Day" := false;
                    "Is Afternoon Half Day" := false;
                    exit;
                end;

                if "End Date" < "Start Date" then
                    Error('End Date cannot be earlier than Start Date');

                CurrentCalendar.Reset();
                CurrentCalendar.SetRange("Current Leave Calendar", true);
                if CurrentCalendar.FindFirst() then begin
                    if ("End Date" < CurrentCalendar."Start Date") or ("End Date" > CurrentCalendar."End Date") then
                        Error('End Date %1 is outside the current leave calendar range (%2 to %3). Please update the calendar or select a date within range.',
                            "End Date", CurrentCalendar."Start Date", CurrentCalendar."End Date");
                end;

                if DetermineIfIsNonWorking("End Date") = true then
                    Error('End date must be a working day');

                //if "Is Morning Half Day" or "Is Afternoon Half Day" then begin
                //    if "Start Date" <> "End Date" then
                //        Error('Half day leave must have the same start and end date');
                //
                //    "Days Applied" := 0.5;
                //
                //    if "Is Morning Half Day" then
                //        "Return Date" := "End Date"
                //    else begin
                //        "Return Date" := CalcDate('1D', "End Date");
                //        while DetermineIfIsNonWorking("Return Date") do
                //            "Return Date" := CalcDate('1D', "Return Date");
                //    end;
                //end else begin
                //    "Days Applied" := CalculateDaysFromDateRange("Start Date", "End Date");
                //
                //    "Return Date" := CalcDate('1D', "End Date");
                //    while DetermineIfIsNonWorking("Return Date") do
                //        "Return Date" := CalcDate('1D', "Return Date");
                //end;

                "Days Applied" := CalculateDaysFromDateRange("Start Date", "End Date");

                if "Is Morning Half Day" then begin
                    if GetDayLeaveValue("End Date") = 0.5 then
                        Error('Morning Half-Day cannot be applied because %1 is already configured as a half-day in the leave calendar.', "End Date");
                    "Days Applied" -= 0.5;
                end;

                if "Is Afternoon Half Day" then begin
                    if GetDayLeaveValue("Start Date") = 0.5 then
                        Error('Afternoon Half-Day cannot be applied because %1 is already configured as a half-day in the leave calendar.', "Start Date");
                    "Days Applied" -= 0.5;
                end;

                if "Start Date" = "End Date" then begin
                    if "Is Morning Half Day" and "Is Afternoon Half Day" then
                        Error('Cannot apply for zero days leave. For same-day half-day leave, select only one option.');
                end;

                if "Is Morning Half Day" then begin
                    "Return Date" := "End Date";
                    "Return Time" := 'Afternoon';
                end else begin
                    "Return Date" := CalcDate('1D', "End Date");
                    while DetermineIfIsNonWorking("Return Date") do
                        "Return Date" := CalcDate('1D', "Return Date");
                    "Return Time" := 'Morning';
                end;

                // Calculate leave start time
                if "Is Afternoon Half Day" then
                    "Leave Start Time Calc" := 'Afternoon'
                else
                    "Leave Start Time Calc" := 'Morning';

                if "Days Applied" < 0.5 then
                    Error('Calculated days cannot be less than 0.5');

                IF HRLeaveTypes.get("Leave Type") THEN BEGIN
                    IF HRLeaveTypes.Gender = HRLeaveTypes.Gender::Female then
                        IF "Days Applied" < HRLeaveTypes.Days THEN Error('Days Applied cannot be less than %1', Format(HRLeaveTypes.Days));
                END;

                if "Days Applied" >= 15 then
                    "Request Leave Allowance" := true
                else
                    "Request Leave Allowance" := false;

                if Date2DMY("End Date", 3) <> Date2DMY(Today, 3) then
                    Error('You cannot apply leave for a different year other than %1', Format(Date2DMY(Today, 3)));

                HRLeaveApp.Reset();
                HRLeaveApp.SetRange("Applicant Staff No.", Rec."Applicant Staff No.");
                HRLeaveApp.SetFilter("Application Code", '<>%1', Rec."Application Code");
                HRLeaveApp.SetFilter(Status, '%1|%2', HRLeaveApp.Status::Approved, HRLeaveApp.Status::"Pending Approval");
                if HRLeaveApp.FindSet() then begin
                    repeat
                        if (Rec."Start Date" <= HRLeaveApp."End Date") and (Rec."End Date" >= HRLeaveApp."Start Date") then
                            Error('You already have an active or pending leave application (%1) that overlaps with these dates!', HRLeaveApp."Application Code");
                    until HRLeaveApp.Next() = 0;
                end;

                if "Days Applied" > "Leave Days Balance" then
                    Error('You are applying for %1 days which exceeds your leave balance of %2 days', "Days Applied", "Leave Days Balance");
            end;
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
            // "Global Dimension 2 Code" = FIELD("Global Dimension 2 Code"));

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
                    // POPULATE EMPLOYEE NAME
                    Rec."Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";

                    HRLeaveCal.Reset;
                    HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
                    if not HRLeaveCal.Find('-') then Error('Leave Calendar has not been setup');

                    // FILTER BY LEAVE PERIOD
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
            DecimalPlaces = 0 : 1;
        }
        field(4003; "Total Leave Days"; Decimal)
        {
            Caption = 'Total Annual Leave Days';
            DecimalPlaces = 0 : 1;
        }
        field(4004; "Total Leave Taken"; Decimal)
        {
            Caption = 'Total Annual Leave Taken';
            DecimalPlaces = 0 : 1;
        }
        field(4005; "Leave Days Balance"; Decimal)
        {
            Caption = 'Annual Leave Days Balance';
            DecimalPlaces = 0 : 1;
        }
        field(4006; "Is Morning Half Day"; Boolean)
        {
            Caption = 'Morning Half Day';

            trigger OnValidate()
            begin
                // Recalculate whenever checkbox changes (checked or unchecked)
                if "End Date" <> 0D then
                    Validate("End Date");
            end;
        }
        field(4007; "Is Afternoon Half Day"; Boolean)
        {
            Caption = 'Afternoon Half Day';

            trigger OnValidate()
            begin
                // Recalculate whenever checkbox changes (checked or unchecked)
                if "End Date" <> 0D then
                    Validate("End Date");
            end;
        }
        field(4008; "Leave Start Time"; Text[20])
        {
            Caption = 'Leave Starts';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("HR Leave Application"."Leave Start Time Calc" WHERE("Application Code" = FIELD("Application Code")));
        }
        field(4009; "Leave Start Time Calc"; Text[20])
        {
            Caption = 'Leave Start Time';
            Editable = false;

            trigger OnValidate()
            begin
                if "Is Afternoon Half Day" then
                    "Leave Start Time Calc" := 'Afternoon'
                else
                    "Leave Start Time Calc" := 'Morning';
            end;
        }
        field(4010; "Return Time"; Text[20])
        {
            Caption = 'Return Time';
            Editable = false;

            trigger OnValidate()
            begin
                if "Is Morning Half Day" then
                    "Return Time" := 'Afternoon'
                else
                    "Return Time" := 'Morning';
            end;
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
        ERROR('Please edit document instead of deleting');
    end;

    trigger OnInsert()
    var
        LeaveApplication: Record "HR Leave Application";
    begin
        // NO SERIES
        if "Application Code" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Leave Application Nos.");
            "Application Code" := NoSeriesMgt.GetNextNo(HRSetup."Leave Application Nos.");
        end;

        if "Source of Application" = "Source of Application"::BC then begin
            HREmp.Reset;
            HREmp.SetRange(HREmp."User ID", UserId);
            if HREmp.Find('-') then begin
                HREmp.TestField(HREmp."Date Of Join");

                Calendar.Reset;
                Calendar.SetRange("Period Type", Calendar."Period Type"::Month);
                Calendar.SetRange("Period Start", HREmp."Date Of Join", Today);
                empMonths := Calendar.Count;


                // POPULATE FIELDS
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
                // "Responsibility Center":=HREmp."Responsibility Center";

                // APPROVER DETAILS
                // GetApplicantSupervisor(UserId);

            end else begin
                ERROR('UserID [%1] has not been assigned to any employee. Please consult the HR officer for assistance', USERID)
            end;
            // end;




            // CHECK EXISTING APPLICATIONS
            xRec.Reset;
            xRec.SetRange(xRec."Applicant User ID", UserId);
            // ALLOW MULTIPLE PENDING APPLICATIONS
            // xRec.SetRange(xRec.Status, xRec.Status::"Pending Approval");
            // CHECK NEW OR PENDING STATUS
            xRec.SetFilter(xRec.Status, '%1|%2', xRec.Status::New, xRec.Status::"Pending Approval");
            if xRec.Find('-') then begin
                ERROR('Your leave application no. %1 with status %2 is still pending. Please complete or cancel this application before creating a new one.', xRec."Application Code", xRec.Status);
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


                // POPULATE FIELDS
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
                // "Responsibility Center":=HREmp."Responsibility Center";

                // APPROVER DETAILS
                // GetApplicantSupervisor(UserId);

            end;

            LeaveApplication.Reset;
            LeaveApplication.SetRange(LeaveApplication."Applicant Staff No.", HREmp."No.");
            LeaveApplication.SetFilter(LeaveApplication."Application Code", '<>%1', Rec."Application Code");
            LeaveApplication.SetFilter(LeaveApplication.Status, '=%1|%2', LeaveApplication.Status::"Pending Approval", LeaveApplication.Status::New);
            if LeaveApplication.Find('-') then begin
                ERROR('Your leave application no %1 is still pending Approval. Kindly contact the HR department to have it approved first.', LeaveApplication."Application Code");
                REPEAT
                    IF "Start Date" < HRLeaveApp."Return Date" THEN
                        ERROR('You already have an active leave application!');
                UNTIL HRLeaveApp.NEXT = 0;
            END;
        end;
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit "No. Series";
        HREmp: Record "HR Employees";
        varDaysApplied: Decimal;
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

    procedure CalculateDaysFromDateRange(StartDate: Date; EndDate: Date): Decimal
    var
        CurrentDate: Date;
        TotalDays: Decimal;
        DayValue: Decimal;
    begin
        TotalDays := 0;
        CurrentDate := StartDate;

        while CurrentDate <= EndDate do begin
            DayValue := GetDayLeaveValue(CurrentDate);
            TotalDays += DayValue;
            CurrentDate := CalcDate('1D', CurrentDate);
        end;

        exit(TotalDays);
    end;

    procedure GetDayLeaveValue(var bcDate: Date): Decimal
    var
        CalendarLine: Record "HR Leave Calendar Lines";
        CalendarCode: Code[20];
    begin
        if bcDate = 0D then
            exit(1.0);

        CalendarCode := GetCurrentCalendarCode();

        CalendarLine.Reset();
        CalendarLine.SetRange(Code, CalendarCode);
        CalendarLine.SetRange(Date, bcDate);

        if CalendarLine.FindFirst() then begin
            if CalendarLine."Non Working" then
                exit(0.0);

            if CalendarLine."Is Half Day" then
                exit(0.5);

            exit(1.0);
        end;
        exit(1.0);
    end;

    local procedure GetCurrentCalendarCode(): Code[20]
    var
        LeaveCalendar: Record "HR Leave Calendar";
    begin
        LeaveCalendar.Reset();
        LeaveCalendar.SetRange("Current Leave Calendar", true);
        if LeaveCalendar.FindFirst() then
            exit(LeaveCalendar."Calendar Code");

        Error('No current leave calendar is configured. Please set a calendar as current in Leave Calendar setup.');
    end;

    // [Scope('OnPrem')]
    procedure DetermineLeaveReturnDate(var fBeginDate: Date; var fDays: Decimal) fReturnDate: Date
    var
        DayValue: Decimal;
    begin
        varDaysApplied := fDays;
        fReturnDate := fBeginDate;

        if varDaysApplied <= 0 then
            exit(fReturnDate);

        repeat
            if DetermineIfIncludesNonWorking("Leave Type") = false then begin
                // GET VALUE OF CURRENT DAY
                DayValue := GetDayLeaveValue(fReturnDate);

                varDaysApplied := varDaysApplied - DayValue;

                if varDaysApplied > 0 then
                    fReturnDate := CalcDate('1D', fReturnDate);
            end else begin
                // LEAVES THAT INCLUDE WEEKENDS
                varDaysApplied := varDaysApplied - 1;

                if varDaysApplied > 0 then
                    fReturnDate := CalcDate('1D', fReturnDate);
            end;
        until varDaysApplied <= 0;

        // FIND NEXT WORKING DAY FOR RETURN DATE
        fReturnDate := CalcDate('1D', fReturnDate);
        while GetDayLeaveValue(fReturnDate) = 0.0 do begin
            fReturnDate := CalcDate('1D', fReturnDate);
        end;

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
    begin
        // IF VALUE IS 0.0 IT IS NON-WORKING. 0.5 AND 1.0 ARE WORKING
        if GetDayLeaveValue(bcDate) = 0.0 then
            exit(true)
        else
            exit(false);
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

    procedure CreateLeaveLedgerEntries()
    begin
        // GET OPEN LEAVE PERIOD
        HRLeaveCal.Reset;
        HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
        HRLeaveCal.Find('-');

        HRJournalBatch.Reset;
        HRSetup.Get;
        HRSetup.TestField(HRSetup."Default Leave Posting Template");
        HRSetup.TestField(HRSetup."Negative Leave Posting Batch");

        HRJournalBatch.Get(HRSetup."Default Leave Posting Template", HRSetup."Negative Leave Posting Batch");

        // POPULATE JOURNAL LINES
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

        // POST JOURNAL
        HRJournalLine.Reset;
        HRJournalLine.SetRange("Journal Template Name", HRSetup."Default Leave Posting Template");
        HRJournalLine.SetRange("Journal Batch Name", HRSetup."Negative Leave Posting Batch");
        if HRJournalLine.Find('-') then begin
            CODEUNIT.Run(CODEUNIT::"HR Leave Jnl.-Post", HRJournalLine);


        end;


        // INSERT LEAVE ALLOWANCE
        if "Request Leave Allowance" = true then begin
            prVitalSetup.Reset;
            prVitalSetup.Get;
            // Mandatory fields
            // prVitalSetup.TESTFIELD(prVitalSetup."Leave Allowance Percentage");
            // prVitalSetup.TESTFIELD(prVitalSetup."Leave Allowance Based On");
            // prVitalSetup.TESTFIELD(prVitalSetup."Max. Leave Allowance");

            if prVitalSetup."Leave Allowance Based On" = prVitalSetup."Leave Allowance Based On"::"Basic Pay" then          // BASED ON BPAY
            begin
                // GET BASIC PAY
                PRSalCard.Reset;
                if not PRSalCard.Find('-') then begin
                    Error('Enter BPAY for Staff');
                end;
            end;

            // INSERT ENTRY

            LeaveAllowances.Init;
            LeaveAllowances."Application No." := "Application Code";
            LeaveAllowances."Employee No." := "Applicant Staff No.";
            LeaveAllowances."Employee Name" := Names;
            LeaveAllowances."Start Date" := "Start Date";
            LeaveAllowances."End Date" := "End Date";
            LeaveAllowances."Date Posted" := Today;
            LeaveAllowances.Year := Date2DMY(LeaveAllowances."Date Posted", 3);
            LeaveAllowances.Amount := prVitalSetup."Leave Allowance Percentage" * PRSalCard."Basic Pay";
            // MAX 50000
            if LeaveAllowances.Amount > prVitalSetup."Max. Leave Allowance" then LeaveAllowances.Amount := prVitalSetup."Max. Leave Allowance";

            LeaveAllowances.Insert
        end;
    end;

    [Scope('OnPrem')]
    procedure NotifyApplicant()
    begin



        HREmp.Get("Applicant Staff No.");
        HREmp.TestField(HREmp."Company E-Mail");


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

            // Get supervisor e-mail
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
        // NOTIFY RELIEVER
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
        // NOTIFY RELIEVER
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
        HREmailParameters.Reset;
        HREmailParameters.Get(HREmailParameters."Associate With"::"Leave Notifications");
        Message('HR has been notified successfully');
    end;

    procedure UpdateRecallSummary()
    begin
        CalcFields("Days Reimbursed");
        Modify();
    end;

    local procedure SendApprovalEmailToApplicant()
    var
        Dispatcher: Codeunit "HR Email Dispatcher";
        TokenVals: Text;
    begin
        // TOKENS: EMPLOYEE_NAME, LEAVE_TYPE, START_DATE, END_DATE, DAYS_APPROVED, RETURN_DATE, APPLICATION_CODE
        TokenVals := 'EMPLOYEE_NAME=' + Names + '||' +
                     'LEAVE_TYPE=' + "Leave Type" + '||' +
                     'START_DATE=' + Format("Start Date") + '||' +
                     'END_DATE=' + Format("End Date") + '||' +
                     'DAYS_APPROVED=' + Format("Days Applied") + '||' +
                     'RETURN_DATE=' + Format("Return Date") + '||' +
                     'APPLICATION_CODE=' + "Application Code";
        Dispatcher.Send('LEAVE-APPROVAL', 0, "Applicant Staff No.", "Application Code", TokenVals);
    end;

    local procedure SendApprovalSMSToApplicant()
    var
        SMSDispatcher: Codeunit "HR SMS Dispatcher";
        TokenVals: Text;
    begin
        // TOKENS: EMPLOYEE_NAME,RELIEVER_NAME,LEAVE_TYPE, START_DATE, END_DATE, DAYS_APPROVED, RETURN_DATE, APPLICATION_CODE
        TokenVals := 'EMPLOYEE_NAME=' + Names + '||' +
                     'RELIEVER_NAME=' + "Reliever Name" + '||' +
                     'LEAVE_TYPE=' + "Leave Type" + '||' +
                     'START_DATE=' + Format("Start Date") + '||' +
                     'END_DATE=' + Format("End Date") + '||' +
                     'DAYS_APPROVED=' + Format("Days Applied") + '||' +
                     'RETURN_DATE=' + Format("Return Date") + '||' +
                     'APPLICATION_CODE=' + "Application Code";
        SMSDispatcher.Send('LEAVE-APPROVAL', 0, "Applicant Staff No.", "Application Code", TokenVals);
    end;

    local procedure SendApprovalEmailToReliever()
    var
        Dispatcher: Codeunit "HR Email Dispatcher";
        TokenVals: Text;
    begin
        if Reliever = '' then
            exit;
        // TOKENS: RELIEVER_NAME, EMPLOYEE_NAME, LEAVE_TYPE, START_DATE, END_DATE, RETURN_DATE, APPLICATION_CODE
        TokenVals := 'RELIEVER_NAME=' + "Reliever Name" + '||' +
                     'EMPLOYEE_NAME=' + Names + '||' +
                     'LEAVE_TYPE=' + "Leave Type" + '||' +
                     'START_DATE=' + Format("Start Date") + '||' +
                     'END_DATE=' + Format("End Date") + '||' +
                     'RETURN_DATE=' + Format("Return Date") + '||' +
                     'APPLICATION_CODE=' + "Application Code";
        Dispatcher.Send('LEAVE-RELIEVER', 1, Reliever, "Application Code", TokenVals);
    end;

    local procedure SendApprovalSMSToReliever()
    var
        SMSDispatcher: Codeunit "HR SMS Dispatcher";
        TokenVals: Text;
    begin
        if Reliever = '' then
            exit;
        // TOKENS: RELIEVER_NAME, EMPLOYEE_NAME, LEAVE_TYPE, START_DATE, END_DATE, RETURN_DATE
        TokenVals := 'RELIEVER_NAME=' + "Reliever Name" + '||' +
                     'EMPLOYEE_NAME=' + Names + '||' +
                     'LEAVE_TYPE=' + "Leave Type" + '||' +
                     'START_DATE=' + Format("Start Date") + '||' +
                     'END_DATE=' + Format("End Date") + '||' +
                     'RETURN_DATE=' + Format("Return Date");
        SMSDispatcher.Send('LEAVE-RELIEVER', 1, Reliever, "Application Code", TokenVals);
    end;

}
