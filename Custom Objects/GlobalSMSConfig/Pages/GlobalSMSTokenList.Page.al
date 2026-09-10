page 52186019 "Global SMS Token List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Global SMS Token Registry";
    Caption = 'Global SMS Tokens';
    CardPageId = "Global SMS Token Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Tokens)
            {
                field(Token; Rec.Token)
                {
                    ApplicationArea = All;
                    ToolTip = 'Token name with square brackets';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description of what this token represents';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Token category';
                }
                field("Data Type"; Rec."Data Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Expected data type';
                }
                field("Sample Value"; Rec."Sample Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sample value for preview';
                }
                field("System Defined"; Rec."System Defined")
                {
                    ApplicationArea = All;
                    ToolTip = 'Whether this token was seeded by the system';
                }
                field("Usage Count"; Rec."Usage Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Number of templates using this token';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(InstallDefaultTokens)
            {
                ApplicationArea = All;
                Caption = 'Install Default Tokens';
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Install system default tokens';

                trigger OnAction()
                var
                    Installer: Codeunit "Global SMS Installer";
                begin
                    if Confirm('Install default tokens?', true) then
                        Installer.InstallDefaultTokens();
                end;
            }
        }
    }
}
