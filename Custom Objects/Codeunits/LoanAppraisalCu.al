#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185484 "Loan Appraisal Codeunit"
{
    trigger OnRun()
    begin
    end;

    procedure GetmaxSelfGuaranteeAmt(Accno: Code[20]): Decimal
    var
        LoanGua: Record "Loan Guarantors and Security";
        SavingsAcc: Record "Savings Accounts";
        Deductions: Decimal;
        GenSetup: Record "General Set-Up";
        SavBal: Decimal;
    begin
        Deductions := 0;
        SavBal := 0;
        GenSetup.Get();
        GenSetup.TestField("Self Guarantee %");
        GenSetup.testField("Withdrawal Fee");
        SavBal := SavingsAcc.GetAvailableBalance(Accno);
        if SavBal > 0 then begin
            Deductions := (GenSetup."Self Guarantee %" * 0.01 * SavBal * 3) + GenSetup."Withdrawal Fee" + GetTotalSelfGuarantee(Accno);
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
        LoanGuar.SetLoadFields(LoanGuar."Outstanding Balance");
        LoanGuar.SetFilter(LoanGuar."Outstanding Balance", '>0');
        LoanGuar.CalcSums("Amount Guaranteed");
        TotalGuar := LoanGuar."Amount Guaranteed";
        exit(TotalGuar);
    end;

    var
        Members: Record "Members";
        SavAccs: record "Savings Accounts";

}
