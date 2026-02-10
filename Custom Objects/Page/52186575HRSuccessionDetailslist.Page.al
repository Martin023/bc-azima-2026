// page 52186575 "HR Succession Details list"
// {
//     CardPageID = "HR Succession Details";
//     PageType = List;
//     SourceTable = "HR Jobs to Succeed";
//     SourceTableView = SORTING("Job ID")
//                       WHERE(Status = FILTER(Approved));
//     UsageCategory = Lists;
//     ApplicationArea = Basic;

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Job ID"; Rec."Job ID")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Description; Rec.Description)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Department; Rec.Department)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Availability; Rec.Availability)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Comment; Rec.Comment)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("No of Posts"; Rec."No of Posts")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Position Reporting to"; Rec."Position Reporting to")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Responsibility Center"; Rec."Responsibility Center")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Status; Rec.Status)
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
//             group(Succession)
//             {
//                 Caption = 'Succession';
//                 action(Approvals)
//                 {
//                     ApplicationArea = Basic;
//                     Image = Approvals;
//                     Promoted = true;
//                     PromotedCategory = Category4;

//                     trigger OnAction()
//                     begin
//                         /*DocumentType:=DocumentType::EmpConfirmation;
//                         ApprovalEntries.SetRecordFilters(DATABASE::"HR Employee Confirmation",DocumentType,No);
//                         ApprovalEntries.RUN;
//                             */

//                     end;
//                 }
//                 action("Send Approval Request")
//                 {
//                     ApplicationArea = Basic;
//                     Image = SendApprovalRequest;
//                     Promoted = true;
//                     PromotedCategory = Category4;

//                     trigger OnAction()
//                     begin
//                         /*//TESTFIELDS;

//                         IF CONFIRM('Send this Application for Approval?',TRUE)=FALSE THEN EXIT;

//                         ApprovalMgt.SendEmpConfirmationApprovalReq(Rec);
//                                */

//                     end;
//                 }
//                 action("Cancel Approvals")
//                 {
//                     ApplicationArea = Basic;
//                     Image = Cancel;
//                     Promoted = true;
//                     PromotedCategory = Category4;

//                     trigger OnAction()
//                     begin
//                         //ApprovalMgt.CancelEmpConfirmationAppRequest(Rec,TRUE,TRUE);
//                     end;
//                 }
//             }
//         }
//     }
// }

