#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185554 "prLoan Payment History"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/prLoan Payment History.rdl';

    dataset
    {
        dataitem("PR Period Transactions"; "PR Period Transactions")
        {
            DataItemTableView = sorting("Employee Code", "Transaction Code", "Period Month", "Period Year", "Reference No");
            RequestFilterFields = "Employee Code", "Transaction Code";
            column(ReportForNavId_7769; 7769)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}
            column(USERID; UserId)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(prPeriod_Transactions__Employee_Code_; "Employee Code")
            {
            }
            column(EName; EName)
            {
            }
            column(prPeriod_Transactions__Transaction_Code_; "Transaction Code")
            {
            }
            column(prPeriod_Transactions__Transaction_Name_; "Transaction Name")
            {
            }
            column(MonthName; MonthName)
            {
            }
            column(prPeriod_Transactions__Period_Year_; "Period Year")
            {
            }
            column(prPeriod_Transactions_Amount; Amount)
            {
            }
            column(prPeriod_Transactions_Balance; Balance)
            {
            }
            column(prPeriod_Transactions_Amount_Control1102755010; Amount)
            {
            }
            column(Employee_Transaction_HistoryCaption; Employee_Transaction_HistoryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(prPeriod_Transactions__Employee_Code_Caption; "PR Period Transactions".FieldCaption("Employee Code"))
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(TransactionCaption; TransactionCaptionLbl)
            {
            }
            column(Running_BalanceCaption; Running_BalanceCaptionLbl)
            {
            }
            column(prPeriod_Transactions_AmountCaption; "PR Period Transactions".FieldCaption(Amount))
            {
            }
            column(YearCaption; YearCaptionLbl)
            {
            }
            column(MonthCaption; MonthCaptionLbl)
            {
            }
            column(prPeriod_Transactions_Period_Month; "Period Month")
            {
            }
            //column(prPeriod_Transactions_Membership; Membership)
            //{
            //}
            column(prPeriod_Transactions_Reference_No; "Reference No")
            {
            }

            trigger OnAfterGetRecord()
            begin
                MonthName := Format("PR Period Transactions"."Payroll Period", 0, '<Month Text>');
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := "PR Period Transactions".FieldNo("Transaction Code");
                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(CompanyInfo.Picture);
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

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: label 'Total for ';
        MonthName: Text[100];
        EName: Text[200];
        HREmployee: Record "HR Employees";
        CompanyInfo: Record "Company Information";
        Employee_Transaction_HistoryCaptionLbl: label 'Employee Transaction History';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Employee_NameCaptionLbl: label 'Employee Name';
        TransactionCaptionLbl: label 'Transaction';
        Running_BalanceCaptionLbl: label 'Running Balance';
        YearCaptionLbl: label 'Year';
        MonthCaptionLbl: label 'Month';
}
