// page 52185783 "MBanking Applications"
// {
//     DeleteAllowed = false;
//     PageType = Card;
//     PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
//     SourceTable = "M-SACCO Applications";
//     ApplicationArea = Basic, Suite;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 field(No; Rec.No)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Application Type"; Rec."Application Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Application No"; Rec."Application No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Document Serial No"; Rec."Document Serial No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Document Date"; Rec."Document Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = true;
//                     Enabled = false;
//                 }
//                 field("Account No"; Rec."Account No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Customer ID No"; Rec."Customer ID No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Customer Name"; Rec."Customer Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("MPESA Mobile No"; Rec."MPESA Mobile No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field(Comments; Rec.Comments)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Date Entered"; Rec."Date Entered")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Time Entered"; Rec."Time Entered")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Entered By"; Rec."Entered By")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Withdrawal Limit Code"; Rec."Withdrawal Limit Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = WithLimit;
//                 }
//                 field("Withdrawal Limit Amount"; Rec."Withdrawal Limit Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Responsibility Center"; Rec."Responsibility Center")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Responsibility Center';
//                 }
//             }
//             field("Virtual Registration"; Rec."Virtual Registration")
//             {
//                 ApplicationArea = Basic, Suite;
//             }
//             field("Sent To Server"; Rec."Sent To Server")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Editable = false;
//             }
//             part(Control1102755018; "MBanking Applications Part")
//             {
//                 Editable = true;
//                 SubPageLink = "Application No" = FIELD(No);
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("Function")
//             {
//                 Caption = 'Function';
//                 action("Create MSACCO Application")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Image = Customer;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                         if Rec.Status <> Rec.Status::Approved then
//                             Error('This application has not yet been approved');


//                         if Confirm('Are you sure you would like to Create the application?') = true then begin
//                             //FOSA
//                             MPESAAppDetails.Reset;
//                             MPESAAppDetails.SetRange(MPESAAppDetails."Application No", Rec.No);
//                             MPESAAppDetails.SetRange(MPESAAppDetails."Account Type", MPESAAppDetails."Account Type"::Creditor);
//                             if MPESAAppDetails.Find('-') then begin
//                                 repeat
//                                     Account.Reset;
//                                     Account.SetRange(Account."No.", MPESAAppDetails."Account No.");
//                                     if Account.Find('-') then begin
//                                         Cust.Reset;
//                                         Cust.SetRange("Transactional Mobile No", Rec."MPESA Mobile No");
//                                         if Cust.Find('-') then
//                                             Error('This number has been registered to this %1 account', Cust."No.");

//                                         if Rec."Application Type" = Rec."Application Type"::Initial then begin //Application Type Initial

//                                             if Account."Transactional Mobile No" <> Rec."MPESA Mobile No" then begin

//                                                 if Account."Transactional Mobile No" <> '' then begin
//                                                     Error('The FOSA Account No. ' + Account."No." + ' has already been registered for M-SACCO.');
//                                                     exit;
//                                                 end else begin
//                                                     Account."Transactional Mobile No" := Rec."MPESA Mobile No";
//                                                     Account.Modify;

//                                                     Message('M-SACCO activated for Customer ' + Account.Name + '. The Customer will receive a confirmation SMS shortly.');

//                                                 end;
//                                             end else begin

//                                                 Error('This telephone no already exists in the account');

//                                             end;

//                                         end else begin // Application Type is change

//                                             Account."Transactional Mobile No" := '';
//                                             Account.Modify;

//                                             Message('M-SACCO succesfully de-activated for Customer ' + Account.Name + '.');

//                                         end;

//                                     end;
//                                 until MPESAAppDetails.Next = 0;
//                             end;

//                             /*"App Status":="App Status"::Approved;
//                             "Date Approved":=TODAY;
//                             "Time Approved":=TIME;
//                             "Approved By":=USERID;
//                             MODIFY;*/

//                             //MESSAGE('M-SACCO activated for Customer ' + "Customer Name" + '. The Customer will receive a confirmation SMS shortly.');

//                         end;

