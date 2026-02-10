#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185592 "Payroll Summary Simplified"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Payroll Summary Simplified.rdl';

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(DepartmentCode_HREmployee; "HR Employees"."Department Code")
            {
            }
            column(No_HREmployee; "HR Employees"."No.")
            {
            }
            column(FirstName_HREmployee; "HR Employees"."First Name")
            {
            }
            column(MiddleName_HREmployee; "HR Employees"."Middle Name")
            {
            }
            column(LastName_HREmployee; "HR Employees"."Last Name")
            {
            }
            column(Initials_HREmployee; "HR Employees".Initials)
            {
            }
            column(StatutoriesLCY; StatutoriesLCY)
            {
            }
            column(NPAYLCY; NPAYLCY)
            {
            }
            column(NPAY; NPAY)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }

            trigger OnAfterGetRecord()
            begin
                AllowancesLCY := 0;
                DeductionsLCY := 0;
                NPAYLCY := 0;
                PeriodTransactions.Reset;
                //PeriodTransactions.SETCURRENTKEY(PeriodTransactions."Employee Code",PeriodTransactions."Period Month",PeriodTransactions."Period Year",
                //PeriodTransactions."Group Order",PeriodTransactions."Sub Group Order",PeriodTransactions."Payslip Order");
                PeriodTransactions.SetRange(PeriodTransactions."Employee Code", "HR Employees"."No.");
                PeriodTransactions.SetRange(PeriodTransactions."Payroll Period", "Current Period Filter");
                PeriodTransactions.SetRange(PeriodTransactions."Company Deduction", false);         //dennis to filter our company deductions
                if PeriodTransactions.FindSet then
                    repeat

                        if (PeriodTransactions."Group Text" = 'ALLOWANCE') and (PeriodTransactions."Employee Classification" <> 'NGN') then
                            AllowancesLCY += PeriodTransactions.Amount
                        else
                            if (PeriodTransactions."Group Text" = 'DEDUCTIONS') then
                                if (PeriodTransactions."Employee Classification" = 'NGN') then // get allowances that are not the total deductions
                                    DeductionsLCY += PeriodTransactions.Amount
                                else
                                    TotalDeductionsLCY := PeriodTransactions.Amount
                            else
                                if (PeriodTransactions."Group Text" = 'STATUTORIES') and (PeriodTransactions."Employee Classification" <> 'NGN') then
                                    StatutoriesLCY += PeriodTransactions.Amount
                                else
                                    if (PeriodTransactions."Transaction Code" = 'NPAY') and (PeriodTransactions."Employee Classification" <> 'NGN') then
                                        NPAY := PeriodTransactions.Amount;

                    until PeriodTransactions.Next = 0;

                NPAYLCY := AllowancesLCY - (TotalDeductionsLCY - DeductionsLCY) - StatutoriesLCY;
            end;

            trigger OnPreDataItem()
            begin
                //UnknownTable "HR EMPLOYEES".SetFilter("Current Month Filter", Format("Current Period Filter"));
                "HR Employees".SetFilter("Current Month Filter", Format("Current Period Filter"));
                if "HR Employees".GetFilter("HR Employees"."Current Month Filter") = '' then
                    Error('You must specify current Period filter.');
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
                field("Current Period Filter"; "Current Period Filter")
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Period Filter';
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        AllowancesLCY: Decimal;
        DeductionsLCY: Decimal;
        StatutoriesLCY: Decimal;
        PeriodTransactions: Record "PR Period Transactions";
        NPAYLCY: Decimal;
        NPAY: Decimal;
        TotalDeductionsLCY: Decimal;
        CompanyInfo: Record "Company Information";
        "Current Period Filter": Date;
}
