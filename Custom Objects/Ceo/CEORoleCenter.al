page 52185743 "CEO Role Center"
{
    Caption = 'CEO Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Headline; CustomHeadline)
            {
                ApplicationArea = Basic, Suite;
            }
            part("CEO Activities"; "CEO Activities")
            {
                Caption = 'Activities';
                ApplicationArea = Basic;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
            part(Emails; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(MyNotes; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(Sections)
        {
            // ==================== PERFORMANCE MANAGEMENT ====================
            group("Performance Management")
            {
                Caption = 'Performance Management';

                group("CEO Goals & Targets")
                {
                    Caption = 'CEO Goals & Targets';

                    action("CEO Goals List")
                    {
                        ApplicationArea = Basic;
                        Caption = 'CEO Goals';
                        RunObject = Page "HR CEO Goals List";
                        ToolTip = 'Create and manage institutional goals to assign to HODs';
                        // Image = TargetSales;
                    }
                    action("CEO Goal HOD Assignments")
                    {
                        ApplicationArea = Basic;
                        Caption = 'HOD Goal Assignments';
                        RunObject = Page "HR CEO Goal HOD Assignments";
                        ToolTip = 'View all goal assignments across all HODs';
                        Image = Allocate;
                    }
                }

                group("Department Targets")
                {
                    Caption = 'Department Targets';

                    action("All Department Targets")
                    {
                        ApplicationArea = Basic;
                        Caption = 'All Department Targets';
                        RunObject = Page "HR Department Targets List";
                        ToolTip = 'View all department targets across all HODs';
                    }
                    action("Employee Target Assignments")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Employee Target Assignments';
                        RunObject = Page "HR Employee Target Assgns List";
                        ToolTip = 'View all employee target assignments';
                    }
                    action("HOD Department Targets")
                    {
                        ApplicationArea = Basic;
                        Caption = 'My Department Targets (HOD)';
                        RunObject = Page "HRHOD Department Targets";
                        ToolTip = 'View targets for my department (if CEO is also an HOD)';
                    }
                }

                group("Appraisals")
                {
                    Caption = 'Appraisals';

                    action("All Individual Appraisals")
                    {
                        ApplicationArea = Basic;
                        Caption = 'All Individual Appraisals';
                        RunObject = Page "HR Individual Appraisals List";
                        ToolTip = 'View all employee appraisals';
                    }
                    action("My Individual Appraisals")
                    {
                        ApplicationArea = Basic;
                        Caption = 'My Appraisals';
                        RunObject = Page "My Individual Appraisals List";
                        ToolTip = 'View my own performance appraisals';
                    }
                    action("My Assigned Targets")
                    {
                        ApplicationArea = Basic;
                        Caption = 'My Assigned Targets';
                        RunObject = Page "My Assigned Targets";
                        ToolTip = 'View targets assigned to me';
                    }
                    action("My Team Appraisals")
                    {
                        ApplicationArea = Basic;
                        Caption = 'My Team Appraisals (Supervisor)';
                        RunObject = Page "Supervisor Appraisals List";
                        ToolTip = 'Review appraisals for employees I supervise';
                    }
                }

                group("Appraisal Setup")
                {
                    Caption = 'Setup';

                    action("Appraisal Period Setup")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Appraisal Period Setup';
                        RunObject = Page "HR Appraisal Period Setup";
                        ToolTip = 'Manage appraisal periods and cycle stages';
                    }
                    action("Heads of Departments")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Heads of Departments';
                        RunObject = Page "HR Head of Departments List";
                        ToolTip = 'Manage HOD assignments';
                    }
                    action("CEO Setup")
                    {
                        ApplicationArea = Basic;
                        Caption = 'CEO Setup';
                        RunObject = Page "HR CEO Setup";
                        Image = Setup;
                        ToolTip = 'Configure the CEO employee record for goal creation';
                    }
                }

                group("Performance Reports")
                {
                    Caption = 'Reports';

                    action("Department Targets Report")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Department Targets Report';
                        RunObject = Report "Department Targets Report";
                    }
                    action("Employee Target Assignment Report")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Employee Target Assignment Report';
                        RunObject = Report "Employee Target Assignment Rpt";
                    }
                    action("Individual Targets Report")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Individual Targets Report';
                        RunObject = Report "Individual Targets Report";
                    }
                    action("Appraisal Summary Report")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Appraisal Summary Report';
                        RunObject = Report "Appraisal Summary Report";
                    }
                    action("Perspective Analysis Report")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Perspective Analysis Report';
                        RunObject = Report "Perspective Analysis Report";
                    }
                    action("Performance Report")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Performance Report';
                        RunObject = Report "Performance";
                    }
                }
            }

            // ==================== HUMAN RESOURCES ====================
            group("Human Resources")
            {
                Caption = 'Human Resources';

                action("Active Employees")
                {
                    ApplicationArea = Basic;
                    Caption = 'Active Employees';
                    RunObject = Page "HR Employee List - Active";
                }
                action("Leave Applications")
                {
                    ApplicationArea = Basic;
                    Caption = 'Leave Applications';
                    RunObject = Page "HR Leave Applications List1";
                }
            }

            // ==================== DEPARTMENT DASHBOARDS ====================
            group("Department Dashboards")
            {
                Caption = 'Department Dashboards';
                Image = Departments;

                action("Human Resources RC")
                {
                    ApplicationArea = All;
                    Caption = 'Human Resources';
                    RunObject = Page 52187320;
                    Image = Employee;
                }
                action("Banking Management RC")
                {
                    ApplicationArea = All;
                    Caption = 'Banking Management';
                    RunObject = Page 52187301;
                    Image = Bank;
                }
                action("Finance RC")
                {
                    ApplicationArea = All;
                    Caption = 'Finance Department';
                    RunObject = Page 52186778;
                    Image = CashReceiptJournal;
                }
                action("Audit RC")
                {
                    ApplicationArea = All;
                    Caption = 'Audit Department';
                    RunObject = Page 52186583;
                    Image = CheckLedger;
                }
                action("DMU RC")
                {
                    ApplicationArea = All;
                    Caption = 'Debt Management Unit';
                    RunObject = Page 52185502;
                    Image = JobLedger;
                }
                action("ICT RC")
                {
                    ApplicationArea = All;
                    Caption = 'ICT Department';
                    RunObject = Page 52185498;
                    Image = Setup;
                }
                action("Procurement RC")
                {
                    ApplicationArea = All;
                    Caption = 'Procurement';
                    RunObject = Page 52187326;
                    Image = Purchasing;
                }
                action("Business Loans RC")
                {
                    ApplicationArea = All;
                    Caption = 'Business Loans';
                    RunObject = Page 52187328;
                    Image = Agreement;
                }
            }

            // ==================== EMPLOYEE SELF SERVICE ====================
            group("Employee Self Service")
            {
                Caption = 'Employee Self Service';

                action("My Leave Application")
                {
                    ApplicationArea = Basic;
                    Caption = 'Leave Application';
                    RunObject = Page "HR Leave Applications List1";
                }
                action("My Payslip")
                {
                    ApplicationArea = All;
                    Caption = 'Payslip';
                    RunObject = Report "Self Service Slip";
                }
            }
        }
    }
}

profile "CEO"
{
    Caption = 'CEO Role Center';
    RoleCenter = "CEO Role Center";
    ProfileDescription = 'CEO Role Center with performance management and executive oversight';
}
