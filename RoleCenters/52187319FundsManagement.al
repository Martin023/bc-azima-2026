page 52187319 "Funds Management Role Center"
{
    Caption = 'Funds Management Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)

        {
            part(Control139; CustomHeadline)
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control140; "Funds Management Activity")
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
            part(Control1907692008; "My Accounts")
            {
                ApplicationArea = Basic, Suite;
            }



        }
    }
    actions
    {
        area(Sections)
        {
            group("Receipts, Payments and Bank Transfers")
            {
                Caption = 'Receipts, Payments and Bank Transfers';
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
                action("Payment Voucher Delegate")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Voucher Delegate';
                    RunObject = page "Payment Voucher Delegate  List";
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
                        //RunObject = page "Imprest Surrender List";
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
                group("Transfers")
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

            group("Reports and Analysis")
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
    }
}



