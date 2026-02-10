#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185571 "Transactions - Detailed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Transactions - Detailed.rdl';

    dataset
    {
        dataitem("PR Period Transactions"; "PR Period Transactions")
        {
            DataItemTableView = sorting("Transaction Code", "Employee Code", "Payroll Period");
            RequestFilterFields = "Payroll Period", "Transaction Code";
            column(ReportForNavId_7769; 7769)
            {
            }
            column(GETFILTERS; "PR Period Transactions".GetFilters)
            {
            }
            column(USERID; UserId)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(prPeriod_Transactions__Transaction_Code_; "Transaction Code")
            {
            }
            column(prPeriod_Transactions__Transaction_Name_; "Transaction Name")
            {
            }
            column(prPeriod_Transactions__Employee_Code_; "Employee Code")
            {
            }
            //column(prPeriod_Transactions_Membership; Membership)
            //{
            //}
            column(prPeriod_Transactions_Amount; Amount)
            {
            }
            column(prPeriod_Transactions_Balance; Balance)
            {
            }
            column(EmpName; EmpName)
            {
            }
            column(prPeriod_Transactions_Amount_Control1102755029; Amount)
            {
            }
            column(prPeriod_Transactions_Balance_Control1102755030; Balance)
            {
            }
            column(RCount; RCount)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Transactions___DetailedCaption; Transactions___DetailedCaptionLbl)
            {
            }
            column(prPeriod_Transactions__Transaction_Code_Caption; "PR Period Transactions".FieldCaption("Transaction Code"))
            {
            }
            column(prPeriod_Transactions__Transaction_Name_Caption; "PR Period Transactions".FieldCaption("Transaction Name"))
            {
            }
            column(prPeriod_Transactions_BalanceCaption; "PR Period Transactions".FieldCaption(Balance))
            {
            }
            column(prPeriod_Transactions_AmountCaption; "PR Period Transactions".FieldCaption(Amount))
            {
            }
            column(Membership_No_Caption; Membership_No_CaptionLbl)
            {
            }
            column(prPeriod_Transactions__Employee_Code_Caption; "PR Period Transactions".FieldCaption("Employee Code"))
            {
            }
            column(NamesCaption; NamesCaptionLbl)
            {
            }
            column(prPeriod_Transactions_Period_Month; "Period Month")
            {
            }
            column(prPeriod_Transactions_Period_Year; "Period Year")
            {
            }
            column(prPeriod_Transactions_Reference_No; "Reference No")
            {
            }
            column(Department_prPeriodTransactions; "PR Period Transactions".Department)
            {
            }
            column(CostCentre_prPeriodTransactions; "PR Period Transactions"."Cost Centre")
            {
            }
            column(Dimension1Name; Dimension1Name)
            {
            }
            column(Dimension2Name; Dimension2Name)
            {
            }
            column(EmpAmount_prPeriodTransactions; "PR Period Transactions"."Emp Amount")
            {
            }

            trigger OnAfterGetRecord()
            begin
                EmpName := '';
                if Employee.Get("Employee Code") then begin
                    EmpName := Employee."Last Name" + ' ' + Employee."First Name" + ' ' + Employee."Middle Name";
                end;

                RCount := RCount + 1;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := "PR Period Transactions".FieldNo("Transaction Code");

                RCount := 1;

                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(CompanyInfo.Picture);

                GenLedgerSetup.Get;
                Dimension1Name := GenLedgerSetup."Global Dimension 1 Code";
                Dimension2Name := GenLedgerSetup."Global Dimension 2 Code";
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
        Employee: Record "HR Employees";
        EmpName: Text[200];
        RCount: Integer;
        CompanyInfo: Record "Company Information";
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Transactions___DetailedCaptionLbl: label 'Transactions - Detailed';
        Membership_No_CaptionLbl: label 'Membership No.';
        NamesCaptionLbl: label 'Names';
        Dimension1Name: Text;
        Dimension2Name: Text;
        GenLedgerSetup: Record "General Ledger Setup";
}
