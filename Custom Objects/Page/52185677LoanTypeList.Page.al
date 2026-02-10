page 52185677 "Loan Type List"
{
    CardPageID = "Staff Loan Types";
    PageType = List;
    SourceTable = "Staff Loan Types";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Description"; Rec."Product Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest rate"; Rec."Interest rate")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("No of Installment"; Rec."No of Installment")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Repayment Method"; Rec."Repayment Method")
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

