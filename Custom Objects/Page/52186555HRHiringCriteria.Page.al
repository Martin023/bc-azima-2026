page 52186555 "HR Hiring Criteria"
{
    PageType = List;
    SourceTable = "HR Hiring Criteria";
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
                }
                field("Hiring Criteria"; Rec."Hiring Criteria")
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

