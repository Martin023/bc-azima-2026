page 52187329 "Records"
{
    Caption = 'Records Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Control76; CustomHeadline)
            {
                ApplicationArea = Basic, Suite;
            }
            part("Records Activities Cue"; "Membership Activity cue")
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
            group("Ongoing Member Applications")
            {
                Caption = 'Ongoing Member Applications';
                // action("To Do Page")
                // {
                //     ApplicationArea = Basic, Suite;
                //     RunObject = Page "To Do";
                // }
                group("Single Applications")
                {
                    action("Open Member Applications List")
                    {
                        Caption = 'Open Member Single Application';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Open Member Application List";
                        //RunPageLink = Status = CONST(Open);
                        RunPageView = where(Status = const(Open), "Account Type" = const("Single Member Account"));
                    }
                    action("Pending Member Applications List")
                    {
                        Caption = 'Pending Member Single Application';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Open Member Application List";
                        //RunPageLink = Status = CONST(Pending);
                        RunPageView = where(Status = const(Pending), "Account Type" = const("Single Member Account"));
                    }
                    action("Approved Member Applications List")
                    {
                        Caption = 'Approved Member Single Application';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Open Member Application List";
                        //RunPageLink = Status = CONST(Approved);
                        RunPageView = where(Status = const(Approved), "Account Type" = const("Single Member Account"));
                    }
                    action("Created Member Application List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Created Member Application List';
                        RunObject = Page "Open Member Readmission List";
                        RunPageView = where(Created = const(true), "Account Type" = const("Single Member Account"));
                    }
                    action("Rejected Member Applications")
                    {
                        Caption = 'Rejected Member Applications';
                        RunObject = Page "Open Member Application List";
                        RunPageView = where(Status = Const(Rejected), "Account Type" = const("Single Member Account"));
                    }
                }
                // group("CRM Member Applications")
                // {
                //     group("New Applications")
                //     {
                //         action("N Open Member Application List")
                //         {
                //             Caption = 'Open Member Application List';
                //             ApplicationArea = Basic, Suite;
                //             RunObject = Page "Open Member Application List";
                //             RunPageView = where(Status = const(Open), "Source Aplication" = const(CRM), "Type of Application" = const("New Registration"), "Sent Back to CRM" = CONST(false));
                //         }
                //         action("N Sent To CRM List")
                //         {
                //             Caption = 'Sent To CRM List';

                //             ApplicationArea = Basic, Suite;
                //             RunObject = Page "Open Member Application List";
                //             RunPageView = where(Status = const(Open), "Source Aplication" = const(CRM), "Type of Application" = const("New Registration"), "Sent Back to CRM" = CONST(true));
                //         }
                //         action("N Pending Member Application List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Pending Member Application List';
                //             RunObject = Page "Pending Member Application";
                //             RunPageView = where("Source Aplication" = const(CRM), "Type of Application" = const("New Registration"));

                //         }
                //         action("N Approved Member Application List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Approved Member Application List';
                //             RunObject = Page "Approved Member Application";
                //             RunPageView = where("Source Aplication" = const(CRM), "Type of Application" = const("New Registration"));
                //         }
                //         action("N Deffered Member Application List")
                //         {
                //             Caption = 'Deffered Member Application List';

                //             ApplicationArea = Basic, Suite;
                //             RunObject = Page "Open Member Application List";
                //             RunPageView = where(Status = const(Deffered), "Source Aplication" = const(CRM), "Type of Application" = const("New Registration"), "Sent Back to CRM" = const(false));
                //         }
                //         action("N Rejected Member Application List")
                //         {
                //             Caption = 'Rejected Member Application List';

                //             ApplicationArea = Basic, Suite;
                //             RunObject = Page "Open Member Application List";
                //             RunPageView = where(Status = const(Rejected), "Type of Application" = const("New Registration"));
                //         }
                //         action("N Archived Application List")
                //         {
                //             Caption = 'Archived Application List';

                //             ApplicationArea = Basic, Suite;
                //             RunObject = Page "Open Member Application List";
                //             RunPageView = where(Status = const(Archived), "Type of Application" = const("New Registration"));
                //         }
                //     }
                group(Readmission)
                {
                    action("Open Member Application List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Open Member Readmission List";
                        RunPageView = where(Status = const(Open), "Account Type" = const("Single Member Account"));
                    }
                    // action("Sent To CRM List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     RunObject = Page "Open Member Application List";
                    //     RunPageView = where(Status = const(Open), "Source Aplication" = const(CRM), "Type of Application" = const(Readmission), "Sent Back to CRM" = CONST(true));
                    // }
                    action("Pending Member Application List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pending Member Application List';
                        RunObject = Page "Open Member Readmission List";
                        RunPageView = where("Type of Application" = const(Readmission), "Account Type" = const("Single Member Account"));

                    }
                    action("Approved Member Application List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Member Application List';
                        RunObject = Page "Open Member Readmission List";
                        RunPageView = where("Type of Application" = const(Readmission), "Account Type" = const("Single Member Account"));
                    }
                    action("Created Member Readmission List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Created Member Readmission List';
                        RunObject = Page "Open Member Readmission List";
                        RunPageView = where("Type of Application" = const(Readmission), "Account Type" = const("Single Member Account"), Created = const(true));

                    }
                    action("Deffered Member Application List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Open Member Readmission List";
                        RunPageView = where(Status = const(Deffered), "Type of Application" = const(Readmission), "Account Type" = const("Single Member Account"));
                    }
                    action("Rejected Member Application List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Open Member Readmission List";
                        RunPageView = where(Status = const(Rejected), "Type of Application" = const(Readmission), "Account Type" = const("Single Member Account"));
                    }
                    action("Archived Application List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Open Member Readmission List";
                        RunPageView = where(Status = const(Archived), "Type of Application" = const(Readmission), "Account Type" = const("Single Member Account"));
                    }
                }
                //}

                // group("Kenpipe Smart Applications")
                // {
                //     group("M-S New Applications")
                //     {
                //         Visible = false;
                //         action("N Open Application List")
                //         {
                //             Caption = 'Open Application List';
                //             ApplicationArea = Basic, Suite;
                //             RunObject = Page "Open Member Application List";
                //             RunPageView = where(Status = const(Open), "Source Aplication" = const("Kenpipe Smart"), "Type of Application" = const("New Registration"), "Sent Back to M-Smart" = CONST(false));
                //         }
                //         action("Sent To M-Smart List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             RunObject = Page "Open Member Application List";
                //             RunPageView = where(Status = const(Open), "Source Aplication" = const("Kenpipe Smart"), "Type of Application" = const("New Registration"), "Sent Back to M-Smart" = CONST(true));
                //         }
                //         action("N Pending Application List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Pending Member Application List';
                //             RunObject = Page "Pending Member Application";
                //             RunPageView = where(Status = const(Pending), "Source Aplication" = const("Kenpipe Smart"), "Type of Application" = const("New Registration"));

                //         }
                //         action("N Approved Application List")
                //         {

                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Approved Member Application List';
                //             RunObject = Page "Approved Member Application";
                //             RunPageView = where(Status = const(Approved), "Source Aplication" = const("Kenpipe Smart"), "Type of Application" = const("New Registration"));
                //         }
                //         action("N Deffered Application List")
                //         {
                //             Caption = 'Deffered Application List';

                //             ApplicationArea = Basic, Suite;
                //             RunObject = Page "Open Member Application List";
                //             RunPageView = where(Status = const(Deffered), "Source Aplication" = const("Kenpipe Smart"), "Type of Application" = const("New Registration"));
                //         }
                //     }
                //     group("M-S Readmission Applications")
                //     {
                //         action("Open Application List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             RunObject = Page "Open Member Application List";
                //             RunPageView = where(Status = const(Open), "Source Aplication" = const("Kenpipe Smart"), "Type of Application" = const(Readmission), "Sent Back to M-Smart" = CONST(false));
                //         }
                //         action("Sent To M-Smart List Read")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             RunObject = Page "Open Member Application List";
                //             RunPageView = where(Status = const(Open), "Source Aplication" = const("Kenpipe Smart"), "Type of Application" = const(Readmission), "Sent Back to M-Smart" = CONST(true));
                //         }
                //         action("Pending Application List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Pending Member Application List';
                //             RunObject = Page "Pending Member Application";
                //             RunPageView = where(Status = const(Pending), "Source Aplication" = const("Kenpipe Smart"), "Type of Application" = const(Readmission));

                //         }
                //         action("Approved Application List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Approved Member Application List';
                //             RunObject = Page "Approved Member Application";
                //             RunPageView = where(Status = const(Approved), "Source Aplication" = const("Kenpipe Smart"), "Type of Application" = const(Readmission));
                //         }
                //         action("Deffered Application List")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             RunObject = Page "Open Member Application List";
                //             RunPageView = where(Status = const(Deffered), "Source Aplication" = const("Kenpipe Smart"), "Type of Application" = const(Readmission));
                //         }
                //     }
                // }
                //....Groups 
                // group("Group Applications")
                // {
                //     Caption = 'Members'' Account Applocation';
                //     action("Group Application List")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Members'' Savings App List';
                //         RunObject = Page "Member Application Group List";
                //     }
                //     action("Approved Group App List")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Members'' Savings App List';
                //         RunObject = Page "Approved Group App List";
                //     }
                //     action("Rejected Group Applications")
                //     {
                //         ApplicationArea = All;
                //         Caption = ' Rejected Members'' Savings Applications';
                //         RunObject = Page "Rejected Group App List";
                //     }
                // }


            }

            group("Completed Applications")
            {
                Caption = 'Completed Applications';

                group("Member Listing")
                {
                    action("Member Register")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Member Single List";
                        //RunPageView = where(Status = filter(<> " "));
                    }
                    action("Member Group List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Members'' Savings Account';
                        RunObject = Page "Member Group List";
                    }
                    action("Archived Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Archived Register';
                        RunObject = Page "Member Single List";
                        RunPageView = where(Status = filter(Deceased | Closed));
                    }
                    action("Active Membership")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Member Single List";
                        Caption = 'Active Membership';
                        RunPageView = where(Status = filter(Active | Dormant), Subflag = filter("First Time" | Rejoined | "Partial withdrawn" | "Pending Withdrawal" | Withdrawal | Defaulter));
                    }
                    action("Awaiting Contributions")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Member Single List";
                        Caption = 'Awaiting Contributions';
                        RunPageView = where(Status = filter(New | Dormant), Subflag = filter("First Time" | Rejoined));
                    }
                }
                action("Savings Accounts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Savings Accounts';
                    RunObject = page "Savings Accounts";
                    ;
                }
                // action("New Members")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'New Members';
                //     RunObject = Page "Member Single List";
                //     RunPageView = where(status = const(New));
                // }

                // group(ChannelRequest)
                // {
                //     Caption = 'Channel Requests.';

                //     action("Mobile Banking Applicant List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Mobile Banking Applicant List';
                //         RunObject = page "Member List";
                //         RunPageView = where("Request Mobile Banking" = const(true));
                //     }
                //     action("ATM Applicant List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'ATM Applicant List';
                //         RunObject = page "Member List";
                //         RunPageView = where("Request for ATM" = const(true));
                //     }

                // }
                group(Archives)
                {
                    action("Rejected Member Application")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Rejected Member Application List';
                        RunObject = Page "Rejected Member Application";
                        RunPageView = where(Status = const(Rejected));
                    }
                    action("Created Members")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Open Member Application List";
                        RunPageView = where(Created = const(true));
                    }
                    action("File Management List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Archived File Tracker List';
                        RunObject = page "File Tracker List";
                        RunPageView = where(Status = filter(archived));
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

            }

            group("Savings Account")
            {
                action("Saving Account Application")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Saving Account Application';
                    RunObject = page "Savings Account Application";
                }
                action("Savings Accounts Register List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Savings Accounts Register List';
                    RunObject = page "Savings Accounts";
                }


                // action("Account Activation List")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Account Activation List';
                //     RunObject = page "Account Activation List";
                // }
                action("Account Changes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'FOSA Account Change Logs';
                    RunObject = report "FOSA Account Change Logs";
                }
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
                    }
                }
            }
            group("Delegates Management")
            {
                Caption = 'Delegates Management';
                group(Registry)
                {
                    group("Electoral Zones")
                    {
                        Caption = 'Electoral Zones Registration';
                        action("Application List")
                        {
                            Caption = 'Electoral Zones Application List';
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Electoral Application List";

                        }
                        action("Approved List")
                        {
                            Caption = 'Approved Electoral Zones List';
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Approved Electoral List";
                        }
                        action("Rejected List")
                        {
                            Caption = 'Rejected Electoral Zones List';
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Electoral Rejected List";

                        }

                    }
                    group("Delegates Officials")
                    {
                        Caption = 'Officials Registrations';
                        action("Officials Application List")
                        {
                            Caption = 'Officials Application List';
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Delegate Official Applications";

                        }
                        action("Officials Approved List")
                        {
                            Caption = 'Active Delegate Officials';
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Active Delegate Officials";
                        }
                        action("Retired Delegates Officials")
                        {
                            Caption = 'Rejected Electoral Zones List';
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Retired Delegate Officials";

                        }
                    }
                }
                group("Meetings and Payments")
                {

                    Caption = 'Meetings & Payments';
                    group(Meetings)
                    {
                        Caption = 'Delegate Meetings';
                        action("Open Delegates Meetings")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Delegate Meeting Header";
                        }
                        action("Approved Delegates Meetings")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Approved Delegate Meetings";
                        }
                        action("Paid Delegates Meetings")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Posted Delegate Meetings";
                        }

                    }
                    group("Delegate Payments")
                    {
                        Caption = 'Delegate Payments';
                        action("Delegates Payments List")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Delegates Payment List";
                        }
                        action("Approved Payments List")
                        {
                            Caption = 'Approved Delegates Payments List';
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Approved Delegates Payments";
                        }
                        action("Posted Payments List")
                        {
                            Caption = 'Posted Delegate Payments';
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Posted Delegates Payments";
                        }
                        action("Deleg. Payment Withholding Tax")
                        {
                            Caption = 'Delegate Payment Withholding Tax';
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Deleg. Payment Withholding Tax";
                        }
                    }
                }
                action("Delegate Tariffs")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Delegate Tariffs";
                }
            }
            // group("FixedDepositContract")
            // {
            //     Visible = false;
            //     Caption = 'Fixed/Call Deposit Contracts';
            //     action("Fixed Deposit")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Fixed/Call Deposit Contracts';
            //         RunObject = page "Fixed Deposit Contract List";
            //         RunPageLink = "Fixed Deposit Status" = CONST(" ");
            //     }
            //     action("ActiveFixed Deposit")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Running Fixed/Call Deposit Contracts';
            //         RunObject = page "Fixed Deposit Contract List";
            //         RunPageLink = "Fixed Deposit Status" = CONST(Active);
            //     }
            //     action("CTFixed Deposit")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Closed/Terminated Fixed/Call Deposit Contracts';
            //         RunObject = page "Fixed Deposit Contract List";
            //         RunPageLink = "Fixed Deposit Status" = filter(Matured | Closed | "Not Matured" | Terminated);
            //     }
            // }
            group("Marketing")
            {
                Caption = 'Marketing';
                // action("Campaign List")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Campaign List';
                //     RunObject = page "Campaign List";
                // }
            }
            // group("ATM Management")
            // {
            //     Caption = 'ATM Management';

            //     action("ATM Applications List")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'ATM Applications List';
            //         RunObject = page "ATM Application List";
            //     }
            //     action("Approved ATM Applications List")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Approved ATM Applications List';
            //         RunObject = page "Approved ATM Application List";
            //     }

            //     action("Dispatch ATM List")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Dispatch ATM List';
            //         RunObject = page "Dispatch ATM Lists";
            //     }
            //     action("ATM Return List")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'ATM Return List';
            //         RunObject = page "ATM Returned List";
            //     }
            // }

            group("Member Files")
            {
                // group("File Requests.")
                // {
                //     action("Request File")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Request File';
                //         RunObject = page "File Request List";
                //         RunPageView = where(Status = filter(open), Overdue = const(false));
                //     }
                //     action("File Request")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Files Requested';
                //         RunObject = page "File Request List";
                //         RunPageView = where(Status = filter(requested), Overdue = const(false));
                //     }
                //     action("Overdue Files")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Overdue Files.';
                //         RunObject = page "File Request List";
                //         RunPageView = where(Overdue = const(true));
                //     }
                //     action("Closed File Request")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Closed Files Requests.';
                //         RunObject = page "File Request List";
                //         RunPageView = where(Status = filter(closed));
                //     }
                // }
                group("Files")
                {
                    action("File Details List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'File Details List';
                        RunObject = page "Files List";
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
                    action("Overdue File Requests")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Overdue File Requests';
                        RunObject = page "File Tracker List";
                        RunPageView = where(Overdue = const(true));
                    }
                    // action("File List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'File Tracker List';
                    //     RunObject = page "File Tracker List";
                    //     RunPageView = where(Status = filter(<> archived));
                    // }
                }
                group("File Batching & Archiving")
                {
                    action("Batching & Archiving Process")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Open File Batch';
                        RunObject = page "Batching Process List";
                        RunPageView = where(Status = const(Open));
                    }
                    action("Batches Pending Approval")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'File Batch Pending Approval';
                        RunObject = page "Batching Process List";
                        RunPageView = where(Status = const(Pending));
                    }
                    action("Rejected Batches")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Rejected File Batch';
                        RunObject = page "Batching Process List";
                        RunPageView = where(Status = const(Rejected));
                    }
                    action("Approved Batches")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved File Batch';
                        RunObject = page "Batching Process List";
                        RunPageView = where(Status = const(Approved));
                    }
                    action("Archived File Volumes")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Archived File Volumes';
                        //RunObject = page "Batching Lines";
                        RunObject = page "Batching Lines List";
                    }
                }
                group("File Configurations.")
                {
                    action("User Station List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'User Stations';
                        RunObject = page "User Station List";
                    }
                    action("File Movement Remarks")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'File Movement Remarks';
                        RunObject = page "File MVT Remarks";
                    }
                    action("File Stations")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'File Stations';
                        RunObject = page "File Stations";
                    }
                }
            }

            // group("Delegates Officials")
            // {
            //     Caption = 'Officials Registrations';

            //     action("Officials Application List")
            //     {
            //         Caption = 'Officials Application List';
            //         ApplicationArea = Basic, Suite;
            //         RunObject = Page "Delegate Official Applications";

            //     }
            //     action("Active Delegate Officials")
            //     {
            //         Caption = 'Active Delegate Officials';
            //         ApplicationArea = Basic, Suite;
            //         RunObject = Page "Active Delegate Officials";
            //     }

            //     action("Retired Delegates Officials")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         RunObject = Page "Retired Delegate Officials";
            //         RunPageView = where(Retired = const(true));
            //     }
            //     action("Rejected Delegates Officials")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         RunObject = Page "Retired Delegate Officials";
            //         RunPageView = where(Status = const(Rejected));
            //     }
            // }
            group("Member Edits")
            {
                Caption = 'Member Edits';

                // group("CRM Applications")
                // {
                //     Caption = 'CRM Applications';
                //     action("All CRM Member Edits Applications")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         caption = 'All CRM Member Edit Applications';
                //         RunObject = page "Open CRM Member Edits";
                //     }
                //     action("Open CRM Member Edits Applications")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         caption = 'Open CRM Member Edit Applications';
                //         RunObject = page "Open CRM Member Edits";
                //         RunPageView = where(Status = Const(Open));
                //     }
                // action("Pending CRM Member Edits Applications")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'Pending CRM Member Edit Applications';
                //     RunObject = page "Open CRM Member Edits";
                //     RunPageView = where(Status = Const(Pending));
                // }
                // action("Sent Back to CRM Member Edits Applications")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'Sent Back to CRM Member Edit Applications';
                //     RunObject = page "Open CRM Member Edits";
                //     RunPageView = where("Sent Back to CRM" = const(true));
                // }
                // action("Approved CRM Member Edits Applications")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'Approved CRM Member Edit Applications';
                //     RunObject = page "Open CRM Member Edits";
                //     RunPageView = where(Status = Const(Approved));
                // }
                // action("Deffered CRM Member Edits Applications")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'Deffered CRM Member Edit Applications';
                //     RunObject = page "Open CRM Member Edits";
                //     RunPageView = where(Status = Const(Deffered));
                // }
                // action("Rejected CRM Member Edits Applications")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'Rejected CRM Member Edit Applications';
                //     RunObject = page "Open CRM Member Edits";
                //     RunPageView = where(Status = Const(Rejected));
                // }
                // action("Archived CRM Member Edits Applications")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'Archived CRM Member Edit Applications';
                //     RunObject = page "Open CRM Member Edits";
                //     RunPageView = where(Status = Const(Archived));
                // }
                //}
                // group("M-Smart Applications")
                // {
                //     Caption = 'M-Smart Applications';
                //     action("All M-Smart Member Edits Applications")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         caption = 'All M-Smart Member Edit Applications';
                //         RunObject = page "Open M-Smart Member Edits";
                //     }
                //     action("Open M-Smart Member Edits Applications")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         caption = 'Open M-Smart Member Edit Applications';
                //         RunObject = page "Open M-Smart Member Edits";
                //         RunPageView = where(Status = Const(Open));
                //     }
                // action("Pending M-Smart Member Edits Applications")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'Pending M-Smart Member Edit Applications';
                //     RunObject = page "Open M-Smart Member Edits";
                //     RunPageView = where(Status = Const(Pending), "Sent Back to M-Smart" = const(false));
                // }
                // action("Sent Back to M-Smart Member Edits Applications")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'Sent Back to M-Smart Member Edit Applications';
                //     RunObject = page "Open M-Smart Member Edits";
                //     RunPageView = where("Sent Back to M-Smart" = const(true));
                // }
                // action("Approved M-Smart Member Edits Applications")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'Approved M-Smart Member Edit Applications';
                //     RunObject = page "Open M-Smart Member Edits";
                //     RunPageView = where(Status = Const(Approved));
                // }
                // action("Deffered M-Smart Member Edits Applications")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'Deffered M-Smart Member Edit Applications';
                //     RunObject = page "Open M-Smart Member Edits";
                //     RunPageView = where(Status = Const(Deffered));
                // }
                // action("Rejected M-Smart Member Edits Applications")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'Rejected M-Smart Member Edit Applications';
                //     RunObject = page "Open M-Smart Member Edits";
                //     RunPageView = where(Status = Const(Rejected));
                // }
                // action("Archived M-Smart Member Edits Applications")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'Archived M-Smart Member Edit Applications';
                //     RunObject = page "Open M-Smart Member Edits";
                //     RunPageView = where(Status = Const(Archived));
                // }
                //}

                // group("M-Smart Documents")
                // {
                //     Caption = 'M-Smart Documents';
                //     action("All M-Smart Documents")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         caption = 'All M-Smart Documents';
                //         RunObject = page "M-Smart Documents List";
                //         RunPageView = where("Landing Department" = Const(RECORDS));
                //     }
                //     action("Open M-Smart Documents")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         caption = 'Open M-Smart Documents';
                //         RunObject = page "M-Smart Documents List";
                //         RunPageView = where(Status = Const(Open), "Landing Department" = Const(RECORDS));
                //     }
                // action("Pending M-Smart Documents")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'Pending M-Smart Documents';
                //     RunObject = page "M-Smart Documents List";
                //     RunPageView = where(Status = Const(Pending), "Landing Department" = Const(RECORDS));
                // }
                // action("Approved M-Smart Documents")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'Approved M-Smart Documents';
                //     RunObject = page "M-Smart Documents List";
                //     RunPageView = where(Status = Const(Approved), "Landing Department" = Const(RECORDS));
                // }
                // action("Deffered M-Smart Documents")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'Deffered M-Smart Documents';
                //     RunObject = page "M-Smart Documents List";
                //     RunPageView = where(Status = Const(Deffered), "Landing Department" = Const(RECORDS));
                // }
                // action("Rejected M-Smart Documents")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'Rejected M-Smart Documents';
                //     RunObject = page "M-Smart Documents List";
                //     RunPageView = where(Status = Const(Rejected), "Landing Department" = Const(RECORDS));
                // }
                // action("Archived M-Smart Documents")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'Archived M-Smart Documents';
                //     RunObject = page "M-Smart Documents List";
                //     RunPageView = where(Status = Const(Archived), "Landing Department" = Const(RECORDS));
                // }
                // action("Cancelled M-Smart Documents")
                // {
                //     ApplicationArea = Basic, Suite;
                //     caption = 'Cancelled M-Smart Documents';
                //     RunObject = page "M-Smart Documents List";
                //     RunPageView = where(Status = Const(Cancelled), "Landing Department" = Const(RECORDS));
                // }
                //}
                group("Member Edit")
                {
                    Caption = 'Member Edit';
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
                        action("Rejected Edits List")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "System Edits List";
                            RunPageView = where(Status = const(Rejected));
                        }
                        action("Deferred Edits List")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "System Edits List";
                            RunPageView = where(Status = const(Deffered));
                        }

                        action("Archived Edits List")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "System Edits List";
                            RunPageView = where(Status = const(archived));
                        }

                        action("Cancelled Edits List")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "System Edits List";
                            RunPageView = where(Status = const(Cancelled));
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
                    // action("Bulk Member Upload")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     caption = 'Bulk Member Upload';
                    //     RunObject = xmlport "Member Upload Records";
                    // }
                    // action("Savings Accounts Upload")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'savings Upload';
                    //     RunObject = xmlport "Upload Savings Records";
                    // }
                    // group("MKey Case Forwarding;")
                    // {

                    //     action("Mkey Received Cases")
                    //     {
                    //         ApplicationArea = Basic, Suite;
                    //         RunObject = page "MKey Received Cases";
                    //         RunPageView = where("Case Closed" = const(false));
                    //     }
                    //     action("Mkey Actioned Cases")
                    //     {
                    //         ApplicationArea = Basic, Suite;
                    //         RunObject = page "MKey Received Cases";
                    //         RunPageView = where("Case Closed" = const(true));

                    //     }
                    // }
                }

                group("Member List On Edits")
                {
                    action("Ongoing Member Edits")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Ongoing Member Edits';
                        RunObject = page "Member Single List";
                        RunPageView = where("Marked For Edits" = const(true));
                    }
                }

                group("Dependancies Application")
                {
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
                        action("Archived Dependancies Applications")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Pending Dependancies Apps";
                            RunPageView = where(Status = const(Archived));
                        }
                    }
                    group("Completed Dependancy Applications")
                    {
                        action("Created Dependancies Applications")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Created Dependancies Apps";//Approved Created
                        }
                        action("Rejected Dependancies Applications")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Pending Dependancies Apps";//<>open <>created
                            RunPageView = where(Status = const(Rejected));

                        }
                    }



                }
                group("Member Withdrawal Notice")
                {
                    Visible = false;
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
                    Visible = false;
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

                // group("Exit and Transfer")
                // {
                //     Caption = 'Group Exit & Transfer';
                //     action("Exit and Transfer List")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Exit and Transfer List';
                //         RunObject = Page "Business Clossure List";
                //         RunPageView = where(Posted = const(false));

                //     }
                //     action("Posted Exit and Transfer List")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Posted Exit and Transfer List';
                //         RunObject = Page "Business Clossure List";
                //         RunPageView = where(Posted = const(true));

                //     }

                //     action("Group Mem Exit & Update List")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Group Mem Exit & Update List';
                //         RunObject = Page "Group Mem Exit & Update List";
                //     }
                // }
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
                // action("Store Requisition")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Store Requisition';
                //     RunObject = Page "Store Requisitions List";
                // }
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
                action("Loan Application")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Apply Staff Loan';
                    RunObject = page "Self Loan Application List";
                }
                group("Employee Requests")
                {
                    Visible = false;

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
                    // group("Conf & Meeting Room Booking")
                    // {
                    //     Caption = 'Conf & Meeting Room Aplications';
                    //     action("Conference Hall & Meeting Rooms")
                    //     {
                    //         ApplicationArea = All;
                    //         Caption = 'Open Bookings';
                    //         RunObject = page "MNS Conf & Meetings Appl List";
                    //         RunPageLink = Status = CONST(Open);
                    //     }
                    //     action("Pending Conf & Meeting Room Booking")
                    //     {
                    //         ApplicationArea = All;
                    //         Caption = 'Pending Bookings';
                    //         //RunObject = page "Pending Conf & Meeting - List";
                    //         RunObject = page "MNS Conf & Meetings Appl List";
                    //         RunPageLink = Status = CONST(Pending);
                    //     }
                    //     action("Approved Conf & Meeting Room Booking")
                    //     {
                    //         ApplicationArea = All;
                    //         Caption = 'Approved Booking';
                    //         //RunObject = page "Approved Conf & Meeting - List";
                    //         RunObject = page "MNS Conf & Meetings Appl List";
                    //         RunPageLink = Status = CONST(Approved);
                    //     }
                    //     action("Invoicing for Hire of Halls")
                    //     {
                    //         ApplicationArea = All;
                    //         Caption = 'Invoicing for Hire of Halls';
                    //         //RunObject = page "Approved Conf & Meeting - List";
                    //         RunObject = page "MNS Conf & Meetings Appl List";
                    //         //RunPageLink = Status = CONST(Approved);
                    //         RunPageView = WHERE(Status = CONST(Approved), "Type of Meeting/Function" = Const(External));
                    //     }
                    //     action("Rejected Conf & Meeting Room Booking")
                    //     {
                    //         ApplicationArea = All;
                    //         Caption = 'Declined Bookings';
                    //         //RunObject = page "Rejected Conf & Meeting - List";
                    //         RunObject = page "MNS Conf & Meetings Appl List";
                    //         RunPageLink = Status = CONST(Rejected);
                    //     }
                    //     action("Closed Conf & Meeting Room Booking")
                    //     {
                    //         ApplicationArea = All;
                    //         Caption = 'Closed Bookings';
                    //         //RunObject = page "Closed Conf & Meeting - List";
                    //         RunObject = page "MNS Conf & Meetings Appl List";
                    //         RunPageLink = "Status of the Booking" = CONST(Closed);
                    //     }
                    // }
                    // Group("Motor Vehicle Requests")
                    // {
                    //     Caption = 'Motor Vehicle Requests';
                    //     action("Vehicle Request Application")
                    //     {
                    //         ApplicationArea = all;
                    //         Caption = 'Open Vehicle Requests';
                    //         RunObject = page "Motor Vehicle Request List";
                    //         RunPageLink = Status = CONST(Open);
                    //     }
                    //     action("Pending Vehicle Requests")
                    //     {
                    //         ApplicationArea = all;
                    //         Caption = 'Pending Vehicle Requests';
                    //         RunObject = page "Motor Vehicle Request List";
                    //         RunPageLink = Status = CONST(Pending);
                    //     }
                    //     action("Approved Vehicle Requests")
                    //     {
                    //         ApplicationArea = all;
                    //         Caption = 'Approved Vehicle Requests';
                    //         //RunObject = page "Approved Vehicle Req - List";
                    //         RunObject = page "Motor Vehicle Request List";
                    //         RunpageLink = Status = CONST(Approved);
                    //     }
                    //     action("Deffered Vehicle Requests")
                    //     {
                    //         ApplicationArea = all;
                    //         Caption = 'Deffered Vehicle Requests';
                    //         RunObject = page "Deffered Vehicle Req - List";
                    //     }
                    //     action("Reject Vehicle Requests")
                    //     {
                    //         ApplicationArea = all;
                    //         Caption = 'Rejected Vehicle Requests';
                    //         //RunObject = page "Rejected Vehicle Req - List";
                    //         RunObject = page "Motor Vehicle Request List";
                    //         RunPageLink = Status = CONST(Rejected);
                    //     }
                    //     action("Closed Vehicle Request")
                    //     {
                    //         ApplicationArea = all;
                    //         Caption = 'Closed Vehicle Request';
                    //         //RunObject = page "Closed Vehicle Req - List";
                    //         RunObject = page "Motor Vehicle Request List";
                    //         RunPageLink = Status = CONST(Closed);
                    //     }
                    //     action("Reallocated Requests")
                    //     {
                    //         ApplicationArea = all;
                    //         Caption = 'Reallocated Requests';
                    //         RunObject = page "Motor Vehicle Request List";
                    //         RunPageLink = Reallocated = CONST(TRUE);
                    //     }
                    // }
                    // group("Key Requests")
                    // {
                    //     action("Open Keys Request")
                    //     {
                    //         ApplicationArea = All;
                    //         Caption = 'Office Keys Request';
                    //         RunObject = page "Key Request List";
                    //         RunPageLink = Status = CONST(Open);
                    //     }
                    //     action("Pending Keys Request")
                    //     {
                    //         ApplicationArea = All;
                    //         Caption = 'Pending Requests';
                    //         RunObject = page "Key Request List";
                    //         RunPageLink = Status = CONST(Pending);
                    //     }
                    //     action("Approved Keys Request")
                    //     {
                    //         ApplicationArea = All;
                    //         Caption = 'Approved Requests';
                    //         RunObject = page "Key Request List";
                    //         RunPageLink = Status = CONST(Approved);
                    //     }
                    //     action("Rejected Keys Request")
                    //     {
                    //         ApplicationArea = All;
                    //         Caption = 'Rejected Key Request';
                    //         RunObject = page "Key Request List";
                    //         RunPageLink = Status = CONST(Rejected);
                    //     }
                    //     action("Closed Keys Request")
                    //     {
                    //         ApplicationArea = All;
                    //         Caption = 'Closed Key Requests';
                    //         RunObject = page "Key Request List";
                    //         RunPageLink = "Key Status" = CONST(Received);
                    //     }
                    // }
                    // Group("Parking Allocation")
                    // {
                    //     action("Parking Space List")
                    //     {
                    //         ApplicationArea = All;
                    //         Caption = 'Open Parking Application';
                    //         RunObject = page "Parking Space List";
                    //         RunPageLink = Status = CONST(Open);
                    //     }
                    //     action("Pending Parking Space Application")
                    //     {
                    //         ApplicationArea = All;
                    //         Caption = 'Pending Parking Allocation';
                    //         //RunObject = page "Approved Parking - List";
                    //         RunObject = page "Parking Space List";
                    //         RunPageLink = Status = CONST(Pending);
                    //     }
                    //     action("Approved Parking Space Application")
                    //     {
                    //         ApplicationArea = All;
                    //         Caption = 'Approved Parking Allocation';
                    //         //RunObject = page "Approved Parking - List";
                    //         RunObject = page "Parking Space List";
                    //         RunPageLink = Status = CONST(Approved);
                    //     }
                    //     action("Rejected Parking Space Application")
                    //     {
                    //         ApplicationArea = All;
                    //         Caption = 'Rejected Parking Allocation';
                    //         //RunObject = page "Rejected Parking Space - List";
                    //         RunObject = page "Parking Space List";
                    //         RunPageLink = Status = CONST(Rejected);
                    //     }
                    // }
                }
            }
            // group("Contract Request")
            // {
            //     Caption = 'Contract Request';
            //     action("Contract Requests")
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'Open Contract Request';
            //         RunObject = Page "Contract Request List";
            //         RunPageLink = Status = CONST(Open);
            //     }
            //     action("Contract Requests Pending Approval")
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'Contract Request - Pending Approval';
            //         RunObject = Page "Contract Request List";
            //         RunPageLink = Status = CONST(Pending);
            //     }
            //     action("Rejected Contract Requests")
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'Rejected Contract Request';
            //         RunObject = Page "Contract Request List";
            //         RunPageLink = Status = CONST(Rejected);
            //     }
            //     action("Approved Contract Requests")
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'Approved Contract Requests';
            //         RunObject = Page "Contract Request List";
            //         RunPageLink = Status = CONST(Approved);
            //     }

            // }
            group(Setups)
            {
                Caption = 'Setup';
                group("General")
                {
                    caption = 'General';

                    // action("Present Officers")
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Present Officers Setups';
                    //     RunObject = page "Present Users";

                    // }
                    action("System Edits Tables List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "System Edits Tables";
                    }

                    // action("General Set-Up")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'General Set-Up';
                    //     // RunObject = page "Gen set-up card";
                    // }
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

                    action("Electoral Zones/Area Svr Center")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Electoral Zones/Area Svr Center';
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

                    // action("Present Users")
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Present Users Setups';
                    //     RunObject = page "Present Users";

                    // }
                    action("System Edits Reasons")
                    {
                        ApplicationArea = All;
                        RunObject = page "System Edits Reasons";

                    }
                    action("Religions")
                    {
                        ApplicationArea = All;
                        RunObject = page "HR Lookup Values List";
                        RunPageView = where(Type = const(Religion));

                    }
                    action("ResponsibilityCentres")
                    {
                        Caption = 'Responsibility Centres';
                        ApplicationArea = All;
                        RunObject = page "Responsibility Center List";

                    }
                    action("Digital Signatures")
                    {
                        ApplicationArea = All;
                        RunObject = page "Digital Signature";

                    }




                }


                Group("Audit Process")
                {
                    Caption = 'Audit Process';
                    action("Account Access Log")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Account Access Log';
                        RunObject = page "Account Access Log";
                    }
                    action("Change Log")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Change Log/Audit Trail';
                        RunObject = page "Change Log Entries";
                        RunPageView = where("Table Caption" = filter('members|Savings Accounts'));
                    }
                    action("Approval Entry Logs")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approval Entry Logs';
                        RunObject = page "Loans Approval Entries";
                    }
                    action("Error Message Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Error Message Register';
                        RunObject = page "Error Message Register";
                    }
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                group("Member Application")
                {
                    action("Member Register R")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member Appl. Register';
                        RunObject = Report "Member Application Register";
                    }
                    action("Daily Member Listing Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Daily Member Listing Report';
                        RunObject = Report "Daily Membership Report";
                    }
                    action("Member Appl. Pending Approval")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member Appl. Pending Approval';
                        RunObject = Report "Member Appl. Pending Approval";
                    }
                    action("Incomplete Application Report")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Report "Incomplete Application Report";
                    }
                    action(AutocreateProducts)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Auto Create Products';
                        RunObject = report "AutocreateProducts";
                        ToolTip = 'This report will create products for members based on the product factory setup.';
                    }
                }

                group("Members")
                {
                    action("Member Listing Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member Listing - List';
                        RunObject = report "Member Register";

                    }
                    action("Next Of Kin List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Next Of Kin List';
                        RunObject = page "Next Of Kin List";
                    }
                    action("Members Missing Next Of Kin")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Members Missing Next Of Kin';
                        RunObject = page "Member Single List";
                        RunPageView = where("Has NOK" = const(false), Status = filter(<> Deceased & <> Closed));
                    }
                    action("Uploaded Non Created Members")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Uploaded Non Created Members';
                        RunObject = Report "Uploaded Non Created Members";
                    }
                    action("Members Missing Photos")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Members Missing Photos';
                        RunObject = Report "Members Missing Photos";
                    }
                    action("Members With Pictures")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Members With Pictures';
                        RunObject = Report "Members With Pictures";
                    }
                    action("Member Cards Awaiting Printing")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member Cards Awaiting Printing';
                        RunObject = Report "Member Cards Awaiting Printing";
                    }

                    action("Onboarding Report Per Class")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Onboarding Report Per Class';
                        RunObject = Report "Onboarding Report Per Class";
                    }
                    action("Member Appl. Channels")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member Appl. Channels';
                        RunObject = Report "Member Appl Channels";
                    }
                    action("Member Application Channels")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member Application Channels';
                        RunObject = Report "Member Application Channels";
                    }
                    action("Member Status Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member Status Report';
                        RunObject = Report "Member Status";
                    }
                    action("Members Age")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Members Age';
                        RunObject = Report "Members Age";
                    }
                    action("Member Rejoining")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Member Rejoining Report';
                        RunObject = report "Member Rejoining";
                    }
                    action("Edits Applications")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Edits Applications';
                        RunObject = report "Edits Applications";
                    }
                    action("Delegates/Board Members")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Delegates/Board Members';
                        RunObject = report "Delegate/Board Member Position";
                    }
                    action("KYC Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'KYC Report';
                        RunObject = report "KYC Report";
                    }
                    action("Members - Incomplete Data")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Members - Incomplete Data';
                        RunObject = report "Members With Incomplete Data";
                    }
                    // action("Employer DataSheet")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Employer DataSheet';
                    //     RunObject = report "Employer Data Sheet";
                    // }
                    action("Recovered Registration Fees")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Recovered Registration Fees';
                        RunObject = Report "Recovered Registration Fees";
                    }

                    // action("BBF/Risk/entrance fees/Depo")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'BBF/RISK/ENTRANCE/DEPOSIT Summary';
                    //     RunObject = report "BBF/Risk/entrance fees/Depo";
                    // }
                    // action("Unrecov. Reg Fee/BBF/Risk/Shar")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Unrecoveres Reg Fee/BBF/Risk/Share';
                    //     RunObject = report "Unrecov. Reg Fee/BBF/Risk/Shar";
                    // }
                }
                group(Edits)
                {
                    action("Member Edits Report")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Edit Audit Trail";
                    }
                }
                group("Member Closure Reports")
                {
                    //original
                    action("Withdrawal Notices")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Withdrawal Notices';
                        RunObject = report "Withdrawal Notices";
                    }
                    // action("Member  Withdawal Notice")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Member Withdrawal Notice';
                    //     RunObject = report "Member Withdrawal Notice";
                    // }
                    action("Membership Closure")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Membership Closure';
                        RunObject = report "Membership Closure Report";
                    }

                }

                group("Nominee")
                {
                    // action("Nominee Report")
                    // {
                    //     ApplicationArea = Basic;
                    //     Caption = 'Nominee / BBF Register';
                    //     RunObject = Report "Nominee Register";
                    // }
                    action("Nominee Reports")
                    {
                        ApplicationArea = Basic;
                        RunObject = page "BBF/Nominee Register";
                    }
                }
                group("File Movement")
                {
                    action("Archived Files")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Archived Files';
                        RunObject = Report "Archived Files";
                    }
                    action("Filing Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'File Movement Report';
                        RunObject = Report "File Movement Report";
                    }
                    action("Overdue Files Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Overdue Files';
                        RunObject = Report "Overdue Files";
                    }
                    action("Files Due For Archiving")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Files Due For Archiving';
                        RunObject = Report "Files Due For Archiving";
                    }
                }
                action("Activate BOSA Accounts")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Report "Activate BOSA Accounts";
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
            action("Bulk SMS")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bulk SMS List';
                RunObject = page "Bulk SMS Header List";
            }
            action("Customer Management Portal")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customer Management Portal';
                RunObject = codeunit "Customer Management Portal Url";
            }
            action("Depedancy Application - Portal")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Open Dependency Applications - Portal';
                RunObject = page "Dependancies Applications List";
                RunPageView = where("Source Application" = filter("Member Portal"));
            }
        }
    }
}

profile "Records"
{
    Caption = 'Records Role Center';
    RoleCenter = "Records";
    ProfileDescription = 'Records Department';
}
