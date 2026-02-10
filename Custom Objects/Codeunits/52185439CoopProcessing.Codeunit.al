// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Codeunit 52185439 "Coop Processing"
// {

//     trigger OnRun()
//     var
//         Vendor: Record "Savings Accounts";
//         TNo: Code[50];
//         GLAccount: Record "G/L Account";
//     begin

//         //  Vendor.GET('5050123278000');
//         //  Vendor."ATM No." := '4299331606489806';
//         //  Vendor.MODIFY;

//         //IF GLAccount.GET('105019') THEN GLAccount.Blocked := FALSE; GLAccount.MODIFY;
//         //4299348600580976
//         //ReverseTransaction('RVS000001','TR0000003','BALANCE_ENQ',
//         //MESSAGE('%1',
//         ////BalanceEnquiry('TR00r004','BAL_ENQ',CURRENTDATETIME,'TM001','APP','11111','1000002','SIT','YETU SACCO LTD',10,'KES',30,'KES','Balance Enquiry'));

//         //MESSAGE(BalanceEnquiry('ServiceName','TRN0002',CURRENTDATETIME,'TM001','POS456789012345',ConnectionMode,'B_A/C_001','4299331917076136','001','Harambee',10,'404',20,'404','','',''));


//         //MESSAGE(BalanceEnquiryNew('ServiceName','TR0011',CURRENTDATETIME,'TM001','ATM',ConnectionMode,'B_A/C_001','4299346900536128','001','Harambee',10,'404',20,'404','',''));


//         //MESSAGE(MiniStatement('MINISTATEMENT','TRN0029',10,'TM001','ATM',CURRENTDATETIME,'100114573200','0717663099','100114573200',12,'404',22,'404','Mini Statement','001','','',''));

//         //MESSAGE(FundsTransfer('ServiceName','TR00051',CURRENTDATETIME,'','OMNISACCO',ConnectionMode,'0001','','001','Harambee',500,'404','100100040800','B_A/C_001',0,'404',0,'404','Cash Withdrawal','','','',''));

//         //Reversal
//         //MESSAGE(FundsTransfer('FT','106906004119_CS_POSTFUNDS2',CURRENTDATETIME,'POS03170','0002P001',
//         //ConnectionMode,'1420','106906004119_CS_POSTFUNDS','001','Harambee',1800,'KES','4299337600286155','B_A/C_001',15,'404',25,'404','Cash Withdrawal','','',''));

//         //PostATM('TEST202202246_CS_POSTFUNDS');

//         //MESSAGE('Done');


//         //MESSAGE('%1',GetAccountBalance('0502-001-09366',TODAY));

//         //MESSAGE(MiniStatement('MINISTATEMENT','TRN0029',10,'POS','',CURRENTDATETIME,'100114573200','0717663099','100114573200',12,'404',22,'404','Mini Statement','001','','',''));

//         //MESSAGE('Done');
//         //
//     end;

//     var
//         ExciseDutyGL: Code[20];
//         ExciseDutyRate: Decimal;
//         ExciseDuty: Decimal;
//         CoopSetup: Record "Coop ATM  Setup";
//         ChargeAmount: Decimal;
//         TransAmount: Decimal;
//         JTemplate: Code[30];
//         JBatch: Code[30];
//         GenLedgerSetup: Record "General Ledger Setup";
//         GenSetup: Record "General Set-Up";
//         BUser: Record "User Setup";
//         SaccoTrans: Codeunit "Sacco Transactions";
//         CoopTrans: Record "Coop ATM Transaction";
//         DocNo: Code[20];
//         PDate: Date;
//         AcctType: Enum "Gen. Journal Account Type";
//         BalAccType: Enum "Gen. Journal Account Type";
//         TransType: Enum "Transaction Types";
//         AccNo: Code[20];
//         BalAccNo: Code[20];
//         SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued";
//         ExtDoc: Code[20];
//         LoanNo: Code[20];
//         Dim1: Code[30];
//         Dim2: Code[30];
//         SystCreated: Boolean;
//         SLedger: Record "Savings Ledger Entry";
//         Sep: label '\::/';
//         Null: label 'NULL';
//         Success: label '200';
//         Account_Does_Not_Exist: label '300';
//         Parameters_Not_Valid_Or_Missing: label '400';
//         Caller_Not_Authorized_For_This_Request: label '401';
//         Insufficient_Funds: label '402';
//         Daily_Amount_Limit_Reached: label '403';
//         Operation_Does_Not_Exist: label '404';
//         Daily_Frequency_Limit_Reached: label '405';
//         Severe_problem_Has_Occured: label '500';
//         CoopCode: Record "Coop Transaction Codes";
//         Continue: Boolean;
//         LedgerCount: Integer;
//         CurrRecord: Integer;
//         EndRec: label '\::::/';
//         SavAcc: Record "Savings Accounts";
//         GenJournalBatch: Record "Gen. Journal Batch";
//         ConnectionMode: Text;
//         xmlLTextWriter: code[100];//dotnet JsonTextWriter;
//         xmlWriter: code[100];//dotnet XmlTextWriter;
//         EncodingText: code[100];//dotnet Encoding;
//         StringBuilder: code[100];//dotnet StringBuilder;
//         StringWriter: code[100];//dotnet StringWriter;
//         ATM_No: Text;
//         BankCharge: Decimal;
//         SaccoFee: Decimal;
//         TerminalCode: Code[20];
//         CRate: Decimal;
//         PeriodicActivities: Codeunit "Periodic Activities";
//         // MobileBanking: Codeunit MobileBanking;
//         SendSms: Codeunit SendSms;
//         ChannelCode: Text;
//         DefDesc: Text;
//         DiffrenceInDays: Integer;


//     procedure BalanceEnquiry(serviceName: Text; RequestReference: Text; TransactionDate: DateTime; TerminalID: Text; Channel: Text; ConnectionMode: Text; CreditAccount: Text; DebitAccount: Text; InstitutionCode: Text; InstitutionName: Text[100]; ChargeAmount: Decimal; ChargeCurrency: Text; FeeAmount: Decimal; FeeCurrency: Text; deviceType: Text; location: Text; conversionRate: Text) Response: Text
//     var
//         i: Decimal;
//         MemberNo: Text[30];
//         AccBalance: Decimal;
//         thisSavAccNo: Text[30];
//         foundChargeAccount: Boolean;
//         A: Integer;
//         MNo: Code[20];
//         AcctNo: Code[20];
//         TotalCharge: Decimal;
//         AccBal: Decimal;
//         RespTransactionID: Text;
//         RespStatusCode: Text;
//         RespStatusDescription: Text;
//         RespTransactionDate: DateTime;
//         RespTransactionReference: Text;
//         RespInstitutionCode: Text;
//         RespDebitAccount: Text;
//         RespAccountBookBalance: Decimal;
//         RespAccountClearedBalance: Decimal;
//         RespAccountCurrency: Text;
//         xmlLTextWriter: code[100];//dotnet JsonTextWriter;
//         xmlWriter: code[100];//dotnet XmlTextWriter;
//         EncodingText: code[100];//dotnet Encoding;
//         StringBuilder: code[100];//dotnet StringBuilder;
//         StringWriter: code[100];//dotnet StringWriter;
//         TransactionType: Code[20];
//         PDesc: Text;
//     begin




//         ChannelCode := Channel;
//         TerminalCode := TerminalID;


//         if Channel <> '' then
//             ChannelCode := CopyStr(Channel, 4, 2);

//         if TerminalID <> '' then
//             TerminalCode := CopyStr(TerminalID, 1, 3);

//         if TerminalCode = 'ATM' then
//             ChannelCode := '';
//         if TerminalCode = 'POS' then
//             ChannelCode := '';


//         TransactionType := '0016';
//         if not CoopCode.Get(TransactionType, TerminalCode, ChannelCode) then begin
//             TerminalCode := '';
//             ChannelCode := '';
//         end;
//         PDesc := '';
//         PDesc := CoopCode."Posting Description";





//         // Get Excise duty G/L
//         ExciseDutyGL := GetExciseDutyGL();
//         ExciseDutyRate := GetExciseRate();
//         ExciseDuty := 0;

//         /*
//         TotalCharge:=ChargeAmount+FeeAmount;
//         ExciseDuty:=ROUND(FeeAmount*ExciseDutyRate/100);
//         */


//         BankCharge := 0;
//         SaccoFee := 0;
//         GetATMcharges(TransactionType, TerminalCode, ChannelCode, 0, BankCharge, SaccoFee);
//         TotalCharge := BankCharge + SaccoFee;
//         ExciseDuty := ROUND(SaccoFee * ExciseDutyRate / 100);


//         //ERROR('TotalCharge %1',TotalCharge);


//         CoopSetup.Get;


//         RespTransactionID := RequestReference;
//         RespTransactionDate := TransactionDate;
//         RespTransactionReference := Null;
//         //CoopSetup.TESTFIELD("Institution Code");
//         RespInstitutionCode := InstitutionCode;
//         RespDebitAccount := DebitAccount;
//         RespAccountBookBalance := 0;
//         RespAccountClearedBalance := 0;
//         RespAccountCurrency := 'KES';

//         ATM_No := '';
//         DebitAccount := GetAccountNoFromATMNo(DebitAccount);

