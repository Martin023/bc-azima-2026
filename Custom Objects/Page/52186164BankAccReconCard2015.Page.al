// page 52186164 "Bank Acc. Recon Card 2015"
// {
//     Caption = 'Bank Acc. Reconciliation';
//     DeleteAllowed = false;
//     PageType = Document;
//     PromotedActionCategories = 'New,Process,Report,Bank,Matching,Selection';
//     SaveValues = false;
//     SourceTable = "Bank Acc. Reconciliation";
//     ApplicationArea = Basic, Suite;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("Bank Account No."; Rec."Bank Account No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Statement No."; Rec."Statement No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Statement Date"; Rec."Statement Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Balance Last Statement"; Rec."Balance Last Statement")
//                 {
//                     Editable = true;
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Statement Ending Balance"; Rec."Statement Ending Balance")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//             }
//             group(Control11)
//             {
//                 ShowCaption = false;
//                 part(StmtLine; "Bank Acc. Recon Lines 2015")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Bank Statement Lines';
//                     SubPageLink = "Bank Account No." = FIELD("Bank Account No."),
//                                   "Statement No." = FIELD("Statement No.");
//                 }
//                 part(ApplyBankLedgerEntries; "Apply Bank Acc. Ledger Entries")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Bank Account Ledger Entries';
//                     SubPageLink = "Bank Account No." = FIELD("Bank Account No."),
//                                   Open = CONST(true),
//                                   "Statement Status" = FILTER(Open | "Bank Acc. Entry Applied" | "Check Entry Applied");
//                     Visible = false;
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             systempart(Control5; Links)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Visible = false;
//             }
//             systempart(Control2; Notes)
//             {
//                 ApplicationArea = Basic, Suite;
//                 Visible = false;
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("&Recon.")
//             {
//                 Caption = '&Recon.';
//                 Image = BankAccountRec;
//                 action("&Card")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = '&Card';
//                     Image = EditLines;
//                     // RunObject = Page "Bank Account Card";
//                     // RunPageLink = "No." = FIELD("Bank Account No.");
//                     ShortCutKey = 'Shift+F7';
//                 }
//             }
//         }
//         area(processing)
//         {
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 Image = "Action";
//                 action(SuggestLines)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Suggest Lines';
//                     Ellipsis = true;
//                     Image = SuggestLines;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     begin
//                         SuggestBankAccStatement.SetStmt(Rec);
//                         SuggestBankAccStatement.RunModal;
//                         Clear(SuggestBankAccStatement);
//                     end;
//                 }
//                 action("Transfer to General Journal")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Transfer to General Journal';
//                     Ellipsis = true;
//                     Image = TransferToGeneralJournal;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     begin
//                         TransferToGLJnl.SetBankAccRecon(Rec);
//                         TransferToGLJnl.Run;
//                     end;
//                 }
//             }
//             group("Ba&nk")
//             {
//                 Caption = 'Ba&nk';
//                 action(ImportBankStatement)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Import Bank Statement';
//                     Image = Import;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     begin
//                         Rec.ImportBankStatement;
//                     end;
//                 }
//             }
//             group("M&atching")
//             {
//                 Caption = 'M&atching';
//                 action(MatchAutomatically)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Match Automatically';
//                     Image = MapAccounts;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     begin
//                         Rec.SetRange("Statement Type", Rec."Statement Type");
//                         Rec.SetRange("Bank Account No.", Rec."Bank Account No.");
//                         Rec.SetRange("Statement No.", Rec."Statement No.");
//                         //REPORT.Run(REPORT::"Match Bank Entries", true, true, Rec);
//                     end;
//                 }
//                 action(MatchManually)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Match Manually';
//                     Image = CheckRulesSyntax;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     var
//                         TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary;
//                         TempBankAccountLedgerEntry: Record "Bank Account Ledger Entry" temporary;
//                         MatchBankRecLines: Codeunit "Match Bank Rec. Lines";
//                     begin
//                         CurrPage.StmtLine.PAGE.GetSelectedRecords(TempBankAccReconciliationLine);
//                         CurrPage.ApplyBankLedgerEntries.PAGE.GetSelectedRecords(TempBankAccountLedgerEntry);
//                         //MatchBankRecLines.MatchManually(TempBankAccReconciliationLine,TempBankAccountLedgerEntry,1);
//                     end;
//                 }
//                 action(RemoveMatch)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Remove Match';
//                     Image = RemoveContacts;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     var
//                         TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary;
//                         TempBankAccountLedgerEntry: Record "Bank Account Ledger Entry" temporary;
//                         MatchBankRecLines: Codeunit "Match Bank Rec. Lines";
//                     begin
//                         CurrPage.StmtLine.PAGE.GetSelectedRecords(TempBankAccReconciliationLine);
//                         CurrPage.ApplyBankLedgerEntries.PAGE.GetSelectedRecords(TempBankAccountLedgerEntry);
//                         MatchBankRecLines.RemoveMatch(TempBankAccReconciliationLine, TempBankAccountLedgerEntry);
//                     end;
//                 }
              
