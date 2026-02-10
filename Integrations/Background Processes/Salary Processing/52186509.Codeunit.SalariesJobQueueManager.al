// codeunit 52186530 "Salaries Job Queue Manager"
// {
//     TableNo = "Salary Header P";
//     trigger OnRun()
//     var
//         RecordsPerBatch: Integer;
//         Counter: Integer;
//         StartFrom: Integer;

//         JobQueueEntry: Record "Job Queue Entry";
//         SalLines: Record "Salary Lines P";
//         TheDuration: Duration;

//         TheParameterObj: JsonObject;
//         TheParameterString: Text;

//         DialogProgress: Dialog;
//         RecordCount: Integer;
//         NoOfThreads: Integer;

//         Settings: Record "Sky Background Process Manager";
//     begin
//         JobQueueEntry.Reset;

//         JobQueueEntry.SetFilter("Object ID to Run", '=%1|%2', Codeunit::"Salary Job", Codeunit::"Salaries Job Queue Manager");
//         JobQueueEntry.SetRange(Status, JobQueueEntry.Status::"In Process");

//         if JobQueueEntry.FindSet then begin
//             Error('There are ongoing salaries process jobs running at the moment. Count = %1', JobQueueEntry.Count);
//         end;

//         // Clear not in process
//         JobQueueEntry.Reset;
//         JobQueueEntry.SetFilter("Object ID to Run", '=%1|%2', Codeunit::"Salary Job", Codeunit::"Salaries Job Queue Manager");
//         JobQueueEntry.SetFilter(Status, '<>%1', JobQueueEntry.Status::"In Process");
//         JobQueueEntry.DeleteAll();

//         JobQueueEntry.Reset;

//         if Settings.FindFirst then begin
//             Settings.TestField("Records Pause Count");
//             Settings.TestField("Threads Count");

//             StartFrom := 1;
//             Counter := 0;

//             SalLines.Reset;
//             SalLines.SetRange(SalLines."Salary Header No.", Rec.No);
//             SalLines.SetRange(Posted, false);

//             if SalLines.FindSet then begin
//                 RecordCount := SalLines.Count;

//                 NoOfThreads := Settings."Threads Count";
//                 RecordsPerBatch := Round(RecordCount / NoOfThreads, 1, '>');

//                 while ((Counter < RecordCount) and (RecordCount <> 0)) do begin
//                     Clear(TheParameterObj);
//                     TheParameterString := '';
//                     Counter += RecordsPerBatch;

//                     if Counter = RecordsPerBatch then begin
//                         DialogProgress.Open('Preparing salary lines batch from #1 to #2###', StartFrom, Counter);
//                     end else begin
//                         DialogProgress.Update();
//                     end;

//                     if Counter >= RecordCount then begin
//                         Counter := RecordCount;
//                     end;

//                     JobQueueEntry.Init;

//                     JobQueueEntry.ID := CreateGuid();
//                     JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
//                     JobQueueEntry."Object ID to Run" := Codeunit::"Salary Job";
//                     JobQueueEntry.Description := 'Salary job starting from record ' + Format(StartFrom) + ' to record ' + Format(Counter);
//                     JobQueueEntry."Job Queue Category Code" := '';
//                     JobQueueEntry."Recurring Job" := false;
//                     JobQueueEntry.Status := JobQueueEntry.Status::Ready;
//                     JobQueueEntry."Earliest Start Date/Time" := CurrentDateTime + 1000;
//                     JobQueueEntry."Starting Time" := Time + 1000;

//                     TheParameterObj.Add('task_id', JobQueueEntry.ID);
//                     TheParameterObj.Add('start', StartFrom);
//                     TheParameterObj.Add('end', Counter);
//                     TheParameterObj.Add('records_pause', Settings."Records Pause Count");
//                     TheParameterObj.Add('salary_header_no', Rec.No);

//                     TheParameterObj.WriteTo(TheParameterString);

//                     JobQueueEntry."Parameter String" := TheParameterString;
//                     JobQueueEntry."Record ID to Process" := Rec.RecordId;

