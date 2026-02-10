// page 52186137 "Contract Purchase Order"
// {
//     Caption = 'Contract Purchase Order';
//     PageType = Document;
//     PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval';
//     RefreshOnActivate = true;
//     SourceTable = "Purchase Header";

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No."; Rec."No.")
//                 {
//                     Importance = Promoted;
//                     //Visible = DocNoVisible;

//                     trigger OnAssistEdit()
//                     begin
//                         if Rec.AssistEdit(xRec) then
//                             CurrPage.Update;
//                     end;
//                 }
//                 field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
//                 {
//                     Importance = Promoted;
//                     ShowMandatory = true;

//                     trigger OnValidate()
//                     begin
//                         rec.BuyfromVendorNoOnAfterValidate;
//                     end;
//                 }
//                 field("Buy-from Contact No."; Rec."Buy-from Contact No.")
//                 {
//                 }
//                 field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
//                 {
//                 }
//                 field("Buy-from Address"; Rec."Buy-from Address")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Buy-from Address 2"; Rec."Buy-from Address 2")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Buy-from Post Code"; Rec."Buy-from Post Code")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Buy-from City"; Rec."Buy-from City")
//                 {
//                 }
//                 field("Buy-from Contact"; Rec."Buy-from Contact")
//                 {
//                     Importance = Additional;
//                 }
//                 field("No. of Archived Versions"; Rec."No. of Archived Versions")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Posting Date"; Rec."Posting Date")
//                 {
//                 }
//                 field("Order Date"; Rec."Order Date")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Document Date"; Rec."Document Date")
//                 {
//                 }
//                 field("Quote No."; Rec."Quote No.")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Contract No."; Rec."Contract No.")
//                 {
//                 }
//                 field("Vendor Order No."; Rec."Vendor Order No.")
//                 {
//                 }
//                 field("Vendor Shipment No."; Rec."Vendor Shipment No.")
//                 {
//                 }
//                 field("Vendor Invoice No."; Rec."Vendor Invoice No.")
//                 {
//                     ShowMandatory = VendorInvoiceNoMandatory;
//                 }
//                 field("Order Address Code"; Rec."Order Address Code")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Purchaser Code"; Rec."Purchaser Code")
//                 {

//                     trigger OnValidate()
//                     begin
//                         rec.PurchaserCodeOnAfterValidate;
//                     end;
//                 }
//                 field("Responsibility Center"; Rec."Responsibility Center")
//                 {
//                 }
//                 field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
//                 {

//                     trigger OnValidate()
//                     begin
//                         ShortcutDimension1CodeOnAfterV;
//                     end;
//                 }
//                 field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
//                 {

//                     trigger OnValidate()
//                     begin
//                         rec.ShortcutDimension2CodeOnAfterV;
//                     end;
//                 }
//                 field("Assigned User ID"; Rec."Assigned User ID")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Job Queue Status"; Rec."Job Queue Status")
//                 {
//                     Importance = Additional;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Posting Description"; Rec."Posting Description")
//                 {
//                 }
//                 field("Receiving No. Series"; Rec."Receiving No. Series")
//                 {
//                 }
//             }
//             part(PurchLines; "Contract Order Subform")
//             {
//                 SubPageLink = "Document No." = FIELD("No.");
//                 UpdatePropagation = Both;
//             }
//             group(Invoicing)
//             {
//                 Caption = 'Invoicing';
//                 field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
//                 {
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         PaytoVendorNoOnAfterValidate;
//                     end;
//                 }
//                 field("Pay-to Contact No."; Rec."Pay-to Contact No.")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Pay-to Name"; Rec."Pay-to Name")
//                 {
//                 }
//                 field("Pay-to Address"; Rec."Pay-to Address")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Pay-to Address 2"; Rec."Pay-to Address 2")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Pay-to Post Code"; Rec."Pay-to Post Code")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Pay-to City"; Rec."Pay-to City")
//                 {
//                 }
//                 field("Pay-to Contact"; Rec."Pay-to Contact")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Payment Terms Code"; Rec."Payment Terms Code")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Due Date"; Rec."Due Date")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Payment Discount %"; Rec."Payment Discount %")
//                 {
//                 }
//                 field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Payment Method Code"; Rec."Payment Method Code")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Payment Reference"; Rec."Payment Reference")
//                 {
//                 }
//                 field("Creditor No."; Rec."Creditor No.")
//                 {
//                 }
//                 field("On Hold"; Rec."On Hold")
//                 {
//                 }
//                 field("Prices Including VAT"; Rec."Prices Including VAT")
//                 {

