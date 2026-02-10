page 52185887 "BBF Entitlement2"
{
    PageType = List;
    SourceTable = "BBF Entitlement";
    ApplicationArea = Basic, Suite;
    // UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Relationship Type";Rec."Relationship Type")
                {

                }
                field("Start Date";Rec."Start Date")
                {

                }
                field("End Date";Rec."End Date")
                {
                    
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

