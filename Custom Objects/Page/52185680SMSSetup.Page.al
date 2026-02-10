page 52185680 "SMS Setup"
{
    PageType = Card;
    SourceTable = "SMS Setup";
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field("Subscription Type"; Rec."Subscription Type")
                {
                    ApplicationArea = Basic;
                }
                field(SMS; Rec.SMS)
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Sms Options")
            {
                field("Member Creation"; Rec."Member Creation")
                {
                    ApplicationArea = Basic;
                }
                field("Deposit Confirmation"; Rec."Deposit Confirmation")
                {
                    ApplicationArea = Basic;
                }
                field("Cash Withdrawal"; Rec."Cash Withdrawal")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Application"; Rec."Loan Application")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Guarantors"; Rec."Loan Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Posted"; Rec."Loan Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Loan defaulted"; Rec."Loan defaulted")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Posted"; Rec."Salary Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Deposit Maturity"; Rec."Fixed Deposit Maturity")
                {
                    ApplicationArea = Basic;
                }
                field("InterAccount Transfer"; Rec."InterAccount Transfer")
                {
                    ApplicationArea = Basic;
                }
                field("Account Status"; Rec."Account Status")
                {
                    ApplicationArea = Basic;
                }
                field("Status Order Creation"; Rec."Status Order Creation")
                {
                    ApplicationArea = Basic;
                }
                field("EFT Effected"; Rec."EFT Effected")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Application Failed"; Rec."ATM Application Failed")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Collection"; Rec."ATM Collection")
                {
                    ApplicationArea = Basic;
                }
                field(MSACCO; Rec.MSACCO)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

