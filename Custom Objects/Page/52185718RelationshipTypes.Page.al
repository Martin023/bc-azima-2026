page 52185718 "Relationship Types"
{

    PageType = List;
    SourceTable = "Relationship Types";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Relation; Rec.Relation)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Min. Age"; Rec."Min. Age")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Max. Age"; Rec."Max. Age")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("BBF Max. Allowed"; Rec."BBF Max. Allowed")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Welfare Claim Amount"; Rec."Welfare Claim Amount")
                {

                }
                field(Self; Rec.Self)
                {

                }
            }
        }
    }

    actions
    {
    }
}
