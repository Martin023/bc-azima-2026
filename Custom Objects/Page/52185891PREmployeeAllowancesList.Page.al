page 52185891 "PR Employee Allowances List"
{
    CardPageID = "PR Employee Allowances Card";
    PageType = List;
    SourceTable = "PR Employee Allowances";
    ApplicationArea = Basic, Suite;
    

    layout
    {
        area(content)
        {
            repeater(General)
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

