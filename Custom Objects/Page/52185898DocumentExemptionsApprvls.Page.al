page 52185898 "Document Exemptions Apprvls"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Document Exemptions Auth.";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sequence No."; Rec."Sequence No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approval Code"; Rec."Approval Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sender ID"; Rec."Sender ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date-Time Sent for Approval"; Rec."Date-Time Sent for Approval")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Date-Time Modified"; Rec."Last Date-Time Modified")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Modified By ID"; Rec."Last Modified By ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Due Date"; Rec."Due Date")
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
                field("Available Credit Limit (LCY)"; Rec."Available Credit Limit (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approval Type"; Rec."Approval Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Limit Type"; Rec."Limit Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Comments For Exemptions"; Rec."Comments For Exemptions")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Control22; "Loans List")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Loan No." = FIELD("Document No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action24)
            {
            }
        }
    }
}