//                     trigger OnValidate()
//                     begin
//                         PricesIncludingVATOnAfterValid;
//                     end;
//                 }
//                 field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
//                 {
//                 }
//             }
//             group(Shipping)
//             {
//                 Caption = 'Shipping';
//                 field("Ship-to Name"; Rec."Ship-to Name")
//                 {
//                 }
//                 field("Ship-to Address"; Rec."Ship-to Address")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Ship-to Address 2"; Rec."Ship-to Address 2")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Ship-to Post Code"; Rec."Ship-to Post Code")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Ship-to City"; Rec."Ship-to City")
//                 {
//                 }
//                 field("Ship-to Contact"; Rec."Ship-to Contact")
//                 {
//                 }
//                 field("Location Code"; Rec."Location Code")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Shipment Method Code"; Rec."Shipment Method Code")
//                 {
//                 }
//                 field("Lead Time Calculation"; Rec."Lead Time Calculation")
//                 {
//                     Importance = Additional;
//                 }
//                 field("Requested Receipt Date"; Rec."Requested Receipt Date")
//                 {
//                 }
//                 field("Promised Receipt Date"; Rec."Promised Receipt Date")
//                 {
//                 }
//                 field("Expected Receipt Date"; Rec."Expected Receipt Date")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Sell-to Customer No."; Rec."Sell-to Customer No.")
//                 {
//                 }
//                 field("Ship-to Code"; Rec."Ship-to Code")
//                 {
//                 }
//             }
//             group("Foreign Trade")
//             {
//                 Caption = 'Foreign Trade';
//                 field("Currency Code"; Rec."Currency Code")
//                 {
//                     Importance = Promoted;

//                     trigger OnAssistEdit()
//                     begin
//                         Clear(ChangeExchangeRate);
//                         if Rec."Posting Date" <> 0D then
//                             ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date")
//                         else
//                             ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WorkDate);
//                         if ChangeExchangeRate.RunModal = ACTION::OK then begin
//                             Rec.Validate(Rec."Currency Factor", ChangeExchangeRate.GetParameter);
//                             CurrPage.Update;
//                         end;
//                         Clear(ChangeExchangeRate);
//                     end;

//                     trigger OnValidate()
//                     begin
//                         CurrPage.Update;
//                         PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
//                     end;
//                 }
//                 field("Transaction Type"; Rec."Transaction Type")
//                 {
//                 }
//                 field("Transaction Specification"; Rec."Transaction Specification")
//                 {
//                 }
//                 field("Transport Method"; Rec."Transport Method")
//                 {
//                 }
//                 field("Entry Point"; Rec."Entry Point")
//                 {
//                 }
//                 field("Area"; Rec.Area)
//                 {
//                 }
//             }
//             group(Prepayment)
//             {
//                 Caption = 'Prepayment';
//                 field("Prepayment %"; Rec."Prepayment %")
//                 {
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         Prepayment37OnAfterValidate;
//                     end;
//                 }
//                 field("Compress Prepayment"; Rec."Compress Prepayment")
//                 {
//                 }
//                 field("Prepmt. Payment Terms Code"; Rec."Prepmt. Payment Terms Code")
//                 {
//                 }
//                 field("Prepayment Due Date"; Rec."Prepayment Due Date")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Prepmt. Payment Discount %"; Rec."Prepmt. Payment Discount %")
//                 {
//                 }
//                 field("Prepmt. Pmt. Discount Date"; Rec."Prepmt. Pmt. Discount Date")
//                 {
//                 }
//                 field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
//                 {
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             part(Control23; "Pending Approval FactBox")
//             {
//                 SubPageLink = "Table ID" = CONST(38),
//                               "Document Type" = FIELD("Document Type"),
//                               "Document No." = FIELD("No.");
//                 Visible = OpenApprovalEntriesExistForCurrUser;
//             }
//             part(Control1903326807; "Item Replenishment FactBox")
//             {
//                 Provider = PurchLines;
//                 SubPageLink = "No." = FIELD("No.");
//                 Visible = false;
//             }
//             part(Control1906354007; "Approval FactBox")
//             {
//                 SubPageLink = "Table ID" = CONST(38),
//                               "Document Type" = FIELD("Document Type"),
//                               "Document No." = FIELD("No.");
//                 Visible = false;
//             }
//             part(Control1901138007; "Vendor Details FactBox")
//             {
//                 SubPageLink = "No." = FIELD("Buy-from Vendor No.");
//                 Visible = false;
//             }
//             part(Control1904651607; "Vendor Statistics FactBox")
//             {
//                 SubPageLink = "No." = FIELD("Pay-to Vendor No.");
//                 Visible = true;
//             }
//             part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
//             {
//                 ShowFilter = false;
//                 Visible = false;
//             }
//             part(Control1903435607; "Vendor Hist. Buy-from FactBox")
//             {
//                 SubPageLink = "No." = FIELD("Buy-from Vendor No.");
//                 Visible = true;
//             }
//             part(Control1906949207; "Vendor Hist. Pay-to FactBox")
//             {
//                 SubPageLink = "No." = FIELD("Pay-to Vendor No.");
//                 Visible = false;
//             }
//             part(Control3; "Purchase Line FactBox")
//             {
//                 Provider = PurchLines;
//                 SubPageLink = "Document Type" = FIELD("Document Type"),
//                               "Document No." = FIELD("Document No."),
//                               "Line No." = FIELD("Line No.");
//             }
//             part(WorkflowStatus; "Workflow Status FactBox")
//             {
//                 Editable = false;
//                 Enabled = false;
//                 ShowFilter = false;
//                 Visible = ShowWorkflowStatus;
//             }
//             systempart(Control1900383207; Links)
//             {
//                 Visible = false;
//             }
//             systempart(Control1905767507; Notes)
//             {
//                 Visible = true;
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("O&rder")
//             {
//                 Caption = 'O&rder';
//                 Image = "Order";
//                 action(Dimensions)
//                 {
//                     AccessByPermission = TableData Dimension = R;
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     Promoted = false;
//                     //The property 'PromotedIsBig' can only be set if Rec.the property 'Promoted' is set to 'true'
//                     //PromotedIsBig = false;
//                     ShortCutKey = 'Shift+Ctrl+D';

