page 52186452 "DCS Parameter Range List"
{
    PageType = List;
    SourceTable = "DCS Parameter Range";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(RangeID; Rec.RangeID)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Parameter Code"; Rec."Parameter Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Range MIN"; Rec."Range MIN")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Range MAX"; Rec."Range MAX")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Evaluation Method"; Rec."Evaluation Method")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Evaluation Factor"; Rec."Evaluation Factor")
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

