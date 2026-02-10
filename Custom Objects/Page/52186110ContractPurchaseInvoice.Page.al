// page 52186110 "Contract Purchase Invoice"
// {
//     Caption = 'Contract Purchase Invoice';
//     PageType = Document;
//     PromotedActionCategories = 'New,Process,Report,Approve';
//     RefreshOnActivate = true;
//     SourceTable = "Purchase Header";
//     SourceTableView = WHERE("Document Type" = FILTER(Invoice));
//     ApplicationArea = Basic, Suite;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Promoted;
//                     Visible = DocNoVisible;

//                     trigger OnAssistEdit()
//                     begin
//                         if Rec.AssistEdit(xRec) then
//                             CurrPage.Update;
//                     end;
//                 }
//                 field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Promoted;
//                     ShowMandatory = true;

//                     trigger OnValidate()
//                     begin
//                         BuyfromVendorNoOnAfterValidate;
//                     end;
//                 }
//                 field("Buy-from Contact No."; Rec."Buy-from Contact No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Buy-from Address"; Rec."Buy-from Address")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                 }
//                 field("Buy-from Address 2"; Rec."Buy-from Address 2")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                 }
//                 field("Buy-from Post Code"; Rec."Buy-from Post Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                 }
//                 field("Buy-from City"; Rec."Buy-from City")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Buy-from Contact"; Rec."Buy-from Contact")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                 }
//                 field("Posting Date"; Rec."Posting Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Promoted;
//                 }
//                 field("Document Date"; Rec."Document Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Vendor Invoice No."; Rec."Vendor Invoice No.")
//                 {
//                     ApplicationArea = Basic, Suite;

//                 }
//                 field("Order Address Code"; Rec."Order Address Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Purchaser Code"; Rec."Purchaser Code")
//                 {
//                     ApplicationArea = Basic, Suite;

//                     trigger OnValidate()
//                     begin
//                         PurchaserCodeOnAfterValidate;
//                     end;
//                 }
//                 field("Responsibility Center"; Rec."Responsibility Center")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
//                 {
//                     ApplicationArea = Basic, Suite;

//                     trigger OnValidate()
//                     begin
//                         ShortcutDimension1CodeOnAfterV;
//                     end;
//                 }
//                 field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
//                 {
//                     ApplicationArea = Basic, Suite;

//                     trigger OnValidate()
//                     begin
//                         ShortcutDimension2CodeOnAfterV;
//                     end;
//                 }
//                 field("Assigned User ID"; Rec."Assigned User ID")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//                 field("Contract No."; Rec."Contract No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//             part(PurchLines; "Purch. Invoice Subform")
//             {
//                 SubPageLink = "Document No." = FIELD("No.");
//                 UpdatePropagation = Both;
//                 ApplicationArea = Basic, Suite;
//             }
//             group(Invoicing)
//             {
//                 Caption = 'Invoicing';
//                 field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         PaytoVendorNoOnAfterValidate;
//                     end;
//                 }
//                 field("Pay-to Contact No."; Rec."Pay-to Contact No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                 }
//                 field("Pay-to Name"; Rec."Pay-to Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Pay-to Address"; Rec."Pay-to Address")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                 }
//                 field("Pay-to Address 2"; Rec."Pay-to Address 2")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                 }
//                 field("Pay-to Post Code"; Rec."Pay-to Post Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                 }
//                 field("Pay-to City"; Rec."Pay-to City")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Pay-to Contact"; Rec."Pay-to Contact")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                 }
//                 field("Payment Terms Code"; Rec."Payment Terms Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Promoted;
//                 }
//                 field("Due Date"; Rec."Due Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Promoted;
//                 }
//                 field("Payment Discount %"; Rec."Payment Discount %")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Additional;
//                 }
//                 field("Payment Method Code"; Rec."Payment Method Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Payment Reference"; Rec."Payment Reference")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Creditor No."; Rec."Creditor No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("On Hold"; Rec."On Hold")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Prices Including VAT"; Rec."Prices Including VAT")
//                 {
//                     ApplicationArea = Basic, Suite;

