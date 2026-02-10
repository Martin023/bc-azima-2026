// page 52187410 "Refunds And Account Transfer"
// {
//     //DeleteAllowed = false;
//     PageType = Card;
//     SourceTable = "Account Transfer Header";
//     PromotedActionCategories = 'New,Process,Reports,Workflow Actions';

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field(No; Rec.No)
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Transaction Type"; Rec."Transaction Type")
//                 {
//                     Editable = HeaderA;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Member No"; Rec."Member No")
//                 {
//                     Editable = HeaderA;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Transfer Type"; Rec."Transfer Type")
//                 {
//                     Editable = HeaderA;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Responsibility Center"; Rec."Responsibility Center")
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Remarks; Rec.Remarks)
//                 {
//                     Editable = HeaderA;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Posted; Rec.Posted)
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Status; rec.Status)
//                 {
//                     Editable = true;
//                     ApplicationArea = Basic, Suite;

//                     // trigger OnValidate()
//                     // begin
//                     //     AControl;
//                     // end;
//                 }
//                 field("Created By"; Rec."Created By")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Transaction Date"; Rec."Transaction Date")
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Transaction Time"; Rec."Transaction Time")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Total Debits"; Rec."Total Debits")
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;

//                 }
//                 field("Total Credits"; Rec."Total Credits")
//                 {
//                     Editable = false;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Rejection Reason"; Rec."Rejection Reason")
//                 {
//                     Enabled = RejectApproved;
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//             group(Control17)
//             {
//                 ShowCaption = false;

//                 part("Account Transfers-Source [ Debit ]"; "Account Transfer Source")
//                 {
//                     Caption = 'Account Transfers-Source [ Debit ]';
//                     Editable = SourceA;
//                     SubPageLink = "No." = FIELD(No);
//                     ApplicationArea = Basic, Suite;
//                 }
//                 part("Account Transfers-Destination [ Credit ]"; "Account Transfer Destination")
//                 {
//                     Caption = 'Account Transfers-Destination [ Credit ]';
//                     Editable = DestinationA;
//                     SubPageLink = "No." = FIELD(No);
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             group(Posting)
//             {
//                 Caption = 'Posting';
//                 action(Post)
//                 {
//                     Caption = 'Post';
//                     Image = Post;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ApplicationArea = Basic, Suite;

//                     trigger OnAction()
//                     begin
//                         if rec.Status <> rec.Status::Approved then
//                             Error(DocMustbeApproved);


//                         //CalcCharges;

//                         AccountTransferSource.Reset;
//                         AccountTransferSource.SetRange(AccountTransferSource."No.", rec.No);
//                         AccountTransferSource.SetRange(AccountTransferSource."Source Account Type", AccountTransferSource."Source Account Type"::Savings);
//                         if AccountTransferSource.Find('-') then begin
//                             repeat
//                                 AvailableBalance := 0;
//                                 MinBalance := 0;

//                                 if Account.Get(AccountTransferSource."Source Account No.") then begin
//                                     Account.CalcFields(Account.Balance, Account."Uncleared Cheques", Account."Authorised Over Draft");

//                                     ProdType.Reset;
//                                     ProdType.SetRange(ProdType."Product ID", Account."Product Type");
//                                     if ProdType.Find('-') then begin
//                                         MinBalance := ProdType."Minimum Balance";

//                                         AvailableBalance := (Account.Balance + Account."Authorised Over Draft") - (MinBalance + Account."Uncleared Cheques"/*+TChargeAmount*/);
//                                         if AccountTransferSource."Source Amount" > AvailableBalance then
//                                             Error('Amount cannot be more than the avaiable balance of %1', AvailableBalance);

//                                     end;
//                                 end;
//                             until AccountTransferSource.Next = 0;
//                         end;
//                         //Mark Transaction Posted...
//                         //IF AccountTransferHeader.GET(No) THEN
//                         AccountTransferHeader.Reset;
//                         AccountTransferHeader.SetRange(AccountTransferHeader.No, Rec.No);
//                         if AccountTransferHeader.Find('-') then
//                             SavingsLedgerEntry.Reset;
//                         SavingsLedgerEntry.SetRange("Document No.", AccountTransferHeader.No);
//                         if SavingsLedgerEntry.Find('-') then begin
//                             Message('This Requisition is already paid');
//                             AccountTransferHeader.Posted := true;
//                             AccountTransferHeader.Modify;
//                             exit;
//                         end;
//                         SaccoT.PostTransfers(Rec);

