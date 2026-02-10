#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185597 "prPaye Report-redeployed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/prPaye Report-redeployed.rdl';

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

            trigger OnAfterGetRecord()
            begin
                HrEmp.Get("Employee Code");
                SNo += 1;
                EmpName := HrEmp."First Name" + ' ' + HrEmp."Middle Name" + ' ' + HrEmp."Last Name";
                BasicPay := 0;
                TotalAllowances := 0;
                Paye := 0;
                Pension := 0;
                TaxablePay := 0;

                prPeriodTrans.Reset;
                prPeriodTrans.SetRange("Employee Code", "Employee Code");
                prPeriodTrans.SetRange("Payroll Period", PayrollPeriod);
                if prPeriodTrans.FindSet then
                    repeat
                        if prPeriodTrans."Transaction Code" = 'BPAY' then BasicPay := prPeriodTrans.Amount;
                        if prPeriodTrans."Transaction Code" = 'TXCHRG' then Paye := prPeriodTrans.Amount;
                        if prPeriodTrans."Transaction Code" = 'TXBP' then TaxablePay := prPeriodTrans.Amount;
                        if prPeriodTrans."Transaction Code" = 'PENS' then Pension := prPeriodTrans.Amount;
                    until prPeriodTrans.Next = 0;
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
}