//         if (SavAcc.Get(DebitAccount)) and (DebitAccount <> '') then begin

//             AccBal := SavAcc.GetAvailableBalance(SavAcc."No.");
//             if AccBal >= TotalCharge + ExciseDuty then begin

//                 BUser.Get(UserId);

//                 JTemplate := 'GENERAL';
//                 JBatch := 'COOPBRIDGE';

//                 GenJournalBatch.Reset;
//                 GenJournalBatch.SetRange("Journal Template Name", JTemplate);
//                 GenJournalBatch.SetRange(Name, JBatch);
//                 if not GenJournalBatch.FindFirst then begin
//                     GenJournalBatch.Init;
//                     GenJournalBatch."Journal Template Name" := JTemplate;
//                     GenJournalBatch.Name := JBatch;
//                     GenJournalBatch.Description := 'CoopBridge Batch';
//                     GenJournalBatch.Insert;
//                 end;

//                 CoopTrans.Init;
//                 CoopTrans."Transaction ID" := RequestReference;
//                 CoopTrans."Document No." := SetDocumentNo(RequestReference);
//                 CoopTrans."Service Name" := serviceName;
//                 CoopTrans."Transaction Date" := Dt2Date(TransactionDate);
//                 CoopTrans."Transaction Time" := Dt2Time(TransactionDate);
//                 CoopTrans."Terminal ID" := TerminalID;
//                 CoopTrans.Channel := Channel;
//                 CoopTrans."Sacco Account" := CreditAccount;
//                 CoopTrans."Member Account" := DebitAccount;
//                 CoopTrans."ATM No." := ATM_No;
//                 CoopTrans."Institution Code" := InstitutionCode;
//                 CoopTrans."Institution Name" := InstitutionName;
//                 CoopTrans.Commission := ChargeAmount;
//                 CoopTrans."Commission Currency" := ChargeCurrency;
//                 CoopTrans."Fee Charged" := FeeAmount;
//                 CoopTrans."Fee Currency" := FeeCurrency;
//                 CoopTrans."Description 1" := 'Coop Balance Enquiry';
//                 CoopTrans."Description 2" := CoopTrans."Description 1";
//                 CoopTrans."Posting Description" := PDesc;

//                 CoopTrans.Activity := CoopTrans.Activity::"Balance Enquiry";
//                 CoopTrans."Transaction Type" := TransactionType;
//                 CoopTrans."Terminal Code" := TerminalCode;
//                 CoopTrans."Channel Code" := ChannelCode;
//                 CoopTrans."Total Charges" := TotalCharge;
//                 CoopTrans."Sacco Fee" := SaccoFee;
//                 CoopTrans."Coop Fee" := BankCharge;
//                 CoopTrans."Sacco Excise Duty" := ExciseDuty;
//                 CoopTrans."Total Account Debit" := CoopTrans.Amount + CoopTrans."Total Charges" + CoopTrans."Sacco Excise Duty";
//                 CoopTrans.Insert;

//                 RespTransactionReference := CoopTrans."Document No.";
//                 SavAcc.CalcFields("Balance (LCY)");
//                 RespAccountBookBalance := SavAcc."Balance (LCY)" - CoopTrans."Total Account Debit";
//                 RespAccountClearedBalance := SavAcc.GetAvailableBalance(SavAcc."No.") - CoopTrans."Total Account Debit";
//                 RespStatusCode := Success;
//                 RespStatusDescription := 'Success';



//                 CoopTrans.Reset;
//                 CoopTrans.SetRange("Transaction ID", RequestReference);
//                 //CoopTrans.SETRANGE(Posted,FALSE);
//                 if CoopTrans.FindFirst then begin
//                     /*
//                     DocNo := CoopTrans."Document No.";
//                     PDate := CoopTrans."Transaction Date";
//                     AcctNo := CoopTrans."Member Account";
//                     ExtDoc := '';
//                     LoanNo := '';
//                     TransType := TransType::" ";
//                     Dim1 := SavAcc."Global Dimension 1 Code";
//                     Dim2 := SavAcc."Global Dimension 2 Code";
//                     SystCreated := TRUE;
        
        
//                     SaccoTrans.InitJournal(JTemplate,JBatch);
        
//                     SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Savings,AcctNo,COPYSTR(CoopTrans."Description 1",1,50),BalAccType::"G/L Account",
//                                   '',TotalCharge,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);
//                     SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Savings,AcctNo,COPYSTR('Excise Duty - '+CoopTrans."Description 1",1,50),BalAccType::"G/L Account",
//                                   ExciseDutyGL,ExciseDuty,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);
        
        
//                     AcctNo := CoopSetup."Coop Commission Account";
//                     ExtDoc := CoopTrans."Member Account";
//                     LoanNo := '';
//                     TransType := TransType::" ";
//                     SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::"Bank Account",CoopSetup."Coop Commission Account",COPYSTR('Balance Enquiry Commission',1,50),BalAccType::"G/L Account",
//                                   '',-BankCharge,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);
        
//                     AcctNo := CoopSetup."Coop Fee Account";
//                     ExtDoc := CoopTrans."Member Account";
//                     LoanNo := '';
//                     TransType := TransType::" ";
        
//                     SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::"G/L Account",AcctNo,COPYSTR('Balance Enquiry Fee',1,50),BalAccType::"G/L Account",
//                                   '',-SaccoFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);
        
        
//                     CoopTrans.Posted:=TRUE;
//                     CoopTrans."Posted By":=USERID;
//                     CoopTrans."Date Posted":=TODAY;
//                     CoopTrans.MODIFY;
//                     RespTransactionReference := CoopTrans."Document No.";
        
//                     SaccoTrans.PostJournal(JTemplate,JBatch);
        
        
//                     {
//                     SLedger.RESET;
//                     SLedger.SETRANGE("Document No.",CoopTrans."Document No.");
//                     SLedger.SETRANGE("Posting Date",CoopTrans."Transaction Date");
//                     SLedger.SETRANGE("Vendor No.",CoopTrans."Member Account");
//                     IF SLedger.FINDFIRST THEN BEGIN
//                         RespTransactionReference := FORMAT(SLedger."Transaction No.");
        
//                     END;
//                     }
        
//                     SavAcc.CALCFIELDS("Balance (LCY)");
//                     RespAccountBookBalance := SavAcc."Balance (LCY)";
        
//                     RespAccountClearedBalance := GetAccountBalance(SavAcc."No.",TODAY);
        
        
//                     RespStatusCode:=Success;
//                     RespStatusDescription:='Success';
//                     */

//                 end;
//             end
//             else begin
//                 RespStatusCode := Insufficient_Funds;
//                 RespStatusDescription := 'Insufficient Funds';
//                 //ERROR('Insufficient Funds');
//             end;
//         end
//         else begin
//             RespStatusCode := Account_Does_Not_Exist;
//             RespStatusDescription := 'Account Does Not Exist';
//             //ERROR('Account Does Not Exist');
//         end;


//         //PostATM(RespTransactionID);
//         Response := '<BalanceEnquiryResponse>' +
//                         '<Response>' +

//                             '<HeaderReply>' +
//                                 '<RequestReference>' + RespTransactionID + '</RequestReference>' +
//                                 '<StatusCode>' + RespStatusCode + '</StatusCode>' +
//                                 '<StatusDescription>' + RespStatusDescription + '</StatusDescription>' +
//                             '</HeaderReply>' +

//                             '<OperationParameters>' +
//                                 '<TransactionDate>' + FormatDate(0D, RespTransactionDate) + '</TransactionDate>' +
//                                 '<TransactionReference>' + RespTransactionReference + '</TransactionReference>' +
//                             '</OperationParameters>' +

//                             '<Institution>' +
//                                 '<InstitutionCode>' + RespInstitutionCode + '</InstitutionCode>' +
//                                 '<InstitutionName>' + InstitutionName + '</InstitutionName>' +
//                             '</Institution>' +

//                             '<Account>' +
//                                 '<DebitAccount>' + RespDebitAccount + '</DebitAccount>' +
//                                 '<BookBalance>' + FormatDecimal(RespAccountBookBalance) + '</BookBalance>' +
//                                 '<ClearedBalance>' + FormatDecimal(RespAccountClearedBalance) + '</ClearedBalance>' +
//                                 '<Currency>' + RespAccountCurrency + '</Currency>' +
//                             '</Account>' +

//                             '<AdditionalInfos>' +
//                                 '<AdditionalInfo>' +
//                                     '<key>' + 'CLEAREDBALANCE' + '</key>' +
//                                     '<value>' + FormatDecimal(RespAccountBookBalance) + '</value>' +
//                                 '</AdditionalInfo>' +
//                                 '<AdditionalInfo>' +
//                                     '<key>' + 'ACCOUNTBOOKEDBALANCE' + '</key>' +
//                                     '<value>' + FormatDecimal(RespAccountClearedBalance) + '</value>' +
//                                 '</AdditionalInfo>' +
//                             '</AdditionalInfos>' +
//                         '</Response>' +
//                     '</BalanceEnquiryResponse>';

//     end;


//     procedure GetExciseRate() rate: Integer
//     begin


//         GenSetup.Get;
//         GenSetup.TestField(GenSetup."Excise Duty (%)");
//         rate := GenSetup."Excise Duty (%)";
//     end;


