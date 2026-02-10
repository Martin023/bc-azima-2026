page 52185672 "HR Leave Planner Lines Drill"
{
    PageType = List;
    SourceTable = "HR Leave Planner Drill";
    UsageCategory = Lists;
    ApplicationArea = Basic;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application Code"; Rec."Application Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = Basic;
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = Basic;
                }
                field("Applicant Comments"; Rec."Applicant Comments")
                {
                    ApplicationArea = Basic;
                }
                field(Reliever; Rec.Reliever)
                {
                    ApplicationArea = Basic;
                }
                field("Reliever Name"; Rec."Reliever Name")
                {
                    ApplicationArea = Basic;
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Employee No" := Rec.GetFilter("Employee No");
        if Evaluate(Rec.Month, Rec.GetFilter(Month)) then
            Rec.Month := Rec.Month;
        if Evaluate(Rec.Year, Rec.GetFilter(Year)) then
            Rec.Year := Rec.Year;

        Commit;
        Rec."User ID" := UserId;
    end;

    trigger OnOpenPage()
    begin
        Rec.SetFilter("User ID", UserId)
    end;
}

