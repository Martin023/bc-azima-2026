// page 52186310 "Delegate Region App Card"
// {
//     PageType = Card;
//     SourceTable = "Delegate Groups Application";

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
//                 field("Delegate Group Description"; Rec."Delegate Group Description")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Electoral Zone"; Rec."Electoral Zone")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Electoral Zone Name"; Rec."Electoral Zone Name")
//                 {
//                     ApplicationArea = Basic, Suite;
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
//                 field("Created By"; Rec."Created By")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Creation Date"; Rec."Creation Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Created; Rec.Created)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//             part(Control11; "Delegate Members Applications")
//             {
//                 SubPageLink = Code = FIELD(Code);
//             }
//         }
//     }

//     actions
//     {
//         area(creation)
//         {
//             action(Approve)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Approve';
//                 Image = Approve;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 PromotedIsBig = true;
//                 Visible = OpenApprovalEntriesExistForCurrUser;

//                 trigger OnAction()
//                 var
//                 // ApprovalsMgmt: Codeunit 1535;
//                 begin
//                     // ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
//                 end;
//             }
//             separator(Action21)
//             {
//             }
//             action(SendApprovalRequest)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Send A&pproval Request';
//                 Enabled = NOT OpenApprovalEntriesExist;
//                 Image = SendApprovalRequest;
//                 Promoted = true;
//                 PromotedCategory = Category9;

//                 trigger OnAction()
//                 var
//                 //  ApprovalsMgmt: Codeunit 1535;
//                 begin
//                     VarVariant := Rec;
//                     // if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
//                     //     CustomApprovals.OnSendDocForApproval(VarVariant);
//                 end;
//             }
//             action(CancelApprovalRequest)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Cancel Approval Re&quest';
//                 Enabled = OpenApprovalEntriesExist;
//                 Image = Cancel;
//                 Promoted = true;
//                 PromotedCategory = Category9;

//                 trigger OnAction()
//                 var
//                 // ApprovalsMgmt: Codeunit 1535;
//                 begin
//                     // VarVariant := Rec;
//                     // CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
//                 end;
//             }
//             action(Approvals)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Approvals';
//                 Image = Approvals;

//                 trigger OnAction()
//                 var
//                 //// //ApprovalEntries: Page "Approval Entries";
//                 // approvalsMgmt: Codeunit 1535;
//                 begin
//                     //  // ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
//                 end;
//             }
//         }
//     }

//     var
//         OpenApprovalEntriesExistForCurrUser: Boolean;
//         OpenApprovalEntriesExist: Boolean;
//         VarVariant: Variant;
//     //    CustomApprovals: Codeunit "Custom Approvals Codeunit";
// }