//     procedure GetExciseDutyGL() account: Text[20]
//     begin

//         GenSetup.Reset;
//         GenSetup.Get;
//         GenSetup.TestField(GenSetup."Excise Duty G/L");
//         account := GenSetup."Excise Duty G/L";
//     end;


//     procedure ReverseTransaction(ReversalID: Code[50]; TransactionID: Code[50]; ServiceName: Code[50]; Channel: Code[50]; AccountNo: Code[50]; Amount: Decimal) Reversed: Boolean
//     var
//         Text0001: label 'Ensure the Salary  Journal Template is set up in Banking User Setup';
//         Text0002: label 'Ensure the Salary Journal Batch is set up in Banking User Setup';
//         Text0003: label 'Ensure the Default Bank is set up in User Setup';
//         Text0004: label 'The transaction has already been posted.';
//         Text0005: label 'Your Income of ';
//         Text0006: label ' has been credited to your account at ';
//         Text0007: label ' on ';
//         ReversalEntry: Record "Reversal Entry";
//         GLRegister: Record "G/L Register";
//         CoopTrans: Record "Coop ATM Transaction";
//     begin
//         Reversed := false;

//         //ERROR('TransactionID %1\Channel %2\AccountNo %3\AccountNo %4',TransactionID,Channel,AccountNo,AccountNo);
//         CoopTrans.Reset;
//         CoopTrans.SetRange("Transaction ID", TransactionID);
//         CoopTrans.SetFilter(CoopTrans.Activity, '<>%1', CoopTrans.Activity::Reversal);
//         CoopTrans.SetRange(Channel, Channel);
//         CoopTrans.SetRange("Member Account", AccountNo);
//         CoopTrans.SetRange(Amount, Amount);
//         CoopTrans.SetRange(Posted, true);
//         CoopTrans.SetRange(Reversed, false);
//         if CoopTrans.FindFirst then begin
//             //ERROR('t');
//             SLedger.Reset;
//             SLedger.SetRange("Customer No.", CoopTrans."Member Account");
//             //IF CoopTrans.Activity = CoopTrans.Activity::"Balance Enquiry" THEN
//             //SLedger.SETRANGE(Amount,CoopTrans.Commission+CoopTrans."Fee Charged");
//             SLedger.SetRange("Document No.", CoopTrans."Document No.");
//             SLedger.SetRange("Posting Date", CoopTrans."Transaction Date");
//             SLedger.SetRange(Reversed, false);
//             if SLedger.FindFirst then begin

//                 GLRegister.Reset;
//                 GLRegister.SetFilter("From Entry No.", '<=%1', SLedger."Entry No.");
//                 GLRegister.SetFilter("To Entry No.", '>=%1', SLedger."Entry No.");
//                 if GLRegister.FindFirst then begin
//                     //MESSAGE('t');
//                     //Stage 1
//                     Clear(ReversalEntry);
//                     SLedger.TestField("Transaction No.");

//                     //Stage 2
//                     ReversalEntry.DeleteAll;

//                     //ReversalEntry.AutoReverseRegister(GLRegister."No.");

//                     ReversalEntry.AutoReverseRegister(GLRegister."No.");
//                 end;
//             end;


//             SLedger.Reset;
//             SLedger.SetRange("Customer No.", CoopTrans."Member Account");
//             if CoopTrans.Activity = CoopTrans.Activity::"Balance Enquiry" then
//                 SLedger.SetRange(Amount, CoopTrans.Commission + CoopTrans."Fee Charged");
//             SLedger.SetRange("Document No.", CoopTrans."Document No.");
//             SLedger.SetRange("Posting Date", CoopTrans."Transaction Date");
//             SLedger.SetRange(Reversed, true);
//             if SLedger.FindFirst then begin

//                 CoopTrans.Reversed := true;
//                 CoopTrans."Date Reversed" := Today;
//                 CoopTrans."Reversed By" := UserId;
//                 CoopTrans."Reversal ID" := ReversalID;
//                 CoopTrans.Modify;

//                 Reversed := true;
//             end;


//         end;
//     end;


//     procedure FundsTransfer(ServiceName: Text; RequestReference: Text; TransactionDate: DateTime; TerminalID: Text; Channel: Text; ConnectionMode: Text; TransactionType: Text; OriginalMessageID: Text; InstitutionCode: Text; InstitutionName: Text[100]; TransactionAmount: Decimal; Currency: Text; DebitAccount: Text; CreditAccount: Text; ChargeAmount: Decimal; ChargeCurrency: Text; FeeAmount: Decimal; FeeCurrency: Text; Narrative1: Text; Narrative2: Text; deviceType: Text; location: Text; conversionRate: Text) Response: Text[1024]
//     var
//         i: Decimal;
//         MemberNo: Text[30];
//         AccBalance: Decimal;
//         thisSavAccNo: Text[30];
//         foundChargeAccount: Boolean;
//         A: Integer;
//         MNo: Code[20];
//         AcctNo: Code[50];
//         TotalCharge: Decimal;
//         AccBal: Decimal;
//         RespTransactionID: Text;
//         RespStatusCode: Text;
//         RespStatusDescription: Text;
//         RespTransactionDate: DateTime;
//         RespTransactionReference: Text;
//         RespInstitutionCode: Text;
//         RespDebitAccount: Text;
//         RespAccountBookBalance: Decimal;
//         RespAccountClearedBalance: Decimal;
//         RespAccountCurrency: Text;
//         RespTotalAmount: Decimal;
//         RespCreditAccount: Text;
//         Reversal: Boolean;
//         Limit: Decimal;
//         LimitReached: Boolean;
//         DepRev: Boolean;
//         ForeignAmt: Decimal;
//         PDesc: Text;
//         DiffrenceInDays: Decimal;
//     begin



//         ForeignAmt := 0;
//         if Currency <> '404' then begin
//             ForeignAmt := TransactionAmount;
//             TransactionAmount := ChargeAmount;
//         end;
//         if TransactionAmount = 0 then
//             TransactionAmount := ForeignAmt;


//         // Get Excise duty G/L
//         ExciseDutyGL := GetExciseDutyGL();
//         ExciseDutyRate := GetExciseRate();
//         ExciseDuty := 0;



//         ChannelCode := '';
//         TerminalCode := '';


//         if Channel <> '' then
//             ChannelCode := CopyStr(Channel, 4, 2);

//         if TerminalID <> '' then
//             TerminalCode := CopyStr(TerminalID, 1, 3);

//         if TerminalCode = 'ATM' then
//             ChannelCode := '';

//         DefDesc := '';
//         PDesc := '';

//         //MESSAGE(TransactionType+' v '+TerminalCode+' X '+ChannelCode);
//         if CoopCode.Get(TransactionType, TerminalCode, ChannelCode) then begin

//             Limit := CoopCode."Daily Limit";
//             ;
//             DefDesc := CoopCode.Description;
//             PDesc := CoopCode."Posting Description";
//         end
//         else begin
//             TerminalCode := '';
//             ChannelCode := '';

//             if CoopCode.Get(TransactionType, TerminalCode, ChannelCode) then begin

//                 Limit := CoopCode."Daily Limit";
//                 ;
//                 DefDesc := CoopCode.Description;
//                 PDesc := CoopCode."Posting Description";
//             end;
//         end;



//         TotalCharge := ChargeAmount + FeeAmount;
//         ExciseDuty := ROUND(FeeAmount * ExciseDutyRate / 100);
//         //MESSAGE(TerminalCode+' T '+ChannelCode);

//         BankCharge := 0;
//         SaccoFee := 0;
//         GetATMcharges(TransactionType, TerminalCode, ChannelCode, TransactionAmount, BankCharge, SaccoFee);
//         TotalCharge := BankCharge + SaccoFee;
//         ExciseDuty := ROUND(SaccoFee * ExciseDutyRate / 100);



//         CoopSetup.Get;

//         //CoopSetup.TESTFIELD("Institution Code");

//         RespTransactionID := RequestReference;
//         RespTransactionDate := TransactionDate;
//         RespTransactionReference := Null;


//         RespInstitutionCode := InstitutionCode;

//         RespDebitAccount := DebitAccount;
//         RespAccountBookBalance := 0;
//         RespAccountClearedBalance := 0;
//         RespAccountCurrency := 'KES';
//         RespTotalAmount := TransactionAmount;
//         RespCreditAccount := CreditAccount;






//         ATM_No := DebitAccount;
//         DebitAccount := GetAccountNoFromATMNo(DebitAccount);



//         CoopSetup.Get;
//         DiffrenceInDays := (CurrentDatetime - TransactionDate) / (1000 * 60 * 60 * 24);
//         //IF DiffrenceInDays > CoopSetup."Trasaction Valid Days"  THEN BEGIN

//         //  RespStatusCode:=Parameters_Not_Valid_Or_Missing;
//         //  RespStatusDescription:='Transaction days are more than '+FORMAT(CoopSetup."Trasaction Valid Days") +' days';
//         //END ELSE BEGIN

//         CoopTrans.Reset;
//         CoopTrans.SetRange("Transaction ID", RequestReference);
//         CoopTrans.SetRange(CoopTrans."Transaction Type", TransactionType);
//         if CoopTrans.FindFirst then begin

//             RespStatusCode := Severe_problem_Has_Occured;
//             RespStatusDescription := 'Transaction Already Exists';
//         end
//         else begin


