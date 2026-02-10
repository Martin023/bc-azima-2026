page 52185827 "Branch Treasury"
{
    PageType = Card;
    SourceTable = "Branch Treasury Accounts";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Treasury Name"; Rec."Treasury Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bank Balances"; Rec."Bank Balances")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Vault Balance"; Rec."Vault Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Till Balances"; Rec."Till Balances")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Total; Rec.Total)
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

