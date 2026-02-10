#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185609 "Generate Mass Transactions"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            DataItemTableView = sorting("No.") where(Status = const(Active));
            RequestFilterFields = "No.", "Department Code", Office, "Salary Grade", "Salary Notch/Step", Position;
            column(ReportForNavId_8631; 8631)
            {
            }
            column(HR_Employee_No_; "No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Amount := 0;

                if Percentage > 0 then begin
                    Amount := Percentage / 100 * "Basic Pay 2";
                end else
                    if FixedAmount > 0 then begin
                        Amount := FixedAmount;
                    end;


                PayrollPeriod.Reset;
                PayrollPeriod.SetRange(PayrollPeriod."Date Opened", PeriodSelected);
                if PayrollPeriod.Find('-') then begin

                    if PayrollPeriod.Closed = true then
                        Error(Txt001);

                    Trans.Reset;
                    if Trans.Get(TransactionCode) then begin

                        PayrollVariations.Reset;
                        PayrollVariations.Init;
                        PayrollVariations."Employee Code" := "HR Employees"."No.";
                        PayrollVariations."Transaction Code" := Trans."Transaction Code";
                        PayrollVariations."Period Month" := PayrollPeriod."Period Month";
                        PayrollVariations."Period Year" := PayrollPeriod."Period Year";
                        PayrollVariations."Payroll Period" := PayrollPeriod."Date Opened";
                        PayrollVariations.Validate("Employee Code");
                        PayrollVariations."Transaction Type" := Trans."Transaction Type";
                        PayrollVariations."Transaction Name" := Trans."Transaction Name";
                        PayrollVariations.Frequency := Trans.Frequency;
                        PayrollVariations.Validate("Transaction Code");
                        PayrollVariations.Amount := Amount;
                        PayrollVariations."Original Amount" := Amount;
                        PayrollVariations."Basic Pay" := "HR Employees"."Basic Pay 2";
                        PayrollVariations.Insert;

                    end;

                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(PeriodSelected; PeriodSelected)
                {
                    ApplicationArea = Basic;
                    Caption = 'Period Selected';
                    TableRelation = "PR Payroll Periods"."Date Opened";
                }
                field(TransactionCode; TransactionCode)
                {
                    ApplicationArea = Basic;
                    Caption = 'Transaction Code';
                    TableRelation = "PR Transaction Codes";
                }
                field(Percentage; Percentage)
                {
                    ApplicationArea = Basic;
                    Caption = 'Percentage of BPAY';

                    trigger OnValidate()
                    begin
                        if FixedAmount > 0 then
                            Error(Txt003);
                    end;
                }
                field(FixedAmount; FixedAmount)
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed Amount to Assign';

                    trigger OnValidate()
                    begin
                        if Percentage > 0 then
                            Error(Txt003);
                    end;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        Message(Txt002);
    end;

    var
        Trans: Record "PR Transaction Codes";
        PayrollVariations: Record "prPayroll Variations";
        PeriodTrans: Record "PR Period Transactions";
        PayrollPeriod: Record "PR Payroll Periods";
        PeriodSelected: Date;
        TransactionCode: Code[20];
        FixedAmount: Decimal;
        Txt001: label 'You cannot make changes to a closed period';
        Txt002: label 'Process Complete. Go to the variations to assign the generated transactions to employees';
        Percentage: Decimal;
        Amount: Decimal;
        Txt003: label 'You can only use either a fixed amount or a percentage';
}
