page 52185520 "HR Professional Bodies List"
{
    CardPageID = "HR Professional bodies";
    PageType = List;
    SourceTable = "HR Professional body Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field("Professional Body"; Rec."Professional Body")
                {
                }
                field(Members; Rec.Members)
                {
                }
                field("CPD Points";Rec."CPD Points")
                {

                }
                
            }
        }
    }

    actions
    {
    }
}

