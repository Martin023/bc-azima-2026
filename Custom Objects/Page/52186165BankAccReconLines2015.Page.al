page 52186165 "Bank Acc. Recon Lines 2015"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Bank Acc. Reconciliation Line";
    ApplicationArea = Basic, Suite;
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleTxt;
                }
                field("Value Date"; Rec."Value Date")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = false;
                }
                field("Check No."; Rec."Check No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleTxt;
                }
                field("Statement Amount"; Rec."Statement Amount")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleTxt;

                    trigger OnValidate()
                    begin
                        if Rec.Suggested = true then Error('You can not modify a suggested entry');
                    end;
                }
                field("Applied Amount"; Rec."Applied Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Difference; Rec.Difference)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Applied Entries"; Rec."Applied Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Payer Information"; Rec."Payer Information")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Transaction Information"; Rec."Transaction Information")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Reconciled; Rec.Reconciled)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Cleared"; Rec."Date Cleared")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("External Document No"; Rec."External Document No")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Control16)
            {
                ShowCaption = false;
                label(Control13)
                {
                    ShowCaption = false;
                }
                // field(Balance; Rec.Balance + "Statement Amount")
                // {
                //     AutoFormatExpression = GetCurrencyCode;
                //     AutoFormatType = 1;
                //     Caption = 'Balance';
                //     Editable = false;
                //     Enabled = BalanceEnable;
                // }
                // field(TotalBalance; Rec.TotalBalance + "Statement Amount")
                // {
                //     AutoFormatExpression = GetCurrencyCode;
                //     AutoFormatType = 1;
                //     Caption = 'Total Balance';
                //     Editable = false;
                //     Enabled = TotalBalanceEnable;
                // }
                // field(TotalDiff; Rec.TotalDiff + Difference)
                // {
                //     AutoFormatExpression = GetCurrencyCode;
                //     AutoFormatType = 1;
                //     Caption = 'Total Difference';
                //     Editable = false;
                //     Enabled = TotalDiffEnable;
                // }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ShowStatementLineDetails)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Details';
                RunObject = Page "Bank Statement Line Details";
                RunPageLink = "Data Exch. No." = FIELD("Data Exch. Entry No."),
                              "Line No." = FIELD("Data Exch. Line No.");
            }
            // action(ApplyEntries)
            // {
            //     Caption = '&Apply Entries...';
            //     Enabled = ApplyEntriesAllowed;
            //     Image = ApplyEntries;

            //     trigger OnAction()
            //     begin
            //         ApplyEntries;
            //     end;
            // }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        if Rec."Statement Line No." <> 0 then
            CalcBalance(Rec."Statement Line No.");
        SetUserInteractions;
    end;

    trigger OnAfterGetRecord()
    begin
        SetUserInteractions;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        SetUserInteractions;
    end;

    trigger OnInit()
    begin
        BalanceEnable := true;
        TotalBalanceEnable := true;
        TotalDiffEnable := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if BelowxRec then
            CalcBalance(xRec."Statement Line No.")
        else
            CalcBalance(xRec."Statement Line No." - 1);
    end;

    var
        BankAccRecon: Record "Bank Acc. Reconciliation";
        StyleTxt: Text;
        TotalDiff: Decimal;
        Balance: Decimal;
        TotalBalance: Decimal;

        TotalDiffEnable: Boolean;

        TotalBalanceEnable: Boolean;

        BalanceEnable: Boolean;
        ApplyEntriesAllowed: Boolean;

    local procedure CalcBalance(BankAccReconLineNo: Integer)
    var
        TempBankAccReconLine: Record "Bank Acc. Reconciliation Line";
    begin
        BankAccRecon.Get(Rec."Statement Type", Rec."Bank Account No.", Rec."Statement No.");

        TempBankAccReconLine.Copy(Rec);

        TotalDiff := -Rec.Difference;
        if TempBankAccReconLine.CalcSums(Difference) then begin
            TotalDiff := TotalDiff + TempBankAccReconLine.Difference;
            TotalDiffEnable := true;
        end else
            TotalDiffEnable := false;

        TotalBalance := BankAccRecon."Balance Last Statement" - Rec."Statement Amount";
        if TempBankAccReconLine.CalcSums("Statement Amount") then begin
            TotalBalance := TotalBalance + TempBankAccReconLine."Statement Amount";
            TotalBalanceEnable := true;
        end else
            TotalBalanceEnable := false;

        Balance := BankAccRecon."Balance Last Statement" - Rec."Statement Amount";
        TempBankAccReconLine.SetRange("Statement Line No.", 0, BankAccReconLineNo);
        if TempBankAccReconLine.CalcSums("Statement Amount") then begin
            Balance := Balance + TempBankAccReconLine."Statement Amount";
            BalanceEnable := true;
        end else
            BalanceEnable := false;
    end;



    //[Scope('OnPrem')]
    procedure GetSelectedRecords(var TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary)
    var
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
    begin
        CurrPage.SetSelectionFilter(BankAccReconciliationLine);
        if BankAccReconciliationLine.FindSet then
            repeat
                TempBankAccReconciliationLine := BankAccReconciliationLine;
                TempBankAccReconciliationLine.Insert;
            until BankAccReconciliationLine.Next = 0;
    end;

    local procedure SetUserInteractions()
    begin
        //StyleTxt := GetStyle;
        //ApplyEntriesAllowed := Rec.Type = Rec.Type::"Check Ledger Entry";
    end;

    //[Scope('OnPrem')]
    procedure ToggleMatchedFilter(SetFilterOn: Boolean)
    begin
        if SetFilterOn then
            Rec.SetFilter(Difference, '<>%1', 0)
        else
            Rec.Reset;
        CurrPage.Update;
    end;

    //[Scope('OnPrem')]
    procedure Mark_SelectedRecords(CurrBankAC: Code[20])
    var
        BRecLine_2: Record "Bank Acc. Reconciliation Line";
        CFM_003: Label 'Do you want to mark as Reconciled [ %1 ] Lines for bank account [ %2 ]?';
    begin
        CurrPage.SetSelectionFilter(BRecLine_2);

        if Confirm(CFM_003, false, BRecLine_2.Count, CurrBankAC) = false then Error('Aborted');

        if BRecLine_2.FindSet(true) then begin
            repeat
                BRecLine_2.Reconciled := true;
                BRecLine_2.Modify;
            until BRecLine_2.Next = 0;
        end;
    end;

    //[Scope('OnPrem')]
    procedure "Un-Mark_SelectedRecords"(CurrBankAC: Code[20])
    var
        BRecLine_2: Record "Bank Acc. Reconciliation Line";
        CFM_004: Label 'Do you want to Un-Mark as Reconciled [ %1 ] Lines for bank account [ %2 ]?';
    begin
        CurrPage.SetSelectionFilter(BRecLine_2);

        if Confirm(CFM_004, false, BRecLine_2.Count, CurrBankAC) = false then Error('Aborted');

        if BRecLine_2.FindSet(true) then begin
            repeat
                BRecLine_2.Reconciled := false;
                BRecLine_2.Modify;
            until BRecLine_2.Next = 0;
        end;
    end;
}

