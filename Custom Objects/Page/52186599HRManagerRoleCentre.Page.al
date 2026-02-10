// page 52186599 "HR Manager Role Centre"
// {
//     Caption = 'Role Center';
//     PageType = RoleCenter;
//     PromotedActionCategories = 'Manage,Process,Report,Employees,Jobs,Leave';

//     layout
//     {
//         area(rolecenter)
//         {
//             group(Control29)
//             {
//                 ShowCaption = false;
//                 part(Control28; "HR  Manager Cue")
//                 {
//                     Caption = 'Manager Cue';
//                 }
//                 part(Control85; Rec."Connect Online")
//                 {
//                     Visible = false;
//                 }
//                 systempart(Control24; MyNotes)
//                 {
//                 }
//             }
//             group(Control26)
//             {
//                 ShowCaption = false;
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
//             action("HR Jobs")
//             {
//                 Caption = 'HR Jobs';
//                 Image = Job;
//                 Promoted = true;
//                 PromotedCategory = Category5;
//                 //RunObject = Report "HR Jobs";
//             }
//             action("HR Employees")
//             {
//                 Caption = 'HR Employees';
//                 Image = CustomerList;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 //RunObject = Report "HR Employee List";
//             }
//             action("HR Job Occupants")
//             {
//                 Caption = 'HR Job Occupants';
//                 Image = AddContacts;
//                 Promoted = true;
//                 PromotedCategory = Category5;
//                 //RunObject = Report "HR Job Occupants";
//             }
//             action("HR Jobs (Vacant & Occupied)")
//             {
//                 Caption = 'HR Jobs (Vacant & Occupied)';
//                 Image = JobRegisters;
//                 Promoted = true;
//                 PromotedCategory = Category5;
//                 //RunObject = Report "HR Jobs (Vacant)";
//             }
//             action("HR Job Responsibilities")
//             {
//                 Caption = 'HR Job Responsibilities';
//                 Image = JobResponsibility;
//                 Promoted = true;
//                 PromotedCategory = Category5;
//                 //RunObject = Report "HR Job Responsibilities";
//             }
//             action("HR Job Requirements")
//             {
//                 Caption = 'HR Job Requirements';
//                 Image = JobLines;
//                 Promoted = true;
//                 PromotedCategory = Category5;
//                 //RunObject = Report "HR Job Requirements";
//             }
//         }
//         area(processing)
//         {
//             action("HR Leave Adjustments")
//             {
//                 Caption = 'HR Leave Adjustments';
//                 Image = LimitedCredit;
//                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //PromotedCategory = Category6;
//                 RunObject = Page "HR Leave Journal Lines";
//             }
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
//             group("Professional Bodies")
//             {
//                 Caption = 'Professional Bodies';
//                 Image = FiledPosted;
//                 action("HR Professional Bodies")
//                 {
//                     Caption = 'HR Professional Bodies';
//                     RunObject = Page "HR Professional Bodies List";
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
//             group("Transport Management")
//             {
//                 Caption = 'Transport Management';
//                 Image = AnalysisView;
//                 action("HR Transport Requisitions")
//                 {
//                     Caption = 'HR Transport Requisitions';
//                     RunObject = Page "HR Transport Requisition List";
//                 }
//                 action("HR Transport Allocations")
//                 {
//                     Caption = 'HR Transport Allocations';
//                     RunObject = Page "HR Transport Allocations List";
//                 }
//                 action("Company Pool Vehicles")
//                 {
//                     Caption = 'Company Pool Vehicles';
//                     RunObject = Page "Company Vehicles list";
//                 }
//             }
//             group("Medical Scheme Management")
//             {
//                 Caption = 'Medical Scheme Management';
//                 Image = Travel;
//                 action("HR Medical Schemes")
//                 {
//                     Caption = 'HR Medical Schemes';
//                     RunObject = Page "HR Medical Schemes List";
//                 }
//                 action("HR Medical Scheme Members")
//                 {
//                     Caption = 'HR Medical Scheme Members';
//                     RunObject = Page "HR Medical Scheme Members List";
//                 }
//                 action("HR Medical Claims")
//                 {
//                     Caption = 'HR Medical Claims';
//                     RunObject = Page "HR Medical Claims List";
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
//             group("Shift Management")
//             {
//                 Caption = 'Shift Management';
//                 Image = Job;
//                 action("HR Login Management")
//                 {
//                     Caption = 'HR Login Management';
//                     RunObject = Page "HR Emp. Login Management List";
//                 }
//                 action("HR Shift Management")
//                 {
//                     Caption = 'HR Shift Management';
//                     RunObject = Page "HR Shift Management List";
//                 }
//                 action("HR Shift Schedule")
//                 {
//                     Caption = 'HR Shift Schedule';
//                     RunObject = Page "HR Shift Schedule Header List";
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
//             group("Occupational Health and Safety")
//             {
//                 Caption = 'Occupational Health and Safety';
//                 Image = LotInfo;
//                 action("HR Incidents")
//                 {
//                     Caption = 'HR Incidents';
//                     RunObject = Page "HR OSIncident List";
//                 }
//                 action("HR Investigations")
//                 {
//                     Caption = 'HR Investigations';
//                     RunObject = Page "HR OSInvestigation List";
//                 }
//                 action("HR Inspection")
//                 {
//                     Caption = 'HR Inspection';
//                     RunObject = Page "HR OSInspection List";
//                 }
//                 action("HR Safety Rules")
//                 {
//                     Caption = 'HR Safety Rules';
//                     RunObject = Page "HR OSSafety Rules";
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
//                     RunObject = Page 658;
//                 }
//             }
//         }
//     }
// }

