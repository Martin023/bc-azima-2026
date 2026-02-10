page 52186410 "Loan Product Charge Appl."
{
    PageType = List;
    SourceTable = "Loan Product Charge Appl.";
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
                field("Use Percentage"; Rec."Use Percentage")
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
                field("Additional Conditional Charge"; Rec."Additional Conditional Charge")
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

