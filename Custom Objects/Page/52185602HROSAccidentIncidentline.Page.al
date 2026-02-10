page 52185602 "HR OSAccident Incident line"
{
    PageType = ListPart;
    SourceTable = "HR OSAccident Incident Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Investigation No."; Rec."Investigation No.")
                {
                }
                field(Cause; Rec.Cause)
                {
                    Caption = 'Cause';
                }
                field("Resolution/Recommendation"; Rec."Resolution/Recommendation")
                {
                }
            }
        }
    }

    actions
    {
    }
}

