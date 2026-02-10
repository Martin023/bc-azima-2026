page 52187377 "Closed Conf & Meeting - List"
{
    ApplicationArea = All;
    Caption = 'Closed Conf & Meeting - List';
    PageType = List;
    SourceTable = "Conference & Meeting Rooms-T";
    UsageCategory = Lists;
    CardPageId = "Closed Conf & Meetings - Card";
    DeleteAllowed = False;
    Editable = False;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE("Status of the Booking" = CONST(Closed)); 
    
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
       
                // field("Type of Meeting/Function"; Rec."Type of Meeting/Function")
                // {
                //     ToolTip = 'Specifies the value of the Type of Meeting/Function field.';
                // }
            }
        }
    }
}


