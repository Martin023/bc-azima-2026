page 52186069 "Loan History"
{
    Editable = false;
    PageType = List;
    SourceTable = "Loan History";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Outanding Bill"; Rec."Outanding Bill")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Loan Issued Date"; Rec."Loan Issued Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Expiry Date"; Rec."Loan Expiry Date")
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

