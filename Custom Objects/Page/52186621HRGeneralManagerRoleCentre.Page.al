// page 52186621 "HR General Manager Role Centre"
// {
//     Caption = 'Role Center';
//     PageType = RoleCenter;
//     PromotedActionCategories = 'Manage,Process,Report,Employees,Jobs,Payroll';

//     layout
//     {
//         area(rolecenter)
//         {
//             group(Control29)
//             {
//                 ShowCaption = false;
//                 part("HR Manager Cue"; "HR General Manager Cue")
//                 {
//                     Caption = 'HR Manager Cue';
//                 }
//                 part(Control85; Rec."Connect Online")
//                 {
//                     Visible = false;
//                 }
//             }
//             group(Control26)
//             {
//                 ShowCaption = false;
//                 systempart(Control24; MyNotes)
//                 {
//                 }
//                 systempart(Control81; Outlook)
//                 {
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(reporting)
//         {
//             // action("HR Jobs")
//             // {
//             //     Caption = 'HR Jobs';
//             //     Image = Job;
//             //     Promoted = true;
//             //     PromotedCategory = Category5;
//             //     RunObject = Report "HR Jobs";
//             // }
//             // action("HR Employees")
//             // {
//             //     Caption = 'HR Employees';
//             //     Image = CustomerList;
//             //     Promoted = true;
//             //     PromotedCategory = Category4;
//             //     RunObject = Report "HR Employee List";
//             // }
//             // action("HR Job Occupants")
//             // {
//             //     Caption = 'HR Job Occupants';
//             //     Image = AddContacts;
//             //     Promoted = true;
//             //     PromotedCategory = Category5;
//             //     RunObject = Report "HR Job Occupants";
//             // }
//             // action("HR Jobs (Vacant & Occupied)")
//             // {
//             //     Caption = 'HR Jobs (Vacant & Occupied)';
//             //     Image = JobRegisters;
//             //     Promoted = true;
//             //     PromotedCategory = Category5;
//             //     RunObject = Report "HR Jobs (Vacant)";
//             // }
//             // action("HR Job Responsibilities")
//             // {
//             //     Caption = 'HR Job Responsibilities';
//             //     Image = JobResponsibility;
//             //     Promoted = true;
//             //     PromotedCategory = Category5;
//             //     RunObject = Report "HR Job Responsibilities";
//             // }
//             // action("HR Job Requirements")
//             // {
//             //     Caption = 'HR Job Requirements';
//             //     Image = JobLines;
//             //     Promoted = true;
//             //     PromotedCategory = Category5;
//             //     RunObject = Report "HR Job Requirements";
//             // }
//             // action("Pay Advice")
//             // {
//             //     Caption = 'Pay Advice';
//             //     Image = Currencies;
//             //     Promoted = true;
//             //     PromotedCategory = Category6;
//             //     RunObject = Report prPaySlip2Local;
//             // }
//             // action("Payroll Benefits")
//             // {
//             //     Caption = 'Payroll Benefits';
//             //     Image = Resource;
//             //     Promoted = true;
//             //     PromotedCategory = Category6;
//             //     RunObject = Report "prAllowances Report";
//             // }
//             // action("Payroll Deductions")
//             // {
//             //     Caption = 'Payroll Deductions';
//             //     Image = AdjustEntries;
//             //     Promoted = true;
//             //     PromotedCategory = Category6;
//             //     RunObject = Report "prDeductions Report";
//             // }
//             // action("Payroll Provident Fund")
//             // {
//             //     Caption = 'Payroll Provident Fund';
//             //     Image = BankContact;
//             //     Promoted = true;
//             //     PromotedCategory = Category6;
//             //     RunObject = Report P10A;
//             // }
//             // action("Ghana Pension Scheme Tier1")
//             // {
//             //     Caption = 'Ghana Pension Scheme Tier1';
//             //     Image = PaymentForecast;
//             //     Promoted = true;
//             //     PromotedCategory = Category6;
//             //     RunObject = Report P10;
//             // }
//             // action("Ghana Pension Scheme Tier2")
//             // {
//             //     Caption = 'Ghana Pension Scheme Tier2';
//             //     Image = PaymentHistory;
//             //     Promoted = true;
//             //     PromotedCategory = Category6;
//             //     RunObject = Report "PR Payroll Summary";
//             // }
//             // action("Ghana Pension Old Scheme")
//             // {
//             //     Caption = 'Ghana Pension Old Scheme';
//             //     Image = Payment;
//             //     Promoted = true;
//             //     PromotedCategory = Category6;
//             //     RunObject = Report "PR NHIF";
//             // }
//             // action("Payroll Bank Details")
//             // {
//             //     Caption = 'Payroll Bank Details';
//             //     Image = Bank;
//             //     Promoted = true;
//             //     PromotedCategory = Category6;
//             //     RunObject = Report "PR Other PR Customers (Listin)";
//             // }
//             // action("Payroll Bank DetailsByBranch")
//             // {
//             //     Caption = 'Payroll Bank DetailsByBranch';
//             //     Image = BankAccount;
//             //     Promoted = true;
//             //     PromotedCategory = Category6;
//             //     RunObject = Report "PR Bank Summary";
//             // }
//             // action("prPayroll Bank Summary")
//             // {
//             //     Caption = 'prPayroll Bank Summary';
//             //     Image = BankAccountStatement;
//             //     Promoted = true;
//             //     PromotedCategory = Category6;
//             //     RunObject = Report "PR E-Mail Individual Payslip";
//             // }
//             // action("Payroll Details")
//             // {
//             //     Caption = 'Payroll Details';
//             //     Image = CustomerLedger;
//             //     Promoted = true;
//             //     PromotedCategory = Category6;
//             //     RunObject = Report "prPayroll Details";
//             // }
//             // action("GRA Form 51")
//             // {
//             //     Caption = 'GRA Form 51';
//             //     Image = AdjustVATExemption;
//             //     Promoted = true;
//             //     PromotedCategory = Category6;
//             //     RunObject = Report "prGRA Form 51";
//             // }
//             // action("NAPSA Report")
//             // {
//             //     Caption = 'NAPSA Report';
//             //     Image = Allocations;
//             //     Promoted = true;
//             //     PromotedCategory = Category6;
//             //     RunObject = Report "PR NSSF";
//             // }
//             // action("ZRA Form 51")
//             // {
//             //     Caption = 'ZRA Form 51';
//             //     Image = "1099Form";
//             //     Promoted = true;
//             //     PromotedCategory = Category6;
//             //     RunObject = Report "prZRA Form 51";
//             // }
//         }
//         area(sections)
//         {
//             group("Jobs Management")
//             {
//                 Caption = 'Jobs Management';
//                 Image = ResourcePlanning;
//                 action(Action58)
//                 {
//                     Caption = 'HR Jobs';
//                     Image = Job;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     RunObject = Page "HR Jobs List";
//                 }
//                 separator(Action3)
//                 {
//                 }
//                 action("HR Job Qualifications")
//                 {
//                     Caption = 'HR Job Qualifications';
//                     RunObject = Page "HR Job Qualifications";
//                 }
//             }
//             group("Recruitment Management")
//             {
//                 Caption = 'Recruitment Management';
//                 Image = Marketing;
//                 action("HR Employee Requisitions")
//                 {
//                     Caption = 'HR Employee Requisitions';
//                     RunObject = Page "HR Employee Requisitions List";
//                 }
//                 action("HR Job Applications")
//                 {
//                     Caption = 'HR Job Applications';
//                     RunObject = Page "HR Job Applications List";
//                 }
//                 action("HR Shortlisting")
//                 {
//                     Caption = 'HR Shortlisting';
//                     RunObject = Page "HR Shortlisting List";
//                 }
//                 action("HR Job Applicant(s) Qualified")
//                 {
//                     Caption = 'HR Job Applicant(s) Qualified';
//                     RunObject = Page "HR Job Applicants Qualified L";
//                 }
//                 action("HR Job Applicant(s) UnQualified")
//                 {
//                     Caption = 'HR Job Applicant(s) UnQualified';
//                     RunObject = Page "HR Applicants UnQualified L";
//                 }
//                 action("HR Successful Job Applicant(s)")
//                 {
//                     Caption = 'HR Successful Job Applicant(s)';
//                     RunObject = Page "HR  App Qualified Applicants";
//                 }
//                 action("HR Job Applicants Uploaded")
//                 {
//                     Caption = 'HR Job Applicants Uploaded';
//                     RunObject = Page "HR Job Applicants Uploaded";
//                 }
//                 action("HR Employee Requisitions Approved")
//                 {
//                     Caption = 'HR Employee Requisitions Approved';
//                     RunObject = Page "HR Employee Reqs List Approved";
//                 }
//             }
//             group("Employee Management")
//             {
//                 Caption = 'Employee Management';
//                 Image = HumanResources;
//                 action("HR Induction Schedule")
//                 {
//                     Caption = 'HR Induction Schedule';
//                     RunObject = Page "HR Induction Schedule List";
//                 }
//                 action("Unapproved HR Employee-List (All)")
//                 {
//                     Caption = 'Unapproved HR Employee-List (All)';
//                     RunObject = Page "HR Employee List - Pending App";
//                 }
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
//                 action("Deactivated HR Employee-List")
//                 {
//                     Caption = 'Deactivated HR Employee-List';
//                     RunObject = Page "HR Employee-List Disabled";
//                 }
//             }
//             group("Employee Confirmation")
//             {
//                 Caption = 'Employee Confirmation';
//                 Image = Confirm;
//                 action("HR Employee Confirmation")
//                 {
//                     Caption = 'HR Employee Confirmation';
//                     RunObject = Page "HR Employee Confirmation List";
//                 }
//             }
//             group("Employee Promotion")
//             {
//                 Caption = 'Employee Promotion';
//                 Image = ExecuteBatch;
//                 action("HR Promotion Recommendations")
//                 {
//                     Caption = 'HR Promotion Recommendations';
//                     RunObject = Page "HR Promotion Recommend List";
//                 }
//                 action("Effected HR Promotion Recommendations")
//                 {
//                     Caption = 'Effected HR Promotion Recommendations';
//                     RunObject = Page "HR Promotion Recommend AppList";
//                 }
//             }
//             group("Employee Transfer")
//             {
//                 Caption = 'Employee Transfer';
//                 Image = Departments;
//                 action("HR Employee Transfer")
//                 {
//                     Caption = 'HR Employee Transfer';
//                     RunObject = Page "HR Employee Transfer List";
//                 }
//                 action("Effected HR Employee Transfer")
//                 {
//                     Caption = 'Effected HR Employee Transfer';
//                     RunObject = Page "HR Employee Transfer List Effe";
//                 }
//             }
//             group("Asset Transfer")
//             {
//                 Caption = 'Asset Transfer';
//                 Image = FixedAssets;
//                 action("HR Asset Transfer")
//                 {
//                     Caption = 'HR Asset Transfer';
//                     RunObject = Page "HR Asset Transfer List";
//                 }
//                 action("Effected HR Asset Transfer")
//                 {
//                     Caption = 'Effected HR Asset Transfer';
//                     RunObject = Page "HR EffectedAsset Transfer List";
//                 }
//             }
//             group("Overtime Management")
//             {
//                 Caption = 'Overtime Management';
//                 Image = Reconcile;
//                 action("HR Overtime")
//                 {
//                     Caption = 'HR Overtime';
//                     RunObject = Page "HR Overtime List";
//                 }
//                 action("HR Overtime Rates")
//                 {
//                     Caption = 'HR Overtime Rates';
//                     RunObject = Page "HR Overtime Rates List";
//                 }
//                 action("HR Converted Overtime")
//                 {
//                     Caption = 'HR Converted Overtime';
//                     RunObject = Page "HR Overtime List - Converted";
//                 }
//             }
//             group("360 degrees Appraisal")
//             {
//                 Caption = '360 degrees Appraisal';
//                 Image = Calculator;
//                 action("HR 360 Appraisals List - Appraisee")
//                 {
//                     Caption = 'HR 360 Appraisals List - Appraisee';
//                     RunObject = Page "HR 360 Appraisals List - TS";
//                 }
//                 action("HR 360 Appraisals List - Supervisor")
//                 {
//                     Caption = 'HR 360 Appraisals List - Supervisor';
//                     RunObject = Page "HR 360 Appraisals List - TA";
//                 }
//                 action("HR 360 Appraisals List - Evaluation")
//                 {
//                     Caption = 'HR 360 Appraisals List - Evaluation';
//                     RunObject = Page "HR 360 Appraisals List - EV";
//                 }
//                 action("HR Appraisal Evaluation Areas - Job Specific")
//                 {
//                     Caption = 'HR Appraisal Evaluation Areas - Job Specific';
//                     RunObject = Page "HR Appraisal Eval Areas - JS";
//                 }
//                 action("HR Appraisal Evaluation Areas - Employee's Peers")
//                 {
//                     Caption = 'HR Appraisal Evaluation Areas - Employee''s Peers';
//                     RunObject = Page "HR Appraisal Eval Areas - EP";
//                 }
//                 action("HR Appraisal Evaluation Areas - Employee's Subordinates")
//                 {
//                     Caption = 'HR Appraisal Evaluation Areas - Employee''s Subordinates';
//                     RunObject = Page "HR Appraisal Eval Areas - ES";
//                 }
//                 action("HR Appraisal Evaluation Areas - External Sources")
//                 {
//                     Caption = 'HR Appraisal Evaluation Areas - External Sources';
//                     RunObject = Page "HR Appraisal Eval Areas - ExS";
//                 }
//                 action("Human Resource Unit of Measure")
//                 {
//                     Caption = 'Human Resource Unit of Measure';
//                     RunObject = Page "Human Resource Unit of Measure";
//                 }
//             }
//             group("BSC Appraisal")
//             {
//                 Caption = 'BSC Appraisal';
//                 Image = CostAccounting;
//                 action("HR BSC List Target Setting")
//                 {
//                     Caption = 'HR BSC List Target Setting';
//                     RunObject = Page "HR BSC List Targets";
//                 }
//                 action("HR BSC List Review")
//                 {
//                     Caption = 'HR BSC List Review';
//                     RunObject = Page "HR BSC List Review";
//                 }
//                 action("HR BSC List End Year")
//                 {
//                     Caption = 'HR BSC List End Year';
//                     RunObject = Page "HR BSC List End Year";
//                 }
//             }
//             group("Training Management")
//             {
//                 Caption = 'Training Management';
//                 Image = Payables;
//                 action("HR Training Needs")
//                 {
//                     Caption = 'HR Training Needs';
//                     RunObject = Page "HR Training Needs List";
//                 }
//                 action("HR Training Applications")
//                 {
//                     Caption = 'HR Training Applications';
//                     RunObject = Page "HR Training Application List";
//                 }
//                 action("HR Training Applications - Approved")
//                 {
//                     Caption = 'HR Training Applications - Approved';
//                     RunObject = Page "HR Training App List -Approved";
//                 }
//             }
//             group("Succession Planning")
//             {
//                 Caption = 'Succession Planning';
//                 Image = ResourcePlanning;
//                 action("HR Jobs to Succeed")
//                 {
//                     Caption = 'HR Jobs to Succeed';
//                     RunObject = Page "HR Jobs to Succeed List";
//                 }
//                 action("HR Succession Planning List")
//                 {
//                     Caption = 'HR Succession Planning List';
//                     RunObject = Page "HR Succession Planning List";
//                 }
//             }
//             group("Disciplinary Management")
//             {
//                 Caption = 'Disciplinary Management';
//                 Image = Statistics;
//                 action("HR Disciplinary Cases")
//                 {
//                     Caption = 'HR Disciplinary Cases';
//                     RunObject = Page "HR Disciplinary Cases List N";
//                 }
//                 action("HR Closed Disciplinary Cases")
//                 {
//                     Caption = 'HR Closed Disciplinary Cases';
//                     RunObject = Page "HR Disciplinary Cases ListClsd";
//                 }
//                 action("HR Disciplinary Actions")
//                 {
//                     Caption = 'HR Disciplinary Actions';
//                     RunObject = Page "HR Disciplinary Actions";
//                 }
//             }
//             group("Leave Management")
//             {
//                 Caption = 'Leave Management';
//                 Image = Capacities;
//                 action("HR Leave Applications")
//                 {
//                     Caption = 'HR Leave Applications';
//                     RunObject = Page "HR Leave Applications List";
//                 }
//                 action("HR Leave Reimbursments")
//                 {
//                     Caption = 'HR Leave Reimbursments';
//                     RunObject = Page "HR Leave Reimbursment List";
//                 }
//                 action("HR Leave Types")
//                 {
//                     Caption = 'HR Leave Types';
//                     RunObject = Page "HR Leave Types";
//                 }
//                 action("HR Leave Periods")
//                 {
//                     Caption = 'HR Leave Periods';
//                     RunObject = Page "HR Leave Period List";
//                 }
//                 action("HR Leave Applications History")
//                 {
//                     Caption = 'HR Leave Applications History';
//                     RunObject = Page "HR Leave Applications History";
//                 }
//             }
//             group("Company Activities")
//             {
//                 Caption = 'Company Activities';
//                 Image = Dimensions;
//                 action("HR Company Activities")
//                 {
//                     Caption = 'HR Company Activities';
//                     RunObject = Page "HR Company Activities List";
//                 }
//                 action("HR Closed Company Activities")
//                 {
//                     Caption = 'HR Closed Company Activities';
//                     RunObject = Page "HR Company Activities List Clo";
//                 }
//             }
//             group("Exit Management")
//             {
//                 Caption = 'Exit Management';
//                 Image = Alerts;
//                 action("HR Exit Interviews")
//                 {
//                     Caption = 'HR Exit Interviews';
//                     RunObject = Page "HR Exit Interview list";
//                 }
//                 action("HR Closed Exit Interviews")
//                 {
//                     Caption = 'HR Closed Exit Interviews';
//                     RunObject = Page "Closed HR Exit Interview list";
//                 }
//             }
//             group(Approvals)
//             {
//                 Caption = 'Approvals';
//                 Image = AdministrationSalesPurchases;
//                 action("Approval Entries")
//                 {
//                     Caption = 'Approval Entries';
//                     RunObject = Page "Approval Entries";
//                 }
//             }
//         }
//     }
// }