//             Continue := true;
//             CRate := 0;
//             if conversionRate <> '' then
//                 if not Evaluate(CRate, conversionRate) then begin
//                     Continue := false;

//                     RespStatusCode := Severe_problem_Has_Occured;
//                     RespStatusDescription := 'Invalid Conversion Rate';
//                 end;


//             if Continue then
//                 if SavAcc.Get(DebitAccount) then begin

//                     AccBal := SavAcc.GetAvailableBalance(SavAcc."No.");


//                     LimitReached := false;
//                     if Limit > 0 then begin
//                         CoopTrans.Reset;
//                         CoopTrans.SetRange("Transaction ID", RequestReference);
//                         CoopTrans.SetRange(CoopTrans."Transaction Type", TransactionType);
//                         CoopTrans.SetRange(CoopTrans."Transaction Date", Dt2Date(TransactionDate));
//                         CoopTrans.SetRange(CoopTrans.Activity, CoopTrans.Activity::"Funds Transfer");
//                         CoopTrans.SetRange(CoopTrans."Terminal Code", TerminalCode);
//                         CoopTrans.SetRange(CoopTrans."Channel Code", ChannelCode);
//                         CoopTrans.SetRange(CoopTrans.Reversed, false);
//                         if CoopTrans.FindFirst then begin
//                             CoopTrans.CalcSums(CoopTrans.Amount);
//                             if (TransactionAmount + CoopTrans.Amount) > Limit then
//                                 LimitReached := true
//                         end;
//                     end;
//                     DepRev := false;

//                     if (TransactionType = '1420') then begin
//                         if OriginalMessageID = '' then
//                             OriginalMessageID := RequestReference;
//                     end;

//                     if (TransactionType = '1420') or (TransactionType = '0010') then
//                         DepRev := true;


//                     if (DepRev) or ((AccBal >= TransactionAmount + TotalCharge + ExciseDuty) and (not LimitReached)) then begin


//                         JTemplate := 'GENERAL';
//                         JBatch := 'COOPBRIDGE';

//                         GenJournalBatch.Reset;
//                         GenJournalBatch.SetRange("Journal Template Name", JTemplate);
//                         GenJournalBatch.SetRange(Name, JBatch);
//                         if not GenJournalBatch.FindFirst then begin
//                             GenJournalBatch.Init;
//                             GenJournalBatch."Journal Template Name" := JTemplate;
//                             GenJournalBatch.Name := JBatch;
//                             GenJournalBatch.Description := 'CoopBridge Batch';
//                             GenJournalBatch.Insert;
//                         end;


//                         if Narrative1 = '' then
//                             Narrative1 := DefDesc;

//                         if Narrative2 = '' then
//                             Narrative2 := DefDesc;

//                         if Narrative1 = '' then
//                             Narrative1 := 'Funds transfer';

//                         if Narrative2 = '' then
//                             Narrative2 := 'Funds transfer';


//                         if PDesc = '' then
//                             PDesc := Narrative1;

//                         CoopTrans.Init;
//                         CoopTrans."Transaction ID" := RequestReference;
//                         CoopTrans."Document No." := SetDocumentNo(RequestReference);
//                         CoopTrans."Service Name" := ServiceName;
//                         CoopTrans."Foreign Amount" := ForeignAmt;
//                         CoopTrans."Transaction Date" := Dt2Date(TransactionDate);
//                         CoopTrans."Transaction Time" := Dt2Time(TransactionDate);
//                         CoopTrans.Channel := Channel;
//                         CoopTrans."Transaction Type" := TransactionType;
//                         CoopTrans."Terminal Code" := TerminalCode;
//                         CoopTrans."Channel Code" := ChannelCode;

//                         //ERROR('TotalCharge %1\TransactionType %2\TerminalCode %3\ChannelCode %4',TotalCharge,TransactionType,TerminalCode,ChannelCode);

//                         RespTransactionReference := CoopTrans."Document No.";

//                         if CoopCode.Get(TransactionType, TerminalCode, ChannelCode) then
//                             CoopTrans."Transaction Name" := CoopCode.Description;

//                         CoopTrans."Original Transaction ID" := OriginalMessageID;

//                         Continue := true;
//                         Reversal := false;
//                         if CoopTrans."Transaction Type" = '1420' then begin
//                             Reversal := true;
//                             if CoopTrans."Original Transaction ID" = '' then begin
//                                 //CoopTrans.TESTFIELD("Original Transaction ID");;

//                                 RespStatusCode := Parameters_Not_Valid_Or_Missing;
//                                 RespStatusDescription := 'Original Message ID missing for this Reversal Request';
//                                 Continue := false;
//                             end;
//                         end;

//                         if TransactionType = '0010' then
//                             TransactionAmount := TransactionAmount * -1;

//                         if Continue then begin
//                             CoopTrans."Member Account" := DebitAccount;
//                             CoopTrans.Amount := TransactionAmount;
//                             CoopTrans."Amount Currency" := Currency;
//                             CoopTrans."Sacco Account" := CreditAccount;
//                             CoopTrans.Commission := ChargeAmount;
//                             CoopTrans."Commission Currency" := ChargeCurrency;
//                             CoopTrans."Fee Charged" := FeeAmount;
//                             CoopTrans."Fee Currency" := FeeCurrency;
//                             CoopTrans."Description 1" := Narrative1;
//                             CoopTrans."Description 2" := Narrative2;
//                             CoopTrans."Posting Description" := PDesc;
//                             CoopTrans."ATM No." := ATM_No;
//                             CoopTrans."Institution Code" := InstitutionCode;
//                             CoopTrans."Institution Name" := InstitutionName;
//                             CoopTrans.Activity := CoopTrans.Activity::"Funds Transfer";
//                             if Reversal then
//                                 CoopTrans.Activity := CoopTrans.Activity::Reversal;
//                             CoopTrans."Total Charges" := TotalCharge;
//                             CoopTrans."Sacco Fee" := SaccoFee;
//                             CoopTrans."Coop Fee" := BankCharge;
//                             CoopTrans."Sacco Excise Duty" := ExciseDuty;
//                             CoopTrans."Total Account Debit" := CoopTrans.Amount + CoopTrans."Total Charges" + CoopTrans."Sacco Excise Duty";
//                             CoopTrans."Device Type" := deviceType;
//                             CoopTrans.Location := location;
//                             CoopTrans."Conversion Rate" := CRate;
//                             SavAcc.CalcFields("Balance (LCY)");
//                             RespAccountBookBalance := SavAcc."Balance (LCY)" - CoopTrans."Total Account Debit";
//                             RespAccountClearedBalance := SavAcc.GetAvailableBalance(SavAcc."No.") - CoopTrans."Total Account Debit";

//                             CoopTrans.Insert;

//                             RespTransactionReference := CoopTrans."Document No.";
//                             RespStatusCode := Success;
//                             RespStatusDescription := 'Success';


//                             CoopTrans.Reset;
//                             CoopTrans.SetRange("Transaction ID", RequestReference);
//                             //CoopTrans.SETRANGE(Posted,FALSE);
//                             if CoopTrans.FindFirst then begin
//                                 /*
//                                 IF Reversal THEN BEGIN
//                                     IF ReverseTransaction(RequestReference,OriginalMessageID,ServiceName,Channel,DebitAccount,TransactionAmount) THEN BEGIN

//                                         CoopTrans.Posted:=TRUE;
//                                         CoopTrans."Posted By":=USERID;
//                                         CoopTrans."Date Posted":=TODAY;


//                                         CoopTrans.Reversed:=TRUE;
//                                         CoopTrans."Date Reversed":=TODAY;
//                                         CoopTrans."Reversed By":=USERID;
//                                         CoopTrans.MODIFY;

//                                         RespStatusCode:=Success;
//                                         RespStatusDescription:='Success';
//                                     END
//                                     ELSE BEGIN
//                                         //ERROR('Reversal Failed');
//                                         RespStatusCode:=Severe_problem_Has_Occured;
//                                         RespStatusDescription:='Reversal Failed';
//                                     END;
//                                 END
//                                 ELSE BEGIN
//                                     DocNo := CoopTrans."Document No.";
//                                     PDate := CoopTrans."Transaction Date";
//                                     AcctNo := CoopTrans."Member Account";
//                                     ExtDoc := '';
//                                     LoanNo := '';
//                                     TransType := TransType::" ";
//                                     Dim1 := SavAcc."Global Dimension 1 Code";
//                                     Dim2 := SavAcc."Global Dimension 2 Code";
//                                     SystCreated := TRUE;

//                                     SaccoTrans.InitJournal(JTemplate,JBatch);

//                                     SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Savings,AcctNo,COPYSTR(CoopTrans."Transaction Name",1,50),BalAccType::"Bank Account",
//                                                   CoopSetup."Coop Bank Account",TransactionAmount,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);



//                                     SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Savings,AcctNo,COPYSTR(CoopTrans."Transaction Name",1,50),BalAccType::"G/L Account",
//                                                   '',TotalCharge,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);
//                                     SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Savings,AcctNo,COPYSTR('Excise Duty - '+CoopTrans."Transaction Name",1,50),BalAccType::"G/L Account",
//                                                   ExciseDutyGL,ExciseDuty,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);


