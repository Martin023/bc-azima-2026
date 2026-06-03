namespace MNS.MNS;
using System.Email;
using MNSProjectMwanga.MNSProjectMwanga;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Bank.BankAccount;
using System.Automation;

page 52186686 "Credit Officers RC"
{
    Caption = 'Credit Officers RC';
    PageType = RoleCenter;


    layout
    {
        area(RoleCenter)
        {
            part(Control76; CustomHeadline)
            {
                ApplicationArea = Basic, Suite;
            }
            part("Credit Officer"; "Credit Officers Cue Page")
            {
                Caption = 'Activities';

                ApplicationArea = Basic;
            }
            part("Emails"; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
            systempart(Control1901377608; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {

        area(Sections)
        {
            group("Accounts")
            {
                Caption = 'Accounts';
                action("Saving Account Application")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Saving Account Application';
                    RunObject = page "Savings Account Application";
                }
                action("Savings Accounts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Savings Accounts List';
                    RunObject = page "Savings Accounts";
                    ;
                }
                action("Banking Closure List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Account Closure List';
                    RunObject = page "Banking Closure List";
                }
                action("Account Activation List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Account Activation List';
                    RunObject = page "Account Activation List";
                }
                action("Account Changes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'FOSA Account Change Logs';
                    RunObject = report "FOSA Account Change Logs";
                }
                action(MemberList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Member List';
                    RunObject = page "Member List";
                }
                action(BankAccounts)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Accounts List';
                    //RunObject = page "Bank Account List";
                    RunObject = page "Bank Account List";
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
                    group("Risk Claims")
                    {

                        action("Risk Claim List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Risk Claim List';
                            RunObject = Page "Risk Claim List";

                        }

                    }
                }

            }


            group("Banking Operations")
            {
                Caption = 'Banking Operations';
                group("Cashier")
                {
                    Caption = 'Cashier And Treasury Transactions';
                    group(Cashiers)
                    {
                        action("Cashier Transactions")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open Cashier Transactions';
                            RunObject = page "Cashier Transactions List";
                            RunPageView = where(Status = filter(Open));
                        }
                        action("Pending Cashier Transactions")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Pending Cashier Transactions';
                            RunObject = page "Cashier Transactions List";
                            RunPageView = where(Status = filter("Pending Approval"));
                        }
                        action("Posted Cashier Transactions")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Cashier Transactions';
                            RunObject = page "Posted Cashier Transactions";
                        }
                        group(CashierReports)
                        {
                            Caption = 'Cashier Reports';

                            action("Teller Specifications Report")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Teller Specifications Report';
                                RunObject = report "Teller Specifications Report";
                            }
                            action("Cashier Daily Report")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Cashier Report';
                                RunObject = report "Cashier Deposits Withdrawals";
                            }
                            action("Cashier Cheque Deposits")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Cashier Cheque Deposits Report';
                                RunObject = report "Cashier Cheque Deposits";
                            }
                            // action("MPESA Account Statement")
                            // {
                            //     ApplicationArea = Basic, Suite;
                            //     Caption = 'MPESA Account Statement Report';
                            //     RunObject = report "MPESA Account Statement";
                            // }
                        }
                    }
                    group(Receipt)
                    {
                        Caption = 'Receipts';
                        action("Receipt List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Receipts';
                            RunObject = page "Receipts List";
                        }
                        action(" Posted Receipt List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = ' Posted Receipts';
                            RunObject = page "Posted Receipt List";
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
                    group(TreasuryCashierTransaction)
                    {
                        Caption = 'Treasury & Cashier Transactions';

                        action("Treasury & Cashier Transactions")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Treasury & Cashier Transactions';
                            RunObject = page "Treasury Cashier List";
                            RunPageView = where(Posted = const(false));
                        }
                        action("Treasury Cashier Transactions")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Treasury & Cashier Transactions';
                            RunObject = page "Treasury Cashier List";
                            RunPageView = where(Posted = const(true));
                        }
                        // action("Treasury  Cashier Transactions")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Treasury Report';
                        //     RunObject = report "Treasury Deposits Withdrawals";
                        // }

                    }
                    action(DailyTrans)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Daily FOSA Transaction Report';
                        RunObject = report "Daily Transactions Report";
                    }
                }
                group("Transfers")
                {
                    Caption = 'Transfers';
                    group(Account)
                    {
                        Caption = 'Account Transfer';
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
                    group(Interbank)
                    {
                        Caption = 'InterBank Transfers';
                        action("Interbank Transfer")
                        {
                            ApplicationArea = Suite, FixedAssets;
                            Caption = 'InterBank Transfer';
                            RunObject = page "InterBank Transfers List";
                        }
                        action("Posted Interbank Transfer")
                        {
                            ApplicationArea = Suite, FixedAssets;
                            Caption = 'Posted InterBank Transfer';
                            RunObject = page "Posted Bank & Cash Transfers";
                        }

                    }
                }
                group(Payments)
                {
                    Caption = 'Payments';
                    group("Petty Cash")
                    {
                        Caption = 'Petty Cash';
                        action(PettyCash)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Petty Cash List';
                            RunObject = page "Petty Cash Vouchers List";
                        }
                        action(PPettyCash)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Petty Cash List';
                            RunObject = page "Posted Petty Cash Vouchers";
                        }
                    }
                    group(BBFF)
                    {
                        Caption = 'BBF';
                        action(BBF)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'BBF List';
                            RunObject = page "BBF SinkFund List";
                        }
                        action(ApprBBF)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved BBF List';
                            RunObject = page "Approved BBF SinkFund List";
                        }
                        action(PostedBBF)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted BBF List';
                            RunObject = page "Paid SinkFund List";
                        }
                    }

                    group("Fosa Payment Voucher")
                    {
                        action(" Open FOSA Payment Vouchers List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open FOSA Payment Voucher';
                            RunObject = page "FOSA Payment Voucher List";
                            RunPageLink = Status = CONST(Open);
                        }
                        action("Pending FOSA Payment Vouchers List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = ' Pending Payment Voucher';
                            RunObject = page "FOSA Payment Voucher List";
                            RunPageLink = Status = filter("Pending Approval" | Pending);
                        }
                        action("Approved FOSA Payment Vouchers List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = ' Approved Payment Voucher';
                            RunObject = page "FOSA Payment Voucher List";
                            RunPageLink = Status = CONST("Approved");
                        }

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

                //Loans
                group("Loans")
                {
                    Caption = 'Loans';
                    group("Loan Processing FOSA")
                    {

                        Caption = 'Loan Applications FOSA';

                        action("Loan Application List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Loan Application List All';
                            RunObject = page "Loan Application List";
                        }

                        action("Loan Application List_FOSA")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Loan Application List(FOSA)';
                            RunObject = page "Loan Application List_FOSA";
                            RunPageView = where("Sent Back to CRM" = const(false), "Sent Back to M-Smart" = const(false));
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
                        action("Applications Sent Back To CRM")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Application Send Back To CRM';
                            RunObject = page "Loan Application List_FOSA";
                            RunPageView = where("Sent Back to CRM" = const(true));
                        }
                        action("Applications Sent Back To M-Smart")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Applications Send Back To M-Smart';
                            RunObject = page "Loan Application List_FOSA";
                            RunPageView = where("Sent Back to M-Smart" = const(true));
                        }
                    }


                    group("Loan Processing Business Loans")
                    {

                        Caption = 'Loan Processing Business Loans';
                        action("Loan Application List BL")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Loan Application List BL';
                            RunObject = page "Loan Application List_BL";
                            RunPageView = where("Sent Back to CRM" = const(false), "Sent Back to M-Smart" = const(false));
                        }
                        action("Loan Appraisal List FOSA")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Loan Appraisal List BL';
                            RunObject = page "Appraisal Loans List_BL";
                        }
                        action("Loan Approved List FOSA")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Loan Approved List BL';
                            RunObject = page "Approved Loans List_BL";
                        }
                        action("Loan Disbursement List  BL")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Loan Disbursement List BL';
                            RunObject = page "Loan Disbursement List";
                        }
                        action("Deferred Loan Application List BL")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Deferred Loan Application List BL';
                            RunObject = page "Deferred Loan Application List";
                        }
                        action("Rejected Loan Application List FOSA")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Rejected/Archived Loans BL';
                            RunObject = page "Rejected Loan Application List";
                        }
                        action("Loan Archived List BL")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Loan Archived List BL';
                            RunObject = page "Loan Application List";
                            RunPageView = where(Status = filter(Archived));
                        }
                        action("Loans Send Back to CRM FOSA")
                        {
                            ApplicationArea = all;
                            Visible = true;
                            caption = 'Loans Send Back to CRM BL';
                            RunObject = page "Loan Application List_BL";
                            RunPageView = where("Sent Back to CRM" = const(true));
                        }
                        action("Loans Send Back to M-Smart")
                        {
                            ApplicationArea = all;
                            Visible = true;
                            caption = 'Loans Send Back to M-Smart BL';
                            RunObject = page "Loan Application List_BL";
                            RunPageView = where("Sent Back to CRM" = const(true));
                        }
                        action("Loan Calculator")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Loan Calculator';
                            RunObject = page "Loan Application Card Dummy";
                        }

                    }

                    group("Loan Processing")
                    {
                        Caption = 'Loan Processing BOSA';
                        // action("Loan Application List_BOSA")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     caption = 'BOSA Loan Application List';
                        //     RunObject = page "Loan Application List_BOSA";
                        //     RunPageView = where(Status = filter(open));
                        //     // RunPageView = where("Sent Back to CRM" = const(false), "Sent Back to M-Smart" = const(false));// Show all loans
                        // }

                        action("BOSA Loan Appraisal List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'BOSA Loan Appraisal List';
                            RunObject = page "Appraisal Loans List";
                            RunPageView = where("Source Unit" = const(BOSA));
                        }
                        action("BOSA Loans Approved List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'BOSA Loan Approved List';
                            RunObject = page "Approved Loans List";
                            RunPageView = where("Source Unit" = const(BOSA));
                        }
                        // action("Loan Disbursement List")
                        action("BOSA Deferred Loan Application List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Deferred BOSA Loans List';
                            RunObject = page "Deferred Loan Application List";
                            RunPageView = where("Source Unit" = const(BOSA));
                        }
                        action("Rejected BOSA Loan Application List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Rejected/Archived BOSA Loans.';
                            RunObject = page "Rejected Loan Application List";
                            RunPageView = where("Source Unit" = const(BOSA));
                        }

                        // action("Loans Send Back to CRM")
                        // {
                        //     ApplicationArea = all;
                        //     Visible = true;
                        //     caption = 'BOSA Loans Send Back to CRM';
                        //     RunObject = page "Loan Application List_BOSA";
                        //     RunPageView = where("Sent Back to CRM" = const(true));
                        // }
                        // action("BOSA Loans Send Back to M-Smart")
                        // {
                        //     ApplicationArea = all;
                        //     Visible = true;
                        //     caption = 'Loans Send Back to M-Smart';
                        //     RunObject = page "Loan Application List_BOSA";
                        //     RunPageView = where("Sent Back to CRM" = const(true));
                        // }

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
                        action("Loan Ageing Report")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = report "Loan Ageing Report";
                        }
                    }

                }

                group(PeriodicActivities)
                {
                    Caption = 'Periodic Activities';
                    group("Loan Activity")
                    {

                        Caption = 'Periodic Loan Activities';
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
                        group("Loan Restructuring")
                        {
                            action("Open Loan Restructring List")
                            {
                                ApplicationArea = Basic, Suite;
                                caption = 'Open Loan Restructuring List';
                                RunObject = page "Loan Restructure List";
                                RunPageLink = "Schedule Type" = filter(Restructure), Status = filter(Open);
                            }
                            action("Pending Loan Restructring List")
                            {
                                ApplicationArea = Basic, Suite;
                                caption = 'Pending Loan Restructuring List';
                                RunObject = page "Loan Restructure List";
                                RunPageLink = "Schedule Type" = filter(Restructure), Status = filter(Pending);
                            }
                            action("Approved Loan Restructring List")
                            {
                                ApplicationArea = Basic, Suite;
                                caption = 'Approved Loan Restructuring List';
                                RunObject = page "Loan Restructure List";
                                RunPageLink = "Schedule Type" = filter(Restructure), Status = filter(Approved);
                            }
                            action("Restructured Loan Restructring List")
                            {
                                ApplicationArea = Basic, Suite;
                                caption = 'Restructured Loan List';
                                RunObject = page "Loan Restructure List";
                                RunPageLink = "Schedule Type" = filter(Restructure), Status = filter(Approved), Rescheduled = const(true);
                            }
                        }
                        action("Guarantor Substitution List")
                        {
                            ApplicationArea = Basic, Suite;
                            caption = 'Guarantor Substitution List';
                            RunObject = page "Guarantor Subsitution List";
                        }

                        group("Case Forwarding")
                        {
                            group("MKey Case Forwarding;")
                            {
                                action("Mkey Unforwarded Cases")
                                {
                                    ApplicationArea = Basic, Suite;
                                    RunObject = page "MKey Sent Cases";
                                    RunPageView = where("Originating Status" = const(New));
                                }
                                action("Mkey forwarded Cases")
                                {
                                    ApplicationArea = Basic, Suite;
                                    RunObject = page "MKey Sent Cases";
                                    RunPageView = where("Originating Status" = const(Sent));

                                }
                                action("Mkey Actioned Cases")
                                {
                                    ApplicationArea = Basic, Suite;
                                    RunObject = page "MKey Sent Cases";
                                    RunPageView = where("Originating Status" = const("Sent & Actioned"));

                                }
                            }

                            group("DMU Case Forwarding;")
                            {

                                action("Unforwarded Cases")
                                {
                                    ApplicationArea = Basic, Suite;
                                    RunObject = page "Unforwarded Cases";
                                }
                                action("Forwarded Cases")
                                {
                                    ApplicationArea = Basic, Suite;
                                    RunObject = page "Forwarded Cases";
                                }
                                action("Received Cases")
                                {
                                    ApplicationArea = Basic, Suite;
                                    RunObject = page "Received Cases";
                                }
                                action("Actioned Cases")
                                {
                                    ApplicationArea = Basic, Suite;
                                    RunObject = page "Actioned Cases";
                                }

                            }
                        }

                    }

                    group(FOSAPeriodicActivities)
                    {
                        Caption = 'FOSA Periodic Activities';
                        group(Salries)
                        {
                            Caption = 'Salaries';
                            action("Salary Lists")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Salary Lists';
                                RunObject = page "Salary Lists";
                            }
                            action("Posted Salary Lists")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Posted Salary Lists';
                                RunObject = page "Posted Salary List";
                            }
                        }
                        group(ChargeOverdrawn)
                        {
                            Caption = 'Accounts Activities';
                            action("ChargeOverAccounts")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Charge Overdrawn Accounts';
                                RunObject = report "Process Interest Calculation";
                            }
                            action("DormantAccount")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Generate Dormant Accounts';
                                RunObject = report "Generate Dormant Accounts";
                            }
                        }
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
                    // action("Standing Order Control List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Standing Order Control List';
                    //     RunObject = page "Standing Order Control List";
                    // }
                }
                group(RTGS)
                {
                    Caption = 'RTGS';
                    action("RTGS Transfer List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'RTGS Transfer List';
                        RunObject = page "RTGS Transfer List";
                    }
                    action("Posted EFT Transfer List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted RTGS Transfer List';
                        RunObject = page "Posted EFT Transfer List";
                    }
                    action("RTGS Reports")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'RTGS Report';
                        RunObject = report "RTGS Report";
                    }
                }
                group("Cheque Management")
                {
                    Caption = 'Cheque Management';
                    action("Bankers Cheque Application")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bankers Cheque Application';
                        RunObject = page "Bankers Application List";
                    }
                    action("Treasury Cheque Application")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Treasury Control Cheque Application';
                        RunObject = page "Treasury Application List";
                    }
                    action("Treasury Cheque Inventory")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Treasury Control Cheque Inventory';
                        RunObject = page "Treasury Cheque Inventory";
                    }
                    action("Cheque Clearance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cheque Clearance';
                        RunObject = page "Cheque Clearance";
                    }
                    action("Cheque Book Application")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cheque Book Application';
                        RunObject = page "Cheque Book Application List";
                    }
                    action("Cheque Types")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cheque Types';
                        RunObject = page "Cheque Types";
                    }
                    action("Cheque Receipts")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cheque Receipts';
                        RunObject = page "Cheque Receipts List";
                    }

                }
                group("ATM Management")
                {
                    Caption = 'ATM Management';
                    // group("ATM Management Setups")
                    // {
                    //     Caption = 'ATM Management Setups';

                    //     action("ATM Charge")
                    //     {
                    //         ApplicationArea = Basic, Suite;
                    //         Caption = 'ATM Charge';
                    //         RunObject = page "ATM Charge List";
                    //     }
                    // }
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
                    // action("ATM Inventory List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'ATM Inventory List';
                    //     RunObject = page "ATM Inventory List";
                    // }
                    action("Dispatch ATM List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Dispatch ATM List';
                        RunObject = page "Dispatch ATM Lists";
                    }
                    action("ATM Return List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'ATM Return List';
                        RunObject = page "ATM Returned List";
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
                    group(ATMRepin)
                    {
                        Caption = 'ATM Repin';
                        Visible = true;
                        action("ATM Repin Application List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'ATM Repin Application List';
                            RunObject = page "ATM Repin Application List";
                        }
                        action("ATM Repin Processed List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'ATM Repin Procssed List';
                            RunObject = page "ATM Repin Procssed List";
                        }
                    }
                    action("ATM Card List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'ATM Card List';
                        RunObject = page "ATM Card List";
                    }
                    action("ATM Transactions")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'ATM Transactions';
                        RunObject = page "Sky ATM Transactions Buffer";
                    }
                    action("ATM Applicant List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'ATM Applicant List';
                        RunObject = page "Member List";
                        RunPageView = where("Request for ATM" = const(true));
                    }
                    group(MobileBank)
                    {
                        Caption = 'Mobile Banking';
                        Visible = true;
                        action("Mobile Banking List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Mobile Banking Application List';
                            RunObject = page "Mobile Banking App List";
                        }
                        action("Mobile Processed List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Mobile Banking Processed List';
                            RunObject = page "Mobile Banking Procssed List";
                        }
                    }
                    action("Mobile Banking Applicant List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Mobile Banking Applicant List';
                        RunObject = page "Member List";
                        RunPageView = where("Request Mobile Banking" = const(true));
                    }

                }

                group("FixedDepositContract")
                {
                    Caption = 'Fixed/Call Deposit Contracts';
                    action("Fixed Deposit")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Fixed/Call Deposit Contracts';
                        RunObject = page "Fixed Deposit Contract List";
                        RunPageLink = "Fixed Deposit Status" = CONST(" ");
                    }
                    action("ActiveFixed Deposit")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Running Fixed/Call Deposit Contracts';
                        RunObject = page "Fixed Deposit Contract List";
                        RunPageLink = "Fixed Deposit Status" = CONST(Active);
                    }
                    action("CTFixed Deposit")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Closed/Terminated Fixed/Call Deposit Contracts';
                        RunObject = page "Fixed Deposit Contract List";
                        RunPageLink = "Fixed Deposit Status" = filter(Matured | Closed | "Not Matured" | Terminated);
                    }
                }
                group(SystemEdits)
                {
                    Caption = 'System Edits';
                    action(SystemEdit)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'System Edits';
                        RunObject = page "System Edits List";
                    }
                    group("On Going Dependancy Applications")
                    {
                        action("Open Dependancies Applications")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Dependancies Applications List";//open
                            RunPageView = where(Status = const(Open));

                        }
                        action("Pending Dependancies Applications")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Pending Dependancies Apps";//<>open <>created
                            RunPageView = where(Status = const(Pending));

                        }
                        action("Deffered Dependancies Applications")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Pending Dependancies Apps";
                            RunPageView = where(Status = const(Deffered));

                        }
                        action("Approved Dependancies Applications")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Pending Dependancies Apps";
                            RunPageView = where(Status = const(Approved));

                        }

                    }
                }
                group("Loan Periodic Activities")
                {
                    Caption = 'Loan Periodic Activities';
                    group("Monthly Billing")
                    {
                        caption = 'Monthly Loan Interest';
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
                        action("Dailly Bills Buffer List")
                        {
                            ApplicationArea = all;
                            Caption = 'Dailly Bills Buffer List';
                            RunObject = page "Dailly Interest Buffer";
                        }
                    }
                }
                group("Reversal")
                {
                    Caption = 'Reversals';

                    action(AutoReversal)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Auto Reversal';
                        RunObject = page "System Reversal List";
                    }
                    action(PostedAutoReversal)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Auto Reversal';
                        RunObject = page "Posted Reversal List";
                    }
                }

                group(GLRegister)
                {
                    Caption = 'General Journal And Register';
                    group(GLRegisters)
                    {
                        Caption = 'General Journal And Register';
                        action(Register)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'G/L Register';
                            RunObject = page "G/L Registers";
                        }
                        action(GeneralJournal)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'General Journal';
                            //RunObject = page "General Journal";
                            RunObject = page "General Journal";
                        }
                    }
                    group("Refunds& account Transfer")
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
                    }

                }
                group("Commercial Loans")
                {
                    action("Commercial Loan Buyoff")
                    {
                        ApplicationArea = all;
                        Caption = 'Commercial Loan Buyoffs';
                        RunObject = page "Bosa Commercial List";
                    }
                }
                // group("Member Files")
                // {

                action("File List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'File Tracker List';
                    RunObject = page "File Tracker List";
                    RunPageView = where(Status = filter(<> archived));
                }
                group("File Requests.")
                {
                    action("Request File")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Request File';
                        RunObject = page "File Request List";
                        RunPageView = where(Status = filter(open));
                    }
                    action("File Request")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Files Requested';
                        RunObject = page "File Request List";
                        RunPageView = where(Status = filter(requested));
                    }
                    action("Closed File Request")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Closed Files Requests.';
                        RunObject = page "File Request List";
                        RunPageView = where(Status = filter(closed));
                    }
                }

            }
            group(EmployeeSelfService)
            {
                Caption = 'Employee Self Service';
                group("Employee Fixed Assets")
                {
                    action("Employee Fixed Asset Transfer List")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Fixed Assets Transfer List';
                        RunObject = Page "Asset Transfer List";
                        ToolTip = 'This module facilitates Transfer of FA location and responsible employee';
                    }
                    action("Employee Transferred Fixed Assets")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Transferred Fixed Assets';
                        RunObject = Page "Asset Transfer List Effected";
                        ToolTip = 'View the list of fixed assets that have been transferred.';
                    }
                }
                action(StaffWelfare)
                {
                    Caption = 'Staff Welfare Claim';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Staff Welfare List";
                }
                action(LeaveApplication1)
                {
                    Caption = 'Employee Leave Application';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "HR Leave Applications List1";

                }
                action("Store Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Store Requisition';
                    RunObject = Page "Store Requisitions List";


                }
                action("Overtime Claim List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Overtime';
                    RunObject = page "Overtime Claim List";
                }

                action("System Rights Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'System Rights Requisition';
                    RunObject = page "Permission Requisition Card";
                }

                action("Loan Application")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Apply Staff Loan';
                    RunObject = page "Self Loan Application List";
                }
                group("Employee Requests")
                {

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
                    group("Conf & Meeting Room Booking")
                    {
                        Caption = 'Conf & Meeting Room Aplications';
                        action("Conference Hall & Meeting Rooms")
                        {
                            ApplicationArea = All;
                            Caption = 'Open Bookings';
                            RunObject = page "MNS Conf & Meetings Appl List";
                            RunPageLink = Status = CONST(Open);
                        }
                        action("Pending Conf & Meeting Room Booking")
                        {
                            ApplicationArea = All;
                            Caption = 'Pending Bookings';
                            //RunObject = page "Pending Conf & Meeting - List";
                            RunObject = page "MNS Conf & Meetings Appl List";
                            RunPageLink = Status = CONST(Pending);
                        }
                        action("Approved Conf & Meeting Room Booking")
                        {
                            ApplicationArea = All;
                            Caption = 'Approved Booking';
                            //RunObject = page "Approved Conf & Meeting - List";
                            RunObject = page "MNS Conf & Meetings Appl List";
                            RunPageLink = Status = CONST(Approved);
                        }
                        action("Invoicing for Hire of Halls")
                        {
                            ApplicationArea = All;
                            Caption = 'Invoicing for Hire of Halls';
                            //RunObject = page "Approved Conf & Meeting - List";
                            RunObject = page "MNS Conf & Meetings Appl List";
                            //RunPageLink = Status = CONST(Approved);
                            RunPageView = WHERE(Status = CONST(Approved), "Type of Meeting/Function" = Const(External));
                        }
                        action("Rejected Conf & Meeting Room Booking")
                        {
                            ApplicationArea = All;
                            Caption = 'Declined Bookings';
                            //RunObject = page "Rejected Conf & Meeting - List";
                            RunObject = page "MNS Conf & Meetings Appl List";
                            RunPageLink = Status = CONST(Rejected);
                        }
                        action("Closed Conf & Meeting Room Booking")
                        {
                            ApplicationArea = All;
                            Caption = 'Closed Bookings';
                            //RunObject = page "Closed Conf & Meeting - List";
                            RunObject = page "MNS Conf & Meetings Appl List";
                            RunPageLink = "Status of the Booking" = CONST(Closed);
                        }
                    }
                    Group("Motor Vehicle Requests")
                    {
                        Caption = 'Motor Vehicle Requests';
                        action("Vehicle Request Application")
                        {
                            ApplicationArea = all;
                            Caption = 'Open Vehicle Requests';
                            RunObject = page "Motor Vehicle Request List";
                            RunPageLink = Status = CONST(Open);
                        }
                        action("Pending Vehicle Requests")
                        {
                            ApplicationArea = all;
                            Caption = 'Pending Vehicle Requests';
                            RunObject = page "Motor Vehicle Request List";
                            RunPageLink = Status = CONST(Pending);
                        }
                        action("Approved Vehicle Requests")
                        {
                            ApplicationArea = all;
                            Caption = 'Approved Vehicle Requests';
                            //RunObject = page "Approved Vehicle Req - List";
                            RunObject = page "Motor Vehicle Request List";
                            RunpageLink = Status = CONST(Approved);
                        }
                        action("Deffered Vehicle Requests")
                        {
                            ApplicationArea = all;
                            Caption = 'Deffered Vehicle Requests';
                            RunObject = page "Deffered Vehicle Req - List";
                        }
                        action("Reject Vehicle Requests")
                        {
                            ApplicationArea = all;
                            Caption = 'Rejected Vehicle Requests';
                            //RunObject = page "Rejected Vehicle Req - List";
                            RunObject = page "Motor Vehicle Request List";
                            RunPageLink = Status = CONST(Rejected);
                        }
                        action("Closed Vehicle Request")
                        {
                            ApplicationArea = all;
                            Caption = 'Closed Vehicle Request';
                            //RunObject = page "Closed Vehicle Req - List";
                            RunObject = page "Motor Vehicle Request List";
                            RunPageLink = Status = CONST(Closed);
                        }
                        action("Reallocated Requests")
                        {
                            ApplicationArea = all;
                            Caption = 'Reallocated Requests';
                            RunObject = page "Motor Vehicle Request List";
                            RunPageLink = Reallocated = CONST(TRUE);
                        }
                    }
                    group("Key Requests")
                    {
                        action("Open Keys Request")
                        {
                            ApplicationArea = All;
                            Caption = 'Office Keys Request';
                            RunObject = page "Key Request List";
                            RunPageLink = Status = CONST(Open);
                        }
                        action("Pending Keys Request")
                        {
                            ApplicationArea = All;
                            Caption = 'Pending Requests';
                            RunObject = page "Key Request List";
                            RunPageLink = Status = CONST(Pending);
                        }
                        action("Approved Keys Request")
                        {
                            ApplicationArea = All;
                            Caption = 'Approved Requests';
                            RunObject = page "Key Request List";
                            RunPageLink = Status = CONST(Approved);
                        }
                        action("Rejected Keys Request")
                        {
                            ApplicationArea = All;
                            Caption = 'Rejected Key Request';
                            RunObject = page "Key Request List";
                            RunPageLink = Status = CONST(Rejected);
                        }
                        action("Closed Keys Request")
                        {
                            ApplicationArea = All;
                            Caption = 'Closed Key Requests';
                            RunObject = page "Key Request List";
                            RunPageLink = "Key Status" = CONST(Received);
                        }
                    }
                    Group("Parking Allocation")
                    {
                        action("Parking Space List")
                        {
                            ApplicationArea = All;
                            Caption = 'Open Parking Application';
                            RunObject = page "Parking Space List";
                            RunPageLink = Status = CONST(Open);
                        }
                        action("Pending Parking Space Application")
                        {
                            ApplicationArea = All;
                            Caption = 'Pending Parking Allocation';
                            //RunObject = page "Approved Parking - List";
                            RunObject = page "Parking Space List";
                            RunPageLink = Status = CONST(Pending);
                        }
                        action("Approved Parking Space Application")
                        {
                            ApplicationArea = All;
                            Caption = 'Approved Parking Allocation';
                            //RunObject = page "Approved Parking - List";
                            RunObject = page "Parking Space List";
                            RunPageLink = Status = CONST(Approved);
                        }
                        action("Rejected Parking Space Application")
                        {
                            ApplicationArea = All;
                            Caption = 'Rejected Parking Allocation';
                            //RunObject = page "Rejected Parking Space - List";
                            RunObject = page "Parking Space List";
                            RunPageLink = Status = CONST(Rejected);
                        }
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
                    action("Savings Accounts Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Savings Accounts Register';
                        RunObject = report "Savings Accounts Register";
                    }
                    action("FOSA Savings Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'FOSA Savings Register';
                        RunObject = report "FOSA Savings Register";
                    }
                    action("Savings Account Types")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Savings Accounts Types Report';
                        RunObject = report "Savings Account Types Report";
                    }
                    action("Account Balance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'FOSA Loan Register';
                        RunObject = report "FOSA Loan Register";
                    }
                    action("Salary Accounts List Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Salaries received though FOSA';
                        RunObject = report "Salary Accounts List Report";
                    }
                    // action("Salary Through FOSA Report")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Salary Through FOSA Report';
                    //     RunObject = report "Salary Through FOSA Report";
                    // }
                    action("Salary Not Thru FOSA")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Salary Not Thru FOSA';
                        RunObject = report "Salary Not Through FOSA";
                    }

                    // action("Savings Contribution Variance")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Savings Contribution Variance';
                    //     //RunObject = report "Savings Contribution Variance";
                    // }
                    action("Generate Dormant Accounts")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Generate Dormant Accounts';
                        RunObject = report "Generate Dormant Accounts";
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


                    action("Daily Transactions Cashiers")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Daily Transactions Cashiers Report';
                        RunObject = report "Daily Transaction Report";
                    }
                    action("Bankers Cheque Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bankers Cheque Report';
                        RunObject = report "Bankers Cheque Report";
                    }
                    action("Treasury Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Treasury Report';
                        RunObject = report "Treasury Report";
                    }
                    action("Anti-Money Laundering Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Anti-Money Laundering Report';
                        RunObject = report "Anti-Money Laundering Report";
                    }
                }



                group("ATM Reports")
                {
                    Caption = 'ATM Reports';
                    action("ATM Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'ATM Activation Report';
                        RunObject = report "ATM Activation Report";
                    }
                    // action("ATM card no's account balances")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'ATM card nos account balances';
                    //     // RunObject = report "ATM card no's account balances";
                    // }
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

                    action("Standing Orders Register")
                    {
                        ApplicationArea = SalesReturnOrder, PurchReturnOrder;
                        Caption = 'Standing Orders Register';
                        RunObject = report "Standing Orders Register";
                    }
                    // action("Banking Standing Order")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Standing Order';
                    //     RunObject = report "Standing Order";
                    // }
                    // action("Standing Order Register")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Standing Order Register';
                    //     RunObject = report "Standing Order Register";
                    // }
                }
                group("Loans Reports")
                {
                    action("Insider Lending Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'FOSA Insider Lending Report';
                        RunObject = report "FOSA Insider Lending";
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
                    action("Loans Defaulter Aging - SASRA")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loans Defaulter Aging - SASRA';
                        RunObject = report "Loans Defaulter Aging - SASRA";
                    }
                }

                group("Other Reports")
                {
                    Caption = 'Other Reports';
                    action("Mobile Banking Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Mobile Banking Transactions Report';
                        RunObject = report "Mobile Banking Report";
                    }
                    action("Petty Cash Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Petty Cash Report';
                        RunObject = report "Petty Cash FOSA Report";
                    }

                    action("FOSA Account List Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'FOSA Account List Report';
                        RunObject = report "FOSA Account Page List";
                    }

                    action("FOSA Account Activation Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'FOSA Account Activation Report';
                        RunObject = report "FOSA Account Activation";
                    }
                    action("FOSA Treasury Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'FOSA Branch Treasury Report';
                        RunObject = report "FOSA Treasury Report";
                    }
                    action("FOSA Treasury Control")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'FOSA Treasury Controls Report';
                        RunObject = report "FOSA Treasury Controls";
                    }
                    action("FOSA Loan Recovery Variance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'FOSA Loan Recovery Variance';
                        RunObject = report "Loan Recovery Variance";
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
                        Caption = 'Transaction Types List';
                        RunObject = page "Transaction Types List";
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
                    action("ATM Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'ATM Card Types Setup';
                        RunObject = page "ATM Card Types";
                    }
                    // action(ProductSetup)
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Product Setup';
                    //     RunObject = page "Product Factory List";
                    // }

                }
                group("Fixed Deposit Setup")
                {
                    Caption = 'Fixed Deposit Setup';
                    action("Fixed Deposit Type")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Fixed Deposit Type';
                        RunObject = page "Fixed Deposit Type List";
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
                    action("Cash Office User Template")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Office User Template';
                        RunObject = page "Cash Office User Template";
                    }
                }
            }
        }
    }
}


profile "Credit Officers"
{
    Caption = 'Credit Officers Role Center';
    RoleCenter = "Credit Officers RC";
    ProfileDescription = 'Credit Officers Role Center';
}


