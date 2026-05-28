page 52187326 "Procurement Role Center"
{
    Caption = 'Procurement Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(CustomHeadline; CustomHeadline)
            {
                ApplicationArea = Basic, Suite;
            }
            part("Procurement Cue Page"; "Procurement Cue Page")
            {
                Caption = 'Activities';
                ApplicationArea = Basic;
            }
            part("Emails"; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
            systempart(Control1901377608; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        area(Sections)
        {
            group("Planning")
            {
                Caption = 'Planning';
                group("Procurememnt Order Planning")
                {
                    Caption = 'Order Planning';
                    action("Order Planning")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Order Planning';
                        RunObject = page "G/L Budget Names";
                    }
                }
                group("Planning Administration")
                {
                    Caption = 'Administration';
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
            }
            group("Order Processing")
            {
                Caption = 'Order Processing';
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
                    //     RunObject = page "ADM Registration List";
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
                    action("Posted Purchase Receipts")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Good Received Note';
                        RunObject = page "Posted Purchase Receipts";
                    }
                    action("Sales Invoice List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Invoice List';
                        RunObject = page "Sales Invoice List";
                    }
                    action("Transfer List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Transfer Orders';
                        RunObject = page "Transfer Orders";
                    }
                    action("Purchase Quotes")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Quotes';
                        RunObject = page "Purchase Quotes";
                    }
                    action("Sales Quotes")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Disposal Requisition';
                        RunObject = page "Sales Quotes";
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
                group("Administration")
                {
                    Caption = 'Administration';
                    action("Subcontracting Worksheet")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Subcontracting Worksheet';
                        RunObject = page "Subcontracting Worksheet";
                    }
                }
            }
            group("Inventory and Costing")
            {
                Caption = 'Inventory & Costing';
                group("Inventory and Costing List")
                {
                    // action("Nonstock Item List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Nonstock Item List';
                    //     RunObject = page "Nonstock Item List";
                    // }
                    action("Stockkeeping Unit List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Stockkeeping Unit List';
                        RunObject = page "Stockkeeping Unit List";
                    }
                }
                group("Tasks")
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

            }
            group("Reports and Analysis")
            {
                Caption = 'Reports and Analysis';
                group("Planning Reports")
                {
                    Caption = 'Planning';

                    // action("Purchase Invoice Report")
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Purchase Invoice Report';
                    //     RunObject = report "Purchase Invoice Report";

                    // }
                    action("Purchase Order Report")
                    {
                        ApplicationArea = all;
                        Caption = 'Purchase Order Report';
                        RunObject = report "Purchase Order";

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
                    // action("Vendor - List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Vendor - List';
                    //     RunObject = report "Vendor - List";
                    // }
                    action("Vendor - Purchase List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Purchase List';
                        RunObject = report "Vendor - Purchase List";
                    }
                    // action("Vendor - Summary Aging")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Vendor - Summary Aging';
                    //     RunObject = report "Vendor - Summary Aging";
                    // }
                    // action("Vendor - Top 10 List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Vendor - Top 10 List';
                    //     RunObject = report "Vendor - Top 10 List";
                    // }
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
                    // action("Inventory - Availability Plan")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Inventory - Availability Plan';
                    //     RunObject = report "Inventory - Availability Plan";
                    // }
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
                    //     RunObject = report "Nonstock Item Sales";
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
                    // action("Item Age Composition - Qty.")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Item Age Composition - Qty.';
                    //     RunObject = report "Item Age Composition - Qty.";
                    // }
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
                    action("Report Selection - Purchase ")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Report Selection - Purchase ';
                        //RunObject = page "Report Selection - Purchase ";
                    }
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
                    //     RunObject = page "Product Groups";
                    // }
                    // action("Nonstock Item Setup")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'Nonstock Item Setup';
                    //     //RunObject = page "Nonstock Item Setup";
                    // }
                }
            }

        }
    }
}
