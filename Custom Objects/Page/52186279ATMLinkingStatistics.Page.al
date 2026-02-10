page 52186279 "ATM Linking Statistics"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ATM Linking  Statistics";
    ApplicationArea = Basic, Suite;
    //  UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Linking Type"; Rec."Linking Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Activity Date"; Rec."Activity Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Activity Time"; Rec."Activity Time")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reason for change"; Rec."Reason for change")
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

