page 52186685 "Complaint Categories"
{
    PageType = List;
    SourceTable = "Complaint Categories";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Complaint Category"; Rec."Complaint Category")
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

