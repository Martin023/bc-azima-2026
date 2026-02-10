// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52186172 pageextension52186172 extends "Accountant Portal Finance Cues" 
// {

//     //Unsupported feature: Property Modification (Name) on ""Accountant Portal Finance Cues"(Page 1315)".

//     Caption = 'Extended Text';

//     //Unsupported feature: Property Modification (SourceTable) on ""Accountant Portal Finance Cues"(Page 1315)".


//     //Unsupported feature: Property Modification (PageType) on ""Accountant Portal Finance Cues"(Page 1315)".


//     //Unsupported feature: Property Insertion (DataCaptionExpr) on ""Accountant Portal Finance Cues"(Page 1315)".


//     //Unsupported feature: Property Insertion (PopulateAllFields) on ""Accountant Portal Finance Cues"(Page 1315)".

//     layout
//     {
//         modify(OverduePurchaseDocumentsStyle)
//         {

//             //Unsupported feature: Property Modification (Name) on "OverduePurchaseDocumentsStyle(Control 4)".

//             ToolTip = 'Specifies whether the extended text will be available on finance charge memos.';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "OverduePurchaseDocumentsStyle(Control 4)".

//         }
//         modify(PurchaseDiscountsNextWeek)
//         {

//             //Unsupported feature: Property Modification (Level) on "PurchaseDiscountsNextWeek(Control 5)".


//             //Unsupported feature: Property Modification (ControlType) on "PurchaseDiscountsNextWeek(Control 5)".


//             //Unsupported feature: Property Modification (Name) on "PurchaseDiscountsNextWeek(Control 5)".

//             ToolTip = 'Specifies whether the extended text will be available on reminders.';

//             //Unsupported feature: Property Insertion (SourceExpr) on "PurchaseDiscountsNextWeek(Control 5)".

//             ApplicationArea = Basic;
//         }
//         modify(PurchaseDiscountsNextWeekStyle)
//         {

//             //Unsupported feature: Property Modification (Name) on "PurchaseDiscountsNextWeekStyle(Control 7)".

//             ToolTip = 'Specifies whether the text will be available on sales invoices.';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "PurchaseDiscountsNextWeekStyle(Control 7)".

//         }
//         modify(OverdueSalesDocuments)
//         {

//             //Unsupported feature: Property Modification (Name) on "OverdueSalesDocuments(Control 8)".

//             Caption = 'Sales';
//         }
//         modify(OverdueSalesDocumentsStyle)
//         {

//             //Unsupported feature: Property Modification (Name) on "OverdueSalesDocumentsStyle(Control 10)".

//             ToolTip = 'Specifies a date on which the text will no longer be used on the item, account, resource or standard text.';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "OverdueSalesDocumentsStyle(Control 10)".

//         }
//         modify(PurchaseDocumentsDueToday)
//         {

//             //Unsupported feature: Property Modification (Level) on "PurchaseDocumentsDueToday(Control 11)".


//             //Unsupported feature: Property Modification (ControlType) on "PurchaseDocumentsDueToday(Control 11)".


//             //Unsupported feature: Property Modification (Name) on "PurchaseDocumentsDueToday(Control 11)".

//             ToolTip = 'Specifies a date from which the text will be used on the item, account, resource or standard text.';

//             //Unsupported feature: Property Insertion (SourceExpr) on "PurchaseDocumentsDueToday(Control 11)".

//             ApplicationArea = Basic;
//         }
//         modify(PurchaseDocumentsDueTodayStyle)
//         {

//             //Unsupported feature: Property Modification (Name) on "PurchaseDocumentsDueTodayStyle(Control 13)".

//             ToolTip = 'Specifies whether the text should be used for all language codes. If a language code has been chosen in the Language Code field, it will be overruled by this function.';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "PurchaseDocumentsDueTodayStyle(Control 13)".

//         }
//         modify(VendorsPaymentsOnHold)
//         {

//             //Unsupported feature: Property Modification (Level) on "VendorsPaymentsOnHold(Control 14)".


//             //Unsupported feature: Property Modification (ControlType) on "VendorsPaymentsOnHold(Control 14)".


//             //Unsupported feature: Property Modification (Name) on "VendorsPaymentsOnHold(Control 14)".

//             ToolTip = 'Specifies the language code of the extended text.';

