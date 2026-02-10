#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185573 "PrAllowances Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/PrAllowances Summary.rdl';

    dataset
    {
        dataitem("PR Period Transactions"; "PR Period Transactions")
        {
            DataItemTableView = sorting("Group Order", "Transaction Code", "Period Month", "Period Year");
            RequestFilterFields = "Payroll Period";
            column(ReportForNavId_1; 1)
            {
            }
            column(EmployeeCode_PRPeriodTransactions; "PR Period Transactions"."Employee Code")
            {
            }
            column(TransactionCode_PRPeriodTransactions; "PR Period Transactions"."Transaction Code")
            {
            }
            column(GroupText_PRPeriodTransactions; "PR Period Transactions"."Group Text")
            {
            }
            column(TransactionName_PRPeriodTransactions; "PR Period Transactions"."Transaction Name")
            {
            }
            column(Amount_PRPeriodTransactions; "PR Period Transactions".Amount)
            {
            }
            column(Balance_PRPeriodTransactions; "PR Period Transactions".Balance)
            {
            }
            column(OriginalAmount_PRPeriodTransactions; "PR Period Transactions"."Original Amount")
            {
            }
            column(GroupOrder_PRPeriodTransactions; "PR Period Transactions"."Group Order")
            {
            }
            column(SubGroupOrder_PRPeriodTransactions; "PR Period Transactions"."Sub Group Order")
            {
            }
            column(PeriodMonth_PRPeriodTransactions; "PR Period Transactions"."Period Month")
            {
            }
            column(PeriodYear_PRPeriodTransactions; "PR Period Transactions"."Period Year")
            {
            }
            column(PeriodFilter_PRPeriodTransactions; "PR Period Transactions"."Period Filter")
            {
            }
            column(PayrollPeriod_PRPeriodTransactions; "PR Period Transactions"."Payroll Period")
            {
            }
            column(LastFieldNo; LastFieldNo)
            {
            }
            column(FooterPrinted; FooterPrinted)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(SelectedPeriod; SelectedPeriod)
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            column(TotalsAllowances; TotalsAllowances)
            {
            }
            column(TotalFor; TotalFor)
            {
            }
            column(GroupOrder; GroupOrder)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Amount <= 0 then
                    CurrReport.Skip;
                TotalsAllowances := TotalsAllowances + "PR Period Transactions".Amount;
            end;

            trigger OnPreDataItem()
            begin
                OnViewCurrRec();

                "PR Period Transactions".SetRange("Payroll Period", SelectedPeriod);
                "PR Period Transactions".SetFilter("Group Order", '=1');
                "PR Period Transactions".SetFilter("Transaction Code", '<>GPAY');
                LastFieldNo := "PR Period Transactions".FieldNo("Period Year");
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
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

        SelectedPeriod := "PR Period Transactions".GetRangeMin("Payroll Period");
        objPeriod.Reset;
        objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
        if objPeriod.Find('-') then begin
            PeriodName := objPeriod."Period Name";
        end;

        CompanyInfo.Reset;
        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture)
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        PeriodTrans: Record "PR Period Transactions";
        objPeriod: Record "PR Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        CompanyInfo: Record "Company Information";
        TotalsAllowances: Decimal;
        TotalFor: label 'Total for ';
        GroupOrder: label '3';


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
