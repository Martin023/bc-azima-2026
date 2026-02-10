page 52185666 "prPAYE Angola"
{
    PageType = List;
    SourceTable = "prPAYE Angola";
    SourceTableView = SORTING("Tier Code")
                      ORDER(Ascending);
    UsageCategory = Lists;
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tier Code"; Rec."Tier Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Min. Amount"; Rec."Min. Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Max. Amount"; Rec."Max. Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Excess Amount"; Rec."Excess Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Rate; Rec.Rate)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Fixed Amount"; Rec."Fixed Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Tax Code"; Rec."Tax Code")
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

