
// Report 52185960 "Modify Credit Ledger"
// {
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem(CreditLedgerEntry; CreditLedgerEntry)
//         {
//             //DataItemTableView = where("Transaction Type" = const(Loan), Amount = filter(< 0));
//             column(ReportForNavId_1; 1)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 // CreditLedgerEntry."Transaction Type" := CreditLedgerEntry."transaction type"::Repayment;
//                 // CreditLedgerEntry.Modify;
//             end;

//             trigger OnPostDataItem()
//             begin
//                 Message('Done!!!');
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
// }
