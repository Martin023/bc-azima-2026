page 52185477 "Internet Banking Transactions"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ShowFilter = true;
    SourceTable = "Online Transactions";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No."; Rec."Account No.")
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
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account To"; Rec."Account To")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Utility Type"; Rec."Utility Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Status"; Rec."Account Status")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Needs Change"; Rec."Needs Change")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Change Transaction No"; Rec."Change Transaction No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Old Account No"; Rec."Old Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Changed; Rec.Changed)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Changed"; Rec."Date Changed")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time Changed"; Rec."Time Changed")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Changed By"; Rec."Changed By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approved By"; Rec."Approved By")
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

