// page 52186006 "Posted Staff Claims"
// {
//     DeleteAllowed = false;
//     Editable = false;
//     InsertAllowed = false;
//     PageType = Document;
//     PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
//     SourceTable = "Staff Claims Header";
//     SourceTableView = WHERE(Posted = CONST(true));

//     layout
//     {
//         area(content)
//         {
//             group(Control1)
//             {
//                 ShowCaption = false;
//                 field("No."; Rec."No.")
//                 {
//                 }
//                 // field(Date; Rec.Date)
//                 // {
//                 //     Editable = DateEditable;
//                 // }
//                 // field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 // {
//                 //     Editable = GlobalDimension1CodeEditable;
//                 // }
//                 field("Function Name"; Rec."Function Name")
//                 {
//                     Editable = false;
//                 }
//                 // field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
//                 // {
//                 //     Editable = ShortcutDimension2CodeEditable;
//                 // }
//                 field("Budget Center Name"; Rec."Budget Center Name")
//                 {
//                     Editable = false;
//                 }
//                 field("Account No."; Rec."Account No.")
//                 {
//                     Caption = 'Staff No/Name';
//                     Editable = false;
//                 }
//                 field(Payee; Rec.Payee)
//                 {
//                     Editable = false;
//                 }
//                 // field("Currency Code"; Rec."Currency Code")
//                 // {
//                 //     Editable = "Currency CodeEditable";
//                 // }
//                 // field("Paying Bank Account"; Rec."Paying Bank Account")
//                 // {
//                 //     Editable = "Paying Bank AccountEditable";
//                 // }
//                 field("Bank Name"; Rec."Bank Name")
//                 {
//                     Editable = false;
//                 }
//                 field(Purpose; Rec.Purpose)
//                 {
//                     Caption = 'Claim Description';
//                 }
//                 field(Cashier; Rec.Cashier)
//                 {
//                     Caption = 'Requestor ID';
//                     Editable = false;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     Editable = false;
//                 }
//                 field("Total Net Amount"; Rec."Total Net Amount")
//                 {
//                 }
//                 field("Total Net Amount LCY"; Rec."Total Net Amount LCY")
//                 {
//                 }
//                 // field("Payment Release Date"; Rec."Payment Release Date")
//                 // {
//                 //     Caption = 'Posting Date';
//                 //     Editable = "Payment Release DateEditable";
//                 // }
//                 // field("Pay Mode"; Rec."Pay Mode")
//                 // {
//                 //     Editable = "Pay ModeEditable";
//                 // }
//                 // field("Responsibility Center"; Rec."Responsibility Center")
//                 // {
//                 // }
//                 // field("Cheque No."; Rec."Cheque No.")
//                 // {
//                 //     Caption = 'Cheque/EFT No.';
//                 //     Editable = "Cheque No.Editable";
//                 // }
//             }
//             part(PVLines; "Staff Claim Lines")
//             {
//                 SubPageLink = No = FIELD("No.");
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
//                 action("Print/Preview")
//                 {
//                     Caption = 'Print/Preview';
//                     Image = Print;
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     begin
//                         if Status <> Status::Approved then
//                             Error('You can only print after the document is Approved');
//                         Reset;
//                         SetFilter("No.", "No.");
//                         //REPORT.Run(52185780, true, true, Rec);
//                         Reset;
//                     end;
//                 }
//                 separator(Action1102756006)
//                 {
//                 }
//                 action("Cancel Document")
//                 {
//                     Caption = 'Cancel Document';
//                     Image = Cancel;
//                     Promoted = true;
//                     PromotedCategory = Category6;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     var
//                         Text000: Label 'Are you sure you want to Cancel this Document?';
//                         Text001: Label 'You have selected not to Cancel this Document';
//                     begin


