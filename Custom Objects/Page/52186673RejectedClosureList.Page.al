page 52186673 "Rejected Closure List"
{
    CardPageID = "Membership Closure";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Membership closure";
    SourceTableView = WHERE(Status = CONST(Rejected));
    ApplicationArea = Basic, Suite;
    usagecategory = Lists;

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
                // field("Responsible Officer"; Rec."Responsible Officer")
                // {

                // }
                // field("Supervisor ID"; Rec."Supervisor ID")
                // {

                // }

            }
        }
    }

    actions
    {
    }
}

