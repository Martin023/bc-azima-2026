// page 52186780 "Corporate Department"
// {
//     Caption = 'Corporate Department';
//     PageType = RoleCenter;

//     layout
//     {
//         area(RoleCenter)
//         {
//             part(Control76; customheadline)
//             {
//                 ApplicationArea = Basic, Suite;
//             }
//             part("Treasury Cue Page"; "Treasury Cue Page")
//             {
//                 ApplicationArea = Basic, Suite;
//             }
//             part(ApprovalsActivities; "Approvals Activities")
//             {
//                 ApplicationArea = Suite;
//             }
//             part("Emails"; "Email Activities")
//             {
//                 ApplicationArea = Basic, Suite;
//             }
//         }
//     }
//     actions
//     {
//         area(Sections)
//         {

//             Group("Applications Report")
//             {
//                 Caption = 'Applications Report';
//                 action("Applications Reports")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Product Applications';
//                     RunObject = report "Member Application Register";
//                 }
//                 action("Daily Member Application")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Daily Member Application Report';
//                     RunObject = Report "Daily Membership Report";
//                 }
//                 action("Member Listing Report")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Member Listing - List';
//                     RunObject = page "Member Listing Report";

//                 }
//                 action("Member Details Check Report")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Member Details Check Report';
//                     RunObject = report "Member Details Check Report";
//                 }
//                 action("Member Portfolio Report")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Member Portfolio Report';
//                     RunObject = report "Member Portfolio";
//                 }

//             }
//             Group("General Statements")
//             {
//                 group("Loans")
//                 {
//                     Caption = 'Loan statements';
//                     action("Loan statements")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Loan statements';
//                         RunObject = report "Loan Statement";
//                     }
//                 }
//                 Group("Members")
//                 {
//                     Caption = 'Member Statement';
//                     action("Member Statements")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Statements';
//                         RunObject = report "Member Statement";
//                     }
//                 }
//                 Group("Repayment")
//                 {
//                     Caption = 'Loan Repayment';
//                     action("Ideal Repayment Schedule")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Loan Repayment';
//                         RunObject = report "Ideal Repayment Schedule";
//                     }
//                 }
//                 Group("Loans Repayment")
//                 {
//                     Caption = 'Loans Repayment';
//                     action("Loan repayments")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Loan Repayment';
//                         RunObject = report "Loan Repayment Dues Summaries";
//                     }
//                 }
//             }
//             Group("Accounts")

//             {
//                 Group("Member Accounts")
//                 {
//                     Caption = 'Accounts';
//                     action("Member Account")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Member Accounts';
//                         RunObject = page "Savings Accounts";
//                         ;
//                     }
//                 }
//                 Group("Deposit Listings")
//                 {
//                     Caption = 'Deposit Listing Report';
//                     action("Deposit Listing")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Deposit Listing';
//                         RunObject = report "Deposit Listing Report";
//                     }
//                 }
//                 Group("Bosa Accounts")
//                 {
//                     Caption = 'Bosa Accounts';
//                     action("Bosa Account Arrears")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Member Accounts';
//                         //RunObject = report "BOSA Account Arreas Report";
//                     }
//                 }
//                 group("Credit accounts")
//                 {
//                     action("Credit Accounts List")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Credit Accounts';
//                         RunObject = Page "Credit Accounts List";
//                     }
//                 }
//             }


//             Group("Loan Appraisal")

//             {
//                 Group("Loan Appraisals")
//                 {
//                     Caption = 'Loan Appraisal';
//                     action("Appraisal")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Loan Appraisal';
//                         RunObject = page "Loan Calculator";
//                     }
//                 }
//             }
//             Group("Loan Posted List")

//             {
//                 Group("Approved Loans")
//                 {
//                     Caption = 'Approved Loans';
//                     action("Approved Loan")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Loan Appraisal';
//                         RunObject = page "Approved Loans List";
//                     }
//                     action("Loan Disbursement List")
//                     {
//                         ApplicationArea = Basic, Suite;
//                         caption = 'Loan Disbursement List';
//                         RunObject = page "Loan Disbursement List";
//                     }

