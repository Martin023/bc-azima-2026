page 52185858 "Recovery & Attachment List"
{
    CardPageID = "Loan Recovery Header";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Loan Recovery Header";
    SourceTableView = WHERE(Status = filter(Open | Pending | Deffered | Approved));
    UsageCategory = Lists;
    ApplicationArea = Basic, Suite;

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
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsible Officer"; Rec."Responsible Officer")
                {

                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {

                }
                field("Loan No."; Rec."Loan No.")
                {

                }
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field("Posted By"; Rec."Posted By")
                {

                }
            }
        }
    }
    actions
    {
    }
}
