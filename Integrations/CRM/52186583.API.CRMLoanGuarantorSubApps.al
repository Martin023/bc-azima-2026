// page 52186583 "CRM Loan Guarantor Sub App API"
// {
//     APIGroup = 'crm';
//     APIPublisher = 'sky';
//     APIVersion = 'v1.0';
//     ApplicationArea = All;
//     Caption = 'crmLoanGuarantorSubAppAPI';
//     DelayedInsert = true;
//     EntityName = 'loanGuarantorSubstitution';
//     EntitySetName = 'loanGuarantorSubstitutions';
//     PageType = API;
//     SourceTable = "Guarantors Substitution";

//     EntityCaption = 'Loan Guarantor Substitution';
//     EntitySetCaption = 'Loan Guarantor Substitutions';

//     ODataKeyFields = SystemId;

//     InsertAllowed = false;
//     ModifyAllowed = false;
//     DeleteAllowed = false;

//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field(no; Rec."No.")
//                 {
//                     Caption = 'No.';
//                 }
//                 field(loanNo; Rec."Loan No.")
//                 {
//                     Caption = 'Loan No.';
//                 }
//                 field(loanType; Rec."Loan Product Type")
//                 {
//                     Caption = 'Loan Product Type';
//                 }
//                 field("date"; Rec."Date")
//                 {
//                     Caption = 'Date';
//                 }
//                 field(loanAccountNo; Rec."Loan Account No.")
//                 {
//                     Caption = 'Loan Account No.';
//                 }
//                 field(name; Rec.Name)
//                 {
//                     Caption = 'Name';
//                 }
//                 field(accountStatus; Rec."Account Status")
//                 {
//                     Caption = 'Account Status';
//                 }
//                 field(status; Rec.Status)
//                 {
//                     Caption = 'Status';
//                 }
//                 field(statusComment; 'The current status is: ' + Format(Rec.Status))
//                 {
//                     Caption = 'Status Comment';
//                 }
//                 field(approvedBy; Rec."Posted By")
//                 {
//                     Caption = 'Approved By';
//                 }
//                 field(createdBy; Rec."Captured By")
//                 {
//                     Caption = 'Created By';
//                 }
//                 field(activityCode; Rec."Activity Code")
//                 {
//                     Caption = 'Activity Code';
//                 }
//                 field(branchCode; Rec."Branch Code")
//                 {
//                     Caption = 'Branch Code';
//                 }
//                 field(documentNo; Rec."Document No.")
//                 {
//                     Caption = 'Document No.';
//                 }
//                 field(idNo; Rec."ID/Passport")
//                 {
//                     Caption = 'ID/Passport No';
//                 }
//                 field("approvalDate"; Rec."Approval Date")
//                 {
//                     Caption = 'Approval Date';
//                 }
//                 field("loanMembershipStatus"; Rec."Member Status")
//                 {
//                     Caption = 'Loan membership status';
//                 }
//                 field(posted; Rec.Posted)
//                 {
//                     Caption = 'Posted';
//                 }
//                 field(crmApplicationNo; Rec."CRM Application No.")
//                 {
//                     Caption = 'CRM Application No.';
//                 }
//                 field(crmCreatedBy; Rec."CRM Created By")
//                 {
//                     Caption = 'CRM Created By';
//                 }
//                 field(crmOriginatingBranch; Rec."CRM Originating Branch")
//                 {
//                     Caption = 'CRM Originating Branch';
//                 }
//                 field(crmNotes; Rec."CRM Notes")
//                 {
//                     Caption = 'CRM Notes';
//                 }
//                 field(memberNo; Rec."Member No.")
//                 {
//                     Caption = 'Member No.';
//                 }
//                 field(incomingGuarantorMemberNo; '')
//                 {
//                     Caption = 'Incoming Guarantor Member No.';
//                 }
//                 field(outgoingGuarantorMemberNo; '')
//                 {
//                     Caption = 'Outgoing Guarantor Member No.';
//                 }
//                 field(noneAllocated; Rec."Captured By" = '')
//                 {
//                     Caption = 'None allocated';
//                 }
//                 field(sentBackToCRM; Rec."Sent Back to CRM")
//                 {
//                     Caption = 'Sent Back to CRM';
//                 }
//                 field(rejectedBy; Rec."Rejected By")
//                 {
//                     Caption = 'Rejected By';
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
