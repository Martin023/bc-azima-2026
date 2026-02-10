page 52187072 "MNS Conf & Meetings Appl List"
{
    ApplicationArea = All;
    Caption = 'MNS Conf & Meeting Rooms Appl List';
    PageType = List;
    SourceTable = "Conference & Meeting Rooms-T";
    UsageCategory = Lists;
    CardPageID = "Conference Room Booking Card";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }
                field("Type of Meeting/Function"; Rec."Type of Meeting/Function")
                {
                    ToolTip = 'Specifies the value of the Type of Meeting/Function field.';
                }
                field("Meeting/Function Date"; Rec."Date of Meeting/Function")
                {
                    ToolTip = 'Specifies the value of the Date of Meeting/Function field.';
                }
                field("Meeting Room"; Rec."Meeting Room")
                {
                    ToolTip = 'Specifies the value of the Meeting Room field.';
                }
                field("Meeting Room Name"; Rec."Meeting Room Name")
                {
                    ToolTip = 'Specifies the value of the Meeting Room Name field.';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ToolTip = 'Specifies the value of the Staff Name field.';
                }
                field(Department; Rec."Department")
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("Department/Client/Company Name"; Rec."Department/Client/Company Name")
                {
                    ToolTip = 'Specifies the value of the Department/Client/Company Name field.';
                }
                field("Staff/client/company Details"; Rec."Staff/client/company Details")
                {
                    ToolTip = 'Specifies the value of the Details of staff/client/company requesting field.';
                }
                field("Duration of Meeting/Fucntion"; Rec."Duration of Meeting/Fucntion")
                {
                    ToolTip = 'Specifies the value of the Duration of Meeting/Fucntion field.';
                }
                field("No. of Attendees"; Rec."No. of Attendees")
                {
                    ToolTip = 'Specifies the value of the No. of Attendees field.';
                }
                field("Status"; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
                field("Status of Booking"; Rec."Status of the Booking")
                {
                    ToolTip = 'Specifies the value of the Status of Booking field.';
                    Editable = false;
                }
                field("Date Created"; Rec."Created at")
                {
                    ToolTip = 'Specifies the value of the Date Created field.';
                    Editable = false;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then begin
            UserSetup.TestField("Responsibility Centre");
            Rec.SetFilter("Current Department", UserSetup."Responsibility Centre");
        end else
            Error('You must be set up in user setup');
    end;
}