//                     trigger OnValidate()
//                     begin
//                         PricesIncludingVATOnAfterValid;
//                     end;
//                 }
//                 field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//             group(Shipping)
//             {
//                 Caption = 'Shipping';
//                 field("Ship-to Name"; Rec."Ship-to Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Ship-to Address"; Rec."Ship-to Address")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Ship-to Address 2"; Rec."Ship-to Address 2")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Ship-to Post Code"; Rec."Ship-to Post Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Ship-to City"; Rec."Ship-to City")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Ship-to Contact"; Rec."Ship-to Contact")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Location Code"; Rec."Location Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Promoted;
//                 }
//                 field("Shipment Method Code"; Rec."Shipment Method Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Expected Receipt Date"; Rec."Expected Receipt Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Promoted;
//                 }
//             }
//             group("Foreign Trade")
//             {
//                 Caption = 'Foreign Trade';
//                 field("Currency Code"; Rec."Currency Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Importance = Promoted;

//                     // trigger OnAssistEdit()
//                     // begin
//                     //     Clear(ChangeExchangeRate);
//                     //     if Rec."Posting Date" <> 0D then
//                     //         ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date")
//                     //     else
//                     //         ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WorkDate);
//                     //     if ChangeExchangeRate.RunModal = ACTION::OK then begin
//                     //         Rec.Validate(Rec."Currency Factor", ChangeExchangeRate.GetParameter);
//                     //         CurrPage.Update;
//                     //     end;
//                     //     Clear(ChangeExchangeRate);
//                     // end;

//                     trigger OnValidate()
//                     begin
//                         CurrPage.Update;
//                         PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
//                     end;
//                 }
//                 field("Transaction Type"; Rec."Transaction Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Transaction Specification"; Rec."Transaction Specification")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Transport Method"; Rec."Transport Method")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Entry Point"; Rec."Entry Point")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Area"; Rec.Area)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             part(Control73; "Purchase Line Budget FactBox")
//             {
//                 Provider = PurchLines;
//                 SubPageLink = "Document No." = FIELD("Document No."),
//                               "Line No." = FIELD("Li
//                               ApplicationArea = Basic, Suite;ne No.");
//             }
//             ApplicationArea = Basic, Suite;
//             part(Control27; "Pending Approval FactBox")
//             {
//                 SubPageLink = "Table ID" = CONST(38),
//                               "Document Type" = FIELD("Document Type"),
//                               "Document No." = FIELD(
//                                 ApplicationArea = Basic, Suite;"No.");
//                 Visible = OpenApprovalEntriesExistFo
//                 ApplicationArea = Basic, Suite;rCurrUser;
//             }
//             part(Control1906354007; "Approval FactBox")
//             {
//                 SubPageLink = "Table ID" = CONST(38),
//                               "Document Type" = FIELD("Document Type"),
//                               "Document No." = FIELD(
//                                 ApplicationArea = Basic, Suite;"No.");
//                 Visible = false;
//                 ApplicationArea = Basic, Suite;
//             }
//             part(Control1901138007; "Vendor Details FactBox")
//             {
//                 SubPageLink = "No." = FIELD("Buy-from Vendor No.");
//                 Visible = false;
//                 ApplicationArea = Basic, Suite;
//             }
//             part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
//             {
//                 ShowFilter = false;
//             }
//             part(Control1904651607; "Vendor Statistics FactBox")
//             {
//                 SubPageLink = "No." = FIELD("Pay-to Vendor No.");
//                 Visible = true;
//                 ApplicationArea = Basic, Suite;
//             }
//             part(Control1903435607; "Vendor Hist. Buy-from FactBox")
//             {
//                 SubPageLink = "No." = FIELD("Buy-from Vendor No.");
//                 Visible = true;
//                 ApplicationArea = Basic, Suite;
//             }
//             part(Control1906949207; "Vendor Hist. Pay-to FactBox")
//             {
//                 SubPageLink = "No." = FIELD("Pay-to Vendor No.");
//                 Visible = false;
//                 ApplicationArea = Basic, Suite;
//             }
//             part(Control3; "Purchase Line FactBox")
//             {
//                 Provider = PurchLines;
//                 SubPageLink = "Document Type" = FIELD("Document Type"),
//                               "Document No." = FIELD(
//                                 ApplicationArea = Basic, Suite;"Document No."),
//                               "Line No." = FIELD("Li
//                               ApplicationArea = Basic, Suite;ne No.");
//                 Visible = false;
//                 ApplicationArea = Basic, Suite;
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
//                 ApplicationArea = Basic, Suite;
//             }
//             systempart(Control1905767507; Notes)
//             {
//                 Visible = true;
//                 ApplicationArea = Basic, Suite;
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("&Invoice")
//             {
//                 Caption = '&Invoice';
//                 Image = Invoice;
//                 action(Statistics)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Statistics';
//                     Image = Statistics;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     ShortCutKey = 'F7';

