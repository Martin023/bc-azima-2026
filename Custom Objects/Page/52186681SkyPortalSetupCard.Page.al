page 52186681 "Sky Portal Setup Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Sky Portal Setup";

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
                field("Vendor Commission Account"; Rec."Vendor Commission Account")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Fee Account"; Rec."Sacco Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor Commission"; Rec."Vendor Commission")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Fee"; Rec."Sacco Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Safaricom Account"; Rec."Safaricom Account")
                {
                    ApplicationArea = Basic;
                }
                field("Safaricom Fee"; Rec."Safaricom Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Pre-Payment Account"; Rec."Pre-Payment Account")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Charge"; Rec."SMS Charge")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Account"; Rec."SMS Account")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Limit"; Rec."Transaction Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Non-Member Debit Account"; Rec."Non-Member Debit Account")
                {
                    ApplicationArea = Basic;
                }
                field("Daily Limit"; Rec."Daily Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Weekly Limit"; Rec."Weekly Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Monthly Limit"; Rec."Monthly Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Type"; Rec."Charge Type")
                {
                    ApplicationArea = Basic;
                }
                field("Restrict to Employer"; Rec."Restrict to Employer")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Agents"; Rec."Charge Agents")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control24; "Portal Tiered Charges")
            {
                SubPageLink = Code = FIELD(Code);
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
    }
}

