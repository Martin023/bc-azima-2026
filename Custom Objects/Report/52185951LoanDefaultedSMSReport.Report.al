// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185951 "Loan Defaulted SMS Report"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-kenpipe-2024/Layout/Loan Defaulted SMS Report.rdl';

//     dataset
//     {
//         //dataitem(SMSMessages; UnknownTable52185764)
//         dataitem(SMSMessages; "M-SACCO SMS Messages")
//         {
//             DataItemTableView = where(Source = const("Loan defaulted"), "Account No" = filter(<> ''));
//             RequestFilterFields = "Date Entered", "Account No", "Document No", "Entered By";
//             column(ReportForNavId_1; 1)
//             {
//             }
//             column(Date_Entered; SMSMessages."Date Entered")
//             {
//             }
//             column(Tel_No; SMSMessages."Telephone No")
//             {
//             }
//             column(Message; SMSMessages."SMS Message")
//             {
//             }
//             column(Account_N0; SMSMessages."Account No")
//             {
//             }
//             column(Loan_No; SMSMessages."Document No")
//             {
//             }
//             column(EmployerCode; EmployerCode)
//             {
//             }
//             column(EmployerName; EmployerName)
//             {
//             }
//             column(Company_Name; Company.Name)
//             {
//             }
//             column(Company_Picture; Company.Picture)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 EmployerCode := '';
//                 EmployerName := '';
//                 Loans.Get(SMSMessages."Document No");
//                 Members.Get(Loans."Member No.");
//                 EmployerCode := Members."Employer Code";
//                 EmployerName := Members."Employer Name";
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
//         EmployerCode: Code[10];
//         EmployerName: Text;
//         Company: Record "Company Information";
//         Loans: Record Loans;
//         Members: Record "Members";
// }
