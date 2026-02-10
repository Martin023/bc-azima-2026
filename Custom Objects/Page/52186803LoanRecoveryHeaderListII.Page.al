page 52186803 "Loan Recovery Header List II"
{
    CardPageID = "Loan Recovery Header II";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Loan Recovery Header II";
    SourceTableView = WHERE(Status = filter(Open|Pending|Deffered|Approved));
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
                field("Responsible Officer";Rec."Responsible Officer")
                {

                }
                field("Supervisor ID";Rec."Supervisor ID")
                {
                    
                }
                field("Loan No.";Rec."Loan No.")
                {
                    
                }
            }
        }
    }
    actions
    {
    }
}
