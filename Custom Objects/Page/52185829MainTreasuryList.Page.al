page 52185829 "Main Treasury List"
{
    CardPageID = "Main Treasury";
    Editable = false;
    PageType = List;
    SourceTable = "Main Treasury Account";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Treasury Name"; Rec."Treasury Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bank Balances"; Rec."Bank Balances")
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
        }
    }

    actions
    {
    }
}

