// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52186991 pageextension52186991 extends "Order Processor Role Center" 
// {
//     Caption = 'Role Center';
//     layout
//     {

//         //Unsupported feature: Property Modification (Level) on "Control1901851508(Control 1901851508)".


//         //Unsupported feature: Property Modification (Level) on "Control1907692008(Control 1907692008)".


//         //Unsupported feature: Property Modification (Level) on "Control1(Control 1)".


//         //Unsupported feature: Property Modification (Level) on "Control4(Control 4)".


//         //Unsupported feature: Property Modification (Level) on "Control1905989608(Control 1905989608)".


//         //Unsupported feature: Property Modification (Level) on "Control21(Control 21)".


//         //Unsupported feature: Property Modification (Level) on "Control1901377608(Control 1901377608)".

//         modify(Control104)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control1901851508(Control 1901851508)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control1907692008(Control 1907692008)".

//         modify(Control14)
//         {
//             Visible = false;
//         }
//         modify(Control13)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control1(Control 1)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control4(Control 4)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905989608(Control 1905989608)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control21(Control 21)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control1901377608(Control 1901377608)".

//         addfirst(RoleCenter)
//         {
//             group(Control1900724808)
//             {
//             }
//         }
//         addafter(Control1907692008)
//         {
//             group(Control1900724708)
//             {
//             }
//         }
//         addfirst(Control21)
//         {
//             part(Control1903012608;"Copy Profile")
//             {
//                 Visible = false;
//             }
//         }
//     }
//     actions
//     {
//         modify(ActionContainer1900000011)
//         {
//             ToolTip = 'Manage sales processes. See KPIs and your favorite items and customers.';
//         }
//         modify(SalesOrders)
//         {

//             //Unsupported feature: Property Modification (Name) on "SalesOrders(Action 2)".

//             ApplicationArea = Basic;
//         }
//         modify(SalesOrdersShptNotInv)
//         {

//             //Unsupported feature: Property Modification (Name) on "SalesOrdersShptNotInv(Action 6)".

//             ApplicationArea = Basic;
//         }
//         modify(SalesOrdersComplShtNotInv)
//         {

//             //Unsupported feature: Property Modification (Name) on "SalesOrdersComplShtNotInv(Action 7)".

//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (RunPageView) on "SalesOrdersComplShtNotInv(Action 7)".

//         }
//         modify(Items)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Customers)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Item Journals")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(SalesJournals)
//         {

//             //Unsupported feature: Property Modification (Name) on "SalesJournals(Action 5)".

//             ApplicationArea = Basic;
//         }
//         modify(CashReceiptJournals)
//         {

//             //Unsupported feature: Property Modification (Name) on "CashReceiptJournals(Action 10)".

//             ApplicationArea = Basic;
//         }
//         modify("Transfer Orders")
//         {
//             Caption = 'Price &List';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (RunObject) on ""Transfer Orders"(Action 20)".


//             //Unsupported feature: Property Modification (Name) on ""Transfer Orders"(Action 20)".


//             //Unsupported feature: Property Insertion (Image) on ""Transfer Orders"(Action 20)".

//         }
//         modify("Sales Orders - Microsoft Dynamics 365 for Sales")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Sales Orders - Microsoft Dynamics 365 for Sales"(Action 25)".

//             Caption = 'Dynamics CRM Sales Orders';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Name) on ""Sales Orders - Microsoft Dynamics 365 for Sales"(Action 25)".

//         }

//         //Unsupported feature: Property Modification (Level) on "Vendors(Action 22)".


//         //Unsupported feature: Property Modification (ActionType) on "Vendors(Action 22)".


//         //Unsupported feature: Property Modification (Name) on "Vendors(Action 22)".

//         modify("Item Charges")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Item Charges"(Action 47)".

//             Caption = 'Customer/&Item Sales';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (RunObject) on ""Item Charges"(Action 47)".


//             //Unsupported feature: Property Modification (Name) on ""Item Charges"(Action 47)".


//             //Unsupported feature: Property Insertion (Image) on ""Item Charges"(Action 47)".

//         }
//         modify("Posted Documents")
//         {
//             ToolTip = 'View history for sales, shipments, and inventory.';
//         }
//         modify(Action32)
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Name) on "Action32(Action 32)".

//         }
//         modify(Action34)
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Name) on "Action34(Action 34)".

//         }
//         modify("Posted Return Receipts")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Action40)
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Name) on "Action40(Action 40)".