//                 }
//             }
//             group(EmployeeSelfService)
//             {
//                 Caption = 'Employee Self Service';
//                 action(StaffWelfare)
//                 {
//                     Caption = 'Staff Welfare Claim';
//                     ApplicationArea = Basic, Suite;
//                     RunObject = page "Staff Welfare List";
//                 }
//                 action(LeaveApplication1)
//                 {
//                     Caption = 'Employee Leave Application';
//                     ApplicationArea = Basic, Suite;
//                     RunObject = page "HR Leave Applications List1";
//                 }
//                 action("Overtime Claim List")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Overtime';
//                     RunObject = page "Overtime Claim List";
//                 }
//                 action("System Rights Requisition")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'System Rights Requisition';
//                     RunObject = page "Permission Requisition Card";
//                 }
//                 action("Loan Application")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Apply Staff Loan';
//                     RunObject = page "Self Loan Application List";
//                 }
//                 group("Employee Requests")
//                 {

//                     group("File Requests.")
//                     {
//                         action("Request File")
//                         {
//                             ApplicationArea = Basic, Suite;
//                             Caption = 'Request File';
//                             RunObject = page "File Request List";
//                             RunPageView = where(Status = filter(open));
//                         }
//                         action("File Request")
//                         {
//                             ApplicationArea = Basic, Suite;
//                             Caption = 'Files Requested';
//                             RunObject = page "File Request List";
//                             RunPageView = where(Status = filter(requested));
//                         }
//                         action("Closed File Request")
//                         {
//                             ApplicationArea = Basic, Suite;
//                             Caption = 'Closed Files Requests.';
//                             RunObject = page "File Request List";
//                             RunPageView = where(Status = filter(closed));
//                         }
//                         action("File List")
//                         {
//                             ApplicationArea = Basic, Suite;
//                             Caption = 'File Tracker List';
//                             RunObject = page "File Tracker List";
//                             RunPageView = where(Status = filter(<> archived));
//                         }
//                     }
//                     group("Conf & Meeting Room Booking")
//                     {
//                         Caption = 'Conf & Meeting Room Aplications';
//                         action("Conference Hall & Meeting Rooms")
//                         {
//                             ApplicationArea = All;
//                             Caption = 'Open Bookings';
//                             RunObject = page "MNS Conf & Meetings Appl List";
//                             RunPageLink = Status = CONST(Open);
//                         }
//                         action("Pending Conf & Meeting Room Booking")
//                         {
//                             ApplicationArea = All;
//                             Caption = 'Pending Bookings';
//                             //RunObject = page "Pending Conf & Meeting - List";
//                             RunObject = page "MNS Conf & Meetings Appl List";
//                             RunPageLink = Status = CONST(Pending);
//                         }
//                         action("Approved Conf & Meeting Room Booking")
//                         {
//                             ApplicationArea = All;
//                             Caption = 'Approved Booking';
//                             //RunObject = page "Approved Conf & Meeting - List";
//                             RunObject = page "MNS Conf & Meetings Appl List";
//                             RunPageLink = Status = CONST(Approved);
//                         }
//                         action("Invoicing for Hire of Halls")
//                         {
//                             ApplicationArea = All;
//                             Caption = 'Invoicing for Hire of Halls';
//                             //RunObject = page "Approved Conf & Meeting - List";
//                             RunObject = page "MNS Conf & Meetings Appl List";
//                             //RunPageLink = Status = CONST(Approved);
//                             RunPageView = WHERE(Status = CONST(Approved), "Type of Meeting/Function" = Const(External));
//                         }
//                         action("Rejected Conf & Meeting Room Booking")
//                         {
//                             ApplicationArea = All;
//                             Caption = 'Declined Bookings';
//                             //RunObject = page "Rejected Conf & Meeting - List";
//                             RunObject = page "MNS Conf & Meetings Appl List";
//                             RunPageLink = Status = CONST(Rejected);
//                         }
//                         action("Closed Conf & Meeting Room Booking")
//                         {
//                             ApplicationArea = All;
//                             Caption = 'Closed Bookings';
//                             //RunObject = page "Closed Conf & Meeting - List";
//                             RunObject = page "MNS Conf & Meetings Appl List";
//                             RunPageLink = "Status of the Booking" = CONST(Closed);
//                         }
//                     }
//                     Group("Motor Vehicle Requests")
//                     {
//                         Caption = 'Motor Vehicle Requests';
//                         action("Vehicle Request Application")
//                         {
//                             ApplicationArea = all;
//                             Caption = 'Open Vehicle Requests';
//                             RunObject = page "Motor Vehicle Request List";
//                             RunPageLink = Status = CONST(Open);
//                         }
//                         action("Pending Vehicle Requests")
//                         {
//                             ApplicationArea = all;
//                             Caption = 'Pending Vehicle Requests';
//                             RunObject = page "Motor Vehicle Request List";
//                             RunPageLink = Status = CONST(Pending);
//                         }
//                         action("Approved Vehicle Requests")
//                         {
//                             ApplicationArea = all;
//                             Caption = 'Approved Vehicle Requests';
//                             //RunObject = page "Approved Vehicle Req - List";
//                             RunObject = page "Motor Vehicle Request List";
//                             RunpageLink = Status = CONST(Approved);
//                         }
//                         action("Deffered Vehicle Requests")
//                         {
//                             ApplicationArea = all;
//                             Caption = 'Deffered Vehicle Requests';
//                             RunObject = page "Deffered Vehicle Req - List";
//                         }
//                         action("Reject Vehicle Requests")
//                         {
//                             ApplicationArea = all;
//                             Caption = 'Rejected Vehicle Requests';
//                             //RunObject = page "Rejected Vehicle Req - List";
//                             RunObject = page "Motor Vehicle Request List";
//                             RunPageLink = Status = CONST(Rejected);
//                         }
//                         action("Closed Vehicle Request")
//                         {
//                             ApplicationArea = all;
//                             Caption = 'Closed Vehicle Request';
//                             //RunObject = page "Closed Vehicle Req - List";
//                             RunObject = page "Motor Vehicle Request List";
//                             RunPageLink = Status = CONST(Closed);
//                         }
//                         action("Reallocated Requests")
//                         {
//                             ApplicationArea = all;
//                             Caption = 'Reallocated Requests';
//                             RunObject = page "Motor Vehicle Request List";
//                             RunPageLink = Reallocated = CONST(TRUE);
//                         }
//                     }
//                     group("Key Requests")
//                     {
//                         action("Open Keys Request")
//                         {
//                             ApplicationArea = All;
//                             Caption = 'Office Keys Request';
//                             RunObject = page "Key Request List";
//                             RunPageLink = Status = CONST(Open);
//                         }
//                         action("Pending Keys Request")
//                         {
//                             ApplicationArea = All;
//                             Caption = 'Pending Requests';
//                             RunObject = page "Key Request List";
//                             RunPageLink = Status = CONST(Pending);
//                         }
//                         action("Approved Keys Request")
//                         {
//                             ApplicationArea = All;
//                             Caption = 'Approved Requests';
//                             RunObject = page "Key Request List";
//                             RunPageLink = Status = CONST(Approved);
//                         }
//                         action("Rejected Keys Request")
//                         {
//                             ApplicationArea = All;
//                             Caption = 'Rejected Key Request';
//                             RunObject = page "Key Request List";
//                             RunPageLink = Status = CONST(Rejected);
//                         }
//                         action("Closed Keys Request")
//                         {
//                             ApplicationArea = All;
//                             Caption = 'Closed Key Requests';
//                             RunObject = page "Key Request List";
//                             RunPageLink = "Key Status" = CONST(Received);
//                         }
//                     }
//                     Group("Parking Allocation")
//                     {
//                         action("Parking Space List")
//                         {
//                             ApplicationArea = All;
//                             Caption = 'Open Parking Application';
//                             RunObject = page "Parking Space List";
//                             RunPageLink = Status = CONST(Open);
//                         }
//                         action("Pending Parking Space Application")
//                         {
//                             ApplicationArea = All;
//                             Caption = 'Pending Parking Allocation';
//                             //RunObject = page "Approved Parking - List";
//                             RunObject = page "Parking Space List";
//                             RunPageLink = Status = CONST(Pending);
//                         }
//                         action("Approved Parking Space Application")
//                         {
//                             ApplicationArea = All;
//                             Caption = 'Approved Parking Allocation';
//                             //RunObject = page "Approved Parking - List";
//                             RunObject = page "Parking Space List";
//                             RunPageLink = Status = CONST(Approved);
//                         }
//                         action("Rejected Parking Space Application")
//                         {
//                             ApplicationArea = All;
//                             Caption = 'Rejected Parking Allocation';
//                             //RunObject = page "Rejected Parking Space - List";
//                             RunObject = page "Parking Space List";
//                             RunPageLink = Status = CONST(Rejected);
//                         }
//                     }
//                 }
//             }
//             group(Finance)
//             {
//                 Caption = 'Finance';
//                 action("Share Capital Transfer List")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Share Capital Transfer List';
//                     RunObject = page "Share Capital Transfer List";
//                 }
//                 action("Posted Bank & Cash Transfer")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Posted Bank & Cash Transfer';
//                     RunObject = page "Posted Bank & Cash Transfer";
//                 }
//             }
//         }
//     }
// }

// profile "Corporate Department"
// {
//     Caption = 'Corporate Department Role Center';
//     RoleCenter = "Corporate Department";
//     ProfileDescription = 'Corporate Department Role Center';
// }


