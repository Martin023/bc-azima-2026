page 52185500 "Main Role Center"
{
    Caption = 'Credit Management Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Control76; CustomHeadline)
            {
                ApplicationArea = Basic, Suite;
            }
            part("Loan Processing Activities"; "Loan Processing Activities")
            {
                Caption = 'Activities';
                ApplicationArea = Basic;
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
        area(Sections)
        {
            group(Membership)
            {
                group("Group")
                {
                    Caption = 'Member';
                    group("Normal Member Single Application")
                    {

                        Caption = 'Normal Member Single Application';
                        action("Open Member Application List")

                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open Member Application List';
                            RunObject = Page "Open Member Application List";

                        }
                        action("Pending Member Application List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Pending Member Application List';
                            RunObject = Page "Pending Member Application";
                        }
                        action("Approved Member Application List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved Member Application List';
                            RunObject = Page "Approved Member Application";
                        }
                        action("Rejected Member Application")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Rejected Member Application List';
                            RunObject = Page "Rejected Member Application";
                        }
                    }

                    group("Virtual Member Single Application")
                    {
                        Caption = 'Virtual Member Single Application';
                        action("Open Member Application List V")

                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open Member Application List Virtual';
                            RunObject = Page "Open Member Application V";
                        }
                        action("Pending Member Application List V")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Pending Member Application List';
                            RunObject = Page "Pending Member Application V";
                        }
                        action("Approved Member Application List V")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved Member Application List';
                            RunObject = Page "Approved Member Application V";
                        }
                        action("Rejected Member Application V")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Rejected Member Application List';
                            RunObject = Page "Rejected Member Application V";
                        }

                    }

                    group("Member Group Application")
                    {

                        Caption = 'Member Group Application';
                        action("Member Group Application List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Member Group Application List';
                            RunObject = Page "Member Application Group List";
                        }
                    }
                    group("Micro Member Application")
                    {
                        Caption = 'Micro Member Application';
                        action("Micro Member Application List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Micro Member Application List';
                            RunObject = Page "Micro Member Application List";
                        }
                    }
                    group("Membership Reports")
                    {
                        Caption = 'Reports';
                        group("Membership Reports and Analysis")
                        {
                            Caption = 'Reports and Analysis';
                            action("PostBatches2")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Post Batches2';
                                RunObject = report PostBatches2;
                            }
                            // action("PostBatches") //Missing Report
                            // {
                            //     ApplicationArea = Basic, Suite;
                            //     Caption = 'Post Batches';
                            //     RunObject = report PostBatches;
                            // }
                        }


                    }
                }
                group("Agents")
                {
                    Caption = 'Agents';
                    // action("Agent Membership Applic. List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Agent Membership Applic. List';
                    //     RunObject = page "Agent Membership Applic. List";

                    // }
                    action("Dimension Value")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Dimension Value List';
                        RunObject = page "Dimension Value List";

                    }
                }
                group("Saving Account")
                {
                    Caption = 'Saving Account Application';
                    action("Saving Accounts")
                    {
                        ApplicationArea = All;
                        Caption = 'Savings Account Application';
                        RunObject = page "Savings Account Application";

                    }
                }

                group("Membership Set Ups")
                {
                    Caption = 'Membership Setups';
                    action("Present Users")
                    {
                        ApplicationArea = All;
                        Caption = 'Present Users Setups';
                        RunObject = page "Present Users";

                    }
                    action("User Tasks")
                    {
                        ApplicationArea = All;
                        Caption = 'User Tasks';
                        RunObject = page "User Tasks";

                    }
                }
            }
            group("Credit Management")
            {
                group("Member")
                {
                    Caption = 'Member';

                    action("Member Single List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member Single';
                        RunObject = Page "Member Single List";
                    }
                    action("Member Group List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member Groups';
                        RunObject = Page "Member Group List";
                    }
                    action("Savings Accounts")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Savings Accounts';
                        RunObject = page "Savings Accounts";
                    }
                    action("Credit Accounts List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Credit Accounts';
                        RunObject = Page "Credit Accounts List";
                    }
                    group("File Movement")
                    {
                        group(group1)
                        {
                            Caption = 'File Tracker';

                            action("File Tracker List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'File Tracker List';
                                RunObject = page "File Tracker List";
                            }
                            action("File Stages List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'File Stages List';
                                RunObject = page "File Stages List";
                            }
                        }
                        group(group2)
                        {
                            Caption = 'File Movt Setups';

                            action("File Station List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'File Station List';
                                RunObject = page "File Station List";
                            }
                            action("User Station List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'User Station List';
                                RunObject = page "User Station List";
                            }
                            action("File MVT Remarks List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'File MVT Remarks List';
                                RunObject = page "File MVT Remarks";
                            }
                        }
                    }
                }
                group("Loans")
                {
                    Caption = 'Loans';

                    group("Loan Processing")
                    {
                        Caption = 'Loan Processing';

                        action("Loan Application List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Loan Application List';
                            RunObject = page "Loan Application List";
                        }
                        action("Loan Appraisal List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Loan Appraisal List';
                            RunObject = page "Appraisal Loans List";
                        }
                        action("Loan Approved List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Loan Approved List';
                            RunObject = page "Approved Loans List";
                        }
                        action("Loan Disbursement List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Loan Disbursement List';
                            RunObject = page "Loan Disbursement List";
                        }
                        action("Deferred Loan Application List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Deferred Loan Application List';
                            RunObject = page "Deferred Loan Application List";
                        }
                        action("Rejected Loan Application List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Rejected Loan Application List';
                            RunObject = page "Rejected Loan Application List";
                        }
                    }
                    group("Loan Processed")
                    {
                        Caption = 'Loan Processed';

                        action("Loan Posted List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Loan Posted List';
                            RunObject = page "Loan Posted List";
                        }
                        action("Posted Loan Disbursment List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Posted Loan Disbursment List';
                            RunObject = page "Posted Loan Disbursement List";
                        }
                    }
                    group("Loan Security")
                    {
                        Caption = 'Loan Security';

                        action("Collateral Register - List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Collateral Register - List';
                            RunObject = page "Collateral Register - List";
                        }
                        action("Collateral Collection - List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Collateral Collection - List';
                            RunObject = page "Collateral Collection - List";
                        }
                    }
                }
                group("Periodic Activities")
                {
                    Caption = 'Periodic Activities';

                    group("Monthly Billing")
                    {
                        caption = 'Monthly Billing';

                        action("Interest Due Periods")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Interest Due Periods';
                            RunObject = page "Interest Due Periods";
                        }
                        action("Billing List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Billing List';
                            RunObject = page "Interest Header List";
                        }
                    }
                    group("Check Off")
                    {
                        caption = 'Check Off';

                        group("Check Off Advise")
                        {
                            caption = 'Check Off Advise';

                            action("Check Off Advice")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Check Off Advice';
                                RunObject = page "Checkoff Advice Header List";
                            }
                        }
                        group("Check Off Posting")
                        {
                            caption = 'Check Off Posting';

                            action("Check Off Buffer")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Checkoff Buffer';
                                RunObject = page "Checkoff Buffer";
                            }
                            action("Check Off List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Check Off List';
                                RunObject = page "Checkoff Header List";
                            }
                            action("View Checkoff Lines II")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'View Checkoff Lines';
                                RunObject = page "View Checkoff Lines";
                            }
                        }
                    }
                    group("Loan Activity")
                    {
                        Caption = 'Loan Activity';

                        action("Loan Rescheduling List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Loan Rescheduling List';
                            RunObject = page "Loan Rescheduling List";
                        }
                        action("Guarantor Substitution List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Guarantor Substitution List';
                            RunObject = page "Guarantor Subsitution List";
                        }
                        action("Loan Recovery Header List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Loan Recovery Header List';
                            RunObject = page "Recovery & Attachment List";
                        }
                        action("Posted Loan Recovery Header")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Posted Loan Recovery Header';
                            RunObject = page "Posted Loan Recovery Header";
                        }
                        action("Loan Recovery Header(Modified)")
                        {
                            applicationarea = basic, suite;
                            caption = 'Loan Recovery Header(Modified)';
                            runobject = page "Loan Recovery Header(Modified)";
                        }
                    }
                    group("Loan Categorization")
                    {
                        caption = 'Loan Categorization';

                        action("SASRA Loan Categorization.")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'SASRA Loan Categorization';
                            RunObject = report "SASRA Loan Categorization";
                        }
                    }
                    group("Member Activity")
                    {
                        Caption = 'Member Activity';

                        group("Member Withdrawal Notice")
                        {
                            Caption = 'Member Withdrawal Notice';

                            action("Open Withdrawal Notice")
                            {
                                ApplicationArea = Basic, Suite;
                                caption = 'Open Withdrawal Notice';
                                RunObject = page "Open Withdrawal Notice";
                            }
                            action("Pending Withdrawal Notice")
                            {
                                ApplicationArea = Basic, Suite;
                                caption = 'Pending Withdrawal Notice';
                                RunObject = page "Pending Withdrawal Notice";
                            }
                            action("Approved Withdrawal Notice")
                            {
                                ApplicationArea = Basic, Suite;
                                caption = 'Approved Withdrawal Notice';
                                RunObject = page "Approved Withdrawal Notice";
                            }
                            action("Rejected Withdrawal Notice")
                            {
                                ApplicationArea = Basic, Suite;
                                caption = 'Rejected Withdrawal Notice';
                                RunObject = page "Rejected Withdrawal Notice";
                            }
                        }
                        group("Member CLosure")
                        {
                            Caption = 'Member Closure';

                            action("Open Closure List")
                            {
                                ApplicationArea = Basic, Suite;
                                caption = 'Open Closure List';
                                RunObject = page "Open Closure List";
                            }
                            action("Pending Closure List")
                            {
                                ApplicationArea = Basic, Suite;
                                caption = 'Pending Closure List';
                                RunObject = page "Pending Closure List";
                            }
                            action("Approved Closure List")
                            {
                                ApplicationArea = Basic, Suite;
                                caption = 'Approved Closure List';
                                RunObject = page "Approved Closure List";
                            }
                            action("Rejected Closure List")
                            {
                                ApplicationArea = Basic, Suite;
                                caption = 'Rejected Closure List';
                                RunObject = page "Rejected Closure List";
                            }
                        }
                        group("Member Securities")
                        {
                            Caption = 'Member Securities';

                            action("Member Changes")
                            {
                                ApplicationArea = Basic, Suite;
                                caption = 'Member Changes';
                                RunObject = page "Dependancies Applications List";
                            }
                            // action("+Member Changes")
                            // {
                            //     ApplicationArea = Basic, Suite;
                            //     caption = 'Posted Member Changes';
                            //     RunObject = page "+ Member Change List";
                            // }
                        }
                    }
                    group("Loan - CRB")
                    {
                        Caption = 'Loan - CRB';

                        action("CRB Data")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'CRB Data';
                            RunObject = page "CRB Data";
                        }
                        action("Loans CRB")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loans CRB';
                            RunObject = xmlport "Loans CRB";
                        }
                        action("Loans Guarantors")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loans Guarantors';
                            RunObject = XMLPort "Loans Gurarantors- CRB";
                        }
                    }
                    group("CRM Applications")
                    {
                        Caption = 'CRM Applications';

                        action("CRM Application List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'CRM Application List';
                            RunObject = page "CRM Application List";
                        }
                    }
                    group("Dividend Process")
                    {
                        caption = 'Dividend Process';

                        action("Dividend Progression")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Dividend Progression';
                            RunObject = page "Dividend Progression";
                        }
                        action("Diviend Posting Buffer")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Diviend Posting Buffer';
                            RunObject = page "Dividend Posting Buffer";
                        }
                    }
                }
                group("Loan Calculator")
                {
                    Caption = 'Loan Calculator';

                    action("Loan Calculator II")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Calculator';
                        RunObject = page "Loan Application Card Dummy";
                    }
                }
                group("Reports")
                {
                    Caption = 'Reports';

                    group("Members Report")
                    {
                        Caption = 'Member';

                        action("Application")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Member Application Register';
                            RunObject = report "Member Application Register";
                        }
                        action("Member Register")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Member Register';
                            RunObject = report "Member Register";
                        }
                        action("Members Age")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Members Age';
                            RunObject = report "Members Age";
                        }
                        // action("Spouse Details")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Spouse Details';
                        //     RunObject = report "Spouse Details";
                        // }
                        action("Member Details Check Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Member Details Check Report';
                            RunObject = report "Member Details Check Report";
                        }
                        action("Members Summary Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Member Summary Report';
                            RunObject = report "Members Summary Report";
                        }
                        action("Members Without Beneficiary")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Members Without Beneficiary';
                            RunObject = report "Member W/T Beneficiary";
                        }
                        action("Members Without NOK/Beneficiary")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Members Without NOK/Beneficiary';
                            RunObject = report "Member W/T KIN";
                        }
                        action("NOK With Principle Mem ID No.")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'NOK With Principle Mem ID No';
                            RunObject = report "NOK With Principle Mem ID No.";
                        }
                        action("Member Portfolio Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Member Portfolio Report';
                            RunObject = report "Member Portfolio";
                        }
                        action("Dormant Savings Accounts")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Dormant Savings Accounts';
                            RunObject = report "Dormant Savings Accounts";
                        }
                        action("Activate Savings Accounts")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Activate Savings Accounts';
                            RunObject = report "Activate Savings Accounts";
                        }
                        action("E-Mail Member Statement")
                        {
                            ApplicationArea = "Basic, Suite";
                            Caption = 'E-Mail Member Statement';
                            //RunObject = report "E-Mail Member Statement";
                        }
                        action("Import Emails Update")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Import Emails Update';
                            RunObject = xmlport "Import Emails Update";
                        }
                        // action("Withdrawal Notices")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Withdrawal Notices';
                        //     RunObject = report "Withdrawal Notices";
                        // }
                        action("Withdrawal Notice Maturity")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Withdrawal Notice Maturity';
                            RunObject = report "Member Withdrawal Notice";
                        }
                        action("Member Closure Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Member Closure Report';
                            RunObject = report "Membership Closure Report";
                        }
                    }
                    group("Loans Report")
                    {
                        Caption = 'Loans';

                        action("Loans Interest Register")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loans Registered Filtered';
                            RunObject = report "Loan Interest  Register";
                        }
                        action("Loan Register ")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loans Register';
                            RunObject = report "Loan Register";
                        }

                        action("Loan Approved Schedule")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loan Approved Schedule';
                            RunObject = report "Loan Approved Schedule";
                        }
                        action("Loan Guarantors Reports")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loan Guarantors Report';
                            RunObject = report "Loan Guarators Reports";
                        }
                        action("Loan Guaranteed")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loan Guaranteed';
                            RunObject = report "Loan Guaranteed";
                        }
                        action("Loans Cleared Early")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loans Cleared Early';
                            RunObject = report "Loans Cleared Early";
                        }
                        action("Loan Repayment Dues")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loan Repayment Dues';
                            RunObject = report "Loan Repayment Dues";
                        }
                        action("Loan Bills")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loan Bills';
                            RunObject = report "Loan Bills";
                        }
                        action("SASRA Loan Categorization")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'SASRA Loan Categorization';
                            RunObject = report "SASRA Loan Categorization";
                        }
                        action("Loans Defaulter Aging - SASRA")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loans Defaulter Aging - SASRA';
                            RunObject = report "Loans Defaulter Aging - SASRA";
                        }

                        action("SASRA Deposit Return")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'SASRA Deposit Return';
                            RunObject = report "SASRA Deposit Return";
                        }
                        action("Loan Provisioning Summary")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loan Provisioning Summary';
                            // RunObject = report "Loans Provisioning Summary";
                            RunObject = report "Risk Provisioning";
                        }

                        action("Loan Product Summaries")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loan Product Summaries';
                            RunObject = report "Loan Product Summaries";
                        }
                        action("Savings & Loans Listings")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Savings & Loans Listings';
                            RunObject = report "Savings & Loans Listings";
                        }
                        action("Loans Datasheet Employer")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loans Datasheet Employer';
                            RunObject = report "Loans Datasheet Employer";
                        }
                        action("Savings Datasheet Employer")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Savings Datasheet Employer';
                            RunObject = report "Savings Datasheet Employer";
                        }
                        action("Loan Registered By Category")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loan Registered By Category';
                            RunObject = report "Premier Loan Report";
                        }
                        action("Loans issued Summary")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loan Issued Summary';
                            RunObject = report "Loan Issued Summary";
                        }

                        action("Position on Borrowers in Sacco")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Position on Borrowers in Sacco';
                            RunObject = report "Position on Borrowers in Sacco";
                        }
                        action("JV Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'JV Report';
                            RunObject = report "JV Report";
                        }
                        action("Delegate Loans Register")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Delegate Loans Register';
                            RunObject = report "Delegate Loans Register";
                        }
                        action("Delegate Loans Register New")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Delegate Loans Register New';
                            RunObject = report "Delegates Loan Register New";
                        }
                        action("Loan Repayment Dues Summaries")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loan Repayment Dues Summaries';
                            RunObject = report "Loan Repayment Dues Summaries";
                        }
                        action("Montlhy Bill Summary")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Montlhy Bill Summary';
                            RunObject = report "Monthly Bill Summary";
                        }
                        action("Loans Movement Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loans Movement Report';
                            RunObject = report "Loans Movement Report";
                        }
                        action("Loans Attached")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loans Attached';
                            RunObject = report "Loan Attachment";
                        }
                        action("Tenor Loan Register")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Tenor Loan Register';
                            RunObject = report "Tenor Loan Register";
                        }
                        action("Asset Finance Loans")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Asset Finance Loans';
                            RunObject = report "Asset Finance Loans";
                        }
                        action("Summary Unallocated A/C")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Summary Unallocated A/C';
                            RunObject = report "Summary Unlocated A/C";
                        }
                        action("Batch Loan Register")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Batch Loan Register';
                            RunObject = report "Batch Loan Register";
                        }
                        action("Sectoral Classification")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Sectoral Classification';
                            RunObject = report "Sectoral Classification";
                        }
                        action("Member Guarantors Report")
                        {
                            ApplicationArea = "Basic, Suite";
                            Caption = 'Member Guarantors Report';
                            RunObject = report "Member Guarantors Report";
                        }
                        // action("Loan Defaulted SMS Report")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Loan Defaulted SMS Report';
                        //     RunObject = report "Loan Defaulted SMS Report";
                        // }
                        action("Loan Movement Summary")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loan Movement Summary';
                            RunObject = report "Loan Movement Summary";
                        }
                        action("Loan Movement Report II")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loan Movement Report II';
                            RunObject = report "Loans Movement Report II";
                        }
                        action("Direct Debit Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Direct Debit Report';
                            RunObject = report "Direct Debit Report";
                        }
                        action("Release Guarantor")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Release Guarantor';
                            RunObject = report "Release Guarantor";
                        }
                        action("Update Loan Installments")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Update Loan Installments';
                            RunObject = report "Update Loan Instalments";
                        }
                        // action("Post Lien")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     caption = 'Post Lien';
                        //     RunObject = report "Post Lien";
                        // }
                        action("Generate CRB Data")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Generate CRB Data';
                            RunObject = report "Generate CRB Data";
                        }

                    }
                    group("Periodic Activitites Reports")
                    {
                        Caption = 'Periodic Activities';

                        group("Dividend")
                        {
                            action("Dividend Register")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Dividend Register';
                                RunObject = report "Dividend Register";
                            }
                            action("Dividend Generation")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Dividend Generation';
                                RunObject = report "Dividend Generation";
                            }
                            action("Dividend Posting Buffer")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Dividend Posting Buffer';
                                RunObject = report "Dividend Posting Buffer";
                            }
                            action("Dividend Posting")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Dividend Posting';
                                RunObject = report "Dividend Posting";
                            }
                            action("Dividend Register II")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Dividend Register';
                                RunObject = report "Dividend Register";
                            }
                            action("Dividend Register Summary")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Dividend Register Summary';
                                RunObject = report "Dividend Register Summary";
                            }
                            action("Dividend Statement")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Dividend Statement';
                                RunObject = report "Dividend Statement";
                            }
                            action("Dividend Register Filtered")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Dividend Register Filltered';
                                RunObject = report "Dividend Register Filtered";
                            }


                        }
                        group("Monthly Billings")
                        {
                            Caption = 'Monthly Billing';

                            action("Charge Monthly Fee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Charge Monthly Fee';
                                RunObject = report "Charge Monthly Fee";
                            }
                            action("Montlhly Bill Summary")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Montlhly Bill Summary';
                                RunObject = report "Monthly Bill Summary";
                            }
                        }
                        group("CheckOff Reports")
                        {
                            caption = 'CheckOff Reports';

                            action("CheckOff Summary")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'CheckOff Summary';
                                RunObject = report "CheckOff Summary";
                            }
                            action("CheckOff Summary Monthly")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'CheckOff Summary Monthly';
                                RunObject = report "CheckOff Summary Monthly";
                            }
                            action("CheckOff Summary II")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'CheckOff Summary';
                                RunObject = report "CheckOff Summary II";
                            }
                            action("Non Salaried Loan Granted")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Non Salaried Loan Granted';
                                RunObject = report "Non Salaried Loans Granted";
                            }
                            action("CheckOff Remmittance")
                            {
                                applicationarea = basic, suite;
                                caption = 'CheckOff Remmittance';
                                runobject = report "Membership Declaration";
                            }
                        }
                        group("Marketing Reports")
                        {
                            Caption = 'Marketing';

                            // action("Process BDE Payments II")
                            // {
                            //     ApplicationArea = Basic, Suite;
                            //     Caption = 'Process BDE Payments';
                            //     RunObject = report "Process BDE Payments";
                            // }
                            
                        }
                    }
                    group("Defaulters Management")
                    {
                        Caption = 'Defaulters Management';

                        action("Defaulter Notice-First")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Defaulter Notice-First';
                            RunObject = report "Defaulter Notice-1";
                        }
                        action("Defaulter Notice-Second")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Defaulter Notice-Second';
                            RunObject = report "Defaulter Notice-2";
                        }
                        action("Defaulter Notice-Final")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Defaulter Notice-Final';
                            RunObject = report "Defaulter Notice-3";
                        }
                    }
                    group("Sasra")
                    {
                        Caption = 'Sasra';

                        //Entirely Missing Page
                        // action("Export Checkoff Lines")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Export Checkoff Lines';
                        //     RunObject = page "Export Checkoff Lines";
                        // }
                        action("User Groups and Permission Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'User Groups and Permission Report';
                            RunObject = report "User Groups Permision Report";
                        }
                        action("Sasra Staff Access Granted")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Sasra Staff Access Granted';
                            RunObject = report "Sasra Staff Access Granted";
                        }

                        action("Sasra Staff Positions")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Sasra Staff Positions';
                            RunObject = report "Sasra Staff Positions";
                        }
                        action("Sasra Loan Register")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Sasra Loan Register';
                            RunObject = report "Sasra Loan Register";
                        }
                        action("Sasra Deposit Accounts BOSA")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Sasra Deposit Accounts BOSA';
                            RunObject = report "Sasra Deposit Accounts BOSA";
                        }
                        action("Sasra Deposit Accounts Others")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Sasra Deposit Accounts Others';
                            RunObject = report "Sasra Deposit Accounts Others";
                        }
                        action("Unpaid Deposits Claims")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Unpaid Deposits Claims';
                            RunObject = report "Unpaid Deposits Claims";
                        }
                        // action("ATM Link Report")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'ATM Link Report';
                        //     RunObject = report "ATM Link Report";
                        // } //MOved to Banking
                        // action("M-Sacco Application Report")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'M-Sacco Application Report';
                        //     RunObject = report "M-Sacco Application Report";
                        // } MOved to other operations
                        // action("Posted Salaries Report")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Posted Salaries Report';
                        //     RunObject = report "Posted Salaries Report";
                        // } Moved to Payroll RC
                        // action("Posted Checkoff Receipts")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Posted Checkoff Receipts';
                        //     RunObject = report "Posted Checkoff Receipts";
                        // }
                        action("Anti-Money Laundering Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Anti-Money Laundering Report';
                            RunObject = report "Anti-Money Laundering Report";
                        }

                    }
                }
                group("Credit Management Setups")
                {
                    Caption = 'Setup';

                    group("General")
                    {
                        caption = 'General';

                        action("No. Setup")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Credit No. Setup';
                            RunObject = page "Member Nos. Series";
                        }
                        action("Member Segement/County/Dividend")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Member Segement/County/Dividend';
                            RunObject = page "Segment/County/Dividend/Signat";
                        }
                        action("Member Category")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Member Category';
                            RunObject = page "Member Clasess";
                        }
                        action("Bank Code Structure")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Bank Code Structure';
                            RunObject = page "Bank Code Structure";
                        }
                        action("Application Document")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Application Document';
                            RunObject = page "Application Documents";
                        }
                        action("Electoral Zones/Area Svr Center")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Eletoral Zones/Area Svr Center';
                            RunObject = page "Electrol Zones/Area Svr Center";
                        }
                        action("Salutation Tittles")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Salutation Tittles';
                            RunObject = page "Salutation Tittles";
                        }
                        action("Rejection Reasons")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Rejection Reasons';
                            RunObject = page "Exceptions/ Rejection Reason";
                        }
                    }
                    group("Credit Mngt.")
                    {
                        caption = 'Credit Mngt.';

                        action("Product Factory")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Product Setups';
                            RunObject = page "Product Factory List";
                        }
                        /*
                    action("Product Factory Appl. List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Product Factory Application';
                        RunObject = page "Product Factory Appl. List";
                    }
                    */
                        action("Appraisal Salary ")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Appraisal Salary Set-up';
                            RunObject = page "Appraisal Salary Set-up";
                        }
                        action("Loan Securities Set-up")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loan Securities Set-up';
                            RunObject = page "Loan Securities Set-up";
                        }
                        action("Loan Purpose")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loan Purpose';
                            RunObject = page "Loan Purpose";
                        }
                        action("Financial Appraisal")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Financilal Appraisal';
                            RunObject = page "Financilal Appraisal";
                        }
                        action("Tired Charges")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Tiered Charges List';
                            RunObject = page "Tiered Charges List";
                        }
                    }
                    group("Dividend Setup II")
                    {
                        caption = 'Dividend Setup';

                        action("Dividend Setup")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Dividend Setup';
                            RunObject = page "Dividend Setup";
                        }
                        action("Dividend Simulation Header")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Dividend Simulation Header';
                            RunObject = page "Dividend Simulation Header";
                        }
                    }
                    group("SMS")
                    {
                        caption = 'SMS';

                        action("SMS Setup")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'SMS Setup';
                            RunObject = page "SMS Setup";
                        }
                        action("SMS Codes")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'SMS Codes';
                            RunObject = page "SMS Codes";
                        }
                        action("SMS Subscription List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'SMS Subscription List';
                            RunObject = page "SMS Subscription List";
                        }
                    }
                }
            }
            group("Treasury")
            {
                group("Treasury and Cashier Transactions")
                {
                    Caption = 'Treasury and Cashier Transactions';
                    group("Treasury and Cashier Transactions List")
                    {
                        caption = 'Treasury and Cashier Transactions';
                        action("Treasury Transactions")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Treasury Transactions';
                            RunObject = page "Treasury Cashier List";
                        }
                        action("T Cashier Transactions")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cashier Transactions';
                            runobject = page "Cashier Transactions List";
                        }

                        action("T Cashier Transactions Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cashier Transactions Report';
                            RunObject = report "Cashier Transactions";
                        }

                    }
                    group("Treasury Management")
                    {
                        Caption = 'Treasury Management';
                        group("T Accounts")
                        {
                            caption = 'Accounts';
                            action("Main Treasury")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Main Treasury';
                                RunObject = page "Main Treasury List";
                            }
                            action("Branch Treasury")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Branch Treasury';
                                runobject = page "Branch Treasury List";
                            }

                        }
                    }
                }
                group("Investment")
                {
                    Caption = 'Investment';
                    group("Money Market")
                    {
                        caption = 'Money Market';
                        action("Investments")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Investments';
                            RunObject = page "Investment List";
                        }
                    }

                }
                group("T Payments")
                {
                    Caption = 'Payment Vouchers List';
                    action("Payment Vouchers List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Vouchers List';
                        RunObject = page "Payment Vouchers List";
                    }
                    action("Petty Cash Vouchers List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Petty Cash Vouchers List';
                        RunObject = page "Petty Cash Vouchers List";
                    }
                }
                group("Cash Flow")
                {
                    Caption = 'Cash Flow';
                    group("Lits")
                    {
                        caption = 'Cash Flow';
                        action("Cash Flow Forecasts")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cash Flow Forecasts';
                            RunObject = page "Cash Flow Forecast List";
                        }
                        action("Chart of Cash Flow Accounts")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Chart of Cash Flow Accounts';
                            RunObject = page "Chart of Cash Flow Accounts";
                        }
                        action("Cash Flow Manual Revenues")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cash Flow Manual Revenues';
                            RunObject = page "Cash Flow Manual Revenues";
                        }
                        action("Cash Flow Manual Expenses")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cash Flow Manual Expenses';
                            RunObject = page "Cash Flow Manual Expenses";
                        }
                    }
                    group("T Tasks")
                    {
                        caption = 'Tasks';
                        action("Cash Flow Worksheet")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cash Flow Worksheet';
                            RunObject = page "Cash Flow Worksheet";
                        }

                    }
                    group("T History")
                    {
                        Caption = 'History';
                        action("Navigate")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Navigate';
                            RunObject = page "Navigate";
                        }
                    }
                    group("T Reports and Analysis")
                    {
                        caption = 'Reports and Analysis';
                        group("Analysis and Reporting")
                        {
                            Caption = 'Analysis and Reporting';
                            action("Account Schedules")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Account Schedules';
                                RunObject = page "Account Schedule Names";
                            }
                            action("Analysis by Dimension")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Analysis by Dimension';
                                RunObject = page "Analysis View List";
                            }
                        }
                    }
                    group("T Reports")
                    {
                        Caption = 'Reports';
                        action("Account Schedule")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Account Schedule';
                            RunObject = report "Account Schedule";
                        }
                        action("Cash Flow Date List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cash Flow Date List';
                            RunObject = report "Cash Flow Date List";
                        }
                        action("Dimensions - Total")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Dimensions - Total';
                            RunObject = report "Dimensions - Total";
                        }
                        action("Cash Flow Dimensions - Detail")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cash Flow Dimensions - Detail';
                            RunObject = report "Cash Flow Dimensions - Detail";
                        }
                    }

                    group("T Archive")
                    {
                        Caption = 'Archive';
                        group("Cashflow History")
                        {
                            Caption = 'History';
                            action("Cash Flow Ledger Entries")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Cash Flow Ledger Entries';
                                RunObject = page "Cash Flow Forecast Entries";
                            }
                        }

                    }
                    group("Administration")
                    {
                        Caption = 'Administration';
                        action("Cash Flow Setup")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cash Flow Setup';
                            RunObject = page "Cash Flow Setup";
                        }
                        action("Cash Flow Report Selectons")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cash Flow Report Selectons';
                            RunObject = page "Report Selection - Cash Flow";
                        }
                    }
                }

                group("Setup")
                {
                    Caption = 'Setup';
                    group("Investemt Setup")
                    {
                        Caption = 'Investement';
                        action("Investement")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Investement';
                            RunObject = page "Investment Type";
                        }
                    }

                }
            }
            group("Banking Management")
            {
                group("Accounts")
                {
                    Caption = 'Accounts';
                    action("B Savings Accounts")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Savings Accounts List';
                        RunObject = page "Savings Accounts";
                        ;
                    }
                    action("Banking Closure List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Banking Closure List';
                        RunObject = page "Banking Closure List";
                    }

                }
                group("Banking Operations")
                {
                    Caption = 'Banking Operations';
                    group("Cashier")
                    {
                        Caption = 'Cashier';
                        action("Cashier Transactions")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cashier Transactions';
                            RunObject = page "Cashier Transactions List";
                        }
                        action("Treasury & Cashier Transactions")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Treasury & Cashier Transactions';
                            RunObject = page "Treasury Cashier List";
                        }
                    }
                    group("Transfers")
                    {
                        Caption = 'Transfers';
                        action("Account Trasfer")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Account Transfer';
                            RunObject = page "Account Transfer List";
                        }
                        action("Posted Account Transfer")
                        {
                            ApplicationArea = Suite, FixedAssets;
                            Caption = 'Posted Account Transfer';
                            RunObject = page "Posted Account Transfer List";
                        }
                    }
                    group("Interest")
                    {
                        Caption = 'Interest Management';
                        action("Account Interest List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Account Interest List';
                            RunObject = page "Account Interest List";
                        }
                        action("Posted Account Interest List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Account Interest List';
                            RunObject = page "Posted Account Interest List";
                        }
                        action("End Year Interest List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'End Year Interest List';
                            RunObject = page "End Year Interest List";
                        }

                        action("Posted End Year Interest List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted End Year Interest List';
                            RunObject = page "Posted End Year Interest List";
                        }
                    }
                    group("Standing Orders")
                    {
                        Caption = 'Standing Order';
                        action("Standing Order List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Standing Order List';
                            RunObject = page "Standing Order List";
                        }
                        action("Standing Order Register List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Standing Order Register List';
                            RunObject = page "Standing Order Register List";
                        }
                        action("Standing Order Control List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Standing Order Control List';
                            RunObject = page "Standing Order Control List";
                        }
                    }
                    group("EFT/RTGS")
                    {
                        Caption = 'EFT/RTGS';
                        action("EFT Transfer List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'EFT Transfer List';
                            RunObject = page "RTGS Transfer List";
                        }
                        action("Posted EFT Transfer List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted EFT Transfer List';
                            RunObject = page "Posted EFT Transfer List";
                        }
                    }
                    group("Cheque Management")
                    {
                        Caption = 'Cheque Management';
                        action("Cheque Types")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cheque Types';
                            RunObject = page "Cheque Types";
                        }

                        action("Cheque Book Application")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cheque Book Application';
                            RunObject = page "Cheque Book Application List";
                        }
                        action("Cheque Receipts")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cheque Receipts';
                            RunObject = page "Cheque Receipts List";
                        }
                        action("Bankers Cheque Application")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Bankers Cheque Application';
                            RunObject = page "Bankers Cheque Application";
                        }

                        action("Cheque Clearance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cheque Clearance';
                            RunObject = page "Cheque Clearance";
                        }
                    }
                    group("ATM Management")
                    {
                        Caption = 'ATM Management';
                        action("ATM Applications List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'ATM Applications List';
                            RunObject = page "ATM Application List";
                        }
                        action("Approved ATM Applications List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved ATM Applications List';
                            RunObject = page "Approved ATM Application List";
                        }
                        action("ATM Linking Application List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'ATM Linking Application List';
                            RunObject = page "ATM Linking Application List";
                        }
                        action("Approved ATM Linking List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved ATM Linking List';
                            RunObject = page "Approved ATM Linking List";
                        }
                        action("ATM Transactions")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'ATM Transactions';
                            RunObject = page "Sky ATM Transactions Buffer";
                        }
                        action("ATM Charge")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'ATM Charge';
                            RunObject = page "ATM Charge List";
                        }
                        action("Sky ATM Transactions")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Sky ATM Transactions';
                            //RunObject = page "Sky ATM Transactions";
                        }
                    }
                    group("Bank Overdraft")
                    {
                        Caption = 'Bank Overdraft';
                        action("Over Draft Authorisation")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Over Draft Authorisation';
                            RunObject = page "Over Draft Authorisation List";
                        }

                    }
                    group("Delegates")
                    {
                        Caption = 'Delegates Management';
                        action("Delegate Region App Lists")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Delegate Region App Lists';
                            RunObject = page "Delegate Group App Lists";
                        }
                        action("Delegate Region Lists")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Delegate Region Lists';
                            RunObject = page "Delegate Group Lists";
                        }
                        action("Delegate Changes List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Delegate Changes List';
                            RunObject = page "Delegate Group Retire Lists";
                        }
                        action("Delegates Payment List Page")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Delegates Payment Lists';
                            RunObject = page "Delegates Payment List";
                        }
                        action("Delegate Meetings")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Delegate Meetings';
                            RunObject = page "Delegate Meeting Header";
                        }
                        action("Delegate Members List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Delegate Members List';
                            RunObject = page "Delegate Members List";
                        }
                        action("ADM Registration List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'ADM Registration List';
                            RunObject = page "ADM Registration List";
                        }
                        action("ADM Payment List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'ADM Payment List ';
                            RunObject = page "ADM Payment List";
                        }
                        action("Delegate Group Change Lists")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Delegate Group Change Lists';
                            RunObject = page "Delegate Group Change Lists";
                        }
                        action("Delegates AGM Update List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Delegates AGM Update List';
                            RunObject = page "Delegates AGM Update List";
                        }
                    }
                    group("Bonds")
                    {
                        Caption = 'Bonds Management';
                        action("Bond List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Bond List';
                            RunObject = page "Bond List";
                        }
                    }
                    group("Salary")
                    {
                        Caption = 'Salary';
                        action("Salary Lists")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Salary Lists';
                            RunObject = page "Salary Lists";
                        }
                    }
                }
                group("Banking Reports")
                {
                    Caption = 'Reports and Analysis';
                    group("Account Reports")
                    {
                        Caption = 'Account Management';
                        action("Accounts Application Register")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Accounts Application Register';
                            RunObject = report "Accounts Application Register";
                        }
                        action("FOSA Savings Register")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'FOSA Savings Register';
                            RunObject = report "FOSA Savings Register";
                        }
                        action("Credit Register")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Credit Register';
                            RunObject = report "Credit Register";
                        }
                        action("Account Balance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Account Balance';
                            RunObject = report "FOSA Loan Register";
                        }
                        action("Junior Saving Account Balances")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Junior Saving Account Balances';
                            RunObject = report "Junior Saving Account Balances";
                        }

                        action("Savings Contribution Variance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Savings Contribution Variance';
                            // RunObject = report "Savings Contribution Variance";
                        }
                        action("Member Detailed Statement")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Member Detailed Statement';
                            RunObject = report "Member Detailed Statement";
                        }
                        action("Generate Dormant Accounts")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Generate Dormant Accounts';
                            RunObject = report "Generate Dormant Accounts";
                        }
                        action("Update Can Guarantee Loan")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Update Can Guarantee Loan';
                            RunObject = report "Update Can Gurantee Loan";
                        }
                        action("Salary Not Thru FOSA for 3 months")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Salary Not Thru FOSA for 3 months';
                            // RunObject = report "Salary Not Thru FOSA for 3 months";
                        }
                        action("Salary Through FOSA Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Salary Through FOSA Report';
                            RunObject = report "Salary Through FOSA Report";
                        }
                        action("Salary Pass Through FOSA")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Salary Pass Through FOSA';
                            //RunObject = report "Salary Pass Through FOSA";
                        }
                        action("Loan SMS Notice")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loan SMS Notice';
                            RunObject = report "Loan SMS Notice";
                        }
                        action("Clear Lien Process")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Clear Lien Process';
                            RunObject = report "Clear Lien Process";
                        }

                    }
                    group("Cashier Reports")
                    {
                        Caption = 'Cashier Reports';
                        action("Cashier Transactions Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cashier Transactions';
                            RunObject = report "Cashier Transactions";
                        }

                    }
                    action("EFT Reports")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'EFT Report';
                        RunObject = report "RTGS Report";
                    }
                    action("Fixed Deposit Notifications")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Fixed Deposit Notifications';
                        //RunObject = report "Fixed Deposit Notifications";
                    }
                    action("Process Fixed Deposit")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Process Fixed Deposit';
                        RunObject = report "Process Fixed Deposit";
                    }

                    group("ATM Reports")
                    {
                        Caption = 'ATM Reports';
                        action("ATM card no's account balances")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'ATM card nos account balances';
                            //RunObject = report "ATM card no's account balances";
                        }
                        action("ATM Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'ATM Report';
                            RunObject = report "ATM Activation Report";
                        }
                        action("ATM Upload Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'ATM Upload Report';
                            RunObject = report "ATM Upload Report";
                        }
                    }
                    group("Standing Order Reports")
                    {
                        Caption = 'Standing Order Reports';
                        action("Standing Order")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Standing Order Processing';
                            //RunObject = report "Standing Order Processing";
                        }
                        action("Standing Order Processing New")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Standing Order Processing New';
                            //RunObject = report "Standing Order Processing New";
                        }
                        action("Standing Order Processing")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Standing Order Processing';
                            //RunObject = report "Standing Order Processing";
                        }
                        action("Standing Orders Register")
                        {
                            ApplicationArea = SalesReturnOrder, PurchReturnOrder;
                            Caption = 'Standing Orders Register';
                            RunObject = report "Standing Orders Register";
                        }
                        action("Banking Standing Order")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Standing Order';
                            RunObject = report "Standing Order";
                        }

                        action("Standing Order Register")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Standing Order Register';
                            RunObject = report "Standing Order Register";
                        }
                    }
                    group("Delegates Reports")
                    {
                        Caption = 'Delegate Reports';
                        // action("Delegates List")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Delegates List';
                        //     RunObject = report "Delegates List";
                        // }
                        action("Delegates Payment List")
                        {
                            ApplicationArea = CBasic, Suite;
                            Caption = 'Delegates Payment List';
                            RunObject = report "Delegates Payment  List";
                        }
                        // action("Region Delegates Tariff")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Region Delegates Tariff';
                        //     RunObject = report "Region Delegates Tariff";
                        // }
                        action("Delegate Payment Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Delegate Payment Report';
                            RunObject = report "Delegate Payment Report";
                        }
                        action("Delegates Listing")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Delegates Listing';
                            RunObject = report "Delegates Listing";
                        }
                        action("Delegates Payments Reports")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Delegates Payments Reports';
                            RunObject = report "Delegates Payments Reports";
                        }
                        action("Annual General Meeting Attendees")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Deligates Registration';
                            RunObject = report "Deligates Registration";
                        }
                    }

                    group(" E-Mail Notification")
                    {
                        Caption = 'Notification';
                        action("E-Mail Frequency Statement")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'E-Mail Frequency Statement';
                            //RunObject = report "E-Mail Frequency Statement";
                        }
                    }

                }
                group("Banking Setup")
                {
                    Caption = 'Banking Setups';
                    group("Transaction Setup")
                    {
                        Caption = 'Transactions Setup';
                        action("Transaction Types")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Transaction Types';
                            RunObject = page "Transaction Types";
                        }
                        action("Tiered Charges")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Tiered Charges';
                            RunObject = page "Tiered Charges List";
                        }
                        action("Denominition Setup")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Denominition Setup';
                            RunObject = page "Denomination Setup";
                        }

                    }
                    group("Fixed Deposit Setup")
                    {
                        Caption = 'Fixed Deposit Setup';
                        action("Fixed Deposit Type")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Fixed Deposit Type';
                            RunObject = page "Fixed Deposit Type";
                        }
                    }
                    group("Delegates Setup")
                    {
                        Caption = 'Delegates Setup';
                        action("Region Delegate Tariffs")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Region Delegate Tariffs';
                            RunObject = page "Region Delegate Tariffs";
                        }
                        action("Delegate Tariffs")
                        {
                            ApplicationArea = CostAccounting;
                            Caption = 'Delegate Tariffs';
                            RunObject = page "Delegate Tariffs";
                        }
                    }
                    group("Banking No. Setup")
                    {
                        Caption = 'Banking No Setup';
                        action("Banking No Setup")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Banking No Setup';
                            RunObject = page "Banking No Setup";
                        }
                        action("Banking User Setup")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Banking User Setup';
                            RunObject = page "Banking User Setup";
                        }
                    }


                }
            }
            group("Funds Management")
            {
                group("Recipts, Payments and Bank Transfers")
                {
                    Caption = 'Recipts, Payments and Bank Transfers';
                    action("Bank Deposit")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Deposit';
                        Image = DepositSlip;
                        RunObject = Codeunit "Open Deposits Page";
                        ToolTip = 'Create a new deposit. ';
                    }
                    action("Receipts List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Receipts List';
                        RunObject = page "Receipts List";
                    }
                    action("Checkoff Receipt Trans List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Checkoff Receipt Trans List';
                        RunObject = page "Checkoff Receipt Trans List";
                    }
                    action("Posted Checkoff  Receipt List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Checkoff  Receipt List';
                        RunObject = page "Posted Checkoff  Receipt List";
                    }
                    action("Purchase Requisitions")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Requisitions';
                        RunObject = page "Purchase Requisitions";
                    }
                    action("RFQ List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'RFQ List';
                        RunObject = page "RFQ List";
                    }
                    action("Payment Vouchers")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Vouchers List';
                        RunObject = page "Payment Vouchers List";
                    }
                    action("Petty Cash Vouchers")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Petty Cash Vouchers List';
                        RunObject = page "Petty Cash Vouchers List";
                    }
                    action("Payment Voucher Board")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Voucher Board';
                        RunObject = page "Payment Voucher Board";
                    }
                    action("Payment Voucher Staff")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Voucher Staff';
                        RunObject = page "Payment Voucher Staff List";
                    }

                    action("Bank & Cash Transfers")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank & Cash Transfers List';
                        RunObject = page "Bank & Cash Transfers List";
                    }
                    action("Vote Transfer")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vote Transfer List.';
                        RunObject = page "Vote Transfer List.";
                    }

                }
                group("Imprest and Claim Management")
                {
                    Caption = 'Imprest and Claims';
                    group("Staff")
                    {
                        Caption = 'Staff';
                        action("Staff Claims List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Staff Claims List';
                            RunObject = page "Staff Claims List";
                        }
                        action("Staff Advance Request List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Staff Advance Request List';
                            RunObject = page "Staff Advance Request List";
                        }
                        action("Staff Advance Surrender")
                        {
                            ApplicationArea = Suite, Basic;
                            Caption = 'Posted Account Transfer';
                            RunObject = page "Staff Advance Surrender List";
                        }
                        action("Paid SinkFund List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Paid SinkFund List';
                            RunObject = page "Paid SinkFund List";
                        }
                    }

                    group("Imprest")
                    {
                        Caption = 'Imprest Vouchers';
                        action("Imprest Vouchers")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Imprest Vouchers List';
                            RunObject = page "Imprest Vouchers List";
                        }
                        action("Imprest Surrender")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Imprest Surrender List';
                            RunObject = page "Imprest Surrender List";
                        }
                    }
                    group("Overtime")
                    {
                        Caption = 'Overtime';
                        action("Overtime Claim List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Overtime Claim List';
                            RunObject = page "Overtime Claim List";
                        }

                        action("Overtime Claim List-Approved")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Overtime Claim List-Approved';
                            RunObject = page "Overtime Claim List-Approved";
                        }
                    }
                }
                group("History")
                {
                    Caption = 'History';
                    group("FT Transfers")
                    {
                        Caption = 'Transfers';
                        action("Posted Bank & Cash Transfers")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Bank & Cash Transfers';
                            RunObject = page "Posted Bank & Cash Transfers";
                        }
                    }
                    group("Payments")
                    {
                        Caption = 'Payment';
                        action("Posted Payment Vouchers List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Payment Vouchers List';
                            RunObject = page "Posted Payment Vouchers List";
                        }
                        action("Posted Petty Cash Vouchers")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Petty Cash Vouchers';
                            RunObject = page "Posted Petty Cash Vouchers";
                        }
                        action("Cancelled Petty Cash Vouchers")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cancelled Petty Cash Vouchers';
                            RunObject = page "Cancelled Petty Cash Vouchers";
                        }
                        action("Posted Payment Voucher Board L")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Payment Voucher Board L';
                            RunObject = page "Posted Payment Voucher Board L";
                        }

                        action("Posted Payment Voucher Staff L")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Payment Voucher Staff L';
                            RunObject = page "Posted Payment Voucher Staff L";
                        }
                        action("Posted PaymentV  Delegate")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted PaymentV  Delegate';
                            //RunObject = page "Posted PaymentV  Delegate";
                        }
                    }
                    group("Receipts")
                    {
                        Caption = 'Receipts';
                        action("Posted Receipt List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Receipt List';
                            RunObject = page "Posted Receipt List";
                        }
                        action("Posted Cash Receipts List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Cash Receipts List';
                            RunObject = page "Posted Cash Receipts List";
                        }
                    }
                    group("Claims")
                    {
                        Caption = 'Claims';
                        action("Posted Staff Claims List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Staff Claims List';
                            RunObject = page "Posted Staff Claims List";
                        }
                        action("Posted Staff Advance Requests")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Staff Advance Requests';
                            RunObject = page "Posted Staff Advance Requests";
                        }
                        action("Cancelled Staff Advance Request")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cancelled Staff Advance Reques';
                            RunObject = page "Cancelled Staff Advance Reques";
                        }
                        action("Posted Staff Advance Surrender")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Staff Advance Surrender';
                            RunObject = page "Posted Staff Advance Surrender";
                        }
                        action("Overtime Claim List-Cancelled")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Overtime Claim List-Cancelled';
                            RunObject = page "Overtime Claim List-Cancelled";
                        }
                        action("Cancelled Staff Claims List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cancelled Staff Claims List';
                            RunObject = page "Cancelled Staff Claims List";
                        }
                        action("Benv.Claim List-Posted")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Benv.Claim List-Posted';
                            RunObject = page "Benv.Claim List-Posted";
                        }
                    }
                    group("Imprests")
                    {
                        Caption = 'Imprest Requisition';
                        action("Posted Imprest Vouchers List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Imprest Vouchers List';
                            RunObject = page "Posted Imprest Vouchers List";
                        }
                        action("Cancelled Imprest Vouchers Lis")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cancelled Imprest Vouchers Lis';
                            RunObject = page "Cancelled Imprest Vouchers Lis";
                        }
                    }
                    group("Requisitions")
                    {
                        Caption = 'Requisitions';
                        action("Posted Store Requisitions List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Store Requisitions List';
                            RunObject = page "Posted Store Requisitions List";
                        }
                        action("Posted Purchase Requisitions")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Purchase Requisitions';
                            RunObject = page "Posted Purchase Requisitions";
                        }
                    }
                }

                group("FM Reports and Analysis")
                {

                    Caption = 'Reports and Analysis';
                    group("Receipts, Payment and Bank Transfers reports")
                    {
                        Caption = 'Receipts, Payment and Bank Transfers';
                        action("Board Payment Voucher Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Board Payment Voucher Report';
                            RunObject = report "Board Payment Voucher Report";
                        }
                        action("Staff Payment Voucher Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Staff Payment Voucher Report';
                            RunObject = report "Staff Payment Voucher Report";
                        }
                    }
                    group("Funds Transfer")
                    {
                        Caption = 'Transfers';
                        action("Checkoff Trans Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Checkoff Trans Report';
                            RunObject = report "Checkoff Trans Report";
                        }
                    }
                    group("Imprest and Claim Reports")
                    {
                        Caption = 'Imprest and Claims Report';
                        group("Staff CLaims")
                        {
                            Caption = 'Staff Claims';
                            action("Sink Fund Notice Report")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Sink Fund Notice Report';
                                RunObject = report "Sink Fund Notice Report";
                            }
                            action("Sink Fund Receipt Report")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Sink Fund Receipt Report';
                                RunObject = report "Sink Fund Receipt Report";
                            }
                        }
                        group("Staff Advance")
                        {
                            Caption = 'Staff Advance';
                        }
                        group("Benevolent Claims")
                        {
                            Caption = 'Benevolent CLaims';
                            action("BBF Claim Report")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'BBF Claim Report';
                                //RunObject = report "BBF Claim Report";
                            }
                            action("BBF Loan Register")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'BBF Loan Register';
                                RunObject = report "BBF Loan Register";
                            }
                            // action("BBF Refunds")
                            // {
                            //     ApplicationArea = Basic, Suite;
                            //     Caption = 'BBF Refunds';
                            //     RunObject = report "BBF Refunds";
                            // }

                        }
                        group("Imprest Requisition")
                        {
                            Caption = 'Imprest Requisition';
                        }
                        group("Membership Declarations")
                        {
                            Caption = 'Membership Declaration';
                            action("Membership Declaration")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Membership Declaration';
                                RunObject = report "Membership Declaration";
                            }
                            action("Updated Membership Declaration")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Updated Membership Declaration';
                                RunObject = report "Membership Declaration";
                            }
                        }
                    }
                }
                group("Funds Setup")
                {
                    Caption = 'Funds Setup';
                    action("BBF Entitlement2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'BBF Entitlement2';
                        RunObject = page "BBF Entitlement2";
                    }
                    action("Cash Office Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Office Setup';
                        RunObject = page "Cash Office Setup";
                    }
                    action("Budgetary Control Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Budgetary Control Setup';
                        RunObject = page "Budgetary Control Setup";
                    }
                    action("Cash Office User Template")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Office User Template';
                        RunObject = page "Cash Office User Template";
                    }
                    action("Receipt Types")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Receipt Types';
                        RunObject = page "Receipt Types";
                    }
                    action("Payment Types Lists")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Types Lists';
                        RunObject = page "Payment Types Lists";
                    }
                    action("Claim Types List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Claim Types List';
                        RunObject = page "Claim Types List";
                    }
                    action("Advance Types List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Advance Types List';
                        RunObject = page "Advance Types List";
                    }
                    action("Tariff Code s")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tariff Code s';
                        RunObject = page "Tariff Code s";
                    }
                    action("Expense Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Expense Code';
                        RunObject = page "Expense Code";
                    }
                    action("Imprest Types List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Imprest Types List';
                        RunObject = page "Imprest Types List";
                    }
                    action("Destination Code List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Destination Code List';
                        RunObject = page "Destination Code List";
                    }
                    action("Staff Allowance Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Staff Allowance Setup';
                        RunObject = page "Staff Allowance Setup";
                    }
                    action("Staff Member List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Staff Member List';
                        RunObject = page "Staff Member List";
                    }
                    action("Staff Allowance Grade")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Staff Allowance Grade';
                        RunObject = page "Staff Allowance Grade";
                    }
                    group("Aministration")
                    {
                        Caption = 'Administration';
                        action("Create Journals")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Create Journals';
                            RunObject = report "Create Journals";
                        }
                    }
                }
            }
            group("E-Channels")
            {
                group("M-Cash Banking")
                {
                    Caption = 'M-Cash Banking';

                    group("Applications")
                    {
                        Caption = 'Applications';

                        // action(MbankingApplicationList)
                        // {
                        //     ApplicationArea = Basic;
                        //     Caption = 'Mbanking Application List';
                        //     RunObject = Page "MBanking Applications List";
                        // }
                        action(MbankingRegisteredAccounts)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Mbanking Registered Accounts';
                            RunObject = Page "Mbanking Registered Members";
                        }
                        action(MbankingChangesList)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Mbanking Changes List';
                            RunObject = Page "Sky Mbanking Changes List";
                        }
                        // action(MobileUsers)
                        // {
                        //     ApplicationArea = Basic;
                        //     Caption = 'Mobile Users';
                        //     RunObject = Page "Sky Mobile Users";
                        // }
                    }

                    group("E-Loans")
                    {
                        Caption = 'Loans';

                        group("Loans Lists")
                        {
                            Caption = 'Lists';

                            action(MobileLoanAppraisalAnalysis)
                            {
                                ApplicationArea = Basic;
                                Caption = 'Mobile Loan Appraisal Analysis';
                                RunObject = Page "Sky Mobile Loan Appraisal";
                            }
                            action(MobileLoans)
                            {
                                ApplicationArea = Basic;
                                Caption = 'Mobile Loans';
                                RunObject = Page "Sky Mobile Loans";
                            }
                            action(BosaMobileLoanApplications)
                            {
                                ApplicationArea = Basic;
                                Caption = 'Bosa Mobile Loan-Applications';
                                // RunObject = Page "MBanking Loan Application List";
                            }
                            action(BosaMobileLoanAppraisal)
                            {
                                ApplicationArea = Basic;
                                Caption = 'Bosa Mobile Loan Appraisal';
                                RunObject = Page "MBanking Loan Appraised List";
                            }
                        }
                        group("Task")
                        {
                            Caption = 'Tasks';

                            action(BosaMobileLoanRejected)
                            {
                                ApplicationArea = Basic;
                                Caption = 'Bosa Mobile Loan Rejected';
                                RunObject = Page "MBanking Loan Rejected List";
                            }
                            // action(DividendPayslipLoans)
                            // {
                            //     ApplicationArea = Basic;
                            //     Caption = 'Dividend Payslip Loans';
                            //     RunObject = Page "Dividend Payslip Loans";
                            // }
                        }
                    }
                    group("E-SMS")
                    {
                        Caption = 'SMS';

                        group("SMS List")
                        {
                            // action(BulkSMS)
                            // {
                            //     ApplicationArea = Basic;
                            //     Caption = 'Bulk SMS';
                            //     RunObject = Page "MBanking Bulk SMS Header List";
                            // }
                            action(SMSMessages)
                            {
                                ApplicationArea = Basic;
                                Caption = 'SMS Messages';
                                RunObject = Page "Sky SMS Messages";
                            }

                        }

                    }
                    group(VirtualMembers)
                    {
                        Caption = 'Virtual Members';

                        action("Virtual Members")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Virtual Members';
                            // RunObject = Page "Sky Virtual Member";
                        }
                        action("Created Virtual Members")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Created Virtual Members';
                            //RunObject = Page "Sky Created Virtual Members";
                        }
                    }
                    group(BusinesAccounts)
                    {
                        Caption = 'Business Accounts';

                        action(BusinessAccounts)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Business Accounts';
                            RunObject = Page "Sky Business Accounts";
                        }
                    }
                    group(Morgage)
                    {
                        Caption = 'Morgage';

                        action("Morgage requisition List")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Mortgage requisition List';
                            RunObject = Page "Mortgage Requisition List";
                        }
                        action("Actioned Mortgage")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Auctioned Mortgage';
                            RunObject = Page "Actioned Mortgage";
                        }
                    }
                    group(Insurance)
                    {
                        Caption = 'Insurance';

                        action("Insurance Requisition List")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Insurance Requisition List';
                            RunObject = Page "Insurance Requisition List";
                        }
                        action("Insurance Actioned List")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Insurance Actioned List';
                            RunObject = Page "Insurance Actioned List";
                        }
                    }

                }
                group("Internet Banking")
                {
                    Caption = 'Internet Banking';

                    group("Users")
                    {
                        action(OnlineUsers)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Online Users';
                            RunObject = Page "Online Users";
                        }
                    }
                    // group("Internet Loans")
                    // {
                    //     Caption = 'Internet Loans';

                    //     group("Internet Loans Lists")
                    //     {
                    //         action("Online Loans")
                    //         {
                    //             ApplicationArea = Basic;
                    //             Caption = 'Online Loans';
                    //             RunObject = Page "Online Loans";
                    //         }
                    //         action("Internet Loan Application List")
                    //         {
                    //             ApplicationArea = Basic;
                    //             Caption = 'Internet Loan Application List';
                    //             RunObject = Page "Internet Loan Application List";
                    //         }
                    //         action("Approved Portal Loan App List")
                    //         {
                    //             ApplicationArea = Basic;
                    //             Caption = 'Approved Portal Loan App List';
                    //             RunObject = Page "Approved Portal Loan App List";
                    //         }
                    //     }
                    //     group("Internet Loan Task")
                    //     {
                    //         Caption = 'Internet Loan Task';

                    //         action("Rejected Portal Loan App List")
                    //         {
                    //             ApplicationArea = Basic;
                    //             Caption = 'Rejected Portal Loan App List';
                    //             RunObject = Page "Rejected Internet Loan List";
                    //         }
                    //     }
                    //     group("Loans Archive")
                    //     {
                    //         Caption = 'Loans Archive';

                    //         action("Validated/Posted Online Loans")
                    //         {
                    //             ApplicationArea = Basic;
                    //             Caption = 'Validated/Posted Online Loans';
                    //             RunObject = Page "Online Loans Posted";
                    //         }
                    //     }
                    // }
                    group("Internet Transactions")
                    {
                        Caption = 'Internet Transactions';

                        action("Internet Banking Transactions ")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Internet Banking Transactions ';
                            RunObject = Page "Internet Banking Transactions";
                        }
                    }
                }
                group("PESA Banking")
                {
                    Caption = 'PESA Banking';

                    group("Agency")
                    {
                        Caption = 'Agency';

                        group("Agency List")
                        {
                            Caption = 'Agency List';

                            action(AgentApplicationList)
                            {
                                ApplicationArea = Basic;
                                Caption = 'Agent Application List';
                                RunObject = Page "Agent Applications List";
                            }
                            action(ApprovedAgentsList)
                            {
                                ApplicationArea = Basic;
                                Caption = 'Approved Agents List';
                                RunObject = Page "Approved Agents List";
                            }
                        }
                        group(Admin)
                        {
                            Caption = 'Administration';

                            action(AgentSentSmsMessages)
                            {
                                ApplicationArea = Basic;
                                Caption = 'Agent Sent Sms Messages';
                                RunObject = Page "Agent Sent Sms Messages";
                            }
                            action(AgentErrorMessages)
                            {
                                ApplicationArea = Basic;
                                Caption = 'Agent Error Messages';
                                RunObject = Page "Agent Error Messages";
                            }
                        }
                    }
                    group("PESA Transactions")
                    {
                        Caption = 'Transactions';

                        group("Transaction Lists")
                        {
                            action(AgentTransactions)
                            {
                                ApplicationArea = Basic;
                                Caption = 'Agent Transactions';
                                RunObject = Page "Sky Agent Transactions";
                            }
                            // action(Agencies)
                            // {
                            //     ApplicationArea = Basic;
                            //     Caption = 'Agent Transactions List';
                            //     RunObject = Page "Sky Agencies";
                            // }
                            action("Agent Withdrawals Buffer")
                            {
                                ApplicationArea = Basic;
                                Caption = 'Agent Withdrawals Buffer';
                                RunObject = Page "Agent Withdrawals Buffer";
                            }
                            action("Agent Transfer List")
                            {
                                ApplicationArea = Basic;
                                Caption = 'Agent Transfer List';
                                RunObject = Page "Sky Agent Transfer List";
                            }
                        }
                    }
                    group("PESA Setups")
                    {
                        Caption = 'PESA Setups';

                        action(AgentTarrifBuffer)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Agent Tarrif Buffer';
                            RunObject = Page "Agent Tariff Header";
                        }
                    }
                }
                group("Web Portal")
                {
                    Caption = 'Web Portal';


                    group(" Web Portal Transactions")
                    {
                        action("Portal Transactions")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Portal Transactions';
                            RunObject = Page "Sky Portal Transactions";
                        }
                    }
                    group("Checkoff Advice")
                    {
                        action(CheckOffAdvice)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Checkoff Advice';
                            RunObject = Page "Sky Checkoff Advice";
                        }
                    }
                }
                group("Reports And Analysis")
                {
                    Caption = 'Reports and Analysis';

                    action(AgentTransactionsReport)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Agent Transactions Report';
                        RunObject = report "Agent Transactions Report";
                    }
                    action(AgentTransactionsRep)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Agent Transactions Report';
                        RunObject = report "Agent Transactions";
                    }
                }

            }
            group("Payroll Processing")
            {
                group("Payroll")
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
                    group("PR Reports and Analysis")
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
                        Caption = 'Transaction Codes';
                        RunObject = page "PR Transaction Codes List";
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
                    group("PR Tasks")
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
                group("PR Reports")
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
                            // RunObject = report "prDeductions Report";
                            ApplicationArea = Basic, Suite;
                        }
                        action("prAllowances Report")
                        {
                            Caption = 'prAllowances Report';
                            //RunObject = report "prAllowances Report";
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
                            //RunObject = report "prPayrollSummary-List";
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
                            // RunObject = report "PrAllowances Summary";
                            ApplicationArea = Basic, Suite;
                        }
                        action(" PrDeductions Summary")
                        {
                            Caption = 'PrDeductions Summary';
                            // RunObject = report "PrDeductions Summary";
                            ApplicationArea = Basic, Suite;
                        }
                        action("pr Loans Deductions Report")
                        {
                            Caption = 'pr Loans Deductions Report';
                            // RunObject = report "pr Loans Deductions Report";
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
                            // RunObject = report "PR Company Totals";
                            ApplicationArea = Basic, Suite;
                        }
                        action("prP9A-test  new")
                        {
                            Caption = 'prP9A-test  new';
                            // RunObject = report "prP9A-test  new";
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
                            // RunObject = report "Staff Allowance  P9";
                            ApplicationArea = Basic, Suite;
                        }
                        action("Overtime Hours Worked1")
                        {
                            Caption = 'Overtime Hours Worked1';
                            RunObject = report "Overtime Hours Worked1";
                            ApplicationArea = Basic, Suite;
                        }
                        group("PR Admin")
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
            group("Advanced HR")
            {
                group(HREmployeeManagement)
                {
                    group("HR Employee recruitment")
                    {
                        action(HRemployeeRequisitions)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'HR Employee Requisitions';

                            RunObject = Page "HR Employee Requisitions List";
                        }
                        action(HRjobApplications)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'HR job applications';

                            RunObject = Page "HR Job Applications List";
                        }
                        action(Shortlisting)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'HR Shortlisting';

                            RunObject = Page "HR Shortlisting List1";
                        }
                        action(HRJobApplicantsQualified)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'HR Job Applicants Qualified';

                            RunObject = Page "HR Job Applicants QualifiedL1";
                        }
                        action(HRJobApplicantsNotQualified)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'HR Job Applicants UnQualified';

                            RunObject = Page "HR Applicants UnQualified L1";
                        }
                        action(SuccesfulJobApplicants)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Qualified (Succesful) Job Applicants';

                            RunObject = Page "HR  App Qualified Applicants1";
                        }
                        group(RepoAndanalysis)
                        {
                            Caption = 'Reports and Analysis';
                            action(HRJobApplicants)
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'HR Job Applicantions';

                                RunObject = report "HR Job Applications";
                            }
                            action(JobInterviewReport)
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Job Interview Report';

                                RunObject = report "Job Interview results";
                            }
                            action(Shortlistingreport)
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Shortlisting Report';

                                RunObject = report "Shortlisting Report";
                            }
                        }
                        group("AHR Archive")
                        {
                            Caption = 'Archive';
                            action(HRjobApplicantsUploaded)
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'HR Job Applicants Uploaded';

                                RunObject = Page "HR Job Applicants Uploaded1";
                            }
                            action(HRemployeereqapproved)
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'HR Employee Requisitions Approved';

                                RunObject = Page "HR Employee ReqsListApproved1";
                            }
                        }
                    }
                    group("HR Employee Management")
                    {
                        Caption = 'HR Employee Management';
                        action(HRInductionSchedule)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'HR Induction Schedule';

                            RunObject = Page "HR Induction Schedule List1";
                        }
                        action(HREmployeeList)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'HR Employee List - New';

                            RunObject = Page "HR Employee List - New1";
                        }
                        action(HREmployeeList1)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'HR Employees - Pending Approval';

                            RunObject = Page "HR Employee List-Pending App1";
                        }
                        action(HREmployeeList2)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'HR Employees - Active';

                            RunObject = Page "HR Employee List - Active";
                        }
                        action(HREmployeeList3)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'HR Employees - Inactive';

                            RunObject = Page "HR Employee List - Inactive";
                        }
                        action(HREmployeeList4)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'HR Employees - Fixed TC';

                            RunObject = Page "HR Employee List - (FixedTc)";
                        }
                        action(HREmployeeChangeLog)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'HR Employees - Probation';

                            RunObject = Page "HR Employee Change Log";
                        }
                        group("AHR Tasks")
                        {
                            Caption = 'Tasks';
                            action(HrHeadOfDepartments)
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'HR Head of Departments';

                                RunObject = Page "HR Head of Departments List";
                            }
                        }
                        group(RepandAnalysis)
                        {
                            Caption = 'Reports And Analysis';
                            action(HREmployeeListReport)
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'HR Employee List Report';

                                RunObject = report "HR Employee List Report";
                            }
                            action(HREmployeeListdetailedReport)
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'HR Employee List Detailed Report';

                                RunObject = report "Employee Detailed Report";
                            }
                            action(HREmployeeListReport1)
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'HR Employee List ';

                                RunObject = report "HR Employee List";
                            }
                        }
                    }
                    group("HR Training Management")
                    {
                        Caption = 'HR Training Management';
                        group(HrTrainingMgt)
                        {
                            Caption = 'HR Training Management';
                            action(HRTrainingNeeds)
                            {
                                Caption = 'HR Training Needs';
                                ApplicationArea = Basic, Suite;
                                RunObject = Page "HR Training Needs List";
                            }
                            action(HrTrainingApplications)
                            {
                                Caption = 'HR Training Applications';
                                ApplicationArea = Basic, Suite;
                                RunObject = Page "HR Training ApplicationList";
                            }
                            group(Taskss)
                            {
                                Caption = 'Tasks';
                                action(HRTrainingFeedBack)
                                {
                                    Caption = 'HR Training FeedBack';
                                    ApplicationArea = Basic, Suite;
                                    RunObject = Page "HR Training Feedback";
                                }

                            }
                            group(Archve)
                            {
                                Caption = 'Archives';
                                action(HrTrainingApplicationsArchive)
                                {
                                    Caption = 'HR Training Applications Archive';
                                    ApplicationArea = Basic, Suite;
                                    RunObject = Page "HR Training Application Lines";
                                }
                            }
                        }
                        group(HrInternsMgt)
                        {
                            Caption = 'HR Interns Management';
                            action(HrInterns)
                            {
                                Caption = 'HR Interns';
                                ApplicationArea = Basic, Suite;
                                RunObject = Page "HR Interns List";
                            }
                            action(HrInternsRequisitions)
                            {
                                Caption = 'HR Interns Requisitions';
                                ApplicationArea = Basic, Suite;
                                RunObject = Page "HR Intern Requisition List";
                            }
                        }

                    }
                    group("HR Disciplinary Management")
                    {
                        Caption = 'HR Disciplinary Management';
                        action(HRDisciplinaryCases)
                        {
                            Caption = 'HR Disciplinary Cases';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "HR Disciplinary Cases List N1";
                        }
                        action(HRDiscWthdwaList)
                        {
                            Caption = 'HR Disciplinary Withdrawal List';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "HR Disc Withdrawal list";
                        }
                        action(HRDiscAppealList)
                        {
                            Caption = 'HR Disciplinary Appeal list';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "HR Disciplinary Appeal List";
                        }
                        action(HREmployeeGrievance)
                        {
                            Caption = 'HR Employee Grievance';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "HR Employee Grievance List";
                        }
                        group(Takss)
                        {
                            Caption = 'Tasks';
                            action(HrDiscCasesLst)
                            {
                                Caption = 'HR Disciplinary Cases list';
                                ApplicationArea = Basic, Suite;
                                RunObject = page "HR Disciplinary Cases List";

                            }
                        }
                        group(RepAnalysis)
                        {
                            Caption = 'Reports and Analysis';
                            action(HrDiscCasesList)
                            {
                                Caption = 'HR Disciplinary Cases list';
                                ApplicationArea = Basic, Suite;
                                RunObject = report "HR Disciplinary Cases List";
                            }
                            action(HrDiscCases)
                            {
                                Caption = 'HR Disciplinary Cases';
                                ApplicationArea = Basic, Suite;
                                RunObject = report "HR Disciplinary Cases";
                            }

                        }
                        group(Archves)
                        {
                            Caption = 'Archive';
                            action(ClosedHrDiscCases)
                            {
                                Caption = 'Closed HR Disciplinary Cases';
                                ApplicationArea = Basic, Suite;
                                RunObject = page "HR Disciplinary Cases ListCls1";

                            }
                        }
                        group(Admini)
                        {
                            Caption = 'Administration';
                            action(HrDiscActions)
                            {
                                Caption = 'HR Disciplinary Actions';
                                ApplicationArea = Basic, Suite;
                                RunObject = page "HR Disciplinary Actions1";

                            }
                        }
                    }
                    group("HR Perfomance Management")
                    {
                        Caption = 'Hr Perfomance Management';
                        group("HR BSC Appraisal")
                        {
                            action("HR BSC List Target Setting")
                            {
                                Caption = 'HR BSC List Target Setting';
                                ApplicationArea = Basic, suite;
                                RunObject = page "HR BSC List Targets1";
                            }

                            action("HR BSC List Quater1")
                            {
                                Caption = 'HR BSC List Quater1';
                                ApplicationArea = Basic, suite;
                                RunObject = page "HR BSC List Qaurter 1";
                            }

                            action("HR BSC List Quater 3")
                            {
                                Caption = 'HR BSC List Quater 3';
                                ApplicationArea = Basic, suite;
                                RunObject = page "HR BSC List Qaurter 3";
                            }
                            action("HR BSC List Approved")
                            {
                                Caption = 'HR BSC List Approved';
                                ApplicationArea = Basic, suite;
                                RunObject = page "HR BSC List Approved";
                            }
                            action("HR BSC List End Year")
                            {
                                Caption = 'HR BSC List End Year';
                                ApplicationArea = Basic, suite;
                                RunObject = page "HR BSC List End Year1";
                            }
                            action("HR BSC List Closed")
                            {
                                Caption = 'HR BSC List Closed';
                                ApplicationArea = Basic, suite;
                                RunObject = page "HR BSC List Closed";
                            }
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
                            //ADDED DEPARTMENT TARGETS MENU ITEMS FOR HOD AND HR ADMIN ACCESS
                            action("HR Department Targets List")
                            {
                                Caption = 'HR Department Targets';
                                ApplicationArea = Basic, Suite;
                                RunObject = page "HR Department Targets List";
                            }
                            action("HR HOD Department Targets")
                            {
                                Caption = 'My Department Targets (HOD)';
                                ApplicationArea = Basic, Suite;
                                RunObject = page "HRHOD Department Targets";
                            }
                        }
                        group(randanalysis)
                        {
                            Caption = 'Reports and Analysis';
                            action(PerfomanceReport)
                            {
                                Caption = 'Perfomance Report';
                                ApplicationArea = Basic, Suite;
                                RunObject = report "Performance Report";

                            }
                            action(AppraisalReport)
                            {
                                Caption = 'Appraisal Report';
                                ApplicationArea = Basic, Suite;
                                RunObject = report "Appraisal Report";

                            }
                        }
                    }
                    group("HR Leave Management")
                    {
                        group(Grp1Tasks)
                        {
                            Caption = 'Tasks';
                            action(HRLeaveAdjustments)
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'HR Leave Adjustments';

                                RunObject = Page "HR Leave Journal Lines";
                            }
                            action(HrleaveJnrTemp)
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'HR Leave Journal Templates';

                                RunObject = Page "HR Leave Jnl. Template List";
                            }
                            action(HrLeaveReimbusementList)
                            {
                                Caption = 'HR Leave Reimbusement List';
                                ApplicationArea = Basic, Suite;
                                RunObject = Page "HR Leave Reimbursment List1";
                            }
                            action(HrLeavePlannerList)
                            {
                                Caption = 'HR Leave Planner List';
                                ApplicationArea = Basic, Suite;
                                RunObject = Page "HR Leave Planner List";
                            }
                            action(HrLeavePlannerLinesDrill)
                            {
                                Caption = 'HR Leave Planner Lines dril';
                                ApplicationArea = Basic, Suite;
                                RunObject = Page "HR Leave Planner Lines Drill";
                            }

                        }
                        group(Grp2repansanalysis)
                        {
                            Caption = 'Reports and Analysis';
                            action(HrLeaveApplication)
                            {
                                Caption = 'HR Leave Application';
                                ApplicationArea = Basic, Suite;
                                RunObject = report "HR Leave Application";
                            }
                            action(HrLeaveStatement)
                            {
                                Caption = 'HR Leave Statement';
                                ApplicationArea = Basic, Suite;
                                RunObject = report "HR Leave Statement";
                            }

                            action(StaffLeaveBalances)
                            {
                                Caption = 'Staff Leave Balances';
                                ApplicationArea = Basic, Suite;
                                RunObject = report "HR Leave Balance";
                            }
                            action(HrleaveBal2)
                            {
                                Caption = 'HR Leave Balance2';
                                ApplicationArea = Basic, Suite;
                                RunObject = report "HR Leave Balance2";
                            }
                            action(HrLeaveBalSummary)
                            {
                                Caption = 'HR Leave Balance Summary';
                                ApplicationArea = Basic, Suite;
                                RunObject = report "HR Leave Balance Summary";
                            }
                            action(StaffOnLeave)
                            {
                                Caption = 'Staff On Leave';
                                ApplicationArea = Basic, Suite;
                                RunObject = report "Staff On Leave";
                            }
                        }
                        group(Archives)
                        {
                            Caption = 'Archives';
                            action(HrLeavePlannerArchive)
                            {
                                Caption = 'HR Leave Planner Archive';
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
                    group("Staff Loan")
                    {
                        Caption = 'Staff Loan';
                        action(SalaryAdvance)
                        {
                            Caption = 'Salary Advance';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "prSalary Advance List";
                        }
                        action(LnTypeList)
                        {
                            Caption = 'Loan Type List';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Loan Type List";
                        }
                    }
                    group("HR Exit Interviews")
                    {
                        Caption = 'HR Exit Interviews';
                        action("HR Employee Exit Interviews")
                        {
                            Caption = 'HR Employee Exit Interviews';
                            ApplicationArea = Basic, Suite;
                            // RunObject = page "HR Employee Exit Interviews1";
                        }

                        group(repandanaly)
                        {
                            Caption = 'Reports And Analysis';
                            action(SeparationReport)
                            {
                                Caption = 'Separation Report';
                                ApplicationArea = Basic, Suite;
                                // RunObject = report "Separation report1"; missing repo
                            }
                        }
                        group(arch)
                        {
                            Caption = 'Archive';
                            action("Closed HR Employee Exit Interviews")
                            {
                                Caption = 'Separation Report';
                                ApplicationArea = Basic, Suite;
                                RunObject = page "Closed HR Exit Interview list1";
                            }
                        }

                    }
                }
                group("HR Activities")
                {
                    Caption = 'HR Activities';
                    group("HR jobs Management")
                    {
                        Caption = 'HR jobs Management';
                        action("HR Jobs")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'HR Jobs';

                            RunObject = Page "HR Jobs List";
                        }
                        action("HR Job Qualifications")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'HR Job Qualifications';

                            RunObject = Page "HR Job Qualifications";
                        }
                        group("AHR Task")
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
                                    Caption = 'HR Jobs';

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
                                    Caption = 'HR Jobs vacant and occupied ';

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
                    group("HR Company Activities")
                    {
                        Caption = 'HR Company Activities';
                        action(CompanyActivitieswelfare)
                        {
                            Caption = 'Company Activities/ Welfare';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "HR Company Activities List1";
                        }
                        group(RepAndAnalys)
                        {
                            Caption = 'Reports and Analysis';
                            action(CompActivitiesWelface)
                            {
                                Caption = 'Company Activities/Welfare';
                                ApplicationArea = Basic, Suite;
                                RunObject = report "HR Company Activities";
                            }

                        }
                        group(Archv)
                        {
                            Caption = 'Archive';
                            action(CompActivitiwelface)
                            {
                                Caption = 'Company Activities/Welfare closed activities';
                                ApplicationArea = Basic, Suite;
                                RunObject = page "HR Company Activities List Cl1";
                            }

                        }
                    }
                    group("HR Promotion Recommendation")
                    {
                        Caption = 'HR Promotion Recommendation';
                        action("HRPromotion Recommendations")
                        {

                            Caption = 'HR Promotion Recommendations';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "HR Promotion Recommend List";
                        }
                        action("Effected Promotion Recommendations")
                        {

                            Caption = 'Effected Promotion Recommendations';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "HR Promotion RecommendAppList";
                        }
                    }
                    group("Salary Agreements")
                    {
                        group(GrpSalary)
                        {
                            Caption = 'Salary Agreements';
                            action("Salary Agreement List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Salary Agreement List';
                                RunObject = page "Salary Agreement List";
                            }
                            action("Approved Salary Agreement List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Salary Agreement List';
                                RunObject = page "Approved Salary Agreement List";
                            }
                            action("Rejected Salary Agreement List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Rejected Salary Agreement List';
                                RunObject = page "Rejected Salary Agreement List";
                            }
                        }
                        group(SalAgreeRepos)
                        {
                            Caption = 'Salary Agreements Reports';
                            action("Salary Agreement")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Salary Agreement';
                                RunObject = report "Salary Agreement";
                            }
                            action("Salary Agreement Report")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Salary Forms Report';
                                RunObject = report "Salary Agreement Report";
                            }
                            action("Salary Agreement Counter")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Salary Agreement Counter';
                                RunObject = report "Salary Agreement Counter";
                            }
                            action("RSalary Agreement List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Salary Agreement List';
                                RunObject = report "Salary Agreement List";
                            }
                        }

                    }

                }

                group("User / HR requests")
                {
                    Caption = 'User / HR requests';
                    group("Leave")
                    {
                        Caption = 'Leave Application';
                        group("Leave Management Lists")
                        {
                            Caption = 'Lists';
                            action("HR Leave Applications List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'HR Leave Applications List';
                                RunObject = page "HR Leave Applications List1";
                            }
                        }
                        group("Arc")
                        {
                            action("HR Leave Applications")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'HR Leave Applications List';
                                RunObject = page "HR Leave Applications History1";
                            }
                        }
                    }
                    group("Other Requisitions")
                    {
                        Caption = 'Other Requisitions';
                        group("Other Requisition")
                        {
                            Caption = 'Lists';
                            action("Overtime Claims List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Other Requisitions';
                                RunObject = page "Overtime Claim List";
                            }
                            action("Purchase Requisition")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Purchase Requisitions';
                                RunObject = page "Purchase Requisitions";
                            }
                            action("System Rights Requisition")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'System Rights Requisition';
                                RunObject = page "Permission Requisition Card";
                            }
                        }
                    }
                    group(group3)
                    {
                        Caption = 'Reports';
                        group("AHR Reports")
                        {
                            Caption = 'Lists';
                            action("Dividend Slip")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Dividend Slip';
                                RunObject = report "Dividend Slip B64";
                            }
                        }
                    }

                    group(group4)
                    {
                        Caption = 'Store Requisitions';
                        group("Store Requisitions")
                        {
                            Caption = 'Lists';
                            action("Store Requisition List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Store Requisition List';
                                RunObject = page "Store Requisitions List";
                            }
                            action("Cancelled Store Requisitions List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Cancelled Store Requisitions List';
                                RunObject = page "Cancelled Store Req List";
                            }
                        }
                        group(Arkiv)
                        {
                            Caption = 'Lists';
                            action("Store Requisition Released/Pending")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Store Requisition Released/Pending';
                                RunObject = page "Store Requisition List";

                            }
                        }
                    }
                }
                group("HR General Setup")
                {

                    Caption = 'HR General Setup';
                    action("HR leave Calendar")
                    {
                        Caption = 'HR Leave Calendar';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "HR Leave Calendar List";
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
                    group(Admn)
                    {
                        Caption = 'Administration';
                        action("HR Setup")
                        {
                            Caption = 'HR Setup';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "HR Setup";
                        }
                    }
                }

            }
            group(Procurement)
            {
                group("Planning")
                {
                    Caption = 'Planning';
                    group("Procurememnt Order Planning")
                    {
                        Caption = 'Order Planning';
                        action("Order Planning")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Order Planning';
                            RunObject = page "Order Planning";
                        }
                    }
                    group("Planning Administration")
                    {
                        Caption = 'Administration';
                        action("Req. Worksheet")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Req. Worksheet';
                            RunObject = page "Req. Worksheet";
                        }
                        action("Recurring Req. Worksheet")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Recurring Req. Worksheet';
                            RunObject = page "Recurring Req. Worksheet";
                        }
                        action("Purchase Order List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Purchase Order List';
                            RunObject = page "Purchase Order List";
                        }
                        action("Service Orders")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Service Orders';
                            RunObject = page "Service Orders";
                        }
                        action("Transfer Orders")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Transfer Orders';
                            RunObject = page "Transfer Orders";
                        }
                    }
                }
                group("Order Processing")
                {
                    Caption = 'Order Processing';
                    group("Order Processing List")
                    {
                        Caption = 'Order Processing';
                        action("Purchases Requisitions")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Purchase Requisitions';
                            RunObject = page "Purchase Requisitions";
                        }
                        action("RFQ Lists")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'RFQ List';
                            RunObject = page "RFQ List";
                        }
                        action("Local Purchase Orders")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Local Purchase Orders';
                            RunObject = page "Purchase Order List";
                        }
                        action("Procurement Petty Cash List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Procurement Petty Cash List';
                            RunObject = page "ADM Registration List";
                        }
                        action("Local Service Orders")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Local Service Orders';
                            RunObject = page "Purchase Order List";
                        }
                        action("Purchase Invoices")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Purchase Invoices';
                            RunObject = page "Purchase Invoices";
                        }
                        action("Purchase Credit Memos")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Purchase Credit Memos';
                            RunObject = page "Purchase Credit Memos";
                        }
                        action("Posted Purchase Receipts")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Good Received Note';
                            RunObject = page "Posted Purchase Receipts";
                        }
                        action("Sales Invoice List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Sales Invoice List';
                            RunObject = page "Sales Invoice List";
                        }
                        action("Transfer List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Transfer Orders';
                            //RunObject = page "Transfer List";
                        }
                        action("Purchase Quotes")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Purchase Quotes';
                            RunObject = page "Purchase Quotes";
                        }
                        action("Sales Quotes")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Disposal Requisition';
                            RunObject = page "Sales Quotes";
                        }
                    }
                    group("Order Processing Task")
                    {
                        Caption = 'Order Processing Task';
                        action("Purchase Journal")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Purchase Journal';
                            RunObject = page "Purchase Journal";
                        }
                    }
                    group("Order Processing Documents")
                    {
                        Caption = 'Documents';
                        action("Purchase - Quote")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Purchase - Quote';
                            RunObject = report "Purchase - Quote";
                        }
                        action("Order")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Order';
                            RunObject = report "Order";
                        }
                        action("Blanket Purchase Order")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Blanket Purchase Order';
                            RunObject = report "Blanket Purchase Order";
                        }
                        action("Purchase - Invoice")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Purchase - Invoice';
                            RunObject = report "Purchase - Invoice";
                        }
                        action("Purchase - Credit Memo")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Purchase - Credit Memo';
                            RunObject = report "Purchase - Credit Memo";
                        }
                        action("Purchase - Receipt")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Purchase - Receipt';
                            RunObject = report "Purchase - Receipt";
                        }
                        action("Purchase - Return Shipment")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Purchase - Return Shipment';
                            RunObject = report "Purchase - Return Shipment";
                        }
                        action("Return Order Confirmation")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Return Order Confirmation';
                            RunObject = report "Return Order Confirmation";
                        }
                        action("Vendor-Payment Receipt")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Vendor - Payment Receipt';
                            RunObject = report "Vendor - Payment Receipt";
                        }
                        action("Purchase Document - Test")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Purchase Document - Test';
                            RunObject = report "Purchase Document - Test";
                        }
                        action("Item Tracking Appendix")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item Tracking Appendix';
                            RunObject = report "Item Tracking Appendix";
                        }
                    }
                    group("P Administration")
                    {
                        Caption = 'Administration';
                        action("Subcontracting Worksheet")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Subcontracting Worksheet';
                            RunObject = page "Subcontracting Worksheet";
                        }
                    }
                }
                group("Inventory and Costing")
                {
                    Caption = 'Inventory & Costing';
                    group("Inventory and Costing List")
                    {
                        action("Nonstock Item List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Nonstock Item List';
                            //RunObject = page "Nonstock Item List";
                        }
                        action("Stockkeeping Unit List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Stockkeeping Unit List';
                            RunObject = page "Stockkeeping Unit List";
                        }
                    }
                    group("P Tasks")
                    {
                        Caption = 'Tasks';
                        action("Item Journal")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item Journal';
                            RunObject = page "Item Journal";
                        }

                        action("Phys. Inventory Journal")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Phys. Inventory Journal';
                            RunObject = page "Phys. Inventory Journal";
                        }
                        action("Revaluation Journal")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Revaluation Journal';
                            RunObject = page "Revaluation Journal";
                        }
                        action("Item Reclass. Journal")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item Reclass. Journal';
                            RunObject = page "Item Reclass. Journal";
                        }
                        action("Recurring Item Jnl.")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Recurring Item Jnl.';
                            RunObject = page "Recurring Item Jnl.";
                        }
                    }
                    group("Costing")
                    {
                        Caption = 'Costing';
                        action("Standard Cost Worksheet")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Standard Cost Worksheet';
                            RunObject = page "Standard Cost Worksheet";
                        }
                    }

                }
                group("P Reports and Analysis")
                {
                    Caption = 'Reports and Analysis';
                    group("Planning Reports")
                    {
                        Caption = 'Planning';
                        action("Vendor - Payment Receipt")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Vendor - Payment Receipt';
                            RunObject = report "Vendor - Payment Receipt";
                        }
                        action("Purchase Reservation Avail.")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Purchase Reservation Avail.';
                            RunObject = report "Purchase Reservation Avail.";
                        }
                        action("Purchase Statistics")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Purchase Statistics';
                            RunObject = report "Purchase Statistics";
                        }
                        action("Vendor Item Catalog")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Vendor Item Catalog';
                            RunObject = report "Vendor Item Catalog";
                        }
                        action("Vendor - Balance to Date")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Vendor - Balance to Date';
                            RunObject = report "Vendor - Balance to Date";
                        }
                        action("Vendor - Detail Trial Balance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Vendor - Detail Trial Balance';
                            RunObject = report "Vendor - Detail Trial Balance";
                        }
                        // action("Vendor - List")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Vendor - List';
                        //     RunObject = report "Vendor - List";
                        // }
                        action("Vendor - Purchase List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Vendor - Purchase List';
                            RunObject = report "Vendor - Purchase List";
                        }
                        // action("Vendor - Summary Aging")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Vendor - Summary Aging';
                        //     RunObject = report "Vendor - Summary Aging";
                        // }
                        // action("Vendor - Top 10 List")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Vendor - Top 10 List';
                        //     RunObject = report "Vendor - Top 10 List";
                        // }
                        action("Vendor - Trial Balance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Vendor - Trial Balance';
                            RunObject = report "Vendor - Trial Balance";
                        }
                        action("Vendor/Item Purchases")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Vendor/Item Purchases';
                            RunObject = report "Vendor/Item Purchases";
                        }
                        action("Inventory Cost and Price List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Inventory Cost and Price List';
                            RunObject = report "Inventory Cost and Price List";
                        }
                        action("Inventory Purchase Orders")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Inventory Purchase Orders';
                            RunObject = report "Inventory Purchase Orders";
                        }
                       
                        action("Inventory - Cost Variance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Inventory - Cost Variance';
                            RunObject = report "Inventory - Cost Variance";
                        }
                        action("Inventory - Inbound Transfer")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Inventory - Inbound Transfer';
                            RunObject = report "Inventory - Inbound Transfer";
                        }
                        action("Inventory - List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Inventory - List';
                            RunObject = report "Inventory - List";
                        }
                        action("Inventory - Vendor Purchases")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Inventory - Vendor Purchases';
                            RunObject = report "Inventory - Vendor Purchases";
                        }
                        action("Item Substitutions")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item Substitutions';
                            RunObject = report "Item Substitutions";
                        }
                        action("Item/Vendor Catalog")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item/Vendor Catalog';
                            RunObject = report "Item/Vendor Catalog";
                        }
                        action("Nonstock Item Sales")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Nonstock Item Sales';
                            //RunObject = report "Nonstock Item Sales";
                        }
                        action("Prod. Order - Mat. Requisition")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Prod. Order - Mat. Requisition';
                            RunObject = report "Prod. Order - Mat. Requisition";
                        }
                        action("Prod. Order - Shortage List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Prod. Order - Shortage List';
                            RunObject = report "Prod. Order - Shortage List";
                        }
                    }

                    group("Order Processing Reports")
                    {
                        Caption = 'Order Processing';
                        action("Vendor/Items Purchases")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Vendor/Item Purchases';
                            RunObject = report "Vendor/Item Purchases";
                        }
                        action("Inventory Availability")
                        {
                            ApplicationArea = Suite, Basic;
                            Caption = 'Inventory Availability';
                            RunObject = report "Inventory Availability";
                        }
                        action("Inventory Cost and Prices List")
                        {
                            ApplicationArea = Suite, Basic;
                            Caption = 'Inventory Cost and Price List';
                            RunObject = report "Inventory Cost and Price List";
                        }
                        action("Inventory Posting - Test")
                        {
                            ApplicationArea = Suite, Basic;
                            Caption = 'Inventory Posting - Test';
                            RunObject = report "Inventory Posting - Test";
                        }
                        action("Inventory Purchases Orders")
                        {
                            ApplicationArea = Suite, Basic;
                            Caption = 'Inventory Purchase Orders';
                            RunObject = report "Inventory Purchase Orders";
                        }
                        action("Inventory-List")
                        {
                            ApplicationArea = Suite, Basic;
                            Caption = 'Inventory - List';
                            RunObject = report "Inventory - List";
                        }
                        action("Inventory - Reorders")
                        {
                            ApplicationArea = Suite, Basic;
                            Caption = 'Inventory - Reorders';
                            RunObject = report "Inventory - Reorders";
                        }
                        action("Inventory - Transaction Detail")
                        {
                            ApplicationArea = Suite, Basic;
                            Caption = 'Inventory - Transaction Detail';
                            RunObject = report "Inventory - Transaction Detail";
                        }
                        action("Inventory - Vendors Purchases")
                        {
                            ApplicationArea = Suite, Basic;
                            Caption = 'Inventory - Vendor Purchases';
                            RunObject = report "Inventory - Vendor Purchases";
                        }
                        action("Item Charges - Specification")
                        {
                            ApplicationArea = Suite, Basic;
                            Caption = 'Item Charges - Specification';
                            RunObject = report "Item Charges - Specification";
                        }
                        action("Items Substitutions")
                        {
                            ApplicationArea = Suite, Basic;
                            Caption = 'Item Substitutions';
                            RunObject = report "Item Substitutions";
                        }
                        action("Item/Vendors Catalog")
                        {
                            ApplicationArea = Suite, Basic;
                            Caption = 'Item/Vendor Catalog';
                            RunObject = report "Item/Vendor Catalog";
                        }
                    }
                    group("Inventory and Costing Reports")
                    {
                        Caption = 'Inventrory and Costing';
                        action("Adjust Cost - Item Entries")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Adjust Cost - Item Entries';
                            //RunObject = report "Adjust Cost - Item Entries";
                        }
                        action("Adjust Item Costs/Prices")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Adjust Item Costs/Prices';
                            RunObject = report "Adjust Item Costs/Prices";
                        }
                        action("RInventory Availability")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Inventory Availability';
                            RunObject = report "Inventory Availability";
                        }
                        action("RInventory - Cost Variance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Inventory - Cost Variance';
                            RunObject = report "Inventory - Cost Variance";
                        }
                        action("RInventory - Inbound Transfer")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Inventory - Inbound Transfer';
                            RunObject = report "Inventory - Inbound Transfer";
                        }
                        action("RInventory - List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Inventory - List';
                            RunObject = report "Inventory - List";
                        }
                        action("Invt. Valuation - Cost Spec.")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Invt. Valuation - Cost Spec.';
                            RunObject = report "Invt. Valuation - Cost Spec.";
                        }
                       
                        action("Item Age Composition - Value")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item Age Composition - Value';
                            RunObject = report "Item Age Composition - Value";
                        }
                        action("Item Expiration - Quantity")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item Expiration - Quantity';
                            RunObject = report "Item Expiration - Quantity";
                        }
                        action("RItem Charges - Specification")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item Charges - Specification';
                            RunObject = report "Item Charges - Specification";
                        }
                        action("Item Register - Quantity")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item Register - Quantity';
                            RunObject = report "Item Register - Quantity";
                        }
                        action("Item Register - Value")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item Register - Value';
                            RunObject = report "Item Register - Value";
                        }
                    }

                }
                group("Procurement Setup")
                {
                    Caption = 'Setup';
                    group("Planning Setup")
                    {
                        Caption = 'Planning';
                        action("Salespeople/Purchasers")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Salespeople/Purchasers';
                            RunObject = page "Salespersons/Purchasers";
                        }
                        action("Req. Worksheet Templates")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Req. Worksheet Templates';
                            RunObject = page "Req. Worksheet Templates";
                        }
                    }
                    group("Order Processing Setup")
                    {
                        Caption = 'Order Processing';
                        action("Standard Purchase Codes")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Standard Purchase Codes';
                            RunObject = page "Standard Purchase Codes";
                        }
                        action("Purchasing Codes")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Purchasing Codes';
                            RunObject = page "Purchasing Codes";
                        }
                        action("Shipment Methods")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Shipment Methods';
                            RunObject = page "Shipment Methods";
                        }
                        action("Return Reasons")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Return Reasons';
                            RunObject = page "Return Reasons";
                        }
                        action("Report Selection - Purchase ")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Report Selection - Purchase ';
                            //RunObject = page "Report Selection - Purchase ";
                        }
                    }
                    group("Inventory and Costing Setup")
                    {
                        Caption = 'Inventrory and Costing';
                        action("Units of Measure")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Units of Measure';
                            RunObject = page "Units of Measure";
                        }
                        action("Manufacturers")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Manufacturers';
                            RunObject = page "Manufacturers";
                        }
                        action("Product Groups")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Product Groups';
                            //RunObject = page "Product Groups";
                        }
                        action("Nonstock Item Setup")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Nonstock Item Setup';
                            //RunObject = page "Nonstock Item Setup";
                        }
                    }
                }

            }
            group(Legal)
            {
                group("Legal Management")
                {
                    group("Case Management")
                    {
                        Caption = 'Legal Case Managment';
                        group("Legal Case Management Lists")
                        {
                            Caption = 'Lists';
                            action("Case List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Case List';
                                RunObject = Page "Legal List";
                            }
                            action("Witness Line")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Witness Line';
                                RunObject = Page "Witness Line";
                            }
                            action("Advocate List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Advocate List';
                                RunObject = Page "Advocate List";
                            }
                            action("Approved Cases")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Cases';
                                RunObject = Page "Legal List Aproved";
                            }
                            action("Verdict List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Verdict List';
                                RunObject = Page "Verdict List";
                            }
                            action("Damages List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Damages List';
                                RunObject = Page "Damages List";
                            }

                        }
                    }

                    group("Legal Payments")
                    {
                        Caption = 'Payments';
                        group("Payment Lists")
                        {
                            action("Case Invoices")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Case Invoices';
                                RunObject = Page "Case Invoice";
                            }
                            action("Case Payment")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Case Payment';
                                RunObject = Page "Case Payment List";
                            }
                        }
                    }
                    group("Appealed Cases")
                    {
                        Caption = 'Appealed Cases';
                        group("Appealed Cases List")
                        {
                            action("Appealed Case")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Appealed Cases';
                                RunObject = Page "Appealed Legal List";
                            }
                        }
                    }
                    group("Closed Case")
                    {
                        Caption = 'Closed Cases';
                        group("Closed Cases List")
                        {
                            action("Closed Cases")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Appealed Cases';
                                RunObject = Page "Legal List Aproved";
                            }
                        }
                    }

                    group("Surety")
                    {
                        Caption = 'Surety Management';
                        group("Surety Lists")
                        {
                            action("Surety Management List")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Surety Management List';
                                RunObject = Page "Surety Management List";
                            }
                            action("Approved Surety Management")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Surety Management';
                                RunObject = page "Approved Surety Management";
                            }

                        }
                        Group("L Reports")
                        {
                            action("Surety Managemnt Report")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Advocate Report';
                                RunObject = Report "Surety Management Report";
                            }
                        }

                    }
                }
                group(ContractManagement)
                {
                    Caption = 'Contracts Management';
                    ToolTip = 'Contract mgt signing, renewal, termination, payment, invoice, reports';
                    group("Contract Management")
                    {
                        Caption = 'Contract Management';
                        action("Contracts list")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Contracts Details';
                            RunObject = Page "Contracts list";
                        }
                        action("Renewed Contracts list")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Renewed Contracts list';
                            RunObject = Page "Renewed Contracts list";
                        }
                        action("Terminated Contracts list")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Terminated Contracts list';
                            RunObject = Page "Terminated Contracts list";
                        }

                        action("Approved Contracts list")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Approved Contracts list';
                            RunObject = Page "Approved Contracts list";
                        }



                    }
                    group("Contract setUp")
                    {
                        Caption = 'Contract Setup';
                        action("Contract Type")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Contract Classification';
                            //RunObject = Page contract type

                        }
                        action("Contract Line")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Contract Line';
                            RunObject = Page "Contract Lines";

                        }
                        action("Contract Cycle")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Contract Cycle';
                            RunObject = Page "Contract Cycle";

                        }
                        action("Contract Lines Type")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Contract Lines Type';
                            RunObject = Page "Contract Lines Type";

                        }
                        action("Contracts Duration/ cycle")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Contracts Duration/ cycle';
                            RunObject = Page "Contract Cycle";
                        }
                        action("Contract Cycle Stage")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Contract Cycle Stage';
                            RunObject = Page "Contract Cycle Stage";
                        }

                    }
                    group(Invoice)
                    {
                        Caption = 'Invoice';
                        action("Contract Purchase Invoices")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Contract Purchase Invoices';
                            RunObject = Page "Contract Purchase Invoices";
                        }
                    }
                    group(Paiment)
                    {
                        Caption = 'Payment';
                        action(Payment)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Payment';
                            RunObject = Page "Payment Vouchers List";
                        }
                    }

                }
                group("Contract Reports")
                {
                    Caption = 'Contract Reports';
                    action("Detailed Contract Report")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Detailed Contract Report';
                        RunObject = report "Detailed Contract Report";
                    }
                    action("Contract Status")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Contract Status';
                        RunObject = report "Contract Status";
                    }
                    action("Contract Report")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Contract Report';
                        RunObject = report "Contract Report";
                    }
                }
                group("Reporting")
                {
                    Caption = 'Legal Management Reports';
                    group("L Reports and Analysis")
                    {
                        action("Case Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Case Report';
                            RunObject = Report "Case Report";
                        }
                        action("Advocate Cost Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Advocate Cost Report';
                            RunObject = Report "Avocate Cost Report";
                        }
                        action("Case Status Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Case Status Report';
                            RunObject = Report "Case Status Report";
                        }
                        action("Case Cost")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Case Cost';
                            RunObject = Report "Case Cost";
                        }
                        action("Advocate Report")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Advocate Report';
                            RunObject = Report "Advocate Report";
                        }
                    }


                }

            }

            group("Global Functions & SetUps")
            {
                group("System Edits Functions")
                {
                    group("System Edits")
                    {
                        Caption = 'System Edits';

                        action("System Edits  List")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "System Edits List";
                        }
                        action("Posted System Edits")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Posted System Edits List";
                        }

                    }
                    group("System Edits Setups")
                    {
                        Caption = 'System Edits Set-Ups';

                        action("System Edits Tables List")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "System Edits Tables";
                        }

                    }
                }
                group("System Reversals")
                {
                    Caption = 'System Reversals';

                    action("System Reversal List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "System Reversal List";
                    }
                    action("Reversed System Reversal List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Reversed System Reversal List";
                    }
                }

            }
            group("ICT Dept")
            {

                Group("Product Applications")
                {
                    Caption = 'Product Applications';
                    action("Product Application")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Product Applications';
                        RunObject = page "Product Factory List";
                    }
                }
                group("User Creation")
                {
                    Caption = 'User Creation Requests';
                    action("User Creation Requests")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'User Creation Requests';
                        RunObject = page "User Creation Request List";
                    }
                }
                group("User Termination")
                {
                    Caption = 'User Termination Requests';
                    action("User Termination Requests List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'User Termination Requests';
                        RunObject = page "User Termination Requests List";
                    }
                }
                Group("Permsision Requests")
                {
                    Caption = 'Permission Requests';
                    action("Permission Requests")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Permission Requests';
                        RunObject = page "Permission Requisition List";
                    }
                }
                Group("User Reactivation Request")
                {
                    Caption = 'User Reactivation Requests';
                    action("User Reactivation Requests")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'User Reactivation Request';
                        RunObject = page "User Reactivation List";
                    }
                }

            }
        }
    }
}
profile "Main Role Center"
{
    Caption = 'Main Role Center';
    RoleCenter = "Main Role Center";
    ProfileDescription = 'Main Role Center';
}