//                     trigger OnAction()
//                     begin
//                         Rec.ShowDocDim;
//                         CurrPage.SaveRecord;
//                     end;
//                 }
//                 action(Statistics)
//                 {
//                     Caption = 'Statistics';
//                     Image = Statistics;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'F7';

//                     trigger OnAction()
//                     begin
//                         Rec.OpenPurchaseOrderStatistics;
//                         PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
//                     end;
//                 }
//                 action(Card)
//                 {
//                     Caption = 'Card';
//                     Image = EditLines;
//                     Promoted = false;
//                     //The property 'PromotedIsBig' can only be set if Rec.the property 'Promoted' is set to 'true'
//                     //PromotedIsBig = false;
//                     RunObject = Page "Vendor Card";
//                     RunPageLink = "No." = FIELD("Buy-from Vendor No.");
//                     ShortCutKey = 'Shift+F7';
//                 }
//                 action(Approvals)
//                 {
//                     Caption = 'Approvals';
//                     Image = Approvals;

//                     trigger OnAction()
//                     var
//                     //// //ApprovalEntries: Page "Approval Entries";
//                     begin
//                         //ApprovalEntries.SetRecordFilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");
//                         //ApprovalEntries.Run;
//                     end;
//                 }
//                 action("Co&mments")
//                 {
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page 66;
//                     RunPageLink = "Document Type" = FIELD("Document Type"),
//                                   "No." = FIELD("No."),
//                                   "Document Line No." = CONST(0);
//                 }
//             }
//             group(Documents)
//             {
//                 Caption = 'Documents';
//                 Image = Documents;
//                 action(Receipts)
//                 {
//                     Caption = 'Receipts';
//                     Image = PostedReceipts;
//                     RunObject = Page "Posted Purchase Receipts";
//                     RunPageLink = "Order No." = FIELD("No.");
//                     RunPageView = SORTING("Order No.");
//                 }
//                 action(Invoices)
//                 {
//                     Caption = 'Invoices';
//                     Image = Invoice;
//                     Promoted = false;
//                     //The property 'PromotedIsBig' can only be set if Rec.the property 'Promoted' is set to 'true'
//                     //PromotedIsBig = false;
//                     RunObject = Page 146;
//                     RunPageLink = "Order No." = FIELD("No.");
//                     RunPageView = SORTING("Order No.");
//                 }
//                 action("Prepa&yment Invoices")
//                 {
//                     Caption = 'Prepa&yment Invoices';
//                     Image = PrepaymentInvoice;
//                     RunObject = Page 146;
//                     RunPageLink = "Prepayment Order No." = FIELD("No.");
//                     RunPageView = SORTING("Prepayment Order No.");
//                 }
//                 action("Prepayment Credi&t Memos")
//                 {
//                     Caption = 'Prepayment Credi&t Memos';
//                     Image = PrepaymentCreditMemo;
//                     RunObject = Page 147;
//                     RunPageLink = "Prepayment Order No." = FIELD("No.");
//                     RunPageView = SORTING("Prepayment Order No.");
//                 }
//             }
//             group(Warehouse)
//             {
//                 Caption = 'Warehouse';
//                 Image = Warehouse;
//                 separator(Action181)
//                 {
//                 }
//                 action("In&vt. Put-away/Pick Lines")
//                 {
//                     Caption = 'In&vt. Put-away/Pick Lines';
//                     Image = PickLines;
//                     RunObject = Page 5774;
//                     RunPageLink = "Source Document" = CONST("Purchase Order"),
//                                   "Source No." = FIELD("No.");
//                     RunPageView = SORTING("Source Document", "Source No.", "Location Code");
//                 }
//                 action(7342)
//                 {
//                     Caption = 'Whse. Receipt Lines';
//                     Image = ReceiptLines;
//                     RunObject = Page 7342;
//                                     RunPageLink = "Source Type" = CONST(39),
//                                   "Source Subtype" = FIELD("Document Type"),
//                                   "Source No." = FIELD("No.");
//                     RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
//                 }
//                 separator(Action182)
//                 {
//                 }
//                 group("Dr&op Shipment")
//                 {
//                     Caption = 'Dr&op Shipment';
//                     Image = Delivery;
//                     action("Get &Sales Order")
//                     {
//                         Caption = 'Get &Sales Order';
//                         Image = "Order";
//                         RunObject = Codeunit 76;
//                     }
//                 }
//                 group("Speci&al Order")
//                 {
//                     Caption = 'Speci&al Order';
//                     Image = SpecialOrder;
//                     action(Action228)
//                     {
//                         AccessByPermission = TableData "Sales Shipment Header" = R;
//                         Caption = 'Get &Sales Order';
//                         Image = "Order";