//             //Unsupported feature: Property Insertion (SourceExpr) on "VendorsPaymentsOnHold(Control 14)".

//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Modification (Level) on "VendorsPaymentsOnHoldStyle(Control 16)".


//         //Unsupported feature: Property Modification (ControlType) on "VendorsPaymentsOnHoldStyle(Control 16)".


//         //Unsupported feature: Property Modification (Name) on "VendorsPaymentsOnHoldStyle(Control 16)".


//         //Unsupported feature: Property Insertion (ContainerType) on "VendorsPaymentsOnHoldStyle(Control 16)".

//         modify(MyUserTaskStyle)
//         {

//             //Unsupported feature: Property Modification (Name) on "MyUserTaskStyle(Control 6)".

//             ToolTip = 'Specifies whether the text will be available on sales credit memos.';
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "MyUserTaskStyle(Control 6)".

//         }
//         modify(Control1)
//         {
//             Visible = false;
//         }
//         modify(OverduePurchaseDocuments)
//         {
//             Visible = false;
//         }
//         modify(OverduePurchaseDocumentsAmount)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (CaptionML) on "OverduePurchaseDocumentsStyle(Control 4)".


//         //Unsupported feature: Property Deletion (CaptionML) on "PurchaseDiscountsNextWeek(Control 5)".


//         //Unsupported feature: Property Deletion (GroupType) on "PurchaseDiscountsNextWeek(Control 5)".

//         modify(PurchaseDiscountsNextWeekAmount)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (CaptionML) on "PurchaseDiscountsNextWeekStyle(Control 7)".


//         //Unsupported feature: Property Deletion (GroupType) on "OverdueSalesDocuments(Control 8)".

//         modify(OverdueSalesDocumentsAmount)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (CaptionML) on "OverdueSalesDocumentsStyle(Control 10)".


//         //Unsupported feature: Property Deletion (CaptionML) on "PurchaseDocumentsDueToday(Control 11)".


//         //Unsupported feature: Property Deletion (GroupType) on "PurchaseDocumentsDueToday(Control 11)".

//         modify(PurchaseDocumentsDueTodayAmount)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (CaptionML) on "PurchaseDocumentsDueTodayStyle(Control 13)".


//         //Unsupported feature: Property Deletion (CaptionML) on "VendorsPaymentsOnHold(Control 14)".


//         //Unsupported feature: Property Deletion (GroupType) on "VendorsPaymentsOnHold(Control 14)".

//         modify(VendorsPaymentsOnHoldAmount)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (CaptionML) on "VendorsPaymentsOnHoldStyle(Control 16)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "VendorsPaymentsOnHoldStyle(Control 16)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "VendorsPaymentsOnHoldStyle(Control 16)".


//         //Unsupported feature: Property Deletion (SourceExpr) on "VendorsPaymentsOnHoldStyle(Control 16)".

