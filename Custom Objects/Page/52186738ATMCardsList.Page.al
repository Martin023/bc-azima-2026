page 52186753 "ATM Card List"
{
    Editable = false;
    PageType = List;
    SourceTable = "ATM Card Table";
    ApplicationArea = Basic, Suite;
    // UsageCategory = Lists;
    DeleteAllowed = false;
    InsertAllowed = false;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("ATM No."; Rec."ATM No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Card Type"; Rec."Card Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Linked"; Rec."Date Linked")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("User Id"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }

    }

}