//                                     AcctNo := CoopSetup."Coop Commission Account";
//                                     ExtDoc := CoopTrans."Member Account";
//                                     LoanNo := '';
//                                     TransType := TransType::" ";

//                                     SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::"Bank Account",CoopSetup."Coop Commission Account",COPYSTR(CoopTrans."Transaction Name",1,50),BalAccType::"G/L Account",
//                                                   '',-BankCharge,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);

//                                     AcctNo := CoopSetup."Coop Fee Account";
//                                     ExtDoc := CoopTrans."Member Account";
//                                     LoanNo := '';
//                                     TransType := TransType::" ";

//                                     SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::"G/L Account",AcctNo,COPYSTR(CoopTrans."Transaction Name",1,50),BalAccType::"G/L Account",
//                                                   '',-SaccoFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);


//                                     CoopTrans.Posted:=TRUE;
//                                     CoopTrans."Posted By":=USERID;
//                                     CoopTrans."Date Posted":=TODAY;
//                                     CoopTrans.MODIFY;
//                                     RespTransactionReference := CoopTrans."Document No.";

//                                     SaccoTrans.PostJournal(JTemplate,JBatch);


//                                     {
//                                     SLedger.RESET;
//                                     SLedger.SETRANGE("Document No.",CoopTrans."Document No.");
//                                     SLedger.SETRANGE("Posting Date",CoopTrans."Transaction Date");
//                                     SLedger.SETRANGE("Vendor No.",CoopTrans."Member Account");
//                                     IF SLedger.FINDFIRST THEN BEGIN
//                                         RespTransactionReference := FORMAT(SLedger."Transaction No.");
//                                     END;
//                                     }


//                                     RespStatusCode:=Success;
//                                     RespStatusDescription:='Success';
//                                 END;
//                                 */

//                             end
//                             else begin

//                                 RespStatusCode := Severe_problem_Has_Occured;
//                                 RespStatusDescription := 'Transaction Missing in NAVISION';
//                             end;
//                         end;
//                     end
//                     else begin
//                         if LimitReached then begin
//                             RespStatusCode := Severe_problem_Has_Occured;
//                             RespStatusDescription := 'Daily Limit Reached';
//                         end
//                         else begin
//                             RespStatusCode := Insufficient_Funds;
//                             RespStatusDescription := 'Insufficient Funds';
//                         end;
//                     end;
//                 end
//                 else begin
//                     RespStatusCode := Account_Does_Not_Exist;
//                     RespStatusDescription := 'Account Does Not Exist';
//                 end;
//         end;
//         //END;
//         Response := '<FundsTransferResponse>' +
//                         '<Response>' +

//                             '<HeaderReply>' +
//                                 '<RequestReference>' + RespTransactionID + '</RequestReference>' +
//                                 '<StatusCode>' + RespStatusCode + '</StatusCode>' +
//                                 '<StatusDescription>' + RespStatusDescription + '</StatusDescription>' +
//                             '</HeaderReply>' +

//                             '<OperationParameters>' +
//                                 '<TransactionDate>' + FormatDate(0D, RespTransactionDate) + '</TransactionDate>' +
//                                 '<TransactionReference>' + RespTransactionReference + '</TransactionReference>' +
//                             '</OperationParameters>' +

//                             '<Institution>' +
//                                 '<InstitutionCode>' + RespInstitutionCode + '</InstitutionCode>' +
//                             '</Institution>' +

//                             '<Account>' +
//                                 '<DebitAccount>' + RespDebitAccount + '</DebitAccount>' +
//                                 '<Amount>' + FormatDecimal(RespTotalAmount) + '</Amount>' +
//                                 '<ClearedBalance>' + '0' + '</ClearedBalance>' +
//                                 '<CreditAccount>' + RespCreditAccount + '</CreditAccount>' +
//                             '</Account>' +

//                             '<AdditionalInfos>' +
//                                 '<AdditionalInfo>' +
//                                     '<key>' + 'CLEAREDBALANCE' + '</key>' +
//                                     '<value>' + FormatDecimal(RespAccountBookBalance) + '</value>' +
//                                 '</AdditionalInfo>' +
//                                 '<AdditionalInfo>' +
//                                     '<key>' + 'ACCOUNTBOOKEDBALANCE' + '</key>' +
//                                     '<value>' + FormatDecimal(RespAccountClearedBalance) + '</value>' +
//                                 '</AdditionalInfo>' +
//                             '</AdditionalInfos>' +

//                         '</Response>' +
//                     '</FundsTransferResponse>';

//     end;


//     procedure MiniStatement(ServiceName: Text; RequestReference: Text; MaxNumberRows: Integer; TerminalID: Text; Channel: Text; TransactionDate: DateTime; DebitAccount: Text; MobileNo: Text; CreditAccount: Text; ChargeAmount: Decimal; ChargeCurrency: Text; FeeAmount: Decimal; FeeCurrency: Text; Narrative: Text[50]; InstitutionCode: Text; deviceType: Text; location: Text; conversionRate: Text) Response: Text
//     var
//         TransactionType: Code[20];
//         i: Decimal;
//         MemberNo: Text[30];
//         AccBalance: Decimal;
//         thisSavAccNo: Text[30];
//         foundChargeAccount: Boolean;
//         A: Integer;
//         MNo: Code[20];
//         AcctNo: Code[20];
//         TotalCharge: Decimal;
//         AccBal: Decimal;
//         RespTransactionID: Text;
//         RespStatusCode: Text;
//         RespStatusDescription: Text;
//         RespTransactionDate: DateTime;
//         RespTransactionReference: Text;
//         RespInstitutionCode: Text;
//         RespDebitAccount: Text;
//         RespAccountBookBalance: Decimal;
//         RespAccountClearedBalance: Decimal;
//         RespAccountCurrency: Text;
//         RespTotalAmount: Decimal;
//         RespCreditAccount: Text;
//         Reversal: Boolean;
//         RespDebitCreditFlag: Text;
//         RespTransAmount: Decimal;
//         RespNarration: Text;
//         RespPostingDate: Date;
//         RespChannelID: Text;
//         RespAccountName: Text;
//         RespAccountNumber: Text;
//         Found: Boolean;
//         RespBookBal: Text;
//         RespAvailableBalance: Text;
//         RespSummaryAccountBookBalance: Decimal;
//         RespSummaryAccountClearedBalance: Decimal;
//         PDesc: Text;
//     begin


//         Found := false;


//         ChannelCode := '';
//         TerminalCode := '';


//         if Channel <> '' then
//             ChannelCode := CopyStr(Channel, 4, 2);

//         if TerminalID <> '' then
//             TerminalCode := CopyStr(TerminalID, 1, 3);

//         if TerminalCode = 'ATM' then
//             ChannelCode := '';
//         if TerminalCode = 'POS' then
//             ChannelCode := '';



//         Message('%1\%2', TerminalCode, ChannelCode);
//         PDesc := '';
//         TransactionType := '0014';
//         if not CoopCode.Get(TransactionType, TerminalCode, ChannelCode) then begin
//             TerminalCode := '';
//             ChannelCode := '';
//         end;
//         PDesc := CoopCode."Posting Description";




//         // Get Excise duty G/L
//         ExciseDutyGL := GetExciseDutyGL();
//         ExciseDutyRate := GetExciseRate();
//         ExciseDuty := 0;

//         /*
//         TotalCharge:=ChargeAmount+FeeAmount;
//         ExciseDuty:=ROUND(FeeAmount*ExciseDutyRate/100);
//         */


//         BankCharge := 0;
//         SaccoFee := 0;
//         GetATMcharges(TransactionType, TerminalCode, ChannelCode, 0, BankCharge, SaccoFee);
//         TotalCharge := BankCharge + SaccoFee;
//         ExciseDuty := ROUND(SaccoFee * ExciseDutyRate / 100);

//         MaxNumberRows := 6;

//         //ERROR('TotalCharge %1',TotalCharge);

//         CoopSetup.Get;



//         RespTransactionID := RequestReference;
//         RespTransactionDate := TransactionDate;
//         RespTransactionReference := Null;
//         RespInstitutionCode := InstitutionCode;
//         RespDebitAccount := DebitAccount;
//         RespAccountBookBalance := 0;
//         RespAccountClearedBalance := 0;
//         RespSummaryAccountBookBalance := 0;
//         RespSummaryAccountClearedBalance := 0;
//         RespAccountCurrency := 'KES';
//         //RespTotalAmount:=TotalAmount;
//         RespCreditAccount := CreditAccount;


//         ATM_No := DebitAccount;
//         DebitAccount := GetAccountNoFromATMNo(DebitAccount);

//         if SavAcc.Get(DebitAccount) then begin


//             RespAccountName := SavAcc.Name;
//             RespAccountNumber := SavAcc."No.";

//             if MaxNumberRows > 0 then begin

//                 AccBal := SavAcc.GetAvailableBalance(SavAcc."No.");

//                 //ERROR('AccBal %1 TotalCharge+ExciseDuty %2 ',AccBal , TotalCharge+ExciseDuty );
//                 if AccBal >= TotalCharge + ExciseDuty then begin

//                     BUser.Get(UserId);

//                     JTemplate := 'GENERAL';
//                     JBatch := 'COOPBRIDGE';

