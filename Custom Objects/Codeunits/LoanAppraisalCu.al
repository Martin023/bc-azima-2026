#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185484 "Loan Appraisal Codeunit"
{
    trigger OnRun()
    begin
    end;

    procedure GetmaxSelfGuaranteeAmt(Accno: Code[20]; LoanNo: Code[20]): Decimal
    var
        LoanGua: Record "Loan Guarantors and Security";
        SavingsAcc: Record "Savings Accounts";
        Deductions: Decimal;
        GenSetup: Record "General Set-Up";
        SavBal: Decimal;
        Members: Record "Members";
        Loans: Record "Loans";
        TotalLoanBalance: Decimal;
        TotalThreeMonthInterest: Decimal;
        TotalTopUp: Decimal;
        TotalLoanCommittment: Decimal;
        Toups: record "Loans Top up";
        AppledLoan: record Loans;
    begin

        Deductions := 0;
        TotalLoanCommittment := 0;
        TotalLoanBalance := 0;
        TotalThreeMonthInterest := 0;


        SavBal := 0;
        GenSetup.Get();
        GenSetup.TestField("Self Guarantee %");
        GenSetup.testField("Withdrawal Fee");
        SavBal := SavingsAcc.GetAvailableBalance(Accno);
        //Message('Available Balance: %1', SavBal);
        if SavBal > 0 then begin
            SavingsAcc.Reset();
            SavingsAcc.Setrange("No.", Accno);
            SavingsAcc.SetAutoCalcFields(balance);
            if SavingsAcc.FindFirst() then begin
                Loans.Reset();
                Loans.SetRange("Member No.", SavingsAcc."Member No.");
                Loans.SetRange(Posted, True);
                Loans.Setfilter("Total Loan Balance", '>0');
                Loans.SetAutoCalcFields("Total Loan Balance", "Outstanding Balance", "Outstanding Interest");
                if Loans.Find('-') then begin
                    repeat
                        TotalLoanBalance += Loans."Total Loan Balance";
                        Toups.reset;
                        Toups.setrange("Loan No.", LoanNo);
                        Toups.SetRange("Loan Top Up", Loans."Loan No.");
                        if not Toups.IsEmpty() then
                            TotalThreeMonthInterest += (Loans."Outstanding Balance" * 3 * (Loans."Interest" / 12 * 0.01));
                    until Loans.Next() = 0;
                end
                else begin
                    AppledLoan.get(LoanNo);
                    TotalThreeMonthInterest := SavingsAcc.Balance * 3 * (AppledLoan."Interest" / 12 * 0.01);
                end;
                //Message('Total Loan Balance: %1, Total Three Month Interest: %2', TotalLoanBalance, TotalThreeMonthInterest);
                TotalLoanCommittment := TotalLoanBalance + TotalThreeMonthInterest;
                //Message('Total Loan Committment: %1', TotalLoanCommittment);
            end;
            Deductions := TotalLoanCommittment + GenSetup."Withdrawal Fee" + GetTotalGuaranteedAmt(Accno);
            // Message('Deductions: %1, Available Balance: %2', Deductions, SavBal);
            //Deductions := (GenSetup."Self Guarantee %" * 0.01 * SavBal * 3) + GenSetup."Withdrawal Fee" + GetTotalSelfGuarantee(Accno) + GetTotalGuaranteedAmt(Accno);
            //Deductions := 
            //(90 * 0.01 *1,158,790.42 * 3) +  3000 + 53,857.00 + 53,857.00 = 1,059,790.42
            if Deductions > SavBal then
                exit(0)
            else
                exit(SavBal - Deductions);
        end
        else
            exit(0);
    end;


    procedure GetTotalSelfGuarantee(MemberNo: Code[20]): Decimal
    var
        TotalSelfGuar: Decimal;
        LoanGuar: Record "Loan Guarantors and Security";
    begin
        TotalSelfGuar := 0;
        LoanGuar.Reset;
        LoanGuar.SetRange(LoanGuar."Savings Account No./Member No.", MemberNo);
        LoanGuar.SetRange(Substituted, false);
        LoanGuar.SetRange(LoanGuar."Self Guarantee", true);
        LoanGuar.SetLoadFields(LoanGuar."Outstanding Balance");
        LoanGuar.SetFilter(LoanGuar."Outstanding Balance", '>0');
        if LoanGuar.FindSet() then begin
            repeat
                TotalSelfGuar += LoanGuar."Outstanding Balance";
            until LoanGuar.Next() = 0;
        end;
        exit(TotalSelfGuar);
    end;

    procedure GetTotalGuaranteedAmt(AccNO: Code[20]): Decimal
    var
        TotalGuar: Decimal;
        LoanGuar: Record "Loan Guarantors and Security";
    begin
        TotalGuar := 0;
        LoanGuar.Reset;
        LoanGuar.SetRange(LoanGuar."Savings Account No./Member No.", AccNO);
        LoanGuar.SetRange(Substituted, false);
        LoanGuar.SetRange(LoanGuar."Self Guarantee", false);
        LoanGuar.SetLoadFields(LoanGuar."Outstanding Balance");
        LoanGuar.SetFilter(LoanGuar."Outstanding Balance", '>0');
        LoanGuar.CalcSums("Amount Guaranteed");
        TotalGuar := LoanGuar."Amount Guaranteed";
        Message('Total Guaranteed Amount: %1', TotalGuar);
        exit(TotalGuar);
    end;

    procedure GetTotalTopUpLoans(LoanNo: Code[20]): Decimal
    var
        TotalTopUp: Record "Loans Top up";
        LoanGuar: Record "Loan Guarantors and Security";
    begin
        TotalTopUp.Reset;
        TotalTopUp.SetRange("Loan No.", LoanNo);
        TotalTopUp.SetLoadFields("Total Top Up");
        IF TotalTopUp.FindSet() THEN BEGIN
            TotalTopUp.CalcSums("Total Top Up");
            //Message('Total Top Up: %1', TotalTopUp."Total Top Up");
            exit(TotalTopUp."Total Top Up");
        END;
    end;

    var
        Members: Record "Members";
        SavAccs: record "Savings Accounts";

}
