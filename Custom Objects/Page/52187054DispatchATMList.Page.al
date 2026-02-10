page 52187054 "Dispatch ATM Lists"
{
    CardPageID = "Dispatch ATM Header";
    DeleteAllowed = TRUE;
    Editable = false;
    PageType = List;
    SourceTable = "Dispatch ATM Header";
    ApplicationArea = Basic, Suite;
    //UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("User Id"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Of Dispatch"; Rec."Date Of Dispatch")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document No"; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Record Count"; Rec."Record Count")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Received"; Rec."Total Received")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("To Branch"; Rec."To Branch")
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

