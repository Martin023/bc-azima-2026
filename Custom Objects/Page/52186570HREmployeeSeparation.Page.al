// page 52186570 "HR Employee Separation"
// {
//     SourceTable = "HR Employee Separation";
//     UsageCategory = Lists;
//     ApplicationArea = Basic;

//     layout
//     {
//         area(content)
//         {
//             field("Separation No."; Rec."Separation No.")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("Employee No."; Rec."Employee No.")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("Employee Name"; Rec."Employee Name")
//             {
//                 ApplicationArea = Basic;
//             }
//             field(Department; Rec.Department)
//             {

//             }
//             field("Job Title"; Rec."Job Title")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("Nature of Separation"; Rec."Nature of Separation")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("Reason for Separation"; Rec."Reason for Separation")
//             {
//                 ApplicationArea = Basic;
//                 MultiLine = true;
//             }
//             field("Separation Date"; Rec."Separation Date")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("Responsibility Center"; Rec."Responsibility Center")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("Reason for Retirement"; Rec."Reason for Retirement")
//             {
//                 ApplicationArea = Basic;
//                 Visible = false;
//             }
//             field(Illness; Rec.Illness)
//             {

//             }
//             field(Justification; Rec.Justification)
//             {

//                 MultiLine = true;
//             }
//             field(Status; Rec.Status)
//             {

//             }
//             field("End of contract Date"; Rec."End of contract Date")
//             {
//                 ApplicationArea = Basic;
//             }
//         }
//         area(factboxes)
//         {
//             systempart(Control17; Outlook)
//             {
//             }
//             systempart(Control16; Notes)
//             {
//             }
//         }
//     }

//     actions
//     {
//         area(creation)
//         {
//             action(Approvals)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Approvals';
//                 Image = Approvals;
//                 Promoted = true;
//                 PromotedCategory = Category4;

//                 trigger OnAction()
//                 var
//                     DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher",PettyCash,Imprest,Requisition,ImpSurrender,Interbank,Receipt,StaffClaim,"Staff Adv",AdvSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Requisition","Transport Requisition",JV,"Grant Task","Concept Note",Proposal,"Job Approval","Disciplinary Approvals",GRN,Clearence,Donation,Transfer,PayChange,Budget,GL,"Cash Purchase","Leave Reimburse",Appraisal,Inspection,Closeout,"Lab Request",ProposalProjectsAreas,"Leave Carry over","IB Transfer",EmpTransfer,LeavePlanner,HrAssetTransfer,Contract,Project,MR,Inves,PB,Prom,Ind,Conf,BSC,OT,Jobsucc,SuccDetails,Disc,Separation;
//                     //ApprovalEntries: Page "Approval Entries";
//                 begin
//                     DocumentType := DocumentType::Separation;
//                     ApprovalEntries.SetRecordFilters(DATABASE::"HR Employee Separation", DocumentType, Rec."Separation No.");
//                     ApprovalEntries.Run;
//                 end;
//             }
//             action("Send Approval Request")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Send Approval Request';
//                 Image = SendApprovalRequest;
//                 Promoted = true;
//                 PromotedCategory = Category4;

//                 trigger OnAction()
//                 begin
//                     /*TESTFIELD("No of Posts");
//                     TESTFIELD("Responsibility Center");

//                     CALCFIELDS("No. of Requirements");
//                     IF "No. of Requirements" = 0 THEN  ERROR('Please Specify the Job Requirements');
//                      CALCFIELDS("No. of Responsibilities");

//                     IF "No. of Responsibilities" = 0 THEN ERROR('Please Specify the Job Responsibilities');
//                       */
//                     if Confirm('Send this Document for Approval?', true) = false then exit;
//                     //   AppMgmt.SendQualifiedAplicantApprovalReq(Rec);

//                 end;
//             }
//             action("Cancel Approval Request")
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Cancel Approval Request';
//                 Image = CancelAllLines;
//                 Promoted = true;
//                 PromotedCategory = Category4;

//                 trigger OnAction()
//                 begin
//                     if Confirm('Cancel Approval Request?', true) = false then exit;
//                     //AppMgmt.CancelEmpChangeDetailsRequest(Rec,TRUE,TRUE);
//                 end;
//             }
//         }
//     }

//     var
//         HREmployees: Record "HR Employees";
// }

