page 52187065 "Administration Role Center"
{
    ApplicationArea = All;
    Caption = 'Administration Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {

            part(Control76; customheadline)
            {
                ApplicationArea = Basic, Suite;
            }

            part("Admin Activity"; "Admin Cue Page")
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
            group("Fleet Management")
            {
                Caption = 'Fleet';
                group("Driver Creation")
                {
                    action("Driver Application")
                    {
                        ApplicationArea = All;
                        Caption = 'Driver Application';
                        RunObject = page "Drivers List";
                        RunPageLink = Status = CONST(Open);
                        RunPageMode = Create;
                    }
                    action("Driver - Pending")
                    {
                        ApplicationArea = All;
                        Caption = 'Pending Driver Appl';
                        RunObject = page "Drivers List";
                        RunPageLink = Status = CONST(Pending);
                        RunPageMode = Edit;
                    }
                    action("Driver - Approved")
                    {
                        ApplicationArea = All;
                        Caption = 'Approved Driver Appl.';
                        RunObject = page "Drivers List";
                        RunPageLink = Status = CONST(Approved);
                        RunPageMode = View;

                    }
                    action("Drivers")
                    {
                        ApplicationArea = All;
                        Caption = 'Rejected Driver Appl.';
                        RunObject = page "Drivers List";
                        RunPageLink = Status = CONST(Rejected);
                        RunPageMode = View;
                    }
                    action("Active Drivers")
                    {
                        ApplicationArea = All;
                        Caption = 'Active Drivers';
                        RunObject = page "Drivers List";
                        RunPageView = where(Status = CONST(Approved), Active = Const(True));
                        RunPageMode = View;
                    }
                }
                //Company Vehicles
                group("Company Vehicles")
                {
                    Caption = 'Company Vehicles';
                    action("Company Vehicles list")
                    {
                        ApplicationArea = All;
                        RunObject = page "Company Vehicles list";
                        Caption = 'Company Motor Vehicles';
                        RunPageLink = Status = CONST(Open);
                    }
                    action("Pending Vehicles")
                    {
                        ApplicationArea = All;
                        RunObject = page "Company Vehicles list";
                        Caption = 'Pending Motor Vehicles';
                        RunPageLink = Status = CONST("Pending Approval");
                    }
                    action("Approved Vehicles")
                    {
                        ApplicationArea = All;
                        //RunObject = page "Approved Vehicle";
                        RunObject = page "Company Vehicles list";
                        Caption = 'Approved Vehicles';
                        RunPageLink = Status = CONST(Approved);
                    }
                    action("Rejected Vehicles")
                    {
                        ApplicationArea = All;
                        //RunObject = page "Rejected Vehicles";
                        RunObject = page "Company Vehicles list";
                        Caption = 'Rejected Vehicles';
                        RunPageLink = Status = CONST(Rejected);
                    }
                    action("Closed vehicles")
                    {
                        ApplicationArea = All;
                        //RunObject = page "Closed vehicles";
                        RunObject = page "Company Vehicles list";
                        RunPageLink = Status = CONST(Closed);
                        Caption = 'Closed vehicles';
                    }
                    action("Active Vehicles")
                    {
                        ApplicationArea = All;
                        RunObject = page "Active Vehicles";
                        Caption = 'Active Vehicles';
                    }
                }
                group("Motor Vehicle Request")
                {
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
                            Caption = 'Vehicle Requests Pending Approval.';
                            RunObject = page "Motor Vehicle Request List";
                            RunPageLink = Status = CONST(Pending);
                        }

                        action("Pending Allocation Vehicle Requests")
                        {
                            ApplicationArea = all;
                            Caption = 'Vehicle Requests Pending Allocation.';
                            RunObject = page "Motor Vehicle Request List";
                            RunPageLink = Status = CONST("Requested Pending Allocation");
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
                            //RunObject = page "Deffered Vehicle Req - List";
                            RunObject = page "Motor Vehicle Request List";
                            RunpageLink = Status = CONST(Deffered);
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
                    group("MotorVehicle Requests Edits")
                    {
                        action("Open Vehicle Requests Edit")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Vehicle Requests Edit';
                            RunObject = Page "System Edits List";
                            RunPageLink = "Table ID" = CONST(52187061);
                        }

                    }
                }

                group("Movement")
                {
                    Caption = 'Vehicle Movement';
                    action("Open Vehicle Movement")
                    {
                        ApplicationArea = All;
                        RunObject = page "Motor Vehicle Movement List";
                        Caption = 'Open Vehicle Movement';
                        RunPageLink = Status = const(Open);
                    }
                    action("Pending Vehicle Movement")
                    {
                        ApplicationArea = All;
                        RunObject = page "Motor Vehicle Movement List";
                        Caption = 'Pending Vehicle Movement';
                        RunPageLink = Status = const(Pending);
                    }
                    action("Approved Vehicle Movement")
                    {
                        ApplicationArea = All;
                        RunObject = page "Motor Vehicle Movement List";
                        Caption = 'Approved Vehicle Movement';
                        RunPageView = Where(Status = const(Approved), "Movement Status" = const("In-progress"));
                    }
                    action("Rejected Vehicle Movement")
                    {
                        ApplicationArea = All;
                        RunObject = page "Motor Vehicle Movement List";
                        Caption = 'Rejected Vehicle Movement';
                        RunPageLink = Status = const(Rejected);
                    }
                    action("Vehicle Movements In-progress")
                    {
                        ApplicationArea = All;
                        RunObject = page "Motor Vehicle Movement List";
                        Caption = 'Vehicle Movements In-progress';
                        RunPageLink = "Movement Status" = const("In-progress");
                    }
                    action("Closed Movement")
                    {
                        ApplicationArea = All;
                        RunObject = page "Motor Vehicle Movement List";
                        Caption = 'Closed Vehicle Movements';
                        RunPageLink = "Movement Status" = const(Closed);
                    }
                }


                group("Vehicle Fueling")
                {
                    action("Open Fueling")
                    {
                        ApplicationArea = All;
                        RunObject = page "Motor Vehicle Fueling List";
                        Caption = 'Open Vehicle Fueling';
                        RunPageLink = Status = CONST(Open);
                    }
                    action("Fueling Pending Approval")
                    {
                        ApplicationArea = All;
                        RunObject = page "Motor Vehicle Fueling List";
                        Caption = 'Fueling Pending Approval';
                        RunPageLink = Status = CONST(Pending);
                    }
                    action("Approved Fuel")
                    {
                        ApplicationArea = All;
                        RunObject = page "Motor Vehicle Fueling List";
                        Caption = 'Approved Fueling';
                        RunPageLink = Status = CONST(Approved);
                    }
                    action("Rejected Fuel")
                    {
                        ApplicationArea = All;
                        RunObject = page "Motor Vehicle Fueling List";
                        Caption = 'Rejected Fueling';
                        RunPageLink = Status = CONST(Rejected);
                    }
                }
                //vehicle service details &   //Vehicle repair
                group("Vehicle Repair")
                {
                    action("Open Vehicles Repair")
                    {
                        ApplicationArea = All;
                        //RunObject = page "Maintain Machne/Vehicles";
                        RunObject = page "Motor Vehicle Repair";
                        Caption = 'Open Motor Vehicle Repair';
                        RunPageLink = Status = CONST(Open);
                    }
                    action("Vehicles Repair Pending Approval")
                    {
                        ApplicationArea = All;
                        //RunObject = page "Maintain Machne/Vehicles";
                        RunObject = page "Motor Vehicle Repair";
                        Caption = 'Motor Vehicle Repair Pending Approval';
                        RunPageLink = Status = CONST(Pending);
                    }
                    action("Rejected Vehicles Repair")
                    {
                        ApplicationArea = All;
                        //RunObject = page "Maintain Machne/Vehicles";
                        RunObject = page "Motor Vehicle Repair";
                        Caption = 'Rejected Motor Vehicle Repair';
                        RunPageLink = Status = CONST(Rejected);
                    }
                    action("Approved Vehicles Repair")
                    {
                        ApplicationArea = All;
                        //RunObject = page "Maintain Machne/Vehicles";
                        RunObject = page "Motor Vehicle Repair";
                        Caption = 'Approved Motor Vehicle Repair';
                        RunPageLink = Status = CONST(Approved);
                    }
                }
                group("Vehicle Servicing")
                {
                    action("Open Motor Vehicle Servicing")
                    {
                        ApplicationArea = All;
                        RunObject = page "Vehicle Servicing List Page";
                        Caption = 'Open Motor Vehicle Servicing';
                        RunPageLink = Status = CONST(Open);
                    }
                    action("Motor Vehicle Servicing Pending Approval")
                    {
                        ApplicationArea = All;
                        RunObject = page "Vehicle Servicing List Page";
                        Caption = 'Motor Vehicle Servicing Pending Approval';
                        RunPageLink = Status = CONST(Pending);
                    }
                    action("Rejected Motor Vehicle Servicing")
                    {
                        ApplicationArea = All;
                        RunObject = page "Vehicle Servicing List Page";
                        Caption = 'Rejected Motor Vehicle Servicing';
                        RunPageLink = Status = CONST(Rejected);
                    }
                    action("Approved Motor Vehicle Servicing")
                    {
                        ApplicationArea = All;
                        RunObject = page "Vehicle Servicing List Page";
                        Caption = 'Approved Motor Vehicle Servicing';
                        RunPageLink = Status = CONST(Approved);
                    }
                }
                //motor vehicle accident 
                // group(Accidents)
                // {
                //     action("Open Vehicle Accidents")
                //     {
                //         ApplicationArea = all;
                //         Caption = 'Accidents';
                //         RunObject = page "HR OSAccident List";
                //         //RunPageLink = Status = CONST(Open);
                //     }
                //     action("Accidents Pending Approval")
                //     {
                //         ApplicationArea = all;
                //         Caption = 'Pending Accidents';
                //         RunObject = page "HR OSAccident List";
                //         RunPageLink = Status = CONST(Pending);
                //     }
                //     action("Approved Vehicle Accidents")
                //     {
                //         ApplicationArea = all;
                //         Caption = 'Approved Accidents';
                //         RunObject = page "HR OSAccident List";
                //         RunPageLink = Status = CONST(Approved);
                //     }
                //     action("Motor Vehicle Accidents")
                //     {
                //         ApplicationArea = all;
                //         Caption = 'Rejected Accidents';
                //         RunObject = page "HR OSAccident List";
                //         RunPageLink = Status = CONST(Rejected);
                //     }
                // }


                group(Accidents)
                {
                    action("Open Vehicle Accidents")
                    {
                        ApplicationArea = all;
                        Caption = 'Accidents';
                        RunObject = page "HR OSAccident List";
                        //RunPageLink = Status = CONST(Open);
                    }
                    action("Accidents Pending Approval")
                    {
                        ApplicationArea = all;
                        Caption = 'Pending Accidents';
                        RunObject = page "HR OSAccident List";
                        RunPageLink = Status = CONST(Pending);
                    }
                    action("Approved Vehicle Accidents")
                    {
                        ApplicationArea = all;
                        Caption = 'Approved Accidents';
                        RunObject = page "HR OSAccident List";
                        RunPageLink = Status = CONST(Approved);
                    }
                    action("Motor Vehicle Accidents")
                    {
                        ApplicationArea = all;
                        Caption = 'Rejected Accidents';
                        RunObject = page "HR OSAccident List";
                        RunPageLink = Status = CONST(Rejected);
                    }
                }
            }
            // group("Tenancy Management")
            // {
            //     Caption = 'Tenancy Management';
            //     action("Tenancy Management")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Tenancy Management';
            //         RunObject = page "Tenancy Management List";
            //     }
            // }
            group("Property Management")
            {
                Caption = 'Property';
                group("Tenancy")
                {
                    caption = 'Tenancy';
                    group("LandLords")
                    {
                        Caption = 'Landlords';
                        action("Open Landlord List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open Landlord List';
                            RunObject = page "Landlord  List";
                            RunPageLink = Status = CONST(New);
                        }
                        action("Landlords Pending Approval")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Landlords Pending Approval';
                            RunObject = page "Landlord  List";
                            RunPageLink = Status = CONST("Pending Approval");
                        }
                        action("Rejected Landlord")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Rejected Landlord';
                            RunObject = page "Landlord  List";
                            RunPageLink = Status = CONST(Rejected);
                        }
                        action("Approved Landlord")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved Landlord List';
                            RunObject = page "Landlord  List";
                            RunPageLink = Status = CONST(Approved);
                        }
                    }
                    group("Tenants")
                    {
                        Caption = 'Tenants';
                        action("Open Tenants")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open Tenants';
                            RunObject = page "Tenant List";
                            //RunPageLink = "Account Type" = CONST(Tenant);
                            RunPageView = WHERE(Status = CONST(New), "Account Type" = CONST(Tenant));
                        }
                        action("Tenants Pending Approval")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Tenants Pending Approval';
                            RunObject = page "Tenant List";
                            //RunPageLink = "Account Type" = CONST(Tenant);
                            RunPageView = WHERE(Status = CONST("Pending Approval"), "Account Type" = CONST(Tenant));
                        }
                        action("Rejected Tenant")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Rejected Tenants';
                            RunObject = page "Tenant List";
                            //RunPageLink = "Account Type" = CONST(Tenant);
                            RunPageView = WHERE(Status = CONST(Rejected), "Account Type" = CONST(Tenant));
                        }
                        action("Approved Tenant")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved Tenants';
                            RunObject = page "Tenant List";
                            //RunPageLink = "Account Type" = CONST(Tenant);
                            RunPageView = WHERE(Status = CONST(Approved), "Account Type" = CONST(Tenant));
                        }
                    }
                    group("New Tenants")
                    {
                        Caption = 'Tenants';
                        action("Open Tenant")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open Tenants';
                            RunObject = page "Customer List";
                            //RunPageLink = "Account Type" = CONST(Tenant);
                            RunPageView = WHERE(Status = CONST(New), "Account Type" = CONST(Tenant));
                        }
                        action("Tenant Pending Approval")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Tenants Pending Approval';
                            RunObject = page "Customer List";
                            //RunPageLink = "Account Type" = CONST(Tenant);
                            RunPageView = WHERE(Status = CONST("Pending Approval"), "Account Type" = CONST(Tenant));
                        }
                        action("Rejecteds  Tenants")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Rejected Tenants';
                            RunObject = page "Customer List";
                            //RunPageLink = "Account Type" = CONST(Tenant);
                            RunPageView = WHERE(Status = CONST(Rejected), "Account Type" = CONST(Tenant));
                        }
                        action("Approveds Tenants")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved Tenants';
                            RunObject = page "Customer List";
                            //RunPageLink = "Account Type" = CONST(Tenant);
                            RunPageView = WHERE(Status = CONST(Approved), "Account Type" = CONST(Tenant));
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
                            Caption = 'Offices List';
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
                }
                group("Lease Management")
                {
                    caption = 'Lease Management';
                    action("Lease List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Open Lease List';
                        RunObject = page "Lease-List";
                        //RunPageLink = Status = CONST(Open);
                        RunPageView = Where(Status = CONST(Open), "Lease Status" = CONST("Open"));
                    }
                    action("Pending Lease List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pending Lease List';
                        RunObject = page "Lease-List";
                        //RunPageLink = Status = CONST(Pending);
                        RunPageView = Where(Status = CONST(Pending), "Lease Status" = CONST("Open"));
                    }
                    action("Rejected Lease List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Rejected Lease List';
                        RunObject = page "Lease-List";
                        //RunPageLink = Status = CONST(Rejected);
                        RunPageView = Where(Status = CONST(Rejected), "Lease Status" = CONST("Open"));
                    }
                    action("Approved Lease List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Lease List';
                        RunObject = page "Lease-List";
                        //RunPageLink = Status = CONST(Approved);
                        RunPageView = Where(Status = CONST(Approved), "Lease Status" = CONST("Open"));
                    }
                }
                group("Lease Commencement")
                {
                    Caption = 'Lease Commencement';

                    action("Lease-Commencement")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Lease-Commencement All Leases';
                        RunObject = page "Lease-Commencement";
                    }
                    // action("Active Lease-List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Active Lease-List';
                    //     runobject = page "Active Lease-List";
                    // }
                    // action("Terminated Leases")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Terminated Leases';
                    //     RunObject = page "Terminate Active Lease-List";
                    // }
                    action("Active Leases")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Active Leases List';
                        RunObject = page "Lease-List";
                        //RunPageLink = Terminated = CONST(TRUE);
                        RunPageLink = "Lease Status" = CONST("Active");
                    }
                    action("Terminated Leases List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Terminated Leases List';
                        RunObject = page "Lease-List";
                        RunPageLink = Terminated = CONST(TRUE);
                    }
                    action("Expired Leases")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Expired Leases';
                        RunObject = page "Lease-list";
                        RunPageLink = Expired = CONST(true);
                    }
                    action("Renewed Leases")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Renewed Leases';
                        RunObject = page "Lease-list";
                        RunPageLink = "Renew Lease" = CONST(true);
                    }
                    // action("Bills List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Bills List';
                    //     RunObject = page "Bills List";
                    // }
                    // action("Posted Bills List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Posted Bills List';
                    //     RunObject = page "Posted Bills List";
                    // }
                }
                // group("Approvals")
                // {
                //     Caption = 'Approvals';
                //     action("Approval Entries")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Approval Entries';
                //         RunObject = page "Approval Entries";
                //     }
                //     action("Approval Request Entries")
                //     {
                //         ApplicationArea = Basic, Suite;
                //         Caption = 'Approval Request Entries';
                //         RunObject = page "Approval Request Entries";
                //     }
                // }
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
                        action("Admin Notificaitions")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Admin Notificaitions & Expiries';
                            RunObject = Report "Admin Notificaitions";
                        }
                    }
                }
            }
            group("Conference Hall and Meeting Rooms Management")
            {
                Caption = 'Conference and Meetings';
                group("Conference Room Clients")
                {
                    action("Open Conference Room Clients")
                    {
                        ApplicationArea = All;
                        Caption = 'Open Conference Room Clients';
                        RunObject = page "Customer list";
                        RunPageLink = Status = CONST(New), "Account Type" = CONST("Conference Room Customer");
                    }
                    action("Approved Conference Room Clients")
                    {
                        ApplicationArea = All;
                        Caption = 'Approved Conference Room Clients';
                        RunObject = page "Customer list";
                        RunPageLink = Status = CONST(Approved), "Account Type" = CONST("Conference Room Customer");
                    }
                    action("Conference Room Clients Pending Approval")
                    {
                        ApplicationArea = All;
                        Caption = 'Conference Room Clients Pending Approval';
                        RunObject = page "Customer list";
                        RunPageLink = Status = CONST("Pending Approval"), "Account Type" = CONST("Conference Room Customer");
                    }
                    action("Rejected Conference Room Clients Pending")
                    {
                        ApplicationArea = All;
                        Caption = 'Rejected Conference Room Clients Pending';
                        RunObject = page "Customer list";
                        RunPageLink = Status = CONST(Rejected), "Account Type" = CONST("Conference Room Customer");
                    }
                }
                group("Conference Halls & Meeting Rooms Creation")
                {
                    
                    
                    
                }
                group("Conf & Meeting Room Booking")
                {
                    Caption = 'Conf & Meeting Room Aplications';
                    action("Employee Conference Hall & Meeting Rooms")
                    {
                        ApplicationArea = All;
                        Caption = 'Open Bookings';
                        RunObject = page "MNS Conf & Meetings Appl List";
                        RunPageLink = Status = CONST(Open);
                    }
                    action("Employee Pending Conf & Meeting Room Booking")
                    {
                        ApplicationArea = All;
                        Caption = 'Pending Bookings';
                        //RunObject = page "Pending Conf & Meeting - List";
                        RunObject = page "MNS Conf & Meetings Appl List";
                        RunPageLink = Status = CONST(Pending);
                    }
                    action("Employee Approved Conf & Meeting Room Booking")
                    {
                        ApplicationArea = All;
                        Caption = 'Approved Booking';
                        //RunObject = page "Approved Conf & Meeting - List";
                        RunObject = page "MNS Conf & Meetings Appl List";
                        RunPageLink = Status = CONST(Approved);
                    }
                    action("Employee Invoicing for Hire of Halls")
                    {
                        ApplicationArea = All;
                        Caption = 'Invoicing for Hire of Halls';
                        //RunObject = page "Approved Conf & Meeting - List";
                        RunObject = page "MNS Conf & Meetings Appl List";
                        //RunPageLink = Status = CONST(Approved);
                        RunPageView = WHERE(Status = CONST(Approved), "Type of Meeting/Function" = Const(External));
                        //), ("Current Department" = const(<> "Originating Department")
                    }
                    action("Employee Rejected Conf & Meeting Room Booking")
                    {
                        ApplicationArea = All;
                        Caption = 'Declined Bookings';
                        //RunObject = page "Rejected Conf & Meeting - List";
                        RunObject = page "MNS Conf & Meetings Appl List";
                        RunPageLink = Status = CONST(Rejected);
                    }
                    action("Employee  Closed Conf & Meeting Room Booking")
                    {
                        ApplicationArea = All;
                        Caption = 'Closed Bookings';
                        //RunObject = page "Closed Conf & Meeting - List";
                        RunObject = page "MNS Conf & Meetings Appl List";
                        RunPageLink = "Status of the Booking" = CONST(Closed);
                    }
                    action("Conference Booking Calendar")
                    {
                        ApplicationArea = All;
                        Caption = 'Conference Booking Planner';
                        RunObject = Report "Conference Booking Calendar";
                    }
                    action("Admin Booking Calendar Card")
                    {
                        ApplicationArea = All;
                        Caption = 'Admin Booking Calendar';
                        RunObject = page "Admin Booking Calendar List";
                    }
                    action("Bookings")
                    {
                        ApplicationArea = All;
                        Caption = 'Bookings';
                        RunObject = page "Admin Booking Planner";
                    }
                }
            }
            group("Office Keys Managment")
            {
                Caption = 'Office Keys';
                group("Key Creation")
                {
                    action("Open Key Creation")
                    {
                        ApplicationArea = All;
                        Caption = 'Keys List';
                        RunObject = page "Key Details";
                    }

                    //     action("Pending Key Creation")
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Pending Key Creation';
                    //     RunObject = page "Key Details";
                    //     RunPageLink = Status = CONST(Pending);
                    // }
                    // action("Approved Key Creation")
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Approved Key Creation';
                    //     RunObject = page "Key Details";
                    //     RunPageLink = Status = CONST(Approved);
                    // }
                    // action("Rejected Key Creation")
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Rejected Key Creation';
                    //     RunObject = page "Key Details";
                    //     RunPageLink = Status = CONST(Rejected);
                    // }
                    // action("Created Keys")
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Created Keys';
                    //     RunObject = page "Key Details";
                    //     RunPageLink = "Key Status" = CONST(Created);

                    // }
                    // action("Deactivated Keys")
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Deactivated Keys';
                    //     RunObject = page "Key Details";
                    //     RunPageLink = "Key Status" = CONST(Inactive);     
                    // }
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
                // group("Key Dispatch")
                // {
                //     action("Open Keys Dispatch")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Open Keys Dispatch';
                //         RunObject = page  "Key Dispatch List";
                //         RunPageLink = "Key Status" = CONST(Open);
                //     }
                //     action("Dispatched Keys")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Dispatched Keys';
                //         RunObject = page  "Key Dispatch List";
                //         RunPageLink = "Key Status" = CONST(Dispatched);
                //     }
                //     action("Office Keys Dispatch")
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Returned Keys';
                //         RunObject = page  "Key Dispatch List";
                //         RunPageLink = "Key Status" = CONST(Returned);
                //     }
                // }
            }
            group("Parking Management")
            {
                Caption = 'Parking';
                group("Parking Tenants Creation")
                {
                    action("Open Parking Tenants")
                    {
                        ApplicationArea = All;
                        Caption = 'Parking Tenants Creation';
                        RunObject = page "Tenant List";
                        RunPageLink = Status = CONST(New), "Account Type" = CONST("Parking Customer");
                    }
                    action("Approved Tenants")
                    {
                        ApplicationArea = All;
                        Caption = 'Approved Parking Tenants';
                        RunObject = page "Tenant List";
                        RunPageLink = Status = CONST(Approved), "Account Type" = CONST("Parking Customer");
                    }
                    action("Closed Tenants")
                    {
                        ApplicationArea = All;
                        Caption = 'Pending Parking Tenants';
                        RunObject = page "Tenant List";
                        RunPageLink = Status = CONST("Pending Approval"), "Account Type" = CONST("Parking Customer");
                    }
                    action("Rejected Tenants")
                    {
                        ApplicationArea = All;
                        Caption = 'Rejected Parking Tenants';
                        RunObject = page "Tenant List";
                        RunPageLink = Status = CONST(Rejected), "Account Type" = CONST("Parking Customer");
                    }
                }
                group("Parking Space Creation")
                {
                    action("Parking Spaces")
                    {
                        ApplicationArea = All;
                        Caption = 'Parking Space';
                        RunObject = page "MNS Parking Space List";
                    }

                    // action("Approved Parking Spaces")
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Approved Parking Space';
                    //     RunObject = page "MNS Parking Space List";
                    //     RunPageLink = Status = const(Approved); 
                    // }
                    // action("Pending Parking Spaces")
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Pending Parking Space';
                    //     RunObject = page "MNS Parking Space List";
                    //     RunPageLink = Status = CONST(Pending);
                    // }
                    // action("Rejected Parking Spaces")
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Rejected Parking Space';
                    //     RunObject = page "MNS Parking Space List";
                    // }
                }
                group("Parking Space Application")
                {
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

                        action("Closed Parking Space Application")
                        {
                            ApplicationArea = All;
                            Caption = 'Closed Parking Allocations';
                            RunObject = page "Parking Space List";
                            //RunObject = page "Closed Parking Spaces - List";
                            RunPageLink = "Booking Status" = CONST(Closed);
                        }
                    }
                    group("Parking Allocation Edits")
                    {
                        action("Parking Allocations Edits")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Parking Allocations Edits';
                            RunObject = Page "System Edits List";
                            RunPageLink = "Table ID" = CONST(52187060);
                        }
                    }
                }
            }
            group("SACCO Insurance")
            {
                Caption = 'Insurance Contracts';
                group(Insurance)
                {
                    action("Open Insurance")
                    {
                        ApplicationArea = All;
                        RunObject = page "Insurance List";
                        Caption = 'Open Insurance';
                        RunPageLink = Status = CONST(Open);
                    }
                    action("Insurance Pending Approval")
                    {
                        ApplicationArea = All;
                        RunObject = page "Insurance List";
                        Caption = 'Insurance Pending Approval';
                        RunPageLink = Status = CONST(Pending);
                    }
                    action("Insurance Rejected")
                    {
                        ApplicationArea = All;
                        RunObject = page "Insurance List";
                        Caption = 'Insurance Rejected';
                        RunPageLink = Status = CONST(Rejected);
                    }
                    action("Insurance Approved")
                    {
                        ApplicationArea = All;
                        RunObject = page "Insurance List";
                        Caption = 'Insurance Approved';
                        RunPageLink = Status = CONST(Approved), "Insurance Status" = const(New);
                    }
                    action("Active Insurance")
                    {
                        ApplicationArea = All;
                        RunObject = page "Insurance List";
                        Caption = 'Active Insurance';
                        RunPageLink = Status = CONST(Approved), "Insurance Status" = const(Active);
                    }
                    action("Expired VInsurance")
                    {
                        ApplicationArea = All;
                        RunObject = page "Insurance List";
                        Caption = 'Expired Insurance';
                        RunPageLink = Status = CONST(Approved), "Insurance Status" = const(Expired);
                    }
                }
                group("Insurance Claims")
                {
                    Caption = 'Insurance Claims';
                    action("Open Insurance Claims")
                    {
                        Caption = 'Open Insurance Claims';
                        ApplicationArea = All;
                        RunObject = page "Insurance Claims - List";
                        RunPageLink = Status = CONST(Open), Closed = CONST(FALSE);
                    }
                    action("Pending Insurance Claims")
                    {
                        Caption = 'Pending Insurance Claims';
                        ApplicationArea = All;
                        RunObject = page "Insurance Claims - List";
                        RunPageLink = Status = CONST(Pending), Closed = CONST(FALSE);
                    }
                    action("Rejected Insurance Claims")
                    {
                        Caption = 'Rejected Insurance Claims';
                        ApplicationArea = All;
                        RunObject = page "Insurance Claims - List";
                        RunPageLink = Status = CONST(Rejected), Closed = CONST(FALSE);
                    }
                    action("Approved Insurance Claims")
                    {
                        Caption = 'Approved Insurance Claims';
                        ApplicationArea = All;
                        RunObject = page "Insurance Claims - List";
                        RunPageLink = Status = CONST(Approved), Closed = CONST(FALSE);
                    }
                    action("Closed Insurance Claims")
                    {
                        Caption = 'Closed Insurance Claims';
                        ApplicationArea = All;
                        RunObject = page "Insurance Claims - List";
                        RunPageLink = Closed = CONST(TRUE);
                    }
                }
            }
            // group(EmployeeSelfService)
            // {
            //     Caption = 'Employee Self Service';
            // action(StaffWelfare)
            // {
            //     Caption = 'Staff Welfare Claim';
            //     ApplicationArea = Basic, Suite;
            //     RunObject = page "Staff Welfare List";
            // }
            // action(LeaveApplication1)
            // {
            //     Caption = 'Employee Leave Application';
            //     ApplicationArea = Basic, Suite;
            //     RunObject = page "HR Leave Applications List1";
            // }
            // action("Overtime Claim List")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Overtime';
            //     RunObject = page "Overtime Claim List";
            // }
            // action("System Rights Requisition")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'System Rights Requisition';
            //     //RunObject = page "Permission Requisition Card";
            //     RunObject = page "Permission Requisition List";
            // }
            // action("Loan Application")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Apply Staff Loan';
            //     RunObject = page "Self Loan Application List";
            // }

            //}
            group("Admin Notifications")
            {
                action("Notifications")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page NotificationSetupSms;
                    RunPageLink = Notification = CONST(Administration);
                }
            }

            group("Contract Request")
            {
                Caption = 'Contract Request';
                action("Contract Requests")
                {
                    ApplicationArea = Basic;
                    Caption = 'Open Contract Request';
                    RunObject = Page "Contract Request List";
                    RunPageLink = Status = CONST(Open);
                }
                action("Contract Requests Pending Approval")
                {
                    ApplicationArea = Basic;
                    Caption = 'Contract Request - Pending Approval';
                    RunObject = Page "Contract Request List";
                    RunPageLink = Status = CONST(Pending);
                }
                action("Rejected Contract Requests")
                {
                    ApplicationArea = Basic;
                    Caption = 'Rejected Contract Request';
                    RunObject = Page "Contract Request List";
                    RunPageLink = Status = CONST(Rejected);
                }
                action("Approved Contract Requests")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Contract Requests';
                    RunObject = Page "Contract Request List";
                    RunPageLink = Status = CONST(Approved);
                }

            }
            group(Reports)
            {
                caption = 'Reports';
                group("Fleet Reports")
                {
                    action("SACCO Active Vehicles")
                    {
                        ApplicationArea = All;
                        Caption = 'Society Active Vehicles';
                        RunObject = Report "Society Active Vehicles";
                    }
                    action("Society Vehicle Movement")
                    {
                        Applicationarea = all;
                        Caption = 'Society Vehicle Movement';
                        RunObject = Report "Society Vehicle Movement";
                    }
                    action("Society Vehicle Request")
                    {
                        ApplicationArea = All;
                        Caption = 'Society Vehicle Request';
                        RunObject = Report "Society Vehicle Request";
                    }
                    action("Society Vehicle Fueling")
                    {
                        ApplicationArea = all;
                        Caption = 'Society Vehicle Fueling';
                        RunObject = Report "Society Vehicle Fueling";
                    }
                    action("Society Vehicle Repair")
                    {
                        ApplicationArea = all;
                        Caption = 'Society Vehicle Repair';
                        RunObject = Report "Society Vehicle Repair";
                    }
                    action("Society Vehicle Service")
                    {
                        ApplicationArea = all;
                        Caption = 'Society Vehicle Service';
                        RunObject = Report "Society Vehicle Service";
                    }
                    action("Society Accidents - Single Collision")
                    {
                        ApplicationArea = all;
                        Caption = 'Society Vehicle Accident - Single';
                        RunObject = Report "Vehicle Accidents - Single";
                    }
                    action("Vehicle Accidents - Multiple")
                    {
                        ApplicationArea = all;
                        Caption = 'Society Vehicle Accident - Multiple';
                        RunObject = Report "Vehicle Accidents - Multiple";
                    }
                    // action("Insurance Details Per Vehicle")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Insurance Details Per Vehicle';
                    //     RunObject = Report "Insurance Details Per Vehicle";
                    // }
                    // action("Vehicle Depreciation")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Vehicle Depreciation Per Vehicle';
                    //     RunObject = Report "Vehicle Depreciation";
                    // }
                    action("Mileage Per Driver")
                    {
                        ApplicationArea = all;
                        Caption = 'Mileage Per Driver';
                        RunObject = Report "Mileage Per Driver";
                    }
                }
                group("Property")
                {
                    Caption = 'Property';
                    action("Buildings Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Buildings Report';
                        RunObject = report "Buildings Report";
                    }
                    action("Tenant Invoice")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tenant Invoice';
                        RunObject = report "Tenant Invoices";
                    }
                    action("Tenant Leases")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tenant Leases';
                        RunObject = report "Tenant Leases";
                    }
                    // action("Investor - Balance to Date")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Investor - Balance to Date';
                    //     RunObject = report "Investor - Balance to Date";
                    // }
                    // action("Customer - Summary Aging Simp.")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Customer - Summary Aging Simp.';
                    //     RunObject = report "Customer - Summary Aging Simp.";
                    // }
                    // action("Property Vacancy Schedule")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Property Vacancy Schedule';
                    //     RunObject = report "Property Vacancy Schedule";
                    // }
                    action("Tenancy Schedule")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tenancy Schedule';
                        RunObject = report "Tenancy Schedule";
                    }
                    action("Unit Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Offices Spaces Report';
                        RunObject = report "Unit Report";
                    }
                    action("Lease Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Lease Report';
                        RunObject = Report "Lease Report";
                    }
                    action("Expired Lease")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Expired Leases';
                        RunObject = report "Expired Leases";
                    }
                    action("Leases Approaching Expiry")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Leases Approaching Expiry';
                        RunObject = report "Leases Approaching Expiry";
                    }
                    action("Terminated Lease")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Terminated Leases';
                        RunObject = Report "Terminated Leases";
                    }
                    action("Service Charges")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Service Charges';
                        RunObject = report "Service Charges";
                    }
                    action("Vacated Offices Per Period")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vacated Offices Per Period';
                        RunObject = report "Vacated Offices Per Period";
                    }
                    action("Escalation For Leases")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Escalations For Leases';
                        RunObject = report "Escalation For Leases";
                    }
                }
                group("Parking Reports")
                {
                    action("Vacant Parking Slots")
                    {
                        ApplicationArea = all;
                        Caption = 'Available Parking Slots';
                        RunObject = Report "Available Parking Slots";
                    }
                    action("Parking Space Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Parking Space - Internal';
                        RunObject = Report "Parking Space";
                    }
                    action("Parking Space - External")
                    {
                        ApplicationArea = all;
                        Caption = 'Parking Space - External';
                        RunObject = Report "Parking Report - External";
                    }
                }
                group("Office Keys Report")
                {
                    Caption = 'Office Keys Reports';
                    action("Office Keys Movement")
                    {
                        ApplicationArea = all;
                        Caption = 'Ofice Keys Movement';
                        RunObject = Report "Office Keys Movement";
                    }
                    action("Staff Holding Keys")
                    {
                        ApplicationArea = all;
                        Caption = 'Staff Holding Keys';
                        RunObject = Report "Staff Holding Keys";
                    }
                }
                group("Conference Rooms")
                {
                    // action("Conference Hall & Meeting Rooom")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Conference Hall & Meeting Room Use';
                    //     RunObject = Report "Conference Hall and Meeting";
                    // }
                    action("Status of Bookings")
                    {
                        ApplicationArea = all;
                        Caption = 'Conf Hall & Meetng Room Booking Status';
                        RunObject = Report "Conf Hall & Meeting Booking St";
                    }
                    action("Internal")
                    {
                        ApplicationArea = all;
                        Caption = 'Internal Conf Hall & Meeting Room';
                        RunObject = Report "Internal Conf Hall & Mtng Use";
                    }
                    action(External)
                    {
                        ApplicationArea = all;
                        Caption = 'External Conf Hall & Meeting Room';
                        RunObject = Report "External Conf Hall and Mtng";
                    }
                }
                group("Insurance Reports")
                {
                    action("Insurance Details Per Vehicle")
                    {
                        ApplicationArea = all;
                        Caption = 'Insurance Contracts';
                        RunObject = Report "Insurance Contracts";
                    }
                    action("Pending Claims")
                    {
                        ApplicationArea = all;
                        Caption = 'Pending Insurance Claims';
                        RunObject = Report "Pending Insurance Claims";
                    }
                    action("Closed Claims")
                    {
                        ApplicationArea = all;
                        Caption = 'Closed Claims';
                        RunObject = Report "Closed Insurance Claims";
                    }
                    action("Fixed Asset List")
                    {
                        ApplicationArea = all;
                        Caption = 'Fixed Asset List';
                        RunObject = Report "Fixed Asset - List";
                    }
                    action("Fully Depreciated Assets")
                    {
                        ApplicationArea = all;
                        Caption = 'Fully Depreciated Assets';
                        RunObject = Report "Fully Depreciated Assets";
                    }
                    action("FA Period Depreciation Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Fixed Asset Depreciation';
                        RunObject = Report "FA Period Depreciation Report";
                    }
                    action("FA Depreciation History")
                    {
                        ApplicationArea = all;
                        Caption = 'Fixed Asset Depreciation History';
                        RunObject = Report "FA Depreciation History";
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
                action("Purchase Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Requisitions';
                    RunObject = page "Purchase Requisitions";
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
        }

    }
}
profile "Administration Role Center"
{
    Caption = 'Administration Role Center';
    RoleCenter = "Administration Role Center";
    ProfileDescription = 'Administrator';
}

