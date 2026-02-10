namespace KenpipeBC.KenpipeBC;
using System.Environment;
using Microsoft.Foundation.Company;

report 52186214 "Payroll Variance Report"
{
    ApplicationArea = All;
    Caption = 'Payroll Variance Report';
    RDLCLayout = './bc-kenpipe-2024/Layout/Payroll Variance Report.rdl';
    UsageCategory = ReportsAndAnalysis;
    //Basic,Gross and Net Pay changes.
    dataset
    {
        //dataitem("PR Employee Transactions"; "PR Employee Transactions")
        dataitem("PR Period Transactions"; "PR Period Transactions")
        {
            RequestFilterFields = "Employee Code";
            
            column(Transaction_Code; "Transaction Code") { }
            column(Transaction_Name; "Transaction Name") { }
            column(Employee_Code; "Employee Code") { }
            column(Employee_Name; Employee_Name) { }
            column(Variance; Variance) { }
            column(CurrentPeriod; CurrentPeriod) { }
            column(PreviousPeriod; PreviousPeriod) { }
            column(PreviousAmount; PreviousAmount) { }
            column(CurrentAmount; CurrentAmount) { }
            column(CompanyInformation_Name; CompanyInformation.Name) { }
            column(CompanyInformation_Picture; CompanyInformation.Picture) { }
            column(CompanyAddress; CompanyAddress) { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(CommunicationOnline; CommunicationOnline) { }

            trigger OnAfterGetRecord()
            begin
                PreviousAmount := 0;
                CurrentAmount := 0;
                Variance := 0;
                TransactionCode := '';
                TransactionName := '';
                Employee_Name := '';


                // if HRTable.Get("PR Period Transactions"."Employee Code") then
                // Employee_Name := HRTable."Full Name";

                HRTable.Reset();
                HRTable.SetRange("No.", "PR Period Transactions"."Employee Code");
                if HRTable.Find('-') then
                    Employee_Name := HRTable."First Name" + ' ' +HRTable."Middle Name" + ' ' + HRTable."Last Name";


                //BPAY|NPAY|GPAY
                // if ("PR Period Transactions"."Transaction Code" <> 'BPAY') OR ("PR Period Transactions"."Transaction Code" <> 'GPAY') OR ("PR Period Transactions"."Transaction Code" <> 'NPAY') then
                //     CurrReport.Skip
                // else begin
                CurrentAmount := "PR Period Transactions".Amount;

                PRPeriodTrans.Reset();
                PRPeriodTrans.SetRange("Transaction Code", "PR Period Transactions"."Transaction Code");
                PRPeriodTrans.SetRange("Employee Code", "PR Period Transactions"."Employee Code");
                PRPeriodTrans.SetRange("Payroll Period", PreviousPeriod);
                if PRPeriodTrans.Find('-') then begin
                    PreviousAmount := PRPeriodTrans.Amount;
                end;

                Variance := CurrentAmount - PreviousAmount;
                //IF (PreviousAmount = 0) and (CurrentAmount = 0) then CurrReport.Skip();
                //end;
            end;

            trigger OnPreDataItem()
            begin
                "PR Period Transactions".Reset();
                "PR Period Transactions".Setfilter("Payroll Period", '=%1', CurrentPeriod);
                "PR Period Transactions".SetFilter("Transaction Code", '=%1|=%2|=%3', 'BPAY', 'GPAY', 'NPAY');
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(CurrentPeriod; CurrentPeriod)
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Period';
                    TableRelation = "PR Payroll Periods";
                }
                field(PreviousPeriod; PreviousPeriod)
                {
                    ApplicationArea = Basic;
                    Caption = 'Previous Period';
                    TableRelation = "PR Payroll Periods";
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    trigger OnPreReport()
    begin
        //if (CurrentPeriod = 0D) and (PreviousPeriod = 0D) then Error('You must specify the period filter');
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        PreviousPeriodName: Text[50];
        CurrentPeriodName: Text[50];
        PreviousAmount: decimal;
        PreviousPeriod: date;
        CurrentPeriod: date;
        CurrentAmount: decimal;
        Variance: decimal;
        //Bpay: decimal;
        TransactionCode: code[30];
        TransactionName: text[100];
        HREmp: Record "HR Employees";
        CompanyInformation: Record "Company Information";
        PEmployeeTrans: Record "PR Employee Transactions";
        PRPeriodTrans: Record "PR Period Transactions";
        HRTable: Record "HR Employees";
        Employee_Name: Text;
}