//         }
//         modify(Action54)
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Name) on "Action54(Action 54)".

//         }
//         modify(Action53)
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Name) on "Action53(Action 53)".

//         }

//         //Unsupported feature: Property Modification (Level) on ""Posted Transfer Shipments"(Action 17)".


//         //Unsupported feature: Property Modification (ActionType) on ""Posted Transfer Shipments"(Action 17)".


//         //Unsupported feature: Property Modification (Name) on ""Posted Transfer Shipments"(Action 17)".

//         modify("Posted Transfer Receipts")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Posted Transfer Receipts"(Action 19)".

//             Caption = 'Salesperson - Sales &Statistics';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (RunObject) on ""Posted Transfer Receipts"(Action 19)".


//             //Unsupported feature: Property Modification (Name) on ""Posted Transfer Receipts"(Action 19)".


//             //Unsupported feature: Property Insertion (Image) on ""Posted Transfer Receipts"(Action 19)".

//         }
//         modify(Service)
//         {

//             //Unsupported feature: Property Modification (Level) on "Service(Action 52)".


//             //Unsupported feature: Property Modification (Name) on "Service(Action 52)".

//             Caption = 'Sales Credit Memos';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (RunObject) on "Service(Action 52)".

//         }
//         modify(System)
//         {

//             //Unsupported feature: Property Modification (Level) on "System(Action 51)".


//             //Unsupported feature: Property Modification (Name) on "System(Action 51)".

//             Caption = 'Sales Return Orders';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (RunObject) on "System(Action 51)".


//             //Unsupported feature: Property Insertion (Image) on "System(Action 51)".

//         }
//         modify("Relationship Management")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Relationship Management"(Action 50)".


//             //Unsupported feature: Property Modification (Name) on ""Relationship Management"(Action 50)".

//             Caption = 'Sales Invoices';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (RunObject) on ""Relationship Management"(Action 50)".


//             //Unsupported feature: Property Insertion (Image) on ""Relationship Management"(Action 50)".

//         }
//         modify(Intercompany)
//         {

//             //Unsupported feature: Property Modification (Level) on "Intercompany(Action 49)".


//             //Unsupported feature: Property Modification (Name) on "Intercompany(Action 49)".

//             Caption = 'Blanket Sales Orders';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (RunObject) on "Intercompany(Action 49)".

//         }
//         modify("Service Connections")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Service Connections"(Action 24)".

//             Caption = 'Inventory - Sales &Back Orders';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (RunObject) on ""Service Connections"(Action 24)".


//             //Unsupported feature: Property Modification (Image) on ""Service Connections"(Action 24)".


//             //Unsupported feature: Property Modification (Name) on ""Service Connections"(Action 24)".

//         }
//         modify(Extensions)
//         {

//             //Unsupported feature: Property Modification (Level) on "Extensions(Action 11)".

//             Caption = 'Sales Quotes';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (RunObject) on "Extensions(Action 11)".


//             //Unsupported feature: Property Modification (Image) on "Extensions(Action 11)".


//             //Unsupported feature: Property Modification (Name) on "Extensions(Action 11)".

//         }
//         modify("Sales &Quote")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Image) on ""Sales &Quote"(Action 18)".

//         }
//         modify("Sales &Invoice")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Image) on ""Sales &Invoice"(Action 15)".

//         }
//         modify("Sales &Order")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Sales &Return Order")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Sales &Credit Memo")
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Modification (ActionType) on "Tasks(Action 35)".


//         //Unsupported feature: Property Modification (Name) on "Tasks(Action 35)".


//         //Unsupported feature: Property Insertion (IsHeader) on "Tasks(Action 35)".

//         modify("Sales &Journal")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Sales &Journal"(Action 36)".

//             ApplicationArea = Basic;
//         }
//         modify("Sales Price &Worksheet")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Sales Price &Worksheet"(Action 38)".

//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Modification (ActionType) on "ActionGroup42(Action 42)".


//         //Unsupported feature: Property Modification (Name) on "ActionGroup42(Action 42)".

//         modify("&Prices")
//         {

//             //Unsupported feature: Property Modification (Level) on ""&Prices"(Action 43)".

//             Caption = 'Sales &Prices';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Name) on ""&Prices"(Action 43)".

//         }
//         modify("&Line Discounts")
//         {

//             //Unsupported feature: Property Modification (Level) on ""&Line Discounts"(Action 44)".

//             Caption = 'Sales &Line Discounts';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Name) on ""&Line Discounts"(Action 44)".

