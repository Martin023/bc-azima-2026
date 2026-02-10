// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185970 "Salary Thru FOSA Update"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Salary Thru FOSA Update.rdl';

//     dataset
//     {
//         dataitem(SalaryThruFOSAUpdate; UnknownTable52186055)
//         {
//             RequestFilterFields = "Account No.";
//             column(ReportForNavId_1; 1)
//             {
//             }
//             column(Account_No; SalaryThruFOSAUpdate."Account No.")
//             {
//             }
//             column(Date_Umarked; SalaryThruFOSAUpdate."Date Unmarked")
//             {
//             }
//             column(Company_Name; Company.Name)
//             {
//             }
//             column(Company_Picture; Company.Picture)
//             {
//             }
//             column(Last_SalaryDate; SalaryThruFOSAUpdate."Last Salary Date")
//             {
//             }
//             dataitem(SavingsAccounts; "Savings Accounts")
//             {
//                 DataItemLink = "No." = field("Account No.");
//                 column(ReportForNavId_4; 4)
//                 {
//                 }
//                 column(Member_Name; SavingsAccounts.Name)
//                 {
//                 }
//                 column(Member_No; SavingsAccounts."Member No.")
//                 {
//                 }
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 SavingsAccounts.Reset;
//                 SavingsAccounts.SetRange("No.", SalaryThruFOSAUpdate."Account No.");
//                 SavingsAccounts.SetRange("Salary Through FOSA", true);
//                 if SavingsAccounts.Find('-') then CurrReport.Skip;
//             end;

//             trigger OnPreDataItem()
//             begin
//                 Company.Get;
//                 Company.CalcFields(Picture);
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
//         Company: Record "Company Information";
// }
