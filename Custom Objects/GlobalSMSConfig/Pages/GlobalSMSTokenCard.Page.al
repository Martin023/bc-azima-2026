page 52186021 "Global SMS Token Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Global SMS Token Registry";
    Caption = 'SMS Token';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(Token; Rec.Token)
                {
                    ApplicationArea = All;
                    ToolTip = 'Token name (auto-formatted with square brackets and uppercase)';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description of what this token represents';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Token category for organization';
                }
                field("Data Type"; Rec."Data Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Expected data type for this token';
                }
                field("Sample Value"; Rec."Sample Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sample value used in message preview';
                }
            }

            group(Metadata)
            {
                Caption = 'Metadata';

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
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Last Modified By"; Rec."Last Modified By")
                {
                    ApplicationArea = All;
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
