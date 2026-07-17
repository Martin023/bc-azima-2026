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
        dataitem("PR Period Transactions"; "PR Period Transactions")
        {
            //RequestFilterFields = "Transaction Code";
            //DataItemTableView = where("Employer Deduction" = const(true));
            column(TransactionCode; "Transaction Code") { }
            column(TransactionName; "Transaction Name") { }
            column(EmployeeCode; EmployeeCode) { }
            column(EmployeeName; EmployeeName) { }
            column(EmployeeAmt; EmployeeAmt) { }
            column(EmployerAmt; EmployerAmt) { }
            column(TotalAmt; TotalAmt) { }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            trigger OnAfterGetRecord()
            begin
                EmployeeAmt := 0;
                EmployerAmt := 0;
                EmployeeCode := '';
                EmployeeName := '';
                TotalAmt := 0;

                PRTransactionCodes.Reset();
                PRTransactionCodes.SetRange("Employer Deduction", TRUE);
                PRTransactionCodes.SetRange("Transaction Code", "PR Period Transactions"."Transaction Code");
                if PRTransactionCodes.Find('-') then begin

                    PRPeriodTransactions.Reset;
                    PRPeriodTransactions.SetRange("Transaction Code", PRTransactionCodes."Transaction Code");
                    PRPeriodTransactions.SetRange("Payroll Period", SelectedPeriod);
                    if PRPeriodTransactions.FindSet() then begin
                        EmployeeAmt := PRPeriodTransactions.Amount;
                        EmployeeCode := PRPeriodTransactions."Employee Code";
                        Employees.Reset();
                        Employees.SetRange("No.", EmployeeCode);
                        if Employees.Find() then
                            EmployeeName := Employees."First Name" + ' ' + Employees."Middle Name" + ' ' + Employees."Last Name";
                    end;

                    prEmployerDeductions.Reset;
                    prEmployerDeductions.SetRange("Transaction Code", PRTransactionCodes."Transaction Code");
                    prEmployerDeductions.SetRange("Payroll Period", SelectedPeriod);
                    if prEmployerDeductions.FindSet() then begin
                        EmployerAmt := prEmployerDeductions.Amount;
                    end;

                    TotalAmt := EmployeeAmt + EmployerAmt;
                end
                ELSE
                    CurrReport.Skip();
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);

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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";

        // if CI.Get() then
        //     CI.CalcFields(CI.Picture);
    end;

    var
        LastFieldNo: Integer;
        objPeriod: Record "PR Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
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
        PRTransactionCodes: Record "PR Transaction Codes";
        EmployerAmt: Decimal;
        EmployeeAmt: Decimal;
        TotalAmt: Decimal;
        EmployeeCode: Code[20];
}


