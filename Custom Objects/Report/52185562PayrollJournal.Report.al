#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185562 "Payroll Journal"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Payroll Journal.rdl';

    dataset
    {
        dataitem("PR Transaction Codes"; "PR Transaction Codes")
        {
            //DataItemTableView = sorting(Field215, Field216);
            RequestFilterFields = "Current Month Filter", "Taxable Percentage", "No. Series", "IsTraining Deduction";
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
            column(CreditAmount; CreditAmount)
            {
            }
            column(DebitAmount; DebitAmount)
            {
            }
            column(prTransaction_Codes__Transaction_Name_; "Transaction Name")
            {
            }
            column(prTransaction_Codes__Transaction_Code_; "Transaction Code")
            {
            }
            column(DebitAmount_RDebitAmount; DebitAmount + RDebitAmount)
            {
            }
            column(CreditAmount_RCreditAmount; CreditAmount + RCreditAmount)
            {
            }
            column(RDebitAmount; RDebitAmount)
            {
            }
            column(RCreditAmount; RCreditAmount)
            {
            }
            column(Payroll_JournalCaption; Payroll_JournalCaptionLbl)
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
            column(DebitCaption; DebitCaptionLbl)
            {
            }
            column(CreditCaption; CreditCaptionLbl)
            {
            }
            column(Rounding_AdjustmentCaption; Rounding_AdjustmentCaptionLbl)
            {
            }
            column(Prepared_by_Caption; Prepared_by_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755042; EmptyStringCaption_Control1102755042Lbl)
            {
            }
            column(Authorised_by_Caption; Authorised_by_CaptionLbl)
            {
            }
            column(NameCaption_Control1102755044; NameCaption_Control1102755044Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755045; EmptyStringCaption_Control1102755045Lbl)
            {
            }
            column(Approved_by_Caption; Approved_by_CaptionLbl)
            {
            }
            column(NameCaption_Control1102755047; NameCaption_Control1102755047Lbl)
            {
            }
            column(Signature___DateCaption; Signature___DateCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755049; EmptyStringCaption_Control1102755049Lbl)
            {
            }
            column(Signature___DateCaption_Control1102755050; Signature___DateCaption_Control1102755050Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755051; EmptyStringCaption_Control1102755051Lbl)
            {
            }
            column(Signature___DateCaption_Control1102755052; Signature___DateCaption_Control1102755052Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755053; EmptyStringCaption_Control1102755053Lbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "PR Transaction Codes".CalcFields("PR Transaction Codes"."Curr. Amount");

                //IF "PR Transaction Codes"."Non-Transactional" = TRUE THEN BEGIN
                if ("PR Transaction Codes"."Transaction Code" <> 'BPAY') and
                   ("PR Transaction Codes"."Transaction Code" <> 'PAYE') and
                   ("PR Transaction Codes"."Transaction Code" <> 'NPAY') and
                   ("PR Transaction Codes"."Transaction Code" <> 'NHF') then
                    CurrReport.Skip;

                //END;

                if "PR Transaction Codes"."Transaction Type" = "PR Transaction Codes"."transaction type"::Income then
                    DebitAmount := "PR Transaction Codes"."Curr. Amount"
                else
                    CreditAmount := "PR Transaction Codes"."Curr. Amount";

                if ("PR Transaction Codes"."Transaction Code" = 'NPAY') then begin
                    DebitAmount := 0;
                    CreditAmount := "PR Transaction Codes"."Curr. Amount";
                end;
            end;

            trigger OnPreDataItem()
            begin
                if "PR Transaction Codes".GetFilter("Current Month Filter") = '' then
                    Error('You must specify Current Period Filter.');

                Evaluate(SelectedPeriod, "PR Transaction Codes".GetFilter("Current Month Filter"));

                CurrReport.CreateTotals(DebitAmount, CreditAmount);

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
        CompanyInfo: Record "Company Information";
        Payroll_JournalCaptionLbl: label 'Payroll Journal';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        CodeCaptionLbl: label 'Code';
        DescriptionCaptionLbl: label 'Description';
        DebitCaptionLbl: label 'Debit';
        CreditCaptionLbl: label 'Credit';
        Rounding_AdjustmentCaptionLbl: label 'Rounding Adjustment';
        Prepared_by_CaptionLbl: label 'Prepared by:';
        NameCaptionLbl: label 'Name';
        EmptyStringCaptionLbl: label '......................................................................................................................................................';
        EmptyStringCaption_Control1102755042Lbl: label '......................................................................................................................................................';
        Authorised_by_CaptionLbl: label 'Authorised by:';
        NameCaption_Control1102755044Lbl: label 'Name';
        EmptyStringCaption_Control1102755045Lbl: label '......................................................................................................................................................';
        Approved_by_CaptionLbl: label 'Approved by:';
        NameCaption_Control1102755047Lbl: label 'Name';
        Signature___DateCaptionLbl: label 'Signature & Date';
        EmptyStringCaption_Control1102755049Lbl: label '......................................................................................................................................................';
        Signature___DateCaption_Control1102755050Lbl: label 'Signature & Date';
        EmptyStringCaption_Control1102755051Lbl: label '......................................................................................................................................................';
        Signature___DateCaption_Control1102755052Lbl: label 'Signature & Date';
        EmptyStringCaption_Control1102755053Lbl: label '......................................................................................................................................................';
}
