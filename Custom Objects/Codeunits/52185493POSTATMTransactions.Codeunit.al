#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185493 "POST ATM Transactions"
{

    trigger OnRun()
    var
        Location: Text;
        Counts: Integer;
        Venderdetails: Record "Savings Ledger Entry";
    begin


        //delete journal line
        /*
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name",JTemplate);
        GenJournalLine.SETRANGE("Journal Batch Name",JBatch);
        GenJournalLine.DELETEALL;
        */

        if BankingUserTemplate.Get(UserId) then begin
            JTemplate := BankingUserTemplate."Cashier Journal Template";
            JBatch := BankingUserTemplate."Cashier Journal Batch";
        end;
        POSTJOURNAL.ClearJournalLines(JTemplate, JBatch);
        //end of deletion
        //MESSAGE('1');
        GenBatches.Reset;
        GenBatches.SetRange(GenBatches."Journal Template Name", JTemplate);
        GenBatches.SetRange(GenBatches.Name, JBatch);
        if GenBatches.Find('-') = false then begin
            GenBatches.Init;
            GenBatches."Journal Template Name" := JTemplate;
            GenBatches.Name := JBatch;
            GenBatches.Description := 'ATM Transactions';
            GenBatches.Validate(GenBatches."Journal Template Name");
            GenBatches.Validate(GenBatches.Name);
            GenBatches.Insert;
        end;
        //MESSAGE('2');
        GenSetup.Get;
        i := 0;
        Counts := 0;
        SMSAmount := 0;

        ATMTrans.Reset;
        ATMTrans.SetRange(ATMTrans.Posted, false);
        //ATMTrans.SETRANGE(ATMTrans."Reference No",'825412841231');
        //ATMTrans.SETFILTER(ATMTrans."Transaction Type Charges",'<>%1',ATMTrans."Transaction Type Charges"::"Utility Payment");

        ATMTrans.SetRange(ATMTrans.Source, ATMTrans.Source::ATM);

        if ATMTrans.Find('-') then begin

            repeat

                if (Counts <= 100) then begin

                    // prevent double posting
                    if ATMTrans.Reversed = false then begin
                        Venderdetails.Reset;
                        Venderdetails.SetRange(Venderdetails."Document No.", ATMTrans."Reference No");
                        if Venderdetails.Find('-') then begin
                            ATMTrans.Posted := true;
                            ATMTrans."Customer Names" := 'Transaction Already Posted';
                            ATMTrans.Modify;
                            Commit;
                            exit;
                        end;
                    end;
                    // prevent double posting reversals
                    if ATMTrans.Reversed = true then begin
                        Venderdetails.Reset;
                        Venderdetails.SetRange(Venderdetails."Document No.", ATMTrans."Reference No");
                        Venderdetails.SetRange(Venderdetails.Description, 'Reversal');
                        if Venderdetails.Find('-') then begin

                            ATMTrans.Posted := true;
                            ATMTrans."Customer Names" := 'Reversal Transaction Already Posted';
                            ATMTrans.Modify;
                            Commit;
                            exit;
                        end;
                    end;

                    // Prevent Double Posting
                    //MESSAGE('document NO' + DocNo);
                    ATMCharges := 0;
                    BankCharges := 0;
                    Commision := 0;
                    POSCommission := 0;
                    GLAcc := '';
                    BankAcc := '';
                    BankChargecode := '';
                    ExciseDuty := 0;
                    TransDescription := '';
                    DocNo := ATMTrans."Reference No";//ATMTrans."Trace ID"+'ATM';

                    if ATMTrans.Reversed = true then begin
                        AtmTrans1.Reset;
                        AtmTrans1.SetRange(AtmTrans1."Account No", ATMTrans."Account No");
                        AtmTrans1.SetRange(AtmTrans1.Reversed, false);
                        AtmTrans1.SetRange(AtmTrans1."Trace ID", ATMTrans."Reversal Trace ID");
                        if AtmTrans1.Find('-') then begin
                            if ATMCharge.Get(AtmTrans1."Transaction Type Charges") then begin
                                ATMCharges := -ATMCharge."Total Amount";
                                BankCharges := -ATMCharge."Sacco Amount";
                                Commision := -ATMCharge.Commission;
                            end;
                        end;
                    end else begin
                        if ATMCharge.Get(ATMTrans."Transaction Type Charges") then begin
                            ATMCharges := ATMCharge."Total Amount";
                            BankCharges := ATMCharge."Sacco Amount";
                            Commision := ATMCharge.Commission;
                        end;
                    end;

                    if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"Pos-cash Withdrawal")
                    or (AtmTrans1."Transaction Type Charges" = AtmTrans1."transaction type charges"::"Pos-cash Withdrawal") then begin
                        //MESSAGE('sawa');
                        //Posting Charges++++++++++++++++
                        if ATMTrans.Reversed = false then begin
                            Pos.Reset;
                            Pos.SetFilter(Pos."Lower Limit", '<=%1', ATMTrans.Amount);
                            Pos.SetFilter(Pos."Upper Limit", '>=%1', ATMTrans.Amount);
                            if Pos.FindFirst then begin
                                ATMCharges := Pos."Charge Amount";// + (0.2 * Pos."Charge Amount");
                                BankCharges := 0;
                                POSCommission := 0;
                                Commision := Pos."Charge Amount";//+ (0.2 * Pos."Charge Amount");
                                                                 //MESSAGE(FORMAT(ATMCharges));
                                                                 //MESSAGE(FORMAT(Commision));
                            end;
                        end else begin
                            //Reversal Charges+++++++++++++
                            Pos.Reset;
                            Pos.SetFilter(Pos."Lower Limit", '<=%1', ATMTrans.Amount * -1);
                            Pos.SetFilter(Pos."Upper Limit", '>=%1', ATMTrans.Amount * -1);
                            if Pos.FindFirst then begin
                                ATMCharges := -Pos."Charge Amount";// - (0.2 * Pos."Charge Amount");
                                BankCharges := 0;
                                POSCommission := 0;
                                Commision := -(Pos."Charge Amount") /*- (0.2 * Pos."Charge Amount") - (Pos."Bank charge")*/;

                            end;
                        end;//Rvs.
                    end;

                    if (ATMCharge.Source = ATMCharge.Source::ATM) and (ATMCharge."Transaction Type" = ATMCharge."transaction type"::"Cash Withdrawal - VISA ATM") then begin
                        GLAcc := '302105'; //'300-000-310' atm - commissions
                        BankAcc := GenSetup."VISA Settlement Account";//'BNK0000013'; // - VISA settlement account
                        BankChargecode := GenSetup."VISA Settlement Account";//'BNK0000013';

                    end else
                        if (ATMCharge.Source = ATMCharge.Source::ATM) and (ATMCharge."Transaction Type" <> ATMCharge."transaction type"::"Cash Withdrawal - VISA ATM") then begin
                            GLAcc := '302105'; //'300-000-310' atm - commissions
                            BankAcc := GenSetup."ATM Settlement Account";//'BNK0000013'; // - atm settlement account
                            BankChargecode := GenSetup."ATM Settlement Account";//'BNK0000013';


                        end else begin
                            GLAcc := '302105';  //'13207' pos - commissions
                            BankAcc := GenSetup."POS Bank Account";//'BNK0000013';  // - POS settlement account
                            BankChargecode := GenSetup."POS Bank Account";//'BNK0000013';
                        end;
                    //END;
                    if Acct.Get(ATMTrans."Account No") then begin
                        LineNo := LineNo + 10000;
                        if ATMTrans.Reversed = true then
                            TransDescription := '-Reversal'
                        else
                            TransDescription := '';

                        if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"Pos-balance Enquiry") or
                            (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"Pos Normal Purchase") or
                            (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"Pos-mini Statement") or
                             (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"Utility Payment") or
                              (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::Reversal) then begin
                            if ATMCharge.Get(ATMTrans."Transaction Type Charges") then begin
                                ATMCharges := ATMCharge."Total Amount";
                                BankCharges := 0;
                                Commision := ATMCharge."Total Amount";
                            end;
                        end;
                        if ATMTrans.Amount <> 0 then
                            POSTJOURNAL.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::Savings, DocNo, PadStr(ATMTrans.Description, 50), ATMTrans.Amount
                           , ATMTrans."Account No", Today, Optionsaccounts::"G/L Account", '', PadStr(ATMTrans."Account No", 50), savingAcct."Global Dimension 1 Code", savingAcct."Global Dimension 2 Code", TransType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                        //MESSAGE('1');
                        LineNo := LineNo + 10000;

                        if ATMTrans.Amount <> 0 then
                            POSTJOURNAL.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::"Bank Account", DocNo, PadStr(Acct.Name, 50), ATMTrans.Amount * -1
                           , BankAcc, Today, Optionsaccounts::"G/L Account", '', PadStr(ATMTrans."Account No", 50), savingAcct."Global Dimension 1 Code", savingAcct."Global Dimension 2 Code", TransType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                        LineNo := LineNo + 10000;
                        if ATMCharges <> 0 then
                            POSTJOURNAL.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::Savings, DocNo, PadStr(ATMTrans.Description + ' Charge ' + TransDescription, 50), ATMCharges
                           , ATMTrans."Account No", Today, Optionsaccounts::"G/L Account", '', PadStr(ATMTrans."Account No", 50), savingAcct."Global Dimension 1 Code", savingAcct."Global Dimension 2 Code", TransType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                        LineNo := LineNo + 10000;
                        if Commision <> 0 then
                            POSTJOURNAL.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::"Bank Account", DocNo, PadStr(ATMTrans.Description + ' Bank Commission ' + TransDescription, 50), -1 * Commision
                               , BankChargecode, Today, Optionsaccounts::"G/L Account", '', PadStr(ATMTrans."Account No", 50), savingAcct."Global Dimension 1 Code", savingAcct."Global Dimension 2 Code", TransType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                        LineNo := LineNo + 10000;

                        if BankCharges <> 0 then
                            POSTJOURNAL.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::"G/L Account", DocNo, PadStr(ATMTrans.Description + ' Charge ' + TransDescription, 50), -1 * (BankCharges)
                               , GLAcc, Today, Optionsaccounts::"G/L Account", '', PadStr(ATMTrans."Account No", 50), savingAcct."Global Dimension 1 Code", savingAcct."Global Dimension 2 Code", TransType::" ", '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                        LineNo := LineNo + 10000;

                        if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"Pos Normal Purchase")
                        or (AtmTrans1."Transaction Type Charges" = AtmTrans1."transaction type charges"::"Pos Normal Purchase") then begin
                            ExciseDuty := 0;
                        end else
                            if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"Pos-cash Withdrawal")
                            or (AtmTrans1."Transaction Type Charges" = AtmTrans1."transaction type charges"::"Pos-cash Withdrawal") then begin
                                ExciseDuty := 0;
                            end else begin
                                ExciseDuty := -0.2 * (BankCharges);
                            end;
                        if ATMTrans.Reversed = true then
                            TransDescription := 'Excise Duty-Reversal'
                        else
                            TransDescription := 'Excise Duty';

                        if ExciseDuty <> 0 then
                            POSTJOURNAL.PostJournal(JTemplate, JBatch, LineNo, Optionsaccounts::"G/L Account", DocNo, TransDescription, ExciseDuty
                               , GenSetup."Excise Duty G/L", Today, Optionsaccounts::"G/L Account", '', ATMTrans."Account No", savingAcct."Global Dimension 1 Code", savingAcct."Global Dimension 2 Code", 0, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                        // -- send SMS alert -- //
                        PhoneNo := '';
                        if Acct."Phone No." <> '' then begin
                            PhoneNo := Acct."Phone No.";
                        end else
                            if Acct."Mobile Phone No" <> '' then begin
                                PhoneNo := Acct."Mobile Phone No";
                            end;
                        //POSTJOURNAL.LinesCompletePosting(JTemplate,JBatch);
                        //ERROR('%1 ans pp %2',JBatch,JTemplate);

                        POSTJOURNAL.CompletePosting(JTemplate, JBatch);
                        ATMTrans.Posted := true;
                        ATMTrans."Transaction Time" := Time;
                        ATMTrans."Transaction Date" := Today;
                        ATMTrans.Modify;
                        Commit;

                        if ATMTrans.Reversed = true then
                            Location := DelChr(AtmTrans1."Withdrawal Location", '=', ' ')
                        else
                            Location := DelChr(ATMTrans."Withdrawal Location", '=', ' ');

                        if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"Pos-balance Enquiry") then begin
                           
                        msg := 'Dear Member, you have done a Balance Enquiry from ATM terminal ' + Location +' on ' + Format(ATMTrans."Posting Date") + '.HARAMBEE SACCO.';
                        SendSMS.SendSms(Source::MBANKING, Acct."Mobile Phone No", msg, Format(Acct."No."), '', true, 0, false, 'CBS', Acct."No.", 'CBS');
                        end else begin
                            if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"POS - Cash Deposit") or
                               (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"POS - Cash Deposit to Card") or
                               (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::Reversal) then begin
                                SMSAmount := ATMTrans.Amount * -1
                            end else begin
                                SMSAmount := ATMTrans.Amount;
                            end;
                            if (ATMTrans.Reversed = true) then
                                msg := 'Dear Member, your withdrawal of ksh ' + Format(SMSAmount) + ' from ATM terminal ' + Location + ' on ' + Format(ATMTrans."Posting Date") + ' has been reversed.HARAMBEE SACCO.'
                            else
                                msg := 'Dear Member, you have done a ' + ATMTrans.Description + ' of ksh ' + Format(SMSAmount) + ' from ATM terminal ' + Location + ' on ' + Format(ATMTrans."Posting Date") + '.HARAMBEE SACCO.';

                            SendSMS.SendSms(Source::MBANKING, Acct."Mobile Phone No", msg, Format(Acct."No."), '', true, 0, false, 'CBS', Acct."No.", 'CBS');
                        end
                    end
                    else begin
                        Error('%1', 'Account No. %1 not found.', ATMTrans."Account No");
                    end;

                    i := i + 1;
                    if i >= 2510 then exit;
                    Counts := Counts + 1;
                end;
            until ATMTrans.Next = 0;
        end;

    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        ATMTrans: Record "ATM Transactions";
        LineNo: Integer;
        Acct: Record "Savings Accounts";
        ATMCharges: Decimal;
        BankCharges: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        //GLPosting: Codeunit "Gen. Jnl.-Post Line";
        BankCode: Code[20];
        PDate: Date;
        RevFromDate: Date;
        ATMTransR: Record "ATM Transactions";
        GLAcc: Code[20];
        BankAcc: Code[20];
        ATMCharge: Record "ATM Charges";
        AtmTrans1: Record "ATM Transactions";
        BankChargecode: Code[20];
        DocNo: Code[20];
        Pos: Record "POS Commissions";
        GenSetup: Record "General Set-Up";
        // SendNotification: Codeunit "Custom Approvals Codeunit";
        PhoneNo: Text[50];
        smss: Record "Bank Transfer Modes";
        savingAcct: Record "Savings Accounts";
        i: Decimal;
        Commision: Decimal;
        Sendsms: Codeunit SendSms;
        OptionSMS: Option "Membership Approval","Savings Approval","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Guarantors","Loan Posted","Loan defaulted","Salary Posted","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO;
        POSCommission: Decimal;
        POSTJOURNAL: Codeunit "Journal Posting";
        OptionsAccounts: Enum "Gen. Journal Account Type";
        OptionTransactionTypes: Option " ",Loan,Repayment,"Interest Due","Interest Paid",Bills,ATM;
        saccoAccount: Record "Savings Accounts";
        TransDescription: Text[50];
        ExciseDuty: Decimal;
        BankingUserTemplate: Record "Banking User Template";
        JTemplate: Code[20];
        JBatch: Code[20];
        SMSAmount: Decimal;
        msg: Text;
        Source: Enum "SMS Source";
        TransType: Enum "Transaction Types";
}
