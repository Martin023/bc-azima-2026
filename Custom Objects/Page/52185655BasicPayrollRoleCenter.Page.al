// page 52185655 "Basic Payroll Role Center"
// {
//     Caption = 'Role Center';
//     PageType = RoleCenter;

//     layout
//     {
//         area(rolecenter)
//         {
//             group(Control1900724808)
//             {
//                 ShowCaption = false;
//                 systempart(Control1901420308; Outlook)
//                 {
//                 }
//             }
//             group(Control1900724708)
//             {
//                 ShowCaption = false;
//                 part(Control17; "My Job Queue")
//                 {
//                     Visible = false;
//                 }
//                 part(Control1907692008; "My Customers")
//                 {
//                 }
//                 part(Control1902476008; "My Vendors")
//                 {
//                 }
//                 //part(Control1903012608; "Connect Online")
//                 //{
//                 //Visible = false;
//                 //}
//                 systempart(Control1901377608; MyNotes)
//                 {
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(embedding)
//         {
//             action("General Journals")
//             {
//                 Caption = 'General Journals';
//                 Image = Journal;
//                 RunObject = Page "General Journal Batches";
//                 RunPageView = WHERE("Template Type" = CONST(General),
//                                     Recurring = CONST(false));
//             }
//             // action(Salary)
//             // {
//             //     Caption = 'Salary';
//             //     RunObject = Page "Salary List";
//             //     Visible = false;
//             // }
//             action("Absence Registration")
//             {
//                 Caption = 'Absence Registration';
//                 RunObject = Page "Absence Registration";
//             }
//             action("Staff Loan Accounts")
//             {
//                 Caption = 'Staff Loan Accounts';
//                 Image = Customer;
//                 RunObject = Page "Customer List";
//                 RunPageView = WHERE("Customer Posting Group" = CONST('STAFF'));
//             }
//             action("Employee Loans")
//             {
//                 RunObject = Page prAssignEmployeeLoans;
//             }
//             action("Payment Journals")
//             {
//                 Caption = 'Payment Journals';
//                 Image = Journals;
//                 RunObject = Page "General Journal Batches";
//                 RunPageView = WHERE("Template Type" = CONST(Payments),
//                                     Recurring = CONST(false));
//             }
//         }
//         area(sections)
//         {
//             group("Human Resources")
//             {
//                 Caption = 'Human Resources';
//                 action(Employees)
//                 {
//                     Caption = 'Employees';
//                     //  RunObject = Page "HR Employee List - Pending App";
//                 }
//             }
//             group("Employee Tasks")
//             {
//                 Caption = 'Employee Tasks';
//                 action("Purchase Invoice")
//                 {
//                     RunObject = Page "Purchase Invoices";
//                 }
//             }
//             group("Approval Entries")
//             {
//                 Caption = 'Approval Entries';
//                 action(Action1102755020)
//                 {
//                     Caption = 'Approval Entries';
//                     RunObject = Page 658;
//                 }
//                 action("Approval Request Entries")
//                 {
//                     Caption = 'Approval Request Entries';
//                     RunObject = Page "Approval Request Entries";
//                 }
//             }
//             group("Payroll Setup")
//             {
//                 Caption = 'Payroll Setup';
//                 action("Rates & Ceilings")
//                 {
//                     Caption = 'Rates & Ceilings';
//                     RunObject = Page "prRates & Ceilings List";
//                 }
//                 action(Dimensions)
//                 {
//                     Caption = 'Dimensions';
//                     RunObject = Page Dimensions;
//                 }
//                 action("PAYE Setup")
//                 {
//                     Caption = 'PAYE Setup';
//                     RunObject = Page "prP.A.Y.E Setup";
//                 }
//                 action("Transactions Setup")
//                 {
//                     Caption = 'Transactions Setup';
//                     RunObject = Page "PR Transaction Codes List";
//                 }
//                 // action("Salary Grades")
//                 // {
//                 //     Caption = 'Salary Grades';
//                 //     RunObject = Page "Salary Grades";
//                 // }
//                 action("Bank Structure")
//                 {
//                     Caption = 'Bank Structure';
//                     RunObject = Page "PR Bank Accounts";
//                 }
//                 action("Membership Groups")
//                 {
//                     Caption = 'Membership Groups';
//                     RunObject = Page "prMembership Groups";
//                 }
//                 action("Payroll Type")
//                 {
//                     Caption = 'Payroll Type';
//                     RunObject = Page "prPayroll Type";
//                 }
//                 action("Posting Groups")
//                 {
//                     Caption = 'Posting Groups';
//                     RunObject = Page "prEmployee Posting Group";
//                 }
//             }
//             group("Posted Documents")
//             {
//                 Caption = 'Posted Documents';
//                 Image = FiledPosted;
//                 action("Posted Purchase Receipts")
//                 {
//                     Caption = 'Posted Purchase Receipts';
//                     RunObject = Page "Posted Purchase Receipts";
//                 }
//                 action("Posted Purchase Invoices")
//                 {
//                     Caption = 'Posted Purchase Invoices';
//                     RunObject = Page "Posted Purchase Invoices";
//                 }
//                 action(Action1102755051)
//                 {
//                     Caption = 'Employee Loans';
//                     RunObject = Page prPostedAssignEmployeeLoans;
//                 }
//             }
//         }
//         area(creation)
//         {
//             action(Employee)
//             {
//                 Caption = 'Employee';
//                 Image = Employee;
//                 //RunObject = Page "HR E-Mail Parameters List";
//             }
//             action(Staff)
//             {
//                 Caption = 'Staff';
//                 Image = Customer;
//                 //Promoted = false;
//                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //PromotedCategory = Process;
//                 RunObject = Page "Customer Card";
//                 RunPageMode = Create;
//             }
//             action("Navi&gate")
//             {
//                 Caption = 'Navi&gate';
//                 Image = Navigate;
//                 RunObject = Page Navigate;
//             }
//         }
//         area(processing)
//         {
//             separator(Tasks)
//             {
//                 Caption = 'Tasks';
//                 IsHeader = true;
//             }
//             action("Journal Transfer")
//             {
//                 Caption = 'Journal Transfer';
//                 Image = TransferToGeneralJournal;
//                 //RunObject = Report "PR Transfer To Journal";
//             }
//             action("Period Management")
//             {
//                 Caption = 'Period Management';
//                 Image = AccountingPeriods;
//                 RunObject = Page "PR Payroll Periods";
//             }
//             action(Action1102755089)
//             {
//                 Caption = 'Rates & Ceilings';
//                 Image = PayrollStatistics;
//                 // RunObject = Page "PR Rates & Ceilings";
//             }
//             action(Action1102755036)
//             {
//                 Caption = 'Posting Groups';
//                 Image = Group;
//                 RunObject = Page "prEmployee Posting Group";
//             }
//             action("Mass Update Transactions")
//             {
//                 Caption = 'Mass Update Transactions';
//                 Image = UpdateDescription;
//                 // RunObject = Report "prPayroll Cheque Details";
//             }
//             action("Allowance Variations")
//             {
//                 Caption = 'Allowance Variations';
//                 Image = Allocations;
//                 RunObject = Page "Allowance Var";
//             }
//             action("Deduction Variations")
//             {
//                 Caption = 'Deduction Variations';
//                 Image = RemoveLine;
//                 RunObject = Page "Deductions Var";
//             }
//             action("Processed Allowance Variations")
//             {
//                 Caption = 'Processed Allowance Variations';
//                 Image = CalculateCost;
//                 RunObject = Page "Processed Allowance Variations";
//             }
//             action("Processed Deduction Variations")
//             {
//                 Caption = 'Processed Deduction Variations';
//                 Image = CalculateLines;
//                 RunObject = Page "Processed Deduction Variations";
//             }
//             action("Generate 13th Month")
//             {
//                 Caption = 'Generate 13th Month';
//                 Image = CalculateCalendar;
//                 // RunObject = Report "Job Interview results";
//             }
//             separator(Reset)
//             {
//                 Caption = 'Reset';
//             }
//             action("Clear Weekend OT")
//             {
//                 Caption = 'Clear Weekend OT';
//                 Image = ClearLog;
//                 // RunObject = Report "Clear Weekend OT";
//             }
//             action("Clear Old Code Variations")
//             {
//                 Caption = 'Clear Old Code Variations';
//                 Image = ClearLog;
//                 // RunObject = Report "Clear Old Code Variations";
//             }
//             action("Up-Process Variations")
//             {
//                 Caption = 'Up-Process Variations';
//                 Image = CalculateRegenerativePlan;
//                 // RunObject = Report "Up-Process Variations";
//             }
//             separator("PAYE Reset")
//             {
//                 Caption = 'PAYE Reset';
//             }
//             action("Mark as Does Not Pay PAYE")
//             {
//                 Caption = 'Mark as Does Not Pay PAYE';
//                 Image = CheckList;
//                 // RunObject = Report "Mark as DOES NOT pay PAYE";
//             }
//             action("Mark as Pays PAYE")
//             {
//                 Caption = 'Mark as Pays PAYE';
//                 Image = CheckList;
//                 // RunObject = Report "Mark as PAYS PAYE";
//             }
//             action("Update Employee PAYE")
//             {
//                 Caption = 'Update Employee PAYE';
//                 Image = UpdateDescription;
//                 // RunObject = Report "Update Employee PAYE";
//             }
//         }
//     }
// }

