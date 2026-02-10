// page 52187032 "SinkFund Notice Risk Claim"
// {
//     Caption='Risk Claim';
//     DeleteAllowed = false;
//     PageType = Card;
//     PromotedActionCategories = 'New,Process,Report,Print,,,,,Approvals';

//     SourceTable = "SinkFund Report Information";


//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 // Editable = ApprovedEdit;
//                 field(No; Rec.No)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field(Date; Rec.Date)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Member No"; Rec."Member No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Member Name"; Rec."Member Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Reported By Name"; Rec."Reported By Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Reported By ID No"; Rec."Reported By ID No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Reported By Relationship"; Rec."Reported By Relationship")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Date of Death"; Rec."Date of Death")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Exclude Loans and Deposits"; Rec."Exclude Loans and Deposits")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Claim Option"; Rec."Claim Option")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Deceased Person"; Rec."Deceased Person")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = true;
//                 }
//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Responsibily Center"; Rec."Responsibily Center")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Captured By"; Rec."Captured By")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Savings Balance"; Rec."Savings Balance")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Total Outstanding Loan"; Rec."Total Outstanding Loan")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Total Outstanding Interest"; Rec."Total Outstanding Interest")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Benevolent Claim Amount"; Rec."Benevolent Claim Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Sacco Income Recovable"; Rec."Sacco Income Recovable")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Total Net Amount"; Rec."Total Net Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Insurance Payment Status"; Rec."Insurance Payment Status")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Sms Sent"; Rec."Sms Sent")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Sms Request Reason"; Rec."Sms Request Reason")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = true;
//                 }
//                 group(Documents)
//                 {
//                     Caption = 'Documents';
//                     // Editable = ApprovedEdit;
//                     field("Request Letter"; Rec."Request Letter")
//                     {
//                         ApplicationArea = Basic, Suite;
//                     }
//                     field("ID Copy Of Claimnant"; Rec."ID Copy Of Claimnant")
//                     {
//                         ApplicationArea = Basic, Suite;
//                     }
//                     field("ID Copy Deceased"; Rec."ID Copy Deceased")
//                     {
//                         ApplicationArea = Basic, Suite;
//                     }
//                     field("Birth Certificate"; Rec."Birth Certificate")
//                     {
//                         ApplicationArea = Basic, Suite;
//                     }
//                     field("Stamped Burial Permitt"; Rec."Stamped Burial Permitt")
//                     {
//                         ApplicationArea = Basic, Suite;
//                     }
//                     field("Employer Letter"; Rec."Employer Letter")
//                     {
//                         ApplicationArea = Basic, Suite;
//                     }
//                     field("Chief's Letter"; Rec."Chief's Letter")
//                     {
//                         ApplicationArea = Basic, Suite;
//                     }
//                     field("Death Certificate"; Rec."Death Certificate")
//                     {
//                         ApplicationArea = Basic, Suite;
//                     }
//                     field(PaySlip; Rec.PaySlip)
//                     {
//                         ApplicationArea = Basic, Suite;
//                     }
//                     field("Marriage Certificate/Affidavit"; Rec."Marriage Certificate/Affidavit")
//                     {
//                         ApplicationArea = Basic, Suite;
//                     }
//                     FIELD("Claim Type"; Rec."Claim Type")
//                     {

//                     }
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             group("&Functions")
//             {
//                 Caption = '&Functions';
//                 action(Post)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Image = PostBatch;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     var
//                         //RunPeriodicTrans: Codeunit "Sacco Transactions";
//                         SinkFund: Record "SinkFund Report Information";
//                         GenJnlLine: Record "Gen. Journal Line";
//                         DefaultBatch: Record "Gen. Journal Batch";
//                         CashierLinks: Record "Cash Office User Template";
//                         LineNo: Integer;
//                         Temp: Record "Cash Office User Template";
//                         JTemplate: Code[10];
//                         JBatch: Code[10];
//                         Post: Boolean;
//                         strText: Text[100];
//                         CashOfficeSetup: Record "Cash Office Setup";
//                         BankLed: Record "Cust. Ledger Entry";
//                     begin

