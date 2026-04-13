namespace KenpipeCBS.KenpipeCBS;

report 52186229 "Update Guaranteed Amount"
{
    ApplicationArea = All;
    Caption = 'Update Guaranteed Amount';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Loans; Loans)
        {
            CalcFields = "Outstanding Balance";
            //DataItemTableView = where("Outstanding Balance" = filter(> 0), "Disbursement Date" = filter(< 20250501));
            column(LoanNo; "Loan No.")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            trigger OnAfterGetRecord()
            begin
                //Guaranteed amount to be updated for all loans----
                //loans.SetFilter("Disbursement Date", '<= %1', 20250501D);
                loans.CalcFields("Outstanding Balance");
                if Loans."Outstanding Balance" > 0 then begin
                    LoanGuarSec.Reset();
                    LoanGuarSec.SetRange("Loan No", "Loan No.");
                    LoanGuarSec.setrange(Substituted, false);
                    if LoanGuarSec.FindSet() then begin
                        TotalGuarantors := LoanGuarSec.Count();
                        repeat
                            LoanGuarSec."Amount Guaranteed" := round(Loans."Outstanding Balance" / TotalGuarantors, 0.01, '=');
                            if SavAcc.Get(LoanGuarSec."Savings Account No./Member No.") then begin
                                SavAcc.CalcFields("Balance (LCY)");
                                if LoanGuarSec."Amount Guaranteed" > SavAcc."Balance (LCY)" then
                                    LoanGuarSec."Amount Guaranteed" := SavAcc."Balance (LCY)";
                            end;
                            LoanGuarSec.PercentageGur := round((LoanGuarSec."Amount Guaranteed" / Loans."Outstanding Balance" * 100), 0.01, '=');
                            LoanGuarSec.Modify(false);
                        //LoanGuarSec.Rename("Amount Guaranteed");
                        until LoanGuarSec.Next() = 0;
                    end;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        LoanGuarSec: record "Loan Guarantors and Security";
        TotalGuarantors: Integer;
        SavAcc: record "Savings Accounts";
}
