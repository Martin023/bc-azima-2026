page 52186020 Others
{
    PageType = ListPart;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    SourceTable = Contracts;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                // field("Review Interval"; Rec."Review Interval")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Type Of Service"; Rec."Type Of Service")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Nature Of Service"; Rec."Nature Of Service")
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

