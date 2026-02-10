page 52186544 "HR Policy List"
{
    PageType = List;
    SourceTable = "HR Policies";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Rules & Regulations"; Rec."Rules & Regulations")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Document Description"; Rec."Document Description")
                {
                }
            }
        }
    }

    actions
    {
    }
}

