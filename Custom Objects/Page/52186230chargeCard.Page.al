page 52186230 "charge Card"
{
    PageType = Card;
    SourceTable = Charges;

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
                field(Name; Rec.Name)
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
                field("VAT Percentage(%)"; Rec."VAT Percentage(%)")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("VAT Account"; Rec."VAT Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Uses Rates"; Rec."Uses Rates")
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
                field("Direct Post"; Rec."Direct Post")
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
                field("Legal Fees"; Rec."Legal Fees")
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