//                         Rec.TestField(Rec.Status, Rec.Status::Approved);
//                         PostClaim(Rec);
//                     end;

//                 }
//                 action("Send Update Reques SMS")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Send Update Reques SMS';
//                     Image = "Report";
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     var
//                         Account: Record Members;
//                         Text0001: Label 'Dear Member,We acknowledge receipt of your claim,kindly visit any of our branches to update accounts details to allow processing of your claim. Harambee Sacco';
//                     begin
//                         if Confirm('Do you want to send SMS notifications to Member?', false) = true then begin
//                             PayLine.Reset;
//                             PayLine.SetRange(PayLine.No, Rec.No);
//                             PayLine.SetRange("Sms Sent", false);
//                             PayLine.SetRange(Posted, false);
//                             if PayLine.Find('-') then begin
//                                 if Account.Get(PayLine."Member No") then begin
//                                     SendSms.SendSms(SourceType::Delegate, Account."Phone No.", Text0001
//                                     , Account."No.", Rec.No, true);
//                                     Rec."Sms Sent" := true;
//                                     Rec.Modify;
//                                 end;
//                             end;
//                         end;
//                         Message('Notification successfully sent');
//                     end;
//                 }
//                 action("Mandatory Requirements")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Image = RegisteredDocs;
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     PromotedIsBig = true;
//                     RunObject = Page "Required Documents";
//                     RunPageLink = "Document No." = FIELD(No);
//                 }
//                 action("ReOpen Document")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'ReOpen Document';
//                     Image = ReOpen;
//                     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedCategory = Category9;

//                     trigger OnAction()
//                     var
//                         MsgOnDoc: Label 'Document has been Opened. Please send approval request before you can continue.';
//                     begin
//                         Rec.Status := Rec.Status::Open;
//                         Rec.Modify;
//                     end;
//                 }
//                 action("Cancel Document")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Cancel Document';
//                     Image = Cancel;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     var
//                         Text000: Label 'Are you sure you want to cancel this Document?';
//                         Text001: Label 'You have selected not to Cancel the Document';
//                     begin
//                     end;
//                 }
//                 action("Send Deferred SMS")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Image = MiniForm;
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     begin
//                         Rec.TestField("Member No");
//                         //MyComment := Window.InputBox('Type the Message you want to send to ' + "Member Name", 'account:' + "Member No", '', 100, 100);
//                         if MyComment = '' then Error('Type the Message you want to send');
//                         if Confirm('Do you want to send Deferred SMS to Member?', false) = true then begin
//                             if Members.Get(Rec."Member No") then begin
//                                 //if Members."Phone No." <> '' then
//                                 //SendSMS.SendSms(SourceTypes::"Account Rec.Status", Members."Phone No.", 'Dear member, your claim has been deferred:- ' + MyComment, No, "Member No", true);
//                             end;
//                         end;
//                     end;
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
//                     // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     //CustomApprovals: Codeunit "Custom Approvals Codeunit";
//                     begin
//                         BBFEntitlement.Get(Rec."Claim Option");
//                         NextofKIN.Reset;
//                         NextofKIN.SetRange("Record ID", Rec."Member No");
//                         // NextofKIN.SetRange("Identification Type", NextofKIN."Identification Type"::);
//                         if NextofKIN.IsEmpty then
//                             Error(Err0001);

//                         if Rec."Claim Option" <> 'PRINCIPAL MEMBER' then begin
//                             ImageData.Reset;
//                             ImageData.SetRange(ImageData."Member No", Rec."Member No");
//                             if ImageData.Find('-') then begin
//                                 ImageData.CalcFields(ImageData.Picture, ImageData.Signature);
//                                 if not ImageData.Picture.HasValue then
//                                     Error('Kindly capture the member photo before proceeding');
//                                 if not ImageData.Signature.HasValue then
//                                     Error('Kindly Signature sample of the member before proceeding');
//                             end;
//                         end;

