// namespace KenpipeCBS.KenpipeCBS;
// using Microsoft.Finance.GeneralLedger.Journal;

// report 52186242 ReverseEntries
// {
//     ApplicationArea = All;
//     Caption = 'Reverse CAS Entries';
//     UsageCategory = Lists;
//     ProcessingOnly = true;
//     dataset
//     {
//         dataitem(InterestBuffer; "End Year Interest Buffer")
//         {
//             RequestFilterFields = No;
//             column(No; No)
//             {
//             }
//             column(AccountNo; "Account No")
//             {
//             }
//             column(AccountType; "Account Type")
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 if sav.get(InterestBuffer."Account No") then begin
//                     FosaAcc.Reset();
//                     FosaAcc.SetRange("Member No.", Sav."Member No.");
//                     FosaAcc.setrange("Product Type", '191');
//                     if FosaAcc.Find('-') then begin
//                         if FosaAcc.Blocked <> FosaAcc.Blocked::" " then begin
//                             FosaAcc.Blocked := FosaAcc.Blocked::" ";
//                             FosaAcc.modify;
//                         end;
//                         LineNo := LineNo + 10000;
//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name" := JTemp;
//                         GenJournalLine."Journal Batch Name" := JBatch;
//                         GenJournalLine."Line No." := LineNo;
//                         GenJournalLine."Account Type" := InterestBuffer."Account Type"::Savings;
//                         GenJournalLine."Account No." := FosaAcc."No.";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Document No." := 'R-' + InterestBuffer.No;
//                         GenJournalLine."Posting Date" := Today;
//                         GenJournalLine.Description := 'Account transfer to CAS acc.';
//                         GenJournalLine.Amount := InterestBuffer."Account Balance";
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         GenJournalLine."Bal. Account Type" := InterestBuffer."Bal. Account Type";
//                         GenJournalLine."Bal. Account No." := '';
//                         GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                         GenJournalLine."Shortcut Dimension 1 Code" := InterestBuffer."Shortcut Dimension 1 Code";
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                         GenJournalLine."Shortcut Dimension 2 Code" := InterestBuffer."Shortcut Dimension 2 Code";
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                         if GenJournalLine.Amount <> 0 then
//                             GenJournalLine.Insert;

//                         LineNo := LineNo + 10000;
//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name" := JTemp;
//                         GenJournalLine."Journal Batch Name" := JBatch;
//                         GenJournalLine."Line No." := LineNo;
//                         GenJournalLine."Account Type" := InterestBuffer."Account Type"::Savings;
//                         GenJournalLine."Account No." := InterestBuffer."Account No";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Document No." := 'R-' + InterestBuffer.No;
//                         GenJournalLine."Posting Date" := Today;
//                         GenJournalLine.Description := 'Account transfer to CAS acc.';
//                         GenJournalLine.Amount := -InterestBuffer."Account Balance";
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                         GenJournalLine."Bal. Account No." := '';
//                         GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                         GenJournalLine."Shortcut Dimension 1 Code" := InterestBuffer."Shortcut Dimension 1 Code";
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                         GenJournalLine."Shortcut Dimension 2 Code" := InterestBuffer."Shortcut Dimension 2 Code";
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                         if GenJournalLine.Amount <> 0 then begin
//                             GenJournalLine.Insert;
//                         end;
//                     end;
//                 end;
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
//                     field("Journal Template"; JTemp)
//                     {
//                         ApplicationArea = All;
//                     }
//                     field("Journal Batch"; JBatch)
//                     {
//                         ApplicationArea = All;
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
//     var
//         GenJournalLine: Record "Gen. Journal Line";
//         LineNo: Integer;
//         JTemp: Code[20];
//         JBatch: Code[20];
//         FosaAcc: Record "Savings Accounts";
//         sav: Record "Savings Accounts";
// }
