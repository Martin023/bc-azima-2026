codeunit 52187324 ActualLoanSchedule
{
    procedure GenerateLoanSchedule(Loans: Record Loans)
    var
        ActualInterestBal: Decimal;
        ActualPrincipleBal: Decimal;
        NewApprovedAmount: Decimal;
        i: Integer;

        PeriodStartDate: Date;
        PeriodEndDate: Date;
        IsTodayInCurrentPeriod: Boolean;
        CurrentPeriodsInstallment: Integer;

        LInterest: Decimal;
        LPrincipal: Decimal;
        LBalance: Decimal;

        InterestRepayments: Decimal;
        PrincipleRepayments: Decimal;
        ExpectedInterests: Decimal;

        TotalMRepay: Decimal;

        OriginalAmount: Decimal;

        LoanFromLegacy: Boolean;

        DateWhenLegacyLoanSetFoot: Date;

        ProcessEntry: Boolean;
        NewInstallments: Decimal;
        LastPaymentDate: Date;
        ExpectedDateOfCompletion: Date;
    begin
        if Loans.Installments > 0 then begin
            Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Daily Interest");
            OriginalAmount := Loans."Approved Amount";
            ActualInterestBal := Loans."Outstanding Interest";
            ActualPrincipleBal := Loans."Outstanding Balance";

            IdealSchedule.Reset();
            IdealSchedule.SetRange("Loan No.", Loans."Loan No.");
            IdealSchedule.SetLoadFields("Loan No.");
            if not IdealSchedule.FindFirst() then
                LoanProcess.GenerateSchedule(Loans,True);

            ActualSchedule.Reset();
            ActualSchedule.SetRange("Loan Number", Loans."Loan No.");
            if ActualSchedule.Find('-') then
                ActualSchedule.DeleteAll();

            LedgerEntry.Reset();
            LedgerEntry.SetRange("Loan No", Loans."Loan No.");
            LedgerEntry.SetRange(Reversed, false);
            LedgerEntry.SetLoadFields("Posting Date");
            if LedgerEntry.FindFirst() then
                DateWhenLegacyLoanSetFoot := LedgerEntry."Posting Date";

            //Get last payment date
            LedgerEntry.Reset();
            LedgerEntry.SetRange("Loan No", Loans."Loan No.");
            LedgerEntry.SetRange("Transaction Type", LedgerEntry."Transaction Type"::Repayment, LedgerEntry."Transaction Type"::"Interest Paid");
            LedgerEntry.SetRange(Reversed, false);
            LedgerEntry.SetLoadFields("Posting Date");
            if LedgerEntry.FindLast() then
                LastPaymentDate := LedgerEntry."Posting Date";

            IdealSchedule.Reset();
            IdealSchedule.SetRange("Loan No.", Loans."Loan No.");
            if IdealSchedule.FindLast() then
                ExpectedDateOfCompletion := IdealSchedule."Repayment Date";

            IF ExpectedDateOfCompletion = 0D then begin
                ExpectedDateOfCompletion := Loans."Expected Date of Completion";
                if Loans."Disbursement Date" = 0D then Loans."Disbursement Date" := Today;
                IF ExpectedDateOfCompletion = 0D then
                    IF Loans.Installments > 0 then
                        ExpectedDateOfCompletion := CalcDate((Format(Loans.Installments) + 'M'), Loans."Disbursement Date") ELSE
                        ExpectedDateOfCompletion := Today;

            end;

            i := 0;

            NewApprovedAmount := OriginalAmount;

            LBalance := OriginalAmount;
            ProcessEntry := true;
            if Loans."Source Aplication" = Loans."Source Aplication"::BC then begin
                LBalance := ActualPrincipleBal;
                ProcessEntry := false;
                NewApprovedAmount := ActualPrincipleBal;

            end;

            Clear(PrincipleRepayments);
            Clear(InterestRepayments);
            Clear(ExpectedInterests);

            IdealSchedule.Reset();
            IdealSchedule.SetRange("Loan No.", Loans."Loan No.");
            // IdealSchedule.SetLoadFields("Loan No.", "Repayment Date");
            if IdealSchedule.Find('-') then begin
                repeat
                    i += 1;
                    PeriodStartDate := CalcDate('-CM', IdealSchedule."Repayment Date");
                    PeriodEndDate := IdealSchedule."Repayment Date";

                    if (Today >= PeriodStartDate) and (Today <= PeriodEndDate) then begin
                        IsTodayInCurrentPeriod := true;
                        CurrentPeriodsInstallment := i;
                    end;

                    if Loans."Source Aplication" = Loans."Source Aplication"::BC then begin
                        if (DateWhenLegacyLoanSetFoot <= PeriodEndDate) then begin
                            ProcessEntry := true;
                        end;
                    end;

                    if ProcessEntry then begin
                        Clear(PrincipleRepayments);
                        Clear(InterestRepayments);
                        Clear(ExpectedInterests);

                        LedgerEntry.Reset();
                        LedgerEntry.SetRange("Customer No.", Loans."Loan Account");
                        if i = 1 then
                            LedgerEntry.SetFilter("Posting Date", '<=%1', PeriodEndDate)
                        else
                            LedgerEntry.SetRange("Posting Date", PeriodStartDate, PeriodEndDate);
                        LedgerEntry.SetFilter("Transaction Type", '=%1|=%2|=%3', LedgerEntry."Transaction Type"::Repayment, LedgerEntry."Transaction Type"::"Interest Paid", LedgerEntry."Transaction Type"::"Interest Due");
                        LedgerEntry.SetRange(Reversed, false);
                        LedgerEntry.SetLoadFields(Amount);
                        if LedgerEntry.Find('-') then begin
                            repeat
                                if LedgerEntry."Transaction Type" = LedgerEntry."Transaction Type"::Repayment then begin
                                    PrincipleRepayments += Abs(LedgerEntry.Amount);
                                end;
                                if LedgerEntry."Transaction Type" = LedgerEntry."Transaction Type"::"Interest Paid" then begin
                                    InterestRepayments += Abs(LedgerEntry.Amount);
                                end;
                                if LedgerEntry."Transaction Type" = LedgerEntry."Transaction Type"::"Interest Due" then begin
                                    ExpectedInterests += Abs(LedgerEntry.Amount);
                                end;
                            until LedgerEntry.Next() = 0;
                        end;


                        Loans.SetFilter("Date Filter", '..%1', PeriodEndDate);

                        SchedulePosition := SchedulePosition::Current;

                        if (IsTodayInCurrentPeriod) or ((i > CurrentPeriodsInstallment) and (CurrentPeriodsInstallment <> 0)) then begin
                            if NewInstallments = 0 then
                                NewInstallments := (Loans.Installments - i) + 1; //Adding the current inst because we are processing it in here

                            if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised then begin
                                Loans.TestField(Interest);
                                Loans.TestField(Installments);
                                TotalMRepay := Round((Loans.Interest / 12 / 100) / (1 - Power((1 + (Loans.Interest / 12 / 100)), -(NewInstallments))) * (NewApprovedAmount), 0.0001, '>');
                                LInterest := Round(LBalance / 100 / 12 * Loans.Interest, 0.0001, '>');
                                LPrincipal := TotalMRepay - LInterest;
                            end;

                            if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Straight Line" then begin
                                Loans.TestField(Interest);
                                Loans.TestField(Installments);
                                LPrincipal := NewApprovedAmount / NewInstallments;
                                LInterest := (Loans.Interest / 12 / 100) * NewApprovedAmount;
                            end;

                            if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Balance" then begin
                                Loans.TestField(Interest);
                                Loans.TestField(Installments);
                                LPrincipal := NewApprovedAmount / NewInstallments;
                                LInterest := (Loans.Interest / 12 / 100) * LBalance;
                            end;

                            if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Flat" then begin
                                Loans.TestField(Interest);
                                Loans.TestField(Installments);
                                LPrincipal := Round(NewApprovedAmount / NewInstallments, 1.0, '>');
                                LInterest := Round(((NewApprovedAmount * Loans.Interest / 12 / 100) + (LPrincipal * Loans.Interest / 12 / 100)) / 2, 1.0, '>');
                                Loans.Repayment := LPrincipal + LInterest;
                            end;

                            if i = CurrentPeriodsInstallment then
                                LBalance -= PrincipleRepayments
                            else
                                LBalance -= LPrincipal;
                        end;

                        ActualSchedule.Init();
                        ActualSchedule."No." := IdealSchedule."Repayment Code";
                        ActualSchedule."Repayment Date" := PeriodEndDate;
                        ActualSchedule."Loan Number" := Loans."Loan No.";
                        ActualSchedule."Schedule Position" := SchedulePosition;
                        ActualSchedule."Expected Interest" := Round(ExpectedInterests + LInterest, 0.01, '>');
                        ActualSchedule."Interest Payments" := InterestRepayments + LInterest;
                        ActualSchedule."Expected Principle" := IdealSchedule."Principal Repayment";
                        ActualSchedule."Principle Payments" := PrincipleRepayments + LPrincipal;

                        if (IsTodayInCurrentPeriod) then begin
                            ActualSchedule."Expected Interest" := Round(LInterest, 0.01, '>');
                            ActualSchedule."Interest Payments" := InterestRepayments;
                            ActualSchedule."Expected Principle" := LPrincipal;
                            ActualSchedule."Principle Payments" := PrincipleRepayments;
                        end;

                        if ((i > CurrentPeriodsInstallment) and (CurrentPeriodsInstallment <> 0)) then begin
                            ActualSchedule."Expected Interest" := Round(LInterest, 0.01, '>');
                            ActualSchedule."Interest Payments" := LInterest;
                            ActualSchedule."Expected Principle" := LPrincipal;
                            ActualSchedule."Principle Payments" := LPrincipal;
                        end;

                        ActualSchedule."Total Actual Repayment" := ActualSchedule."Principle Payments" + ActualLoanSchedule."Interest Payments";
                        ActualSchedule."Principle Balance" := LBalance;
                        // IF LBalance > 0 then
                        ActualSchedule.Insert();
                    end;
                until IdealSchedule.Next() = 0;
            end;

            if LastPaymentDate > ExpectedDateOfCompletion then begin
                SchedulePosition := SchedulePosition::Overdue;
                i += 1;
                PrincipleRepayments := 0;
                InterestRepayments := 0;
                LedgerEntry.Reset();
                LedgerEntry.SetRange("Customer No.", Loans."Loan Account");
                LedgerEntry.SetRange("Posting Date", CalcDate('1D', ExpectedDateOfCompletion), LastPaymentDate);
                LedgerEntry.SetFilter("Transaction Type", '=%1|=%2', LedgerEntry."Transaction Type"::Repayment, LedgerEntry."Transaction Type"::"Interest Paid");
                LedgerEntry.SetRange(Reversed, false);
                LedgerEntry.SetLoadFields(Amount);
                if LedgerEntry.Find('-') then begin
                    repeat
                        if LedgerEntry."Transaction Type" = LedgerEntry."Transaction Type"::Repayment then begin
                            PrincipleRepayments += Abs(LedgerEntry.Amount);
                        end;
                        if LedgerEntry."Transaction Type" = LedgerEntry."Transaction Type"::"Interest Paid" then begin
                            InterestRepayments += Abs(LedgerEntry.Amount);
                        end;
                        if LedgerEntry."Transaction Type" = LedgerEntry."Transaction Type"::"Interest Due" then begin
                            ExpectedInterests += Abs(LedgerEntry.Amount);
                        end;
                    until LedgerEntry.Next() = 0;
                end;

                LBalance -= PrincipleRepayments;

                ActualSchedule.Init();
                ActualSchedule."No." := Format(i);
                ActualSchedule."Repayment Date" := LastPaymentDate;
                ActualSchedule."Loan Number" := Loans."Loan No.";
                ActualSchedule."Schedule Position" := SchedulePosition;
                ActualSchedule."Expected Interest" := Round(ExpectedInterests, 0.01, '>');
                ActualSchedule."Interest Payments" := InterestRepayments;
                ActualSchedule."Expected Principle" := LBalance;
                ActualSchedule."Principle Payments" := PrincipleRepayments;
                ActualSchedule."Total Actual Repayment" := ActualSchedule."Principle Payments" + ActualLoanSchedule."Interest Payments";
                ActualSchedule."Principle Balance" := LBalance;
                ActualSchedule.Insert();
            end;

            if Loans."Outstanding Balance" > 0 then
                if (Today > ExpectedDateOfCompletion) then begin
                    i += 1;

                    SchedulePosition := SchedulePosition::Overdue;
                    ActualSchedule.Init();
                    ActualSchedule."No." := Format(i);
                    ActualSchedule."Repayment Date" := Today;
                    ActualSchedule."Loan Number" := Loans."Loan No.";
                    ActualSchedule."Schedule Position" := SchedulePosition;
                    ActualSchedule."Expected Interest" := ActualInterestBal + Loans."Daily Interest";
                    ActualSchedule."Interest Payments" := ActualInterestBal + Loans."Daily Interest";
                    ActualSchedule."Expected Principle" := ActualPrincipleBal;
                    ActualSchedule."Principle Payments" := ActualPrincipleBal;
                    ActualSchedule."Total Actual Repayment" := ActualSchedule."Principle Payments" + ActualLoanSchedule."Interest Payments";
                    ActualSchedule."Principle Balance" := LBalance - ActualPrincipleBal;
                    ActualSchedule.Insert();
                end;
        end;
    end;

    procedure GenerateFutureInterest(Loans: Record Loans) FutureInterest: Decimal
    var
        GlobalFunctions: Codeunit "Global Functions";
        RepaymentSchedule: Record "Ideal Repayment Schedule";
        NextPeriodDate: Date;
    begin
        // GenerateLoanSchedule(Loans);

        Clear(FutureInterest);

        NextPeriodDate := CalcDate('1M+CM', Today);
        ActualLoanSchedule.Reset();
        // ActualLoanSchedule.SetFilter("Repayment Date", '>=%1', NextPeriodDate);
        ActualLoanSchedule.SetRange("Loan Number", Loans."Loan No.");
        ActualLoanSchedule.SetLoadFields("Expected Interest");
        if ActualLoanSchedule.Find('-') then begin
            ActualLoanSchedule.CalcSums("Expected Interest");
            FutureInterest := ActualLoanSchedule."Expected Interest";
        end;

        Loans.CalcFields("Interest Paid");
        FutureInterest -= abs(Loans."Interest Paid");
    end;

    procedure GetPPlusIAmountFuture(Loans: Record Loans; var Interest: Decimal; var Principle: Decimal) PPlusIAmount: decimal
    var
        InterestPaid: Decimal;
        PrinciplePaid: Decimal;
        CreditLedger: Record "Credit Ledger Entry";
    begin
        GenerateLoanSchedule(Loans);
        ActualLoanSchedule.Reset();
        ActualLoanSchedule.SetRange("Loan Number", Loans."Loan No.");
        ActualLoanSchedule.SetLoadFields("Interest Payments", "Principle Payments");
        if ActualLoanSchedule.Find('-') then begin
            ActualLoanSchedule.CalcSums("Interest Payments", "Principle Payments");
            Interest := ActualLoanSchedule."Interest Payments";
            Principle := ActualLoanSchedule."Principle Payments";
        end;

        CreditLedger.Reset();
        CreditLedger.SetRange("Loan No", Loans."Loan No.");
        CreditLedger.SetFilter("Transaction Type", '=%1|=%2', CreditLedger."Transaction Type"::Repayment, CreditLedger."Transaction Type"::"Interest Paid");
        if CreditLedger.Find('-') then begin
            repeat
                if CreditLedger."Transaction Type" = CreditLedger."Transaction Type"::"Interest Paid" then
                    InterestPaid += CreditLedger."Credit Amount";
                if CreditLedger."Transaction Type" = CreditLedger."Transaction Type"::Repayment then
                    PrinciplePaid += CreditLedger."Credit Amount";
            until CreditLedger.Next() = 0;
        end;

        Interest -= InterestPaid;
        Principle -= PrinciplePaid;

        PPlusIAmount := Interest + Principle;
    end;

    procedure GetPPlusIAmountFuture(Loans: Record Loans) PPlusIAmount: decimal
    var
        CreditLedger: Record "Credit Ledger Entry";
        TotalPaid: Decimal;
    begin
        GenerateLoanSchedule(Loans);
        ActualLoanSchedule.Reset();
        ActualLoanSchedule.SetRange("Loan Number", Loans."Loan No.");
        ActualLoanSchedule.SetLoadFields("Interest Payments", "Principle Payments");
        if ActualLoanSchedule.Find('-') then begin
            ActualLoanSchedule.CalcSums("Total Actual Repayment");
            PPlusIAmount := ActualLoanSchedule."Total Actual Repayment";

            CreditLedger.Reset();
            CreditLedger.SetRange("Loan No", Loans."Loan No.");
            CreditLedger.SetFilter("Transaction Type", '=%1|=%2', CreditLedger."Transaction Type"::Repayment, CreditLedger."Transaction Type"::"Interest Paid");
            if CreditLedger.Find('-') then begin
                CreditLedger.CalcSums("Credit Amount");
                TotalPaid := CreditLedger."Credit Amount";
            end;

            PPlusIAmount -= TotalPaid;
        end;
    end;

    procedure GetAttachedLoanBalance(Loans: Record Loans; Var OutInt: Decimal; Var OutBal: Decimal)
    var
        RecoveryHeader: Record "Loan Recovery Header";
        RecoveryLines: Record "Loan Recovery Lines";
        RecoveryHeaderII: Record "Loan Recovery Header II";
        RecoveryLinesII: Record "Loan Recovery Lines II";
    begin
        OutBal := 0;
        OutInt := 0;
        Loans.CalcFields("Actively Attached", "Actively Attached II");
        if (Loans."Actively Attached" > 0) or (Loans."Actively Attached II" > 0) then begin
            if Loans."Actively Attached" > 0 then begin
                RecoveryHeader.Reset();
                RecoveryHeader.SetRange("Loan No.", Loans."Loan No.");
                RecoveryHeader.SetRange(Nullified, false);
                RecoveryHeader.SetRange("Header Reversed", false);
                RecoveryHeader.SetRange(Action, RecoveryHeader.Action::Recovered);
                RecoveryHeader.SetRange("Recovery Type", RecoveryHeader."Recovery Type"::"Recovery and Attachment");
                RecoveryHeader.SetLoadFields("Principle Balance", "Interest Balance");
                if RecoveryHeader.FindFirst() then begin
                    OutInt := RecoveryHeader."Principle Balance";
                    OutBal := RecoveryHeader."Interest Balance";
                end;
            end;
            if Loans."Actively Attached II" > 0 then begin
                RecoveryHeaderII.Reset();
                RecoveryHeaderII.SetRange("Loan No.", Loans."Loan No.");
                RecoveryHeaderII.SetRange(Nullified, false);
                RecoveryHeaderII.SetRange("Header Reversed", false);
                RecoveryHeaderII.SetRange(Action, RecoveryHeaderII.Action::Recovered);
                RecoveryHeaderII.SetRange("Recovery Type", RecoveryHeaderII."Recovery Type"::"Recovery and Attachment");
                if RecoveryHeaderII.FindFirst() then begin
                    OutInt := RecoveryHeader."Principle Balance";
                    OutBal := RecoveryHeader."Interest Balance";
                end;
            end;
        end;
    end;

    var
        IdealSchedule: Record "Ideal Repayment Schedule";
        ActualSchedule: Record "Actual Loan Schedule";
        ActualLoanSchedule: Record "Actual Loan Schedule";
        LoanProcess: Codeunit "Loans Process";
        LedgerEntry: Record "Credit Ledger Entry";


        SchedulePosition: Option Current,Future,Overdue;
}