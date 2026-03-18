page 52187328 "Business Loans"
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
            group("Business Loans Applications")
            {
                Caption = 'BS Loan Applications';
                group("Business Account Application")
                {
                    action("BLA Application List")
                    {
                        ApplicationArea = All;
                        Caption = 'BLA Application List';
                        RunObject = page "BLA Application List";
                    }
                    action("Approved BLA Application List")
                    {
                        ApplicationArea = All;
                        Caption = 'BLA Approved Application List';
                        RunObject = page "Approved BLA Application List";
                        RunPageView = WHERE(Status = const(Approved), "Account Created" = const(false));
                    }
                    action("Archived BLA Application List")
                    {
                        ApplicationArea = All;
                        RunObject = page "Rejected BLA Application List";
                        RunPageView = where(Status = filter(Archived));
                    }
                    action("Created BLA Application List")
                    {
                        ApplicationArea = All;
                        Caption = 'BLA Created Application List';
                        RunObject = page "Approved BLA Application List";
                        RunPageView = WHERE(Status = const(Approved), "Account Created" = const(true));
                    }
                    action("Deffered BLA Application List")
                    {
                        ApplicationArea = All;
                        RunObject = page "Rejected BLA Application List";
                        RunPageView = where(Status = filter(Deffered));
                    }
                    action("Rejected BLA Application List")
                    {
                        ApplicationArea = All;
                        Caption = 'Rejected BLA Application List';
                        RunObject = page "Rejected BLA Application List";
                        RunPageView = where(Status = filter(Rejected));
                    }
                }

                group("BS Group/Chama Application")
                {
                    action("BLG Application List")
                    {
                        ApplicationArea = All;
                        Caption = 'BS Loan Group App List';
                        RunObject = Page "Member Application Group List";
                    }
                    action("Approved Group App List")
                    {
                        ApplicationArea = All;
                        Caption = 'Approved Group App List';
                        RunObject = Page "Approved Group App List";
                    }
                    action("Rejected Group Applications")
                    {
                        ApplicationArea = All;
                        Caption = 'Rejected Group Applications';
                        RunObject = Page "Rejected Group App List";
                    }
                }


            }

            group("Business Loans Groups")
            {
                Caption = 'BS Loan Members & Groups';
                action("BS Loan Members List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Business Loans Members';
                    RunObject = Page "Business Loans Members";
                }
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
                    RunObject = page "Savings Account List";
                }
                action("Savings Account Register")
                {
                    ApplicationArea = All;
                    Caption = 'Savings Account Register';
                    RunObject = page "Savings Accounts";
                }
                action("New Members")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Members';
                    RunObject = Page "Member Single List";
                    RunPageView = where(status = const(New));
                }
                group("Account Securities")
                {
                    Caption = 'Account Securities';
                    action("Edits List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'System Edits List';
                        RunObject = page "System Edits List";
                    }
                    action("Posted Edits")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Posted Edits';
                        RunObject = page "Posted System Edits List";
                    }


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

                action("File List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'File Tracker List';
                    RunObject = page "File Tracker List";
                    RunPageView = where(Status = filter(<> archived));
                }

            }
            group("Business Loans")
            {
                Caption = 'Loans';

                group("Loan Processing")
                {

                    Caption = 'Loan Processing';
                    action("Loan Application List All")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Loan Application List All';
                        RunObject = page "Loan Application List";
                    }

                    action("Loan Application List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Loan Application List';
                        RunObject = page "Loan Application List_BL";
                        RunPageView = where("Sent Back to CRM" = const(false), "Sent Back to M-Smart" = const(false));
                    }
                    action("Loan Appraisal List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Loan Appraisal List';
                        RunObject = page "Appraisal Loans List_BL";

                    }
                    action("Loan Approved List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Loan Approved List';
                        RunObject = page "Approved Loans List_BL";
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
                        caption = 'Rejected/Archived Loan';
                        RunObject = page "Rejected Loan Application List";
                    }
                    action("Loan Archived List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Loan Archived List';
                        RunObject = page "Loan Application List";
                        RunPageView = where(Status = filter(Archived));
                    }

                    action("Loans Send Back to CRM")
                    {
                        ApplicationArea = all;
                        Visible = true;
                        caption = 'Loans Send Back to CRM';
                        RunObject = page "Loan Application List_BL";
                        RunPageView = where("Sent Back to CRM" = const(true));
                    }
                    action("Loans Send Back to M-Smart")
                    {
                        ApplicationArea = all;
                        Visible = true;
                        caption = 'Loans Send Back to M-Smart';
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

                group("Loan Processed")
                {

                    Caption = 'Loan Processed';
                    action("Loan Posted List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Loan Posted List';
                        RunObject = page "Loan Posted List";
                        RunPageView = where("Source Unit" = filter(<> "HR LOANS"), "Total Balance" = filter(> 0));
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
                        //RunPageView = where(Status = filter(<> archived), "Lending Unit" = const("Business Loans"));
                    }
                    action("Archived Collateral Register - List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Archived Collateral Register - List';
                        RunObject = page "Collateral Register - List";
                        RunPageView = where(Status = filter(archived));
                    }
                    // action("Posted Lien")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     caption = 'Posted Lien - List';
                    //     RunObject = page "Collateral Register - List";
                    //     RunPageView = where("Cash Collateral Posted" = filter(true));
                    // }
                    // action("Blocked Cash Collateral")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Blocked Cash Collateral';
                    //     RunObject = Page "One Month Installments";
                    //     RunPageLink = Type = CONST(Lien), "Funds Status" = CONST(WithHeld);
                    // }
                    // action("Released Cash Collateral")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Released Cash Collateral';
                    //     RunObject = Page "One Month Installments";
                    //     RunPageLink = Type = CONST(Lien), "Funds Status" = CONST(Released);
                    // }
                    action("Collateral Collection - List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Collateral Collection - List';
                        RunObject = page "Collateral Collection - List";
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
            }


            group("Loan Activity")
            {

                Caption = 'Periodic Activities';

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
                group("Guarantor Substitution")
                {
                    action("Open Guarantor Substitution")
                    {

                        ApplicationArea = Basic, Suite;
                        caption = 'Open Guarantor Substitution List';
                        RunObject = page "Guarantor Subsitution List";
                        RunPageLink = Status = filter(Open), "Sent Back to CRM" = const(false);
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
                    action("Guarantor Substitution Sent Send Back to CRM")
                    {
                        ApplicationArea = all;
                        Caption = 'Guarantor Substitution Sent Send Back to CRM';
                        RunObject = page "Guarantor Subsitution List";
                        RunPageLink = "Sent Back to CRM" = const(true);
                    }
                }
                group("Loan Recovery")
                {
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
                group("Exit and Transfer")
                {
                    action("Exit and Transfer List")
                    {
                        ApplicationArea = All;
                        Caption = 'Exit and Transfer List';
                        RunObject = Page "Business Clossure List";
                        RunPageView = where(Posted = const(false));

                    }
                    action("Posted Exit and Transfer List")
                    {
                        ApplicationArea = All;
                        Caption = 'Posted Exit and Transfer List';
                        RunObject = Page "Business Clossure List";
                        RunPageView = where(Posted = const(true));

                    }

                }

                action("SASRA Loan Categorization.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SASRA Loan Categorization';
                    RunObject = report "SASRA Loan Categorization";
                }
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
                        Caption = 'Interest Accrual List';
                        RunObject = page "Interest Header List";
                    }
                    action("Dailly Interest Buffer")
                    {
                        ApplicationArea = all;
                        Caption = 'Dailly Interest Buffer';
                        RunObject = page "Dailly Interest Buffer";
                    }
                }
                group("Moratorium Loan")
                {
                    Caption = 'Moratorium Loan';
                    action("Open Moratorim Loan List")
                    {
                        ApplicationArea = all;
                        Caption = 'Open Moratorium Loan List';
                        RunObject = page "Moratorium Loan List";
                        RunPageLink = Status = filter(Open);
                    }
                    action("Pending Moratorim Loan List")
                    {
                        ApplicationArea = all;
                        Caption = 'Pending Moratorium Loan List';
                        RunObject = page "Moratorium Loan List";
                        RunPageLink = Status = filter(Pending);
                    }
                    action("Approved Moratorium Loan List")
                    {
                        ApplicationArea = all;
                        Caption = 'Approved Moratorium Loan List';
                        RunObject = page "Moratorium Loan List";
                        RunPageLink = Status = filter(Approved), Processed = const(false);
                    }
                    action("Processed Moratorium Loans")
                    {
                        ApplicationArea = all;
                        Caption = 'Processed Moratorium Loans';
                        RunObject = page "Moratorium Loan List";
                        RunPageLink = Status = filter(Approved), Processed = const(true);
                    }
                }
                // group("Loan - CRB")
                // {
                //     Caption = 'Loan - CRB';
                //     action("CRB Data")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'CRB Data';
                //         RunObject = page "CRB Data";
                //     }

                //     action("Loans CRB")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Loans CRB';
                //         RunObject = xmlport "Loans CRB";
                //     }
                //     action("Loans Guarantors")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Loans Guarantors';
                //         RunObject = XMLPort "Loans Gurarantors- CRB";
                //     }
                // }
                group("Loan Restructuring")
                {
                    action("Open Loan Restructring List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Open Loan Restructuring List';
                        RunObject = page "Loan Restructure List";
                        RunPageLink = "Schedule Type" = filter(Restructure | "Defaulter Loan Conversion"), Status = filter(Open), Rescheduled = filter(false);
                    }
                    action("Pending Loan Restructring List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Pending Loan Restructuring List';
                        RunObject = page "Loan Restructure List";
                        RunPageLink = "Schedule Type" = filter(Restructure | "Defaulter Loan Conversion"), Status = filter(Pending), Rescheduled = filter(false);
                        RunPageMode = View;
                    }
                    action("Approved Loan Restructring List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Approved Loan Restructuring List';
                        RunObject = page "Loan Restructure List";
                        RunPageLink = "Schedule Type" = filter(Restructure | "Defaulter Loan Conversion"), Status = filter(Approved), Rescheduled = filter(false);
                        RunPageMode = View;
                    }
                    action("Restructured Loan Restructring List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Restructured Loan List';
                        RunObject = page "Loan Restructure List";
                        RunPageLink = "Schedule Type" = filter(Restructure | "Defaulter Loan Conversion"), Rescheduled = const(true);
                        RunPageMode = View;
                    }
                }

                group("Refunds & account Transfer")
                {
                    action("Bulk Account Refunds")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bulk Account Refunds';
                        RunObject = Page "Bulk Account Refunds";
                        RunPageView = where(Posted = const(false));

                    }
                    action("Posted Bulk Account Refunds")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Bulk Account Refunds';
                        RunObject = Page "Bulk Account Refunds";
                        RunPageView = where(Posted = const(true));
                        RunPageMode = View;
                    }
                    action("Refund $ Account Trans List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Refunds and account transfers';
                        RunObject = Page "Refund $ Account Trans List BL";
                        RunPageView = where(Posted = const(false));
                    }

                    action("Posted Refund & Account Trans List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Refunds and account transfers';
                        RunObject = Page "Refund $ Account Trans List BL";
                        RunPageView = where(Posted = const(true));
                    }

                }
                group("Standing Orders")
                {
                    Caption = 'Standing Orders';
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

                    action("Standing Orders Register")
                    {
                        ApplicationArea = SalesReturnOrder, PurchReturnOrder;
                        Caption = 'Standing Orders Register';
                        RunObject = report "Standing Orders Register";
                    }

                }
                group("Reversal")
                {
                    Caption = 'Journals and Reversals';

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
                    action(GeneralJournals)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'General Journals';
                        Image = Journal;
                        RunObject = Page "General Journal Batches";
                        RunPageView = where("Template Type" = const(General),
                                        Recurring = const(false));
                        ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
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
                // group("Refunds& account Transfer")
                // {

                // }
                group(Dividends)
                {
                    action("Dividend Simulation")
                    {
                        ApplicationArea = all;
                        Caption = 'Dividend Simulation';
                        RunObject = page "Dividend Simulation Header";
                    }
                    group("Dividend Provisions")
                    {
                        action("Dividends Provision List")
                        {
                            ApplicationArea = all;
                            Caption = 'Dividends Provision List';
                            RunObject = page "Dividends Provision List";
                            RunPageView = where(Posted = const(false));

                        }
                        action("Posted Dividends Provision List")
                        {
                            ApplicationArea = all;
                            Caption = 'Posted Dividends Provision List';
                            RunObject = page "Dividends Provision List";
                            RunPageView = where(Posted = const(true));

                        }

                    }

                    group("Dividend Processing")
                    {

                        // action("Run Dividends")
                        // {
                        //     ApplicationArea = all;
                        //     Caption = 'Dividends Generation';
                        //     RunObject = report "Dividend Generation";
                        // }
                        action("Dividend Progression ")
                        {
                            ApplicationArea = all;
                            Caption = 'Dividend Progression List';
                            RunObject = page "Dividend Progression";
                        }
                        // action("Dividend Posting Buffer")
                        // {
                        //     ApplicationArea = all;
                        //     Caption = 'Generate Dividend Posting Buffer';
                        //     RunObject = report "Dividend Posting Buffer";
                        // }
                        action("Dividend Posting Buffer ")
                        {
                            ApplicationArea = all;
                            Caption = 'Dividend Posting Buffer';
                            RunObject = page "Dividend Posting Buffer";
                        }
                        group("Dividend Reports")
                        {
                            action("Dividends Register")
                            {
                                ApplicationArea = all;
                                Caption = 'Dividend Register';
                                RunObject = report "Dividend Register";
                            }
                            action("Dividends Slip")
                            {
                                ApplicationArea = all;
                                Caption = 'Dividend Slip';
                                RunObject = report "Dividend Slip B64";
                            }
                            action("Dividends Statement")
                            {
                                ApplicationArea = all;
                                Caption = 'Dividend Summary';
                                RunObject = report "Dividend Register Summary";
                            }
                            action("DividendsRegister")
                            {
                                ApplicationArea = all;
                                Caption = 'Detailed Dividend Register';
                                RunObject = report "Dividend Register Filtered";
                            }
                        }
                    }
                }
                group(SystemReversals)
                {
                    Caption = 'System Reversal';
                    action(SystemReversal)
                    {
                        Caption = 'System Reversal';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "System Reversal List";
                    }
                    action(PostedSystemReversal)
                    {
                        Caption = 'Posted System Reversal';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Reversed System Reversal List";
                    }
                }
                group("Account Activation")
                {
                    Caption = 'Account Activation';
                    action("Open Account Activaion")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Open Account Activaion';
                        RunObject = Page "BOSA Account Activation List";
                        RunPageView = where(Status = filter(Open));
                    }
                    action("Account Activaion Pending Approval")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Account Activaion Pending Approval';
                        RunObject = Page "BOSA Account Activation List";
                        RunPageView = where(Status = filter(Pending));
                    }
                    action("Rejected Account Activaion")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Rejected Account Activaion';
                        RunObject = Page "BOSA Account Activation List";
                        RunPageView = where(Status = filter(Rejected));
                    }
                    action("Approved Account Activaion")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Account Activaion';
                        RunObject = Page "BOSA Account Activation List";
                        RunPageView = where(Status = filter(Approved));
                    }
                    action("Posted Account Activation")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Account Activation';
                        RunObject = Page "Posted BOSA Account Activation";
                    }
                }
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

                group(Receipt)
                {
                    Caption = 'Receipts';
                    action("Receipt List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Receipts';
                        RunObject = page "Receipts List";
                        RunPageLink = "Shortcut Dimension 2 Code" = CONST('MICRO');
                    }
                    action(" Posted Receipt List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = ' Posted Receipts';
                        RunObject = page "Posted Receipt List";
                        RunPageLink = "Shortcut Dimension 2 Code" = CONST('MICRO');
                    }

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
                action(ClosureListAll)
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Member Closure List All';
                    RunObject = page "Member Closure List All";
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


            group(Action257)
            {
                Caption = 'Sales';
                action(Action67)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Contacts';
                    Image = CustomerContact;
                    RunObject = Page "Contact List";
                    ToolTip = 'View or edit detailed information about the contact persons at your business partners that you use to communicate business activities with or that you target marketing activities towards.';
                }
                action(Action66)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Opportunities';
                    RunObject = Page "Opportunity List";
                    ToolTip = 'View the sales opportunities that are handled by salespeople for the contact. Opportunities must involve a contact and can be linked to campaigns.';
                }

                action(Segments)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Segments';
                    RunObject = Page "Segment List";
                    ToolTip = 'View the list of segments that are currently used in active campaigns. Segments represent a grouping of contacts, so that you can interact with several contacts at once, for example by direct mail.';
                }
                action(Action59)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Campaigns';
                    Image = Campaign;
                    RunObject = Page "Campaign List";
                    ToolTip = 'View the list of your marketing campaigns. A campaign organizes all the sales and marketing activities involving your contacts, such as a sales promotion campaign.';
                }
                action(Action58)
                {
                    ApplicationArea = Suite, RelationshipMgmt;
                    Caption = 'Salespersons';
                    RunObject = Page "Salespersons/Purchasers";
                    ToolTip = 'View or edit information about the sales people that work for you and which customers they are assigned to.';
                }
                action("Salespeople/Purchasers")
                {
                    ApplicationArea = Suite, RelationshipMgmt;
                    Caption = 'Salespeople/Purchasers';
                    RunObject = Page "Salespersons/Purchasers";
                    ToolTip = 'View or edit information about the sales people and purchasers that work for you and which customers and vendors they are assigned to.';
                }
                action("Sales Cycles")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Sales Cycles';
                    RunObject = Page "Sales Cycles";
                    ToolTip = 'View the different sales cycles that you use to manage sales opportunities.';
                }

                group("HR Perfomance Management")
                {
                    Caption = 'Hr Perfomance Management';
                    group("HR BSC Appraisal")
                    {
                        action("HR BSC List Target Setting ")
                        {
                            Caption = 'HR List Target Setting';
                            ApplicationArea = Basic, suite;
                            RunObject = page "HR 360 Appraisals List - TS1";
                        }
                        action("HR BSC List Target Approval")
                        {
                            Caption = 'HR List Target Approval';
                            ApplicationArea = Basic, suite;
                            RunObject = page "HR 360 Appraisals List - TA1";
                        }
                        action("HR BSC List Evaluation Areas")
                        {
                            Caption = 'HR List Evaluation';
                            ApplicationArea = Basic, suite;
                            RunObject = page "HR 360 Appraisals List - EV1";
                        }
                        action("HR Appraisal Appeal List")
                        {
                            Caption = 'HR Appraisal Appeal List';
                            ApplicationArea = Basic, suite;
                            RunObject = page "HR Appraissal Appeal list";
                        }
                    }
                }
            }
            group(EmployeeSelfService)
            {
                Caption = 'Employee Self Service';
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

                action("Staff Store Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Store Requisition';
                    RunObject = page "Store Requisitions List";
                }
                group("Employee Requests")
                {
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

                    group("Staff File Requests.")
                    {
                        action("Staff Request File")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Request File';
                            RunObject = page "File Request List";
                            RunPageView = where(Status = filter(open));
                        }
                        action("Staff File Request")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Files Requested';
                            RunObject = page "File Request List";
                            RunPageView = where(Status = filter(requested));
                        }
                        action("Staff Closed File Request")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Closed Files Requests.';
                            RunObject = page "File Request List";
                            RunPageView = where(Status = filter(closed));
                        }
                        action("Staff File List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'File Tracker List';
                            RunObject = page "File Tracker List";
                            RunPageView = where(Status = filter(<> archived));
                        }
                    }
                    group("Employee Conf & Meeting Room Booking")
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
                    Group("Employee Motor Vehicle Requests")
                    {
                        Caption = 'Motor Vehicle Requests';
                        action("Employee Vehicle Request Application")
                        {
                            ApplicationArea = all;
                            Caption = 'Open Vehicle Requests';
                            RunObject = page "Motor Vehicle Request List";
                            RunPageLink = Status = CONST(Open);
                        }
                        action("Employee Pending Vehicle Requests")
                        {
                            ApplicationArea = all;
                            Caption = 'Pending Vehicle Requests';
                            RunObject = page "Motor Vehicle Request List";
                            RunPageLink = Status = CONST(Pending);
                        }
                        action("Employee Approved Vehicle Requests")
                        {
                            ApplicationArea = all;
                            Caption = 'Approved Vehicle Requests';
                            //RunObject = page "Approved Vehicle Req - List";
                            RunObject = page "Motor Vehicle Request List";
                            RunpageLink = Status = CONST(Approved);
                        }
                        action("Employee Deffered Vehicle Requests")
                        {
                            ApplicationArea = all;
                            Caption = 'Deffered Vehicle Requests';
                            RunObject = page "Deffered Vehicle Req - List";
                        }
                        action("Employee Reject Vehicle Requests")
                        {
                            ApplicationArea = all;
                            Caption = 'Rejected Vehicle Requests';
                            //RunObject = page "Rejected Vehicle Req - List";
                            RunObject = page "Motor Vehicle Request List";
                            RunPageLink = Status = CONST(Rejected);
                        }
                        action("Employee Closed Vehicle Request")
                        {
                            ApplicationArea = all;
                            Caption = 'Closed Vehicle Request';
                            //RunObject = page "Closed Vehicle Req - List";
                            RunObject = page "Motor Vehicle Request List";
                            RunPageLink = Status = CONST(Closed);
                        }
                        action("Employee Reallocated Requests")
                        {
                            ApplicationArea = all;
                            Caption = 'Reallocated Requests';
                            RunObject = page "Motor Vehicle Request List";
                            RunPageLink = Reallocated = CONST(TRUE);
                        }
                    }
                    group("Employee Key Requests")
                    {
                        action("Employee Open Keys Request")
                        {
                            ApplicationArea = All;
                            Caption = 'Office Keys Request';
                            RunObject = page "Key Request List";
                            RunPageLink = Status = CONST(Open);
                        }
                        action("Employee Pending Keys Request")
                        {
                            ApplicationArea = All;
                            Caption = 'Pending Requests';
                            RunObject = page "Key Request List";
                            RunPageLink = Status = CONST(Pending);
                        }
                        action("Employee Approved Keys Request")
                        {
                            ApplicationArea = All;
                            Caption = 'Approved Requests';
                            RunObject = page "Key Request List";
                            RunPageLink = Status = CONST(Approved);
                        }
                        action("Employee Rejected Keys Request")
                        {
                            ApplicationArea = All;
                            Caption = 'Rejected Key Request';
                            RunObject = page "Key Request List";
                            RunPageLink = Status = CONST(Rejected);
                        }
                        action("Employee Closed Keys Request")
                        {
                            ApplicationArea = All;
                            Caption = 'Closed Key Requests';
                            RunObject = page "Key Request List";
                            RunPageLink = "Key Status" = CONST(Received);
                        }
                    }
                    Group("Employee Parking Allocation")

                    {
                        action("Employee Parking Space List")
                        {
                            ApplicationArea = All;
                            Caption = 'Open Parking Application';
                            RunObject = page "Parking Space List";
                            RunPageLink = Status = CONST(Open);
                        }
                        action("Employee Pending Parking Space Application")
                        {
                            ApplicationArea = All;
                            Caption = 'Pending Parking Allocation';
                            //RunObject = page "Approved Parking - List";
                            RunObject = page "Parking Space List";
                            RunPageLink = Status = CONST(Pending);
                        }
                        action("Employee Approved Parking Space Application")
                        {
                            ApplicationArea = All;
                            Caption = 'Approved Parking Allocation';
                            //RunObject = page "Approved Parking - List";
                            RunObject = page "Parking Space List";
                            RunPageLink = Status = CONST(Approved);
                        }
                        action("Employee Rejected Parking Space Application")
                        {
                            ApplicationArea = All;
                            Caption = 'Rejected Parking Allocation';
                            //RunObject = page "Rejected Parking Space - List";
                            RunObject = page "Parking Space List";
                            RunPageLink = Status = CONST(Rejected);
                        }
                    }
                    action("Imprest List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Imprest List';
                        RunObject = page "Imprest List";
                        RunPageView = where(Posted = CONST(false));
                    }
                }

            }
            group("Reports")
            {
                Caption = 'Reports';

                group("Loans Report")
                {
                    Caption = 'Loans';
                    action("Loans Interest Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Loans Register';
                        RunObject = report "Loan Interest  Register";
                        Visible = false;
                    }
                    // action("Loan Listings Report")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Loan Listings Report';
                    //     RunObject = report "Loans Listing Report";
                    // }
                    action("Loan Register ")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loans List Report';
                        RunObject = report "Loan Register";

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
                    action("Loan Repayment Dues")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Repayment Dues';
                        RunObject = report "Loan Repayment Dues";

                    }
                    action("One Month Installments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'One Month Installments';
                        RunObject = report "One Month Installment";
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
                    action("Loan FallOff Recovery")
                    {
                        ApplicationArea = all;
                        Caption = 'Loan FallOff Recovery';
                        RunObject = report "Recovered Fresh Loans";

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
                    action("Post Lien")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Post Lien';
                        RunObject = report "Post Lien";
                    }
                    action("Generate CRB Data")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Generate CRB Data';
                        RunObject = report "Generate CRB Data";
                    }
                    action("Business Loans TAT")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Business Loans TAT";

                    }
                    action("Loans Collection Report")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Loan Collection Report";

                    }


                }
                group("Periodic Activitites Reports")
                {
                    Caption = 'Periodic Activities';
                    group("Monthly Billings")
                    {
                        Caption = 'Monthly Billing';
                        action("Monthly Bill Summary")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Monthly Bill Summary';
                            RunObject = report "Monthly Bill Summary";
                        }

                        // action("Needs Change Report")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Needs Change Report';
                        //     RunObject = report "Needs Change Report";
                        // }
                    }
                    group(Reminders)
                    {
                        action(BirthdayReminders)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Send Birtday Reminder SMS';
                            RunObject = report "Birthday Reminders";

                        }
                    }

                }
                group("Sasra")
                {
                    Caption = 'Sasra';

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

                    action("Anti-Money Laundering Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Anti-Money Laundering Report';
                        RunObject = report "Anti-Money Laundering Report";
                    }

                    action("Transaction Log-Finance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Transaction Log-Finance';
                        RunObject = XMLPort "Transaction Log-Finance";
                    }
                }


                group("Account Reports")
                {
                    Caption = 'Account Management';
                    action("Savings Accounts Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Savings Accounts Register';
                        RunObject = report "Savings Accounts Register";
                    }
                    action("FOSA Savings Register")
                    {
                        Visible = false;
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
                    action("Posted Journals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Journals';
                        RunObject = page "Posted General Journal";
                    }
                }
                group("Securities")
                {
                    Caption = 'Securities';
                    action("Security Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Collateral Register';
                        RunObject = report "Security Report";
                    }
                    action("Secured Loans Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Secured Loans Report';
                        RunObject = report "Secured Loans Report";
                    }
                }
            }


            group("Business Loans Setups")
            {

                Caption = 'Setup';
                group("General")
                {
                    caption = 'General';

                    action("General Set-Up")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'General Set-Up';
                        // RunObject = page "Gen set-up card";
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

                    action("Loan Purpose")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Purpose';
                        RunObject = page "Loan Purpose";
                    }
                    action("Tired Charges")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tiered Charges List';
                        RunObject = page "Tiered Charges List";
                    }

                }
            }
        }
    }
}



profile "Business Loans"
{
    Caption = 'Business Loans Role Center';
    RoleCenter = "Business Loans";
    ProfileDescription = 'Business Loans Role Center';
}
