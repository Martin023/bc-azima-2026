namespace MNS.MNS;

page 52186607 "Member Sub-Status Tracker"
{
    ApplicationArea = All;
    Caption = 'Member Sub-Status Tracker';
    PageType = List;
    SourceTable = "Member Sub-Status Tracker";
    UsageCategory = Lists;
    Editable = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Sub-Status"; Rec."Sub-Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sub-Status field.', Comment = '%';
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Modified By field.', Comment = '%';
                }
                field("Date Modified"; Rec."Date Modified")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Modified field.', Comment = '%';
                }
                field("Current Subflag"; Rec."Current Subflag")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current Subflag field.', Comment = '%';
                }
            }
        }
    }
}
