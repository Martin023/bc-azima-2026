#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185520 P10A
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/P10A.rdl';

    dataset
    {
        dataitem("HR Employees"; "HR Employees")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(HREmpPR_No; "HR Employees"."No.")
            {
            }
            column(HREmpPR_FName; "HR Employees"."First Name")
            {
            }
            column(HREmpPR_PinNo; "HR Employees"."PIN No.")
            {
            }
            column(HREmpPR_MName; "HR Employees"."Middle Name")
            {
            }
            column(HREmpPR_LName; "HR Employees"."Last Name")
            {
            }
            column(Tot_TaxablePay; Tot_TaxablePay)
            {
            }
            column(Tot_PAYE; Tot_PAYE)
            {
            }
            column(SelectedYear; SelectedYear)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoPINNo; CompanyInfo."PIN No")
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Total Taxable Pay
                PRPeriodTrans.Reset;
                PRPeriodTrans.SetCurrentkey("Employee Code", "Transaction Code", "Period Month", "Period Year", "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Period Year", SelectedYear);
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'TXBP');
                PRPeriodTrans.SetRange(PRPeriodTrans."Employee Code", "No.");
                //PRPeriodTrans.SETRANGE(PRPeriodTrans."Period Closed",true);
                if PRPeriodTrans.Find('-') then begin
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    Tot_TaxablePay := PRPeriodTrans.Amount;
                end else begin
                    Tot_TaxablePay := 0;
                end;

                //Total PAYE
                PRPeriodTrans.Reset;
                PRPeriodTrans.SetCurrentkey("Employee Code", "Transaction Code", "Period Month", "Period Year", "Reference No");
                PRPeriodTrans.SetRange(PRPeriodTrans."Period Year", SelectedYear);
                PRPeriodTrans.SetRange(PRPeriodTrans."Transaction Code", 'PAYE');
                PRPeriodTrans.SetRange(PRPeriodTrans."Employee Code", "No.");
                //PRPeriodTrans.SETRANGE(PRPeriodTrans."Period Closed",true);
                if PRPeriodTrans.Find('-') then begin
                    PRPeriodTrans.CalcSums(PRPeriodTrans.Amount);
                    Tot_PAYE := PRPeriodTrans.Amount;
                end else begin
                    Tot_PAYE := 0;
                end;
                if (Tot_TaxablePay = 0) and (Tot_PAYE = 0) then CurrReport.Skip;
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

        if SelectedYear = 0 then Error(Text001);

        CompanyInfo.Reset;
        if CompanyInfo.Get then begin
            CompanyInfo.TestField(CompanyInfo.Name);
            //CompanyInfo.TestField(CompanyInfo."PIN No");
            CompanyInfo.CalcFields(CompanyInfo.Picture);
        end;
    end;

    var
        SelectedYear: Integer;
        CompanyInfo: Record "Company Information";
        PRPeriodTrans: Record "PR Period Transactions";
        Text001: label 'Please enter Period Year';
        Tot_TaxablePay: Decimal;
        Tot_PAYE: Decimal;
        PRPeriodTrans_1: Record "PR Period Transactions";
        PRPeriodTrans_2: Record "PR Period Transactions";
        PRPayrollPeriod: Record "PR Payroll Periods";
}
