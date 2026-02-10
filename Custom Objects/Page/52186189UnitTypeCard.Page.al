page 52186189 "Unit Type Card"
{
    PageType = Card;
    SourceTable = "Unit Type";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sub Types"; Rec."Sub Types")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        UST.Reset;
                        UST.SetFilter(UST."Unit Type", Rec.Code);
                        PAGE.Run(Page::"Sky Mbanking Changes Card", UST);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    var
        UST: Record "Unit Sub Type";
}

