page 52186415 "Loan Securites Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Loan Securities Set-up";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec."Setup Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("No."; Rec."No.")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field(Description; Rec."Security Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Examples; Rec.Examples)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Collateral Multiplier"; Rec."Collateral Multiplier")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Collateral Multiplier %.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Revaluation Frequency"; Rec."Revaluation Frequency")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control10; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control11; Links)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
    }
}

