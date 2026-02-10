page 52187379 "Rejected Conf & Meeting - Card"
{
    ApplicationArea = All;
    Caption = 'Rejected Conf & Meeting - Card';
    PageType = Card;
    SourceTable = "Conference & Meeting Rooms-T";
    DeleteAllowed = False;
    Editable = False;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE(Status = CONST(Rejected)); 
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }
                field("Date of Meeting/Function"; Rec."Date of Meeting/Function")
                {
                    ToolTip = 'Specifies the value of the Date of Meeting/Function field.';
                }
                field("Type of Meeting/Function"; Rec."Type of Meeting/Function")
                {
                    ToolTip = 'Specifies the value of the Type of Meeting/Function field.';
                }
                field("Meeting Room"; Rec."Meeting Room")
                {
                    ToolTip = 'Specifies the value of the Meeting Room field.';
                }
                field("Meeting Room Name"; Rec."Meeting Room Name")
                {
                    ToolTip = 'Specifies the value of the Meeting Room Name field.';
                    Editable = false;
                }
                field("Department/Client/Company Name"; Rec."Department/Client/Company Name")
                {
                    ToolTip = 'Specifies the value of the Department/Client/Company Name field.';
                }
                field("Details of staff/client/company"; Rec."Staff/client/company Details")
                {
                    ToolTip = 'Specifies the value of the Details of staff/client/company requesting field.';
                }
                field("Start Time of Meeting/Function"; Rec."Start Time of Meeting/Function")
                {
                    ToolTip = 'Specifies the value of the Start Time of Meeting/Function field.';
                }
                field("Duration of Meeting/Fucntion"; Rec."Duration of Meeting/Fucntion")
                {
                    ToolTip = 'Specifies the value of the Duration of Meeting/Fucntion field.';
                }
                field("No. of Attendees"; Rec."No. of Attendees")
                {
                    ToolTip = 'Specifies the value of the No. of Attendees field.';
                }
                field("Special Requirements"; Rec."Special Requirements")
                {
                    ToolTip = 'Specifies the value of the Special Requirements field.';
                }
                field("Status of Booking"; Rec."Status of the Booking")
                {
                    ToolTip = 'Specifies the value of the Status of Booking field.';
                }
                field("Status"; Rec.Status)
                {
                    Editable = False;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
            }
        }

    }
    actions
    {
        area(creation)
        {
            action("Send For Approval")
            {
                Caption = 'Send For Approval';
                trigger OnAction()
                begin
                    Rec."Status" := Rec."Status"::Pending;
                    Rec.MODIFY;
                    MESSAGE('Request Sent for Approval');
                end;
            }
            action("Defer")
            {
                Caption = 'Cance Appliation';
                trigger OnAction()
                begin
                    Rec."Status" := Rec."Status"::Deffered;
                    Rec.MODIFY;
                    MESSAGE('Deffered');
                end;
            }
            action("Reject Application")
            {
                Caption = 'Reject Application';
                trigger OnAction()
                begin
                    Rec."Status" := Rec."Status"::Rejected;
                    Rec.MODIFY;
                    MESSAGE('Rejected');
                end;
            }
        }
    }
}

