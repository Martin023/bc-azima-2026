// namespace KenpipeCBS.KenpipeCBS;
// using Microsoft.Finance.GeneralLedger.Journal;

// report 52186213 "Standing Order Over recovery"
// {
//     ApplicationArea = All;
//     Caption = 'Standing Order Over recovery';
//     UsageCategory = Tasks;
//     ProcessingOnly = true;
//     dataset
//     {
//         dataitem(SavingsAccounts; "Savings Accounts")
//         {
//             DataItemTableView = where("Product Type" = const('ODS'));
//             column(No; "No.")
//             {
//             }
//             column(MemberNo; "Member No.")
//             {
//             }
//             column(MemberStatus; "Member Status")
//             {
//             }
//             column(EmployerCode; "Employer Code")
//             {
//             }
//             column(GlobalDimension1Code; "Global Dimension 1 Code")
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 AmtToRef := 0;
//                 SavingLedgerEntries.reset;
//                 SavingLedgerEntries.SetRange("Customer No.", SavingsAccounts."No.");
//                 SavingLedgerEntries.SetRange(Reversed, false);
//                 SavingLedgerEntries.SetRange("Document No.", 'SAL000004');
//                 if SavingLedgerEntries.findset() then begin
//                     repeat
//                         if SavingLedgerEntries.Description.Contains('STO:-') then begin
//                             STOHeader.reset;
//                             STOHeader.SetRange(status, STOHeader.Status::Approved);
//                             if STOHeader.FindSet() then begin
//                                 repeat
//                                     StandingOrderLines.Reset();
//                                     StandingOrderLines.SetRange("Document No.", STOHeader."No.");
//                                     StandingOrderLines.SetRange("Destination Account Type", StandingOrderLines."Destination Account Type"::Credit);
//                                     if StandingOrderLines.FindFirst() then begin
//                                         if StandingOrderLines.Count = 1 then begin
//                                             if SavingLedgerEntries.Description.Contains(StandingOrderLines."Document No.") then begin
//                                                 if SavingLedgerEntries."Debit Amount (LCY)" > StandingOrderLines.Amount then begin
//                                                     AmtToRef := SavingLedgerEntries."Debit Amount (LCY)" - StandingOrderLines.Amount;
//                                                     loans.reset;
//                                                     loans.SetRange("Loan No.", StandingOrderLines."Loan No.");
//                                                     Loans.setfilter("Date Filter", '..' + format(Today - 1));
//                                                     if loans.FindFirst() then begin
//                                                         //Loans.CalcFields("Outstanding Balance", "Outstanding Interest");

//                                                         LineNo += 1;

//                                                         GenJournalLine.Init;
//                                                         GenJournalLine."Journal Template Name" := Jtemplate;
//                                                         GenJournalLine."Journal Batch Name" := JBatch;
//                                                         GenJournalLine."Line No." := LineNo;

//                                                         GenJournalLine."Document No." := CopyStr('STO-REVERSE', 1, 20);
//                                                         //GenJournalLine."External Document No.":=SalLines."Branch Reff.";
//                                                         GenJournalLine."Posting Date" := Today;
//                                                         GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
//                                                         GenJournalLine."Account No." := SavingsAccounts."No.";
//                                                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                                                         GenJournalLine.Description := 'Standing Order Over Recovery';
//                                                         GenJournalLine.Amount := -AmtToRef;
//                                                         GenJournalLine.Validate(GenJournalLine.Amount);
//                                                         GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::" ";
//                                                         ;
//                                                         GenJournalLine."Shortcut Dimension 1 Code" := 'NAIROBI';
//                                                         GenJournalLine."Shortcut Dimension 2 Code" := 'BOSA';
//                                                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                                                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                                                         if GenJournalLine.Amount <> 0 then
//                                                             GenJournalLine.Insert(false);

//                                                         LineNo := LineNo + 1;
//                                                         GenJournalLine.Init;
//                                                         GenJournalLine."Journal Template Name" := Jtemplate;
//                                                         GenJournalLine."Journal Batch Name" := JBatch;//USERID;
//                                                         GenJournalLine."Line No." := LineNo;
//                                                         GenJournalLine."Posting Date" := Today;
//                                                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                                                         GenJournalLine."Document No." := CopyStr('STO-REVERSE', 1, 20);
//                                                         //GenJournalLine."External Document No.":=SalLines."Branch Reff.";
//                                                         GenJournalLine."Posting Date" := Today;
//                                                         GenJournalLine."Account Type" := GenJournalLine."account type"::Credit;
//                                                         GenJournalLine."Account No." := Loans."Loan Account";
//                                                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                                                         GenJournalLine.Description := 'Standing Order Over Recovery - REVERSED';
//                                                         GenJournalLine."Shortcut Dimension 1 Code" := 'NAIROBI';
//                                                         GenJournalLine."Shortcut Dimension 2 Code" := 'BOSA';
//                                                         GenJournalLine.Amount := AmtToRef;
//                                                         GenJournalLine."Loan No" := Loans."Loan No.";
//                                                         GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::Repayment;
//                                                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                                                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                                                         if GenJournalLine.Amount <> 0 then
//                                                             GenJournalLine.Insert(false);
//                                                     end;

//                                                     //Return to principal
//                                                     // loans.reset;
//                                                     // loans.SetRange("Loan No.", StandingOrderLines."Loan No.");
//                                                     // Loans.setfilter("Date Filter", '..' + format(Today));
//                                                     // if loans.FindFirst() then begin
//                                                     //     Loans.CalcFields("Outstanding Balance", "Outstanding Interest");

//                                                     //     LineNo += 1;

//                                                     //     GenJournalLine.Init;
//                                                     //     GenJournalLine."Journal Template Name" := Jtemplate;
//                                                     //     GenJournalLine."Journal Batch Name" := JBatch;
//                                                     //     GenJournalLine."Line No." := LineNo;