//                     end;
//                 }
//                 action(Print)
//                 {
//                     Caption = 'Print';
//                     Image = Print;
//                     ApplicationArea = Basic, Suite;

//                     trigger OnAction()
//                     begin
//                         /*BTRANS.RESET;
//                         BTRANS.SETRANGE(BTRANS.No,No);
//                         IF BTRANS.FIND('-') THEN BEGIN
//                         //REPORT.Run(52185861,TRUE,TRUE,BTRANS);
//                         END;
//                         */

//                     end;
//                 }
//                 action("Import")
//                 {
//                     Image = Import;
//                     ApplicationArea = Basic, Suite;
//                     RunObject = xmlport "Refund & Account Transfer";

//                 }
//             }
//             group(Approval)
//             {
//                 Caption = 'Approval';
//                 action(Approve)
//                 {
//                     Caption = 'Approve';
//                     Image = Approve;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Visible = OpenApprovalEntriesExistForCurrUser;
//                     ApplicationArea = Basic, Suite;

//                     // trigger OnAction()
//                     // var
//                     //     // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     // begin
//                     //     ApprovalsMgmt.ApproveRecordApprovalRequest(RecordId);
//                     // end;
//                 }
//                 action(Reject)
//                 {
//                     Caption = 'Reject';
//                     Image = Reject;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Visible = OpenApprovalEntriesExistForCurrUser;
//                     ApplicationArea = Basic, Suite;

//                     // trigger OnAction()
//                     // var
//                     //     // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     // begin
//                     //     // ApprovalsMgmt.RejectRecordApprovalRequest(RecordId);
//                     // end;
//                 }
//                 action(Delegate)
//                 {
//                     Caption = 'Delegate';
//                     Image = Delegate;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     Visible = OpenApprovalEntriesExistForCurrUser;
//                     ApplicationArea = Basic, Suite;

//                     // trigger OnAction()
//                     // var
//                     //     // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     // begin
//                     //     ApprovalsMgmt.DelegateRecordApprovalRequest(RecordId);
//                     // end;
//                 }
//                 action("Re-Open ")
//                 {
//                     Image = ReOpen;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ApplicationArea = Basic, Suite;

//                     trigger OnAction()
//                     begin
//                         if rec.Status = rec.Status::Approved then begin
//                             rec.Status := rec.Status::Open;
//                             rec.Modify;
//                             Message('Document open successfuly');
//                         end;
//                     end;
//                 }
//                 action(Comment)
//                 {
//                     Caption = 'Comments';
//                     Image = ViewComments;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     // RunObject = Page "Approval Comments";
//                     // Visible = OpenApprovalEntriesExistForCurrUser;
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//             group("Request Approval")
//             {
//                 Caption = 'Request Approval';
//                 action(SendApprovalRequest)
//                 {
//                     Caption = 'Send A&pproval Request';
//                     Enabled = NOT OpenApprovalEntriesExist;
//                     Image = SendApprovalRequest;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     ApplicationArea = Basic, Suite;

//                     trigger OnAction()
//                     var
//                     // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin

//                         if rec.Status <> rec.Status::Open then
//                             Error(DocMustbeOpen);

//                         rec.TestField(rec."Transaction Type");


//                         rec.CalcFields(rec."Total Credits", rec."Total Debits");
//                         if rec."Total Credits" <> rec."Total Debits" then
//                             Error(AmountErrorTxt);

//                         rec."Created By" := UserId;
//                         rec."Transaction Date" := Today;
//                         rec."Transaction Time" := Time;
//                         rec.Modify;


