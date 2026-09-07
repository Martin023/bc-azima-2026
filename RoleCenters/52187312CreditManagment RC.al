page 52187312 "Credit Management Role Center"
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
                    Caption = 'MFI List';
                    RunObject = Page "Member Group List";
                }

                action("Savings Account Register")
                {
                    ApplicationArea = All;
                    Caption = 'Savings Account Register';
                    RunObject = page "Savings Accounts";
                }
                action("Credit Accounts List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Credit Accounts';
                    RunObject = Page "Credit Accounts List";
                }
                group("Member Withdrawal")
                {
                    Caption = 'Member Withdrawal';
                    group("Member Withdrawal Notice")
                    {
                        //Visible = false;
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
                        //Visible = false;
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
                }

                //*************************DMU-ADDONS*****************************************//
                group("CRB Listing")
                {
                    Caption = 'CRB Listing';
                    group("Daily CRB Listing")
                    {
                        Caption = 'Daily CRB Listing Lists';
                        action("Daily CRB Listing - Metropol")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Daily CRB Listing - Metropol';
                            RunObject = Page "CRB DPI File Submissions";
                            RunPageView = where("CRB Institution" = Const('METROPOL'));
                        }
                    }

                    group("Monthly CRB Listing")
                    {
                        Caption = 'Monthly CRB Listing Lists';
                        action("Monthly CRB Listing ICE - Metropol")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Monthly CRB Listing (Individual) - Metropol';
                            RunObject = Page "CRB Monthly ICE File Subm.";
                            RunPageView = where("CRB Institution" = Const('METROPOL'));
                        }
                        action("Monthly CRB Listing NICE - Metropol")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Monthly CRB Listing (Non-Individual) - Metropol';
                            RunObject = Page "CRB Monthly NICE File Subm.";
                            RunPageView = where("CRB Institution" = Const('METROPOL'));
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
                        caption = 'Loan Application List All';
                        RunObject = page "Loan Application List";
                        //RunPageView=where("Global Dimension 1 Code"=filter())
                    }
                    // action("Loan Application List_BOSA")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     caption = 'Loan Application List(BOSA)';
                    //     RunObject = page "Loan Application List_BOSA";
                    //     RunPageView = where(Status = filter(open));
                    //     // RunPageView = where("Sent Back to CRM" = const(false), "Sent Back to M-Smart" = const(false));// Show all loans
                    // }
                    action("Loan Application List_FOSA")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Loan Application List(FOSA)';
                        RunObject = page "Loan Application List_FOSA";
                        Visible = false;
                        RunPageView = where("Sent Back to CRM" = const(false), "Sent Back to M-Smart" = const(false));
                    }
                    // action("Loan Application List_BL")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     caption = 'Loan Application List(Business Loans)';
                    //     RunObject = page "Loan Application List_BL";
                    // }
                    // action("Loan Application List_HR")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     caption = 'Loan Application List(HR Loans)';
                    //     RunObject = page "Loan Application List_HR";
                    // }
                    action("Loan Appraisal List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Loan Appraisal List';
                        RunObject = page "Appraisal Loans List";
                        // RunPageView = where("Source Unit" = const(BOSA));
                    }
                    action("Loan Approved List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Loan Approved List';
                        RunObject = page "Approved Loans List";
                        // RunPageView = where("Source Unit" = const(BOSA));
                    }
                    action("Deferred Loan Application List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Deferred Loans List';
                        RunObject = page "Deferred Loan Application List";
                        // RunPageView = where("Source Unit" = const(BOSA));
                    }
                    action("Rejected Loan Application List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Rejected/Archived Loans.';
                        RunObject = page "Rejected Loan Application List";
                        // RunPageView = where("Source Unit" = const(BOSA));
                    }


                }


                group("Loan Processed")
                {

                    Caption = 'Posted/Reversed Loans';
                    action("Running Loan List")
                    {
                        Caption = 'Running Loans List';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Loan Posted List";
                        RunPageView = where("Total Balance" = filter(<> 0));
                    }
                    action("Cleared Loan List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Cleared Loan List';
                        RunObject = page "Loan Posted List";
                        RunPageView = where("Source Unit" = filter(<> "HR LOANS"), "Total Balance" = filter(0));
                    }
                    action("Overpaid Loan List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Overpaid Loan List';
                        RunObject = page "Loan Posted List";
                        RunPageView = where("Source Unit" = filter(<> "HR LOANS"), "Total Balance" = filter(< 0));
                    }
                    action("Reversed Loan List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Reversed Loan List';
                        RunObject = page "Loan Posted List";
                        RunPageView = where("Source Unit" = filter(<> "HR LOANS"), "Reversed" = filter(true));
                    }
                    action("Loan Posted List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'All Loans Posted List';
                        RunObject = page "Loan Posted List";
                        RunPageView = where("Source Unit" = filter(<> "HR LOANS"));
                    }

                }
                group(LoanBatchingList)
                {
                    Caption = 'Partial/Batch Disbursements';
                    action("Loan Disbursement List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Loan Disbursement List';
                        RunObject = page "Loan Disbursement List";
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
                    group("Security Register")
                    {
                        Caption = 'Security Register';
                        action("Collateral Register - List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Open Collateral Register - List';
                            RunObject = page "Collateral Register - List";
                            RunPageView = where(Status = const(Open));
                        }
                        action("Pending Collateralls")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Pending Collateral';
                            RunObject = page "Collateral Register - List";
                            RunPageView = where(Status = const(Pending));
                        }
                        action("Rejected")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Collateral Register - List';
                            RunObject = page "Collateral Register - List";
                            RunPageView = where(Status = const(Rejected));
                        }
                        action("Approved")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Approved Collaterals';
                            RunObject = page "Collateral Register - List";
                            RunPageView = where(Status = const(Approved));
                        }
                        action("Archived")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Archived Collaterals';
                            RunObject = page "Collateral Register - List";
                            RunPageView = where(Status = const(Archived), "Lending Unit" = const(BOSA));

                        }
                    }
                    group("Collaterals Update")
                    {
                        action("Open Collateral Update")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open Collateral Updates';
                            RunObject = Page "System Edits List";
                            RunPageView = where("Table ID" = CONST(52185840), Status = CONST(Open));
                        }
                        action("Collateral Update Pending Approval")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Collateral Updates Pending Approval';
                            RunObject = Page "System Edits List";
                            RunPageView = where("Table ID" = CONST(52185840), Status = CONST(Pending));
                        }
                        action("Rejected Collateral Update")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Rejected Collateral Updates';
                            RunObject = Page "System Edits List";
                            RunPageView = where("Table ID" = CONST(52185840), Status = CONST(Rejected));
                        }
                        action("Approved Collateral Update")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved Collateral Updates';
                            RunObject = Page "System Edits List";
                            RunPageView = WHere("Table ID" = CONST(52185840), Status = CONST(Approved));
                        }
                        action("Posted Collateral Update")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Collateral Updates';
                            RunObject = Page "System Edits List";
                            RunPageView = where("Table ID" = CONST(52185840), Status = CONST(Approved), Posted = CONST(TRUE));
                        }
                    }
                    group("Collateral Collection")
                    {
                        Caption = 'Collateral Discharge';
                        action("Open Collateral Collection - List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Open Collateral Discharge - List';
                            RunObject = page "Collateral Collection - List";
                            RunPageView = WHERE(Status = filter(Open));
                        }
                        action("Pending Collateral Collection - List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Pending Collateral Discharge - List';
                            RunObject = page "Collateral Collection - List";
                            RunPageView = where(Status = filter(Pending));
                        }
                        action("Rejected Collateral Collection - List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Rejected Collateral Discharge - List';
                            RunObject = page "Collateral Collection - List";
                            RunPageView = where(Status = filter(Rejected));
                        }
                        action("Approved Collateral Collection - List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Approved Collateral Discharge - List';
                            RunObject = page "Collateral Collection - List";
                            RunPageView = WHERE(Status = filter(Approved));
                        }
                    }

                    // action("Collateral Collection - List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     caption = 'Collateral Collection - List';
                    //     RunObject = page "Collateral Collection - List";
                    // }
                    group("Security Perfection Tracking")
                    {
                        action("Securities at Credit")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Securities at Credit';
                            //RunObject = page "Perfected Securities List";
                            RunObject = page "Security Perfection List";
                            RunPageView = where("Perfection Stage" = CONST("At Credit"));
                        }
                        action("Securities at Legal")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Securities at Legal';
                            //RunObject = page "Perfected Securities List";
                            RunObject = page "Security Perfection List";
                            RunPageView = where("Perfection Stage" = CONST("At Legal"));
                        }
                        action("Securities Pending Instructions")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Securities Pending Instructions';
                            //RunObject = page "Perfected Securities List";
                            RunObject = page "Security Perfection List";
                            RunPageView = where("Perfection Stage" = CONST("At Legal - Pending Instructions to Advocate"));
                        }
                        action("Securities Pending Execution")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Securities Pending Execution';
                            //RunObject = page "Perfected Securities List";
                            RunObject = page "Security Perfection List";
                            RunPageView = where("Perfection Stage" = CONST("At Legal - Pending Execution"));
                        }
                        action("Securities At Advocate")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Securities At Advocate';
                            //RunObject = page "Perfected Securities List";
                            RunObject = page "Security Perfection List";
                            RunPageView = where("Perfection Stage" = CONST("At Advocate"));
                        }
                        action("Securities - Charge Preparation")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Securities - Charge Preparation';
                            //RunObject = page "Perfected Securities List";
                            RunObject = page "Security Perfection List";
                            RunPageView = where("Perfection Stage" = CONST("At Legal - Pending Execution"));
                        }
                        action("Securities Pending Registration")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Securities Pending Registration';
                            //RunObject = page "Perfected Securities List";
                            RunObject = page "Security Perfection List";
                            RunPageView = where("Perfection Stage" = CONST("At Advocate Pending Registration"));
                        }
                        action("Perfected Securities")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Perfected Securities';
                            //RunObject = page "Perfected Securities List";
                            RunObject = page "Security Perfection List";
                            RunPageView = where("Perfection Stage" = CONST(Registered));
                        }
                        action("Discharged Securities")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Discharged Securities';
                            RunObject = page "Security Perfection List";
                            RunPageLink = "Perfection Stage" = CONST(Discharged);
                        }
                    }
                }
                group("Loans Calculator")
                {
                    Caption = 'Loans Calculator';

                    action("Loan Calculator")
                    {
                        ApplicationArea = all;
                        Caption = 'Loan Calculator';
                        RunObject = page "Loan Calculator";
                    }
                }
            }
            group("Periodic Activities")
            {
                Caption = 'Periodic Activities';
                group("Monthly Billing")
                {
                    caption = 'Monthly Interest';
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
                    // action("Dailly Interest Buffer List")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Dailly Interest Buffer.';
                    //     RunObject = page "Dailly Interest Buffer";
                    // }
                }
                group("Account Activation")
                {
                    group("BOSA Account Activation")
                    {
                        Caption = 'BOSA Account Activation';
                        action("Open Account Activaion")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open BOSA Account Activation';
                            RunObject = Page "BOSA Account Activation List";
                            RunPageView = where(Status = filter(Open));
                        }
                        action("Account Activaion Pending Approval")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'BOSA Account Activation Pending Approval';
                            RunObject = Page "BOSA Account Activation List";
                            RunPageView = where(Status = filter(Pending));
                        }
                        action("Rejected Account Activaion")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Rejected BOSA Account Activation';
                            RunObject = Page "BOSA Account Activation List";
                            RunPageView = where(Status = filter(Rejected));
                        }
                        action("Approved Account Activaion")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved BOSA Account Activation';
                            RunObject = Page "BOSA Account Activation List";
                            RunPageView = where(Status = filter(Approved));
                        }
                        action("Posted Account Activation")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted BOSA Account Activation';
                            RunObject = Page "Posted BOSA Account Activation";
                        }
                    }
                    group("FOSA Account Activation")
                    {
                        action("FOSA Account Activation List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Account Activation List';
                            RunObject = page "Account Activation List";
                            RunPageView = where(Status = filter(Open), Activated = filter(false));
                        }
                        action("FOSA Account Activation Pending Approval")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Account Activation Pending Approval';
                            RunObject = page "Account Activation List";
                            RunPageView = where(Status = filter(Pending), Activated = filter(false));
                        }
                        action("FOSA Account Activation Approved")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Account Activation Approved';
                            RunObject = page "Account Activation List";
                            RunPageView = where(Status = filter(Approved), Activated = filter(false));
                        }
                        action("FOSA Account Activation Rejected")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Account Activation Rejected';
                            RunObject = page "Account Activation List";
                            RunPageView = where(Status = filter(Rejected), Activated = filter(false));
                        }
                        action("FOSA Account Activation Posted")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Account Activation Posted';
                            RunObject = page "Account Activation List";
                            RunPageView = where(Activated = filter(true));
                        }
                    }
                }
                group("LienTransactions")
                {
                    Caption = 'Lien Transactions.';
                    action("Lien Transactions List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Lien Transactions List';
                        RunObject = page "Lien Transactions List";
                        RunPageView = where(Posted = const(false), "Type" = Const(Lien));
                    }
                    action("Posted Lien Transactions List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Posted Lien Transactions List';
                        RunObject = page "Lien Transactions List";
                        RunPageView = where(Posted = const(true), "Type" = Const(Lien));
                    }
                }


                // 
                // group("Loan Categorization")
                // {
                //     caption = 'Loan Categorization';

                //     action("SASRA Loan Categorization.")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'SASRA Loan Categorization';
                //         RunObject = report "SASRA Loan Categorization";
                //     }
                // }
                group(SystemReversals)
                {
                    Caption = 'System Reversal';
                    action(OSystemReversal)
                    {
                        Caption = 'Open System Reversal';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "System Reversal List";
                        RunPageView = where(Status = filter(Open), Reversed = const(false));
                    }
                    action(PSystemReversal)
                    {
                        Caption = 'Pending System Reversal';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "System Reversal List";
                        RunPageView = where(Status = filter(Pending), Reversed = const(false));
                    }
                    action(ASystemReversal)
                    {
                        Caption = 'Approved System Reversal';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "System Reversal List";
                        RunPageView = where(Status = filter(Approved), Reversed = const(false));
                    }

                    action(PostedSystemReversal)
                    {
                        Caption = 'Posted System Reversal';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Reversed System Reversal List";
                    }
                    action(RejectedSysReversal)
                    {
                        Caption = 'Rejected System Reversal';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "System Reversal List";
                        RunPageView = where(Status = filter(Rejected), Reversed = const(false));
                    }
                }


                group("Standing Orders")
                {
                    group(Processing)
                    {
                        action("Open Standing Order List")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Standing Order List";
                            RunPageView = where(Status = const(Open));
                        }
                        action("Pending Standing Order List")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Standing Order List";
                            RunPageView = where(Status = const(Pending));
                        }

                    }
                    group("Active STOs")
                    {
                        action("Approved Standing Order List")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Standing Order List";
                            RunPageView = where(Status = const(Approved));
                        }
                        action("Standing Order Register List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Standing Order Register List';
                            RunObject = page "Standing Order Register List";
                        }
                    }
                    group(Achives)
                    {
                        action("Rejected Standing Order List")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Standing Order List";
                            RunPageView = where(Status = const(Rejected));
                        }
                        action("Stopped Standing Order List")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Standing Order List";
                            RunPageView = where(Status = const(Stopped));
                        }
                    }


                }

                group("Alerts and Notifications")
                {
                    group("SMS Alerts")
                    {
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
                    group("General SMS Alert")
                    {
                        Caption = 'General SMS Alerts';
                        action("General SMS Header")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "General SMS Header List";
                        }
                        action("Approved SMS")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Approved General SMS List";
                        }
                        action("Posted SMS")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Posted General SMS List";
                        }
                    }
                }

                group("Withheld Funds")
                {

                    action("Withheld Funds.")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "One Month Installments";
                    }

                }

            }
            //******************Dmu-loan activty************************************************//
            group("Loan Activity")
            {

                Caption = 'Debt Management Unit';

                group("Refunds& account Transfer")
                {
                    group("Bulk Refunds")
                    {
                        action("Bulk Account Refunds")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Bulk Account Refunds';
                            RunObject = Page "Bulk Account Refunds";
                            RunPageView = where(Posted = const(false), Status = const(open));
                        }
                        action("Bulk Account RefundsP")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Pending Bulk Account Refunds';
                            RunObject = Page "Bulk Account Refunds";
                            RunPageView = where(Posted = const(false), Status = const(pending));
                        }
                        action("Bulk Account RefundsA")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved Bulk Account Refunds';
                            RunObject = Page "Bulk Account Refunds";
                            RunPageView = where(Posted = const(false), Status = const(Approved));
                        }
                        action("Posted Bulk Account Refunds")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Bulk Account Refunds';
                            RunObject = Page "Bulk Account Refunds";
                            RunPageView = where(Posted = const(true));
                        }
                        action("Rejected Bulk Account Refunds")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Rejected Bulk Account Refunds';
                            RunObject = Page "Bulk Account Refunds";
                            RunPageView = where(Posted = const(false), status = const(Rejected));
                        }

                    }
                    group("Single Refunds")
                    {
                        action("Account Transfer")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Account Transfer List(Single Member)';
                            RunObject = page "Account Transfer List";
                            RunPageView = where(Status = filter(Open));
                        }
                        action("Pending Account Transfer")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Pending Account Transfer List';
                            RunObject = page "Account Transfer List";
                            RunPageView = where(Status = filter("Pending Approval"));
                        }
                        action("Approved Account Transfer")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved Account Transfer List';
                            RunObject = page "Account Transfer List";
                            RunPageView = where(Status = filter(Approved));
                        }
                        action("Rejected Account Transfer")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Rejected Account Transfer';
                            RunObject = page "Account Transfer List";
                            RunPageView = where(Status = filter(Rejected));
                        }
                        action("Posted Account Transfer")
                        {
                            ApplicationArea = Suite, FixedAssets;
                            Caption = 'Posted Account Transfer';
                            RunObject = page "Posted Account Transfer List";
                            RunPageView = where(Posted = filter(true));
                        }
                    }

                }
                group("Loan rescheduling")
                {
                    action("Open Rescheduling List")
                    {

                        ApplicationArea = Basic, Suite;
                        caption = 'Open Rescheduling List';
                        RunObject = page "Loan Rescheduling List";
                        RunPageLink = "Schedule Type" = filter(Reschedule), Status = filter(Open);

                    }
                    action("Pending Recheduling")
                    {

                        ApplicationArea = all;
                        Caption = 'Pending Rescheduling List';
                        RunObject = page "Loan Rescheduling List";
                        RunPageLink = "Schedule Type" = filter(Reschedule), Status = filter(Pending);
                    }
                    action("Approved Reshedulling List")
                    {
                        ApplicationArea = all;
                        Caption = 'Approved Rescheduling List';
                        RunObject = page "Loan Rescheduling List";
                        RunPageLink = "Schedule Type" = filter(Reschedule), Status = filter(Approved), Rescheduled = const(false);
                    }
                    action("Rescheduled Loans List")
                    {
                        ApplicationArea = all;
                        Caption = 'Rescheduled Loans List';
                        RunObject = page "Loan Rescheduling List";
                        RunPageLink = "Schedule Type" = filter(Reschedule), Rescheduled = const(true);
                    }
                }
                // group("Loan Restructuring")
                // {
                //     action("Open Loan Restructring List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         caption = 'Open Loan Restructuring List';
                //         RunObject = page "Loan Restructure List";
                //         RunPageLink = "Schedule Type" = filter(Restructure), Status = filter(Open);
                //     }
                //     action("Pending Loan Restructring List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         caption = 'Pending Loan Restructuring List';
                //         RunObject = page "Loan Restructure List";
                //         RunPageLink = "Schedule Type" = filter(Restructure), Status = filter(Pending);
                //     }
                //     action("Approved Loan Restructring List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         caption = 'Approved Loan Restructuring List';
                //         RunObject = page "Loan Restructure List";
                //         RunPageLink = "Schedule Type" = filter(Restructure), Status = filter(Approved), Rescheduled = const(false);
                //     }
                //     action("Restructured Loan Restructring List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         caption = 'Restructured Loan List';
                //         RunObject = page "Loan Restructure List";
                //         RunPageLink = "Schedule Type" = filter(Restructure), Status = filter(Approved), Rescheduled = const(true);
                //     }
                // }


                group("Guarantor Substitution")
                {
                    action("Open Guarantor Substitution")
                    {

                        ApplicationArea = Basic, Suite;
                        caption = 'Open Guarantor Substitution List';
                        RunObject = page "Guarantor Subsitution List";
                        RunPageLink = Status = filter(Open);//, "Sent Back to CRM" = const(false); Show all but provided a filter
                    }
                    action("Pending Guarantor Substitution")
                    {

                        ApplicationArea = Basic, Suite;
                        caption = 'Pending Guarantor Substitution List';
                        RunObject = page "Guarantor Subsitution List";
                        RunPageLink = Status = filter(Pending), "Sent Back to CRM" = const(false);
                    }
                    action("Approved Guarantor Substitution")
                    {

                        ApplicationArea = Basic, Suite;
                        caption = 'Approved Guarantor Substitution List';
                        RunObject = page "Guarantor Subsitution List";
                        RunPageLink = Status = filter(Approved), Posted = const(false), "Sent Back to CRM" = const(false);
                    }
                    action("Posted Guarantor Substitution")
                    {

                        ApplicationArea = Basic, Suite;
                        caption = 'Posted Guarantor Substitution List';
                        RunObject = page "Guarantor Subsitution List";
                        RunPageLink = Status = filter(Posted), Posted = const(true), "Sent Back to CRM" = const(false);
                    }
                    action("Deffred Guantor Substitution")
                    {
                        ApplicationArea = all;
                        Caption = 'Deffered Guarantor Substitution';
                        RunObject = page "Guarantor Subsitution List";
                        RunPageLink = Status = filter(Deffered), "Sent Back to CRM" = const(false);
                    }
                    action("Rejected Guarantor Substitution")
                    {
                        ApplicationArea = all;
                        Caption = 'Rejected Guarantor Substitution';
                        RunObject = page "Guarantor Subsitution List";
                        RunPageLink = Status = filter(Rejected), "Sent Back to CRM" = const(false);
                    }
                    // action("Guarantor Substitution Sent Send Back to CRM")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Guarantor Substitution Sent Send Back to CRM';
                    //     RunObject = page "Guarantor Subsitution List";
                    //     RunPageLink = "Sent Back to CRM" = const(true);
                    // }
                    action("Guarantor Substitution Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Guarantor Substitution Report';
                        RunObject = report "Guarantor Substitution Report";
                    }
                }
                group("Loan Guarantors List")
                {
                    action("Guarantors List")
                    {
                        ApplicationArea = all;
                        Caption = 'Guarantors Lists';
                        RunObject = page "Guarantors List";

                    }
                }
                //fusion

                // group("Manual Loans Upload")
                // {
                //     action("Guarantors Upload")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         RunObject = xmlport guarantors;
                //     }

                //     action("Loans Upload")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         RunObject = xmlport "Loans migration";
                //     }
                // }
                // group("Promise Topay")
                // {
                //     action("New Promise Topay")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         RunObject = page "Promise Topay Header";
                //         RunPageView = where("Promise Status" = const(New));

                //     }
                //     action("Active Promise Topay")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         RunObject = page "Promise Topay Header F";
                //         RunPageView = where("Promise Status" = const(Active));

                //     }
                //     action("Closed Promise Topay")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         RunObject = page "Promise Topay Header";
                //         RunPageView = where("Promise Status" = const(Closed));
                //     }
                // }
                group("Loan Recoveries")
                {
                    group("Loan Attachmnet")
                    {
                        action("Open Attachments")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Recovery & Attachment List";
                            RunPageLink = status = const(open), "Recovery Type" = const("Recovery and Attachment");
                        }
                        action("Pending Attachments")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Recovery & Attachment List";
                            RunPageLink = status = const(Pending), "Recovery Type" = const("Recovery and Attachment");
                        }
                        action("Approved Attachments")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Recovery & Attachment List";
                            RunPageLink = status = const(Approved), "Recovery Type" = const("Recovery and Attachment"), Action = const(" ");
                        }
                        action("Posted Attachments")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Posted Loan Recovery Header";
                            RunPageLink = status = const(Approved), "Recovery Type" = const("Recovery and Attachment"), Action = const(Recovered);

                        }
                        action("Deffered Attachments")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Recovery & Attachment List";
                            RunPageLink = status = const(Deffered), "Recovery Type" = const("Recovery and Attachment");

                        }
                        action("Rejected Attachments")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Posted Loan Recovery Header";
                            RunPageLink = status = const(Rejected), "Recovery Type" = const("Recovery and Attachment");
                        }
                    }



                    group(Reappotionments)
                    {
                        action("Open Reappotionments")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Loan Reappotionment List";
                            RunPageLink = status = const(open), "Recovery Type" = const(Reappotionment);
                        }
                        action("Pending Reappotionments")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Loan Reappotionment List";
                            RunPageLink = status = const(Pending), "Recovery Type" = const(Reappotionment);
                        }
                        action("Approved Reappotionments")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Loan Reappotionment List";
                            RunPageLink = status = const(Approved), "Recovery Type" = const(Reappotionment), Action = const(" ");
                        }
                        action("Posted Reappotionments")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Posted Loan Recovery Header";
                            RunPageLink = status = const(Approved), "Recovery Type" = const(Reappotionment), Action = const(Reappotioned);

                        }
                        action("Deffered Reappotionments")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Loan Reappotionment List";
                            RunPageLink = status = const(Deffered), "Recovery Type" = const(Reappotionment);

                        }
                        action("Rejected Reappotionments")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Posted Loan Recovery Header";
                            RunPageLink = status = const(Rejected), "Recovery Type" = const(Reappotionment);
                        }
                    }

                    group(Reversals)
                    {
                        action("Open Reversals")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Loan Reversal List";
                            RunPageLink = status = const(open), "Recovery Type" = const(Reversal);
                        }
                        action("Pending Reversals")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Loan Reversal List";
                            RunPageLink = status = const(Pending), "Recovery Type" = const(Reversal);
                        }
                        action("Approved Reversals")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Loan Reversal List";
                            RunPageLink = status = const(Approved), "Recovery Type" = const(Reversal), Action = const(" ");
                        }
                        action("Posted Reversals")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Posted Loan Recovery Header";
                            RunPageLink = status = const(Approved), "Recovery Type" = const(Reversal), Action = const(Reversed);

                        }
                        action("Deffered Reversals")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Loan Recovery Header";
                            RunPageLink = status = const(Deffered), "Recovery Type" = const(Reversal);

                        }
                        action("Rejected Reversals")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Posted Loan Recovery Header";
                            RunPageLink = status = const(Rejected), "Recovery Type" = const(Reversal);
                        }
                    }
                }

                action("Schedule All Loans")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Schedule All Loans";
                }
                // action("SASRA and FFallOff")
                // {
                //     ApplicationArea = Basic, Suite;
                //     RunObject = report "SASRA And FallOff";
                // }
                // group("Fall Off Report")
                // {

                //     action("Fall Off List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         RunObject = page "Loan Fall Off List";
                //     }
                //     action("FallOff Listing Errors")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         RunObject = page "Bulk Processing Errors List";
                //         RunPageView = where(Process = filter("Loan Fall Off"));
                //     }
                // }
                group("System Edit")
                {
                    Caption = 'System Edit';
                    action("All Edits List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'All Edits List';
                        RunObject = page "System Edits List";
                    }
                    group("Ongoing Edits")
                    {
                        action("Open Edits List")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "System Edits List";
                            RunPageView = where(Status = const(Open));
                        }
                        action("Pending Edits List")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "System Edits List";
                            RunPageView = where(Status = const(Pending));
                        }
                        action("Approved Edits List")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "System Edits List";
                            RunPageView = where(Status = const(Approved));
                        }
                        action("Deffered Edits List")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "System Edits List";
                            RunPageView = where(Status = const(Deffered));
                        }
                    }

                    group("Completed Edits")
                    {
                        action("Posted Edits")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Posted Edits';
                            RunObject = page "Posted System Edits List";
                        }
                        action("Rejected Edits")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'System Edits List';
                            RunObject = page "System Edits List";
                            RunPageView = where(Status = const(Rejected));
                        }

                    }

                }

            }
            group("Checkoff Bulk Upload")
            {
                Caption = 'Checkoff Bulk Upload';

                action(EmployerCodeList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Employers List';
                    RunObject = page "Employer Code List";
                }
                group("Product Variations")
                {
                    group("Loans Variations")
                    {
                        action("Open Variations List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open Loans Variations List';
                            RunObject = Page "Variations List";
                            RunPageLink = Status = filter(Open), "Sent Back to CRM" = const(false), "Variation Type" = filter(Loan);
                        }
                        action("Pending Variations List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Pending Loans Variations List';
                            RunObject = Page "Variations List";
                            RunPageLink = Status = filter("Pending"), "Variation Type" = filter(Loan);
                        }
                        action("Approved Variations List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved Loans Variations List';
                            RunObject = Page "Variations List";
                            RunPageLink = Status = filter(Approved), posted = const(false), "Variation Type" = filter(Loan);
                        }
                        action("Posted Variations List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Loans Variations List';
                            RunObject = Page "Variations List";
                            RunPageLink = Status = filter(Approved), posted = const(true), "Variation Type" = filter(Loan);
                        }
                        // action("Variations Send Back To CRM")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Variations Send Back To CRM';
                        //     RunObject = Page "Variations List";
                        //     RunPageLink = Status = filter(Open), "Sent Back to CRM" = const(true), "Variation Type" = filter(Loan);
                        // }
                    }
                    group("Savings Variations")
                    {
                        action("Open  Savings Variations List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open Savings Variations List';
                            RunObject = Page "Savings Variations List";
                            RunPageLink = Status = filter(Open), "Sent Back to CRM" = const(false), "Variation Type" = filter(savings);
                        }
                        action("Savings PendVariations List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Pending Savings Variations List';
                            RunObject = Page "Savings Variations List";
                            RunPageLink = Status = filter("Pending"), "Variation Type" = filter(savings);
                        }
                        action("Savings  AppVariations List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved Savings Variations List';
                            RunObject = Page "Savings Variations List";
                            RunPageLink = Status = filter(Approved), posted = const(false), "Variation Type" = filter(savings);
                        }
                        action("Posted sav Variations List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted  Savings Variations List';
                            RunObject = Page "Savings Variations List";
                            RunPageLink = Status = filter(Approved), posted = const(true), "Variation Type" = filter(savings);
                        }
                        // action("Sav' Variations Send Back To CRM")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = ' Savings Variations Send Back To CRM';
                        //     RunObject = Page "Savings Variations List";
                        //     RunPageLink = Status = filter(Open), "Sent Back to CRM" = const(true), "Variation Type" = filter(savings);
                        // }
                    }

                }
                group("Checkoff Advise Process")
                {
                    action("Checkoff Advise")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Checkoff Advice';
                        RunObject = Page "Checkoff Advice Header List";
                    }
                    action("Posted Checkoff Advise")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Checkoff Advice';
                        RunObject = Page "+Checkoff Advice Header List";
                    }
                    action("Checkoff Advice Logs")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Checkoff Advice Logs';
                        RunObject = Page "Checkoff Advice";
                    }

                }
                // action("Digit Custodian List")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Digit Custodian List';
                //     RunObject = page "Digit Custodian List";
                // }
                action("Product & references")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Product & references';
                    RunObject = page "Product & references";
                }
                group("Checkoff Posting")
                {
                    Caption = 'Checkoff Posting';
                    action("Checkoff Header List")
                    {
                        ApplicationArea = all;
                        Caption = 'Open Checkoff Header List';
                        RunObject = page "Checkoff Header List";
                        RunPageLink = Posted = const(false), Status = const(Open);
                    }
                    action("Pending Checkoff Header List")
                    {
                        ApplicationArea = all;
                        Caption = 'Pending Checkoff Header List';
                        RunObject = page "Checkoff Header List";
                        RunPageLink = Posted = const(false), Status = const(Pending);
                    }
                    action("Approved Checkoff Header")
                    {
                        Caption = 'Approved Checkoff Header List';
                        ApplicationArea = all;
                        RunObject = page "Checkoff Header List";
                        RunPageLink = Posted = const(false), Status = const(Approved);
                    }
                    action("Posted Checkoff Header")
                    {
                        Caption = 'Posted Checkoff Header List';
                        ApplicationArea = all;
                        RunObject = page "Checkoff Header List";
                        RunPageLink = Posted = const(true);
                    }
                    action("Rejected Checkoff Header")
                    {
                        Caption = 'Rejected Checkoff Header List';
                        ApplicationArea = all;
                        RunObject = page "Checkoff Header List";
                        RunPageLink = Posted = const(false), Status = const(Rejected);
                    }
                }


                // group("Revenue Collection")
                // {
                //     action("Open Revenue Collection List")
                //     {
                //         ApplicationArea = all;
                //         RunObject = page "Revenue Collection List";
                //         RunPageLink = Status = const(Open);
                //     }
                //     action("Pending Revenue Collection List")
                //     {
                //         ApplicationArea = all;
                //         RunObject = page "Revenue Collection List";
                //         RunPageLink = Status = const(Pending);
                //     }

                //     action("Approved Revenue Collection List")
                //     {
                //         ApplicationArea = all;
                //         RunObject = page "Revenue Collection List";
                //         RunPageLink = Status = const(Approved);
                //     }
                //     action("Rejected Revenue Collection List")
                //     {
                //         ApplicationArea = all;
                //         RunObject = page "Revenue Collection List";
                //         RunPageLink = Status = const(Rejected);
                //     }
                // }

            }

            //******************** END OF DMU-loan Activity*********************************************//
            //*************************************SMS ALERTS**********************************************************//

            //*************************************END OF SMS ALERTS**************************************************//
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
                action("My Individual Appraisals ESS CRM")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Individual Appraisals';
                    RunObject = page "My Individual Appraisals List";
                    ToolTip = 'View and manage my performance appraisals';
                }
                action("My Team Appraisals ESS CRM")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Team Appraisals (Supervisor)';
                    RunObject = page "Supervisor Appraisals List";
                    ToolTip = 'View and review appraisals for employees I supervise';
                }
                action("My Assigned Targets ESS CRM")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Assigned Targets';
                    RunObject = page "My Assigned Targets";
                    ToolTip = 'View targets assigned to me by my HOD';
                }
                action("My Department Targets HOD CRM")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Department Targets (HOD)';
                    RunObject = page "HRHOD Department Targets";
                    ToolTip = 'Set and manage targets for my department (HOD only)';
                }
                action("My CEO Goal Assignments ESS CRM")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My CEO Goal Assignments';
                    RunObject = page "My CEO Goal Assignments";
                    ToolTip = 'View and acknowledge CEO goals assigned to me as HOD';
                }
                action("Store Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Store Requisition';
                    RunObject = Page "Store Requisitions List";


                }



                // action("Overtime Claim List")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Overtime';
                //     RunObject = page "Overtime Claim List";
                // }

                action("System Rights Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'System Rights Requisition';
                    RunObject = page "Permission Requisition Card";
                }
                action("Payslip")
                {
                    ApplicationArea = all;
                    Caption = 'Payslip';
                    RunObject = report "Self Service Slip";
                }
                // group("Loan Application")
                // {

                //     action("New Application")
                //     {

                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Apply Staff Loan';
                //         RunObject = page "Self Loan Application List";
                //         RunPageLink = "Return To user" = const(false);
                //     }
                //     action("Resubmission")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Resubmission';
                //         RunObject = page "Self Loan Application List";
                //         RunPageLink = "Return To user" = const(true);
                //     }
                // }
                group("Employee Requests")
                {

                    group("Files")
                    {
                        action("File Details List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'File Details List';
                            RunObject = page "Files List";
                        }
                        action("Member Form List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open Member Form List';
                            RunObject = page "Member Form List";
                            RunPageView = where(Filed = filter(false));
                        }
                        action("Filed Member Form List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Filed member Form List';
                            RunObject = page "Member Form List";
                            RunPageView = where(Filed = filter(true));
                        }

                        action("File Volumes List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'File Volumes List';
                            RunObject = page "File Volumes List";
                        }
                        action("File Locations")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'File Locations';
                            RunObject = page "File Locations List";
                        }
                        action("Batch Number List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Batch No List';
                            RunObject = page "Batch No List";
                        }
                    }

                    group("File Tracking")
                    {
                        action("Open File Requests")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open File Tracker List';
                            RunObject = page "File Tracker List";
                            RunPageView = where("File Request Status" = filter(Open));
                        }
                        action("File Requests")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'File Requests';
                            RunObject = page "File Tracker List";
                            RunPageView = where("File Request Status" = filter(Requested));
                        }
                        action("Issued Files")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Issued Files';
                            RunObject = page "File Tracker List";
                            RunPageView = where("File Request Status" = filter(Issued));
                        }
                        action("Received Files")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Received Files';
                            RunObject = page "File Tracker List";
                            RunPageView = where("File Request Status" = filter(Received));
                        }
                        // action("Forwarded Files")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Forwarded Files';
                        //     RunObject = page "File Tracker List";
                        //     RunPageView = where("File Request Status" = filter(Forwarded));
                        // }
                        action("Closed File Requests")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Closed File Request';
                            RunObject = page "File Tracker List";
                            RunPageView = where("File Request Status" = filter(Closed));
                        }
                        // action("Overdue File Requests")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Overdue File Requests';
                        //     RunObject = page "File Tracker List";
                        //     RunPageView = where(Overdue = const(true));
                        // }
                        action("File List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Archived File Tracker List';
                            RunObject = page "File Tracker List";
                            RunPageView = where(Status = filter(archived));
                        }
                    }
                }

            }
            group("Reports")
            {
                Caption = 'Reports';

                group("Members Report")
                {
                    Caption = 'Member';

                    action("Member Balances Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member Balances Report';
                        RunObject = report "Member Balances Report";
                    }
                    action("Insurance Deposit Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Insurance Deposit Report';
                        RunObject = report "Insurance Deposit Report";
                    }
                    // action("Application")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Member Application Register';
                    //     RunObject = report "Member Application Register";
                    // }

                    action("Member Listing Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member Listing - List';
                        RunObject = report "Member Register";
                    }
                    action("Members Age")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Members Age';
                        RunObject = report "Members Age";
                    }

                    action("Member Details Check Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member Details Check Report';
                        RunObject = report "Member Details Check Report";
                    }
                    action("Members Summary Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member Employers Summary Report';
                        RunObject = report "Members Summary Report";
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

                    action("Withdrawal Notices")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Withdrawal Notices';
                        //RunObject = report "Withdrawal Notices";
                        RunObject = report "Withdrawal Notices";
                    }
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
                    // action("Loans Interest Register")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Posted Loans Register';
                    //     RunObject = report "Loan Interest  Register";
                    //     Visible = false;
                    // }
                    action("Loan Repayment & Total Balance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Expected Vs Received Loans Report.';
                        RunObject = report "Expected Loan Repayment";
                    }
                    action("Loan Insurance Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Loan Insurance Report';
                        RunObject = report "Loan Insurance Report";
                    }
                    action("Loan Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loans List Report';
                        RunObject = report "Loan Register";

                    }

                    action("Branch Loan Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Branch Loan Summary';
                        RunObject = report "Loan Summary Register";

                    }
                    action("Unit Loan Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Unit Lan Summary';
                        RunObject = report "Unit Loan Summary Register";

                    }
                    action("Product Loan Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Product Loan Summary';
                        RunObject = report "Product Loan Summary Register";

                    }
                    action("Restructured Loans Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Restructured loans Report';
                        RunObject = report "Restructured Loans report";
                    }
                    action("Loans Cleared Early")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Closed Loans Report';
                        RunObject = report "Loans Cleared Early";
                    }
                    action("Commercial Loans Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "Commercial Loan buyoffs";
                        Caption = 'Commercial Buyoffs Report';
                    }
                    action("Posted Loans Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Posted Loans Report';
                        RunObject = report "Posted Loans Report";
                    }
                    action("Reversed Loans")
                    {
                        ApplicationArea = all;
                        Caption = 'Reversed Loans Report';
                        RunObject = report "Reversed Loans Report";
                    }
                    action("Loans Underway Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Loans Underway Report';
                        RunObject = report "Loans Underway Report";
                    }
                    // action("SASRA Loan Categorization")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'SASRA Loan Categorization';
                    //     RunObject = report "SASRA Loan Categorization";
                    // }


                    action("Loan Approved Schedule")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Approved Schedule';
                        RunObject = report "Loan Approved Schedule";
                        Visible = false;

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
                    action("Loan Repayment Dues")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Repayment Dues';
                        RunObject = report "Loan Repayment Dues";

                    }
                    action("Loan Interest")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Interest';
                        RunObject = report "Loan Bills";
                        Visible = false;
                    }

                    // action("Loans Defaulter Aging - SASRA")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Loans Defaulter Aging - SASRA';
                    //     RunObject = report "Loans Defaulter Aging - SASRA";
                    // }
                    // action("Loan Provisioning Summary")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Risk Provisioning Summary';
                    //     // RunObject = report "Loans Provisioning Summary";
                    //     RunObject = report "Risk Provisioning";
                    //     //Visible = false;
                    // }
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
                        Visible = false;

                    }
                    action("Savings Datasheet Employer")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Savings Datasheet Employer';
                        RunObject = report "Savings Datasheet Employer";
                        Visible = false;

                    }
                    action("Loan Registered By Category")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Registered By Category';
                        RunObject = report "Premier Loan Report";
                        Visible = false;

                    }
                    action("Loans issued Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Issued Summary';
                        RunObject = report "Loan Issued Summary";
                        Visible = true;

                    }

                    action("Position on Borrowers in Sacco")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Position on Borrowers in Sacco';
                        RunObject = report "Position on Borrowers in Sacco";
                        Visible = false;

                    }
                    action("Loan Reschedule report")
                    {
                        ApplicationArea = all;
                        Caption = 'Resheduled Loans Report';
                        RunObject = report "Rescheduled Loans report";
                        Visible = false;

                    }
                    action("Recovery Loans")
                    {
                        ApplicationArea = all;
                        Caption = 'Recovery Loans Report';
                        RunObject = report "Recovery Fresh Loans";
                    }
                    action("Total Lianbilities Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Total Liabilities Report';
                        RunObject = report "Total Liabilities report";
                    }
                    action("Member Deposits")
                    {
                        ApplicationArea = all;
                        Caption = 'Member Deposits Report';
                        RunObject = report "Member Deposits Report";

                    }
                    action("JV Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'JV Report';
                        RunObject = report "JV Report";
                        Visible = false;

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
                        Visible = false;

                    }
                    action("Loan Repayment Dues Summaries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Repayment Dues Summaries';
                        RunObject = report "Loan Repayment Dues Summaries";

                    }
                    action("Loans Recovery Per Month")
                    {
                        ApplicationArea = all;
                        Caption = 'Loans Recovery per Month';
                        RunObject = report "Loans Recovery Per Month";
                    }

                    action("Montlhy Bill Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Montlhy Bill Summary';
                        RunObject = report "Monthly Bill Summary";
                        Visible = false;

                    }
                    action("Member Loan Statement")
                    {
                        ApplicationArea = all;
                        Caption = 'Member loan Statement';
                        RunObject = report "Member Loan Statement II";
                    }
                    action("Ideal Repayment Schedule")
                    {
                        ApplicationArea = all;
                        Caption = 'Loan Repayment Schedule';
                        RunObject = report "Ideal Repayment Schedule";
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
                        Visible = false;

                    }
                    // action("Asset Finance Loans")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Asset Finance Loans';
                    //     RunObject = report "Asset Finance Loans";
                    //     Visible = false;

                    // }
                    action("Summary Unallocated A/C")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Summary Unallocated A/C';
                        RunObject = report "Summary Unlocated A/C";
                        Visible = false;

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
                        Visible = false;
                    }
                    action("Direct Debit Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Direct Debit Report';
                        RunObject = report "Direct Debit Report";
                        Visible = false;

                    }

                    action("Generate CRB Data")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Generate CRB Data';
                        RunObject = report "Generate CRB Data";
                        Visible = false;
                    }
                    action("One Month Installment")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "One Month Installment";
                    }

                    action("Detailed Loan TAT")
                    {
                        ApplicationArea = "Basic, Suite";

                        RunObject = report "Detailed Loan TAT Report";
                    }
                    action("Loan Variation TAT")
                    {
                        ApplicationArea = "Basic, Suite";

                        RunObject = report " Loan Variation TAT";
                    }
                    action("Approved Loan")
                    {
                        ApplicationArea = "Basic, Suite";
                        Caption = 'Loan Appraised BY';

                        RunObject = report "Approved  Loans";
                    }

                    action("LoanCharges")
                    {
                        ApplicationArea = "Basic, Suite";
                        Caption = 'Excempted Loan Charges';

                        RunObject = report "Loan Excempted Charges";
                    }



                }
                group("Collaterals")
                {
                    action("Collateral Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Collateral Register';
                        RunObject = report "Security Report";
                    }
                    action("Loans & Collaterals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loans & Collaterals';
                        RunObject = report "Secured Loans Report";
                    }
                    action("Security Perfection")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Security Perfection';
                        RunObject = report "Perfection Register";
                    }
                }
                group("Periodic Activitites Reports")
                {
                    Caption = 'Periodic Activities';
                    // group("Dividend")
                    // {
                    //     action("Dividend Register")
                    //     {
                    //         ApplicationArea = Basic, Suite;
                    //         Caption = 'Dividend Register';
                    //         RunObject = report "Dividend Register";
                    //     }
                    //     action("Dividend Generation")
                    //     {
                    //         ApplicationArea = Basic, Suite;
                    //         Caption = 'Dividend Generation';
                    //         RunObject = report "Dividend Generation";
                    //     }
                    //     action("Dividend Posting Buffer")
                    //     {
                    //         ApplicationArea = Basic, Suite;
                    //         Caption = 'Dividend Posting Buffer';
                    //         RunObject = report "Dividend Posting Buffer";
                    //     }
                    //     action("Dividend Posting")
                    //     {
                    //         ApplicationArea = Basic, Suite;
                    //         Caption = 'Dividend Posting';
                    //         RunObject = report "Dividend Posting";
                    //     }
                    //     action("Dividend Register II")
                    //     {
                    //         ApplicationArea = Basic, Suite;
                    //         Caption = 'Dividend Register';
                    //         RunObject = report "Dividend Register";
                    //     }
                    //     action("Dividend Register Summary")
                    //     {
                    //         ApplicationArea = Basic, Suite;
                    //         Caption = 'Dividend Register Summary';
                    //         RunObject = report "Dividend Register Summary";
                    //     }
                    //     action("Dividend Statement")
                    //     {
                    //         ApplicationArea = Basic, Suite;
                    //         Caption = 'Dividend Statement';
                    //         RunObject = report "Dividend Statement";
                    //     }
                    //     action("Dividend Register Filtered")
                    //     {
                    //         ApplicationArea = Basic, Suite;
                    //         Caption = 'Dividend Register Filltered';
                    //         RunObject = report "Dividend Register Filtered";
                    //     }

                    // }
                    // group("Monthly Billings")
                    // {
                    //     Caption = 'Monthly Billing';
                    //     action("Charge Monthly Fee")
                    //     {
                    //         ApplicationArea = Basic, Suite;
                    //         Caption = 'Charge Monthly Fee';
                    //         RunObject = report "Charge Monthly Fee";
                    //     }
                    //     action("Montlhly Bill Summary")
                    //     {
                    //         ApplicationArea = Basic, Suite;
                    //         Caption = 'Montlhly Bill Summary';
                    //         RunObject = report "Monthly Bill Summary";
                    //     }
                    //     action("Dailly Interest Buffer")
                    //     {
                    //         ApplicationArea = all;
                    //         Caption = 'Dailly Interest';
                    //         RunObject = report "Dailly Billing Process";
                    //     }


                    // }
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


                }

                group("Sasra")
                {
                    Caption = 'Sasra';
                    action("Sasra Deposit Return")
                    {
                        ApplicationArea = all;
                        Caption = 'Sasra Deposit Return';
                        RunObject = report "SASRA Deposit Return";
                    }
                    action("Insider Lending Sasra")
                    {
                        ApplicationArea = all;
                        RunObject = report "Insider Lending Report";
                    }
                    action("Sectoral Lending")
                    {
                        ApplicationArea = all;
                        RunObject = report "Sectoral Lending";
                    }
                    action("Loan Provisioning Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Risk Provisioning Summary';
                        // RunObject = report "Loans Provisioning Summary";
                        RunObject = report "Risk Provisioning";
                        //Visible = false;
                    }
                    action("Loans Arrears HISTORICAL")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loans Arrears HISTORICAL';
                        RunObject = report "Loans Arrears HISTORICAL";
                    }

                    // action("User Groups and Permission Report")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'User Groups and Permission Report';
                    //     RunObject = report "User Groups Permision Report";
                    // }
                    // action("Sasra Staff Access Granted")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Sasra Staff Access Granted';
                    //     RunObject = report "Sasra Staff Access Granted";
                    // }
                    // action("Sasra Staff Positions")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Sasra Staff Positions';
                    //     RunObject = report "Sasra Staff Positions";
                    // }
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
                    // action("Unpaid Deposits Claims")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Unpaid Deposits Claims';
                    //     RunObject = report "Unpaid Deposits Claims";
                    // }

                    // action("Anti-Money Laundering Report")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Anti-Money Laundering Report';
                    //     RunObject = report "Anti-Money Laundering Report";
                    // }

                    // action("Transaction Log-Finance")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Transaction Log-Finance';
                    //     RunObject = XMLPort "Transaction Log-Finance";
                    // }
                }
                //*******************DMU-ADDITIONAL REPORTS*******************************************************//
                action("Loan Attachment Report")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Loan Attachment";
                }
                action("Loan Attachment Report II")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Loan Attachment II";
                }
                action("Loan Reappotionment")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Reappotionment Report";
                }
                action("Loan Reappotionment II")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Loan Reappotionment Report II";
                }
                action("Loan Reversal")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Loan Detachment";
                }
                action("Loan Reversal II")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Loan Detachment II";
                }
                action("Loan Ageing Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Loan Ageing';
                    RunObject = report "Loan Ageing Report";
                }
                action("Staff Daily Transactions")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Staff Daily Transactions";
                }
                // action("Promise To Pay Report")
                // {
                //     ApplicationArea = Basic, Suite;
                //     RunObject = report "Promise To Pay Report";
                // }
                group("CRB Daily")
                {
                    action("Process CRM Daily")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "CRB Daily Manual";
                    }
                    action("CRB Daily List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "CRB Daily Manual";
                    }

                    action("CRB Daily Errors")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Bulk Processing Errors List";
                        RunPageView = where(Process = filter("CRB Daily"));
                    }
                }
                // action("CRB Monthly Report")
                // {
                //     ApplicationArea = Basic, Suite;
                //     RunObject = report "CRB Monthly Report";
                // }
                group("CRB Monthly")
                {
                    action("Process CRB Monthly")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "CRB Monthly Manual";
                    }
                    action("CRB Monthly List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "CRB Monthly Manual List";
                    }

                    action("CRB Monthly Errors")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Bulk Processing Errors List";
                        RunPageView = where(Process = filter("CRB Monthly"));
                    }
                }
                action("CRB Attached Report")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "CRB Monthly Attached";
                }
                action(Notices)
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Notices Report";
                }
                // group("Fall Off Report")
                // {

                //     action("Fall Off List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         RunObject = page "Loan Fall Off List";
                //     }
                //     action("FallOff Listing Errors")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         RunObject = page "Bulk Processing Errors List";
                //         RunPageView = where(Process = filter("Loan Fall Off"));
                //     }
                //     // action("Customer Numbers")
                //     // {
                //     //     ApplicationArea = Basic, Suite;
                //     //     RunObject = report "Customer Numbers";
                //     // }
                // }
                // group("Loan Listing")
                // {
                //     action("Loan Listing process")
                //     {
                //         Caption = 'Process Loan Listing';
                //         ApplicationArea = Basic, Suite;
                //         RunObject = report "Loans Listing Report";
                //     }
                //     action("Loan Listing Report List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         RunObject = page "Loan Listing Report List";
                //     }

                //     action("Loan Listing Errors")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         RunObject = page "Bulk Processing Errors List";
                //         RunPageView = where(Process = filter("Loan Listing"));
                //     }
                // }


            }

            group("Credit Management Setups")
            {

                Caption = 'Setup';
                group("General")
                {
                    caption = 'General';

                    action("General Set-Up")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'General Set-Up';
                        RunObject = page "General Setup";
                    }
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
                    // action("Present Officers")
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Present Officers Setups';
                    //     RunObject = page "Present Users";

                    // }

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
                        Caption = 'Financial Appraisal';
                        RunObject = page "Financilal Appraisal";
                    }
                    action("Tired Charges")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tiered Charges List';
                        RunObject = page "Tiered Charges List";
                    }

                }


                // group("Notifications")
                // {
                //     Action("Notification Setup")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Notification Setup';
                //         RunObject = page "Notification Setup";
                //     }
                // }
                group("Notifications")
                {
                    action("Credit Notifications")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page NotificationSetupSms;
                        RunPageLink = "Notification" = CONST(Perfection), Notification = const("Collateral Discharge"), Notification = const("Lending Units");
                    }
                    // action("Lending Unit Notifications")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     RunObject = page NotificationSetupSms;
                    //     RunPageLink = Notification = const("Collateral Discharge");
                    // }
                }
                //**********DMU Additional Setups***********************************//
                group(DMUSetUps)
                {
                    action("DMU SMS Templates")
                    {
                        ApplicationArea = All;
                        RunObject = page "SMS Templates";
                    }
                    action("Present Users")
                    {
                        ApplicationArea = All;
                        Caption = 'Present Users Setups';
                        RunObject = page "Present Users";

                    }
                    action("System Edits Reasons")
                    {
                        ApplicationArea = All;
                        RunObject = page "System Edits Reasons";

                    }
                    action("CF Stations")
                    {
                        ApplicationArea = All;
                        RunObject = page "CF Station Actions List";

                    }


                }
            }
        }
        area(Reporting)
        {
            action("Members Portal")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Members Portal';
                RunObject = codeunit "Members Portal Link";
            }
            action("Customer Management Portal")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customer Management Portal';
                RunObject = codeunit "Customer Management Portal Url";
            }
        }
    }
}


profile "Credit Management Role Center"
{
    Caption = 'Credit Management Role Center';
    RoleCenter = "Credit Management Role Center";
    ProfileDescription = 'Credit Management Role Center';
}
