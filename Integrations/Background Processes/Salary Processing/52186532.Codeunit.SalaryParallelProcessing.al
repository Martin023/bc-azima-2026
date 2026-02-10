// codeunit 52186532 "Salary Parallel Processing"
// {
//     procedure PostSalaryLoansP(SalHeaD: Record "Salary Header P"; DocNo: Code[20]; PDate: Date; DActivity2: Code[20]; DBranch2: Code[20]; Jtemplate: Code[20]; Jbatch: Code[20]; RunBal: Decimal; MemberNo: Code[20]; LineNo: Integer; Salaccno: Code[20])
//     var
//         Loans: Record Loans;
//         Interest: Decimal;
//         GenJournalLine: Record "Gen. Journal Line";
//         LRepayment: Decimal;
//         SalLines: Record "Salary Lines P";
//         CreditLedger: Record "Credit Ledger Entry";
//         ProductType: Record "Product Factory";
//         StandingOrdSRegister: Record "Standing Order Register";
//         Amt: Decimal;
//         Pfact: Record "Product Factory";
//         AccNo: Code[20];
//         AcctType: Enum "Gen. Journal Account Type";
//         TransType: Enum "Transaction Types";
//         BalAccType: Enum "Gen. Journal Account Type";
//         BalAccNo: Code[15];
//         JournalPosting: Codeunit "Journal Posting";
//         LoansProcess: Codeunit "Loans Process";

//     begin
//         // with SalHeaD do
//         begin

//             Loans.Reset;
//             Loans.SetRange(Loans."Member No.", MemberNo);
//             Loans.SetRange(Loans."Disbursement Date", 0D, SalHeaD."Last Loan Issue Date");
//             if SalHeaD."Income Type" = SalHeaD."Income Type"::Payments THEN
//                 Loans.SetRange(Loans."Recovery Mode", Loans."recovery mode"::"Board Allowance")
//             ELSE
//                 Loans.SetRange(Loans."Recovery Mode", Loans."recovery mode"::Salary);

//             Loans.SetAutoCalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest", "Daily Interest");
//             if Loans.FindSet() then begin
//                 repeat
//                     LineNo += 1;
//                     if RunBal > 0 then begin
//                         // Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest", "Daily Interest");
//                         if (Loans."Outstanding Interest" + Loans."Daily Interest") > 0 then begin
//                             //Capitalize Interest
//                             if Loans."Daily Interest" > 0 then begin
//                                 Amt := 0;
//                                 // Accrue Interest;
//                                 Pfact.Get(Loans."Loan Product Type");
//                                 Pfact.TestField("Loan Interest Account [G/L]");
//                                 AcctType := AcctType::Credit;
//                                 TransType := TransType::"Interest Due";
//                                 LineNo := LineNo + 10000;
//                                 AccNo := Loans."Loan Account";
//                                 BalAccType := BalAccType::"G/L Account";
//                                 BalAccNo := Pfact."Loan Interest Account [G/L]";
//                                 Amt := Loans."Daily Interest";

//                                 JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, DocNo,
//                                 CopyStr('Daily Interest Capitalized', 1, 50), Amt, AccNo, PDate, BalAccType,
//                                 BalAccNo, Loans."Loan No.", Loans."Global Dimension 1 Code", Loans."Global Dimension 2 Code", TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
//                                 LoansProcess.ClearDailyInterest(Loans."Loan No.");
//                             end;
//                             Interest := 0;
//                             Interest := Loans."Outstanding Interest" + Loans."Daily Interest";
//                             if Interest > 0 then begin
//                                 LineNo := LineNo + 10000;
//                                 GenJournalLine.Init;
//                                 GenJournalLine."Journal Template Name" := Jtemplate;
//                                 GenJournalLine."Journal Batch Name" := Jbatch;
//                                 GenJournalLine."Line No." := LineNo;
//                                 GenJournalLine."Account Type" := GenJournalLine."account type"::Credit;
//                                 GenJournalLine."Account No." := Loans."Loan Account";
//                                 GenJournalLine.Validate(GenJournalLine."Account No.");
//                                 GenJournalLine."Document No." := DocNo;
//                                 GenJournalLine."Posting Date" := PDate;
//                                 GenJournalLine.Description := 'Interest Paid';
//                                 if RunBal > Interest then
//                                     GenJournalLine.Amount := Interest * -1
//                                 else
//                                     GenJournalLine.Amount := RunBal * -1;
//                                 GenJournalLine.Validate(GenJournalLine.Amount);
//                                 GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
//                                 GenJournalLine."Loan No" := Loans."Loan No.";
//                                 GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
//                                 GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
//                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                                 if GenJournalLine.Amount <> 0 then
//                                     GenJournalLine.Insert;

//                                 LineNo := LineNo + 10000;
//                                 GenJournalLine.Init;
//                                 GenJournalLine."Journal Template Name" := Jtemplate;
//                                 GenJournalLine."Journal Batch Name" := Jbatch;
//                                 GenJournalLine."Line No." := LineNo;
//                                 GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
//                                 GenJournalLine."Account No." := Salaccno;
//                                 GenJournalLine.Validate(GenJournalLine."Account No.");
//                                 GenJournalLine."Document No." := DocNo;
//                                 GenJournalLine."Posting Date" := PDate;
//                                 GenJournalLine.Description := PadStr('Interest Paid - ' + Loans."Loan Product Type Name", 50);
//                                 if RunBal > Interest then
//                                     GenJournalLine.Amount := Interest
//                                 else
//                                     GenJournalLine.Amount := RunBal;
//                                 GenJournalLine.Validate(GenJournalLine.Amount);
//                                 GenJournalLine."Loan No" := Loans."Loan No.";
//                                 GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
//                                 GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
//                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                                 if GenJournalLine.Amount <> 0 then
//                                     GenJournalLine.Insert;
//                                 RunBal := RunBal - Abs(GenJournalLine.Amount);
//                             end;
//                         end;

//                         if RunBal > 0 then begin
//                             if Loans."Outstanding Balance" > 0 then begin

//                                 LRepayment := 0;
//                                 LRepayment := Loans."Loan Principle Repayment";
//                                 if LRepayment = 0 then LRepayment := Loans.Repayment;
//                                 IF LRepayment <= 0 THEN BEGIN
//                                     if Loans.Installments <= 0 then Loans.Installments := 1;
//                                     LRepayment := ROUND((Loans."Approved Amount" / Loans.Installments), 0.01, '>');
//                                 end;


//                                 if LRepayment > 0 then begin
//                                     if LRepayment > Loans."Outstanding Balance" then
//                                         LRepayment := Loans."Outstanding Balance";

//                                     LineNo := LineNo + 10000;
//                                     GenJournalLine.Init;
//                                     GenJournalLine."Journal Template Name" := Jtemplate;
//                                     GenJournalLine."Journal Batch Name" := Jbatch;
//                                     GenJournalLine."Line No." := LineNo;
//                                     GenJournalLine."Account Type" := GenJournalLine."account type"::Credit;
//                                     GenJournalLine."Account No." := Loans."Loan Account";
//                                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                                     GenJournalLine."Document No." := DocNo;
//                                     GenJournalLine."Posting Date" := PDate;
//                                     GenJournalLine.Description := 'Loan Repayment';
//                                     if RunBal > LRepayment then
//                                         GenJournalLine.Amount := LRepayment * -1
//                                     else
//                                         GenJournalLine.Amount := RunBal * -1;
//                                     GenJournalLine.Validate(GenJournalLine.Amount);
//                                     GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
//                                     GenJournalLine."Loan No" := Loans."Loan No.";
//                                     GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
//                                     GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
//                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                                     if GenJournalLine.Amount <> 0 then
//                                         GenJournalLine.Insert;

