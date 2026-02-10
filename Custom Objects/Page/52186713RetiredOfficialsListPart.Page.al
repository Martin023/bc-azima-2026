page 52186713 "Retired Officials List Part"
{
    PageType = ListPart;
    SourceTable = "Delegate Officials";
    SourceTableView = WHERE(Retired = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Electoral Zone"; Rec."Electoral Zone")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Member Number"; Rec."Member Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delegate Official Name"; Rec."Delegate Official Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Registered By"; Rec."Registered By")
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

