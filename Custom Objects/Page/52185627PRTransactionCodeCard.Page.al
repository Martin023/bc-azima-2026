page 52185627 "PR Transaction Code Card"
{
    PageType = Card;
    SourceTable = "PR Transaction Codes";
    DeleteAllowed = False;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
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
                    ValuesAllowed = None, Increasing, Reducing;
                }
                // field("Is Cash"; Rec."Is Cash")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field(Taxable; Rec.Taxable)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field(Allowables; Rec.Allowable)
                {
                    ApplicationArea = Basic, Suite;
                }
                // field(Deductible; Rec.Deductible)
                // {
                //     ApplicationArea = Basic, Suite;
                // }

                // FIELD("Is HLEVY"; Rec."Is HLEVY")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field(SHIF; Rec.SHIF)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Pension; Rec.Pension)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(NSSF; Rec.NSSF)
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
                // field("iTax Grouping"; Rec."iTax Grouping")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Employer Deduction"; Rec."Employer Deduction")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Group Code"; Rec."Group Code")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Is Formula for employer"; Rec."Is Formula for employer")
                {
                    ApplicationArea = Basic, Suite;
                }
                label(Control1102756054)
                {
                    CaptionClass = Text19080001;
                    ShowCaption = false;
                }
                field("GL Account"; Rec."GL Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Min Cont."; Rec."Product Min Cont.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(CustomerPostingGroup; Rec.CustomerPostingGroup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Debtor Posting Group';
                }

                // field("Interest Rate"; Rec."Interest Rate")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Interest Rate';
                // }
                // field("IsCoop/LnRep"; Rec."IsCoop/LnRep")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Is Loan/Coop';
                // }

            }
            group(Incometype)
            {
                Caption = 'Salary Type & subledger';
                field("Salary Type"; Rec."Salary Type")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Salary Type';
                }

                field(Subledger; Rec.Subledger)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posting to Subledger';
                }
            }
            group("Loan Setup")
            {
                Caption = 'Loan Setup';
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Other Set-Ups")
            {
                Caption = 'Other Set-Ups';
                field("Amount Preference"; Rec."Amount Preference")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Special Transactions3"; Rec."Special Transactions")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Special Transactions';
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Variated; Rec.Variated)
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Fringe Benefit"; Rec."Fringe Benefit")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Deduct Premium"; Rec."Deduct Premium")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("IsCoop/LnRep2"; Rec."IsCoop/LnRep")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Coop Parameter';
                // }
                field("coop parameters"; Rec."coop parameters")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDown = false;
                }
                field(Suspended; Rec.Suspended)
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("IsLeave Allowance"; Rec."IsLeave Allowance")
                // {
                //     ApplicationArea = Basic, Suite;
                // }

                // field("Based on Loans"; Rec."Based on Loans")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Product Category"; Rec."Product Category")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posting to Other Savings"; Rec."Posting to Other Savings")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Prorated; Rec.Prorated)
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