//             }
//             group("P&osting")
//             {
//                 Caption = 'P&osting';
//                 Image = Post;
//                 action(BankRec)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = '&Bank Reconciliation';
//                     Ellipsis = true;
//                     Image = TestReport;
//                     Promoted = true;
//                     PromotedCategory = Category6;
//                     PromotedIsBig = true;
//                     Visible = false;

//                     trigger OnAction()
//                     begin

//                         // ReconReport.getbankRec(Rec, "Statement Ending Balance");
//                         // Recon//REPORT.Run;
//                     end;
//                 }
//                 action("Bank Reconciliation Report")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Bank Reconciliation Report';
//                     Ellipsis = true;
//                     Image = "Report";
//                     Promoted = true;
//                     PromotedCategory = Category6;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     var
//                     // BankReconReport: Report "Bank Acc. Recononciliation";here
//                     begin

//                         // BankReconReport.getbankRec(Rec, "Statement Ending Balance");
//                         // BankRecon//REPORT.Run;
//                     end;
//                 }
//                 action(Post)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'P&ost';
//                     Image = PostOrder;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     RunObject = Codeunit "Bank Acc. Recon. Post (Yes/No)";
//                     ShortCutKey = 'F9';
//                 }
//                 action(PostAndPrint)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Post and &Print';
//                     Image = PostPrint;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     RunObject = Codeunit "Bank Acc. Recon. Post+Print";
//                     ShortCutKey = 'Shift+F9';
//                 }
//             }
//             group(Action34)
//             {
//                 action("Mark All")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Image = RegisteredDocs;
//                     Promoted = true;
//                     PromotedCategory = Category6;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     var
//                         CFM_001: Label 'Do you want to mark all Lines as Reconciled for Bank [ %1 ]';
//                     begin
//                         if Confirm(CFM_001, false, Rec."Bank Account No.") = false then Error('Aborted');

//                         BankRecLine.Reset;
//                         BankRecLine.SetRange("Bank Account No.", Rec."Bank Account No.");
//                         //BankRecLine.SetFilter(Type, '<>%1', BankRecLine.Type::Difference);
//                         if BankRecLine.Find('-') then begin
//                             repeat
//                                 BankRecLine.Reconciled := true;
//                                 BankRecLine.Modify;
//                             until BankRecLine.Next = 0;
//                         end;
//                     end;
//                 }
//                 action("Un-Mark All")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Image = DeleteAllBreakpoints;
//                     Promoted = true;
//                     PromotedCategory = Category6;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     var
//                         CFM_002: Label 'Do you want to Un-Mark all Lines as Reconciled for Bank [ %1 ]';
//                     begin
//                         if Confirm(CFM_002, false, Rec."Bank Account No.") = false then Error('Aborted');

//                         BankRecLine.Reset;
//                         BankRecLine.SetRange("Bank Account No.", Rec."Bank Account No.");
//                         //BankRecLine.SetFilter(Type, '<>%1', BankRecLine.Type::Difference);
//                         if BankRecLine.Find('-') then begin
//                             repeat
//                                 BankRecLine.Reconciled := false;
//                                 BankRecLine.Modify;
//                             until BankRecLine.Next = 0;
//                         end;
//                     end;
//                 }
//                 action("Mark Selected ")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Image = ImplementPriceChange;
//                     Promoted = true;
//                     PromotedCategory = Category6;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     var
//                         BankRecLine_2: Record "Bank Acc. Reconciliation Line";
//                     begin

//                         CurrPage.StmtLine.PAGE.Mark_SelectedRecords(Rec."Bank Account No.");
//                     end;
//                 }
//                 action("Un-Mark Selected ")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Image = VoidChecks;
//                     Promoted = true;
//                     PromotedCategory = Category6;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     var
//                         BankRecLine_2: Record "Bank Acc. Reconciliation Line";
//                     begin

//                         CurrPage.StmtLine.PAGE."Un-Mark_SelectedRecords"(Rec."Bank Account No.");
//                     end;
//                 }
//                 action("Import Bank Reconciliation Diffrences")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Image = Import;
//                     Promoted = true;
//                     PromotedCategory = Category6;
//                     PromotedIsBig = true;
//                     RunObject = XMLport "Import Bank Rec Diffrences";
//                 }
//             }
//         }
//     }

//     var
//         SuggestBankAccStatement: Report "Suggest Bank Acc. Recon. Lines";
//         TransferToGLJnl: Report "Trans. Bank Rec. to Gen. Jnl.";
//         ReportPrint: Codeunit "Test Report-Print";
//         BankAccStmtLine2: Record "Bank Acc. Reconciliation";
//         BankRecLine: Record "Bank Acc. Reconciliation Line";
//         BankRec: Record "Bank Acc. Reconciliation";
//     // ReconReport: Report "Bank Acc. Recon 2015";
// }

