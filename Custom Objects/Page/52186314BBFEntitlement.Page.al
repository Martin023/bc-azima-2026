page 52186314 "BBF Entitlement"
{
    PageType = List;
    SourceTable = "BBF Entitlement";
    ApplicationArea = Basic, Suite;
    // usagecategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Relationship Type";Rec."Relationship Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Start Date";Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("End Date";Rec."End Date")
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