//                     trigger OnAction()
//                     begin
//                         Rec.CalcInvDiscForHeader;
//                         Commit;
//                         PAGE.RunModal(PAGE::"Purchase Statistics", Rec);
//                         PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
//                     end;
//                 }
//                 action(Vendor)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Vendor';
//                     Image = Vendor;
//                     RunObject = Page "Vendor Card";
//                     RunPageLink = "No." = FIELD("Buy-from Vendor No.");
//                     ShortCutKey = 'Shift+F7';
//                     ApplicationArea = Basic, Suite;
//                 }
//                 action("Co&mments")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page 66;
//                     RunPageLink = "Document Type" = FIELD("Document Type"),
//                                   "No." = FIELD("No."),
//                                   ApplicationArea = Basic, Suite;
//                                   "Document Lin
//                                   ApplicationArea = Basic, Suite;e No." = CONST(0);
//                 }
//                 action(Dimensionsy)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     AccessByPermission = TableData Dimension = R;
//                     Caption = 'Dimensionsy';
//                     Image = Dimensions;
//                     ShortCutKey = 'Shift+Ctrl+D';

//                     trigger OnAction()
//                     begin
//                         Rec.ShowDocDim;
//                         CurrPage.SaveRecord;
//                     end;
//                 }
//                 action(Approvals)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Approvals';
//                     Image = Approvals;

//                     trigger OnAction()
//                     var
//                         ApprovalEntries: Page 658;
//                     begin
//                         ApprovalEntries.SetRecordFilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");
//                         ApprovalEntries.Run;
//                     end;
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
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Approve';
//                     Image = Approve;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                        // ApprovalsMgmt: Codeunit 1535;
//                     begin
//                        // ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId)
//                     end;
//                 }
//                 action(Reject)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Reject';
//                     Image = Reject;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                        // ApprovalsMgmt: Codeunit 1535;
//                     begin
//                        // // ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId)
//                     end;
//                 }
//                 action(Delegate)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Delegate';
//                     Image = Delegate;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         // ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         //ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId)
//                     end;
//                 }
//                 action(Comment)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Comments';
//                     Image = ViewComments;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     // RunObject = Page "Approval Comments";
//                     RunPageLink = "Table ID" = CONST(38),
//                                   "Document Type" = FIELD("Document Type"),
//                                   "Document No." = FIELD(
//                                     ApplicationArea = Basic, Suite;"No.");
//                     Visible = OpenApprovalEntriesExistFo
//                     ApplicationArea = Basic, Suite;rCurrUser;
//                 }
//             }
//             group(Release)
//             {
//                 Caption = 'Release';
//                 Image = Release;
//                 action("Re&lease")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Re&lease';
//                     Image = ReleaseDoc;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     ShortCutKey = 'Ctrl+F9';

//                     trigger OnAction()
//                     var
//                         //ReleasePurchDoc: Codeunit 415;
//                     begin
//                         //ReleasePurchDoc.PerformManualRelease(Rec);
//                     end;
//                 }
//                 action("Re&open")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Re&open';
//                     Image = ReOpen;

//                     trigger OnAction()
//                     var
//                        // ReleasePurchDoc: Codeunit 415;
//                     begin
//                        // ReleasePurchDoc.PerformManualReopen(Rec);
//                     end;
//                 }
//             }
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 Image = "Action";
//                 action(CalculateInvoiceDiscount)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     AccessByPermission = TableData "Vendor Invoice Disc." = R;
//                     Caption = 'Calculate &Invoice Discount';
//                     Image = CalculateInvoiceDiscount;

