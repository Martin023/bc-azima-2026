page 52187311 "Membership Role Center"
{
    Caption = 'Membership Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Control76; customheadline)
            {
                ApplicationArea = Basic, Suite;
            }

            part("Membership Activity"; "Membership Activity cue")
            {
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

                // group("Member Group Application")
                // {

                //     Caption = 'Member Group Application';
                //     action("Member Group Application List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Member Group Application List';
                //         RunObject = Page "Member Application Group List";
                //     }
                // }
                // group("Micro Member Application")
                // {
                //     Caption = 'Micro Member Application';
                //     action("Micro Member Application List")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Micro Member Application List';
                //         RunObject = Page "Micro Member Application List";
                //     }
                // }

                group("System Edits")
                {
                    action("Edits List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'System Edits List';
                        RunObject = page "System Edits List";
                    }
                }
                group("Reports")
                {
                    Caption = 'Reports';
                    group("Reports and Analysis")
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
            group("Set Ups")
            {
                Caption = 'Present Users';
                action("Present Users")
                {
                    ApplicationArea = All;
                    Caption = 'Present Users Setups';
                    RunObject = page "Present Users";

                }
                action("Broker Account list")
                {
                    ApplicationArea = All;
                    Caption = 'Broker Accounts list';
                    RunObject = page "Broker Account list";

                }
            }
            group("Members Listing")
            {
                Caption = 'Members Listing';
                action("Members Listings")
                {
                    ApplicationArea = All;
                    Caption = 'Members Listing';
                    RunObject = query "Members Listing";


                }
            }

            group("Members Testing")
            {
                Caption = 'Members Testing';
                action("Members Testings")
                {
                    ApplicationArea = All;
                    Caption = 'Members Listing';
                    RunObject = query "Members Listing";


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

profile "Membership Role Center"
{
    Caption = 'Membership Role Center';
    RoleCenter = "Membership Role Center";
    ProfileDescription = 'Administrator';
}