//                     GenJournalBatch.Reset;
//                     GenJournalBatch.SetRange("Journal Template Name", JTemplate);
//                     GenJournalBatch.SetRange(Name, JBatch);
//                     if not GenJournalBatch.FindFirst then begin
//                         GenJournalBatch.Init;
//                         GenJournalBatch."Journal Template Name" := JTemplate;
//                         GenJournalBatch.Name := JBatch;
//                         GenJournalBatch.Description := 'Mcoop Batch';
//                         GenJournalBatch.Insert;
//                     end;

//                     if Narrative = '' then
//                         Narrative := 'Mini-Statement';
//                     CoopTrans.Init;
//                     CoopTrans."Transaction ID" := RequestReference;
//                     CoopTrans."Document No." := SetDocumentNo(RequestReference);
//                     CoopTrans."Service Name" := ServiceName;
//                     CoopTrans."Transaction Date" := Dt2Date(TransactionDate);
//                     CoopTrans."Transaction Time" := Dt2Time(TransactionDate);
//                     CoopTrans."Member Account" := DebitAccount;
//                     CoopTrans."Sacco Account" := CreditAccount;
//                     CoopTrans."ATM No." := ATM_No;
//                     CoopTrans.Commission := ChargeAmount;
//                     CoopTrans."Commission Currency" := ChargeCurrency;
//                     CoopTrans."Fee Charged" := FeeAmount;
//                     CoopTrans."Fee Currency" := FeeCurrency;
//                     CoopTrans."Description 1" := Narrative;
//                     CoopTrans."Institution Code" := InstitutionCode;
//                     CoopTrans."Posting Description" := PDesc;
//                     CoopTrans.Activity := CoopTrans.Activity::MiniStatement;
//                     CoopTrans."Transaction Type" := TransactionType;
//                     CoopTrans."Terminal Code" := TerminalCode;
//                     CoopTrans."Channel Code" := ChannelCode;
//                     CoopTrans."Total Charges" := TotalCharge;
//                     CoopTrans."Sacco Fee" := SaccoFee;
//                     CoopTrans."Coop Fee" := BankCharge;
//                     CoopTrans."Sacco Excise Duty" := ExciseDuty;
//                     CoopTrans."Total Account Debit" := CoopTrans.Amount + CoopTrans."Total Charges" + CoopTrans."Sacco Excise Duty";
//                     CoopTrans."Device Type" := deviceType;
//                     CoopTrans.Location := location;
//                     CoopTrans."Conversion Rate" := CRate;
//                     SavAcc.CalcFields("Balance (LCY)");
//                     RespSummaryAccountBookBalance := SavAcc."Balance (LCY)" - CoopTrans."Total Account Debit";
//                     RespSummaryAccountClearedBalance := SavAcc.GetAvailableBalance(SavAcc."No.") - CoopTrans."Total Account Debit";
//                     CoopTrans.Insert;

//                     RespTransactionReference := CoopTrans."Document No.";
//                     RespStatusCode := Success;
//                     RespStatusDescription := 'Success';

//                     CoopTrans.Reset;
//                     CoopTrans.SetRange("Transaction ID", RequestReference);
//                     //CoopTrans.SETRANGE(Posted,FALSE);
//                     if CoopTrans.FindFirst then begin
//                         /*
//                         DocNo := CoopTrans."Document No.";
//                         PDate := CoopTrans."Transaction Date";
//                         AcctNo := CoopTrans."Member Account";
//                         ExtDoc := '';
//                         LoanNo := '';
//                         TransType := TransType::" ";
//                         Dim1 := SavAcc."Global Dimension 1 Code";
//                         Dim2 := SavAcc."Global Dimension 2 Code";
//                         SystCreated := TRUE;
        
//                         SaccoTrans.InitJournal(JTemplate,JBatch);
        
        
//                         SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Savings,AcctNo,COPYSTR(CoopTrans."Description 1",1,50),BalAccType::"G/L Account",
//                                       '',TotalCharge,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);
//                         SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Savings,AcctNo,COPYSTR('Excise Duty - '+CoopTrans."Description 1",1,50),BalAccType::"G/L Account",
//                                       ExciseDutyGL,ExciseDuty,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);
        
        
//                         AcctNo := CoopSetup."Coop Commission Account";
//                         ExtDoc := CoopTrans."Member Account";
//                         LoanNo := '';
//                         TransType := TransType::" ";
        
//                         SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::"Bank Account",AcctNo,COPYSTR('Balance Enquiry Commission',1,50),BalAccType::"G/L Account",
//                                       '',-BankCharge,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);
        
//                         AcctNo := CoopSetup."Coop Fee Account";
//                         ExtDoc := CoopTrans."Member Account";
//                         LoanNo := '';
//                         TransType := TransType::" ";
        
//                         SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::"G/L Account",AcctNo,COPYSTR('Balance Enquiry Fee',1,50),BalAccType::"G/L Account",
//                                       '',-SaccoFee,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated);
        
        
//                         CoopTrans.Posted:=TRUE;
//                         CoopTrans."Posted By":=USERID;
//                         CoopTrans."Date Posted":=TODAY;
//                         CoopTrans.MODIFY;
//                         RespTransactionReference := CoopTrans."Document No.";
        
//                         SaccoTrans.PostJournal(JTemplate,JBatch);
        
        
//                         {
//                         SLedger.RESET;
//                         SLedger.SETRANGE("Document No.",CoopTrans."Document No.");
//                         SLedger.SETRANGE("Posting Date",CoopTrans."Transaction Date");
//                         SLedger.SETRANGE("Vendor No.",CoopTrans."Member Account");
//                         IF SLedger.FINDFIRST THEN BEGIN
//                             RespTransactionReference := FORMAT(SLedger."Transaction No.");
//                         END;
//                         }
        
//                         RespStatusCode:=Success;
//                         RespStatusDescription:='Success';
//                         */
//                     end
//                     else begin

//                         RespStatusCode := Severe_problem_Has_Occured;
//                         RespStatusDescription := 'Transaction Missing in NAVISION';
//                     end;

//                 end
//                 else begin
//                     RespStatusCode := Insufficient_Funds;
//                     RespStatusDescription := 'Insufficient Funds';
//                 end;
//             end;


//             RespTransAmount := 0;
//             RespNarration := '';
//             RespPostingDate := 0D;
//             RespChannelID := '';

//             if RespStatusCode = Success then begin
//                 CoopTrans.Reset;
//                 CoopTrans.SetRange("Transaction ID", RequestReference);
//                 //CoopTrans.SETRANGE(Posted,TRUE);
//                 if CoopTrans.FindFirst then begin
//                     SLedger.Reset;
//                     SLedger.SetRange("Customer No.", CoopTrans."Member Account");
//                     if SLedger.FindFirst then begin


//                         Response := '<MinistatementResponse>' +
//                             '<Response>';

//                         Response += '<HeaderReply>' +

//                                         '<RequestReference>' + RespTransactionID + '</RequestReference>' +
//                                         '<StatusCode>' + RespStatusCode + '</StatusCode>' +
//                                         '<StatusDescription>' + RespStatusDescription + '</StatusDescription>' +
//                                     '</HeaderReply>';


//                         LedgerCount := 0;


//                         CurrRecord := SLedger.Count - MaxNumberRows;

//                         if CurrRecord < 1 then
//                             CurrRecord := 1;


//                         if CurrRecord > 0 then begin
//                             RespAccountBookBalance := 0;
//                             Response += '<MiniStatement>';
//                             repeat


//                                 RespAccountBookBalance += SLedger."Amount (LCY)";
//                                 LedgerCount += 1;
//                                 if LedgerCount >= CurrRecord then begin

//                                     RespAccountClearedBalance := SavAcc.GetAvailableBalance(SavAcc."No.");
//                                     RespAccountBookBalance *= -1;

//                                     Found := true;
//                                     RespStatusCode := Success;
//                                     RespStatusDescription := 'Success';
//                                     if SLedger.Amount > 0 then
//                                         RespDebitCreditFlag := 'DR'
//                                     else
//                                         RespDebitCreditFlag := 'CR';
//                                     RespTransAmount := Abs(SLedger."Amount (LCY)");
//                                     RespNarration := SLedger.Description;
//                                     RespPostingDate := SLedger."Posting Date";
//                                     RespTransactionDate := TransactionDate;
//                                     RespChannelID := CoopTrans.Channel;




//                                     Response += '<AccountTransactions>' +

//                                                     '<RequestReference>' + RespTransactionID + '</RequestReference>' +
//                                                     '<StatusCode>' + RespStatusCode + '</StatusCode>' +
//                                                     '<StatusDescription>' + RespStatusDescription + '</StatusDescription>' +

//                                                     '<TransactionDate>' + FormatDate(0D, RespTransactionDate) + '</TransactionDate>' +
//                                                     '<TransactionReference>' + RespTransactionReference + '</TransactionReference>' +
//                                                     '<DebitCreditFlag>' + RespDebitCreditFlag + '</DebitCreditFlag>' +
//                                                     '<Amount>' + FormatDecimal(RespTransAmount) + '</Amount>' +
//                                                     '<Narration>' + RespNarration + '</Narration>' +
//                                                     '<PostingDate>' + FormatDate(RespPostingDate, 0DT) + '</PostingDate>' +
//                                                     '<BookBalance>' + FormatDecimal(RespAccountBookBalance) + '</BookBalance>' +
//                                                     '<ClearedRunningBalance>' + FormatDecimal(RespAccountClearedBalance) + '</ClearedRunningBalance>' +
//                                                     '<ChannelID>' + RespChannelID + '</ChannelID>' +
//                                                     '<AccountName>' + RespAccountName + '</AccountName>' +
//                                                     '<AccountNumber>' + RespAccountNumber + '</AccountNumber>' +
//                                                 '</AccountTransactions>';


