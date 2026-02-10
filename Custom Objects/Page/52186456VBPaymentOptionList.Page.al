page 52186456 "VB Payment Option List"
{
    PageType = List;
    SourceTable = "VB Payment Option";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Repayment Code"; Rec."Repayment Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Repayment Option"; Rec."Repayment Option")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Computation"; Rec."Interest Computation")
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

