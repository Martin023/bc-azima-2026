page 52186443 "DCS Member Transaction List"
{
    PageType = List;
    SourceTable = "DCS Member Transaction";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Update"; Rec."Last Update")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Basic; Rec.Basic)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Gross Salary"; Rec."Gross Salary")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Earnings; Rec.Earnings)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Deductions; Rec.Deductions)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Net Pay"; Rec."Net Pay")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Balance"; Rec."Loan Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Expected Loan Repayment"; Rec."Expected Loan Repayment")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Repayment Date"; Rec."Last Repayment Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Loan Repayments"; Rec."Total Loan Repayments")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Number of Active Loans"; Rec."Number of Active Loans")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date of Join"; Rec."Date of Join")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Loan; Rec.Loan)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Default Status"; Rec."Default Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Standing Orders"; Rec."Standing Orders")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Direct Debits"; Rec."Direct Debits")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Deposits Contribution"; Rec."Deposits Contribution")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Repayment Frequency"; Rec."Loan Repayment Frequency")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loans Borrowing History"; Rec."Loans Borrowing History")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Deposit Guaranteed"; Rec."Deposit Guaranteed")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Share Capital"; Rec."Share Capital")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Defaulter; Rec.Defaulter)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Deposit Date"; Rec."Last Deposit Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("MSACCO Trans Ferquency"; Rec."MSACCO Trans Ferquency")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("MSACCO Last Trans Date"; Rec."MSACCO Last Trans Date")
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

