page 52185975 "Posted Loan Recovery Header"
{
    CardPageID = "Loan Recovery Header";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Loan Recovery Header";
    SourceTableView = WHERE(Status = filter(Approved|Rejected));
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
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Date Entered"; Rec."Date Entered")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan No.";Rec."Loan No.")
                {

                }
                field("Posting Date";Rec."Posting Date")
                {

                }
                field("Posted By";Rec."Posted By")
                {
                    
                }
            }
        }
    }

    actions
    {
    }
}

