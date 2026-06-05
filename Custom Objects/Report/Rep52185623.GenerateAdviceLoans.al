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
                CalcFields = "Total Balance";
                DataItemTableView = where(Posted = const(true), "Total Balance" = filter(> 0));
                RequestFilterFields = "Loan Product Type", "Disbursement Date", "Member No.", "Employer Code", "Work Station";
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
                            Loans.CalcFields(Loans."Outstanding Balance", "Outstanding Interest", "Total Balance");

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

                            if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Balance" then begin
                                if Loans."Variated Amount" <> 0 then
                                    //Loans."Loan Principle Repayment" := Loans."Variated Amount";
                                CheckoffAdvice."Amount On" := loans."Variated Amount"
                                else
                                    CheckoffAdvice."Amount On" := Loans."Loan Principle Repayment";
                                //+ Loans."Outstanding Interest" - TotalSTO;
                                CheckoffAdvice."Total Loan Repayment" := loans."Loan Principle Repayment" + Loans."Outstanding Interest";
                            end
                            else begin
                                if Loans."Variated Amount" <> 0 then
                                    CheckoffAdvice."Amount On" := Loans."Variated Amount"
                                else
                                    CheckoffAdvice."Amount On" := loans.Repayment;
                                // - TotalSTO;
                                CheckoffAdvice."Total Loan Repayment" := loans.Repayment;
                            end;

                            if loans."Total Balance" < CheckoffAdvice."Amount On"
                            then
                                CheckoffAdvice."Amount On" := Loans."Total Balance";

                            CheckoffAdvice."Loan Principle Repayment" := Loans."Loan Principle Repayment";
                            CheckoffAdvice."Loan Interest Repayment" := Loans."Loan Interest Repayment";
                            CheckoffAdvice."Amount On" := Round(CheckoffAdvice."Amount On", 1, '>');
                            CheckoffAdvice."Balance On" := Loans."Outstanding Balance" + Loans."Outstanding Interest";
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
                            CheckoffAdvice."Work Station" := Loans."Work Station";
                            CheckoffAdvice.Reference := 'MONTHLYDED-' + format(CheckoffAdvice."Product Type");
                            if CheckoffAdvice."Amount On" > 0 then
                                CheckoffAdvice.Insert;
                        end;
                    end;
                end;


            }

            trigger OnAfterGetRecord()
            begin

                // CheckoffAdvice.Reset;
                // CheckoffAdvice.SetRange(CheckoffAdvice."Advice Header No.", CheckoffAdviceHeader."No.");
                // if CheckoffAdvice.Find('-') then begin
                //     CheckoffAdvice.DeleteAll;
                // end;

                CheckoffAdvice.Reset;
                CheckoffAdvice.SetRange(CheckoffAdvice.Period, CheckoffAdviceHeader.Period);
                CheckoffAdvice.SetRange(CheckoffAdvice.Type, CheckoffAdvice.Type::Credit);
                CheckoffAdvice.setrange("Advice Header No.", CheckoffAdviceHeader."No.");
                if CheckoffAdvice.Find('-') then begin
                    CheckoffAdvice.DeleteAll;
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
        CheckoffAdvice: record "Checkoff Advice Line";
        Employer: record Customer;
        Memb: record members;
        TotalSTO: decimal;
        iEntryNo: Integer;
}
