page 52185603 "HR OSAccident List"
{
    CardPageID = "HR OSAccident Card";
    PageType = List;
    Caption = 'Accidents List';
    SourceTable = "HR OSAccident";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Accident No"; Rec."Accident No.")
                {
                }
                // field(Description; Rec.Description)
                // {
                // }
                field("Accident Date"; Rec."Accident Date")
                {
                }
                field("Type of Accident"; Rec."Type of Accident")
                {
                }
                field("Accident Location"; Rec."Accident Location")
                {
                }
                field("Driver Staff No"; Rec."Driver Staff No.")
                {
                }
                field("Driver Name"; Rec."MNS Driver Name")
                {
                }
                field("Vehicle No"; Rec."MNS Vehicle No.")
                {
                }
                field("Vehicle Make"; Rec."MNS Vehicle Make")
                {
                }
                field("Registration No"; Rec."Registration No.")
                {
                }
                field("SACCO Vehicle Insurance"; Rec."SACCO Vehicle Insurance")
                {
                }

                field("Date Captured"; Rec."Created at")
                {
                }
                field("Captured By"; Rec."Created By")
                {
                }
            }
        }
    }

    actions
    {
    }
}

