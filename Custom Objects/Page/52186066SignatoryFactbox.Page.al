page 52186066 "Signatory Factbox"
{
    PageType = List;
    SourceTable = "Account Signatories";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    Caption = 'Signatory Factbox';

    layout
    {
        area(content)
        {
            repeater(Control6)
            {
                ShowCaption = false;
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Signatory; Rec.Signatory)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Must Sign"; Rec."Must Sign")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Must be Present"; Rec."Must be Present")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
}