//                         trigger OnAction()
//                         var
//                             PurchHeader: Record "Purchase Header";
//                             DistIntegration: Codeunit 5702;
//                         begin
//                             PurchHeader.Copy(Rec);
//                             DistIntegration.GetSpecialOrders(PurchHeader);
//                             Rec := PurchHeader;
//                         end;
//                     }
//                 }
//             }
//         }
//         area(processing)
//         {
//             group(Approval)
//             {
//                 Caption = 'Approval';
//                 action(Approve)
//                 {
//                     Caption = 'Approve';
//                     Image = Approve;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit 1535;
//                     begin
//            //              ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
//                     end;
//                 }
//                 action(Reject)
//                 {
//                     Caption = 'Reject';
//                     Image = Reject;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         // ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
//                     end;
//                 }
//                 action(Delegate)
//                 {
//                     Caption = 'Delegate';
//                     Image = Delegate;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
//                     end;
//                 }
//                 action(Comment)
//                 {
//                     Caption = 'Comments';
//                     Image = ViewComments;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     RunObject = Page 660;
//                                     RunPageLink = "Table ID" = CONST(38),
//                                   "Document Type" = FIELD("Document Type"),
//                                   "Document No." = FIELD("No.");
//                     Visible = OpenApprovalEntriesExistForCurrUser;
//                 }
//             }
//             group(Action13)
//             {
//                 Caption = 'Release';
//                 Image = ReleaseDoc;
//                 separator(Action73)
//                 {
//                 }
//                 action(Release)
//                 {
//                     Caption = 'Re&lease';
//                     Image = ReleaseDoc;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     ShortCutKey = 'Ctrl+F9';

//                     trigger OnAction()
//                     var
//                         ReleasePurchDoc: Codeunit 415;
//                     begin
//                         ReleasePurchDoc.PerformManualRelease(Rec);
//                     end;
//                 }
//                 action(Reopen)
//                 {
//                     Caption = 'Re&open';
//                     Image = ReOpen;

//                     trigger OnAction()
//                     var
//                         ReleasePurchDoc: Codeunit 415;
//                     begin
//                         ReleasePurchDoc.PerformManualReopen(Rec);
//                     end;
//                 }
//                 separator(Action611)
//                 {
//                 }
//             }
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 Image = "Action";
//                 action(CalculateInvoiceDiscount)
//                 {
//                     AccessByPermission = TableData "Vendor Invoice Disc." = R;
//                     Caption = 'Calculate &Invoice Discount';
//                     Image = CalculateInvoiceDiscount;

//                     trigger OnAction()
//                     begin
//                         ApproveCalcInvDisc;
//                         PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
//                     end;
//                 }
//                 separator(Action190)
//                 {
//                 }
//                 action("Get St&d. Vend. Purchase Codes")
//                 {
//                     Caption = 'Get St&d. Vend. Purchase Codes';
//                     Ellipsis = true;
//                     Image = VendorCode;

//                     trigger OnAction()
//                     var
//                         StdVendPurchCode: Record "Standard Vendor Purchase Code";
//                     begin
//                         StdVendPurchCode.InsertPurchLines(Rec);
//                     end;
//                 }
//                 separator(Action75)
//                 {
//                 }
//                 action(CopyDocument)
//                 {
//                     Caption = 'Copy Document';
//                     Ellipsis = true;
//                     Image = CopyDocument;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                         CopyPurchDoc.SetPurchHeader(Rec);
//                         CopyPurchDoc.RunModal;
//                         Clear(CopyPurchDoc);
//                     end;
//                 }
//                 action("Move Negative Lines")
//                 {
//                     Caption = 'Move Negative Lines';
//                     Ellipsis = true;
//                     Image = MoveNegativeLines;

//                     trigger OnAction()
//                     begin
//                         Clear(MoveNegPurchLines);
//                         MoveNegPurchLines.SetPurchHeader(Rec);
//                         MoveNegPurchLines.RunModal;
//                         MoveNegPurchLines.ShowDocument;
//                     end;
//                 }
//                 action("Check Budget Availability")
//                 {
//                     Image = Balance;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     var
//                         Doctype: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash,PurchInvoice,StaffClaim,StaffAdvance;
//                         PurchaseLine: Record "Purchase Line";
//                         RequisitionLine: Record "Purchase Line";
//                         CommittmentLine: Record Committment;
//                     begin
//                         Rec.TestField(Rec.Status, Rec.Status::Open);

//                         BCSetup.Get;
//                         if not BCSetup.Mandatory then
//                             exit;

//                         if Rec.Status = Rec.Status::Released then
//                             Error('This document has already been released. This functionality is available for open documents only');

