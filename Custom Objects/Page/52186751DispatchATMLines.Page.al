page 52186751 "Dispatch ATM Lines"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "ATM Inventory";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Card Number"; Rec."Card Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Received; Rec.Received)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("To HQ"; Rec."To HQ")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = FALSE;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {

                    Editable = FALSE;
                }
            }
        }
    }

    actions
    {
    }
}

