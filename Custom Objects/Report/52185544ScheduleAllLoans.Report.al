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
                LoanRescheduling: record "Loan Rescheduling";
                PeriodicActivities: codeunit "Periodic Activities";
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
                    if Loans."Loan Rescheduled" then begin
                        //Check if Ever Rescheduled.
                        LoanRescheduling.Reset;
                        LoanRescheduling.SetRange(LoanRescheduling."Loan No.", Loans."Loan No.");
                        LoanRescheduling.SetRange(LoanRescheduling."Rescheduled", true);
                        if LoanRescheduling.Find('-') then begin
                            PeriodicActivities.RescheduleLoanII(LoanRescheduling);
                        end
                        else
                            LoanProcess.GenerateSchedule(Loans, RecreateSchedule);
                    end else
                        LoanProcess.GenerateSchedule(Loans, RecreateSchedule);
                end;

                if UpdateLoanRepayment then begin
                    if "Disbursement Date" <> 0D then begin
                        Loans.TestField(Installments);
                        if Loans.Interest = 0 then begin
                            Loans."Loan Interest Repayment" := 0;
                            Loans."Loan Principle Repayment" := Loans."Approved Amount" / Loans.Installments;
                        end
                        else begin
                            if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised then begin
                                Loans.Repayment := Round((Loans.Interest / 12 / 100) / (1 - Power((1 + (Loans.Interest / 12 / 100)), -(Loans.Installments))) * (Loans."Approved Amount"), 1, '>');
                                Loans."Loan Interest Repayment" := Round(Loans."Approved Amount" / 100 / 12 * Loans.Interest, 1, '>');
                                Loans."Loan Principle Repayment" := Loans.Repayment - Loans."Loan Interest Repayment";
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
                                        Loans."Loan Principle Repayment" := Round((Loans."Approved Amount" / Loans.Installments), 1, '>');
                                        Loans."Loan Interest Repayment" := Round(((Loans.Interest / 12 / 100) * Loans."Approved Amount"), 1, '>');
                                    end else
                                        if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Flat" then begin
                                            //Loans.TestField(Interest);
                                            Loans."Loan Principle Repayment" := Round(Loans."Approved Amount" / Loans.Installments, 1.0, '>');
                                            Loans."Loan Interest Repayment" := Round(((Loans."Approved Amount" * Loans.Interest / 12 / 100) + (Loans."Loan Principle Repayment" * Loans.Interest / 12 / 100)) / 2, 1.0, '>');
                                        end else begin
                                            Loans."Loan Principle Repayment" := Loans."Approved Amount" / Loans.Installments;
                                            Loans."Loan Interest Repayment" := (Loans.Interest / 12 / 100) * Loans."Approved Amount";
                                        end;

                            end;
                        end;
                        Loans.Repayment := Round(((Loans."Loan Principle Repayment" + Loans."Loan Interest Repayment")), 1, '>');
                        //Loans."Repayment Start Date" := "Disbursement Date" + 45;
                        loans."Repayment Start Date" := CalcDate('CM+1M', loans."Disbursement Date");
                        if Loans.installments > 1 then
                            Loans."Expected Date of Completion" := CalcDate(FORMAT(loans.Installments) + 'M', loans."Repayment Start Date");
                        Loans.Modify();
                    end;
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
