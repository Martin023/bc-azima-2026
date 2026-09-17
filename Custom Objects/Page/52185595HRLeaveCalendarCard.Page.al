page 52185595 "HR Leave Calendar Card"
{
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Functions';
    SourceTable = "HR Leave Calendar";
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Leave Period"; Rec."Leave Period")
                {

                }
                field("Calendar Code"; Rec."Calendar Code")
                {
                    ApplicationArea = Basic;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Current Leave Calendar"; Rec."Current Leave Calendar")
                {
                    ApplicationArea = Basic;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                }
                field("Last Modified By"; Rec."Last Modified By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Modified"; Rec."Date Modified")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Saturday Policy")
            {
                Caption = 'Saturday Working Policy';
                field("Saturday is Half Day"; Rec."Saturday is Half Day")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Defines whether working Saturdays in this calendar should default to half-day (0.5) or full-day (1.0).';
                }
            }
            part(Control10; "HR Non Working Days & Dates")
            {
                ApplicationArea = Basic;




            }
            part(Control1102755000; "HR Leave Calendar Lines")
            {
                ApplicationArea = Basic;
                SubPageLink = Code = FIELD("Calendar Code");

            }
        }
    }

    actions
    {
        area(processing)
        {
            action(CreateCalendar)
            {
                ApplicationArea = Basic;
                Caption = 'Create Calendar';
                Image = CalculateCalendar;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Text8000: Text;
                    TEXT0025: Label 'Saturday';
                    TEXT0026: Label 'Sunday';
                begin
                    Rec.TestField("Calendar Code");
                    Rec.TestField("Start Date");
                    Rec.TestField("End Date");

                    if Confirm('Generate Calendar [%1]', false, Rec."Calendar Code") = true then begin
                        Date.Reset;
                        Date.SetRange(Date."Period Type", Date."Period Type"::Date);
                        Date.SetRange(Date."Period Start", Rec."Start Date", Rec."End Date");
                        if Date.Find('-') then begin
                            HRCalendarList.Reset;
                            HRCalendarList.SetRange(Code, Rec."Calendar Code");
                            HRCalendarList.DeleteAll;

                            repeat
                                HRCalendarList.Init;

                                HRCalendarList.Code := Rec."Calendar Code";
                                HRCalendarList.Date := Date."Period Start";
                                ;      // e.g 01-01-15
                                HRCalendarList.Day := Date."Period Name";         // e.g Thursday
                                HRCalendarList."Non Working" := fn_DetermineNonWorking(Date."Period Start");

                                //Saturday - mark as non-working by default
                                if (Date."Period Name" = TEXT0025) and not (HRCalendarList."Non Working") then begin
                                    HRCalendarList."Non Working" := true;
                                    HRCalendarList.Reason := TEXT0025;
                                end;

                                //Sunday - mark as non-working by default
                                if (Date."Period Name" = TEXT0026) and not (HRCalendarList."Non Working") then begin
                                    HRCalendarList."Non Working" := true;
                                    HRCalendarList.Reason := TEXT0026;
                                end;

                                HRCalendarList.Insert;
                            until Date.Next = 0;
                            Message('Process complete');
                        end else begin
                            Error('Invalid Date format');
                        end;
                    end else begin
                        //Creation aborted
                        exit;
                    end;

                end;
            }
            action(MarkSaturdaysWorking)
            {
                ApplicationArea = Basic;
                Caption = 'Mark All Saturdays as Working Days';
                Image = WorkCenter;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Removes Non-Working flag from all Saturdays in this calendar, making them working days.';

                trigger OnAction()
                var
                    CalendarLine: Record "HR Leave Calendar Lines";
                    DayOfWeekNum: Integer;
                    UpdateCount: Integer;
                begin
                    Rec.TestField("Calendar Code");

                    CalendarLine.Reset();
                    CalendarLine.SetRange(Code, Rec."Calendar Code");
                    if not CalendarLine.FindSet() then
                        Error('No calendar lines found for calendar [%1]', Rec."Calendar Code");

                    UpdateCount := 0;
                    repeat
                        DayOfWeekNum := Date2DWY(CalendarLine.Date, 1);
                        if DayOfWeekNum = 6 then
                            UpdateCount += 1;
                    until CalendarLine.Next() = 0;

                    if UpdateCount = 0 then begin
                        Message('No Saturdays found in this calendar.');
                        exit;
                    end;

                    if not Confirm('This will mark %1 Saturdays as working days. Continue?', false, UpdateCount) then
                        exit;

                    CalendarLine.Reset();
                    CalendarLine.SetRange(Code, Rec."Calendar Code");
                    CalendarLine.FindSet();

                    repeat
                        DayOfWeekNum := Date2DWY(CalendarLine.Date, 1);
                        if DayOfWeekNum = 6 then begin
                            CalendarLine."Non Working" := false;
                            if Rec."Saturday is Half Day" then
                                CalendarLine."Is Half Day" := true
                            else
                                CalendarLine."Is Half Day" := false;
                            CalendarLine.Reason := '';
                            CalendarLine.Modify(true); // Skip validation during bulk operation
                        end;
                    until CalendarLine.Next() = 0;

                    Message('%1 Saturdays marked as working days.', UpdateCount);
                    CurrPage.Update(false);
                end;
            }
            action(MarkSaturdaysNonWorking)
            {
                ApplicationArea = Basic;
                Caption = 'Mark All Saturdays as Non-Working';
                Image = Stop;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Marks all Saturdays in this calendar as non-working days.';

                trigger OnAction()
                var
                    CalendarLine: Record "HR Leave Calendar Lines";
                    DayOfWeekNum: Integer;
                    UpdateCount: Integer;
                begin
                    Rec.TestField("Calendar Code");

                    CalendarLine.Reset();
                    CalendarLine.SetRange(Code, Rec."Calendar Code");
                    if not CalendarLine.FindSet() then
                        Error('No calendar lines found for calendar [%1]', Rec."Calendar Code");

                    UpdateCount := 0;
                    repeat
                        DayOfWeekNum := Date2DWY(CalendarLine.Date, 1);
                        if DayOfWeekNum = 6 then
                            UpdateCount += 1;
                    until CalendarLine.Next() = 0;

                    if UpdateCount = 0 then begin
                        Message('No Saturdays found in this calendar.');
                        exit;
                    end;

                    if not Confirm('This will mark %1 Saturdays as non-working. Continue?', false, UpdateCount) then
                        exit;

                    CalendarLine.Reset();
                    CalendarLine.SetRange(Code, Rec."Calendar Code");
                    CalendarLine.FindSet();

                    repeat
                        DayOfWeekNum := Date2DWY(CalendarLine.Date, 1);
                        if DayOfWeekNum = 6 then begin
                            CalendarLine."Non Working" := true;
                            CalendarLine."Is Half Day" := false;
                            CalendarLine.Reason := 'Saturday';
                            CalendarLine.Modify(true); // Skip validation during bulk operation
                        end;
                    until CalendarLine.Next() = 0;

                    Message('%1 Saturdays marked as non-working.', UpdateCount);
                    CurrPage.Update(false);
                end;
            }
            action(MarkSundaysWorking)
            {
                ApplicationArea = Basic;
                Caption = 'Mark All Sundays as Working Days';
                Image = WorkCenter;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Removes Non-Working flag from all Sundays in this calendar, making them working days (for 7-day operations).';

                trigger OnAction()
                var
                    CalendarLine: Record "HR Leave Calendar Lines";
                    DayOfWeekNum: Integer;
                    UpdateCount: Integer;
                begin
                    Rec.TestField("Calendar Code");

                    CalendarLine.Reset();
                    CalendarLine.SetRange(Code, Rec."Calendar Code");
                    if not CalendarLine.FindSet() then
                        Error('No calendar lines found for calendar [%1]', Rec."Calendar Code");

                    UpdateCount := 0;
                    repeat
                        DayOfWeekNum := Date2DWY(CalendarLine.Date, 1);
                        if DayOfWeekNum = 7 then
                            UpdateCount += 1;
                    until CalendarLine.Next() = 0;

                    if UpdateCount = 0 then begin
                        Message('No Sundays found in this calendar.');
                        exit;
                    end;

                    if not Confirm('This will mark %1 Sundays as working days (for 7-day operations). Continue?', false, UpdateCount) then
                        exit;

                    CalendarLine.Reset();
                    CalendarLine.SetRange(Code, Rec."Calendar Code");
                    CalendarLine.FindSet();

                    repeat
                        DayOfWeekNum := Date2DWY(CalendarLine.Date, 1);
                        if DayOfWeekNum = 7 then begin
                            CalendarLine."Non Working" := false;
                            CalendarLine."Is Half Day" := false;
                            CalendarLine.Reason := '';
                            CalendarLine.Modify(true); // Skip validation during bulk operation
                        end;
                    until CalendarLine.Next() = 0;

                    Message('%1 Sundays marked as working days.', UpdateCount);
                    CurrPage.Update(false);
                end;
            }
            action(MarkSundaysNonWorking)
            {
                ApplicationArea = Basic;
                Caption = 'Mark All Sundays as Non-Working';
                Image = Stop;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Marks all Sundays in this calendar as non-working days (default behavior).';

                trigger OnAction()
                var
                    CalendarLine: Record "HR Leave Calendar Lines";
                    DayOfWeekNum: Integer;
                    UpdateCount: Integer;
                begin
                    Rec.TestField("Calendar Code");

                    CalendarLine.Reset();
                    CalendarLine.SetRange(Code, Rec."Calendar Code");
                    if not CalendarLine.FindSet() then
                        Error('No calendar lines found for calendar [%1]', Rec."Calendar Code");

                    UpdateCount := 0;
                    repeat
                        DayOfWeekNum := Date2DWY(CalendarLine.Date, 1);
                        if DayOfWeekNum = 7 then
                            UpdateCount += 1;
                    until CalendarLine.Next() = 0;

                    if UpdateCount = 0 then begin
                        Message('No Sundays found in this calendar.');
                        exit;
                    end;

                    if not Confirm('This will mark %1 Sundays as non-working. Continue?', false, UpdateCount) then
                        exit;

                    CalendarLine.Reset();
                    CalendarLine.SetRange(Code, Rec."Calendar Code");
                    CalendarLine.FindSet();

                    repeat
                        DayOfWeekNum := Date2DWY(CalendarLine.Date, 1);
                        if DayOfWeekNum = 7 then begin
                            CalendarLine."Non Working" := true;
                            CalendarLine."Is Half Day" := false;
                            CalendarLine.Reason := 'Sunday';
                            CalendarLine.Modify(true); // Skip validation during bulk operation
                        end;
                    until CalendarLine.Next() = 0;

                    Message('%1 Sundays marked as non-working.', UpdateCount);
                    CurrPage.Update(false);
                end;
            }
            action(ApplyHalfDayToSaturdays)
            {
                ApplicationArea = Basic;
                Caption = 'Apply Half-Day to All Working Saturdays';
                Image = DateRange;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Marks all working Saturdays (where Non-Working = FALSE) as half-day, based on this calendar Saturday policy.';

                trigger OnAction()
                var
                    CalendarLine: Record "HR Leave Calendar Lines";
                    DayOfWeekNum: Integer;
                    UpdateCount: Integer;
                begin
                    Rec.TestField("Calendar Code");

                    CalendarLine.Reset();
                    CalendarLine.SetRange(Code, Rec."Calendar Code");
                    if not CalendarLine.FindSet() then
                        Error('No calendar lines found for calendar [%1]', Rec."Calendar Code");

                    UpdateCount := 0;
                    repeat
                        DayOfWeekNum := Date2DWY(CalendarLine.Date, 1);
                        if (DayOfWeekNum = 6) and (not CalendarLine."Non Working") then
                            UpdateCount += 1;
                    until CalendarLine.Next() = 0;

                    if UpdateCount = 0 then begin
                        Message('No working Saturdays found in this calendar. Use "Mark All Saturdays as Working Days" first.');
                        exit;
                    end;

                    if not Confirm('This will apply half-day settings to %1 working Saturdays based on this calendar policy. Continue?', false, UpdateCount) then
                        exit;

                    // RE-READ CURRENT RECORD TO GET FRESH VALUE
                    Rec.Get(Rec."Calendar Code");

                    CalendarLine.Reset();
                    CalendarLine.SetRange(Code, Rec."Calendar Code");
                    CalendarLine.SetRange("Non Working", false);
                    if not CalendarLine.FindSet(true) then begin
                        Message('ERROR: No working days found after confirmation. Calendar may have changed.');
                        exit;
                    end;

                    UpdateCount := 0;
                    repeat
                        DayOfWeekNum := Date2DWY(CalendarLine.Date, 1);
                        if DayOfWeekNum = 6 then begin // ONLY SATURDAYS
                            CalendarLine."Is Half Day" := Rec."Saturday is Half Day";
                            if CalendarLine.Modify(true) then
                                UpdateCount += 1;
                        end;
                    until CalendarLine.Next() = 0;

                    if Rec."Saturday is Half Day" then
                        Message('%1 working Saturdays marked as half-day.', UpdateCount)
                    else
                        Message('%1 working Saturdays marked as full-day.', UpdateCount);

                    CurrPage.Update(false);
                end;
            }
        }
    }

    var
        Day: Date;
        Date: Record Date;
        HRCalendarList: Record "HR Leave Calendar Lines";

    local procedure fn_DetermineNonWorking(currDate: Date) isNonWorking: Boolean
    var
        HRNonWorkingDays: Record "HR Non Working Days & Dates";
    begin
        isNonWorking := false;
        HRCalendarList.Reason := '';

        HRNonWorkingDays.Reset;
        if HRNonWorkingDays.Get(currDate) then begin
            isNonWorking := true;
            HRCalendarList.Reason := HRNonWorkingDays.Reason;
        end;
    end;
}

