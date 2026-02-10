namespace MNS.MNS;

page 52186498 "Contract Templates List"
{
    ApplicationArea = All;
    Caption = 'Contract Templates List';
    PageType = List;
    SourceTable = "Contract Templates";
    UsageCategory = Lists;
    CardPageId = "Contract Templates Header";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Template No."; Rec."Template No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Template No. field.', Comment = '%';
                }
                field("Template Type"; Rec."Template Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Template Type field.', Comment = '%';
                }
                field("Template Description"; Rec."Template Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Template Description field.', Comment = '%';
                }
            }
        }
    }
}