//                     end;
//                 }
//                 action("Delete MSACCO Application")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Image = Customer;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                         if Rec.Status <> Rec.Status::Approved then
//                             Error('This application has not yet been approved');

//                         if Confirm('Are you sure you would like to de-link the application?') = true then begin
//                             //FOSA

//                             Account.Reset;
//                             Account.SetRange(Account."No.", Rec."Account No");
//                             if Account.Find('-') then begin

//                                 //IF "Application Type"= "Application Type"::Initial THEN BEGIN //Application Type Initial

//                                 if Account."Transactional Mobile No" <> '' then begin
//                                     Account."Transactional Mobile No" := '';
//                                     Account.Modify;

//                                     Message('M-SACCO de-activated for Customer ' + Account.Name + '.');

//                                 end else begin
//                                     Error('The FOSA Account No. ' + Account."No." + ' has not been registered for M-SACCO.');
//                                     exit;
//                                 end;

//                                 //END ELSE  BEGIN // Application Type is change

//                                 //Account."Transactional Mobile No":='';
//                                 //Account.MODIFY;

//                                 //MESSAGE('M-SACCO succesfully de-activated for Customer ' + Account.Name + '.');

//                                 //END;

//                             end;
//                         end;
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
//                     // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         // ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
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
//                     // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         // // ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
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
//                     // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         // ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
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
//                     Visible = OpenApprovalEntriesExistForCurrUser;
//                 }
//             }
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
//                     // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin

//                         if Rec.Status <> Rec.Status::Open then
//                             Error(DocMustbeOpen);


//                         Rec.TestField("Document Serial No");
//                         Rec.TestField("Document Date");
//                         Rec.TestField("Customer ID No");
//                         Rec.TestField("Customer Name");
//                         Rec.TestField("Responsibility Center");

//                         if Rec."Application Type" = Rec."Application Type"::Initial then begin

//                             Rec.TestField("MPESA Mobile No");
//                             Rec.TestField("Withdrawal Limit Code");
//                             Rec.TestField("Withdrawal Limit Amount");


//                             StrTel := CopyStr(Rec."MPESA Mobile No", 1, 4);

//                             if StrTel <> '+254' then begin
//                                 Error('The MPESA Mobile Phone No. should be in the format +254XXXYYYZZZ.');
//                             end;

//                             if StrLen(Rec."MPESA Mobile No") <> 13 then begin
//                                 Error('Invalid MPESA mobile phone number. Please enter the correct mobile phone number.');
//                             end;

//                             MPESAAppDetails.Reset;
//                             MPESAAppDetails.SetRange(MPESAAppDetails."Application No", Rec.No);
//                             if MPESAAppDetails.Find('-') then begin
//                                 //Check if Id number exists in this account
//                                 Account.Reset;
//                                 Account.SetRange(Account."ID No.", Rec."Customer ID No");
//                                 Account.SetRange(Account."No.", MPESAAppDetails."Account No.");
//                                 if Account.Find('-') then begin

//                                     //Check if Id number exists in this account
//                                     //Check if mpesa telephone number exist in this account

//                                     Account.Reset;
//                                     Account.SetRange(Account."Transactional Mobile No", Rec."MPESA Mobile No");
//                                     Account.SetRange(Account."No.", MPESAAppDetails."Account No.");
//                                     if Account.Find('-') then begin
//                                         Error('Phone No ' + Rec."MPESA Mobile No" + ' already linked to account no ' + MPESAAppDetails."Account No.");
//                                     end
//                                     else begin

//                                         VarVariant := Rec;
//                                         // if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant)
//                                         //   then
//                                         // CustomApprovals.OnSendDocForApproval(VarVariant);
//                                     end;

//                                 end
//                                 else begin

//                                     Error('Id number ' + Rec."Customer ID No" + ' does not exist to account no ' + MPESAAppDetails."Account No.");

//                                 end;

//                             end else begin

//                                 Error('Please select the account to link with the telepnone No.');
//                             end;

//                         end
//                         else begin //Transaction Type Change

