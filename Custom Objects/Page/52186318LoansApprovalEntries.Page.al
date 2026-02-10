page 52186318 "Loans Approval Entries"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    Caption = 'All Approval Entry Logs';
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Approval Entry";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                // field("Primary Rec"; Rec."Primary Rec")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Approval Code"; Rec."Approval Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sender ID"; Rec."Sender ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document No."; Rec."Document No.")
                {

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
                field("Last Modified By User ID"; Rec."Last Modified By User ID")
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
            }
        }
    }

    actions
    {
    }
}

