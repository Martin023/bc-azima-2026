page 52187314 "Legal Role Center"
{
    Caption = 'Legal Management';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(CustomHeadline; CustomHeadline)
            {
                ApplicationArea = Basic;
            }
            part("Other Operations Activities"; "Legal Cue Page")
            {
                Caption = 'Legal Cue Page';
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
            group("Legal Management")
            {
                Caption = 'Litigation';
                group("Case Management")
                {
                    Caption = 'Case Lists';
                    action("Case List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Open Cases List';
                        RunObject = Page "Legal List";
                        RunPageLink = Status = CONST(Open);
                    }
                    action("Pending Case List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pending Approvals';
                        RunObject = Page "Legal List";
                        RunPageLink = Status = CONST(Pending);
                    }
                    action("Approved Cases")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Cases';
                        //RunObject = Page "Legal List Aproved";
                        RunObject = Page "Legal List";
                        RunPageLink = Status = CONST(Approved);
                    }
                    action("Ongoing Matters")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Ongoing Cases';
                        //RunObject = Page "Legal List Aproved";
                        RunObject = Page "Legal List";
                        RunPageLink = "Case Status" = CONST(Ongoing);
                    }
                    // action("Rejected Cases")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Rejected Cases';
                    //     RunObject = Page "Legal List";
                    //     RunPageLink = Status = CONST(Rejected);
                    // }
                    action("Closed Cases")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Closed Cases';
                        //RunObject = Page "Closed Cases List";
                        RunObject = Page "Legal List";
                        RunPageLink = "Case Status" = CONST(Closed);
                    }
                    action("ADR")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'ADR';
                        RunObject = Page "Legal List";
                        RunPageLink = "Case Status" = CONST(ADR);
                        //RunObject = page "ADR List";
                    }
                }
                group("Appealed Cases")
                {
                    action("Appealed Case")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Open Appeals';
                        RunObject = Page "Appealed Legal List";
                        RunPageLink = Status = CONST(New);
                    }
                    action("Pending Appeals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pending Approvals';
                        RunObject = Page "Appealed Legal List";
                        RunPageLink = Status = CONST("Pending Approval");
                    }
                    action("Approved Appeals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Appeals';
                        //RunObject = Page "Approved Appeals";
                        RunObject = Page "Appealed Legal List";
                        RunpageLink = Status = CONST(Approved);
                    }
                    action("Ongoing Appeals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Ongoing Appeals';
                        //RunObject = Page "Approved Appeals";
                        RunObject = Page "Appealed Legal List";
                        RunpageLink = "Case Status" = CONST(Ongoing);
                    }
                    // action("Rejected Appeals")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Rejected Appeals';
                    //     RunObject = Page "Appealed Legal List";
                    //     RunPageLink = Status = CONST(Rejected);
                    // }
                    action("Closed Appeals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Closed Appeals';
                        RunObject = Page "Appealed Legal List";
                        RunPageLink = "Case Status" = CONST(Closed);
                    }
                }
                group("Legal Dtp Lists")
                {
                    Caption = 'Legal Department Lists';
                    action("Upcoming Matters")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Upcoming Matters';
                        RunObject = Page "Upcoming Matters";
                    }
                    action("Witness Line")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Witness Line';
                        RunObject = Page "Witness Line";
                    }
                    action("Legal Lines")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Legal Lines';
                        RunObject = Page "Legal Line";
                    }
                    action("Advocate List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Advocate List';
                        RunObject = Page "Advocate List";
                    }

                    action("Verdict List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Verdict List';
                        RunObject = Page "Verdict List";
                    }
                    action("Damages List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Damages List';
                        RunObject = Page "Damages List";
                    }
                    // action("Upcoming Matters")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Upcoming Matters';
                    //     RunObject = Page "Upcoming Matters";
                    // }
                }
                group("HR Disciplinary Management")
                {
                    Caption = 'HR Disciplinary Management';
                    action(HRDisciplinaryCases)
                    {
                        Caption = 'HR Disciplinary Cases';
                        ApplicationArea = Basic, Suite;
                        RunObject = page "HR Disciplinary Cases List N1";
                    }
                }
                // group("Case Payments")
                // {
                //     Caption = 'Payments';
                //     group("Payment Lists")
                //     {
                //         action("Case Invoices")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Case Invoices';
                //             RunObject = Page "Case Invoice";
                //         }
                //         action("Case Payment")
                //         {
                //             ApplicationArea = Basic, Suite;
                //             Caption = 'Case Payment';
                //             RunObject = Page "Case Payment List";
                //         }
                //     }
                //}
            }
            group("Surety & Security")
            {
                Caption = 'Surety & Security';
                group("SuretyManagment")
                {
                    Caption = 'Surety';
                    action("Surety Management List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Open Surety';
                        RunObject = Page "Surety Management List";
                        RunPageLink = Status = CONST(OPEN);
                    }
                    action("Pending Surety")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Surety Pending Approval';
                        RunObject = Page "Surety Management List";
                        RunPageLink = Status = CONST(Pending);
                    }
                    action("Approved Surety Management")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Surety';
                        RunObject = Page "Surety Management List";
                        RunPageView = where(Status = const(Approved), Posted = Const(false));
                        //RunObject = page "Approved Surety Management";
                    }
                    action("Blocked Management")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Blocked Surety';
                        RunObject = Page "Surety Management List";
                        RunPageView = Where(Status = const(Approved), Posted = Const(True));
                        //RunPageLink = Status = CONST(Approved);
                        //RunObject = page "Approved Surety Management";
                    }
                    action("Rejected Surety")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Rejected Surety';
                        RunObject = Page "Surety Management List";
                        RunPageLink = Status = CONST(Rejected);
                    }
                    action("Posted Surety")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Surety';
                        RunObject = Page "One Month Installments";
                        RunPageLink = Type = CONST(Surety), "Funds Status" = CONST(WithHeld);
                    }
                    action("Released Surety")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Unblocked Surety';
                        RunObject = Page "One Month Installments";
                        RunPageLink = Type = CONST(Surety), "Funds Status" = CONST(Released);
                    }
                }
                group("Securities Update")
                {
                    // action("Open Collateral Update")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Open Security Updates';
                    //     RunObject = Page "System Edits List";
                    //     RunPageView = where("Table ID" = filter(52185840), Status = filter(Open));
                    // }
                    // action("Collateral Update Pending Approval")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Security Updates Pending Approval';
                    //     RunObject = Page "System Edits List";
                    //     RunPageView = where("Table ID" = filter(52185840), Status = filter(Pending));
                    // }
                    // action("Rejected Collateral Update")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Rejected Security Updates';
                    //     RunObject = Page "System Edits List";
                    //     RunPageView = where("Table ID" = filter(52185840), Status = filter(Rejected));
                    // }
                    // action("Approved Collateral Update")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Approved Security Updates';
                    //     RunObject = Page "System Edits List";
                    //     RunPageView = WHere("Table ID" = filter(52185840), Status = filter(Approved));
                    // }
                    // action("Posted Collateral Update")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Posted Security Updates';
                    //     RunObject = Page "System Edits List";
                    //     RunPageView = where("Table ID" = filter(52185840), Status = filter(Approved), Posted = CONST(TRUE));
                    // }
                    action("Posted System Edits List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Security Updates';
                        RunObject = Page "Posted System Edits List";
                        RunPageView = where("Table ID" = filter(52185840), Posted = CONST(TRUE));
                    }
                }
                group("Security Register")
                {
                    Caption = 'Security Register';
                    // action("Collateral Register - List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     caption = 'Open Security Register - List';
                    //     RunObject = page "Collateral Register - List";
                    //     RunPageView = where(Status = const(Open));
                    // }
                    // action("Pending Collateralls")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     caption = 'Pending Security';
                    //     RunObject = page "Collateral Register - List";
                    //     RunPageView = where(Status = const(Pending));
                    // }
                    // action("Rejected")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     caption = 'Security Register - List';
                    //     RunObject = page "Collateral Register - List";
                    //     RunPageView = where(Status = const(Rejected));
                    // }
                    action("Forwarded Securities List - HR")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Forwarded Securities List - HR';
                        RunObject = page "Collateral Register - List";
                        RunPageView = where(Status = const(Approved), "Lending Unit" = Filter("HR Loans"), "Collateral Perfected" = Const(False));
                    }
                    action("Forwarded Securities List - BOSA")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Forwarded Securities List - BOSA';
                        RunObject = page "Collateral Register - List";
                        RunPageView = where(Status = const(Approved), "Lending Unit" = filter("BOSA"), "Collateral Perfected" = Const(False));
                    }
                    action("Forwarded Securities List - Bussiness Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Forwarded Securities List - Bussiness Loans';
                        RunObject = page "Collateral Register - List";
                        RunPageView = where(Status = const(Approved), "Lending Unit" = filter("BUSINESS LOANS"), "Collateral Perfected" = Const(False));
                    }
                    action("Forwarded Securities List - FOSA")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Forwarded Securities List - FOSA';
                        RunObject = page "Collateral Register - List";
                        RunPageView = where(Status = const(Approved), "Lending Unit" = filter("FOSA"), "Collateral Perfected" = Const(False));
                    }
                }
                group("Security Substitution")
                {
                    Caption = 'Security Substitution';
                    action("Collateral Substitution")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Security Substitution';
                        RunObject = Page "Guarantor Subsitution List";
                        //RunPageLink = Status = filter(Approved), Posted = const(true);
                        RunPageLink = Status = filter(Posted), Posted = const(true), "Sent Back to CRM" = const(false), "CRM Application No." = filter('');
                    }
                }
                group("Security Perfection")
                {
                    Caption = 'Security Perfection';
                    action("Security Perfection Application")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Open Security Perfection';
                        RunObject = page "Security Perfection List";
                        RunPageLink = Status = CONST(OPEN);
                    }
                    action("Pending Security Perfection")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Perfection Pending Approvals';
                        RunObject = page "Security Perfection List";
                        RunPageLink = Status = CONST(Pending);
                    }
                    action("Approved Security Perfection")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Perfection';
                        RunObject = page "Security Perfection List";
                        RunPageLink = Status = CONST(Approved);
                        RunPageView = where(Status = const(Approved), Perfected = CONST(FALSE), Discharged = const(false));
                    }
                    action("Rejected Security Perfection")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Rejected Perfection';
                        RunObject = page "Security Perfection List";
                        RunPageLink = Status = CONST(Rejected);
                    }
                    action("Perfection In Progress list")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Perfection In Progress list';
                        RunObject = page "Perfection In Progress list";
                    }
                    // action("Approved Security Perfection")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Approved Perfection';
                    //     RunObject = page "Approved Security Perf. List";
                    // }
                    // action("Rejected Security Perfection")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Rejected Perfection';
                    //     RunObject = page "Rejected Security Perf. List";
                    // }
                    action("Perfected Securities List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Perfected Securities List';
                        //RunObject = page "Perfected Securities List";
                        RunObject = page "Security Perfection List";
                        RunPageView = where("Perfected" = CONST(true));
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
                }


                group("Collateral Collection")
                {
                    Caption = 'Security Discharge';
                    action("Open Collateral Collection - List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Open Security Discharge - List';
                        RunObject = page "Collateral Collection - List";
                        RunPageView = WHERE(Status = filter(Open));
                    }
                    action("Pending Collateral Collection - List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Pending Security Discharge - List';
                        RunObject = page "Collateral Collection - List";
                        RunPageView = where(Status = filter(Pending));
                    }
                    action("Rejected Collateral Collection - List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Rejected Security Discharge - List';
                        RunObject = page "Collateral Collection - List";
                        RunPageView = where(Status = filter(Rejected));
                    }
                    action("Approved Collateral Collection - List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Approved Security Discharge - List';
                        RunObject = page "Collateral Collection - List";
                        RunPageView = WHERE(Status = filter(Approved));
                    }
                    action("Discharged Collateral - List")
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Discharged Security - List';
                        RunObject = page "Collateral Collection - List";
                        RunPageView = WHERE(Discharged = filter(TRUE));
                    }
                }

                //group("Security Discharge")
                //{
                //Caption = 'Security Discharge';
                // action ("Security Discharge Application")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Security Discharge App List';
                //     RunObject = page "Security Discharge App List";
                // }
                // action("Approved Security Discharge")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Approved Security Discharge';
                //     RunObject = page "Apprvd Security Discharge List";
                // }
                // action("Rejected Security Discharge")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Rejected Security Discharge';
                //     RunObject = page "Rej. Security Discharge List";
                // }
                // action("Discharged Securities List")
                // {
                //     // ApplicationArea = Basic, Suite;
                //     // Caption = 'Discharged Securities List';
                //     // RunObject = page "Discharged Securities List";
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Discharged Securities';
                //     RunObject = page "Security Perfection List";
                //     RunPageLink = "Perfection Stage" = CONST(Discharged);
                // }
                //}
            }
            group(ContractManagement)
            {
                Caption = 'Contracts';
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
                group("Contract Management")
                {
                    Caption = 'Contract Management';
                    action("Contracts list")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Open Contracts';
                        RunObject = Page "Contracts list";
                        RunPageLink = Status = CONST(New);
                    }
                    action("Pending Contracts")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Contracts Pending Approval';
                        RunObject = Page "Contracts list";
                        RunpageLink = Status = CONST("Pending Approval");
                    }
                    action("Approved Contracts list")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Approved Contracts list';
                        //RunObject = Page "Approved Contracts list";
                        RunObject = Page "Contracts list";
                        RunpageLink = Status = CONST(Approved);
                    }
                    action("Lease list")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Lease List';
                        //RunObject = Page "Approved Contracts list";
                        RunObject = Page "Contracts list";
                        //RunpageLink = Status = CONST(Approved);
                        RunPageView = WHERE("Contract Type" = CONST(Lease));
                    }


                    // action("Renewed Contracts list")
                    // {
                    //     ApplicationArea = Basic;
                    //     Caption = 'Renewed Contracts list';
                    //     RunObject = Page "Renewed Contracts list";
                    // }
                    action("Terminated Contracts list")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Terminated Contracts list';
                        //RunObject = Page "Terminated Contracts list";
                        RunObject = Page "Contracts list";
                        RunpageLink = Status = CONST(Approved), Terminated = const(True);
                    }
                    // action("Contract Purchase Order List ")
                    // {
                    //     ApplicationArea = Basic;
                    //     Caption = 'Contract Purchase Order List';
                    //     RunObject = Page "Contract Purchase Order List";
                    // }
                    action("Rejected Contracts")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Contracts Details';
                        RunObject = Page "Contracts list";
                        RunpageLink = Status = CONST(Rejected);
                    }
                }
                group("Contract Templates")
                {
                    Caption = 'Contract Templates';
                    action("Contract Template")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Contract Templates';
                        RunObject = Page "Contract Templates List";
                    }
                }

                group("Lease Agreement Requests")
                {
                    group(Tenants)
                    {
                        Caption = 'Lease Agreement Requests';
                        action("Open Tenant")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open Tenants';
                            RunObject = page "Tenant List";
                            RunPageLink = "Account Type" = CONST(Tenant);
                            RunPageView = WHERE(Status = CONST(New));
                        }
                        action("Tenants Pending Approval")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Tenants Pedning Approval';
                            RunObject = page "Tenant List";
                            RunPageLink = "Account Type" = CONST(Tenant);
                            RunPageView = WHERE(Status = CONST("pending approval"));
                        }
                        action("Rejected Tenant")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Rejected Tenants';
                            RunObject = page "Tenant List";
                            RunPageLink = "Account Type" = CONST(Tenant);
                            RunPageView = WHERE(Status = CONST(Rejected));
                        }
                        action("Approved Tenant")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved Tenants';
                            RunObject = page "Tenant List";
                            RunPageLink = "Account Type" = CONST(Tenant);
                            RunPageView = WHERE(Status = CONST(Approved));
                        }
                    }
                    group("Lease Management")
                    {
                        caption = 'Lease Management';
                        action("Open Lease List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open Lease List';
                            RunObject = page "Lease-List";
                            RunPageLink = Status = CONST(Open);
                        }
                        action("Pending Lease List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Pending Lease List';
                            RunObject = page "Lease-List";
                            RunPageLink = Status = CONST(Pending);
                        }
                        action("Rejected Lease List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Rejected Lease List';
                            RunObject = page "Lease-List";
                            RunPageLink = Status = CONST(Rejected);
                        }
                        action("Approved Lease List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved Lease List';
                            RunObject = page "Lease-List";
                            RunPageLink = Status = CONST(Approved);
                        }
                    }
                }

                // group("Contract setUp")
                // {
                //     Caption = 'Contract Setup';
                //     action("Contract Line")
                //     {
                //         ApplicationArea = Basic;
                //         Caption = 'Contract Line';
                //         RunObject = Page "Contract Lines";
                //     }
                //     action("Contract Cycle")
                //     {
                //         ApplicationArea = Basic;
                //         Caption = 'Contract Cycle';
                //         RunObject = Page "Contract Cycle";
                //     }
                // action("Contract Lines Type")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Contract Lines Type';
                //     RunObject = Page "Contract Lines Type";
                // }
                // action("Contracts Duration/ cycle")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Contracts Duration/ cycle';
                //     RunObject = Page "Contract Cycle";
                // }
                // action("Contract Expecatations")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Contract Expecatations';
                //     RunObject = Page "Contract Expectation Details-L";
                // }
                // action("Contract Cycle Stage")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Contract Cycle Stage';
                //     RunObject = Page "Contract Cycle Stage";
                // }
                //}
                // group(Invoice)
                // {
                //     Caption = 'Invoice';
                //     action("Contract Purchase Invoices")
                //     {
                //         ApplicationArea = Basic;
                //         Caption = 'Contract Purchase Invoices';
                //         RunObject = Page "Contract Purchase Invoices";
                //     }
                // }
                // group(Paiment)
                // {
                //     Caption = 'Payment';
                //     action(Payment)
                //     {
                //         ApplicationArea = Basic;
                //         Caption = 'Payment';
                //         RunObject = Page "Payment Vouchers List";
                //     }
                // }
            }
            group(Nominees)
            {
                Caption = 'Nominees';
                group("Nominee Form Requests")
                {
                    Caption = 'Nominee  Form Requests';
                    // action("Nominee Request Form")
                    // {
                    //     ApplicationArea = Basic;
                    //     Caption = 'Open Form Request';
                    //     RunObject = Page "Nominee Request Form List";
                    //     RunPageLink = Status = Const(Open);
                    // }
                    // action("Pending Request Form")
                    // {
                    //     ApplicationArea = Basic;
                    //     Caption = 'Pending Form Request';
                    //     RunObject = Page "Nominee Request Form List";
                    //     RunPageLink = Status = Const(Pending);
                    // }
                    action("Approved Request Form")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Requested Nominee Form';
                        RunObject = Page "Nominee Request Form List";
                        RunPageLink = Status = Const(Approved);
                    }
                    // action("Rejected Request Form")
                    // {
                    //     ApplicationArea = Basic;
                    //     Caption = 'Rejected Form Request';
                    //     RunObject = Page "Nominee Request Form List";
                    //     RunPageLink = Status = Const(Rejected);
                    // }
                }
                group("View Nominees")
                {
                    action("Nominee")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Nominee';
                        RunObject = Page "Nominee Legal List";
                    }
                }
            }

            group("Share Capital Cert")
            {
                Caption = 'Share Certificate';
                // action("Share Capital Certificate")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Share Capital Cert Register';
                //     RunObject = Page "Share Certificate Buffer List";
                // }   
                action("Share Capital Certificate")
                {
                    ApplicationArea = Basic;
                    Caption = 'Share Capital Certificate';
                    RunObject = Report "Share Capital Certificate";
                }

                // action("Share Capital Register")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Share Capital Register';
                //     RunObject = page "Savings Account List";
                //     RunPageView = WHERE("Product Category" = CONST("Share Capital"), "Balance (LCY)" = filter(>= 30000));
                // }
                // action("Transfered Share Capital Register")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Transfered Share Capital Register';
                //     RunObject = page "Savings Account List";
                //     RunPageView = WHERE("Product Category" = CONST("Transfered Share Capital"), "Balance (LCY)" = filter(> 0));
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
            group("Legal Notifications")
            {
                action("Notifications")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page NotificationSetupSms;
                    RunPageLink = "Notification" = CONST(Legal), Notification = CONST("Collateral Discharge"), Notification = Const("Perfection");
                }
            }
            group(Reports)
            {
                caption = 'Reports';
                group(Litigation)
                {
                    action("Litigation Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Litigation Report';
                        RunObject = Report "Litigation Report";
                    }
                    action("Appeals Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Appeals Report';
                        RunObject = Report "Appeals Report";
                    }
                    action("ADR Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'ADR Report';
                        RunObject = Report "ADR Report";
                    }
                    action("Litigaton Cases By Cost")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Litigaton Cases By Cost';
                        RunObject = Report "Litigaton Cases By Cost";
                    }
                    // action("Case Report")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Case Report';
                    //     RunObject = Report "Case Report";
                    // }
                    // action("Advocate Cost Report")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Advocate Cost Report';
                    //     RunObject = Report "Avocate Cost Report";
                    // }
                    // action("Case Status Report")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Case Status Report';
                    //     RunObject = Report "Case Status Report";
                    // }
                    // action("Case Cost")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Case Cost';
                    //     RunObject = Report "Case Cost";
                    // }
                    // action("Advocate Report")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Advocate Report';
                    //     RunObject = Report "Advocate Report";
                    // }
                }

                group("Contracts")
                {
                    Caption = 'Contracts';
                    action("Detailed Contract Report")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Detailed Contract Report';
                        RunObject = report "Detailed Contract Report";
                    }
                    // action("Contract Status")
                    // {
                    //     ApplicationArea = Basic;
                    //     Caption = 'Contract Status';
                    //     RunObject = report "Contract Status";
                    // }
                    // action("Contract Report")
                    // {
                    //     ApplicationArea = Basic;
                    //     Caption = 'Contract Report';
                    //     RunObject = report "Contract Report";
                    // }
                }
                group("Nominee Register")
                {
                    action("Nominee Report")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Nominee Register';
                        RunObject = Report "Nominee Register";
                    }
                    action("Dispatched Nominee Forms")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Dispatched Nominee Forms';
                        RunObject = Report "Dispatched Nominee Forms";
                    }

                }
                group("Securities Perfection")
                {
                    action("Security Perfection Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Security Perfection Report';
                        RunObject = Report "Perfection Register";
                    }
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
                }
                group("Surety")
                {
                    action("Surety Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Surety Report';
                        RunObject = Report "Surety Report";
                    }
                }
                group("Share Capital")
                {
                    action("Share Capital Register List")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Share Capital Register';
                        // RunObject = Report "Share Capital Register";
                        RunObject = Report "Legal Share Capital Register";
                    }
                }
            }
        }
    }
}
profile "Legal Role Center"
{
    Caption = 'Legal Role Center';
    RoleCenter = "Legal Role Center";
    ProfileDescription = 'Administrator';
}