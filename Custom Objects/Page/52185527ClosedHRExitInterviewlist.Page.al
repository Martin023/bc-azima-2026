page 52185527 "Closed HR Exit Interview list1"
{
    CardPageID = "HR Employee Exit Interviews1";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Employee Exit Interviews";
    SourceTableView = WHERE(Closed = FILTER(true));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Exit Interview No"; Rec."Exit Interview No")
                {
                    ApplicationArea = Basic, Suite;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Date Of Interview"; Rec."Date Of Interview")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Interviewer Name"; Rec."Interviewer Name")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Reason For Leaving"; Rec."Reason For Leaving")
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

