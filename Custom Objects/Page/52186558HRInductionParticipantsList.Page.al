page 52186558 "HR Induction Participants List"
{
    PageType = List;
    SourceTable = "HR Staff  Induction";
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Participant Code"; Rec."Participant Code")
                {
                    ApplicationArea = Basic;
                }
                field("Participant Name"; Rec."Participant Name")
                {
                    ApplicationArea = Basic;
                }
                field(From; Rec.From)
                {
                    ApplicationArea = Basic;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = Basic;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic;
                }
                field("Days Attended"; Rec."Days Attended")
                {
                    ApplicationArea = Basic;
                }
                field("Induction Status"; Rec."Induction Status")
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

