// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185867 "Activate Savings Accounts"
// {
//     // DefaultLayout = RDLC;
//     // RDLCLayout = './bc-azima-2026/Layout/Activate Savings Accounts.rdl';


//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem("Savings Accounts"; "Savings Accounts")
//         {
//             //DataItemTableView = where Status = filter(<> Deceased));
//             RequestFilterFields = "Member No.";
//             column(ReportForNavId_1; 1)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 // SavingsLedgerEntry.Reset;
//                 // // SavingsLedgerEntry.SetRange("Customer No.", "Savings Accounts"."No.");
//                 // // SavingsLedgerEntry.SetFilter(Amount, '<%1', 0);
//                 // if SavingsLedgerEntry.FindLast then
//                 //     PostingDate := SavingsLedgerEntry."Posting Date";

//                 // Members.Get("Savings Accounts"."Member No.");
//                 // if (PostingDate >= CalcDate('-30D', Today)) and (Members.Status = Members.Status::Dormant) then begin
//                 Members.Status := Members.Status::Active;
//                 Members.Modify;
//                 // end;
//             end;

//             trigger OnPostDataItem()
//             begin
//                 Message('Members Modified Successfully');
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
//         CompanyInformation.Get;
//         CompanyInformation.CalcFields(Picture);
//     end;

//     var
//         SavingsLedgerEntry: Record "Savings Ledger Entry";
//         PostingDate: Date;
//         CompanyInformation: Record "Company Information";
//         SavingsAccounts: Record "Savings Accounts";
//         Members: Record Members;
// }