//                     if JobQueueEntry.Insert(true) then begin
//                         JobQueueEntry.ScheduleTask();
//                         JobQueueEntry.Reset();
//                     end;

//                     // if ((Counter mod 5) = 0) and (Counter <> 0) then begin
//                     Sleep(1000); // 5s
//                     // end;

//                     StartFrom += RecordsPerBatch;
//                 end;

//                 DialogProgress.Close();
//             end;
//         end else begin
//             Error('Sky background manager settings have not been set!');
//         end;
//     end;
// }

// codeunit 52186531 "Salary Job"
// {
//     TableNo = "Job Queue Entry";
//     trigger OnRun()
//     var
//         SalHeaD: Record "Salary Header P";
//         SalLines: Record "Salary Lines P";
//         SavingsLedgerEntry: Record "Savings Ledger Entry";
//         MemberNo: Code[20];
//         Salaccno: Code[20];
//         GenJournalLine: Record "Gen. Journal Line";
//         Temp: Record "Banking User Template";
//         Jtemplate: Code[20];
//         JBatch: Code[20];
//         DActivity2: Code[20];
//         DBranch2: Code[20];
//         DocNo: Code[20];
//         WasBlocked: Boolean;
//         Account: Record "Savings Accounts";
//         SaccoTrans: Codeunit "Sacco Transactions";
//         SalaryTrans: Codeunit "Salary Parallel Processing";
//         RunBal: Decimal;
//         LineNo: Integer;
//         PostingRemarks: Text[500];
//         TCharges: Decimal;
//         TransactionCharges: Record "Transaction Charges";
//         ChargeAmount: Decimal;
//         TariffDetails: record "Tiered Charges Lines";
//         Gensetup: Record "General Set-Up";
//         Memb: Record Members;
//         Text0008: Text;
//         msg: Text;
//         Text0005: label 'Your Salary of KES ';
//         Text0006: label ' has been credited to your FOSA  account ';
//         Text0007: label ' on ';
//         SendSMS: Codeunit SendSms;
//         Source: Enum "SMS Source";
//         GFunc: Codeunit "Global Functions";

//         Counter: Integer;
//         Skip: Integer;
//         TheParameterObj: JsonObject;
//         PDate: date;
//         MobileNo: Text;

//         theStart: JsonToken;
//         theEnd: JsonToken;
//         RecordsPause: JsonToken;
//         SalaryHeaderNo: JsonToken;
//         i: Integer;
//     begin
//         TheParameterObj.ReadFrom(Rec."Parameter String");
//         TheParameterObj.SelectToken('$.start', theStart);
//         TheParameterObj.SelectToken('$.end', theEnd);
//         TheParameterObj.SelectToken('$.records_pause', RecordsPause);
//         TheParameterObj.SelectToken('$.salary_header_no', SalaryHeaderNo);

//         if SalHeaD.Get(SalaryHeaderNo.AsValue.AsText) then begin
//             PDate := SalHeaD."Posting date";
//             PostingRemarks := SalHeaD.Remarks;
//             Temp.Get(UserId);
//             Jtemplate := Temp."Salary Journal Template";
//             JBatch := Temp."Salary Journal Batch";
//             Gensetup.Get;

//             //Check Posted
//             SalLines.Reset;
//             SalLines.SetRange(SalLines."Salary Header No.", SalHeaD.No);
//             SalLines.SetRange(Posted, false);

//             if SalLines.FindSet then begin
//                 SalLines.Next((theStart.AsValue.AsInteger) - 1);

//                 for i := theStart.AsValue.AsInteger to theEnd.AsValue.AsInteger do begin

//                     SavingsLedgerEntry.SetCurrentKey("Document No.", "Posting Date", "Customer No."); // Use indexed fields if possible
//                     // SavingsLedgerEntry.SetRange("Document No.", SalHeaD.No);
//                     SavingsLedgerEntry.SetRange("Document No.", SalLines."Document No.");
//                     SavingsLedgerEntry.SetRange("Posting Date", PDate);
//                     SavingsLedgerEntry.SetRange("Customer No.", SalLines."Account No.");
//                     if SavingsLedgerEntry.Find('-') then begin
//                         SalLines.Posted := true;
//                         SalLines.Modify;
//                     end;


