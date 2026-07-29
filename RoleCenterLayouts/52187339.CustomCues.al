codeunit 52187339 CustomCuesCodeunit
{
    procedure CalcDailyCashierTrans(): Decimal;
    var
        CashTrans: Record "Cashier Transactions";
        Totals: Decimal;
    begin
        Totals := 0;
        CashTrans.Reset();
        CashTrans.SetRange(Posted, CashTrans.Posted = true);
        CashTrans.Setrange("Date Posted", TODAY);
        if CashTrans.find('-') then begin
            repeat
                Totals := Totals + CashTrans.Amount;

            Until CashTrans.next() = 0;
        end;
        exit(Totals);
    end;

    procedure TreasuryTransThisMonth(): Decimal;
    var
        TreasuryTrans: Record "Treasury Cashier Transactions";
        Totals: Decimal;

    begin
        //Message('%1', BeginningOfMonth);
        Totals := 0;
        TreasuryTrans.Reset();
        TreasuryTrans.setrange(Posted, true);
        TreasuryTrans.SetRange("Date Posted", CalcDate('-CM', Today), Today);
        if TreasuryTrans.find('-') then begin
            repeat
                Totals := Totals + TreasuryTrans.Amount;

            Until TreasuryTrans.next() = 0;
        end;
        exit(Totals);
    end;

    procedure GetLoansDisbursedCurrentMonth(): Decimal
    var
        LoansDisbursedCurrentMonth: Record Loans;
        Totals: Decimal;
    begin
        LoansDisbursedCurrentMonth.SetRange("Disbursement Date", CalcDate('-CM', Today), CalcDate('CM', Today));
        // Message('%1', CalcDate('-CM', Today));
        //LoansDisbursedCurrentMonth.SetRange(LoansDisbursedCurrentMonth.Status, LoansDisbursedCurrentMonth.Status::Posted);

        LoansDisbursedCurrentMonth.SetRange(LoansDisbursedCurrentMonth.Posted, true);

        if LoansDisbursedCurrentMonth.Find('-') then begin
            Totals := 0;
            repeat

                Totals := Totals + LoansDisbursedCurrentMonth."Amount To Disburse";
            until LoansDisbursedCurrentMonth.Next = 0;

        end;
        //Message('%1', Totals);
        exit(Totals);


    end;

    procedure Revolvingfundbal(): Decimal
    var
        LoansDisbursedHr: Record Loans;
        Totals: Decimal;
        HrSetup: Record "HR Setup";
        Revolvingfunbal: Decimal;
    begin
        Revolvingfunbal := 0;
        Totals := 0;
        HrSetup.Get();
        LoansDisbursedHr.Reset();
        LoansDisbursedHr.SetFilter(LoansDisbursedHr.Status, '%1|%2', LoansDisbursedHr.Status::Approved, LoansDisbursedHr.Status::Posted);
        LoansDisbursedHr.SetRange("Source Unit", LoansDisbursedHr."Source Unit"::"HR LOANS");
        LoansDisbursedHr.SetFilter("Outstanding Balance", '>%1', 0);
        LoansDisbursedHr.SetRange(LoansDisbursedHr.Posted, true);
        LoansDisbursedHr.SetAutoCalcFields("Outstanding Balance");
        if LoansDisbursedHr.Findset() then begin
            REPEAT
                Totals += LoansDisbursedHr."Outstanding Balance";
            UNTIL LoansDisbursedHr.next = 0;
        end;
        Revolvingfunbal := HrSetup."Revolving Fund" - Totals;
        exit(Revolvingfunbal);
    end;

    procedure SumHrLoansPosted(): Decimal
    var
        LoansDisbursedHr: Record Loans;
        Totals: Decimal;
    begin

        Totals := 0;
        LoansDisbursedHr.Reset();
        LoansDisbursedHr.SetFilter(LoansDisbursedHr.Status, '%1|%2', LoansDisbursedHr.Status::Approved, LoansDisbursedHr.Status::Posted);
        LoansDisbursedHr.SetRange("Source Unit", LoansDisbursedHr."Source Unit"::"HR LOANS");
        LoansDisbursedHr.SetFilter("Outstanding Balance", '>%1', 0);
        LoansDisbursedHr.SetRange(LoansDisbursedHr.Posted, true);
        LoansDisbursedHr.SetAutoCalcFields("Outstanding Balance");
        if LoansDisbursedHr.FindSet() then begin
            REPEAT
                Totals += LoansDisbursedHr."Outstanding Balance";
            UNTIL LoansDisbursedHr.next = 0;
        end;
        exit(Totals);
    end;

    procedure DrillDownLoansDisbursedCurrentMonth()
    var
        LoansTable: Record Loans;
    begin
        LoansTable.SetRange("Disbursement Date", CalcDate('-CM', Today), CalcDate('CM', Today));
        //LoansTable.SetRange(LoansTable.Status, LoansTable.Status::Approved);
        LoansTable.SetRange(LoansTable.Posted, true);
        PAGE.Run(PAGE::"Loan Posted List", LoansTable);
    end;

    procedure DrillDownProrataRecs(Mem: Code[20]; prod: Code[20])
    var
        LoansTable: Record Loans;
    begin
        if prod = '1' then begin
            LoansTable.SetRange("Member No.", Mem);
            LoansTable.SetFilter("Outstanding Balance", '>%1', 0);
            LoansTable.SetFilter("Prorata Amount", '>%1', 0);
            LoansTable.SetCurrentKey("Prorata Amount");
            if LoansTable.Find('+') then
                PAGE.Run(PAGE::"Loan Posted List", LoansTable);
        end;
    end;

    //Loans paid this month
    //Loans paid this month

    procedure TotalLoansPaidThisMonth(): Decimal
    var
        CreditLedgerEntry: Record "Credit Ledger Entry";
    begin
        CreditLedgerEntry.Reset();
        CreditLedgerEntry.SetRange(CreditLedgerEntry."Posting Date", CalcDate('-CM', Today), Today);
        CreditLedgerEntry.SetRange(CreditLedgerEntry."Transaction Type", CreditLedgerEntry."Transaction Type"::"Repayment");
        if CreditLedgerEntry.FindFirst() then begin
            CreditLedgerEntry.CalcSums(CreditLedgerEntry.Amount)
        end;
        exit(CreditLedgerEntry.Amount * (-1))
    end;

    //Loans paid this month
    procedure DrillDownLoansPaidThisMonth()
    var
        CreditLedgerEntry: Record "Credit Ledger Entry";
    begin
        CreditLedgerEntry.Reset();
        CreditLedgerEntry.SetRange(CreditLedgerEntry."Posting Date", CalcDate('-CM', Today), CalcDate('CM', Today));
        CreditLedgerEntry.SetRange(CreditLedgerEntry."Transaction Type", CreditLedgerEntry."Transaction Type"::Repayment);
        Page.Run(Page::"Credit Ledger Entries", CreditLedgerEntry);
    end;

    //Interest Paid this month

    procedure DrillDownInterestPaidThisMonth(): Decimal
    var
        CreditLedg: Record "Credit Ledger Entry";
    begin
        CreditLedg.SetRange(CreditLedg."Posting Date", CalcDate('-CM', Today), CalcDate('CM', Today));
        CreditLedg.Setrange(CreditLedg."Transaction Type", CreditLedg."Transaction Type"::"Interest Paid");
        CreditLedg.CalcSums(CreditLedg.Amount);
        PAGE.Run(PAGE::"Credit Ledger Entries", CreditLedg);
    end;

    //Total Interest Paid this month
    procedure TotalInterestPaidThisMonth(): Decimal
    var
        CreditLedgerEntry: Record "Credit Ledger Entry";
    begin
        CreditLedgerEntry.Reset();
        CreditLedgerEntry.SetRange(CreditLedgerEntry."Posting Date", CalcDate('-CM', Today), CalcDate('CM', Today));
        CreditLedgerEntry.SetRange(CreditLedgerEntry."Transaction Type", CreditLedgerEntry."Transaction Type"::"Interest Paid");
        if CreditLedgerEntry.FindFirst() then begin
            CreditLedgerEntry.CalcSums(CreditLedgerEntry."Credit Amount (LCY)")
        end;
        exit(CreditLedgerEntry."Credit Amount (LCY)")
    end;

    procedure Prorata(Mem: Code[20]; Prod: Code[20]): Decimal
    var
        Loans: Record Loans;
        Prora: Decimal;
    begin
        Prora := 0;
        if Prod = '1' then begin
            Loans.Reset();
            Loans.SetRange("Member No.", mem);
            Loans.SetFilter("Outstanding Balance", '>%1', 0);
            Loans.SetFilter("Prorata Amount", '>%1', 0);
            Loans.SetCurrentKey("Prorata Amount");
            if Loans.Find('+') then begin
                Prora := Loans."Prorata Amount";
            end;
            exit(Prora)
        end;
    end;

    procedure DrillDownInterestBalances()
    var
        CreditLedgerEntry: Record "Credit Ledger Entry";
    begin
        CreditLedgerEntry.Reset();
        //CreditLedgerEntry.SetRange(CreditLedgerEntry."Posting Date", CalcDate('-CM', Today), CalcDate('CM', Today));
        CreditLedgerEntry.SetRange(CreditLedgerEntry."Transaction Type", CreditLedgerEntry."Transaction Type"::"Interest Due");
        CreditLedgerEntry.CalcSums(CreditLedgerEntry."Credit Amount (LCY)");
        PAGE.Run(PAGE::"Credit Ledger Entries", CreditLedgerEntry);
    end;

    procedure DrillDownLoansHrFunds()
    var
        myInt: Integer;
        LoansTable: Record Loans;
    begin
        LoansTable.Reset();
        LoansTable.SetRange("Source Unit", LoansTable."Source Unit"::"HR LOANS");
        LoansTable.SetRange(LoansTable.Posted, true);
        PAGE.Run(PAGE::"Loan Posted List", LoansTable);
    end;

    procedure DrillDownMembersCreatedToday()
    var
        Members: Record Members;
    begin
        Members.Reset();
        Members.SetRange("Registration Date", TODAY);
        IF Members.Find('-') then
            PAGE.Run(PAGE::"Member Single List", Members);
    end;

    procedure calculatememberscreatedtoday(): Integer
    var
        Members: Record Members;
        NoofMembers: Integer;
    begin
        Members.Reset();
        Members.SetRange("Registration Date", TODAY);
        if Members.Find('-') then begin
            NoofMembers := Members.Count();
        end;
    end;

    procedure DrillDownTotalMembers()
    var
        Members: Record Members;
    begin
        Members.Reset();
        Members.SetFilter(Status, '%1|%2', Members.Status::New, Members.Status::Active);
        if Members.Find('-') then
            PAGE.Run(PAGE::"Member Single List", Members);
    end;

    procedure CalculateTotalMembers(): Integer
    var
        Members: Record Members;
        MemberCount: Integer;
    begin

        Members.Reset();
        Members.SetRange(Status, Members.Status::Active);
        if Members.Find('-') THEN begin
            MemberCount := Members.Count();
        end;
    end;

    procedure TotalPAR(): Decimal
    var
        LoansTable: Record Loans;
        TotalOut: Decimal;
        DefaultedBal: Decimal;
    begin
        TotalOut := 0;
        DefaultedBal := 0;
        LoansTable.Reset();
        LoansTable.SetLoadFields("Outstanding Balance", "Outstanding Interest", "Loans Category-SASRA");
        LoansTable.SetAutoCalcFields("Outstanding Balance", "Outstanding Interest", "Loans Category-SASRA");
        LoansTable.Setfilter("Outstanding Balance", '>0');
        if LoansTable.FindSet() then begin
            repeat
                case
                    LoansTable."Loans Category-SASRA" of
                    LoansTable."Loans Category-SASRA"::Substandard, LoansTable."Loans Category-SASRA"::Doubtful, LoansTable."Loans Category-SASRA"::Loss:
                        DefaultedBal += LoansTable."Outstanding Balance";
                end;
                TotalOut += LoansTable."Outstanding Balance";
            until LoansTable.next() = 0;
        end;
        if (TotalOut = 0) or (DefaultedBal = 0) then
            exit(0)
        else
            exit(Round(((DefaultedBal / TotalOut) * 100), 0.01));
    end;

}
