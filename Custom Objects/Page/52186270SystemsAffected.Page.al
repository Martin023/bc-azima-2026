page 52186270 "Systems Affected"
{
    PageType = List;
    SourceTable = "Systems Affected";
    ApplicationArea = Basic;
    usageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Systems Affected"; Rec."Systems Affected")
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

