codeunit 52187321 CustomPostCU
{
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnMoveGenJournalLine', '', false, false)]
    local procedure OnMoveGenJournalLines(var GenJournalLine: Record "Gen. Journal Line"; ToRecordID: RecordId)
    begin
    end;
    //Post Savings

    procedure PostSavings(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    var
        LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
        Cust: Record "Savings Accounts";
        CustPostingGr: Record "Customer Posting Group";
        CustLedgEntry: Record "Savings Ledger Entry";
        CVLedgEntryBuf: Record "CV Ledger Entry Buffer";
        TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer" temporary;
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        ReceivablesAccount: Code[20];
        DtldLedgEntryInserted: Boolean;
        members: Record Members;
        FIxedDepContracts: Record "Fixed Deposit Contract";
    begin
        InitNextEntryNos(Sender);
        Cust.GET(GenJournalLine."Account No.");
        LoanTypes.Get(Cust."Product Type");
        if LoanTypes."Product Category" = LoanTypes."Product Category"::"Fixed Deposit" then begin
            FIxedDepContracts.Reset();
            FIxedDepContracts.SetRange("No.", GenJournalLine."Fixed Deposit Contract");
            if not FIxedDepContracts.FindFirst() then begin
                Error('Fixed Deposit Contract must be specified for %1 account.', LoanTypes."Product Category");
            end;
        end;
#pragma warning disable AL0603
        if CopyStr(GenJournalLine."Document No.", 1, 3) <> 'DIV' then
            Cust.CheckBlockedCustOnJnls(Cust, GenJournalLine."Document Type", TRUE);
#pragma warning restore AL0603
        IF GenJournalLine."Posting Group" = '' THEN BEGIN
            cust."Customer Posting Group" := LoanTypes."Product Posting Group";
            Cust.modify;
            Cust.TESTFIELD("Customer Posting Group");
            GenJournalLine."Posting Group" := Cust."Customer Posting Group";
        END;

        CustPostingGr.GET(GenJournalLine."Posting Group");
        ReceivablesAccount := CustPostingGr.GetReceivablesAccount;

        CustLedgEntry.LOCKTABLE;

        InitSavingsLedgEntry(GenJournalLine, CustLedgEntry);
        CustLedgEntry."Posting Group" := GenJournalLine."Posting Group";
        // CustLedgEntry."Customer Posting Group" := GenJournalLine."Posting Group";
        CustLedgEntry."Member No." := Cust."Member No.";
        IF Cust."Currency Code" <> '' THEN
            CustLedgEntry.Amount := GenJournalLine.Amount
        ELSE
            CustLedgEntry.Amount := GenJournalLine."Amount (LCY)";
        CustLedgEntry."Amount (LCY)" := GenJournalLine."Amount (LCY)";
        CustLedgEntry.Open := GenJournalLine.Amount <> 0;
        CustLedgEntry."Remaining Amount" := CustLedgEntry.Amount;
        CustLedgEntry."Credit Amount" := GenJournalLine."Credit Amount";
        CustLedgEntry."Debit Amount (LCY)" := GenJournalLine."Debit Amount";
        CustLedgEntry."Credit Amount (LCY)" := GenJournalLine."Credit Amount";

        CustLedgEntry."Debit Amount" := GenJournalLine."Debit Amount";
        CustLedgEntry.Positive := GenJournalLine.Amount > 0;
        //CustLedgEntry.UpdateDebitCredit(Correction);
        CustLedgEntry."Date Modified" := Today;
        CustLedgEntry."Creation Date Time" := CurrentDateTime;
        CustLedgEntry."Creation Date" := Today;
        CustLedgEntry."Creation Time" := Time;
        CustLedgEntry."Posting Time" := time;
        CustLedgEntry.INSERT(TRUE);
        Sender.CreateGLEntryBalAcc(
            GenJournalLine, ReceivablesAccount, GenJournalLine."Amount (LCY)", GenJournalLine."Source Currency Amount",
           GenJournalLine."Bal. Account Type", GenJournalLine."Bal. Account No.");
        // GenJnlPost.DeferralPosting("Deferral Code", "Source Code", ReceivablesAccount, GenJournalLine, Balancing);
        OnMoveGenJournalLines(GenJournalLine, CustLedgEntry.RECORDID);
    end;

    local procedure InitSavingsLedgEntry(var GenJournalLine: Record "Gen. Journal Line"; var CustLedgEntry: Record "Savings Ledger Entry")

    begin
        // InitNextEntryNos();
        CustLedgEntry.INIT;
        CustLedgEntry.CopyFromGenJnlLine(GenJournalLine);
        CustLedgEntry."Entry No." := NextEntryNo;
        CustLedgEntry."Transaction No." := NextTransactionNo;
    end;

    //Credit Ledger Entry
    procedure PostCredit(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    var
        LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
        Cust: Record "Credit Accounts";
        CustPostingGr: Record "Customer Posting Group";
        CustLedgEntry: Record "Credit Ledger Entry";
        CVLedgEntryBuf: Record "CV Ledger Entry Buffer";
        TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer" temporary;
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        ReceivablesAccount: Code[20];
        DtldLedgEntryInserted: Boolean;
        members: Record Members;
        Loan: Record Loans;
        LoanTypes: Record "Product Factory";

    begin
        InitNextEntryNos(Sender);
        Cust.GET(GenJournalLine."Account No.");
        Loan.RESET;
        Loan.SETRANGE(Loan."Loan No.", GenJournalLine."Loan No");
        Loan.SetLoadFields("Loan Product Type");
        IF Loan.FindFirst() THEN
            ReceivablesAccount := LoanTypes.GetReceivablesAccount(Loan."Loan Product Type", GenJournalLine."Transaction Type");

        IF ReceivablesAccount = '' THEN
            ERROR('Transaction Type blocked for %1.', GenJournalLine."Account No.");

        CustLedgEntry.LOCKTABLE;

        InitCreditLedgEntry(GenJournalLine, CustLedgEntry);
        CustLedgEntry."Loan Type" := GenJournalLine."Loan Product Type";

        CustLedgEntry."Member No." := Cust."Member No.";
        CustLedgEntry."Transaction Type" := GenJournalLine."Transaction Type";
        CustLedgEntry."Loan No" := GenJournalLine."Loan No";
        CustLedgEntry."Customer Posting Group" := GenJournalLine."Posting Group";
        CustLedgEntry."Loan Span" := GenJournalLine."Loan Span";
        IF Cust."Currency Code" <> '' THEN
            CustLedgEntry.Amount := GenJournalLine.Amount
        ELSE
            CustLedgEntry.Amount := GenJournalLine."Amount (LCY)";
        CustLedgEntry."Amount (LCY)" := GenJournalLine."Amount (LCY)";
        CustLedgEntry.Open := GenJournalLine.Amount <> 0;
        CustLedgEntry."Remaining Amount" := CustLedgEntry.Amount;
        CustLedgEntry."Credit Amount" := GenJournalLine."Credit Amount";
        CustLedgEntry."Debit Amount (LCY)" := GenJournalLine."Debit Amount";
        CustLedgEntry."Credit Amount (LCY)" := GenJournalLine."Credit Amount";

        CustLedgEntry."Debit Amount" := GenJournalLine."Debit Amount";
        CustLedgEntry.Positive := GenJournalLine.Amount > 0;
        //CustLedgEntry.UpdateDebitCredit(Correction);
        CustLedgEntry."Date Modified" := Today;
        CustLedgEntry."Creation Date Time" := CurrentDateTime;
        CustLedgEntry."Creation Date" := Today;
        CustLedgEntry."Creation Time" := Time;
        CustLedgEntry."Posting Time" := time;
        CustLedgEntry.INSERT(TRUE);
        Sender.CreateGLEntryBalAcc(
            GenJournalLine, ReceivablesAccount, GenJournalLine."Amount (LCY)", GenJournalLine."Source Currency Amount",
           GenJournalLine."Bal. Account Type", GenJournalLine."Bal. Account No.");
        // GenJnlPost.DeferralPosting("Deferral Code", "Source Code", ReceivablesAccount, GenJournalLine, Balancing);
        OnMoveGenJournalLines(GenJournalLine, CustLedgEntry.RECORDID);
    end;

    local procedure InitCreditLedgEntry(var GenJournalLine: Record "Gen. Journal Line"; var CustLedgEntry: Record "Credit Ledger Entry")
    begin
        // InitNextEntryNos();
        CustLedgEntry.INIT;
        CustLedgEntry.CopyFromGenJnlLine(GenJournalLine);
        CustLedgEntry."Entry No." := NextEntryNo;
        CustLedgEntry."Transaction No." := NextTransactionNo;

    end;

    local procedure InitNextEntryNos(Sender: Codeunit "Gen. Jnl.-Post Line")
    var
        GLEntry: Record "G/L Entry";
        LastEntryNo: Integer;
        LastTransactionNo: Integer;
    begin
        //GLEntry.LockTable();
        // GLEntry.GetLastEntry(LastEntryNo, LastTransactionNo);
        NextEntryNo := Sender.GetNextEntryNo();
        NextTransactionNo := Sender.GetNextTransactionNo();
    end;


    var
        NextEntryNo: Integer;
        NextTransactionNo: Integer;
        LoanApp: Record Loans;
        LoanTypes: Record "Product Factory";
}