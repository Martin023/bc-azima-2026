page 52186194 "Charges Card"
{
    PageType = Card;
    SourceTable = Charges;

    layout
    {
        area(content)
        {
            group(Control1102755000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Vatable; Rec.Vatable)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Charge Once"; Rec."Charge Once")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("IsService Charge"; Rec."IsService Charge")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("VAT Account"; Rec."VAT Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Uses Rates"; Rec."Uses Rates")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is Rental"; Rec."Is Rent")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("VAT Percentage(%)"; Rec."VAT Percentage(%)")
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

