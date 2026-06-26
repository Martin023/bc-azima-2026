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
                field("Exclude Salary Deductions"; Rec."Exclude Salary Deductions")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sal. Deposit Deduction"; Rec."Sal. Deposit Deduction")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Commission Type"; Rec."Commission Type")
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

