#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186508 "P9 Portal"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/P9 Portal.rdl';
    // UsageCategory = Lists;

    dataset
    {
        dataitem("HR Employees"; "HR Employees")
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            // RequestFilterFields = "No.", Status;
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(HREmpPR_ContType; "HR Employees"."Contract Type")
            {
            }
            column(HREmpPR_FName; "HR Employees"."First Name")
            {
            }
            column(HREmpPR_MName; "HR Employees"."Middle Name")
            {
            }
            column(HREmpPR_LName; "HR Employees"."Last Name")
            {
            }
            column(HREmpPR_PinNo; "HR Employees"."PIN No.")
            {
            }
            column(Primary_Identification; "Primary Identification")
            {

            }
            column(EmployeeNo; "HR Employees"."No.")
            {

            }
            column(EmployeeName; "HR Employees".FullName)
            {

            }
            column(CompInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompInfo_PINNo; CompanyInfo."PIN No")
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(HREmpPR_No; "HR Employees"."No.")
            {
            }
            column(PensionContr; PensionContr)
            {
            }
            column(InsuranceRelief; InsuranceRelief)
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            // column(SelectedYear; SelectedYear)
            // {
            // }
            column(BPAY_LessPension; BPAY_LessPension)
            {
            }
            column(TotPensionContr; TotPensionContr)
            {
            }
            dataitem("PR Employee P9 Info"; "PR Employee P9 Info")
            {
                DataItemLink = "Employee Code" = field("No.");
                DataItemTableView = sorting("Employee Code", "Payroll Period") order(ascending);
                PrintOnlyIfDetail = false;
                RequestFilterFields = "Employee Code", "Period Filter";
                column(ReportForNavId_1000000001; 1000000001)
                {
                }
                column(EmployeeCode_PREmployeeP9Info; "PR Employee P9 Info"."Employee Code")
                {
                }
                column(P9Info_EmployeeCode; "PR Employee P9 Info"."Employee Code")
                {
                }
                column(P9Info_PayrollPeriod; "PR Employee P9 Info"."Payroll Period")
                {
                }
                column(P9Info_BasicPay; "PR Employee P9 Info"."Basic Pay")
                {
                }
                column(P9Info_Benefits; "PR Employee P9 Info".Benefits)
                {
                }
                column(PAYE; PAYE)
                {

                }
                column(P9Info_ValueQuarters; "PR Employee P9 Info"."Value Of Quarters")
                {
                }
                column(P9Info_GrossPay; "PR Employee P9 Info"."Gross Pay")
                {
                }
                column(P9Info_NSSF; "PR Employee P9 Info".NSSF)
                {
                }
                column(BasicFraction; BasicFraction)
                {

                }
                column(P9Info_OwnerOccupier; "PR Employee P9 Info"."Owner Occupier Interest")
                {
                }
                column(P9Info_TaxablePay; "PR Employee P9 Info"."Taxable Pay")
                {
                }
                column(P9Info_TaxCharged; "PR Employee P9 Info"."Tax Charged")
                {
                }
                column(P9Info_TaxRelief; "PR Employee P9 Info"."Tax Relief")
                {
                }
                column(NHIF; NHIF)
                {

                }
                COLUMN(Pension; Pension)
                {

                }
                column(Fixed; Fixed)
                {

                }
                column(TotPension; TotPension)
                {

                }
                column(Lower; Lower)
                {

                }
                column(EF; EF)
                {

                }

                trigger OnAfterGetRecord()
                begin

                    //Initialize
                    InsuranceRelief := 0;
                    PensionContr := 0;
                    TotTaxableAllow := 0;
                    BasicPay := 0;
                    BPAY_LessPension := 0;
                    NSSFContribution := 0;
                    TotPensionContr := 0;
                    VolNSSFContribution := 0;
                    Fixed := 0;
                    VoluntaryPension := 0;
                    TotPension := 0;
                    EF := 0;

                    //30% of basic pay
                    BasicFraction := 0.3 * "PR Employee P9 Info"."Basic Pay";

                    //Pension Contribution
                    fn_PRPeriodTransactions;
                    PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'D048');  //Transaction Code for Pension Contribution
                    if PRPeriodTrans.Find('-') then begin
                        PensionContr := PRPeriodTrans.Amount;
                    end else begin
                        PensionContr := 0;
                    end;

                    //Insurance Relief
                    PRSalaryCard.Reset;
                    if PRSalaryCard.Get("Employee Code") then begin
                        //Only allow Insurance relief is staff has brough insurance certificate
                        if PRSalaryCard."Insurance Certificate?" then begin
                            PRTransCodes.Reset;
                            PRTransCodes.SetRange(PRTransCodes."Special Transactions", PRTransCodes."special transactions"::"Life Insurance");
                            if PRTransCodes.Find('-') then begin
                                repeat
                                    //Sum up all Insurance Reliefs for current Employee
                                    fn_PRPeriodTransactions;
                                    PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", PRTransCodes."Transaction Code");
                                    if PRPeriodTrans.Find('-') then begin
                                        InsuranceRelief += PRPeriodTrans.Amount;
                                        InsuranceRelief := 0.15 * InsuranceRelief;
                                    end;
                                until PRTransCodes.Next = 0;
                            end;
                        end;
                    end;


                    //Basic Pay + ALL Taxable Allowances
                    PRTransCodes.Reset;
                    PRTransCodes.SetRange(PRTransCodes."Transaction Type", PRTransCodes."transaction type"::Income);
                    PRTransCodes.SetRange(PRTransCodes.Taxable, true);
                    if PRTransCodes.Find('-') then begin
                        repeat
                            fn_PRPeriodTransactions;
                            PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", PRTransCodes."Transaction Code");
                            if PRPeriodTrans.Find('-') then begin
                                TotTaxableAllow := TotTaxableAllow + PRPeriodTrans.Amount;  //Total Taxable Allowances
                            end;
                        until PRTransCodes.Next = 0;
                        BasicPay := "Basic Pay" + TotTaxableAllow;
                        //error('Total Taxable Allowances is %1 and Basic Pay is %2',TotTaxableAllow,BasicPay);
                    end;


                    //Volunatary NSSF
                    fn_PRPeriodTransactions;
                    PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'D49');
                    if PRPeriodTrans.Find('-') then begin
                        VolNSSFContribution := PRPeriodTrans.Amount;
                    end else begin
                        VolNSSFContribution := 0;
                    end;
                    //Voluntary Pension
                    fn_PRPeriodTransactions;
                    PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'D078');
                    if PRPeriodTrans.Find('-') then begin
                        VoluntaryPension := PRPeriodTrans.Amount;
                    end else begin
                        VoluntaryPension := 0;
                    end;
                    TotPension := VoluntaryPension + PensionContr;

                    //Pension Contribution  + Employer NSSF Contribution + Voluntary NSSF
                    fn_PRPeriodTransactions;
                    PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'NSSF');
                    if PRPeriodTrans.Find('-') then begin
                        NSSFContribution := PRPeriodTrans.Amount;
                        TotPensionContr := NSSFContribution + PensionContr + VolNSSFContribution;
                    end else begin
                        NSSFContribution := 0;
                    end;


                    //Basic Pay less pension
                    BPAY_LessPension := BasicPay - TotPensionContr;
                    if RatesCeilings.get() then begin
                        Fixed := RatesCeilings."Max Pension Contribution";
                    end;
                    Lower := Fixed;

                    if TotPension < Lower then
                        Lower := TotPension else if
