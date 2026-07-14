table 52185560 "HR Leave Recall Lines"
{
    Caption = 'HR Leave Recall Lines';
    DataClassification = CustomerContent;
    DrillDownPageID = "HR Leave Recall Lines";
    LookupPageID = "HR Leave Recall Lines";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Leave Application Code"; Code[20])
        {
            Caption = 'Leave Application Code';
            TableRelation = "HR Leave Application"."Application Code";
            Editable = false;
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "HR Employees"."No.";
            Editable = false;
        }
        field(4; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(5; "Recall Date"; Date)
        {
            Caption = 'Recall Date';

            trigger OnValidate()
            var
                LeaveApp: Record "HR Leave Application";
                ExistingRecall: Record "HR Leave Recall Lines";
                RecallEndDate: Date;
                CheckDate: Date;
                HRSetup: Record "HR Setup";
                DaysNotice: Integer;
                ActualDaysInRange: Decimal;
            begin
                TestField("Leave Application Code");
                TestField("Days Recalled");

                if "Recall Date" = 0D then
                    exit;

                LeaveApp.Get("Leave Application Code");

                if ("Recall Date" < LeaveApp."Start Date") or ("Recall Date" > LeaveApp."End Date") then
                    Error('Recall date must be within the leave period (%1 to %2)', LeaveApp."Start Date", LeaveApp."End Date");

                if LeaveApp.DetermineIfIsNonWorking("Recall Date") then
                    Error('Recall date must be a working day (not weekend or holiday)');

                if HRSetup.Get then begin
                    if HRSetup."Min Recall Notice Days" > 0 then begin
                        DaysNotice := "Recall Date" - Today;
                        if DaysNotice < HRSetup."Min Recall Notice Days" then
                            Error('Recall requires minimum %1 days notice. You are providing %2 days notice.', HRSetup."Min Recall Notice Days", DaysNotice);
                    end;
                end;

                // Calculate RecallEndDate by counting actual leave days from calendar (not calendar days)
                RecallEndDate := CalculateRecallEndDate("Recall Date", "Days Recalled", LeaveApp);

                // Validate recall end date is within leave period
                if RecallEndDate > LeaveApp."End Date" then
                    Error('Days Recalled (%1) extends beyond the leave end date (%2). The recall period would end on %3.',
                        "Days Recalled", LeaveApp."End Date", RecallEndDate);

                // Check for overlaps with existing recalls
                CheckDate := "Recall Date";
                while CheckDate <= RecallEndDate do begin
                    ExistingRecall.Reset();
                    ExistingRecall.SetRange("Leave Application Code", "Leave Application Code");
                    ExistingRecall.SetFilter("Entry No.", '<>%1', "Entry No.");
                    if ExistingRecall.FindSet() then begin
                        repeat
                            if (CheckDate >= ExistingRecall."Recall Date") and
                               (CheckDate <= CalculateRecallEndDate(ExistingRecall."Recall Date", ExistingRecall."Days Recalled", LeaveApp)) then
                                Error('Recall dates overlap with existing recall (Entry %1, Recall Date %2)', ExistingRecall."Entry No.", ExistingRecall."Recall Date");
                        until ExistingRecall.Next() = 0;
                    end;

                    CheckDate := CalcDate('1D', CheckDate);
                end;

                ValidateTotalRecalledDays();
            end;
        }
        field(6; "Days Recalled"; Decimal)
        {
            Caption = 'Days Recalled';
            DecimalPlaces = 0 : 1;
            MinValue = 0.5;

            trigger OnValidate()
            var
                LeaveApp: Record "HR Leave Application";
                ExistingRecalls: Record "HR Leave Recall Lines";
                TotalPreviousRecalls: Decimal;
            begin
                if "Days Recalled" <= 0 then
                    Error('Days Recalled must be greater than 0');

                // CALCULATE DAYS REMAINING AFTER RECALL
                if "Leave Application Code" <> '' then begin
                    LeaveApp.Get("Leave Application Code");

                    // TOTAL PREVIOUS RECALLS EXCLUDING CURRENT
                    TotalPreviousRecalls := 0;
                    ExistingRecalls.Reset();
                    ExistingRecalls.SetRange("Leave Application Code", "Leave Application Code");
                    ExistingRecalls.SetFilter("Entry No.", '<>%1', "Entry No.");
                    ExistingRecalls.SetRange(Posted, true);
                    if ExistingRecalls.FindSet() then begin
                        repeat
                            TotalPreviousRecalls += ExistingRecalls."Days Recalled";
                        until ExistingRecalls.Next() = 0;
                    end;

                    "Days Remaining After Recall" := LeaveApp."Days Applied" - "Days Spent Before Recall" - TotalPreviousRecalls - "Days Recalled";
                end;

                if "Recall Date" <> 0D then
                    Validate("Recall Date");
            end;
        }
        field(7; Reason; Text[250])
        {
            Caption = 'Reason for Recall';

            trigger OnValidate()
            begin
                if StrLen(Reason) < 10 then
                    Error('Reason must be at least 10 characters');
            end;
        }
        field(8; "Recalled By"; Code[50])
        {
            Caption = 'Recalled By';
            Editable = false;
        }
        field(9; "Recall Timestamp"; DateTime)
        {
            Caption = 'Recall Timestamp';
            Editable = false;
        }
        field(10; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }
        field(11; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            Editable = false;
        }
        field(12; "Posted Date"; Date)
        {
            Caption = 'Posted Date';
            Editable = false;
        }
        field(13; "Ledger Entry No."; Integer)
        {
            Caption = 'Ledger Entry No.';
            Editable = false;
            TableRelation = "HR Leave Ledger Entries"."Entry No.";
        }
        field(14; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Editable = false;
        }
        field(15; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Editable = false;
        }
        field(16; "Leave Type"; Code[30])
        {
            Caption = 'Leave Type';
            TableRelation = "HR Leave Types".Code;
            Editable = false;
        }
        field(17; "Leave Start Time"; Text[20])
        {
            Caption = 'Leave Starts';
            Editable = false;
            FieldClass = Normal;
        }
        field(18; "Leave Return Time"; Text[20])
        {
            Caption = 'Leave Returns';
            Editable = false;
            FieldClass = Normal;
        }
        field(19; "Days Spent Before Recall"; Decimal)
        {
            Caption = 'Days Spent';
            Editable = false;
            DecimalPlaces = 0 : 1;
            FieldClass = Normal;
        }
        field(20; "Days Remaining After Recall"; Decimal)
        {
            Caption = 'Days Remaining';
            Editable = false;
            DecimalPlaces = 0 : 1;
            FieldClass = Normal;
        }
        field(21; "Recall End Date"; Date)
        {
            Caption = 'Recall End Date';
            Editable = false;
            ToolTip = 'Last working day of the recall period';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Leave Application Code")
        {
        }
        key(Key3; "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        LeaveApp: Record "HR Leave Application";
        ExistingRecalls: Record "HR Leave Recall Lines";
        TotalPreviousRecalls: Decimal;
    begin
        if "Leave Application Code" = '' then
            Error('Leave Application Code must be specified');

        LeaveApp.Get("Leave Application Code");

        if LeaveApp.Status <> LeaveApp.Status::Approved then
            Error('Leave Recall can only be recorded for approved leave applications');

        "Employee No." := LeaveApp."Applicant Staff No.";
        "Employee Name" := LeaveApp.Names;
        "Leave Type" := LeaveApp."Leave Type";
        "Global Dimension 1 Code" := LeaveApp."Global Dimension 1 Code";
        "Global Dimension 2 Code" := LeaveApp."Global Dimension 2 Code";
        "Recalled By" := UserId;
        "Recall Timestamp" := CurrentDateTime;

        // Populate narrative fields
        "Leave Start Time" := LeaveApp."Leave Start Time Calc";
        "Leave Return Time" := LeaveApp."Return Time";

        // AUTO-POPULATE RECALL DATE FROM PARENT LEAVE APPLICATION CARD
        if LeaveApp."Recall Date" <> 0D then
            "Recall Date" := LeaveApp."Recall Date";

        // Calculate days spent and remaining
        // Days spent = time from start to today (or start to recall date if not yet started)
        if Today < LeaveApp."Start Date" then
            "Days Spent Before Recall" := 0
        else if Today > LeaveApp."End Date" then
            "Days Spent Before Recall" := LeaveApp."Days Applied"
        else
            "Days Spent Before Recall" := LeaveApp.CalculateDaysFromDateRange(LeaveApp."Start Date", Today);

        // Calculate total previous recalls
        TotalPreviousRecalls := 0;
        ExistingRecalls.Reset();
        ExistingRecalls.SetRange("Leave Application Code", "Leave Application Code");
        ExistingRecalls.SetRange(Posted, true);
        if ExistingRecalls.FindSet() then begin
            repeat
                TotalPreviousRecalls += ExistingRecalls."Days Recalled";
            until ExistingRecalls.Next() = 0;
        end;

        // Days remaining = Original days - days recalled previously - current recall (will be updated on validate)
        "Days Remaining After Recall" := LeaveApp."Days Applied" - TotalPreviousRecalls;
    end;

    trigger OnModify()
    begin
        if Posted then
            Error('Cannot modify posted recall lines');
    end;

    trigger OnDelete()
    begin
        if Posted then
            Error('Cannot delete posted recall lines');
    end;

    procedure ValidateTotalRecalledDays()
    var
        LeaveApp: Record "HR Leave Application";
        RecallLine: Record "HR Leave Recall Lines";
        TotalRecalled: Decimal;
    begin
        LeaveApp.Get("Leave Application Code");

        RecallLine.Reset();
        RecallLine.SetRange("Leave Application Code", "Leave Application Code");
        RecallLine.SetFilter("Entry No.", '<>%1', "Entry No.");
        if RecallLine.FindSet() then begin
            repeat
                TotalRecalled += RecallLine."Days Recalled";
            until RecallLine.Next() = 0;
        end;

        TotalRecalled += "Days Recalled";

        if TotalRecalled > LeaveApp."Days Applied" then
            Error('Total recalled days (%1) cannot exceed days applied (%2)', TotalRecalled, LeaveApp."Days Applied");
    end;

    procedure PostRecall()
    var
        LeaveApp: Record "HR Leave Application";
        HRSetup: Record "HR Setup";
        LeaveGjline: Record "HR Leave Journal Line";
        HRLeaveCal: Record "HR Leave Calendar";
        StatusChangePermission: Record "Status Change Permissions.";
        HRLeaveLedger: Record "HR Leave Ledger Entries";
        JBatch: Code[10];
        JTemplate: Code[10];
        EntryNo: Integer;
        CalenderCode: Code[20];
    begin
        TestField("Recall Date");
        TestField("Days Recalled");
        TestField(Reason);

        if Posted then
            Error('This recall has already been posted');

        StatusChangePermission.Reset();
        StatusChangePermission.SetRange("Edit HR", true);
        if not StatusChangePermission.Find('-') then
            Error('You do not have permission to post leave recalls. Please contact ICT.');

        LeaveApp.Get("Leave Application Code");

        if LeaveApp.Status <> LeaveApp.Status::Approved then
            Error('Leave status must be Approved to post recall');

        // CALCULATE AND STORE RECALL END DATE BEFORE POSTING
        "Recall End Date" := CalculateRecallEndDate("Recall Date", "Days Recalled", LeaveApp);

        HRLeaveCal.Reset();
        HRLeaveCal.SetRange("Current Leave Calendar", true);
        if not HRLeaveCal.Find('-') then
            Error('Leave Calendar not setup')
        else
            CalenderCode := HRLeaveCal."Calendar Code";

        JBatch := 'POSITIVE';
        JTemplate := 'LEAVE';

        LeaveGjline.SetRange("Journal Batch Name", JBatch);
        LeaveGjline.SetRange("Journal Template Name", JTemplate);
        if LeaveGjline.Find('-') then
            LeaveGjline.DeleteAll();

        LeaveGjline.Reset();
        LeaveGjline.SetRange("Journal Batch Name", JBatch);
        LeaveGjline.SetRange("Journal Template Name", JTemplate);
        if LeaveGjline.FindLast() then
            EntryNo := LeaveGjline."Line No." + 1
        else
            EntryNo := 1;

        LeaveGjline.Init();
        LeaveGjline."Journal Template Name" := JTemplate;
        LeaveGjline."Journal Batch Name" := JBatch;
        LeaveGjline.Validate("Journal Batch Name");
        LeaveGjline."Line No." := EntryNo;
        LeaveGjline."Leave Calendar Code" := CalenderCode;
        LeaveGjline."Staff No." := "Employee No.";
        LeaveGjline."Staff Name" := "Employee Name";
        LeaveGjline."Leave Type" := "Leave Type";
        LeaveGjline."Leave Entry Type" := LeaveGjline."Leave Entry Type"::Reimbursement;
        LeaveGjline."No. of Days" := "Days Recalled";
        LeaveGjline.Description := 'Recall' + Format("Recall Date") + ' - ' + "Leave Application Code" + ' - ' + Reason;
        LeaveGjline."Document No." := "Employee No.";
        LeaveGjline."Posting Date" := Today;
        LeaveGjline."Global Dimension 1 Code" := "Global Dimension 1 Code";
        LeaveGjline."Global Dimension 2 Code" := "Global Dimension 2 Code";
        LeaveGjline.Insert();

        LeaveGjline.Reset();
        LeaveGjline.SetRange("Journal Batch Name", JBatch);
        LeaveGjline.SetRange("Journal Template Name", JTemplate);
        if LeaveGjline.Find('-') then begin
            Codeunit.Run(Codeunit::"HR Leave Jnl.-Post", LeaveGjline);

            // CAPTURE LEDGER ENTRY NO. AFTER POSTING
            HRLeaveLedger.Reset();
            HRLeaveLedger.SetRange("Staff No.", "Employee No.");
            HRLeaveLedger.SetRange("Document No.", "Employee No.");
            HRLeaveLedger.SetRange("Leave Entry Type", HRLeaveLedger."Leave Entry Type"::Reimbursement);
            HRLeaveLedger.SetRange("Posting Date", Today);
            HRLeaveLedger.SetRange("Leave Type", "Leave Type");
            if HRLeaveLedger.FindLast() then
                "Ledger Entry No." := HRLeaveLedger."Entry No.";

            Posted := true;
            "Posted By" := UserId;
            "Posted Date" := Today;
            Modify();

            SendRecallNotificationEmail();
            Message('Leave recall posted successfully. %1 day(s) reimbursed to %2. Recall period: %3 to %4',
                "Days Recalled", "Employee Name", "Recall Date", "Recall End Date");
        end else
            Error('Failed to post recall. Please check leave journal posting.');
    end;

    local procedure SendRecallNotificationEmail()
    var
        HREmp: Record "HR Employees";
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailBody: Text;
        Subject: Text;
    begin
        if HREmp.Get("Employee No.") then begin
            if HREmp."E-Mail" <> '' then begin
                Subject := 'Leave Recall Notification';
                EmailBody := '<html><body>';
                EmailBody += '<p>Dear <b>' + "Employee Name" + '</b>,</p>';
                EmailBody += '<p>You are hereby notified that you have been recalled from your approved leave.</p>';
                EmailBody += '<p><b>Recall Details:</b></p>';
                EmailBody += '<ul>';
                EmailBody += '<li><b>Leave Application Code:</b> ' + "Leave Application Code" + '</li>';
                EmailBody += '<li><b>Recall Date:</b> ' + Format("Recall Date") + '</li>';
                EmailBody += '<li><b>Days Recalled:</b> ' + Format("Days Recalled") + '</li>';
                EmailBody += '<li><b>Reason:</b> ' + Reason + '</li>';
                EmailBody += '<li><b>Days Reimbursed:</b> ' + Format("Days Recalled") + ' day(s) have been added back to your leave balance</li>';
                EmailBody += '</ul>';
                EmailBody += '<p>Please ensure you report to work on the recall date(s).</p>';
                EmailBody += '<p>Thank you.</p>';
                EmailBody += '<p><i>This is an automated notification from HR Leave Management System.</i></p>';
                EmailBody += '</body></html>';

                EmailMsg.Create(HREmp."E-Mail", Subject, EmailBody, true);
                Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
            end;
        end;
    end;

    local procedure CalculateRecallEndDate(StartDate: Date; DaysToRecall: Decimal; LeaveApp: Record "HR Leave Application"): Date
    var
        CurrentDate: Date;
        DaysAccumulated: Decimal;
        DayValue: Decimal;
    begin
        // Calculate the end date by counting actual leave days from calendar
        CurrentDate := StartDate;
        DaysAccumulated := 0;

        while DaysAccumulated < DaysToRecall do begin
            // Get day value from calendar (0.0 = non-working, 0.5 = half-day, 1.0 = full day)
            DayValue := LeaveApp.GetDayLeaveValue(CurrentDate);

            // Only count working days
            if DayValue > 0 then begin
                DaysAccumulated += DayValue;

                // If we've reached or exceeded target, this is the end date
                if DaysAccumulated >= DaysToRecall then
                    exit(CurrentDate);
            end;

            CurrentDate := CalcDate('1D', CurrentDate);

            // Safety check: don't go beyond leave end date
            if CurrentDate > LeaveApp."End Date" then
                exit(CurrentDate);
        end;

        exit(CurrentDate);
    end;
}
