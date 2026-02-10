page 52185499 "E-Channels Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part("Custom Headline"; customheadline)
            {
                ApplicationArea = Basic, Suite;
            }

            Part(Echannelscue; "E-Channels Cue")
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
        area(Sections)
        {
            group("Mobile Banking")
            {
                Caption = 'Mobile Banking';
                group("Posted Transactions")
                {
                    Caption = 'Posted Transactions';

                    action(AllWithdrawals)
                    {
                        ApplicationArea = Basic;
                        Caption = 'All Withdrawals';
                        RunObject = Page "Sky M-Banking Trans. Buffer";
                        RunPageView = where(
                                "Posted" = const(true),
                                "Transaction Type" = Filter(
                                    "Mpesa Withdrawal" |
                                    "Utility Payment" |
                                    Airtime |
                                    "Bank Transfer"
                                ),
                            "Change Type" = filter(Post | Reverse)
                            );
                    }
                    action(PostedWithdrawals)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Withdrawal Transactions';
                        RunObject = Page "Sky M-Banking Trans. Buffer";
                        RunPageView = where(
                                "Posted" = const(true),
                                "Transaction Type" = Filter(
                                    "Mpesa Withdrawal" |
                                    "Utility Payment" |
                                    Airtime |
                                    "Bank Transfer"
                                ),
                                "Change Type" = const(Post)
                            );
                    }
                    action(ReversedWithdrawals)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Reversed Withdrawal Transactions';
                        RunObject = Page "Sky M-Banking Trans. Buffer";
                        RunPageView = where(
                                "Posted" = const(true),
                                "Transaction Type" = Filter(
                                    "Mpesa Withdrawal" |
                                    "Utility Payment" |
                                    Airtime |
                                    "Bank Transfer"
                                ),
                                "Change Type" = const(Reverse)
                            );
                    }
                    action(PostedDeposits)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Deposit Transactions';
                        RunObject = Page "Sky M-Banking Trans. Buffer";
                        RunPageView = where(
                                "Posted" = const(true),
                                "Transaction Type" = Filter(
                                    "Mpesa Deposit" |
                                    "Loan Repayment" | "Coop B2B Deposit" | "Coop P2F Deposit"
                                ),
                                "Change Type" = const(Post)
                            );
                    }
                    action(ReversedDeposits)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Reversed Deposit Transactions';
                        RunObject = Page "Sky M-Banking Trans. Buffer";
                        RunPageView = where(
                                "Posted" = const(true),
                                "Transaction Type" = Filter(
                                    "Mpesa Deposit" |
                                    "Loan Repayment" | "Coop B2B Deposit" | "Coop P2F Deposit"
                                ),
                                "Change Type" = const(Reverse)
                            );
                    }
                }

                group("Unposted Transactions")
                {
                    Caption = 'Unposted Transactions';
                    action(UnpostedWithdrawals)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Withdrawal Transactions';
                        RunObject = Page "Sky M-Banking Trans. Buffer";
                        RunPageView = where(
                                "Posted" = const(false),
                                "Transaction Type" = Filter(
                                    "Mpesa Withdrawal" |
                                    "Utility Payment" |
                                    Airtime |
                                    "Bank Transfer"
                                )
                            );
                    }
                    action(UnpostedDeposits)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Deposit Transactions';
                        RunObject = Page "Sky M-Banking Trans. Buffer";
                        RunPageView = where(
                                "Posted" = const(false),
                                "Transaction Type" = Filter(
                                    "Mpesa Deposit" |
                                    "Loan Repayment" | "Coop B2B Deposit" | "Coop P2F Deposit"
                                )
                            );
                    }
                    group("Tasks")
                    {
                        Caption = 'Tasks';

                        action(DepositNeedsChange)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Deposit Needs Change';
                            RunObject = Page "Sky M-Banking Trans. Buffer";
                            RunPageView = where(
                                "Needs Change" = const(true)
                            );
                        }
                    }
                }

                group("Reversal Transactions")
                {
                    Caption = 'Reversal Transactions';
                    action(PostedReversals)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Posted Reversals';
                        RunObject = Page "Sky M-Banking Trans. Buffer";
                        RunPageView = where(
                            "Transaction Status" = const(REVERSE_CONFIRMED),
                            Posted = const(true)
                        );
                    }
                    action(UnpostedReversals)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Unposted Reversals';
                        RunObject = Page "Sky M-Banking Trans. Buffer";
                        RunPageView = where(
                            "Transaction Status" = const(REVERSE_CONFIRMED),
                            Posted = const(false)
                        );
                    }
                }

                group("Loans")
                {
                    Caption = 'Mobile Loans';
                    action("Posted Mobile Loans")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Posted Mobile Loans';
                        RunObject = Page "Sky Mobile Loans";
                        RunPageView = where(
                                Posted = const(true)
                            );
                    }
                    action("Unposted Mobile Loans")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Unposted Mobile Loans';
                        RunObject = Page "Sky Mobile Loans";
                        RunPageView = where(
                            Posted = const(false)
                        );
                    }
                    action("Mobile Loans - Loan Book")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Posted Mobile Loan Book';
                        RunObject = Page "Loans List";
                        RunPageView = where(
                            Posted = const(true), "Mobile Loan" = filter(true)
                        );
                    }

                }
                group("Members Portal Loans")
                {
                    action("Portal Loans")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Applied Portal Loans';
                        RunObject = Page "Loans List";
                        RunPageView = where(
                            Posted = const(false), "Source Aplication" = filter("Member Portal")
                        );
                    }
                    action("Posted Portal Loans")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Posted Portal Loans';
                        RunObject = Page "Loans List";
                        RunPageView = where(
                            Posted = const(true), "Source Aplication" = filter("Member Portal")
                        );
                    }
                }

            }
            group("ATM Banking")
            {
                Caption = 'ATM Banking';

                action(AllATMTransactions)
                {
                    ApplicationArea = Basic;
                    Caption = 'All ATM Transactions';
                    RunObject = Page "Sky ATM Transactions Buffer";
                    RunPageView = where(
                        "Posted" = const(true)
                    );
                }
                action(PostedATM)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted ATM Transactions';
                    RunObject = Page "Sky ATM Transactions Buffer";
                    RunPageView = where(
                        "Posted" = const(true)
                    );
                }
                action(UnpostedATM)
                {
                    ApplicationArea = Basic;
                    Caption = 'Unposted ATM Transactions';
                    RunObject = Page "Sky ATM Transactions Buffer";
                    RunPageView = where(
                        "Posted" = const(false)
                    );
                }
                action(ReversalATM)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reversal ATM Transactions';
                    RunObject = Page "Sky ATM Transactions Buffer";
                    RunPageView = where(
                        Reversed = Const(true)
                    );
                }
            }
            group(SMS)
            {
                Caption = 'SMS';
                action(SMSMessages)
                {
                    ApplicationArea = Basic;
                    Caption = 'SMS Messages';
                    RunObject = Page "Sky SMS Messages";
                }
            }
            group(Setups)
            {
                Caption = 'Setups';
                action(MobileTransactionTypes)
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile Transaction Types';
                    RunObject = Page "Mobile Transaction types List";
                }
                action(ATMTransactionTypes)
                {
                    ApplicationArea = Basic;
                    Caption = 'ATM Transaction Types';
                    RunObject = Page "ATM Charge List";
                }
                action(TransactionLimits)
                {
                    ApplicationArea = Basic;
                    Caption = 'Transaction Limits';
                    RunObject = Page "E-Channels Transaction Setup";
                }
            }
        }

        area(Reporting)
        {
            action("Bulk SMS")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bulk SMS List';
                RunObject = page "Bulk SMS Header List";
            }
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
            action("NCBA Pension List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'NCBA Pension List';
                RunObject = page "NCBA Pension List";
            }
        }
    }

}
profile "E-Channels Role Center"
{
    Caption = 'E-Channels Role Center';
    RoleCenter = "E-Channels Role Center";
    ProfileDescription = 'Administrator';
}