//                         Rec.TestField("Reported By ID No");
//                         Rec.TestField("Reported By Name");
//                         Rec.TestField("Reported By Relationship");
//                         Rec.TestField("Request Letter");
//                         Rec.TestField("ID Copy Of Claimnant");
//                         Rec.TestField("Employer Letter");
//                         Rec.TestField("Chief's Letter");
//                         Rec.TestField(PaySlip);
//                         // if BBFEntitlement.Minor = false then begin Testfield(PaySlip); Rec.if ("Claim Option" = 'SPOUSE') then TestField("Marriage Certificate/Affidavit") end;
//                         // if BBFEntitlement.Minor = true then TestField("Birth Certificate");
//                         /*TESTFIELD("Death Certificate");*/
//                         Rec.TestField("Member No");
//                         Rec.TestField("Date of Death");
//                         Rec.TestField("Claim Option");

//                         if Members.Get(Rec."Member No") then begin
//                             if Members."Phone No." <> '' then
//                                 //SendSMSS.SendSms(SourceTypes::"Account Rec.Status", Members."Phone No.", 'Dear member, we are in receipt of your sink fund claim. ' +
//                                 //'You will be notified when the refund is ready.', No, "Member No", true);
//                                 //end;

//                                 VarVariant := Rec;
//                             // if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
//                             //     CustomApprovals.OnSendDocForApproval(VarVariant);

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
//                     // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     //CustomApprovals: Codeunit "Custom Approvals Codeunit";
//                     begin
//                         Rec.TestField(Posted, false);
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
//                     // //ApprovalEntries: Page "Approval Entries";
//                     // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         // ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
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
//                     // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
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
//                     // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
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
//                     // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
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
//                     // RunPageLink = "Table ID" = CONST(52185888),
//                     //"Document No." = FIELD("No. Series");
//                     Visible = OpenApprovalEntriesExistForCurrUser;
//                 }
//                 action("Re-Open Document")
//                 {
//                     ApplicationArea = Basic, Suite;

//                     trigger OnAction()
//                     begin
//                         if Rec.Status = Rec.Status::Approved then begin
//                             if Confirm('Are you sure you want to re-open this document?', false) = true then begin
//                                 Rec.Status := Rec.Status::Open;
//                                 Rec.Modify;
//                             end;
//                         end;
//                     end;
//                 }
//                 action("Member Card")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Image = CreditCard;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = Page "Member Single";
//                     RunPageLink = "No." = FIELD("Member No");
//                 }
//                 action("Print Claim")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Image = Print;
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     begin
//                         Rec.Reset;
//                         //Rec.SetFilter(Rec.No);
//                         REPORT.Run(52185998, true, true, Rec);
//                         Rec.Reset;
//                     end;
//                 }
//             }
//             action("Next of KIN")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Image = Relationship;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 RunObject = Page 52185729;
//                 // RunPageLink = "Account No" = FIELD("Member No"),
//                 //               Type = FILTER("Next of Kin" | Spouse | "Benevolent Beneficiary");
//             }
//             separator(Action61)
//             {
//             }
//             action("Family Member")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Sinkfund Members';
//                 Image = Relationship;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 // RunObject = Page "Family Member";
//                 //                 RunPageLink = "Account No" = FIELD("Member No");
//             }
//         }
//     }


//     trigger OnAfterGetCurrRecord()
//     begin
//         SetControlAppearance;
//     end;

//     trigger OnAfterGetRecord()
//     begin
//         SetControlAppearance;
//     end;

//     trigger OnModifyRecord(): Boolean
//     begin
//         if Rec.Status <> Rec.Status::Open then
//             Error('Status must be Open');
//     end;

//     trigger OnOpenPage()
//     begin
//         //IF Rec.Status<>Status::Open THEN
//         //  CurrPage.EDITABLE:=FALSE;
//         SetControlAppearance;
//         Rec."Claim Type" := Rec."Claim Type"::"Risk Claim";

//     end;


//     //[RunOnClient]
//     //Window: DotNet Interaction;

