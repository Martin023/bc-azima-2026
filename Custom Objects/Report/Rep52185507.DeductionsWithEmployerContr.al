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
            // RequestFilterFields = "Transaction Code";
            column(TransactionCode; "PR Period Transactions"."Transaction Code") { }
            column(TransactionName; "PR Period Transactions"."Transaction Name") { }
            column(EmployeeCode; "PR Period Transactions"."Employee Code") { }
            column(EmployeeName; EmployeeName) { }
            column(EmployeeAmt; "PR Period Transactions".Amount) { }
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
                SNO += 1;

                Employees.Reset();
                Employees.SetRange("No.", "PR Period Transactions"."Employee Code");
                if Employees.Find('-') then
                    EmployeeName := Employees."First Name" + ' ' + Employees."Middle Name" + ' ' + Employees."Last Name";

                PRTransactionCodes.Reset();
                PRTransactionCodes.SetRange("Include Employer Deduction", TRUE);
                PRTransactionCodes.SetRange("Transaction Code", "PR Period Transactions"."Transaction Code");
                if PRTransactionCodes.Find('-') then begin
                    prEmployerDeductions.Reset;
                    prEmployerDeductions.SetRange("Transaction Code", PRTransactionCodes."Transaction Code");
                    prEmployerDeductions.SetRange("Payroll Period", SelectedPeriod);
                    if prEmployerDeductions.FindSet() then begin
                        EmployerAmt := prEmployerDeductions.Amount;
                    end;

                    TotalAmt := "PR Period Transactions".Amount + EmployerAmt;
                end
                else
                    CurrReport.Skip();
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);


                "PR Period Transactions".Setrange("Payroll Period", SelectedPeriod);
                "PR Period Transactions".SetRange("Transaction Code", TransactionCode);

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
                field(TransCode; TransactionCode)
                {
                    ApplicationArea = Basic;
                    Caption = 'Transaction Code';
                    TableRelation = "PR Transaction Codes"."Transaction Code" where("Employer Deduction" = filter(true));
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
        if TransactionCode = '' then Error('You must specify Transaction Code');

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
        SNo: Integer;
        TransactionCode: code[30];
}


