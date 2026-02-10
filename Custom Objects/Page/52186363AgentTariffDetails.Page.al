page 52186363 "Agent Tariff Details"
{
    PageType = ListPart;
    SourceTable = "Agent Tariff Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loans Category-SASRA"; Rec."Loans Category-SASRA")
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

