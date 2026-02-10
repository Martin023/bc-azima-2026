#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185588 "Period Trans without Employee"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Period Trans without Employee.rdl';

    dataset
    {
        //dataitem(52185624;52185624)
        dataitem("PR Period Transactions"; "PR Period Transactions")
        {
            DataItemTableView = sorting("Employee Code", "Transaction Code", "Period Month", "Period Year", "Reference No");
            RequestFilterFields = "Payroll Period";
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
            column(prPeriod_Transactions__Employee_Code_; "Employee Code")
            {
            }
            column(prPeriod_Transactions__Transaction_Code_; "Transaction Code")
            {
            }
            column(prPeriod_Transactions__Transaction_Name_; "Transaction Name")
            {
            }
            column(prPeriod_Transactions_Amount; Amount)
            {
            }
            column(prPeriod_Transactions_Balance; Balance)
            {
            }
            column(prPeriod_TransactionsCaption; prPeriod_TransactionsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(prPeriod_Transactions__Employee_Code_Caption; "PR Period Transactions".FieldCaption("Employee Code"))
            {
            }
            column(prPeriod_Transactions__Transaction_Code_Caption; "PR Period Transactions".FieldCaption("Transaction Code"))
            {
            }
            column(prPeriod_Transactions__Transaction_Name_Caption; "PR Period Transactions".FieldCaption("Transaction Name"))
            {
            }
            column(prPeriod_Transactions_AmountCaption; "PR Period Transactions".FieldCaption(Amount))
            {
            }
            column(prPeriod_Transactions_BalanceCaption; "PR Period Transactions".FieldCaption(Balance))
            {
            }
            column(prPeriod_Transactions_Period_Month; "Period Month")
            {
            }
            column(prPeriod_Transactions_Period_Year; "Period Year")
            {
            }
            //column(prPeriod_Transactions_Membership; Membership)
            //{
            //}
            column(prPeriod_Transactions_Reference_No; "Reference No")
            {
            }
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
        Employee: Record "HR Employees";
        prPeriod_TransactionsCaptionLbl: label 'prPeriod Transactions';
        CurrReport_PAGENOCaptionLbl: label 'Page';
}
