#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186418 tableextension52186418 extends "Reversal Entry"
{
    procedure AutoReverseRegister(RegisterNo: Integer)
    var
        GLReg: Record "G/L Register";
    begin
        if UserSetup.Get(UserId) then
            if UserSetup."Post Reversals" = false then
                Error('You donnot have permission to do a reversal');
        GLReg.Get(RegisterNo);
        // if GLReg.Reversed then
        //   Error(Text010,GLReg.TableCaption,GLReg."No.");
        if GLReg."Journal Batch Name" = '' then
            ReversalEntry.TestFieldError;

        AutoReverseEntries(RegisterNo, Rec."reversal type"::Register);
    end;

    local procedure AutoReverseEntries(Number: Integer; RevType: Option Transaction,Register)
    var
        ReversalPost: Codeunit "Silent Reversal-Post";
    begin
        HideDialog := true;
        //Reversals
        ReversalEntry.SetCurrentkey("Document No.", "Posting Date", "Entry Type", "Entry No.");
        if not HideDialog then
            Page.RunModal(Page::"Reverse Transaction Entries", ReversalEntry)
        else begin
            ReversalPost.SetPrint(false);
            ReversalPost.Run(ReversalEntry);
        end;
        ReversalEntry.DeleteAll;
    end;

    procedure CheckSavAcc(SavLedger: Record "Savings Ledger Entry")
    var
        SavAcc: Record "Savings Accounts";
    begin
        SavAcc.GET(SavLedger."Customer No.");
        CheckPostingDates(
          SavLedger."Posting Date", SavLedger.TableCaption(), SavLedger."Entry No.");
        SavAcc.CheckBlockedCustOnJnls(SavAcc, SavLedger."Document Type", false);
        if SavLedger.Reversed then
            AlreadyReversedEntry(SavLedger.TableCaption(), SavLedger."Entry No.");
        IF SavLedger.Reversed THEN
            AlreadyReversedEntry(SavLedger.TABLECAPTION, SavLedger."Entry No.");
    end;

    procedure CheckPostingDates(PostingDate: Date; Caption: Text[50]; EntryNo: Integer)
    var
        IsHandled: Boolean;
    begin
        if GenJnlCheckLine.DateNotAllowed(PostingDate) then
            Error(Text001, Caption, EntryNo);
        if PostingDate > MaxPostingDate then
            MaxPostingDate := PostingDate;
    end;

    procedure ShowSavingAccLedgEntries()
    begin
        PAGE.Run(0, SavingsLedgEntry);
    end;

    procedure ShowCreditAccLedgEntries()
    begin
        PAGE.Run(0, CreditLedgEntry);
    end;

    procedure InsertFromSavingsLedgEntry(var TempRevertTransactionNo: Record "Integer" temporary; Number: Integer; RevType: Option Transaction,Register; var NextLineNo: Integer)
    var
        Cust: Record "Savings Accounts";
        CustLedgEntry: Record "Savings Ledger Entry";
    begin
        CustLedgEntry.SetCurrentKey("Transaction No.", "Customer No.");
        if CustLedgEntry.FindSet() then
            repeat
                CustLedgEntry.SetRange("Transaction No.", CustLedgEntry."Transaction No.");
                CustLedgEntry.SetRange("Customer No.", CustLedgEntry."Customer No.");
                if (not CustLedgEntry.IsEmpty) and (RevType = RevType::Register) then
                    Error(PostedAndAppliedSameTransactionErr, Number);

                Clear(TempReversalEntry);
                if RevType = RevType::Register then
                    TempReversalEntry."G/L Register No." := Number;
                TempReversalEntry."Reversal Type" := RevType;
                TempReversalEntry."Entry Type" := TempReversalEntry."Entry Type"::Savings;
                Cust.Get(CustLedgEntry."Customer No.");
                TempReversalEntry."Account No." := Cust."No.";
                TempReversalEntry."Account Name" := Cust.Name;
                TempReversalEntry.CopyFromSavingsLedgEntry(CustLedgEntry);
                TempReversalEntry."Line No." := NextLineNo;
                NextLineNo := NextLineNo + 1;
                TempReversalEntry.Insert();

            until CustLedgEntry.Next() = 0;

    end;

    procedure CopyFromSavingsLedgEntry(CustLedgEntry: Record "Savings Ledger Entry")
    begin
        "Entry No." := CustLedgEntry."Entry No.";
        "Posting Date" := CustLedgEntry."Posting Date";
        "Source Code" := CustLedgEntry."Source Code";
        "Journal Batch Name" := CustLedgEntry."Journal Batch Name";
        "Transaction No." := CustLedgEntry."Transaction No.";
        //"Currency Code" := CustLedgEntry."Currency Code";
        Description := CustLedgEntry.Description;
        CustLedgEntry.CalcFields(Amount, "Debit Amount", "Credit Amount",
          "Amount (LCY)", "Debit Amount (LCY)", "Credit Amount (LCY)");
        Amount := CustLedgEntry.Amount;
        "Debit Amount" := CustLedgEntry."Debit Amount";
        "Credit Amount" := CustLedgEntry."Credit Amount";
        "Amount (LCY)" := CustLedgEntry."Amount (LCY)";
        "Debit Amount (LCY)" := CustLedgEntry."Debit Amount (LCY)";
        "Credit Amount (LCY)" := CustLedgEntry."Credit Amount (LCY)";
        "Document Type" := CustLedgEntry."Document Type";
        "Document No." := CustLedgEntry."Document No.";
        "Bal. Account Type" := CustLedgEntry."Bal. Account Type";
        "Bal. Account No." := CustLedgEntry."Bal. Account No.";
    end;

    var
        UserSetup: Record "User Setup";
        ReversalEntry: Record "Reversal Entry" temporary;
        GenJnlCheckLine: Codeunit "Gen. Jnl.-Check Line";
        SavingsLedgEntry: Record "Savings Ledger Entry";
        CreditLedgEntry: Record "Credit Ledger Entry";
        Text001: Label 'You cannot reverse %1 No. %2 because the posting date is not within the allowed posting period.';
        Text002: Label 'You cannot reverse the transaction because it is out of balance.';
        Text003: Label 'You cannot reverse %1 No. %2 because the entry has a related check ledger entry.';
        Text004: Label 'You can only reverse entries that were posted from a journal.';
        Text005: Label 'You cannot reverse %1 No. %2 because the %3 is not within the allowed posting period.';
        Text006: Label 'You cannot reverse %1 No. %2 because the entry is closed.';
        Text007: Label 'You cannot reverse %1 No. %2 because the entry is included in a bank account reconciliation line. The bank reconciliation has not yet been posted.';
        Text008: Label 'You cannot reverse the transaction because the %1 has been sold.';
        CannotReverseDeletedErr: Label 'The transaction cannot be reversed, because the %1 has been compressed or a %2 has been deleted.', Comment = '%1 and %2 = table captions';
        Text010: Label 'You cannot reverse %1 No. %2 because the register has already been involved in a reversal.';
        Text011: Label 'You cannot reverse %1 No. %2 because the entry has already been involved in a reversal.';
        PostedAndAppliedSameTransactionErr: Label 'You cannot reverse register number %1 because it contains customer or vendor or employee ledger entries that have been posted and applied in the same transaction.\\You must reverse each transaction in register number %1 separately.', Comment = '%1="G/L Register No."';
        Text013: Label 'You cannot reverse %1 No. %2 because the entry has an associated Realized Gain/Loss entry.';
        UnrealizedVATReverseErr: Label 'You cannot reverse %1 No. %2 because the entry has an associated Unrealized VAT Entry.';

}