//                                     LineNo := LineNo + 10000;
//                                     GenJournalLine.Init;
//                                     GenJournalLine."Journal Template Name" := Jtemplate;
//                                     GenJournalLine."Journal Batch Name" := Jbatch;
//                                     GenJournalLine."Line No." := LineNo;
//                                     GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
//                                     GenJournalLine."Account No." := Salaccno;
//                                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                                     GenJournalLine."Document No." := DocNo;
//                                     GenJournalLine."Posting Date" := PDate;
//                                     GenJournalLine.Description := PadStr('Loan Repayment - ' + Loans."Loan Product Type Name", 50);
//                                     if RunBal > LRepayment then
//                                         GenJournalLine.Amount := LRepayment
//                                     else
//                                         GenJournalLine.Amount := RunBal;
//                                     GenJournalLine.Validate(GenJournalLine.Amount);
//                                     GenJournalLine."Loan No" := Loans."Loan No.";
//                                     GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
//                                     GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
//                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                                     if GenJournalLine.Amount <> 0 then
//                                         GenJournalLine.Insert;
//                                     RunBal := RunBal - GenJournalLine.Amount;
//                                     //ERROR('Interst %1',Interest);
//                                 end;
//                             end;
//                         end;
//                     end;
//                     LineNo += 1;
//                 until Loans.Next = 0;
//             end;
//         end;
//         /*
//         StandingOrdSRegister.RESET;
//         StandingOrdSRegister.SETRANGE("Source Account No.",Salaccno);
//         StandingOrdSRegister.SETRANGE("Deduction Status",StandingOrdSRegister."Deduction Status"::Successfull);
//         StandingOrdSRegister.SETRANGE("Date Processed",CALCDATE('-5D',PDate),PDate);
//         IF NOT StandingOrdSRegister.FIND('-') THEN
//         */
//         PostSalarySTOP(SalHeaD, DocNo, PDate, DActivity2, DBranch2, Jtemplate, Jbatch, RunBal, MemberNo, LineNo, Salaccno);

//     end;

//     procedure ActivateDormantP(SalHeaD: Record "Salary Header P"; DocNo: Code[20]; PDate: Date; DActivity2: Code[20]; DBranch2: Code[20]; Jtemplate: Code[20]; Jbatch: Code[20]; RunBal: Decimal; MemberNo: Code[20]; LineNo: Integer; Salaccno: Code[20])
//     var
//         SavAcc: Record "Savings Accounts";
//         TransactionCharges: Record "Transaction Charges";
//         TransactionTypes: Record "Transaction Types";
//         AccType: Enum "Gen. Journal Account Type";
//         AccNo: Code[20];
//         TransType: Enum "Transaction Types";
//         BalAccType: Enum "Gen. Journal Account Type";
//         BalAccNo: Code[20];
//         Amt: Decimal;
//         JournalPosting: Codeunit "Journal Posting";
//         GenSetup: Record "General Set-Up";
//     begin
//         //Auto Activate Dormant On Loan Posting
//         GenSetup.Get;
//         //with SalHeaD do
//         begin
//             SavAcc.Reset;
//             SavAcc.SetRange("No.", Salaccno);
//             SavAcc.SetRange(Status, SavAcc.Status::Dormant);
//             if SavAcc.Find('-') then begin
//                 TransactionTypes.Reset;
//                 TransactionTypes.SetRange(Code, GenSetup."Dormant Account Activation Fee");
//                 if TransactionTypes.Find('-') then begin
//                     TransactionCharges.Reset;
//                     TransactionCharges.SetRange("Transaction Type", TransactionTypes.Code);
//                     if TransactionCharges.FindSet() then begin
//                         repeat
//                             TransactionCharges.TestField(TransactionCharges."G/L Account");
//                             if SavAcc.Blocked = SavAcc.Blocked::" " then begin
//                                 SavAcc.Blocked := SavAcc.Blocked::" ";
//                                 SavAcc.Status := SavAcc.Status::Active;
//                                 SavAcc."Status Change Reason" := 'Auto Activated on Salary Posting';
//                                 SavAcc.Modify;
//                             end;
//                             LineNo := LineNo + 10000;
//                             AccType := Acctype::"G/L Account";
//                             AccNo := TransactionCharges."G/L Account";
//                             TransType := Transtype::" ";
//                             BalAccType := Balacctype::Savings;
//                             BalAccNo := SavAcc."No.";

//                             Amt := TransactionCharges."Charge Amount";
//                             Amt := Amt * -1;
//                             JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, TransactionCharges.Description + SavAcc."No.", Amt, AccNo, PDate, BalAccType,
//                           BalAccNo, '', DActivity2, DBranch2, TransType, SalHeaD."Document No", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

//                             if TransactionCharges."Recover Excise Duty" = true then begin
//                                 GenSetup.TestField("Excise Duty G/L");
//                                 GenSetup.TestField("Excise Duty (%)");
//                                 LineNo := LineNo + 10000;
//                                 AccType := Acctype::"G/L Account";
//                                 AccNo := GenSetup."Excise Duty G/L";
//                                 TransType := Transtype::" ";
//                                 BalAccType := Balacctype::Savings;
//                                 BalAccNo := SavAcc."No.";
//                                 Amt := Amt * GenSetup."Excise Duty (%)" * 0.01;
//                                 JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, CopyStr((TransactionCharges.Description + SavAcc."No." + '-Excise Duty'), 1, 50), Amt, AccNo, PDate, BalAccType,
//                                 BalAccNo, '', DActivity2, DBranch2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
//                             end;
//                         until TransactionCharges.Next = 0;
//                     end;
//                 end;
//             end;
//         end;
//         //block account if
//     end;

//     local procedure PostSalarySTOP(SalHeaD: Record "Salary Header P"; DocNo: Code[20]; PDate: Date; DActivity2: Code[20]; DBranch2: Code[20]; Jtemplate: Code[20]; Jbatch: Code[20]; RunBal: Decimal; MemberNo: Code[20]; LineNo: Integer; Salaccno: Code[20])
//     var
//         StandingOrderHeader: Record "Standing Order Header";
//         SavingsAccounts: Record "Savings Accounts";
//         ProductFactory: Record "Product Factory";
//         AvailableBal: Decimal;
//         GenJournalLine: Record "Gen. Journal Line";
//         BalAccountType: Enum "Gen. Journal Account Type";
//         StandingOrdDeductStatus: Option " ",Successfull,"Partial Deduction",Failed;
//         StandingOrdSRegister: Record "Standing Order Register";
//         TCharges: Decimal;
//         SalLines: Record "Salary Lines P";
//         STOHeaderNo: Code[20];
//         StandingOrderLines: Record "Standing Order Lines";
//         StandingOrderLinesII: Record "Standing Order Lines";
//         LoanApps: Record Loans;
//         LoanInterest: Decimal;
//         LoanPrinciple: Decimal;
//         STOHead: Record "Standing Order Header";
//         STOlinesname: Text[80];
//         TransactionCharges: Record "Transaction Charges";
//         ChargeAmount: Decimal;
//         TariffDetails: Record "Tiered Charges Lines";
//         TChargeAmount: Decimal;
//         AmountDedu: Decimal;
//         LoanPrincipal: Decimal;
//         LoanRepayment: Decimal;
//         TransTypes: Record "Transaction Types";
//         DeductedSTO: Decimal;
//         SavingsACCS: Record "Savings Accounts";
//         STR: Date;
//         SkipSTO: Boolean;
//         THESavings: Record "Savings Accounts";
//         AmtDeducted: Decimal;
//         TransactionTypes: record "Transaction Types";
//         Txt004: label 'Dear Member your  standing order towards (senior saver loan) repayment was unsuccessful.';
//         GenSetup: Record "General Set-Up";
//         Loans: Record Loans;
//         SaccoTrans: Codeunit "Sacco Transactions";
//         Amt: Decimal;
//         Pfact: record "Product Factory";
//         AcctType: Enum "Gen. Journal Account Type";
//         AccType: Enum "Gen. Journal Account Type";
//         AccNo: Code[20];
//         TransType: Enum "Transaction Types";
//         BalAccType: Enum "Gen. Journal Account Type";
//         BalAccNo: Code[20];
//         JournalPosting: Codeunit "Journal Posting";
//         LoansProcess: Codeunit "Loans Process";
//         msg: Text;
//         SendSMS: Codeunit SendSMS;
//         Memb: Record Members;
//         Source: enum "SMS Source";
//     begin
//         //with SalHeaD do 
//         begin

