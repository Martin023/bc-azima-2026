page 52187332 Procurement
{
    ApplicationArea = All;
    Caption = 'Procurement Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Control76; CustomHeadline)
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
            group("Order Processing")
            {
                Caption = 'Order Processing & Planning';
                group("Order Processing List")
                {
                    Caption = 'Order Processing';
                    action("Purchases Requisitions")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Requisitions';
                        RunObject = page "Purchase Requisitions";
                    }
                    action("RFQ Lists")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'RFQ List';
                        RunObject = page "RFQ List";
                    }
                    action("Purchase Quotes")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Quotes';
                        RunObject = page "Purchase Quotes";
                    }
                    action("Local Purchase Orders")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Local Purchase Orders';
                        RunObject = page "Purchase Order List";
                    }
                    // action("Procurement Petty Cash List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Procurement Petty Cash List';
                    //     RunObject = page "Petty Cash Details";
                    // }
                    action("Local Service Orders")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Local Service Orders';
                        RunObject = page "Purchase Order List";
                    }
                    action("Purchase Invoices")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Invoices';
                        RunObject = page "Purchase Invoices";
                    }
                    action("Purchase Credit Memos")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Credit Memos';
                        RunObject = page "Purchase Credit Memos";
                    }

                    action("Sales Invoice List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Invoice List';
                        RunObject = page "Sales Invoice List";
                    }

                    action("Sales Quotes")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Disposal Quote';
                        RunObject = page "Sales Quotes";
                    }
                    action("Disposal Requisition List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Disposal Requisition';
                        RunObject = page "Disposal Requisition List";
                    }

                }
                group("Order Processing Task")
                {
                    Caption = 'Order Processing Task';
                    action("Purchase Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Journal';
                        RunObject = page "Purchase Journal";
                    }
                }
                group("Order Processing Documents")
                {
                    Caption = 'Documents';
                    action("Purchase - Quote")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase - Quote';
                        RunObject = report "Purchase - Quote";
                    }
                    action("Order")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Order';
                        RunObject = report "Order";
                    }
                    action("Blanket Purchase Order")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Blanket Purchase Order';
                        RunObject = report "Blanket Purchase Order";
                    }
                    action("Purchase - Invoice")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase - Invoice';
                        RunObject = report "Purchase - Invoice";
                    }
                    action("Purchase - Credit Memo")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase - Credit Memo';
                        RunObject = report "Purchase - Credit Memo";
                    }
                    action("Purchase - Receipt")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase - Receipt';
                        RunObject = report "Purchase - Receipt";
                    }
                    action("Purchase - Return Shipment")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase - Return Shipment';
                        RunObject = report "Purchase - Return Shipment";
                    }
                    action("Return Order Confirmation")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Return Order Confirmation';
                        RunObject = report "Return Order Confirmation";
                    }
                    action("Vendor-Payment Receipt")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Payment Receipt';
                        RunObject = report "Vendor - Payment Receipt";
                    }
                    action("Purchase Document - Test")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Document - Test';
                        RunObject = report "Purchase Document - Test";
                    }
                    action("Item Tracking Appendix")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Tracking Appendix';
                        RunObject = report "Item Tracking Appendix";
                    }
                }
                group("P Administration")
                {
                    Caption = 'Administration';
                    action("Subcontracting Worksheet")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Subcontracting Worksheet';
                        RunObject = page "Subcontracting Worksheet";
                    }
                    action("Req. Worksheet")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Req. Worksheet';
                        RunObject = page "Req. Worksheet";
                    }
                    action("Recurring Req. Worksheet")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Recurring Req. Worksheet';
                        RunObject = page "Recurring Req. Worksheet";
                    }
                    action("Purchase Order List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Order List';
                        RunObject = page "Purchase Order List";
                    }
                    action("Service Orders")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Service Orders';
                        RunObject = page "Service Orders";
                    }
                    action("Transfer Orders")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Transfer Orders';
                        RunObject = page "Transfer Orders";
                    }
                }
                group("Procurememnt Order Planning")
                {
                    Caption = 'Order Planning';
                    action("Order Planning")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Order Planning';
                        RunObject = page "Order Planning";
                    }
                    action(Budgets)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'G/L Budgets';
                        RunObject = page "G/L Budget Names";
                    }
                    action(Vendors)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendors';
                        RunObject = page "Vendor List";
                    }
                    action(Item)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Items';
                        RunObject = page "Item List";
                    }
                    action("Stock Keeping")
                    {
                        ApplicationArea = Basic, Suite;

                        RunObject = page "StockKeeping List";
                    }
                }
            }
            group(Payments)
            {
                action(PostedPurchaseInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoice';
                    //RunObject = page "Posted Purchase Invoice";
                    RunObject = Page "Posted Purchase Invoices";
                }
            }
            group("Inventory and Costing")
            {
                Caption = 'Inventory & Costing';
                group("Inventory and Costing List")
                {
                    action("Fixed-Assets")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Fixed Assets';
                        RunObject = Page "Fixed Asset List";
                    }
                    action("Fixed Assets G/L Journals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Fixed Assets G/L Journals';
                        RunObject = Page "Fixed Asset G/L Journal";
                    }
                    action("Fixed Asset Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Fixed Asset Journal';
                        RunObject = Page "Fixed Asset Journal";
                    }
                    action("FA Reclass. Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'FA Reclass. Journal';
                        RunObject = Page "FA Reclass. Journal";
                    }
                    action("Insurance List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Insurance List';
                        RunObject = Page "Insurance List";
                    }
                    action("Insurance Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Insurance Journal';
                        RunObject = Page "Insurance Journal";
                    }
                    action("Recurring General Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Recurring General Journal';
                        RunObject = Page "Recurring General Journal";
                    }
                    action("Recurring FA Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Recurring Fixed Assets Journal';
                        RunObject = Page "Recurring Fixed Asset Journal";
                    }
                    // action("Nonstock Item List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Nonstock Item List';
                    //     //RunObject = page "Nonstock Item List";
                    // }
                }
                group("P Tasks")
                {
                    Caption = 'Tasks';
                    action("Item Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Journal';
                        RunObject = page "Item Journal";
                    }

                    action("Phys. Inventory Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Phys. Inventory Journal';
                        RunObject = page "Phys. Inventory Journal";
                    }
                    action("Revaluation Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Revaluation Journal';
                        RunObject = page "Revaluation Journal";
                    }
                    action("Item Reclass. Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Reclass. Journal';
                        RunObject = page "Item Reclass. Journal";
                    }
                    action("Recurring Item Jnl.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Recurring Item Jnl.';
                        RunObject = page "Recurring Item Jnl.";
                    }
                }
                group("Costing")
                {
                    Caption = 'Costing';
                    action("Standard Cost Worksheet")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Standard Cost Worksheet';
                        RunObject = page "Standard Cost Worksheet";
                    }
                }
                group("Store Keeping")
                {
                    Caption = 'Store Keeping';
                    action("Store Requisition")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Store Requisition';
                        RunObject = Page "Store Requisitions List";
                    }
                    action("Cancelled Store Req List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cancelled Store Req List';
                        RunObject = Page "Cancelled Store Req List";
                    }
                    action("Posted Store Req List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Store Req List';
                        RunObject = Page "Posted Store Requisitions List";
                    }

                    action("Stockkeeping Unit List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Stockkeeping Unit List';
                        RunObject = page "Stockkeeping Unit List";
                    }
                    action("Store Requisition Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Store Requisition Report';
                        RunObject = Report "Store Requisition";
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
            group("P Reports and Analysis")
            {
                Caption = 'Reports';
                group("Planning Reports")
                {
                    Caption = 'Planning';
                    action("Purchase Invoice Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Purchase Invoice Report';
                        RunObject = report "Purchase Invoice Report";

                    }
                    action("Purchase Order Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Purchase Order Report';
                        RunObject = report "Purchase Order";

                    }
                    action("Goods Receive Note")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Good Received Note';
                        RunObject = report "Goods Receive Note";
                    }

                    action("Items Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Items Report';
                        RunObject = report "Item Report";

                    }

                    action("Stock Inventory Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Stock Inventory Report';
                        RunObject = report InventoryStock;

                    }
                    action("Indivdual Usage Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Individual Usage Report';
                        RunObject = report "Individual Usage Report";

                    }
                    action("Disposal Requisition Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "Disposal Requisition Report";

                    }

                    action("Disposal Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Disposal Report';
                        RunObject = report "Disposal Report";

                    }
                    // action("Expenditure Report")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Expenditure Report';
                    //     RunObject = report "Total Expenditure";

                    // }
                    action("Expenditure Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Expenditure Report';
                        RunObject = Report "Store Requisition";
                    }
                    action("Trial Balance Report")
                    {
                        ApplicationArea = all;

                        RunObject = report "Vendor - Detail Trial Balance";
                    }
                    action("Vendor History Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Vendor History Report';
                        RunObject = report "Vendor History Report";
                    }

                    action("Vendor Payment Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Vendor Payment Report';
                        RunObject = report "Payment Voucher";
                    }
                    action("Vendor Payments")
                    {
                        ApplicationArea = all;
                        Caption = 'Vendor Payments Report';
                        RunObject = report "Vendor Payments";
                    }



                    action("Purchase Reservation Avail.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Reservation Avail.';
                        RunObject = report "Purchase Reservation Avail.";
                    }
                    action("Purchase Statistics")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Statistics';
                        RunObject = report "Purchase Statistics";
                    }
                    action("Vendor Item Catalog")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor Item Catalog';
                        RunObject = report "Vendor Item Catalog";
                    }
                    action("Vendor - Balance to Date")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Balance to Date';
                        RunObject = report "Vendor - Balance to Date";
                    }
                    action("Vendor - Detail Trial Balance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Detail Trial Balance';
                        RunObject = report "Vendor - Detail Trial Balance";
                    }
                    action("Vendor - List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - List';
                        RunObject = report "Vendor - List";
                    }
                    action("Vendor - Purchase List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Purchase List';
                        RunObject = report "Vendor - Purchase List";
                    }
                    action("Vendor - Summary Aging")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Summary Aging';
                        RunObject = report "Vendor - Summary Aging";
                    }
                    action("Vendor - Top 10 List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Top 10 List';
                        RunObject = report "Vendor - Top 10 List";
                    }
                    action("Vendor - Trial Balance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Trial Balance';
                        RunObject = report "Vendor - Trial Balance";
                    }
                    action("Vendor/Item Purchases")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor/Item Purchases';
                        RunObject = report "Vendor/Item Purchases";
                    }
                    action("Inventory Cost and Price List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Cost and Price List';
                        RunObject = report "Inventory Cost and Price List";
                    }
                    action("Inventory Purchase Orders")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Purchase Orders';
                        RunObject = report "Inventory Purchase Orders";
                    }
                    action("Inventory - Availability Plan")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - Availability Plan';
                        RunObject = report "Inventory - Availability Plan";
                    }
                    action("Inventory - Cost Variance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - Cost Variance';
                        RunObject = report "Inventory - Cost Variance";
                    }
                    action("Inventory - Inbound Transfer")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - Inbound Transfer';
                        RunObject = report "Inventory - Inbound Transfer";
                    }
                    action("Inventory - List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - List';
                        RunObject = report "Inventory - List";
                    }
                    action("Inventory - Vendor Purchases")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - Vendor Purchases';
                        RunObject = report "Inventory - Vendor Purchases";
                    }
                    action("Item Substitutions")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Substitutions';
                        RunObject = report "Item Substitutions";
                    }
                    action("Item/Vendor Catalog")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item/Vendor Catalog';
                        RunObject = report "Item/Vendor Catalog";
                    }
                    // action("Nonstock Item Sales")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Nonstock Item Sales';
                    //     //RunObject = report "Nonstock Item Sales";
                    // }
                    action("Prod. Order - Mat. Requisition")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Prod. Order - Mat. Requisition';
                        RunObject = report "Prod. Order - Mat. Requisition";
                    }
                    action("Prod. Order - Shortage List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Prod. Order - Shortage List';
                        RunObject = report "Prod. Order - Shortage List";
                    }
                }

                group("Order Processing Reports")
                {
                    Caption = 'Order Processing';
                    action("Vendor/Items Purchases")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor/Item Purchases';
                        RunObject = report "Vendor/Item Purchases";
                    }
                    action("Inventory Availability")
                    {
                        ApplicationArea = Suite, Basic;
                        Caption = 'Inventory Availability';
                        RunObject = report "Inventory Availability";
                    }
                    action("Inventory Cost and Prices List")
                    {
                        ApplicationArea = Suite, Basic;
                        Caption = 'Inventory Cost and Price List';
                        RunObject = report "Inventory Cost and Price List";
                    }
                    action("Inventory Posting - Test")
                    {
                        ApplicationArea = Suite, Basic;
                        Caption = 'Inventory Posting - Test';
                        RunObject = report "Inventory Posting - Test";
                    }
                    action("Inventory Purchases Orders")
                    {
                        ApplicationArea = Suite, Basic;
                        Caption = 'Inventory Purchase Orders';
                        RunObject = report "Inventory Purchase Orders";
                    }
                    action("Inventory-List")
                    {
                        ApplicationArea = Suite, Basic;
                        Caption = 'Inventory - List';
                        RunObject = report "Inventory - List";
                    }
                    action("Inventory - Reorders")
                    {
                        ApplicationArea = Suite, Basic;
                        Caption = 'Inventory - Reorders';
                        RunObject = report "Inventory - Reorders";
                    }
                    action("Inventory - Transaction Detail")
                    {
                        ApplicationArea = Suite, Basic;
                        Caption = 'Inventory - Transaction Detail';
                        RunObject = report "Inventory - Transaction Detail";
                    }
                    action("Inventory - Vendors Purchases")
                    {
                        ApplicationArea = Suite, Basic;
                        Caption = 'Inventory - Vendor Purchases';
                        RunObject = report "Inventory - Vendor Purchases";
                    }
                    action("Item Charges - Specification")
                    {
                        ApplicationArea = Suite, Basic;
                        Caption = 'Item Charges - Specification';
                        RunObject = report "Item Charges - Specification";
                    }
                    action("Items Substitutions")
                    {
                        ApplicationArea = Suite, Basic;
                        Caption = 'Item Substitutions';
                        RunObject = report "Item Substitutions";
                    }
                    action("Item/Vendors Catalog")
                    {
                        ApplicationArea = Suite, Basic;
                        Caption = 'Item/Vendor Catalog';
                        RunObject = report "Item/Vendor Catalog";
                    }
                }
                group("Inventory and Costing Reports")
                {
                    Caption = 'Inventrory and Costing';
                    action("Adjust Cost - Item Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Adjust Cost - Item Entries';
                        RunObject = report "Adjust Cost - Item Entries";
                    }
                    action("Adjust Item Costs/Prices")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Adjust Item Costs/Prices';
                        RunObject = report "Adjust Item Costs/Prices";
                    }
                    action("RInventory Availability")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Availability';
                        RunObject = report "Inventory Availability";
                    }
                    action("RInventory - Cost Variance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - Cost Variance';
                        RunObject = report "Inventory - Cost Variance";
                    }
                    action("RInventory - Inbound Transfer")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - Inbound Transfer';
                        RunObject = report "Inventory - Inbound Transfer";
                    }
                    action("RInventory - List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - List';
                        RunObject = report "Inventory - List";
                    }
                    action("Invt. Valuation - Cost Spec.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Invt. Valuation - Cost Spec.';
                        RunObject = report "Invt. Valuation - Cost Spec.";
                    }
                    action("Item Age Composition - Qty.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Age Composition - Qty.';
                        RunObject = report "Item Age Composition - Qty.";
                    }
                    action("Item Age Composition - Value")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Age Composition - Value';
                        RunObject = report "Item Age Composition - Value";
                    }
                    action("Item Expiration - Quantity")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Expiration - Quantity';
                        RunObject = report "Item Expiration - Quantity";
                    }
                    action("RItem Charges - Specification")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Charges - Specification';
                        RunObject = report "Item Charges - Specification";
                    }
                    action("Item Register - Quantity")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Register - Quantity';
                        RunObject = report "Item Register - Quantity";
                    }
                    action("Item Register - Value")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Register - Value';
                        RunObject = report "Item Register - Value";
                    }
                }

            }
            group("Procurement Setup")
            {
                Caption = 'Setup';
                group("Planning Setup")
                {
                    Caption = 'Planning';
                    action("Salespeople/Purchasers")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Salespeople/Purchasers';
                        RunObject = page "Salespersons/Purchasers";
                    }
                    action("Req. Worksheet Templates")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Req. Worksheet Templates';
                        RunObject = page "Req. Worksheet Templates";
                    }
                }
                group("Order Processing Setup")
                {
                    Caption = 'Order Processing';
                    action("Standard Purchase Codes")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Standard Purchase Codes';
                        RunObject = page "Standard Purchase Codes";
                    }
                    action("Purchasing Codes")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchasing Codes';
                        RunObject = page "Purchasing Codes";
                    }
                    action("Shipment Methods")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Shipment Methods';
                        RunObject = page "Shipment Methods";
                    }
                    action("Return Reasons")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Return Reasons';
                        RunObject = page "Return Reasons";
                    }
                    // action("Report Selection - Purchase ")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Report Selection - Purchase ';
                    //     //RunObject = page "Report Selection - Purchase ";
                    // }
                }
                group("Inventory and Costing Setup")
                {
                    Caption = 'Inventrory and Costing';
                    action("Units of Measure")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Units of Measure';
                        RunObject = page "Units of Measure";
                    }
                    action("Manufacturers")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Manufacturers';
                        RunObject = page "Manufacturers";
                    }
                    // action("Product Groups")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Product Groups';
                    //     //RunObject = page "Product Groups";
                    // }
                    // action("Nonstock Item Setup")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Nonstock Item Setup';
                    //     //RunObject = page "Nonstock Item Setup";
                    // }
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
        }

    }
}
profile "Procurement Role Center"
{
    Caption = 'Procurement Role Center';
    RoleCenter = Procurement;
    ProfileDescription = 'Procurement Role Center';
}