//                         //TESTFIELD(Status,Status::Approved);
//                         //here
//                         // if (Status = Status::Approved) or (Status = Status::Pending) then begin
//                         //     if Confirm(Text000, true) then begin
//                         //         //Post Committment Reversals
//                         //         Doc_Type := Doc_Type::Imprest;
//                         //         BudgetControl.ReverseEntries(Doc_Type, "No.");
//                         //         Status := Status::Cancelled;
//                         //         Modify;
//                         //     end else
//                         //         Error(Text001);

//                         // end;
//                     end;
//                 }
//                 action("Upload Document")
//                 {
//                     Caption = 'Upload Document';
//                     Image = Upload;

//                     trigger OnAction()
//                     var
//                         vartest: Variant;
//                         Links: Record "Record Link";
//                     begin
//                         //if Upload('Upload file', 'C:\', 'Text file(*.txt)|*.txt|PDF file(*.pdf)|*.pdf|ALL file(*)|*', 'Doc.txt', vartest) then begin
//                         /*  Links.INIT;
//                           Links."Link ID":=0;
//                         //"No."  Links."Record ID":=;
//                           Links.URL1:='\\128.0.1.74:\tsl\'+USERID;
//                           Links.INSERT(TRUE);
//                         */
//                         Rec.AddLink('\\128.0.1.74:\' + UserId);
//                         Message('File Uploaded Successfully')
//                         // end
//                         // else
//                         //     Message('File Uploaded Successfully');

//                     end;
//                 }
//                 //     action(Download)
//                 //     {
//                 //         Caption = 'Download';

//                 //         trigger OnAction()
//                 //         var
//                 //             vartest: Variant;
//                 //         begin
//                 //             Download('Upload file', 'C:\', 'Text file(*.txt)|*.txt|PDF file(*.pdf)|*.pdf|ALL file(*)|*', 'Doc.txt', vartest)
//                 //         end;
//                 //     }
//                 // }
//                 group(Navigate)
//                 {
//                     Caption = 'Navigate';
//                     action(Approvals)
//                     {
//                         Caption = 'Approvals';
//                         Image = Approvals;
//                         Promoted = true;
//                         PromotedCategory = Category9;

//                         trigger OnAction()
//                         var
//                             // //ApprovalEntries: Page "Approval Entries";
//                             // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                         begin
//                             /*
//                             DocumentType := DocumentType::"Payment Voucher";
//                             ApprovalEntries.SetRecordFilters(DATABASE::"Payments Header","Document Type","No.");
//                             ApprovalEntries.RUN;
//                             */
//                             //here//ApprovalsMgmt.OpenApprovalEntriesPage(RecordId);

//                         end;
//                     }
//                 }
//             }
//         }

//     trigger OnAfterGetRecord()
//     begin
//         //OnAfGetCurrRecord;
//         CurrPageUpdate;
//     end;

//     trigger OnInit()
//     begin
//         "Currency CodeEditable" := true;
//         DateEditable := true;
//         ShortcutDimension2CodeEditable := true;
//         GlobalDimension1CodeEditable := true;
//         "Cheque No.Editable" := true;
//         "Pay ModeEditable" := true;
//         "Paying Bank AccountEditable" := true;
//         "Payment Release DateEditable" := true;
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin

//         //check if the documenent has been added while another one is still pending
//         TravReqHeader.Reset;
//         //TravAccHeader.SETRANGE(SaleHeader."Document Type",SaleHeader."Document Type"::"Cash Sale");
//         TravReqHeader.SetRange(TravReqHeader.Cashier, UserId);
//         TravReqHeader.SetRange(TravReqHeader.Status, Status::Pending);

//         if TravReqHeader.Count > 0 then begin
//             Error('There are still some pending document(s) on your account. Please list & select the pending document to use.  ');
//         end;
//         //*********************************END ****************************************//