//             GenSetup.Get;

//             StandingOrderHeader.Reset;
//             StandingOrderHeader.SetCurrentkey(StandingOrderHeader."No.");
//             StandingOrderHeader.SetRange(StandingOrderHeader."Member No.", MemberNo);
//             StandingOrderHeader.SetRange(StandingOrderHeader.Status, StandingOrderHeader.Status::Approved);
//             if SalHeaD."Income Type" = SalHeaD."Income Type"::Payments THEN
//                 Loans.SetRange(Loans."Recovery Mode", Loans."recovery mode"::"Board Allowance")
//             ELSE
//                 StandingOrderHeader.SetFilter(StandingOrderHeader."Income Type", '%1|%2|%3|%4', StandingOrderHeader."income type"::Salary,
//                                               StandingOrderHeader."income type"::Pension, StandingOrderHeader."income type"::"Direct Debit", StandingOrderHeader."income type"::SAYE);
//             if StandingOrderHeader.FindSet() then begin //*Header Info

//                 repeat
//                     SkipSTO := false;
//                     LineNo += 1;
//                     StandingOrdSRegister.Reset();
//                     StandingOrdSRegister.SetRange("Document No.", StandingOrderHeader."No.");
//                     if StandingOrdSRegister.FindSet() then begin
//                         repeat
//                             AmtDeducted += StandingOrdSRegister."Amount Deducted";
//                         until StandingOrdSRegister.Next() = 0;
//                     end;
//                     // if AmtDeducted >= StandingOrderHeader."Target Amount" then begin
//                     //     SkipSTO := true;
//                     //     StandingOrderHeader.Status := StandingOrderHeader.Status::Stopped;
//                     //     StandingOrderHeader.Modify();
//                     // end;

//                     // AmountToDeduct := StandingOrderHeader."Target Amount" - AmountDeducted;

//                     STR := (CalcDate('-5D', PDate));

//                     //For non partial
//                     StandingOrdSRegister.Reset;
//                     StandingOrdSRegister.SetCurrentkey("Date Processed", "No.");
//                     StandingOrdSRegister.SetRange("Document No.", StandingOrderHeader."No.");
//                     StandingOrdSRegister.SetRange("Deduction Status", StandingOrdSRegister."deduction status"::Successful);
//                     if StandingOrdSRegister.FindLast then begin
//                         if (StandingOrdSRegister."Date Processed" >= STR) and (StandingOrdSRegister."Date Processed" <= PDate) then
//                             SkipSTO := true;
//                     end;

//                     StandingOrderLinesII.reset;
//                     StandingOrderLinesII.SetRange("Destination Account Type", StandingOrderLinesII."Destination Account Type"::Credit);
//                     StandingOrderLinesII.SetRange(StandingOrderLinesII."Document No.", STOHeaderNo);
//                     if StandingOrderLinesII.Findset() then begin
//                         repeat
//                             if LoanApps.get(StandingOrderLinesII."Loan No.") then begin
//                                 LoanApps.CalcFields("Outstanding Balance");
//                                 if LoanApps."Outstanding Balance" <= 0 then SkipSTO := true;
//                             end else
//                                 SkipSTO := true;
//                             IF StandingOrderLinesII."Destination Account Type" = StandingOrderLinesII."Destination Account Type"::Savings then begin
//                                 IF NOT THESavings.get(StandingOrderLinesII."Destination Account No.") then
//                                     SkipSTO := true;
//                             end;
//                         until
//                         StandingOrderLinesII.Next = 0;
//                     end;

//                     //Taking into consideration double salary for partial
//                     StandingOrdSRegister.Reset;
//                     StandingOrdSRegister.SetCurrentkey("Date Processed", "No.");
//                     StandingOrdSRegister.SetRange("Document No.", StandingOrderHeader."No.");
//                     StandingOrdSRegister.SetRange("Deduction Status", StandingOrdSRegister."deduction status"::"Partial Deduction");
//                     StandingOrdSRegister.SetFilter("Date Processed", '>=%1', STR);
//                     if StandingOrdSRegister.FindLast then begin
//                         if (StandingOrdSRegister."Date Processed" >= STR) and (StandingOrdSRegister."Date Processed" <= PDate) and (StandingOrdSRegister."Amount Deducted" >= StandingOrderHeader.Amount) then
//                             SkipSTO := true;
//                     end;
//                     if SkipSTO = false then begin
//                         STOHeaderNo := '';
//                         STOHeaderNo := StandingOrderHeader."No.";
//                         //*
//                         /*StandingOrdSRegister.RESET;
//                         StandingOrdSRegister.SETRANGE(StandingOrdSRegister."Date Processed",TODAY);
//                         StandingOrdSRegister.SETRANGE("Document No.",StandingOrderHeader."No.");
//                         IF StandingOrdSRegister.FIND('-') THEN
//                         StandingOrdSRegister.DELETEALL;*///27.04.2021

//                         //*
//                         //ERROR(FORMAT(StandingOrderHeader."Allow Partial Deduction"));
//                         if StandingOrderHeader."Allow Partial Deduction" = false then begin

//                             if RunBal < StandingOrderHeader.Amount then begin

//                                 //Sto Charges on failure
//                                 GenSetup.Get;

//                                 TCharges := 0;
//                                 TransactionTypes.Reset;
//                                 TransactionTypes.SetRange(Code, GenSetup."Failed STO Fee");
//                                 if TransactionTypes.Find('-') then begin
//                                     TransactionCharges.Reset;
//                                     TransactionCharges.SetRange("Transaction Type", TransactionTypes.Code);
//                                     //TransactionCharges.SetRange("Transaction Type", StandingOrderHeader."Transaction Type");
//                                     // TransactionCharges.SetRange(TransactionCharges."Transaction Charge Category",TransactionCharges."Transaction Charge Category"::"Failed STO Charge");
//                                     if TransactionCharges.FindSet() then begin
//                                         repeat
//                                             if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::"Failed STO Charge") then begin

//                                                 ChargeAmount := 0;
//                                                 if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"Flat Amount" then
//                                                     ChargeAmount := TransactionCharges."Charge Amount";

//                                                 if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" then
//                                                     ChargeAmount := (StandingOrderHeader.Amount * TransactionCharges."Percentage of Amount") * 0.01;


