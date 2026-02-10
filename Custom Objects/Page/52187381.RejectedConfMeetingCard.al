page 52187381 "Rejected Conf & Meeting - List"
{
    ApplicationArea = All;
    Caption = 'Declined Conf & Meeting - List';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Conference & Meeting Rooms-T";
    DeleteAllowed = False;
    Editable = False;
    InsertAllowed = false;
    ModifyAllowed = false;
    CardPageId = "Rejected Conf & Meeting - Card";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE(Status = CONST(Rejected)); 
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
                field("Meeting/Function Date"; Rec."Date of Meeting/Function")
                {
                    ToolTip = 'Specifies the value of the Date of Meeting/Function field.';
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
                field("Status of Booking"; Rec."Status of the Booking")
                {
                    ToolTip = 'Specifies the value of the Status of Booking field.';
                }
                
            }
        }
    }
}