//     //[Scope('OnPrem')]
//     procedure PostClaim(Rec: Record "SinkFund Report Information")
//     var
//         BankLed: Record "Cust. Ledger Entry";
//     begin
//         BankLed.Reset;
//         BankLed.SetRange("Document No.", Rec.No);
//         BankLed.SetRange(BankLed."Posting Date", Rec."Date Posted");
//         if BankLed.Find('-') then begin
//             Rec.Posted := true;
//             Rec."Posted By" := UserId;
//             Rec."Date Posted" := Today;
//             Rec.Modify;
//             Message('Transaction Posted succesfully');
//             exit;
//         end;
//         Temp.Get(UserId);

//         JTemplate := Temp."Receipt Journal Template";
//         JBatch := Temp."Receipt Journal Batch";

//         if JTemplate = '' then begin
//             Error('Ensure the Loans Template is set up in Banking User Setup');
//         end;
//         if JBatch = '' then begin
//             Error('Ensure the Loans Batch is set up in Banking User Setup')
//         end;


//         GenJnlLine.Reset;
//         GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
//         GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
//         GenJnlLine.DeleteAll;
//         CashOfficeSetup.Get();


//         LineNo := LineNo + 1000;
//         GenJnlLine.Init;
//         GenJnlLine."Journal Template Name" := JTemplate;
//         GenJnlLine."Journal Batch Name" := JBatch;
//         GenJnlLine."Line No." := LineNo;
//         GenJnlLine."Source Code" := 'PAYMENTJNL';
//         GenJnlLine."Posting Date" := Today;
//         GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
//         GenJnlLine."Document No." := Rec.No;
//         GenJnlLine."External Document No." := Rec.No + '-' + Rec."Member No";
//         GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
//         GenJnlLine."Account No." := CashOfficeSetup."Insurance Receivable Claim";
//         GenJnlLine.Validate(GenJnlLine."Account No.");
//         //CALCFIELDS("Total Net Amount");
//         GenJnlLine.Amount := Rec."Total Net Amount";
//         GenJnlLine.Validate(GenJnlLine.Amount);
//         GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
//         GenJnlLine."Bal. Account No." := '';
//         //CashOfficeSetup."Insurance Claim Received";
//         //GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
//         GenJnlLine.Description := CopyStr('Sinkfund Claim: ' + Rec."Member No" + ':' + Rec."Deceased Person", 1, 50);
//         GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
//         GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
//         GenJnlLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
//         GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");

//         if GenJnlLine.Amount <> 0 then
//             GenJnlLine.Insert;
//         LineNo := LineNo + 1000;
//         GenJnlLine.Init;
//         GenJnlLine."Journal Template Name" := JTemplate;
//         GenJnlLine."Journal Batch Name" := JBatch;
//         GenJnlLine."Line No." := LineNo;
//         GenJnlLine."Source Code" := 'PAYMENTJNL';
//         GenJnlLine."Posting Date" := Today;
//         GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
//         GenJnlLine."Document No." := Rec.No;
//         GenJnlLine."External Document No." := Rec.No + '-' + Rec."Member No";
//         GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
//         GenJnlLine."Account No." := CashOfficeSetup."Insurance Claim Received";
//         GenJnlLine.Validate(GenJnlLine."Account No.");
//         //CALCFIELDS("Total Net Amount");
//         GenJnlLine.Amount := (Rec."Total Net Amount" * -1);
//         GenJnlLine.Validate(GenJnlLine.Amount);
//         GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
//         GenJnlLine."Bal. Account No." := '';
//         //CashOfficeSetup."Insurance Claim Received";
//         //GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
//         GenJnlLine.Description := CopyStr('Sinkfund Claim: ' + Rec."Member No" + ':' + Rec."Deceased Person", 1, 50);
//         GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
//         GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
//         GenJnlLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
//         GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");

//         if GenJnlLine.Amount <> 0 then
//             GenJnlLine.Insert;

//         GenJnlLine.Reset;
//         GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
//         GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
//         //CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);

//         Post := false;
//         //Post := JournlPosted.PostedSuccessfully();
//         if Post then begin
//             Rec.Posted := true;
//             Rec."Posted By" := UserId;
//             Rec."Date Posted" := Today;
//             Rec."Insurance Payment Status" := Rec."Insurance Payment Status"::"Pending Payment";
//             Rec.Modify;
//             /*IF Members.GET("Member No") THEN BEGIN

