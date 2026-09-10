namespace AZIMA.AZIMA;

page 52186780 "CRB log Buffer"
{
    ApplicationArea = All;
    Caption = 'CRB log Buffer';
    PageType = List;
    SourceTable = "CRB Log Buffer";
    UsageCategory = Lists;
    Editable = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Credit Ledger Entry No."; Rec."Credit Ledger Entry No.")
                {
                    ToolTip = 'Specifies the value of the Credit Ledger Entry No. field.', Comment = '%';
                }
                field("Is Processed?"; Rec."Is Processed?")
                {
                    ToolTip = 'Specifies the value of the Is Processed? field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
            }
        }
    }
}