//                                                 if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
//                                                     TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
//                                                     TariffDetails.Reset;
//                                                     TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
//                                                     if TariffDetails.FindSet() then begin
//                                                         repeat
//                                                             if (StandingOrderHeader.Amount >= TariffDetails."Lower Limit") and
//                                                                 (StandingOrderHeader.Amount <= TariffDetails."Upper Limit") then begin
//                                                                 if TariffDetails."Use Percentage" then
//                                                                     ChargeAmount := StandingOrderHeader.Amount * TariffDetails.Percentage * 0.01
//                                                                 else
//                                                                     ChargeAmount := TariffDetails."Charge Amount";
//                                                             end;
//                                                         until TariffDetails.Next = 0;
//                                                     end;
//                                                 end;

//                                                 LineNo := LineNo + 10000;

//                                                 GenJournalLine.Init;
//                                                 GenJournalLine."Journal Template Name" := Jtemplate;
//                                                 GenJournalLine."Journal Batch Name" := Jbatch;
//                                                 GenJournalLine."Line No." := LineNo;
//                                                 GenJournalLine."Posting Date" := PDate;
//                                                 GenJournalLine."Document No." := DocNo;
//                                                 GenJournalLine."External Document No." := StandingOrderHeader."No.";
//                                                 GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
//                                                 GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
//                                                 GenJournalLine.Description := TransactionCharges.Description;
//                                                 GenJournalLine.Validate(GenJournalLine.Amount, ChargeAmount);
//                                                 GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                                                 GenJournalLine.Validate(GenJournalLine."Bal. Account No.", TransactionCharges."G/L Account");
//                                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
//                                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
//                                                 if GenJournalLine.Amount <> 0 then
//                                                     GenJournalLine.Insert;


//                                                 if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
//                                                     (TransactionCharges."Recover Excise Duty" = true) then begin
//                                                     //Excise
//                                                     LineNo := LineNo + 10000;
//                                                     GenJournalLine.Init;
//                                                     GenJournalLine."Journal Template Name" := Jtemplate;
//                                                     GenJournalLine."Journal Batch Name" := Jbatch;
//                                                     GenJournalLine."Line No." := LineNo;
//                                                     GenJournalLine."Posting Date" := PDate;
//                                                     GenJournalLine."Document No." := DocNo;
//                                                     GenJournalLine."External Document No." := StandingOrderHeader."No.";
//                                                     GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
//                                                     GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
//                                                     GenJournalLine.Description := 'Excise Duty';//TransactionCharges.Description;
//                                                     GenJournalLine.Validate(GenJournalLine.Amount, (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01);
//                                                     GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                                                     GenJournalLine.Validate(GenJournalLine."Bal. Account No.", GenSetup."Excise Duty G/L");
//                                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
//                                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
//                                                     if GenJournalLine.Amount <> 0 then
//                                                         GenJournalLine.Insert;
//                                                     //Excise
//                                                 end;
//                                                 TChargeAmount += ChargeAmount;
//                                             end;
//                                         until TransactionCharges.Next = 0;
//                                     end;
//                                 end;
//                                 TCharges := TChargeAmount;

//                                 SaccoTrans.UpdateStandingOrderRegister('', Today, StandingOrderHeader."No.", '', StandingOrderHeader."Source Account No.", StandingOrderHeader."Source Account Name",
//                                                                     StandingOrderHeader."Member No.", StandingOrderHeader."Payroll/Staff No.", StandingOrderHeader."Allow Partial Deduction",
//                                                                     Standingorddeductstatus::Failed, StandingOrderHeader.Amount, 0, StandingOrderHeader."Effective/Start Date", StandingOrderHeader."Duration (Months)",
//                                                                     StandingOrderHeader."Frequency (Months)", StandingOrderHeader."End Date", StandingOrderHeader.Description, StandingOrderHeader."Transfered to EFT", false, StandingOrderHeader."No.");
//                                 //SendSMS.SendSms(Source::ATM_COLLECTION, SavingsAcc."Mobile Phone No", Txt004, Format(StandingOrderHeader."No."), '', true, 0, false, 'CBS', StandingOrderHeader."No.", 'CBS');
//                                 // StandingOrdSRegister.Reset();
//                                 // StandingOrdSRegister.SetRange("No.", StandingOrdSRegister."Standing Order No.");
//                                 // StandingOrdSRegister.SetRange("Source Account No.", StandingOrdSRegister."Source Account No.");
//                                 // StandingOrdSRegister.SetRange("Member No", StandingOrderHeader."Member No.");
//                                 // StandingOrdSRegister.SetRange("Deduction Status", StandingOrdSRegister."Deduction Status"::Failed);
//                                 // if StandingOrdSRegister.FindFirst() then begin
//                                 //     msg := 'Dear ' + StandingOrdSRegister."Source Account Name" + ', Your Standing Order towards (senior saver loan) repayment was unsuccessful.';
//                                 //     SendSMS.SendSms(Source::Tenants, Memb."Phone No.", msg, Format(Memb."No."), '', true, 0, false, 'CBS', Format(Memb."No."), 'CBS');
//                                 // end;

//                                 //Sto Charges on failure
//                             end else begin

//                                 SaccoTrans.UpdateStandingOrderRegister('', Today, StandingOrderHeader."No.", '', StandingOrderHeader."Source Account No.", StandingOrderHeader."Source Account Name",
//                                                                 StandingOrderHeader."Member No.", StandingOrderHeader."Payroll/Staff No.", StandingOrderHeader."Allow Partial Deduction",
//                                                                 Standingorddeductstatus::Successfull, StandingOrderHeader.Amount, StandingOrderHeader.Amount, StandingOrderHeader."Effective/Start Date", StandingOrderHeader."Duration (Months)",
//                                                                 StandingOrderHeader."Frequency (Months)", StandingOrderHeader."End Date", StandingOrderHeader.Description, StandingOrderHeader."Transfered to EFT", false, StandingOrderHeader."No.");


//                                 STOlinesname := '';
//                                 AmountDedu := 0;

//                                 //*Line Posting
//                                 StandingOrderLines.Reset;
//                                 //StandingOrderLines.SETCURRENTKEY("Destination Account Type","Destination Account Type"::Internal);
//                                 StandingOrderLines.SetRange(StandingOrderLines."Document No.", STOHeaderNo);
//                                 if StandingOrderLines.FindSet() then begin
//                                     repeat
//                                         case StandingOrderLines."Destination Account Type" of
//                                             //*Credit Entries
//                                             StandingOrderLines."destination account type"::Credit:
//                                                 begin

//                                                     LoanApps.Reset;
//                                                     LoanApps.SetRange(LoanApps."Loan No.", StandingOrderLines."Loan No.");
//                                                     //LoanApps.SETFILTER("Total Balance",'>0');
//                                                     if LoanApps.Find('-') then begin
//                                                         LoanApps.CalcFields(LoanApps."Outstanding Interest", LoanApps."Outstanding Balance", "Daily Interest");
//                                                         //Capitalize Interest
//                                                         if LoanApps."Daily Interest" > 0 then begin
//                                                             Amt := 0;
//                                                             // Accrue Interest;
//                                                             Pfact.Get(LoanApps."Loan Product Type");
//                                                             Pfact.TestField("Loan Interest Account [G/L]");
//                                                             AcctType := AcctType::Credit;
//                                                             TransType := TransType::"Interest Due";
//                                                             LineNo := LineNo + 10000;
//                                                             AccNo := LoanApps."Loan Account";
//                                                             BalAccType := BalAccType::"G/L Account";
//                                                             BalAccNo := Pfact."Loan Interest Account [G/L]";
//                                                             Amt := LoanApps."Daily Interest";

