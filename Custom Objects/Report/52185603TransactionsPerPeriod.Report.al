// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185603 "Transactions Per Period"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Transactions Per Period.rdl';

//     dataset
//     {
//         dataitem("Company Information"; "Company Information")
//         {
//             column(ReportForNavId_1000000007; 1000000007)
//             {
//             }
//             column(Name_CompanyInformation; "Company Information".Name)
//             {
//             }
//             column(Name2_CompanyInformation; "Company Information"."Name 2")
//             {
//             }
//             column(Address_CompanyInformation; "Company Information".Address)
//             {
//             }
//             column(Address2_CompanyInformation; "Company Information"."Address 2")
//             {
//             }
//             column(Picture_CompanyInformation; "Company Information".Picture)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 "Company Information".CalcFields("Company Information".Picture);
//             end;
//         }
//         dataitem("PR Payroll Periods";"PR Payroll Periods")
//         {
//             RequestFilterFields = "Date Opened";
//             column(ReportForNavId_1000000021; 1000000021)
//             {
//             }
//             column(DateOpened_prPayrollPeriods; "PR Payroll Periods"."Date Opened")
//             {
//             }
//             dataitem("PR Period Transactions";"PR Period Transactions")
//             {
//                 DataItemLink = "Payroll Period" = field("Date Opened");
//                 RequestFilterFields = "Transaction Code", "Employee Code";
//                 column(ReportForNavId_1000000001; 1000000001)
//                 {
//                 }
//                 column(EmpAmount_prPeriodTransactions; "PR Period Transactions"."Emp Amount")
//                 {
//                 }
//                 column(EmployeeCode_prPeriodTransactions; "PR Period Transactions"."Employee Code")
//                 {
//                 }
//                 column(Amount_prPeriodTransactions; "PR Period Transactions".Amount)
//                 {
//                 }
//                 column(HrEmpName; HrEmpName)
//                 {
//                 }
//                 column(TransactionCode_prPeriodTransactions; "PR Period Transactions"."Transaction Code")
//                 {
//                 }
//                 column(TransactionName_prPeriodTransactions; "PR Period Transactions"."Transaction Name")
//                 {
//                 }
//                 column(PensionHouse; PensionHouse)
//                 {
//                 }
//                 column(PinNo; PinNo)
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     if HrEmp.Get("Employee Code") then begin
//                         HrEmpName := HrEmp."First Name" + ' ' + HrEmp."Middle Name" + ' ' + HrEmp."Last Name";
//                         if ExcludeEmpWithoutPIN = true then
//                             if HrEmp."PIN No." = '' then
//                                 CurrReport.Skip;
//                         if PensionHouseFilter <> '' then
//                             if HrEmp."Pension House" <> PensionHouseFilter then
//                                 CurrReport.Skip;

//                         PinNo := HrEmp."PIN No.";
//                         PensionHouse := HrEmp."Pension House";
//                     end
//                 end;
//             }
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//                 field(ExcludeEmpWithoutPIN; ExcludeEmpWithoutPIN)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Exclude Emp. Without PIN';
//                 }
//                 field(PensionHouseFilter; PensionHouseFilter)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Pension House Filter';
//                     TableRelation = "prInstitutional Membership"."Institution No";
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
//         ExcludeEmpWithoutPIN: Boolean;
//         HrEmp: Record "HR Employees";
//         HrEmpName: Text;
//         PayrollPeriod: Date;
//         PensionHouse: Text;
//         PinNo: Code[50];
//         PensionHouseFilter: Code[20];
// }
