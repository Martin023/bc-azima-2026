page 52185793 "SMS Subscriptions"
{
    PageType = List;
    SourceTable = "Notification Subscription";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(AccountNo; Rec.AccountNo)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("SMS Subscription"; Rec."SMS Subscription")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Email Subscription"; Rec."Email Subscription")
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

