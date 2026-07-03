page 52187320 AdvancedHumanResources
{
    PageType = RoleCenter;
    Caption = 'Human Resources Role Center.';

    layout
    {
        area(RoleCenter)
        {
            part(Control76; CustomHeadline)
            {
                ApplicationArea = Basic, Suite;
            }
            part("HR Manager Cue"; "HR  Manager Activities")
            {
                Caption = 'Activities';

                ApplicationArea = Basic;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }


            // part("Employee Management"; "HR General Manager Cue")
            // {
            //     ApplicationArea = Basic;
            // }
            part("Emails"; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
            }

            systempart(Control1901377608; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }



        }
    }

    actions
    {
        // area(Creation)
        // {
        //     action(ActionBarAction)
        //     {
        //         RunObject = Page ObjectName;
        //     }
        // }
        area(Sections)
        {
            group(HREmployeeManagement)
            {
                group("Employee Recruitment")
                {
                    action(HRemployeeRequisitions)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employee Requisitions List';

                        RunObject = Page "HR Employee Requisitions List";
                    }
                    action(HRjobApplications)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Job Applications List';

                        RunObject = Page "HR Job Applications List";
                    }
                    action(Shortlisting)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Shortlisting List';

                        RunObject = Page "HR Shortlisting List1";
                    }
                    // action(HRJobApplicantsQualified)
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'HR Job Applicants Qualified';

                    //     RunObject = Page "HR Job Applicants QualifiedL1";
                    // }
                    action(HRJobApplicantsNotQualified)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Job Applicants UnQualified List';

                        RunObject = Page "HR Applicants UnQualified L1";

                    }
                    action(SuccesfulJobApplicants)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Qualified (Successful) Job Applicants List';

                        RunObject = Page "HR  App Qualified Applicants1";
                    }
                    group(RepoAndanalysis)
                    {
                        Caption = 'Reports and Analysis';
                        action(HRJobApplicants)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Job Applications';

                            RunObject = report "HR Job Applications";
                        }
                        action(JobInterviewReport)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Job Interview Report';

                            RunObject = report "Job Interview results";
                        }
                        action(Shortlistedreport)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Shortlisted Candidates Report';

                            RunObject = report "Shortlisted Candidates";
                        }

                        action(Shortlistingreport)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Interview Report';

                            RunObject = report "Shortlisting Report";
                        }
                        action("Employee Requisition")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Employee Requisition Report';

                            RunObject = report "Employee Requisiton Report";
                        }
                    }
                    group(Archive)
                    {
                        Caption = 'Archive';
                        action(HRjobApplicantsUploaded)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Job Applicants Uploaded List';

                            RunObject = Page "HR Job Applicants Uploaded1";
                        }
                        action(HRemployeereqapproved)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Employee Requisitions Approved List';

                            RunObject = Page "HR Employee ReqsListApproved1";
                        }
                    }
                }
                group("Employee Management")
                {
                    Caption = 'Employee Management';
                    // action(HRInductionSchedule)
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'HR Induction Schedule';

                    //     RunObject = Page "HR Induction Schedule List1";
                    // }
                    action(HREmployeeList)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employees - New List';

                        RunObject = Page "HR Employee List - New1";
                    }
                    action(HREmployeeList1)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employees - Pending Approval List';

                        RunObject = Page "HR Employee List-Pending App1";
                    }
                    action(HREmployeeList2)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employees - Active List';

                        RunObject = Page "HR Employee List - Active";
                    }
                    action(HREmployeeList3)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employees - Inactive List';

                        RunObject = Page "HR Employee List - Inactive";
                    }
                    // action(HREmployeeList4)
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'HR Employees - Fixed TC';

                    //     RunObject = Page "HR Employee List - (FixedTc)";
                    // }
                    // action(HREmployeeChangeLog)
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'HR Employees - Probation';

                    //     RunObject = Page "HR Employee Change Log";
                    // }
                    group(Tasks)
                    {
                        Caption = 'Tasks';
                        action(HrHeadOfDepartments)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Head of Departments List';

                            RunObject = Page "HR Head of Departments List";
                        }
                        action(HRDepartmentTargets)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Department Targets List';

                            RunObject = Page "HR Department Targets List";
                        }
                        action(HRPerspectivesSetup)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Perspectives Setup List';

                            RunObject = Page "HR Perspective Setup List";
                        }
                        // action(HRInductionSchedule)
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'HR Induction Schedule';

                        //     RunObject = Page "HR Induction Schedule List";
                        // }
                    }
                    group(RepandAnalysis)
                    {
                        Caption = 'Reports And Analysis';

                        action(HREmployeeListdetailedReport)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Employee Detailed Report';

                            RunObject = report "Employee Detailed Report";
                        }
                        action(HREmployeeListReport)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Employee Dependants Report';

                            RunObject = report HrNextofKin;
                        }

                        action(HREmployeeListReport1)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Employee List Report';

                            RunObject = report "HR Employee List";
                        }
                        action(HREmployeeSupervisor)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Employee Supervisors Report';

                            RunObject = report "HR Staff Supervisor";
                        }
                        action(HREmployeeAppointment)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Employee Appointment Report';

                            RunObject = report "EmployeeAppointment report";
                        }
                        action("Employee Value Change")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Employee Value Change';

                            RunObject = report "Employee Value Change";
                        }
                        action("Member Listing Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Member Listing - List';
                            RunObject = page "Member Listing Report";

                        }


                    }
                }
                group("Training Management")
                {
                    Caption = 'Training Management';
                    group(HrTrainingMgt)
                    {
                        Caption = 'Training Management';
                        action(HRTrainingNeeds)
                        {
                            Caption = 'Open Training Needs List';
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "HR Training Needs List";
                        }
                        action(HRTrainingNeedRequests)
                        {
                            Caption = 'Training Need Requests - All';
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Training Need Requests - All";
                        }

                        action(HrTrainingApplications)
                        {
                            Caption = 'Training Applications List';
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "HR Training ApplicationList";
                        }
                        group(Taskss)
                        {
                            Caption = 'Tasks';
                            action(HRTrainingFeedBack)
                            {
                                Caption = 'Training FeedBack';
                                ApplicationArea = Basic, Suite;
                                RunObject = Page "Training Evaluation";
                            }
                            action(HRTrainingPlanner)
                            {
                                Caption = 'Training Planner List';
                                ApplicationArea = Basic, Suite;
                                RunObject = Page "Hr Training Planner List";
                            }

                        }
                        // group(Archve)
                        // {
                        //     Caption = 'Archives';
                        //     action(HrTrainingApplicationsArchive)
                        //     {
                        //         Caption = 'HR Training Applications Archive';
                        //         ApplicationArea = Basic, Suite;
                        //         RunObject = Page "HR Training Application Lines";
                        //     }
                        // }
                        group(reports)
                        {
                            Caption = 'Reports';
                            action(HrTraining)
                            {
                                Caption = 'Training Needs Report';
                                ApplicationArea = Basic, Suite;
                                RunObject = Report "HR Training Needs";
                            }

                            action(HrTrainingPlan)
                            {
                                Caption = 'Training Planner Report';
                                ApplicationArea = Basic, Suite;
                                RunObject = Report "Training Planner";
                            }
                            action(HrTrainingAttendees)
                            {
                                Caption = 'Training Attendees Report';
                                ApplicationArea = Basic, Suite;
                                RunObject = Report TrainingAttendees;
                            }
                            action("Training Evaluation Report")
                            {
                                Caption = 'Training Evaluation';
                                ApplicationArea = Basic, Suite;
                                RunObject = Report "Training Evaluation";
                            }

                            // action(jobqueue)
                            // {
                            //     Caption = 'Queue';
                            //     ApplicationArea = Basic, Suite;
                            //     RunObject = Report HremployeesJobQueues;
                            // }



                        }

                    }
                    // group(HrInternsMgt)
                    // {
                    //     Caption = 'HR Interns Management';
                    //     action(HrInterns)
                    //     {
                    //         Caption = 'HR Interns';
                    //         ApplicationArea = Basic, Suite;
                    //         RunObject = Page "HR Interns List";
                    //     }
                    //     action(HrInternsRequisitions)
                    //     {
                    //         Caption = 'HR Interns Requisitions';
                    //         ApplicationArea = Basic, Suite;
                    //         RunObject = Page "HR Intern Requisition List";
                    //     }
                    // }

                }
                group("Disciplinary Management")
                {
                    Caption = 'Disciplinary Management';
                    action(HRDisciplinaryCases)
                    {
                        Caption = 'Disciplinary Cases List';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "HR Disciplinary Cases List N1";
                    }
                    action(ClosedHRDisciplinaryCases)
                    {
                        Caption = 'Closed Disciplinary Cases List';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "HR Disciplinary Cases ListCls1";
                    }

                    action(HRDiscWthdwaList)
                    {
                        Caption = 'Disciplinary Withdrawal List';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "HR Disc Withdrawal list";
                    }
                    action(HRDiscAppealList)
                    {
                        Caption = 'Disciplinary Appeal List';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "HR Disciplinary Appeal List";
                    }


                    group(Archves)
                    {
                        Caption = 'Archive';
                        action(ClosedHrDiscCases)
                        {
                            Caption = 'Closed Disciplinary Cases List';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "HR Disciplinary Cases ListCls1";

                        }
                    }
                    group(Admini)
                    {
                        Caption = 'Administration';
                        action(HrDiscActions)
                        {
                            Caption = 'Disciplinary Actions List';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "HR Disciplinary Actions1";

                        }
                    }
                }
                group("Performance Management")
                {
                    Caption = 'Performance Management';
                    group("BSC Appraisal")
                    {
                        action("HR BSC List Target Setting ")
                        {
                            Caption = 'List Target Setting';
                            ApplicationArea = Basic, suite;
                            RunObject = page "HR 360 Appraisals List - TS1";
                        }
                        action("HR BSC List Target Approval")
                        {
                            Caption = 'List Target Approval';
                            ApplicationArea = Basic, suite;
                            RunObject = page "HR 360 Appraisals List - TA1";
                        }
                        action("HR BSC List Evaluation Areas")
                        {
                            Caption = 'List Evaluation';
                            ApplicationArea = Basic, suite;
                            RunObject = page "HR 360 Appraisals List - EV1";

                        }

                        // action("HR BSC List Target Setting")
                        // {
                        //     Caption = 'HR BSC List Target Setting';
                        //     ApplicationArea = Basic, suite;
                        //     RunObject = page "HR BSC List Targets1";
                        // }
                        // action("HR BSC List Targets-Supervisor")
                        // {
                        //     Caption = 'HR BSC List Targets-Supervisor';
                        //     ApplicationArea = Basic, suite;
                        //     RunObject = page "HR BSC List Targets-Supervisor";
                        // }
                        // action("HR BSC List Quater1")
                        // {
                        //     Caption = 'HR BSC List Quater1';
                        //     ApplicationArea = Basic, suite;
                        //     RunObject = page "HR BSC List Qaurter 1";
                        // }
                        // action("HR BSC List Review")
                        // {
                        //     Caption = 'HR BSC List Review';
                        //     ApplicationArea = Basic, suite;
                        //     RunObject = page "HR BSC List Review1";
                        // }
                        // action("HR BSC List Quater 3")
                        // {
                        //     Caption = 'HR BSC List Quater 3';
                        //     ApplicationArea = Basic, suite;
                        //     RunObject = page "HR BSC List Qaurter 3";
                        // }
                        action("HR BSC List Approved")
                        {

                            Caption = 'HR List Target Setting';
                            ApplicationArea = Basic, suite;
                            RunObject = page "HR 360 Appraisals List - TS1";
                            RunPageLink = Status = CONST(Approved);
                        }

                        // action("HR BSC List End Year")
                        // {
                        //     Caption = 'HR BSC List End Year';
                        //     ApplicationArea = Basic, suite;
                        //     RunObject = page "HR BSC List End Year1";
                        // }
                        // action("HR BSC List Closed")
                        // {
                        //     Caption = 'HR BSC List Closed';
                        //     ApplicationArea = Basic, suite;
                        //     RunObject = page "HR BSC List Closed";
                        // }
                        action("HR Appraisal Appeal List")
                        {
                            Caption = 'HR Appraisal Appeal List';
                            ApplicationArea = Basic, suite;
                            RunObject = page "HR Appraissal Appeal list";
                        }
                    }
                    group(Taskz)
                    {
                        Caption = 'Tasks';
                        action("HR Appraisal Period Setup")
                        {
                            Caption = 'HR Appraisal Period Setup';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "HR Appraisal Period Setup";

                        }
                        action("HR Department Targets List")
                        {
                            Caption = 'HR Department Targets (All)';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "HR Department Targets List";
                        }
                        action("HR HOD Department Targets")
                        {
                            Caption = 'My Department Targets (HOD)';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "HRHOD Department Targets";
                        }
                        action("HR Employee Target Assignments")
                        {
                            Caption = 'Employee Target Assignments';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "HR Employee Target Assgns List";
                        }
                    }
                    group(randanalysis)
                    {
                        Caption = 'Reports and Analysis';
                        // action(PerfomanceReport)
                        // {
                        //     Caption = 'Perfomance Report';
                        //     ApplicationArea = Basic, Suite;
                        //     RunObject = report "Performance Report";

                        // }
                        action(Perfomance)
                        {
                            Caption = 'Perfomance Report';
                            ApplicationArea = Basic, Suite;
                            RunObject = report "Performance";
                            ;

                        }
                        // action(AppraisalReport)
                        // {
                        //     Caption = 'Appraisal Report';
                        //     ApplicationArea = Basic, Suite;
                        //     RunObject = report "Appraisal Report";

                        // }
                    }
                }
                group("Leave Management")
                {
                    group(Grp1Tasks)
                    {
                        Caption = 'Tasks';
                        action("HR Leave Types")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Leave Types List';

                            RunObject = Page "HR Leave Types1";
                        }
                        action(LeaveApplication)
                        {
                            Caption = 'Leave Applications List';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "HR Leave Applications List1";
                        }
                        action(AllLeaveApplication)
                        {
                            Caption = 'Leave Applications - All List';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Hr Leave Application List All";
                        }
                        action(AppLeaveApplication)
                        {
                            Caption = 'Approved Leave Applications List';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Approved Leave Applications";
                        }


                        action(HRLeaveAdjustments)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Leave Adjustments';

                            RunObject = Page "HR Leave Journal Lines";
                        }
                        action(HrleaveJnrTemp)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Leave Journal Templates List';

                            RunObject = Page "HR Leave Jnl. Template List";
                        }
                        action(HrLeaveReimbusementList)
                        {
                            Caption = 'Leave Reimbursement List';
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "HR Leave Reimbursment List1";
                        }
                        action(HrLeaveRecallList)
                        {
                            Caption = 'Leave Recall List';
                            ApplicationArea = Basic, Suite;
                            RunObject = report "Reimburse Recalled Leave Days";
                        }


                        action(HrLeavePlannerList)
                        {
                            Caption = 'Leave Planner List';
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "HR Leave Planner List";
                        }
                        action(HrLeavePlannerLinesDrill)
                        {
                            Caption = 'Leave Planner Lines Drill';
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "HR Leave Planner Lines Drill";
                        }

                    }
                    group(Grp2repansanalysis)
                    {
                        Caption = 'Reports and Analysis';
                        action(HrLeaveApplication)
                        {
                            Caption = 'Leave Application Report';
                            ApplicationArea = Basic, Suite;
                            RunObject = report "HR Leave Application";
                        }
                        action(HrLeaveTypes)
                        {
                            Caption = 'Leave Types Report';
                            ApplicationArea = Basic, Suite;
                            RunObject = report "Leave types report";
                        }
                        action(LeaveBalances)
                        {
                            Caption = 'Leave Balance Report';
                            ApplicationArea = Basic, Suite;
                            RunObject = report "Leave Balance";
                        }


                        action(HrLeaveStatement)
                        {
                            Caption = 'Leave Statement Report';
                            ApplicationArea = Basic, Suite;
                            RunObject = report "HR Leave Statement";
                        }
                        action(StaffLeaveBalances)
                        {
                            Caption = 'Utilization Report';
                            ApplicationArea = Basic, Suite;
                            RunObject = report "HR Leave Balance";
                        }
                        action(HrleaveBal2)
                        {
                            Caption = 'Leave Balance 2 Report';
                            ApplicationArea = Basic, Suite;
                            RunObject = report "HR Leave Balance2";
                        }
                        action(HrLeaveBalSummary)
                        {
                            Caption = 'Leave Balance Summary Report';
                            ApplicationArea = Basic, Suite;
                            RunObject = report "HR Leave Balance Summary";
                        }
                        action(StaffOnLeave)
                        {
                            Caption = 'Staff On Leave Report';
                            ApplicationArea = Basic, Suite;
                            RunObject = report "Staff On Leave";
                        }
                        action("Leave Costing")
                        {
                            Caption = 'Leave Costing Report';
                            ApplicationArea = Basic, Suite;
                            RunObject = report "Leave Costing";
                        }
                        action("LeaveCost to payroll")
                        {
                            Caption = 'Leave Cost to Payroll Report';
                            ApplicationArea = Basic, Suite;
                            RunObject = report "LeaveCost to payroll";
                        }




                    }
                    group(Archives)
                    {
                        Caption = 'Archives';
                        action(HrLeavePlannerArchive)
                        {
                            Caption = 'Leave Planner Archive';
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Hr Leave Planner Lines";
                        }
                        action(Rejectedleaveapp)
                        {
                            Caption = 'Rejected Leave Applications';
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Rejected Leave Applications";
                        }
                    }
                    group(Adm)
                    {
                        Caption = 'Administration';
                        action(HrLeavePeriods)
                        {
                            Caption = 'HR Leave Periods';
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "HR Leave Period List";
                        }

                    }

                }
                // group(Overtime)
                // {
                //     action("Overtime Management")
                //     {
                //         Caption = 'HR Needs Request';
                //         ApplicationArea = Basic, Suite;
                //         RunObject = Page "HR Overtime List1";
                //     }
                //     action(Overtimeclaim)
                //     {
                //         Caption = 'HR Overtime Claim List';
                //         ApplicationArea = Basic, Suite;
                //         RunObject = Page "Overtime Claim List";
                //     }
                //     action(OvertimeReport)
                //     {
                //         Caption = 'HR Overtime Claim Cost Report';
                //         ApplicationArea = Basic, Suite;
                //         RunObject = report "Overtime Claim Cost";
                //     }
                //     action(OvertimeNeedsReport)
                //     {
                //         Caption = 'HR Overtime Needs Report';
                //         ApplicationArea = Basic, Suite;
                //         RunObject = report "Overtime Needs Request";
                //     }
                //     action(OvertimeClaimReport)
                //     {
                //         Caption = 'HR Overtime Claim Report';
                //         ApplicationArea = Basic, Suite;
                //         RunObject = report "Overtime Claim";
                //     }


                // }
                // group("Loans")
                // {
                //     Caption = 'Loans';
                //     group("Loan Processing")
                //     {

                //         Caption = 'Loan Processing';

                //         action("Loan Application List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             caption = 'Loan Application List All';
                //             RunObject = page "Loan Application List";
                //             RunPageLink = "Source Unit" = CONST("HR LOANS");
                //         }

                //         action("Loan Application List_HR")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             caption = 'Loan Application List(HR Loans)';
                //             RunObject = page "Loan Application List_HR";
                //             RunPageLink = "Sent Back to CRM" = const(false);


                //         }
                //         action("Loan Appraisal List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             caption = 'Loan Appraisal List';

                //             RunObject = page "Appraisal Loans List";
                //             RunPageLink = "Source Unit" = CONST("HR LOANS");
                //         }
                //         action("Loan Approved List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             caption = 'Loan Approved List';
                //             RunObject = page "Approved Loans List";
                //             RunPageLink = "Source Unit" = CONST("HR LOANS");
                //         }
                //         action("Loan Disbursement List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             caption = 'Loan Disbursement List';
                //             RunObject = page "Loan Disbursement List";

                //         }
                //         action("Deferred Loan Application List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             caption = 'Deferred Loans List';
                //             RunObject = page "Deferred Loan Application List";
                //             RunPageLink = "Source Unit" = CONST("HR LOANS");
                //         }
                //         action("Rejected Loan Application List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             caption = 'Rejected Loans List';
                //             RunObject = page "Rejected Loan Application List";
                //             RunPageLink = "Source Unit" = CONST("HR LOANS");
                //         }
                //         action("Returned Loan Application List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             caption = 'Returned Loans Application List';
                //             RunObject = page "Rejected Loan Application List";
                //             RunPageLink = "Source Unit" = CONST("HR LOANS"), "Sent Back to CRM" = const(true);
                //         }


                //     }

                // group("Loan Processed")
                // {

                //     Caption = 'Loan Processed';
                //     action("Loan Posted List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         caption = 'Loan Posted List';
                //         RunObject = page "Loan Posted List";
                //         RunPageLink = "Source Unit" = CONST("HR LOANS");
                //     }
                //     action("Posted Loan Disbursment List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         caption = 'Posted Loan Disbursment List';
                //         RunObject = page "Posted Loan Disbursement List";

                //     }

                // }
                // group("Loan Activity")
                // {


                //     group("Loan rescheduling")
                //     {

                //         action("Open Rescheduling List")
                //         {

                //             ApplicationArea = Basic, Suite;
                //             caption = 'Open Rescheduling List';
                //             RunObject = page "Loan Rescheduling List";
                //             RunPageLink = "Schedule Type" = filter(Reschedule), Status = filter(Open);

                //         }
                //         action("Pending Recheduling")
                //         {

                //             ApplicationArea = all;
                //             Caption = 'Pending Rescheduling List';
                //             RunObject = page "Loan Rescheduling List";
                //             RunPageLink = "Schedule Type" = filter(Reschedule), Status = filter(Pending);
                //         }
                //         action("Approved Reshedulling List")
                //         {
                //             ApplicationArea = all;
                //             Caption = 'Approved Rescheduling List';
                //             RunObject = page "Loan Rescheduling List";
                //             RunPageLink = "Schedule Type" = filter(Reschedule), Status = filter(Approved), Rescheduled = const(false);
                //         }
                //         action("Rescheduled Loans List")
                //         {
                //             ApplicationArea = all;
                //             Caption = 'Rescheduled Loans List';
                //             RunObject = page "Loan Rescheduling List";
                //             RunPageLink = "Schedule Type" = filter(Reschedule), Rescheduled = const(true);
                //         }
                //     }
                //     group("Loan Restructuring")
                //     {
                //         action("Open Loan Restructring List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             caption = 'Open Loan Restructuring List';
                //             RunObject = page "Loan Restructure List";
                //             RunPageLink = "Schedule Type" = filter(Restructure), Status = filter(Open);
                //         }
                //         action("Pending Loan Restructring List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             caption = 'Pending Loan Restructuring List';
                //             RunObject = page "Loan Restructure List";
                //             RunPageLink = "Schedule Type" = filter(Restructure), Status = filter(Pending);
                //         }
                //         action("Approved Loan Restructring List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             caption = 'Approved Loan Restructuring List';
                //             RunObject = page "Loan Restructure List";
                //             RunPageLink = "Schedule Type" = filter(Restructure), Status = filter(Approved);
                //         }
                //         action("Restructured Loan Restructring List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             caption = 'Restructured Loan List';
                //             RunObject = page "Loan Restructure List";
                //             RunPageLink = "Schedule Type" = filter(Restructure), Status = filter(Approved), Rescheduled = const(true);
                //         }
                //     }
                // }


                // group("Security Register")
                // {
                //     Caption = 'Security Register';
                //     action("Collateral Register - List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         caption = 'Open Collateral Register - List';
                //         RunObject = page "HR Collateral List";
                //         //RunPageView = where(Status = const(Open), "Lending Unit" = filter("HR LOANS"));
                //     }
                //     action("Pending Collateralls")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         caption = 'Pending Collateral';
                //         RunObject = page "HR Collateral List";
                //         //RunPageView = where(Status = const(Pending), "Lending Unit" = filter("HR LOANS"));
                //     }
                //     action("Rejected")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         caption = 'Collateral Register - List';
                //         RunObject = page "HR Collateral List";
                //         //RunPageView = where(Status = const(Rejected), "Lending Unit" = filter("HR LOANS"));
                //     }
                //     action("Approved")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         caption = 'Approved Collaterals';
                //         RunObject = page "HR Collateral List";
                //         //RunPageView = where(Status = const(Approved), "Lending Unit" = filter("HR LOANS"));
                //     }
                //     action("Posted Lien")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         caption = 'Posted Lien - List';
                //         RunObject = page "HR Collateral List";
                //         //RunPageView = where("Cash Collateral Posted" = filter(true));
                //     }
                //     action("Blocked Cash Collateral")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Blocked Cash Collateral';
                //         RunObject = Page "One Month Installments";
                //         RunPageLink = Type = CONST(Lien), "Funds Status" = CONST(WithHeld);
                //     }
                //     action("Released Cash Collateral")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Released Cash Collateral';
                //         RunObject = Page "One Month Installments";
                //         RunPageLink = Type = CONST(Lien), "Funds Status" = CONST(Released);
                //     }
                // }
                // group("Security Substitution")
                // {
                //     action("Open Guarantor Substitution")
                //     {

                //         ApplicationArea = Basic, Suite;
                //         caption = 'Open Security Substitution List';
                //         RunObject = page "Guarantor Subsitution List";
                //         RunPageLink = Status = filter(Open), "Sent Back to CRM" = const(false);
                //     }
                //     action("Pending Guarantor Substitution")
                //     {

                //         ApplicationArea = Basic, Suite;
                //         caption = 'Pending Security Substitution List';
                //         RunObject = page "Guarantor Subsitution List";
                //         RunPageLink = Status = filter(Pending), "Sent Back to CRM" = const(false);
                //     }
                //     action("Approved Guarantor Substitution")
                //     {

                //         ApplicationArea = Basic, Suite;
                //         caption = 'Approved Security Substitution List';
                //         RunObject = page "Guarantor Subsitution List";
                //         RunPageLink = Status = filter(Approved), Posted = const(false), "Sent Back to CRM" = const(false);
                //     }
                //     action("Posted Guarantor Substitution")
                //     {

                //         ApplicationArea = Basic, Suite;
                //         caption = 'Posted Security Substitution List';
                //         RunObject = page "Guarantor Subsitution List";
                //         RunPageLink = Status = filter(Approved), Posted = const(true), "Sent Back to CRM" = const(false);
                //     }
                //     action("Deffred Guantor Substitution")
                //     {
                //         ApplicationArea = all;
                //         Caption = 'Deffered Security Substitution';
                //         RunObject = page "Guarantor Subsitution List";
                //         RunPageLink = Status = filter(Deffered), "Sent Back to CRM" = const(false);
                //     }
                //     action("Rejected Guarantor Substitution")
                //     {
                //         ApplicationArea = all;
                //         Caption = 'Rejected Security Substitution';
                //         RunObject = page "Guarantor Subsitution List";
                //         RunPageLink = Status = filter(Rejected), "Sent Back to CRM" = const(false);
                //     }
                //     action("Guarantor Substitution Sent Send Back to CRM")
                //     {
                //         ApplicationArea = all;
                //         Caption = 'Security Substitution Sent Send Back to CRM';
                //         RunObject = page "Guarantor Subsitution List";
                //         RunPageLink = "Sent Back to CRM" = const(true);
                //     }
                // }
                // group("Collateral Collection")
                // {
                //     Caption = 'Collateral Discharge';
                //     action("Open Collateral Collection - List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         caption = 'Open Collateral Discharge - List';
                //         RunObject = page "Collateral Collection - List";
                //         RunPageView = WHERE(Status = filter(Open));
                //     }
                //     action("Pending Collateral Collection - List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         caption = 'Pending Collateral Discharge - List';
                //         RunObject = page "Collateral Collection - List";
                //         RunPageView = where(Status = filter(Pending));
                //     }
                //     action("Rejected Collateral Collection - List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         caption = 'Rejected Collateral Discharge - List';
                //         RunObject = page "Collateral Collection - List";
                //         RunPageView = where(Status = filter(Rejected));
                //     }
                //     action("Approved Collateral Collection - List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         caption = 'Approved Collateral Discharge - List';
                //         RunObject = page "Collateral Collection - List";
                //         RunPageView = WHERE(Status = filter(Approved));
                //     }
                // }

                // group("Security Perfection Tracking")
                // {
                //     action("Securities at Credit")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Securities at Credit';
                //         //RunObject = page "Perfected Securities List";
                //         RunObject = page "Security Perfection List";
                //         RunPageView = where("Perfection Stage" = CONST("At Credit"));
                //     }
                //     action("Securities at Legal")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Securities at Legal';
                //         //RunObject = page "Perfected Securities List";
                //         RunObject = page "Security Perfection List";
                //         RunPageView = where("Perfection Stage" = CONST("At Legal"));
                //     }
                //     action("Securities Pending Instructions")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Securities Pending Instructions';
                //         //RunObject = page "Perfected Securities List";
                //         RunObject = page "Security Perfection List";
                //         RunPageView = where("Perfection Stage" = CONST("At Legal - Pending Instructions to Advocate"));
                //     }
                //     action("Securities Pending Execution")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Securities Pending Execution';
                //         //RunObject = page "Perfected Securities List";
                //         RunObject = page "Security Perfection List";
                //         RunPageView = where("Perfection Stage" = CONST("At Legal - Pending Execution"));
                //     }
                //     action("Securities At Advocate")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Securities At Advocate';
                //         //RunObject = page "Perfected Securities List";
                //         RunObject = page "Security Perfection List";
                //         RunPageView = where("Perfection Stage" = CONST("At Advocate"));
                //     }
                //     action("Securities - Charge Preparation")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Securities - Charge Preparation';
                //         //RunObject = page "Perfected Securities List";
                //         RunObject = page "Security Perfection List";
                //         RunPageView = where("Perfection Stage" = CONST("At Legal - Pending Execution"));
                //     }
                //     action("Securities Pending Registration")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Securities Pending Registration';
                //         //RunObject = page "Perfected Securities List";
                //         RunObject = page "Security Perfection List";
                //         RunPageView = where("Perfection Stage" = CONST("At Advocate Pending Registration"));
                //     }
                //     action("Perfected Securities")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Perfected Securities';
                //         //RunObject = page "Perfected Securities List";
                //         RunObject = page "Security Perfection List";
                //         RunPageView = where("Perfection Stage" = CONST(Registered));
                //     }
                //     action("Discharged Securities")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Discharged Securities';
                //         RunObject = page "Security Perfection List";
                //         RunPageLink = "Perfection Stage" = CONST(Discharged);
                //     }
                // }
                //     group("Monthly Billing")
                //     {
                //         caption = 'Monthly Interest';
                //         action("Interest Due Periods")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Interest Due Periods';
                //             RunObject = page "Interest Due Periods";
                //         }
                //         action("Billing List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Billing List';
                //             RunObject = page "Interest Header List";
                //         }
                //         action("Dailly Bills Buffer List")
                //         {
                //             ApplicationArea = all;
                //             Caption = 'Dailly Bills Buffer List';
                //             RunObject = page "Dailly Interest Buffer";
                //         }
                //     }
                //     group("Loans Calculator")
                //     {
                //         Caption = 'Loans Calculator';

                //         action("Loan Calculator")
                //         {
                //             ApplicationArea = all;
                //             Caption = 'Loan Calculator';
                //             RunObject = page "Loan Calculator";
                //         }
                //     }
                //     group("Loan Report")
                //     {
                //         Caption = 'Loan Report';
                //         action("Member Statement")
                //         {
                //             ApplicationArea = all;
                //             Caption = 'Member Statement';
                //             RunObject = report "Member and loan Statement";
                //         }
                //         action("Collateral Reports")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Collateral Reports';
                //             RunObject = report "Security Report";
                //         }
                //         action("Loans Secured Report")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Loans Secured Report';
                //             RunObject = report "Secured Loans Report";
                //         }
                //         action("Insider Lending Report")
                //         {
                //             ApplicationArea = all;
                //             Caption = 'Insider lending Report';
                //             RunObject = report "Insider Lending Report";
                //         }
                //         action("Sectoral Clasification")
                //         {
                //             ApplicationArea = all;
                //             Caption = 'Sectoral Classification';
                //             RunObject = report "Sectoral Lending";
                //         }
                //         action("Loan Ageing Report")
                //         {
                //             ApplicationArea = all;

                //             RunObject = report "Loan Ageing Report";
                //         }

                //     }
                // }

                // group("DMU Case Forwarding;")
                // {
                //     action("Unforwarded Cases")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         RunObject = page "Unforwarded Cases";
                //     }
                //     action("Forwarded Cases")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         RunObject = page "Forwarded Cases";
                //     }
                //     action("Received Cases")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         RunObject = page "Received Cases";
                //     }
                //     action("Actioned Cases")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         RunObject = page "Actioned Cases";
                //     }
                // }


                // group("Staff Loan")
                // {
                //     Caption = 'Staff Loan';
                //     action(SalaryAdvance)
                //     {
                //         Caption = 'Salary Advance';
                //         ApplicationArea = Basic, Suite;
                //         RunObject = page "prSalary Advance List";
                //     }
                //     action(LnTypeList)
                //     {
                //         Caption = 'Loan Type List';
                //         ApplicationArea = Basic, Suite;
                //         RunObject = page "Loan Type List";
                //     }
                // }
                // group("Staff Welfare List")
                // {
                //     Caption = 'Staff Welfare List';
                //     action("Staff Welfare Lists")
                //     {
                //         Caption = 'Staff Welfare List';
                //         ApplicationArea = Basic, Suite;
                //         RunObject = page "Staff Welfare List";
                //     }
                //     action("Relationship Types")
                //     {
                //         Caption = 'Benefits';
                //         ApplicationArea = Basic, Suite;
                //         RunObject = page "Relationship Types";
                //     }

                //     action("Staff Welfare Report")
                //     {
                //         Caption = 'Staff WelfareClaim Report';
                //         ApplicationArea = Basic, Suite;
                //         RunObject = report "Staff Welfare Claims";
                //     }
                //     action("Staff Welfare Advance Report")
                //     {
                //         Caption = 'Staff Welfare Advance Report';
                //         ApplicationArea = Basic, Suite;
                //         RunObject = page "Welfare Advance List";
                //     }


                // }
                group("HR Exit Interviews")
                {
                    Caption = 'HR Employee Exit';
                    action("HR Employee Exit Interviews")
                    {
                        Caption = 'HR Employee Exit ';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "HR Exit Interview list1";
                    }
                    action("Closed HR Employee Exit ")
                    {

                        ApplicationArea = Basic, Suite;
                        RunObject = page "Closed HR Exit Interview list1";
                    }
                    action("Clearance Form")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Clearance Form List";
                    }
                    action("SeparationTypes")
                    {
                        Caption = 'Separation Types  Report';
                        ApplicationArea = Basic, Suite;
                        RunObject = report SeparationTypes;
                    }
                    action("Exited Employees")
                    {
                        Caption = 'Exited Employees Report';
                        ApplicationArea = Basic, Suite;
                        RunObject = report EmployeesExit;
                    }
                    action("Exited Employees Report")
                    {
                        Caption = 'Exit Report';
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Exit Clearance";
                    }

                    action("Separation Dues")
                    {
                        Caption = 'Separation Dues Report';
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Separation dues";
                    }




                }
                // group("Product Variations")
                // {
                //     action("Open Variations List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Open Variations List';
                //         RunObject = Page "Variations List";
                //         RunPageLink = Status = filter(Open);
                //     }
                //     action("Pending Variations List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Pending Variations List';
                //         RunObject = Page "Variations List";
                //         RunPageLink = Status = filter("Pending Approval");
                //     }
                //     action("Approved Variations List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Approved Variations List';
                //         RunObject = Page "Variations List";
                //         RunPageLink = Status = filter(Approved), posted = const(false);
                //     }
                //     action("Posted Variations List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Posted Variations List';
                //         RunObject = Page "Variations List";
                //         RunPageLink = Status = filter(Approved), posted = const(true);
                //     }

                // }



            }
            group("HR Activities")
            {
                Caption = 'HR Activities';
                group("HR jobs Management")
                {
                    Caption = 'HR jobs Management';
                    // action("HR Establishment")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'HR Establishment';

                    //     RunObject = Page "HR Establishment Card";
                    // }
                    action("HR Jobs")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'HR Jobs List';

                        RunObject = Page "HR Jobs List";
                    }
                    action("HR Job Qualifications")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'HR Job Qualifications';

                        RunObject = Page "HR Job Qualifications";
                    }

                    group(Task)
                    {
                        Caption = 'Tasks';
                        action("HR Job Requirements")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'HR Job Requirements';

                            RunObject = Page "HR Job Requirements";
                        }
                        action("HR Job Responsibilities")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'HR Job Responsibilities';

                            RunObject = Page "HR Job Responsibilities";
                        }
                        group(ReportsandAnalysis)
                        {
                            Caption = 'Reports and Analysis';
                            action("HRJobs")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Variance Report';

                                RunObject = report "HR Jobs";
                            }
                            action("HRJobOccupants")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'HR Job Occupants';

                                RunObject = report "HR Job Occupants";
                            }
                            action(Hrjobsvacantandoccupied)
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Jobs Report';

                                RunObject = report "HR Jobs (Vacant)";
                            }
                            action("HRJobresponsibilities")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'HR Job responsibilities';

                                RunObject = report "HR Job responsibilities";
                            }
                            action("HRJobrequirements")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'HR Job requirements';

                                RunObject = report "HR Job requirements";
                            }
                            action("StaffPosition")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Staff Position Report';

                                RunObject = report "StaffPosition";
                            }

                        }

                    }
                }
                group("HR Professional Bodies")
                {
                    Caption = 'HR Professional Bodies';
                    action("HRProfessional Bodies")
                    {

                        Caption = 'HR Professional Bodies';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "HR Professional Bodies List";
                    }
                }
                // group("HR Company Activities")
                // {
                //     Caption = 'HR Company Activities';
                //     action(CompanyActivitieswelfare)
                //     {
                //         Caption = 'Company Activities/ Welfare';
                //         ApplicationArea = Basic, Suite;
                //         RunObject = page "HR Company Activities List1";
                //     }
                //     group(RepAndAnalys)
                //     {
                //         Caption = 'Reports and Analysis';
                //         action(CompActivitiesWelface)
                //         {
                //             Caption = 'Company Activities/Welfare';
                //             ApplicationArea = Basic, Suite;
                //             RunObject = report "HR Company Activities";
                //         }

                //     }
                //     group(Archv)
                //     {
                //         Caption = 'Archive';
                //         action(CompActivitiwelface)
                //         {
                //             Caption = 'Company Activities/Welfare closed activities';
                //             ApplicationArea = Basic, Suite;
                //             RunObject = page "HR Company Activities List Cl1";
                //         }

                //     }
                // }
                // group("HR Promotion Recommendation")
                // {
                //     Caption = 'HR Promotion Recommendation';
                //     action("HRPromotion Recommendations")
                //     {

                //         Caption = 'HR Promotion Recommendations';
                //         ApplicationArea = Basic, Suite;
                //         RunObject = page "HR Promotion Recommend List";
                //     }
                //     action("Effected Promotion Recommendations")
                //     {

                //         Caption = 'Effected Promotion Recommendations';
                //         ApplicationArea = Basic, Suite;
                //         RunObject = page "HR Promotion RecommendAppList";
                //     }
                // }
                // group("Salary Agreements")
                // {
                //     group(GrpSalary)
                //     {
                //         Caption = 'Salary Agreements';
                //         action("Salary Agreement List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Salary Agreement List';
                //             RunObject = page "Salary Agreement List";
                //         }
                //         action("Approved Salary Agreement List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Approved Salary Agreement List';
                //             RunObject = page "Approved Salary Agreement List";
                //         }
                //         action("Rejected Salary Agreement List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Rejected Salary Agreement List';
                //             RunObject = page "Rejected Salary Agreement List";
                //         }
                //     }
                //     group(SalAgreeRepos)
                //     {
                //         Caption = 'Salary Agreements Reports';
                //         action("Salary Agreement")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Salary Agreement';
                //             RunObject = report "Salary Agreement";
                //         }
                //         action("Salary Agreement Report")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Salary Forms Report';
                //             RunObject = report "Salary Agreement Report";
                //         }
                //         action("Salary Agreement Counter")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Salary Agreement Counter';
                //             RunObject = report "Salary Agreement Counter";
                //         }
                //         action("RSalary Agreement List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Salary Agreement List';
                //             RunObject = report "Salary Agreement List";
                //         }
                //     }

                // }
                // group("File Requests.")
                // {
                //     action("Request File")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Request File';
                //         RunObject = page "File Request List";
                //         RunPageView = where(Status = filter(open));
                //     }
                //     action("File Request")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Files Requested';
                //         RunObject = page "File Request List";
                //         RunPageView = where(Status = filter(requested));
                //     }
                //     action("Closed File Request")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Closed Files Requests.';
                //         RunObject = page "File Request List";
                //         RunPageView = where(Status = filter(closed));
                //     }
                //     action("File List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'File Tracker List';
                //         RunObject = page "File Tracker List";
                //         RunPageView = where(Status = filter(<> archived));
                //     }
                // }
                group("Alerts and Notifications")
                {
                    Caption = 'SMS Alerts';
                    action("SMS Alerts Header")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "SMS Alert Header List";
                    }
                    action("Approved Cases")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Approved SMS Alerts List";
                    }
                    action("Posted Alerts")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Posted SMS Alerts List";
                    }
                }

            }

            // group("User / HR requests")
            // {
            //     Caption = 'User / HR requests';
            // group(group1)
            // {
            //     Caption = 'Leave Application';
            //     group("Leave Management Lists")
            //     {
            //         Caption = 'Lists';
            //         action("HR Leave Applications List")
            //         {
            //             ApplicationArea = Basic, Suite;
            //             Caption = 'HR Leave Applications List';
            //             RunObject = page "HR Leave Applications List1";
            //         }
            //     }
            // group("Arc")
            // {
            //     action("HR Leave Applications")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'HR Leave Applications List';
            //         RunObject = page "HR Leave Applications History1";
            //     }
            // }
            // }
            // group(group2)
            // {
            //     Caption = 'Other Requisitions';
            //     group("Other Requisitions")
            //     {
            //         Caption = 'Lists';


            //     }
            // }


            //     group(group4)
            //     {
            //         Caption = 'Store Requisitions';
            //         group("Lists")
            //         {
            //             Caption = 'Lists';
            //             action("Store Requisition List")
            //             {
            //                 ApplicationArea = Basic, Suite;
            //                 Caption = 'Store Requisition List';
            //                 RunObject = page "Store Requisitions List";
            //             }
            //             action("Cancelled Store Requisitions List")
            //             {
            //                 ApplicationArea = Basic, Suite;
            //                 Caption = 'Cancelled Store Requisitions List';
            //                 RunObject = page "Cancelled Store Req List";
            //             }
            //         }
            //         group(Arkiv)
            //         {
            //             Caption = 'Lists';
            //             action("Store Requisition Released/Pending")
            //             {
            //                 ApplicationArea = Basic, Suite;
            //                 Caption = 'Store Requisition Released/Pending';
            //                 RunObject = page "Store Requisition List";

            //             }
            //         }
            //     }
            // }
            group("HR General Setup")
            {

                Caption = 'HR General Setup';
                action("HR leave Calendar")
                {
                    Caption = 'HR Leave Calendar';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "HR Leave Calendar List";
                }
                action("Hr Leave Periods")
                {
                    Caption = 'HR Leave Periods';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "HR Leave Period List";
                }
                action("HR Lookup Values")
                {
                    Caption = 'HR Lookup Values';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "HR Lookup Values List";
                }
                action("Hr Committees")
                {
                    Caption = 'Hr Committees';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "HR Committees";
                }
                action("Hr Policies")
                {
                    Caption = 'Hr Policies';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "HR Policy List";
                }
                action("Hr E-Mail Parameters")
                {
                    Caption = 'Hr E-Mail Parameters';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "HR E-Mail Parameters List";
                }

                action("HR Setup")
                {
                    Caption = 'HR Setup';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "HR Setup";
                }
                action("HR Notification Log")
                {
                    Caption = 'HR Notification Log';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "HR Notification Log";
                    ToolTip = 'View contract expiry and retirement notification history';
                }
                action("Employee group")
                {
                    Caption = 'Employee Group';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Employee Groups";
                }
                // action("Notifications")
                // {

                //     ApplicationArea = Basic, Suite;
                //     RunObject = page NotificationSetupSms;
                // }
                action("Disciplinary Actions")
                {

                    ApplicationArea = Basic, Suite;
                    RunObject = page "HR Disciplinary Actions1";

                }
                // action("Product Factory")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Product Setups';
                //     RunObject = page "Product Factory List";
                // }



            }
            group(EmployeeSelfService)
            {
                Caption = 'Employee Self Service';
                // group("Employee Fixed Assets")
                // {
                //     action("Employee Fixed Asset Transfer List")
                //     {
                //         ApplicationArea = FixedAssets;
                //         Caption = 'Fixed Assets Transfer List';
                //         RunObject = Page "Asset Transfer List";
                //         ToolTip = 'This module facilitates Transfer of FA location and responsible employee';
                //     }
                //     action("Employee Transferred Fixed Assets")
                //     {
                //         ApplicationArea = FixedAssets;
                //         Caption = 'Transferred Fixed Assets';
                //         RunObject = Page "Asset Transfer List Effected";
                //         ToolTip = 'View the list of fixed assets that have been transferred.';
                //     }
                // }
                // action(StaffWelfare)
                // {
                //     Caption = 'Staff Welfare Claim';
                //     ApplicationArea = Basic, Suite;
                //     RunObject = page "Staff Welfare List";
                // }
                action(LeaveApplication1)
                {
                    Caption = 'Employee Leave Application';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "HR Leave Applications List1";
                }
                // action("Store Requisition")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Store Requisition';
                //     RunObject = Page "Store Requisitions List";


                // }
                // action("Overtime Claim List")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Overtime';
                //     RunObject = page "Overtime Claim List";
                // }
                action("Exit Clearance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Exit Clearance Form';
                    RunObject = page "HR Exit Interview list1";
                }
                action("System Rights Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'System Rights Requisition';
                    RunObject = page "Permission Requisition Card";
                }
                action("Training Application")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Training Application';
                    RunObject = page "HR Training ApplicationList";
                }
                action("Training Need Request")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Training Need Request';
                    RunObject = page "HR Training Need Request List";
                }
                action("Appraisal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Appraisals';
                    RunObject = page "HR 360 Appraisals List - TS1";
                }
                action("My Assigned Targets")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Assigned Targets';
                    RunObject = page "My Assigned Targets";
                }
                group("Self Loan Application")
                {


                    action("New Application")
                    {

                        ApplicationArea = Basic, Suite;
                        Caption = 'Apply Staff Loan';
                        RunObject = page "Self Loan Application List";
                        RunPageLink = "Return To user" = const(false);
                    }
                    action("Resubmission")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Resubmission';
                        RunObject = page "Self Loan Application List";
                        RunPageLink = "Return To user" = const(true);
                    }
                }

                action("Loan Calculators")
                {
                    ApplicationArea = all;
                    Caption = 'Loan Calculator';
                    RunObject = page "Loan Calculator";
                }
                action("Payslip")
                {
                    ApplicationArea = all;
                    Caption = 'Payslip';
                    RunObject = report "Self Service Slip";
                }



            }
            // group("Contract Request")
            // {
            //     Caption = 'Contract Request';
            //     action("Contract Requests")
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'Open Contract Request';
            //         RunObject = Page "Contract Request List";
            //         RunPageLink = Status = CONST(Open);
            //     }
            //     action("Contract Requests Pending Approval")
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'Contract Request - Pending Approval';
            //         RunObject = Page "Contract Request List";
            //         RunPageLink = Status = CONST(Pending);
            //     }
            //     action("Rejected Contract Requests")
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'Rejected Contract Request';
            //         RunObject = Page "Contract Request List";
            //         RunPageLink = Status = CONST(Rejected);
            //     }
            //     action("Approved Contract Requests")
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'Approved Contract Requests';
            //         RunObject = Page "Contract Request List";
            //         RunPageLink = Status = CONST(Approved);
            //     }

            // }
        }

        // area(Embedding)
        // {
        //     action(EmbeddingAction)
        //     {
        //         RunObject = Page ObjectName;
        //     }
        // }
    }


}
profile "AdvancedHumanResources"
{
    Caption = 'Human Resource & Payroll Role Center';
    RoleCenter = "AdvancedHumanResources";
    ProfileDescription = 'HR AND PAYROLL';
}
