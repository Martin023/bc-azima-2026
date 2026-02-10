page 52186028 "Contract Lines Type"
{
    PageType = List;
    SourceTable = "Contract Lines Types";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Contract Line Code"; Rec."Contract Line Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contract Line Type"; Rec."Contract Line Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contract Cycle"; Rec."Contract Cycle")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Contract &Cycle")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "Contract Cycle Stage";
                RunPageLink = "Contract Line Type" = FIELD("Contract Line Type");
            }
        }
    }
}