//         }

//         //Unsupported feature: Property Modification (ActionType) on "History(Action 45)".


//         //Unsupported feature: Property Modification (Name) on "History(Action 45)".


//         //Unsupported feature: Property Insertion (IsHeader) on "History(Action 45)".

//         modify("Navi&gate")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Navi&gate"(Action 46)".

//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "SalesOrders(Action 2)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "SalesOrdersShptNotInv(Action 6)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "SalesOrdersComplShtNotInv(Action 7)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Items(Action 23)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Customers(Action 26)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Item Journals"(Action 3)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "SalesJournals(Action 5)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "CashReceiptJournals(Action 10)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer Orders"(Action 20)".

//         modify(ActionGroup76)
//         {
//             Visible = false;
//         }
//         modify(Action61)
//         {
//             Visible = false;
//         }
//         modify("Sales Quotes")
//         {
//             Visible = false;
//         }
//         modify("Sales Orders")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Orders - Microsoft Dynamics 365 for Sales"(Action 25)".

//         modify("Blanket Sales Orders")
//         {
//             Visible = false;
//         }
//         modify("Sales Invoices")
//         {
//             Visible = false;
//         }
//         modify("Sales Return Orders")
//         {
//             Visible = false;
//         }
//         modify("Sales Credit Memos")
//         {
//             Visible = false;
//         }
//         modify("Sales Journals")
//         {
//             Visible = false;
//         }
//         modify("Posted Sales Invoices")
//         {
//             Visible = false;
//         }
//         modify("Posted Sales Credit Memos")
//         {
//             Visible = false;
//         }
//         modify("Posted Sales Return Receipts")
//         {
//             Visible = false;
//         }
//         modify("Posted Sales Shipments")
//         {
//             Visible = false;
//         }
//         modify(Action68)
//         {
//             Visible = false;
//         }
//         modify(Reminders)
//         {
//             Visible = false;
//         }
//         modify("Finance Charge Memos")
//         {
//             Visible = false;
//         }
//         modify(ActionGroup63)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (CaptionML) on "Vendors(Action 22)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Vendors(Action 22)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Vendors(Action 22)".


//         //Unsupported feature: Property Deletion (RunObject) on "Vendors(Action 22)".


//         //Unsupported feature: Property Deletion (Promoted) on "Vendors(Action 22)".


//         //Unsupported feature: Property Deletion (Image) on "Vendors(Action 22)".


//         //Unsupported feature: Property Deletion (PromotedCategory) on "Vendors(Action 22)".

//         modify("Purchase Quotes")
//         {
//             Visible = false;
//         }
//         modify("Purchase Orders")
//         {
//             Visible = false;
//         }
//         modify("Blanket Purchase Orders")
//         {
//             Visible = false;
//         }
//         modify("Purchase Invoices")
//         {
//             Visible = false;
//         }
//         modify("Purchase Return Orders")
//         {
//             Visible = false;
//         }
//         modify("Purchase Credit Memos")
//         {
//             Visible = false;
//         }
//         modify(PurchaseJournals)
//         {
//             Visible = false;
//         }
//         modify("Posted Purchase Invoices")
//         {
//             Visible = false;
//         }
//         modify("Posted Purchase Credit Memos")
//         {
//             Visible = false;
//         }
//         modify("Posted Purchase Return Shipments")
//         {
//             Visible = false;
//         }
//         modify("Posted Purchase Receipts")
//         {
//             Visible = false;
//         }
//         modify(ActionGroup62)
//         {
//             Visible = false;
//         }
//         modify(Action93)
//         {
//             Visible = false;
//         }
//         modify(Action96)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Item Charges"(Action 47)".


//         //Unsupported feature: Property Deletion (Promoted) on ""Item Charges"(Action 47)".


//         //Unsupported feature: Property Deletion (PromotedCategory) on ""Item Charges"(Action 47)".

//         modify("Item Attributes")
//         {
//             Visible = false;
//         }
//         modify("Item Tracking")
//         {
//             Visible = false;
//         }
//         modify("Item Reclassification Journals")
//         {
//             Visible = false;
//         }
//         modify("Phys. Inventory Journals")
//         {
//             Visible = false;
//         }
//         modify("Assembly Orders")
//         {
//             Visible = false;
//         }
//         modify("Drop Shipments")
//         {
//             Visible = false;
//         }
//         modify(Locations)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Action32(Action 32)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Action34(Action 34)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Return Receipts"(Action 33)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Action40(Action 40)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Action54(Action 54)".

