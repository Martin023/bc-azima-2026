page 52185773 "Loan Appraisal Parameters"
{
    PageType = List;
    SourceTable = "Loan Application Credit Score";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Code"; Rec."Product Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Parameter Code"; Rec."Parameter Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Score; Rec.Score)
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

