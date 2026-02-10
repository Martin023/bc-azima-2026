page 52185742 "Fixed Deposit Notification Lis"
{
    PageType = List;
    SourceTable = "Fixed Deposit Notification Lis";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User Type"; Rec."User Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Fixed Deposit Type"; Rec."Fixed Deposit Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Notification Type"; Rec."Notification Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Notification Period"; Rec."Notification Period")
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

