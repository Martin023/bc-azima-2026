page 52186731 "SMS Alert Header List"
{
    ApplicationArea = All;
    Caption = 'SMS Alert Header List';
    PageType = List;
    SourceTable = "SMS Alerts Header";
    CardPageId = "SMS Alerts Header Card";
    UsageCategory = Lists;
    SourceTableView = where(Status = filter(Open | Pending));
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Responsible Officer"; Rec."Responsible Officer")
                {
                    Editable = false;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    Editable = false;
                }
                field("Created At"; Rec."Created At")
                {
                    ToolTip = 'Specifies the value of the Created At field.';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Posted At"; Rec."Posted At")
                {
                    ToolTip = 'Specifies the value of the Posted At field.';
                }
                field("Posted By"; Rec."Posted By")
                {
                    ToolTip = 'Specifies the value of the Posted By field.';
                }
                field("Send SMS"; Rec."Send SMS")
                {
                    ToolTip = 'Specifies the value of the Send SMS field.';
                }
                field("Send Email"; Rec."Send Email")
                {
                    ToolTip = 'Specifies the value of the Send Email field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Notice Type"; Rec."Notice Type")
                {
                    ToolTip = 'Specifies the value of the Notice Type field.';
                }

                field("Include Attached Loans"; Rec."Include Attached Loans")
                {
                    ToolTip = 'Specifies the value of the Include Attached Loans field.';
                }
            }
        }
    }
}