//         "Payment Type" := "Payment Type"::Imprest;
//         "Account Type" := "Account Type"::Customer;
//     end;
//     //here
//     // trigger OnNewRecord(BelowxRec: Boolean)
//     // begin
//     //     "Responsibility Center" := UserMgt.GetPurchasesFilter();
//     //     //Add dimensions if set by default here
//     //     "Global Dimension 1 Code" := UserMgt.GetSetDimensions(UserId, 1);
//     //     Validate("Global Dimension 1 Code");
//     //     "Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(UserId, 2);
//     //     Validate("Shortcut Dimension 2 Code");
//     //     "Shortcut Dimension 3 Code" := UserMgt.GetSetDimensions(UserId, 3);
//     //     Validate("Shortcut Dimension 3 Code");
//     //     "Shortcut Dimension 4 Code" := UserMgt.GetSetDimensions(UserId, 4);
//     //     Validate("Shortcut Dimension 4 Code");
//     //     UpdateControls;
//     // end;

//     trigger OnNextRecord(Steps: Integer): Integer
//     begin
//         UpdateControls;
//     end;

//     trigger OnOpenPage()
//     begin
//         /*
//         IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
//           FILTERGROUP(2);
//           SETRANGE("Responsibility Center" ,UserMgt.GetPurchasesFilter());
//           FILTERGROUP(0);
//         END;
//         UpdateControls;
//         */

//     end;

//     var
//         PayLine: Record "Staff Claim Lines";
//         PVUsers: Record "W/P Budget Buffer";
//         strFilter: Text[250];
//         IntC: Integer;
//         IntCount: Integer;
//         Payments: Record "Payments Header";
//         RecPayTypes: Record "Receipts and Payment Types";
//         TarriffCodes: Record "Tariff Code s";
//         GenJnlLine: Record "Gen. Journal Line";
//         DefaultBatch: Record "Gen. Journal Batch";
//         CashierLinks: Record "Cash Office User Template";
//         LineNo: Integer;
//         Temp: Record "Cash Office User Template";
//         JTemplate: Code[10];
//         JBatch: Code[10];
//         //here//PCheck: Codeunit "Posting Check FP";
//         Post: Boolean;
//         strText: Text[100];
//         PVHead: Record "Payments Header";
//         BankAcc: Record "Bank Account";
//         //here//CheckBudgetAvail: Codeunit "Budgetary Control";
//         Commitments: Record Committment;
//         //here//UserMgt: Codeunit "User Setup Management BR";
//         //here//JournlPosted: Codeunit "Journal Post Successful";
//         DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender;
//         HasLines: Boolean;
//         AllKeyFieldsEntered: Boolean;
//         Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash;
//         //here//BudgetControl: Codeunit "Budgetary Control";
//         TravReqHeader: Record "Staff Claims Header";
//         //here//AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
//         
//         "Payment Release DateEditable": Boolean;
//         
//         "Paying Bank AccountEditable": Boolean;
//         
//         "Pay ModeEditable": Boolean;
//         
//         "Cheque No.Editable": Boolean;
//         
//         GlobalDimension1CodeEditable: Boolean;
//         
//         ShortcutDimension2CodeEditable: Boolean;
//         
//         ShortcutDimension3CodeEditable: Boolean;
//         
//         ShortcutDimension4CodeEditable: Boolean;
//         
//         DateEditable: Boolean;
//         
//         "Currency CodeEditable": Boolean;
//         StatusEditable: Boolean;

//     //[Scope('OnPrem')]
//     procedure LinesCommitmentStatus() Exists: Boolean
//     var
//         BCsetup: Record "Budgetary Control Setup";
//     begin
//         if BCsetup.Get() then begin
//             if not BCsetup.Mandatory then begin
//                 Exists := false;
//                 exit;
//             end;
//         end else begin
//             Exists := false;
//             exit;
//         end;
//         Exists := false;
//         PayLine.Reset;
//         PayLine.SetRange(PayLine.No, "No.");
//         PayLine.SetRange(PayLine.Committed, false);
//         PayLine.SetRange(PayLine."Budgetary Control A/C", true);
//         if PayLine.Find('-') then
//             Exists := true;
//     end;

//     //[Scope('OnPrem')]
//     procedure PostImprest()
//     begin

//         if Temp.Get(UserId) then begin
//             GenJnlLine.Reset;
//             GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
//             GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
//             GenJnlLine.DeleteAll;
//         end;

