page 52187310 "Payroll processing Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Control76; CustomHeadline)
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control77; "Payroll Activity")
            {
                ApplicationArea = Basic, Suite;
            }

            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }

            part("Emails"; "Email Activities")
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
            group("Payroll Processing")
            {
                Caption = 'Payroll processing';
                action(PRsalaryListAll)
                {
                    Caption = 'PR Salary List (All)';
                    RunObject = Page "PR Salary List (ALL)";
                    ApplicationArea = Basic, Suite;
                }
                action(PRsalaryListCasual)
                {
                    Caption = 'PR Salary List Casual';
                    RunObject = Page "PrSalary List Casual";
                    ApplicationArea = Basic, Suite;
                }
                action("Hr Employees - Active")
                {
                    Caption = 'Hr Employees - Active';
                    //RunObject = Page "HR Employee List - Active";
                    ApplicationArea = Basic, Suite;
                }
                action("Board Pay Card")
                {
                    Caption = 'Board Pay Card';
                    RunObject = Page "prBoard employee list";
                    ApplicationArea = Basic, Suite;
                }
                action("PR Bank Summary")
                {
                    Caption = 'PR Bank Summary';
                    RunObject = Page "PR Bank Summary";
                    ApplicationArea = Basic, Suite;
                }
                group("Reports and Analysis")
                {
                    Caption = 'Reports and Analysis';
                    action("PR NHIF")
                    {
                        Caption = 'PR NHIF report';
                        RunObject = report "pr NHIF";
                        ApplicationArea = Basic, Suite;
                    }
                    action("PR NSSF")
                    {
                        Caption = 'PR NSSF report';
                        RunObject = report prNSSF;
                        ApplicationArea = Basic, Suite;
                    }
                    action(p9)
                    {
                        Caption = 'P9';
                        RunObject = report P9;
                        ApplicationArea = Basic, Suite;
                    }
                    action(P10)
                    {
                        Caption = 'P10';
                        RunObject = report P10;
                        ApplicationArea = Basic, Suite;
                    }
                    action(P10A)
                    {
                        Caption = 'P10A';
                        RunObject = report P10A;
                        ApplicationArea = Basic, Suite;
                    }
                    action("PR Payroll Summary")
                    {
                        Caption = 'PR Payroll Summary';
                        RunObject = report "PR Payroll Summary";
                        ApplicationArea = Basic, Suite;
                    }
                    action("PR Other PR Customers (Listing)")
                    {
                        Caption = 'PR Other PR Customers (Listing)';
                        RunObject = report "PR Other PR Customers (Listin)";
                        ApplicationArea = Basic, Suite;
                    }
                    action("PR BankSummary")
                    {
                        Caption = 'PR Bank summary';
                        RunObject = report "PR Bank Summary";
                        ApplicationArea = Basic, Suite;
                    }
                    action("PR Email Individual payslip")
                    {
                        Caption = 'PR E-Mail Individual Payslip';
                        ApplicationArea = Basic, Suite;
                        RunObject = report "PR E-Mail Individual Payslip";
                    }
                    action("PR NSSF NEW")
                    {
                        Caption = 'PRE NSSF NEW';
                        RunObject = report "PR NSSF NEW";
                        ApplicationArea = Basic, Suite;
                    }

                }
            }
            group(PayrollSetup)
            {
                Caption = 'Payroll Setup';
                action("Employee Posting Groups")
                {
                    Caption = 'Employee Posting Groups';
                    RunObject = page "prEmployee Posting Group";
                    ApplicationArea = Basic, Suite;
                }
                action("Transaction Codes")
                {
                    Caption = 'Employee Posting Groups';
                    RunObject = page "prTransaction Code";
                    ApplicationArea = Basic, Suite;
                }
                action("PR Rates & Ceilings")
                {
                    Caption = 'Rates and Ceilings';
                    RunObject = page "PR Rates & Ceilings";
                    ApplicationArea = Basic, Suite;
                }
                action("PR Bank Accounts")
                {
                    Caption = 'Bank Accounts';
                    RunObject = page "PR Bank Accounts";
                    ApplicationArea = Basic, Suite;
                }
                action("PR Bank Branches")
                {
                    Caption = 'Bank Branches';
                    RunObject = page "PR Bank Branches";
                    ApplicationArea = Basic, Suite;
                }
                action("prP.A.Y.E Setup")
                {
                    Caption = 'prP.A.Y.E Setup';
                    RunObject = page "prP.A.Y.E Setup";
                    ApplicationArea = Basic, Suite;
                }
                action("Salary Grades List")
                {
                    Caption = 'Salary Grades List';
                    RunObject = page "Salary Grades List";
                    ApplicationArea = Basic, Suite;
                }
                action("prNSSF List")
                {
                    Caption = 'prNSSF List';
                    RunObject = page "prNSSF List";
                    ApplicationArea = Basic, Suite;
                }
                action("prNHIF SetUp")
                {
                    Caption = 'prNHIF SetUp';
                    RunObject = page "prNHIF SetUp";
                    ApplicationArea = Basic, Suite;
                }
                action("prBoard Earning")
                {
                    Caption = 'prBoard Earning';
                    RunObject = page "prBoard Earning";
                    ApplicationArea = Basic, Suite;
                }
                action("PrCasual Payroll Setup")
                {
                    Caption = 'PrCasual Payroll Setup';
                    RunObject = page "PrCasual Payroll Setup";
                    ApplicationArea = Basic, Suite;
                }
                action("PR Employee Allowances List")
                {
                    Caption = 'PR Employee Allowances List';
                    RunObject = page "PR Employee Allowances List";
                    ApplicationArea = Basic, Suite;
                }
                action("Status Change Permssion.")
                {
                    Caption = 'Status Change Permssion.';
                    RunObject = page "Status Change Permssion.";
                    ApplicationArea = Basic, Suite;
                }

            }
            group(PeriodicActivities)
            {
                Caption = 'Periodic Activities';
                action("PR Payroll Periods")
                {
                    Caption = 'PR Payroll Periods';
                    RunObject = page "PR Payroll Periods";
                    ApplicationArea = Basic, Suite;
                }
                action("Leave Allowances")
                {
                    Caption = 'Leave Allowances';
                    RunObject = page "Leave Allowances";
                    ApplicationArea = Basic, Suite;
                }
                group(Tasks)
                {
                    Caption = 'Tasks';
                    action("Payroll Salary Process")
                    {
                        Caption = 'Payroll Salary Process';
                        RunObject = page "Payroll Salary Process";
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Reports & Analysis")
                {
                    Caption = 'Reports and Analysis';
                    action("Transfer Net Pay To Fosa")
                    {
                        Caption = 'Transfer Net Pay To Fosa';
                        RunObject = report "Transfer Net Pay To Fosa";
                        ApplicationArea = Basic, Suite;
                    }
                    action("PR Transfer To Journal Bills")
                    {
                        Caption = 'PR Transfer To Journal Bills';
                        RunObject = report "PR Transfer To Journal Bills";
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                group("Ta sks")
                {
                    Caption = 'Tasks';
                    action("Update Payroll Credit Accounts")
                    {
                        Caption = 'Update Payroll Credit Accounts';
                        //RunObject = report "Update Payroll Credit Accounts";
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Rep and Analysis")
                {
                    Caption = 'Reports and Analysis';
                    action("PR E-Mail Individual Payslip")
                    {
                        Caption = 'PR E-Mail Individual Payslip';
                        //RunObject = report "PR E-Mail Individual Payslip";
                        ApplicationArea = Basic, Suite;
                    }

                    action("PRPayroll Summary")
                    {
                        Caption = 'PR Payroll Summary';
                        RunObject = report "PR Payroll Summary";
                        ApplicationArea = Basic, Suite;
                    }
                    action("prPaye Report")
                    {
                        Caption = 'PAYE Schedule';
                        RunObject = report "prPaye Report";
                        ApplicationArea = Basic, Suite;
                    }
                    action("prDeductions Report")
                    {
                        Caption = 'Deductions Report';
                        RunObject = report "prDeductions Report";
                        ApplicationArea = Basic, Suite;
                    }
                    action("prAllowances Report")
                    {
                        Caption = 'prAllowances Report';
                        RunObject = report "prAllowances Report";
                        ApplicationArea = Basic, Suite;
                    }
                    action(prGrossNetPay)
                    {
                        Caption = 'Gross NetPay';
                        ApplicationArea = Basic, Suite;
                        RunObject = report prGrossNetPay;
                    }
                    action("prGrossNetPay FxedTC")
                    {
                        Caption = 'prGrossNetPay FxedTC';
                        RunObject = report "prGrossNetPay FxedTC";
                        ApplicationArea = Basic, Suite;
                    }
                    action("prPayrollSummary-List")
                    {
                        Caption = 'prPayrollSummary-List';
                        RunObject = report "prPayrollSummary-List";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Pension Summary")
                    {
                        Caption = 'Pension Summary';
                        RunObject = report "Pension Summary";
                        ApplicationArea = Basic, Suite;
                    }
                    action("prBank Payments")
                    {
                        Caption = 'prBank Payments';
                        RunObject = report "prBank Payments";
                        ApplicationArea = Basic, Suite;
                    }
                    action("PrAllowances Summary")
                    {
                        Caption = 'PrAllowances Summary';
                        RunObject = report "PrAllowances Summary";
                        ApplicationArea = Basic, Suite;
                    }
                    action(" PrDeductions Summary")
                    {
                        Caption = 'PrDeductions Summary';
                        RunObject = report "PrDeductions Summary";
                        ApplicationArea = Basic, Suite;
                    }
                    action("pr Loans Deductions Report")
                    {
                        Caption = 'pr Loans Deductions Report';
                        RunObject = report "pr Loans Deductions Report";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Helb Report")
                    {
                        Caption = 'Helb Report';
                        RunObject = report "Helb Report";
                        ApplicationArea = Basic, Suite;
                    }
                    action("PR iTax Report")
                    {
                        Caption = 'PR iTax Report';
                        RunObject = report "PR iTax Report";
                        ApplicationArea = Basic, Suite;
                    }
                    action("PR Company Totals")
                    {
                        Caption = 'PR Company Totals';
                        RunObject = report "PR Company Totals";
                        ApplicationArea = Basic, Suite;
                    }
                    action("prP9A-test  new")
                    {
                        Caption = 'prP9A-test  new';
                        //RunObject = report "prP9A-test  new";
                        ApplicationArea = Basic, Suite;
                    }
                    action("PR Company FixedTC Totals")
                    {
                        Caption = 'PR Company FixedTC Totals';
                        //RunObject = report "PR Company FixedTC Totals";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Detailed Payroll Transactions")
                    {
                        Caption = 'Detailed Payroll Transactions';
                        RunObject = report "Detailed Payroll Transactions";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Staff Allowance  P9")
                    {
                        Caption = 'Staff Allowance  P9';
                        //RunObject = report "Staff Allowance  P9";
                        ApplicationArea = Basic, Suite;
                    }
                    action("Overtime Hours Worked1")
                    {
                        Caption = 'Overtime Hours Worked1';
                        RunObject = report "Overtime Hours Worked1";
                        ApplicationArea = Basic, Suite;
                    }
                    group(Admin)
                    {
                        Caption = 'Administration';
                        action("Update Mismatched HR Loans")
                        {
                            Caption = 'Update Mismatched HR Loans';
                            RunObject = report "Update Mismatched HR Loans";
                            ApplicationArea = Basic, Suite;
                        }
                    }
                }
            }
            group(TaxReturns)
            {
                Caption = 'Tax Returns';
                group("Repo and analysis")
                {
                    Caption = 'Reports And analysis';
                    action("P 10A")
                    {
                        Caption = 'P 10A';
                        RunObject = report P10A;
                        ApplicationArea = Basic, Suite;
                    }
                    action("P1 0")
                    {
                        Caption = 'P10';
                        RunObject = report P10;
                        ApplicationArea = Basic, Suite;
                    }
                    action("P 9")
                    {
                        Caption = 'P9';
                        RunObject = report P9;
                        ApplicationArea = Basic, Suite;
                    }
                    action("priTax")
                    {
                        Caption = 'priTax';
                        // RunObject = report priTax;
                        ApplicationArea = Basic, Suite;
                    }

                }
            }


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
profile "Payroll Processor Role Center"
{
    Caption = 'Payroll Processor Role Center';
    RoleCenter = "Payroll processing Role Center";
    ProfileDescription = 'Payroll Processor Role Center';
}