//         modify(POsPendingApproval)
//         {
//             Visible = false;
//         }
//         modify(POsPendingApprovalAmount)
//         {
//             Visible = false;
//         }
//         modify(POsPendingApprovalStyle)
//         {
//             Visible = false;
//         }
//         modify(SOsPendingApproval)
//         {
//             Visible = false;
//         }
//         modify(SOsPendingApprovalAmount)
//         {
//             Visible = false;
//         }
//         modify(SOsPendingApprovalStyle)
//         {
//             Visible = false;
//         }
//         modify(ApprovedSalesOrders)
//         {
//             Visible = false;
//         }
//         modify(ApprovedSalesOrdersAmount)
//         {
//             Visible = false;
//         }
//         modify(ApprovedSalesOrdersStyle)
//         {
//             Visible = false;
//         }
//         modify(ApprovedPurchaseOrders)
//         {
//             Visible = false;
//         }
//         modify(ApprovedPurchaseOrdersAmount)
//         {
//             Visible = false;
//         }
//         modify(ApprovedPurchaseOrdersStyle)
//         {
//             Visible = false;
//         }
//         modify(PurchaseReturnOrders)
//         {
//             Visible = false;
//         }
//         modify(PurchaseReturnOrdersAmount)
//         {
//             Visible = false;
//         }
//         modify(PurchaseReturnOrdersStyle)
//         {
//             Visible = false;
//         }
//         modify(SalesReturnOrdersAll)
//         {
//             Visible = false;
//         }
//         modify(SalesReturnOrdersAllAmount)
//         {
//             Visible = false;
//         }
//         modify(SalesReturnOrdersAllStyle)
//         {
//             Visible = false;
//         }
//         modify(CustomersBlocked)
//         {
//             Visible = false;
//         }
//         modify(CustomersBlockedAmount)
//         {
//             Visible = false;
//         }
//         modify(CustomersBlockedStyle)
//         {
//             Visible = false;
//         }
//         modify(NewIncomingDocuments)
//         {
//             Visible = false;
//         }
//         modify(NewIncomingDocumentsAmount)
//         {
//             Visible = false;
//         }
//         modify(NewIncomingDocumentsStyle)
//         {
//             Visible = false;
//         }
//         modify(ApprovedIncomingDocuments)
//         {
//             Visible = false;
//         }
//         modify(ApprovedIncomingDocumentsAmount)
//         {
//             Visible = false;
//         }
//         modify(ApprovedIncomingDocumentsStyle)
//         {
//             Visible = false;
//         }
//         modify(OCRPending)
//         {
//             Visible = false;
//         }
//         modify(OCRPendingAmount)
//         {
//             Visible = false;
//         }
//         modify(OCRPendingStyle)
//         {
//             Visible = false;
//         }
//         modify(OCRCompleted)
//         {
//             Visible = false;
//         }
//         modify(OCRCompletedAmount)
//         {
//             Visible = false;
//         }
//         modify(OCRCompletedStyle)
//         {
//             Visible = false;
//         }
//         modify(RequestsToApprove)
//         {
//             Visible = false;
//         }
//         modify(RequestsToApproveAmount)
//         {
//             Visible = false;
//         }
//         modify(RequestsToApproveStyle)
//         {
//             Visible = false;
//         }
//         modify(RequestsSentForApproval)
//         {
//             Visible = false;
//         }
//         modify(RequestsSentForApprovalAmount)
//         {
//             Visible = false;
//         }
//         modify(RequestsSentForApprovalStyle)
//         {
//             Visible = false;
//         }
//         modify(CashAccountsBalance)
//         {
//             Visible = false;
//         }
//         modify(CashAccountsBalanceAmount)
//         {
//             Visible = false;
//         }
//         modify(CashAccountsBalanceStyle)
//         {
//             Visible = false;
//         }
//         modify(LastDepreciatedPostedDate)
//         {
//             Visible = false;
//         }
//         modify(LastDepreciatedPostedDateAmount)
//         {
//             Visible = false;
//         }
//         modify(LastDepreciatedPostedDateStyle)
//         {
//             Visible = false;
//         }
//         modify(LastLoginDate)
//         {
//             Visible = false;
//         }
//         modify(LastLoginDateAmount)
//         {
//             Visible = false;
//         }
//         modify(LastLoginDateStyle)
//         {
//             Visible = false;
//         }
//         modify(MyUserTask)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (CaptionML) on "MyUserTaskStyle(Control 6)".

//         addfirst(VendorsPaymentsOnHoldStyle)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//             }
//         }
//         addafter(PurchaseDocumentsDueTodayStyle)
//         {
//             field(Description;Description)
//             {
//                 ApplicationArea = Basic;
//                 ToolTip = 'Specifies the content of the extended item description.';
//             }
//         }
//         addafter(PurchaseDocumentsDueToday)
//         {
//             part(Control9;"Extended Text Lines")
//             {
//                 SubPageLink = "Table Name"=field("Table Name"),
//                               "No."=field("No."),
//                               "Language Code"=field("Language Code"),
//                               "Text No."=field("Text No.");
//             }
//         }
//         moveafter(;VendorsPaymentsOnHoldStyle)
//         moveafter(Control16;VendorsPaymentsOnHold)
//         moveafter("Language Code";PurchaseDocumentsDueTodayStyle)
//         moveafter("All Language Codes";PurchaseDocumentsDueToday)
//         moveafter("Starting Date";OverdueSalesDocumentsStyle)
//         moveafter("Ending Date";OverdueSalesDocuments)
//         moveafter(Sales;PurchaseDiscountsNextWeekStyle)
//         moveafter("Sales Invoice";MyUserTaskStyle)
//         moveafter("Sales Credit Memo";PurchaseDiscountsNextWeek)
//     }
// }