//         //CREDIT BANK
//         LineNo := LineNo + 1000;
//         GenJnlLine.Init;
//         GenJnlLine."Journal Template Name" := JTemplate;
//         GenJnlLine."Journal Batch Name" := JBatch;
//         GenJnlLine."Line No." := LineNo;
//         GenJnlLine."Source Code" := 'PAYMENTJNL';
//         GenJnlLine."Posting Date" := "Payment Release Date";
//         GenJnlLine."Document No." := "No.";
//         GenJnlLine."External Document No." := "Cheque No.";
//         GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
//         GenJnlLine."Account No." := "Paying Bank Account";
//         GenJnlLine.Validate(GenJnlLine."Account No.");
//         GenJnlLine.Description := Purpose;
//         CalcFields("Total Net Amount");
//         GenJnlLine."Credit Amount" := "Total Net Amount";
//         GenJnlLine.Validate(GenJnlLine."Credit Amount");
//         //Added for Currency Codes
//         GenJnlLine."Currency Code" := "Currency Code";
//         GenJnlLine.Validate("Currency Code");
//         GenJnlLine."Currency Factor" := "Currency Factor";
//         GenJnlLine.Validate("Currency Factor");
//         GenJnlLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
//         GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
//         GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
//         GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
//         GenJnlLine.ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
//         GenJnlLine.ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");

//         if GenJnlLine.Amount <> 0 then
//             GenJnlLine.Insert;



//         //DEBIT RESPECTIVE G/L ACCOUNT(S)
//         PayLine.Reset;
//         PayLine.SetRange(PayLine.No, "No.");
//         if PayLine.Find('-') then begin
//             repeat
//                 LineNo := LineNo + 1000;
//                 GenJnlLine.Init;
//                 GenJnlLine."Journal Template Name" := JTemplate;
//                 GenJnlLine."Journal Batch Name" := JBatch;
//                 GenJnlLine."Line No." := LineNo;
//                 GenJnlLine."Source Code" := 'PAYMENTJNL';
//                 GenJnlLine."Posting Date" := "Payment Release Date";
//                 //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Invoice;
//                 GenJnlLine."Document No." := "No.";
//                 GenJnlLine."External Document No." := "Cheque No.";
//                 GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
//                 GenJnlLine."Account No." := PayLine."Account No:";
//                 GenJnlLine.Validate(GenJnlLine."Account No.");
//                 GenJnlLine.Description := Purpose;
//                 GenJnlLine."Debit Amount" := PayLine.Amount;
//                 GenJnlLine.Validate(GenJnlLine."Debit Amount");
//                 //Added for Currency Codes
//                 GenJnlLine."Currency Code" := "Currency Code";
//                 GenJnlLine.Validate("Currency Code");
//                 GenJnlLine."Currency Factor" := "Currency Factor";
//                 GenJnlLine.Validate("Currency Factor");
//                 GenJnlLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
//                 GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
//                 GenJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
//                 GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
//                 GenJnlLine.ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
//                 GenJnlLine.ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");

//                 if GenJnlLine.Amount <> 0 then
//                     GenJnlLine.Insert;

//             until PayLine.Next = 0
//         end;


//         GenJnlLine.Reset;
//         GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
//         GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
//         //Adjust Gen Jnl Exchange Rate Rounding Balances
//         //herev//AdjustGenJnl.Run(GenJnlLine);
//         //End Adjust Gen Jnl Exchange Rate Rounding Balances

//         //here//CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Line", GenJnlLine);

//         Post := false;
//         //here//Post := JournlPosted.PostedSuccessfully();
//         if Post then begin
//             Posted := true;
//             "Date Posted" := Today;
//             "Time Posted" := Time;
//             "Posted By" := UserId;
//             Status := Status::Posted;
//             Modify;
//         end;
//     end;

//     //[Scope('OnPrem')]
//     procedure CheckImprestRequiredItems()
//     begin

