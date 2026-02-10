page 52186587 "HR Overtime Lines"
{
    PageType = ListPart;
    SourceTable = "HR Overtime Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                }
                field("Overtime Type"; Rec."Overtime Type")
                {
                }
                field("Start Time"; Rec."Start Time")
                {
                }
                field("End Time"; Rec."End Time")
                {
                }
                field("Work Done"; Rec."Work Done")
                {
                }
                field("Overtime Hours"; Rec."Overtime Hours")
                {
                }
            }
        }
    }

    actions
    {
    }
}

