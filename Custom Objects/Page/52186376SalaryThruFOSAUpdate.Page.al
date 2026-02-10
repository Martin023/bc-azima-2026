page 52186376 "Salary Thru FOSA Update"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Salary Thru FOSA Update";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Unmarked"; Rec."Date Unmarked")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Salary Date"; Rec."Last Salary Date")
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

