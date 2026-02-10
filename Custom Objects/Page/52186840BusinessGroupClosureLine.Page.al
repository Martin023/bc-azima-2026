page 52186840 "Business Group Closure Line"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Account Closure Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Total Loan Balance"; Rec."Total Loan Balance")
                {
                    Caption = 'Business Unit Loans';
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Loan Balance"; Rec."Interest Loan Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Business Unit Interest';
                }
                field("Savings Balance"; Rec."Savings Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Business Unit Savings';
                }
                field("Net Refundable"; Rec."Net Refundable") { ApplicationArea = Basic, Suite; }
                field(Close; Rec.Close)
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

