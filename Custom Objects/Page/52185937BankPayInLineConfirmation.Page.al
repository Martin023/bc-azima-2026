page 52185937 "Bank Pay In Line Confirmation"
{
    PageType = ListPart;
    SourceTable = "Bank Slip Line";
    SourceTableView = WHERE(Vaulted = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Control1102758000)
            {
                ShowCaption = false;
                field(Select; Rec.Select)
                {
                    Caption = 'Confirmed';
                    ApplicationArea = Basic, Suite;
                }
                field("Bank Slip No."; Rec."Bank Slip No.")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Drawers Name"; Rec."Drawers Name")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = true;
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    var
        BHeader: Record "Bank Slip";
}

