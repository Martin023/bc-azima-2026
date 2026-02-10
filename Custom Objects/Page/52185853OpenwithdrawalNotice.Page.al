page 52185853 "Open withdrawal Notice"
{
    CardPageID = "Member withdrawal Notice";
    Editable = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Member withdrawal Notice";
    SourceTableView = where(Status = const(Open));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        Rec."Date Entered" := Today;
                        Rec."Date Modified" := Today;
                        Rec.Modify;
                    end;
                }
                // field(Digit; Rec.Digit)
                // {
                //     Editable = false;
                // }
                field("Responsible Officer"; rec."Responsible Officer")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reason for withdrawal"; Rec."Reason for withdrawal")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Withdrawal Notice Date"; Rec."Withdrawal Notice Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Notice Type"; Rec."Notice Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer Liability"; Rec."Employer Liability")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Actioning Department"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Actioning Department';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Modified"; Rec."Date Modified")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Sent Back to CRM"; Rec."Sent Back to CRM")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        UserSetUp: Record "User Setup";
    begin
        // UserSetUp.Reset();
        // UserSetUp.SetRange("User ID", UserId);
        // if UserSetUp.FindFirst() then begin
        //     UserSetUp.TestField("Global Dimension 2 Code");
        //     Rec.SetFilter("Global Dimension 2 Code", UserSetUp."Global Dimension 2 Code");
        // end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        MemberwithdrawalNotice.Reset;
        MemberwithdrawalNotice.SetRange(Status, MemberwithdrawalNotice.Status::Open);
        MemberwithdrawalNotice.SetFilter("Notice Type", '%1|%2', MemberwithdrawalNotice."Notice Type"::"Withdrawal - Normal", MemberwithdrawalNotice."Notice Type"::" ");
        if MemberwithdrawalNotice.FindFirst then Error('Kindly make use of card %1', MemberwithdrawalNotice."No.");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        MemberwithdrawalNotice.Reset;
        MemberwithdrawalNotice.SetRange(Status, MemberwithdrawalNotice.Status::Open);
        MemberwithdrawalNotice.SetFilter("Notice Type", '%1|%2', MemberwithdrawalNotice."Notice Type"::"Withdrawal - Normal", MemberwithdrawalNotice."Notice Type"::" ");
        if MemberwithdrawalNotice.FindFirst then Error('Kindly make use of card %1', MemberwithdrawalNotice."No.");
    end;

    var
        MemberwithdrawalNotice: Record "Member withdrawal Notice";
}

