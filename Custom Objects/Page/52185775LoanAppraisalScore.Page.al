page 52185775 "Loan Appraisal Score"
{
    PageType = List;
    SourceTable = "Loan Application Credit Score";
    SourceTableView = SORTING(Priority);
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product Code"; Rec."Product Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Parameter Code"; Rec."Parameter Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Calculated Success"; Rec."Calculated Success")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Calculated Failure"; Rec."Calculated Failure")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Qualifying Amount"; Rec."Qualifying Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(RequestTime; Rec.RequestTime)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("General Output"; Rec."General Output")
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

