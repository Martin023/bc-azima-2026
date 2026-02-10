page 52186675 "Return Lines List"
{
    Editable = false;
    PageType = List;
    SourceTable = "Delegates Returns Lines";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ID/Personal/Member Number"; Rec."ID/Personal/Member Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
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