//                                                     //     GenJournalLine."Document No." := CopyStr('STO-REVERSE', 1, 20);
//                                                     //     //GenJournalLine."External Document No.":=SalLines."Branch Reff.";
//                                                     //     GenJournalLine."Posting Date" := Today;
//                                                     //     GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
//                                                     //     GenJournalLine."Account No." := SavingsAccounts."No.";
//                                                     //     GenJournalLine.Validate(GenJournalLine."Account No.");
//                                                     //     GenJournalLine.Description := 'Standing Order Over Recovery';
//                                                     //     GenJournalLine.Amount := -Loans."Outstanding Interest";
//                                                     //     GenJournalLine.Validate(GenJournalLine.Amount);
//                                                     //     ;
//                                                     //     GenJournalLine."Shortcut Dimension 1 Code" := 'NAIROBI';
//                                                     //     GenJournalLine."Shortcut Dimension 2 Code" := 'BOSA';
//                                                     //     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                                                     //     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                                                     //     if GenJournalLine.Amount <> 0 then
//                                                     //         GenJournalLine.Insert(false);

//                                                     //     LineNo := LineNo + 1;
//                                                     //     GenJournalLine.Init;
//                                                     //     GenJournalLine."Journal Template Name" := Jtemplate;
//                                                     //     GenJournalLine."Journal Batch Name" := JBatch;//USERID;
//                                                     //     GenJournalLine."Line No." := LineNo;
//                                                     //     GenJournalLine."Posting Date" := Today - 1;
//                                                     //     GenJournalLine.Validate(GenJournalLine."Account No.");
//                                                     //     GenJournalLine."Document No." := CopyStr('STO-REVERSE', 1, 20);
//                                                     //     //GenJournalLine."External Document No.":=SalLines."Branch Reff.";
//                                                     //     GenJournalLine."Posting Date" := Today;
//                                                     //     GenJournalLine."Account Type" := GenJournalLine."account type"::Credit;
//                                                     //     GenJournalLine."Account No." := Loans."Loan Account";
//                                                     //     GenJournalLine.Validate(GenJournalLine."Account No.");
//                                                     //     GenJournalLine.Description := 'Standing Order Over Recovery - REVERSED';
//                                                     //     GenJournalLine."Shortcut Dimension 1 Code" := 'NAIROBI';
//                                                     //     GenJournalLine."Shortcut Dimension 2 Code" := 'BOSA';
//                                                     //     GenJournalLine.Amount := Loans."Outstanding Interest";
//                                                     //     GenJournalLine."Loan No" := Loans."Loan No.";
//                                                     //     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                                                     //     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                                                     //     if GenJournalLine.Amount <> 0 then
//                                                     //         GenJournalLine.Insert(false);
//                                                     // end;

//                                                     // Send SMS

//                                                     if SendSMSTomemb then begin

//                                                         if Memb.get(SavingsAccounts."Member No.") then begin

//                                                             Msg := 'Dear ' + Memb."First Name" + ' your Ordinary account has been credited with KES ' + Format(AmtToRef) + ' from Standing Order over deduction. Your new Ordinary account balance is KES ' + Format(GlobalFunctions.GetSavingsAccountAvailableBalance(SavingsAccounts, true));

//                                                             if SavingsAccounts."Transactional Mobile No" <> '' then
//                                                                 SendSMS.SendSms(Source::SALARY_PROCESSING, SavingsAccounts."Transactional Mobile No", msg, SavingsAccounts."No.", '', true, 0, false, 'CBS', "Member No.", 'CBS')
//                                                             else
//                                                                 SendSMS.SendSms(Source::SALARY_PROCESSING, Memb."Phone No.", msg, SavingsAccounts."No.", '', true, 0, false, 'CBS', "Member No.", 'CBS')

//                                                         end;


//                                                     end;
//                                                 end;
//                                             end;
//                                         end;
//                                     end;
//                                 until STOHeader.Next = 0;
//                             end;
//                         end
//                         else
//                             CurrReport.Skip();
//                     until SavingLedgerEntries.Next = 0;
//                 end
//                 else
//                     CurrReport.Skip();
//             end;
//         }

//     }



//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(GroupName)
//                 {
//                     field(SendSMSTomemb; SendSMSTomemb)
//                     {
//                         Caption = 'Send SMS';
//                     }
//                 }
//             }
//         }
//         actions
//         {
//             area(Processing)
//             {
//             }
//         }
//     }

//     trigger OnPreReport()
//     begin
//         Bankinguser.get(UserID);
//         JTemplate := Bankinguser."Salary Journal Template";
//         JBatch := Bankinguser."Salary Journal Batch";

//         LineNo := 1;

//         GenJournalLine.Reset();
//         GenJournalLine.SetRange("Journal Template Name", JTemplate);
//         GenJournalLine.SetRange("Journal Batch Name", JBatch);
//         GenJournalLine.DeleteAll();
//     end;




//     var
//         StandingOrderLines: record "Standing Order Lines";
//         STOHeader: record "Standing Order Header";
//         SavingLedgerEntries: record "Savings Ledger Entry";
//         STOno: code[100];
//         loans: record loans;
//         GenJournalLine: record "Gen. Journal Line";
//         Bankinguser: record "Banking User Template";
//         JBatch: code[100];
//         Jtemplate: code[100];
//         LineNo: integer;
//         AmtToRef: Decimal;
//         Memb: Record Members;
//         Msg: text[1000];
//         GlobalFunctions: Codeunit "Global Functions";
//         SendSMS: Codeunit SendSms;
//         Source: Enum "SMS Source";

//         SendSMSTomemb: Boolean;

// }