//                                 end;
//                             until (SLedger.Next = 0);

//                             Response += '</MiniStatement>';

//                             RespAvailableBalance := FormatDecimal(SavAcc.GetAvailableBalance(SavAcc."No."));
//                             SavAcc.CalcFields("Balance (LCY)");

//                             RespBookBal := FormatDecimal(SavAcc."Balance (LCY)");
//                             Response += '<AdditionalInfos>';

//                             Response += '<AdditionalInfo>' +
//                                             '<key>' + 'CLEAREDBALANCE' + '</key>' +
//                                             '<value>' + RespAvailableBalance + '</value>' +
//                                         '</AdditionalInfo>' +
//                                         '<AdditionalInfo>' +
//                                             '<key>' + 'ACCOUNTBOOKEDBALANCE' + '</key>' +
//                                             '<value>' + RespBookBal + '</value>' +
//                                         '</AdditionalInfo>';

//                             Response += '</AdditionalInfos>';


//                             Response += '</Response>' +
//                                   '</MinistatementResponse>';
//                         end
//                         else begin
//                             RespStatusCode := Severe_problem_Has_Occured;
//                             RespStatusDescription := 'Invalid Maximum Number of Rows or Record Transaction';
//                         end;
//                     end
//                     else begin
//                         RespStatusCode := Severe_problem_Has_Occured;
//                         RespStatusDescription := 'No transactions Exist for this Member';
//                     end;
//                 end
//                 else begin
//                     RespStatusCode := Operation_Does_Not_Exist;
//                     RespStatusDescription := 'Operation Does Not Exist';
//                 end;
//             end;
//         end
//         else begin
//             RespStatusCode := Account_Does_Not_Exist;
//             RespStatusDescription := 'Account Does Not Exist';
//         end;



//         if not Found then begin

//             CoopSetup.Get;


//             RespTransactionID := RequestReference;
//             RespTransactionDate := TransactionDate;
//             RespTransactionReference := Null;
//             //CoopSetup.TESTFIELD("Institution Code");
//             RespInstitutionCode := InstitutionCode;
//             RespDebitAccount := DebitAccount;
//             RespAccountBookBalance := 0;
//             RespAccountClearedBalance := 0;
//             RespAccountCurrency := 'KES';




//             //PostATM(RespTransactionID);
//             Response := '<MinistatementResponse>' +
//                             '<Response>' +

//                                 '<HeaderReply>' +
//                                     '<RequestReference>' + RespTransactionID + '</RequestReference>' +
//                                     '<StatusCode>' + RespStatusCode + '</StatusCode>' +
//                                     '<StatusDescription>' + RespStatusDescription + '</StatusDescription>' +
//                                 '</HeaderReply>' +


//                                 '<MiniStatement/>' +

//                             '</Response>' +
//                         '</MinistatementResponse>';
//         end;

//     end;


//     procedure FormatDecimal(Amount: Decimal) TextValue: Text
//     begin

//         TextValue := DelChr(Format(Amount), '=', ',')
//     end;


//     procedure FormatDate(Date: Date; DateTime: DateTime) DateFormat: Text
//     var
//         DatePart: Date;
//         TimePart: Time;
//         Milliseconds: Integer;
//         Hours: Integer;
//         Seconds: Integer;
//         Minutes: Integer;
//         D: Integer;
//         M: Integer;
//         Y: Integer;
//         dd: Text;
//         mm: Text;
//         yyyy: Text;
//         DateString: Text;
//         TimeString: Text;
//         hh: Text;
//         ss: Text;
//     begin
//         TimePart := 0T;
//         DatePart := 0D;


//         Milliseconds := 0;
//         Seconds := 0;
//         Minutes := 0;
//         Hours := 0;

//         DateString := '';
//         TimeString := '';


//         DatePart := Date;

//         if DatePart = 0D then
//             DatePart := Dt2Date(DateTime);

//         D := Date2dmy(DatePart, 1);
//         M := Date2dmy(DatePart, 2);
//         Y := Date2dmy(DatePart, 3);

//         dd := Format(D);
//         mm := Format(M);
//         yyyy := Format(Y);

//         if StrLen(dd) = 1 then
//             dd := '0' + dd;
//         if StrLen(mm) = 1 then
//             mm := '0' + mm;

//         DateString := yyyy + '-' + mm + '-' + dd;

//         if DateTime <> 0DT then begin
//             TimePart := Dt2Time(DateTime);


//             Milliseconds := TimePart - 000000T;

//             Hours := Milliseconds DIV 1000 DIV 60 DIV 60;
//             Milliseconds -= Hours * 1000 * 60 * 60;

//             Minutes := Milliseconds DIV 1000 DIV 60;
//             Milliseconds -= Minutes * 1000 * 60;

//             Seconds := Milliseconds DIV 1000;
//             Milliseconds -= Seconds * 1000;

//             //MESSAGE('%1 \%2 \%3', Hours, Minutes, Milliseconds);

//         end;


//         hh := Format(Hours);
//         mm := Format(Minutes);
//         ss := Format(Seconds);


//         if StrLen(hh) = 1 then
//             hh := '0' + hh;
//         if StrLen(mm) = 1 then
//             mm := '0' + mm;
//         if StrLen(ss) = 1 then
//             ss := '0' + ss;

//         TimeString := hh + ':' + mm + ':' + ss;


//         DateFormat := DateString + 'T' + TimeString;
//     end;


//     procedure GetAccountNoFromATMNo(ATMNo: Code[20]): Text
//     var
//         Vendor: Record "Savings Accounts";
//     begin

//         Vendor.Reset;
//         Vendor.SetRange(Vendor."ATM No.", ATMNo);
//         Vendor.SetRange(Vendor.Blocked, Vendor.Blocked::" ");
//         Vendor.SetRange(Vendor.Status, Vendor.Status::Active);
//         if Vendor.FindFirst then begin

//             if Vendor.Count <> 1 then
//                 Error('ATM No. not linked to one account');

//             exit(Vendor."No.");
//         end;
//     end;

//     local procedure SetDocumentNo(TransNo: Code[50]): Code[20]
//     var
//         TNo: Text;
//     begin

//         TNo := CreateGuid;
//         TNo := DelChr(TNo, '=', '{|}|-');
//         TNo := CopyStr(TNo, 1, 15);
//         Message('Doc: %1', StrLen(TNo));


//         TNo := CopyStr(TransNo, 1, 12);

//         exit(TNo);
//     end;


//     procedure GetATMcharges(TransCode: Code[10]; Terminal: Code[10]; Channel: Code[10]; Amount: Decimal; var BankCharge: Decimal; var SaccoFee: Decimal)
//     var
//         Charge: Record "Coop ATM Charges";
//         Counter: Integer;
//     begin

//         BankCharge := 0;
//         SaccoFee := 0;
//         Charge.Reset;
//         Charge.SetRange(Charge.Code, TransCode);
//         //IF (TransCode  <> '0016') AND (TransCode  <> '0014') THEN BEGIN
//         Charge.SetRange(Charge.Terminal, Terminal);
//         Charge.SetRange(Charge.Channel, Channel);
//         //END;
//         Charge.SetFilter(Charge.Minimum, '<=%1', Amount);
//         Charge.SetFilter(Charge.Maximum, '>=%1', Amount);
//         if Charge.FindFirst then begin
//             BankCharge := Charge."Bank Commission";
//             SaccoFee := Charge."Sacco Commission";

//             if Charge."Sacco Per Every" > 0 then begin
//                 Counter := ROUND(Amount / Charge."Sacco Per Every", 1, '>');
//                 SaccoFee := SaccoFee * Counter;
//             end;

//         end;
//     end;


//     procedure PostATM(TransID: Code[50]) Response: Text
//     var
//         i: Decimal;
//         MemberNo: Text[30];
//         AccBalance: Decimal;
//         thisSavAccNo: Text[30];
//         foundChargeAccount: Boolean;
//         A: Integer;
//         MNo: Code[20];
//         AcctNo: Code[20];
//         TotalCharge: Decimal;
//         AccBal: Decimal;
//         RespTransactionID: Text;
//         RespStatusCode: Text;
//         RespStatusDescription: Text;
//         RespTransactionDate: DateTime;
//         RespTransactionReference: Text;
//         RespInstitutionCode: Text;
//         RespDebitAccount: Text;
//         RespAccountBookBalance: Decimal;
//         RespAccountClearedBalance: Decimal;
//         RespAccountCurrency: Text;
//         TransactionType: Code[10];
//         Source: Enum "SMS Source";
//         PhoneNo: Code[20];
//         Msg: Text;
//         Reversal: Boolean;
//         Vendor: Record "Savings Accounts";
//         Continue: Boolean;
//         Desc: Text;
//         BankAccount: Code[20];
//         SaccoFee: Decimal;
//         CoopFee: Decimal;
//         ExciseDuty: Decimal;
//     begin

