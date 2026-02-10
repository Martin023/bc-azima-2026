page 52185605 "HR OSAccident Line"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "HR OSAccident Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Accident No."; Rec."Accident No.")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

