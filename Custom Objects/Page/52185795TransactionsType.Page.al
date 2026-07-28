page 52185795 "Transactions Type"
{
    SourceTable = "Transaction Types";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Default Mode"; Rec."Default Mode")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Exclude Salary Loan Deductions"; Rec."Exclude Salary Loan Deductions")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Exclude STO Deductions"; Rec."Exclude STO Deductions")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sal. Deposit Deduction"; Rec."Sal. Deposit Deduction")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Salary Income Types"; Rec."Salary Income Type")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Control1; "Transaction Charges")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Transaction Type" = FIELD(Code);
            }
        }
    }

    actions
    {
    }
}

