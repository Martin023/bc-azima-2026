namespace AzimaCBS.AzimaCBS;

page 52185938 "Marketing Teams Header"
{
    ApplicationArea = All;
    Caption = 'Sales Team List';
    PageType = List;
    SourceTable = "Marketing Teams Header";
    UsageCategory = Lists;
    CardPageId = "Sales Teams";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(No; Rec."Payroll No.")
                {
                    ToolTip = 'Specifies the value of the Payroll No field.', Comment = '%';
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.', Comment = '%';
                }
                field(Phone; Rec.Phone)
                {
                    ToolTip = 'Specifies the value of the Phone field.', Comment = '%';
                }
                field("ID Number"; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.', Comment = '%';
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ToolTip = 'Specifies the value of the Branch Code field.', Comment = '%';
                }
                field("Status"; Rec."Status")
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Registered By"; Rec."Registered By")
                {
                    ToolTip = 'Specifies the value of the Registered By field.', Comment = '%';
                }
            }
        }
    }
}
