#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185598 "prPaye Report-redeployed2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/prPaye Report-redeployed2.rdl';

    dataset
    {
        dataitem("PR Salary Card"; "PR Salary Card")
        {
            column(ReportForNavId_1000000008; 1000000008)
            {
            }
            column(EmployeeCode_prSalaryCard; "PR Salary Card"."Employee Code")
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(EmpName; EmpName)
            {
            }
            column(SNo; SNo)
            {
            }
            column(Pension; Pension)
            {
            }
            column(Paye; Paye)
            {
            }
            column(TotalAllowances; TotalAllowances)
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(PayrollPeriod; PayrollPeriod)
            {
            }
            column(TaxablePay; TaxablePay)
            {
            }
            column(PayeLCY; PayeLCY)
            {
            }

            trigger OnAfterGetRecord()
            begin
                HrEmp.Get("Employee Code");
                SNo += 1;
                EmpName := HrEmp."First Name" + ' ' + HrEmp."Middle Name" + ' ' + HrEmp."Last Name";
                BasicPay := "PR Salary Card"."Basic Pay";
                TotalAllowances := 0;
                Paye := 0;
                Pension := 0;
                TaxablePay := 0;

                prPeriodTrans.Reset;
                prPeriodTrans.SetRange("Employee Code", "Employee Code");
                prPeriodTrans.SetRange("Payroll Period", PayrollPeriod);
                if prPeriodTrans.FindSet then
                    repeat
                        //  IF prPeriodTrans."Transaction Code" = 'BPAY' THEN BasicPay := prPeriodTrans.Amount;
                        if prPeriodTrans."Transaction Code" = 'PAYE-EX' then PayeLCY := prPeriodTrans.Amount;
                        if prPeriodTrans."Transaction Code" = 'TXBP' then TaxablePay := prPeriodTrans.Amount;
                        if prPeriodTrans."Transaction Code" = 'PENS' then Pension := prPeriodTrans.Amount;
                    until prPeriodTrans.Next = 0;

                prEmpTrans.Reset;
                prEmpTrans.SetRange("Employee Code", "Employee Code");
                prEmpTrans.SetRange("Payroll Period", PayrollPeriod);
                if prEmpTrans.FindSet then
                    repeat
                        //  IF prEmpTrans."Transaction Code" = 'BPAY' THEN BasicPay := prEmpTrans.Amount;
                        //  IF prEmpTrans."Transaction Code" = 'PAYE-EX' THEN Paye := prEmpTrans.Amount;
                        //  IF prEmpTrans."Transaction Code" = 'TXBP' THEN TaxablePay := prEmpTrans.Amount;
                        if prEmpTrans."Transaction Code" = 'PAYE-EX' then Paye := prEmpTrans.Amount;
                        if prEmpTrans."Transaction Code" = 'PENS2-EX' then Pension := prEmpTrans.Amount;
                        if prEmpTrans."Transaction Code" = 'HSE-EX' then Hse := prEmpTrans.Amount;
                        if prEmpTrans."Transaction Code" = 'TRANS-EX' then Trans := prEmpTrans.Amount;
                    until prEmpTrans.Next = 0;

                BasicPay := BasicPay + Trans + Hse;
                TaxablePay := (BasicPay - (200000 / 12) - (BasicPay * 20 / 100) - (BasicPay * 7.5 / 100));
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
                field(PayrollPeriod; PayrollPeriod)
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll Period';
                    TableRelation = "PR Payroll Periods";
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

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        if PayrollPeriod = 0D then Error('Please Specify the payroll period');
    end;

    var
        CompanyInfo: Record "Company Information";
        EmpName: Text;
        HrEmp: Record "HR Employees";
        SNo: Integer;
        BasicPay: Decimal;
        TotalAllowances: Decimal;
        Paye: Decimal;
        PayrollPeriod: Date;
        Pension: Decimal;
        prPeriodTrans: Record "PR Period Transactions";
        TaxablePay: Decimal;
        prEmpTrans: Record "PR Employee Transactions";
        PayeLCY: Decimal;
        Hse: Decimal;
        Trans: Decimal;
}
