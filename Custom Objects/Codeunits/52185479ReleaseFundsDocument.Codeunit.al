// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Codeunit 52185479 "Release Funds Document"
// {

//     trigger OnRun()
//     var
//         PurchLine: Record "Purchase Line";
//         TempVATAmountLine0: Record "VAT Amount Line" temporary;
//         TempVATAmountLine1: Record "VAT Amount Line" temporary;
//         PrepaymentMgt: Codeunit "Prepayment Mgt.";
//         NotOnlyDropShipment: Boolean;
//         PostingDate: Date;
//         PrintPostedDocuments: Boolean;
//     begin
//     end;

//     var
//         Text001: label 'There is nothing to release for the document of type %1 with the number %2.';
//         PurchSetup: Record "Purchases & Payables Setup";
//         InvtSetup: Record "Inventory Setup";
//         WhsePurchRelease: Codeunit "Whse.-Purch. Release";
//         Text002: label 'This document can only be released when the approval process is complete.';
//         Text003: label 'The approval process must be cancelled or completed to reopen this document.';
//         Text004: label 'There are unposted prepayment amounts on the document of type %1 with the number %2.';
//         Text005: label 'There are unpaid prepayment invoices that are related to the document of type %1 with the number %2.';


//     procedure Reopen(var PurchHeader: Record "Purchase Header")
//     begin
//         OnBeforeReopenPurchaseDoc(PurchHeader);

//         begin
//             if PurchHeader.Status = PurchHeader.Status::Open then
//                 exit;
//             if PurchHeader."Document Type" in [PurchHeader."document type"::Order, PurchHeader."document type"::"Return Order"] then
//                 WhsePurchRelease.Reopen(PurchHeader);
//             PurchHeader.Status := PurchHeader.Status::Open;

//             PurchHeader.Modify(true);
//         end;

//         OnAfterReopenPurchaseDoc(PurchHeader);
//     end;


//     procedure PerformManualRelease(var PaymentHeader: Record "Payments Header")
//     var
//         PrepaymentMgt: Codeunit "Prepayment Mgt.";
//     //  // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//     begin
//         //IF ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PaymentHeader) AND (PaymentHeader.Status = PaymentHeader.Status::Open) THEN
//         //  ERROR(Text002);

//         if PaymentHeader.Status = PaymentHeader.Status::Approved then
//             exit;

//         //OnBeforeReleasePurchaseDoc(PaymentHeader);
//         //OnCheckPurchaseReleaseRestrictions;

//         PaymentHeader.Status := PaymentHeader.Status::Approved;

//         PaymentHeader.Modify(true);

//         //OnAfterReleasePurchaseDoc(PaymentHeader);
//     end;


//     procedure PerformManualReopen(var PurchHeader: Record "Purchase Header")
//     begin
//         if PurchHeader.Status = PurchHeader.Status::"Pending Approval" then
//             Error(Text003);

//         Reopen(PurchHeader);
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeReopenPurchaseDoc(var PurchaseHeader: Record "Purchase Header")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterReopenPurchaseDoc(var PurchaseHeader: Record "Purchase Header")
//     begin
//     end;
// }
