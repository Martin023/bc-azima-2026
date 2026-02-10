page 52186026 "Nature Of Services"
{
    PageType = List;
    SourceTable = "Nature Of Sevices";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Service Code"; Rec."Service Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Service Name"; Rec."Service Name")
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
            action("Contract Lines")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "Contract Documents";
                //RunPageLink = Field4 = FIELD("Service Code");
            }
        }
    }
}

