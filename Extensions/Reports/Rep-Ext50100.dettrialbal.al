// namespace MNS.MNS;

// using Microsoft.Finance.GeneralLedger.Reports;

// reportextension 50100 "det trial bal" extends "Detail Trial Balance"
// {
//     dataset
//     {
//         add("G/L Account")
//         {
//             column(TaxGroupCode; "Tax Group Code")
//             {
//             }
//         }
//     }
//     requestpage
//     {
//         trigger OnOpenPage()
//         begin
//             Report.run(report::"Custom Detail Trial Bal.");
//             CurrReport.Quit();
//         end;
//     }
//     trigger OnPreReport()
//     begin

//     end;

//     var
//         CustomDetTrialBal: Report "Custom Detail Trial Bal.";


// }
