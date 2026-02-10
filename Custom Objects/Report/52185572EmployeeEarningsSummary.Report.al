#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185572 "Employee Earnings Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Employee Earnings Summary.rdl';

    dataset
    {
        dataitem("PR Transaction Codes"; "PR Transaction Codes")
        {
            //DataItemTableView = sorting(Field215, Field216) where("Transaction Type" = const(Income));
            RequestFilterFields = "Employee Code Filter", "Current Month Filter";
            column(ReportForNavId_6955; 6955)
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
            column(GETFILTERS; "PR Transaction Codes".GetFilters)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(prTransaction_Codes__GETFILTER__Employee_Code_Filter__; "PR Transaction Codes".GetFilter("Employee Code Filter"))
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(prTransaction_Codes__Transaction_Name_; "Transaction Name")
            {
            }
            column(prTransaction_Codes__Transaction_Code_; "Transaction Code")
            {
            }
            column(prTransaction_Codes__Curr__Amount_; "Curr. Amount")
            {
            }
            column(prTransaction_Codes__Curr__Amount__Control1102755010; "Curr. Amount")
            {
            }
            column(Employee_Earnings_SummaryCaption; Employee_Earnings_SummaryCaptionLbl)
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

            trigger OnAfterGetRecord()
            begin

                //IF "PR Transaction Codes"."Non-Transactional" = TRUE THEN BEGIN
                if ("PR Transaction Codes"."Transaction Code" <> 'BPAY') and
                   ("PR Transaction Codes"."Transaction Code" <> 'PAYE') and
                   ("PR Transaction Codes"."Transaction Code" <> 'NHF') then
                    CurrReport.Skip;

                //END;
            end;

            trigger OnPreDataItem()
            begin
                if "PR Transaction Codes".GetFilter("PR Transaction Codes"."Employee Code Filter") = '' then
                    Error('You must specify Employee Code Filter.');

                EmployeeName := '';
                if HREmployee.Get("PR Transaction Codes".GetFilter("PR Transaction Codes"."Employee Code Filter")) then
                    EmployeeName := HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";
                //SETFILTER("Previous Month Filter",FORMAT(CALCDATE('-1M',SelectedPeriod)));
                //CurrReport.CREATETOTALS(DebitAmount,CreditAmount);

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
        TotalFor: label 'Total for ';
        SelectedPeriod: Date;
        DebitAmount: Decimal;
        CreditAmount: Decimal;
        RDebitAmount: Decimal;
        RCreditAmount: Decimal;
        HREmployee: Record "HR Employees";
        EmployeeName: Text[300];
        CompanyInfo: Record "Company Information";
        Employee_Earnings_SummaryCaptionLbl: label 'Employee Earnings Summary';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        CodeCaptionLbl: label 'Code';
        DescriptionCaptionLbl: label 'Description';
        AmountCaptionLbl: label 'Amount';
}
