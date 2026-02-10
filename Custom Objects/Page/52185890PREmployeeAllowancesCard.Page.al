page 52185890 "PR Employee Allowances Card"
{
    PageType = Card;
    SourceTable = "PR Employee Allowances";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Job Grade"; Rec."Job Grade")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
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

