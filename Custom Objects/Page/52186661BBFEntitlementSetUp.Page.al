page 52186661 "BBF Entitlement SetUp"
{
    PageType = List;
    SourceTable = "BBF Entitlement SetUp";
    ApplicationArea = Basic, Suite;
    usagecategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                // field("BBF Code"; Rec."BBF Code")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Amount"; Rec."Member Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sacco Amount"; Rec."Sacco Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sacco G/L"; Rec."Sacco G/L")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sacco G/L Name"; Rec."Sacco G/L Name")
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

