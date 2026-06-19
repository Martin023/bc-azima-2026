#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185544 "Schedule All Loans"
{
    DefaultLayout = RDLC;
    //RDLCLayout = './bc-azima-2026/Layout/Schedule All Loans.rdl';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.", "Employer Code", "Staff No", "Member No.", "Application Date", "Source Unit", "Loan Product Type";
            DataItemTableView = where(Posted = const(True));
            trigger OnAfterGetRecord()
            var
                LoanSchedule: Record "Ideal Repayment Schedule";
            begin
                //Sleep(10000);
                intProgressI += 1;

                IF (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) THEN BEGIN
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));

                    //diaProgress.UPDATE(1, STRSUBSTNO('Processing Loan No: %1 (%2%%)', Loans."Loan No.",ROUND(NoOfProgressed / intProgressTotal * 100, 1)));

                    intProgressI := 0;
                    TimeProgress := TIME;
                END;

                if RecreateSchedule then begin
                    LoanProcess.GenerateSchedule(Loans, RecreateSchedule);
                end else begin
                    LRepaymentSchedule.Reset;
                    LRepaymentSchedule.SetRange(LRepaymentSchedule."Loan No.", Loans."Loan No.");
                    if not LRepaymentSchedule.Find('-') then
                        LoanProcess.GenerateSchedule(Loans, RecreateSchedule);
                end;

                if UpdateLoanRepayment then begin
                    if Loans.Interest = 0 then Loans."Interest Calculation Method" := Loans."Interest Calculation Method"::"Straight Line";
                    Loans.TestField(Installments);

                    if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised then begin
                        if Loans.Interest > 0 then begin
                            Loans.Repayment := Round((Loans.Interest / 12 / 100) / (1 - Power((1 + (Loans.Interest / 12 / 100)), -(Loans.Installments))) * (Loans."Approved Amount"), 0.01, '>');
                            Loans."Loan Interest Repayment" := Round(Loans."Approved Amount" / 100 / 12 * Loans.Interest, 0.01, '>');
                            Loans."Loan Principle Repayment" := Loans.Repayment - Loans."Loan Interest Repayment";
                        end else begin
                            Loans."Loan Principle Repayment" := Loans."Approved Amount" / Loans.Installments;
                            Loans."Loan Interest Repayment" := 0;
                            Repayment := "Loan Principle Repayment" / "Loan Interest Repayment";
                        end;
                    end else begin
                        if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Straight Line" then begin
                            //Loans.TestField(Interest);
                            Loans."Loan Principle Repayment" := Loans."Approved Amount" / Loans.Installments;
                            Loans."Loan Interest Repayment" := (Loans.Interest / 12 / 100) * Loans."Approved Amount";
                            //Grace Period Interest
                            //Loans."Loan Interest Repayment":=(Loans."Loan Interest Repayment"*InitialInstal)/(InitialInstal-InitialGraceInt);
                        end else

                            if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Balance" then begin
                                //Loans.TestField(Interest);
                                Loans."Loan Principle Repayment" := Loans."Approved Amount" / Loans.Installments;
                                Loans."Loan Interest Repayment" := (Loans.Interest / 12 / 100) * Loans."Approved Amount";
                            end else

                                if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Flat" then begin
                                    //Loans.TestField(Interest);
                                    Loans."Loan Principle Repayment" := Round(Loans."Approved Amount" / Loans.Installments, 1.0, '>');
                                    Loans."Loan Interest Repayment" := Round(((Loans."Approved Amount" * Loans.Interest / 12 / 100) + (Loans."Loan Principle Repayment" * Loans.Interest / 12 / 100)) / 2, 1.0, '>');
                                end else begin
                                    Loans."Loan Principle Repayment" := Loans."Approved Amount" / Loans.Installments;
                                    Loans."Loan Interest Repayment" := (Loans.Interest / 12 / 100) * Loans."Approved Amount";
                                end;
                        Loans.Repayment := Loans."Loan Principle Repayment" + Loans."Loan Interest Repayment";
                    end;
                    loans."Repayment Start Date" := CalcDate('CM+1M', loans."Disbursement Date");
                    Loans.Modify();
                end;
            end;

            trigger OnPreDataItem()
            begin
                intProgressTotal := COUNT;

                intProgressI := 0;
                TimeProgress := TIME;
                NoOfRecsProgress := intProgressTotal DIV 100;
                NoOfProgressed := 0;

                diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
            end;

            trigger OnPostDataItem()
            var
            begin
                diaProgress.CLOSE;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(RecreateSchedule; RecreateSchedule)
                {
                    Caption = 'Recreate Schedules';
                    ApplicationArea = All;
                }
                field(UpdateLoanRepayment; UpdateLoanRepayment)
                {
                    Caption = 'Update Loan Repayment';
                    ApplicationArea = All;
                }
            }
        }

    }

    labels
    {
    }

    trigger OnPreReport()
    begin

    end;

    var
        LRepaymentSchedule: Record "Ideal Repayment Schedule";
        LoanProcess: Codeunit "Loans Process";
        ErrorLog: Record "Loan Schedule Error Log";
        RecreateSchedule: Boolean;

        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Generating Schedules';
        diaProgress: Dialog;
        intProgress: Integer;
        UpdateLoanRepayment: Boolean;
}
