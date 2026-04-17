// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185881 "Update Dividend Payslip Loans"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Update Dividend Payslip Loans.rdl';

//     dataset
//     {
//         dataitem(Loans; Loans)
//         {
//             //DataItemTableView = where("Loan Product Type" = const(136), "Outstanding Balance" = filter(> 0));
//             column(ReportForNavId_1; 1)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 Loans.CalcFields("Outstanding Balance");
//                 if DividendPayslipLoans.Get(Loans."Loan No.") then begin
//                     DividendPayslipLoans.Balance := Loans."Outstanding Balance";
//                     DividendPayslipLoans.Modify;
//                 end else begin
//                     DividendPayslipLoans.Init;
//                     DividendPayslipLoans."Loan No" := Loans."Loan No.";
//                     DividendPayslipLoans.Balance := Loans."Outstanding Balance";
//                     DividendPayslipLoans.Name := Loans."Member Name";
//                     DividendPayslipLoans.Insert;
//                 end;
//             end;

//             trigger OnPostDataItem()
//             begin
//                 Message('Update Complete!');
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

//     trigger OnPreReport()
//     begin
//         DividendPayslipLoans.Reset;
//         if DividendPayslipLoans.FindFirst then begin
//             if FinishedLoans.Get(DividendPayslipLoans."Loan No") then begin
//                 FinishedLoans.CalcFields("Outstanding Balance");
//                 if FinishedLoans."Outstanding Balance" <= 0 then begin
//                     DividendPayslipLoans.Delete;
//                 end;
//             end;
//         end;
//     end;

//     var
//         DividendPayslipLoans: Record "Dividend Payslip Loans";
//         FinishedLoans: Record Loans;
// }
