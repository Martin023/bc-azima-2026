table 52185754 "Admin Bookings Planner"
{
    Caption = 'Admin Bookings Planner';
    DataClassification = ToBeClassified;
    LookupPageId = "Admin Booking Planner";
    DrillDownPageId = "Admin Booking Planner";

    fields
    {
        field(1; "Booking No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Calendar Code"; Code[50])
        {
            Caption = 'Calendar Code';
            trigger OnValidate()
            begin
                //Prevent Changing Calendar code once ledger entries have been posted into HR Leave Ledger
                // TestNoEntriesExist_PrevRec(FieldCaption("Calendar Code"));

                if "Calendar Code" <> '' then
                    HRCalendarList.Reset;
                HRCalendarList.SetRange(HRCalendarList.Code, xRec."Calendar Code");
                if HRCalendarList.Find('-') then HRCalendarList.DeleteAll;

                Validate("Event Date");
            end;
        }
        field(3; "Meeting Room"; Code[100])
        {
            Caption = 'Meeting Room';
        }
        field(4; "Start Time"; Time)
        {
            Caption = 'Start Time';
        }
        field(5; "Meeting Duration"; Duration)
        {
            Caption = 'Meeting Duration';
        }
        field(6; "No. of Atendees"; Integer)
        {
            Caption = 'No. of Participants';
        }
        field(7; "Special Requirements"; Text[250])
        {
            Caption = 'Special Requirements';
        }
        field(8; "Event Date"; Date)
        {
            Caption = 'Event Date';
        }
        field(9; "Meeting Type"; Text[100])
        {
            Caption = 'Meeting Type';
        }
        field(10; "Event End Date"; Date)
        {
            Caption = 'Event End Date';
        }
    }
    keys
    {
        key(PK; "Booking No.")
        {
            Clustered = true;
        }
    }
    var
        HRCalendarList: Record "HR Leave Calendar Lines";
        //HRLeaveLedger: Record "HR Leave Ledger Entries";
}
