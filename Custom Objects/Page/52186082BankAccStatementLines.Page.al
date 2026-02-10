page 52186082 "Bank Acc. Statement Lines"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    Editable = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Bank Acc. Statement Line";
    SourceTableView = WHERE("Statement Type" = CONST("Bank Reconciliation"));


    layout
    {
        area(content)
        {
            repeater(Control14)
            {
                ShowCaption = false;
                field("Transaction Date"; Rec."Transaction Date")
                {
                    StyleExpr = StyleTxt;
                }
                field("Value Date"; Rec."Value Date")
                {
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Visible = false;
                }
                field("Check No."; Rec."Check No.")
                {
                    Visible = true;
                }
                field(Type; Rec.Type)
                {

                    trigger OnValidate()
                    begin
                        SetUserInteractions;
                    end;
                }
                field(Description; Rec.Description)
                {
                    StyleExpr = StyleTxt;
                }
                field("Statement Amount"; Rec."Statement Amount")
                {
                    StyleExpr = StyleTxt;
                }
                field("Applied Amount"; Rec."Applied Amount")
                {
                }
                field(Reconciled; Rec.Reconciled)
                {
                    Visible = false;
                }
                field(Difference; Rec.Difference)
                {
                }
                field("Applied Entries"; Rec."Applied Entries")
                {
                    Visible = false;
                }
                field("Related-Party Name"; Rec."Related-Party Name")
                {
                    Visible = false;
                }
                field("Additional Transaction Info"; Rec."Additional Transaction Info")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ShowStatementLineDetails)
            {
                Caption = 'Details';
                RunObject = Page "Bank Statement Line Details";
                RunPageLink = "Data Exch. No." = FIELD("Data Exch. Entry No."),
                              "Line No." = FIELD("Data Exch. Line No.");
                Visible = false;
            }
            // action(ApplyEntries)
            // {
            //     Caption = '&Apply Entries...';
            //     Enabled = ApplyEntriesAllowed;
            //     Image = ApplyEntries;
            //     Visible = false;

            //     trigger OnAction()
            //     begin
            //         ApplyEntries;
            //     end;
            // }
        }
    }

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
        /*
        IF BankAccRecon.GET("Statement Type","Bank Account No.","Statement No.") THEN;
        
        TempBankAccReconLine.COPY(Rec);
        
        TotalDiff := -Difference;
        IF TempBankAccReconLine.CALCSUMS(Difference) THEN BEGIN
          TotalDiff := TotalDiff + TempBankAccReconLine.Difference;
          TotalDiffEnable := TRUE;
        END ELSE
          TotalDiffEnable := FALSE;
        
        TotalBalance := BankAccRecon."Balance Last Statement" - "Statement Amount";
        IF TempBankAccReconLine.CALCSUMS("Statement Amount") THEN BEGIN
          TotalBalance := TotalBalance + TempBankAccReconLine."Statement Amount";
          TotalBalanceEnable := TRUE;
        END ELSE
          TotalBalanceEnable := FALSE;
        
        Balance := BankAccRecon."Balance Last Statement" - "Statement Amount";
        TempBankAccReconLine.SETRANGE("Statement Line No.",0,BankAccReconLineNo);
        IF TempBankAccReconLine.CALCSUMS("Statement Amount") THEN BEGIN
          Balance := Balance + TempBankAccReconLine."Statement Amount";
          BalanceEnable := TRUE;
        END ELSE
          BalanceEnable := FALSE;
        */

    end;



    //[Scope('OnPrem')]
    procedure GetSelectedRecords(var TempBankAccReconciliationLine: Record "Bank Acc. Statement Line" temporary)
    var
        BankAccReconciliationLine: Record "Bank Acc. Statement Line";
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
        StyleTxt := Rec.GetStyle;
        ApplyEntriesAllowed := Rec.Type = Rec.Type::"Check Ledger Entry";
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
}

