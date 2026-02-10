page 52185757 "Loan Charges"
{
    PageType = List;
    SourceTable = "Loan Charges";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Charge Code"; Rec."Charge Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Charge Description"; Rec."Charge Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Charge Amount"; Rec."Charge Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Charge Method"; Rec."Charge Method")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Charge Type"; Rec."Charge Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Charging Option"; Rec."Charging Option")
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

