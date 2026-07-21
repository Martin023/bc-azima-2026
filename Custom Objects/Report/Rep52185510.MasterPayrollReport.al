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
        dataitem("PR Salary Card"; "PR Salary Card")
        {
            column(SelectedPeriod; SelectedPeriod) { }
            column(Employee_Code; "Employee Code") { }
            column(strEmpName; strEmpName) { }
            column(BPAY; BPAY) { }
            column(HALLOW; HALLOW) { }
            column(COMMALL; COMMALL) { }
            column(BHC; BHC) { }
            column(MRKTINGALL; MRKTINGALL) { }
            column(TRAVELANDSUB; TRAVELANDSUB) { }
            column(MKTSUBACT; MKTSUBACT) { }
            column(GPAY; GPAY) { }
            column(NSSFSELFI; NSSFSELFI) { }
            column(NSSFSEFLII; NSSFSEFLII) { }
            column(TOTNSSF; TOTNSSF) { }
            column(PensSELF; PensSELF) { }
            column(SHIF; SHIF) { }
            column(HLEVY; HLEVY) { }
            column(SHARECAP; SHARECAP) { }
            column(MEMDEPOSIT; MEMDEPOSIT) { }
            column(CAPITALLOAN; CAPITALLOAN) { }
            column(NML; NML) { }
            column(FSAHRES; FSAHRES) { }
            column(HELB; HELB) { }
            column(INSBRITAM; INSBRITAM) { }
            column(INSICEA; INSICEA) { }
            column(MORGAGE; MORGAGE) { }
            column(MORTINT; MORTINT) { }
            column(EML; EML) { }
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
                PAYE := 0;
                HALLOW := 0;
                BHC := 0;
                NSSFSELFI := 540;
                NSSFSEFLII := 0;
                TOTNSSF := 0;
                PensSELF := 0;
                SHIF := 0;
                HLEVY := 0;
                SHARECAP := 0;
                MEMDEPOSIT := 0;
                CAPITALLOAN := 0;
                NML := 0;
                FSAHRES := 0;
                HELB := 0;
                INSBRITAM := 0;
                INSICEA := 0;
                MORGAGE := 0;
                MORTINT := 0;
                EML := 0;
                TRAVELANDSUB := 0;
                MRKTINGALL := 0;


                if HREmployee.Get("PR Salary Card"."Employee Code") then
                    strEmpName := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";

                PeriodTrans.Reset();
                PeriodTrans.Setrange("Employee Code", "PR Salary Card"."Employee Code");
                PeriodTrans.Setrange("Payroll Period", SelectedPeriod);
                //PeriodTrans.Setfilter(PeriodTrans."Transaction Code", '=%1|%2|%3|%4|%5', 'BPAY', 'GPAY', 'NPAY', 'TOT-DED', 'PAYE');
                if PeriodTrans.findset() then begin
                    repeat
                        case
                         PeriodTrans."Transaction Code" of
                            'BPAY':
                                BPAY := PeriodTrans.Amount;
                            'E001':
                                HALLOW := PeriodTrans.Amount;
                            'E002':
                                COMMALL := PeriodTrans.Amount;
                            'E003':
                                MRKTINGALL := PeriodTrans.Amount;
                            'E004':
                                TRAVELANDSUB := PeriodTrans.Amount;
                            'GPAY':
                                GPAY := PeriodTrans.Amount;
                            'NSSF':
                                NSSFSEFLII := PeriodTrans.Amount - NSSFSELFI;
                            'D048':
                                PensSELF := PeriodTrans.Amount;
                            'D049':
                                SHIF := PeriodTrans.Amount;
                            'D080':
                                HLEVY := PeriodTrans.Amount;
                            'D003':
                                SHARECAP := PeriodTrans.Amount;
                            'D006':
                                FSAHRES := PeriodTrans.Amount;
                            'D028':
                                HELB := PeriodTrans.Amount;
                            'D009':
                                INSBRITAM := PeriodTrans.Amount;
                            'D010':
                                INSICEA := PeriodTrans.Amount;
                            'D004':
                                NML := PeriodTrans.Amount;
                            'D008':
                                CAPITALLOAN := PeriodTrans.Amount;
                            'D051':
                                EML := PeriodTrans.Amount;
                            'D011':
                                MORGAGE := PeriodTrans.Amount;
                            'D012':
                                MORTINT := PeriodTrans.Amount;
                            'D002':
                                MEMDEPOSIT := PeriodTrans.Amount;

                        end;

                    until PeriodTrans.Next() = 0;
                    BHC := BPAY + HALLOW + COMMALL;
                    MKTSUBACT := MRKTINGALL + TRAVELANDSUB;
                    TOTNSSF := NSSFSEFLII + NSSFSELFI;
                end;
                if BPAY = 0 then CurrReport.skip;
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
        if CI.Get() then
            CI.CalcFields(CI.Picture)
    end;

    var
        strEmpName: Text[100];
        HALLOW: Decimal;
        COMMALL: Decimal;
        BHC: Decimal;
        PeriodTrans: Record "PR Period Transactions";
        SelectedPeriod: Date;
        PeriodName: Text[50];
        HREmployee: Record "HR Employees";
        CI: Record "Company Information";
        BPAY: Decimal;
        GPAY: Decimal;
        NPAY: Decimal;
        PAYE: Decimal;
        MRKTINGALL: Decimal;
        TRAVELANDSUB: Decimal;
        NSSFSELFI: Decimal;
        NSSFSEFLII: Decimal;
        TOTNSSF: Decimal;
        PensSELF: Decimal;
        SHIF: Decimal;
        HLEVY: Decimal;
        SHARECAP: Decimal;
        MEMDEPOSIT: Decimal;
        CAPITALLOAN: Decimal;
        NML: Decimal;
        FSAHRES: Decimal;
        HELB: Decimal;
        INSBRITAM: Decimal;
        INSICEA: Decimal;
        MORGAGE: Decimal;
        MORTINT: Decimal;
        EML: Decimal;
        MKTSUBACT: Decimal;


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
