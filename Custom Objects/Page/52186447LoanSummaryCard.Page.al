page 52186447 "Loan Summary Card"
{
    PageType = Card;
    SourceTable = "DCS Loan Summary";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Amount"; Rec."Loan Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Paid"; Rec."Total Paid")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Expected Repayment"; Rec."Expected Repayment")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No"; Rec."Account No")
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

