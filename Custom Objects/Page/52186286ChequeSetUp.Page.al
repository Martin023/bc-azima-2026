page 52186286 "Cheque Set Up"
{
    PageType = List;
    SourceTable = "Cheque Set Up";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque Code"; Rec."Cheque Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Number Of Leaf"; Rec."Number Of Leaf")
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