//         modify(Action86)
//         {
//             Visible = false;
//         }
//         modify(Action87)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Action53(Action 53)".


//         //Unsupported feature: Property Deletion (CaptionML) on ""Posted Transfer Shipments"(Action 17)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Transfer Shipments"(Action 17)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on ""Posted Transfer Shipments"(Action 17)".


//         //Unsupported feature: Property Deletion (RunObject) on ""Posted Transfer Shipments"(Action 17)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Transfer Receipts"(Action 19)".

//         modify("Issued Reminders")
//         {
//             Visible = false;
//         }
//         modify("Issued Finance Charge Memos")
//         {
//             Visible = false;
//         }
//         modify(SetupAndExtensions)
//         {
//             Visible = false;
//         }
//         modify("Assisted Setup")
//         {
//             Visible = false;
//         }
//         modify("Manual Setup")
//         {
//             Visible = false;
//         }
//         modify(General)
//         {
//             Visible = false;
//         }
//         modify(Finance)
//         {
//             Visible = false;
//         }
//         modify(Sales)
//         {
//             Visible = false;
//         }
//         modify(Purchasing)
//         {
//             Visible = false;
//         }
//         modify(Jobs)
//         {
//             Visible = false;
//         }
//         modify("Fixed Assets")
//         {
//             Visible = false;
//         }
//         modify(HR)
//         {
//             Visible = false;
//         }
//         modify(Inventory)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Service(Action 52)".


//         //Unsupported feature: Property Deletion (RunPageView) on "Service(Action 52)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "System(Action 51)".


//         //Unsupported feature: Property Deletion (RunPageView) on "System(Action 51)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Relationship Management"(Action 50)".


//         //Unsupported feature: Property Deletion (RunPageView) on ""Relationship Management"(Action 50)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Intercompany(Action 49)".


//         //Unsupported feature: Property Deletion (RunPageView) on "Intercompany(Action 49)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Service Connections"(Action 24)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Extensions(Action 11)".

//         modify(Workflows)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Quote"(Action 18)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Invoice"(Action 15)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Order"(Action 12)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Return Order"(Action 9)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Credit Memo"(Action 8)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Journal"(Action 36)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Price &Worksheet"(Action 38)".


//         //Unsupported feature: Property Deletion (CaptionML) on "ActionGroup42(Action 42)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""&Prices"(Action 43)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""&Line Discounts"(Action 44)".

//         modify(Reports)
//         {
//             Visible = false;
//         }
//         modify(Customer)
//         {
//             Visible = false;
//         }
//         modify("Customer - &Order Summary")
//         {
//             Visible = false;
//         }
//         modify("Customer - &Top 10 List")
//         {
//             Visible = false;
//         }
//         modify("Customer/&Item Sales")
//         {
//             Visible = false;
//         }
//         modify(ActionGroup31)
//         {
//             Visible = false;
//         }
//         modify("Salesperson - Sales &Statistics")
//         {
//             Visible = false;
//         }
//         modify("Price &List")
//         {
//             Visible = false;
//         }
//         modify("Inventory - Sales &Back Orders")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Navi&gate"(Action 46)".

//         addfirst(reporting)
//         {
//             action("Customer - &Order Summary")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Customer - &Order Summary';
//                 Image = "Report";
//                 RunObject = Report "Customer - Order Summary";
//             }
//             action("Customer - &Top 10 List")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Customer - &Top 10 List';
//                 Image = "Report";
//                 RunObject = Report "Customer - Top 10 List";
//             }
//         }
//         moveafter(;"Item Charges")
//         moveafter("Customer/&Item Sales";"Posted Transfer Shipments")
//         moveafter("Salesperson - Sales &Statistics";"Transfer Orders")
//         moveafter("Price &List";Vendors)
//         moveafter(Action22;"Service Connections")
//         moveafter("Completely Shipped Not Invoiced";"Sales Orders - Microsoft Dynamics 365 for Sales")
//         moveafter("Dynamics CRM Sales Orders";Extensions)
//         moveafter("Sales Quotes";Intercompany)
//         moveafter("Blanket Sales Orders";"Relationship Management")
//         moveafter("Sales Invoices";System)
//         moveafter("Sales Return Orders";Service)
//         moveafter("Posted Documents";Action40)
//         moveafter("Posted Sales Invoices";"Posted Return Receipts")
//         moveafter("Posted Sales Credit Memos";Action53)
//     }
// }

