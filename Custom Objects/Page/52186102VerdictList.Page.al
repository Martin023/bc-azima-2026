page 52186102 "Verdict List"
{
    //CardPageID = "Verdict Card";
    PageType = ListPart;
    SourceTable = Verdict;
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
                // field("Verdict No"; Rec."Line No")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }
                field(Description; Rec.Description)
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

