page 52186322 "Delegate Meeting Attendees"
{
    PageType = ListPart;
    SourceTable = "Delegates Meeting Attendees";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Delegate No."; Rec."Delegate No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delegate Name"; Rec."Delegate Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delegate Email"; Rec."Delegate Email")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delegate Phone"; Rec."Delegate Phone")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Delegate Position"; Rec."Delegate Position")
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

