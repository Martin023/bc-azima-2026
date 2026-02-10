namespace MNS.MNS;

page 52185583 "Admin Booking Planner"
{
    Caption = 'Admin Booking Planner';
    PageType = List;
    SourceTable = "Admin Bookings Planner";
    UsageCategory = Lists;
    ApplicationArea = All;
    Editable = False;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("Booking No."; Rec."Booking No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                // field("Calendar Code"; Rec."Calendar Code")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Calendar Code field.';
                // }
                field("Event Date"; Rec."Event Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Event Date field.';
                    Caption = 'Event Start Date';
                }
                field("Event End Date"; Rec."Event End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Event End Date field.';
                    Caption = 'Event End Date';
                }
                field("Meeting Room"; Rec."Meeting Room")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Meeting Room field.';
                }
                field("No. of Participants"; Rec."No. of Atendees")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Participants field.';
                }
                field("Special Requirements"; Rec."Special Requirements")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Special Requirements field.';
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Time field.';
                }
                field("Meeting Duration"; Rec."Meeting Duration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Meeting Duration field.';
                }
            }
        }
    }
}
