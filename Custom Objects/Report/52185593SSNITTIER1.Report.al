#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185593 "SSNIT TIER 1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/SSNIT TIER 1.rdl';

    dataset
    {
        dataitem("PR Salary Card"; "PR Salary Card")
        {
            column(ReportForNavId_1000000006; 1000000006)
            {
            }
            column(EmployeeCode_prSalaryCard; "PR Salary Card"."Employee Code")
            {
            }
            column(BasicPay_prSalaryCard; "PR Salary Card"."Basic Pay")
            {
            }
            column(PensionHouseFilter_prSalaryCard; "PR Salary Card"."Job Title")
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(PayrollPeriod; PayrollPeriodDate)
            {
            }
            column(SNo; SNo)
            {
            }
            column(SocialSecurityNo; SocialSecurityNo)
            {
            }
            column(EmpName; EmpName)
            {
            }
            column(City; City)
            {
            }
            column(TierAmount; TierAmount)
            {
            }
            column(ControlInfoNSSFNo; ControlInfo."N.S.S.F No.")
            {
            }
            column(BPay; BPay)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ControlInfo.Get;
                HREmp.Get("Employee Code");
                EmpName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                SocialSecurityNo := HREmp."PIN No.";
                City := HREmp.City;

                PrPeriodTrans.Reset;
                PrPeriodTrans.SetRange("Employee Code", "Employee Code");
                PrPeriodTrans.SetRange("Payroll Period", PayrollPeriod);
                PrPeriodTrans.SetRange("Transaction Code", 'BPAY');
                if not PrPeriodTrans.FindFirst then CurrReport.Skip;
                BPay := PrPeriodTrans.Amount;
                TierAmount := PrPeriodTrans.Amount * 0.135;
                //TierAmount := "Basic Pay" * 0.135;

                PrEmpTrans.Reset;
                PrEmpTrans.SetRange("Employee Code", "Employee Code");
                PrEmpTrans.SetRange("Payroll Period", PayrollPeriod);
                PrEmpTrans.SetRange("Transaction Code", 'PENS');
                if not PrEmpTrans.FindFirst then CurrReport.Skip;
                SNo += 1;

                PayrollPeriodDate := CalcDate('CM', PayrollPeriod);
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
        if PayrollPeriod = 0D then Error('Specify The Payroll Period Filter');
    end;

    var
        CompanyInfo: Record "Company Information";
        PayrollPeriod: Date;
        SNo: Integer;
        EmpName: Text;
        HREmp: Record "HR Employees";
        SocialSecurityNo: Code[50];
        City: Text;
        TierAmount: Decimal;
        PrEmpTrans: Record "PR Employee Transactions";
        ControlInfo: Record "Control-Information";
        PayrollPeriodDate: Date;
        PrPeriodTrans: Record "PR Period Transactions";
        BPay: Decimal;
}