//                         VarVariant := Rec;
//                         if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
//                             CustomApprovals.OnSendDocForApproval(VarVariant);
//                     end;
//                 }
//                 action(CancelApprovalRequest)
//                 {
//                     Caption = 'Cancel Approval Re&quest';
//                     Enabled = OpenApprovalEntriesExist;
//                     Image = Cancel;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     ApplicationArea = Basic, Suite;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin

//                         if rec.Status <> rec.Status::"Pending Approval" then
//                             Error(DocMustbePending);

//                         VarVariant := Rec;
//                         CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
//                     end;
//                 }
//                 action(Approvals)
//                 {
//                     Caption = 'Approvals';
//                     Image = Approvals;
//                     ApplicationArea = Basic, Suite;

//                     // trigger OnAction()
//                     // var
//                     //     // //ApprovalEntries: Page "Approval Entries";
//                     //     // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     // begin

//                     //     approvalsMgmt.OpenApprovalEntriesPage(RecordId);
//                     // end;
//                 }
//                 action("Reject Approved Document")
//                 {
//                     Image = RemoveLine;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Visible = RejectApproved;
//                     ApplicationArea = Basic, Suite;

//                     trigger OnAction()
//                     begin
//                         if DelChr(rec."Rejection Reason", '=', ' ') = '' then Error('Specify reason for rejection');
//                         rec.TestField(rec.Status, rec.Status::Approved);
//                         rec.TestField(rec.Posted, false);
//                         rec.TestField(rec."Rejection Reason");
//                         if Confirm('Do you want to reject the document?') then begin
//                             rec.Status := rec.Status::Rejected;
//                             rec.Modify;
//                         end;
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetCurrRecord()
//     begin
//         AControl;
//         // SetControlAppearance;
//     end;

//     trigger OnAfterGetRecord()
//     begin
//         // SetControlAppearance;
//     end;

//     var
//         users: Record User;
//         GenJournalLine: Record "Gen. Journal Line";
//         DefaultBatch: Record "Gen. Journal Batch";
//         BSched: Record "Account Transfer Source";
//         BTRANS: Record "Account Transfer Header";
//         DActivity: Code[20];
//         DBranch: Code[20];
//         UsersID: Record User;
//         BSchedDestin: Record "Account Transfer Destination";
//         BSchedPch: Record "Account Transfer Source";
//         OpenApprovalEntriesExistForCurrUser: Boolean;
//         OpenApprovalEntriesExist: Boolean;
//         VarVariant: Variant;
//         CustomApprovals: Codeunit "Custom Approvals Codeunit";
//         DocMustbeOpen: Label 'This application request must be open';
//         DocMustbePending: Label 'This application request must be Pending';
//         SaccoT: Codeunit "Sacco Transactions";
//         DocMustbeApproved: Label 'This document must be approved before posting';
//         HeaderA: Boolean;
//         SourceA: Boolean;
//         DestinationA: Boolean;
//         AmountErrorTxt: Label 'Check compliance to contra Entry.';
//         AccountTransferHeader: Record "Account Transfer Header";
//         SavingsLedgerEntry: Record "Savings Ledger Entry";
//         AvailableBalance: Decimal;
//         MinBalance: Decimal;
//         Account: Record "Savings Accounts";
//         AccountTransferSource: Record "Account Transfer Source";
//         ProdType: Record "Product Factory";
//         RejectApproved: Boolean;

//     // local procedure SetControlAppearance()
//     // var
//     //     // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//     // begin

//     // //    OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RecordId);
//     //     OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
//     // end;

//     //[Scope('OnPrem')]
//     procedure AControl()
//     begin
//         case rec.Status of
//             rec.Status::Open:
//                 begin
//                     SourceA := true;
//                     DestinationA := true;
//                     HeaderA := true;
//                 end;

//             rec.Status::"Pending Approval", rec.Status::Approved, rec.Status::Rejected:
//                 begin
//                     SourceA := false;
//                     DestinationA := false;
//                     HeaderA := false;
//                 end;
//         end;

//         if (rec.Status = rec.Status::Approved) and (rec.Posted = false) then
//             RejectApproved := true
//         else
//             RejectApproved := false;
//     end;
// }

