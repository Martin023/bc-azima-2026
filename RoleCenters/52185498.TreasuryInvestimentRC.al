page 52185498 "Treasury RC"
{
    Caption = 'Treasury and Investiment RC';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Control76; customheadline)
            {
                ApplicationArea = Basic, Suite;
            }
            part("Treasury Cue Page"; "Treasury Cue Page")
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
            part(PowerBIEmbeddedReportPart; "Power BI Embedded Report Part")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control9; "Help And Chart Wrapper")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        area(Sections)
        {

            group("Investment")
            {
                Caption = 'Investments';
                group("Money Market")
                {
                    caption = 'Investments';
                    action("Investments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Open Investments';
                        RunObject = page "Investment List";
                        RunPageView = where(Status = filter(Open), Posted = const(false));
                    }
                    action("Pending Investments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pending Investments';
                        RunObject = page "Investment List";
                        RunPageView = where(Status = filter("Pending Approval"), Posted = const(false));
                    }
                    action("Rejected Investments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Rejected Investments';
                        RunObject = page "Investment List";
                        RunPageView = where(Status = filter(Rejected), Posted = const(false));
                    }
                    action("Approved Investments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Investments';
                        RunObject = page "Investment List";
                        RunPageView = where(Status = filter(Approved), Posted = const(false));
                    }
                    action("Active Investments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Active Investments';
                        RunObject = page "Investment List";
                        RunPageView = where(Status = filter(Fulfilled), Posted = const(true));
                    }
                    action("Matured Investments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Matured Investments';
                        RunObject = page "Investment List";
                        RunPageView = where(Status = filter(Matured), Posted = const(true));
                    }
                }
                group(InvestmentInterests)
                {
                    Caption = 'Investments Interests';
                    action("Investments Interest")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Open Investments Interests';
                        RunObject = page "Investment Interest List";
                        RunPageView = where(Status = filter(Open), Posted = const(false));
                    }
                    action("Pending Investments Interests")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pending Investments Interests';
                        RunObject = page "Investment Interest List";
                        RunPageView = where(Status = filter("Pending Approval"), Posted = const(false));
                    }
                    action("Approved Investments Interests")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Investments Interests';
                        RunObject = page "Investment Interest List";
                        RunPageView = where(Status = filter(Approved), Posted = const(false));
                    }
                    action("Rejected Investments Interests")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Rejected Investments Interests';
                        RunObject = page "Investment Interest List";
                        RunPageView = where(Status = filter(Rejected), Posted = const(false));
                    }
                    action("Posted Investments Interests")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Closed Investments Interests';
                        RunObject = page "Investment Interest List";
                        RunPageView = where(Posted = filter(true));
                    }
                }
                group("Investment Setup")
                {
                    caption = 'Investment Setup';
                    action("Investment Type")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Investment Type';
                        RunObject = page "Investment Type";
                    }
                }
                group(InvestRecpt)
                {
                    Caption = 'Investment Receipt';

                    action("InvReceipt List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Investment Receipt List';
                        RunObject = page "Investment Receipts List";
                    }
                    action("InvPosted Receipt List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Investment Posted Receipt List';
                        RunObject = page "Posted Investment Receipt List";
                    }
                    action("Receipt and Payment Types")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Receipt and Payment Types';
                        RunObject = page "Receipt and Payment Types List";
                    }
                }
            }

            group("Tenancy")
            {
                caption = 'Tenancy';
                group("Conf & Meeting Room Booking")
                {
                    action("Invoicing for Hire of Halls")
                    {
                        ApplicationArea = All;
                        Caption = 'Invoicing for Hire of Halls';
                        //RunObject = page "Approved Conf & Meeting - List";
                        RunObject = page "MNS Conf & Meetings Appl List";
                        //RunPageLink = Status = CONST(Approved);
                        RunPageView = WHERE(Status = CONST(Approved), "Type of Meeting/Function" = Const(External));
                    }
                }
                group("Tenants")
                {
                    Caption = 'Tenants';
                    // action("Open Tenants")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Open Tenants';
                    //     RunObject = page "Tenant List";
                    //     RunPageLink = "Account Type" = CONST(Tenant);
                    //     RunPageView = WHERE(Status = CONST(New));
                    // }
                    // action("Tenants Pending Approval")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Tenants Pending Approval';
                    //     RunObject = page "Tenant List";
                    //     RunPageLink = "Account Type" = CONST(Tenant);
                    //     RunPageView = WHERE(Status = CONST("Pending Approval"));
                    // }
                    // action("Rejected Tenant")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Rejected Tenants';
                    //     RunObject = page "Tenant List";
                    //     RunPageLink = "Account Type" = CONST(Tenant);
                    //     RunPageView = WHERE(Status = CONST(Rejected));
                    // }
                    action("Approved Tenant")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tenants List';
                        RunObject = page "Tenant List";
                        RunPageLink = "Account Type" = CONST(Tenant);
                        RunPageView = WHERE(Status = CONST(Approved));
                    }
                }
                group("Buildings & Property")
                {
                    Caption = 'Buildings & Property';
                    action("Building List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Building List';
                        runobject = page "Property List";
                    }
                    action("Units")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Units';
                        runobject = page "Unit List";
                    }

                    action("Land List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Land List';
                        RunObject = page "Land Property List";
                    }
                    action("Active Property List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Active Property List';
                        RunObject = page "Active Property List";
                    }
                }

                group("Lease Management")
                {
                    caption = 'Lease Management';
                    // action("Lease List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Open Lease List';
                    //     RunObject = page "Lease-List";
                    //     RunPageLink = Status = CONST(Open);
                    // }
                    // action("Pending Lease List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Pending Lease List';
                    //     RunObject = page "Lease-List";
                    //     RunPageLink = Status = CONST(Pending);
                    // }
                    // action("Rejected Lease List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Rejected Lease List';
                    //     RunObject = page "Lease-List";
                    //     RunPageLink = Status = CONST(Rejected);
                    // }
                    action("Approved Lease List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Active Leases List';
                        RunObject = page "Lease-List";
                        RunPageLink = Status = CONST(Approved);
                    }
                    action("Terminated Leases List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Terminated Leases List';
                        RunObject = page "Lease-List";
                        RunPageLink = Terminated = CONST(TRUE);
                    }
                }

                group("Setup")
                {
                    caption = 'Property Management Setups';
                    action("General Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'General Setup';
                        RunObject = page "Property General Setup";
                    }
                    action("Floor Codes")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Floor Codes';
                        RunObject = page "Floor Codes";
                    }
                    action("Charges")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Charges';
                        runobject = page "Charges List";
                    }
                    action("Units Type")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Units Types';
                        runobject = page "Unit Type List";
                    }
                    action("Business Types")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Business Types';
                        runobject = page "Business Types";
                    }
                    action("Property Expense List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Property Expense List';
                        RunObject = page "Property Expense List";
                    }
                    action("Common Area Charges")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Common Area Charges';
                        RunObject = page "Common Area Charges";
                    }
                    group("Escalation")
                    {
                        caption = 'Escalation';
                        action("Escalation For Tenants")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Escalation For Tenants';
                            RunObject = report "Tenant Escalation";
                        }
                        action("Escalation For Landlords")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Escalation For Landlords';
                            RunObject = report "Lease Escalation";
                        }
                    }
                }
                group("Sales Invoice")
                {
                    caption = 'Invoices & Credit Memos';
                    group(Sales)
                    {
                        action("Sales Invoices")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Sales Invoice';
                            RunObject = page "Sales Invoice List";
                        }
                        action("Posted Sales Invoice")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Sales Invoice';
                            RunObject = page "Posted Sales Invoices";
                        }
                    }
                    group(Memos)
                    {
                        Caption = 'Credit Memo';

                        action("Credit Memo")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Credit Memo';
                            RunObject = page "Sales Credit Memos";
                        }
                        action("Posted Credit Memo")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Credit Memo';
                            RunObject = page "Posted Sales Credit Memos";
                        }
                    }
                    group(TenantRecpt)
                    {
                        Caption = 'Tenant Receipt';
                        action("Receipt List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Tenant Receipt List';
                            RunObject = page "Tenant Receipts List";
                        }
                        action("Posted Receipt List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Tenant Posted Receipt List';
                            RunObject = page "Posted Tenant Receipt List";
                        }
                        action("Receipt and Payment Type")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Receipt and Payment Types';
                            RunObject = page "Receipt and Payment Types List";
                        }
                    }
                }
            }

            group(Employer)
            {
                Caption = 'Employers';

                action("Employer List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer List';
                    RunObject = page "Customer List";
                }
                action(STOL)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Standing Order List';
                    RunObject = page "Standing Order List";
                }
                action(STO)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Standing Order Register';
                    RunObject = page "Standing Order Register List";
                }
                action("Invoicing - Hire of Halls")
                {
                    ApplicationArea = All;
                    Caption = 'Invoicing for Hire of Halls';
                    RunObject = page "MNS Conf & Meetings Appl List";
                    RunPageView = WHERE(Status = CONST(Approved), "Type of Meeting/Function" = Const(External));
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
            group("Financial Entries")
            {
                Caption = 'Financial & Member Entries';
                group(Financial)
                {
                    Caption = 'Financial Entries';
                    action(GenJournal)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'General Journal';
                        RunObject = page "General Journal";
                    }
                    action(Register)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'G/L Register';
                        RunObject = page "G/L Registers";
                    }
                    action(GLEntries)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'General Ledger Entries';
                        RunObject = page "General Ledger Entries";
                    }
                    action(Edits)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'System Edits List';
                        RunObject = page "System Reversal List";
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
                    action(ChartOfAcc)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Chart Of Accounts';
                        RunObject = page "Chart of Accounts";
                    }
                    action(BankAccount)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Accounts List';
                        RunObject = page "Bank Account List";
                    }
                }
                group(Member)
                {
                    Caption = 'Member Entries';
                    action(Loan)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan List';
                        RunObject = page "Loan Posted List";
                    }
                    action(SavAcc)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Savings Accounts List';
                        RunObject = page "Savings Account List";
                    }
                    action(MemList)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member List';
                        RunObject = page "Member List";
                    }
                    action(Petty)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Petty Cash List';
                        RunObject = page "Posted Petty Cash Vouchers";
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
                        action("File List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'File Tracker List';
                            RunObject = page "File Tracker List";
                            RunPageView = where(Status = filter(<> archived));
                        }
                    }
                    group("Conf & Meeting Room Request")
                    {
                        Caption = 'Conf & Meeting Room Aplications';
                        action("Open Conference Hall & Meeting Rooms")
                        {
                            ApplicationArea = All;
                            Caption = 'Open Bookings';
                            RunObject = page "MNS Conf & Meetings Appl List";
                            RunPageLink = Status = CONST(Open);
                        }
                        action("Pending Conf & Meeting Room Bookings")
                        {
                            ApplicationArea = All;
                            Caption = 'Pending Bookings';
                            //RunObject = page "Pending Conf & Meeting - List";
                            RunObject = page "MNS Conf & Meetings Appl List";
                            RunPageLink = Status = CONST(Pending);
                        }
                        action("Approved Conf & Meeting Room Bookings")
                        {
                            ApplicationArea = All;
                            Caption = 'Approved Booking';
                            //RunObject = page "Approved Conf & Meeting - List";
                            RunObject = page "MNS Conf & Meetings Appl List";
                            RunPageLink = Status = CONST(Approved);
                        }

                        action("Rejected Conf & Meeting Room Bookings")
                        {
                            ApplicationArea = All;
                            Caption = 'Declined Bookings';
                            //RunObject = page "Rejected Conf & Meeting - List";
                            RunObject = page "MNS Conf & Meetings Appl List";
                            RunPageLink = Status = CONST(Rejected);
                        }
                        action("Closed Conf & Meeting Room Bookings")
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
            group("Reports and Analysis")
            {
                Caption = 'Reports';
                group("Investment Reports")
                {
                    Caption = 'Investment Report';
                    action("Current Placed Investment Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Current Placed Investment Report';
                        RunObject = report "Current Placed Investments";
                    }
                    action("Matured Investment")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Matured Investment';
                        RunObject = report "Matured Investments";
                    }
                    action("All Investments Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'All Investments Report';
                        RunObject = report "All Investments Report";
                    }
                    action(InvestmentMovement)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Investment and Interest Income(Monthly)';
                        RunObject = report "Investment and Interest Income";
                    }
                    action("Investment Movement Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Investment Movement Report';
                        RunObject = report "Investment Movement Report";
                    }
                    action("Prorated Invest Interest")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Prorated Invest Interest';
                        RunObject = report "Prorated Invest Interest";
                    }
                    action(InvestmentInterestt)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Investment Accrued Interest';
                        RunObject = report "Invest Accumulated Interest";
                    }
                    action("Investment Comparison report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Investment Interest';
                        RunObject = report "Invest Historical Comparison";
                    }
                }
                group("Employer Reports")
                {
                    Caption = 'Employer Reports';
                    action("Employer Aging Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Aging Report';
                        RunObject = report "New Customer Aging Report";
                    }
                    action("Comparison EmployerReport")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employer Comparison Report';
                        RunObject = report "Employer Comparison Report";
                    }
                    action("Comparison Employer Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employer Monthly Movement Report';
                        RunObject = report "Revenue Collection Report";
                    }
                    action("Employer Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Summary Aging Report';
                        RunObject = report "Customer Summary Aging Report";
                    }
                    action("Employer Email Status")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employer Email Status Report';
                        RunObject = report "Employer Email Status";
                    }
                    action("Employer Shares & Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employer Shares & Loans Report';
                        RunObject = report "Employer Shares & Loans";
                    }
                    action("Expected BOSA Contributions")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Expected BOSA Contributions Report';
                        RunObject = report "Expected BOSA Contributions";
                    }
                    action("Loan Defaulter Aging")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loans Defaulter Aging';
                        RunObject = report "Summarry-Loans Defaulter Aging";
                    }
                    action("Ideal Repayment Schedule")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Repayment Schedule Report';
                        RunObject = report "Ideal Repayment Schedule";
                    }
                    action(MemberRegister)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member Register(Expected)';
                        RunObject = report "Member Register";
                    }
                    action("Member Receipt Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member Monthly Deposit Receipts Report';
                        RunObject = report "Member Receipt Report";
                    }
                    action("Deposit Monthly Receipt Report ")
                    {
                        ApplicationArea = all;
                        Caption = 'Monthly Savings Receipts Summary Report';
                        RunObject = report "Monthly Receipt ";
                    }
                    action("Loan Monthly Receipt Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Monthly Receipt Report';
                        RunObject = report "Loan Monthly Receipt Report";
                    }
                    action("Employer Movement Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employer Movement Report';
                        RunObject = report "Employer Movement Report";
                    }
                    action(MemBalReg)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member Contribution Register';
                        RunObject = report "Member Balance Register";
                    }
                    action("Loan Register ")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loans Register Report';
                        RunObject = report "Loan Register";
                    }
                    action("Employer Member Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employer Member Register';
                        RunObject = report "Employer Member Register";
                    }
                    action(EmployerRegFee)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employer Reg Fee Variance';
                        RunObject = report "Reg Fee Arrears";
                    }
                    // action("Member Listing Report")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Member Listing Report';
                    //     RunObject = Report "Members Register - Active";
                    // }

                }
                group("Tenants Reports")
                {
                    Caption = 'Tenants Reports';
                    action("Posted Invoices")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tenants Posted Invoices';
                        RunObject = report "Posted Invoices";
                    }
                    action("Tenants Posted Receipt")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tenants Posted Receipts';
                        RunObject = report "Posted Tenants Receipt";
                    }
                    // action("Tenants Email Report")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Tenants Email Report';
                    //     RunObject = report "Tenant Email Report";
                    // }
                    action(TenantMovtReport)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tenant Movement Report';
                        RunObject = report "Tenant Movement Report";
                    }
                    action("Tenant Leases")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tenants Leases Report';
                        RunObject = report "Tenant Leases";
                    }
                    action("Expired Leases")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Expired Leases Report';
                        RunObject = report "Expired Leases";
                    }
                    // action("Tenant Receipt")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Tenant Receipt';
                    //     RunObject = report "Tenant Receipt";
                    // }
                    action("Reversed Invoices/Receipt")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Reversed Invoices/Receipt';
                        RunObject = report "Reversed Invoices & Receipts";
                    }
                    action("Tenants Electricity Charges")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tenants Electricity Charges Report';
                        RunObject = report "Tenants Electricity Charges";
                    }
                    action("Tenant Debtor Listing")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tenant Debtor Listing Report';
                        RunObject = report "Tenant Debtor Listing";
                        Visible = false;
                    }
                    action("Tenant Arrears Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tenant Revenue Collection Report';
                        RunObject = report "Tenant Arrears Report";

                    }
                    action("Terminated Leases")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Terminated Leases Report';
                        RunObject = report "Terminated Leases";
                    }
                    action("Tenant Listing")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tenants Deposit Listing Report';
                        RunObject = report "Tenant Listing";
                    }
                    action("Tenant Outstanding Balance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tenant Outstanding Balance Report';
                        RunObject = report "Tenant Outstanding Balance";
                    }
                    action("Tenant Income Earned")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tenant Income Earned Report';
                        RunObject = report "Tenant Income Earned";
                    }
                    action("Tenant Waivers")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Waived Tenants';
                        RunObject = report "Waived Tenants";
                    }
                    action("Vacant Offices")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vacant Offices Report';
                        RunObject = report "Vacant Offices Report";
                    }
                    action(TenantAging)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tenant Aging Report';
                        RunObject = report "Tenant Aging Report";
                    }
                }

                group("Financial Reports")
                {
                    Caption = 'Financial Reports';
                    action("Petty Cash Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Petty Cash Report';
                        RunObject = report "Petty Cash FOSA Report";
                    }
                    action("FOSA Treasury Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'FOSA Branch Treasury Report';
                        RunObject = report "FOSA Treasury Report";
                    }
                    action("MPESA Bank Bal Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'MPESA Balance And Account Balances Report';
                        RunObject = report "MPESA Bank Bal Report";
                    }
                    action("Savings Accounts Register List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Savings Accounts Register List';
                        RunObject = page "Savings Accounts";
                    }
                    action("Deposit Listing Report ")
                    {
                        ApplicationArea = all;
                        Caption = 'Deposit Listing Report';
                        RunObject = report "Deposit Listing Report";
                    }

                }
            }

        }
    }
}




