page 52185502 "Debt Management Unit"
{
    ApplicationArea = All;
    Caption = 'DMU Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Control76; CustomHeadline)
            {
                ApplicationArea = Basic, Suite;
            }
            part("DMU Cues"; "DMU Cues")
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
            group(Lists)
            {
                Caption = 'Lists';
                action("Member List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Member List";
                }
                action("Savings Accounts List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Savings Accounts";;
                }
                action("Loan List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Loan List';
                    RunObject = Page "Loan Posted List";
                }
                group("CRB Listing")
                {
                    Caption = 'CRB Listing';
                    group("Daily CRB Listing")
                    {
                        Caption = 'Daily CRB Listing Lists';
                        // action("Daily CRB Listing - TransUnion")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Daily CRB Listing - TransUnion';
                        //     RunObject = Page "CRB DPI File Submissions";
                        //     RunPageView = where("CRB Institution" = Const('TRANSUNION'));
                        // }
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
                        // action("Monthly CRB Listing ICE - TransUnion")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Monthly CRB Listing (Individual) - TransUnion';
                        //     RunObject = Page "CRB Monthly ICE File Subm.";
                        //     RunPageView = where("CRB Institution" = Const('TRANSUNION'));
                        // }
                        // action("Monthly CRB Listing NICE - TransUnion")
                        // {
                        //     ApplicationArea = Basic, Suite;
                        //     Caption = 'Monthly CRB Listing (Non-Individual) - TransUnion';
                        //     RunObject = Page "CRB Monthly NICE File Subm.";
                        //     RunPageView = where("CRB Institution" = Const('TRANSUNION'));
                        // }

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
                action("Checkoff Advice Lines")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Checkoff Advice Lines';
                    RunObject = Page "Checkoff Advice";
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
            }

            group("Case Forwarding")
            {
                action("Unforwarded Cases")
                {
                    Description = 'Originator Status is new and Org Dept is equal to the user dept';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Unforwarded Cases";
                }
                action("Forwarded Cases")
                {
                    Description = 'Originator Status is not new and Org Dept is equal to the user dept';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Forwarded Cases";
                    RunPageView = where("Case Closed" = const(false));
                }
                action("Received Cases")
                {
                    Description = 'Originator Status is not new and Curr Dept is equal to the user dept';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Received Cases";
                    RunPageView = where("Case Closed" = const(false));

                }
                action("Actioned Cases")
                {
                    Description = 'Case Closed True';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Actioned Cases";
                }
            }

            group("Loan Activity")
            {

                Caption = 'Loan Activity';

                group("Manual Loans Upload")
                {
                    action("Guarantors Upload")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport guarantors;
                    }

                    action("Loans Upload")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = xmlport "Loans migration";
                    }
                }
                group("Promise Topay")
                {
                    action("New Promise Topay")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Promise Topay Header";
                        RunPageView = where("Promise Status" = const(New));

                    }
                    action("Active Promise Topay")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Promise Topay Header F";
                        RunPageView = where("Promise Status" = const(Active));

                    }
                    action("Closed Promise Topay")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Promise Topay Header";
                        RunPageView = where("Promise Status" = const(Closed));
                    }
                }
                group("New System Recoveries")
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

                group("Old System Recoveries")
                {
                    group("Loan Attachmnet II")
                    {

                        Caption = 'Loan Attachmnet';

                        action("Update Old Attached Loans")
                        {
                            Caption = 'Update Old Attached Loans';
                            ApplicationArea = Basic, Suite;
                            RunObject = report "Recovery Header II Update";
                        }
                        action("Open Attachments II")
                        {
                            Caption = 'Open Attachments';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Loan Recovery Header List II";
                            RunPageLink = status = const(open), "Recovery Type" = const("Recovery and Attachment");
                        }
                        action("Pending Attachments II")
                        {
                            Caption = 'Pending Attachments';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Loan Recovery Header List II";
                            RunPageLink = status = const(Pending), "Recovery Type" = const("Recovery and Attachment");
                        }
                        action("Approved Attachments II")
                        {
                            Caption = 'Approved Attachments';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Loan Recovery Header List II";
                            RunPageLink = status = const(Approved), "Recovery Type" = const("Recovery and Attachment"), Action = const(" ");
                        }
                        action("Posted Attachments II")
                        {
                            Caption = 'Posted Attachments';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Posted Loan Recovery Header II";
                            RunPageLink = status = const(Approved), "Recovery Type" = const("Recovery and Attachment"), Action = const(Recovered);

                        }
                        action("Deffered Attachments II")
                        {
                            Caption = 'Deffered Attachments';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Loan Recovery Header List II";
                            RunPageLink = status = const(Deffered), "Recovery Type" = const("Recovery and Attachment");

                        }
                        action("Rejected Attachments II")
                        {
                            Caption = 'Rejected Attachments';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Posted Loan Recovery Header II";
                            RunPageLink = status = const(Rejected), "Recovery Type" = const("Recovery and Attachment");
                        }
                    }


                    group("Reappotionments II")
                    {
                        Caption = 'Reappotionments';
                        action("Open Reappotionments II")
                        {
                            Caption = 'Open Reappotionments';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Loan Recovery Header List II";
                            RunPageLink = status = const(open), "Recovery Type" = const(Reappotionment);
                        }
                        action("Pending Reappotionments II")
                        {
                            Caption = 'Pending Reappotionments';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Loan Recovery Header List II";
                            RunPageLink = status = const(Pending), "Recovery Type" = const(Reappotionment);
                        }
                        action("Approved Reappotionments II")
                        {
                            Caption = 'Approved Reappotionments';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Loan Recovery Header List II";
                            RunPageLink = status = const(Approved), "Recovery Type" = const(Reappotionment), Action = const(" ");
                        }
                        action("Posted Reappotionments II")
                        {
                            Caption = 'Posted Reappotionments';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Posted Loan Recovery Header II";
                            RunPageLink = status = const(Approved), "Recovery Type" = const(Reappotionment), Action = const(Reappotioned);

                        }
                        action("Deffered Reappotionments II")
                        {
                            Caption = 'Deffered Reappotionments';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Loan Recovery Header List II";
                            RunPageLink = status = const(Deffered), "Recovery Type" = const(Reappotionment);

                        }
                        action("Rejected Reappotionments II")
                        {
                            Caption = 'Rejected Reappotionments';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Posted Loan Recovery Header II";
                            RunPageLink = status = const(Rejected), "Recovery Type" = const(Reappotionment);
                        }
                    }

                    group("Reversals II")
                    {
                        Caption = 'Reversals';
                        action("Open Reversals II")
                        {
                            Caption = 'Open Reversals';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Loan Recovery Header List II";
                            RunPageLink = status = const(open), "Recovery Type" = const(Reversal);
                        }
                        action("Pending Reversals II")
                        {
                            Caption = 'Pending Reversals';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Loan Recovery Header List II";
                            RunPageLink = status = const(Pending), "Recovery Type" = const(Reversal);
                        }
                        action("Approved Reversals II")
                        {
                            Caption = 'Approved Reversals';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Loan Recovery Header List II";
                            RunPageLink = status = const(Approved), "Recovery Type" = const(Reversal), Action = const(" ");
                        }
                        action("Posted Reversals II")
                        {
                            Caption = 'Posted Reversals';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Posted Loan Recovery Header II";
                            RunPageLink = status = const(Approved), "Recovery Type" = const(Reversal), Action = const(Reversed);

                        }
                        action("Deffered Reversals II")
                        {
                            Caption = 'Deffered Reversals';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Loan Recovery Header List II";
                            RunPageLink = status = const(Deffered), "Recovery Type" = const(Reversal);

                        }
                        action("Rejected Reversals II")
                        {
                            Caption = 'Rejected Reversals';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Posted Loan Recovery Header II";
                            RunPageLink = status = const(Rejected), "Recovery Type" = const(Reversal);
                        }
                    }
                }

                group("External Debt Collectors")
                {
                    action("Vendor List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Vendor List";
                        RunPageView = where("Vendor Type" = const("External Debt Collectors"));

                    }
                    group(Staging)
                    {
                        action("Debt Collectors Staging")
                        {
                            Caption = 'Staged Loans';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Debt Collectors Staging";
                            RunPageView = where(Posted = const(false));

                        }
                        action("Debt Collectors Posted")
                        {
                            Caption = 'Posted Loans';
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Debt Collectors Staging";
                            RunPageView = where(Posted = const(true));

                        }
                    }
                    group("Debt Collectors Header")
                    {
                        action("Open Headers")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Debt Collectors Header List";
                            RunPageView = where(Closed = const(false));

                        }
                        action("Closed Headers")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Debt Collectors Header List";
                            RunPageView = where(Closed = const(true));

                        }
                    }

                }

                group("System Reversals")
                {
                    action("System Reversal List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "System Reversal List";
                    }
                    action("Posted Reversal List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Posted Reversal List";
                    }
                }

                action("SASRA Loan Categorization.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SASRA Loan Categorization';
                    RunObject = report "SASRA Loan Categorization";
                }
                action("Schedule All Loans")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Schedule All Loans";
                }
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
                action("Store Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Store Requisition';
                    RunObject = Page "Store Requisitions List";
                }
                action("Payslip")
                {
                    ApplicationArea = all;
                    Caption = 'Payslip';
                    RunObject = report "Self Service Slip";
                }
                // group("Employee Requests")
                // {

                //     group("File Requests.")
                //     {
                //         action("Request File")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Request File';
                //             RunObject = page "File Request List";
                //             RunPageView = where(Status = filter(open));
                //         }
                //         action("File Request")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Files Requested';
                //             RunObject = page "File Request List";
                //             RunPageView = where(Status = filter(requested));
                //         }
                //         action("Closed File Request")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Closed Files Requests.';
                //             RunObject = page "File Request List";
                //             RunPageView = where(Status = filter(closed));
                //         }
                //         action("File List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'File Tracker List';
                //             RunObject = page "File Tracker List";
                //             RunPageView = where(Status = filter(<> archived));
                //         }
                //     }

                //     group("File Tracking")
                //     {
                //         action("File Tracker List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'File Tracker List';
                //             RunObject = page "File Tracker List";
                //             RunPageView = where(Status = filter(<> archived));
                //         }
                //     }
                //     group("Conf & Meeting Room Booking")
                //     {
                //         Caption = 'Conf & Meeting Room Aplications';
                //         action("Conference Hall & Meeting Rooms")
                //         {
                //             ApplicationArea = All;
                //             Caption = 'Open Bookings';
                //             RunObject = page "MNS Conf & Meetings Appl List";
                //             RunPageLink = Status = CONST(Open);
                //         }
                //         action("Pending Conf & Meeting Room Booking")
                //         {
                //             ApplicationArea = All;
                //             Caption = 'Pending Bookings';
                //             //RunObject = page "Pending Conf & Meeting - List";
                //             RunObject = page "MNS Conf & Meetings Appl List";
                //             RunPageLink = Status = CONST(Pending);
                //         }
                //         action("Approved Conf & Meeting Room Booking")
                //         {
                //             ApplicationArea = All;
                //             Caption = 'Approved Booking';
                //             //RunObject = page "Approved Conf & Meeting - List";
                //             RunObject = page "MNS Conf & Meetings Appl List";
                //             RunPageLink = Status = CONST(Approved);
                //         }
                //         action("Invoicing for Hire of Halls")
                //         {
                //             ApplicationArea = All;
                //             Caption = 'Invoicing for Hire of Halls';
                //             //RunObject = page "Approved Conf & Meeting - List";
                //             RunObject = page "MNS Conf & Meetings Appl List";
                //             //RunPageLink = Status = CONST(Approved);
                //             RunPageView = WHERE(Status = CONST(Approved), "Type of Meeting/Function" = Const(External));
                //         }
                //         action("Rejected Conf & Meeting Room Booking")
                //         {
                //             ApplicationArea = All;
                //             Caption = 'Declined Bookings';
                //             //RunObject = page "Rejected Conf & Meeting - List";
                //             RunObject = page "MNS Conf & Meetings Appl List";
                //             RunPageLink = Status = CONST(Rejected);
                //         }
                //         action("Closed Conf & Meeting Room Booking")
                //         {
                //             ApplicationArea = All;
                //             Caption = 'Closed Bookings';
                //             //RunObject = page "Closed Conf & Meeting - List";
                //             RunObject = page "MNS Conf & Meetings Appl List";
                //             RunPageLink = "Status of the Booking" = CONST(Closed);
                //         }
                //     }
                //     Group("Motor Vehicle Requests")
                //     {
                //         Caption = 'Motor Vehicle Requests';
                //         action("Vehicle Request Application")
                //         {
                //             ApplicationArea = all;
                //             Caption = 'Open Vehicle Requests';
                //             RunObject = page "Motor Vehicle Request List";
                //             RunPageLink = Status = CONST(Open);
                //         }
                //         action("Pending Vehicle Requests")
                //         {
                //             ApplicationArea = all;
                //             Caption = 'Pending Vehicle Requests';
                //             RunObject = page "Motor Vehicle Request List";
                //             RunPageLink = Status = CONST(Pending);
                //         }
                //         action("Approved Vehicle Requests")
                //         {
                //             ApplicationArea = all;
                //             Caption = 'Approved Vehicle Requests';
                //             //RunObject = page "Approved Vehicle Req - List";
                //             RunObject = page "Motor Vehicle Request List";
                //             RunpageLink = Status = CONST(Approved);
                //         }
                //         action("Deffered Vehicle Requests")
                //         {
                //             ApplicationArea = all;
                //             Caption = 'Deffered Vehicle Requests';
                //             RunObject = page "Deffered Vehicle Req - List";
                //         }
                //         action("Reject Vehicle Requests")
                //         {
                //             ApplicationArea = all;
                //             Caption = 'Rejected Vehicle Requests';
                //             //RunObject = page "Rejected Vehicle Req - List";
                //             RunObject = page "Motor Vehicle Request List";
                //             RunPageLink = Status = CONST(Rejected);
                //         }
                //         action("Closed Vehicle Request")
                //         {
                //             ApplicationArea = all;
                //             Caption = 'Closed Vehicle Request';
                //             //RunObject = page "Closed Vehicle Req - List";
                //             RunObject = page "Motor Vehicle Request List";
                //             RunPageLink = Status = CONST(Closed);
                //         }
                //         action("Reallocated Requests")
                //         {
                //             ApplicationArea = all;
                //             Caption = 'Reallocated Requests';
                //             RunObject = page "Motor Vehicle Request List";
                //             RunPageLink = Reallocated = CONST(TRUE);
                //         }
                //     }
                //     group("Key Requests")
                //     {
                //         action("Open Keys Request")
                //         {
                //             ApplicationArea = All;
                //             Caption = 'Office Keys Request';
                //             RunObject = page "Key Request List";
                //             RunPageLink = Status = CONST(Open);
                //         }
                //         action("Pending Keys Request")
                //         {
                //             ApplicationArea = All;
                //             Caption = 'Pending Requests';
                //             RunObject = page "Key Request List";
                //             RunPageLink = Status = CONST(Pending);
                //         }
                //         action("Approved Keys Request")
                //         {
                //             ApplicationArea = All;
                //             Caption = 'Approved Requests';
                //             RunObject = page "Key Request List";
                //             RunPageLink = Status = CONST(Approved);
                //         }
                //         action("Rejected Keys Request")
                //         {
                //             ApplicationArea = All;
                //             Caption = 'Rejected Key Request';
                //             RunObject = page "Key Request List";
                //             RunPageLink = Status = CONST(Rejected);
                //         }
                //         action("Closed Keys Request")
                //         {
                //             ApplicationArea = All;
                //             Caption = 'Closed Key Requests';
                //             RunObject = page "Key Request List";
                //             RunPageLink = "Key Status" = CONST(Received);
                //         }
                //     }
                //     Group("Parking Allocation")
                //     {
                //         action("Parking Space List")
                //         {
                //             ApplicationArea = All;
                //             Caption = 'Open Parking Application';
                //             RunObject = page "Parking Space List";
                //             RunPageLink = Status = CONST(Open);
                //         }
                //         action("Pending Parking Space Application")
                //         {
                //             ApplicationArea = All;
                //             Caption = 'Pending Parking Allocation';
                //             //RunObject = page "Approved Parking - List";
                //             RunObject = page "Parking Space List";
                //             RunPageLink = Status = CONST(Pending);
                //         }
                //         action("Approved Parking Space Application")
                //         {
                //             ApplicationArea = All;
                //             Caption = 'Approved Parking Allocation';
                //             //RunObject = page "Approved Parking - List";
                //             RunObject = page "Parking Space List";
                //             RunPageLink = Status = CONST(Approved);
                //         }
                //         action("Rejected Parking Space Application")
                //         {
                //             ApplicationArea = All;
                //             Caption = 'Rejected Parking Allocation';
                //             //RunObject = page "Rejected Parking Space - List";
                //             RunObject = page "Parking Space List";
                //             RunPageLink = Status = CONST(Rejected);
                //         }
                //     }
                // }

            }
            group(SetUps)
            {
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
                action("DMU SMS Templates")
                {
                    ApplicationArea = All;
                    RunObject = page "SMS Templates";
                }


            }
            group(Reports)
            {
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
                action("Promise To Pay Report")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Promise To Pay Report";
                }
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
               
                

                
            }
        }
    }
}

// profile "Debt Management Unit"
// {
//     Caption = 'Debt Management Unit Role Center';
//     RoleCenter = "Debt Management Unit";
//     ProfileDescription = 'Debt Management Unit Role Center';
// }