"PR Employee P9 Info".NSSF < Lower then
                                                Lower := "PR Employee P9 Info".NSSF;
                    EF := Lower + "PR Employee P9 Info"."Owner Occupier Interest";

                end;




                trigger OnPreDataItem()
                begin

                    //Filter by Selected Year
                    //UnknownTable52185625.SetRange("Period Year", SelectedYearInteger);
                end;
            }
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        "HR Employees".SetFilter("No.", "PR Employee P9 Info"."Employee Code");

        CompanyInfo.Reset;
        if CompanyInfo.Get then begin
            CompanyInfo.CalcFields(CompanyInfo.Picture);
            CompanyInfo.TestField(CompanyInfo.Name);
            //CompanyInfo.TESTFIELD(CompanyInfo."PIN No");
        end;
    end;

    var
        // SelectedYear: Option " ","2022","2023","2024","2025","2026","2027","2028","2029","2030";
        CompanyInfo: Record "Company Information";
        PRPeriodTrans: Record "PR Period Transactions";
        PensionContr: Decimal;
        PRTransCodes: Record "PR Transaction Codes";
        InsuranceRelief: Decimal;
        PRSalaryCard: Record "PR Salary Card";
        BasicPay: Decimal;
        TotTaxableAllow: Decimal;
        BPAY_LessPension: Decimal;
        NSSFContribution: Decimal;
        TotPensionContr: Decimal;
        VolNSSFContribution: Decimal;
        pfringe: decimal;
        BasicFraction: decimal;
        VoluntaryPension: decimal;
        Fixed: decimal;
        RatesCeilings: record "PR Vital Setup Info";
        TotPension: decimal;
        Lower: decimal;
        i: integer;
        EF: decimal;


    procedure fn_PRPeriodTransactions()
    begin
        PRPeriodTrans.Reset;
        PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", "PR Employee P9 Info"."Payroll Period");
        PRPeriodTrans.SetRange(PRPeriodTrans."Employee Code", "PR Employee P9 Info"."Employee Code");
    end;
}
