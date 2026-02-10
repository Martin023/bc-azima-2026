page 52186711 "Meeting Type Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Meeting Types";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                // field(Intervals; Rec.Intervals)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Allowed Creation Channel"; Rec."Allowed Creation Channel")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Only Officials"; Rec."Only Officials")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Control6; "Allowed Allowances Part")
            {
                SubPageLink = "Meeting Type Code" = FIELD(Code);
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
    }
}

