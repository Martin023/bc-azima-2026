// page 52186585 "CRM Share Transfer App. API"
// {
//     APIGroup = 'crm';
//     APIPublisher = 'sky';
//     APIVersion = 'v1.0';
//     ApplicationArea = All;
//     Caption = 'crmShareTransferAppAPI';
//     DelayedInsert = true;
//     EntityName = 'shareCapitalTransfer';
//     EntitySetName = 'shareCapitalTransfers';
//     PageType = API;
//     SourceTable = "Share Capital Transfer Buffer";

//     EntityCaption = 'Share Capital Transfer Application';
//     EntitySetCaption = 'Share Capital Transfer Applications';

//     ODataKeyFields = SystemId;

//     InsertAllowed = false;
//     ModifyAllowed = false;
//     DeleteAllowed = false;

//     // Share Capital -> (Source) Seller Status
//     //                   -> (Destination) Buyer's status

//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field(documentNo; Rec."Document No")
//                 {
//                     Caption = 'Document No';
//                 }
//                 field(sourceAccountNo; Rec."Source Account No")
//                 {
//                     Caption = 'Source Account No';
//                 }
//                 field(sourceMemberNo; Rec."Source Member No")
//                 {
//                     Caption = 'Source Member No';
//                 }
//                 field(sourceMemberName; Rec."Source Member Name")
//                 {
//                     Caption = 'Source Member Name';
//                 }
//                 field(sourceBalance; Rec."Source Balance")
//                 {
//                     Caption = 'Source Balance';
//                 }
//                 field(sourceMobileNumber; Rec."Source Mobile Number")
//                 {
//                     Caption = 'Source Mobile Number';
//                 }
//                 field(sourceIDNo; Rec."Source ID No.")
//                 {
//                     Caption = 'Source ID No.';
//                 }
//                 field(destinatonAccNo; Rec."Destinaton Acc No")
//                 {
//                     Caption = 'Destinaton Acc No';
//                 }
//                 field(destinationMemberName; Rec."Destination Member Name")
//                 {
//                     Caption = 'Destination Member Name';
//                 }
//                 field(destinationBalance; Rec."Destination Balance")
//                 {
//                     Caption = 'Destination Balance';
//                 }
//                 field(destinationEmployerCode; Rec."Destination Employer Code")
//                 {
//                     Caption = 'Destination Employer Code';
//                 }
//                 field(transfered; Rec.Transfered)
//                 {
//                     Caption = 'Transfered';
//                 }
//                 field(transferReason; Rec."Transfer Reason")
//                 {
//                     Caption = 'Transfer Reason';
//                 }
//                 field(destinationMemberNo; Rec."Destination Member No.")
//                 {
//                     Caption = 'Destination Member No.';
//                 }
//                 field(status; Rec.Status)
//                 {
//                     Caption = 'Status';
//                 }
//                 field("transactionType"; Rec."Transaction Type")
//                 {
//                     Caption = 'Transaction Type';
//                 }
//                 field(crmApplicationNo; Rec."CRM Application No.")
//                 {
//                     Caption = 'CRM Application No.';
//                 }
//                 field(crmNotes; Rec."CRM Notes")
//                 {
//                     Caption = 'CRM Notes';
//                 }
//                 field(crmOriginatingBranch; Rec."CRM Originating Branch")
//                 {
//                     Caption = 'CRM Originating Branch';
//                 }
//                 field(crmCreatedBy; Rec."CRM Created By")
//                 {
//                     Caption = 'CRM Created By';
//                 }
//                 field(sentBackToCRM; Rec."Sent Back to CRM")
//                 {
//                     Caption = 'Sent Back to CRM';
//                 }
//                 field(posted; Rec.Posted)
//                 {
//                     Caption = 'Posted';
//                 }
//                 field(referenceNo; Rec."Reference No")
//                 {
//                     Caption = 'Reference No';
//                 }
//                 field(applicationDate; Rec."Application Date")
//                 {
//                     Caption = ' Application Date';
//                 }
//                 field(receiptAmount; Rec."Receipt Amount")
//                 {
//                     Caption = 'Receipt Amount';
//                 }
//                 field(responsibleOfficer; Rec."Responsible Officer")
//                 {
//                     Caption = 'Responsible Officer';
//                 }


//                 field(sellerStatus; 'Seller status: ' + Format(Rec.Status))
//                 {
//                     Caption = 'Seller Status';
//                 }
//                 field(buyerStatus; 'Buyer status: ' + Format(Rec.Status))
//                 {
//                     Caption = 'Buyer Status';
//                 }
//                 field(approvedBy; Rec."Approved By")
//                 {
//                     Caption = 'Approved By';
//                 }
//                 field(approvalDate; Rec."Approval Date")
//                 {
//                     Caption = 'Approval Date';
//                 }
//                 field(statusComment; 'The current status is: ' + Format(Rec.Status))
//                 {
//                     Caption = 'Status comment';
//                 }
//                 field(noneAllocated; false)
//                 {
//                     Caption = 'None allocated';
//                 }

//                 field(systemCreatedAt; Rec.SystemCreatedAt)
//                 {
//                     Caption = 'SystemCreatedAt';
//                 }
//                 field(systemCreatedBy; Rec.SystemCreatedBy)
//                 {
//                     Caption = 'SystemCreatedBy';
//                 }
//                 field(systemId; Rec.SystemId)
//                 {
//                     Caption = 'SystemId';
//                 }
//                 field(systemModifiedAt; Rec.SystemModifiedAt)
//                 {
//                     Caption = 'SystemModifiedAt';
//                 }
//                 field(systemModifiedBy; Rec.SystemModifiedBy)
//                 {
//                     Caption = 'SystemModifiedBy';
//                 }
//             }
//         }
//     }
// }
