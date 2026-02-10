page 52185830 "Tiered Charges Header"
{
    PageType = Card;
    SourceTable = "Tiered Charges Header";

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
            }
            group(Control6)
            {
                ShowCaption = false;
                part(Control5; "Tiered Charges Lines")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = Code = FIELD(Code);
                }
            }
        }
    }

    actions
    {
    }
}

