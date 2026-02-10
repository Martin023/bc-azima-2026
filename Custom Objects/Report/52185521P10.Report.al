#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185521 P10
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/P10.rdl';

    dataset
    {
        dataitem("PR Payroll Periods"; "PR Payroll Periods")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(PRPayrollPeriod_DateOpened; "PR Payroll Periods"."Date Opened")
            {
            }
            column(GrandTotalPAYE; GrandTotalPAYE)
            {
            }
            column(Tot_PAYE; Tot_PAYE)
            {
            }
            column(SelectedYear; SelectedYear)
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

            trigger OnAfterGetRecord()
            begin
                Tot_PAYE := 0;


                PRPeriodTrans.Reset;
                PRPeriodTrans.SetCurrentkey("Employee Code", "Period Month", "Period Year", "Group Order", "Sub Group Order", "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Payroll Period", "Date Opened");
                PRPeriodTrans.SetFilter(PRPeriodTrans."Contract Type", '<>%1', 'CASUALS');
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'PAYE');
                if PRPeriodTrans.Find('-') then begin
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    Tot_PAYE := PRPeriodTrans.Amount;
                end else begin
                    Tot_PAYE := 0;
                end;


                //Grand Total
                GrandTotalPAYE += Tot_PAYE;
            end;

            trigger OnPreDataItem()
            begin
                //UnknownTable52185613.SetRange("Period Year",SelectedYear);
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
                group(Period)
                {
                    field(Year; SelectedYear)
                    {
                        ApplicationArea = Basic;
                    }
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
        GrandTotalPAYE := 0;

        if SelectedYear = 0 then Error(Text001);

        CompanyInfo.Reset;
        if CompanyInfo.Get then begin
            CompanyInfo.TestField(CompanyInfo.Name);
            //CompanyInfo.TestField(CompanyInfo."PIN No");
        end;
    end;

    var
        SelectedYear: Integer;
        CompanyInfo: Record "Company Information";
        PRPeriodTrans: Record "PR Period Transactions";
        Text001: label 'Please enter Period Year';
        Tot_TaxablePay: Decimal;
        Tot_PAYE: Decimal;
        PayrollPeriod: Date;
        GrandTotalPAYE: Decimal;
        Scheme: Code[20];
}
