namespace AzimaBC.AzimaBC;
using Microsoft.Sales.Customer;

report 52185623 "Generate Advice Loans"
{
    ApplicationArea = All;
    Caption = 'Generate Advice Loans';
    UsageCategory = Lists;
    processingonly = true;
    dataset
    {
        dataitem(CheckoffAdviceHeader; "Checkoff Advice Header")
        {
            column(No; "No.")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            dataitem(Loans; Loans)
            {
                DataItemTableView = where(Posted = const(true));
                RequestFilterFields = "Loan Product Type", "Disbursement Date", "Member No.", "Employer Code";
                trigger OnpreDataItem()
                begin
                    if CheckoffAdviceHeader."Employer Code" <> '' then
                        Loans.SetRange("Employer Code", CheckoffAdviceHeader."Employer Code");
                    Loans.SetFilter("Date Filter", '..' + Format(CheckoffAdviceHeader."Loan Interest Cut OFF Date"));
                    Loans.SetFilter("Disbursement Date", '..' + Format(CheckoffAdviceHeader."Loan Issue Cut OFF Date"));

                end;

                trigger OnAfterGetRecord()
                begin
                    TotalSTO := 0;
                    if Memb.Get(Loans."Member No.") then begin
                        if Memb.status <> Memb.Status::Deceased then begin
                            //if Memb."Employer Code" = CheckoffAdviceHeader."Employer Code" then begin
                            Loans.CalcFields(Loans."Outstanding Balance", "Outstanding Interest", "Total Balance", "Repayment Advised");
                            if (loans."Outstanding Balance" > 0) or (loans."Repayment Advised" > 0) then begin
                                iEntryNo := 0;
                                CheckoffAdvice.Reset;
                                if CheckoffAdvice.Find('+') then
                                    iEntryNo := CheckoffAdvice."Entry No" + 1;

                                CheckoffAdvice.Init;
                                CheckoffAdvice."Entry No" := iEntryNo;
                                CheckoffAdvice."Advice Header No." := CheckoffAdviceHeader."No.";
                                CheckoffAdvice."Account No." := Loans."Loan Account";
                                CheckoffAdvice."Product Type" := Loans."Loan Product Type";
                                CheckoffAdvice.Validate("Product Type");
                                CheckoffAdvice."Loan No." := Loans."Loan No.";
                                if Memb.Get(Loans."Member No.") then
                                    CheckoffAdvice."ID No." := Memb."Primary Identification";
                                CheckoffAdvice."Member No." := Loans."Member No.";
                                CheckoffAdvice."Employer Code" := Memb."Employer Code";
                                CheckoffAdvice.Validate(CheckoffAdvice."Member No.");
                                CheckoffAdvice.Names := Loans."Member Name";
                                if Loans."Variated Amount" > 0 then
                                    //Loans."Loan Principle Repayment" := Loans."Variated Amount";
                                    CheckoffAdvice."Amount On" := loans."Variated Amount";

                                if CheckoffAdvice."Amount On" = 0 then begin
                                    if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Balance" then begin
                                        CheckoffAdvice."Amount On" := Loans."Loan Principle Repayment";
                                        CheckoffAdvice."Balance On" := Loans."Outstanding Balance";
                                    end
                                    else begin
                                        CheckoffAdvice."Amount On" := Loans.Repayment;
                                        LoanRepaySchedule.Reset();
                                        LoanRepaySchedule.SetRange("Loan No.", Loans."Loan No.");
                                        LoanRepaySchedule.setfilter("Repayment Date", '>=%1', Today);
                                        // if LoanRepaySchedule.Find('-') then
                                        LoanRepaySchedule.CalcSums("Monthly Interest");
                                        CheckoffAdvice."Balance On" := Loans."Outstanding Balance" + LoanRepaySchedule."Monthly Interest";
                                    end;

                                end;
                                // else 
                                // begin
                                //      CheckoffAdvice."Amount Off":
                                // end;

                                if loans."Total Balance" < CheckoffAdvice."Amount On"
                                then
                                    CheckoffAdvice."Amount On" := Loans."Total Balance";

                                CheckoffAdvice."Loan Principle Repayment" := Loans."Loan Principle Repayment";
                                CheckoffAdvice."Loan Interest Repayment" := Loans."Loan Interest Repayment";
                                CheckoffAdvice."Amount On" := Round(CheckoffAdvice."Amount On", 1, '>');

                                CheckoffAdvice."Advice Date" := Today;

                                CheckoffAdvice."Payroll No" := Loans."Staff No";
                                //Update Staff numbers
                                if Memb.Get(Loans."Member No.") then
                                    if Memb."Payroll/Staff No." <> Loans."Staff No" then begin
                                        CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
                                        Loans."Staff No" := Memb."Payroll/Staff No.";
                                        Loans.Modify();
                                    end;

                                CheckoffAdvice."Standing Order amount" := TotalSTO;
                                CheckoffAdvice.Type := CheckoffAdvice.Type::Credit;
                                CheckoffAdvice."Employer Code" := Loans."Employer Code";
                                Loans.CalcFields("Repayment Advised");
                                if Loans."Repayment Advised" > 0 then begin
                                    if Loans."Repayment Advised" <> Loans."Variated Amount" then
                                        if Loans."Variated Amount" <> 0 then begin
                                            CheckoffAdvice.Reference := 'VARIATION';
                                            CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::Variations;
                                        end;
                                    CheckoffAdvice.Reference := 'MONTHLYDED-' + format(CheckoffAdvice."Product Type");
                                    CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"Monthly Deduction";
                                    if Loans."Total Balance" = 0 then begin
                                        CheckoffAdvice.Reference := 'STOPPAGE-' + format(CheckoffAdvice."Product Type");
                                        CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::Stoppage;
                                    end;
                                    CheckoffAdvice.Insert;
                                end
                                else begin
                                    CheckoffAdvice."Advice Type" := CheckoffAdvice."Advice Type"::"Fresh Loan";
                                    CheckoffAdvice.Reference := 'NEWLOAN-' + format(CheckoffAdvice."Product Type");
                                    if CheckoffAdvice."Amount On" > 0 then
                                        CheckoffAdvice.Insert;
                                end;
                            end;
                        end;
                    end;
                end;

            }

            trigger OnAfterGetRecord()
            begin

                CheckoffAdvice.Reset;
                CheckoffAdvice.SetRange(CheckoffAdvice."Advice Header No.", CheckoffAdviceHeader."No.");
                CheckoffAdvice.SetRange(CheckoffAdvice.Type, CheckoffAdvice.Type::Credit);
                if CheckoffAdvice.Find('-') then begin
                    CheckoffAdvice.DeleteAll;
                end;

                // CheckoffAdvice.Reset;
                // // CheckoffAdvice.SetRange(CheckoffAdvice.Period, CheckoffAdviceHeader.Period);
                // CheckoffAdvice.SetRange(CheckoffAdvice.Type, CheckoffAdvice.Type::Credit);
                // CheckoffAdvice.setrange("Advice Header No.", CheckoffAdviceHeader."No.");
                // // if CheckoffAdvice.Find('-') then begin
                // CheckoffAdvice.DeleteAll;
                // end;
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

    trigger OnPreReport()
    begin
        Message('Kindly ensure all loans have principal and interest repayments have figures to generate.');
    end;

    var
        CheckoffAdvice: record "Checkoff Advice Line";
        Employer: record Customer;
        Memb: record members;
        TotalSTO: decimal;
        iEntryNo: Integer;
        LoanRepaySchedule: record "Ideal Repayment Schedule";
}
