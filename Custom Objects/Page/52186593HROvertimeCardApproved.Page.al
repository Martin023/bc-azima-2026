// page 52186593 "HR Overtime Card - Approved"
// {
//     Editable = false;
//     PageType = Card;
//     SourceTable = "HR Overtime Header";

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 field("Application Code"; Rec."Application Code")
//                 {
//                 }
//                 field("Application Date"; Rec."Application Date")
//                 {
//                 }
//                 field("Staff No."; Rec."Staff No.")
//                 {
//                 }
//                 field("Staff Name"; Rec."Staff Name")
//                 {
//                 }
//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                 }
//                 field("Weekend Hours"; Rec."Weekend Hours")
//                 {
//                 }
//                 field("Holiday Hours"; Rec."Holiday Hours")
//                 {
//                 }
//                 field("Extra Hours"; Rec."Extra Hours")
//                 {
//                 }
//                 field("Total Overtime Hours"; Rec."Total Overtime Hours")
//                 {
//                 }
//                 field("Convert To?"; Rec."Convert To?")
//                 {
//                 }
//                 field(Converted; Rec.Converted)
//                 {
//                 }
//                 field("Posted to Payroll"; Rec."Posted to Payroll")
//                 {
//                     Visible = false;
//                 }
//             }
//             group("Overtime Details")
//             {
//                 Caption = 'Overtime Details';
//                 part(Control1000000004; "HR Overtime Lines")
//                 {
//                     SubPageLink = "Application Code" = FIELD("Application Code");
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(creation)
//         {
//             action(Approval)
//             {
//                 Caption = 'Approvals';
//                 Image = Approval;
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 var
//                     //ApprovalEntries: Page "Approval Entries";
//                     DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Jobs,"Employee Req",Employees,Promotion,Confirmation,"Employee Transfer","Asset Transfer","Transport Req",Overtime,"Training App","Leave App";
//                 begin
//                     DocumentType := DocumentType::Overtime;
//                     ApprovalEntries.SetRecordFilters(DATABASE::"HR Overtime Header", DocumentType, Rec."Application Code");
//                     ApprovalEntries.Run;
//                 end;
//             }
//         }
//     }

//     var
//         HRSetup: Record "HR Setup";
//         DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation","Overdraft ",BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp;
// }