//                     trigger OnAction()
//                     begin
//                         ApproveCalcInvDisc;
//                         PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
//                     end;
//                 }
//                 separator(Action133)
//                 {
//                 }
//                 action("Get St&d. Vend. Purchase Codes")
//                 {
//                     ApplicationArea = Basic, Suite;
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
//                 separator(Action136)
//                 {
//                 }
//                 action("Copy Document")
//                 {
//                     ApplicationArea = Basic, Suite;
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
//                 action(MoveNegativeLines)
//                 {
//                     ApplicationArea = Basic, Suite;
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
//                 separator(Action137)
//                 {
//                 }
//                 action("Check Budget Availability")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Image = Balance;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     begin
//                         PurchaseLine.Reset;
//                         PurchaseLine.SetRange("Document No.", Rec."No.");
//                         PurchaseLine.SetFilter("Order No.", '<>%1', '');
//                         if PurchaseLine.FindSet then Error('Invoice Linked to order please proceed to post the document');

//                         BCSetup.Get;
//                         if not BCSetup.Mandatory then
//                             exit;

//                         if Rec.Status = Rec.Status::Released then
//                             Error('This document has already been released. This functionality is available for open documents only');
//                         if SomeLinesCommitted then begin
//                             if not Confirm('Some or All the Lines Are already Committed do you want to continue', true, Rec."Document Type") then
//                                 Error('Budget Availability Check and Commitment Aborted');
//                             DeleteCommitment.Reset;
//                             DeleteCommitment.SetRange(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::PurchInvoice);
//                             DeleteCommitment.SetRange(DeleteCommitment."Document No.", Rec."No.");
//                             DeleteCommitment.DeleteAll;
//                         end;
//                         Commitment.CheckPurchase(Rec);
//                         Message('Budget Availability Checking Complete');
//                     end;
//                 }
//                 action("Cancel Budget Commitment")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Image = CancelAllLines;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     var
//                         PurchLine: Record "Purchase Line";
//                     begin

//                         if not Confirm('Are you sure you want to Cancel All Commitments Done for this document', true, Rec."Document Type") then
//                             Error('Budget Availability Check and Commitment Aborted');

//                         DeleteCommitment.Reset;
//                         DeleteCommitment.SetRange(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::PurchInvoice);
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
//                 group(IncomingDocument)
//                 {
//                     Caption = 'Incoming Document';
//                     Image = Documents;
//                     action(IncomingDocCard)
//                     {
//                         ApplicationArea = Basic, Suite;
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
//                         ApplicationArea = Basic, Suite;
//                         AccessByPermission = TableData "Incoming Document" = R;
//                         Caption = 'Select Incoming Document';
//                         Image = SelectLineToApply;
//                         //The property 'ToolTip' cannot be empty.
//                         //ToolTip = '';

//                         trigger OnAction()
//                         var
//                             IncomingDocument: Record "Incoming Document";
//                         begin
//                             //VALIDATE("Incoming Document Entry No.",IncomingDocument.SelectIncomingDocument("Incoming Document Entry No.",Rec));
//                         end;
//                     }
//                     action(IncomingDocAttachFile)
//                     {
//                         ApplicationArea = Basic, Suite;
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
//                         ApplicationArea = Basic, Suite;
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
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Send A&pproval Request';
//                     Enabled = NOT OpenApprovalEntriesExist;
//                     Image = SendApprovalRequest;

//                     trigger OnAction()
//                     var
//                     //    ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         PurchaseLine.Reset;
//                         PurchaseLine.SetRange("Document No.", Rec."No.");
//                         PurchaseLine.SetFilter("Order No.", '%1', '');
//                         // if PurchaseLine.FindSet then
//                             // PurchaseLine.TESTFIELD(Committed);

