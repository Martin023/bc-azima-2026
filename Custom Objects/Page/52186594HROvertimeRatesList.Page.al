page 52186594 "HR Overtime Rates List1"
{
    PageType = List;
    SourceTable = "HR Overtime Rates";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Conversion Type"; Rec."Conversion Type")
                {
                }
                field("Extra Hours Rate"; Rec."Extra Hours Rate")
                {
                }
                field("Weekend Hours Rate"; Rec."Weekend Hours Rate")
                {
                }
                field("Holiday Hours Rate"; Rec."Holiday Hours Rate")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control8; Outlook)
            {
            }
            systempart(Control9; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

