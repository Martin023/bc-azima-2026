page 52186411 "DCS Parameter Matrix Appl."
{
    PageType = List;
    SourceTable = "DCS Parameter Matrix Appl.";
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
        area(creation)
        {
            group(Action23)
            {
                action("Product Charges")
                {
                    ApplicationArea = Basic, Suite;
                    Image = SetupPayment;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Product Charge Appl.";
                }
                action("Appraisal Parameters")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Evaluate;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "DCS Product Parameter Matrix";
                }
                action("Related Product")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Relatives;
                    Promoted = true;
                    RunObject = Page "Related Product Appl. List";
                }
            }
        }
        area(navigation)
        {
            action("Product Application Document")
            {
                ApplicationArea = Basic, Suite;
                Image = Documents;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Product Application Document";
            }
        }
    }
}

