page 52185582 "HR Disciplinary Actions1"
{
    PageType = List;
    SourceTable = "HR Disciplinary Actions";
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Action Code"; Rec."Action Code")
                {
                    ApplicationArea = Basic;
                }
                field(Instance; Rec.Instance)
                {
                    ApplicationArea = Basic;
                }
                field("Recommended Action"; Rec."Recommended Action")
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