//                     // if (((i mod RecordsPause.AsValue.AsInteger) = 0) and (i <> 0)) then begin
//                     //     Sleep(2000); // 2s
//                     // end;

//                     SalLines.Next();
//                 end;
//             end;

//             // Process
//             SalLines.Reset;
//             SalLines.SetRange(SalLines."Salary Header No.", SalHeaD.No);
//             SalLines.SetRange(Posted, false);
//             SalLines.setcurrentkey(SalLines.Blocked);

//             if SalLines.FindSet then begin
//                 SalLines.Next((theStart.AsValue.AsInteger) - 1);

//                 for i := theStart.AsValue.AsInteger to theEnd.AsValue.AsInteger do begin
//                     // Processing here...
//                     MemberNo := '';
//                     Salaccno := '';

//                     MemberNo := SalLines."Member No.";
//                     Salaccno := SalLines."Account No.";

//                     if SalLines."Document No." <> '' then begin
//                         SalLines."Document No." := CopyStr(GFunc.CleanGuid(), 1, 19);
//                         SalLines.Modify;
//                     end;

//                     DocNo := SalLines."Document No.";

//                     GenJournalLine.Reset;
//                     GenJournalLine.SetRange("Journal Template Name", Jtemplate);
//                     GenJournalLine.SetRange("Journal Batch Name", JBatch);
//                     GenJournalLine.SetRange("Document No.", DocNo);
//                     GenJournalLine.DeleteAll;
//                     //BlockUblock
//                     WasBlocked := false;
//                     if Account.Get(SalLines."Account No.") then begin
//                         if Account.Blocked <> Account.Blocked::" " then begin
//                             SaccoTrans.BlockUblock(Account."No.", true);
//                             wasBlocked := true;
//                         end;

//                         DActivity2 := Account."Global Dimension 1 Code";
//                         DBranch2 := Account."Global Dimension 2 Code";

//                         //Check Account Bal
//                         // AvailableBal := 0;
//                         //Account.CalcFields(Account.Balance, Account."Authorised Over Draft", Account."Uncleared Cheques");

//                         // AvailableBal := ((Account.Balance + Account."Authorised Over Draft") - (Account."ATM Transactions" + Account."Uncleared Cheques"));
//                         //if ProductF.Get(Account."Product Type") then
//                         //    AvailableBal := AvailableBal - ProductF."Minimum Balance";

//                         //RunBal := AvailableBal + SalLines.Amount;
//                         RunBal := SalLines.Amount;

//                         // LineNo := LineNo + 10000;
//                         LineNo := i + 10000;
//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name" := Jtemplate;
//                         GenJournalLine."Journal Batch Name" := JBatch;
//                         GenJournalLine."Line No." := LineNo;
//                         GenJournalLine."Document No." := DocNo;
//                         //GenJournalLine."External Document No.":=SalLines."Branch Reff.";
//                         GenJournalLine."Posting Date" := PDate;
//                         GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
//                         GenJournalLine."Account No." := SalLines."Account No.";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine.Description := PostingRemarks;
//                         GenJournalLine.Amount := -SalLines.Amount;
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
//                         GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                         if GenJournalLine.Amount <> 0 then
//                             if not GenJournalLine.Insert then begin
//                                 // i -= 1;
//                                 // break;
//                                 RetryGenJournalLineInsert(GenJournalLine);
//                             end;