//                                                             JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, DocNo,
//                                                             CopyStr('Daily Interest Capitalized', 1, 50), Amt, AccNo, PDate, BalAccType,
//                                                             BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
//                                                             LoansProcess.ClearDailyInterest(LoanApps."Loan No.");
//                                                         end;


//                                                         LineNo := LineNo + 10000;

//                                                         GenJournalLine.Init;
//                                                         GenJournalLine."Journal Template Name" := Jtemplate;
//                                                         GenJournalLine."Journal Batch Name" := Jbatch;
//                                                         GenJournalLine."Line No." := LineNo;
//                                                         GenJournalLine."Posting Date" := PDate;
//                                                         GenJournalLine."Document No." := DocNo;
//                                                         GenJournalLine."External Document No." := StandingOrderHeader."No.";
//                                                         GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
//                                                         GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
//                                                         //GenJournalLine.Description:='Destination:-'+LoanApps."Loan No."+'-'+StandingOrderLines."Destination Account Name";
//                                                         GenJournalLine.Description := PadStr('STO:-' + LoanApps."Loan No." + '-' + Format(StandingOrderHeader."Source Account Name"), 50);
//                                                         if (LoanApps."Outstanding Interest" + LoanApps."Daily Interest") > StandingOrderLines.Amount then begin
//                                                             LoanInterest := StandingOrderLines.Amount;
//                                                             LoanPrinciple := 0;
//                                                         end else begin
//                                                             LoanPrinciple := StandingOrderLines.Amount - (LoanApps."Outstanding Interest" + LoanApps."Daily Interest");
//                                                             if LoanPrinciple < 0 then LoanPrinciple := 0;
//                                                             LoanInterest := (LoanApps."Outstanding Interest" + LoanApps."Daily Interest");
//                                                             if LoanInterest < 0 then LoanInterest := 0;
//                                                         end;
//                                                         GenJournalLine.Validate(GenJournalLine.Amount, -LoanInterest);
//                                                         GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
//                                                         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
//                                                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
//                                                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
//                                                         if GenJournalLine.Amount <> 0 then
//                                                             GenJournalLine.Insert;
//                                                         RunBal -= Abs(GenJournalLine.Amount);
//                                                         AmountDedu += Abs(GenJournalLine.Amount);


//                                                         if LoanPrinciple > LoanApps."Outstanding Balance" then
//                                                             LoanPrinciple := LoanApps."Outstanding Balance";

//                                                         //repayment
//                                                         LineNo := LineNo + 10000;

//                                                         GenJournalLine.Init;
//                                                         GenJournalLine."Journal Template Name" := Jtemplate;
//                                                         GenJournalLine."Journal Batch Name" := Jbatch;
//                                                         GenJournalLine."Line No." := LineNo;
//                                                         GenJournalLine."Posting Date" := PDate;
//                                                         GenJournalLine."Document No." := DocNo;
//                                                         GenJournalLine."External Document No." := StandingOrderHeader."No.";
//                                                         GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
//                                                         GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
//                                                         //GenJournalLine.Description:='Destination:-'+LoanApps."Loan No."+'-'+StandingOrderLines."Destination Account Name";
//                                                         GenJournalLine.Description := PadStr('STO:-' + LoanApps."Loan No." + '-' + Format(StandingOrderHeader."Source Account Name"), 50);
//                                                         //if LoanPrinciple > 0 then begin
//                                                         GenJournalLine.Validate(GenJournalLine.Amount, -LoanPrinciple);
//                                                         GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
//                                                         GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
//                                                         // End else
//                                                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
//                                                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
//                                                         if GenJournalLine.Amount <> 0 then
//                                                             GenJournalLine.Insert;
//                                                         RunBal -= Abs(GenJournalLine.Amount);
//                                                         AmountDedu += Abs(GenJournalLine.Amount);

//                                                         //Excess Back to FOSA
//                                                         /*
//                                                         if (StandingOrderLines.Amount - (LoanPrincipal + LoanInterest)) > 0 then begin
//                                                             //repayment
//                                                             LineNo := LineNo + 10000;

//                                                             GenJournalLine.Init;
//                                                             GenJournalLine."Journal Template Name" := Jtemplate;
//                                                             GenJournalLine."Journal Batch Name" := Jbatch;
//                                                             GenJournalLine."Line No." := LineNo;
//                                                             GenJournalLine."Posting Date" := PDate;
//                                                             GenJournalLine."Document No." := DocNo;
//                                                             GenJournalLine."External Document No." := StandingOrderHeader."No.";
//                                                             GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type"::Savings;
//                                                             GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
//                                                             GenJournalLine.Description := PadStr('STO:-' + LoanApps."Loan No." + '-' + Format(StandingOrderHeader."Source Account Name"), 50);
//                                                             GenJournalLine.Amount := ((StandingOrderLines.Amount - (LoanPrincipal + LoanInterest)) * -1);
//                                                             GenJournalLine.validate(Amount);
//                                                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
//                                                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
//                                                             if GenJournalLine.Amount <> 0 then
//                                                                 GenJournalLine.Insert;
//                                                             RunBal -= Abs(GenJournalLine.Amount);
//                                                             AmountDedu += Abs(GenJournalLine.Amount);
//                                                         end;*/

//                                                     end;
//                                                 end;//Credit Entries



//                                             //*Internal,External Entries
//                                             StandingOrderLines."destination account type"::"G/L Account", StandingOrderLines."destination account type"::Savings:
//                                                 begin

//                                                     LineNo := LineNo + 10000;

//                                                     GenJournalLine.Init;
//                                                     GenJournalLine."Journal Template Name" := Jtemplate;
//                                                     GenJournalLine."Journal Batch Name" := Jbatch;

//                                                     GenJournalLine."Line No." := LineNo;

//                                                     GenJournalLine."Posting Date" := PDate;
//                                                     GenJournalLine."Document No." := DocNo;
//                                                     GenJournalLine."External Document No." := StandingOrderHeader."No.";

//                                                     case StandingOrderLines."Destination Account Type" of

//                                                         StandingOrderLines."destination account type"::"G/L Account":
//                                                             begin
//                                                                 GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
//                                                                 GenJournalLine.Validate(GenJournalLine."Account No.", GenSetup."External STO Account No.");
//                                                             end;


//                                                         StandingOrderLines."destination account type"::Savings:
//                                                             begin
//                                                                 GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
//                                                                 GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
//                                                             end;
//                                                     end;

//                                                     //GenJournalLine.Description:='Destination:-'+StandingOrderLines."Destination Account Name";
//                                                     GenJournalLine.Description := PadStr('STO:-' + Format(StandingOrderHeader."No.") + '-' + Format(StandingOrderHeader."Source Account Name"), 50);

//                                                     if RunBal >= StandingOrderLines.Amount then
//                                                         GenJournalLine.Validate(GenJournalLine.Amount, -StandingOrderLines.Amount)
//                                                     else
//                                                         GenJournalLine.Validate(GenJournalLine.Amount, -RunBal);

//                                                     //GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
//                                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
//                                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
//                                                     if GenJournalLine.Amount <> 0 then
//                                                         GenJournalLine.Insert;
//                                                     RunBal -= Abs(GenJournalLine.Amount);
//                                                     AmountDedu += Abs(GenJournalLine.Amount);
//                                                 end;//*Internal,External Entries


//                                         end;
//                                     until StandingOrderLines.Next = 0;
//                                 end;


//                                 //*Header Posting

