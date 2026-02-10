page 52186409 "Related Product Appl. List"
{
    PageType = List;
    SourceTable = "Related Product Application";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Related Product Code"; Rec."Related Product Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Related Product Desc"; Rec."Related Product Desc")
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

