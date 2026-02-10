page 52186771 "Atm Card"
{
    Editable = false;
    PageType = List;
    SourceTable = "ATM Card Storage";
    ApplicationArea = Basic, Suite;
    //  UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Card Number"; Rec."Card Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;

                }
                field(Linked; Rec.Linked)
                {
                    ApplicationArea = Basic, Suite;

                }
                field(DeLinked; Rec.DeLinked)
                {
                    ApplicationArea = Basic, Suite;

                }
            }
        }

    }
}

