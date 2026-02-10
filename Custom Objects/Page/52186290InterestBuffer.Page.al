page 52186290 "Interest Buffer"
{
    DeleteAllowed = false;
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Interest Buffer";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Date"; Rec."Interest Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Amount"; Rec."Interest Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Matured"; Rec."Account Matured")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Transferred; Rec.Transferred)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Qualifying Amount"; Rec."Qualifying Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
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

