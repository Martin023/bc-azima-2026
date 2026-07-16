namespace AzimaBC.AzimaBC;
using Microsoft.Foundation.Company;

report 52185511 "Master Payroll Report"
{
    ApplicationArea = All;
    Caption = 'Master Payroll Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Master Payroll Report.rdl';

    dataset
    {
        dataitem("PR Transaction Codes"; "PR Transaction Codes")
        {
            RequestFilterFields = "Transaction Code";
            // dataitem("PR Period Transactions"; "PR Period Transactions")
            //"PR Employee Transactions"
            dataitem("PR Employee Transactions"; "PR Employee Transactions")
            {
                DataItemLink = "Transaction Code" = field("Transaction Code");
                RequestFilterFields = "Payroll Period";
                column(Employee_Code; "Employee Code") { }
                column(strEmpName; strEmpName) { }
                column(Transaction_Code; "Transaction Code") { }
                column(Transaction_Name; "Transaction Name") { }
                column(BPAY; BPAY) { }
                column(GPAY; GPAY) { }
                column(NPAY; NPAY) { }
                column(TotDed; TotDed) { }
                column(TotAllow; TotAllow) { }
                column(Amount; Amount) { }
                column(Employer_Amount; "Employer Amount") { }
                column(PeriodName; PeriodName) { }
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
                var
                    myInt: Integer;
                begin
                    strEmpName := '';
                    BPAY := 0;
                    GPAY := 0;
                    NPAY := 0;

                    if HREmployee.Get("PR Employee Transactions"."Employee Code") then
                        strEmpName := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";


                    PeriodTrans.Reset();
                    PeriodTrans.Setrange("Employee Code", "PR Employee Transactions"."Employee Code");
                    PeriodTrans.Setrange("Payroll Period", SelectedPeriod);
                    PeriodTrans.Setfilter(PeriodTrans."Transaction Code", '=%1|%2|%3|%4', 'BPAY', 'GPAY', 'NPAY', 'TOT-DED');
                    if PeriodTrans.Find('-') then begin
                        repeat
                            if PeriodTrans."Transaction Code" = 'BPAY' then begin
                                BPAY := PeriodTrans.Amount;
                            end;
                            if PeriodTrans."Transaction Code" = 'GPAY' then begin
                                GPAY := PeriodTrans.Amount;
                            end;
                            if PeriodTrans."Transaction Code" = 'NPAY' then begin
                                NPAY := PeriodTrans.Amount;
                            end;
                            if PeriodTrans."Transaction Code" = 'TOT-DED' then
                                TotDed := PeriodTrans.Amount;
                        until PeriodTrans.Next() = 0;
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                if "PR Transaction Codes"."Transaction Type" = "PR Transaction Codes"."Transaction Type"::Income then begin
                    PeriodTrans.Reset();
                    PeriodTrans.Setrange("Employee Code", "PR Employee Transactions"."Employee Code");
                    PeriodTrans.Setrange("Payroll Period", SelectedPeriod);
                    PeriodTrans.Setfilter(PeriodTrans."Transaction Code", "PR Transaction Codes"."Transaction Code");
                    if PeriodTrans.Find('-') then begin
                        Allow := PeriodTrans.Amount;
                    end;
                    TotAllow := TotAllow + Allow;
                end;
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

        //SelectedPeriod:=objPeriod.GETFILTER("Date Opened");
        //SelectedPeriod := "PR Period Transactions".GetRangeMin("Payroll Period");
        SelectedPeriod := "PR Employee Transactions".GetRangeMin("Payroll Period");
        Message('Selected Period: %1', SelectedPeriod);
        objPeriod.Reset;
        objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
        if objPeriod.Find('-') then begin
            PeriodName := objPeriod."Period Name";
        end;


        if CI.Get() then
            CI.CalcFields(CI.Picture)
    end;

    var
        strEmpName: Text[100];
        Grosspay: Decimal;
        PenGrat: Decimal;
        Nssf: Decimal;
        subTotNssf: Decimal;
        TotPenGrat: Decimal;
        TotNssf: Decimal;
        PeriodTrans: Record "PR Period Transactions";
        TransCodes: Record "PR Transaction Codes";
        objPeriod: Record "PR Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[50];
        HREmployee: Record "HR Employees";
        CompanyInfo: Record "Company Information";
        PayrollMode: Option " ","Bank Transfer",Cheque,Cash,SACCO;
        CI: Record "Company Information";
        BPAY: Decimal;
        GPAY: Decimal;
        NPAY: Decimal;
        TotDed: Decimal;
        TotAllow: Decimal;
        Allow: Decimal;

    procedure OnViewCurrRec()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestricViewTxt: label 'You do not have Permissions to VIEW,MODIFY or DELETE on this record. Contact system administrator for assistance. %';
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("View Payroll", true);
        ChangePermission.SetRange("Function Extended", ChangePermission."function extended"::"View Payroll");
        if not ChangePermission.Find('-') then
            Error(ErrorOnRestricViewTxt, UserId);
    end;
}
