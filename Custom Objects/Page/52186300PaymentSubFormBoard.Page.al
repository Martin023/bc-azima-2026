page 52186300 "Payment Sub Form Board"
{
    PageType = ListPart;
    SourceTable = "Payment Line Board";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("External DOC No"; Rec."External DOC No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payment Types"; Rec."Payment Types")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Destination Code"; Rec."Destination Code")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("No of Days"; Rec."No of Days")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Daily Rate(Amount)"; Rec."Daily Rate(Amount)")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = true;
                // }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Savings Account"; Rec."Savings Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }

                // field("Earnings & Deductions"; Rec."Earnings & Deductions")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = true;
                //     trigger OnDrillDown()
                //     begin
                //         BoardTransactions.reset;
                //         BoardTransactions.setrange("Payment No.", rec."Document No");
                //         BoardTransactions.setrange("No.", Rec."Member No.");
                //         Page.RunModal(page::"prBoard Payment", BoardTransactions);
                //         rec.CalcFields("Earnings & Deductions");
                //     end;
                // }
                // field("Other Deductions"; Rec."Other Deductions")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = true;
                //     trigger OnDrillDown()
                //     begin
                //         BoardDeductions.reset;
                //         BoardDeductions.setrange("Document No", rec."Document No");
                //         BoardDeductions.setrange("Member No", Rec."Member No.");
                //         Page.RunModal(page::"Board Payroll Deductions", BoardDeductions);
                //     end;
                // }

                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("W/Tax Amount"; Rec."W/Tax Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("SMS Sent"; Rec."SMS Sent")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
    var
        BoardTransactions: record "PR Board Transactions";
        BoardDeductions: record "Board Payroll Deductions";
}

