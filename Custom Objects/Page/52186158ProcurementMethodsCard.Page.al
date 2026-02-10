page 52186158 "Procurement Methods Card"
{
    PageType = Card;
    SourceTable = "Procurement Methods";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Control2; "Procurement Methods Sub Page")
            {
                SubPageLink = "Procurement Method" = FIELD(Code);
                ApplicationArea = Basic, Suite;
            }
            systempart(Control1; Outlook)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
    }
}

