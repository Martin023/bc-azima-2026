// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185559 "Validate Transactions Codes"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-kenpipe-2024/Layout/Validate Transactions Codes.rdl';

//     dataset
//     {
//         dataitem("PR Transaction Codes"; "PR Transaction Codes")
//         {
//             column(ReportForNavId_6955; 6955)
//             {
//             }
//             column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
//             {
//             }
//             column(COMPANYNAME; COMPANYNAME)
//             {
//             }
//             //column(CurrReport_PAGENO; CurrReport.PageNo)
//             //{
//             //}
//             column(USERID; UserId)
//             {
//             }
//             column(prTransaction_Codes__Transaction_Code_; "Transaction Code")
//             {
//             }
//             column(prTransaction_Codes__Transaction_Name_; "Transaction Name")
//             {
//             }
//             column(prTransaction_Codes__Transaction_Type_; "Transaction Type")
//             {
//             }
//             column(TransactionsCaption; TransactionsCaptionLbl)
//             {
//             }
//             column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
//             {
//             }
//             column(prTransaction_Codes__Transaction_Code_Caption; "PR Transaction Codes".FieldCaption("Transaction Code"))
//             {
//             }
//             column(prTransaction_Codes__Transaction_Name_Caption; "PR Transaction Codes".FieldCaption("Transaction Name"))
//             {
//             }
//             column(prTransaction_Codes__Transaction_Type_Caption; "PR Transaction Codes".FieldCaption("Transaction Type"))
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 // IF "PR Transaction Codes"."Transaction Type" = "PR Transaction Codes"."Transaction Type"::Income THEN
//                 // "PR Transaction Codes"."Group Order":=3
//                 // ELSE
//                 // "PR Transaction Codes"."Group Order":=8;
//                 // "PR Transaction Codes".MODIFY;
//             end;

//             trigger OnPostDataItem()
//             begin
//                 if Trans.Get('BPAY') = false then begin
//                     Trans.Init;
//                     Trans."Transaction Code" := 'BPAY';
//                     Trans."Transaction Name" := 'Basic Pay';
//                     Trans."Transaction Type" := Trans."transaction type"::Income;
//                     //Trans."Non-Transactional":=TRUE;
//                     //Trans."Group Order":=1;
//                     Trans.Insert;
//                 end;

//                 if Trans.Get('GPAY') = false then begin
//                     Trans.Init;
//                     Trans."Transaction Code" := 'GPAY';
//                     Trans."Transaction Name" := 'Gross Pay';
//                     Trans."Transaction Type" := Trans."transaction type"::Income;
//                     //Trans."Non-Transactional":=TRUE;
//                     //Trans."Group Order":=4;
//                     Trans.Insert;
//                 end;

//                 if Trans.Get('NONTAX') = false then begin
//                     Trans.Init;
//                     Trans."Transaction Code" := 'NONTAX';
//                     Trans."Transaction Name" := 'Non-Taxable Pay';
//                     Trans."Transaction Type" := Trans."transaction type"::Income;
//                     //Trans."Non-Transactional":=TRUE;
//                     //Trans."Group Order":=6;
//                     //Trans."Sub Group Order":=5;
//                     Trans.Insert;
//                 end;

//                 if Trans.Get('NPAY') = false then begin
//                     Trans.Init;
//                     Trans."Transaction Code" := 'NPAY';
//                     Trans."Transaction Name" := 'Net Pay';
//                     Trans."Transaction Type" := Trans."transaction type"::Income;
//                     //Trans."Non-Transactional":=TRUE;
//                     //Trans."Group Order":=9;
//                     Trans.Insert;
//                 end;

//                 if Trans.Get('PAYE') = false then begin
//                     Trans.Init;
//                     Trans."Transaction Code" := 'PAYE';
//                     Trans."Transaction Name" := 'PAYE';
//                     Trans."Transaction Type" := Trans."transaction type"::Deduction;
//                     //Trans."Non-Transactional":=TRUE;
//                     //Trans."Group Order":=7;
//                     //Trans."Sub Group Order":=3;
//                     Trans.Insert;
//                 end;

//                 if Trans.Get('NHF') = false then begin
//                     Trans.Init;
//                     Trans."Transaction Code" := 'NHF';
//                     Trans."Transaction Name" := 'N.H.F';
//                     Trans."Transaction Type" := Trans."transaction type"::Deduction;
//                     //Trans."Non-Transactional":=TRUE;
//                     //Trans."Group Order":=7;
//                     //Trans."Sub Group Order":=4;
//                     Trans.Insert;
//                 end;


//                 if Trans.Get('TOT-DED') = false then begin
//                     Trans.Init;
//                     Trans."Transaction Code" := 'TOT-DED';
//                     Trans."Transaction Name" := 'Total Deductions';
//                     Trans."Transaction Type" := Trans."transaction type"::Deduction;
//                     //Trans."Non-Transactional":=TRUE;
//                     //Trans."Group Order":=8;
//                     //Trans."Sub Group Order":=9;
//                     Trans.Insert;
//                 end;


//                 if Trans.Get('TXCHRG') = false then begin
//                     Trans.Init;
//                     Trans."Transaction Code" := 'TXCHRG';
//                     Trans."Transaction Name" := 'Tax Charged';
//                     Trans."Transaction Type" := Trans."transaction type"::Deduction;
//                     //Trans."Non-Transactional":=TRUE;
//                     //Trans."Group Order":=6;
//                     //Trans."Sub Group Order":=7;
//                     Trans.Insert;
//                 end;

//                 if Trans.Get('TXBP') = false then begin
//                     Trans.Init;
//                     Trans."Transaction Code" := 'TXBP';
//                     Trans."Transaction Name" := 'Taxable Pay';
//                     Trans."Transaction Type" := Trans."transaction type"::Deduction;
//                     //Trans."Non-Transactional":=TRUE;
//                     //Trans."Group Order":=6;
//                     //Trans."Sub Group Order":=6;
//                     Trans.Insert;
//                 end;
//             end;

//             trigger OnPreDataItem()
//             begin
//                 Trans.Reset;
//                 //Trans.SETRANGE(non,TRUE);
//                 if Trans.Find('-') then
//                     Trans.DeleteAll;
//             end;
//         }
//     }

//     requestpage
//     {
//         SaveValues = true;

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
//         HREmployee: Record "HR Employees";
//         Trans: Record "PR Transaction Codes";
//         TransactionsCaptionLbl: label 'Transactions';
//         CurrReport_PAGENOCaptionLbl: label 'Page';
// }
