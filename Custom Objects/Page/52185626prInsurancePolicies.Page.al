page 52185626 "prInsurance Policies"
{
    PageType = List;
    SourceTable = prInsurancePolicies;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Policy Number"; Rec."Policy Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Insurance Code"; Rec."Insurance Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Deduct premium"; Rec."Deduct premium")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(balance; Rec.balance)
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

