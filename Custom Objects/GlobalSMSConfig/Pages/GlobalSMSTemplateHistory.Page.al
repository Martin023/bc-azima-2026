page 52186023 "Global SMS Template History"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Global SMS Template History";
    Caption = 'SMS Template Change History';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(History)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Entry number';
                }
                field("Event Code"; Rec."Event Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Event code for the template';
                }
                field(Action; Rec.Action)
                {
                    ApplicationArea = All;
                    ToolTip = 'Action performed';
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'User who made the change';
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date and time of change';
                }
                field("Old Value"; Rec."Old Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Previous value';
                }
                field("New Value"; Rec."New Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'New value';
                }
                field("Change Reason"; Rec."Change Reason")
                {
                    ApplicationArea = All;
                    ToolTip = 'Reason for change';
                }
            }
        }
    }
}
