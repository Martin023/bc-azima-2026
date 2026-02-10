#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185580 "Up-Process Variations"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Up-Process Variations.rdl';

    dataset
    {
        dataitem("prPayroll Variations"; "prPayroll Variations")
        {
            DataItemTableView = sorting("Transaction Type", "Employee Code", "Transaction Code", "Reference No", "Period Month", "Period Year", "Payroll Period");
            column(ReportForNavId_5357; 5357)
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
            column(prPayroll_Variations__Employee_Code_; "Employee Code")
            {
            }
            column(prPayroll_Variations__Transaction_Code_; "Transaction Code")
            {
            }
            column(prPayroll_Variations__Transaction_Name_; "Transaction Name")
            {
            }
            column(prPayroll_Variations_Amount; Amount)
            {
            }
            column(prPayroll_Variations_Balance; Balance)
            {
            }
            column(prPayroll_VariationsCaption; prPayroll_VariationsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            // column(prPayroll_Variations__Employee_Code_Caption;UnknownTable52185658.FieldCaption("Employee Code"))
            // {
            // }
            // column(prPayroll_Variations__Transaction_Code_Caption;UnknownTable52185658.FieldCaption("Transaction Code"))
            // {
            // }
            // column(prPayroll_Variations__Transaction_Name_Caption;UnknownTable52185658.FieldCaption("Transaction Name"))
            // {
            // }
            // column(prPayroll_Variations_AmountCaption;UnknownTable52185658.FieldCaption(Amount))
            // {
            // }
            // column(prPayroll_Variations_BalanceCaption;UnknownTable52185658.FieldCaption(Balance))
            // {
            // }
            column(prPayroll_Variations_Transaction_Type; "Transaction Type")
            {
            }
            column(prPayroll_Variations_Reference_No; "Reference No")
            {
            }
            column(prPayroll_Variations_Period_Month; "Period Month")
            {
            }
            column(prPayroll_Variations_Period_Year; "Period Year")
            {
            }
            column(prPayroll_Variations_Payroll_Period; "Payroll Period")
            {
            }

            trigger OnAfterGetRecord()
            begin
                "prPayroll Variations".Processed := false;
                "prPayroll Variations".Modify;
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
        prPayroll_VariationsCaptionLbl: label 'prPayroll Variations';
        CurrReport_PAGENOCaptionLbl: label 'Page';
}
