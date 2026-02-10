namespace MNS.MNS;

page 52186481 "Admin Booking Calendar List"
{
    Caption = 'Admin Booking Calendar List';
    PageType = List;
    SourceTable = "Admin Booking Calendar";
    CardPageId = "Admin Booking Calendar Card";
    DeleteAllowed = false;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                
                field("Calendar Code"; Rec."Calendar Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Calendar Code field.', Comment = '%';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.', Comment = '%';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Created field.', Comment = '%';
                }
                field("Current Leave Calendar"; Rec."Current Calendar")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current Leave Calendar field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                    Caption = ' Booking Description';
                }
            }
        }
    }
}
