namespace AzimaBC.AzimaBC;
using Microsoft.Foundation.Company;

report 52185493 "NSSF Tier II"
{
    ApplicationArea = All;
    Caption = 'NSSF Tier II';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/prNSSF Tier II.rdl';

    dataset
    {
        dataitem("PR Period Transactions"; "PR Period Transactions")
        {
            RequestFilterFields = "Employee Code";
            Dataitemtableview = where("Transaction Code" = filter('NSSF'));

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
            column(USERID; UserId)
            {
            }
            column(TODAY; Today)
            {
            }
            column(PeriodName; PeriodName)
            {
            }

            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(tier1Cont; Tier1Cont)
            {
            }
            column(tier2Cont; Tier2Cont)
            {
            }
            column(totalCont; TotalCont)
            {
            }
            column(prPeriod_Transactions__Group_Text_; "PR Period Transactions"."Employee Code")
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            trigger OnAfterGetRecord()
            begin
                "PR Period Transactions".SetRange("Payroll Period", SelectedPeriod);

                Employees.Reset;
                if Employees.Get("PR Period Transactions"."Employee Code") then
                    EmployeeName := Employees."First Name" + ' ' + Employees."Middle Name" + ' ' + Employees."Last Name"
                else
                    EmployeeName := '';

                prNSSF.Reset;
                prNSSF.SetCurrentkey(prNSSF.Tier);
                if prNSSF.FindFirst then begin
                    Tier1Cont := prNSSF."Tier 1 Employee Deduction";
                end;
                Tier2Cont := "PR Period Transactions".Amount - Tier1Cont;
                //TotalCont := "PR Period Transactions".Amount * 2;
                TotalCont := Tier2Cont * 2;
            end;

            trigger OnPreDataItem()
            begin
                //OnViewCurrRec();
                LastFieldNo := "PR Period Transactions".FieldNo("Period Year");
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

    labels
    {
    }

    trigger OnPreReport()
    begin
        if SelectedPeriod = 0D then Error('You must specify the period filter');

        objPeriod.Reset;
        objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
        if objPeriod.Find('-') then begin
            PeriodName := objPeriod."Period Name";
        end;


        if CI.Get() then
            CI.CalcFields(CI.Picture);
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
}
