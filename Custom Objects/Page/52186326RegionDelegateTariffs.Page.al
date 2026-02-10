page 52186326 "Region Delegate Tariffs"
{
    //DeleteAllowed = false;
    PageType = List;
    SourceTable = "Region Delegates Tariff";
    UsageCategory = Lists;
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Region Code"; Rec."Region Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payment Frequency"; Rec."Payment Frequency")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(CalculationMethod; Rec.CalculationMethod)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Rate Per KM"; Rec."Rate Per KM")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Maximum No Paid"; Rec."Maximum No Paid")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Type"; Rec."Transaction Type")
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

