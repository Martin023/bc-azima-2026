// page 52185649 "Payroll Role Center"
// {
//     Caption = 'Role Center';
//     PageType = RoleCenter;

//     layout
//     {
//         area(rolecenter)
//         {
//             group(Control1)
//             {
//                 ShowCaption = false;
//                 part("Salary List"; "PR Salary List (ALL)")
//                 {
//                 }
//                 group(Control1900724808)
//                 {
//                     ShowCaption = false;
//                     systempart(Control1901420308; Outlook)
//                     {
//                     }
//                 }
//                 group(Control1900724708)
//                 {
//                     ShowCaption = false;
//                     part(Control17; "My Job Queue")
//                     {
//                         Visible = false;
//                     }
//                     part(Control1903012608; "Connect Online")
//                     {
//                         Visible = false;
//                     }
//                     systempart(Control1901377608; MyNotes)
//                     {
//                     }
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(reporting)
//         {
//             action("Pay Advice")
//             {
//                 Caption = 'Pay Advice';
//                 Image = Currencies;
//                 RunObject = Report prPaySlip2Local;
//             }
//             action("Payroll Benefits")
//             {
//                 Caption = 'Payroll Benefits';
//                 Image = Resource;
//                 RunObject = Report "prAllowances Report";
//             }
//             action("Payroll Deductions")
//             {
//                 Caption = 'Payroll Deductions';
//                 Image = AdjustEntries;
//                 RunObject = Report "prDeductions Report";
//             }
//             action("Payroll Provident Fund")
//             {
//                 Caption = 'Payroll Provident Fund';
//                 Image = BankContact;
//                 RunObject = Report P10A;
//             }
//             action("Ghana Pension Scheme Tier1")
//             {
//                 Caption = 'Ghana Pension Scheme Tier1';
//                 Image = PaymentForecast;
//                 RunObject = Report P10;
//             }
//             action("Ghana Pension Scheme Tier2")
//             {
//                 Caption = 'Ghana Pension Scheme Tier2';
//                 Image = PaymentHistory;
//                 RunObject = Report "PR Payroll Summary";
//             }
//             action("Ghana Pension Old Scheme")
//             {
//                 Caption = 'Ghana Pension Old Scheme';
//                 Image = Payment;
//                 RunObject = Report "PR NHIF";
//             }
//             action("Payroll Bank Details")
//             {
//                 Caption = 'Payroll Bank Details';
//                 Image = Bank;
//                 RunObject = Report "PR Other PR Customers (Listin)";
//             }
//             action("Payroll Bank DetailsByBranch")
//             {
//                 Caption = 'Payroll Bank DetailsByBranch';
//                 Image = BankAccount;
//                 RunObject = Report "PR Bank Summary";
//             }
//             action("prPayroll Bank Summary")
//             {
//                 Caption = 'prPayroll Bank Summary';
//                 Image = BankAccountStatement;
//                 RunObject = Report "PR E-Mail Individual Payslip";
//             }
//             action("Payroll Details")
//             {
//                 Caption = 'Payroll Details';
//                 Image = CustomerLedger;
//                 RunObject = Report "prPayroll Details";
//             }
//             action("GRA Form 51")
//             {
//                 Caption = 'GRA Form 51';
//                 Image = AdjustVATExemption;
//                 RunObject = Report "prGRA Form 51";
//             }
//             action("NAPSA Report")
//             {
//                 Caption = 'NAPSA Report';
//                 Image = Allocations;
//                 RunObject = Report "PR NSSF";
//             }
//             action("ZRA Form 51")
//             {
//                 Caption = 'ZRA Form 51';
//                 Image = "1099Form";
//                 RunObject = Report "prZRA Form 51";
//             }
//         }
//         area(embedding)
//         {
//             action(Action1102755024)
//             {
//                 Caption = 'Salary List';
//                 RunObject = Page "PR Salary List (ALL)";
//             }
//         }
//         area(sections)
//         {
//             group("Human Resources")
//             {
//                 Caption = 'Human Resources';
//                 Image = HRSetup;
//                 action("Approved HR Employee-List (All)")
//                 {
//                     Caption = 'Approved HR Employee-List (All)';
//                     RunObject = Page "HR Employee List - Active";
//                 }
//                 action("Approved HR Employee-List (Permanent)")
//                 {
//                     Caption = 'Approved HR Employee-List (Permanent)';
//                     RunObject = Page "HR Employee List - New";
//                 }
//                 action("Approved HR Employee-List (Contract)")
//                 {
//                     Caption = 'Approved HR Employee-List (Contract)';
//                     RunObject = Page "HR Employee-List (Contract) Ap";
//                 }
//                 action("Approved HR Employee-List (Casuals)")
//                 {
//                     Caption = 'Approved HR Employee-List (Casuals)';
//                     RunObject = Page "HR Employee-List (Casuals) App";
//                 }
//                 action("Approved HR Employee-List (Interns)")
//                 {
//                     Caption = 'Approved HR Employee-List (Interns)';
//                     RunObject = Page "HR Employee-List (Interns) App";
//                 }
//             }
//             group("Approval Entries")
//             {
//                 Caption = 'Approval Entries';
//                 Image = Capacities;
//                 action(Action1102755020)
//                 {
//                     Caption = 'Approval Entries';
//                     RunObject = Page "Approval Entries";
//                 }
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
//                 RunObject = Report "PR Transfer To Journal";
//             }
//             action("Generate Mass Transactions")
//             {
//                 Caption = 'Generate Mass Transactions';
//                 Image = LedgerEntries;
//                 RunObject = Report "Generate Mass Transactions";
//             }
//             action("Allowance Variations")
//             {
//                 Caption = 'Allowance Variations';
//                 Image = VATEntries;
//                 RunObject = Page "Allowance Var";
//             }
//             action("Deductions Variations")
//             {
//                 Caption = 'Deductions Variations';
//                 Image = WarehouseRegisters;
//                 RunObject = Page "Deductions Var";
//             }
//             action("Processed Allowance Variations")
//             {
//                 Caption = 'Processed Allowance Variations';
//                 Image = AdjustEntries;
//                 RunObject = Page "Processed Allowance Variations";
//             }
//             action("Processed Deduction Variations")
//             {
//                 Caption = 'Processed Deduction Variations';
//                 Image = Allocations;
//                 RunObject = Page "Processed Deduction Variations";
//             }
//         }
//     }
// }

