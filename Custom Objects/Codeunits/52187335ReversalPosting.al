codeunit 52187335 "Reversal Posting"
{
    SingleInstance = true;
    EventSubscriberInstance = StaticAutomatic;

    var
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        CreditLedgerEntry: Record "Credit Ledger Entry";
        TempSavingsLedgerEntryII: Record "Savings Ledger Entry" temporary;
        TempCreditLedgerEntryII: Record "Credit Ledger Entry" temporary;
        CannotReverseErr: Label 'You cannot reverse the transaction, because it has already been reversed.';

    //Reversals
    [EventSubscriber(ObjectType::Table, Database::"Reversal Entry", 'OnAfterSetReverseFilter', '', false, false)]
    //subscribe to set reversal filter
    local procedure OnAfterSetReverseFilter(Number: Integer; RevType: Option Transaction,Register; GLRegister: Record "G/L Register")
    var

    begin
        case RevType of
            RevType::Transaction:
                begin
                    SavingsLedgerEntry.SetCurrentKey("Transaction No.");
                    CreditLedgerEntry.SetCurrentKey("Transaction No.");
                    SavingsLedgerEntry.SetRange("Transaction No.", Number);
                    CreditLedgerEntry.SetRange("Transaction No.", Number);
                    CopyFiltersIntoTempTables();
                end;
            RevType::Register:
                begin
                    GLRegister.Get(Number);
                    SavingsLedgerEntry.SetRange("Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");
                    CreditLedgerEntry.SetRange("Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");
                    CopyFiltersIntoTempTables();
                end;
        end;
    end;

    local procedure CopyFiltersIntoTempTables()
    begin
        TempCreditLedgerEntryII.Reset();
        TempCreditLedgerEntryII.DeleteAll();
        TempSavingsLedgerEntryII.Reset();
        TempSavingsLedgerEntryII.DeleteAll();
        if SavingsLedgerEntry.FindSet() then
            repeat
                if SavingsLedgerEntry."Reversed by Entry No." <> 0 then
                    Error(CannotReverseErr);
                TempSavingsLedgerEntryII := SavingsLedgerEntry;
                TempSavingsLedgerEntryII.Insert();
            until SavingsLedgerEntry.Next() = 0;

        if CreditLedgerEntry.FindSet() then
            repeat
                if CreditLedgerEntry."Reversed by Entry No." <> 0 then
                    Error(CannotReverseErr);
                //TempCreditLedgerEntryII."Entry No." := CreditLedgerEntry."Entry No.";
                TempCreditLedgerEntryII."Entry No." := CreditLedgerEntry."Entry No.";
                TempCreditLedgerEntryII."Customer No." := CreditLedgerEntry."Customer No.";
                TempCreditLedgerEntryII."Posting Date" := CreditLedgerEntry."Posting Date";
                TempCreditLedgerEntryII."Document Type" := CreditLedgerEntry."Document Type";
                TempCreditLedgerEntryII."Document No." := CreditLedgerEntry."Document No.";
                TempCreditLedgerEntryII."Description" := CreditLedgerEntry."Description";

                TempCreditLedgerEntryII."Currency Code" := CreditLedgerEntry."Currency Code";
                TempCreditLedgerEntryII."Amount" := CreditLedgerEntry."Amount";
                TempCreditLedgerEntryII."Remaining Amount" := CreditLedgerEntry."Remaining Amount";
                TempCreditLedgerEntryII."Original Amt. (LCY)" := CreditLedgerEntry."Original Amt. (LCY)";
                TempCreditLedgerEntryII."Remaining Amt. (LCY)" := CreditLedgerEntry."Remaining Amt. (LCY)";
                TempCreditLedgerEntryII."Amount (LCY)" := CreditLedgerEntry."Amount (LCY)";
                TempCreditLedgerEntryII."Sales (LCY)" := CreditLedgerEntry."Sales (LCY)";
                TempCreditLedgerEntryII."Profit (LCY)" := CreditLedgerEntry."Profit (LCY)";

                TempCreditLedgerEntryII."Inv. Discount (LCY)" := CreditLedgerEntry."Inv. Discount (LCY)";
                TempCreditLedgerEntryII."Sell-to Customer No." := CreditLedgerEntry."Sell-to Customer No.";
                TempCreditLedgerEntryII."Customer Posting Group" := CreditLedgerEntry."Customer Posting Group";
                TempCreditLedgerEntryII."Global Dimension 1 Code" := CreditLedgerEntry."Global Dimension 1 Code";
                TempCreditLedgerEntryII."Global Dimension 2 Code" := CreditLedgerEntry."Global Dimension 2 Code";
                TempCreditLedgerEntryII."Salesperson Code" := CreditLedgerEntry."Salesperson Code";
                TempCreditLedgerEntryII."User ID" := CreditLedgerEntry."User ID";
                TempCreditLedgerEntryII."Source Code" := CreditLedgerEntry."Source Code";
                TempCreditLedgerEntryII."On Hold" := CreditLedgerEntry."On Hold";
                TempCreditLedgerEntryII."Applies-to Doc. Type" := CreditLedgerEntry."Applies-to Doc. Type";
                TempCreditLedgerEntryII."Applies-to Doc. No." := CreditLedgerEntry."Applies-to Doc. No.";
                TempCreditLedgerEntryII."Open" := CreditLedgerEntry."Open";
                TempCreditLedgerEntryII."Due Date" := CreditLedgerEntry."Due Date";
                TempCreditLedgerEntryII."Pmt. Discount Date" := CreditLedgerEntry."Pmt. Discount Date";
                TempCreditLedgerEntryII."Original Pmt. Disc. Possible" := CreditLedgerEntry."Original Pmt. Disc. Possible";
                TempCreditLedgerEntryII."Pmt. Disc. Given (LCY)" := CreditLedgerEntry."Pmt. Disc. Given (LCY)";
                TempCreditLedgerEntryII."Positive" := CreditLedgerEntry."Positive";
                TempCreditLedgerEntryII."Closed by Entry No." := CreditLedgerEntry."Closed by Entry No.";
                TempCreditLedgerEntryII."Closed at Date" := CreditLedgerEntry."Closed at Date";
                TempCreditLedgerEntryII."Closed by Amount" := CreditLedgerEntry."Closed by Amount";
                TempCreditLedgerEntryII."Applies-to ID" := CreditLedgerEntry."Applies-to ID";
                TempCreditLedgerEntryII."Journal Batch Name" := CreditLedgerEntry."Journal Batch Name";
                TempCreditLedgerEntryII."Reason Code" := CreditLedgerEntry."Reason Code";
                TempCreditLedgerEntryII."Bal. Account Type" := CreditLedgerEntry."Bal. Account Type";
                TempCreditLedgerEntryII."Bal. Account No." := CreditLedgerEntry."Bal. Account No.";
                TempCreditLedgerEntryII."Transaction No." := CreditLedgerEntry."Transaction No.";
                TempCreditLedgerEntryII."Closed by Amount (LCY)" := CreditLedgerEntry."Closed by Amount (LCY)";
                TempCreditLedgerEntryII."Debit Amount" := CreditLedgerEntry."Debit Amount";
                TempCreditLedgerEntryII."Credit Amount" := CreditLedgerEntry."Credit Amount";
                TempCreditLedgerEntryII."Debit Amount (LCY)" := CreditLedgerEntry."Debit Amount (LCY)";
                TempCreditLedgerEntryII."Credit Amount (LCY)" := CreditLedgerEntry."Credit Amount (LCY)";
                TempCreditLedgerEntryII."Document Date" := CreditLedgerEntry."Document Date";
                TempCreditLedgerEntryII."External Document No." := CreditLedgerEntry."External Document No.";
                TempCreditLedgerEntryII."Calculate Interest" := CreditLedgerEntry."Calculate Interest";
                TempCreditLedgerEntryII."Closing Interest Calculated" := CreditLedgerEntry."Closing Interest Calculated";
                TempCreditLedgerEntryII."No. Series" := CreditLedgerEntry."No. Series";
                TempCreditLedgerEntryII."Closed by Currency Code" := CreditLedgerEntry."Closed by Currency Code";
                TempCreditLedgerEntryII."Closed by Currency Amount" := CreditLedgerEntry."Closed by Currency Amount";
                TempCreditLedgerEntryII."Adjusted Currency Factor" := CreditLedgerEntry."Adjusted Currency Factor";
                TempCreditLedgerEntryII."Original Currency Factor" := CreditLedgerEntry."Original Currency Factor";
                TempCreditLedgerEntryII."Original Amount" := CreditLedgerEntry."Original Amount";
                TempCreditLedgerEntryII."Date Filter" := CreditLedgerEntry."Date Filter";
                TempCreditLedgerEntryII."Remaining Pmt. Disc. Possible" := CreditLedgerEntry."Remaining Pmt. Disc. Possible";
                TempCreditLedgerEntryII."Pmt. Disc. Tolerance Date" := CreditLedgerEntry."Pmt. Disc. Tolerance Date";
                TempCreditLedgerEntryII."Max. Payment Tolerance" := CreditLedgerEntry."Max. Payment Tolerance";
                TempCreditLedgerEntryII."Last Issued Reminder Level" := CreditLedgerEntry."Last Issued Reminder Level";
                TempCreditLedgerEntryII."Accepted Payment Tolerance" := CreditLedgerEntry."Accepted Payment Tolerance";
                TempCreditLedgerEntryII."Accepted Pmt. Disc. Tolerance" := CreditLedgerEntry."Accepted Pmt. Disc. Tolerance";
                TempCreditLedgerEntryII."Pmt. Tolerance (LCY)" := CreditLedgerEntry."Pmt. Tolerance (LCY)";
                TempCreditLedgerEntryII."Amount to Apply" := CreditLedgerEntry."Amount to Apply";
                TempCreditLedgerEntryII."IC Partner Code" := CreditLedgerEntry."IC Partner Code";
                TempCreditLedgerEntryII."Applying Entry" := CreditLedgerEntry."Applying Entry";

                TempCreditLedgerEntryII."Reversed" := CreditLedgerEntry."Reversed";
                TempCreditLedgerEntryII."Reversed by Entry No." := CreditLedgerEntry."Reversed by Entry No.";
                TempCreditLedgerEntryII."Reversed Entry No." := CreditLedgerEntry."Reversed Entry No.";
                TempCreditLedgerEntryII."Prepayment" := CreditLedgerEntry."Prepayment";
                TempCreditLedgerEntryII."Loan No" := CreditLedgerEntry."Loan No";

                TempCreditLedgerEntryII."Group Code" := CreditLedgerEntry."Group Code";
                TempCreditLedgerEntryII."Member Name" := CreditLedgerEntry."Member Name";
                TempCreditLedgerEntryII."Loan Type" := CreditLedgerEntry."Loan Type";
                TempCreditLedgerEntryII."Prepayment Date" := CreditLedgerEntry."Prepayment Date";
                // Message(Format(CreditLedgerEntry."Transaction Type"));
                TempCreditLedgerEntryII."Transaction Type Narration" := Format(CreditLedgerEntry."Transaction Type");
                //TempCreditLedgerEntryII."Transaction Type" := TempCreditLedgerEntryII."Transaction Type"::Repayment;
                TempCreditLedgerEntryII."Bulk Process" := CreditLedgerEntry."Bulk Process";

                TempCreditLedgerEntryII."Posting Time" := CreditLedgerEntry."Posting Time";
                TempCreditLedgerEntryII."Approver ID" := CreditLedgerEntry."Approver ID";
                TempCreditLedgerEntryII."Member No." := CreditLedgerEntry."Member No.";
                TempCreditLedgerEntryII."Loan Span" := CreditLedgerEntry."Loan Span";
                TempCreditLedgerEntryII."Dimension Set ID" := CreditLedgerEntry."Dimension Set ID";
                TempCreditLedgerEntryII."SASRA Loan Status" := CreditLedgerEntry."SASRA Loan Status";


                TempCreditLedgerEntryII.Insert();
            until CreditLedgerEntry.Next() = 0;
    end;

    local procedure CopyFromSavingsLedgEntry(var TempReversalEntry: Record "Reversal Entry" temporary; SavingsLedgEntry: Record "Savings Ledger Entry")
    begin
        TempReversalEntry."Entry No." := SavingsLedgEntry."Entry No.";
        TempReversalEntry."Posting Date" := SavingsLedgEntry."Posting Date";
        TempReversalEntry."Source Code" := SavingsLedgEntry."Source Code";
        TempReversalEntry."Journal Batch Name" := SavingsLedgEntry."Journal Batch Name";
        TempReversalEntry."Transaction No." := SavingsLedgEntry."Transaction No.";
        TempReversalEntry."Currency Code" := SavingsLedgEntry."Currency Code.";
        TempReversalEntry.Description := SavingsLedgEntry.Description;
        TempReversalEntry.Amount := SavingsLedgEntry.Amount;
        TempReversalEntry."Debit Amount" := SavingsLedgEntry."Debit Amount";
        TempReversalEntry."Credit Amount" := SavingsLedgEntry."Credit Amount";
        TempReversalEntry."Amount (LCY)" := SavingsLedgEntry."Amount (LCY)";
        TempReversalEntry."Debit Amount (LCY)" := SavingsLedgEntry."Debit Amount (LCY)";
        TempReversalEntry."Credit Amount (LCY)" := SavingsLedgEntry."Credit Amount (LCY)";
        TempReversalEntry."Document Type" := SavingsLedgEntry."Document Type";
        TempReversalEntry."Document No." := SavingsLedgEntry."Document No.";
        TempReversalEntry."Bal. Account Type" := SavingsLedgEntry."Bal. Account Type";
        TempReversalEntry."Bal. Account No." := SavingsLedgEntry."Bal. Account No.";
    end;

    local procedure InsertFromSavingsLedgerEntry(var TempRevertTransactionNo: Record "Integer"; Number: Integer; RevType: Option Transaction,Register; var NextLineNo: Integer; var TempReversalEntry: Record "Reversal Entry" temporary)
    var
        SavingsAccounts: Record "Savings Accounts";
    begin
        If SavingsLedgerEntry.FindSet() then
            repeat
                Clear(TempReversalEntry);
                if RevType = RevType::Register then
                    TempReversalEntry."G/L Register No." := Number;
                TempReversalEntry."Reversal Type" := RevType;
                TempReversalEntry."Entry Type" := TempReversalEntry."Entry Type"::Savings;
                SavingsAccounts.Get(SavingsLedgerEntry."Customer No.");
                TempReversalEntry."Account No." := SavingsAccounts."No.";
                TempReversalEntry."Account Name" := SavingsAccounts.Name;
                CopyFromSavingsLedgEntry(TempReversalEntry, SavingsLedgerEntry);
                TempReversalEntry."Line No." := NextLineNo;
                NextLineNo := NextLineNo + 1;
                TempReversalEntry.Insert();
            until SavingsLedgerEntry.Next() = 0;
    end;

    local procedure CopyFromCreditLedgEntry(var TempReversalEntry: Record "Reversal Entry" temporary; CreditLedgerEntry: Record "Credit Ledger Entry")
    begin
        TempReversalEntry."Entry No." := CreditLedgerEntry."Entry No.";
        TempReversalEntry."Posting Date" := CreditLedgerEntry."Posting Date";
        TempReversalEntry."Source Code" := CreditLedgerEntry."Source Code";
        TempReversalEntry."Journal Batch Name" := CreditLedgerEntry."Journal Batch Name";
        TempReversalEntry."Transaction No." := CreditLedgerEntry."Transaction No.";
        TempReversalEntry."Currency Code" := CreditLedgerEntry."Currency Code";
        TempReversalEntry.Description := CreditLedgerEntry.Description;
        TempReversalEntry.Amount := CreditLedgerEntry.Amount;
        TempReversalEntry."Debit Amount" := CreditLedgerEntry."Debit Amount";
        TempReversalEntry."Credit Amount" := CreditLedgerEntry."Credit Amount";
        TempReversalEntry."Amount (LCY)" := CreditLedgerEntry."Amount (LCY)";
        TempReversalEntry."Debit Amount (LCY)" := CreditLedgerEntry."Debit Amount (LCY)";
        TempReversalEntry."Credit Amount (LCY)" := CreditLedgerEntry."Credit Amount (LCY)";
        TempReversalEntry."Document Type" := CreditLedgerEntry."Document Type";
        TempReversalEntry."Document No." := CreditLedgerEntry."Document No.";
        TempReversalEntry."Bal. Account Type" := CreditLedgerEntry."Bal. Account Type";
        TempReversalEntry."Bal. Account No." := CreditLedgerEntry."Bal. Account No.";
    end;

    local procedure InsertFromCreditLedgerEntry(var TempRevertTransactionNo: Record "Integer"; Number: Integer; RevType: Option Transaction,Register; var NextLineNo: Integer; var TempReversalEntry: Record "Reversal Entry" temporary)
    var
        CreditAccount: Record "Credit Accounts";
    begin
        If CreditLedgerEntry.FindSet() then
            repeat
                Clear(TempReversalEntry);
                if RevType = RevType::Register then
                    TempReversalEntry."G/L Register No." := Number;
                TempReversalEntry."Reversal Type" := RevType;
                TempReversalEntry."Entry Type" := TempReversalEntry."Entry Type"::Credit;
                CreditAccount.Get(CreditLedgerEntry."Customer No.");
                TempReversalEntry."Account No." := CreditAccount."No.";
                TempReversalEntry."Account Name" := CreditAccount.Name;
                CopyFromCreditLedgEntry(TempReversalEntry, CreditLedgerEntry);
                TempReversalEntry."Line No." := NextLineNo;
                NextLineNo := NextLineNo + 1;
                TempReversalEntry.Insert();
            until CreditLedgerEntry.Next() = 0;
    end;
    //setreverrsal entries
    [EventSubscriber(ObjectType::Table, Database::"Reversal Entry", 'OnAfterInsertReversalEntry', '', false, false)]
    local procedure OnAfterInsertReversalEntry(var TempRevertTransactionNo: Record "Integer"; Number: Integer; RevType: Option Transaction,Register; var NextLineNo: Integer; var TempReversalEntry: Record "Reversal Entry" temporary)
    var
        GlReg: Record "G/L Register";
    begin

        //OnAfterSetReverseFilter(Number, RevType);
        InsertFromSavingsLedgerEntry(TempRevertTransactionNo, Number, RevType, NextLineNo, TempReversalEntry);
        InsertFromCreditLedgerEntry(TempRevertTransactionNo, Number, RevType, NextLineNo, TempReversalEntry);

    end;

    local procedure CheckPostingDate(PostingDate: Date; Caption: Text[50]; EntryNo: Integer; var MaxPostingDate: Date)
    var
        IsHandled: Boolean;
        GenJnlCheckLine: Codeunit "Gen. Jnl.-Check Line";
        Text001: Label 'You cannot reverse %1 No. %2 because the posting date is not within the allowed posting period.';
    begin
        IsHandled := false;
        // OnBeforeCheckPostingDate(PostingDate, Caption, EntryNo, IsHandled);
        if IsHandled then
            exit;

        if GenJnlCheckLine.DateNotAllowed(PostingDate) then
            Error(Text001, Caption, EntryNo);
        if PostingDate > MaxPostingDate then
            MaxPostingDate := PostingDate;
    end;

    local procedure CheckSavings(SavLedg: Record "Savings Ledger Entry"; var MaxPostingDate: Date)
    var
        SavAcc: Record "Savings Accounts";
        ReversalEntry: Record "Reversal Entry";
    begin
        SavAcc.Get(SavLedg."Customer No.");
        CheckPostingDate(
          SavLedg."Posting Date", SavLedg.TableCaption, SavLedg."Entry No.", MaxPostingDate);
        SavAcc.CheckBlockedCustOnJnls(SavAcc, SavLedg."Document Type", false);
        if SavLedg.Reversed then
            ReversalEntry.AlreadyReversedEntry(SavLedg.TableCaption, SavLedg."Entry No.");

    end;

    local procedure CheckCredit(CredLedg: Record "Credit Ledger Entry"; var MaxPostingDate: Date)
    var
        CredAcc: Record "Credit Accounts";
        ReversalEntry: Record "Reversal Entry";
    begin
        CredAcc.Get(CredLedg."Customer No.");
        CheckPostingDate(
          CredLedg."Posting Date", CredLedg.TableCaption, CredLedg."Entry No.", MaxPostingDate);
        CredAcc.CheckBlockedCustOnJnls(CredAcc, CredLedg."Document Type", false);
        if CredLedg.Reversed then
            ReversalEntry.AlreadyReversedEntry(CredLedg.TableCaption, CredLedg."Entry No.");
    end;

    local procedure CheckDimComb(EntryNo: Integer; DimSetID: Integer; TableID1: Integer; AccNo1: Code[20]; TableID2: Integer; AccNo2: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
        TableID: array[10] of Integer;
        AccNo: array[10] of Code[20];
        DimCombBlockedErr: Label 'The combination of dimensions used in general ledger entry %1 is blocked. %2.';
    begin
        if not DimMgt.CheckDimIDComb(DimSetID) then
            Error(DimCombBlockedErr, EntryNo, DimMgt.GetDimCombErr);
        Clear(TableID);
        Clear(AccNo);
        TableID[1] := TableID1;
        AccNo[1] := AccNo1;
        TableID[2] := TableID2;
        AccNo[2] := AccNo2;
        if not DimMgt.CheckDimValuePosting(TableID, AccNo, DimSetID) then
            Error(DimMgt.GetDimValuePostingErr);
    end;

    //onbefore checkentries// added check savings & Credit
    [EventSubscriber(ObjectType::Table, Database::"Reversal Entry", 'OnAfterCheckEntries', '', false, false)]
    local procedure OnAfterCheckEntries(var MaxPostingDate: Date)
    begin
        if SavingsLedgerEntry.Find('-') then
            repeat
                CheckSavings(SavingsLedgerEntry, MaxPostingDate);
            until SavingsLedgerEntry.Next() = 0;
        if CreditLedgerEntry.Find('-') then
            repeat
                CheckCredit(CreditLedgerEntry, MaxPostingDate);
            until CreditLedgerEntry.Next() = 0;

    end;

    local procedure ReverseSavingsLedgEntry(SavingsLedgerEntry: Record "Savings Ledger Entry"; NewEntryNo: Integer; SourceCode: Code[10]; GenJnlLine: Record "Gen. Journal Line"; NextTransNo: Integer)
    var
        NewSavingsLedgerEntry: Record "Savings Ledger Entry";
        ReversedSavingsLedgerEntry: Record "Savings Ledger Entry";
        ReversalPost: Codeunit "Gen. Jnl.-Post Reverse";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    begin

        NewSavingsLedgerEntry := SavingsLedgerEntry;
        NewSavingsLedgerEntry.Amount := -NewSavingsLedgerEntry.Amount;
        NewSavingsLedgerEntry."Remaining Amount" := -NewSavingsLedgerEntry."Remaining Amount";
        NewSavingsLedgerEntry."Amount (LCY)" := -NewSavingsLedgerEntry."Amount (LCY)";
        NewSavingsLedgerEntry."Debit Amount" := -NewSavingsLedgerEntry."Debit Amount";
        NewSavingsLedgerEntry."Credit Amount" := -NewSavingsLedgerEntry."Credit Amount";
        NewSavingsLedgerEntry."Debit Amount (LCY)" := -NewSavingsLedgerEntry."Debit Amount (LCY)";
        NewSavingsLedgerEntry."Credit Amount (LCY)" := -NewSavingsLedgerEntry."Credit Amount (LCY)";
        //NewSavingsLedgerEntry."Entry Type" := NewSavingsLedgerEntry."Entry Type";
        NewSavingsLedgerEntry.Positive := NOT NewSavingsLedgerEntry.Positive;
        NewSavingsLedgerEntry."User ID" := USERID;
        NewSavingsLedgerEntry."Entry No." := NewEntryNo;
        NewSavingsLedgerEntry."Transaction No." := NextTransNo;
        NewSavingsLedgerEntry."Journal Batch Name" := '';
        NewSavingsLedgerEntry."Source Code" := SourceCode;
        //ReversalPost.SetReversalDescription(SavingsLedgerEntry, NewSavingsLedgerEntry.Description);
        NewSavingsLedgerEntry."Reversed Entry No." := SavingsLedgerEntry."Entry No.";
        NewSavingsLedgerEntry.Reversed := TRUE;
        // Reversal of Reversal
        IF SavingsLedgerEntry."Reversed Entry No." <> 0 THEN BEGIN
            ReversedSavingsLedgerEntry.GET(SavingsLedgerEntry."Reversed Entry No.");
            ReversedSavingsLedgerEntry."Reversed by Entry No." := 0;
            ReversedSavingsLedgerEntry.Reversed := FALSE;
            ReversedSavingsLedgerEntry.MODIFY;
            SavingsLedgerEntry."Reversed Entry No." := NewSavingsLedgerEntry."Entry No.";
            NewSavingsLedgerEntry."Reversed by Entry No." := SavingsLedgerEntry."Entry No.";
        END;
        SavingsLedgerEntry."Reversed by Entry No." := NewSavingsLedgerEntry."Entry No.";
        // SavingsLedgerEntry."Entry Type" := NewSavingsLedgerEntry."Entry Type";
        SavingsLedgerEntry.Reversed := TRUE;
        SavingsLedgerEntry.MODIFY;
        // OnReverseSavingsLedgEntryOnBeforeInsert(NewSavingsLedgerEntry, SavingsLedgerEntry);
        NewSavingsLedgerEntry.INSERT;

    end;

    local procedure ReverseCreditLedgEntry(CreditLedgerEntry: Record "Credit Ledger Entry"; NewEntryNo: Integer; SourceCode: Code[10]; GenJnlLine: Record "Gen. Journal Line"; NextTransNo: Integer)
    var
        NewCreditLedgerEntry: Record "Credit Ledger Entry";
        ReversedCreditLedgerEntry: Record "Credit Ledger Entry";
        ReversalPost: Codeunit "Gen. Jnl.-Post Reverse";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    begin

        // WITH NewCreditLedgerEntry DO BEGIN
        NewCreditLedgerEntry := CreditLedgerEntry;
        NewCreditLedgerEntry.Amount := -NewCreditLedgerEntry.Amount;
        NewCreditLedgerEntry."Remaining Amount" := -NewCreditLedgerEntry."Remaining Amount";
        NewCreditLedgerEntry."Amount (LCY)" := -NewCreditLedgerEntry."Amount (LCY)";
        NewCreditLedgerEntry."Debit Amount" := -NewCreditLedgerEntry."Debit Amount";
        NewCreditLedgerEntry."Credit Amount" := -NewCreditLedgerEntry."Credit Amount";
        NewCreditLedgerEntry."Debit Amount (LCY)" := -NewCreditLedgerEntry."Debit Amount (LCY)";
        NewCreditLedgerEntry."Credit Amount (LCY)" := -NewCreditLedgerEntry."Credit Amount (LCY)";
        NewCreditLedgerEntry.Positive := NOT NewCreditLedgerEntry.Positive;
        NewCreditLedgerEntry."User ID" := USERID;
        NewCreditLedgerEntry."Entry No." := NewEntryNo;
        NewCreditLedgerEntry."Transaction No." := NextTransNo;
        NewCreditLedgerEntry."Journal Batch Name" := '';
        NewCreditLedgerEntry."Source Code" := SourceCode;

        NewCreditLedgerEntry."Transaction Type Narration" := CreditLedgerEntry."Transaction Type Narration";
        if CreditLedgerEntry."Transaction Type Narration" = 'Loan' then
            NewCreditLedgerEntry."Transaction Type" := NewCreditLedgerEntry."Transaction Type"::Loan;
        if CreditLedgerEntry."Transaction Type Narration" = 'Principal' then
            NewCreditLedgerEntry."Transaction Type" := NewCreditLedgerEntry."Transaction Type"::Loan;
        if CreditLedgerEntry."Transaction Type Narration" = 'Repayment' then
            NewCreditLedgerEntry."Transaction Type" := NewCreditLedgerEntry."Transaction Type"::Repayment;
        if CreditLedgerEntry."Transaction Type Narration" = 'Interest Due' then
            NewCreditLedgerEntry."Transaction Type" := NewCreditLedgerEntry."Transaction Type"::"Interest Due";
        if CreditLedgerEntry."Transaction Type Narration" = 'Interest Paid' then
            NewCreditLedgerEntry."Transaction Type" := NewCreditLedgerEntry."Transaction Type"::"Interest Paid";
        CreditLedgerEntry."Transaction Type" := NewCreditLedgerEntry."Transaction Type";
        // Message('%1 and %2', CreditLedgerEntry."Transaction Type", CreditLedgerEntry."Transaction Type Narration");
        //ReversalPost.SetReversalDescription(CreditLedgerEntry, NewCreditLedgerEntry.Description);
        NewCreditLedgerEntry."Reversed Entry No." := CreditLedgerEntry."Entry No.";
        NewCreditLedgerEntry.Reversed := TRUE;
        // Reversal of Reversal
        IF CreditLedgerEntry."Reversed Entry No." <> 0 THEN BEGIN
            ReversedCreditLedgerEntry.GET(CreditLedgerEntry."Reversed Entry No.");
            ReversedCreditLedgerEntry."Reversed by Entry No." := 0;
            ReversedCreditLedgerEntry.Reversed := FALSE;
            ReversedCreditLedgerEntry."Transaction Type" := NewCreditLedgerEntry."Transaction Type";
            ReversedCreditLedgerEntry.MODIFY;
            CreditLedgerEntry."Reversed Entry No." := NewCreditLedgerEntry."Entry No.";
            NewCreditLedgerEntry."Reversed by Entry No." := CreditLedgerEntry."Entry No.";
        END;
        CreditLedgerEntry."Reversed by Entry No." := NewCreditLedgerEntry."Entry No.";
        CreditLedgerEntry."Creation Date Time" := CurrentDateTime;
        CreditLedgerEntry."Creation Date" := Today;
        CreditLedgerEntry."Creation Time" := Time;
        NewCreditLedgerEntry."Creation Date Time" := CurrentDateTime;
        NewCreditLedgerEntry."Creation Date" := Today;
        NewCreditLedgerEntry."Creation Time" := Time;

        CreditLedgerEntry.Reversed := TRUE;
        CreditLedgerEntry.MODIFY;
        NewCreditLedgerEntry.INSERT;
        //END;

    end;

    local procedure CopyFilters(var TempCreditLedgerEntry: Record "Credit Ledger Entry" temporary; var TempSavingsLedgerEntry: Record "Savings Ledger Entry" temporary)
    begin
        TempCreditLedgerEntry.Copy(CreditLedgerEntry);
        TempSavingsLedgerEntry.Copy(SavingsLedgerEntry);
    end;

    local procedure CopySavingsLedgerEntry(var TempSavingsLedgerEntry: Record "Savings Ledger Entry" temporary)
    begin

        IF TempSavingsLedgerEntryII.FindSet() then
            repeat
                if TempSavingsLedgerEntryII."Reversed by Entry No." <> 0 then
                    Error(CannotReverseErr);
                TempSavingsLedgerEntry := TempSavingsLedgerEntryII;
                TempSavingsLedgerEntry.Insert();
            until TempSavingsLedgerEntryII.Next() = 0;
    end;

    local procedure CopyCreditLedgerEntry(var TempCreditLedgerEntry: Record "Credit Ledger Entry" temporary)
    begin

        IF TempCreditLedgerEntryII.FindSet() then
            repeat
                if TempCreditLedgerEntryII."Reversed by Entry No." <> 0 then
                    Error(CannotReverseErr);
                TempCreditLedgerEntry := TempCreditLedgerEntryII;
                TempCreditLedgerEntry.Insert();
            until TempCreditLedgerEntryII.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", 'OnReverseGLEntryOnBeforeInsertGLEntry', '', false, false)]
    local procedure OnReverseGLEntryOnBeforeInsertGLEntry(var GLEntry: Record "G/L Entry"; GenJnlLine: Record "Gen. Journal Line"; GLEntry2: Record "G/L Entry")
    var
        TempCreditLedgerEntry: Record "Credit Ledger Entry" temporary;
        TempSavingsLedgerEntry: Record "Savings Ledger Entry" temporary;
    begin
        CopyFilters(TempCreditLedgerEntry, TempSavingsLedgerEntry);
        CopyCreditLedgerEntry(TempCreditLedgerEntry);
        CopySavingsLedgerEntry(TempSavingsLedgerEntry);
        case true of
            TempCreditLedgerEntry.Get(GLEntry2."Entry No."):
                begin
                    CheckDimComb(
                      GLEntry2."Entry No.", GLEntry2."Dimension Set ID", DATABASE::"Credit Accounts", TempCreditLedgerEntry."Customer No.", 0, '');
                    ReverseCreditLedgEntry(
                      TempCreditLedgerEntry, GLEntry."Entry No.", GenJnlLine."Source Code", GenJnlLine, GLEntry."Transaction No.");
                    TempCreditLedgerEntry.Delete();
                end;
            TempSavingsLedgerEntry.Get(GLEntry2."Entry No."):
                begin
                    CheckDimComb(
                      GLEntry2."Entry No.", GLEntry2."Dimension Set ID", DATABASE::"Savings Accounts", TempSavingsLedgerEntry."Customer No.", 0, '');
                    ReverseSavingsLedgEntry(
                      TempSavingsLedgerEntry, GLEntry."Entry No.", GenJnlLine."Source Code", GenJnlLine, GLEntry."Transaction No.");
                    TempSavingsLedgerEntry.Delete();
                end;


        end;
    end;

    //set dialog hiding
    procedure SetHideDialog(Hide: Boolean)
    var
        ReversalEntry: Record "Reversal Entry";
    begin
        ReversalEntry.SetHideDialog(Hide);
    end;
    //set hide warnings
    procedure SetHideWarnings()
    var
        ReversalEntry: Record "Reversal Entry";
    begin
        ReversalEntry.SetHideWarningDialogs();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Reversal Entry", 'OnBeforeReverseEntries', '', false, false)]
    local procedure OnBeforeReverseEntries(Number: Integer; RevType: Integer; var IsHandled: Boolean)
    var
        StatusP: Record "Status Change Permissions.";
    begin
        StatusP.Reset();
        StatusP.SetRange("User ID", UserId);
        StatusP.SetRange("Edit Journal", true);
        if StatusP.Find('-') = false then
            Error('You do not have the reversal permission');

    end;

    [EventSubscriber(ObjectType::Table, Database::"Reversal Entry", 'OnInsertFromGLEntryOnBeforeTempReversalEntryInsert', '', false, false)]
    local procedure OnInsertFromGLEntryOnBeforeTempReversalEntryInsert(var TempReversalEntry: Record "Reversal Entry" temporary; GLEntry: Record "G/L Entry");
    begin
        // if GLEntry."Posting Date" <> Today then
        //     Error('This transactions falls outside the allowed dates for reversal.');
        UserSetup.Get(UserId);
        if UserSetup."Post Reversals" = false then
            Error('You do not have permission to reverse this entry');
        if GLEntry."User ID" = UserId then
            Error('You are not allowed to reverse an entry you posted.');

    end;

    var
        UserSetup: Record "User Setup";
}