//                         PurchaseLine.Reset;
//                         PurchaseLine.SetRange("Document No.", Rec."No.");
//                         PurchaseLine.SetFilter("Requisition No", '<>%1', '');
//                         if PurchaseLine.FindSet then
//                             repeat
//                                 CommittmentLine.Reset;
//                                 CommittmentLine.SetRange(CommittmentLine."Document No.", PurchaseLine."Requisition No");
//                                 CommittmentLine.SetRange(CommittmentLine."Document Line No.", PurchaseLine."Requisition Line No.");
//                                 CommittmentLine.SetRange(CommittmentLine.Committed, false);
//                                 if not CommittmentLine.FindFirst then
//                                     Commitment.ReverseEntries(Doctype::Requisition, PurchaseLine."Requisition No");
//                             until PurchaseLine.Next = 0;
//                         if SomeLinesCommitted then begin
//                             if not Confirm('Some or All the Lines Are already Committed do you want to continue', true, Rec."Document Type") then
//                                 Error('Budget Availability Check and Commitment Aborted');
//                             DeleteCommitment.Reset;
//                             DeleteCommitment.SetRange(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::LPO);
//                             DeleteCommitment.SetRange(DeleteCommitment."Document No.", Rec."No.");
//                             DeleteCommitment.DeleteAll;
//                         end;
//                         Commitment.CheckPurchase(Rec);
//                         Message('Budget Availability Checking Complete');
//                     end;
//                 }
//                 action("Cancel Budget Commitment")
//                 {
//                     Image = CancelAllLines;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     var
//                         PurchLine: Record "Purchase Line";
//                     begin
//                         Rec.TestField(Rec.Status, Rec.Status::Open);

//                         if not Confirm('Are you sure you want to Cancel All Commitments Done for this document', true, Rec."Document Type") then
//                             Error('Budget Availability Check and Commitment Aborted');

//                         DeleteCommitment.Reset;
//                         DeleteCommitment.SetRange(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::LPO);
//                         DeleteCommitment.SetRange(DeleteCommitment."Document No.", Rec."No.");
//                         DeleteCommitment.DeleteAll;
//                         //Tag all the Purchase Line entries as Uncommitted
//                         PurchLine.Reset;
//                         PurchLine.SetRange(PurchLine."Document Type", Rec."Document Type");
//                         PurchLine.SetRange(PurchLine."Document No.", Rec."No.");
//                         if PurchLine.Find('-') then begin
//                             repeat
//                                 PurchLine.Committed := false;
//                                 PurchLine.Modify;
//                             until PurchLine.Next = 0;
//                         end;

//                         Message('Commitments Cancelled Successfully for Doc. No %1', Rec."No.");
//                     end;
//                 }
//                 group(Action225)
//                 {
//                     Caption = 'Dr&op Shipment';
//                     Image = Delivery;
//                     action(Action184)
//                     {
//                         Caption = 'Get &Sales Order';
//                         Image = "Order";
//                         RunObject = Codeunit 76;
//                     }
//                 }
//                 group(Action186)
//                 {
//                     Caption = 'Speci&al Order';
//                     Image = SpecialOrder;
//                     action(Action187)
//                     {
//                         AccessByPermission = TableData "Sales Shipment Header" = R;
//                         Caption = 'Get &Sales Order';
//                         Image = "Order";

//                         trigger OnAction()
//                         var
//                             DistIntegration: Codeunit 5702;
//                             PurchHeader: Record "Purchase Header";
//                         begin
//                             PurchHeader.Copy(Rec);
//                             DistIntegration.GetSpecialOrders(PurchHeader);
//                             Rec := PurchHeader;
//                         end;
//                     }
//                 }
//                 action("Archive Document")
//                 {
//                     Caption = 'Archi&ve Document';
//                     Image = Archive;

//                     trigger OnAction()
//                     begin
//                         ArchiveManagement.ArchivePurchDocument(Rec);
//                         CurrPage.Update(false);
//                     end;
//                 }
//                 action("Send IC Purchase Order")
//                 {
//                     AccessByPermission = TableData "IC G/L Account" = R;
//                     Caption = 'Send IC Purchase Order';
//                     Image = IntercompanyOrder;

//                     trigger OnAction()
//                     var
//                         ICInOutboxMgt: Codeunit 427;
//                         ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
//                             ICInOutboxMgt.SendPurchDoc(Rec, false);
//                     end;
//                 }
//                 separator(Action189)
//                 {
//                 }
//                 group(IncomingDocument)
//                 {
//                     Caption = 'Incoming Document';
//                     Image = Documents;
//                     action(IncomingDocCard)
//                     {
//                         Caption = 'View Incoming Document';
//                         Enabled = HasIncomingDocument;
//                         Image = ViewOrder;
//                         //The property 'ToolTip' cannot be empty.
//                         //ToolTip = '';

//                         trigger OnAction()
//                         var
//                             IncomingDocument: Record "Incoming Document";
//                         begin
//                             IncomingDocument.ShowCardFromEntryNo(Rec."Incoming Document Entry No.");
//                         end;
//                     }
//                     action(SelectIncomingDoc)
//                     {
//                         AccessByPermission = TableData "Incoming Document" = R;
//                         Caption = 'Select Incoming Document';
//                         Image = SelectLineToApply;
//                         //The property 'ToolTip' cannot be empty.
//                         //ToolTip = '';

