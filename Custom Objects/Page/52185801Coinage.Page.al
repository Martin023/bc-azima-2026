page 52185801 Coinage
{
    Editable = true;
    PageType = ListPart;
    SourceTable = Coinage;

    layout
    {
        area(content)
        {
            group(Summary)
            {
                ShowCaption = false;

                field("Coinage AAmount"; TotalCoinageRequested)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Coinage Requested';
                    Editable = false;
                }
                field("Coinage Difference"; CoinageDifference)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Coinage Difference';
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = CoinageDifference <> 0;
                }
            }
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Enabled = false;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    Enabled = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Enabled = true;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
            }
        }
    }

    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        RefreshHeaderRec();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        RefreshHeaderRec();
    end;

    var
        HeaderRec: Record "Treasury Cashier Transactions";
        TotalCoinageRequested: Decimal;
        CoinageDifference : decimal;

    local procedure RefreshHeaderRec()
    var
        CoinageRec: Record Coinage;
    begin
        if Rec.No = '' then begin
            Clear(HeaderRec);
            TotalCoinageRequested := 0;
            exit;
        end;

        if not HeaderRec.Get(Rec.No) then begin
            Clear(HeaderRec);
            TotalCoinageRequested := 0;
            exit;
        end;

        CoinageDifference := HeaderRec."Coinage Difference";

        CoinageRec.SetRange(No, Rec.No);
        CoinageRec.CalcSums("Total Amount");
        TotalCoinageRequested := CoinageRec."Total Amount";
    end;
}

