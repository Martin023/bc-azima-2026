page 52186031 "Contract Cycle"
{
    PageType = List;
    SourceTable = "Contract Cycle";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Cycles; Rec.Cycles)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                // field(Blocked; Rec.Blocked)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Estimated Value (LCY)"; Rec."Estimated Value (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Contract Cycle Stages")
            {
                RunObject = Page "Contract Cycle Stage List";
                ApplicationArea = Basic, Suite;
            }
        }
    }
}

