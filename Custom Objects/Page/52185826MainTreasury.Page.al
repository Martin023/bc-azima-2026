page 52185826 "Main Treasury"
{
    PageType = Card;
    SourceTable = "Main Treasury Account";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Bank Balances"; Rec."Bank Balances")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Treasury Name"; Rec."Treasury Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Vault Balances"; Rec."Vault Balances")
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
            group("Treasury View")
            {
                Caption = 'Treasury View';
                chartpart(TRS00001; TRS00001)
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

