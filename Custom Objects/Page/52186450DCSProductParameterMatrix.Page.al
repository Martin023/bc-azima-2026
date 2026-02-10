page 52186450 "DCS Product Parameter Matrix"
{
    PageType = List;
    SourceTable = "DCS Parameter Matrix";
    ApplicationArea = All;
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
                field("Parameter Code"; Rec."Parameter Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Parameter Desc"; Rec."Parameter Desc")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Parameter Base"; Rec."Parameter Base")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Parameter Base Unit"; Rec."Parameter Base Unit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Computation Method"; Rec."Computation Method")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Formula; Rec.Formula)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Formula"; Rec."Date Formula")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Factor; Rec.Factor)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contributes To Score As"; Rec."Contributes To Score As")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Application Priority"; Rec."Application Priority")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Success Default Value"; Rec."Success Default Value")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Parameter Scope"; Rec."Parameter Scope")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Failure Response"; Rec."Failure Response")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Fall Back Parameter"; Rec."Fall Back Parameter")
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

