page 52186705 "Retired Delegate Officials"
{
    CardPageID = "Delegate Officials Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Delegate Officials";
    // SourceTableView = WHERE(Retired = CONST(true));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Electoral Zone"; Rec."Electoral Zone")
                {
                    ApplicationArea = Basic, Suite;
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
                field(Retired; Rec.Retired)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Retirement Date"; Rec."Retirement Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Electoral Zone Name"; Rec."Electoral Zone Name")
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

