// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185570 "Transactions Summary"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Transactions Summary.rdl';

//     dataset
//     {
//         dataitem("PR Transaction Codes"; "PR Transaction Codes")
//         {
//             //DataItemTableView = sorting(Field215, Field216);
//             RequestFilterFields = "Current Month Filter", "Transaction Type";
//             column(ReportForNavId_6955; 6955)
//             {
//             }
//             column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
//             {
//             }
//             column(COMPANYNAME; COMPANYNAME)
//             {
//             }
//             column(CurrReport_PAGENO; CurrReport.PageNo)
//             {
//             }
//             column(USERID; UserId)
//             {
//             }
//             column(CompanyInfo_Picture; CompanyInfo.Picture)
//             {
//             }
//             column(GETFILTERS; "PR Transaction Codes".GetFilters)
//             {
//             }
//             column(prTransaction_Codes__Transaction_Name_; "Transaction Name")
//             {
//             }
//             column(prTransaction_Codes__Transaction_Code_; "Transaction Code")
//             {
//             }
//             column(prTransaction_Codes__Curr__Amount_; "Curr. Amount")
//             {
//             }
//             column(prTransaction_Codes__Curr__Amount__Control1102755010; "Curr. Amount")
//             {
//             }
//             column(Transactions_SummaryCaption; Transactions_SummaryCaptionLbl)
//             {
//             }
//             column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
//             {
//             }
//             column(CodeCaption; CodeCaptionLbl)
//             {
//             }
//             column(DescriptionCaption; DescriptionCaptionLbl)
//             {
//             }
//             column(AmountCaption; AmountCaptionLbl)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin

//                 //IF "PR Transaction Codes"."Non-Transactional" = TRUE THEN BEGIN
//                 if ("PR Transaction Codes"."Transaction Code" <> 'BPAY') and
//                    ("PR Transaction Codes"."Transaction Code" <> 'PAYE') and
//                    ("PR Transaction Codes"."Transaction Code" <> 'NHF') then
//                     CurrReport.Skip;

//                 //;
//             end;

//             trigger OnPreDataItem()
//             begin
//                 if "PR Transaction Codes".GetFilter("Current Month Filter") = '' then
//                     Error('You must specify Current Period Filter.');

//                 Evaluate(SelectedPeriod, "PR Transaction Codes".GetFilter("Current Month Filter"));

//                 //SETFILTER("Previous Month Filter",FORMAT(CALCDATE('-1M',SelectedPeriod)));
//                 //CurrReport.CREATETOTALS(DebitAmount,CreditAmount);
//                 if CompanyInfo.Get() then
//                     CompanyInfo.CalcFields(CompanyInfo.Picture);
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     var
//         TotalFor: label 'Total for ';
//         SelectedPeriod: Date;
//         DebitAmount: Decimal;
//         CreditAmount: Decimal;
//         RDebitAmount: Decimal;
//         RCreditAmount: Decimal;
//         CompanyInfo: Record "Company Information";
//         Transactions_SummaryCaptionLbl: label 'Transactions Summary';
//         CurrReport_PAGENOCaptionLbl: label 'Page';
//         CodeCaptionLbl: label 'Code';
//         DescriptionCaptionLbl: label 'Description';
//         AmountCaptionLbl: label 'Amount';
// }
