page 52187417 "FOSA Payment Lines"
{
    PageType = ListPart;
    SourceTable = "FOSA Payment Line";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        //check if the payment reference is for farmer purchase
                        if Rec."Payment Reference" = Rec."Payment Reference"::"Farmer Purchase" then begin
                            if Rec.Amount <> xRec.Amount then begin
                                Error('Amount cannot be modified');
                            end;
                        end;

                        Rec."Amount With VAT" := Rec.Amount;


                    end;
                }
                // field("VAT Code"; Rec."VAT Code")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("VAT Amount"; Rec."VAT Amount")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }
                // field("VAT Withholding Code"; Rec."VAT Withholding Code")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("VAT Withholding Amount"; Rec."VAT Withholding Amount")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Withholding Tax Amount"; Rec."Withholding Tax Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Retention Code"; Rec."Retention Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Retention  Amount"; Rec."Retention  Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    Visible = false;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }
                // field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Applies-to ID"; Rec."Applies-to ID")
                // {
                //     ApplicationArea = Basic, Suite;
                // }

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    var
        RecPayTypes: Record "Receipts and Payment Types";
        TarriffCodes: Record "Tariff Code s";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        CustLedger: Record "Vendor Ledger Entry";
        CustLedger1: Record "Vendor Ledger Entry";
        Amt: Decimal;
        TotAmt: Decimal;
        //ApplyInvoice: Codeunit "Purchase Header Apply";
        VendEntries: Record "Vendor Ledger Entry";
        PInv: Record "Purch. Inv. Header";
        VATPaid: Decimal;
        VATToPay: Decimal;
        PInvLine: Record "Purch. Inv. Line";
        VATBase: Decimal;
        ShortcutDimCode: array[8] of Code[20];
}

