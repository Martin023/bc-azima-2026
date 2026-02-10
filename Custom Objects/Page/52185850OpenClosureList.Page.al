page 52185850 "Open Closure List"
{
    CardPageID = "Membership Closure";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Membership closure";
    SourceTableView = WHERE(Posted = CONST(false),
                            Status = CONST(Open));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    InsertAllowed = false;

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
                }
                // field(Digit; Rec.Digit)
                // {
                //     Editable = false;
                // }
                // field("Responsible Officer"; Rec."Responsible Officer")
                // {

                // }
                // field("Supervisor ID"; Rec."Supervisor ID")
                // {

                // }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Closing Date"; Rec."Closing Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Loan"; Rec."Total Loan")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Interest"; Rec."Total Interest")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Savings"; Rec."Member Savings")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Closure Type"; Rec."Closure Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Deposit Refundable"; Rec."Deposit Refundable")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Close Account"; Rec."Close Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loans Option"; Rec."Loans Option")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        // if UserSetup.Get(UserId) then begin
        //     UserSetup.TestField("Responsibility Centre");
        //     Rec.SetFilter("Current Department", UserSetup."Responsibility Centre");
        // end else
        //     Error('You must be set up in user setup');
    end;
}

