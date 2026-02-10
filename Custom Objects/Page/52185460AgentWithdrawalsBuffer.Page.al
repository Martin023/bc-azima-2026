page 52185460 "Agent Withdrawals Buffer"
{
    PageType = List;
    SourceTable = "Sky Agent Withdrawals Buffer";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Trace ID"; Rec."Trace ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posting S"; Rec."Posting S")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Unit ID"; Rec."Unit ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Trans Time"; Rec."Trans Time")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reversed Posted"; Rec."Reversed Posted")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reversal Trace ID"; Rec."Reversal Trace ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Withdrawal Location"; Rec."Withdrawal Location")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Type Charges"; Rec."Transaction Type Charges")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Card Acceptor Terminal ID"; Rec."Card Acceptor Terminal ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ATM Card No"; Rec."ATM Card No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Customer Names"; Rec."Customer Names")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Process Code"; Rec."Process Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is Coop Bank"; Rec."Is Coop Bank")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("POS Vendor"; Rec."POS Vendor")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Session ID"; Rec."Session ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Reversed"; Rec."Date Reversed")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reversed By"; Rec."Reversed By")
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

