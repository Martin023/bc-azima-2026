page 52186446 "DCS Loan Summary List"
{
    PageType = List;
    SourceTable = "DCS Loan Summary";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No"; Rec."Account No")
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
                field("Last Update Date"; Rec."Last Update Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Source; Rec.Source)
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

