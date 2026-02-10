#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185563 "Payroll - Global"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Payroll - Global.rdl';

    dataset
    {
        dataitem("PR Period Transactions"; "PR Period Transactions")
        {
            DataItemTableView = sorting("Group Order", "Transaction Code", "Period Month", "Period Year", "Reference No", "Department Code");
            RequestFilterFields = "Payroll Period", "Location/Division", Department, "Cost Centre", "Salary Grade", "Salary Notch";
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
            column(GETFILTERS; "PR Period Transactions".GetFilters)
            {
            }
            column(prPeriod_Transactions_Amount; Amount)
            {
            }
            column(prPeriod_Transactions__Transaction_Name_; "Transaction Name")
            {
            }
            column(prPeriod_Transactions__Transaction_Code_; "Transaction Code")
            {
            }
            column(Reconciliation___SummaryCaption; Reconciliation___SummaryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(CodeCaption; CodeCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(prPeriod_Transactions_Employee_Code; "Employee Code")
            {
            }
            column(prPeriod_Transactions_Period_Month; "Period Month")
            {
            }
            column(prPeriod_Transactions_Period_Year; "Period Year")
            {
            }
            //column(prPeriod_Transactions_Membership; Membership)

            column(prPeriod_Transactions_Reference_No; "Reference No")
            {
            }
            column(prPeriod_Transactions_Group_Order; "Group Order")
            {
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := "PR Period Transactions".FieldNo("Transaction Code");
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
        Reconciliation___SummaryCaptionLbl: label 'Reconciliation - Summary';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        CodeCaptionLbl: label 'Code';
        DescriptionCaptionLbl: label 'Description';
        AmountCaptionLbl: label 'Amount';
}