//                         LineNo := LineNo + 10000;
//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name" := Jtemplate;
//                         GenJournalLine."Journal Batch Name" := JBatch;//USERID;
//                         GenJournalLine."Line No." := LineNo;
//                         GenJournalLine."Document No." := DocNo;
//                         //GenJournalLine."External Document No.":=SalLines."Branch Reff.";
//                         GenJournalLine."Posting Date" := PDate;
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine.Description := PostingRemarks;//'Salary';
//                         GenJournalLine."Account Type" := SalHeaD."Account Type";
//                         // if SalProcessingHeader.Get(SalLines."Salary Header No.") then begin
//                         GenJournalLine."Account No." := SalHeaD."Account No";
//                         // end;
//                         GenJournalLine.Amount := SalLines.Amount;
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
//                         GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                         if GenJournalLine.Amount <> 0 then
//                             if not GenJournalLine.Insert then begin
//                                 // i -= 1;
//                                 // break;
//                                 RetryGenJournalLineInsert(GenJournalLine);
//                             end;

//                         //Charges
//                         TCharges := 0;
//                         TransactionCharges.Reset;
//                         TransactionCharges.SetRange(TransactionCharges."Transaction Type", SalHeaD."Transaction Type");
//                         if TransactionCharges.FindSet() then begin
//                             repeat
//                                 LineNo := LineNo + 10000;
//                                 ChargeAmount := 0;
//                                 if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
//                                     ChargeAmount := (SalHeaD.Amount * TransactionCharges."Percentage of Amount") * 0.01
//                                 else
//                                     ChargeAmount := TransactionCharges."Charge Amount";
//                                 if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
//                                     TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
//                                     TariffDetails.Reset;
//                                     TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
//                                     if TariffDetails.FindSet() then begin
//                                         repeat
//                                             if (SalHeaD.Amount >= TariffDetails."Lower Limit") and (SalHeaD.Amount <= TariffDetails."Upper Limit") then begin
//                                                 if TariffDetails."Use Percentage" = true then begin
//                                                     ChargeAmount := SalHeaD.Amount * TariffDetails.Percentage * 0.01;
//                                                 end else begin
//                                                     ChargeAmount := TariffDetails."Charge Amount";
//                                                 end;
//                                             end;
//                                         until TariffDetails.Next = 0;
//                                     end;
//                                 end;

//                                 GenJournalLine.Init;
//                                 GenJournalLine."Journal Template Name" := Jtemplate;
//                                 GenJournalLine."Journal Batch Name" := JBatch;
//                                 GenJournalLine."Document No." := DocNo;
//                                 GenJournalLine."Line No." := LineNo;
//                                 GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
//                                 GenJournalLine."Account No." := SalLines."Account No.";
//                                 //GenJournalLine."External Document No.":="ID No";
//                                 GenJournalLine.Validate(GenJournalLine."Account No.");
//                                 GenJournalLine."Posting Date" := PDate;
//                                 GenJournalLine.Description := TransactionCharges.Description;
//                                 GenJournalLine.Validate(GenJournalLine."Currency Code");
//                                 GenJournalLine.Amount := ChargeAmount;
//                                 GenJournalLine.Validate(GenJournalLine.Amount);
//                                 GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                                 GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
//                                 GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                                 GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
//                                 GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
//                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                                 if GenJournalLine.Amount <> 0 then
//                                     if not GenJournalLine.Insert then begin
//                                         // i -= 1;
//                                         // break;
//                                         RetryGenJournalLineInsert(GenJournalLine);
//                                     end;
//                                 RunBal := RunBal - GenJournalLine.Amount;

//                                 //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

//                                 if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
//                                 (TransactionCharges."Recover Excise Duty" = true) then begin
//                                     //Excise Duty
//                                     LineNo := LineNo + 10000;
//                                     GenJournalLine.Init;
//                                     GenJournalLine."Journal Template Name" := Jtemplate;
//                                     GenJournalLine."Journal Batch Name" := JBatch;
//                                     GenJournalLine."Document No." := DocNo;
//                                     GenJournalLine."Line No." := LineNo;
//                                     GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
//                                     GenJournalLine."Account No." := SalLines."Account No.";
//                                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                                     GenJournalLine."Posting Date" := PDate;
//                                     GenJournalLine.Description := 'Excise Duty';
//                                     GenJournalLine.Validate(GenJournalLine."Currency Code");
//                                     GenJournalLine.Amount := (ChargeAmount * Gensetup."Excise Duty (%)") * 0.01;
//                                     GenJournalLine.Validate(GenJournalLine.Amount);
//                                     GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                                     GenJournalLine."Bal. Account No." := Gensetup."Excise Duty G/L";
//                                     GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
//                                     GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
//                                     GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
//                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
//                                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                                     if GenJournalLine.Amount <> 0 then
//                                         if not GenJournalLine.Insert then begin
//                                             // i -= 1;
//                                             // break;
//                                             RetryGenJournalLineInsert(GenJournalLine);
//                                         end;
//                                     RunBal := RunBal - GenJournalLine.Amount;