//             CompanyInformation.GET();
//               SendSMSS.SendSms(SourceTypes::"Account Rec.Status",Members."Phone No.",'Dear member, we are in receipt of your sink fund claim. '+
//                  'You will be notified when the refund is ready.',No,"Member No",TRUE);

//             //SinkFindDeseased("Claim Option",Members);
//             END;*/
//             // Members.RESET;
//             // Members.SETRANGE("No.",Rec."Member No");
//             // IF Members.FIND('-') THEN BEGIN
//             // IF "Claim Option"='PRINCIPAL MEMBER' THEN
//             // Members.Status:=Members.Status::Deceased;
//             // Members.MODIFY;
//             //
//             // END;
//         end;

//     end;

//     //[Scope('OnPrem')]
//     procedure SetControlAppearance()
//     var
//     // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//     begin
//         //    OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
//         // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);

//         if Rec.Status = Rec.Status::Open then
//             CurrPage.Editable := true else
//             CurrPage.Editable := false;


//         case Rec.Status of
//             Rec.Status::Open:
//                 begin
//                     ApplicationDetailsEdit := true;
//                     ApprovedEdit := true;
//                 end;

//             Rec.Status::Approved:
//                 begin
//                     ApprovedEdit := false;
//                     ApplicationDetailsEdit := false;
//                 end;
//             Rec.Status::Pending:
//                 begin
//                     ApprovedEdit := false;
//                     ApplicationDetailsEdit := false;
//                 end;
//             Rec.Status::Rejected:
//                 begin
//                     ApprovedEdit := false;
//                     ApplicationDetailsEdit := false;
//                 end;
//         end;
//     end;

//     local procedure SinkFindDeseased(ClaimType: Code[30]; Members: Record Members)
//     var
//         BBFEntitlement: Record "BBF Entitlement";
//     begin

//         BBFEntitlement.Reset;
//         BBFEntitlement.SetRange(Code, ClaimType);
//         BBFEntitlement.SetRange(Self, true);
//         if BBFEntitlement.FindFirst then begin
//             Members.Status := Members.Status::Deceased;
//             Members.Modify;
//         end;
//     end;


//     var
//         // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//         //CustomApprovals: Codeunit "Custom Approvals Codeunit";
//         "NOT OpenApprovalEntriesExist": Boolean;
//         OpenApprovalEntriesExistForCurrUser: Boolean;
//         OpenApprovalEntriesExist: Boolean;
//         VarVariant: Variant;
//         ReqDocs: Record "Loan Required Documents";
//         SavingsLedgerEntry: Record "Savings Ledger Entry";
//         BBFRequisationHeader: Record "BBF Requisation Header";
//         BBFRequisationLines: Record "BBF Requisation Lines";
//         //JournlPosted: Codeunit "Journal Post Successful";
//         CashOfficeSetup: Record "Cash Office Setup";
//         GenJnlLine: Record "Gen. Journal Line";
//         DefaultBatch: Record "Gen. Journal Batch";
//         CashierLinks: Record "Cash Office User Template";
//         LineNo: Integer;
//         Temp: Record "Cash Office User Template";
//         JTemplate: Code[10];
//         JBatch: Code[10];
//         //PCheck: Codeunit "Posting Check FP";
//         Post: Boolean;
//         strText: Text[100];
//         SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Rec.Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book",Internetbanking,CRM,"Member Withdrawal",Delegate;
//         SendSms: Codeunit SendSms;
//         PayLine: Record "SinkFund Report Information";
//         NextofKIN: Record "Next of KIN";
//         Err0001: Label 'Member does not have next of kin details';
//         ImageData: Record "Image Data";
//         BBFEntitlement: Record "BBF Entitlement";
//         ApplicationDetailsEdit: Boolean;
//         ApprovedEdit: Boolean;
//         // SendSMSS: Codeunit SendSms;
//         SourceTypes: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Rec.Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes";
//         CompanyInformation: Record "Company Information";
//         Members: Record Members;
//         MyComment: Text;
// }

