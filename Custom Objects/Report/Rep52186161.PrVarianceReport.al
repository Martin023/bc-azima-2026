namespace mns.mns;
using Microsoft.Foundation.Company;
using System.Security.User;
using Microsoft.Finance.Dimension;

report 52186179 "Pr Variance Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/PR Variance2.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {


        dataitem("PR Employee Transactions"; "PR Employee Transactions")
        {

            column(Transaction_Code; "Transaction Code")
            {

            }
            column(Transaction_Name; "Transaction Name")
            {

            }


            column(Employee_Code; "Employee Code")
            {

            }
            column(Variance; Variance)
            {

            }
            column(CurrentPeriod; CurrentPeriod)
            {

            }
            column(PreviousPeriod; PreviousPeriod)
            {

            }
            column(PreviousAmount; PreviousAmount)
            {

            }
            column(CurrentAmount; CurrentAmount)
            {

            }


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

            column(Bpay; Bpay)
            {

            }

            column(EmployeeCode; EmployeeCode)
            {

            }
            column(EmployeeName; EmployeeName)
            { }



            trigger OnAfterGetRecord()
            begin
                PreviousAmount := 0;
                CurrentAmount := 0;
                Variance := 0;
                TransactionCode := '';
                TransactionName := '';
                PEmployeeTrans.Reset();
                PEmployeeTrans.SetRange("Transaction Code", "PR Employee Transactions"."Transaction Code");
                PEmployeeTrans.SetRange("Employee Code", "PR Employee Transactions"."Employee Code");
                PEmployeeTrans.SetRange("Payroll Period", PreviousPeriod);
                if PEmployeeTrans.Find('-') then begin
                    PEmployeeTrans.CalcSums(Amount);
                    PreviousAmount := PEmployeeTrans.Amount;
                end;

                CurrentAmount := "PR Employee Transactions".Amount;
                Variance := CurrentAmount - PreviousAmount;
                IF (PreviousAmount = 0) and (CurrentAmount = 0) then CurrReport.Skip();


            end;

            trigger OnPreDataItem()
            begin

                "PR Employee Transactions".Setfilter("Payroll Period", '%1', CurrentPeriod);

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
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if (CurrentPeriod = 0D) and (PreviousPeriod = 0D) then Error('You must specify the period filter');
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
        Bpay: decimal;
        TransactionCode: code[30];
        TransactionName: text[100];
        HREmp: Record "HR Employees";


        SalInfo: record "PR Salary Card";
        CI: Record "Company Information";
        //Variance: Record "PrMonthly Variance";
        PEmployeeTrans: Record "PR Employee Transactions";
        CompanyInformation: record "Company Information";
        PrMonthlyVariance: record "PrMonthly Variance";
        EmployeeCode: Code[50];
        EmployeeName: text[100];

}