//                             VarVariant := Rec;
//                             // if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant)
//                             //   then
//                             // CustomApprovals.OnSendDocForApproval(VarVariant);
//                         end;
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
//                     // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin

//                         if Rec.Status <> Rec.Status::Pending then
//                             Error(DocMustbePending);

//                         VarVariant := Rec;
//                         // CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
//                     end;
//                 }
//                 action(Approvals)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Approvals';
//                     Image = Approvals;

//                     trigger OnAction()
//                     var
//                     //// //ApprovalEntries: Page "Approval Entries";
//                     // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin

//                         // // ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetCurrRecord()
//     begin
//         SetControlAppearance();
//         UpdateControl();
//         Rec."Document Date" := Today;
//     end;

//     trigger OnOpenPage()
//     begin
//         Error('This is an old process');
//     end;

//     var
//         StrTel: Text[30];
//         DocMustbeOpen: Label 'This application must be open';
//         //// //ApprovalEntries: Page "Approval Entries";
//         DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,ImprestSurrender,"MSacco Applications";
//         Account: Record "Savings Accounts";
//         Cust: Record "Savings Accounts";
//         MPESAAppDetails: Record "M-SACCO Application Details";
//         GenJournalLine: Record "Gen. Journal Line";
//         LineNo: Integer;
//         Acct: Record "Savings Accounts";
//         ATMCharges: Decimal;
//         BankCharges: Decimal;
//         GenBatches: Record "Gen. Journal Batch";
//         GLPosting: Codeunit "Gen. Jnl.-Post Line";
//         BankCode: Code[20];
//         PDate: Date;
//         RevFromDate: Date;
//         MPESATRANS: Record Denominations;
//         GenLedgerSetup: Record "General Ledger Setup";
//         MPesaAccount: Code[50];
//         MPesaCharges: Decimal;
//         MPesaChargesAccount: Code[50];
//         MPesaLiabilityAccount: Code[50];
//         TotalCharges: Decimal;
//         TariffHeader: Record "Salary Header";
//         TariffDetails: Record "Banking User Template";
//         Charges: Record "Dividend Simulation Header";
//         TariffCharges: Decimal;
//         DocSNo: Boolean;
//         DocDate: Boolean;
//         CustID: Boolean;
//         CustName: Boolean;
//         MpesaNo: Boolean;
//         Comms: Boolean;
//         WithLimit: Boolean;
//         MpesaPagePart: Boolean;
//         DocMustbePending: Label 'Application must be pending approval';
//         OpenApprovalEntriesExistForCurrUser: Boolean;
//         OpenApprovalEntriesExist: Boolean;
//         VarVariant: Variant;
//         // CustomApprovals: Codeunit "Custom Approvals Codeunit";
//         MpesaApp: Record "M-SACCO Applications";

//     local procedure SetControlAppearance()
//     var
//     // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//     begin

//         // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
//         // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
//     end;

//     //[Scope('OnPrem')]
//     procedure UpdateControl()
//     begin


//         if Rec.Status = Rec.Status::Open then begin

//             DocSNo := true;
//             DocDate := true;
//             CustID := true;
//             CustName := true;
//             MpesaNo := true;
//             Comms := true;
//             WithLimit := true;

//         end;


//         if Rec.Status = Rec.Status::Pending then begin

//             DocSNo := false;
//             DocDate := false;
//             CustID := false;
//             CustName := false;
//             MpesaNo := false;
//             Comms := true;
//             WithLimit := false;
//         end;


//         if Rec.Status = Rec.Status::Rejected then begin
//             DocSNo := false;
//             DocDate := false;
//             CustID := false;
//             CustName := false;
//             MpesaNo := false;
//             Comms := true;
//             WithLimit := false;
//         end;

//         if Rec.Status = Rec.Status::Approved then begin
//             DocSNo := false;
//             DocDate := false;
//             CustID := false;
//             CustName := false;
//             MpesaNo := false;
//             Comms := true;
//             WithLimit := false;

//         end;
//     end;
// }