//         //ERROR('test');
//         BUser.Get(UserId);

//         JTemplate := 'GENERAL';
//         JBatch := 'COOPBRIDGE';

//         GenJournalBatch.Reset;
//         GenJournalBatch.SetRange("Journal Template Name", JTemplate);
//         GenJournalBatch.SetRange(Name, JBatch);
//         if not GenJournalBatch.FindFirst then begin
//             GenJournalBatch.Init;
//             GenJournalBatch."Journal Template Name" := JTemplate;
//             GenJournalBatch.Name := JBatch;
//             GenJournalBatch.Description := 'Coopbridge Batch';
//             GenJournalBatch.Insert;
//         end;


//         // Get Excise duty G/L
//         ExciseDutyGL := GetExciseDutyGL();
//         ExciseDutyRate := GetExciseRate();
//         ExciseDuty := 0;

//         CoopSetup.Get;
//         CoopTrans.Reset;
//         CoopTrans.SetRange(Skipped, false);
//         CoopTrans.SetRange(Posted, false);
//         if TransID <> '' then
//             CoopTrans.SetRange("Transaction ID", TransID);
//         if CoopTrans.FindFirst then begin
//             repeat
//                 CoopTrans.Skipped := true;

//                 DocNo := CoopTrans."Document No.";
//                 //PDate := CoopTrans."Transaction Date";
//                 PDate := Today;
//                 AcctNo := CoopTrans."Member Account";
//                 ExtDoc := '';
//                 LoanNo := '';
//                 TransType := Transtype::" ";
//                 Dim1 := SavAcc."Global Dimension 1 Code";
//                 Dim2 := SavAcc."Global Dimension 2 Code";
//                 SystCreated := true;
//                 Continue := true;
//                 if Vendor.Get(AcctNo) then
//                     if Vendor.Blocked <> Vendor.Blocked::" " then
//                         Continue := false;

//                 BankAccount := '';
//                 if Continue then begin

//                     if CoopTrans.Activity <> CoopTrans.Activity::Reversal then begin
//                         SaccoTrans.InitJournal(JTemplate, JBatch);

//                         BankAccount := GetCoopBankAccount(CoopTrans."Transaction Type", CoopTrans."Terminal Code", CoopTrans."Channel Code", SaccoFee, CoopFee);
//                         //ERROR(BankAccount);

//                         CoopFee := 0;
//                         ExciseDutyRate := GetExciseRate;
//                         SaccoFee := 0;
//                         GetATMcharges(CoopTrans."Transaction Type", CoopTrans."Terminal Code", CoopTrans."Channel Code", CoopTrans.Amount, CoopFee, SaccoFee);
//                         TotalCharge := CoopFee + SaccoFee;
//                         ExciseDuty := ROUND(SaccoFee * ExciseDutyRate / 100);


//                         Desc := CoopTrans."Transaction Name";
//                         if Desc = '' then
//                             Desc := CoopTrans."Description 1";
//                         if Desc = '' then
//                             Desc := CoopTrans."Description 2";


//                         if CoopTrans."Posting Description" <> '' then
//                             Desc := CoopTrans."Posting Description";
//                         SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AcctNo, CopyStr(Desc, 1, 50), Balacctype::"Bank Account",
//                                       BankAccount, CoopTrans.Amount, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);




//                         SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AcctNo, CopyStr(Desc + ' Charge', 1, 50), Balacctype::"G/L Account",
//                                       '', SaccoFee + CoopFee + ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);

//                         SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", ExciseDutyGL, CopyStr('Excise Duty - ' + Desc, 1, 50), Balacctype::"G/L Account",
//                                       '', -ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);


//                         AcctNo := CoopSetup."Coop Commission Account";
//                         ExtDoc := CoopTrans."Member Account";
//                         LoanNo := '';
//                         TransType := Transtype::" ";
//                         SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"Bank Account", BankAccount, CopyStr(Desc + ': ' + CoopTrans."Member Account", 1, 50), Balacctype::"G/L Account",
//                                       '', -CoopFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);

//                         AcctNo := CoopSetup."Coop Fee Account";
//                         ExtDoc := CoopTrans."Member Account";
//                         LoanNo := '';
//                         TransType := Transtype::" ";

//                         SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", AcctNo, CopyStr(Desc + ': ' + CoopTrans."Member Account", 1, 50), Balacctype::"G/L Account",
//                                       '', -SaccoFee, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);

//                         CoopTrans.Posted := true;
//                         CoopTrans.Skipped := false;
//                         CoopTrans."Posted By" := UserId;
//                         CoopTrans."Date Posted" := Today;
//                         CoopTrans."Time Posted" := Time;
//                         CoopTrans.Modify;

//                         if CoopTrans.Activity = CoopTrans.Activity::"Funds Transfer" then begin
//                             if SavAcc.Get(CoopTrans."Member Account") then begin
//                                 PhoneNo := SavAcc."Transactional Mobile No";
//                                 if PhoneNo = '' then
//                                     PhoneNo := SavAcc."Mobile Phone No";

//                                 Msg := 'Dear ' + SavAcc.Name + ', You have done a ' + CoopTrans."Transaction Name" + ' of KES ' + Format(CoopTrans.Amount) + ' from ' + CoopTrans."Terminal Code" + ' Terminal ' +
//                                 DelChr(CoopTrans.Location, '=', '  ') + ' on ' + Format(CreateDatetime(CoopTrans."Transaction Date", CoopTrans."Transaction Time"));
//                                 SendSMS.SendSms(Source::CASH_WITHDRAWAL_CONFIRM, PhoneNo, msg, Format(CoopTrans."Transaction ID"), '', true, 0, false, 'CBS', CoopTrans."Transaction ID", 'CBS');

//                             end;
//                         end;

//                         SaccoTrans.PostJournal(JTemplate, JBatch);
//                     end
//                     else
//                         if CoopTrans.Activity = CoopTrans.Activity::Reversal then begin

//                             if CoopTrans."Transaction Type" = '1420' then begin
//                                 if CoopTrans."Original Transaction ID" <> '' then begin

//                                     if ReverseTransaction(CoopTrans."Transaction ID", CoopTrans."Original Transaction ID", CoopTrans."Service Name", CoopTrans.Channel, CoopTrans."Member Account", CoopTrans.Amount) then begin
//                                         if SavAcc.Get(CoopTrans."Member Account") then begin
//                                             PhoneNo := SavAcc."Transactional Mobile No";
//                                             if PhoneNo = '' then
//                                                 PhoneNo := SavAcc."Mobile Phone No";


//                                             Msg := 'Dear ' + SavAcc.Name + ', your transaction of KES ' + Format(Abs(CoopTrans.Amount)) + ' has been reversed';
//                                             SendSMS.SendSms(Source::CASH_WITHDRAWAL_CONFIRM, PhoneNo, msg, Format(CoopTrans."Transaction ID"), '', true, 0, false, 'CBS', CoopTrans."Member Account", 'CBS');

//                                         end;

//                                         CoopTrans.Posted := true;
//                                         CoopTrans."Posted By" := UserId;
//                                         CoopTrans."Date Posted" := Today;

//                                         CoopTrans.Reversed := true;
//                                         CoopTrans."Date Reversed" := Today;
//                                         CoopTrans."Reversed By" := UserId;
//                                         CoopTrans."Time Reversed" := Time;
//                                         CoopTrans.Modify;

//                                         RespStatusCode := Success;
//                                         RespStatusDescription := 'Success';
//                                     end
//                                     else begin
//                                         CoopTrans.Remarks := 'Reversal Failed';
//                                     end;

//                                 end
//                                 else
//                                     CoopTrans.Remarks := 'Original Transaction ID Missing';
//                             end
//                             else
//                                 CoopTrans.Remarks := 'Invalid Transaction Code. Expected Code is 1420';

//                         end;
//                     CoopTrans.Modify;
//                 end;
//             until CoopTrans.Next = 0;
//         end;
//     end;


//     procedure GetCoopBankAccount(TransCode: Code[10]; Terminal: Code[10]; Channel: Code[10]; var SaccoFee: Decimal; var CoopFee: Decimal) BankAccount: Code[20]
//     var
//         Charge: Record "Coop Transaction Codes";
//         Counter: Integer;
//         CoopATMCharges: Record "Coop ATM Charges";
//     begin

//         BankAccount := '';

//         Charge.Reset;
//         Charge.SetRange(Charge.Code, TransCode);
//         if (TransCode <> '0016') and (TransCode <> '0014') then begin
//             Charge.SetRange(Charge.Terminal, Terminal);
//             Charge.SetRange(Charge.Channel, Channel);

//             CoopATMCharges.Reset;
//             CoopATMCharges.SetRange(Code, TransCode);
//             CoopATMCharges.SetRange(CoopATMCharges.Terminal, Terminal);
//             CoopATMCharges.SetRange(CoopATMCharges.Channel, Channel);
//             if CoopATMCharges.FindFirst then begin
//                 CoopFee := CoopATMCharges."Bank Commission";
//                 SaccoFee := CoopATMCharges."Sacco Commission";
//             end;
//         end;
//         if Charge.FindFirst then begin
//             BankAccount := Charge."Coop Bank Account";
//         end;
//     end;
// }