//         TestField("Payment Release Date");
//         TestField("Paying Bank Account");
//         TestField("Account No.");
//         TestField("Account Type", "Account Type"::Customer);

//         if Posted then begin
//             Error('The Document has already been posted');
//         end;

//         TestField(Status, Status::Approved);

//         /*Check if the user has selected all the relevant fields*/

//         Temp.Get(UserId);
//         JTemplate := Temp."Claim Template";
//         JBatch := Temp."Claim  Batch";

//         if JTemplate = '' then begin
//             Error('Ensure the Imprest Template is set up in Cash Office Setup');
//         end;

//         if JBatch = '' then begin
//             Error('Ensure the Imprest Batch is set up in the Cash Office Setup')
//         end;

//         if not LinesExists then
//             Error('There are no Lines created for this Document');

//     end;

//     //[Scope('OnPrem')]
//     procedure UpdateControls()
//     begin
//         if Status <> Status::Approved then begin
//             "Payment Release DateEditable" := false;
//             "Paying Bank AccountEditable" := false;
//             "Pay ModeEditable" := false;
//             //CurrForm."Currency Code".EDITABLE:=FALSE;
//             "Cheque No.Editable" := false;
//             //CurrPage.UpdateControls();
//         end else begin
//             "Payment Release DateEditable" := true;
//             "Paying Bank AccountEditable" := true;
//             "Pay ModeEditable" := true;
//             "Cheque No.Editable" := true;
//             //CurrForm."Currency Code".EDITABLE:=TRUE;
//             //CurrPage.UpdateControls();
//         end;

//         if Status = Status::Pending then begin
//             GlobalDimension1CodeEditable := true;
//             ShortcutDimension2CodeEditable := true;
//             //CurrForm.Payee.EDITABLE:=TRUE;
//             ShortcutDimension3CodeEditable := true;
//             ShortcutDimension4CodeEditable := true;
//             DateEditable := true;
//             //CurrForm."Account No.".EDITABLE:=TRUE;
//             "Currency CodeEditable" := true;
//             //CurrForm."Paying Bank Account".EDITABLE:=FALSE;
//             //CurrPage.UpdateControls();
//         end else begin
//             GlobalDimension1CodeEditable := false;
//             ShortcutDimension2CodeEditable := false;
//             //CurrForm.Payee.EDITABLE:=FALSE;
//             ShortcutDimension3CodeEditable := false;
//             ShortcutDimension4CodeEditable := false;
//             DateEditable := false;
//             //CurrForm."Account No.".EDITABLE:=FALSE;
//             "Currency CodeEditable" := false;
//             //CurrForm."Paying Bank Account".EDITABLE:=TRUE;
//             //CurrPage.UpdateControls();
//         end
//     end;

//     //[Scope('OnPrem')]
//     procedure LinesExists(): Boolean
//     var
//         PayLines: Record "Staff Claim Lines";
//     begin
//         HasLines := false;
//         PayLines.Reset;
//         PayLines.SetRange(PayLines.No, "No.");
//         if PayLines.Find('-') then begin
//             HasLines := true;
//             exit(HasLines);
//         end;
//     end;

//     //[Scope('OnPrem')]
//     procedure AllFieldsEntered(): Boolean
//     var
//         PayLines: Record "Staff Claim Lines";
//     begin
//         AllKeyFieldsEntered := true;
//         PayLines.Reset;
//         PayLines.SetRange(PayLines.No, "No.");
//         if PayLines.Find('-') then begin
//             repeat
//                 if (PayLines."Account No:" = '') or (PayLines.Amount <= 0) then
//                     AllKeyFieldsEntered := false;
//             until PayLines.Next = 0;
//             exit(AllKeyFieldsEntered);
//         end;
//     end;

//     local procedure OnAfGetCurrRecord()
//     begin
//         xRec := Rec;
//         UpdateControls();
//     end;

//     //[Scope('OnPrem')]
//     procedure CurrPageUpdate()
//     begin
//         xRec := Rec;
//         UpdateControls;
//         CurrPage.Update;
//     end;
// }

