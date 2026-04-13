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
        TotalDeposit: Decimal;
        GenSetup: Record "General Set-Up";
    begin
        GenSetup.Get();
        GenSetup.TestField("Self Guarantee %");
        GenSetup.testField("Withdrawal Fee");
        exit(SavingsAcc.GetAvailableBalance(Accno) - ((GenSetup."Self Guarantee %" * 0.01 * 3) + GenSetup."Withdrawal Fee"));
    end;


    procedure GetTotalSelfGuarantee(MemberNo: Code[20]): Decimal
    var
        TotalSelfGuar: Decimal;
        LoanGuar: Record "Loan Guarantors and Security";
    begin
        TotalSelfGuar := 0;
        LoanGuar.Reset;
        LoanGuar.SetRange(LoanGuar."Member No", MemberNo);
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

    procedure GetTotalGuaranteedAmt(MemberNo: Code[20]): Decimal
    var
        TotalGuar: Decimal;
        LoanGuar: Record "Loan Guarantors and Security";
    begin
        TotalGuar := 0;
        LoanGuar.Reset;
        LoanGuar.SetRange(LoanGuar."Member No", MemberNo);
        LoanGuar.SetRange(Substituted, false);
        LoanGuar.SetLoadFields(LoanGuar."Outstanding Balance");
        LoanGuar.SetFilter(LoanGuar."Outstanding Balance", '>0');
        if LoanGuar.FindSet() then begin
            repeat
                TotalGuar += LoanGuar."Amount Guaranteed";
            until LoanGuar.Next() = 0;
        end;
        exit(TotalGuar);
    end;

    procedure GetNumberOfLoansGuaranteed(AccNo: Code[20]; GuarType: enum "Loan Guarantor Types Enum"): Integer
    var
        LoanGuar: Record "Loan Guarantors and Security";
    begin
        LoanGuar.Reset;
        if GuarType <> GuarType::Collateral then
            LoanGuar.SetRange("Savings Account No./Member No.", AccNo)
        else
            LoanGuar.SetRange("Member No", AccNo);
        LoanGuar.SetFilter("Outstanding Balance", '>0');
        if LoanGuar.FindSet() then begin
            exit(LoanGuar.Count());
        end;
    end;


    var
        Members: Record "Members";
        SavAccs: record "Savings Accounts";

}