//                                 if STOHead.Get(STOHeaderNo) then begin

//                                     //**********************
//                                     GenSetup.Get;


//                                     TCharges := 0;
//                                     TransactionCharges.Reset;
//                                     TransactionCharges.SetRange(TransactionCharges."Transaction Type", StandingOrderHeader."Transaction Type");
//                                     if TransactionCharges.FindSet() then begin
//                                         repeat

//                                             if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) then begin

//                                                 ChargeAmount := 0;
//                                                 if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" then
//                                                     ChargeAmount := (StandingOrderHeader.Amount * TransactionCharges."Percentage of Amount") * 0.01
//                                                 else
//                                                     ChargeAmount := TransactionCharges."Charge Amount";

//                                                 if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
//                                                     TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
//                                                     TariffDetails.Reset;
//                                                     TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
//                                                     if TariffDetails.FindSet() then begin
//                                                         repeat
//                                                             if (StandingOrderHeader.Amount >= TariffDetails."Lower Limit") and
//                                                                 (StandingOrderHeader.Amount <= TariffDetails."Upper Limit") then begin
//                                                                 if TariffDetails."Use Percentage" then
//                                                                     ChargeAmount := StandingOrderHeader.Amount * TariffDetails.Percentage * 0.01
//                                                                 else
//                                                                     ChargeAmount := TariffDetails."Charge Amount";
//                                                             end;
//                                                         until TariffDetails.Next = 0;
//                                                     end;
//                                                 end;

//                                                 LineNo := LineNo + 10000;

//                                                 GenJournalLine.Init;
//                                                 GenJournalLine."Journal Template Name" := Jtemplate;
//                                                 GenJournalLine."Journal Batch Name" := Jbatch;
//                                                 GenJournalLine."Line No." := LineNo;
//                                                 GenJournalLine."Posting Date" := PDate;
//                                                 GenJournalLine."Document No." := DocNo;
//                                                 GenJournalLine."External Document No." := StandingOrderHeader."No.";
//                                                 GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
//                                                 GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
//                                                 GenJournalLine.Description := TransactionCharges.Description;
//                                                 GenJournalLine.Validate(GenJournalLine.Amount, ChargeAmount);
//                                                 GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                                                 GenJournalLine.Validate(GenJournalLine."Bal. Account No.", TransactionCharges."G/L Account");
//                                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
//                                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
//                                                 if GenJournalLine.Amount <> 0 then
//                                                     GenJournalLine.Insert;


//                                                 if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
//                                                     (TransactionCharges."Recover Excise Duty" = true) then begin
//                                                     //Excise
//                                                     LineNo := LineNo + 10000;
//                                                     GenJournalLine.Init;
//                                                     GenJournalLine."Journal Template Name" := Jtemplate;
//                                                     GenJournalLine."Journal Batch Name" := Jbatch;
//                                                     GenJournalLine."Line No." := LineNo;
//                                                     GenJournalLine."Posting Date" := PDate;
//                                                     GenJournalLine."Document No." := DocNo;
//                                                     GenJournalLine."External Document No." := StandingOrderHeader."No.";
//                                                     GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
//                                                     GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
//                                                     GenJournalLine.Description := 'Excise Duty';//TransactionCharges.Description;
//                                                     GenJournalLine.Validate(GenJournalLine.Amount, (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01);
//                                                     GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                                                     GenJournalLine.Validate(GenJournalLine."Bal. Account No.", GenSetup."Excise Duty G/L");
//                                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
//                                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
//                                                     if GenJournalLine.Amount <> 0 then
//                                                         GenJournalLine.Insert;
//                                                     //Excise
//                                                 end;
//                                                 TChargeAmount += ChargeAmount;
//                                             end;
//                                         until TransactionCharges.Next = 0;
//                                     end;
//                                     TCharges := TChargeAmount;
//                                     //**********************

//                                     LineNo := LineNo + 10000;

//                                     GenJournalLine.Init;
//                                     GenJournalLine."Journal Template Name" := Jtemplate;
//                                     GenJournalLine."Journal Batch Name" := Jbatch;

//                                     GenJournalLine."Line No." := LineNo;

//                                     GenJournalLine."Posting Date" := PDate;
//                                     GenJournalLine."Document No." := DocNo;
//                                     GenJournalLine."External Document No." := STOHead."No.";
//                                     GenJournalLine."Account Type" := GenJournalLine."Account Type"::Savings;
//                                     GenJournalLine.Validate(GenJournalLine."Account No.", STOHead."Source Account No.");
//                                     //GenJournalLine.Description:='Source:-'+STOHead."Source Account Name";
//                                     GenJournalLine.Description := PadStr('STO:-' + Format(STOHead."No.") + '-' + Format(STOlinesname), 50);
//                                     // if AmountDedu > 0 then
//                                     GenJournalLine.Validate(GenJournalLine.Amount, AmountDedu);// ELSE
//                                     //    GenJournalLine.Validate(GenJournalLine.Amount, STOHead.Amount);

//                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
//                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
//                                     if GenJournalLine.Amount <> 0 then
//                                         GenJournalLine.Insert;
//                                 end;
//                             end;
//                         end else begin
//                             //Partial
//                             AmountDedu := 0;
//                             DeductedSTO := 0;

//                             //Taking into consideration double salary
//                             StandingOrdSRegister.Reset;
//                             StandingOrdSRegister.SetCurrentkey("Date Processed", "No.");
//                             StandingOrdSRegister.SetRange("Document No.", StandingOrderHeader."No.");
//                             StandingOrdSRegister.SetRange("Deduction Status", StandingOrdSRegister."deduction status"::"Partial Deduction");
//                             StandingOrdSRegister.SetFilter("Date Processed", '>=%1', STR);
//                             if StandingOrdSRegister.FindLast then begin
//                                 if (StandingOrdSRegister."Date Processed" >= STR) and (StandingOrdSRegister."Date Processed" <= PDate) then
//                                     StandingOrderHeader.Amount -= StandingOrdSRegister."Amount Deducted";
//                             end;


//                             if RunBal > StandingOrderHeader.Amount then begin
//                                 DeductedSTO := StandingOrderHeader.Amount;
//                                 StandingOrdDeductStatus := Standingorddeductstatus::Successfull;
//                             end else begin
//                                 DeductedSTO := RunBal;
//                                 StandingOrdDeductStatus := Standingorddeductstatus::"Partial Deduction";

//                             end;
//                             if DeductedSTO < 0 then
//                                 DeductedSTO := 0;
//                             //  ERROR(FORMAT(StandingOrdDeductStatus));
//                             SaccoTrans.UpdateStandingOrderRegister('', Today, StandingOrderHeader."No.", '', StandingOrderHeader."Source Account No.", StandingOrderHeader."Source Account Name",
//                                                         StandingOrderHeader."Member No.", StandingOrderHeader."Payroll/Staff No.", StandingOrderHeader."Allow Partial Deduction",
//                                                         StandingOrdDeductStatus, StandingOrderHeader.Amount, DeductedSTO, StandingOrderHeader."Effective/Start Date", StandingOrderHeader."Duration (Months)",
//                                                         StandingOrderHeader."Frequency (Months)", StandingOrderHeader."End Date", StandingOrderHeader.Description, StandingOrderHeader."Transfered to EFT", false, StandingOrderHeader."No.");