//                         trigger OnAction()
//                         var
//                             IncomingDocument: Record "Incoming Document";
//                         begin
//                             //VALIDATE("Incoming Document Entry No.",IncomingDocument.SelectIncomingDocument("Incoming Document Entry No."));
//                         end;
//                     }
//                     action(IncomingDocAttachFile)
//                     {
//                         Caption = 'Create Incoming Document from File';
//                         Ellipsis = true;
//                         Enabled = NOT HasIncomingDocument;
//                         Image = Attach;
//                         //The property 'ToolTip' cannot be empty.
//                         //ToolTip = '';

//                         trigger OnAction()
//                         var
//                             IncomingDocumentAttachment: Record "Incoming Document Attachment";
//                         begin
//                             IncomingDocumentAttachment.NewAttachmentFromPurchaseDocument(Rec);
//                         end;
//                     }
//                     action(RemoveIncomingDoc)
//                     {
//                         Caption = 'Remove Incoming Document';
//                         Enabled = HasIncomingDocument;
//                         Image = RemoveLine;
//                         //The property 'ToolTip' cannot be empty.
//                         //ToolTip = '';

//                         trigger OnAction()
//                         begin
//                             Rec."Incoming Document Entry No." := 0;
//                         end;
//                     }
//                 }
//             }
//             group("Request Approval")
//             {
//                 Caption = 'Request Approval';
//                 action(SendApprovalRequest)
//                 {
//                     Caption = 'Send A&pproval Request';
//                     Enabled = NOT OpenApprovalEntriesExist;
//                     Image = SendApprovalRequest;
//                     Promoted = true;
//                     PromotedCategory = Category9;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         if not SomeLinesCommitted then Error('All lines must be committed');

//                         if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
//                             ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
//                     end;
//                 }
//                 action(CancelApprovalRequest)
//                 {
//                     Caption = 'Cancel Approval Re&quest';
//                     Enabled = OpenApprovalEntriesExist;
//                     Image = Cancel;
//                     Promoted = true;
//                     PromotedCategory = Category9;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
//                     end;
//                 }
//             }
//             group(Action17)
//             {
//                 Caption = 'Warehouse';
//                 Image = Warehouse;
//                 action("Create &Whse. Receipt")
//                 {
//                     AccessByPermission = TableData "Warehouse Receipt Header" = R;
//                     Caption = 'Create &Whse. Receipt';
//                     Image = NewReceipt;

//                     trigger OnAction()
//                     var
//                         GetSourceDocInbound: Codeunit 5751;
//                     begin
//                         GetSourceDocInbound.CreateFromPurchOrder(Rec);

//                         if not Rec.Find('=><') then
//                             Rec.Init;
//                     end;
//                 }
//                 action("Create Inventor&y Put-away/Pick")
//                 {
//                     AccessByPermission = TableData "Posted Invt. Put-away Header" = R;
//                     Caption = 'Create Inventor&y Put-away/Pick';
//                     Ellipsis = true;
//                     Image = CreateInventoryPickup;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                         Rec.CreateInvtPutAwayPick;

//                         if not Rec.Find('=><') then
//                             Rec.Init;
//                     end;
//                 }
//                 separator(Action74)
//                 {
//                 }
//             }
//             group("P&osting")
//             {
//                 Caption = 'P&osting';
//                 Image = Post;
//                 //here
//                 // action(Post)
//                 // {
//                 //     Caption = 'P&ost';
//                 //     Ellipsis = true;
//                 //     Image = PostOrder;
//                 //     Promoted = true;
//                 //     PromotedCategory = Process;
//                 //     PromotedIsBig = true;
//                 //     ShortCutKey = 'F9';

//                 //     trigger OnAction()
//                 //     begin
//                 //         Post(CODEUNIT::445);
//                 //     end;
//                 // }
//                 action(Preview)
//                 {
//                     Caption = 'Preview Posting';
//                     Image = ViewPostedOrder;

//                     trigger OnAction()
//                     var
//                         PurchPostYesNo: Codeunit 445;
//                     begin
//                         PurchPostYesNo.Preview(Rec);
//                     end;
//                 }
//                 action("Post and &Print")
//                 {
//                     Caption = 'Post and &Print';
//                     Ellipsis = true;
//                     Image = PostPrint;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'Shift+F9';

//                     trigger OnAction()
//                     begin
//                         Post(CODEUNIT::91);
//                     end;
//                 }
//                 action("Test Report")
//                 {
//                     Caption = 'Test Report';
//                     Ellipsis = true;
//                     Image = TestReport;

//                     trigger OnAction()
//                     begin
//                         ReportPrint.PrintPurchHeader(Rec);
//                     end;
//                 }
//                 action("Post &Batch")
//                 {
//                     Caption = 'Post &Batch';
//                     Ellipsis = true;
//                     Image = PostBatch;

