
report 52186230 UpdateData
{
    ApplicationArea = All;
    Caption = 'Update Expected Date of Completion';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Loan Product Type" = const('BGL'));

            trigger OnAfterGetRecord()
            var
                ProdFac: Record "Product Factory";
                InstalmentPeriods: DateFormula;
                InstallmentPeriodText: Text;
            begin
                // Only proceed if Loan Product Type exists
                if ProdFac.Get(Loans."Loan Product Type") then begin
                    if Format(ProdFac."Grace Period - Principle") <> '' then begin
                        // Grace period logic
                        Loans."Repayment Start Date" := CalcDate(ProdFac."Grace Period - Principle", Loans."Disbursement Date");

                        if Date2DMY(Loans."Repayment Start Date", 1) <= 10 then
                            Loans."Repayment Start Date" := CalcDate('CM', Loans."Repayment Start Date")
                        else
                            Loans."Repayment Start Date" := CalcDate('CM+1M', Loans."Repayment Start Date");
                    end else begin
                        // No grace period
                        if Date2DMY(Loans."Disbursement Date", 1) <= 10 then
                            Loans."Repayment Start Date" := CalcDate('CM', Loans."Disbursement Date")
                        else
                            Loans."Repayment Start Date" := CalcDate('CM+1M', Loans."Disbursement Date");
                    end;

                    // Compute expected date of completion
                    InstallmentPeriodText := Format(Loans.Installments) + 'M';
                    if Evaluate(InstalmentPeriods, InstallmentPeriodText) then
                        Loans."Expected Date of Completion" := CalcDate(InstalmentPeriods, Loans."Repayment Start Date");

                    // Save changes
                    Loans.Modify();
                end;
            end;
        }
    }
}