//                             if StandingOrderHeader."Allow Partial Deduction" = true then begin //Partial Deduction
//                                 StandingOrderLines.Reset;
//                                 StandingOrderLines.SetRange(StandingOrderLines."Document No.", StandingOrderHeader."No.");
//                                 if StandingOrderLines.FindSet() then begin
//                                     repeat
//                                         STOlinesname := StandingOrderLines."Destination Account Name";
//                                         //   MESSAGE('The Lines name is %1',STOlinesname);
//                                         case StandingOrderLines."Destination Account Type" of
//                                             StandingOrderLines."destination account type"::Savings, StandingOrderLines."destination account type"::"G/L Account":
//                                                 begin
//                                                     LineNo := LineNo + 10000;
//                                                     GenJournalLine.Init;
//                                                     GenJournalLine."Journal Template Name" := Jtemplate;
//                                                     GenJournalLine."Journal Batch Name" := Jbatch;
//                                                     GenJournalLine."Posting Date" := PDate;
//                                                     GenJournalLine."Line No." := LineNo;
//                                                     GenJournalLine."Document No." := DocNo;
//                                                     GenJournalLine."External Document No." := STOHead."No.";
//                                                     GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
//                                                     GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
//                                                     //GenJournalLine.Description:=PADSTR('Destination:- '+StandingOrderHeader."Source Account No."+'-'+StandingOrderHeader."Source Account Name",50);
//                                                     GenJournalLine.Description := PadStr('STO:-' + Format(StandingOrderHeader."No.") + '-' + Format(StandingOrderHeader."Source Account Name"), 50);
//                                                     if RunBal >= StandingOrderLines.Amount then
//                                                         GenJournalLine.Validate(GenJournalLine.Amount, -StandingOrderLines.Amount)
//                                                     else
//                                                         GenJournalLine.Validate(GenJournalLine.Amount, -RunBal);

//                                                     //GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
//                                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
//                                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
//                                                     if GenJournalLine.Amount <> 0 then
//                                                         GenJournalLine.Insert;

//                                                     RunBal -= Abs(GenJournalLine.Amount);
//                                                     AmountDedu += Abs(GenJournalLine.Amount); //MESSAGE('TE5 :%1',AmountDedu);
//                                                 end;

//                                             StandingOrderLines."destination account type"::Credit:
//                                                 begin

//                                                     LoanInterest := 0;
//                                                     LoanPrincipal := 0;
//                                                     LoanRepayment := 0;

//                                                     LoanApps.Reset;
//                                                     LoanApps.SetRange(LoanApps."Loan No.", StandingOrderLines."Loan No.");
//                                                     if LoanApps.Find('-') then begin
//                                                         LoanApps.CalcFields(LoanApps."Outstanding Interest", LoanApps."Daily Interest", LoanApps."Outstanding Balance");
//                                                         //Capitalize Interest
//                                                         if LoanApps."Daily Interest" > 0 then begin
//                                                             Amt := 0;
//                                                             // Accrue Interest;
//                                                             Pfact.Get(LoanApps."Loan Product Type");
//                                                             Pfact.TestField("Loan Interest Account [G/L]");
//                                                             AcctType := AcctType::Credit;
//                                                             TransType := TransType::"Interest Due";
//                                                             LineNo := LineNo + 10000;
//                                                             AccNo := LoanApps."Loan Account";
//                                                             BalAccType := BalAccType::"G/L Account";
//                                                             BalAccNo := Pfact."Loan Interest Account [G/L]";
//                                                             Amt := LoanApps."Daily Interest";

//                                                             JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, DocNo,
//                                                             CopyStr('Daily Interest Capitalized', 1, 50), Amt, AccNo, PDate, BalAccType,
//                                                             BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
//                                                             LoansProcess.ClearDailyInterest(LoanApps."Loan No.");
//                                                         end;


//                                                         LoanPrincipal := StandingOrderLines.Amount;

//                                                         if (LoanApps."Outstanding Interest" + LoanApps."Daily Interest") > 0 then begin
//                                                             LineNo := LineNo + 10000;
//                                                             GenJournalLine.Init;
//                                                             GenJournalLine."Journal Template Name" := Jtemplate;
//                                                             GenJournalLine."Journal Batch Name" := Jbatch;
//                                                             GenJournalLine."Line No." := LineNo;
//                                                             GenJournalLine."Posting Date" := PDate;
//                                                             GenJournalLine."Document No." := DocNo;
//                                                             GenJournalLine."External Document No." := STOHead."No.";
//                                                             GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
//                                                             GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
//                                                             GenJournalLine.Description := PadStr('Destination:-' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
//                                                                                          Format(GenJournalLine."transaction type"::"Interest Paid"), 50);

//                                                             if (LoanApps."Outstanding Interest" + LoanApps."Daily Interest") > StandingOrderLines.Amount then begin
//                                                                 LoanInterest := StandingOrderLines.Amount;
//                                                                 LoanPrincipal := StandingOrderLines.Amount - LoanInterest;
//                                                                 if LoanPrincipal < 0 then LoanPrincipal := 0;
//                                                             end else
//                                                                 LoanInterest := (LoanApps."Outstanding Interest" + LoanApps."Daily Interest");
//                                                             if LoanInterest < 0 then LoanInterest := 0;

//                                                             if RunBal > LoanInterest then
//                                                                 GenJournalLine.Validate(GenJournalLine.Amount, -LoanInterest)
//                                                             else
//                                                                 GenJournalLine.Validate(GenJournalLine.Amount, -RunBal);

//                                                             GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
//                                                             GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
//                                                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
//                                                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
//                                                             if GenJournalLine.Amount <> 0 then
//                                                                 GenJournalLine.Insert;

//                                                             RunBal -= Abs(GenJournalLine.Amount);
//                                                             AmountDedu += Abs(GenJournalLine.Amount);
//                                                         end;

//                                                         if (LoanApps."Outstanding Balance" > 0) then begin
//                                                             LineNo := LineNo + 10000;
//                                                             LineNo := LineNo + 10000;
//                                                             GenJournalLine.Init;
//                                                             GenJournalLine."Journal Template Name" := Jtemplate;
//                                                             GenJournalLine."Journal Batch Name" := Jbatch;
//                                                             GenJournalLine."Line No." := LineNo;
//                                                             GenJournalLine."Posting Date" := PDate;
//                                                             GenJournalLine."Document No." := DocNo;
//                                                             GenJournalLine."External Document No." := STOHead."No.";
//                                                             GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
//                                                             GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
//                                                             GenJournalLine.Description := PadStr('Destination:-' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
//                                                                                          Format(GenJournalLine."transaction type"::Repayment), 50);

//                                                             if LoanApps."Outstanding Balance" > LoanPrincipal then
//                                                                 LoanRepayment := LoanPrincipal
//                                                             else
//                                                                 LoanRepayment := LoanApps."Outstanding Balance";

//                                                             if RunBal > LoanRepayment then
//                                                                 GenJournalLine.Validate(GenJournalLine.Amount, -LoanRepayment)
//                                                             else
//                                                                 GenJournalLine.Validate(GenJournalLine.Amount, -RunBal);

//                                                             GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
//                                                             GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
//                                                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
//                                                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
//                                                             if GenJournalLine.Amount <> 0 then
//                                                                 GenJournalLine.Insert;

//                                                             RunBal -= Abs(GenJournalLine.Amount);
//                                                             AmountDedu += Abs(GenJournalLine.Amount);  //MESSAGE('TE8 :%1',AmountDedu);
//                                                         end;


//                                                     end;
//                                                     /*Excess Back to Savings

//                                                     if (StandingOrderLines.Amount - (LoanRepayment + LoanInterest)) > 0 then begin
//                                                         //repayment
//                                                         LineNo := LineNo + 10000;

