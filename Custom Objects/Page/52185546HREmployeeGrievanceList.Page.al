page 52185546 "HR Employee Grievance List"
{
    CardPageID = "HR Employee Grievance Card";
    PageType = List;
    SourceTable = "HR Employee Grievance";
    
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee First Name"; Rec."Employee First Name")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Last Name"; Rec."Employee Last Name")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Grievance"; Rec."Date Of Grievance")
                {
                    ApplicationArea = Basic;
                }
                field("Release Date"; Rec."Release Date")
                {
                    ApplicationArea = Basic;
                }
                field("Follow Up Date"; Rec."Follow Up Date")
                {
                    ApplicationArea = Basic;
                }
                field("Follow Up Completed"; Rec."Follow Up Completed")
                {
                    ApplicationArea = Basic;
                }
                field("Follow Up Date (Actual Date)"; Rec."Follow Up Date (Actual Date)")
                {
                    ApplicationArea = Basic;
                }
                field("Cause Of Grievance"; Rec."Cause Of Grievance")
                {
                    ApplicationArea = Basic;
                }
                field("Outcome Of Grievance"; Rec."Outcome Of Grievance")
                {
                    ApplicationArea = Basic;
                }
                field("Letter Sent To Employee"; Rec."Letter Sent To Employee")
                {
                    ApplicationArea = Basic;
                }
                field("Letter Sent By Whom"; Rec."Letter Sent By Whom")
                {
                    ApplicationArea = Basic;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

