page 52186281 "Investment List"
{
    CardPageID = "Investment Card";
    DeleteAllowed = true;
    Editable = false;
    PageType = List;
    SourceTable = "Investment Header";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Investment No"; Rec."Investment No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Investment Type Code"; Rec."Investment Type Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Institution Name"; Rec."Institution Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Period Type"; Rec."Period Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = Basic, Suite;
                }

                field(Status; Rec.Status)
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

