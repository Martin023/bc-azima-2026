page 52185772 "Loan Collaterals1"
{
    PageType = List;
    SourceTable = "Loan Collateral";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Collateral Registration"; Rec."Collateral Registration")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Collateral Type"; Rec."Collateral Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Collateral Total Value"; Rec."Collateral Total Value")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Collateral Multiplier"; Rec."Collateral Multiplier")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Collateral Value"; Rec."Collateral Value")
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

