namespace AzimaBC.AzimaBC;
using Microsoft.Foundation.Company;

report 52185507 "Deductions With Employer Contr"
{
    ApplicationArea = All;
    Caption = 'PR Deductions With Employer Contributions';
    RDLCLayout = './bc-azima-2026/Layout/Deductions With Employer Contributions.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(PRTransactionCodes; "PR Transaction Codes")
        {
            RequestFilterFields = "Transaction Code";
            DataItemTableView = where("Employer Deduction" = const(true));
            column(TransactionCode; "Transaction Code") { }
            column(TransactionName; "Transaction Name") { }
            column(EmployeeAmt; EmployeeAmt) { }
            column(EmployerAmt; EmployerAmt) { }
            column(TotalAmt; TotalAmt) { }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            trigger OnAfterGetRecord()
            begin
                EmployeeAmt := 0;
                EmployerAmt := 0;
                PRPeriodTransactions.Reset;
                PRPeriodTransactions.SetRange("Transaction Code", "Transaction Code");
                PRPeriodTransactions.SetRange("Payroll Period", SelectedPeriod);
                if PRPeriodTransactions.FindSet() then begin
                    EmployeeAmt := PRPeriodTransactions.Amount;
                end;

                prEmployerDeductions.Reset;
                prEmployerDeductions.SetRange("Transaction Code", "Transaction Code");
                prEmployerDeductions.SetRange("Payroll Period", SelectedPeriod);
                if prEmployerDeductions.FindSet() then begin
                    EmployerAmt := prEmployerDeductions.Amount;
                end;

                TotalAmt := EmployeeAmt + EmployerAmt;
            end;
            // dataitem(PRPeriodTransactions; "PR Period Transactions")
            // {
            //     DataItemLink = "Transaction Code" = field("Transaction Code");
            //     column(EmployeeCode; "Employee Code") { }
            //     column(Amount; Amount) { }
            //     trigger OnPreDataItem()
            //     begin
            //         //OnViewCurrRec();
            //         //LastFieldNo := "PR Period Transactions".FieldNo("Period Year");
            //     end;
            // }

        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(SelectedPeriod; SelectedPeriod)
                {
                    ApplicationArea = Basic;
                    Caption = 'Selected Period';
                    TableRelation = "PR Payroll Periods";
                }
            }
        }

        actions
        {
        }
    }
    trigger OnPreReport()
    begin
        if SelectedPeriod = 0D then Error('You must specify the period filter');

        objPeriod.Reset;
        objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
        if objPeriod.Find('-') then begin
            PeriodName := objPeriod."Period Name";
        end;


        // if CI.Get() then
        //     CI.CalcFields(CI.Picture);
    end;

    var
        LastFieldNo: Integer;
        objPeriod: Record "PR Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        CompanyInfo: Record "Company Information";
        Employees: Record "HR Employees";
        EmployeeName: Text[100];
        CI: Record "Company Information";
        prNSSF: record "prNSSF Tiers";
        Tier1Cont: Decimal;
        Tier2Cont: Decimal;
        TotalCont: Decimal;
        PRPeriodTransactions: Record "PR Period Transactions";
        prEmployerDeductions: Record "prEmployer Deductions";
        EmployerAmt: Decimal;
        EmployeeAmt: Decimal;
        TotalAmt: Decimal;
}