//                     trigger OnAction()
//                     begin
//                         //REPORT.RunModal(REPORT::"Batch Post Purchase Orders", true, true, Rec);
//                         CurrPage.Update(false);
//                     end;
//                 }
//                 action("Remove From Job Queue")
//                 {
//                     Caption = 'Remove From Job Queue';
//                     Image = RemoveLine;
//                     Visible = JobQueueVisible;

//                     trigger OnAction()
//                     begin
//                         Rec.CancelBackgroundPosting;
//                     end;
//                 }
//                 separator(Action201)
//                 {
//                 }
//                 group("Prepa&yment")
//                 {
//                     Caption = 'Prepa&yment';
//                     Image = Prepayment;
//                     action("Prepayment Test &Report")
//                     {
//                         Caption = 'Prepayment Test &Report';
//                         Ellipsis = true;
//                         Image = PrepaymentSimulation;

//                         trigger OnAction()
//                         begin
//                             ReportPrint.PrintPurchHeaderPrepmt(Rec);
//                         end;
//                     }
//                     action(PostPrepaymentInvoice)
//                     {
//                         Caption = 'Post Prepayment &Invoice';
//                         Ellipsis = true;
//                         Image = PrepaymentPost;

//                         trigger OnAction()
//                         var
//                             ApprovalsMgmt: Codeunit 1535;
//                             PurchPostYNPrepmt: Codeunit 445;
//                         begin
//                             if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
//                                 PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, false);
//                         end;
//                     }
//                     action("Post and Print Prepmt. Invoic&e")
//                     {
//                         Caption = 'Post and Print Prepmt. Invoic&e';
//                         Ellipsis = true;
//                         Image = PrepaymentPostPrint;

//                         trigger OnAction()
//                         var
//                             ApprovalsMgmt: Codeunit 1535;
//                             PurchPostYNPrepmt: Codeunit 445;
//                         begin
//                             if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
//                                 PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, true);
//                         end;
//                     }
//                     action(PostPrepaymentCreditMemo)
//                     {
//                         Caption = 'Post Prepayment &Credit Memo';
//                         Ellipsis = true;
//                         Image = PrepaymentPost;

//                         trigger OnAction()
//                         var
//                             ApprovalsMgmt: Codeunit 1535;
//                             PurchPostYNPrepmt: Codeunit 445;
//                         begin
//                             if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
//                                 PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec, false);
//                         end;
//                     }
//                     action("Post and Print Prepmt. Cr. Mem&o")
//                     {
//                         Caption = 'Post and Print Prepmt. Cr. Mem&o';
//                         Ellipsis = true;
//                         Image = PrepaymentPostPrint;

//                         trigger OnAction()
//                         var
//                             ApprovalsMgmt: Codeunit 1535;
//                             PurchPostYNPrepmt: Codeunit 445;
//                         begin
//                             if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
//                                 PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec, true);
//                         end;
//                     }
//                 }
//             }
//             group(Print)
//             {
//                 Caption = 'Print';
//                 Image = Print;
//                 action("Print LPO")
//                 {
//                     Caption = 'Print LPO';
//                     Image = Print;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                         PurchaseHeader.Reset;
//                         PurchaseHeader.SetRange(PurchaseHeader."Document Type", PurchaseHeader."Document Type"::Order);
//                         PurchaseHeader.SetRange(PurchaseHeader."No.", Rec."No.");
//                         //if Rec.PurchaseHeader.FindFirst then
//                         //REPORT.Run(REPORT::"Order 2", true, true, PurchaseHeader);
//                     end;
//                 }
//                 action("&Print")
//                 {
//                     Caption = '&Print';
//                     Ellipsis = true;
//                     Image = Print;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                         DocPrint.PrintPurchHeader(Rec);
//                     end;
//                 }
//                 action("EDMS [Case 360]")
//                 {
//                     Image = Document;
//                     Promoted = true;
//                     PromotedCategory = Category5;

//                     trigger OnAction()
//                     var
//                         DMS: Record EDMS;
//                     begin
//                         /*
//                         DMS.RESET;
//                         DMS.SETRANGE(DMS.Key, DMS.Key::"Loan File");
//                         IF Rec.DMS.FIND('-') THEN BEGIN
//                         HYPERLINK(DMS."url path"+"Loan No.");
//                         END;
//                         */

//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetCurrRecord()
//     begin
//         CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
//         ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);
//     end;

//     trigger OnAfterGetRecord()
//     begin
//         SetControlAppearance;
//     end;

//     trigger OnDeleteRecord(): Boolean
//     begin
//         CurrPage.SaveRecord;
//         exit(Rec.ConfirmDeletion);
//     end;

//     trigger OnInit()
//     begin
//         SetExtDocNoMandatoryCondition;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         //DocApprovalType := DocApprovalType::"3";
//         //"Invoice Type":="Invoice Type"::Contract;

//         Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
//         //Add dimensions if Rec.set by default here
//         Rec."Shortcut Dimension 1 Code" := UserMgt.GetSetDimensions(UserId, 1);
//         Rec.Validate("Shortcut Dimension 1 Code");
//         Rec."Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(UserId, 2);
//         Rec.Validate("Shortcut Dimension 2 Code");
//     end;

