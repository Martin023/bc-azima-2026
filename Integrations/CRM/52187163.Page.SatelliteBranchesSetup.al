page 52187163 "Satellite Branches Setup"
{
    ApplicationArea = All;
    Caption = 'Satellite Branches Setup';
    PageType = List;
    SourceTable = "Satellite Branches Setup";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Satellite Branch Code"; Rec."Satellite Branch Code")
                {
                    ToolTip = 'Specifies the value of the Satellite Branch Code field.', Comment = '%';
                }
                field("Satellite Branch"; Rec."Satellite Branch")
                {
                    ToolTip = 'Specifies the value of the Satellite Branch field.', Comment = '%';
                }
                field("Main Branch Code"; Rec."Main Branch Code")
                {
                    ToolTip = 'Specifies the value of the Main Branch Code field.', Comment = '%';
                }
                field("Main Branch"; Rec."Main Branch")
                {
                    ToolTip = 'Specifies the value of the Main Branch field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field("Updated By"; Rec."Updated By")
                {
                    ToolTip = 'Specifies the value of the Updated By field.', Comment = '%';
                }
            }
        }
    }
}
