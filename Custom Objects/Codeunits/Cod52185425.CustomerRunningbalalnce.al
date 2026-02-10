namespace Microsoft.Bank.Ledger;
using Microsoft.Sales.Receivables;
codeunit 52185425 "Customer Running balalnce"
{
    SingleInstance = true;

    var
        CustAccLedgerEntry2: Record "Detailed Cust. Ledg. Entry";
        DayTotals: Dictionary of [Date, Decimal];
        DayTotalsLCY: Dictionary of [Date, Decimal];
        EntryValues: Dictionary of [Integer, Decimal];
        EntryValuesLCY: Dictionary of [Integer, Decimal];
        PrevAccNo: Code[20];
        PrevTableID: Integer;
        PrevHighestEntryNo: Integer;

    procedure GetCustAccBalance(var CustLedgerEntry: record "Cust. Ledger Entry"): Decimal
    var
        RunningBalance: Decimal;
        RunningBalanceLCY: Decimal;
        CustAccLedgerEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        CustAccLedgerEntry.Reset();
        CustAccLedgerEntry.SetRange("Cust. Ledger Entry No.", CustLedgerEntry."Entry No.");
        if CustAccLedgerEntry.find('-') then begin
            CalcBankAccBalance(CustAccLedgerEntry, RunningBalance, RunningBalanceLCY);
            //Message('Running Balance: %1', RunningBalance);
        end;
        exit(RunningBalance);
    end;

    procedure GetBankAccBalanceLCY(var CustAccLedgerEntry: Record "Detailed Cust. Ledg. Entry"): Decimal
    var
        RunningBalance: Decimal;
        RunningBalanceLCY: Decimal;
    begin
        CalcBankAccBalance(CustAccLedgerEntry, RunningBalance, RunningBalanceLCY);
        exit(RunningBalanceLCY);
    end;

    local procedure CalcBankAccBalance(var CustAccLedgerEntry: Record "Detailed Cust. Ledg. Entry"; var RunningBalance: Decimal; var RunningBalanceLCY: Decimal)
    var
        DateTotal: Decimal;
        DateTotalLCY: Decimal;
    begin
        if (PrevTableID <> 0) and (PrevTableID <> Database::"Detailed Cust. Ledg. Entry") or
           (PrevAccNo <> '') and (PrevAccNo <> CustAccLedgerEntry."Customer No.")
        then begin
            Clear(DayTotals);
            Clear(DayTotalsLCY);
            Clear(EntryValues);
            Clear(EntryValuesLCY);
            Clear(PrevHighestEntryNo);
        end;
        PrevTableID := Database::"Detailed Cust. Ledg. Entry";
        PrevAccNo := CustAccLedgerEntry."Customer No.";

        if EntryValues.Get(CustAccLedgerEntry."Entry No.", RunningBalance) and EntryValuesLCY.Get(CustAccLedgerEntry."Entry No.", RunningBalanceLCY) then
            exit;

        CustAccLedgerEntry2.Reset();
        CustAccLedgerEntry2.SetLoadFields("Entry No.", "Customer No.", "Posting Date", Amount, "Amount (LCY)");
        CustAccLedgerEntry2.SetRange("Customer No.", CustAccLedgerEntry."Customer No.");
        if not (DayTotals.Get(CustAccLedgerEntry."Posting Date", DateTotal) and DayTotalsLCY.Get(CustAccLedgerEntry."Posting Date", DateTotalLCY)) then begin
            CustAccLedgerEntry2.SetFilter("Posting Date", '<=%1', CustAccLedgerEntry."Posting Date");
            CustAccLedgerEntry2.CalcSums(Amount, "Amount (LCY)");
            DateTotal := CustAccLedgerEntry2.Amount;
            DateTotalLCY := CustAccLedgerEntry2."Amount (LCY)";
            DayTotals.Add(CustAccLedgerEntry."Posting Date", DateTotal);
            DayTotalsLCY.Add(CustAccLedgerEntry."Posting Date", DateTotalLCY);
        end;
        CustAccLedgerEntry2.SetRange("Posting Date", CustAccLedgerEntry."Posting Date");
        CustAccLedgerEntry2.SetFilter("Entry No.", '>%1', CustAccLedgerEntry."Entry No.");
        CustAccLedgerEntry2.CalcSums(Amount, "Amount (LCY)");
        RunningBalance := DateTotal - CustAccLedgerEntry2.Amount;
        RunningBalanceLCY := DateTotalLCY - CustAccLedgerEntry2."Amount (LCY)";
        EntryValues.Add(CustAccLedgerEntry."Entry No.", RunningBalance);
        EntryValuesLCY.Add(CustAccLedgerEntry."Entry No.", RunningBalanceLCY);
        if PrevHighestEntryNo < CustAccLedgerEntry."Entry No." then
            PrevHighestEntryNo := CustAccLedgerEntry."Entry No.";
    end;

    internal procedure FlushDayTotalsForNewestEntries(BankAccountNo: Code[20])
    var
        LocalCustAccLedgerEntry: Record "Detailed Cust. Ledg. Entry";
        MinimumPostingDateForNewEntries: Date;
    begin
        if PrevAccNo <> BankAccountNo then
            exit;

        if PrevHighestEntryNo = 0 then
            exit;

        LocalCustAccLedgerEntry.Reset();
        LocalCustAccLedgerEntry.SetRange("Customer No.", BankAccountNo);
        LocalCustAccLedgerEntry.SetFilter("Entry No.", '>' + Format(PrevHighestEntryNo));
        LocalCustAccLedgerEntry.SetCurrentKey("Posting Date");
        LocalCustAccLedgerEntry.SetAscending("Posting Date", true);
        if not LocalCustAccLedgerEntry.FindFirst() then
            exit;
        MinimumPostingDateForNewEntries := LocalCustAccLedgerEntry."Posting Date";
        LocalCustAccLedgerEntry.SetRange("Entry No.");
        LocalCustAccLedgerEntry.SetFilter("Posting Date", '>=' + Format(MinimumPostingDateForNewEntries));
        if LocalCustAccLedgerEntry.FindSet() then
            repeat
                if DayTotals.Remove(LocalCustAccLedgerEntry."Posting Date") then;
                if DayTotalsLCY.Remove(LocalCustAccLedgerEntry."Posting Date") then;
                if EntryValues.Remove(LocalCustAccLedgerEntry."Entry No.") then;
                if EntryValuesLCY.Remove(LocalCustAccLedgerEntry."Entry No.") then;
            until LocalCustAccLedgerEntry.Next() = 0;
    end;

    procedure CustomBankAccRunnBal(BankAccLedgerEntry: Record "Bank Account Ledger Entry"): Decimal
    begin
        BankAccLedgerEntry.Reset();
        BankAccLedgerEntry.SetRange("Bank Account No.", BankAccLedgerEntry."Bank Account No.");
        //BankAccLedgerEntry.SetRange(Reversed, false);
        BankAccLedgerEntry.SetFilter("Entry No.", '<=%1', BankAccLedgerEntry."Entry No.");
        //if BankAccLedgerEntry.Findfirst then
        BankAccLedgerEntry.CalcSums("Amount (LCY)");
        exit(BankAccLedgerEntry."Amount (LCY)");
    end;
}

