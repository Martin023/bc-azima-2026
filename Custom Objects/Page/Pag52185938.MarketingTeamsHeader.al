namespace AzimaCBS.AzimaCBS;

page 52185938 "Marketing Teams Header"
{
    ApplicationArea = All;
    Caption = 'Marketing Teams Header';
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
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field("No. of Members"; Rec."No. of Members")
                {
                    ToolTip = 'Specifies the value of the No. of Members field.', Comment = '%';
                }
            }
        }
    }
}
