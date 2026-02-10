page 52186466 "General SMS Header List"
{
    ApplicationArea = All;
    Caption = 'General SMS Header List';
    PageType = List;
    SourceTable = "General SMS Header";
    CardPageId = "General SMS Header Card";
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
                field(SMS; Rec.SMS)
                {
                    ToolTip = 'Specifies the value of the Send Email field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }

            }
        }
    }
}