//                                                         GenJournalLine.Init;
//                                                         GenJournalLine."Journal Template Name" := Jtemplate;
//                                                         GenJournalLine."Journal Batch Name" := Jbatch;
//                                                         GenJournalLine."Line No." := LineNo;
//                                                         GenJournalLine."Posting Date" := PDate;
//                                                         GenJournalLine."Document No." := DocNo;
//                                                         GenJournalLine."External Document No." := StandingOrderHeader."No.";
//                                                         GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type"::Savings;
//                                                         GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
//                                                         GenJournalLine.Description := PadStr('STO:-' + LoanApps."Loan No." + '-' + Format(StandingOrderHeader."Source Account Name"), 50);
//                                                         GenJournalLine.Amount := ((StandingOrderLines.Amount - (LoanPrincipal + LoanInterest)) * -1);
//                                                         GenJournalLine.validate(Amount);
//                                                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
//                                                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
//                                                         if GenJournalLine.Amount <> 0 then
//                                                             GenJournalLine.Insert;
//                                                         RunBal -= Abs(GenJournalLine.Amount);
//                                                         AmountDedu += Abs(GenJournalLine.Amount);
//                                                     end;*/

//                                                 end;
//                                         end;
//                                     until StandingOrderLines.Next = 0;
//                                 end;
//                                 //--Partial End***
//                             end;

//                             //*Header Posting

//                             if STOHead.Get(STOHeaderNo) then begin


//                                 //Charges
//                                 STOlinesname := StandingOrderLines."Destination Account Name";


//                                 GenSetup.Get;


//                                 TCharges := 0;
//                                 TransactionCharges.Reset;
//                                 TransactionCharges.SetRange(TransactionCharges."Transaction Type", StandingOrderHeader."Transaction Type");
//                                 if TransactionCharges.FindSet() then begin
//                                     repeat

//                                         if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) then begin

//                                             ChargeAmount := 0;
//                                             if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" then
//                                                 ChargeAmount := (StandingOrderHeader.Amount * TransactionCharges."Percentage of Amount") * 0.01
//                                             else
//                                                 ChargeAmount := TransactionCharges."Charge Amount";

//                                             if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
//                                                 TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
//                                                 TariffDetails.Reset;
//                                                 TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
//                                                 if TariffDetails.FindSet() then begin
//                                                     repeat
//                                                         if (StandingOrderHeader.Amount >= TariffDetails."Lower Limit") and
//                                                             (StandingOrderHeader.Amount <= TariffDetails."Upper Limit") then begin
//                                                             if TariffDetails."Use Percentage" then
//                                                                 ChargeAmount := StandingOrderHeader.Amount * TariffDetails.Percentage * 0.01
//                                                             else
//                                                                 ChargeAmount := TariffDetails."Charge Amount";
//                                                         end;
//                                                     until TariffDetails.Next = 0;
//                                                 end;
//                                             end;

//                                             LineNo := LineNo + 10000;

//                                             GenJournalLine.Init;
//                                             GenJournalLine."Journal Template Name" := Jtemplate;
//                                             GenJournalLine."Journal Batch Name" := Jbatch;
//                                             GenJournalLine."Line No." := LineNo;
//                                             GenJournalLine."Posting Date" := PDate;
//                                             GenJournalLine."Document No." := DocNo;
//                                             GenJournalLine."External Document No." := StandingOrderHeader."No.";
//                                             GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
//                                             GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
//                                             GenJournalLine.Description := TransactionCharges.Description;
//                                             GenJournalLine.Validate(GenJournalLine.Amount, ChargeAmount);
//                                             GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                                             GenJournalLine.Validate(GenJournalLine."Bal. Account No.", TransactionCharges."G/L Account");
//                                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
//                                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
//                                             if GenJournalLine.Amount <> 0 then
//                                                 GenJournalLine.Insert;


//                                             if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
//                                                 (TransactionCharges."Recover Excise Duty" = true) then begin
//                                                 //Excise
//                                                 LineNo := LineNo + 10000;
//                                                 GenJournalLine.Init;
//                                                 GenJournalLine."Journal Template Name" := Jtemplate;
//                                                 GenJournalLine."Journal Batch Name" := Jbatch;
//                                                 GenJournalLine."Line No." := LineNo;
//                                                 GenJournalLine."Posting Date" := PDate;
//                                                 GenJournalLine."Document No." := DocNo;
//                                                 GenJournalLine."External Document No." := StandingOrderHeader."No.";
//                                                 GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
//                                                 GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
//                                                 GenJournalLine.Description := 'Excise Duty';//TransactionCharges.Description;
//                                                 GenJournalLine.Validate(GenJournalLine.Amount, (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01);
//                                                 GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                                                 GenJournalLine.Validate(GenJournalLine."Bal. Account No.", GenSetup."Excise Duty G/L");
//                                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
//                                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
//                                                 if GenJournalLine.Amount <> 0 then
//                                                     GenJournalLine.Insert;
//                                                 //Excise
//                                             end;
//                                             TChargeAmount += ChargeAmount;
//                                         end;
//                                     until TransactionCharges.Next = 0;
//                                 end;
//                                 TCharges := TChargeAmount;
//                                 //Charges
//                                 LineNo := LineNo + 10000;

//                                 GenJournalLine.Init;
//                                 GenJournalLine."Journal Template Name" := Jtemplate;
//                                 GenJournalLine."Journal Batch Name" := Jbatch;

//                                 GenJournalLine."Line No." := LineNo;

//                                 GenJournalLine."Posting Date" := PDate;
//                                 GenJournalLine."Document No." := DocNo;
//                                 GenJournalLine."External Document No." := STOHead."No.";
//                                 GenJournalLine."Account Type" := STOHead."Source Account Type";
//                                 GenJournalLine.Validate(GenJournalLine."Account No.", STOHead."Source Account No.");
//                                 //GenJournalLine.Description:='Source:-'+STOHead."Source Account Name";
//                                 GenJournalLine.Description := PadStr('STO:-' + Format(STOHead."No.") + '-' + Format(STOlinesname), 50);
//                                 GenJournalLine.Validate(GenJournalLine.Amount, AmountDedu);
//                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
//                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
//                                 if GenJournalLine.Amount <> 0 then
//                                     GenJournalLine.Insert;
//                             end;
//                         end;

//                         StandingOrdSRegister.Reset();
//                         StandingOrdSRegister.SetRange("No.", StandingOrdSRegister."Standing Order No.");
//                         StandingOrdSRegister.SetRange("Source Account No.", StandingOrdSRegister."Source Account No.");
//                         StandingOrdSRegister.SetRange("Member No", StandingOrderHeader."Member No.");
//                         StandingOrdSRegister.SetRange("Deduction Status", StandingOrdSRegister."Deduction Status"::Failed);
//                         if StandingOrdSRegister.FindFirst() then begin
//                             msg := 'Dear ' + StandingOrdSRegister."Source Account Name" + ', Your Standing Order towards loan repayment was unsuccessful.';
//                             SendSMS.SendSms(Source::Tenants, Memb."Phone No.", msg, Format(Memb."No."), '', true, 0, false, 'CBS', Format(Memb."No."), 'CBS');
//                         end;
//                     end;//All Successful STOS Exempt

//                 until StandingOrderHeader.Next = 0;
//             end;//*Header Info
//         end;



//         //PostLoansArreas(SalHeaD,DocNo,PDate,DActivity2,DBranch2,Jtemplate,Jbatch,RunBal,MemberNo,LineNo,Salaccno);

//     end;
// }