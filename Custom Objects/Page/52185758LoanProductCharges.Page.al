page 52185758 "Loan Product Charges"
{
    PageType = List;
    SourceTable = "Loan Product Charges";
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
                field("Use Percentage"; Rec."Use Percentage")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Effect Excise Duty"; Rec."Effect Excise Duty")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Product Code"; Rec."Product Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Charge Type"; Rec."Charge Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Charging Option"; Rec."Charging Option")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Charges G_L Account"; Rec."Charges G_L Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Minimum; Rec.Minimum)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Maximum; Rec.Maximum)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Additional Charge %"; Rec."Additional Charge %")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Prorate; Rec.Prorate)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Staggered Charge Code"; Rec."Staggered Charge Code")
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

