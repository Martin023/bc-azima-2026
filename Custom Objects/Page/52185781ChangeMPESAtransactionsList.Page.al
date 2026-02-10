page 52185781 "Change MPESA transactions List"
{
    CardPageID = "Mpesa Changes";
    DeleteAllowed = false;
    Editable = true;
    PageType = List;
    SourceTable = "M-PESA Change Transactions";
    SourceTableView = WHERE(Status = FILTER(Open),
                            Status = FILTER(Pending));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Initiated By"; Rec."Initiated By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("MPESA Receipt No"; Rec."MPESA Receipt No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("New Account No"; Rec."New Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time Approved"; Rec."Time Approved")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Changed; Rec.Changed)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Send For Approval By"; Rec."Send For Approval By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Sent For Approval"; Rec."Date Sent For Approval")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time Sent For Approval"; Rec."Time Sent For Approval")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reasons for rejection"; Rec."Reasons for rejection")
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

