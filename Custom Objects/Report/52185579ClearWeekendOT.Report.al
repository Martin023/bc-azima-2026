#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185579 "Clear Weekend OT"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Clear Weekend OT.rdl';

    dataset
    {
        dataitem("PR Employee Transactions"; "PR Employee Transactions")
        {
            //DataItemTableView = sorting("Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period", "Reference No") where("Payroll Period" = const("10/01/12"), "Transaction Code" = filter(WKE | E5411));
            column(ReportForNavId_5642; 5642)
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
            column(prEmployee_Transactions__Employee_Code_; "Employee Code")
            {
            }
            column(prEmployee_Transactions__Transaction_Code_; "Transaction Code")
            {
            }
            column(prEmployee_Transactions__Transaction_Name_; "Transaction Name")
            {
            }
            column(prEmployee_Transactions_Amount; Amount)
            {
            }
            column(prEmployee_TransactionsCaption; prEmployee_TransactionsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            // column(prEmployee_Transactions__Employee_Code_Caption; UnknownTable52185623.FieldCaption("Employee Code"))
            // {
            // }
            // column(prEmployee_Transactions__Transaction_Code_Caption; UnknownTable52185623.FieldCaption("Transaction Code"))
            // {
            // }
            // column(prEmployee_Transactions__Transaction_Name_Caption; UnknownTable52185623.FieldCaption("Transaction Name"))
            // {
            // }
            // column(prEmployee_Transactions_AmountCaption; UnknownTable52185623.FieldCaption(Amount))
            // {
            // }
            column(prEmployee_Transactions_Period_Month; "Period Month")
            {
            }
            column(prEmployee_Transactions_Period_Year; "Period Year")
            {
            }
            column(prEmployee_Transactions_Payroll_Period; "Payroll Period")
            {
            }
            column(prEmployee_Transactions_Reference_No; "Reference No")
            {
            }

            trigger OnAfterGetRecord()
            begin
                "PR Employee Transactions".Delete;
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
        prEmployee_TransactionsCaptionLbl: label 'prEmployee Transactions';
        CurrReport_PAGENOCaptionLbl: label 'Page';
}
