page 52185673 "prTransaction Code"
{
    PageType = Card;
    SourceTable = "PR Transaction Codes";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = Basic, Suite;
                    ValuesAllowed = Fixed, Varied;
                }
                field("Balance Type"; Rec."Balance Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount Preference"; Rec."Amount Preference")
                {
                    ApplicationArea = Basic, Suite;
                    ValuesAllowed = "Posted Amount", "Take Lower ", "Take Higher";
                }
                field("Is Cash"; Rec."Is Cash")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is Income/Deduction"; Rec."Is Income/Deduction")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Taxable; Rec.Taxable)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is Formula"; Rec."Is Formula")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Formula; Rec.Formula)
                {
                    ApplicationArea = Basic, Suite;
                }
                label(Control1102756053)
                {
                    CaptionClass = Text19025872;
                    ShowCaption = false;
                }
                field("Include Employer Deduction"; Rec."Include Employer Deduction")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer Deduction"; Rec."Employer Deduction")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is Formula for employer"; Rec."Is Formula for employer")
                {
                    ApplicationArea = Basic, Suite;
                }
                label(Control1102756054)
                {
                    CaptionClass = Text19080001;
                    ShowCaption = false;
                }
                group(Loans)
                {
                    Caption = 'Loans';
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Interest Rate';
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = Basic, Suite;
                    ValuesAllowed = Reducing, "Straight line", Amortized;
                }
                field("Fringe Benefit"; Rec."Fringe Benefit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("GL Account"; Rec."GL Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Subledger; Rec.Subledger)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posting to Subledger';
                }
                field(CustomerPostingGroup; Rec.CustomerPostingGroup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Debtor Posting Group';
                }
                field("IsCoop/LnRep"; Rec."IsCoop/LnRep")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Is Loan/Coop';
                }
            }
            group("Other Set-Ups")
            {
                Caption = 'Other Set-Ups';
                field("IsTransfer Allowance"; Rec."IsTransfer Allowance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("IsLeave Allowance"; Rec."IsLeave Allowance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is Salary Advance"; Rec."Is Salary Advance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is HR Loan"; Rec."Is HR Loan")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Special Transactions"; Rec."Special Transactions")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("IsTraining Deduction"; Rec."IsTraining Deduction")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Deduct Premium"; Rec."Deduct Premium")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("coop parameters"; Rec."coop parameters")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'coop parameters';
                    DrillDown = false;
                }
                field(Suspended; Rec.Suspended)
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
        Text19025872: Label 'E.g ([005]+[020]*[24])/2268';
        Text19080001: Label 'E.g ([005]+[020]*[24])/2268';
}

