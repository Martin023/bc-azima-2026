#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185595 prUpdateNetPay
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/prUpdateNetPay.rdl';

    dataset
    {
        dataitem("PR Salary Card"; "PR Salary Card")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(payrollperiod; PayrollPeriod)
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
            dataitem("prEmployee Banks Temp"; "prEmployee Banks Temp")
            {
                DataItemLink = "Employee Code" = field("Employee Code");
                column(ReportForNavId_1000000001; 1000000001)
                {
                }
                column(EmployeeCode_prEmployeeBanksTemp; "prEmployee Banks Temp"."Employee Code")
                {
                }
                column(BankCode_prEmployeeBanksTemp; "prEmployee Banks Temp"."Bank Code")
                {
                }
                column(BranchCode_prEmployeeBanksTemp; "prEmployee Banks Temp"."Branch Code")
                {
                }
                column(AccountNo_prEmployeeBanksTemp; "prEmployee Banks Temp"."Account No")
                {
                }
                column(Amount_prEmployeeBanksTemp; "prEmployee Banks Temp".Amount)
                {
                }
                column(Currency_prEmployeeBanksTemp; "prEmployee Banks Temp".Currency)
                {
                }
                column(BankName; BankName)
                {
                }
                column(BranchName; BranchName)
                {
                }
                column(SortCode; SortCode)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if PRBanks.Get("prEmployee Banks Temp"."Bank Code", "prEmployee Banks Temp"."Branch Code") then begin
                        BankName := PRBanks."Bank Code";
                        BranchName := PRBanks."Bank Name";
                        SortCode := '';
                    end
                    else begin
                        BankName := '';
                        BranchName := '';
                        SortCode := '';
                    end
                end;

                trigger OnPreDataItem()
                begin
                    "prEmployee Banks Temp".SetRange("prEmployee Banks Temp".Currency, CurrencyCode);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                HrEmp.Get("Employee Code");
                EmpName := HrEmp."First Name" + ' ' + HrEmp."Middle Name" + ' ' + HrEmp."Last Name";
                SNo += 1;

                FnUpdatePeriodCurrency("Employee Code", PayrollPeriod);

                prEmpBanks.Reset;
                prEmpBanks.SetRange("Employee Code", "Employee Code");
                prEmpBanks.SetRange(Currency, Currency);
                if not prEmpBanks.FindFirst then begin
                    NPAYLCY := NPAY;
                    NPAY := 0;
                end
                else begin
                    NPAYLCY := NPAY - ROUND(CurrExchRate.ExchangeAmtFCYToLCY(CalcDate('CM', PayrollPeriod), Currency, prEmpBanks.Amount
                                          , CurrExchRate.ExchangeRate(CalcDate('CM', PayrollPeriod), Currency)));
                    NPAY := prEmpBanks.Amount;
                end;

                prNetPay.Init;
                prNetPay."Employee Code" := "Employee Code";
                prNetPay.Amount := NPAY;
                prNetPay."Amount LCY" := NPAYLCY;
                prNetPay.Currency := Currency;
                prNetPay."Payroll Period" := PayrollPeriod;
                prNetPay.Insert(true);

                prEmpBanks.Reset;
                prEmpBanks.SetRange(prEmpBanks."Employee Code", "Employee Code");
                prEmpBanks.SetRange(prEmpBanks.Currency, ' ');
                if prEmpBanks.FindFirst then begin
                    BankCode := prEmpBanks."Bank Code";
                    BranchCode := prEmpBanks."Branch Code";
                    AccountCode := prEmpBanks."Account No";
                end
                else begin
                    BankCode := HrEmp."Main Bank";
                    BranchCode := HrEmp."Branch Bank";
                    AccountCode := HrEmp."Bank Account Number";
                end;

                prEmpBankTemp.Init;
                prEmpBankTemp."Employee Code" := "Employee Code";
                prEmpBankTemp."Bank Code" := BankCode;
                prEmpBankTemp."Branch Code" := BranchCode;
                prEmpBankTemp."Account No" := AccountCode;
                prEmpBankTemp.Amount := NPAYLCY;
                prEmpBankTemp.Currency := '';
                prEmpBankTemp.Insert;

                //now to capture net pay paid in different currency
                prEmpBanks.Reset;
                prEmpBanks.SetRange(prEmpBanks."Employee Code", "Employee Code");
                prEmpBanks.SetFilter(prEmpBanks.Currency, '<>%1', ' ');
                if prEmpBanks.FindFirst then begin
                    BankCode := prEmpBanks."Bank Code";
                    BranchCode := prEmpBanks."Branch Code";
                    AccountCode := prEmpBanks."Account No";

                    prEmpBankTemp.Init;
                    prEmpBankTemp."Employee Code" := "Employee Code";
                    prEmpBankTemp."Bank Code" := BankCode;
                    prEmpBankTemp."Branch Code" := BranchCode;
                    prEmpBankTemp."Account No" := AccountCode;
                    prEmpBankTemp.Amount := NPAY;
                    prEmpBankTemp.Currency := prEmpBanks.Currency;
                    prEmpBankTemp.Insert;

                end;

                Commit;
            end;

            trigger OnPreDataItem()
            begin
                if CurrencyCode <> '' then
                    "PR Salary Card".SetRange(Currency, CurrencyCode);
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
                field(CurrencyCode; CurrencyCode)
                {
                    ApplicationArea = Basic;
                    Caption = 'Currency';
                    TableRelation = Currency;
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
        if PayrollPeriod = 0D then Error('Please select the payroll period');

        CompanyInfo.Get;

        prNetPay.Reset;
        prNetPay.SetRange("Payroll Period", PayrollPeriod);
        prNetPay.DeleteAll;

        prEmpBankTemp.DeleteAll;
    end;

    var
        PayrollPeriod: Date;
        AllowancesLCY: Decimal;
        DeductionsLCY: Decimal;
        prEmpTrans: Record "PR Employee Transactions";
        TotalDeductionsLCY: Decimal;
        StatutoriesLCY: Decimal;
        NPAYLCY: Decimal;
        NPAY: Decimal;
        prNetPay: Record "prNet Pay";
        prEmpBanks: Record "prEmployee Banks";
        CurrExchRate: Record "Currency Exchange Rate";
        CompanyInfo: Record "Company Information";
        HrEmp: Record "HR Employees";
        EmpName: Text;
        SNo: Integer;
        BankName: Text;
        BranchName: Text;
        PRBanks: Record "PR Bank Branches";
        SortCode: Text;
        CurrencyCode: Code[10];
        prEmpBankTemp: Record "prEmployee Banks Temp";
        BankCode: Code[30];
        BranchCode: Code[30];
        AccountCode: Code[30];


    procedure FnUpdatePeriodCurrency(EmployeeCode: Code[10]; SelectedPeriod: Date)
    var
        PeriodTransactions: Record "PR Period Transactions";
    begin
        AllowancesLCY := 0;
        DeductionsLCY := 0;
        PeriodTransactions.Reset;
        //PeriodTransactions.SETCURRENTKEY(PeriodTransactions."Employee Code",PeriodTransactions."Period Month",PeriodTransactions."Period Year",
        //PeriodTransactions."Group Order",PeriodTransactions."Sub Group Order",PeriodTransactions."Payslip Order");
        PeriodTransactions.SetRange(PeriodTransactions."Employee Code", EmployeeCode);
        PeriodTransactions.SetRange(PeriodTransactions."Payroll Period", SelectedPeriod);
        PeriodTransactions.SetRange(PeriodTransactions."Company Deduction", false);         //dennis to filter our company deductions
        if PeriodTransactions.FindSet then
            repeat
                prEmpTrans.Reset;
                prEmpTrans.SetRange("Employee Code", PeriodTransactions."Employee Code");
                prEmpTrans.SetRange("Transaction Code", PeriodTransactions."Transaction Code");
                prEmpTrans.SetRange("Payroll Period", PeriodTransactions."Payroll Period");
                if prEmpTrans.FindFirst then
                    PeriodTransactions."Employee Classification" := prEmpTrans.EmployeePostingG
                else
                    PeriodTransactions."Employee Classification" := '';

                if PeriodTransactions."Transaction Code" = 'BPAY' then PeriodTransactions."Employee Classification" := "PR Salary Card".Currency;

                if PeriodTransactions."Transaction Code" = 'NPAY' then NPAY := PeriodTransactions.Amount;

                if (PeriodTransactions."Group Text" = 'ALLOWANCE') and (PeriodTransactions."Employee Classification" <> "PR Salary Card".Currency) then
                    AllowancesLCY += PeriodTransactions.Amount
                else
                    if (PeriodTransactions."Group Text" = 'DEDUCTIONS') then
                        if (PeriodTransactions."Employee Classification" = "PR Salary Card".Currency) then // get allowances that are not the total deductions
                            DeductionsLCY += PeriodTransactions.Amount
                        else
                            TotalDeductionsLCY := PeriodTransactions.Amount
                    else
                        if (PeriodTransactions."Group Text" = 'STATUTORIES') and (PeriodTransactions."Employee Classification" <> "PR Salary Card".Currency) then
                            StatutoriesLCY += PeriodTransactions.Amount;

                PeriodTransactions.Modify;
            until PeriodTransactions.Next = 0;

        NPAYLCY := AllowancesLCY - (TotalDeductionsLCY - DeductionsLCY) - StatutoriesLCY;
    end;
}
