page 52185754 "Savings Ledger Entries"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Savings Ledger Entry";
    ApplicationArea = Basic, Suite;
    UsageCategory = None;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Creation Date Time"; Rec."Creation Date Time")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Fixed Deposit Contract"; Rec."Fixed Deposit Contract")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Debit Amount (LCY)"; Rec."Debit Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Credit Amount (LCY)"; Rec."Credit Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reversed by Entry No."; Rec."Reversed by Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reversed Entry No."; Rec."Reversed Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
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
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = Basic, Suite;
                }

                field(Open; Rec.Open)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                }

                field(Positive; Rec.Positive)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Closed by Entry No."; Rec."Closed by Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Closed at Date"; Rec."Closed at Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Closed by Amount"; Rec."Closed by Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Closed by Amount (LCY)"; Rec."Closed by Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Date Filter"; Rec."Date Filter")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Amount to Apply"; Rec."Amount to Apply")
                {
                    ApplicationArea = Basic, Suite;
                }

                field(Prepayment; Rec.Prepayment)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bulk Process"; Rec."Bulk Process")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posting Time"; Rec."Posting Time")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Approver ID"; Rec."Approver ID")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Creation Time"; Rec."Creation Time")
                {
                    ApplicationArea = Basic, Suite;
                }

            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Reverse Transaction")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Reverse Transaction';
                Ellipsis = true;
                Image = ReverseRegister;
                Enabled = false;
                trigger OnAction()
                var
                    ReversalEntry: Record "Reversal Entry";
                begin
                    Clear(ReversalEntry);
                    if Rec.Reversed then
                        ReversalEntry.AlreadyReversedEntry(Rec.TableCaption, Rec."Entry No.");
                    if Rec."Journal Batch Name" = '' then
                        ReversalEntry.TestFieldError;
                    Rec.TestField("Transaction No.");
                    ReversalEntry.ReverseTransaction(Rec."Transaction No.");
                end;
            }
            action("&Navigate")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.Run;
                end;
            }
        }
    }

    var
        Navigate: Page Navigate;
}

