namespace Azima.Azima;

page 52185440 "Dividend Header List"
{
    ApplicationArea = All;
    Caption = 'Dividend Header List';
    PageType = List;
    SourceTable = "Dividend Header";
    UsageCategory = Lists;
    CardPageID = "Dividend Header Card";
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Year field.', Comment = '%';
                }
                field(CreatedOn; Rec."Created On")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CreatedOn field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
            }
        }
    }
}
