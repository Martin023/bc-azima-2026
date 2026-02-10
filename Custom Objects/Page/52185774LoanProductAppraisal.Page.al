page 52185774 "Loan Product Appraisal"
{
    PageType = List;
    SourceTable = "Loan Product Parameters";
    ApplicationArea = Basic, Suite;

    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Product Code"; Rec."Loan Product Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Parameter Base"; Rec."Parameter Base")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Computation Method"; Rec."Computation Method")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Factor; Rec.Factor)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Application Priority"; Rec."Application Priority")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Formula; Rec.Formula)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Parameter Base Unit"; Rec."Parameter Base Unit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Success Default Value"; Rec."Success Default Value")
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