// ApplicationArea = Basic, Suite;
//                             // if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
//                             //     ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
//                     end;
//                 }
//                 action(CancelApprovalRequest)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Cancel Approval Re&quest';
//                     Enabled = OpenApprovalEntriesExist;
//                     Image = Cancel;

//                     trigger OnAction()
//                     var
//                     //    ApprovalsMgmt: Codeunit 1535;
//                     begin
//                        // ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
//                     end;
//                 }
//             }
//             group("P&osting")
//             {
//                 Caption = 'P&osting';
//                 Image = Post;
//                 // action(Post)
//                 // {
//                 //     Caption = 'P&ost';
//                 //     Image = PostOrder;
//                 //     Promoted = true;
//                 //     PromotedCategory = Process;
//                 //     PromotedIsBig = true;
//                 //     ShortCutKey = 'F9';

//                 //     trigger OnAction()
//                 //     begin
//                 //         Post(CODEUNIT::"Purch.-Post");
//                 //     end;
//                 // }
//                 action(Preview)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Preview Posting';
//                     Image = ViewPostedOrder;

//                     trigger OnAction()
//                     var
//                         PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
//                     begin
//                         PurchPostYesNo.Preview(Rec);
//                     end;
//                 }
//                 action(TestReport)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Test Report';
//                     Ellipsis = true;
//                     Image = TestReport;

//                     trigger OnAction()
//                     begin
//                         ReportPrint.PrintPurchHeader(Rec);
//                     end;
//                 }
//                 action(PostAndPrint)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Post and &Print';
//                     Image = PostPrint;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'Shift+F9';

//                     trigger OnAction()
//                     begin
//                         Post(CODEUNIT::"Purch.-Post + Print");
//                     end;
//                 }
//                 action(PostBatch)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Post &Batch';
//                     Ellipsis = true;
//                     Image = PostBatch;

//                     trigger OnAction()
//                     begin
//                         //REPORT.RunModal(REPORT::"Batch Post Purchase Invoices", true, true, Rec);
//                         CurrPage.Update(false);
//                     end;
//                 }
//                 action(RemoveFromJobQueue)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Remove From Job Queue';
//                     Image = RemoveLine;
//                     Visible = Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled For Posting";

//                     trigger OnAction()
//                     begin
//                         Rec.CancelBackgroundPosting;
//                     end;
//                 }
//                 action(Invoice)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Image = Document;
//                     Promoted = true;

//                     trigger OnAction()
//                     begin
//                         DMS.Reset;
//                         DMS.SetRange(DMS.Key, DMS.Key::Invoice);
//                         if DMS.Find('-') then begin
//                             HyperLink(DMS."url path" + Rec."No.");
//                         end;
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
//         Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
//         //Add dimensions if set by default here
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
//         //ChangeExchangeRate: Page "Change Exchange Rate";
//         CopyPurchDoc: Report 492;
//         MoveNegPurchLines: Report "Move Negative Purchase Lines";
//         ReportPrint: Codeunit "Test Report-Print";
//         UserMgt: Codeunit "User Setup Management BR";
//         PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
//         HasIncomingDocument: Boolean;
//         DocNoVisible: Boolean;
//         VendorInvoiceNoMandatory: Boolean;
//         OpenApprovalEntriesExist: Boolean;
//         OpenApprovalEntriesExistForCurrUser: Boolean;
//         ShowWorkflowStatus: Boolean;
//         Commitment: Codeunit "Budgetary Control";
//         BCSetup: Record "Budgetary Control Setup";
//         DeleteCommitment: Record Committment;
//         PurchaseLine: Record "Purchase Line";
//         DMS: Record EDMS;

//     //[Scope('OnPrem')]
//     procedure LineModified()
//     begin
//     end;

//     local procedure Post(PostingCodeunitID: Integer)
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
//         if Rec.GetFilter(Rec."Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
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

//     local procedure SetDocNoVisible()
//     var
//         DocumentNoVisibility: Codeunit 1400;
//         DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
//     begin
//         DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::Invoice, Rec."No.");
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
//         // ApprovalsMgmt: Codeunit 1535;
//     begin
//         HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
//         SetExtDocNoMandatoryCondition;

//         //OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
//        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
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

