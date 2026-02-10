page 52185671 "HR Leave Reliver"
{
    PageType = List;
    SourceTable = "HR Leave Reliver";
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Employee; Rec.Employee)
                {
                    ApplicationArea = Basic;
                }
                field("Reliver Code"; Rec."Reliver Code")
                {
                    ApplicationArea = Basic;
                }
                field("Reliver Name"; Rec."Reliver Name")
                {
                    ApplicationArea = Basic;
                }
                field(Duties; Rec.Duties)
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

