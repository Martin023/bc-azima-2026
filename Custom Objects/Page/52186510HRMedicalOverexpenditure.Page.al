// page 52186510 "HR Medical Overexpenditure"
// {
//     PageType = Card;
//     SourceTable = "HR Medical Overexpenditure";

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 field("Application No."; Rec."Application No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Employee No."; Rec."Employee No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Employee Name"; Rec."Employee Name")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Designation; Rec.Designation)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Date; Rec.Date)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Region; Rec.Region)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Department; Rec.Department)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Scheme Provider"; Rec."Scheme Provider")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Amount; Rec.Amount)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Hospital to be paid"; Rec."Hospital to be paid")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Eligible; Rec.Eligible)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             action(Approvals)
//             {
//                 Image = Approval;
//                 Promoted = true;
//                 PromotedCategory = Category4;

//                 trigger OnAction()
//                 begin
//                     DocumentType := DocumentType::MedicalOverexpenditure;
//                     ApprovalEntries.SetRecordFilters(DATABASE::"HR Promo. Recommend Header", DocumentType, Rec."Application No.");
//                     ApprovalEntries.Run;
//                 end;
//             }
//             action("Send Approval Request")
//             {
//                 Image = SendApprovalRequest;
//                 Promoted = true;
//                 PromotedCategory = Category4;

//                 trigger OnAction()
//                 begin

//                     if Confirm('Send this Recommendation for Approval?', true) = false then exit;
//                     // ApprovalMgt.SendappealApprovalRequest(Rec);
//                 end;
//             }
//             action("Cancel approval")
//             {
//                 Image = Cancel;
//                 Promoted = true;
//                 PromotedCategory = Category4;

//                 trigger OnAction()
//                 begin
//                     //ApprovalMgt.CancelAppealApprovalRequest(Rec,TRUE,TRUE);
//                 end;
//             }
//         }
//     }

//     var
//         HREmp: Record "HR Employees";
//         EmpJobDesc: Text[50];
//         HRJobs: Record "HR Jobs";
//         SupervisorName: Text[60];
//         //SMTP: Codeunit "SMTP Mail";
//         URL: Text[500];
//         HRSetup: Record "HR Setup";
//         EmpDept: Text[30];
//         DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Requisition","Transport Requisition",JV,"Grant Task","Concept Note",Proposal,"Job Approval","Disciplinary Approvals",GRN,Clearence,Donation,Transfer,PayChange,Budget,GL,"Cash Purchase","Leave Reimburse",Appraisal,Inspection,Closeout,"Lab Request",ProposalProjectsAreas,"Leave Carry over","IB Transfer",EmpTransfer,LeavePlanner,HrAssetTransfer,EmpConfirmation,EmpPromotion,Appraissalappeal,MedicalOverexpenditure;
//         //ApprovalEntries: Page "Approval Entries";
//         HRLeaveLedgerEntries: Record "HR Leave Ledger Entries";
//         EmpName: Text[70];
//         ApprovalComments: Page "Approval Comments";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         UserSetup: Record "User Setup";
//         varDaysApplied: Integer;
//         ReturnDateLoop: Boolean;
//         mSubject: Text[250];
//         ApplicantsEmail: Text[30];
//         "LineNo.": Integer;
//         sDate: Record Date;
//         Customized: Record "HR Leave Calendar";
//         HREmailParameters: Record "HR E-Mail Parameters";
//         HRJournalBatch: Record "HR Leave Journal Batch";
// }

