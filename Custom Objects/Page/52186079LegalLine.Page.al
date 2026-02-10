page 52186079 "Legal Line"
{
    PageType = ListPart;
    SourceTable = "Legal Line";
    ApplicationArea = Basic, Suite;
    //UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field("Discussion No"; Rec."Line No")
                // {
                //     ApplicationArea = Basic,Suite;
                // }
                field("Case Number"; Rec."Case Number")
                {
                    ApplicationArea = Basic, Suite;
                    Editable =false;
                }
                field(Discussion; Rec.Discussion)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Recommendation; Rec.Recommendation)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                }
                 field("Captured On"; Rec. "Captured On")
                {
                    Editable = false;
                }
                field("Captured By"; Rec. "Captured By")
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

