page 52185606 "HR OSMeasure Line"
{
    PageType = ListPart;
    SourceTable = "HR OSMeasure Line";
    Deleteallowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Accident No."; Rec."Measure No")
                {
                    Editable = false;
                }
                // field("Code"; Rec.Code)
                // {
                // }
                // field(Assessor;Rec.Assessor)
                // {
                
                // }
                field("Assessor Name";Rec."Assessor Name")
                {
                    //Editable = false;
                }
                field(Damage;Rec.Damage)
                {
                }
                // field(Description; Rec."Damage Description")
                // {
                // }

                field("Damage Description";Rec."Damage Description")
                {
                
                }
                field("Damage Costs";Rec."Damage Costs")
                {
                
                }
                field("Other Costs";Rec."Other Costs")
                {
                
                }
                field("Total Costs";Rec."Total Costs")
                {
                    Editable = false;
                
                }
                field("Entered By";Rec."Captured By")
                {
                    Editable = false;
                
                }
                field("Date Entered";Rec."Captured On")
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

