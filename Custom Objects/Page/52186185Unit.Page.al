page 52186185 Unit
{
    PageType = List;
    SourceTable = Unit;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Unit Code"; Rec."Unit Code")
                {
                    Caption = 'Office No.';
                    ApplicationArea = Basic, Suite;
                }
                field("Unit Name"; Rec."Unit Name")
                {
                    Caption = 'Office Name';
                    ApplicationArea = Basic, Suite;
                }
                field("Unit Type"; Rec."Unit Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Unit Type Name"; Rec."Unit Type Name")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }
                // field("Meter No."; Rec."Meter No.")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Unit Sub Type"; Rec."Unit Sub Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Unit Sub Type Name"; Rec."Unit Sub Type Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

