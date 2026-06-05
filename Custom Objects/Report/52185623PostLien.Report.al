// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185623 "Post Lien"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Post Lien.rdl';

//     dataset
//     {
//         dataitem(Loans; Loans)
//         {
//             column(ReportForNavId_1; 1)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 //LoansProcess.PostLien(PeriodFilter, Loans);
//             end;

//             trigger OnPreDataItem()
//             begin
//                 if PeriodFilter = 0D then begin
//                     //#IF NOT CONFIRM (PeriodFilterError) = TRUE THEN EXIT;
//                     PeriodFilter := Today;
//                 end;
//             end;
//         }
//     }

//     requestpage
//     {
//         SaveValues = true;

//         layout
//         {
//             area(content)
//             {
//                 field("Period Filter"; PeriodFilter)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     var
//         PeriodFilter: Date;
//         LoansProcess: Codeunit "Loans Process";
//         PeriodFilterError: label 'are you sure you want to continue without specifying period filter.';
//         Process: Boolean;
// }
