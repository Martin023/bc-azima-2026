#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185494 "Post ATM Transactions 2"
{

    trigger OnRun()
    begin
        Message('count ' + Format(ProcessTransactions()));
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


    procedure ProcessTransactions() transactionsCount: Integer
    var
        tcount: Integer;
    begin
        // //EXIT;
        //  //delete journal line
        //  IF BankingUserTemplate.GET(USERID) THEN BEGIN
        //    JTemplate:=BankingUserTemplate."Cashier Journal Template";
        //    JBatch:=BankingUserTemplate."Cashier Journal Batch";
        //  END;
        //  POSTJOURNAL.ClearJournalLines(JTemplate,JBatch);
        //  //end of deletion
        //
        //  //MESSAGE('1');
        //  GenBatches.RESET;
        //  GenBatches.SETRANGE(GenBatches."Journal Template Name",JTemplate);
        //  GenBatches.SETRANGE(GenBatches.Name,JBatch);
        //  IF GenBatches.FIND('-') = FALSE THEN BEGIN
        //    GenBatches.INIT;
        //    GenBatches."Journal Template Name":=JTemplate;
        //    GenBatches.Name:=JBatch;
        //    GenBatches.Description:='ATM Transactions';
        //    GenBatches.VALIDATE(GenBatches."Journal Template Name");
        //    GenBatches.VALIDATE(GenBatches.Name);
        //    GenBatches.INSERT;
        //  END;
        //  //MESSAGE('2');


        // get unposted transactions
        ATMTrans.Reset;
        ATMTrans.SetRange(Source, ATMTrans.Source::ATM);
        //ATMTrans.SETRANGE(Posted,FALSE);
        ATMTrans.SetRange("Posting Date", 20171210D);
        if ATMTrans.Find('-') then begin
            Error(Format(ATMTrans."Posting Date") + '    ' + ATMTrans."Reference No" + ' status ' + Format(ATMTrans.Posted));

            tcount := 0;
            repeat
                Message('found ' + ATMTrans."Reference No" + ' status ' + Format(ATMTrans.Posted));
            until (tcount = 5) or (ATMTrans.Next = 0);
        end;
        // end // get unposted transactions



        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        //
        //  GenSetup.GET;
        //  i:= 0;
        //  Counts:=0;
        //  SMSAmount:=0;
        //
        //  ATMTrans.RESET;
        //  ATMTrans.SETRANGE(ATMTrans.Posted,FALSE);
        //
        //  //ATMTrans.SETFILTER(ATMTrans."Transaction Type Charges",'<>%1',ATMTrans."Transaction Type Charges"::"Utility Payment");
        //
        //  ATMTrans.SETRANGE(ATMTrans.Source,ATMTrans.Source::ATM);
        //
        //  IF ATMTrans.FIND('-') THEN  BEGIN
        //
        //    REPEAT
        //
        //      IF(Counts<=100) THEN BEGIN
        //        {
        //        //************************************** Prevent double posting
        //        IF ATMTrans.Reversed=TRUE THEN BEGIN
        //          Venderdetails.RESET;
        //          Venderdetails.SETRANGE(Venderdetails."Document No.",ATMTrans."Reference No" );
        //          Venderdetails.SETRANGE(Venderdetails.Description,'Reversal');
        //          IF Venderdetails.FIND('-') THEN BEGIN
        //            ATMTrans.Posted:=TRUE;
        //            ATMTrans."Customer Names":='Double Posting';
        //            ATMTrans.MODIFY;
        //            COMMIT;
        //            EXIT;
        //          END;
        //        END;
        //        // ************************************ Prevent double posting
        //        }
        //        //MESSAGE('document NO' + DocNo);
        //        ATMCharges:=0;
        //        BankCharges:=0;
        //        Commision :=0;
        //        POSCommission :=0;
        //        GLAcc:='';
        //        BankAcc:='';
        //        BankChargecode:='';
        //        ExciseDuty:=0;
        //        TransDescription:='';
        //        DocNo:=ATMTrans."Reference No";//ATMTrans."Trace ID"+'ATM';
        //
        //    IF ATMTrans.Reversed=TRUE THEN BEGIN
        //      AtmTrans1.RESET;
        //      AtmTrans1.SETRANGE(AtmTrans1."Account No",ATMTrans."Account No");
        //      AtmTrans1.SETRANGE(AtmTrans1.Reversed,FALSE);
        //      AtmTrans1.SETRANGE(AtmTrans1."Trace ID",ATMTrans."Reversal Trace ID");
        //      IF AtmTrans1.FIND('-') THEN BEGIN
        //      IF ATMCharge.GET(AtmTrans1."Transaction Type Charges") THEN BEGIN
        //        ATMCharges:=-ATMCharge."Total Amount";
        //        BankCharges:=-ATMCharge."Sacco Amount";
        //        Commision:=-ATMCharge.Commission;
        //      END;
        //     END;
        //     END ELSE BEGIN
        //      IF ATMCharge.GET(ATMTrans."Transaction Type Charges") THEN BEGIN
        //        ATMCharges:=ATMCharge."Total Amount";
        //        BankCharges:=ATMCharge."Sacco Amount";
        //        Commision:=ATMCharge.Commission;
        //        END;
        //      END;
        //
        //        IF (ATMTrans."Transaction Type Charges" = ATMTrans."Transaction Type Charges"::"Pos-cash Withdrawal")
        //        OR (AtmTrans1."Transaction Type Charges" = AtmTrans1."Transaction Type Charges"::"Pos-cash Withdrawal") THEN BEGIN
        //        //MESSAGE('sawa');
        // //Posting Charges++++++++++++++++
        //         IF ATMTrans.Reversed= FALSE THEN BEGIN
        //          Pos.RESET;
        //          Pos.SETFILTER(Pos."Lower Limit",'<=%1',ATMTrans.Amount);
        //          Pos.SETFILTER(Pos."Upper Limit",'>=%1',ATMTrans.Amount);
        //          IF Pos.FINDFIRST THEN BEGIN
        //            ATMCharges:=Pos."Charge Amount" + (0.1 * Pos."Charge Amount");
        //            BankCharges:=0;
        //            POSCommission := 0;
        //            Commision:=Pos."Charge Amount" + (0.1 * Pos."Charge Amount");
        //            //MESSAGE(FORMAT(ATMCharges));
        //            //MESSAGE(FORMAT(Commision));
        //          END;
        //          END ELSE BEGIN
        // //Reversal Charges+++++++++++++
        //          Pos.RESET;
        //          Pos.SETFILTER(Pos."Lower Limit",'<=%1',ATMTrans.Amount*-1) ;
        //          Pos.SETFILTER(Pos."Upper Limit",'>=%1',ATMTrans.Amount*-1) ;
        //          IF Pos.FINDFIRST THEN BEGIN
        //            ATMCharges:=-Pos."Charge Amount" - (0.1 * Pos."Charge Amount");
        //            BankCharges:=0;
        //            POSCommission := 0;
        //            Commision:=-(Pos."Sacco charge") - (0.1 * Pos."Charge Amount") - (Pos."Bank charge");
        //
        //          END;
        //          END;//Rvs.
        //        END;
        //
        //        IF ATMCharge.Source=ATMCharge.Source::ATM THEN BEGIN
        //          GLAcc:='302105'; //'300-000-310' atm - commissions
        //          BankAcc:='BNK0000013'; // - atm settlement account
        //          BankChargecode:='BNK0000013';
        //        END ELSE BEGIN
        //          GLAcc:='302105';  //'13207' pos - commissions
        //          BankAcc:='BNK0000013';  // - atm settlement account
        //          BankChargecode:='BNK0000013';
        //        END;
        //      //END;
        //      IF Acct.GET(ATMTrans."Account No") THEN BEGIN
        //        LineNo:=LineNo+10000;
        //         IF ATMTrans.Reversed=TRUE THEN
        //              TransDescription:='-Reversal'
        //            ELSE
        //             TransDescription:='';
        //
        //  IF (ATMTrans."Transaction Type Charges" = ATMTrans."Transaction Type Charges"::"Pos-balance Enquiry") OR
        //      (ATMTrans."Transaction Type Charges" = ATMTrans."Transaction Type Charges"::"Pos Normal Purchase") OR
        //      (ATMTrans."Transaction Type Charges" = ATMTrans."Transaction Type Charges"::"Pos-mini Statement") OR
        //       (ATMTrans."Transaction Type Charges" = ATMTrans."Transaction Type Charges"::"Utility Payment") THEN BEGIN
        //       IF ATMCharge.GET(ATMTrans."Transaction Type Charges") THEN BEGIN
        //        ATMCharges:=ATMCharge."Total Amount";
        //        BankCharges:=0;
        //        Commision:=ATMCharge."Total Amount";
        //        END;
        //      END;
        //        IF ATMTrans.Amount<> 0 THEN
        //           POSTJOURNAL.PostJournal(JTemplate,JBatch,LineNo,OptionsAccounts::Savings,DocNo,PADSTR(ATMTrans.Description,50), ATMTrans.Amount
        //          ,ATMTrans."Account No",TODAY,OptionsAccounts::"G/L Account",'',PADSTR(ATMTrans."Account No",50),savingAcct."Global Dimension 1 Code",savingAcct."Global Dimension 2 Code",0,'','','',0,'',0);
        //          //MESSAGE('1');
        //        LineNo:=LineNo+10000;
        //
        //        IF ATMTrans.Amount<> 0 THEN
        //            POSTJOURNAL.PostJournal(JTemplate,JBatch,LineNo,OptionsAccounts::"Bank Account",DocNo,PADSTR(Acct.Name,50), ATMTrans.Amount*-1
        //           ,BankAcc,TODAY,OptionsAccounts::"G/L Account",'',PADSTR(ATMTrans."Account No",50),savingAcct."Global Dimension 1 Code",savingAcct."Global Dimension 2 Code",0,'','','',0,'',0);
        //
        //        LineNo:=LineNo+10000;
        //        IF ATMCharges<> 0 THEN
        //            POSTJOURNAL.PostJournal(JTemplate,JBatch,LineNo,OptionsAccounts::Savings,DocNo,PADSTR(ATMTrans.Description + ' Charge ' + TransDescription,50), ATMCharges
        //           ,ATMTrans."Account No",TODAY,OptionsAccounts::"G/L Account",'',PADSTR(ATMTrans."Account No",50),savingAcct."Global Dimension 1 Code",savingAcct."Global Dimension 2 Code",0,'','','',0,'',0);
        //        LineNo:=LineNo+10000;
        // IF Commision <> 0 THEN
        // POSTJOURNAL.PostJournal(JTemplate,JBatch,LineNo,OptionsAccounts::"Bank Account",DocNo,PADSTR(ATMTrans.Description + ' Bank Commission ' + TransDescription,50), -1*Commision
        //    ,BankChargecode,TODAY,OptionsAccounts::"G/L Account",'',PADSTR(ATMTrans."Account No",50),savingAcct."Global Dimension 1 Code",savingAcct."Global Dimension 2 Code",0,'','','',0,'',0);
        //        LineNo:=LineNo+10000;
        //
        // IF BankCharges <> 0 THEN
        // POSTJOURNAL.PostJournal(JTemplate,JBatch,LineNo,OptionsAccounts::"G/L Account",DocNo,PADSTR(ATMTrans.Description + ' Charge ' + TransDescription,50),-1*(BankCharges)
        //    ,GLAcc,TODAY,OptionsAccounts::"G/L Account",'',PADSTR(ATMTrans."Account No",50), savingAcct."Global Dimension 1 Code",savingAcct."Global Dimension 2 Code",0,'','','',0,'',0);
        //
        //        LineNo:=LineNo+10000;
        //
        //          IF (ATMTrans."Transaction Type Charges" = ATMTrans."Transaction Type Charges"::"Pos Normal Purchase")
        //          OR (AtmTrans1."Transaction Type Charges" = AtmTrans1."Transaction Type Charges"::"Pos Normal Purchase") THEN BEGIN
        //          ExciseDuty:=0;
        //          END ELSE
        //          IF (ATMTrans."Transaction Type Charges" = ATMTrans."Transaction Type Charges"::"Pos-cash Withdrawal")
        //          OR (AtmTrans1."Transaction Type Charges" = AtmTrans1."Transaction Type Charges"::"Pos-cash Withdrawal") THEN BEGIN
        //          ExciseDuty:=0;
        //            END ELSE BEGIN
        //          ExciseDuty:=-0.1*(BankCharges);
        //         END;
        //         IF ATMTrans.Reversed=TRUE THEN
        //         TransDescription:='Excise Duty-Reversal'
        //         ELSE
        //         TransDescription:='Excise Duty';
        //
        //        IF ExciseDuty <> 0 THEN
        // POSTJOURNAL.PostJournal(JTemplate,JBatch,LineNo,OptionsAccounts::"G/L Account",DocNo,TransDescription,ExciseDuty
        //    ,GenSetup."Excise Duty G/L",TODAY,OptionsAccounts::"G/L Account",'',ATMTrans."Account No",savingAcct."Global Dimension 1 Code",savingAcct."Global Dimension 2 Code",0,'','','',0,'',0);
        //
        //        // -- send SMS alert -- //
        //        PhoneNo:='';
        //        IF Acct."Phone No."<>'' THEN  BEGIN
        //          PhoneNo:=Acct."Phone No.";
        //        END ELSE IF Acct."Mobile Phone No" <> '' THEN BEGIN
        //         PhoneNo:=Acct."Mobile Phone No";
        //        END;
        //     //POSTJOURNAL.LinesCompletePosting(JTemplate,JBatch);
        //     //ERROR('%1 ans pp %2',JBatch,JTemplate);
        //
        //    POSTJOURNAL.CompletePosting(JTemplate,JBatch);
        //    ATMTrans.Posted:=TRUE;
        //    ATMTrans.MODIFY;
        //    COMMIT;
        //
        //    IF ATMTrans.Reversed=TRUE THEN
        //    Location:=DELCHR(AtmTrans1."Withdrawal Location",'=',' ')
        //    ELSE
        //    Location:=DELCHR(ATMTrans."Withdrawal Location",'=',' ');
        //
        // IF(ATMTrans."Transaction Type Charges" = ATMTrans."Transaction Type Charges"::"Pos-balance Enquiry")  THEN BEGIN
        //    Sendsms.SendSms(OptionSMS::MSACCO,Acct."Mobile Phone No"
        //    ,'Dear Member, you have done a Balance Enquiry from ATM terminal '+Location+
        //    ' on ' +  FORMAT(ATMTrans."Posting Date")+ '.HARAMBEE SACCO.','', Acct."No.",
        // FALSE);
        // END ELSE BEGIN
        //   IF(ATMTrans."Transaction Type Charges" = ATMTrans."Transaction Type Charges"::"POS - Cash Deposit") OR
        //      (ATMTrans."Transaction Type Charges" = ATMTrans."Transaction Type Charges"::"POS - Cash Deposit to Card") OR
        //      (ATMTrans."Transaction Type Charges" = ATMTrans."Transaction Type Charges"::Reversal) THEN BEGIN
        //      SMSAmount:=ATMTrans.Amount* -1
        //      END ELSE BEGIN
        //      SMSAmount:=ATMTrans.Amount;
        //      END;
        //   IF (ATMTrans.Reversed=TRUE) THEN
        //  Sendsms.SendSms(OptionSMS::MSACCO,Acct."Mobile Phone No",'Dear Member, your withdrawal of ksh ' + FORMAT(SMSAmount)+ ' from ATM terminal '+Location+' on ' +  FORMAT(ATMTrans."Posting Date")+ ' has been reversed.HARAMBEE SACCO.',
        //  '', Acct."No.",FALSE)
        //   ELSE
        //  Sendsms.SendSms(OptionSMS::MSACCO,Acct."Mobile Phone No",'Dear Member, you have done a ' + ATMTrans.Description  +' of ksh ' + FORMAT(SMSAmount)+ ' from ATM terminal '+Location+' on ' +  FORMAT(ATMTrans."Posting Date")+ '.HARAMBEE SACCO.',
        //  '', Acct."No.",FALSE);
        //   END
        //   END
        //      ELSE
        //       BEGIN
        //        ERROR('%1','Account No. %1 not found.',ATMTrans."Account No");
        //      END;
        //
        //    i:=i+1;
        //     IF i >= 2510 THEN EXIT;
        //    Counts:=Counts+1;
        //    END;
        //    UNTIL ATMTrans.NEXT = 0;
        //  END;
    end;
}