//                                     TCharges := TCharges + ChargeAmount;
//                                 end;
//                             until TransactionCharges.Next = 0;
//                         end;

//                         //--Activate Dormant.
//                         SalaryTrans.ActivateDormantP(SalHeaD, DocNo, PDate, DActivity2, DBranch2, Jtemplate, JBatch, RunBal, MemberNo, LineNo, Salaccno);

//                         // if SalHeaD."Donnot Recover" = false then
//                         SalaryTrans.PostSalaryLoansP(SalHeaD, DocNo, PDate, DActivity2, DBranch2, Jtemplate, JBatch, RunBal, MemberNo, LineNo, Salaccno);

//                         if Account.Get(SalLines."Account No.") then begin
//                             if Account."Loan Disbursement Account" = false then begin
//                                 Account."Loan Disbursement Account" := true;
//                                 Account.Modify;
//                             end;
//                         end;

//                     end;

//                     GenJournalLine.Reset;
//                     GenJournalLine.SetRange("Journal Template Name", Jtemplate);
//                     GenJournalLine.SetRange("Journal Batch Name", JBatch);
//                     GenJournalLine.SetRange("Document No.", SalLines."Document No.");
//                     if GenJournalLine.Find('-') then begin
//                         Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
//                     end;
//                     //BlockUblock
//                     if wasBlocked = true then
//                         SaccoTrans.BlockUblock(Account."No.", false);

//                     SalLines.Posted := true;
//                     SalLines."Posted By" := UserId;
//                     SalLines."Posting Date" := Today;
//                     SalLines."Posting Time" := Time;
//                     SalLines."Income Type" := SalHeaD."Income Type";
//                     SalLines.Modify;
//                     // Commit;//*
//                     Gensetup.Get();
//                     if Gensetup."Disable Salary SMS" = false then begin
//                         if Account.Get(SalLines."Account No.") then begin
//                             MobileNo := Account."Mobile Phone No";
//                             if MobileNo = '' then begin
//                                 if Memb.get(Account."Member No.") then
//                                     MobileNo := Memb."Phone No.";
//                             end;
//                             Text0008 := Gensetup."Salary SMS Suffix";
//                             msg := Text0005 + Format(SalLines.Amount) + Text0006 + Text0007 + SaccoTrans.ddMMyyyy(Today) + ' ' + Format(Time) + ' ' + Text0008;

//                             SendSMS.SendSms(Source::SALARY_PROCESSING, MobileNo, msg, Format(SalLines."Account No."), '', true, 0, false, 'CBS', SalLines."Account No.", 'CBS');

//                         end;
//                     end;


//                     if (((i mod RecordsPause.AsValue.AsInteger) = 0) and (i <> 0)) then begin
//                         Sleep(2000); // 2s
//                     end;

//                     SalLines.Next();
//                 end;
//             end;

//             // Commit all batch write transactions here...
//             Commit;

//             SalHeaD.CalcFields("Total Count", "Total Posted Count");

//             if SalHeaD."Total Count" > 0 then begin
//                 if SalHeaD."Total Count" = SalHeaD."Total Posted Count" then begin
//                     SalHeaD.Posted := true;
//                     SalHeaD.Modify;
//                 end;
//             end;
//         end;
//     end;

//     local procedure RetryGenJournalLineInsert(var GenJournalLine: Record "Gen. Journal Line")
//     begin
//         Sleep(2500); // 2.5s
//         if not GenJournalLine.Insert then begin
//             RetryGenJournalLineInsert(GenJournalLine);
//         end;
//     end;
// }