//     trigger OnOpenPage()
//     begin
//         SetDocNoVisible;

//         if UserMgt.GetPurchasesFilter <> '' then begin
//             Rec.FilterGroup(2);
//             Rec.SetRange("Responsibility Center", UserMgt.GetPurchasesFilter);
//             Rec.FilterGroup(0);
//         end;
//     end;

//     var
//         ChangeExchangeRate: Page "Change Exchange Rate";
//                                 CopyPurchDoc: Report "Copy Purchase Document";
//                                 MoveNegPurchLines: Report "Move Negative Purchase Lines";
//                                 ReportPrint: Codeunit "Test Report-Print";
//                                 DocPrint: Codeunit "Document-Print";
//                                 UserMgt: Codeunit "User Setup Management BR";
//                                 ArchiveManagement: Codeunit ArchiveManagement;
//                                 PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
//     

//     JobQueueVisible: Boolean;
//     HasIncomingDocument: Boolean;
//     DocNoVisible: Boolean;
//     VendorInvoiceNoMandatory: Boolean;
//     OpenApprovalEntriesExistForCurrUser: Boolean;
//     OpenApprovalEntriesExist: Boolean;
//     ShowWorkflowStatus: Boolean;
//     Commitment: Codeunit "Budgetary Control";
//     BCSetup: Record "Budgetary Control Setup";
//     DeleteCommitment: Record Committment;
//     PurchaseHeader: Record "Purchase Header";

// local procedure Post(PostingCodeunitID: Integer)
//     begin
//         Rec.SendToPosting(PostingCodeunitID);
//         if Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" then
//             CurrPage.Close;
//         CurrPage.Update(false);
//     end;

//     local procedure ApproveCalcInvDisc()
//     begin
//         CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
//     end;

//     local procedure BuyfromVendorNoOnAfterValidate()
//     begin
//         if Rec.GetFilter("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
//             if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
//                 Rec.SetRange("Buy-from Vendor No.");
//         CurrPage.Update;
//     end;

//     local procedure PurchaserCodeOnAfterValidate()
//     begin
//         CurrPage.PurchLines.PAGE.UpdateForm(true);
//     end;

//     local procedure PaytoVendorNoOnAfterValidate()
//     begin
//         CurrPage.Update;
//     end;

//     local procedure ShortcutDimension1CodeOnAfterV()
//     begin
//         CurrPage.Update;
//     end;

//     local procedure ShortcutDimension2CodeOnAfterV()
//     begin
//         CurrPage.Update;
//     end;

//     local procedure PricesIncludingVATOnAfterValid()
//     begin
//         CurrPage.Update;
//     end;

//     local procedure Prepayment37OnAfterValidate()
//     begin
//         CurrPage.Update;
//     end;

//     local procedure SetDocNoVisible()
//     var
//         DocumentNoVisibility: Codeunit DocumentNoVisibility;
//         DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
//     begin
//         DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::Order, Rec."No.");
//     end;

//     local procedure SetExtDocNoMandatoryCondition()
//     var
//         PurchasesPayablesSetup: Record "Purchases & Payables Setup";
//     begin
//         PurchasesPayablesSetup.Get;
//         VendorInvoiceNoMandatory := PurchasesPayablesSetup."Ext. Doc. No. Mandatory"
//     end;

//     local procedure SetControlAppearance()
//     var
//         ApprovalsMgmt: Codeunit 1535;
//     begin
//         JobQueueVisible := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
//         HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
//         SetExtDocNoMandatoryCondition;
//     //    OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
// // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
//     end;

//     //[Scope('OnPrem')]
//     procedure LinesCommitted() Exists: Boolean
//     var
//         PurchLines: Record "Purchase Line";
//     begin
//         if BCSetup.Get() then begin
//             if not BCSetup.Mandatory then begin
//                 Exists := false;
//                 exit;
//             end;
//         end else begin
//             Exists := false;
//             exit;
//         end;
//         if BCSetup.Get then begin
//             Exists := false;
//             PurchLines.Reset;
//             PurchLines.SetRange(PurchLines."Document Type", Rec."Document Type");
//             PurchLines.SetRange(PurchLines."Document No.", Rec."No.");
//             PurchLines.SetRange(PurchLines.Committed, false);
//             if PurchLines.Find('-') then
//                 Exists := true;
//         end else
//             Exists := false;
//     end;

//     //[Scope('OnPrem')]
//     procedure SomeLinesCommitted() Exists: Boolean
//     var
//         PurchLines: Record "Purchase Line";
//     begin
//         if BCSetup.Get then begin
//             Exists := false;
//             PurchLines.Reset;
//             PurchLines.SetRange(PurchLines."Document Type", Rec."Document Type");
//             PurchLines.SetRange(PurchLines."Document No.", Rec."No.");
//             PurchLines.SetRange(PurchLines.Committed, true);
//             if PurchLines.Find('-') then
//                 Exists := true;
//         end else
//             Exists := false;
//     end;
// }

