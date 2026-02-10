// page 52186296 "Delegate Groups Retire Card"
// {
//     DeleteAllowed = false;
//     PageType = Card;
//     SourceTable = "Delegate Group Memb Retirement";

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 field("Code"; Rec.Code)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Delegate Group"; Rec."Delegate Group")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Electoral Zone Code';
//                 }
//                 field("Delegate Group Description"; Rec."Delegate Group Description")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Electoral Zone Description';
//                 }
//                 field("Electoral Zone"; Rec."Electoral Zone")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Region Name';
//                 }
//                 field("Electoral Zone Name"; Rec."Electoral Zone Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Region Name Description';
//                 }
//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(County; Rec.County)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("County Name"; Rec."County Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Sub-County"; Rec."Sub-County")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Sub-County Name"; Rec."Sub-County Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Created By"; Rec."Created By")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Creation Date"; Rec."Creation Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//             part(Control11; "Delegate Retire Members")
//             {
//                 Editable = false;
//                 ApplicationArea = Basic, Suite;
//                 SubPageLink = Code = FIELD("Delegate Group");
//             }
//         }
//     }

//     actions
//     {
//         area(creation)
//         {
//             group("Request Approval")
//             {
//                 Caption = 'Request Approval';
//                 action(SendApprovalRequest)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Send A&pproval Request';
//                     Enabled = NOT OpenApprovalEntriesExist;
//                     Image = SendApprovalRequest;
//                     Promoted = true;
//                     PromotedCategory = Category9;

//                     trigger OnAction()
//                     var
//                         // ApprovalsMgmt: Codeunit 1535;
//                      //   CustomApprovals: Codeunit "Custom Approvals Codeunit";
//                     begin
//                         if not LinesExists then
//                             Error('There are no Lines created for this Document');

//                         VarVariant := Rec;
//                         // if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
//                         //     CustomApprovals.OnSendDocForApproval(VarVariant);
//                     end;
//                 }
//                 action(CancelApprovalRequest)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Cancel Approval Re&quest';
//                     Enabled = OpenApprovalEntriesExist;
//                     Image = Cancel;
//                     Promoted = true;
//                     PromotedCategory = Category9;

//                     trigger OnAction()
//                     var
//                         // ApprovalsMgmt: Codeunit 1535;
//                       //  CustomApprovals: Codeunit "Custom Approvals Codeunit";
//                     begin
//                         VarVariant := Rec;
//                         //CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
//                     end;
//                 }
//             }
//             group(Navigate)
//             {
//                 Caption = 'Navigate';
//                 action(Approvals)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Approvals';
//                     Image = Approvals;
//                     Promoted = true;
//                     PromotedCategory = Category9;

//                     trigger OnAction()
//                     var
//                         //// //ApprovalEntries: Page "Approval Entries";
//                         // ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         /*
//                         DocumentType := DocumentType::"Payment Voucher";
//                         ApprovalEntries.SetRecordFilters(DATABASE::"Payments Header","Document Type","No.");
//                         ApprovalEntries.RUN;
//                         */
//                         //ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId)

//                     end;
//                 }
//             }
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
//                         // ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         //ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId)
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
//                         // ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         //// ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId)
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
//                     RunPageLink = "Table ID" = CONST(52185888),
//                                   "Document No." = FIELD("No. Series");
//                     Visible = OpenApprovalEntriesExistForCurrUser;
//                 }
//             }
//         }
//     }

//     var
//         "NOT OpenApprovalEntriesExist": Boolean;
//         OpenApprovalEntriesExistForCurrUser: Boolean;
//         OpenApprovalEntriesExist: Boolean;
//         VarVariant: Variant;
//         HasLines: Boolean;

//     //[Scope('OnPrem')]
//     procedure LinesExists(): Boolean
//     var
//         PayLines: Record "Payment Line Board";
//     begin
//         HasLines := false;
//         /*
//         PayLines.RESET;
//         PayLines.SETRANGE(PayLines."Document No","Transaction No.");
//          IF PayLines.FIND('-') THEN BEGIN
//             HasLines:=TRUE;
//             EXIT(HasLines);
//          END;
//          */

//     end;
// }

