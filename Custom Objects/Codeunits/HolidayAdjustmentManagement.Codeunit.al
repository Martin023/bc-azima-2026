codeunit 52185432 "Holiday Adjustment Management"
{
    procedure ProcessHolidayDeclaration(HolidayDate: Date; CalendarCode: Code[20])
    var
        LeaveApp: Record "HR Leave Application";
        HRLeaveTypes: Record "HR Leave Types";
        AffectedCount: Integer;
        ProcessedCount: Integer;
        FailedCount: Integer;
    begin
        AffectedCount := 0;
        ProcessedCount := 0;
        FailedCount := 0;

        LeaveApp.Reset();
        LeaveApp.SetRange(Status, LeaveApp.Status::Approved);
        LeaveApp.SetFilter("Start Date", '..%1', HolidayDate);
        LeaveApp.SetFilter("End Date", '%1..', HolidayDate);

        if LeaveApp.FindSet() then begin
            repeat
                if HRLeaveTypes.Get(LeaveApp."Leave Type") then begin
                    if not HRLeaveTypes."Inclusive of Non Working Days" then begin
                        AffectedCount += 1;

                        if PostHolidayReimbursement(LeaveApp, HolidayDate, CalendarCode) then
                            ProcessedCount += 1
                        else
                            FailedCount += 1;
                    end;
                end;
            until LeaveApp.Next() = 0;
        end;

        if AffectedCount = 0 then
            Message('No active leave applications affected by this holiday declaration.')
        else
            Message('%1 leave application(s) adjusted successfully. %2 failed.\Total: %3 day(s) reimbursed.', ProcessedCount, FailedCount, ProcessedCount);
    end;

    procedure ReverseHolidayDeclaration(HolidayDate: Date; CalendarCode: Code[20])
    var
        LeaveApp: Record "HR Leave Application";
        HRLeaveTypes: Record "HR Leave Types";
        AffectedCount: Integer;
        ProcessedCount: Integer;
        FailedCount: Integer;
    begin
        AffectedCount := 0;
        ProcessedCount := 0;
        FailedCount := 0;

        LeaveApp.Reset();
        LeaveApp.SetRange(Status, LeaveApp.Status::Approved);
        LeaveApp.SetFilter("Start Date", '..%1', HolidayDate);
        LeaveApp.SetFilter("End Date", '%1..', HolidayDate);

        if LeaveApp.FindSet() then begin
            repeat
                if HRLeaveTypes.Get(LeaveApp."Leave Type") then begin
                    if not HRLeaveTypes."Inclusive of Non Working Days" then begin
                        AffectedCount += 1;

                        if PostHolidayReversal(LeaveApp, HolidayDate, CalendarCode) then
                            ProcessedCount += 1
                        else
                            FailedCount += 1;
                    end;
                end;
            until LeaveApp.Next() = 0;
        end;

        if AffectedCount = 0 then
            Message('No leave applications affected by this holiday reversal.')
        else
            Message('%1 leave application(s) reversed successfully. %2 failed.\Total: %3 day(s) deducted.', ProcessedCount, FailedCount, ProcessedCount);
    end;

    local procedure PostHolidayReimbursement(var LeaveApp: Record "HR Leave Application"; HolidayDate: Date; CalendarCode: Code[20]): Boolean
    var
        LeaveGjline: Record "HR Leave Journal Line";
        HRLeaveCal: Record "HR Leave Calendar";
        JBatch: Code[10];
        JTemplate: Code[10];
        EntryNo: Integer;
    begin
        HRLeaveCal.Reset();
        HRLeaveCal.SetRange("Current Leave Calendar", true);
        if not HRLeaveCal.Find('-') then
            exit(false);

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
        LeaveGjline."Leave Calendar Code" := HRLeaveCal."Calendar Code";
        LeaveGjline."Staff No." := LeaveApp."Applicant Staff No.";
        LeaveGjline."Staff Name" := LeaveApp.Names;
        LeaveGjline."Leave Type" := LeaveApp."Leave Type";
        LeaveGjline."Leave Entry Type" := LeaveGjline."Leave Entry Type"::Reimbursement;
        LeaveGjline."No. of Days" := 1;
        LeaveGjline.Description := 'Holiday Adjustment: ' + Format(HolidayDate) + ' - ' + LeaveApp."Application Code";
        LeaveGjline."Document No." := LeaveApp."Applicant Staff No.";
        LeaveGjline."Posting Date" := Today;
        LeaveGjline."Global Dimension 1 Code" := LeaveApp."Global Dimension 1 Code";
        LeaveGjline."Global Dimension 2 Code" := LeaveApp."Global Dimension 2 Code";
        LeaveGjline.Insert();

        LeaveGjline.Reset();
        LeaveGjline.SetRange("Journal Batch Name", JBatch);
        LeaveGjline.SetRange("Journal Template Name", JTemplate);
        if LeaveGjline.Find('-') then begin
            Codeunit.Run(Codeunit::"HR Leave Jnl.-Post", LeaveGjline);

            SendHolidayAdjustmentEmail(LeaveApp, HolidayDate, 1, true);
            exit(true);
        end;

        exit(false);
    end;

    local procedure PostHolidayReversal(var LeaveApp: Record "HR Leave Application"; HolidayDate: Date; CalendarCode: Code[20]): Boolean
    var
        LeaveGjline: Record "HR Leave Journal Line";
        HRLeaveCal: Record "HR Leave Calendar";
        JBatch: Code[10];
        JTemplate: Code[10];
        EntryNo: Integer;
    begin
        HRLeaveCal.Reset();
        HRLeaveCal.SetRange("Current Leave Calendar", true);
        if not HRLeaveCal.Find('-') then
            exit(false);

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
        LeaveGjline."Leave Calendar Code" := HRLeaveCal."Calendar Code";
        LeaveGjline."Staff No." := LeaveApp."Applicant Staff No.";
        LeaveGjline."Staff Name" := LeaveApp.Names;
        LeaveGjline."Leave Type" := LeaveApp."Leave Type";
        LeaveGjline."Leave Entry Type" := LeaveGjline."Leave Entry Type"::Negative;
        LeaveGjline."No. of Days" := -1;
        LeaveGjline.Description := 'Holiday Reversal: ' + Format(HolidayDate) + ' - ' + LeaveApp."Application Code";
        LeaveGjline."Document No." := LeaveApp."Applicant Staff No.";
        LeaveGjline."Posting Date" := Today;
        LeaveGjline."Global Dimension 1 Code" := LeaveApp."Global Dimension 1 Code";
        LeaveGjline."Global Dimension 2 Code" := LeaveApp."Global Dimension 2 Code";
        LeaveGjline.Insert();

        LeaveGjline.Reset();
        LeaveGjline.SetRange("Journal Batch Name", JBatch);
        LeaveGjline.SetRange("Journal Template Name", JTemplate);
        if LeaveGjline.Find('-') then begin
            Codeunit.Run(Codeunit::"HR Leave Jnl.-Post", LeaveGjline);

            SendHolidayAdjustmentEmail(LeaveApp, HolidayDate, 1, false);
            exit(true);
        end;

        exit(false);
    end;

    local procedure SendHolidayAdjustmentEmail(var LeaveApp: Record "HR Leave Application"; HolidayDate: Date; Days: Decimal; IsReimbursement: Boolean)
    var
        HREmp: Record "HR Employees";
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailBody: Text;
        Subject: Text;
    begin
        if HREmp.Get(LeaveApp."Applicant Staff No.") then begin
            if HREmp."E-Mail" <> '' then begin
                if IsReimbursement then begin
                    Subject := 'Leave Holiday Adjustment Notification';
                    EmailBody := '<html><body>';
                    EmailBody += '<p>Dear <b>' + LeaveApp.Names + '</b>,</p>';
                    EmailBody += '<p>Your leave balance has been adjusted due to a holiday declaration.</p>';
                    EmailBody += '<p><b>Adjustment Details:</b></p>';
                    EmailBody += '<ul>';
                    EmailBody += '<li><b>Leave Application Code:</b> ' + LeaveApp."Application Code" + '</li>';
                    EmailBody += '<li><b>Holiday Date:</b> ' + Format(HolidayDate) + '</li>';
                    EmailBody += '<li><b>Days Reimbursed:</b> ' + Format(Days) + ' day(s)</li>';
                    EmailBody += '</ul>';
                    EmailBody += '<p>The declared holiday fell within your approved leave period. The affected day(s) have been reimbursed to your leave balance.</p>';
                    EmailBody += '<p>Thank you.</p>';
                    EmailBody += '<p><i>This is an automated notification from HR Leave Management System.</i></p>';
                    EmailBody += '</body></html>';
                end else begin
                    Subject := 'Leave Holiday Reversal Notification';
                    EmailBody := '<html><body>';
                    EmailBody += '<p>Dear <b>' + LeaveApp.Names + '</b>,</p>';
                    EmailBody += '<p>Your leave balance has been adjusted due to a holiday reversal.</p>';
                    EmailBody += '<p><b>Adjustment Details:</b></p>';
                    EmailBody += '<ul>';
                    EmailBody += '<li><b>Leave Application Code:</b> ' + LeaveApp."Application Code" + '</li>';
                    EmailBody += '<li><b>Date:</b> ' + Format(HolidayDate) + '</li>';
                    EmailBody += '<li><b>Days Deducted:</b> ' + Format(Days) + ' day(s)</li>';
                    EmailBody += '</ul>';
                    EmailBody += '<p>A previously declared holiday was reversed. The day(s) have been deducted from your leave balance.</p>';
                    EmailBody += '<p>Thank you.</p>';
                    EmailBody += '<p><i>This is an automated notification from HR Leave Management System.</i></p>';
                    EmailBody += '</body></html>';
                end;

                EmailMsg.Create(HREmp."E-Mail", Subject, EmailBody, true);
                Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
            end;
        end;
    end;
}
