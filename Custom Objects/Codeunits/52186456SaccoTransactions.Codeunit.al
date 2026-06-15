#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52186456 "Sacco Transactions"
{

    trigger OnRun()
    begin
        ClearCheques;
        ClearOverDraft;
        ClearLien;
    end;

    var
        Temp: Record "Banking User Template";
        Jtemplate: Code[10];
        JBatch: Code[10];
        LineNo: Integer;
        EntrNo: Integer;
        BalAccountType: Enum "Gen. Journal Account Type";
        GenJLine: Record "Gen. Journal Line";
        Post: Boolean;
        JournlPosted: Codeunit "Journal Post Successful";
        GenSetup: Record "General Set-Up";
        STORegister: Record "Standing Order Register";
        SendSMS: Codeunit SendSms;
        Source: Enum "SMS Source";
        SavingsACC: Record "Savings Accounts";
        MobileNo: Code[20];
        AccTypes: Enum "Gen. Journal Account Type";
        AccNo: Code[20];
        ErrPosted: label 'This document has not been approved';
        MsgOnConfirmDialog: label 'Are you want to Post this Application?';
        AccountTypes: Record "Product Factory";
        // SMTPMail: Codeunit 400;
        // SMTPSetup: Record "SMTP Mail Setup";
        Loans: Record Loans;
        Memb: Record Members;
        CTransLines: Record "Cashier Transaction Lines";
        ProductFactory: Record "Product Factory";
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        ProductType: Record "Product Factory";
        CompanyInformation: Record "Company Information";
        VendorAmount: Decimal;
        Posted: Boolean;
        // SkyMbanking: Codeunit "Sky Mbanking";
        msg: Text;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        Pfact: Record "Product Factory";
        JournalPosting: Codeunit "Journal Posting";
        AcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Types";
        BalAccType: Enum "Gen. Journal Account Type";
        BalAccNo: Code[20];
        Amt: Decimal;
        LoansProcess: Codeunit "Loans Process";

    local procedure "*********Cashier Transactions********"()
    begin
    end;


    procedure InitPost(CashierTrans: Record "Cashier Transactions")
    var
        Temp: Record "Banking User Template";
        Jtemplate: Code[30];
        JBatch: Code[30];
        UserSetup: Record "User Setup";
        DBranch: Code[20];
        DActivity: Code[20];
        BankLedg: Record "Bank Account Ledger Entry";
        Tillno: Code[20];
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        Text0003: label 'Ensure the Default Bank is set up in User Setup';
        Text0004: label 'The transaction has already been posted.';
        Text0005: label 'Cannot post a Transaction being processed by %1';
        Text0006: label 'Please specify the Account No';
        Text0007: label 'Please specify an amount greater than zero.';
        Text0008: label 'Please select the transaction type.';
        CmemberNo: Code[20];
        Text0009: label 'Ensure the Cashier Member No is set up in Banking User Setup';
        Text0010: label 'You are not authorised to transact your own account';
        Text0011: label 'Ensure the Cashier Shortage Account is set up in Banking User Setup';
        Text0012: label 'Ensure the Cashier Excess Account is set up in Banking User Setup';
        Excess: Code[20];
        Shortage: Code[20];
        Text0013: label 'The Transaction date must be today, please reset to proceed';
    begin
        Jtemplate := '';
        JBatch := '';
        Tillno := '';
        CmemberNo := '';
        Excess := '';
        Shortage := '';

        if CashierTrans.Posted = true then
            Error(Text0004);

        BankLedg.Reset();
        BankLedg.SetRange("Document No.", CashierTrans.No);
        if not BankLedg.Find('-') then begin


            if CashierTrans."Transaction Date" <> Today then
                Error(Text0013);
            if CashierTrans.Type <> CashierTrans.Type::Lien then begin
                Temp.Get(CashierTrans.Cashier);
                Jtemplate := Temp."Cashier Journal Template";
                JBatch := Temp."Cashier Journal Batch";
                Tillno := Temp."Default  Bank";
                CmemberNo := Temp."Member No.";
                Excess := Temp."Excess Account";
                Shortage := Temp."Shortage Account";

                if Jtemplate = '' then begin
                    Error(Text0001);
                end;

                if JBatch = '' then begin
                    Error(Text0002);
                end;

                if Tillno = '' then begin
                    Error(Text0003);
                end;

                if CmemberNo = '' then begin
                    Error(Text0009);
                end;

                if Shortage = '' then begin
                    Error(Text0011);
                end;

                if Excess = '' then begin
                    Error(Text0012);
                end;


                CheckTillCurrency(Tillno, CashierTrans."Currency Code");
            end;

            if CmemberNo = CashierTrans."Member No." then begin

                CashierTrans."Attempted Self Transaction" := true;

                CashierTrans.Modify;

                Error(Text0010);

                exit;
            end;

            if CashierTrans.Cashier <> UpperCase(UserId) then
                Error(Text0005, CashierTrans.Cashier);

            UserSetup.Reset;
            UserSetup.SetRange(UserSetup."User ID", UpperCase(UserId));
            if UserSetup.Find('-') then begin
                UserSetup.TestField(UserSetup."Global Dimension 2 Code");
                UserSetup.TestField(UserSetup."Global Dimension 1 Code");
                DBranch := UserSetup."Global Dimension 2 Code";
                DActivity := UserSetup."Global Dimension 1 Code";
            end;


            if CashierTrans."Account No" = '' then
                Error(Text0006);

            if CashierTrans.Amount <= 0 then
                Error(Text0007);

            if CashierTrans."Transaction Type" = '' then
                Error(Text0008);

            CashierTrans.CalcFields("Allocated Amount");

            if CashierTrans.Type = CashierTrans.Type::"Credit Cheque" then begin

                CashierTrans.TestField("Member No.");
                CashierTrans.TestField("Cheque Type");
                CashierTrans.TestField("Cheque No");
                CashierTrans.TestField("Cheque Date");

                if (CashierTrans.Amount < CashierTrans."Allocated Amount") or (CashierTrans."Allocated Amount" = 0) then
                    Error('Amount Allocated must be less than the amount');
                PostChequeDep(CashierTrans, Jtemplate, JBatch, DBranch, DActivity);
            end;

            if CashierTrans.Type = CashierTrans.Type::"Credit Receipt" then begin
                CashierTrans.TestField("Member No.");

                if CashierTrans.Amount <> CashierTrans."Allocated Amount" then
                    Error('Allocated amount must be equall to the transaction amount.');
            end;


            if CashierTrans.Type = CashierTrans.Type::"Cheque Deposit" then begin
                CashierTrans.TestField("Cheque Type");
                CashierTrans.TestField("Cheque No");
                CashierTrans.TestField("Cheque Date");

                PostChequeDep(CashierTrans, Jtemplate, JBatch, DBranch, DActivity);

                exit;
            end;

            if CashierTrans.Type = CashierTrans.Type::"Bankers Cheque" then begin

                CashierTrans.TestField("Bankers Cheque No");
                CashierTrans.TestField(Payee);
                CashierTrans.testfield(Amount);
                PostBankersCheq(CashierTrans, Jtemplate, JBatch, DBranch, DActivity);

                exit;
            end;

            if CashierTrans.Type = CashierTrans.Type::"Cancel Bankers Cheque" then begin

                CashierTrans.TestField("Bankers Cheque No");
                StopBankers(CashierTrans, Jtemplate, JBatch, DBranch, DActivity);

                exit;
            end;

            //prevent withdrawal from dormant
            if CashierTrans.Type = CashierTrans.Type::"Cash Withdrawal" then begin
                if SavingsACC.Get(CashierTrans."Account No") then begin
                    IF (SavingsACC.GetAvailableBalance(CashierTrans."Account No") - CashierTrans.Amount) < 0 then
                        Error('The available balance of %1 is inadequate for withdrawal of KES %2.', (SavingsACC.GetAvailableBalance(CashierTrans."Account No")), (CashierTrans.Amount));
                    if SavingsACC.Status = SavingsACC.Status::Dormant then
                        Error('You cannot withdraw from a dormant account');
                end;
            end;
            //prevent withdrawal from dormant

            if (CashierTrans.Type = CashierTrans.Type::"Cash Deposit") or (CashierTrans.Type = CashierTrans.Type::"Cash Withdrawal") or (CashierTrans.Type = CashierTrans.Type::"Credit Receipt") or (CashierTrans.Type = CashierTrans.Type::"MPESA Deposit") or (CashierTrans.Type = CashierTrans.Type::"MPESA Withdrawal") then begin

                PostCashDepWith(CashierTrans, Jtemplate, JBatch, Tillno, DBranch, DActivity);


                exit;
            end;


            if (CashierTrans.Type = CashierTrans.Type::Lien) then begin

                PostLien(CashierTrans);
                exit;
            end;

        end else begin
            CashierTrans.Posted := true;
            CashierTrans.Modify();
        end;
    end;

    local procedure PostCashDepWith(CashierTrans: Record "Cashier Transactions"; JTemplate: Code[20]; JBatch: Code[20]; TillNo: Code[20]; DBranch: Code[20]; DActivity: Code[20])
    var
        GenSetup: Record "General Set-Up";
        Acc: Record "Savings Accounts";
        BankSetup: Record "Banking User Template";
        BankAccount: Record "Bank Account";
        CurrentTellerAmount: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        TCharges: Decimal;
        SMSCharges: Decimal;
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        SMSChargeAmt: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        TChargeAmount: Decimal;
        Account: Record "Savings Accounts";
        AccountTypes: Record "Product Factory";
        Text0001: label 'This account has been blocked from receiving payments.';
        Text0002: label 'You need to add more money from the treasury since your balance has gone below the teller replenishing level.';
        Text0003: label 'You do not have enough money to carry out this transaction.';
        Text0004: label 'You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.';
        Text0005: label 'You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.';
        Text0006: label 'You cannot withdraw more than your allowed limit of %1 unless authorised.';
        Text0007: label 'You cannot withdraw more than the available balance unless authorised.';
        Text0008: label 'You cannot deposit more than your allowed limit of %1 unless authorised.';
        VarVariant: Variant;
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        Trans: Record "Cashier Transactions";
        ProdType: Record "Product Factory";
        TransType: Record "Transaction Types";
        Text0009: label 'You have done a transaction of KSHS. ';
        Text0010: label ' of type ';
        Text0011: label ' on ';
        Text0012: label ' on your account ';
        Text0013: label ' at ';
        Text0014: label 'The limit for cashier ';
        Text0015: label ' of till ';
        Text0016: label ' has gone below the replenishing levels of ';
        Text0017: label ' has gone above the replenishing levels of ';
        Text0018: label 'Transaction Aborted';
        Employer: Record Customer;
    begin

        //with CashierTrans do
        begin
            if CashierTrans."Account Type" = CashierTrans."account type"::Account then begin
                GenSetup.Get;
                // SMTPSetup.Get;

                // if CashierTrans.Type = CashierTrans.Type::"Cash Deposit" then begin
                //     Acc.Reset;
                //     Acc.SetRange(Acc."Product Category", Acc."product category"::"Entrance Fee");
                //     Acc.SetRange(Acc."Member No.", CashierTrans."Member No.");
                //     if Acc.Find('-') then begin
                //         Acc.CalcFields(Acc."Balance (LCY)");
                //         ProdType.Reset;
                //         ProdType.SetRange(ProdType."Product Category", ProdType."product category"::"Entrance Fee");
                //         if ProdType.Find('-') then begin
                //             if Acc."Balance (LCY)" < ProdType."Minimum Balance" then
                //                 Message('Kindly Note that the Member has not settled the registration fee');
                //         end;
                //     end;// ELSE
                //         //ERROR('Member does not have a registration fee account please create one before proceeding');

                //     if CashierTrans."Product Category" = CashierTrans."product category"::"Entrance Fee" then begin
                //         Acc.Reset;
                //         Acc.SetRange(Acc."Product Category", Acc."product category"::"Entrance Fee");
                //         Acc.SetRange(Acc."Member No.", CashierTrans."Member No.");
                //         if Acc.Find('-') then begin
                //             Acc.CalcFields(Acc."Balance (LCY)");
                //             ProdType.Reset;
                //             ProdType.SetRange(ProdType."Product Category", ProdType."product category"::"Entrance Fee");
                //             if ProdType.Find('-') then begin
                //                 if Acc."Balance (LCY)" > (ProdType."Minimum Balance" + CashierTrans.Amount) then
                //                     Error('Kindly Note that this will lead to an overpayment in registration fee for this member');
                //             end;
                //         end;
                //     end;


                // end;





                if CashierTrans.Type = CashierTrans.Type::"Cash Withdrawal" then begin
                    if Acc.Get(CashierTrans."Account No") then begin
                        if Acc.Blocked = Acc.Blocked::Debit then
                            Error(Text0001);
                    end;


                    //if CashierTrans.Status <> CashierTrans.Status::Approved then begin
                    if Acc.Get(CashierTrans."Account No") then begin

                        if Acc.GetAvailableBalance(Acc."No.") < CashierTrans.Amount then begin
                            Error(Text0007);

                            Error(Text0018);


                            // if Confirm('Do you want to send this transaction for approval?', false) = true then begin
                            //     message('code for approval here')
                            //     // VarVariant := CashierTrans;
                            //     // if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            //     //     CustomApprovals.OnSendDocForApproval(VarVariant);
                            // end;
                            // exit;
                        END;
                    end;
                    //end;



                end;

                BankSetup.Get(UserId);

                BankAccount.Reset;
                BankAccount.SetRange(BankAccount."No.", TillNo);
                if BankAccount.Find('-') then begin
                    BankAccount.CalcFields(BankAccount.Balance);

                    CurrentTellerAmount := BankAccount.Balance;

                    if CurrentTellerAmount - CashierTrans.Amount <= BankSetup."Minimum Balance" then begin
                        if CashierTrans.Type = CashierTrans.Type::"Cash Withdrawal" then
                            // Message(Text0002);
                            Message(Text0002);
                        //send email

                        // SMTPSetup.TestField(SMTPSetup."Email Sender Name");
                        // SMTPSetup.TestField(SMTPSetup."Email Sender Address");
                        BankSetup.TestField(BankSetup."Supervisor E-Mail");

                        // SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address",/*'cyidah@coretec.co.ke'*/BankSetup."Supervisor E-Mail", 'NOTIFICATIONS', '', true);
                        // SMTPMail.AppendBody('************DO NOT REPLY*************');
                        // SMTPMail.AppendBody('<br><br>');
                        // SMTPMail.AppendBody('Dear Sir/Madam');
                        // SMTPMail.AppendBody('<br><br>');
                        // SMTPMail.AppendBody(Text0014 + UserId + Text0015 + BankSetup."Default  Bank" + Text0016 + Format(BankSetup."Min. Balance") + Text0011 + Format(Today) + ' ' + Format(Time));
                        // SMTPMail.AppendBody('<br><br>');
                        // SMTPMail.AppendBody('Thanks & Regards');
                        // SMTPMail.AppendBody('<br><br>');
                        // SMTPMail.AppendBody('*****************************.');
                        // SMTPMail.AppendBody('<br><br>');
                        // // SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
                        // SMTPMail.AppendBody('<br><br>');
                        // SMTPMail.AppendBody('<HR>');
                        // SMTPMail.AppendBody('This is a system generated mail.');
                        //SMTPMail.Send;
                        //send email

                        //Commented coz stima do not want sms
                        //SendSMS.SendSms(SourceType::"Cashier Below Limit",BankSetup."Supervisor Mobile No",Text0014 +USERID+Text0015+BankSetup."Default  Bank"+Text0016+
                        //        FORMAT(BankSetup."Min. Balance")+Text0011+FORMAT(TODAY)+' '+FORMAT(TIME) ,BankSetup."Default  Bank",BankSetup."Default  Bank",FALSE);
                    end;
                    /*
                    IF Type =Type::"Cash Withdrawal" THEN BEGIN
                    IF (CurrentTellerAmount - Amount) < BankSetup."Min. Balance" THEN
                    ERROR(Text0003);
                    SendSMS.SendSms(SourceType::"Cashier Below Limit",BankSetup."Supervisor Mobile No",Text0014 +USERID+Text0015+BankSetup."Default  Bank"+Text0016+
                              FORMAT(BankSetup."Min. Balance")+Text0011+FORMAT(TODAY)+' '+FORMAT(TIME) ,BankSetup."Default  Bank",BankSetup."Default  Bank",FALSE);
                    END;
                    */
                    if CashierTrans.Type = CashierTrans.Type::"Cash Withdrawal" then begin
                        if CurrentTellerAmount - CashierTrans.Amount >= BankSetup."Maximum Withholding" then begin
                            Message(Text0004);
                            // SMTPSetup.TestField(SMTPSetup."Email Sender Name");
                            // SMTPSetup.TestField(SMTPSetup."Email Sender Address");
                            BankSetup.TestField(BankSetup."Supervisor E-Mail");

                            // SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address",/*'cyidah@coretec.co.ke'*/BankSetup."Supervisor E-Mail", 'NOTIFICATIONS', '', true);
                            // SMTPMail.AppendBody('************DO NOT REPLY*************');
                            // SMTPMail.AppendBody('<br><br>');
                            // SMTPMail.AppendBody('Dear Sir/Madam');
                            // SMTPMail.AppendBody('<br><br>');
                            // SMTPMail.AppendBody(Text0014 + UserId + Text0015 + BankSetup."Default  Bank" + Text0017 + Format(BankSetup."Max. Cashier Withholding") + Text0011 + Format(Today) + ' ' + Format(Time));
                            // SMTPMail.AppendBody('<br><br>');
                            // SMTPMail.AppendBody('Thanks & Regards');
                            // SMTPMail.AppendBody('<br><br>');
                            // SMTPMail.AppendBody('*****************************.');
                            // SMTPMail.AppendBody('<br><br>');
                            // // SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
                            // SMTPMail.AppendBody('<br><br>');
                            // SMTPMail.AppendBody('<HR>');
                            // SMTPMail.AppendBody('This is a system generated mail.');
                            // SMTPMail.Send;
                        end;
                        //SendSMS.SendSms(SourceType::"Cashier Above Limit",BankSetup."Supervisor Mobile No",Text0014 +USERID+Text0015+BankSetup."Default  Bank"+Text0017+
                        //        FORMAT(BankSetup."Max. Cashier Withholding")+Text0011+FORMAT(TODAY)+' '+FORMAT(TIME) ,BankSetup."Default  Bank",BankSetup."Default  Bank",FALSE);
                    end else begin
                        if CurrentTellerAmount + CashierTrans.Amount >= BankSetup."Maximum Withholding" then begin
                            Message(Text0005);

                            // SMTPSetup.TestField(SMTPSetup."Email Sender Name");
                            // SMTPSetup.TestField(SMTPSetup."Email Sender Address");
                            BankSetup.TestField(BankSetup."Supervisor E-Mail");

                            // SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address",/*'cyidah@coretec.co.ke'*/BankSetup."Supervisor E-Mail", 'NOTIFICATIONS', '', true);
                            // SMTPMail.AppendBody('************DO NOT REPLY*************');
                            // SMTPMail.AppendBody('<br><br>');
                            // SMTPMail.AppendBody('Dear Sir/Madam');
                            // SMTPMail.AppendBody('<br><br>');
                            // SMTPMail.AppendBody(Text0014 + UserId + Text0015 + BankSetup."Default  Bank" + Text0017 + Format(BankSetup."Max. Cashier Withholding") + Text0011 + Format(Today) + ' ' + Format(Time));
                            // SMTPMail.AppendBody('<br><br>');
                            // SMTPMail.AppendBody('Thanks & Regards');
                            // SMTPMail.AppendBody('<br><br>');
                            // SMTPMail.AppendBody('*****************************.');
                            // SMTPMail.AppendBody('<br><br>');
                            // // SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
                            // SMTPMail.AppendBody('<br><br>');
                            // SMTPMail.AppendBody('<HR>');
                            // SMTPMail.AppendBody('This is a system generated mail.');
                            //SMTPMail.Send;
                            //SendSMS.SendSms(SourceType::"Cashier Above Limit",BankSetup."Supervisor Mobile No",Text0014 +USERID+Text0015+BankSetup."Default  Bank"+Text0017+
                            //      FORMAT(BankSetup."Max. Cashier Withholding")+Text0011+FORMAT(TODAY)+' '+FORMAT(TIME) ,BankSetup."Default  Bank",BankSetup."Default  Bank",FALSE);
                        end;
                    end;


                    if CashierTrans.Type = CashierTrans.Type::"Cash Withdrawal" then begin
                        if CashierTrans.Status <> CashierTrans.Status::Approved then begin
                            if CashierTrans.Amount > BankSetup."Max. Withdrawal Limit" then begin
                                Error(Text0006, BankSetup."Max. Withdrawal Limit");


                                // if Confirm('Do you want to send this transaction for approval?', false) = true then begin
                                //     VarVariant := CashierTrans;
                                //     if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                                //         CustomApprovals.OnSendDocForApproval(VarVariant);
                                // end;
                                // exit;
                            end;
                        end;
                    end;





                end;

                if CashierTrans.Type = CashierTrans.Type::"Cash Deposit" then begin

                    if CashierTrans.Amount > BankSetup."Max. Deposit Limit" then begin
                        Message(Text0008, BankSetup."Max. Deposit Limit");

                        // if Confirm('Do you want to send this transaction for approval?', false) = true then begin
                        //     VarVariant := CashierTrans;
                        //     if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        //         CustomApprovals.OnSendDocForApproval(VarVariant);
                        // end;
                        // exit;
                    end;
                end;


                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", JTemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                GenJournalLine.DeleteAll;

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := JTemplate;
                GenJournalLine."Journal Batch Name" := JBatch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := CashierTrans.No;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                GenJournalLine."Account No." := CashierTrans."Account No";
                GenJournalLine."External Document No." := CashierTrans."ID No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                GenJournalLine.Description := PadStr(Format(CashierTrans.Type) + '-' + CashierTrans.Remarks, 50);
                GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                if (CashierTrans.Type = CashierTrans.Type::"Cash Deposit") then
                    GenJournalLine.Amount := -(CashierTrans.Amount)
                else
                    GenJournalLine.Amount := CashierTrans.Amount;
                if (CashierTrans.Type = CashierTrans.Type::"Credit Receipt") then
                    GenJournalLine.Amount := 0;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                GenJournalLine."Bal. Account No." := TillNo;
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;//(TRUE);


                //Charges
                TCharges := 0;

                TransactionCharges.Reset;
                TransactionCharges.SetRange(TransactionCharges."Transaction Type", CashierTrans."Transaction Type");
                if TransactionCharges.FindSet then begin
                    repeat

                        if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) or
                        (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::"Stamp Duty") then begin

                            LineNo := LineNo + 10000;

                            ChargeAmount := 0;
                            if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                                ChargeAmount := (CashierTrans.Amount * TransactionCharges."Percentage of Amount") * 0.01
                            else
                                ChargeAmount := TransactionCharges."Charge Amount";

                            if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin

                                TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                                TariffDetails.Reset;
                                TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                if TariffDetails.FindSet then begin
                                    repeat
                                        if (CashierTrans.Amount >= TariffDetails."Lower Limit") and (CashierTrans.Amount <= TariffDetails."Upper Limit") then begin
                                            if TariffDetails."Use Percentage" = true then begin
                                                ChargeAmount := CashierTrans.Amount * TariffDetails.Percentage * 0.01;
                                            end else begin
                                                ChargeAmount := TariffDetails."Charge Amount";
                                            end;
                                        end;
                                    until TariffDetails.Next = 0;
                                end;
                            end;




                            //Dont charge Transactional Charges
                            if SavingsACC.Get(CashierTrans."Account No") then begin
                                if Employer.Get(SavingsACC."Employer Code") then begin
                                    if Employer."Dont Charge Transactions" then
                                        ChargeAmount := 0;
                                end;
                            end;
                            //Dont charge Transactional Charges

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := JTemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Document No." := CashierTrans.No;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                            GenJournalLine."Account No." := CashierTrans."Account No";
                            GenJournalLine."External Document No." := CashierTrans."ID No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                            GenJournalLine.Description := TransactionCharges.Description;
                            GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := ChargeAmount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;


                            //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                            if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                              (TransactionCharges."Recover Excise Duty" = true) then begin


                                //Excise Duty

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := JTemplate;
                                GenJournalLine."Journal Batch Name" := JBatch;
                                GenJournalLine."Document No." := CashierTrans.No;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                GenJournalLine."Account No." := CashierTrans."Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                                GenJournalLine.Description := 'Excise Duty';
                                GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := GenSetup."Excise Duty G/L";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                TChargeAmount := TChargeAmount + ChargeAmount;
                            end;
                        end;
                    until TransactionCharges.Next = 0;
                end;



                //Charge withdrawal Frequency
                if CashierTrans.Type = CashierTrans.Type::"Cash Withdrawal" then begin
                    if Account.Get(CashierTrans."Account No") then begin
                        if AccountTypes.Get(Account."Product Type") then begin
                            if Account."Last Withdrawal Date" = 0D then begin
                                Account."Last Withdrawal Date" := Today;
                                Account.Modify;
                            end else begin
                                if CalcDate(AccountTypes."Withdrawal Interval", Account."Last Withdrawal Date") > Today then begin
                                    //IF CALCDATE(AccountTypes."Withdrawal Interval",Account."Last Withdrawal Date") <= CALCDATE('1D',TODAY) THEN BEGIN


                                    //Charges
                                    TCharges := 0;

                                    TransactionCharges.Reset;
                                    TransactionCharges.SetRange(TransactionCharges."Transaction Type", CashierTrans."Transaction Type");
                                    if TransactionCharges.FindSet() then begin
                                        repeat

                                            if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::"Withdrawal Frequency") then begin

                                                LineNo := LineNo + 10000;

                                                ChargeAmount := 0;
                                                if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                                                    ChargeAmount := (CashierTrans.Amount * TransactionCharges."Percentage of Amount") * 0.01
                                                else
                                                    ChargeAmount := TransactionCharges."Charge Amount";

                                                if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin

                                                    TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                                                    TariffDetails.Reset;
                                                    TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                                    if TariffDetails.FindSet() then begin
                                                        repeat
                                                            if (CashierTrans.Amount >= TariffDetails."Lower Limit") and (CashierTrans.Amount <= TariffDetails."Upper Limit") then begin
                                                                if TariffDetails."Use Percentage" = true then begin
                                                                    ChargeAmount := CashierTrans.Amount * TariffDetails.Percentage * 0.01;
                                                                end else begin
                                                                    ChargeAmount := TariffDetails."Charge Amount";
                                                                end;
                                                            end;
                                                        until TariffDetails.Next = 0;
                                                    end;
                                                end;


                                                //Dont charge Transactional Charges
                                                if SavingsACC.Get(CashierTrans."Account No") then begin
                                                    if Employer.Get(SavingsACC."Employer Code") then begin
                                                        if Employer."Dont Charge Transactions" then
                                                            ChargeAmount := 0;
                                                    end;
                                                end;
                                                //Dont charge Transactional Charges

                                                GenJournalLine.Init;
                                                GenJournalLine."Journal Template Name" := JTemplate;
                                                GenJournalLine."Journal Batch Name" := JBatch;
                                                GenJournalLine."Document No." := CashierTrans.No;
                                                GenJournalLine."Line No." := LineNo;
                                                GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                                GenJournalLine."Account No." := CashierTrans."Account No";
                                                GenJournalLine."External Document No." := CashierTrans."ID No";
                                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                                GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                                                GenJournalLine.Description := TransactionCharges.Description;
                                                GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                                GenJournalLine.Amount := ChargeAmount;
                                                GenJournalLine.Validate(GenJournalLine.Amount);
                                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                if GenJournalLine.Amount <> 0 then
                                                    GenJournalLine.Insert;


                                                //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                                                if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                                  (TransactionCharges."Recover Excise Duty" = true) then begin

                                                    //Excise Duty

                                                    LineNo := LineNo + 10000;

                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := JTemplate;
                                                    GenJournalLine."Journal Batch Name" := JBatch;
                                                    GenJournalLine."Document No." := CashierTrans.No;
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                                    GenJournalLine."Account No." := CashierTrans."Account No";
                                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                                    GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                                                    GenJournalLine.Description := 'Excise Duty';
                                                    GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                                    GenJournalLine.Amount := (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                    GenJournalLine."Bal. Account No." := GenSetup."Excise Duty G/L";
                                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;

                                                    TChargeAmount := TChargeAmount + ChargeAmount;
                                                end;
                                            end;
                                        until TransactionCharges.Next = 0;
                                    end;

                                end;
                                Account."Last Withdrawal Date" := Today;
                                Account.Modify;

                            end;
                        end;
                    end;
                end;
                //Charge withdrawal SMS
                SMSCharges := 0;
                GenSetup.get;
                TransactionCharges.Reset;
                TransactionCharges.SetRange(TransactionCharges."Transaction Type", GenSetup."Loan SMS Charge");
                if TransactionCharges.FindSet then begin
                    repeat
                        if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) or
                        (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::"Stamp Duty") then begin

                            LineNo := LineNo + 10000;

                            SMSChargeAmt := 0;
                            if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                                SMSChargeAmt := (CashierTrans.Amount * TransactionCharges."Percentage of Amount") * 0.01
                            else
                                SMSChargeAmt := TransactionCharges."Charge Amount";

                            if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin

                                TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                                TariffDetails.Reset;
                                TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                if TariffDetails.FindSet then begin
                                    repeat
                                        if (CashierTrans.Amount >= TariffDetails."Lower Limit") and (CashierTrans.Amount <= TariffDetails."Upper Limit") then begin
                                            if TariffDetails."Use Percentage" = true then begin
                                                SMSChargeAmt := CashierTrans.Amount * TariffDetails.Percentage * 0.01;
                                            end else begin
                                                SMSChargeAmt := TariffDetails."Charge Amount";
                                            end;
                                        end;
                                    until TariffDetails.Next = 0;
                                end;
                            end;

                            //Dont charge Transactional Charges
                            // if SavingsACC.Get(CashierTrans."Account No") then begin
                            //     if Employer.Get(SavingsACC."Employer Code") then begin
                            //         if Employer."Dont Charge Transactions" then
                            //             ChargeAmount := 0;
                            //     end;
                            // end;
                            //Dont charge Transactional Charges

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := JTemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Document No." := CashierTrans.No;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                            GenJournalLine."Account No." := CashierTrans."Account No";
                            GenJournalLine."External Document No." := CashierTrans."ID No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                            GenJournalLine.Description := TransactionCharges.Description;
                            GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := SMSChargeAmt;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;


                            //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                            if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                              (TransactionCharges."Recover Excise Duty" = true) then begin
                                //Excise Duty
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := JTemplate;
                                GenJournalLine."Journal Batch Name" := JBatch;
                                GenJournalLine."Document No." := CashierTrans.No;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                GenJournalLine."Account No." := CashierTrans."Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                                GenJournalLine.Description := TransactionCharges.Description + ' excise duty.';
                                GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := (SMSChargeAmt * GenSetup."Excise Duty (%)") * 0.01;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := GenSetup."Excise Duty G/L";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                            end;
                        end;
                    until TransactionCharges.Next = 0;
                end;



                //Penalty of maximum amount on transaction
                if CashierTrans.Type = CashierTrans.Type::"Cash Withdrawal" then begin
                    if TransType.Get(CashierTrans."Transaction Type") then begin

                        Trans.Reset;
                        Trans.SetRange(Trans."Transaction Date", Today);
                        Trans.SetRange(Trans."Account No", CashierTrans."Account No");
                        Trans.SetRange(Posted, true);
                        Trans.SetRange(Trans.Type, Trans.Type::"Cash Withdrawal");
                        if Trans.FindSet then begin
                            Trans.CalcSums(Trans.Amount);


                        end;
                    end;

                    if Trans.Amount > TransType."Upper Limit" then begin


                        //Charges
                        TCharges := 0;

                        TransactionCharges.Reset;
                        TransactionCharges.SetRange(TransactionCharges."Transaction Type", CashierTrans."Transaction Type");
                        if TransactionCharges.FindSet() then begin
                            repeat

                                if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::"Withdrawn Amount") then begin

                                    LineNo := LineNo + 10000;

                                    ChargeAmount := 0;
                                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                                        ChargeAmount := (CashierTrans.Amount * TransactionCharges."Percentage of Amount") * 0.01
                                    else
                                        ChargeAmount := TransactionCharges."Charge Amount";

                                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin

                                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                                        TariffDetails.Reset;
                                        TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                        if TariffDetails.FindSet() then begin
                                            repeat
                                                if (CashierTrans.Amount >= TariffDetails."Lower Limit") and (CashierTrans.Amount <= TariffDetails."Upper Limit") then begin
                                                    if TariffDetails."Use Percentage" = true then begin
                                                        ChargeAmount := CashierTrans.Amount * TariffDetails.Percentage * 0.01;
                                                    end else begin
                                                        ChargeAmount := TariffDetails."Charge Amount";
                                                    end;
                                                end;
                                            until TariffDetails.Next = 0;
                                        end;
                                    end;


                                    //Dont charge Transactional Charges
                                    if SavingsACC.Get(CashierTrans."Account No") then begin
                                        if Employer.Get(SavingsACC."Employer Code") then begin
                                            if Employer."Dont Charge Transactions" then
                                                ChargeAmount := 0;
                                        end;
                                    end;
                                    //Dont charge Transactional Charges

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := JTemplate;
                                    GenJournalLine."Journal Batch Name" := JBatch;
                                    GenJournalLine."Document No." := CashierTrans.No;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                    GenJournalLine."Account No." := CashierTrans."Account No";
                                    GenJournalLine."External Document No." := CashierTrans."ID No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                                    GenJournalLine.Description := TransactionCharges.Description;
                                    GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := ChargeAmount;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;


                                    //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                                    if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                      (TransactionCharges."Recover Excise Duty" = true) then begin

                                        //Excise Duty

                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := JTemplate;
                                        GenJournalLine."Journal Batch Name" := JBatch;
                                        GenJournalLine."Document No." := CashierTrans.No;
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                        GenJournalLine."Account No." := CashierTrans."Account No";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                                        GenJournalLine.Description := 'Excise Duty';
                                        GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        GenJournalLine.Amount := (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := GenSetup."Excise Duty G/L";
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        TChargeAmount := TChargeAmount + ChargeAmount;
                                    end;
                                end;
                            until TransactionCharges.Next = 0;
                        end;
                    end;
                end;


                //Penalty of maximum amount on transaction

                if SavingsACC.Get(CashierTrans."Account No") then begin
                    MobileNo := SavingsACC."Transactional Mobile No";
                    if MobileNo = '' then
                        if Memb.Get(SavingsACC."Member No.") then begin
                            MobileNo := Memb."Phone No.";
                        end;
                end;

                msg := 'Dear Member, ' + CashierTrans.Remarks + ' has done a transation of Ksh. ' + Format(CashierTrans.Amount) + Text0010 + Format(CashierTrans.Type) + Text0011 + Format(Today) + ' ' + Format(Time) + Text0012 + Text0013 + COMPANYNAME;

                if CashierTrans.Type = CashierTrans.Type::"Cash Withdrawal" then
                    SendSMS.SendSms(Source::CASH_WITHDRAWAL_CONFIRM, MobileNo, msg, Format(CashierTrans."Account No"), '', true, 0, false, 'CBS', CashierTrans."Account No", 'CBS')
                else
                    SendSMS.SendSms(Source::DEPOSIT_CONFIRMATION, MobileNo, msg, Format(CashierTrans."Account No"), '', true, 0, false, 'CBS', CashierTrans."Account No", 'CBS');






                if CashierTrans.Type = CashierTrans.Type::"Credit Receipt" then begin
                    PostCredit(CashierTrans, JTemplate, JBatch, TillNo, DBranch, DActivity);
                end;

                //Post New
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", JTemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                end;
                //Post New

                Post := false;
                Post := JournlPosted.PostedSuccessfully();
                // if Post then begin
                Posted := true;
                CashierTrans."Date Posted" := Today;
                CashierTrans."Time Posted" := Time;
                CashierTrans."Posted By" := UserId;
                CashierTrans.Modify;
                Commit;
                // end;

                //Advice Loan -------------Advice Savings Accounts
                if (CashierTrans.Type <> CashierTrans.Type::"Credit Cheque") then begin
                    CTransLines.Reset;
                    CTransLines.SetRange("Transaction No", CashierTrans.No);
                    if CTransLines.FindSet() then begin
                        repeat
                            if CTransLines."Transaction Type" = CTransLines."transaction type"::Repayment then begin
                                if Loans.Get(CTransLines."Loan No") then
                                    Loans.Validate(Repayment);
                            end;
                        // if SavingsACC.Get(CTransLines."Account No") then begin
                        //     if (SavingsACC."Product Category" = SavingsACC."Product Category"::"BOSA Deposits") or
                        //       (SavingsACC."Product Category" = SavingsACC."Product Category"::"Benevolent (BBF)") then
                        //         EmployerSavingAdvice(SavingsACC, CTransLines.Amount);
                        // end;
                        until CTransLines.Next = 0;
                    end;
                end;
            end
            else begin

                if Temp.Get(UserId) then begin

                end;



                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", JTemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                GenJournalLine.DeleteAll;

                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := JTemplate;
                GenJournalLine."Journal Batch Name" := JBatch;
                GenJournalLine."Document No." := CashierTrans.No;
                if (CashierTrans.Type = CashierTrans.Type::"MPESA Deposit") or (CashierTrans.Type = CashierTrans.Type::"MPESA Withdrawal") then
                    GenJournalLine."External Document No." := CashierTrans."Mpesa Reference" else
                    GenJournalLine."External Document No." := CashierTrans.No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                GenJournalLine."Account No." := CashierTrans."Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                GenJournalLine.Description := CopyStr(CashierTrans."Transaction Description" + '-' + CashierTrans."Account Name" + '-' + CashierTrans."Member No.", 1, 50);
                GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                if CashierTrans.Type = CashierTrans.Type::"MPESA Withdrawal" then
                    GenJournalLine.Amount := CashierTrans.Amount else
                    GenJournalLine.Amount := CashierTrans.Amount * -1;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                LineNo := LineNo + 10000;

                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := JTemplate;
                GenJournalLine."Journal Batch Name" := JBatch;
                GenJournalLine."Document No." := CashierTrans.No;
                if (CashierTrans.Type = CashierTrans.Type::"MPESA Deposit") or (CashierTrans.Type = CashierTrans.Type::"MPESA Withdrawal") then
                    GenJournalLine."External Document No." := CashierTrans."Mpesa Reference" else
                    GenJournalLine."External Document No." := CashierTrans.No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::"Bank Account";
                GenJournalLine."Account No." := TillNo;
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                GenJournalLine.Description := CashierTrans."Transaction Description" + '-' + CashierTrans.Remarks;
                GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                GenJournalLine.VALIDATE(GenJournalLine."Currency Code");

                if CashierTrans.Type = CashierTrans.Type::"MPESA Withdrawal" then
                    GenJournalLine.Amount := CashierTrans.Amount * -1 else
                    GenJournalLine.Amount := CashierTrans.Amount * 1;
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                IF GenJournalLine.Amount <> 0 THEN
                    GenJournalLine.INSERT;

                VendorAmount := 0;
                TransactionCharges.Reset;
                TransactionCharges.SetRange(TransactionCharges."Transaction Type", CashierTrans."Transaction Type");
                if TransactionCharges.FindSet() then begin
                    repeat
                        ChargeAmount := 0;
                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                            VendorAmount := (CashierTrans.Amount / (1 + TransactionCharges."Percentage of Amount" / 100));
                    until TransactionCharges.Next = 0;
                end;

                // LineNo := LineNo + 10000;
                // GenJournalLine.Init;
                // GenJournalLine."Journal Template Name" := JTemplate;
                // GenJournalLine."Journal Batch Name" := JBatch;
                // GenJournalLine."Document No." := CashierTrans.No;
                // GenJournalLine."External Document No." := CashierTrans.No;
                // GenJournalLine."Line No." := LineNo;
                // GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                // GenJournalLine."Account No." := CashierTrans."Project Vendor";
                // GenJournalLine.Validate(GenJournalLine."Account No.");
                // GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                // GenJournalLine.Description := CopyStr(CashierTrans."Transaction Description" + '-' + CashierTrans."Account Name" + '-' + CashierTrans."Member No.", 1, 50);
                // ;
                // GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                // GenJournalLine.Validate(GenJournalLine."Currency Code");
                // GenJournalLine.Amount := (VendorAmount) * -1;
                // GenJournalLine.Validate(GenJournalLine.Amount);
                // GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                // GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                // if GenJournalLine.Amount <> 0 then
                //     GenJournalLine.Insert;


                // TCharges := 0;
                // GenSetup.Get;

                // TransactionCharges.Reset;
                // TransactionCharges.SetRange(TransactionCharges."Transaction Type", CashierTrans."Transaction Type");
                // if TransactionCharges.FindSet() then begin
                //     repeat
                //         LineNo := LineNo + 10000;

                //         ChargeAmount := 0;
                //         if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                //             ChargeAmount := (VendorAmount * TransactionCharges."Percentage of Amount") * 0.01
                //         else
                //             ChargeAmount := TransactionCharges."Charge Amount";

                //         if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin

                //             TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                //             TariffDetails.Reset;
                //             TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                //             if TariffDetails.FindSet() then begin
                //                 repeat
                //                     if (CashierTrans.Amount >= TariffDetails."Lower Limit") and (CashierTrans.Amount <= TariffDetails."Upper Limit") then begin
                //                         if TariffDetails."Use Percentage" = true then begin
                //                             ChargeAmount := CashierTrans.Amount * TariffDetails.Percentage * 0.01;
                //                         end else begin
                //                             ChargeAmount := TariffDetails."Charge Amount";
                //                         end;
                //                     end;
                //                 until TariffDetails.Next = 0;
                //             end;
                //         end;

                //         LineNo := LineNo + 10000;

                //         GenJournalLine.Init;
                //         GenJournalLine."Journal Template Name" := JTemplate;
                //         GenJournalLine."Journal Batch Name" := JBatch;
                //         GenJournalLine."Document No." := CashierTrans.No;
                //         GenJournalLine."Line No." := LineNo;
                //         GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                //         GenJournalLine."Account No." := TransactionCharges."G/L Account";
                //         GenJournalLine."External Document No." := CopyStr(CashierTrans."ID No", 1, 20);
                //         GenJournalLine.Validate(GenJournalLine."Account No.");
                //         GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                //         GenJournalLine.Description := TransactionCharges.Description + '-' + CashierTrans."Member No.";
                //         GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                //         GenJournalLine.Validate(GenJournalLine."Currency Code");
                //         GenJournalLine.Amount := -ChargeAmount;
                //         GenJournalLine.Validate(GenJournalLine.Amount);
                //         GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                //         GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                //         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                //         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                //         if GenJournalLine.Amount <> 0 then
                //             GenJournalLine.Insert;

                //         TChargeAmount := TChargeAmount + Abs(GenJournalLine.Amount);

                //         if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                //           (TransactionCharges."Recover Excise Duty" = true) then begin

                //             LineNo := LineNo + 10000;
                //             GenJournalLine.Init;
                //             GenJournalLine."Journal Template Name" := JTemplate;
                //             GenJournalLine."Journal Batch Name" := JBatch;
                //             GenJournalLine."Document No." := CashierTrans.No;
                //             GenJournalLine."Line No." := LineNo;
                //             GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                //             GenJournalLine."Account No." := TransactionCharges."G/L Account";
                //             GenJournalLine.Validate(GenJournalLine."Account No.");
                //             GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                //             GenJournalLine.Description := CopyStr('Excise Duty' + CashierTrans."Account Name" + '-' + CashierTrans."Member No.", 1, 50);
                //             ;
                //             GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                //             GenJournalLine.Validate(GenJournalLine."Currency Code");
                //             GenJournalLine.Amount := Abs((ChargeAmount * GenSetup."Excise Duty (%)") * 0.01);
                //             GenJournalLine.Validate(GenJournalLine.Amount);
                //             GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                //             GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                //             GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                //             GenJournalLine."Bal. Account No." := GenSetup."Excise Duty G/L";
                //             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                //             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                //             if GenJournalLine.Amount <> 0 then
                //                 GenJournalLine.Insert;

                //             TChargeAmount := TChargeAmount + Abs(GenJournalLine.Amount);
                //         end;
                //     until TransactionCharges.Next = 0;
                // end;


                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", JTemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                end;


                Post := false;
                Post := JournlPosted.PostedSuccessfully();
                // if Post then begin
                Posted := true;
                CashierTrans."Date Posted" := Today;
                CashierTrans."Time Posted" := Time;
                CashierTrans."Posted By" := UserId;
                CashierTrans.Modify;
                // end;

            end;
        end;

    end;



    local procedure PostChequeDep(CashierTrans: Record "Cashier Transactions"; JTemplate: Code[20]; JBatch: Code[20]; DBranch: Code[20]; DActivity: Code[20])
    var
        GenSetup: Record "General Set-Up";
        Acc: Record "Savings Accounts";
        BankSetup: Record "Banking User Template";
        BankAccount: Record "Bank Account";
        CurrentTellerAmount: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        TCharges: Decimal;
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        TChargeAmount: Decimal;
        Account: Record "Savings Accounts";
        AccountTypes: Record "Product Factory";
        ChBank: Code[20];
        Trans: Record "Cashier Transactions";
    begin
        //with CashierTrans do
        begin

            GenSetup.Get;

            ChBank := CashierTrans."Bank Account";

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", JTemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            GenJournalLine.DeleteAll;

            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := JTemplate;
            GenJournalLine."Journal Batch Name" := JBatch;
            GenJournalLine."Document No." := CashierTrans.No;
            GenJournalLine."External Document No." := CashierTrans."Cheque No";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
            GenJournalLine."Account No." := CashierTrans."Account No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
            GenJournalLine.Description := PadStr(CashierTrans."Transaction Description" + '-' + CashierTrans.Remarks, 50);
            GenJournalLine."Currency Code" := CashierTrans."Currency Code";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := -(CashierTrans.Amount);
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := JTemplate;
            GenJournalLine."Journal Batch Name" := JBatch;
            GenJournalLine."Document No." := CashierTrans.No;
            GenJournalLine."External Document No." := CashierTrans."Cheque No";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
            GenJournalLine."Account No." := ChBank;
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
            GenJournalLine.Description := CashierTrans."Account Name";
            GenJournalLine."Currency Code" := CashierTrans."Currency Code";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := CashierTrans.Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            //Charges
            TCharges := 0;

            TransactionCharges.Reset;
            TransactionCharges.SetRange(TransactionCharges."Transaction Type", CashierTrans."Transaction Type");
            if TransactionCharges.FindSet() then begin
                repeat

                    if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) or
                    (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::"Stamp Duty") then begin

                        LineNo := LineNo + 10000;

                        ChargeAmount := 0;
                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                            ChargeAmount := (CashierTrans.Amount * TransactionCharges."Percentage of Amount") * 0.01
                        else
                            ChargeAmount := TransactionCharges."Charge Amount";

                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin

                            TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                            TariffDetails.Reset;
                            TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                            if TariffDetails.FindSet() then begin
                                repeat
                                    if (CashierTrans.Amount >= TariffDetails."Lower Limit") and (CashierTrans.Amount <= TariffDetails."Upper Limit") then begin
                                        if TariffDetails."Use Percentage" = true then begin
                                            ChargeAmount := CashierTrans.Amount * TariffDetails.Percentage * 0.01;
                                        end else begin
                                            ChargeAmount := TariffDetails."Charge Amount";
                                        end;
                                    end;
                                until TariffDetails.Next = 0;
                            end;
                        end;



                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := JTemplate;
                        GenJournalLine."Journal Batch Name" := JBatch;
                        GenJournalLine."Document No." := CashierTrans.No;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                        GenJournalLine."Account No." := CashierTrans."Account No";
                        GenJournalLine."External Document No." := CashierTrans."ID No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                        GenJournalLine.Description := TransactionCharges.Description;
                        GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := ChargeAmount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;


                        //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                        if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                          (TransactionCharges."Recover Excise Duty" = true) then begin


                            //Excise Duty

                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := JTemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Document No." := CashierTrans.No;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                            GenJournalLine."Account No." := CashierTrans."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                            GenJournalLine.Description := 'Excise Duty';
                            GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := GenSetup."Excise Duty G/L";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            TChargeAmount := TChargeAmount + ChargeAmount;
                        end;
                    end;
                until TransactionCharges.Next = 0;
            end;




            //Post New
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", JTemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
            end;

            //Post New

            Post := false;
            Post := JournlPosted.PostedSuccessfully();
            if Post then begin

                Posted := true;
                CashierTrans."Date Posted" := Today;
                CashierTrans."Time Posted" := Time;
                CashierTrans."Posted By" := UserId;
                CashierTrans.Modify;
                Commit;
            end;


            //Advice Loan -------------Advice Savings Accounts
            if CashierTrans.Type <> CashierTrans.Type::"Credit Cheque" then begin
                CTransLines.Reset;
                CTransLines.SetRange("Transaction No", CashierTrans.No);
                if CTransLines.FindSet() then begin
                    repeat
                        if Loans.Get(CTransLines."Loan No") then
                            Loans.Validate(Repayment);
                        if SavingsACC.Get(CTransLines."Account No") then begin
                            if (SavingsACC."Product Category" = SavingsACC."Product Category"::"BOSA Deposits") or
                              (SavingsACC."Product Category" = SavingsACC."Product Category"::"Benevolent (BBF)") then
                                SavingsACC.Validate("Monthly Contribution");
                        end;
                    until CTransLines.Next = 0;
                end;
            end;
        end;
    end;

    local procedure PostBankersCheq(CashierTrans: Record "Cashier Transactions"; JTemplate: Code[20]; JBatch: Code[20]; DBranch: Code[20]; DActivity: Code[20])
    var
        Acc: Record "Savings Accounts";
        BankingTemp: Record "Banking User Template";
        Text0001: label 'This account has been blocked from receiving payments.';
        ChBank: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        TransactionCharges: Record "Transaction Charges";
        TCharges: Decimal;
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        GenSetup: Record "General Set-Up";
        TChargeAmount: Decimal;
        Text0002: label 'You cannot issue a Bankers cheque more than the available balance unless authorised.';
        BRegister: Record "Bankers Cheques Register";
        Text0003: label 'You do not have enough money to carry out this transaction.';
        Text0004: label 'You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.';
        Text0005: label 'You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.';
        Text0006: label 'You cannot withdraw more than your allowed limit of %1 unless authorised.';
        Text0007: label 'You cannot withdraw more than the available balance unless authorised.';
        Text0008: label 'You cannot deposit more than your allowed limit of %1 unless authorised.';
        Text0009: label 'You have done a transaction of KSHS. ';
        Text0010: label ' of type ';
        Text0011: label ' on ';
        Text0012: label ' on your account ';
        Text0013: label ' at ';
        Text0014: label 'The limit for cashier ';
        Text0015: label ' of till ';
        Text0016: label ' has gone below the replenishing levels of ';
        Text0017: label ' has gone above the replenishing levels of ';
        Text0018: label 'Transaction Aborted';
        BankSetup: Record "Banking User Template";
        VarVariant: Variant;
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        Text0019: label 'You cannot draw banker cheque more than your allowed limit of %1 unless authorised.';
        SMSChargeAmt: Decimal;
    begin

        // with CashierTrans do
        begin

            if Acc.Get(CashierTrans."Account No") then begin
                if Acc.Blocked = Acc.Blocked::Debit then
                    Error(Text0001);
            end;


            if BankingTemp.Get(UserId) then begin
                BankingTemp.TestField(BankingTemp."Bankers Cheque Account");
                ChBank := BankingTemp."Bankers Cheque Account";
            end;




            if CashierTrans.Type = CashierTrans.Type::"Bankers Cheque" then begin
                if CashierTrans."Available Balance" < CashierTrans.Amount then begin

                    Message(Text0002);

                    exit;
                end;
            end;
            if CashierTrans.Status <> CashierTrans.Status::Approved then begin
                CheckBankersNo(CashierTrans."Bankers Cheque No", CashierTrans."Global Dimension 2 Code", CashierTrans.Amount);
                if CashierTrans.Type = CashierTrans.Type::"Bankers Cheque" then begin

                    if CashierTrans.Amount > BankingTemp."Max. Bankers Chequel Limit" then begin
                        Message(Text0019, BankingTemp."Max. Bankers Chequel Limit");

                        if Confirm('Do you want to send this transaction for approval?', false) = true then begin
                            //message('code for approval here')
                            VarVariant := CashierTrans;
                            if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                                CustomApprovals.OnSendDocForApproval(VarVariant);
                        end;
                        exit;
                    end;
                end;
            end;
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", JTemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            GenJournalLine.DeleteAll;

            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := JTemplate;
            GenJournalLine."Journal Batch Name" := JBatch;
            GenJournalLine."Document No." := CashierTrans.No;
            GenJournalLine."External Document No." := CashierTrans."Bankers Cheque No";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
            GenJournalLine."Account No." := CashierTrans."Account No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
            GenJournalLine.Description := CashierTrans."Transaction Description" + '-' + CashierTrans.Payee;
            GenJournalLine."Currency Code" := CashierTrans."Currency Code";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := CashierTrans.Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := JTemplate;
            GenJournalLine."Journal Batch Name" := JBatch;
            GenJournalLine."Document No." := CashierTrans.No;
            GenJournalLine."External Document No." := CashierTrans."Bankers Cheque No";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
            GenJournalLine."Account No." := ChBank;
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
            GenJournalLine.Description := CashierTrans.Payee + '-' + CashierTrans."Cheque No";
            GenJournalLine."Currency Code" := CashierTrans."Currency Code";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := -(CashierTrans.Amount);
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;



            //Charges
            TCharges := 0;
            GenSetup.Get;

            TransactionCharges.Reset;
            TransactionCharges.SetRange(TransactionCharges."Transaction Type", CashierTrans."Transaction Type");
            if TransactionCharges.FindSet() then begin
                repeat
                    LineNo := LineNo + 10000;

                    ChargeAmount := 0;
                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                        ChargeAmount := (CashierTrans.Amount * TransactionCharges."Percentage of Amount") * 0.01
                    else
                        ChargeAmount := TransactionCharges."Charge Amount";

                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin

                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                        TariffDetails.Reset;
                        TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                        if TariffDetails.FindSet() then begin
                            repeat
                                if (CashierTrans.Amount >= TariffDetails."Lower Limit") and (CashierTrans.Amount <= TariffDetails."Upper Limit") then begin
                                    if TariffDetails."Use Percentage" = true then begin
                                        ChargeAmount := CashierTrans.Amount * TariffDetails.Percentage * 0.01;
                                    end else begin
                                        ChargeAmount := TariffDetails."Charge Amount";
                                    end;
                                end;
                            until TariffDetails.Next = 0;
                        end;
                    end;



                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := JTemplate;
                    GenJournalLine."Journal Batch Name" := JBatch;
                    GenJournalLine."Document No." := CashierTrans.No;
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                    GenJournalLine."Account No." := CashierTrans."Account No";
                    GenJournalLine."External Document No." := CashierTrans."ID No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                    GenJournalLine.Description := TransactionCharges.Description;
                    GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := ChargeAmount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                    if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                      (TransactionCharges."Recover Excise Duty" = true) then begin


                        //Excise Duty

                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := JTemplate;
                        GenJournalLine."Journal Batch Name" := JBatch;
                        GenJournalLine."Document No." := CashierTrans.No;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                        GenJournalLine."Account No." := CashierTrans."Account No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                        GenJournalLine.Description := 'Excise Duty';
                        GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := GenSetup."Excise Duty G/L";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        TChargeAmount := TChargeAmount + ChargeAmount;
                    end;
                until TransactionCharges.Next = 0;
            end;
            //Charge Bcheque SMS
            SMSChargeAmt := 0;
            GenSetup.get;
            TransactionCharges.Reset;
            TransactionCharges.SetRange(TransactionCharges."Transaction Type", GenSetup."Loan SMS Charge");
            if TransactionCharges.FindSet then begin
                repeat
                    if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) or
                    (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::"Stamp Duty") then begin

                        LineNo := LineNo + 10000;

                        SMSChargeAmt := 0;
                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                            SMSChargeAmt := (CashierTrans.Amount * TransactionCharges."Percentage of Amount") * 0.01
                        else
                            SMSChargeAmt := TransactionCharges."Charge Amount";

                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin

                            TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                            TariffDetails.Reset;
                            TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                            if TariffDetails.FindSet then begin
                                repeat
                                    if (CashierTrans.Amount >= TariffDetails."Lower Limit") and (CashierTrans.Amount <= TariffDetails."Upper Limit") then begin
                                        if TariffDetails."Use Percentage" = true then begin
                                            SMSChargeAmt := CashierTrans.Amount * TariffDetails.Percentage * 0.01;
                                        end else begin
                                            SMSChargeAmt := TariffDetails."Charge Amount";
                                        end;
                                    end;
                                until TariffDetails.Next = 0;
                            end;
                        end;

                        //Dont charge Transactional Charges
                        // if SavingsACC.Get(CashierTrans."Account No") then begin
                        //     if Employer.Get(SavingsACC."Employer Code") then begin
                        //         if Employer."Dont Charge Transactions" then
                        //             ChargeAmount := 0;
                        //     end;
                        // end;
                        //Dont charge Transactional Charges

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := JTemplate;
                        GenJournalLine."Journal Batch Name" := JBatch;
                        GenJournalLine."Document No." := CashierTrans.No;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                        GenJournalLine."Account No." := CashierTrans."Account No";
                        GenJournalLine."External Document No." := CashierTrans."ID No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                        GenJournalLine.Description := TransactionCharges.Description;
                        GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := SMSChargeAmt;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;


                        //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                        if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                          (TransactionCharges."Recover Excise Duty" = true) then begin
                            //Excise Duty
                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := JTemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Document No." := CashierTrans.No;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                            GenJournalLine."Account No." := CashierTrans."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                            GenJournalLine.Description := TransactionCharges.Description + ' excise duty.';
                            GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := (SMSChargeAmt * GenSetup."Excise Duty (%)") * 0.01;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := GenSetup."Excise Duty G/L";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                        end;
                    end;
                until TransactionCharges.Next = 0;
            end;

            //Post New
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", JTemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
            end;
            //Post New

            Post := false;
            Post := JournlPosted.PostedSuccessfully();
            if Post then begin
                Posted := true;
                CashierTrans."Date Posted" := Today;
                CashierTrans."Time Posted" := Time;
                CashierTrans."Posted By" := UserId;
                CashierTrans.Modify;
                Commit;
            end;

            BRegister.Reset;
            BRegister.SetRange(BRegister."Cheque No.", CashierTrans."Bankers Cheque No");
            BRegister.SetRange(Status, BRegister.Status::Pending);
            if BRegister.Find('-') then begin
                BRegister.Status := BRegister.Status::Approved;
                BRegister.Payee := CashierTrans.Payee;
                BRegister."Member No" := CashierTrans."Member No.";
                BRegister.Amount := CashierTrans.Amount;
                BRegister."Approval Date" := CashierTrans."Date Posted";
                BRegister.Modify;
            end;

            if SavingsACC.Get(CashierTrans."Account No") then begin
                MobileNo := SavingsACC."Mobile Phone No";
            end;

            msg := Text0009 + Format(CashierTrans.Amount) + Text0010 + Format(CashierTrans.Type) + Text0011 +
                       Format(Today) + ' ' + Format(Time) + Text0012 + Text0013 + COMPANYNAME;

            SendSMS.SendSms(Source::CASH_WITHDRAWAL_CONFIRM, MobileNo, msg, Format(CashierTrans."Account No"), '', true, 0, false, 'CBS', CashierTrans."Account No", 'CBS');


        end;
    end;

    local procedure PostCredit(CashierTrans: Record "Cashier Transactions"; JTemplate: Code[20]; JBatch: Code[20]; TillNo: Code[20]; DBranch: Code[20]; DActivity: Code[20])
    var
        CTransLines: Record "Cashier Transaction Lines";
        GenJournalLine: Record "Gen. Journal Line";
        RemainingAmt: Decimal;
    begin
        // with CashierTrans do
        begin
            RemainingAmt := 0;

            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := JTemplate;
            GenJournalLine."Journal Batch Name" := JBatch;
            GenJournalLine."Document No." := CashierTrans.No;
            GenJournalLine."External Document No." := CashierTrans."Cheque No";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
            GenJournalLine."Account No." := TillNo;
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
            GenJournalLine.Description := PadStr(Format(CashierTrans.Type) + '-' + CashierTrans.Remarks, 50);
            GenJournalLine."Currency Code" := CashierTrans."Currency Code";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := CashierTrans.Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            CTransLines.Reset;
            CTransLines.SetRange(CTransLines."Transaction No", CashierTrans.No);
            if CTransLines.FindSet() then begin
                repeat
                    if CTransLines."Transaction Type" = CTransLines."Transaction Type"::Armotised then begin
                        RemainingAmt := CTransLines.Amount;
                        LineNo := LineNo + 10000;

                        CTransLines.TestField(Type, CTransLines.Type::Credit);
                        CTransLines.TestField("Loan No");

                        Loans.Get(CTransLines."Loan No");
                        Loans.CalcFields("Daily Interest");
                        if Loans."Daily Interest" > 0 then begin
                            loansProcess.CapitalizeDailyInterest(Loans."Loan No.");
                        end;
                        Loans.CalcFields("Outstanding Interest", "Outstanding Balance");
                        if Loans."Outstanding Interest" > 0 then begin
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := JTemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Document No." := CashierTrans.No;
                            GenJournalLine."External Document No." := CashierTrans."Cheque No";
                            GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                            if CTransLines.Type = CTransLines.Type::Credit then begin
                                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Credit;
                                GenJournalLine.Description := PadStr('Receipt ' + CashierTrans.No + Format(CTransLines."Transaction Type") + '-' + CashierTrans.Remarks, 50);
                            end;
                            GenJournalLine."Account No." := CTransLines."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            if RemainingAmt > Loans."Outstanding Interest" then begin
                                GenJournalLine.Amount := -Loans."Outstanding Interest";
                                RemainingAmt -= Loans."Outstanding Interest"
                            end

                            else begin
                                GenJournalLine.Amount := -RemainingAmt;
                                RemainingAmt := 0;
                            end;


                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine."Transaction Type" := CTransLines."Transaction Type"::"Interest Paid";
                            GenJournalLine."Loan No" := CTransLines."Loan No";
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                        end;

                        //Outstanding Principal
                        if Loans."Outstanding Balance" > 0 then begin
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := JTemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Document No." := CashierTrans.No;
                            GenJournalLine."External Document No." := CashierTrans."Cheque No";
                            GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                            if CTransLines.Type = CTransLines.Type::Credit then begin
                                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Credit;
                                GenJournalLine.Description := PadStr('Receipt ' + CashierTrans.No + Format(CTransLines."Transaction Type") + '-' + CashierTrans.Remarks, 50);
                            end;
                            GenJournalLine."Account No." := CTransLines."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            if RemainingAmt > Loans."Outstanding Balance" then begin
                                GenJournalLine.Amount := -Loans."Outstanding Balance";
                                RemainingAmt -= Loans."Outstanding Balance"
                            end

                            else begin
                                GenJournalLine.Amount := -RemainingAmt;
                                RemainingAmt := 0;
                            end;


                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine."Transaction Type" := CTransLines."Transaction Type"::Repayment;
                            GenJournalLine."Loan No" := CTransLines."Loan No";
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                        end;

                    end else begin
                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := JTemplate;
                        GenJournalLine."Journal Batch Name" := JBatch;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := CashierTrans.No;
                        GenJournalLine."External Document No." := CashierTrans."Cheque No";
                        GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                        if CTransLines.Type = CTransLines.Type::Credit then begin
                            GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Credit;
                            GenJournalLine.Description := PadStr('Receipt ' + CashierTrans.No + Format(CTransLines."Transaction Type") + '-' + CashierTrans.Remarks, 50);
                        end else
                            if CTransLines.Type = CTransLines.Type::Savings then begin
                                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Savings;
                                GenJournalLine.Description := PadStr('Receipt ' + CashierTrans.No + '-' + CashierTrans.Remarks, 50);
                            end;
                        GenJournalLine."Account No." := CTransLines."Account No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Amount := -CTransLines.Amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine."Transaction Type" := CTransLines."Transaction Type";
                        GenJournalLine."Loan No" := CTransLines."Loan No";
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;


                        if Loans.Get(CTransLines."Loan No") then begin
                            //  Loans.VALIDATE(Repayment);}
                            //Pay Bills
                            if ProductFactory.Get(Loans."Loan Product Type") then begin
                                if CTransLines."Transaction Type" = CTransLines."transaction type"::Repayment then
                                    if CTransLines."Outstanding Bill" <> 0 then begin
                                        begin
                                            LineNo := LineNo + 10000;

                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := JTemplate;
                                            GenJournalLine."Journal Batch Name" := JBatch;
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Document No." := CashierTrans.No;
                                            GenJournalLine."External Document No." := CashierTrans."Cheque No";
                                            GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                                            GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Credit;
                                            GenJournalLine.Description := PadStr('Receipt ' + CashierTrans.No + Format(CTransLines."Transaction Type") + '-' + CashierTrans.Remarks, 50);
                                            GenJournalLine."Account No." := CTransLines."Account No";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            if CTransLines.Amount = CTransLines."OutStanding Loan" then
                                                GenJournalLine.Amount := -CTransLines."Outstanding Bill"
                                            else
                                                if CTransLines."Outstanding Bill" < 0 then
                                                    GenJournalLine.Amount := -CTransLines."Outstanding Bill"
                                                else
                                                    if CTransLines.Amount > CTransLines."Outstanding Bill" then
                                                        GenJournalLine.Amount := -CTransLines."Outstanding Bill"
                                                    else
                                                        GenJournalLine.Amount := -CTransLines.Amount;
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                                            GenJournalLine."Transaction Type" := CTransLines."transaction type"::Bills;
                                            GenJournalLine."Loan No" := CTransLines."Loan No";
                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                            GenJournalLine."Bal. Account No." := ProductFactory."Billed Account";
                                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                            // if GenJournalLine.Amount <> 0 then
                                            //    GenJournalLine.Insert;
                                        end;
                                    end;
                            end;
                        end;
                    end;



                    //change status of deposit account from new to acctive
                    if CTransLines.Type = CTransLines.Type::Savings then
                        if SavingsACC.Get(CTransLines."Account No") then begin
                            if SavingsACC."Product Category" = SavingsACC."Product Category"::"BOSA Deposits" then
                                if SavingsACC.Status = SavingsACC.Status::New then begin
                                    SavingsACC.CalcFields("Balance (LCY)");
                                    if SavingsACC."Balance (LCY)" + CTransLines.Amount >= 1000 then begin
                                        SavingsACC.Status := SavingsACC.Status::Active;
                                        SavingsACC.Modify;
                                    end;
                                end;
                            if Memb.Get(SavingsACC."Member No.") then
                                if Memb.Status = Memb.Status::New then begin
                                    Memb.Status := Memb.Status::Active;
                                    Memb.Modify;
                                end;
                        end;

                until CTransLines.Next = 0;
            end;
        end;
    end;

    local procedure PostCreditCheque(CashierTrans: Record "Cashier Transactions"; JTemplate: Code[20]; JBatch: Code[20]; TillNo: Code[20]; DBranch: Code[20]; DActivity: Code[20])
    var
        CTransLines: Record "Cashier Transaction Lines";
        GenJournalLine: Record "Gen. Journal Line";
        CreditLedger: Record "Credit Ledger Entry";
    begin
        // with CashierTrans do
        begin
            CTransLines.Reset;
            CTransLines.SetRange(CTransLines."Transaction No", CashierTrans.No);
            if CTransLines.FindSet() then begin
                repeat
                    CreditLedger.Reset;
                    CreditLedger.SetRange("Document No.", CTransLines."Transaction No");
                    CreditLedger.SetRange("Loan No", CTransLines."Loan No");
                    if not CreditLedger.Find('-') then begin
                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := JTemplate;
                        GenJournalLine."Journal Batch Name" := JBatch;
                        GenJournalLine."Document No." := CashierTrans.No;
                        GenJournalLine."External Document No." := CashierTrans."Cheque No";
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                        GenJournalLine."Account No." := TillNo;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := Today;//"Transaction Date";
                        GenJournalLine.Description := CashierTrans."Transaction Description";
                        GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := CTransLines.Amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := JTemplate;
                        GenJournalLine."Journal Batch Name" := JBatch;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := CashierTrans.No;
                        GenJournalLine."External Document No." := CashierTrans."Cheque No";
                        GenJournalLine."Posting Date" := Today;//"Transaction Date";
                        if CTransLines.Type = CTransLines.Type::Credit then
                            GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Credit
                        else
                            if CTransLines.Type = CTransLines.Type::Savings then
                                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Savings;
                        GenJournalLine.Description := 'Receipt ' + CashierTrans.No + Format(CTransLines."Transaction Type");
                        GenJournalLine."Account No." := CTransLines."Account No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Amount := -CTransLines.Amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine."Transaction Type" := CTransLines."Transaction Type";
                        GenJournalLine."Loan No" := CTransLines."Loan No";
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    end;
                until CTransLines.Next = 0;
            end;
        end;
    end;


    procedure PostTCIssue(TCTrans: Record "Treasury Cashier Transactions")
    var
        Text0004: label 'The money has already been issued.';
        BankingSetup: Record "Banking User Template";
        Text0005: label 'You do not have permission to transact on this teller till/Account.';
        Banks: Record "Bank Account";
        BankBal: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        Temp: Record "Banking User Template";
        JTemplate: Code[20];
        JBatch: Code[20];
        TillNo: Code[20];
        DBranch: Code[20];
        DActivity: Code[20];
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        Text0003: label 'Ensure the Default Bank is set up in User Setup';
        UserSetup: Record "User Setup";
        Text0007: label 'Please specify an amount greater than zero.';
        ToAccount: Code[20];
        FromAccount: Code[20];
        Text0008: label 'Coinage Amount must be equal to the amount';
    begin
        begin

            Temp.Get(UserId);
            JTemplate := Temp."Cashier Journal Template";
            JBatch := Temp."Cashier Journal Batch";
            TillNo := Temp."Default  Bank";

            if JTemplate = '' then begin
                Error(Text0001);
            end;
            if JBatch = '' then begin
                Error(Text0002);
            end;

            if TillNo = '' then begin
                Error(Text0003);
            end;

            CheckTillCurrency(TillNo, TCTrans."Currency Code");
            UserSetup.Reset;
            UserSetup.SetRange(UserSetup."User ID", UpperCase(UserId));
            if UserSetup.Find('-') then begin
                UserSetup.TestField(UserSetup."Global Dimension 2 Code");
                UserSetup.TestField(UserSetup."Global Dimension 1 Code");
                DBranch := UserSetup."Global Dimension 2 Code";
                DActivity := UserSetup."Global Dimension 1 Code";
            end;

            TCTrans.TestField(Amount);
            TCTrans.TestField("From Account");
            TCTrans.TestField("To Account");

            if TCTrans.Amount <= 0 then
                Error(Text0007);

            // if TCTrans.Amount <> TCTrans."Total Cash on Treasury Coinage" then
            //     Error(Text0008);

            if (TCTrans."Transaction Type" = TCTrans."transaction type"::"Issue To Teller") or
            (TCTrans."Transaction Type" = TCTrans."transaction type"::"Return To Treasury") or
            (TCTrans."Transaction Type" = TCTrans."transaction type"::"Inter Teller Transfers") or
            (TCTrans."Transaction Type" = TCTrans."transaction type"::"Branch Treasury Transactions") or
            (TCTrans."Transaction Type" = TCTrans."transaction type"::"End of Day Return to Treasury")

             then begin

                if TCTrans.Issued = TCTrans.Issued::Yes then
                    Error(Text0004);

                BankingSetup.Reset;
                BankingSetup.SetRange(BankingSetup.UserID, TCTrans."From Account");
                if BankingSetup.Find('-') then begin
                    if UpperCase(UserId) <> BankingSetup.UserID then
                        Error(Text0005);
                end;

                if TCTrans."Transaction Type" <> TCTrans."transaction type"::"End of Day Return to Treasury" then begin


                    Banks.SetRange(Banks."No.", TillNo);
                    if Banks.Find('-') then begin
                        Banks.CalcFields(Banks."Balance (LCY)");
                        BankBal := Banks."Balance (LCY)";
                        if TCTrans.Amount > BankBal then begin
                            Error('You cannot issue more than the account balance.')
                        end;
                    end;
                end;

                if Confirm('Are you sure you want to make this issue?', false) = true then begin
                    TCTrans.Issued := TCTrans.Issued::Yes;
                    TCTrans."Date Issued" := Today;
                    TCTrans."Time Issued" := Time;
                    TCTrans."Issued By" := UpperCase(UserId);
                    TCTrans.Modify;
                    Commit;
                end;
                Message('Money successfully issued/Returned.');
            end else

                if TCTrans."Transaction Type" = TCTrans."transaction type"::"Return To Bank" then begin
                    TCTrans.TestField(Amount);
                    TCTrans.TestField("From Account");
                    TCTrans.TestField("To Account");


                    BankingSetup.Reset;
                    BankingSetup.SetRange(BankingSetup.UserID, TCTrans."From Account");
                    if BankingSetup.Find('-') then begin
                        FromAccount := BankingSetup."Default  Bank";
                    end;

                    ToAccount := TCTrans."To Account";

                    Banks.Reset;
                    Banks.SetRange(Banks."No.", TCTrans."From Account");
                    if Banks.Find('-') then begin
                        Banks.CalcFields("Balance (LCY)");
                        if TCTrans.Amount > Banks."Balance (LCY)" then
                            Error('You cannot receive more than balance in ' + TCTrans."From Account")
                    end;

                    Banks.Reset;
                    Banks.SetRange(Banks."No.", FromAccount);
                    if Banks.Find('-') then begin
                        Banks.CalcFields(Banks."Balance (LCY)", Banks.Balance);
                        BankBal := Banks.Balance;//Banks."Balance (LCY)";
                        if TCTrans.Amount > BankBal then begin
                            Error('You cannot return more than the account balance.')
                        end;
                    end;

                    if Confirm('Are you sure you want to make this return?', false) = false then
                        exit;


                    //Delete any items present
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JTemplate);
                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
                    GenJournalLine.DeleteAll;


                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := JTemplate;
                    GenJournalLine."Journal Batch Name" := JBatch;
                    GenJournalLine."Document No." := TCTrans.No;
                    GenJournalLine."External Document No." := TCTrans."External Document No.";
                    GenJournalLine."Line No." := 10000;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := FromAccount;
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := TCTrans.Description;
                    GenJournalLine."Currency Code" := TCTrans."Currency Code";
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := -(TCTrans.Amount);
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                    GenJournalLine."Bal. Account No." := ToAccount;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JTemplate);
                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
                    if GenJournalLine.Find('-') then
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJournalLine);
                    Post := false;
                    Post := JournlPosted.PostedSuccessfully();
                    if Post then begin
                        TCTrans.Posted := true;
                        TCTrans."Date Posted" := Today;
                        TCTrans."Time Posted" := Time;
                        TCTrans."Posted By" := UpperCase(UserId);
                        TCTrans.Received := TCTrans.Received::Yes;
                        TCTrans."Date Received" := Today;
                        TCTrans."Time Received" := Time;
                        TCTrans."Received By" := UpperCase(UserId);
                        //**COMMIT;
                        TCTrans.MODIFY;
                    end;
                end else
                    Message('Only applicable for teller, treasury & Bank Issues/Returns.');
        end;
    end;

    procedure PostTCReceive(TCTrans: Record "Treasury Cashier Transactions")
    var
        CurrentTellerAmount: Decimal;
        BankingSetup: Record "Banking User Template";
        Banks: Record "Bank Account";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        Temp: Record "Banking User Template";
        JTemplate: Code[20];
        JBatch: Code[20];
        TillNo: Code[20];
        DBranch: Code[20];
        DActivity: Code[20];
        UserSetup: Record "User Setup";
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        Text0003: label 'Ensure the Default Bank is set up in Banking User Setup';
        Text0007: label 'Please specify an amount greater than zero.';
        ToAccount: Code[20];
        FromAccount: Code[20];
        ShortageAcc: Code[20];
        ExcessAcc: Code[20];
        GLEntry: Record "G/L Entry";
        TreasuryChqRegister: Record "Treasury Cheques Register";
    begin

        //with TCTrans do
        begin
            //*******Prevent posting Twice
            GLEntry.Reset;
            GLEntry.SetRange("Document No.", TCTrans.No);
            if GLEntry.Find('-') then begin
                Posted := true;
                TCTrans."Date Posted" := Today;
                TCTrans."Time Posted" := Time;
                TCTrans."Posted By" := UpperCase(UserId);
                TCTrans.Received := TCTrans.Received::Yes;
                TCTrans."Date Received" := Today;
                TCTrans."Time Received" := Time;
                TCTrans."Received By" := UpperCase(UserId);
                Commit;
                TCTrans.Modify;
                exit;
            end;
            //*******Prevent Posting Twice.
            Temp.Get(UserId);

            JTemplate := Temp."Cashier Journal Template";
            JBatch := Temp."Cashier Journal Batch";
            TillNo := Temp."Default  Bank";

            if JTemplate = '' then begin
                Error(Text0001);
            end;

            if JBatch = '' then begin
                Error(Text0002);
            end;

            if TillNo = '' then begin
                Error(Text0003);
            end;

            CheckTillCurrency(TillNo, TCTrans."Currency Code");

            UserSetup.Reset;
            UserSetup.SetRange(UserSetup."User ID", UpperCase(UserId));
            if UserSetup.Find('-') then begin
                UserSetup.TestField(UserSetup."Global Dimension 2 Code");
                UserSetup.TestField(UserSetup."Global Dimension 1 Code");
                DBranch := UserSetup."Global Dimension 2 Code";
                DActivity := UserSetup."Global Dimension 1 Code";
            end;

            TCTrans.TestField(Amount);
            TCTrans.TestField("From Account");
            TCTrans.TestField("To Account");

            if TCTrans.Amount <= 0 then
                Error(Text0007);


            if TCTrans."Transaction Type" = TCTrans."transaction type"::"Issue From Treasury Control" then begin
                TCTrans.TestField("External Document No.");

                BankingSetup.Reset;
                BankingSetup.SetRange(BankingSetup.UserID, TCTrans."To Account");
                if BankingSetup.Find('-') then begin
                    ToAccount := BankingSetup."Default  Bank";
                end;
                FromAccount := TCTrans."From Account";
            end;



            CurrentTellerAmount := 0;

            if Posted then
                Error('The transaction has already been received and posted.');


            if (TCTrans."Transaction Type" = TCTrans."transaction type"::"Issue To Teller") or
               (TCTrans."Transaction Type" = TCTrans."transaction type"::"Branch Treasury Transactions") or
              (TCTrans."Transaction Type" = TCTrans."transaction type"::"Return To Treasury") or
              (TCTrans."Transaction Type" = TCTrans."transaction type"::"End of Day Return to Treasury") or
               (TCTrans."Transaction Type" = TCTrans."transaction type"::"Inter Teller Transfers")

               then begin
                if TCTrans.Issued = TCTrans.Issued::No then
                    Error('The issue has not yet been made and therefore you cannot continue with this transaction.');


                BankingSetup.Reset;
                BankingSetup.SetRange(BankingSetup.UserID, TCTrans."To Account");
                if BankingSetup.Find('-') then begin
                    if UpperCase(UserId) <> BankingSetup.UserID then
                        Error('You do not have permission to transact on this teller till/Account.');

                    ToAccount := BankingSetup."Default  Bank";

                    Banks.Reset;
                    Banks.SetRange(Banks."No.", ToAccount);
                    if Banks.Find('-') then begin
                        Banks.CalcFields(Banks."Balance (LCY)");
                        CurrentTellerAmount := Banks."Balance (LCY)";



                        if CurrentTellerAmount + TCTrans.Amount > BankingSetup."Maximum Withholding" then
                            Error('The transaction will result in the teller having a balance more than the maximum allowable therefore terminated.');
                    end;
                end;

                BankingSetup.Reset;
                BankingSetup.SetRange(BankingSetup.UserID, TCTrans."From Account");
                if BankingSetup.Find('-') then begin
                    FromAccount := BankingSetup."Default  Bank";
                    ExcessAcc := BankingSetup."Excess Account";
                    ShortageAcc := BankingSetup."Shortage Account";
                end;

            end;



            if Confirm('Are you sure you want to make this receipt?', false) = false then exit;

            //Delete any items present
            GenJournalLine.Reset;
            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JTemplate);
            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
            GenJournalLine.DeleteAll;

            //==Post Normal

            LineNo += 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := JTemplate;
            GenJournalLine."Journal Batch Name" := JBatch;
            GenJournalLine."Document No." := TCTrans.No;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
            GenJournalLine."Account No." := FromAccount;
            GenJournalLine."External Document No." := TCTrans."External Document No.";
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine.Description := TCTrans.Description;
            GenJournalLine."Currency Code" := TCTrans."Currency Code";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := -(TCTrans.Amount);
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
            GenJournalLine."Bal. Account No." := ToAccount;
            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
            //END;


            //Posting Excess
            if TCTrans.Type = TCTrans.Type::Excess then begin

                LineNo += 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := JTemplate;
                GenJournalLine."Journal Batch Name" := JBatch;
                GenJournalLine."Document No." := TCTrans.No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                GenJournalLine."Account No." := ExcessAcc;
                GenJournalLine."External Document No." := TCTrans."External Document No.";
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine.Description := 'Excess From Cashier';
                GenJournalLine."Currency Code" := TCTrans."Currency Code";
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := TCTrans."Excess/Shortage Amount" * -1;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                GenJournalLine."Bal. Account No." := FromAccount;
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

            end;
            //Posting Excess


            //Posting Shortage
            if TCTrans.Type = TCTrans.Type::Shortage then begin

                LineNo += 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := JTemplate;
                GenJournalLine."Journal Batch Name" := JBatch;
                GenJournalLine."Document No." := TCTrans.No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                GenJournalLine."Account No." := ShortageAcc;
                GenJournalLine."External Document No." := TCTrans."External Document No.";
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine.Description := 'Shortage From Cashier';
                GenJournalLine."Currency Code" := TCTrans."Currency Code";
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := TCTrans."Excess/Shortage Amount";
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                GenJournalLine."Bal. Account No." := FromAccount;
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

            end;
            //Posting Shortage

            GenJournalLine.Reset;
            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JTemplate);
            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
            if GenJournalLine.Find('-') then
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);

            // Post := false;
            // Post := JournlPosted.PostedSuccessfully();
            // if Post then begin
            TCTrans.Posted := true;
            TCTrans."Date Posted" := Today;
            TCTrans."Time Posted" := Time;
            TCTrans."Posted By" := UpperCase(UserId);
            TCTrans.Received := TCTrans.Received::Yes;
            TCTrans."Date Received" := Today;
            TCTrans."Time Received" := Time;
            TCTrans."Received By" := UpperCase(UserId);
            //**COMMIT;
            TCTrans.Modify;

            TreasuryChqRegister.Reset();
            TreasuryChqRegister.SetRange("Cheque No.", TCTrans."External Document No.");
            if TreasuryChqRegister.FindFirst() then begin
                TreasuryChqRegister.Status := TreasuryChqRegister.Status::Received;
                TreasuryChqRegister.Modify();
            end;
            // end;
        end;
    end;

    // Receive&post
    procedure ProcessEndOfDayReturnToTreasury(TCTrans: Record "Treasury Cashier Transactions")
    var
        Text0004: label 'The money has already been issued.';
        BankingSetup: Record "Banking User Template";
        Text0005: label 'You do not have permission to transact on this teller till/Account.';
        Banks: Record "Bank Account";
        BankBal: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        Temp: Record "Banking User Template";
        JTemplate: Code[20];
        JBatch: Code[20];
        TillNo: Code[20];
        DBranch: Code[20];
        DActivity: Code[20];
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        Text0003: label 'Ensure the Default Bank is set up in User Setup';
        UserSetup: Record "User Setup";
        Text0007: label 'Please specify an amount greater than zero.';
        ToAccount: Code[20];
        FromAccount: Code[20];
        ShortageAcc: Code[20];
        ExcessAcc: Code[20];
        Text0008: label 'Coinage Amount must be equal to the amount';
        GLEntry: Record "G/L Entry";
        LineNo: Integer;
        CurrentTellerAmount: Decimal;
        TreasuryChqRegister: Record "Treasury Cheques Register";
    begin
        // Validate that this is an End of Day Return to Treasury transaction
        if TCTrans."Transaction Type" <> TCTrans."transaction type"::"End of Day Return to Treasury" then
            Error('This procedure is only for End of Day Return to Treasury transactions.');

        // Check if already posted to prevent duplicate posting
        GLEntry.Reset;
        GLEntry.SetRange("Document No.", TCTrans.No);
        if GLEntry.Find('-') then begin
            TCTrans.Posted := true;
            TCTrans."Date Posted" := Today;
            TCTrans."Time Posted" := Time;
            TCTrans."Posted By" := UpperCase(UserId);
            TCTrans.Received := TCTrans.Received::Yes;
            TCTrans."Date Received" := Today;
            TCTrans."Time Received" := Time;
            TCTrans."Received By" := UpperCase(UserId);
            Commit;
            TCTrans.Modify;
            exit;
        end;

        // Get user setup and validate required fields
        Temp.Get(UserId);
        JTemplate := Temp."Cashier Journal Template";
        JBatch := Temp."Cashier Journal Batch";
        TillNo := Temp."Default  Bank";

        if JTemplate = '' then
            Error(Text0001);
        if JBatch = '' then
            Error(Text0002);
        if TillNo = '' then
            Error(Text0003);

        CheckTillCurrency(TillNo, TCTrans."Currency Code");

        // Get user dimensions
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UpperCase(UserId));
        if UserSetup.Find('-') then begin
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            DBranch := UserSetup."Global Dimension 2 Code";
            DActivity := UserSetup."Global Dimension 1 Code";
        end;

        // Validate transaction fields
        TCTrans.TestField(Amount);
        TCTrans.TestField("From Account");
        TCTrans.TestField("To Account");

        if TCTrans.Amount <= 0 then
            Error(Text0007);

        if TCTrans.Amount <> TCTrans."Total Cash on Treasury Coinage" then
            Error(Text0008);

        // STEP 1: ISSUE PROCESS
        // Check if already issued
        if TCTrans.Issued = TCTrans.Issued::Yes then
            Error(Text0004);

        // Validate user permissions for issuing
        BankingSetup.Reset;
        BankingSetup.SetRange(BankingSetup.UserID, TCTrans."From Account");
        if BankingSetup.Find('-') then begin
            if UpperCase(UserId) <> BankingSetup.UserID then
                Error(Text0005);
        end;

        // For End of Day Return, we skip the balance check as mentioned in original code
        // Confirm issue
        if not Confirm('Are you sure you want to make this issue?', false) then
            exit;

        // Mark as issued
        TCTrans.Issued := TCTrans.Issued::Yes;
        TCTrans."Date Issued" := Today;
        TCTrans."Time Issued" := Time;
        TCTrans."Issued By" := UpperCase(UserId);
        TCTrans.Modify;
        Commit;

        // STEP 2: RECEIVE PROCESS
        // Validate user permissions for receiving
        BankingSetup.Reset;
        BankingSetup.SetRange(BankingSetup.UserID, TCTrans."To Account");
        if BankingSetup.Find('-') then begin
            // if UpperCase(UserId) <> BankingSetup.UserID then
            //     Error('You do not have permission to transact on this teller till/Account.');

            ToAccount := BankingSetup."Default  Bank";

            // Check maximum withholding limits
            Banks.Reset;
            Banks.SetRange(Banks."No.", ToAccount);
            if Banks.Find('-') then begin
                Banks.CalcFields(Banks."Balance (LCY)");
                CurrentTellerAmount := Banks."Balance (LCY)";

                if CurrentTellerAmount + TCTrans.Amount > BankingSetup."Maximum Withholding" then
                    Error('The transaction will result in the teller having a balance more than the maximum allowable therefore terminated.');
            end;
        end;

        // Get From Account details
        BankingSetup.Reset;
        BankingSetup.SetRange(BankingSetup.UserID, TCTrans."From Account");
        if BankingSetup.Find('-') then begin
            FromAccount := BankingSetup."Default  Bank";
            ExcessAcc := BankingSetup."Excess Account";
            ShortageAcc := BankingSetup."Shortage Account";
        end;

        // Confirm receipt
        if not Confirm('Are you sure you want to make this receipt?', false) then
            exit;

        // STEP 3: POSTING PROCESS
        // Delete any existing journal lines
        GenJournalLine.Reset;
        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JTemplate);
        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
        GenJournalLine.DeleteAll;

        // Post main transaction
        LineNo := 10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := JTemplate;
        GenJournalLine."Journal Batch Name" := JBatch;
        GenJournalLine."Document No." := TCTrans.No;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No." := FromAccount;
        GenJournalLine."External Document No." := TCTrans."External Document No.";
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine.Description := TCTrans.Description;
        GenJournalLine."Currency Code" := TCTrans."Currency Code";
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := -(TCTrans.Amount);
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
        GenJournalLine."Bal. Account No." := ToAccount;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        // Post excess if applicable
        if TCTrans.Type = TCTrans.Type::Excess then begin
            LineNo += 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := JTemplate;
            GenJournalLine."Journal Batch Name" := JBatch;
            GenJournalLine."Document No." := TCTrans.No;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
            GenJournalLine."Account No." := ExcessAcc;
            GenJournalLine."External Document No." := TCTrans."External Document No.";
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine.Description := 'Excess From Cashier';
            GenJournalLine."Currency Code" := TCTrans."Currency Code";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := TCTrans."Excess/Shortage Amount" * -1;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
            GenJournalLine."Bal. Account No." := FromAccount;
            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
        end;

        // Post shortage if applicable
        if TCTrans.Type = TCTrans.Type::Shortage then begin
            LineNo += 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := JTemplate;
            GenJournalLine."Journal Batch Name" := JBatch;
            GenJournalLine."Document No." := TCTrans.No;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
            GenJournalLine."Account No." := ShortageAcc;
            GenJournalLine."External Document No." := TCTrans."External Document No.";
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine.Description := 'Shortage From Cashier';
            GenJournalLine."Currency Code" := TCTrans."Currency Code";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := TCTrans."Excess/Shortage Amount";
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
            GenJournalLine."Bal. Account No." := FromAccount;
            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
        end;

        // Post the journal
        GenJournalLine.Reset;
        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JTemplate);
        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
        if GenJournalLine.Find('-') then
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);

        // Update transaction status
        TCTrans.Posted := true;
        TCTrans."Date Posted" := Today;
        TCTrans."Time Posted" := Time;
        TCTrans."Posted By" := UpperCase(UserId);
        TCTrans.Received := TCTrans.Received::Yes;
        TCTrans."Date Received" := Today;
        TCTrans."Time Received" := Time;
        TCTrans."Received By" := UpperCase(UserId);
        TCTrans.Modify;

        // Update Treasury Cheque Register if applicable
        TreasuryChqRegister.Reset();
        TreasuryChqRegister.SetRange("Cheque No.", TCTrans."External Document No.");
        if TreasuryChqRegister.FindFirst() then begin
            TreasuryChqRegister.Status := TreasuryChqRegister.Status::Received;
            TreasuryChqRegister.Modify();
        end;

        Message('End of Day Return to Treasury processed successfully.');
    end;



    procedure ClearCheques()
    var
        Transactions: Record "Cashier Transactions";
        GenJournalLine: Record "Gen. Journal Line";
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        TCharges: Decimal;
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        TChargeAmount: Decimal;
        Loans: Record Loans;
        CTransLines: Record "Cashier Transaction Lines";
        CreditLedger: Record "Credit Ledger Entry";
    begin
        Temp.Get(UserId);
        GenSetup.Get;

        Jtemplate := Temp."Cashier Journal Template";
        JBatch := Temp."Cashier Journal Batch";

        if Jtemplate = '' then begin
            Error(Text0001);
        end;

        if JBatch = '' then begin
            Error(Text0002);
        end;

        Transactions.Reset;
        Transactions.SetRange(Posted, true);
        Transactions.SetRange(Transactions.Select, true);
        Transactions.SetRange(Transactions."Cheque Status", Transactions."cheque status"::Pending);
        if Transactions.FindSet() then begin
            repeat
                if (Transactions.Type = Transactions.Type::"Cheque Deposit") or (Transactions.Type = Transactions.Type::"Credit Cheque") then begin
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                    GenJournalLine.SetRange("Journal Batch Name", JBatch);
                    GenJournalLine.DeleteAll;

                    CreditLedger.Reset;
                    CreditLedger.SetRange("Loan No", CTransLines."Loan No");
                    CreditLedger.SetRange("Document No.", CTransLines."Transaction No");
                    if not CreditLedger.Find('-') then begin
                        if Transactions.Type = Transactions.Type::"Credit Cheque" then begin
                            PostCreditCheque(Transactions, Jtemplate, JBatch, Transactions."Account No", Transactions."Global Dimension 2 Code",
                            Transactions."Global Dimension 1 Code");
                        end;
                    end;
                    //Recover Discounting
                    if Transactions."Discounted Amount" > 0 then begin
                        Loans.Reset;
                        Loans.SetRange(Loans.Remarks, Transactions.No);
                        Loans.SetRange(Loans."Member No.", Transactions."Member No.");
                        Loans.SetRange(Loans.Posted, true);
                        Loans.SetAutoCalcFields("Outstanding Balance");
                        if Loans.FindSet() then begin
                            repeat
                                // Loans.CalcFields(Loans."Outstanding Balance");
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := JBatch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Document No." := Transactions.No;
                                GenJournalLine."External Document No." := Loans."Loan No.";
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Credit;
                                GenJournalLine."Account No." := Loans."Loan Account";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'Discounting Loan Recovery';
                                GenJournalLine.Amount := -Loans."Outstanding Balance";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                                GenJournalLine."Loan No" := Loans."Loan No.";
                                GenJournalLine."Shortcut Dimension 1 Code" := Transactions."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code" := Transactions."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := JBatch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Document No." := Transactions.No;
                                GenJournalLine."External Document No." := Loans."Loan No.";
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Savings;
                                GenJournalLine."Account No." := Transactions."Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'Discounting Loan Recovery';
                                GenJournalLine.Amount := (Loans."Outstanding Balance");
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code" := Transactions."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code" := Transactions."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                            until Loans.Next = 0;
                        end else
                            Error('Discounting loan for %1 not found.', Transactions.No);
                    end;

                    //Post New
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                    GenJournalLine.SetRange("Journal Batch Name", JBatch);
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                    end;
                    //Post New
                    Transactions."Cheque Status" := Transactions."cheque status"::Cleared;
                    Transactions."Date Cleared" := Today;
                    Transactions."Cleared By" := UserId;
                    Transactions.Modify(true);
                end;

                CTransLines.Reset;
                CTransLines.SetRange("Transaction No", Transactions.No);
                if CTransLines.FindSet() then begin
                    repeat
                        if CTransLines."Transaction Type" = CTransLines."transaction type"::Repayment then begin
                            if Loans.Get(CTransLines."Loan No") then
                                Loans.Validate(Repayment);
                        end;
                    until CTransLines.Next = 0;
                end;
            until Transactions.Next = 0;
        end;
    end;


    procedure StopCheque(CashierTrans: Record "Cashier Transactions")
    var
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        GenJournalLine: Record "Gen. Journal Line";
        ChargeAmount: Decimal;
        ChequeType: Record "Cheque Types";
        TCharges: Decimal;
        TransactionCharges: Record "Transaction Charges";
        TariffDetails: Record "Tiered Charges Lines";
        TChargeAmount: Decimal;
        TransType: Record "Transaction Types";
    begin
        // with CashierTrans do
        begin

            Temp.Get(UserId);
            GenSetup.Get;

            Jtemplate := Temp."Cashier Journal Template";
            JBatch := Temp."Cashier Journal Batch";


            if Jtemplate = '' then begin
                Error(Text0001);
            end;

            if JBatch = '' then begin
                Error(Text0002);
            end;

            if (CashierTrans.Type = CashierTrans.Type::"Cheque Deposit") or (CashierTrans.Type = CashierTrans.Type::"Credit Cheque") then begin
                // ERROR('Only applicable to cheques');

                if CashierTrans."Cheque Status" <> CashierTrans."cheque status"::Pending then
                    Error('Cheque already processed.');

                if Confirm('Are you sure you want to stop the Cheque? reversal charges will apply', true) = false then
                    exit;



                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                GenJournalLine.DeleteAll;



                //Reverse Entry
                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := Jtemplate;
                GenJournalLine."Journal Batch Name" := JBatch;
                GenJournalLine."Document No." := CashierTrans.No;
                GenJournalLine."External Document No." := CashierTrans."Cheque No";
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                GenJournalLine."Account No." := CashierTrans."Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := 'Unpaid Cheque Reversal';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := CashierTrans.Amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := CashierTrans."Global Dimension 1 Code";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine."Shortcut Dimension 2 Code" := CashierTrans."Global Dimension 2 Code";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := Jtemplate;
                GenJournalLine."Journal Batch Name" := JBatch;
                GenJournalLine."Document No." := CashierTrans.No;
                GenJournalLine."External Document No." := CashierTrans."Cheque No";
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                GenJournalLine."Account No." := CashierTrans."Bank Account";//BankCodes;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := CopyStr(CashierTrans."Member No." + ' ' + CashierTrans."Account Name", 1, 30);
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := -(CashierTrans.Amount);
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := CashierTrans."Global Dimension 1 Code";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine."Shortcut Dimension 2 Code" := CashierTrans."Global Dimension 2 Code";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;


                //Charges
                TCharges := 0;

                TransType.Reset;
                TransType.SetRange(TransType.Type, TransType.Type::"Bounced Cheque");
                if TransType.Find('-') then begin

                    TransactionCharges.Reset;
                    TransactionCharges.SetRange(TransactionCharges."Transaction Type", TransType.Code);
                    if TransactionCharges.FindSet() then begin
                        repeat

                            if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) or
                            (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::"Stamp Duty") then begin

                                LineNo := LineNo + 10000;

                                ChargeAmount := 0;
                                if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                                    ChargeAmount := (CashierTrans.Amount * TransactionCharges."Percentage of Amount") * 0.01
                                else
                                    ChargeAmount := TransactionCharges."Charge Amount";

                                if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin

                                    TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                                    TariffDetails.Reset;
                                    TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                    if TariffDetails.FindSet() then begin
                                        repeat
                                            if (CashierTrans.Amount >= TariffDetails."Lower Limit") and (CashierTrans.Amount <= TariffDetails."Upper Limit") then begin
                                                if TariffDetails."Use Percentage" = true then begin
                                                    ChargeAmount := CashierTrans.Amount * TariffDetails.Percentage * 0.01;
                                                end else begin
                                                    ChargeAmount := TariffDetails."Charge Amount";
                                                end;
                                            end;
                                        until TariffDetails.Next = 0;
                                    end;
                                end;



                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := JBatch;
                                GenJournalLine."Document No." := CashierTrans.No;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                GenJournalLine."Account No." := CashierTrans."Account No";
                                GenJournalLine."External Document No." := CashierTrans."ID No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                                GenJournalLine.Description := TransactionCharges.Description;
                                GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := ChargeAmount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Shortcut Dimension 1 Code" := CashierTrans."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code" := CashierTrans."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                                if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty")
                                  and (TransactionCharges."Recover Excise Duty" = true) then begin

                                    //Excise Duty

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := JBatch;
                                    GenJournalLine."Document No." := CashierTrans.No;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                    GenJournalLine."Account No." := CashierTrans."Account No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := CashierTrans."Transaction Date";
                                    GenJournalLine.Description := 'Excise Duty';
                                    GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := GenSetup."Excise Duty G/L";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Shortcut Dimension 1 Code" := CashierTrans."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code" := CashierTrans."Global Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    TChargeAmount := TChargeAmount + ChargeAmount;
                                end;

                            end;
                        until TransactionCharges.Next = 0;
                    end;
                end;






                //Post
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                end;
                //Post

                CashierTrans."Cheque Status" := CashierTrans."cheque status"::Stopped;
                CashierTrans."Date Cleared" := Today;
                CashierTrans."Cleared By" := UserId;
                CashierTrans.Modify;
            end else
                Error('Only applicable to cheques');
        end;
    end;


    procedure StopBankers(CashierTrans: Record "Cashier Transactions"; JTemplate: Code[20]; JBatch: Code[20]; DBranch: Code[20]; DActivity: Code[20])
    var
        Acc: Record "Savings Accounts";
        BankingTemp: Record "Banking User Template";
        Text0001: label 'This account has been blocked from receiving payments.';
        ChBank: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        TransactionCharges: Record "Transaction Charges";
        TCharges: Decimal;
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        GenSetup: Record "General Set-Up";
        TChargeAmount: Decimal;
        Text0002: label 'You cannot issue a Bankers cheque more than the available balance unless authorised.';
        BRegister: Record "Bankers Cheques Register";
        Text0003: label 'You do not have enough money to carry out this transaction.';
        Text0004: label 'You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.';
        Text0005: label 'You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.';
        Text0006: label 'You cannot withdraw more than your allowed limit of %1 unless authorised.';
        Text0007: label 'You cannot withdraw more than the available balance unless authorised.';
        Text0008: label 'You cannot deposit more than your allowed limit of %1 unless authorised.';
        Text0009: label 'You have done a transaction of KSHS. ';
        Text0010: label ' of type ';
        Text0011: label ' on ';
        Text0012: label ' on your account ';
        Text0013: label ' at ';
        Text0014: label 'The limit for cashier ';
        Text0015: label ' of till ';
        Text0016: label ' has gone below the replenishing levels of ';
        Text0017: label ' has gone above the replenishing levels of ';
        Text0018: label 'Transaction Aborted';
        BankSetup: Record "Banking User Template";
        VarVariant: Variant;
        //  CustomApprovals: Codeunit "Custom Approvals Codeunit";
        Text0019: label 'You cannot draw banker cheque more than your allowed limit of %1 unless authorised.';
        TransType: Record "Transaction Types";
        Text0020: label 'Your Bankers Cheque of KSHS. ';
        Text0021: label 'has been cancelled and charges applied';
    // JTemplate: Code[20];
    // JBatch: Code[20];
    // DBranch: Code[20];
    // DActivity: Code[20];
    begin

        // with CashierTrans do
        begin

            if Acc.Get(CashierTrans."Account No") then begin
                if Acc.Blocked = Acc.Blocked::Debit then
                    Error(Text0001);
            end;


            if BankingTemp.Get(UserId) then begin
                BankingTemp.TestField(BankingTemp."Bankers Cheque Account");
                ChBank := BankingTemp."Bankers Cheque Account";
            end;
            Temp.Get(UserId);
            GenSetup.Get;

            JTemplate := Temp."Cashier Journal Template";
            JBatch := Temp."Cashier Journal Batch";



            if CashierTrans.Type = CashierTrans.Type::"Bankers Cheque" then begin
                /*IF "Available Balance" < Amount THEN BEGIN

                MESSAGE(Text0002);

                EXIT;
                END;*/
                BRegister.Reset;
                BRegister.SetRange(BRegister."Cheque No.", CashierTrans."Bankers Cheque No");
                BRegister.SetFilter(Status, '<>%1', BRegister.Status::Approved);
                if BRegister.Find('-') then begin
                    Error('Reversal Has already been done');
                end;

            end;
            if CashierTrans.Status <> CashierTrans.Status::Approved then begin
                if CashierTrans.Type = CashierTrans.Type::"Bankers Cheque" then begin
                    if Confirm('Do you want to send this transaction for approval?', false) = true then begin
                        VarVariant := CashierTrans;
                        // if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        // CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                    exit;
                end;
            end;
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", JTemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            GenJournalLine.DeleteAll;



            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := JTemplate;
            GenJournalLine."Journal Batch Name" := JBatch;
            GenJournalLine."Document No." := CashierTrans.No;
            GenJournalLine."External Document No." := CashierTrans."Bankers Cheque No";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
            GenJournalLine."Account No." := CashierTrans."Account No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Description := CopyStr('Cancelled-' + CashierTrans."Transaction Description" + '-' + CashierTrans.Payee, 1, 50);
            GenJournalLine."Currency Code" := CashierTrans."Currency Code";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := -(CashierTrans.Amount);
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := JTemplate;
            GenJournalLine."Journal Batch Name" := JBatch;
            GenJournalLine."Document No." := CashierTrans.No;
            GenJournalLine."External Document No." := CashierTrans."Bankers Cheque No";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
            GenJournalLine."Account No." := ChBank;
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Description := CopyStr('Cancelled Bankers Cheque-' + CashierTrans.Payee + '-' + CashierTrans."Cheque No", 1, 50);
            GenJournalLine."Currency Code" := CashierTrans."Currency Code";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := CashierTrans.Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;



            //Charges
            TCharges := 0;
            GenSetup.Get;

            TransType.Reset;
            TransType.SetRange(TransType.Type, TransType.Type::"Cancel Bankers Cheque");
            if TransType.Find('-') then begin

                TransactionCharges.Reset;
                TransactionCharges.SetRange(TransactionCharges."Transaction Type", TransType.Code);
                if TransactionCharges.FindSet() then begin
                    repeat


                        LineNo := LineNo + 10000;

                        ChargeAmount := 0;
                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                            ChargeAmount := (CashierTrans.Amount * TransactionCharges."Percentage of Amount") * 0.01
                        else
                            ChargeAmount := TransactionCharges."Charge Amount";

                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin

                            TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                            TariffDetails.Reset;
                            TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                            if TariffDetails.FindSet() then begin
                                repeat
                                    if (CashierTrans.Amount >= TariffDetails."Lower Limit") and (CashierTrans.Amount <= TariffDetails."Upper Limit") then begin
                                        if TariffDetails."Use Percentage" = true then begin
                                            ChargeAmount := CashierTrans.Amount * TariffDetails.Percentage * 0.01;
                                        end else begin
                                            ChargeAmount := TariffDetails."Charge Amount";
                                        end;
                                    end;
                                until TariffDetails.Next = 0;
                            end;
                        end;



                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := JTemplate;
                        GenJournalLine."Journal Batch Name" := JBatch;
                        GenJournalLine."Document No." := CashierTrans.No;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                        GenJournalLine."Account No." := CashierTrans."Account No";
                        GenJournalLine."External Document No." := CashierTrans."ID No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := TransactionCharges.Description;
                        GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := ChargeAmount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;


                        //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                        if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                          (TransactionCharges."Recover Excise Duty" = true) then begin


                            //Excise Duty

                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := JTemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Document No." := CashierTrans.No;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                            GenJournalLine."Account No." := CashierTrans."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Excise Duty';
                            GenJournalLine."Currency Code" := CashierTrans."Currency Code";
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := GenSetup."Excise Duty G/L";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            TChargeAmount := TChargeAmount + ChargeAmount;
                        end;
                    until TransactionCharges.Next = 0;
                end;
            end;

            //Post New
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", JTemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
            end;
            //Post New

            Post := false;
            Post := JournlPosted.PostedSuccessfully();
            if Post then begin
                Posted := true;
                CashierTrans."Date Posted" := Today;
                CashierTrans."Time Posted" := Time;
                CashierTrans."Posted By" := UserId;
                CashierTrans.Modify;
                Commit;
            end;

            BRegister.Reset;
            BRegister.SetRange(BRegister."Cheque No.", CashierTrans."Bankers Cheque No");
            if BRegister.Find('-') then begin
                BRegister.Status := BRegister.Status::Cancelled;
                BRegister."Cancelled/Stopped By" := UserId;
                BRegister.Modify;
            end;

            if SavingsACC.Get(CashierTrans."Account No") then begin
                MobileNo := SavingsACC."Mobile Phone No";
            end;


            msg := Text0020 + Format(CashierTrans.Amount) + Text0021 + Text0011 +
                       Format(Today) + ' ' + Format(Time) + Text0012 + Text0013 + COMPANYNAME;

            SendSMS.SendSms(Source::CASH_WITHDRAWAL_CONFIRM, MobileNo, msg, Format(CashierTrans."Account No"), '', true, 0, false, 'CBS', CashierTrans."Account No", 'CBS');


        end;

    end;


    procedure CheckTillCurrency(BankAcc: Code[20]; CurrCode: Code[20])
    var
        BankAcct: Record "Bank Account";
    begin
        BankAcct.Reset;
        BankAcct.SetRange(BankAcct."No.", BankAcc);
        if BankAcct.Find('-') then begin
            if BankAcct."Currency Code" <> CurrCode then begin
                if BankAcct."Currency Code" = '' then
                    Error('This bank [%1:- %2] can only transact in LOCAL Currency', BankAcct."No.", BankAcct.Name)
                else
                    Error('This bank [%1:- %2] can only transact in %3', BankAcct."No.", BankAcct.Name, BankAcct."Currency Code");
            end;
        end;
    end;

    local procedure CheckBankersNo(ChequeNo: Code[20]; GlobalDim2: Code[20]; TAmount: Decimal)
    var
        Bregister: Record "Bankers Cheques Register";
    begin
        Bregister.Reset;
        Bregister.SetRange(Bregister.Status, Bregister.Status::Pending);
        //Bregister.SetRange(Bregister."Global Dimension 2 Code", GlobalDim2);
        Bregister.SetRange(Bregister."Cheque No.", ChequeNo);
        if Bregister.Find('-') = false then
            Error('Bankers cheque no has already been used');

        Bregister.Reset;
        Bregister.SetRange(Bregister.Status, Bregister.Status::Pending);
        //Bregister.SetRange(Bregister."Global Dimension 2 Code", GlobalDim2);
        Bregister.SetRange(Bregister."Cheque No.", ChequeNo);
        if Bregister.Find('-') then begin
            if Bregister."Leaf Limit Amount" < TAmount then
                Error('Bankers cheque amount cannot be more than the leaf limit of %1', Bregister."Leaf Limit Amount");
        end;
    end;


    procedure PostTransfers(ACTransfer: Record "Account Transfer Header")
    var
        Text0001: label 'Ensure the Transfer Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        Text0003: label 'Dear member, your erroneous refund of KES ';
        Text0004: label 'The transaction has already been posted.';
        BSched: Record "Account Transfer Source";
        BSchedDestin: Record "Account Transfer Destination";
        GenJournalLine: Record "Gen. Journal Line";
        TCharges: Decimal;
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        TChargeAmount: Decimal;
        Member: Record Members;
        MobNo: Code[20];
        Text0005: label ' has been credited to your FOSA Account';
        Employer: Record Customer;
        Loans: Record Loans;
        Text0006: label ', your account transfer of KES. ';
        Text0007: label ' has been effected on ';
        Text0008: label '. For any enquiry  kindly call ';
        Text0009: label ' on ';
        Text0010: label '. You may withdrawal via M-Sacco/ATM';
        RemainingAmount: Decimal;
        PrevPostedTransfers: Record "Account Transfer Source";
        MembAccounts: Text[2000];
        LoansII: record loans;
    begin
        // with ACTransfer do 
        begin

            //Cyrus
            if Posted = true then
                Error(Text0004);

            Temp.Get(UserId);

            Jtemplate := Temp."Transfer Journal Template";
            JBatch := Temp."Transfer Journal Batch";


            if Jtemplate = '' then begin
                Error(Text0001);
            end;

            if JBatch = '' then begin
                Error(Text0002);
            end;

            ACTransfer.TestField(Remarks);

            if ACTransfer."Total Debits" <> ACTransfer."Total Credits" then
                Error('Debits must be equal to credits, please cheque your schedule');

            if Confirm('Are you sure you want to transfer schedule?') then begin

                GenJournalLine.Reset;
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", Jtemplate);
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JBatch);
                GenJournalLine.DeleteAll;


                BSched.Reset;
                BSched.SetRange(BSched."No.", ACTransfer.No);
                BSched.setfilter("Source Amount", '>0');
                if BSched.FindSet() then begin
                    repeat

                        LineNo := LineNo + 10000;

                        // UPDATE Source Account
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := Jtemplate;
                        GenJournalLine."Journal Batch Name" := JBatch;
                        GenJournalLine."Document No." := ACTransfer.No;
                        GenJournalLine."External Document No." := BSched."External Document No.";
                        GenJournalLine."Line No." := LineNo;
                        if BSched."Source Account Type" = BSched."source account type"::Customer then begin
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                        end else
                            if BSched."Source Account Type" = BSched."source account type"::Credit then begin
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Credit;
                                GenJournalLine."Transaction Type" := BSched."Source Transaction Type";
                                GenJournalLine."Loan No" := BSched."Source Loan No.";
                            end else
                                //if enum maps directly
                                if BSched."Source Account Type" = BSched."source account type"::Vendor then begin
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                end else
                                    if BSched."Source Account Type" = BSched."source account type"::Savings then begin
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                    end else
                                        if BSched."Source Account Type" = BSched."source account type"::"G/L Account" then begin
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                        end else
                                            if BSched."Source Account Type" = BSched."source account type"::"Bank Account" then begin
                                                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                                            end;
                        GenJournalLine."Account No." := BSched."Source Account No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := ACTransfer."Transaction Date";
                        GenJournalLine."Shortcut Dimension 1 Code" := ACTransfer."Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code" := ACTransfer."Global Dimension 2 Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        // GenJournalLine.Description := PadStr(ACTransfer.Remarks + '-Destination Acc-' + BSchedDestin."Destination Account No.", 50);
                        GenJournalLine.Description := BSched."Source Description";
                        //GenJournalLine.Description:=BSched."Source Account Name";//Remarks;
                        GenJournalLine.Amount := BSched."Source Amount";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Fixed Deposit Contract" := BSched."Fixed Deposit Contract";
                        GenJournalLine."Transaction Type" := BSched."Source Transaction Type";
                        GenJournalLine."Loan No" := BSched."Source Loan No.";
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                    until BSched.Next = 0;
                end;



                BSchedDestin.Reset;
                BSchedDestin.SetRange(BSchedDestin."No.", ACTransfer.No);
                BSchedDestin.setfilter("Destination Amount", '>0');
                if BSchedDestin.FindSet() then begin
                    repeat
                        if (BSchedDestin."Destination Account Type" = BSchedDestin."destination account type"::credit) and (BSchedDestin."Destination Transaction Type" = BSchedDestin."destination transaction type"::Armotised) then begin
                            RemainingAmount := BSchedDestin."Destination Amount";
                            Loans.get(BSchedDestin."Destination Loan No.");
                            Loans.CalcFields("Daily Interest", "Outstanding Balance", "Outstanding Interest");
                            if Loans."Daily Interest" > 0 then begin
                                if ProductFactory.Get(Loans."Loan Product Type") then begin
                                    ProductFactory.TestField("Loan Interest Account [G/L]");
                                    if ProductFactory."Loan Interest Account [G/L]" <> '' then begin
                                        //Daily Interest Due
                                        LineNo := LineNo + 1;
                                        JournalPosting.PostJournal(JTemplate, JBatch, LineNo, "Gen. Journal Account Type"::Credit, ACTransfer.No, 'Daily Interest Capitalized ' + Loans."Loan No.", Loans."Daily Interest", Loans."Loan Account", ACTransfer."Transaction Date", "Gen. Journal Account Type"::"G/L Account",
                                        ProductFactory."Loan Interest Account [G/L]", Loans."Loan No.", ACTransfer."Global Dimension 1 Code", ACTransfer."Global Dimension 2 Code", GenJournalLine."Transaction Type"::"Interest Due", Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                    end
                                    else
                                        Error('The product you are trying to Armotize interest for %1, Does not have a valid Interest Receivable Account', Loans."Loan No.");
                                end else
                                    Dialog.Error('The product you are trying to Armotize interest for %1, Does not have a valid product in the setup', Loans."Loan No.");

                                LoansProcess.ClearDailyInterest(Loans."Loan No.");
                            end;
                            //Loans.Validate("Outstanding Interest");
                            // Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Daily Interest");
                            RemainingAmount := BSchedDestin."Destination Amount";

                            // Interest
                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Document No." := ACTransfer.No;
                            GenJournalLine."External Document No." := BSchedDestin."External Document No.";
                            GenJournalLine."Line No." := LineNo;


                            GenJournalLine."Account Type" := GenJournalLine."account type"::Credit;
                            GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Interest Paid";
                            GenJournalLine."Loan No" := BSchedDestin."Destination Loan No.";

                            GenJournalLine."Account No." := BSchedDestin."Destination Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := ACTransfer."Transaction Date";
                            GenJournalLine."Fixed Deposit Contract" := BSchedDestin."Fixed Deposit Contract";
                            GenJournalLine."Shortcut Dimension 1 Code" := ACTransfer."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code" := ACTransfer."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            //GenJournalLine.Description:=PADSTR(Remarks+':-Source Acc.'+BSched."Source Account No.",50);
                            //GenJournalLine.Description:=BSchedDestin."Destination Account Name";
                            BSched.Reset;
                            BSched.SetRange(BSched."No.", ACTransfer.No);
                            if BSched.Find('-') then
                                //GenJournalLine.Description := PadStr(ACTransfer.Remarks + ':-Source Acc.' + BSched."Source Account No.", 50);
                                GenJournalLine.Description := PadStr(BSchedDestin."Destination Description" + ':-Source Acc.' + BSched."Source Account No.", 50);
                            if RemainingAmount >= (Loans."Outstanding Interest" + Loans."Daily Interest") then begin
                                GenJournalLine.Amount := -(Loans."Outstanding Interest" + Loans."Daily Interest");
                                RemainingAmount := RemainingAmount - (Loans."Outstanding Interest" + Loans."Daily Interest");
                            end
                            else begin
                                GenJournalLine.Amount := -RemainingAmount;
                                RemainingAmount := 0;
                            end;
                            //GenJournalLine.Amount := -BSchedDestin."Destination Amount";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Loan No" := BSchedDestin."Destination Loan No.";
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            // Principal repayment

                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Document No." := ACTransfer.No;
                            GenJournalLine."External Document No." := BSchedDestin."External Document No.";
                            GenJournalLine."Line No." := LineNo;

                            GenJournalLine."Account Type" := GenJournalLine."account type"::Credit;
                            GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::Repayment;
                            GenJournalLine."Loan No" := BSchedDestin."Destination Loan No.";

                            GenJournalLine."Account No." := BSchedDestin."Destination Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := ACTransfer."Transaction Date";
                            GenJournalLine."Fixed Deposit Contract" := BSchedDestin."Fixed Deposit Contract";
                            GenJournalLine."Shortcut Dimension 1 Code" := ACTransfer."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code" := ACTransfer."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");


                            BSched.Reset;
                            BSched.SetRange(BSched."No.", ACTransfer.No);
                            if BSched.Find('-') then
                                //GenJournalLine.Description := PadStr(BSched."Source Description" + ':-Source Acc.' + BSched."Source Account No.", 50);
                                GenJournalLine.Description := PadStr(BSchedDestin."Destination Description" + ':-Source Acc.' + BSched."Source Account No.", 50);
                            GenJournalLine.Amount := -RemainingAmount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Loan No" := BSchedDestin."Destination Loan No.";
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                        end
                        else begin
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Document No." := ACTransfer.No;
                            GenJournalLine."External Document No." := BSchedDestin."External Document No.";
                            GenJournalLine."Line No." := LineNo;
                            if BSchedDestin."Destination Account Type" = BSchedDestin."destination account type"::Customer then begin
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                            end else
                                if BSchedDestin."Destination Account Type" = BSchedDestin."destination account type"::Credit then begin
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Credit;
                                    GenJournalLine."Transaction Type" := BSchedDestin."Destination Transaction Type";
                                    GenJournalLine."Loan No" := BSchedDestin."Destination Loan No.";
                                end else
                                    if BSchedDestin."Destination Account Type" = BSchedDestin."destination account type"::Vendor then begin
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    end else
                                        if BSchedDestin."Destination Account Type" = BSchedDestin."destination account type"::"G/L Account" then begin
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                        end else
                                            if BSchedDestin."Destination Account Type" = BSchedDestin."destination account type"::Savings then begin
                                                GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                            end else
                                                if BSchedDestin."Destination Account Type" = BSchedDestin."destination account type"::"Bank Account" then begin
                                                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                                                end;

                            GenJournalLine."Account No." := BSchedDestin."Destination Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := ACTransfer."Transaction Date";
                            GenJournalLine."Fixed Deposit Contract" := BSchedDestin."Fixed Deposit Contract";
                            GenJournalLine."Shortcut Dimension 1 Code" := ACTransfer."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code" := ACTransfer."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            //GenJournalLine.Description:=PADSTR(Remarks+':-Source Acc.'+BSched."Source Account No.",50);
                            //GenJournalLine.Description:=BSchedDestin."Destination Account Name";
                            BSched.Reset;
                            BSched.SetRange(BSched."No.", ACTransfer.No);
                            if BSched.Find('-') then
                                //GenJournalLine.Description := PadStr(ACTransfer.Remarks + ' :-Source Acc.' + BSched."Source Account No.", 50);
                                GenJournalLine.Description := PadStr(BSchedDestin."Destination Description" + ':-Source Acc.' + BSched."Source Account No.", 50);
                            GenJournalLine.Amount := -BSchedDestin."Destination Amount";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type" := BSchedDestin."Destination Transaction Type";
                            GenJournalLine."Loan No" := BSchedDestin."Destination Loan No.";
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                        end;
                    until BSchedDestin.Next = 0;
                end;

                //**************
                BSched.Reset;
                BSched.SetRange(BSched."No.", ACTransfer.No);
                BSched.SetRange(BSched."Source Account Type", BSched."source account type"::Savings);
                BSched.Setfilter("Source Amount", '>0');
                if BSched.FindSet() then begin
                    repeat
                        if SavingsACC.get(BSched."Source Account No.") then begin
                            if AccountTypes.Get(SavingsACC."Product Type") then begin
                                if AccountTypes."Account Transfer Charges" <> '' then begin

                                    if Format(AccountTypes."Account Transfer Charge Period") <> '' then begin

                                        PrevPostedTransfers.Reset;
                                        PrevPostedTransfers.setrange("Source Account No.", BSched."Source Account No.");
                                        PrevPostedTransfers.setcurrentkey("Date Posted");
                                        PrevPostedTransfers.SetAscending("Date Posted", false);
                                        PrevPostedTransfers.setrange(posted, true);
                                        if PrevPostedTransfers.find('-') then begin
                                            if calcdate(AccountTypes."Account Transfer Charge Period", PrevPostedTransfers."Date Posted") > ACTransfer."Transaction Date" then begin
                                                GenSetup.Get;
                                                //Charges
                                                TCharges := 0;

                                                //Account transfer Header -posted precviously for the account

                                                TransactionCharges.Reset;
                                                TransactionCharges.SetRange(TransactionCharges."Transaction Type", AccountTypes."Account Transfer Charges");
                                                if TransactionCharges.FindSet() then begin
                                                    repeat

                                                        if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) then begin
                                                            LineNo := LineNo + 10000;

                                                            ChargeAmount := 0;
                                                            if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                                                                ChargeAmount := (BSched."Source Amount" * TransactionCharges."Percentage of Amount") * 0.01
                                                            else
                                                                ChargeAmount := TransactionCharges."Charge Amount";

                                                            if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin

                                                                TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                                                                TariffDetails.Reset;
                                                                TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                                                if TariffDetails.FindSet() then begin
                                                                    repeat
                                                                        if (BSched."Source Amount" >= TariffDetails."Lower Limit") and (BSched."Source Amount" <= TariffDetails."Upper Limit") then begin
                                                                            if TariffDetails."Use Percentage" = true then begin
                                                                                ChargeAmount := BSched."Source Amount" * TariffDetails.Percentage * 0.01;
                                                                            end else begin
                                                                                ChargeAmount := TariffDetails."Charge Amount";
                                                                            end;
                                                                        end;
                                                                    until TariffDetails.Next = 0;
                                                                end;
                                                            end;


                                                            GenJournalLine.Init;
                                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                                            GenJournalLine."Journal Batch Name" := JBatch;
                                                            GenJournalLine."Document No." := ACTransfer.No;
                                                            GenJournalLine."Line No." := LineNo;
                                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                                            GenJournalLine."Account No." := BSched."Source Account No.";
                                                            GenJournalLine."External Document No." := BSched."External Document No.";
                                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                                            GenJournalLine."Posting Date" := ACTransfer."Transaction Date";
                                                            GenJournalLine.Description := TransactionCharges.Description;
                                                            //GenJournalLine."Currency Code":="Currency Code";
                                                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                                                            GenJournalLine.Amount := ChargeAmount;
                                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                            GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                                                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                                            GenJournalLine."Shortcut Dimension 1 Code" := ACTransfer."Global Dimension 1 Code";
                                                            GenJournalLine."Shortcut Dimension 2 Code" := ACTransfer."Global Dimension 2 Code";
                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                            if GenJournalLine.Amount <> 0 then
                                                                GenJournalLine.Insert;


                                                            //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                                                            if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty")
                                                              and (TransactionCharges."Recover Excise Duty" = true) then begin

                                                                //Excise Duty

                                                                LineNo := LineNo + 10000;

                                                                GenJournalLine.Init;
                                                                GenJournalLine."Journal Template Name" := Jtemplate;
                                                                GenJournalLine."Journal Batch Name" := JBatch;
                                                                GenJournalLine."Document No." := ACTransfer.No;
                                                                GenJournalLine."Line No." := LineNo;
                                                                GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                                                GenJournalLine."Account No." := BSched."Source Account No.";
                                                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                                                GenJournalLine."Posting Date" := ACTransfer."Transaction Date";
                                                                GenJournalLine.Description := (TransactionCharges.Description + ' Excise Duty');
                                                                //GenJournalLine."Currency Code":="Currency Code";
                                                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                                                GenJournalLine.Amount := (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                                                                GenJournalLine.Validate(GenJournalLine.Amount);
                                                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                                GenJournalLine."Bal. Account No." := GenSetup."Excise Duty G/L";
                                                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                                                GenJournalLine."Shortcut Dimension 1 Code" := ACTransfer."Global Dimension 1 Code";
                                                                GenJournalLine."Shortcut Dimension 2 Code" := ACTransfer."Global Dimension 2 Code";
                                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                                if GenJournalLine.Amount <> 0 then
                                                                    GenJournalLine.Insert;

                                                                TChargeAmount := TChargeAmount + ChargeAmount;
                                                            end;
                                                        end;
                                                    until TransactionCharges.Next = 0;
                                                end;
                                            end;
                                        end
                                    end;
                                end;
                            end;
                        end;

                    until BSched.Next = 0;
                end;

                //**************

                //Post
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                    ACTransfer.Posted := true;
                    ACTransfer.Modify;
                    ACTransfer."Time Posted" := time;
                    ACTransfer."Date Posted" := today;
                    Commit;

                    BSched.Reset;
                    BSched.SetRange(BSched."No.", ACTransfer.No);
                    BSched.setfilter("Source Amount", '>0');
                    if Bsched.FindSet() then begin
                        repeat
                            BSched."Posted" := true;
                            BSched."Date Posted" := today;
                            BSched.Modify;
                        until BSched.Next = 0;
                    end;
                    //Post




                    /*IF ACTransfer."Transaction Type"='ACCOUNT TRANSFERS' THEN BEGIN
                      IF Member.GET("Member No") THEN BEGIN
                        MobNo:=Member."Phone No.";
                         END;
                                  CALCFIELDS("Total Debits");
                      SendSMS.SendSms(SourceType::"InterAccount Transfer",MobNo,Text0003 +FORMAT("Total Debits")+Text0005+COMPANYNAME+' '
                        +FORMAT(TODAY)+' '+FORMAT(TIME) ,"Member No","Member No",FALSE);
                      END;*/
                end;
                CompanyInformation.Get;
                // if ACTransfer."Transaction Type" = 'ACCOUNT TRANSFERS' then begin

                BSched.Reset;
                BSched.SetRange(BSched."No.", ACTransfer.No);
                BSched.SetRange(BSched."Source Account Type", BSched."source account type"::Savings);
                //BSched.SetFilter(BSched."Source Amount", '>0');
                BSched.SetFilter("Source Amount", '>0');
                if BSched.Find('-') then begin
                    repeat
                        if Member.Get(BSched."Member No.") then begin
                            //if Member."Phone No." <> '' then begin
                            BSchedDestin.Reset;
                            BSchedDestin.SetRange(BSchedDestin."No.", ACTransfer.No);
                            BSchedDestin.SetFilter("Destination Amount", '>0');
                            if BSchedDestin.FindSet() then begin
                                MembAccounts := '';
                                repeat
                                    if BSchedDestin."destination account type" = BSchedDestin."destination account type"::Savings then begin
                                        if SavingsACC.Get(BSchedDestin."Destination Account No.") then begin
                                            if Memb.Get(SavingsACC."Member No.") then begin
                                                if Memb."Phone No." <> '' then begin
                                                    if not (Member."No." = Memb."No.") then begin
                                                        if Member."First Name" <> '' then begin
                                                            if Memb."First Name" <> '' then
                                                                msg := 'Dear ' + Memb."First Name" + ', ' + Member."First Name" + ' has transferred ' + Format(BSchedDestin."Destination Amount") + ' to your ' +
                                                                                                                                                                                       BSchedDestin."Product Name" + ' on ' + Format(Today) + ' ' + Format(Time)
                                                            else
                                                                msg := 'Dear ' + Memb.Name + ', ' + Member."First Name" + ' has transferred ' + Format(BSchedDestin."Destination Amount") + ' to your ' +
                                                                                                                                                                                           BSchedDestin."Product Name" + ' on ' + Format(Today) + ' ' + Format(Time)
                                                        end
                                                        else begin
                                                            if Memb."First Name" <> '' then
                                                                msg := 'Dear ' + Memb."First Name" + ', ' + Member.Name + ' has transferred ' + Format(BSchedDestin."Destination Amount") + ' to your ' +
                                                                                                                                                                                       BSchedDestin."Product Name" + ' on ' + Format(Today) + ' ' + Format(Time)
                                                            else
                                                                msg := 'Dear ' + Memb.Name + ', ' + Member.Name + ' has transferred ' + Format(BSchedDestin."Destination Amount") + ' to your ' +
                                                                                                                                                                                           BSchedDestin."Product Name" + ' on ' + Format(Today) + ' ' + Format(Time)

                                                            // msg := 'Dear ' + Memb."First Name" + ', ' + Member.Name + ' has transferred ' + Format(BSchedDestin."Destination Amount") + ' to your ' +
                                                            //                                                            BSchedDestin."Product Name" + ' on ' + Format(Today) + ' ' + Format(Time)

                                                        end;

                                                        SendSMS.SendSms(Source::INTERACCOUNT_TRANSFER, Memb."Phone No.", msg, Format(Memb."No."), '', true, 0, false, 'CBS', Memb."No.", 'CBS');

                                                        MembAccounts += format(BSchedDestin."Destination Amount") + ', to ' + Memb."First Name" + ' ' + BSchedDestin."Product Name";
                                                    end
                                                    else
                                                        MembAccounts += ', ' + format(BSchedDestin."Destination Amount") + ' to ' + BSchedDestin."Product Name";
                                                end;
                                            end;
                                        end;
                                    end
                                    else if BSchedDestin."destination account type" = BSchedDestin."destination account type"::Credit then begin
                                        if LoansII.Get(BSchedDestin."Destination Loan No.") then begin
                                            if Memb.Get(LoansII."Member No.") then
                                                if Memb."Phone No." <> '' then
                                                    if not (Member."No." = Memb."No.") then begin
                                                        if ACTransfer."Recover Arrears" then begin
                                                            if Member."First Name" <> '' then
                                                                msg := 'Dear ' + Memb."First Name" + ', ' + Member."First Name" + ' has recovered arrears of ' + Format(BSchedDestin."Destination Amount") + ' to your ' +
                                                                    BSchedDestin."Product Name" + ' on ' + Format(Today) + ' ' + Format(Time)
                                                            else
                                                                msg := 'Dear ' + Memb."First Name" + ', ' + Member.Name + ' has recovered arrears of ' + Format(BSchedDestin."Destination Amount") + ' to your ' +
                                                                    BSchedDestin."Product Name" + ' on ' + Format(Today) + ' ' + Format(Time);
                                                        end else begin
                                                            if Member."First Name" <> '' then
                                                                msg := 'Dear ' + Memb."First Name" + ', ' + Member."First Name" + ' has transferred ' + Format(BSchedDestin."Destination Amount") + ' to your ' +
                                                                    BSchedDestin."Product Name" + ' on ' + Format(Today) + ' ' + Format(Time)
                                                            else
                                                                msg := 'Dear ' + Memb."First Name" + ', ' + Member.Name + ' has transferred ' + Format(BSchedDestin."Destination Amount") + ' to your ' +
                                                                    BSchedDestin."Product Name" + ' on ' + Format(Today) + ' ' + Format(Time);
                                                        end;

                                                        SendSMS.SendSms(Source::INTERACCOUNT_TRANSFER, Memb."Phone No.", msg, Format(Memb."No."), '', true, 0, false, 'CBS', Memb."No.", 'CBS');

                                                        MembAccounts += format(BSchedDestin."Destination Amount") + ', to ' + Memb."First Name" + ' ' + BSchedDestin."Product Name";
                                                    end
                                                    else
                                                        MembAccounts += ' ' + format(BSchedDestin."Destination Amount") + ' to ' + BSchedDestin."Product Name";
                                        end;
                                    end;

                                until BSchedDestin.next = 0;
                                if Member."First Name" <> '' then begin
                                    if ACTransfer."Recover Arrears" then
                                        msg := 'Dear ' + Member."First Name" + ', arrears of ' + format(BSchedDestin."Destination Amount") + ' has been recovered for ' + BSchedDestin."Product Name" + ': ' + BSchedDestin."Destination Loan No." + ' on ' + Format(Today) + ' ' + Format(Time)
                                    // msg := 'Dear ' + Member."First Name" + ', you have recovered arrears: ' + MembAccounts + ' from ' + BSched."Product Name" + ' on ' + Format(Today) + ' ' + Format(Time)
                                    else
                                        msg := 'Dear ' + Member."First Name" + ', you have successfully transferred ' + MembAccounts + ' from ' + BSched."Product Name" + ' on ' + Format(Today) + ' ' + Format(Time)
                                end
                                else begin
                                    if ACTransfer."Recover Arrears" then
                                        msg := 'Dear ' + Member."First Name" + ', arrears of ' + format(BSchedDestin."Destination Amount") + ' has been recovered for ' + BSchedDestin."Product Name" + ': ' + BSchedDestin."Destination Loan No." + ' on ' + Format(Today) + ' ' + Format(Time)
                                    // msg := 'Dear ' + Member.Name + ', you have recovered arrears: ' + MembAccounts + ' from ' + BSched."Product Name" + ' on ' + Format(Today) + ' ' + Format(Time)
                                    else
                                        msg := 'Dear ' + Member.Name + ', you have successfully transferred ' + MembAccounts + ' from ' + BSched."Product Name" + ' on ' + Format(Today) + ' ' + Format(Time);
                                end;
                                SendSMS.SendSms(Source::INTERACCOUNT_TRANSFER, Member."Phone No.", msg, Format(Member."No."), '', true, 0, false, 'CBS', Member."No.", 'CBS');
                            end;
                        end;
                    until BSched.next = 0;
                end;

            end;
        end;
    end;


    procedure ChequeDiscounting(CashierTrans: Record "Cashier Transactions")
    var
        Text0001: label 'Ensure the Cheque Discounting Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cheque Discounting Batch is set up in Banking User Setup';
        GenJournalLine: Record "Gen. Journal Line";
        Loans: Record Loans;
        ProdF: Record "Product Factory";
        LoanProcess: Codeunit "Loans Process";
        AcctsNo: Code[20];
        Accounts: Record "Credit Accounts";
        LnAccount: Code[20];
        ProdType: Record "Product Factory";
    begin
        //with CashierTrans do
        begin

            Temp.Get(UserId);
            GenSetup.Get;


            Jtemplate := Temp."Cheque Discounting Template";
            JBatch := Temp."Cheque Discounting Batch";


            if Jtemplate = '' then begin
                Error(Text0001);
            end;

            if JBatch = '' then begin
                Error(Text0002);
            end;

            if CashierTrans.Type <> CashierTrans.Type::"Cheque Deposit" then
                Error('You can only discount cheques.');

            if CashierTrans."Cheque Status" <> CashierTrans."cheque status"::Pending then
                Error('Cheque already processed.');

            if CashierTrans."Discounting Amount" < 1 then
                Error('Please enter the amount you want to discount.');


            if Confirm('Are you sure you want to discount this cheque?', true) = false then
                exit;

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            GenJournalLine.DeleteAll;


            Loans.Reset;
            Loans.SetRange(Loans.Remarks, CashierTrans.No);
            Loans.SetRange(Loans."Member No.", CashierTrans."Member No.");
            Loans.SetRange(Loans.Posted, false);
            if Loans.Find('-') then
                Loans.DeleteAll;




            Loans."Loan No." := '';
            Loans."Member No." := CashierTrans."Member No.";
            Loans."Disbursement Account No" := CashierTrans."Account No";

            //fetch Cheque Discounting Product
            ProdF.Reset;
            ProdF.SetRange(ProdF."Type of Discounting", ProdF."type of discounting"::"Cheque Discounting");
            ProdF.SetRange(ProdF."Product Class Type", ProdF."product class type"::Loan);
            if ProdF.Find('-') then begin
                Loans."Loan Product Type" := ProdF."Product ID";
                AcctsNo := ProdF."Account No. Prefix" + CashierTrans."Member No.";
            end;
            //fetch Cheque Discounting Product

            if Accounts.Get(AcctsNo) = false then begin
                AcctsNo := LoanProcess.CreateLoanAccount(CashierTrans."Member No.", ProdF."Product ID");

                Loans."Loan Account" := AcctsNo;
            end else
                Loans."Loan Account" := AcctsNo;
            Loans."Application Date" := Today;
            Loans.Interest := ProdF."Interest Rate (Min.)";
            Loans."Requested Amount" := CashierTrans."Discounting Amount";
            Loans."Approved Amount" := CashierTrans."Discounting Amount";
            Loans.Status := Loans.Status::Approved;
            Loans."Disbursement Date" := Today;
            Loans.Remarks := CashierTrans.No;
            Loans.Insert(true);



            Loans.Reset;
            Loans.SetRange(Loans.Remarks, CashierTrans.No);
            Loans.SetRange(Loans."Member No.", CashierTrans."Member No.");
            Loans.SetRange(Loans.Posted, false);
            if Loans.Find('-') then begin

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := Jtemplate;
                GenJournalLine."Journal Batch Name" := JBatch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := Loans."Loan No.";
                GenJournalLine."Posting Date" := Today;
                GenJournalLine."External Document No." := CashierTrans.No;
                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Credit;
                GenJournalLine."Account No." := Loans."Loan Account";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine.Description := 'Principle Amount';
                GenJournalLine.Amount := CashierTrans."Discounting Amount";
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                GenJournalLine."Loan No" := Loans."Loan No.";
                GenJournalLine."Shortcut Dimension 1 Code" := CashierTrans."Global Dimension 1 Code";
                GenJournalLine."Shortcut Dimension 2 Code" := CashierTrans."Global Dimension 2 Code";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;


                Loans.Posted := true;
                Loans.Modify;

                //Discount
                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := Jtemplate;
                GenJournalLine."Journal Batch Name" := JBatch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := Loans."Loan No.";
                GenJournalLine."Posting Date" := Today;
                GenJournalLine."External Document No." := CashierTrans."Cheque No";
                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Savings;
                GenJournalLine."Account No." := CashierTrans."Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine.Description := 'Discounted Cheque';
                GenJournalLine.Amount := -(CashierTrans."Discounting Amount");
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := CashierTrans."Global Dimension 1 Code";
                GenJournalLine."Shortcut Dimension 2 Code" := CashierTrans."Global Dimension 2 Code";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //Discounting Commision
                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := Jtemplate;
                GenJournalLine."Journal Batch Name" := JBatch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := Loans."Loan No.";
                GenJournalLine."Posting Date" := Today;
                GenJournalLine."External Document No." := CashierTrans."Cheque No";
                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Savings;
                GenJournalLine."Account No." := CashierTrans."Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine.Description := 'Discounting Commission';
                GenJournalLine.Amount := ROUND(CashierTrans."Discounting Amount" * (Loans.Interest / 100), 0.01, '>');
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := CashierTrans."Global Dimension 1 Code";
                GenJournalLine."Shortcut Dimension 2 Code" := CashierTrans."Global Dimension 2 Code";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;


                //Interest
                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := Jtemplate;
                GenJournalLine."Journal Batch Name" := JBatch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Credit;
                GenJournalLine."Account No." := Loans."Loan Account";
                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Due";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := Loans."Loan No.";
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := 'Interest Due';
                GenJournalLine.Amount := ROUND(CashierTrans."Discounting Amount" * (Loans.Interest / 100), 0.01, '>');
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                if ProdType.Get(Loans."Loan Product Type") then
                    GenJournalLine."Bal. Account No." := ProdType."Loan Receivable Account[G/L]";
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Loan No" := Loans."Loan No.";
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;


                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := Jtemplate;
                GenJournalLine."Journal Batch Name" := JBatch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := Loans."Loan No.";
                GenJournalLine."Posting Date" := Today;
                GenJournalLine."External Document No." := CashierTrans.No;
                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Credit;
                GenJournalLine."Account No." := Loans."Loan Account";
                ;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine.Description := 'Interest Paid';
                GenJournalLine.Amount := -ROUND(CashierTrans."Discounting Amount" * (Loans.Interest / 100), 0.01, '>');
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                GenJournalLine."Loan No" := Loans."Loan No.";
                GenJournalLine."Shortcut Dimension 1 Code" := CashierTrans."Global Dimension 1 Code";
                GenJournalLine."Shortcut Dimension 2 Code" := CashierTrans."Global Dimension 2 Code";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;




                //Post New
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                end;
                //Post New

                CashierTrans."Discounted Amount" := CashierTrans."Discounted Amount" + CashierTrans."Discounting Amount";
                CashierTrans."Discounting Amount" := 0;
                CashierTrans.Modify;

            end;
        end;
    end;

    local procedure PostLien(CashierTrans: Record "Cashier Transactions")
    var
        GenSetup: Record "General Set-Up";
        Acc: Record "Savings Accounts";
        BankSetup: Record "Banking User Template";
        BankAccount: Record "Bank Account";
        CurrentTellerAmount: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        TCharges: Decimal;
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        TChargeAmount: Decimal;
        Account: Record "Savings Accounts";
        AccountTypes: Record "Product Factory";
        Text0001: label 'This account has been blocked from receiving payments.';
        Text0002: label 'You need to add more money from the treasury since your balance has gone below the teller replenishing level.';
        Text0003: label 'You do not have enough money to carry out this transaction.';
        Text0004: label 'You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.';
        Text0005: label 'You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.';
        Text0006: label 'You cannot withdraw more than your allowed limit of %1 unless authorised.';
        Text0007: label 'You cannot withdraw more than the available balance unless authorised.';
        Text0008: label 'You cannot deposit more than your allowed limit of %1 unless authorised.';
        VarVariant: Variant;
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        Trans: Record "Cashier Transactions";
        ProdType: Record "Product Factory";
        TransType: Record "Transaction Types";
    begin

        // with CashierTrans do
        begin

            if Confirm('Are you sure you want to place lien on this account? ', false) = true then begin

                CashierTrans.Posted := true;
                CashierTrans."Date Posted" := Today;
                CashierTrans."Time Posted" := Time;
                CashierTrans."Posted By" := UserId;
                CashierTrans.Modify;

                Message('Lien placed successfully');
            end;
        end;
    end;


    procedure ClearLien()
    var
        Transactions: Record "Cashier Transactions";
        GenJournalLine: Record "Gen. Journal Line";
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        TCharges: Decimal;
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        TChargeAmount: Decimal;
        Loans: Record Loans;
    begin
        Temp.Get(UserId);
        GenSetup.Get;


        Jtemplate := Temp."Cashier Journal Template";
        JBatch := Temp."Cashier Journal Batch";


        if Jtemplate = '' then begin
            Error(Text0001);
        end;

        if JBatch = '' then begin
            Error(Text0002);
        end;


        Transactions.Reset;
        Transactions.SetRange(Transactions."Cheque Status", Transactions."cheque status"::Pending);
        Transactions.SetRange(Transactions.Type, Transactions.Type::Lien);
        if Transactions.FindSet() then begin
            repeat

                if Transactions."Expected Maturity Date" <= Today then begin


                    Transactions."Cheque Status" := Transactions."cheque status"::Honoured;
                    Transactions."Date Cleared" := Today;
                    Transactions."Cleared By" := UserId;
                    Transactions.Modify;

                end;

            until Transactions.Next = 0;
        end;
    end;


    procedure PostBankChequeCharges(BankCheque: Record "Cheque Book Application")
    var
        TCharges: Decimal;
        TransactionCharges: Record "Transaction Charges";
        LineNo: Integer;
        TariffDetails: Record "Tiered Charges Lines";
        ChargeAmount: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        AvailBal: Decimal;
        MinBalance: Decimal;
        Account: Record "Savings Accounts";
        ProdType: Record "Product Factory";
        Vend: Record "Savings Accounts";
        MobNo: Code[20];
        Text0003: label 'Your account has insufficient funds to cater for cheque book charges ';
    begin
        //with BankCheque do
        begin

            Temp.Get(UserId);
            GenSetup.Get;


            Jtemplate := Temp."Cashier Journal Template";
            JBatch := Temp."Cashier Journal Batch";


            if Jtemplate = '' then begin
                Error(Text0001);
            end;

            if JBatch = '' then begin
                Error(Text0002);
            end;



            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            GenJournalLine.DeleteAll;
            //Charges
            TCharges := 0;

            TransactionCharges.Reset;
            TransactionCharges.SetRange(TransactionCharges."Transaction Type", BankCheque."Transaction Type");
            if TransactionCharges.FindSet() then begin
                repeat

                    if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) or
                    (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::"Stamp Duty") then begin

                        LineNo := LineNo + 10000;

                        ChargeAmount := 0;
                        //IF TransactionCharges."Charge Type"=TransactionCharges."Charge Type"::"% of Amount" = TRUE THEN
                        //ChargeAmount:=(Amount*TransactionCharges."Percentage of Amount")*0.01
                        //ELSE
                        ChargeAmount := TransactionCharges."Charge Amount";

                        /*
                        IF TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered THEN BEGIN

                        TransactionCharges.TESTFIELD(TransactionCharges."Staggered Charge Code");

                        TariffDetails.RESET;
                        TariffDetails.SETRANGE(TariffDetails.Code,TransactionCharges."Staggered Charge Code");
                        IF TariffDetails.FindSet() THEN BEGIN
                        REPEAT
                        IF (Amount >= TariffDetails."Lower Limit") AND (Amount <= TariffDetails."Upper Limit") THEN BEGIN
                        IF TariffDetails."Use Percentage"=TRUE THEN BEGIN
                          ChargeAmount:=Amount*TariffDetails.Percentage*0.01;
                        END ELSE BEGIN
                        ChargeAmount := TariffDetails."Charge Amount";
                        END;
                        END;
                        UNTIL TariffDetails.NEXT =0;
                        END;
                        END;
                        */

                        //cheque available balance
                        AvailBal := 0;
                        MinBalance := 0;

                        if Account.Get(BankCheque."Account No.") then begin
                            Account.CalcFields(Account.Balance, Account."Uncleared Cheques", Account."Authorised Over Draft", Account."Lien Placed");

                            ProdType.Reset;
                            ProdType.SetRange(ProdType."Product ID", Account."Product Type");
                            if ProdType.Find('-') then begin
                                MinBalance := ProdType."Minimum Balance";

                                AvailBal := (Account.Balance + Account."Authorised Over Draft") - (MinBalance + Account."Uncleared Cheques" + Account."Lien Placed");

                                if AvailBal < ChargeAmount then
                                    Error('The transaction will result in overdrawing account %1', BankCheque."Account No.");
                                MobNo := '';

                                if Vend.Get(BankCheque."Account No.") then begin
                                    MobNo := Vend."Transactional Mobile No";
                                end;

                                SendSMS.SendSms(Source::"CHQ BOOK", MobNo, msg, Format(BankCheque."No."), '', true, 0, false, 'CBS', BankCheque."No.", 'CBS');

                            end;
                        end;
                        //cheque available balance


                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := Jtemplate;
                        GenJournalLine."Journal Batch Name" := JBatch;
                        GenJournalLine."Document No." := BankCheque."No.";
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                        GenJournalLine."Account No." := BankCheque."Account No.";
                        GenJournalLine."External Document No." := BankCheque."ID No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := TransactionCharges.Description;
                        //GenJournalLine."Currency Code":="Currency Code";
                        //GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := ChargeAmount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        //GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                        //GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                        //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;


                        //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                        if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                          (TransactionCharges."Recover Excise Duty" = true) then begin


                            //Excise Duty

                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Document No." := BankCheque."No.";
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                            GenJournalLine."Account No." := BankCheque."Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := Today;//"Transaction Date";
                            GenJournalLine.Description := 'Excise Duty';
                            //GenJournalLine."Currency Code":="Currency Code";
                            //GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := GenSetup."Excise Duty G/L";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            //GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            //GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;


                        end;
                    end;
                until TransactionCharges.Next = 0;
            end;

            //Post New
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
            end;
            //Post New


            BankCheque."Cheque Book charges Posted" := true;
            BankCheque.Modify;

            Message('Charges posted successfully');

        end;

    end;

    local procedure "**********Salary Processing***********"()
    begin
    end;

    procedure PostSalaryLineByLine(SalHeaD: Record "Salary Header")
    var
        SalLines: Record "Salary Lines";
        GenJournalLine: Record "Gen. Journal Line";
        Temp: Record "Banking User Template";
        Jtemplate: Code[20];
        JBatch: Code[20];
        Text0001: label 'Ensure the Salary  Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Salary Journal Batch is set up in Banking User Setup';
        Text0003: label 'Ensure the Default Bank is set up in User Setup';
        Text0004: label 'The transaction has already been posted.';
        RunBal: Decimal;
        Gensetup: Record "General Set-Up";
        LineNo: Integer;
        PDate: Date;
        DocNo: Code[20];
        PostingRemarks: Text[500];
        DActivity2: Code[20];
        DBranch2: Code[20];
        Account: Record "Savings Accounts";
        AvailableBal: Decimal;
        ProductF: Record "Product Factory";
        SalFee: Decimal;
        SalProcessingHeader: Record "Salary Header";
        SalGLAccount: Code[20];
        TCharges: Decimal;
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        MemberNo: Code[20];
        Salaccno: Code[20];
        Text0005: label 'Your Salary of KES ';
        Text0006: label ' has been credited to your Ordinary account ';
        Text0007: label ' on ';
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        Text0008: Text;
        WasBlocked: Boolean;
        GlobalFunctions: codeunit "Global Functions";
    begin
        //with SalHeaD do
        begin
            if Posted = true then
                Error(Text0004);

            // IF SalProcessingHeader.Status<>SalProcessingHeader.Status::Approved THEN
            // ERROR('The document is not fully approved');
            Temp.SetLoadFields(UserID, "Salary Journal Template", "Salary Journal Batch");
            Temp.Get(UserId);
            Jtemplate := Temp."Salary Journal Template";
            JBatch := Temp."Salary Journal Batch";

            if Jtemplate = '' then begin
                Error(Text0001);
            end;

            if JBatch = '' then begin
                Error(Text0002);
            end;

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            GenJournalLine.DeleteAll;

            SalHeaD.CalcFields("Total Count", "Scheduled Amount");
            RunBal := 0;
            Gensetup.setloadfields("Excise Duty G/L", "Excise Duty (%)");
            Gensetup.Get;
            //LineNo := LineNo + 10000;
            //TotSal:=TotSal+SalLines.Amount;
            SalHeaD.TestField(Remarks);
            if SalHeaD."Income Type" <> SalHeaD."Income Type"::SAYE then
                SalHeaD.TestField("Document No");
            SalHeaD.TestField("Posting date");
            SalHeaD.TestField(Amount);
            if SalHeaD."Scheduled Amount" <> SalHeaD.Amount then
                Error('Scheduled amount and Amount must be the same');

            PDate := SalHeaD."Posting date";
            DocNo := SalHeaD."Document No";
            PostingRemarks := SalHeaD.Remarks;
            // if Confirm('Are you sure you want to post Salaries?', false) = false then
            //     exit;
            //Check Posted

            SalLines.Reset();
            SalLines.SetRange(SalLines."Salary Header No.", SalHeaD.No);
            SalLines.SetRange(Posted, false);
            SalLines.setrange("Paid Within Month", false);
            SalLines.setrange("Account Not Found", false);
            SalLines.setrange("Multiple Salary", false);

            if SalLines.FindSet() then begin
                repeat
                    SavingsLedgerEntry.SetCurrentKey("Document No.", "Posting Date", "Customer No.");
                    SavingsLedgerEntry.SetRange("Document No.", SalLines."Document No.");
                    SavingsLedgerEntry.SetRange("Posting Date", PDate);
                    SavingsLedgerEntry.SetRange("Customer No.", SalLines."Account No.");
                    SavingsLedgerEntry.SetLoadFields("Entry No.");
                    if SavingsLedgerEntry.FindFirst() then begin
                        if not SalLines.Posted then begin
                            SalLines.Posted := true;
                            SalLines.Modify(false);
                        end;
                    end;

                until SalLines.Next() = 0;
            end;

            //Check Posted

            SalLines.Reset;
            SalLines.SetRange(SalLines."Salary Header No.", SalHeaD.No);
            SalLines.SetRange(Posted, false);
            if SalLines.FindSet() then begin
                repeat
                    LineNo += 1;
                    MemberNo := '';
                    Salaccno := '';
                    MemberNo := SalLines."Member No.";
                    Salaccno := SalLines."Account No.";

                    // GenJournalLine.Reset;
                    // GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                    // GenJournalLine.SetRange("Journal Batch Name", JBatch);
                    // GenJournalLine.DeleteAll;
                    //BlockUblock
                    // WasBlocked := false;
                    Account.SetLoadFields("No.", "Customer Posting Group", "Global Dimension 1 Code", "Global Dimension 2 Code");
                    if Account.Get(SalLines."Account No.") then begin
                        if Account."Customer Posting Group" <> '' then begin
                            //     if Account.Blocked <> Account.Blocked::" " then begin
                            //         BlockUblock(Account."No.", true);
                            //         wasBlocked := true;
                            //     end;

                            DActivity2 := Account."Global Dimension 1 Code";
                            DBranch2 := Account."Global Dimension 2 Code";

                            //Check Account Bal
                            // AvailableBal := 0;
                            //Account.CalcFields(Account.Balance, Account."Authorised Over Draft", Account."Uncleared Cheques");

                            // AvailableBal := ((Account.Balance + Account."Authorised Over Draft") - (Account."ATM Transactions" + Account."Uncleared Cheques"));
                            //if ProductF.Get(Account."Product Type") then
                            //    AvailableBal := AvailableBal - ProductF."Minimum Balance";

                            //RunBal := AvailableBal + SalLines.Amount;
                            RunBal := SalLines.Amount;

                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Line No." := LineNo;

                            // if SalHeaD."Income Type" <> SalHeaD."Income Type"::SAYE then
                            GenJournalLine."Document No." := CopyStr(DocNo, 1, 20);
                            // else
                            //     GenJournalLine."Document No." := CopyStr(SalLines."Document No.", 1, 20);
                            GenJournalLine."External Document No." := SalLines."Staff No.";
                            GenJournalLine."Posting Date" := PDate;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                            GenJournalLine."Account No." := SalLines."Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description := PostingRemarks;
                            GenJournalLine.Amount := -SalLines.Amount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert(false);

                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;//USERID;
                            GenJournalLine."Line No." := LineNo;

                            // if SalHeaD."Income Type" <> SalHeaD."Income Type"::SAYE then
                            GenJournalLine."Document No." := CopyStr(DocNo, 1, 20);
                            // else
                            //     GenJournalLine."Document No." := CopyStr(SalLines."Document No.", 1, 20);
                            GenJournalLine."External Document No." := SalLines."Staff No.";
                            GenJournalLine."Posting Date" := PDate;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description := PostingRemarks;//'Salary';
                            GenJournalLine."Account Type" := SalHeaD."Account Type";
                            GenJournalLine."Account No." := SalHeaD."Account No";
                            GenJournalLine.Amount := SalLines.Amount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert(false);

                            //Charges
                            TCharges := 0;
                            TransactionCharges.Reset;
                            TransactionCharges.SetRange(TransactionCharges."Transaction Type", SalHeaD."Transaction Type");
                            if TransactionCharges.FindSet() then begin
                                repeat
                                    LineNo := LineNo + 10000;
                                    ChargeAmount := 0;
                                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                                        ChargeAmount := (SalLines.Amount * TransactionCharges."Percentage of Amount") * 0.01
                                    else
                                        ChargeAmount := TransactionCharges."Charge Amount";
                                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                                        TariffDetails.Reset;
                                        TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                        if TariffDetails.FindSet() then begin
                                            repeat
                                                if (SalLines.Amount >= TariffDetails."Lower Limit") and (SalLines.Amount <= TariffDetails."Upper Limit") then begin
                                                    if TariffDetails."Use Percentage" = true then begin
                                                        ChargeAmount := SalLines.Amount * TariffDetails.Percentage * 0.01;
                                                    end else begin
                                                        ChargeAmount := TariffDetails."Charge Amount";
                                                    end;
                                                end;
                                            until TariffDetails.Next = 0;
                                        end;
                                    end;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := JBatch;
                                    GenJournalLine."Document No." := CopyStr(DocNo, 1, 20);

                                    // if SalHeaD."Income Type" <> SalHeaD."Income Type"::SAYE then
                                    //     GenJournalLine."Document No." := CopyStr(DocNo, 1, 14)
                                    // else
                                    //     GenJournalLine."Document No." := CopyStr(SalLines."Document No.", 1, 20);

                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                    GenJournalLine."Account No." := SalLines."Account No.";
                                    //GenJournalLine."External Document No.":="ID No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := PDate;
                                    GenJournalLine.Description := TransactionCharges.Description;
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := ChargeAmount;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert(false);
                                    RunBal := RunBal - GenJournalLine.Amount;

                                    //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                                    if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                    (TransactionCharges."Recover Excise Duty" = true) then begin
                                        //Excise Duty
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Journal Batch Name" := JBatch;

                                        //if SalHeaD."Income Type" <> SalHeaD."Income Type"::SAYE then
                                        GenJournalLine."Document No." := CopyStr(DocNo, 1, 20);
                                        // else
                                        //     GenJournalLine."Document No." := CopyStr(SalLines."Document No.", 1, 20);

                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                        GenJournalLine."Account No." := SalLines."Account No.";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := PDate;
                                        GenJournalLine.Description := TransactionCharges.Description + ' Excise Duty.';
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        GenJournalLine.Amount := (ChargeAmount * Gensetup."Excise Duty (%)") * 0.01;
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := Gensetup."Excise Duty G/L";
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert(false);
                                        RunBal := RunBal - GenJournalLine.Amount;

                                        TCharges := TCharges + ChargeAmount;
                                    end;
                                until TransactionCharges.Next = 0;
                            end;

                            //--Activate Dormant.
                            // if Account.Status = Account.Status::Dormant then
                            //    ActivateDormant(SalHeaD, DocNo, PDate, DActivity2, DBranch2, Jtemplate, JBatch, RunBal, MemberNo, LineNo, Salaccno);

                            // SMS Charges here
                            if Gensetup."Disable Salary SMS" = false then begin
                                TransactionCharges.Reset;
                                TransactionCharges.SetRange(TransactionCharges."Transaction Type", SalHeaD."SMS Charge");
                                if TransactionCharges.FindSet() then begin
                                    repeat
                                        LineNo := LineNo + 10000;
                                        ChargeAmount := 0;
                                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                                            ChargeAmount := (SalLines.Amount * TransactionCharges."Percentage of Amount") * 0.01
                                        else
                                            ChargeAmount := TransactionCharges."Charge Amount";
                                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                                            TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                                            TariffDetails.Reset;
                                            TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                            if TariffDetails.FindSet() then begin
                                                repeat
                                                    if (SalLines.Amount >= TariffDetails."Lower Limit") and (SalLines.Amount <= TariffDetails."Upper Limit") then begin
                                                        if TariffDetails."Use Percentage" = true then begin
                                                            ChargeAmount := SalLines.Amount * TariffDetails.Percentage * 0.01;
                                                        end else begin
                                                            ChargeAmount := TariffDetails."Charge Amount";
                                                        end;
                                                    end;
                                                until TariffDetails.Next = 0;
                                            end;
                                        end;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Journal Batch Name" := JBatch;
                                        GenJournalLine."Document No." := CopyStr(DocNo, 1, 20);
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                        GenJournalLine."Account No." := SalLines."Account No.";
                                        //GenJournalLine."External Document No.":="ID No";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := PDate;
                                        GenJournalLine.Description := TransactionCharges.Description;
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        GenJournalLine.Amount := ChargeAmount;
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert(false);
                                        RunBal := RunBal - GenJournalLine.Amount;

                                        //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                                        if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                        (TransactionCharges."Recover Excise Duty" = true) then begin
                                            //Excise Duty
                                            LineNo := LineNo + 10000;
                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                            GenJournalLine."Journal Batch Name" := JBatch;

                                            //if SalHeaD."Income Type" <> SalHeaD."Income Type"::SAYE then
                                            GenJournalLine."Document No." := CopyStr(DocNo, 1, 20);
                                            // else
                                            //     GenJournalLine."Document No." := CopyStr(SalLines."Document No.", 1, 20);

                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                            GenJournalLine."Account No." := SalLines."Account No.";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            GenJournalLine."Posting Date" := PDate;
                                            GenJournalLine.Description := TransactionCharges.Description + ' Excise Duty.';
                                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                                            GenJournalLine.Amount := (ChargeAmount * Gensetup."Excise Duty (%)") * 0.01;
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                            GenJournalLine."Bal. Account No." := Gensetup."Excise Duty G/L";
                                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert(false);
                                            RunBal := RunBal - GenJournalLine.Amount;
                                        end;
                                    until TransactionCharges.Next = 0;
                                end;
                            end;

                            // Take all amount even already in FOSA
                            if Account.GetAvailableBalance(Account."No.") > 0 then
                                RunBal := RunBal + Account.GetAvailableBalance(Account."No.");

                            if SalHeaD."Income Type" <> SalHeaD."Income Type"::SAYE then
                                PostSalaryLoans(SalHeaD, DocNo, PDate, DActivity2, DBranch2, Jtemplate, JBatch, RunBal, MemberNo, LineNo, Salaccno);

                            // if Account.Get(SalLines."Account No.") then begin
                            //     if Account."Loan Disbursement Account" = false then begin
                            //         Account."Loan Disbursement Account" := true;
                            //         Account.Modify;
                            //     end;
                            // end;


                            // GenJournalLine.Reset;
                            // GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                            // GenJournalLine.SetRange("Journal Batch Name", JBatch);
                            // if GenJournalLine.Find('-') then begin
                            //     Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                            // end;

                            //BlockUblock
                            // if wasBlocked = true then
                            //   BlockUblock(Account."No.", false);

                            // SalLines.Posted := true;
                            // SalLines."Posted By" := UserId;
                            // SalLines."Posting Date" := Today;
                            // SalLines."Posting Time" := Time;
                            // SalLines."Income Type" := SalHeaD."Income Type";
                            // SalLines.Modify;
                            // Commit;//*
                            // if Gensetup."Disable Salary SMS" = false then begin
                            //     Account.setloadfields("Mobile Phone No", "Member No.");
                            //     if Account.Get(SalLines."Account No.") then begin
                            //         MobileNo := Account."Transactional Mobile No";
                            //         if MobileNo = '' then begin
                            //             if Memb.get(Account."Member No.") then
                            //                 MobileNo := Memb."Phone No.";
                            //         end;
                            //         Text0008 := Gensetup."Salary SMS Suffix";
                            //         // msg := Text0005 + Format(SalLines.Amount) + Text0006 + Text0007 + ddMMyyyy(Today) + ' ' + Format(Time) + ' ' + Text0008;
                            //         msg := 'Your ' + Format(SalLines."Income Type") + ' of KES ' + Format(SalLines.Amount) + Text0006 + Text0007 + ddMMyyyy(Today) + ' ' + Format(Time) + ' your new Ordinary account balance is KES ' + Format(GlobalFunctions.GetSavingsAccountAvailableBalance(Account, true));

                            //         SendSMS.SendSms(Source::SALARY_PROCESSING, MobileNo, msg, Format(SalLines."Account No."), '', true, 0, false, 'CBS', SalLines."Account No.", 'CBS');

                            //     end;
                            // end;
                        end
                        else
                            Error('The Account does not have a posting group');
                    end;
                until SalLines.Next = 0;

            end;

            // SalHeaD.Posted := true;
            // SalHeaD."Posted By" := UserId;
            // SalHeaD.Modify;

            if Confirm('The salary batch has been successfully transfered to journal. Do you wish to open?', false) then begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                if GenJournalLine.FindSet() then
                    page.run(Page::"Cash Receipt Journal", GenJournalLine);
            end;
        end;
    end;

    procedure PostPerDiem(SalHeaD: Record "Salary Header")
    var
        SalLines: Record "Salary Lines";
        GenJournalLine: Record "Gen. Journal Line";
        Temp: Record "Banking User Template";
        Jtemplate: Code[20];
        JBatch: Code[20];
        Text0001: label 'Ensure the Salary  Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Salary Journal Batch is set up in Banking User Setup';
        Text0003: label 'Ensure the Default Bank is set up in User Setup';
        Text0004: label 'The transaction has already been posted.';
        RunBal: Decimal;
        Gensetup: Record "General Set-Up";
        LineNo: Integer;
        PDate: Date;
        DocNo: Code[20];
        PostingRemarks: Text[500];
        DActivity2: Code[20];
        DBranch2: Code[20];
        Account: Record "Savings Accounts";
        AvailableBal: Decimal;
        ProductF: Record "Product Factory";
        SalFee: Decimal;
        SalProcessingHeader: Record "Salary Header";
        SalGLAccount: Code[20];
        TCharges: Decimal;
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        MemberNo: Code[20];
        Salaccno: Code[20];
        Text0005: label 'Your Salary of KES ';
        Text0006: label ' has been credited to your Ordinary account ';
        Text0007: label ' on ';
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        Text0008: Text;
        WasBlocked: Boolean;
        GlobalFunctions: codeunit "Global Functions";
    begin
        if Posted = true then
            Error(Text0004);

        // IF SalProcessingHeader.Status<>SalProcessingHeader.Status::Approved THEN
        // ERROR('The document is not fully approved');
        Temp.SetLoadFields(UserID, "Salary Journal Template", "Salary Journal Batch");
        Temp.Get(UserId);
        Jtemplate := Temp."Salary Journal Template";
        JBatch := Temp."Salary Journal Batch";

        if Jtemplate = '' then begin
            Error(Text0001);
        end;

        if JBatch = '' then begin
            Error(Text0002);
        end;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.DeleteAll;

        SalHeaD.CalcFields("Total Count", "Scheduled Amount");
        RunBal := 0;
        Gensetup.setloadfields("Excise Duty G/L", "Excise Duty (%)");
        Gensetup.Get;
        LineNo := LineNo + 10000;
        //TotSal:=TotSal+SalLines.Amount;
        SalHeaD.TestField(Remarks);
        if (SalHeaD."Income Type" <> SalHeaD."Income Type"::SAYE) and (SalHeaD."Income Type" <> SalHeaD."Income Type"::claims) then
            SalHeaD.TestField("Document No");
        SalHeaD.TestField("Posting date");
        SalHeaD.TestField(Amount);
        if SalHeaD."Scheduled Amount" <> SalHeaD.Amount then
            Error('Scheduled amount and Amount must be the same');

        PDate := SalHeaD."Posting date";
        DocNo := SalHeaD."Document No";
        PostingRemarks := SalHeaD.Remarks;

        SalLines.Reset();
        SalLines.SetRange(SalLines."Salary Header No.", SalHeaD.No);
        SalLines.SetRange(Posted, false);

        if SalLines.FindSet() then begin
            repeat
                SavingsLedgerEntry.SetCurrentKey("Document No.", "Posting Date", "Customer No.");
                SavingsLedgerEntry.SetRange("Document No.", SalLines."Document No.");
                SavingsLedgerEntry.SetRange("Posting Date", PDate);
                SavingsLedgerEntry.SetRange("Customer No.", SalLines."Account No.");
                SavingsLedgerEntry.SetLoadFields("Entry No.");
                if SavingsLedgerEntry.FindFirst() then begin
                    if not SalLines.Posted then begin
                        SalLines.Posted := true;
                        SalLines.Modify(false);
                    end;
                end;

            until SalLines.Next() = 0;
        end;

        //Check Posted

        SalLines.Reset;
        SalLines.SetRange(SalLines."Salary Header No.", SalHeaD.No);
        SalLines.SetRange(Posted, false);
        if SalLines.FindSet() then begin
            repeat
                LineNo += 1;
                MemberNo := '';
                Salaccno := '';
                MemberNo := SalLines."Member No.";
                Salaccno := SalLines."Account No.";

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                GenJournalLine.DeleteAll;
                //BlockUblock
                // WasBlocked := false;
                Account.SetLoadFields("No.", "Customer Posting Group", "Global Dimension 1 Code", "Global Dimension 2 Code");
                if Account.Get(SalLines."Account No.") then begin


                    DActivity2 := Account."Global Dimension 1 Code";
                    DBranch2 := Account."Global Dimension 2 Code";
                    RunBal := SalLines.Amount;

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := Jtemplate;
                    GenJournalLine."Journal Batch Name" := JBatch;
                    GenJournalLine."Line No." := LineNo;

                    if (SalHeaD."Income Type" <> SalHeaD."Income Type"::SAYE) and (SalHeaD."Income Type" <> SalHeaD."Income Type"::claims) then
                        GenJournalLine."Document No." := CopyStr(DocNo, 1, 14)
                    else
                        GenJournalLine."Document No." := CopyStr(SalLines."Document No.", 1, 20);
                    //GenJournalLine."External Document No.":=SalLines."Branch Reff.";
                    GenJournalLine."Posting Date" := PDate;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                    GenJournalLine."Account No." := SalLines."Account No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := PostingRemarks;
                    GenJournalLine.Amount := -SalLines.Amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert(false);

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := Jtemplate;
                    GenJournalLine."Journal Batch Name" := JBatch;//USERID;
                    GenJournalLine."Line No." := LineNo;

                    if (SalHeaD."Income Type" <> SalHeaD."Income Type"::SAYE) and (SalHeaD."Income Type" <> SalHeaD."Income Type"::claims) then
                        GenJournalLine."Document No." := CopyStr(DocNo, 1, 14)
                    else
                        GenJournalLine."Document No." := CopyStr(SalLines."Document No.", 1, 20);
                    //GenJournalLine."External Document No.":=SalLines."Branch Reff.";
                    GenJournalLine."Posting Date" := PDate;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := PostingRemarks;//'Salary';
                    GenJournalLine."Account Type" := SalHeaD."Account Type";
                    GenJournalLine."Account No." := SalHeaD."Account No";
                    GenJournalLine.Amount := SalLines.Amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert(false);

                    //Charges
                    TCharges := 0;
                    TransactionCharges.Reset;
                    TransactionCharges.SetRange(TransactionCharges."Transaction Type", SalHeaD."Transaction Type");
                    if TransactionCharges.FindSet() then begin
                        repeat
                            LineNo := LineNo + 10000;
                            ChargeAmount := 0;
                            if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                                ChargeAmount := (SalHeaD.Amount * TransactionCharges."Percentage of Amount") * 0.01
                            else
                                ChargeAmount := TransactionCharges."Charge Amount";
                            if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                                TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                                TariffDetails.Reset;
                                TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                if TariffDetails.FindSet() then begin
                                    repeat
                                        if (SalHeaD.Amount >= TariffDetails."Lower Limit") and (SalHeaD.Amount <= TariffDetails."Upper Limit") then begin
                                            if TariffDetails."Use Percentage" = true then begin
                                                ChargeAmount := SalHeaD.Amount * TariffDetails.Percentage * 0.01;
                                            end else begin
                                                ChargeAmount := TariffDetails."Charge Amount";
                                            end;
                                        end;
                                    until TariffDetails.Next = 0;
                                end;
                            end;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Document No." := CopyStr(DocNo, 1, 14);

                            if (SalHeaD."Income Type" <> SalHeaD."Income Type"::SAYE) and (SalHeaD."Income Type" <> SalHeaD."Income Type"::claims) then
                                GenJournalLine."Document No." := CopyStr(DocNo, 1, 14)
                            else
                                GenJournalLine."Document No." := CopyStr(SalLines."Document No.", 1, 20);

                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                            GenJournalLine."Account No." := SalLines."Account No.";
                            //GenJournalLine."External Document No.":="ID No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := PDate;
                            GenJournalLine.Description := TransactionCharges.Description;
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := ChargeAmount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert(false);
                            RunBal := RunBal - GenJournalLine.Amount;

                            //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                            if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                            (TransactionCharges."Recover Excise Duty" = true) then begin
                                //Excise Duty
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := JBatch;

                                if (SalHeaD."Income Type" <> SalHeaD."Income Type"::SAYE) and (SalHeaD."Income Type" <> SalHeaD."Income Type"::claims) then
                                    GenJournalLine."Document No." := CopyStr(DocNo, 1, 14)
                                else
                                    GenJournalLine."Document No." := CopyStr(SalLines."Document No.", 1, 20);

                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                GenJournalLine."Account No." := SalLines."Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := PDate;
                                GenJournalLine.Description := TransactionCharges.Description + ' Excise Duty.';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := (ChargeAmount * Gensetup."Excise Duty (%)") * 0.01;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := Gensetup."Excise Duty G/L";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert(false);
                                RunBal := RunBal - GenJournalLine.Amount;

                                TCharges := TCharges + ChargeAmount;
                            end;
                        until TransactionCharges.Next = 0;
                    end;

                    // SMS Charges
                    if Gensetup."Disable Salary SMS" = false then begin
                        TransactionCharges.Reset;
                        TransactionCharges.SetRange(TransactionCharges."Transaction Type", SalHeaD."SMS Charge");
                        if TransactionCharges.FindSet() then begin
                            repeat
                                LineNo := LineNo + 10000;
                                ChargeAmount := 0;
                                if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                                    ChargeAmount := (SalLines.Amount * TransactionCharges."Percentage of Amount") * 0.01
                                else
                                    ChargeAmount := TransactionCharges."Charge Amount";
                                if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                                    TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                                    TariffDetails.Reset;
                                    TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                    if TariffDetails.FindSet() then begin
                                        repeat
                                            if (SalLines.Amount >= TariffDetails."Lower Limit") and (SalLines.Amount <= TariffDetails."Upper Limit") then begin
                                                if TariffDetails."Use Percentage" = true then begin
                                                    ChargeAmount := SalLines.Amount * TariffDetails.Percentage * 0.01;
                                                end else begin
                                                    ChargeAmount := TariffDetails."Charge Amount";
                                                end;
                                            end;
                                        until TariffDetails.Next = 0;
                                    end;
                                end;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := JBatch;
                                GenJournalLine."Document No." := CopyStr(DocNo, 1, 14);

                                if (SalHeaD."Income Type" <> SalHeaD."Income Type"::SAYE) and (SalHeaD."Income Type" <> SalHeaD."Income Type"::claims) then
                                    GenJournalLine."Document No." := CopyStr(DocNo, 1, 14)
                                else
                                    GenJournalLine."Document No." := CopyStr(SalLines."Document No.", 1, 20);

                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                GenJournalLine."Account No." := SalLines."Account No.";
                                //GenJournalLine."External Document No.":="ID No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := PDate;
                                GenJournalLine.Description := TransactionCharges.Description;
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := ChargeAmount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert(false);
                                RunBal := RunBal - GenJournalLine.Amount;

                                //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                                if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                (TransactionCharges."Recover Excise Duty" = true) then begin
                                    //Excise Duty
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := JBatch;

                                    if (SalHeaD."Income Type" <> SalHeaD."Income Type"::SAYE) and (SalHeaD."Income Type" <> SalHeaD."Income Type"::claims) then
                                        GenJournalLine."Document No." := CopyStr(DocNo, 1, 14)
                                    else
                                        GenJournalLine."Document No." := CopyStr(SalLines."Document No.", 1, 20);

                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                    GenJournalLine."Account No." := SalLines."Account No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := PDate;
                                    GenJournalLine.Description := TransactionCharges.Description + ' Excise Duty.';
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := (ChargeAmount * Gensetup."Excise Duty (%)") * 0.01;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := Gensetup."Excise Duty G/L";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert(false);
                                    RunBal := RunBal - GenJournalLine.Amount;

                                    TCharges := TCharges + ChargeAmount;
                                end;
                            until TransactionCharges.Next = 0;
                        end;
                    end;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                    GenJournalLine.SetRange("Journal Batch Name", JBatch);
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                    end;

                    SalLines.Posted := true;
                    SalLines."Posted By" := UserId;
                    SalLines."Posting Date" := Today;
                    SalLines."Posting Time" := Time;
                    SalLines."Income Type" := SalHeaD."Income Type";
                    SalLines.Modify;
                    Commit;//*
                    if Gensetup."Disable Salary SMS" = false then begin
                        Account.setloadfields("Mobile Phone No", "Member No.");
                        if Account.Get(SalLines."Account No.") then begin
                            MobileNo := Account."Transactional Mobile No";
                            if MobileNo = '' then begin
                                if Memb.get(Account."Member No.") then
                                    MobileNo := Memb."Phone No.";
                            end;

                            Text0008 := Gensetup."Salary SMS Suffix";
                            // msg := Text0005 + Format(SalLines.Amount) + Text0006 + Text0007 + ddMMyyyy(Today) + ' ' + Format(Time) + ' ' + Text0008;
                            msg := 'Your ' + Format(SalLines."Income Type") + ' of KES ' + Format(SalLines.Amount) + Text0006 + Text0007 + ddMMyyyy(Today) + ' ' + Format(Time) + ' your new Ordinary account balance is KES ' + Format(GlobalFunctions.GetSavingsAccountAvailableBalance(Account, true));

                            SendSMS.SendSms(Source::SALARY_PROCESSING, MobileNo, msg, Format(SalLines."Account No."), '', true, 0, false, 'CBS', SalLines."Account No.", 'CBS');

                        end;
                    end;

                end;
            until SalLines.Next = 0;

        end;

        SalHeaD.Posted := true;
        SalHeaD."Posted By" := UserId;
        SalHeaD.Modify;
        Message('The Per-diem has been posted successfully');
    end;

    // procedure PostSalary(SalHeaD: Record "Salary Header"; Post: Boolean)
    // var
    //     SalLines: Record "Salary Lines";
    //     GenJournalLine: Record "Gen. Journal Line";
    //     Temp: Record "Banking User Template";
    //     Jtemplate: Code[20];
    //     JBatch: Code[20];
    //     Text0001: label 'Ensure the Salary  Journal Template is set up in Banking User Setup';
    //     Text0002: label 'Ensure the Salary Journal Batch is set up in Banking User Setup';
    //     Text0003: label 'Ensure the Default Bank is set up in User Setup';
    //     Text0004: label 'The transaction has already been posted.';
    //     RunBal: Decimal;
    //     Gensetup: Record "General Set-Up";
    //     LineNo: Integer;
    //     PDate: Date;
    //     DocNo: Code[20];
    //     PostingRemarks: Text[500];
    //     DActivity2: Code[20];
    //     DBranch2: Code[20];
    //     Account: Record "Savings Accounts";
    //     AvailableBal: Decimal;
    //     ProductF: Record "Product Factory";
    //     SalFee: Decimal;
    //     SalProcessingHeader: Record "Salary Header";
    //     SalGLAccount: Code[20];
    //     TCharges: Decimal;
    //     TransactionCharges: Record "Transaction Charges";
    //     ChargeAmount: Decimal;
    //     TariffDetails: Record "Tiered Charges Lines";
    //     MemberNo: Code[20];
    //     Salaccno: Code[20];
    //     Text0005: label 'Your Salary of KES ';
    //     Text0006: label ' has been credited to your FOSA  account ';
    //     Text0007: label ' on ';
    //     SavingsLedgerEntry: Record "Savings Ledger Entry";
    //     Text0008: Text;
    //     WasBlocked: Boolean;
    // begin
    //     //with SalHeaD do
    //     begin
    //         if Posted = true then
    //             Error(Text0004);

    //         // IF SalProcessingHeader.Status<>SalProcessingHeader.Status::Approved THEN
    //         // ERROR('The document is not fully approved');

    //         Temp.Get(UserId);
    //         Jtemplate := Temp."Salary Journal Template";
    //         JBatch := Temp."Salary Journal Batch";

    //         if Jtemplate = '' then begin
    //             Error(Text0001);
    //         end;

    //         if JBatch = '' then begin
    //             Error(Text0002);
    //         end;

    //         GenJournalLine.Reset;
    //         GenJournalLine.SetRange("Journal Template Name", Jtemplate);
    //         GenJournalLine.SetRange("Journal Batch Name", JBatch);
    //         GenJournalLine.DeleteAll;

    //         SalHeaD.CalcFields("Total Count", "Scheduled Amount");

    //         RunBal := 0;

    //         Gensetup.Get;

    //         LineNo := LineNo + 10000;
    //         //TotSal:=TotSal+SalLines.Amount;
    //         SalHeaD.TestField(Remarks);
    //         SalHeaD.TestField("Document No");
    //         SalHeaD.TestField("Posting date");
    //         SalHeaD.TestField(Amount);
    //         if SalHeaD."Scheduled Amount" <> SalHeaD.Amount then
    //             Error('Scheduled amount and Amount must be the same');

    //         PDate := SalHeaD."Posting date";
    //         DocNo := SalHeaD."Document No";
    //         PostingRemarks := SalHeaD.Remarks;

    //         //Check Posted
    //         SalLines.Reset;
    //         SalLines.SetRange(SalLines."Salary Header No.", SalHeaD.No);
    //         SalLines.SetRange(Posted, false);
    //         if SalLines.FindSet() then begin
    //             repeat
    //                 SavingsLedgerEntry.reset;
    //                 SavingsLedgerEntry.SetCurrentKey("Document No.", "Posting Date", "Customer No."); // Use indexed fields if possible
    //                 SavingsLedgerEntry.SetRange("Document No.", SalHeaD.No);
    //                 SavingsLedgerEntry.SetRange("Posting Date", PDate);
    //                 SavingsLedgerEntry.SetRange("Customer No.", SalLines."Account No.");
    //                 if SavingsLedgerEntry.Find('-') then begin
    //                     SalLines.Posted := true;
    //                     SalLines.Modify;
    //                 end;

    //             until SalLines.Next = 0;
    //         end;
    //         SalLines.Reset;
    //         SalLines.SetRange(SalLines."Salary Header No.", SalHeaD.No);
    //         SalLines.SetRange(Posted, false);
    //         if not SalLines.findfirst then begin
    //             SalHeaD.Posted := true;
    //             SalHeaD."Posted By" := UserId;
    //             SalHeaD.Modify;
    //             Message('Salaries posted successfully');
    //             exit;
    //         end;
    //         //Check Posted

    //         // Debit Ctrl Acc.
    //         LineNo := LineNo + 10000;
    //         GenJournalLine.Init;
    //         GenJournalLine."Journal Template Name" := Jtemplate;
    //         GenJournalLine."Journal Batch Name" := JBatch;//USERID;
    //         GenJournalLine."Line No." := LineNo;
    //         GenJournalLine."Document No." := CopyStr(DocNo, 1, 14);
    //         //GenJournalLine."External Document No.":=SalLines."Branch Reff.";
    //         GenJournalLine."Posting Date" := PDate;
    //         GenJournalLine.Validate(GenJournalLine."Account No.");
    //         GenJournalLine.Description := PostingRemarks;//'Salary';
    //         GenJournalLine."Account Type" := SalHeaD."Account Type";
    //         if SalProcessingHeader.Get(SalLines."Salary Header No.") then begin
    //             GenJournalLine."Account No." := SalProcessingHeader."Account No";
    //         end;
    //         GenJournalLine.Amount := SalHeaD.Amount;
    //         GenJournalLine.Validate(GenJournalLine.Amount);
    //         GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
    //         GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
    //         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
    //         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
    //         if GenJournalLine.Amount <> 0 then
    //             GenJournalLine.Insert;


    //         SalLines.Reset;
    //         SalLines.SetRange(SalLines."Salary Header No.", SalHeaD.No);
    //         SalLines.SetRange(Posted, false);
    //         //SalLines.setcurrentkey(SalLines.Blocked);
    //         if SalLines.FindSet() then begin
    //             repeat
    //                 GenJournalLine.Reset;
    //                 GenJournalLine.SetRange("Journal Template Name", Jtemplate);
    //                 GenJournalLine.SetRange("Journal Batch Name", JBatch);
    //                 if GenJournalLine.findlast then
    //                     LineNo := GenJournalLine."Line No.";

    //                 MemberNo := '';
    //                 Salaccno := '';

    //                 MemberNo := SalLines."Member No.";
    //                 Salaccno := SalLines."Account No.";

    //                 // GenJournalLine.Reset;
    //                 // GenJournalLine.SetRange("Journal Template Name", Jtemplate);
    //                 // GenJournalLine.SetRange("Journal Batch Name", JBatch);
    //                 // GenJournalLine.DeleteAll;
    //                 //BlockUblock
    //                 WasBlocked := false;
    //                 if Account.Get(SalLines."Account No.") then begin
    //                     if Account.Blocked <> Account.Blocked::" " then begin
    //                         BlockUblock(Account."No.", true);
    //                         wasBlocked := true;
    //                     end;

    //                     DActivity2 := Account."Global Dimension 1 Code";
    //                     DBranch2 := Account."Global Dimension 2 Code";

    //                     //Check Account Bal
    //                     // AvailableBal := 0;
    //                     //Account.CalcFields(Account.Balance, Account."Authorised Over Draft", Account."Uncleared Cheques");

    //                     // AvailableBal := ((Account.Balance + Account."Authorised Over Draft") - (Account."ATM Transactions" + Account."Uncleared Cheques"));
    //                     //if ProductF.Get(Account."Product Type") then
    //                     //    AvailableBal := AvailableBal - ProductF."Minimum Balance";

    //                     //RunBal := AvailableBal + SalLines.Amount;
    //                     RunBal := SalLines.Amount;

    //                     LineNo := LineNo + 10000;
    //                     GenJournalLine.Init;
    //                     GenJournalLine."Journal Template Name" := Jtemplate;
    //                     GenJournalLine."Journal Batch Name" := JBatch;
    //                     GenJournalLine."Line No." := LineNo;
    //                     GenJournalLine."Document No." := CopyStr(DocNo, 1, 14);
    //                     //GenJournalLine."External Document No.":=SalLines."Branch Reff.";
    //                     GenJournalLine."Posting Date" := PDate;
    //                     GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
    //                     GenJournalLine."Account No." := SalLines."Account No.";
    //                     GenJournalLine.Validate(GenJournalLine."Account No.");
    //                     GenJournalLine.Description := PostingRemarks;
    //                     GenJournalLine.Amount := -SalLines.Amount;
    //                     GenJournalLine.Validate(GenJournalLine.Amount);
    //                     GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
    //                     GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
    //                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
    //                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
    //                     if GenJournalLine.Amount <> 0 then
    //                         GenJournalLine.Insert;



    //                     //Charges
    //                     TCharges := 0;
    //                     TransactionCharges.Reset;
    //                     TransactionCharges.SetRange(TransactionCharges."Transaction Type", SalHeaD."Transaction Type");
    //                     if TransactionCharges.FindSet() then begin
    //                         repeat

    //                             ChargeAmount := 0;
    //                             if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
    //                                 ChargeAmount := (SalHeaD.Amount * TransactionCharges."Percentage of Amount") * 0.01
    //                             else
    //                                 ChargeAmount := TransactionCharges."Charge Amount";
    //                             if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
    //                                 TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
    //                                 TariffDetails.Reset;
    //                                 TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
    //                                 if TariffDetails.FindSet() then begin
    //                                     repeat
    //                                         if (SalHeaD.Amount >= TariffDetails."Lower Limit") and (SalHeaD.Amount <= TariffDetails."Upper Limit") then begin
    //                                             if TariffDetails."Use Percentage" = true then begin
    //                                                 ChargeAmount := SalHeaD.Amount * TariffDetails.Percentage * 0.01;
    //                                             end else begin
    //                                                 ChargeAmount := TariffDetails."Charge Amount";
    //                                             end;
    //                                         end;
    //                                     until TariffDetails.Next = 0;
    //                                 end;
    //                             end;

    //                             LineNo := LineNo + 10000;
    //                             GenJournalLine.Init;
    //                             GenJournalLine."Journal Template Name" := Jtemplate;
    //                             GenJournalLine."Journal Batch Name" := JBatch;
    //                             GenJournalLine."Document No." := CopyStr(DocNo, 1, 14);
    //                             GenJournalLine."Line No." := LineNo;
    //                             GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
    //                             GenJournalLine."Account No." := SalLines."Account No.";
    //                             //GenJournalLine."External Document No.":="ID No";
    //                             GenJournalLine.Validate(GenJournalLine."Account No.");
    //                             GenJournalLine."Posting Date" := PDate;
    //                             GenJournalLine.Description := TransactionCharges.Description;
    //                             GenJournalLine.Validate(GenJournalLine."Currency Code");
    //                             GenJournalLine.Amount := ChargeAmount;
    //                             GenJournalLine.Validate(GenJournalLine.Amount);
    //                             GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
    //                             GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
    //                             GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
    //                             GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
    //                             GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
    //                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
    //                             GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
    //                             if GenJournalLine.Amount <> 0 then
    //                                 GenJournalLine.Insert;
    //                             RunBal := RunBal - GenJournalLine.Amount;

    //                             //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

    //                             if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
    //                             (TransactionCharges."Recover Excise Duty" = true) then begin
    //                                 //Excise Duty
    //                                 LineNo := LineNo + 10000;
    //                                 GenJournalLine.Init;
    //                                 GenJournalLine."Journal Template Name" := Jtemplate;
    //                                 GenJournalLine."Journal Batch Name" := JBatch;
    //                                 GenJournalLine."Document No." := CopyStr(DocNo, 1, 14);
    //                                 GenJournalLine."Line No." := LineNo;
    //                                 GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
    //                                 GenJournalLine."Account No." := SalLines."Account No.";
    //                                 GenJournalLine.Validate(GenJournalLine."Account No.");
    //                                 GenJournalLine."Posting Date" := PDate;
    //                                 GenJournalLine.Description := 'Excise Duty';
    //                                 GenJournalLine.Validate(GenJournalLine."Currency Code");
    //                                 GenJournalLine.Amount := (ChargeAmount * Gensetup."Excise Duty (%)") * 0.01;
    //                                 GenJournalLine.Validate(GenJournalLine.Amount);
    //                                 GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
    //                                 GenJournalLine."Bal. Account No." := Gensetup."Excise Duty G/L";
    //                                 GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
    //                                 GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
    //                                 GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
    //                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
    //                                 GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
    //                                 if GenJournalLine.Amount <> 0 then
    //                                     GenJournalLine.Insert;
    //                                 RunBal := RunBal - GenJournalLine.Amount;

    //                                 TCharges := TCharges + ChargeAmount;
    //                             end;
    //                         until TransactionCharges.Next = 0;
    //                     end;



    //                     //--Activate Dormant.
    //                     //ActivateDormant(SalHeaD, DocNo, PDate, DActivity2, DBranch2, Jtemplate, JBatch, RunBal, MemberNo, LineNo, Salaccno);

    //                     // if SalHeaD."Donnot Recover" = false then
    //                     PostSalaryLoans(SalHeaD, DocNo, PDate, DActivity2, DBranch2, Jtemplate, JBatch, RunBal, MemberNo, LineNo, Salaccno);

    //                     if Account.Get(SalLines."Account No.") then begin
    //                         if Account."Loan Disbursement Account" = false then begin
    //                             Account."Loan Disbursement Account" := true;
    //                             Account.Modify;
    //                         end;
    //                     end;

    //                 end;

    //             until SalLines.Next = 0;

    //             if Post then begin
    //                 GenJournalLine.Reset;
    //                 GenJournalLine.SetRange("Journal Template Name", Jtemplate);
    //                 GenJournalLine.SetRange("Journal Batch Name", JBatch);
    //                 if GenJournalLine.Find('-') then begin

    //                     Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
    //                 end;

    //                 Gensetup.Get();
    //                 SalLines.Reset;
    //                 SalLines.SetRange(SalLines."Salary Header No.", SalHeaD.No);
    //                 //SalLines.SetRange(Posted, true);
    //                 if SalLines.findset then begin
    //                     repeat
    //                         if Account.get(SalLines."Account No.") then
    //                             if Account."Blocked Buffer" <> Account."Blocked Buffer"::" " then
    //                                 BlockUblock(Account."No.", false);

    //                         SalLines.Posted := true;
    //                         SalLines."Posted By" := UserId;
    //                         SalLines."Posting Date" := SalHeaD."Posting date";
    //                         SalLines."Posting Time" := Time;
    //                         SalLines."Income Type" := SalHeaD."Income Type";
    //                         SalLines."Actual Date Posted" := Today;
    //                         SalLines.Modify;
    //                         Commit;//*

    //                         //Send Messages

    //                         if Gensetup."Disable Salary SMS" = false then begin
    //                             // SalLines.Reset;
    //                             // SalLines.SetRange(SalLines."Salary Header No.", SalHeaD.No);
    //                             // SalLines.SetRange(Posted, true);
    //                             // if SalLines.findset then begin
    //                             //     repeat
    //                             //if Account.Get(SalLines."Account No.") then begin
    //                             MobileNo := Account."Mobile Phone No";
    //                             if MobileNo = '' then begin
    //                                 if Memb.get(Account."Member No.") then
    //                                     MobileNo := Memb."Phone No.";
    //                             end;
    //                             Text0008 := Gensetup."Salary SMS Suffix";
    //                             msg := Text0005 + Format(SalLines.Amount) + Text0006 + Text0007 + ddMMyyyy(Today) + ' ' + Format(Time) + ' ' + Text0008;

    //                             SendSMS.SendSms(Source::SALARY_PROCESSING, MobileNo, msg, Format(SalLines."Account No."), '', true, 0, false, 'CBS', SalLines."Account No.", 'CBS');
    //                             //end;
    //                             //    until SalLines.next = 0;
    //                             // end; 
    //                         end;
    //                     until SalLines.next = 0;
    //                 end;
    //             end;


    //         end;
    //         if Post then begin
    //             SalHeaD.Posted := true;
    //             SalHeaD."Posted By" := UserId;
    //             SalHeaD.Modify;
    //             Message('The salary batch has been posted successfully');
    //         end
    //         else begin
    //             Message('The Salary lines have been successfully moved to General journal -Temp %1, -Batch %2', Jtemplate, Jbatch);
    //             SalHeaD."Sent to Journal" := true;
    //             SalHeaD.modify;
    //         end;



    //     end;
    // end;

    local procedure PostSalaryLoans(SalHeaD: Record "Salary Header"; DocNo: Code[20]; PDate: Date; DActivity2: Code[20]; DBranch2: Code[20]; Jtemplate: Code[20]; Jbatch: Code[20]; RunBal: Decimal; MemberNo: Code[20]; LineNo: Integer; Salaccno: Code[20])
    var
        Loans: Record Loans;
        Interest: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        LRepayment: Decimal;
        SalLines: Record "Salary Lines";
        CreditLedger: Record "Credit Ledger Entry";
        ProductType: Record "Product Factory";
        StandingOrdSRegister: Record "Standing Order Register";
        remainingBal: Decimal;
    begin
        // Priority of Loan repayments
        //1. BOSA loan STOs,
        //2. Salary Loans
        //3. SavingAccounts STOS

        //BOSA loan STOs-
        remainingBal := PostLoanSTO(SalHeaD, DocNo, PDate, DActivity2, DBranch2, Jtemplate, Jbatch, RunBal, MemberNo, LineNo, Salaccno);

        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        if GenJournalLine.findlast then begin
            LineNo := GenJournalLine."Line No.";
        end;

        RunBal -= remainingBal;

        Loans.Reset;
        Loans.SetRange(Loans."Member No.", MemberNo);
        Loans.SetRange(Loans."Disbursement Date", 0D, SalHeaD."Last Loan Issue Date");
        Loans.SetRange("Source Unit", Loans."Source Unit"::FOSA);
        // if SalHeaD."Income Type" = SalHeaD."Income Type"::Payments THEN
        //     Loans.SetRange(Loans."Recovery Mode", Loans."recovery mode"::"Board Allowance")
        // ELSE
        // Loans.SetRange(Loans."Recovery Mode", Loans."recovery mode"::Salary);
        Loans.SetFilter("Recovery Mode", '%1', Loans."Recovery Mode"::Salary);
        Loans.SetAutoCalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");
        if Loans.FindSet() then begin
            repeat
                if RunBal > 0 then begin
                    if (Loans."Outstanding Interest" + Loans."Daily Interest") > 0 then begin
                        Interest := 0;
                        Interest := Loans."Outstanding Interest" + Loans."Daily Interest";
                        if Interest > 0 then begin
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := Jbatch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Credit;
                            GenJournalLine."Account No." := Loans."Loan Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := CopyStr(DocNo, 1, 14);
                            GenJournalLine."Posting Date" := PDate;
                            GenJournalLine.Description := 'Interest Paid';
                            if RunBal > Interest then
                                GenJournalLine.Amount := Interest * -1
                            else
                                GenJournalLine.Amount := RunBal * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                            GenJournalLine."Loan No" := Loans."Loan No.";
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := Jbatch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                            GenJournalLine."Account No." := Salaccno;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := CopyStr(DocNo, 1, 14);
                            GenJournalLine."Posting Date" := PDate;
                            GenJournalLine.Description := PadStr('Interest Paid - ' + Loans."Loan Product Type Name", 50);
                            if RunBal > Interest then
                                GenJournalLine.Amount := Interest
                            else
                                GenJournalLine.Amount := RunBal;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Loan No" := Loans."Loan No.";
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                            RunBal := RunBal - Abs(GenJournalLine.Amount);
                        end;
                    end;

                    if RunBal > 0 then begin
                        if Loans."Outstanding Balance" > 0 then begin

                            LRepayment := 0;
                            // if Loans."Recovery Mode" = Loans."Recovery Mode"::Hybrid then
                            //     LRepayment := Loans."Salary Amount"
                            // else
                            if (Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised) then begin
                                LRepayment := Loans.Repayment - Interest;
                                if Loans."Variated Amount" <> 0 then
                                    LRepayment := Loans."Variated Amount" - Interest;
                            end
                            else begin
                                LRepayment := Loans."Loan Principle Repayment";
                                if Loans."Variated Amount" <> 0 then
                                    LRepayment := Loans."Variated Amount";
                            end;

                            if LRepayment = 0 then LRepayment := Loans.Repayment;
                            IF LRepayment <= 0 THEN BEGIN
                                if Loans.Installments <= 0 then Loans.Installments := 1;
                                // LRepayment := ROUND((Loans."Approved Amount" / Loans.Installments), 0.01, '>');
                                //hybrid repayment
                                // if Loans."Recovery Mode" = Loans."Recovery Mode" then begin
                                //     LRepayment := Loans."Salary Amount";
                                // end else begin
                                LRepayment := ROUND((Loans."Approved Amount" / Loans.Installments), 0.01, '>');
                                // end;

                            end;


                            if LRepayment > 0 then begin
                                if LRepayment > Loans."Outstanding Balance" then
                                    LRepayment := Loans."Outstanding Balance";

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := Jbatch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Credit;
                                GenJournalLine."Account No." := Loans."Loan Account";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := CopyStr(DocNo, 1, 14);
                                GenJournalLine."Posting Date" := PDate;
                                GenJournalLine.Description := 'Loan Repayment';
                                if RunBal > LRepayment then
                                    GenJournalLine.Amount := LRepayment * -1
                                else
                                    GenJournalLine.Amount := RunBal * -1;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                                GenJournalLine."Loan No" := Loans."Loan No.";
                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := Jbatch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                GenJournalLine."Account No." := Salaccno;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := CopyStr(DocNo, 1, 14);
                                GenJournalLine."Posting Date" := PDate;
                                GenJournalLine.Description := PadStr('Loan Repayment - ' + Loans."Loan Product Type Name", 50);
                                if RunBal > LRepayment then
                                    GenJournalLine.Amount := LRepayment
                                else
                                    GenJournalLine.Amount := RunBal;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Loan No" := Loans."Loan No.";
                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                RunBal := RunBal - GenJournalLine.Amount;
                                //ERROR('Interst %1',Interest);
                            end;
                        end;
                    end;
                end;
            //LineNo += 1;
            until Loans.Next = 0;
        end;

        if RunBal > 0 then
            PostSavingSTO(SalHeaD, DocNo, PDate, DActivity2, DBranch2, Jtemplate, Jbatch, RunBal, MemberNo, LineNo, Salaccno);

    end;

    local procedure PostLoanSTO(SalHeaD: Record "Salary Header"; DocNo: Code[20]; PDate: Date; DActivity2: Code[20]; DBranch2: Code[20]; Jtemplate: Code[20]; Jbatch: Code[20]; RunBal: Decimal; MemberNo: Code[20]; LineNo: Integer; Salaccno: Code[20]): Decimal
    var
        StandingOrderHeader: Record "Standing Order Header";
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        AvailableBal: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        BalAccountType: Enum "Gen. Journal Account Type";
        StandingOrdDeductStatus: Option " ",Successfull,"Partial Deduction",Failed;
        StandingOrdSRegister: Record "Standing Order Register";
        TCharges: Decimal;
        SalLines: Record "Salary Lines";
        STOHeaderNo: Code[20];
        StandingOrderLines: Record "Standing Order Lines";
        StandingOrderLinesII: Record "Standing Order Lines";
        LoanApps: Record Loans;
        STOHead: Record "Standing Order Header";
        STOlinesname: Text[80];
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        TChargeAmount: Decimal;
        TransTypes: Record "Transaction Types";
        SavingsACCS: Record "Savings Accounts";
        STR: Date;
        SkipSTO: Boolean;
        THESavings: Record "Savings Accounts";
        AmtDeducted: Decimal;
        TransactionTypes: record "Transaction Types";
        Txt004: label 'Dear Member your  standing order towards (loan) repayment was unsuccessful.';
        TotalDeduction: decimal;
        MaxSTO: Decimal;
    begin
        TotalDeduction := 0;
        //RemainingBal := RunBal;
        GenSetup.Get;
        StandingOrderHeader.Reset;
        StandingOrderHeader.SetCurrentkey(StandingOrderHeader."No.");
        StandingOrderHeader.SetRange(StandingOrderHeader."Member No.", MemberNo);
        StandingOrderHeader.SetRange(StandingOrderHeader.Status, StandingOrderHeader.Status::Approved);
        StandingOrderHeader.setrange(StandingOrderHeader."Source Account No.", Salaccno);
        if SalHeaD."Income Type" = SalHeaD."Income Type"::Payments THEN
            Loans.SetRange(Loans."Recovery Mode", Loans."recovery mode"::"Board Allowance")
        ELSE
            StandingOrderHeader.SetFilter(StandingOrderHeader."Income Type", '%1|%2|%3', StandingOrderHeader."income type"::Salary,
                                          StandingOrderHeader."income type"::Pension, StandingOrderHeader."income type"::"Direct Debit");
        if StandingOrderHeader.findfirst() then begin

            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            if GenJournalLine.findlast then begin
                LineNo := GenJournalLine."Line No.";
            end;
            repeat
                AmtDeducted := 0;
                SkipSTO := false;
                if SkipSTO = false then begin
                    STOHeaderNo := '';
                    STOHeaderNo := StandingOrderHeader."No.";

                    if RunBal > StandingOrderHeader.Amount then begin
                        StandingOrdDeductStatus := Standingorddeductstatus::Successfull;
                    end else begin
                        StandingOrdDeductStatus := Standingorddeductstatus::"Partial Deduction";
                    end;
                    if RunBal < 0 then
                        RunBal := 0;

                    StandingOrderLines.Reset;
                    StandingOrderLines.SetRange(StandingOrderLines."Document No.", StandingOrderHeader."No.");
                    StandingOrderLines.SetRange(StandingOrderLines."destination account type", StandingOrderLines."destination account type"::Credit);
                    if StandingOrderLines.FindSet() then begin
                        repeat
                            MaxSTO := StandingOrderLines.Amount;
                            if RunBal > 0 then begin
                                if RunBal <= StandingOrderLines.Amount then begin
                                    LoanApps.Reset;
                                    LoanApps.SetRange(LoanApps."Loan No.", StandingOrderLines."Loan No.");
                                    if LoanApps.Find('-') then begin
                                        LoanApps.CalcFields(LoanApps."Outstanding Interest", LoanApps."Total Balance", LoanApps."Outstanding Balance");
                                        if LoanApps."Total Balance" > 0 then begin
                                            if (LoanApps."Outstanding Interest") > 0 then begin
                                                LineNo := LineNo + 10000;
                                                GenJournalLine.Init;
                                                GenJournalLine."Journal Template Name" := Jtemplate;
                                                GenJournalLine."Journal Batch Name" := Jbatch;
                                                GenJournalLine."Line No." := LineNo;
                                                GenJournalLine."Posting Date" := PDate;
                                                GenJournalLine."Document No." := DocNo;
                                                GenJournalLine."External Document No." := STOHead."No.";
                                                GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                                GenJournalLine.Description := PadStr(StandingOrderLines."Document No." + ' Destination:-' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                                             Format(GenJournalLine."transaction type"::"Interest Paid"), 50);


                                                if LoanApps."Outstanding Interest" >= RunBal then begin
                                                    GenJournalLine.Amount := RunBal * -1;
                                                    AmtDeducted += RunBal;
                                                    RunBal := 0;
                                                end
                                                else begin
                                                    GenJournalLine.Amount := LoanApps."Outstanding Interest" * -1;
                                                    RunBal -= Abs(LoanApps."Outstanding Interest");
                                                    AmtDeducted += Abs(LoanApps."Outstanding Interest");
                                                end;
                                                GenJournalLine.validate(Amount);
                                                GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                if GenJournalLine.Amount <> 0 then
                                                    GenJournalLine.Insert;


                                            end;
                                            if LoanApps."Interest Calculation Method" = LoanApps."Interest Calculation Method"::"Reducing Balance" then
                                                if LoanApps."Outstanding Balance" > LoanApps."Loan Principle Repayment" then
                                                    LoanApps."Outstanding Balance" := LoanApps."Loan Principle Repayment";


                                            if (LoanApps."Outstanding Balance" > 0) then begin
                                                if RunBal > 0 then begin
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Posting Date" := PDate;
                                                    GenJournalLine."Document No." := DocNo;
                                                    GenJournalLine."External Document No." := STOHead."No.";
                                                    GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                    GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                                    GenJournalLine.Description := PadStr(StandingOrderLines."Document No." + ' Destination:-' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                                                 Format(GenJournalLine."transaction type"::Repayment), 50);

                                                    if LoanApps."Outstanding Balance" >= RunBal then begin
                                                        GenJournalLine.Amount := RunBal * -1;
                                                        AmtDeducted += RunBal;
                                                        RunBal := 0;
                                                    end
                                                    else begin
                                                        GenJournalLine.Amount := LoanApps."Outstanding Balance" * -1;
                                                        RunBal -= Abs(LoanApps."Outstanding Balance");
                                                        AmtDeducted += Abs(LoanApps."Outstanding Balance");
                                                    end;
                                                    GenJournalLine.validate(Amount);
                                                    GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;
                                                end;
                                            end;
                                        end;
                                    end;
                                end
                                else begin
                                    LoanApps.Reset;
                                    LoanApps.SetRange(LoanApps."Loan No.", StandingOrderLines."Loan No.");
                                    if LoanApps.Find('-') then begin
                                        LoanApps.CalcFields(LoanApps."Outstanding Interest", LoanApps."Total Balance", LoanApps."Outstanding Balance");
                                        if LoanApps."Total Balance" > 0 then begin
                                            if (LoanApps."Outstanding Interest") > 0 then begin
                                                LineNo := LineNo + 10000;
                                                GenJournalLine.Init;
                                                GenJournalLine."Journal Template Name" := Jtemplate;
                                                GenJournalLine."Journal Batch Name" := Jbatch;
                                                GenJournalLine."Line No." := LineNo;
                                                GenJournalLine."Posting Date" := PDate;
                                                GenJournalLine."Document No." := DocNo;
                                                GenJournalLine."External Document No." := STOHead."No.";
                                                GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                                GenJournalLine.Description := PadStr(StandingOrderLines."Document No." + ' Destination:-' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                                             Format(GenJournalLine."transaction type"::"Interest Paid"), 50);

                                                if LoanApps."Outstanding Interest" >= MaxSTO then begin
                                                    GenJournalLine.Amount := MaxSTO * -1;
                                                    AmtDeducted += MaxSTO;
                                                    RunBal -= MaxSTO;
                                                    MaxSTO := 0;
                                                end
                                                else begin
                                                    GenJournalLine.Amount := LoanApps."Outstanding Interest" * -1;
                                                    RunBal -= Abs(LoanApps."Outstanding Interest");
                                                    AmtDeducted += Abs(LoanApps."Outstanding Interest");
                                                    MaxSTO -= Abs(LoanApps."Outstanding Interest");
                                                end;
                                                GenJournalLine.Validate(Amount);
                                                GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                if GenJournalLine.Amount <> 0 then
                                                    GenJournalLine.Insert;


                                            end;
                                            if LoanApps."Interest Calculation Method" = LoanApps."Interest Calculation Method"::"Reducing Balance" then
                                                if LoanApps."Outstanding Balance" > LoanApps."Loan Principle Repayment" then
                                                    LoanApps."Outstanding Balance" := LoanApps."Loan Principle Repayment";


                                            if (LoanApps."Outstanding Balance" > 0) then begin
                                                if RunBal > 0 then begin
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Posting Date" := PDate;
                                                    GenJournalLine."Document No." := DocNo;
                                                    GenJournalLine."External Document No." := STOHead."No.";
                                                    GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                    GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                                    GenJournalLine.Description := PadStr(StandingOrderLines."Document No." + ' Destination:-' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                                                 Format(GenJournalLine."transaction type"::Repayment), 50);

                                                    // if LoanApps."Outstanding Balance" >= RunBal then begin
                                                    //     GenJournalLine.Amount := RunBal * -1;
                                                    //     AmtDeducted += RunBal;
                                                    //     RunBal := 0;
                                                    // end
                                                    // else begin
                                                    //     GenJournalLine.Amount := LoanApps."Outstanding Balance" * -1;
                                                    //     RunBal -= Abs(LoanApps."Outstanding Balance");
                                                    //     AmtDeducted += Abs(LoanApps."Outstanding Balance");
                                                    // end;
                                                    if LoanApps."Outstanding Balance" >= MaxSTO then begin
                                                        GenJournalLine.Amount := MaxSTO * -1;
                                                        AmtDeducted += MaxSTO;
                                                        RunBal -= MaxSTO;
                                                        MaxSTO := 0;
                                                    end
                                                    else begin
                                                        GenJournalLine.Amount := LoanApps."Outstanding Balance" * -1;
                                                        RunBal -= Abs(LoanApps."Outstanding Balance");
                                                        AmtDeducted += Abs(LoanApps."Outstanding Balance");
                                                        MaxSTO -= Abs(LoanApps."Outstanding Balance");
                                                    end;
                                                    GenJournalLine.Validate(Amount);
                                                    GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        until StandingOrderLines.Next = 0;
                    end;

                    if STOHead.Get(STOHeaderNo) then begin
                        //Charges
                        STOlinesname := StandingOrderLines."Destination Account Name";
                        GenSetup.Get;
                        TCharges := 0;
                        TransactionCharges.Reset;
                        TransactionCharges.SetRange(TransactionCharges."Transaction Type", StandingOrderHeader."Transaction Type");
                        if TransactionCharges.FindSet() then begin
                            repeat
                                if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) then begin

                                    ChargeAmount := 0;
                                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" then
                                        ChargeAmount := (StandingOrderHeader.Amount * TransactionCharges."Percentage of Amount") * 0.01
                                    else
                                        ChargeAmount := TransactionCharges."Charge Amount";

                                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                                        TariffDetails.Reset;
                                        TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                        if TariffDetails.FindSet() then begin
                                            repeat
                                                if (StandingOrderHeader.Amount >= TariffDetails."Lower Limit") and
                                                    (StandingOrderHeader.Amount <= TariffDetails."Upper Limit") then begin
                                                    if TariffDetails."Use Percentage" then
                                                        ChargeAmount := StandingOrderHeader.Amount * TariffDetails.Percentage * 0.01
                                                    else
                                                        ChargeAmount := TariffDetails."Charge Amount";
                                                end;
                                            until TariffDetails.Next = 0;
                                        end;
                                    end;

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Posting Date" := PDate;
                                    GenJournalLine."Document No." := DocNo;
                                    GenJournalLine."External Document No." := StandingOrderHeader."No.";
                                    GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
                                    GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
                                    GenJournalLine.Description := TransactionCharges.Description;
                                    GenJournalLine.Validate(GenJournalLine.Amount, ChargeAmount);
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.", TransactionCharges."G/L Account");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;


                                    if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                        (TransactionCharges."Recover Excise Duty" = true) then begin
                                        //Excise
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Journal Batch Name" := Jbatch;
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Posting Date" := PDate;
                                        GenJournalLine."Document No." := DocNo;
                                        GenJournalLine."External Document No." := StandingOrderHeader."No.";
                                        GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
                                        GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
                                        GenJournalLine.Description := StandingOrderLines."Document No." + ' Excise Duty';//TransactionCharges.Description;
                                        GenJournalLine.Validate(GenJournalLine.Amount, (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01);
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.", GenSetup."Excise Duty G/L");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                        //Excise
                                    end;
                                    TChargeAmount += ChargeAmount;
                                end;
                            until TransactionCharges.Next = 0;
                        end;
                        TCharges := TChargeAmount;
                        //Charges
                        LineNo := LineNo + 10000;
                        AmtDeducted += TCharges;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := Jtemplate;
                        GenJournalLine."Journal Batch Name" := Jbatch;

                        GenJournalLine."Line No." := LineNo;

                        GenJournalLine."Posting Date" := PDate;
                        GenJournalLine."Document No." := DocNo;
                        GenJournalLine."External Document No." := STOHead."No.";
                        GenJournalLine."Account Type" := STOHead."Source Account Type";
                        GenJournalLine.Validate(GenJournalLine."Account No.", STOHead."Source Account No.");
                        //GenJournalLine.Description:='Source:-'+STOHead."Source Account Name";
                        GenJournalLine.Description := PadStr('STO:-' + Format(STOHead."No.") + '-' + Format(STOlinesname), 50);
                        GenJournalLine.Validate(GenJournalLine.Amount, AmtDeducted);
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    end;
                    UpdateStandingOrderRegister('', Today, StandingOrderHeader."No.", '', StandingOrderHeader."Source Account No.", StandingOrderHeader."Source Account Name",
                                               StandingOrderHeader."Member No.", StandingOrderHeader."Payroll/Staff No.", StandingOrderHeader."Allow Partial Deduction",
                                               StandingOrdDeductStatus, StandingOrderHeader.Amount, AmtDeducted, StandingOrderHeader."Effective/Start Date", StandingOrderHeader."Duration (Months)",
                                               StandingOrderHeader."Frequency (Months)", StandingOrderHeader."End Date", StandingOrderHeader.Description, StandingOrderHeader."Transfered to EFT", false, StandingOrderHeader."No.");

                end;
                TotalDeduction += AmtDeducted;

            until StandingOrderHeader.Next = 0;
        end;
        exit(TotalDeduction);
    end;

    local procedure PostSavingSTO(SalHeaD: Record "Salary Header"; DocNo: Code[20]; PDate: Date; DActivity2: Code[20]; DBranch2: Code[20]; Jtemplate: Code[20]; Jbatch: Code[20]; RunBal: Decimal; MemberNo: Code[20]; LineNo: Integer; Salaccno: Code[20])
    var
        StandingOrderHeader: Record "Standing Order Header";
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        AvailableBal: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        BalAccountType: Enum "Gen. Journal Account Type";
        StandingOrdDeductStatus: Option " ",Successfull,"Partial Deduction",Failed;
        StandingOrdSRegister: Record "Standing Order Register";
        TCharges: Decimal;
        SalLines: Record "Salary Lines";
        STOHeaderNo: Code[20];
        StandingOrderLines: Record "Standing Order Lines";
        StandingOrderLinesII: Record "Standing Order Lines";
        STOHead: Record "Standing Order Header";
        STOlinesname: Text[80];
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        TChargeAmount: Decimal;
        TransTypes: Record "Transaction Types";
        SavingsACCS: Record "Savings Accounts";
        STR: Date;
        SkipSTO: Boolean;
        THESavings: Record "Savings Accounts";
        AmtDeducted: Decimal;
        TransactionTypes: record "Transaction Types";
        Txt004: label 'Dear Member your  standing order towards (loan) repayment was unsuccessful.';
        RemainingBal: decimal;
        MaxSTO: Decimal;
    begin
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        if GenJournalLine.findlast then begin
            LineNo := GenJournalLine."Line No.";
        end;
        AmtDeducted := 0;
        RemainingBal := RunBal;
        GenSetup.Get;
        StandingOrderHeader.Reset;
        StandingOrderHeader.SetCurrentkey(StandingOrderHeader."No.");
        StandingOrderHeader.SetRange(StandingOrderHeader."Member No.", MemberNo);
        StandingOrderHeader.SetRange(StandingOrderHeader.Status, StandingOrderHeader.Status::Approved);
        StandingOrderHeader.setrange(StandingOrderHeader."Source Account No.", Salaccno);
        if SalHeaD."Income Type" = SalHeaD."Income Type"::Payments THEN
            Loans.SetRange(Loans."Recovery Mode", Loans."recovery mode"::"Board Allowance")
        ELSE
            StandingOrderHeader.SetFilter(StandingOrderHeader."Income Type", '%1|%2|%3', StandingOrderHeader."income type"::Salary,
                                          StandingOrderHeader."income type"::Pension, StandingOrderHeader."income type"::"Direct Debit");
        if StandingOrderHeader.findfirst() then begin
            repeat
                AmtDeducted := 0;
                SkipSTO := false;
                if SkipSTO = false then begin
                    STOHeaderNo := '';
                    STOHeaderNo := StandingOrderHeader."No.";

                    if RunBal > StandingOrderHeader.Amount then begin
                        StandingOrdDeductStatus := Standingorddeductstatus::Successfull;
                    end else begin
                        StandingOrdDeductStatus := Standingorddeductstatus::"Partial Deduction";
                    end;
                    if RunBal < 0 then
                        RunBal := 0;

                    StandingOrderLines.Reset;
                    StandingOrderLines.SetRange(StandingOrderLines."Document No.", StandingOrderHeader."No.");
                    StandingOrderLines.Setfilter(StandingOrderLines."destination account type", '%1|%2', StandingOrderLines."destination account type"::Savings, StandingOrderLines."destination account type"::"G/L Account");
                    if StandingOrderLines.FindSet() then begin
                        repeat
                            MaxSTO := StandingOrderLines.Amount;
                            if RunBal > 0 then begin
                                if RunBal <= StandingOrderLines.Amount then begin
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Posting Date" := PDate;
                                    GenJournalLine."Document No." := DocNo;
                                    GenJournalLine."External Document No." := STOHead."No.";
                                    GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                    GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                    GenJournalLine.Description := PadStr(StandingOrderLines."Document No." + ' Destination:-' + '-' + StandingOrderHeader."Source Account No."
                                                                 , 50);

                                    if StandingOrderLines.Amount >= RunBal then begin
                                        GenJournalLine.Amount := RunBal * -1;
                                        AmtDeducted += RunBal;
                                        RunBal := 0;
                                    end
                                    else begin
                                        GenJournalLine.Amount := StandingOrderLines.Amount * -1;
                                        RunBal -= Abs(StandingOrderLines.Amount);
                                        AmtDeducted += Abs(StandingOrderLines.Amount);
                                    end;
                                    GenJournalLine.Validate(Amount);

                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end
                                else begin
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Posting Date" := PDate;
                                    GenJournalLine."Document No." := DocNo;
                                    GenJournalLine."External Document No." := STOHead."No.";
                                    GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                    GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                    GenJournalLine.Description := PadStr(StandingOrderLines."Document No." + ' Destination:-' + '-' + StandingOrderHeader."Source Account No."
                                                                 , 50);

                                    if StandingOrderLines.Amount >= MaxSTO then begin
                                        GenJournalLine.Amount := MaxSTO * -1;
                                        AmtDeducted += MaxSTO;
                                        RunBal -= MaxSTO;
                                        MaxSTO := 0;
                                    end
                                    else begin
                                        GenJournalLine.Amount := StandingOrderLines.Amount * -1;
                                        RunBal -= Abs(StandingOrderLines.Amount);
                                        AmtDeducted += Abs(StandingOrderLines.Amount);
                                        MaxSTO -= Abs(StandingOrderLines.Amount);
                                    end;

                                    // if StandingOrderLines.Amount >= RunBal then begin
                                    //     GenJournalLine.Amount := RunBal * -1;
                                    //     AmtDeducted += RunBal;
                                    //     RunBal := 0;
                                    // end
                                    // else begin
                                    //     GenJournalLine.Amount := StandingOrderLines.Amount * -1;
                                    //     RunBal -= Abs(StandingOrderLines.Amount);
                                    //     AmtDeducted += Abs(StandingOrderLines.Amount);
                                    // end;
                                    GenJournalLine.Validate(Amount);

                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;

                            end;

                        until StandingOrderLines.Next = 0;

                        if STOHead.Get(STOHeaderNo) then begin
                            //Charges
                            STOlinesname := StandingOrderLines."Destination Account Name";
                            GenSetup.Get;
                            TCharges := 0;
                            TransactionCharges.Reset;
                            TransactionCharges.SetRange(TransactionCharges."Transaction Type", StandingOrderHeader."Transaction Type");
                            if TransactionCharges.FindSet() then begin
                                repeat
                                    if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) then begin

                                        ChargeAmount := 0;
                                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" then
                                            ChargeAmount := (StandingOrderHeader.Amount * TransactionCharges."Percentage of Amount") * 0.01
                                        else
                                            ChargeAmount := TransactionCharges."Charge Amount";

                                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                                            TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                                            TariffDetails.Reset;
                                            TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                            if TariffDetails.FindSet() then begin
                                                repeat
                                                    if (StandingOrderHeader.Amount >= TariffDetails."Lower Limit") and
                                                        (StandingOrderHeader.Amount <= TariffDetails."Upper Limit") then begin
                                                        if TariffDetails."Use Percentage" then
                                                            ChargeAmount := StandingOrderHeader.Amount * TariffDetails.Percentage * 0.01
                                                        else
                                                            ChargeAmount := TariffDetails."Charge Amount";
                                                    end;
                                                until TariffDetails.Next = 0;
                                            end;
                                        end;

                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Journal Batch Name" := Jbatch;
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Posting Date" := PDate;
                                        GenJournalLine."Document No." := DocNo;
                                        GenJournalLine."External Document No." := StandingOrderHeader."No.";
                                        GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
                                        GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
                                        GenJournalLine.Description := StandingOrderLines."Document No." + ' ' + TransactionCharges.Description;
                                        GenJournalLine.Validate(GenJournalLine.Amount, ChargeAmount);
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.", TransactionCharges."G/L Account");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;


                                        if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                            (TransactionCharges."Recover Excise Duty" = true) then begin
                                            //Excise
                                            LineNo := LineNo + 10000;
                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                            GenJournalLine."Journal Batch Name" := Jbatch;
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Posting Date" := PDate;
                                            GenJournalLine."Document No." := DocNo;
                                            GenJournalLine."External Document No." := StandingOrderHeader."No.";
                                            GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
                                            GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
                                            GenJournalLine.Description := StandingOrderLines."Document No." + ' Excise Duty';//TransactionCharges.Description;
                                            GenJournalLine.Validate(GenJournalLine.Amount, (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01);
                                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.", GenSetup."Excise Duty G/L");
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;
                                            //Excise
                                        end;
                                        TChargeAmount += ChargeAmount;
                                    end;
                                until TransactionCharges.Next = 0;
                            end;
                        end;


                        TCharges := TChargeAmount;
                        //Charges
                        LineNo := LineNo + 10000;
                        AmtDeducted += TCharges;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := Jtemplate;
                        GenJournalLine."Journal Batch Name" := Jbatch;

                        GenJournalLine."Line No." := LineNo;

                        GenJournalLine."Posting Date" := PDate;
                        GenJournalLine."Document No." := DocNo;
                        GenJournalLine."External Document No." := STOHead."No.";
                        GenJournalLine."Account Type" := STOHead."Source Account Type";
                        GenJournalLine.Validate(GenJournalLine."Account No.", STOHead."Source Account No.");
                        //GenJournalLine.Description:='Source:-'+STOHead."Source Account Name";
                        GenJournalLine.Description := PadStr('STO:-' + Format(STOHead."No.") + '-' + Format(STOlinesname), 50);
                        GenJournalLine.Validate(GenJournalLine.Amount, AmtDeducted);
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    end;
                    UpdateStandingOrderRegister('', Today, StandingOrderHeader."No.", '', StandingOrderHeader."Source Account No.", StandingOrderHeader."Source Account Name",
                                               StandingOrderHeader."Member No.", StandingOrderHeader."Payroll/Staff No.", StandingOrderHeader."Allow Partial Deduction",
                                               StandingOrdDeductStatus, StandingOrderHeader.Amount, AmtDeducted, StandingOrderHeader."Effective/Start Date", StandingOrderHeader."Duration (Months)",
                                               StandingOrderHeader."Frequency (Months)", StandingOrderHeader."End Date", StandingOrderHeader.Description, StandingOrderHeader."Transfered to EFT", false, StandingOrderHeader."No.");

                end;
                RemainingBal -= AmtDeducted;

            until StandingOrderHeader.Next = 0;
        end;
    end;




    procedure PostPensionLine(SalLine: Record "Salary Lines")
    var
        GenJournalLine: Record "Gen. Journal Line";
        Temp: Record "Banking User Template";
        Jtemplate: Code[20];
        JBatch: Code[20];
        Text0001: label 'Ensure the Salary  Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Salary Journal Batch is set up in Banking User Setup';
        Text0003: label 'Ensure the Default Bank is set up in User Setup';
        Text0004: label 'The transaction has already been posted.';
        RunBal: Decimal;
        Gensetup: Record "General Set-Up";
        LineNo: Integer;
        PDate: Date;
        DocNo: Code[20];
        PostingRemarks: Text[500];
        DActivity2: Code[20];
        DBranch2: Code[20];
        Account: Record "Savings Accounts";
        AvailableBal: Decimal;
        ProductF: Record "Product Factory";
        SalFee: Decimal;
        SalGLAccount: Code[20];
        TCharges: Decimal;
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        MemberNo: Code[20];
        Salaccno: Code[20];
        Text0005: label 'Your Pension of KES ';
        Text0006: label ' has been credited to your FOSA  account ';
        Text0007: label ' on ';
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        Text0008: Text;
        WasBlocked: Boolean;
    begin

        if Not Posted then begin

            Temp.Get(UserId);
            Jtemplate := Temp."Salary Journal Template";
            JBatch := Temp."Salary Journal Batch";

            if Jtemplate = '' then begin
                Error(Text0001);
            end;

            if JBatch = '' then begin
                Error(Text0002);
            end;

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            GenJournalLine.DeleteAll;


            RunBal := 0;

            Gensetup.Get;

            LineNo := LineNo + 10000;
            //TotSal:=TotSal+SalLines.Amount;

            PDate := Today;
            DocNo := SalLine."Salary Header No.";
            PostingRemarks := 'NCBA ' + Format(SalLine."Income Type");

            MemberNo := '';
            Salaccno := '';

            MemberNo := SalLine."Member No.";
            Salaccno := SalLine."Account No.";

            WasBlocked := false;
            if Account.Get(SalLine."Account No.") then begin
                if Account.Blocked <> Account.Blocked::" " then begin
                    BlockUblock(Account."No.", true);
                    wasBlocked := true;
                end;

                DActivity2 := Account."Global Dimension 1 Code";
                DBranch2 := Account."Global Dimension 2 Code";


                RunBal := SalLine.Amount;

                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := Jtemplate;
                GenJournalLine."Journal Batch Name" := JBatch;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := CopyStr(DocNo, 1, 14);
                //GenJournalLine."External Document No.":=SalLines."Branch Reff.";
                GenJournalLine."Posting Date" := PDate;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                GenJournalLine."Account No." := SalLine."Account No.";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine.Description := PostingRemarks;
                GenJournalLine.Amount := -SalLine.Amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := Jtemplate;
                GenJournalLine."Journal Batch Name" := JBatch;//USERID;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := CopyStr(DocNo, 1, 14);
                //GenJournalLine."External Document No.":=SalLines."Branch Reff.";
                GenJournalLine."Posting Date" := PDate;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine.Description := PostingRemarks;//'Salary';

                // General Setup
                GenJournalLine."Account Type" := Gensetup."NCBA Account Type";

                GenJournalLine."Account No." := Gensetup."NCBA Account No";

                GenJournalLine.Amount := SalLine.Amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //Charges
                TCharges := 0;
                TransactionCharges.Reset;

                // General Setup
                TransactionCharges.SetRange(TransactionCharges."Transaction Type", Gensetup."NCBA Transaction Type");
                // General Setup

                if TransactionCharges.FindSet() then begin
                    repeat
                        LineNo := LineNo + 10000;
                        ChargeAmount := 0;
                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                            ChargeAmount := (SalLine.Amount * TransactionCharges."Percentage of Amount") * 0.01
                        else
                            ChargeAmount := TransactionCharges."Charge Amount";
                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                            TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                            TariffDetails.Reset;
                            TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                            if TariffDetails.FindSet() then begin
                                repeat
                                    if (SalLine.Amount >= TariffDetails."Lower Limit") and (SalLine.Amount <= TariffDetails."Upper Limit") then begin
                                        if TariffDetails."Use Percentage" = true then begin
                                            ChargeAmount := SalLine.Amount * TariffDetails.Percentage * 0.01;
                                        end else begin
                                            ChargeAmount := TariffDetails."Charge Amount";
                                        end;
                                    end;
                                until TariffDetails.Next = 0;
                            end;
                        end;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := Jtemplate;
                        GenJournalLine."Journal Batch Name" := JBatch;
                        GenJournalLine."Document No." := CopyStr(DocNo, 1, 14);
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                        GenJournalLine."Account No." := SalLine."Account No.";
                        //GenJournalLine."External Document No.":="ID No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := PDate;
                        GenJournalLine.Description := TransactionCharges.Description;
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := ChargeAmount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        RunBal := RunBal - GenJournalLine.Amount;

                        //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                        if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                        (TransactionCharges."Recover Excise Duty" = true) then begin
                            //Excise Duty
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Document No." := CopyStr(DocNo, 1, 14);
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                            GenJournalLine."Account No." := SalLine."Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := PDate;
                            GenJournalLine.Description := 'Excise Duty';
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := (ChargeAmount * Gensetup."Excise Duty (%)") * 0.01;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := Gensetup."Excise Duty G/L";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                            RunBal := RunBal - GenJournalLine.Amount;

                            TCharges := TCharges + ChargeAmount;
                        end;
                    until TransactionCharges.Next = 0;
                end;

                //--Activate Dormant.
                ActivateDormantNCBA(SalLine."Salary Header No.", DocNo, PDate, DActivity2, DBranch2, Jtemplate, JBatch, RunBal, MemberNo, LineNo, Salaccno);

                // SMS Charges here
                if Gensetup."Disable Salary SMS" = false then begin
                    TransactionCharges.Reset;
                    TransactionCharges.SetRange(TransactionCharges."Transaction Type", Gensetup."Loan SMS Charge");
                    if TransactionCharges.FindSet() then begin
                        repeat
                            LineNo := LineNo + 10000;
                            ChargeAmount := 0;
                            if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                                ChargeAmount := (SalLine.Amount * TransactionCharges."Percentage of Amount") * 0.01
                            else
                                ChargeAmount := TransactionCharges."Charge Amount";
                            if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                                TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                                TariffDetails.Reset;
                                TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                if TariffDetails.FindSet() then begin
                                    repeat
                                        if (SalLine.Amount >= TariffDetails."Lower Limit") and (SalLine.Amount <= TariffDetails."Upper Limit") then begin
                                            if TariffDetails."Use Percentage" = true then begin
                                                ChargeAmount := SalLine.Amount * TariffDetails.Percentage * 0.01;
                                            end else begin
                                                ChargeAmount := TariffDetails."Charge Amount";
                                            end;
                                        end;
                                    until TariffDetails.Next = 0;
                                end;
                            end;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Document No." := CopyStr(DocNo, 1, 20);
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                            GenJournalLine."Account No." := SalLine."Account No.";
                            //GenJournalLine."External Document No.":="ID No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := PDate;
                            GenJournalLine.Description := TransactionCharges.Description;
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := ChargeAmount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert(false);
                            RunBal := RunBal - GenJournalLine.Amount;

                            //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                            if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                            (TransactionCharges."Recover Excise Duty" = true) then begin
                                //Excise Duty
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := JBatch;

                                //if SalHeaD."Income Type" <> SalHeaD."Income Type"::SAYE then
                                GenJournalLine."Document No." := CopyStr(DocNo, 1, 20);
                                // else
                                //     GenJournalLine."Document No." := CopyStr(SalLines."Document No.", 1, 20);

                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                GenJournalLine."Account No." := SalLine."Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := PDate;
                                GenJournalLine.Description := TransactionCharges.Description + ' Excise Duty.';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := (ChargeAmount * Gensetup."Excise Duty (%)") * 0.01;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := Gensetup."Excise Duty G/L";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert(false);
                                RunBal := RunBal - GenJournalLine.Amount;
                            end;
                        until TransactionCharges.Next = 0;
                    end;
                end;

                // Take all amount even already in FOSA
                if Account.Get(SalLine."Account No.") then begin
                    if Account.GetAvailableBalance(Account."No.") > 0 then
                        RunBal := RunBal + Account.GetAvailableBalance(Account."No.");
                end;
                // if SalHeaD."Donnot Recover" = false then
                PostSalaryLoansNCBA(DocNo, PDate, DActivity2, DBranch2, Jtemplate, JBatch, RunBal, MemberNo, LineNo, Salaccno);

                if Account.Get(SalLine."Account No.") then begin
                    if Account."Loan Disbursement Account" = false then begin
                        Account."Loan Disbursement Account" := true;
                        Account.Modify;
                    end;
                end;

            end;

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
            end;
            //BlockUblock
            if wasBlocked = true then
                BlockUblock(Account."No.", false);

            SalLine.Posted := true;
            SalLine."Posted By" := UserId;
            SalLine."Posting Date" := Today;
            SalLine."Posting Time" := Time;
            // SalLine."Income Type" := SalLine."Income Type"::Pension;
            SalLine."Actual Date Posted" := Today;
            SalLine.Modify;
            Commit;//*
            Gensetup.Get();
            if Gensetup."Disable Salary SMS" = false then begin
                if Account.Get(SalLine."Account No.") then begin
                    MobileNo := Account."Mobile Phone No";
                    if MobileNo = '' then begin
                        if Memb.get(Account."Member No.") then
                            MobileNo := Memb."Phone No.";
                    end;
                    Text0008 := Gensetup."Salary SMS Suffix";
                    msg := 'Your ' + Format(SalLine."Income Type") + ' of KES ' + Format(SalLine.Amount) + Text0006 + Text0007 + ddMMyyyy(Today) + ' ' + Format(Time) + ' ' + Text0008;

                    SendSMS.SendSms(Source::SALARY_PROCESSING, MobileNo, msg, Format(SalLine."Account No."), '', true, 0, false, 'CBS', SalLine."Account No.", 'CBS');

                end;
            end;

        end;
    end;



    local procedure PostSalaryLoansNCBA(DocNo: Code[20]; PDate: Date; DActivity2: Code[20]; DBranch2: Code[20]; Jtemplate: Code[20]; Jbatch: Code[20]; RunBal: Decimal; MemberNo: Code[20]; LineNo: Integer; Salaccno: Code[20])
    var
        Loans: Record Loans;
        Interest: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        LRepayment: Decimal;
        SalLines: Record "Salary Lines";
        CreditLedger: Record "Credit Ledger Entry";
        ProductType: Record "Product Factory";
        StandingOrdSRegister: Record "Standing Order Register";
        remainingBal: Decimal;
    begin
        // with SalHeaD do
        begin
            remainingBal := PostNCBALoanSTO(DocNo, PDate, DActivity2, DBranch2, Jtemplate, Jbatch, RunBal, MemberNo, LineNo, Salaccno);

            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            if GenJournalLine.findlast then begin
                LineNo := GenJournalLine."Line No.";
            end;

            RunBal -= remainingBal;

            Loans.Reset;
            Loans.SetRange(Loans."Member No.", MemberNo);
            Loans.SetFilter("Recovery Mode", '%1|%2', Loans."Recovery Mode"::Salary, Loans."Recovery Mode"::Pension);
            Loans.SetAutoCalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest", "Daily Interest");
            if Loans.FindSet() then begin
                repeat
                    if RunBal > 0 then begin
                        if (Loans."Outstanding Interest" + Loans."Daily Interest") > 0 then begin
                            Interest := 0;
                            Interest := Loans."Outstanding Interest" + Loans."Daily Interest";
                            if Interest > 0 then begin
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := Jbatch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Credit;
                                GenJournalLine."Account No." := Loans."Loan Account";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := CopyStr(DocNo, 1, 14);
                                GenJournalLine."Posting Date" := PDate;
                                GenJournalLine.Description := 'Interest Paid';
                                if RunBal > Interest then
                                    GenJournalLine.Amount := Interest * -1
                                else
                                    GenJournalLine.Amount := RunBal * -1;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                GenJournalLine."Loan No" := Loans."Loan No.";
                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := Jbatch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                GenJournalLine."Account No." := Salaccno;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := CopyStr(DocNo, 1, 14);
                                GenJournalLine."Posting Date" := PDate;
                                GenJournalLine.Description := PadStr('Interest Paid - ' + Loans."Loan Product Type Name", 50);
                                if RunBal > Interest then
                                    GenJournalLine.Amount := Interest
                                else
                                    GenJournalLine.Amount := RunBal;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Loan No" := Loans."Loan No.";
                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                RunBal := RunBal - Abs(GenJournalLine.Amount);
                            end;
                        end;

                        if RunBal > 0 then begin
                            if Loans."Outstanding Balance" > 0 then begin

                                LRepayment := 0;
                                // if Loans."Recovery Mode" = Loans."Recovery Mode"::Hybrid then
                                //     LRepayment := Loans."Salary Amount"
                                // else
                                if (Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised) then begin
                                    LRepayment := Loans.Repayment - Interest;
                                    if Loans."Variated Amount" <> 0 then
                                        LRepayment := Loans."Variated Amount" - Interest;
                                end
                                else begin
                                    LRepayment := Loans."Loan Principle Repayment";
                                    if Loans."Variated Amount" <> 0 then
                                        LRepayment := Loans."Variated Amount";
                                end;

                                if LRepayment = 0 then LRepayment := Loans.Repayment;
                                IF LRepayment <= 0 THEN BEGIN
                                    if Loans.Installments <= 0 then Loans.Installments := 1;
                                    // LRepayment := ROUND((Loans."Approved Amount" / Loans.Installments), 0.01, '>');
                                    //hybrid repayment
                                    // if Loans."Recovery Mode" = Loans."Recovery Mode" then begin
                                    //     LRepayment := Loans."Salary Amount";
                                    // end else begin
                                    LRepayment := ROUND((Loans."Approved Amount" / Loans.Installments), 0.01, '>');
                                    // end;

                                end;


                                if LRepayment > 0 then begin
                                    if LRepayment > Loans."Outstanding Balance" then
                                        LRepayment := Loans."Outstanding Balance";

                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Credit;
                                    GenJournalLine."Account No." := Loans."Loan Account";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := CopyStr(DocNo, 1, 14);
                                    GenJournalLine."Posting Date" := PDate;
                                    GenJournalLine.Description := 'Loan Repayment';
                                    if RunBal > LRepayment then
                                        GenJournalLine.Amount := LRepayment * -1
                                    else
                                        GenJournalLine.Amount := RunBal * -1;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                                    GenJournalLine."Loan No" := Loans."Loan No.";
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                    GenJournalLine."Account No." := Salaccno;
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := CopyStr(DocNo, 1, 14);
                                    GenJournalLine."Posting Date" := PDate;
                                    GenJournalLine.Description := PadStr('Loan Repayment - ' + Loans."Loan Product Type Name", 50);
                                    if RunBal > LRepayment then
                                        GenJournalLine.Amount := LRepayment
                                    else
                                        GenJournalLine.Amount := RunBal;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Loan No" := Loans."Loan No.";
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                    RunBal := RunBal - GenJournalLine.Amount;
                                    //ERROR('Interst %1',Interest);
                                end;
                            end;
                        end;
                    end;
                //LineNo += 1;
                until Loans.Next = 0;
            end;
        end;
        //Savings STO
        if RunBal > 0 then
            PostNCBASavingSTO(DocNo, PDate, DActivity2, DBranch2, Jtemplate, Jbatch, RunBal, MemberNo, LineNo, Salaccno);
        /*
        StandingOrdSRegister.RESET;
        StandingOrdSRegister.SETRANGE("Source Account No.",Salaccno);
        StandingOrdSRegister.SETRANGE("Deduction Status",StandingOrdSRegister."Deduction Status"::Successfull);
        StandingOrdSRegister.SETRANGE("Date Processed",CALCDATE('-5D',PDate),PDate);
        IF NOT StandingOrdSRegister.FIND('-') THEN
        */
        // PostSalarySTONCBA(DocNo, PDate, DActivity2, DBranch2, Jtemplate, Jbatch, RunBal, MemberNo, LineNo, Salaccno);

    end;
    //test

    local procedure PostSalarySTONCBA(DocNo: Code[20]; PDate: Date; DActivity2: Code[20]; DBranch2: Code[20]; Jtemplate: Code[20]; Jbatch: Code[20]; RunBal: Decimal; MemberNo: Code[20]; LineNo: Integer; Salaccno: Code[20])
    var
        StandingOrderHeader: Record "Standing Order Header";
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        AvailableBal: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        BalAccountType: Enum "Gen. Journal Account Type";
        StandingOrdDeductStatus: Option " ",Successfull,"Partial Deduction",Failed;
        StandingOrdSRegister: Record "Standing Order Register";
        TCharges: Decimal;
        SalLines: Record "Salary Lines";
        STOHeaderNo: Code[20];
        StandingOrderLines: Record "Standing Order Lines";
        StandingOrderLinesII: Record "Standing Order Lines";
        LoanApps: Record Loans;
        LoanInterest: Decimal;
        LoanPrinciple: Decimal;
        STOHead: Record "Standing Order Header";
        STOlinesname: Text[80];
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        TChargeAmount: Decimal;
        AmountDedu: Decimal;
        LoanPrincipal: Decimal;
        LoanRepayment: Decimal;
        TransTypes: Record "Transaction Types";
        DeductedSTO: Decimal;
        SavingsACCS: Record "Savings Accounts";
        STR: Date;
        SkipSTO: Boolean;
        THESavings: Record "Savings Accounts";
        AmtDeducted: Decimal;
        TransactionTypes: record "Transaction Types";
        Txt004: label 'Dear Member your  standing order towards (senior saver loan) repayment was unsuccessful.';
    begin
        //with SalHeaD do 
        begin

            GenSetup.Get;

            StandingOrderHeader.Reset;
            StandingOrderHeader.SetCurrentkey(StandingOrderHeader."No.");
            StandingOrderHeader.SetRange(StandingOrderHeader."Member No.", MemberNo);
            StandingOrderHeader.SetRange(StandingOrderHeader.Status, StandingOrderHeader.Status::Approved);

            // if SalHeaD."Income Type" = SalHeaD."Income Type"::Payments THEN
            //     Loans.SetRange(Loans."Recovery Mode", Loans."recovery mode"::"Board Allowance")
            // ELSE

            StandingOrderHeader.SetFilter(StandingOrderHeader."Income Type", '%1|%2|%3|%4', StandingOrderHeader."income type"::Salary,
                                          StandingOrderHeader."income type"::Pension, StandingOrderHeader."income type"::"Direct Debit", StandingOrderHeader."income type"::SAYE);
            StandingOrderHeader.setrange(StandingOrderHeader."Source Account No.", Salaccno);
            if StandingOrderHeader.FindSet() then begin //*Header Info

                repeat
                    SkipSTO := false;
                    LineNo += 1;
                    StandingOrdSRegister.Reset();
                    StandingOrdSRegister.SetRange("Document No.", StandingOrderHeader."No.");
                    if StandingOrdSRegister.FindSet() then begin
                        repeat
                            AmtDeducted += StandingOrdSRegister."Amount Deducted";
                        until StandingOrdSRegister.Next() = 0;
                    end;
                    // if AmtDeducted >= StandingOrderHeader."Target Amount" then begin
                    //     SkipSTO := true;
                    //     StandingOrderHeader.Status := StandingOrderHeader.Status::Stopped;
                    //     StandingOrderHeader.Modify();
                    // end;

                    // AmountToDeduct := StandingOrderHeader."Target Amount" - AmountDeducted;

                    // STR := (CalcDate('-5D', PDate));

                    // //For non partial
                    // StandingOrdSRegister.Reset;
                    // StandingOrdSRegister.SetCurrentkey("Date Processed", "No.");
                    // StandingOrdSRegister.SetRange("Document No.", StandingOrderHeader."No.");
                    // StandingOrdSRegister.SetRange("Deduction Status", StandingOrdSRegister."deduction status"::Successful);
                    // if StandingOrdSRegister.FindLast then begin
                    //     if (StandingOrdSRegister."Date Processed" >= STR) and (StandingOrdSRegister."Date Processed" <= PDate) then
                    //         SkipSTO := true;
                    // end;

                    StandingOrderLinesII.reset;
                    StandingOrderLinesII.SetRange("Destination Account Type", StandingOrderLinesII."Destination Account Type"::Credit);
                    StandingOrderLinesII.SetRange(StandingOrderLinesII."Document No.", STOHeaderNo);
                    if StandingOrderLinesII.Findset() then begin
                        repeat
                            if LoanApps.get(StandingOrderLinesII."Loan No.") then begin
                                LoanApps.CalcFields("Outstanding Balance");
                                if LoanApps."Outstanding Balance" <= 0 then SkipSTO := true;
                            end else
                                SkipSTO := true;
                            IF StandingOrderLinesII."Destination Account Type" = StandingOrderLinesII."Destination Account Type"::Savings then begin
                                IF NOT THESavings.get(StandingOrderLinesII."Destination Account No.") then
                                    SkipSTO := true;
                            end;
                        until
                        StandingOrderLinesII.Next = 0;
                    end;

                    //Taking into consideration double salary for partial
                    StandingOrdSRegister.Reset;
                    StandingOrdSRegister.SetCurrentkey("Date Processed", "No.");
                    StandingOrdSRegister.SetRange("Document No.", StandingOrderHeader."No.");
                    StandingOrdSRegister.SetRange("Deduction Status", StandingOrdSRegister."deduction status"::"Partial Deduction");
                    StandingOrdSRegister.SetFilter("Date Processed", '>=%1', STR);
                    if StandingOrdSRegister.FindLast then begin
                        if (StandingOrdSRegister."Date Processed" >= STR) and (StandingOrdSRegister."Date Processed" <= PDate) and (StandingOrdSRegister."Amount Deducted" >= StandingOrderHeader.Amount) then
                            SkipSTO := true;
                    end;
                    if SkipSTO = false then begin
                        STOHeaderNo := '';
                        STOHeaderNo := StandingOrderHeader."No.";
                        //*
                        /*StandingOrdSRegister.RESET;
                        StandingOrdSRegister.SETRANGE(StandingOrdSRegister."Date Processed",TODAY);
                        StandingOrdSRegister.SETRANGE("Document No.",StandingOrderHeader."No.");
                        IF StandingOrdSRegister.FIND('-') THEN
                        StandingOrdSRegister.DELETEALL;*///27.04.2021

                        //*
                        //ERROR(FORMAT(StandingOrderHeader."Allow Partial Deduction"));
                        if StandingOrderHeader."Allow Partial Deduction" = false then begin

                            if RunBal < StandingOrderHeader.Amount then begin

                                //Sto Charges on failure
                                GenSetup.Get;

                                TCharges := 0;
                                TransactionTypes.Reset;
                                TransactionTypes.SetRange(Code, GenSetup."Failed STO Fee");
                                if TransactionTypes.Find('-') then begin
                                    TransactionCharges.Reset;
                                    TransactionCharges.SetRange("Transaction Type", TransactionTypes.Code);
                                    //TransactionCharges.SetRange("Transaction Type", StandingOrderHeader."Transaction Type");
                                    // TransactionCharges.SetRange(TransactionCharges."Transaction Charge Category",TransactionCharges."Transaction Charge Category"::"Failed STO Charge");
                                    if TransactionCharges.FindSet() then begin
                                        repeat
                                            if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::"Failed STO Charge") then begin

                                                ChargeAmount := 0;
                                                if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"Flat Amount" then
                                                    ChargeAmount := TransactionCharges."Charge Amount";

                                                if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" then
                                                    ChargeAmount := (StandingOrderHeader.Amount * TransactionCharges."Percentage of Amount") * 0.01;


                                                if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                                                    TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                                                    TariffDetails.Reset;
                                                    TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                                    if TariffDetails.FindSet() then begin
                                                        repeat
                                                            if (StandingOrderHeader.Amount >= TariffDetails."Lower Limit") and
                                                                (StandingOrderHeader.Amount <= TariffDetails."Upper Limit") then begin
                                                                if TariffDetails."Use Percentage" then
                                                                    ChargeAmount := StandingOrderHeader.Amount * TariffDetails.Percentage * 0.01
                                                                else
                                                                    ChargeAmount := TariffDetails."Charge Amount";
                                                            end;
                                                        until TariffDetails.Next = 0;
                                                    end;
                                                end;

                                                LineNo := LineNo + 10000;

                                                GenJournalLine.Init;
                                                GenJournalLine."Journal Template Name" := Jtemplate;
                                                GenJournalLine."Journal Batch Name" := Jbatch;
                                                GenJournalLine."Line No." := LineNo;
                                                GenJournalLine."Posting Date" := PDate;
                                                GenJournalLine."Document No." := DocNo;
                                                GenJournalLine."External Document No." := StandingOrderHeader."No.";
                                                GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
                                                GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
                                                GenJournalLine.Description := TransactionCharges.Description;
                                                GenJournalLine.Validate(GenJournalLine.Amount, ChargeAmount);
                                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.", TransactionCharges."G/L Account");
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                if GenJournalLine.Amount <> 0 then
                                                    GenJournalLine.Insert;


                                                if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                                    (TransactionCharges."Recover Excise Duty" = true) then begin
                                                    //Excise
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Posting Date" := PDate;
                                                    GenJournalLine."Document No." := DocNo;
                                                    GenJournalLine."External Document No." := StandingOrderHeader."No.";
                                                    GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
                                                    GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
                                                    GenJournalLine.Description := 'Excise Duty';//TransactionCharges.Description;
                                                    GenJournalLine.Validate(GenJournalLine.Amount, (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01);
                                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.", GenSetup."Excise Duty G/L");
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;
                                                    //Excise
                                                end;
                                                TChargeAmount += ChargeAmount;
                                            end;
                                        until TransactionCharges.Next = 0;
                                    end;
                                end;
                                TCharges := TChargeAmount;

                                UpdateStandingOrderRegister('', Today, StandingOrderHeader."No.", '', StandingOrderHeader."Source Account No.", StandingOrderHeader."Source Account Name",
                                                                    StandingOrderHeader."Member No.", StandingOrderHeader."Payroll/Staff No.", StandingOrderHeader."Allow Partial Deduction",
                                                                    Standingorddeductstatus::Failed, StandingOrderHeader.Amount, 0, StandingOrderHeader."Effective/Start Date", StandingOrderHeader."Duration (Months)",
                                                                    StandingOrderHeader."Frequency (Months)", StandingOrderHeader."End Date", StandingOrderHeader.Description, StandingOrderHeader."Transfered to EFT", false, StandingOrderHeader."No.");
                                //SendSMS.SendSms(Source::ATM_COLLECTION, SavingsAcc."Mobile Phone No", Txt004, Format(StandingOrderHeader."No."), '', true, 0, false, 'CBS', StandingOrderHeader."No.", 'CBS');
                                // StandingOrdSRegister.Reset();
                                // StandingOrdSRegister.SetRange("No.", StandingOrdSRegister."Standing Order No.");
                                // StandingOrdSRegister.SetRange("Source Account No.", StandingOrdSRegister."Source Account No.");
                                // StandingOrdSRegister.SetRange("Member No", StandingOrderHeader."Member No.");
                                // StandingOrdSRegister.SetRange("Deduction Status", StandingOrdSRegister."Deduction Status"::Failed);
                                // if StandingOrdSRegister.FindFirst() then begin
                                //     msg := 'Dear ' + StandingOrdSRegister."Source Account Name" + ', Your Standing Order towards (senior saver loan) repayment was unsuccessful.';
                                //     SendSMS.SendSms(Source::Tenants, Memb."Phone No.", msg, Format(Memb."No."), '', true, 0, false, 'CBS', Format(Memb."No."), 'CBS');
                                // end;

                                //Sto Charges on failure
                            end else begin

                                UpdateStandingOrderRegister('', Today, StandingOrderHeader."No.", '', StandingOrderHeader."Source Account No.", StandingOrderHeader."Source Account Name",
                                                                StandingOrderHeader."Member No.", StandingOrderHeader."Payroll/Staff No.", StandingOrderHeader."Allow Partial Deduction",
                                                                Standingorddeductstatus::Successfull, StandingOrderHeader.Amount, StandingOrderHeader.Amount, StandingOrderHeader."Effective/Start Date", StandingOrderHeader."Duration (Months)",
                                                                StandingOrderHeader."Frequency (Months)", StandingOrderHeader."End Date", StandingOrderHeader.Description, StandingOrderHeader."Transfered to EFT", false, StandingOrderHeader."No.");


                                STOlinesname := '';
                                AmountDedu := 0;

                                //*Line Posting
                                StandingOrderLines.Reset;
                                //StandingOrderLines.SETCURRENTKEY("Destination Account Type","Destination Account Type"::Internal);
                                StandingOrderLines.SetRange(StandingOrderLines."Document No.", STOHeaderNo);
                                if StandingOrderLines.FindSet() then begin
                                    repeat
                                        case StandingOrderLines."Destination Account Type" of
                                            //*Credit Entries
                                            StandingOrderLines."destination account type"::Credit:
                                                begin

                                                    LoanApps.Reset;
                                                    LoanApps.SetRange(LoanApps."Loan No.", StandingOrderLines."Loan No.");
                                                    //LoanApps.SETFILTER("Total Balance",'>0');
                                                    if LoanApps.Find('-') then begin
                                                        LoanApps.CalcFields(LoanApps."Outstanding Interest", LoanApps."Outstanding Balance", "Daily Interest");
                                                        //Capitalize Interest
                                                        if LoanApps."Daily Interest" > 0 then begin
                                                            Amt := 0;
                                                            // Accrue Interest;
                                                            Pfact.Get(LoanApps."Loan Product Type");
                                                            Pfact.TestField("Loan Interest Account [G/L]");
                                                            AcctType := AcctType::Credit;
                                                            TransType := TransType::"Interest Due";
                                                            LineNo := LineNo + 10000;
                                                            AccNo := LoanApps."Loan Account";
                                                            BalAccType := BalAccType::"G/L Account";
                                                            BalAccNo := Pfact."Loan Interest Account [G/L]";
                                                            Amt := LoanApps."Daily Interest";

                                                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CopyStr(DocNo, 1, 14),
                                                            CopyStr('Daily Interest Capitalized', 1, 50), Amt, AccNo, PDate, BalAccType,
                                                            BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                                            LoansProcess.ClearDailyInterest(LoanApps."Loan No.");
                                                        end;


                                                        LineNo := LineNo + 10000;

                                                        GenJournalLine.Init;
                                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                                        GenJournalLine."Journal Batch Name" := Jbatch;
                                                        GenJournalLine."Line No." := LineNo;
                                                        GenJournalLine."Posting Date" := PDate;
                                                        GenJournalLine."Document No." := DocNo;
                                                        GenJournalLine."External Document No." := StandingOrderHeader."No.";
                                                        GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                        GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                                        //GenJournalLine.Description:='Destination:-'+LoanApps."Loan No."+'-'+StandingOrderLines."Destination Account Name";
                                                        GenJournalLine.Description := PadStr('STO:-' + LoanApps."Loan No." + '-' + Format(StandingOrderHeader."Source Account Name"), 50);
                                                        if (LoanApps."Outstanding Interest" + LoanApps."Daily Interest") > StandingOrderLines.Amount then begin
                                                            LoanInterest := StandingOrderLines.Amount;
                                                            LoanPrinciple := 0;
                                                        end else begin
                                                            LoanPrinciple := StandingOrderLines.Amount - (LoanApps."Outstanding Interest" + LoanApps."Daily Interest");
                                                            if LoanPrinciple < 0 then LoanPrinciple := 0;
                                                            LoanInterest := (LoanApps."Outstanding Interest" + LoanApps."Daily Interest");
                                                            if LoanInterest < 0 then LoanInterest := 0;
                                                        end;
                                                        GenJournalLine.Validate(GenJournalLine.Amount, -LoanInterest);
                                                        GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                        if GenJournalLine.Amount <> 0 then
                                                            GenJournalLine.Insert;
                                                        RunBal -= Abs(GenJournalLine.Amount);
                                                        AmountDedu += Abs(GenJournalLine.Amount);


                                                        if LoanPrinciple > LoanApps."Outstanding Balance" then
                                                            LoanPrinciple := LoanApps."Outstanding Balance";

                                                        //repayment
                                                        LineNo := LineNo + 10000;

                                                        GenJournalLine.Init;
                                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                                        GenJournalLine."Journal Batch Name" := Jbatch;
                                                        GenJournalLine."Line No." := LineNo;
                                                        GenJournalLine."Posting Date" := PDate;
                                                        GenJournalLine."Document No." := DocNo;
                                                        GenJournalLine."External Document No." := StandingOrderHeader."No.";
                                                        GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                        GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                                        //GenJournalLine.Description:='Destination:-'+LoanApps."Loan No."+'-'+StandingOrderLines."Destination Account Name";
                                                        GenJournalLine.Description := PadStr('STO:-' + LoanApps."Loan No." + '-' + Format(StandingOrderHeader."Source Account Name"), 50);
                                                        //if LoanPrinciple > 0 then begin
                                                        GenJournalLine.Validate(GenJournalLine.Amount, -LoanPrinciple);
                                                        GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                                                        // End else
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                        if GenJournalLine.Amount <> 0 then
                                                            GenJournalLine.Insert;
                                                        RunBal -= Abs(GenJournalLine.Amount);
                                                        AmountDedu += Abs(GenJournalLine.Amount);

                                                        //Excess Back to FOSA
                                                        /*
                                                        if (StandingOrderLines.Amount - (LoanPrincipal + LoanInterest)) > 0 then begin
                                                            //repayment
                                                            LineNo := LineNo + 10000;

                                                            GenJournalLine.Init;
                                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                                            GenJournalLine."Journal Batch Name" := Jbatch;
                                                            GenJournalLine."Line No." := LineNo;
                                                            GenJournalLine."Posting Date" := PDate;
                                                            GenJournalLine."Document No." := DocNo;
                                                            GenJournalLine."External Document No." := StandingOrderHeader."No.";
                                                            GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type"::Savings;
                                                            GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
                                                            GenJournalLine.Description := PadStr('STO:-' + LoanApps."Loan No." + '-' + Format(StandingOrderHeader."Source Account Name"), 50);
                                                            GenJournalLine.Amount := ((StandingOrderLines.Amount - (LoanPrincipal + LoanInterest)) * -1);
                                                            GenJournalLine.validate(Amount);
                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                            if GenJournalLine.Amount <> 0 then
                                                                GenJournalLine.Insert;
                                                            RunBal -= Abs(GenJournalLine.Amount);
                                                            AmountDedu += Abs(GenJournalLine.Amount);
                                                        end;*/

                                                    end;
                                                end;//Credit Entries



                                            //*Internal,External Entries
                                            StandingOrderLines."destination account type"::"G/L Account", StandingOrderLines."destination account type"::Savings:
                                                begin

                                                    LineNo := LineNo + 10000;

                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                                    GenJournalLine."Journal Batch Name" := Jbatch;

                                                    GenJournalLine."Line No." := LineNo;

                                                    GenJournalLine."Posting Date" := PDate;
                                                    GenJournalLine."Document No." := DocNo;
                                                    GenJournalLine."External Document No." := StandingOrderHeader."No.";

                                                    case StandingOrderLines."Destination Account Type" of

                                                        StandingOrderLines."destination account type"::"G/L Account":
                                                            begin
                                                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                                                GenJournalLine.Validate(GenJournalLine."Account No.", GenSetup."External STO Account No.");
                                                            end;


                                                        StandingOrderLines."destination account type"::Savings:
                                                            begin
                                                                GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                                GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                                            end;
                                                    end;

                                                    //GenJournalLine.Description:='Destination:-'+StandingOrderLines."Destination Account Name";
                                                    GenJournalLine.Description := PadStr('STO:-' + Format(StandingOrderHeader."No.") + '-' + Format(StandingOrderHeader."Source Account Name"), 50);

                                                    if RunBal >= StandingOrderLines.Amount then
                                                        GenJournalLine.Validate(GenJournalLine.Amount, -StandingOrderLines.Amount)
                                                    else
                                                        GenJournalLine.Validate(GenJournalLine.Amount, -RunBal);

                                                    //GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;
                                                    RunBal -= Abs(GenJournalLine.Amount);
                                                    AmountDedu += Abs(GenJournalLine.Amount);
                                                end;//*Internal,External Entries


                                        end;
                                    until StandingOrderLines.Next = 0;
                                end;


                                //*Header Posting

                                if STOHead.Get(STOHeaderNo) then begin

                                    //**********************
                                    GenSetup.Get;


                                    TCharges := 0;
                                    TransactionCharges.Reset;
                                    TransactionCharges.SetRange(TransactionCharges."Transaction Type", StandingOrderHeader."Transaction Type");
                                    if TransactionCharges.FindSet() then begin
                                        repeat

                                            if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) then begin

                                                ChargeAmount := 0;
                                                if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" then
                                                    ChargeAmount := (StandingOrderHeader.Amount * TransactionCharges."Percentage of Amount") * 0.01
                                                else
                                                    ChargeAmount := TransactionCharges."Charge Amount";

                                                if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                                                    TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                                                    TariffDetails.Reset;
                                                    TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                                    if TariffDetails.FindSet() then begin
                                                        repeat
                                                            if (StandingOrderHeader.Amount >= TariffDetails."Lower Limit") and
                                                                (StandingOrderHeader.Amount <= TariffDetails."Upper Limit") then begin
                                                                if TariffDetails."Use Percentage" then
                                                                    ChargeAmount := StandingOrderHeader.Amount * TariffDetails.Percentage * 0.01
                                                                else
                                                                    ChargeAmount := TariffDetails."Charge Amount";
                                                            end;
                                                        until TariffDetails.Next = 0;
                                                    end;
                                                end;

                                                LineNo := LineNo + 10000;

                                                GenJournalLine.Init;
                                                GenJournalLine."Journal Template Name" := Jtemplate;
                                                GenJournalLine."Journal Batch Name" := Jbatch;
                                                GenJournalLine."Line No." := LineNo;
                                                GenJournalLine."Posting Date" := PDate;
                                                GenJournalLine."Document No." := DocNo;
                                                GenJournalLine."External Document No." := StandingOrderHeader."No.";
                                                GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
                                                GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
                                                GenJournalLine.Description := TransactionCharges.Description;
                                                GenJournalLine.Validate(GenJournalLine.Amount, ChargeAmount);
                                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.", TransactionCharges."G/L Account");
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                if GenJournalLine.Amount <> 0 then
                                                    GenJournalLine.Insert;


                                                if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                                    (TransactionCharges."Recover Excise Duty" = true) then begin
                                                    //Excise
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Posting Date" := PDate;
                                                    GenJournalLine."Document No." := DocNo;
                                                    GenJournalLine."External Document No." := StandingOrderHeader."No.";
                                                    GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
                                                    GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
                                                    GenJournalLine.Description := 'Excise Duty';//TransactionCharges.Description;
                                                    GenJournalLine.Validate(GenJournalLine.Amount, (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01);
                                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.", GenSetup."Excise Duty G/L");
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;
                                                    //Excise
                                                end;
                                                TChargeAmount += ChargeAmount;
                                            end;
                                        until TransactionCharges.Next = 0;
                                    end;
                                    TCharges := TChargeAmount;
                                    //**********************

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := Jbatch;

                                    GenJournalLine."Line No." := LineNo;

                                    GenJournalLine."Posting Date" := PDate;
                                    GenJournalLine."Document No." := DocNo;
                                    GenJournalLine."External Document No." := STOHead."No.";
                                    GenJournalLine."Account Type" := GenJournalLine."Account Type"::Savings;
                                    GenJournalLine.Validate(GenJournalLine."Account No.", STOHead."Source Account No.");
                                    //GenJournalLine.Description:='Source:-'+STOHead."Source Account Name";
                                    GenJournalLine.Description := PadStr('STO:-' + Format(STOHead."No.") + '-' + Format(STOlinesname), 50);
                                    // if AmountDedu > 0 then
                                    GenJournalLine.Validate(GenJournalLine.Amount, AmountDedu);// ELSE
                                    //    GenJournalLine.Validate(GenJournalLine.Amount, STOHead.Amount);

                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;
                            end;
                        end else begin
                            //Partial
                            AmountDedu := 0;
                            DeductedSTO := 0;

                            //Taking into consideration double salary
                            StandingOrdSRegister.Reset;
                            StandingOrdSRegister.SetCurrentkey("Date Processed", "No.");
                            StandingOrdSRegister.SetRange("Document No.", StandingOrderHeader."No.");
                            StandingOrdSRegister.SetRange("Deduction Status", StandingOrdSRegister."deduction status"::"Partial Deduction");
                            StandingOrdSRegister.SetFilter("Date Processed", '>=%1', STR);
                            if StandingOrdSRegister.FindLast then begin
                                if (StandingOrdSRegister."Date Processed" >= STR) and (StandingOrdSRegister."Date Processed" <= PDate) then
                                    StandingOrderHeader.Amount -= StandingOrdSRegister."Amount Deducted";
                            end;


                            if RunBal > StandingOrderHeader.Amount then begin
                                DeductedSTO := StandingOrderHeader.Amount;
                                StandingOrdDeductStatus := Standingorddeductstatus::Successfull;
                            end else begin
                                DeductedSTO := RunBal;
                                StandingOrdDeductStatus := Standingorddeductstatus::"Partial Deduction";

                            end;
                            if DeductedSTO < 0 then
                                DeductedSTO := 0;
                            //  ERROR(FORMAT(StandingOrdDeductStatus));
                            UpdateStandingOrderRegister('', Today, StandingOrderHeader."No.", '', StandingOrderHeader."Source Account No.", StandingOrderHeader."Source Account Name",
                                                        StandingOrderHeader."Member No.", StandingOrderHeader."Payroll/Staff No.", StandingOrderHeader."Allow Partial Deduction",
                                                        StandingOrdDeductStatus, StandingOrderHeader.Amount, DeductedSTO, StandingOrderHeader."Effective/Start Date", StandingOrderHeader."Duration (Months)",
                                                        StandingOrderHeader."Frequency (Months)", StandingOrderHeader."End Date", StandingOrderHeader.Description, StandingOrderHeader."Transfered to EFT", false, StandingOrderHeader."No.");


                            if StandingOrderHeader."Allow Partial Deduction" = true then begin //Partial Deduction
                                StandingOrderLines.Reset;
                                StandingOrderLines.SetRange(StandingOrderLines."Document No.", StandingOrderHeader."No.");
                                if StandingOrderLines.FindSet() then begin
                                    repeat
                                        STOlinesname := StandingOrderLines."Destination Account Name";
                                        //   MESSAGE('The Lines name is %1',STOlinesname);
                                        case StandingOrderLines."Destination Account Type" of
                                            StandingOrderLines."destination account type"::Savings, StandingOrderLines."destination account type"::"G/L Account":
                                                begin
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                                    GenJournalLine."Posting Date" := PDate;
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Document No." := DocNo;
                                                    GenJournalLine."External Document No." := STOHead."No.";
                                                    GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                    GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                                    //GenJournalLine.Description:=PADSTR('Destination:- '+StandingOrderHeader."Source Account No."+'-'+StandingOrderHeader."Source Account Name",50);
                                                    GenJournalLine.Description := PadStr('STO:-' + Format(StandingOrderHeader."No.") + '-' + Format(StandingOrderHeader."Source Account Name"), 50);
                                                    if RunBal >= StandingOrderLines.Amount then
                                                        GenJournalLine.Validate(GenJournalLine.Amount, -StandingOrderLines.Amount)
                                                    else
                                                        GenJournalLine.Validate(GenJournalLine.Amount, -RunBal);

                                                    //GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;

                                                    RunBal -= Abs(GenJournalLine.Amount);
                                                    AmountDedu += Abs(GenJournalLine.Amount); //MESSAGE('TE5 :%1',AmountDedu);
                                                end;

                                            StandingOrderLines."destination account type"::Credit:
                                                begin

                                                    LoanInterest := 0;
                                                    LoanPrincipal := 0;
                                                    LoanRepayment := 0;

                                                    LoanApps.Reset;
                                                    LoanApps.SetRange(LoanApps."Loan No.", StandingOrderLines."Loan No.");
                                                    if LoanApps.Find('-') then begin
                                                        LoanApps.CalcFields(LoanApps."Outstanding Interest", LoanApps."Daily Interest", LoanApps."Outstanding Balance");
                                                        //Capitalize Interest
                                                        if LoanApps."Daily Interest" > 0 then begin
                                                            Amt := 0;
                                                            // Accrue Interest;
                                                            Pfact.Get(LoanApps."Loan Product Type");
                                                            Pfact.TestField("Loan Interest Account [G/L]");
                                                            AcctType := AcctType::Credit;
                                                            TransType := TransType::"Interest Due";
                                                            LineNo := LineNo + 10000;
                                                            AccNo := LoanApps."Loan Account";
                                                            BalAccType := BalAccType::"G/L Account";
                                                            BalAccNo := Pfact."Loan Interest Account [G/L]";
                                                            Amt := LoanApps."Daily Interest";

                                                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, DocNo,
                                                            CopyStr('Daily Interest Capitalized', 1, 50), Amt, AccNo, PDate, BalAccType,
                                                            BalAccNo, LoanApps."Loan No.", LoanApps."Global Dimension 1 Code", LoanApps."Global Dimension 2 Code", TransType, LoanApps."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                                            LoansProcess.ClearDailyInterest(LoanApps."Loan No.");
                                                        end;


                                                        LoanPrincipal := StandingOrderLines.Amount;

                                                        if (LoanApps."Outstanding Interest" + LoanApps."Daily Interest") > 0 then begin
                                                            LineNo := LineNo + 10000;
                                                            GenJournalLine.Init;
                                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                                            GenJournalLine."Journal Batch Name" := Jbatch;
                                                            GenJournalLine."Line No." := LineNo;
                                                            GenJournalLine."Posting Date" := PDate;
                                                            GenJournalLine."Document No." := DocNo;
                                                            GenJournalLine."External Document No." := STOHead."No.";
                                                            GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                            GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                                            GenJournalLine.Description := PadStr('Destination:-' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                                                         Format(GenJournalLine."transaction type"::"Interest Paid"), 50);

                                                            if (LoanApps."Outstanding Interest" + LoanApps."Daily Interest") > StandingOrderLines.Amount then begin
                                                                LoanInterest := StandingOrderLines.Amount;
                                                                LoanPrincipal := StandingOrderLines.Amount - LoanInterest;
                                                                if LoanPrincipal < 0 then LoanPrincipal := 0;
                                                            end else
                                                                LoanInterest := (LoanApps."Outstanding Interest" + LoanApps."Daily Interest");
                                                            if LoanInterest < 0 then LoanInterest := 0;

                                                            if RunBal > LoanInterest then
                                                                GenJournalLine.Validate(GenJournalLine.Amount, -LoanInterest)
                                                            else
                                                                GenJournalLine.Validate(GenJournalLine.Amount, -RunBal);

                                                            GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                            if GenJournalLine.Amount <> 0 then
                                                                GenJournalLine.Insert;

                                                            RunBal -= Abs(GenJournalLine.Amount);
                                                            AmountDedu += Abs(GenJournalLine.Amount);
                                                        end;

                                                        if (LoanApps."Outstanding Balance" > 0) then begin
                                                            LineNo := LineNo + 10000;
                                                            LineNo := LineNo + 10000;
                                                            GenJournalLine.Init;
                                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                                            GenJournalLine."Journal Batch Name" := Jbatch;
                                                            GenJournalLine."Line No." := LineNo;
                                                            GenJournalLine."Posting Date" := PDate;
                                                            GenJournalLine."Document No." := DocNo;
                                                            GenJournalLine."External Document No." := STOHead."No.";
                                                            GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                            GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                                            GenJournalLine.Description := PadStr('Destination:-' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                                                         Format(GenJournalLine."transaction type"::Repayment), 50);

                                                            if LoanApps."Outstanding Balance" > LoanPrincipal then
                                                                LoanRepayment := LoanPrincipal
                                                            else
                                                                LoanRepayment := LoanApps."Outstanding Balance";

                                                            if RunBal > LoanRepayment then
                                                                GenJournalLine.Validate(GenJournalLine.Amount, -LoanRepayment)
                                                            else
                                                                GenJournalLine.Validate(GenJournalLine.Amount, -RunBal);

                                                            GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                            if GenJournalLine.Amount <> 0 then
                                                                GenJournalLine.Insert;

                                                            RunBal -= Abs(GenJournalLine.Amount);
                                                            AmountDedu += Abs(GenJournalLine.Amount);  //MESSAGE('TE8 :%1',AmountDedu);
                                                        end;


                                                    end;
                                                    /*Excess Back to Savings

                                                    if (StandingOrderLines.Amount - (LoanRepayment + LoanInterest)) > 0 then begin
                                                        //repayment
                                                        LineNo := LineNo + 10000;

                                                        GenJournalLine.Init;
                                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                                        GenJournalLine."Journal Batch Name" := Jbatch;
                                                        GenJournalLine."Line No." := LineNo;
                                                        GenJournalLine."Posting Date" := PDate;
                                                        GenJournalLine."Document No." := DocNo;
                                                        GenJournalLine."External Document No." := StandingOrderHeader."No.";
                                                        GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type"::Savings;
                                                        GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
                                                        GenJournalLine.Description := PadStr('STO:-' + LoanApps."Loan No." + '-' + Format(StandingOrderHeader."Source Account Name"), 50);
                                                        GenJournalLine.Amount := ((StandingOrderLines.Amount - (LoanPrincipal + LoanInterest)) * -1);
                                                        GenJournalLine.validate(Amount);
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                        if GenJournalLine.Amount <> 0 then
                                                            GenJournalLine.Insert;
                                                        RunBal -= Abs(GenJournalLine.Amount);
                                                        AmountDedu += Abs(GenJournalLine.Amount);
                                                    end;*/

                                                end;
                                        end;
                                    until StandingOrderLines.Next = 0;
                                end;
                                //--Partial End***
                            end;

                            //*Header Posting

                            if STOHead.Get(STOHeaderNo) then begin


                                //Charges
                                STOlinesname := StandingOrderLines."Destination Account Name";


                                GenSetup.Get;


                                TCharges := 0;
                                TransactionCharges.Reset;
                                TransactionCharges.SetRange(TransactionCharges."Transaction Type", StandingOrderHeader."Transaction Type");
                                if TransactionCharges.FindSet() then begin
                                    repeat

                                        if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) then begin

                                            ChargeAmount := 0;
                                            if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" then
                                                ChargeAmount := (StandingOrderHeader.Amount * TransactionCharges."Percentage of Amount") * 0.01
                                            else
                                                ChargeAmount := TransactionCharges."Charge Amount";

                                            if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                                                TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                                                TariffDetails.Reset;
                                                TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                                if TariffDetails.FindSet() then begin
                                                    repeat
                                                        if (StandingOrderHeader.Amount >= TariffDetails."Lower Limit") and
                                                            (StandingOrderHeader.Amount <= TariffDetails."Upper Limit") then begin
                                                            if TariffDetails."Use Percentage" then
                                                                ChargeAmount := StandingOrderHeader.Amount * TariffDetails.Percentage * 0.01
                                                            else
                                                                ChargeAmount := TariffDetails."Charge Amount";
                                                        end;
                                                    until TariffDetails.Next = 0;
                                                end;
                                            end;

                                            LineNo := LineNo + 10000;

                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                            GenJournalLine."Journal Batch Name" := Jbatch;
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Posting Date" := PDate;
                                            GenJournalLine."Document No." := DocNo;
                                            GenJournalLine."External Document No." := StandingOrderHeader."No.";
                                            GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
                                            GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
                                            GenJournalLine.Description := TransactionCharges.Description;
                                            GenJournalLine.Validate(GenJournalLine.Amount, ChargeAmount);
                                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.", TransactionCharges."G/L Account");
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;


                                            if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                                (TransactionCharges."Recover Excise Duty" = true) then begin
                                                //Excise
                                                LineNo := LineNo + 10000;
                                                GenJournalLine.Init;
                                                GenJournalLine."Journal Template Name" := Jtemplate;
                                                GenJournalLine."Journal Batch Name" := Jbatch;
                                                GenJournalLine."Line No." := LineNo;
                                                GenJournalLine."Posting Date" := PDate;
                                                GenJournalLine."Document No." := DocNo;
                                                GenJournalLine."External Document No." := StandingOrderHeader."No.";
                                                GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
                                                GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
                                                GenJournalLine.Description := 'Excise Duty';//TransactionCharges.Description;
                                                GenJournalLine.Validate(GenJournalLine.Amount, (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01);
                                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.", GenSetup."Excise Duty G/L");
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                if GenJournalLine.Amount <> 0 then
                                                    GenJournalLine.Insert;
                                                //Excise
                                            end;
                                            TChargeAmount += ChargeAmount;
                                        end;
                                    until TransactionCharges.Next = 0;
                                end;
                                TCharges := TChargeAmount;
                                //Charges
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := Jbatch;

                                GenJournalLine."Line No." := LineNo;

                                GenJournalLine."Posting Date" := PDate;
                                GenJournalLine."Document No." := DocNo;
                                GenJournalLine."External Document No." := STOHead."No.";
                                GenJournalLine."Account Type" := STOHead."Source Account Type";
                                GenJournalLine.Validate(GenJournalLine."Account No.", STOHead."Source Account No.");
                                //GenJournalLine.Description:='Source:-'+STOHead."Source Account Name";
                                GenJournalLine.Description := PadStr('STO:-' + Format(STOHead."No.") + '-' + Format(STOlinesname), 50);
                                GenJournalLine.Validate(GenJournalLine.Amount, AmountDedu);
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                            end;
                        end;

                        StandingOrdSRegister.Reset();
                        StandingOrdSRegister.SetRange("No.", StandingOrdSRegister."Standing Order No.");
                        StandingOrdSRegister.SetRange("Source Account No.", StandingOrdSRegister."Source Account No.");
                        StandingOrdSRegister.SetRange("Member No", StandingOrderHeader."Member No.");
                        StandingOrdSRegister.SetRange("Deduction Status", StandingOrdSRegister."Deduction Status"::Failed);
                        if StandingOrdSRegister.FindFirst() then begin
                            msg := 'Dear ' + StandingOrdSRegister."Source Account Name" + ', Your Standing Order towards loan repayment was unsuccessful.';
                            SendSMS.SendSms(Source::Tenants, Memb."Phone No.", msg, Format(Memb."No."), '', true, 0, false, 'CBS', Format(Memb."No."), 'CBS');
                        end;
                    end;//All Successful STOS Exempt

                until StandingOrderHeader.Next = 0;
            end;//*Header Info
        end;



        //PostLoansArreas(SalHeaD,DocNo,PDate,DActivity2,DBranch2,Jtemplate,Jbatch,RunBal,MemberNo,LineNo,Salaccno);

    end;

    local procedure PostNCBALoanSTO(DocNo: Code[20]; PDate: Date; DActivity2: Code[20]; DBranch2: Code[20]; Jtemplate: Code[20]; Jbatch: Code[20]; RunBal: Decimal; MemberNo: Code[20]; LineNo: Integer; Salaccno: Code[20]): Decimal
    var
        StandingOrderHeader: Record "Standing Order Header";
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        AvailableBal: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        BalAccountType: Enum "Gen. Journal Account Type";
        StandingOrdDeductStatus: Option " ",Successfull,"Partial Deduction",Failed;
        StandingOrdSRegister: Record "Standing Order Register";
        TCharges: Decimal;
        SalLines: Record "Salary Lines";
        STOHeaderNo: Code[20];
        StandingOrderLines: Record "Standing Order Lines";
        StandingOrderLinesII: Record "Standing Order Lines";
        LoanApps: Record Loans;
        STOHead: Record "Standing Order Header";
        STOlinesname: Text[80];
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        TChargeAmount: Decimal;
        TransTypes: Record "Transaction Types";
        SavingsACCS: Record "Savings Accounts";
        STR: Date;
        SkipSTO: Boolean;
        THESavings: Record "Savings Accounts";
        AmtDeducted: Decimal;
        TransactionTypes: record "Transaction Types";
        Txt004: label 'Dear Member your  standing order towards (loan) repayment was unsuccessful.';
        TotalDeduction: decimal;
        MaxSTO: Decimal;
    begin
        TotalDeduction := 0;
        //RemainingBal := RunBal;
        GenSetup.Get;
        StandingOrderHeader.Reset;
        StandingOrderHeader.SetCurrentkey(StandingOrderHeader."No.");
        StandingOrderHeader.SetRange(StandingOrderHeader."Member No.", MemberNo);
        StandingOrderHeader.SetRange(StandingOrderHeader.Status, StandingOrderHeader.Status::Approved);
        StandingOrderHeader.setrange(StandingOrderHeader."Source Account No.", Salaccno);
        StandingOrderHeader.SetFilter(StandingOrderHeader."Income Type", '%1|%2|%3|%4', StandingOrderHeader."income type"::Salary,
                                          StandingOrderHeader."income type"::Pension, StandingOrderHeader."income type"::"Direct Debit", StandingOrderHeader."income type"::SAYE);
        if StandingOrderHeader.findset() then begin

            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            if GenJournalLine.findlast then begin
                LineNo := GenJournalLine."Line No.";
            end;
            repeat
                AmtDeducted := 0;
                SkipSTO := false;
                if SkipSTO = false then begin
                    STOHeaderNo := '';
                    STOHeaderNo := StandingOrderHeader."No.";

                    if RunBal > StandingOrderHeader.Amount then begin
                        StandingOrdDeductStatus := Standingorddeductstatus::Successfull;
                    end else begin
                        StandingOrdDeductStatus := Standingorddeductstatus::"Partial Deduction";
                    end;
                    if RunBal < 0 then
                        RunBal := 0;

                    StandingOrderLines.Reset;
                    StandingOrderLines.SetRange(StandingOrderLines."Document No.", StandingOrderHeader."No.");
                    StandingOrderLines.SetRange(StandingOrderLines."destination account type", StandingOrderLines."destination account type"::Credit);
                    if StandingOrderLines.FindSet() then begin
                        repeat
                            MaxSTO := StandingOrderLines.Amount;
                            if RunBal > 0 then begin
                                if RunBal <= StandingOrderLines.Amount then begin
                                    LoanApps.Reset;
                                    LoanApps.SetRange(LoanApps."Loan No.", StandingOrderLines."Loan No.");
                                    if LoanApps.Find('-') then begin
                                        LoanApps.CalcFields(LoanApps."Outstanding Interest", LoanApps."Total Balance", LoanApps."Outstanding Balance");
                                        if LoanApps."Total Balance" > 0 then begin
                                            if (LoanApps."Outstanding Interest") > 0 then begin
                                                LineNo := LineNo + 10000;
                                                GenJournalLine.Init;
                                                GenJournalLine."Journal Template Name" := Jtemplate;
                                                GenJournalLine."Journal Batch Name" := Jbatch;
                                                GenJournalLine."Line No." := LineNo;
                                                GenJournalLine."Posting Date" := PDate;
                                                GenJournalLine."Document No." := DocNo;
                                                GenJournalLine."External Document No." := STOHead."No.";
                                                GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                                GenJournalLine.Description := PadStr(StandingOrderLines."Document No." + ' Destination:-' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                                             Format(GenJournalLine."transaction type"::"Interest Paid"), 50);


                                                if LoanApps."Outstanding Interest" >= RunBal then begin
                                                    GenJournalLine.Amount := RunBal * -1;
                                                    AmtDeducted += RunBal;
                                                    RunBal := 0;
                                                end
                                                else begin
                                                    GenJournalLine.Amount := LoanApps."Outstanding Interest" * -1;
                                                    RunBal -= Abs(LoanApps."Outstanding Interest");
                                                    AmtDeducted += Abs(LoanApps."Outstanding Interest");
                                                end;
                                                GenJournalLine.validate(Amount);
                                                GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                if GenJournalLine.Amount <> 0 then
                                                    GenJournalLine.Insert;


                                            end;
                                            if LoanApps."Interest Calculation Method" = LoanApps."Interest Calculation Method"::"Reducing Balance" then
                                                if LoanApps."Outstanding Balance" > LoanApps."Loan Principle Repayment" then
                                                    LoanApps."Outstanding Balance" := LoanApps."Loan Principle Repayment";


                                            if (LoanApps."Outstanding Balance" > 0) then begin
                                                if RunBal > 0 then begin
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Posting Date" := PDate;
                                                    GenJournalLine."Document No." := DocNo;
                                                    GenJournalLine."External Document No." := STOHead."No.";
                                                    GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                    GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                                    GenJournalLine.Description := PadStr(StandingOrderLines."Document No." + ' Destination:-' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                                                 Format(GenJournalLine."transaction type"::Repayment), 50);

                                                    if LoanApps."Outstanding Balance" >= RunBal then begin
                                                        GenJournalLine.Amount := RunBal * -1;
                                                        AmtDeducted += RunBal;
                                                        RunBal := 0;
                                                    end
                                                    else begin
                                                        GenJournalLine.Amount := LoanApps."Outstanding Balance" * -1;
                                                        RunBal -= Abs(LoanApps."Outstanding Balance");
                                                        AmtDeducted += Abs(LoanApps."Outstanding Balance");
                                                    end;
                                                    GenJournalLine.validate(Amount);
                                                    GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;
                                                end;
                                            end;
                                        end;
                                    end;
                                end
                                else begin
                                    LoanApps.Reset;
                                    LoanApps.SetRange(LoanApps."Loan No.", StandingOrderLines."Loan No.");
                                    if LoanApps.Find('-') then begin
                                        LoanApps.CalcFields(LoanApps."Outstanding Interest", LoanApps."Total Balance", LoanApps."Outstanding Balance");
                                        if LoanApps."Total Balance" > 0 then begin
                                            if (LoanApps."Outstanding Interest") > 0 then begin
                                                LineNo := LineNo + 10000;
                                                GenJournalLine.Init;
                                                GenJournalLine."Journal Template Name" := Jtemplate;
                                                GenJournalLine."Journal Batch Name" := Jbatch;
                                                GenJournalLine."Line No." := LineNo;
                                                GenJournalLine."Posting Date" := PDate;
                                                GenJournalLine."Document No." := DocNo;
                                                GenJournalLine."External Document No." := STOHead."No.";
                                                GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                                GenJournalLine.Description := PadStr(StandingOrderLines."Document No." + ' Destination:-' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                                             Format(GenJournalLine."transaction type"::"Interest Paid"), 50);

                                                if LoanApps."Outstanding Interest" >= MaxSTO then begin
                                                    GenJournalLine.Amount := MaxSTO * -1;
                                                    AmtDeducted += MaxSTO;
                                                    RunBal -= MaxSTO;
                                                    MaxSTO := 0;
                                                end
                                                else begin
                                                    GenJournalLine.Amount := LoanApps."Outstanding Interest" * -1;
                                                    RunBal -= Abs(LoanApps."Outstanding Interest");
                                                    AmtDeducted += Abs(LoanApps."Outstanding Interest");
                                                    MaxSTO -= Abs(LoanApps."Outstanding Interest");
                                                end;
                                                GenJournalLine.Validate(Amount);
                                                GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                if GenJournalLine.Amount <> 0 then
                                                    GenJournalLine.Insert;


                                            end;
                                            if LoanApps."Interest Calculation Method" = LoanApps."Interest Calculation Method"::"Reducing Balance" then
                                                if LoanApps."Outstanding Balance" > LoanApps."Loan Principle Repayment" then
                                                    LoanApps."Outstanding Balance" := LoanApps."Loan Principle Repayment";


                                            if (LoanApps."Outstanding Balance" > 0) then begin
                                                if RunBal > 0 then begin
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Posting Date" := PDate;
                                                    GenJournalLine."Document No." := DocNo;
                                                    GenJournalLine."External Document No." := STOHead."No.";
                                                    GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                                    GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                                    GenJournalLine.Description := PadStr(StandingOrderLines."Document No." + ' Destination:-' + LoanApps."Loan No." + '-' + StandingOrderHeader."Source Account No." + '-' +
                                                                                 Format(GenJournalLine."transaction type"::Repayment), 50);

                                                    // if LoanApps."Outstanding Balance" >= RunBal then begin
                                                    //     GenJournalLine.Amount := RunBal * -1;
                                                    //     AmtDeducted += RunBal;
                                                    //     RunBal := 0;
                                                    // end
                                                    // else begin
                                                    //     GenJournalLine.Amount := LoanApps."Outstanding Balance" * -1;
                                                    //     RunBal -= Abs(LoanApps."Outstanding Balance");
                                                    //     AmtDeducted += Abs(LoanApps."Outstanding Balance");
                                                    // end;
                                                    if LoanApps."Outstanding Balance" >= MaxSTO then begin
                                                        GenJournalLine.Amount := MaxSTO * -1;
                                                        AmtDeducted += MaxSTO;
                                                        RunBal -= MaxSTO;
                                                        MaxSTO := 0;
                                                    end
                                                    else begin
                                                        GenJournalLine.Amount := LoanApps."Outstanding Balance" * -1;
                                                        RunBal -= Abs(LoanApps."Outstanding Balance");
                                                        AmtDeducted += Abs(LoanApps."Outstanding Balance");
                                                        MaxSTO -= Abs(LoanApps."Outstanding Balance");
                                                    end;
                                                    GenJournalLine.Validate(Amount);
                                                    GenJournalLine.Validate(GenJournalLine."Loan No", StandingOrderLines."Loan No.");
                                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        until StandingOrderLines.Next = 0;
                    end;

                    if STOHead.Get(STOHeaderNo) then begin
                        //Charges
                        STOlinesname := StandingOrderLines."Destination Account Name";
                        GenSetup.Get;
                        TCharges := 0;
                        TransactionCharges.Reset;
                        TransactionCharges.SetRange(TransactionCharges."Transaction Type", StandingOrderHeader."Transaction Type");
                        if TransactionCharges.FindSet() then begin
                            repeat
                                if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) then begin

                                    ChargeAmount := 0;
                                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" then
                                        ChargeAmount := (StandingOrderHeader.Amount * TransactionCharges."Percentage of Amount") * 0.01
                                    else
                                        ChargeAmount := TransactionCharges."Charge Amount";

                                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                                        TariffDetails.Reset;
                                        TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                        if TariffDetails.FindSet() then begin
                                            repeat
                                                if (StandingOrderHeader.Amount >= TariffDetails."Lower Limit") and
                                                    (StandingOrderHeader.Amount <= TariffDetails."Upper Limit") then begin
                                                    if TariffDetails."Use Percentage" then
                                                        ChargeAmount := StandingOrderHeader.Amount * TariffDetails.Percentage * 0.01
                                                    else
                                                        ChargeAmount := TariffDetails."Charge Amount";
                                                end;
                                            until TariffDetails.Next = 0;
                                        end;
                                    end;

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Posting Date" := PDate;
                                    GenJournalLine."Document No." := DocNo;
                                    GenJournalLine."External Document No." := StandingOrderHeader."No.";
                                    GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
                                    GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
                                    GenJournalLine.Description := TransactionCharges.Description;
                                    GenJournalLine.Validate(GenJournalLine.Amount, ChargeAmount);
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.", TransactionCharges."G/L Account");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;


                                    if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                        (TransactionCharges."Recover Excise Duty" = true) then begin
                                        //Excise
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Journal Batch Name" := Jbatch;
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Posting Date" := PDate;
                                        GenJournalLine."Document No." := DocNo;
                                        GenJournalLine."External Document No." := StandingOrderHeader."No.";
                                        GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
                                        GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
                                        GenJournalLine.Description := StandingOrderLines."Document No." + ' Excise Duty';//TransactionCharges.Description;
                                        GenJournalLine.Validate(GenJournalLine.Amount, (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01);
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.", GenSetup."Excise Duty G/L");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                        //Excise
                                    end;
                                    TChargeAmount += ChargeAmount;
                                end;
                            until TransactionCharges.Next = 0;
                        end;
                        TCharges := TChargeAmount;
                        //Charges
                        LineNo := LineNo + 10000;
                        AmtDeducted += TCharges;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := Jtemplate;
                        GenJournalLine."Journal Batch Name" := Jbatch;

                        GenJournalLine."Line No." := LineNo;

                        GenJournalLine."Posting Date" := PDate;
                        GenJournalLine."Document No." := DocNo;
                        GenJournalLine."External Document No." := STOHead."No.";
                        GenJournalLine."Account Type" := STOHead."Source Account Type";
                        GenJournalLine.Validate(GenJournalLine."Account No.", STOHead."Source Account No.");
                        //GenJournalLine.Description:='Source:-'+STOHead."Source Account Name";
                        GenJournalLine.Description := PadStr('STO:-' + Format(STOHead."No.") + '-' + Format(STOlinesname), 50);
                        GenJournalLine.Validate(GenJournalLine.Amount, AmtDeducted);
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    end;
                    UpdateStandingOrderRegister('', Today, StandingOrderHeader."No.", '', StandingOrderHeader."Source Account No.", StandingOrderHeader."Source Account Name",
                                               StandingOrderHeader."Member No.", StandingOrderHeader."Payroll/Staff No.", StandingOrderHeader."Allow Partial Deduction",
                                               StandingOrdDeductStatus, StandingOrderHeader.Amount, AmtDeducted, StandingOrderHeader."Effective/Start Date", StandingOrderHeader."Duration (Months)",
                                               StandingOrderHeader."Frequency (Months)", StandingOrderHeader."End Date", StandingOrderHeader.Description, StandingOrderHeader."Transfered to EFT", false, StandingOrderHeader."No.");

                end;
                TotalDeduction += AmtDeducted;

            until StandingOrderHeader.Next = 0;
        end;
        exit(TotalDeduction);
    end;

    local procedure PostNCBASavingSTO(DocNo: Code[20]; PDate: Date; DActivity2: Code[20]; DBranch2: Code[20]; Jtemplate: Code[20]; Jbatch: Code[20]; RunBal: Decimal; MemberNo: Code[20]; LineNo: Integer; Salaccno: Code[20])
    var
        StandingOrderHeader: Record "Standing Order Header";
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        AvailableBal: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        BalAccountType: Enum "Gen. Journal Account Type";
        StandingOrdDeductStatus: Option " ",Successfull,"Partial Deduction",Failed;
        StandingOrdSRegister: Record "Standing Order Register";
        TCharges: Decimal;
        SalLines: Record "Salary Lines";
        STOHeaderNo: Code[20];
        StandingOrderLines: Record "Standing Order Lines";
        StandingOrderLinesII: Record "Standing Order Lines";
        STOHead: Record "Standing Order Header";
        STOlinesname: Text[80];
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        TChargeAmount: Decimal;
        TransTypes: Record "Transaction Types";
        SavingsACCS: Record "Savings Accounts";
        STR: Date;
        SkipSTO: Boolean;
        THESavings: Record "Savings Accounts";
        AmtDeducted: Decimal;
        TransactionTypes: record "Transaction Types";
        Txt004: label 'Dear Member your  standing order towards (loan) repayment was unsuccessful.';
        RemainingBal: decimal;
        MaxSTO: Decimal;
    begin
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        if GenJournalLine.findlast then begin
            LineNo := GenJournalLine."Line No.";
        end;
        AmtDeducted := 0;
        RemainingBal := RunBal;
        GenSetup.Get;
        StandingOrderHeader.Reset;
        StandingOrderHeader.SetCurrentkey(StandingOrderHeader."No.");
        StandingOrderHeader.SetRange(StandingOrderHeader."Member No.", MemberNo);
        StandingOrderHeader.SetRange(StandingOrderHeader.Status, StandingOrderHeader.Status::Approved);
        StandingOrderHeader.setrange(StandingOrderHeader."Source Account No.", Salaccno);
        StandingOrderHeader.SetFilter(StandingOrderHeader."Income Type", '%1|%2|%3|%4', StandingOrderHeader."income type"::Salary,
                                          StandingOrderHeader."income type"::Pension, StandingOrderHeader."income type"::"Direct Debit", StandingOrderHeader."income type"::SAYE);
        if StandingOrderHeader.findset() then begin
            repeat
                AmtDeducted := 0;
                SkipSTO := false;
                if SkipSTO = false then begin
                    STOHeaderNo := '';
                    STOHeaderNo := StandingOrderHeader."No.";

                    if RunBal > StandingOrderHeader.Amount then begin
                        StandingOrdDeductStatus := Standingorddeductstatus::Successfull;
                    end else begin
                        StandingOrdDeductStatus := Standingorddeductstatus::"Partial Deduction";
                    end;
                    if RunBal < 0 then
                        RunBal := 0;

                    StandingOrderLines.Reset;
                    StandingOrderLines.SetRange(StandingOrderLines."Document No.", StandingOrderHeader."No.");
                    StandingOrderLines.Setfilter(StandingOrderLines."destination account type", '%1|%2', StandingOrderLines."destination account type"::Savings, StandingOrderLines."destination account type"::"G/L Account");
                    if StandingOrderLines.FindSet() then begin
                        repeat
                            MaxSTO := StandingOrderLines.Amount;
                            if RunBal > 0 then begin
                                if RunBal <= StandingOrderLines.Amount then begin
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Posting Date" := PDate;
                                    GenJournalLine."Document No." := DocNo;
                                    GenJournalLine."External Document No." := STOHead."No.";
                                    GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                    GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                    GenJournalLine.Description := PadStr(StandingOrderLines."Document No." + ' Destination:-' + '-' + StandingOrderHeader."Source Account No."
                                                                 , 50);

                                    if StandingOrderLines.Amount >= RunBal then begin
                                        GenJournalLine.Amount := RunBal * -1;
                                        AmtDeducted += RunBal;
                                        RunBal := 0;
                                    end
                                    else begin
                                        GenJournalLine.Amount := StandingOrderLines.Amount * -1;
                                        RunBal -= Abs(StandingOrderLines.Amount);
                                        AmtDeducted += Abs(StandingOrderLines.Amount);
                                    end;
                                    GenJournalLine.Validate(Amount);

                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end
                                else begin
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Posting Date" := PDate;
                                    GenJournalLine."Document No." := DocNo;
                                    GenJournalLine."External Document No." := STOHead."No.";
                                    GenJournalLine."Account Type" := StandingOrderLines."Destination Account Type";
                                    GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderLines."Destination Account No.");
                                    GenJournalLine.Description := PadStr(StandingOrderLines."Document No." + ' Destination:-' + '-' + StandingOrderHeader."Source Account No."
                                                                 , 50);

                                    if StandingOrderLines.Amount >= MaxSTO then begin
                                        GenJournalLine.Amount := MaxSTO * -1;
                                        AmtDeducted += MaxSTO;
                                        RunBal -= MaxSTO;
                                        MaxSTO := 0;
                                    end
                                    else begin
                                        GenJournalLine.Amount := StandingOrderLines.Amount * -1;
                                        RunBal -= Abs(StandingOrderLines.Amount);
                                        AmtDeducted += Abs(StandingOrderLines.Amount);
                                        MaxSTO -= Abs(StandingOrderLines.Amount);
                                    end;

                                    // if StandingOrderLines.Amount >= RunBal then begin
                                    //     GenJournalLine.Amount := RunBal * -1;
                                    //     AmtDeducted += RunBal;
                                    //     RunBal := 0;
                                    // end
                                    // else begin
                                    //     GenJournalLine.Amount := StandingOrderLines.Amount * -1;
                                    //     RunBal -= Abs(StandingOrderLines.Amount);
                                    //     AmtDeducted += Abs(StandingOrderLines.Amount);
                                    // end;
                                    GenJournalLine.Validate(Amount);

                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;

                            end;

                        until StandingOrderLines.Next = 0;

                        if STOHead.Get(STOHeaderNo) then begin
                            //Charges
                            STOlinesname := StandingOrderLines."Destination Account Name";
                            GenSetup.Get;
                            TCharges := 0;
                            TransactionCharges.Reset;
                            TransactionCharges.SetRange(TransactionCharges."Transaction Type", StandingOrderHeader."Transaction Type");
                            if TransactionCharges.FindSet() then begin
                                repeat
                                    if (TransactionCharges."Transaction Charge Category" = TransactionCharges."transaction charge category"::Normal) then begin

                                        ChargeAmount := 0;
                                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" then
                                            ChargeAmount := (StandingOrderHeader.Amount * TransactionCharges."Percentage of Amount") * 0.01
                                        else
                                            ChargeAmount := TransactionCharges."Charge Amount";

                                        if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                                            TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                                            TariffDetails.Reset;
                                            TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                            if TariffDetails.FindSet() then begin
                                                repeat
                                                    if (StandingOrderHeader.Amount >= TariffDetails."Lower Limit") and
                                                        (StandingOrderHeader.Amount <= TariffDetails."Upper Limit") then begin
                                                        if TariffDetails."Use Percentage" then
                                                            ChargeAmount := StandingOrderHeader.Amount * TariffDetails.Percentage * 0.01
                                                        else
                                                            ChargeAmount := TariffDetails."Charge Amount";
                                                    end;
                                                until TariffDetails.Next = 0;
                                            end;
                                        end;

                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Journal Batch Name" := Jbatch;
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Posting Date" := PDate;
                                        GenJournalLine."Document No." := DocNo;
                                        GenJournalLine."External Document No." := StandingOrderHeader."No.";
                                        GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
                                        GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
                                        GenJournalLine.Description := StandingOrderLines."Document No." + ' ' + TransactionCharges.Description;
                                        GenJournalLine.Validate(GenJournalLine.Amount, ChargeAmount);
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.", TransactionCharges."G/L Account");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;


                                        if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                            (TransactionCharges."Recover Excise Duty" = true) then begin
                                            //Excise
                                            LineNo := LineNo + 10000;
                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                            GenJournalLine."Journal Batch Name" := Jbatch;
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Posting Date" := PDate;
                                            GenJournalLine."Document No." := DocNo;
                                            GenJournalLine."External Document No." := StandingOrderHeader."No.";
                                            GenJournalLine."Account Type" := StandingOrderHeader."Source Account Type";
                                            GenJournalLine.Validate(GenJournalLine."Account No.", StandingOrderHeader."Source Account No.");
                                            GenJournalLine.Description := StandingOrderLines."Document No." + ' Excise Duty';//TransactionCharges.Description;
                                            GenJournalLine.Validate(GenJournalLine.Amount, (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01);
                                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.", GenSetup."Excise Duty G/L");
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;
                                            //Excise
                                        end;
                                        TChargeAmount += ChargeAmount;
                                    end;
                                until TransactionCharges.Next = 0;
                            end;
                        end;


                        TCharges := TChargeAmount;
                        //Charges
                        LineNo := LineNo + 10000;
                        AmtDeducted += TCharges;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := Jtemplate;
                        GenJournalLine."Journal Batch Name" := Jbatch;

                        GenJournalLine."Line No." := LineNo;

                        GenJournalLine."Posting Date" := PDate;
                        GenJournalLine."Document No." := DocNo;
                        GenJournalLine."External Document No." := STOHead."No.";
                        GenJournalLine."Account Type" := STOHead."Source Account Type";
                        GenJournalLine.Validate(GenJournalLine."Account No.", STOHead."Source Account No.");
                        //GenJournalLine.Description:='Source:-'+STOHead."Source Account Name";
                        GenJournalLine.Description := PadStr('STO:-' + Format(STOHead."No.") + '-' + Format(STOlinesname), 50);
                        GenJournalLine.Validate(GenJournalLine.Amount, AmtDeducted);
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    end;
                    UpdateStandingOrderRegister('', Today, StandingOrderHeader."No.", '', StandingOrderHeader."Source Account No.", StandingOrderHeader."Source Account Name",
                                               StandingOrderHeader."Member No.", StandingOrderHeader."Payroll/Staff No.", StandingOrderHeader."Allow Partial Deduction",
                                               StandingOrdDeductStatus, StandingOrderHeader.Amount, AmtDeducted, StandingOrderHeader."Effective/Start Date", StandingOrderHeader."Duration (Months)",
                                               StandingOrderHeader."Frequency (Months)", StandingOrderHeader."End Date", StandingOrderHeader.Description, StandingOrderHeader."Transfered to EFT", false, StandingOrderHeader."No.");

                end;
                RemainingBal -= AmtDeducted;

            until StandingOrderHeader.Next = 0;
        end;
    end;

    local procedure PostLoansArreas(SalHeaD: Record "Salary Header"; DocNo: Code[20]; PDate: Date; DActivity2: Code[20]; DBranch2: Code[20]; Jtemplate: Code[20]; Jbatch: Code[20]; RunBal: Decimal; MemberNo: Code[20]; LineNo: Integer; Salaccno: Code[20])
    var
        Loans: Record Loans;
        Interest: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        LRepayment: Decimal;
        SalLines: Record "Salary Lines";
    begin
        //with SalHeaD do 
        begin

            Loans.Reset;
            Loans.SetRange(Loans."Member No.", MemberNo);
            //Loans.SETRANGE(Loans."Recovery Mode",Loans."Recovery Mode"::Salary);
            Loans.SetAutoCalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest", Loans."Outstanding Bills");
            if Loans.FindSet() then begin
                repeat
                    if RunBal > 0 then begin
                        // Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest", Loans."Outstanding Bills");
                        if Loans."Outstanding Interest" > 0 then begin
                            Interest := 0;
                            Interest := Loans."Outstanding Interest";

                            if Interest > 0 then begin
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := Jbatch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Credit;
                                GenJournalLine."Account No." := Loans."Loan Account";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := CopyStr(DocNo, 1, 14);
                                GenJournalLine."Posting Date" := PDate;
                                GenJournalLine.Description := 'Interest Paid';
                                if RunBal > Interest then
                                    GenJournalLine.Amount := Interest * -1
                                else
                                    GenJournalLine.Amount := RunBal * -1;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                GenJournalLine."Loan No" := Loans."Loan No.";
                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := Jbatch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                GenJournalLine."Account No." := Salaccno;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := CopyStr(DocNo, 1, 14);
                                GenJournalLine."Posting Date" := PDate;
                                GenJournalLine.Description := 'Interest Paid - ' + Loans."Loan Product Type";
                                if RunBal > Interest then
                                    GenJournalLine.Amount := Interest
                                else
                                    GenJournalLine.Amount := RunBal;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Loan No" := Loans."Loan No.";
                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                RunBal := RunBal - GenJournalLine.Amount;
                            end;
                        end;
                    end;

                    if RunBal > 0 then begin
                        if Loans."Outstanding Balance" > 0 then begin
                            LRepayment := 0;
                            LRepayment := Loans."Outstanding Bills";

                            if LRepayment > 0 then begin
                                if LRepayment > Loans."Outstanding Balance" then
                                    LRepayment := Loans."Outstanding Balance";

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := Jbatch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Credit;
                                GenJournalLine."Account No." := Loans."Loan Account";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := CopyStr(DocNo, 1, 14);
                                GenJournalLine."Posting Date" := PDate;
                                GenJournalLine.Description := 'Loan Repayment';
                                if RunBal > LRepayment then
                                    GenJournalLine.Amount := LRepayment * -1
                                else
                                    GenJournalLine.Amount := RunBal * -1;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                                GenJournalLine."Loan No" := Loans."Loan No.";
                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := Jbatch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                GenJournalLine."Account No." := Salaccno;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := CopyStr(DocNo, 1, 14);
                                GenJournalLine."Posting Date" := PDate;
                                GenJournalLine.Description := 'Loan Repayment - ' + Loans."Loan Product Type";
                                if RunBal > LRepayment then
                                    GenJournalLine.Amount := LRepayment
                                else
                                    GenJournalLine.Amount := RunBal;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Loan No" := Loans."Loan No.";
                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity2;
                                GenJournalLine."Shortcut Dimension 2 Code" := DBranch2;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                RunBal := RunBal - GenJournalLine.Amount;
                            end;
                        end;
                    end;

                until Loans.Next = 0;
            end;
        end;
    end;


    procedure UpdateStandingOrderRegister(RNo: Code[10]; RDateProcessed: Date; RDocNo: Code[10]; RNoSeries: Code[10]; RSourceAccountNo: Code[20]; RSourceAccountName: Text; RMemberNo: Code[20]; RStaffNo: Code[11]; RPartialDeduction: Boolean; RDeductionStatus: Option " ",Successfull,"Partial Deduction",Failed; RDeductionAmount: Decimal; RAmountDeducted: Decimal; RStartDate: Date; RDuration: DateFormula; RFrequency: DateFormula; REndDate: Date; Rremarks: Code[50]; Reft: Boolean; RTransferEft: Boolean; STONo: Code[20])
    var
        LineNo: Code[10];
        StandingOrdSRegister: Record "Standing Order Register";
    begin
        //*
        StandingOrdSRegister.Init;
        StandingOrdSRegister."No." := RNo;
        StandingOrdSRegister."Date Processed" := RDateProcessed;
        StandingOrdSRegister."Document No." := RDocNo;
        StandingOrdSRegister."No. Series" := RNoSeries;
        StandingOrdSRegister."Source Account No." := RSourceAccountNo;
        StandingOrdSRegister."Source Account Name" := RSourceAccountName;
        StandingOrdSRegister."Member No" := RMemberNo;
        StandingOrdSRegister."Staff/Payroll No." := RStaffNo;
        StandingOrdSRegister."Allow Partial Deduction" := RPartialDeduction;
        StandingOrdSRegister."Deduction Status" := RDeductionStatus;
        StandingOrdSRegister.Amount := RDeductionAmount;
        StandingOrdSRegister."Amount Deducted" := RAmountDeducted;
        StandingOrdSRegister."Effective/Start Date" := RStartDate;
        StandingOrdSRegister.Duration := RDuration;
        StandingOrdSRegister.Frequency := RFrequency;
        StandingOrdSRegister."End Date" := REndDate;
        StandingOrdSRegister.Remarks := Rremarks;
        StandingOrdSRegister.EFT := Reft;
        StandingOrdSRegister."Transfered to EFT" := RTransferEft;
        StandingOrdSRegister."Standing Order No." := STONo;
        //StandingOrdSRegister."Destination Account Type":=Destinacctype;
        StandingOrdSRegister.Insert(true);
    end;

    local procedure ActivateDormant(SalHeaD: Record "Salary Header"; DocNo: Code[20]; PDate: Date; DActivity2: Code[20]; DBranch2: Code[20]; Jtemplate: Code[20]; Jbatch: Code[20]; RunBal: Decimal; MemberNo: Code[20]; LineNo: Integer; Salaccno: Code[20])
    var
        SavAcc: Record "Savings Accounts";
        TransactionCharges: Record "Transaction Charges";
        TransactionTypes: Record "Transaction Types";
        AccType: Enum "Gen. Journal Account Type";
        AccNo: Code[20];
        TransType: Enum "Transaction Types";
        BalAccType: Enum "Gen. Journal Account Type";
        BalAccNo: Code[20];
        Amt: Decimal;
        JournalPosting: Codeunit "Journal Posting";
    begin
        //Auto Activate Dormant On Loan Posting
        GenSetup.Get;
        //with SalHeaD do
        begin
            SavAcc.Reset;
            SavAcc.SetRange("No.", Salaccno);
            SavAcc.SetRange(Status, SavAcc.Status::Dormant);
            if SavAcc.Find('-') then begin
                TransactionTypes.Reset;
                TransactionTypes.SetRange(Code, GenSetup."Dormant Account Activation Fee");
                if TransactionTypes.Find('-') then begin
                    TransactionCharges.Reset;
                    TransactionCharges.SetRange("Transaction Type", TransactionTypes.Code);
                    if TransactionCharges.FindSet() then begin
                        repeat
                            TransactionCharges.TestField(TransactionCharges."G/L Account");
                            if SavAcc.Blocked = SavAcc.Blocked::" " then begin
                                SavAcc.Blocked := SavAcc.Blocked::" ";
                                SavAcc.Status := SavAcc.Status::Active;
                                SavAcc."Status Change Reason" := 'Auto Activated on Salary Posting';
                                SavAcc.Modify;
                            end;
                            LineNo := LineNo + 10000;
                            AccType := Acctype::"G/L Account";
                            AccNo := TransactionCharges."G/L Account";
                            TransType := Transtype::" ";
                            BalAccType := Balacctype::Savings;
                            BalAccNo := SavAcc."No.";

                            Amt := TransactionCharges."Charge Amount";
                            Amt := Amt * -1;
                            JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, TransactionCharges.Description + SavAcc."No.", Amt, AccNo, PDate, BalAccType,
                          BalAccNo, '', DActivity2, DBranch2, TransType, SalHeaD."Document No", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                            if TransactionCharges."Recover Excise Duty" = true then begin
                                GenSetup.TestField("Excise Duty G/L");
                                GenSetup.TestField("Excise Duty (%)");
                                LineNo := LineNo + 10000;
                                AccType := Acctype::"G/L Account";
                                AccNo := GenSetup."Excise Duty G/L";
                                TransType := Transtype::" ";
                                BalAccType := Balacctype::Savings;
                                BalAccNo := SavAcc."No.";
                                Amt := Amt * GenSetup."Excise Duty (%)" * 0.01;
                                JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, CopyStr((TransactionCharges.Description + SavAcc."No." + '-Excise Duty'), 1, 50), Amt, AccNo, PDate, BalAccType,
                                BalAccNo, '', DActivity2, DBranch2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            end;
                        until TransactionCharges.Next = 0;
                    end;
                end;
            end;
        end;
        //block account if
    end;

    local procedure ActivateDormantNCBA(SalaryHeaderNo: Text; DocNo: Code[20]; PDate: Date; DActivity2: Code[20]; DBranch2: Code[20]; Jtemplate: Code[20]; Jbatch: Code[20]; RunBal: Decimal; MemberNo: Code[20]; LineNo: Integer; Salaccno: Code[20])
    var
        SavAcc: Record "Savings Accounts";
        TransactionCharges: Record "Transaction Charges";
        TransactionTypes: Record "Transaction Types";
        AccType: Enum "Gen. Journal Account Type";
        AccNo: Code[20];
        TransType: Enum "Transaction Types";
        BalAccType: Enum "Gen. Journal Account Type";
        BalAccNo: Code[20];
        Amt: Decimal;
        JournalPosting: Codeunit "Journal Posting";
    begin
        //Auto Activate Dormant On Loan Posting
        GenSetup.Get;
        //with SalHeaD do
        begin
            SavAcc.Reset;
            SavAcc.SetRange("No.", Salaccno);
            SavAcc.SetRange(Status, SavAcc.Status::Dormant);
            if SavAcc.Find('-') then begin
                TransactionTypes.Reset;
                TransactionTypes.SetRange(Code, GenSetup."Dormant Account Activation Fee");
                if TransactionTypes.Find('-') then begin
                    TransactionCharges.Reset;
                    TransactionCharges.SetRange("Transaction Type", TransactionTypes.Code);
                    if TransactionCharges.FindSet() then begin
                        repeat
                            TransactionCharges.TestField(TransactionCharges."G/L Account");
                            if SavAcc.Blocked = SavAcc.Blocked::" " then begin
                                SavAcc.Blocked := SavAcc.Blocked::" ";
                                SavAcc.Status := SavAcc.Status::Active;
                                SavAcc."Status Change Reason" := 'Auto Activated on Salary Posting';
                                SavAcc.Modify;
                            end;
                            LineNo := LineNo + 10000;
                            AccType := Acctype::"G/L Account";
                            AccNo := TransactionCharges."G/L Account";
                            TransType := Transtype::" ";
                            BalAccType := Balacctype::Savings;
                            BalAccNo := SavAcc."No.";

                            Amt := TransactionCharges."Charge Amount";
                            Amt := Amt * -1;
                            JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, TransactionCharges.Description + SavAcc."No.", Amt, AccNo, PDate, BalAccType,
                          BalAccNo, '', DActivity2, DBranch2, TransType, SalaryHeaderNo, '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                            if TransactionCharges."Recover Excise Duty" = true then begin
                                GenSetup.TestField("Excise Duty G/L");
                                GenSetup.TestField("Excise Duty (%)");
                                LineNo := LineNo + 10000;
                                AccType := Acctype::"G/L Account";
                                AccNo := GenSetup."Excise Duty G/L";
                                TransType := Transtype::" ";
                                BalAccType := Balacctype::Savings;
                                BalAccNo := SavAcc."No.";
                                Amt := Amt * GenSetup."Excise Duty (%)" * 0.01;
                                JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, CopyStr((TransactionCharges.Description + SavAcc."No." + '-Excise Duty'), 1, 50), Amt, AccNo, PDate, BalAccType,
                                BalAccNo, '', DActivity2, DBranch2, TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                            end;
                        until TransactionCharges.Next = 0;
                    end;
                end;
            end;
        end;
        //block account if
    end;


    local procedure "**********Over Draft Processing*******"()
    begin
    end;


    procedure PostOverDraft(Overdraft: Record "Over Draft Authorisation")
    var
        Text0001: label 'Ensure the Overdraft Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Overdraft Journal Batch is set up in Banking User Setup';
        Text0003: label 'Ensure the Default Bank is set up in User Setup';
        Text0004: label 'The transaction has already been posted.';
        TCharges: Integer;
        TransactionCharges: Record "Transaction Charges";
        LineNo: Integer;
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        GenJournalLine: Record "Gen. Journal Line";
        TChargeAmount: Decimal;
        GenSetup: Record "General Set-Up";
    begin

        // with Overdraft do
        begin

            //Cyrus
            if Posted = true then
                Error(Text0004);

            Temp.Get(UserId);
            GenSetup.Get;

            Jtemplate := Temp."Over Draft Template";
            JBatch := Temp."Over Draft Batch";


            if Jtemplate = '' then begin
                Error(Text0001);
            end;

            if JBatch = '' then begin
                Error(Text0002);
            end;


            if Overdraft.Status <> Overdraft.Status::Approved then
                Error('You cannot post an application being processed.');

            Overdraft.TestField("Account No.");
            Overdraft.TestField("Effective/Start Date");
            Overdraft.TestField(Duration);
            Overdraft.TestField("Expiry Date");
            Overdraft.TestField("Requested Amount");
            Overdraft.TestField("Approved Amount");
            //TESTFIELD("Overdraft Interest %");


            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            GenJournalLine.DeleteAll;

            if Confirm('Are you sure you want to charge overdraft issue fee.', false) = false then
                exit;

            //Charges
            TCharges := 0;

            TransactionCharges.Reset;
            TransactionCharges.SetRange(TransactionCharges."Transaction Type", Overdraft."Transaction Type");
            if TransactionCharges.FindSet() then begin
                repeat
                    LineNo := LineNo + 10000;

                    ChargeAmount := 0;
                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                        ChargeAmount := (Overdraft."Approved Amount" * TransactionCharges."Percentage of Amount") * 0.01
                    else
                        ChargeAmount := TransactionCharges."Charge Amount";

                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin

                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                        TariffDetails.Reset;
                        TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                        if TariffDetails.FindSet() then begin
                            repeat
                                if (Overdraft."Approved Amount" >= TariffDetails."Lower Limit") and (Overdraft."Approved Amount" <= TariffDetails."Upper Limit") then begin
                                    if TariffDetails."Use Percentage" = true then begin
                                        ChargeAmount := Overdraft."Approved Amount" * TariffDetails.Percentage * 0.01;
                                    end else begin
                                        ChargeAmount := TariffDetails."Charge Amount";
                                    end;
                                end;
                            until TariffDetails.Next = 0;
                        end;
                    end;



                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := Jtemplate;
                    GenJournalLine."Journal Batch Name" := JBatch;
                    GenJournalLine."Document No." := Overdraft."No.";
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                    GenJournalLine."Account No." := Overdraft."Account No.";
                    GenJournalLine."External Document No." := Overdraft."Account No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := TransactionCharges.Description;
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := ChargeAmount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := Overdraft."Global Dimension 1 Code";
                    GenJournalLine."Shortcut Dimension 2 Code" := Overdraft."Global Dimension 2 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    //IF NOT TransactionCharges."Transaction Charge Category" THEN  BEGIN

                    if TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty" then begin

                        //Excise Duty

                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := Jtemplate;
                        GenJournalLine."Journal Batch Name" := JBatch;
                        GenJournalLine."Document No." := Overdraft."No.";
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                        GenJournalLine."Account No." := Overdraft."Account No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Excise Duty';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := GenSetup."Excise Duty G/L";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := Overdraft."Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code" := Overdraft."Global Dimension 2 Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        TChargeAmount := TChargeAmount + ChargeAmount;
                    end;
                until TransactionCharges.Next = 0;
            end;


            //Post New
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
            end;

            //Post New

            Overdraft.Posted := true;
            Overdraft.Modify;

            Message('Overdraft charges posted successfully.');

        end;
    end;

    local procedure ClearOverDraft()
    var
        OverDraft: Record "Over Draft Authorisation";
    begin

        OverDraft.Reset;
        OverDraft.SetRange(OverDraft.Expired, false);
        if OverDraft.Find('-') then begin
            if OverDraft."Expiry Date" <= Today then begin
                OverDraft.Expired := true;
                OverDraft.Modify;
            end;
        end;
    end;

    local procedure "************Fixed Deposit**************"()
    begin
    end;

    local procedure CalculateFDInterest(Account: Record "Fixed Deposit Contract"; RunDate: Date)
    var
        InterestAmount: Decimal;
        InterestBuffer: Record "Interest Buffer";
        IntBufferNo: Integer;
        AccountTypes: Record "Product Factory";
        FixedDepType: Record "Fixed Deposit Type";
        FDInterestCalc: Record "FD Interest Calculation Rules";
        IntRate: Decimal;
        FDDays: Integer;
        FDMonths: Integer;
    begin

        InterestAmount := 0;
        InterestBuffer.Reset;
        if InterestBuffer.Find('+') then
            IntBufferNo := InterestBuffer.No;
        if AccountTypes.Get(Account."Product Type") then begin
            if AccountTypes."Product Category" = AccountTypes."product category"::"Fixed Deposit" = true then begin
                if FixedDepType.Get(Account."Fixed Deposit Type") then begin

                    // FDInterestCalc.Reset;
                    // FDInterestCalc.SetRange(FDInterestCalc.Code, Account."Fixed Deposit Type");
                    // if FDInterestCalc.FindSet() then begin
                    Account.CalcFields("Balance (LCY)");
                    // repeat
                    // if (FDInterestCalc."Minimum Amount" <= Account."Balance (LCY)") and
                    // (Account."Balance (LCY)" <= FDInterestCalc."Maximum Amount") then
                    // if Account."Neg. Interest Rate" = 0 then begin
                    IntRate := Account."Interest Rate";
                    // end else begin
                    //     IntRate := Account."Neg. Interest Rate";
                    // end;

                    // until FDInterestCalc.Next = 0;
                    // end;
                    if Account."Application Date" = 0D then Account."Application Date" := today;
                    // if FixedDepType."Call Deposit" = false then
                    // FDDays := CalcDate(FixedDepType.Duration, RunDate)
                    //  - RunDate else begin
                    // RunDate := Today;

                    // end;

                    FDDays := Account."FD Maturity Date" - Account."Application Date";
                    FDMonths := round((FDDays / 30), 1, '=');
                    if FDDays <= 0 then begin
                        FDDays := 0;
                        FDMonths := 0;
                    end;

                    //FDDays:=Account."FD Duration";
                    Account.CalcFields("Balance (LCY)");
                    InterestAmount := Account."Balance (LCY)" * IntRate * 0.01 * (FDMonths / 12);
                    InterestAmount := ROUND(InterestAmount, 1.0, '<');

                    IntBufferNo := IntBufferNo + 1;

                    InterestBuffer.Init;
                    InterestBuffer."Account No" := Account."No.";
                    InterestBuffer.No := IntBufferNo;
                    InterestBuffer."Product Type" := Account."Product Type";
                    InterestBuffer."Interest Date" := RunDate;
                    InterestBuffer."Interest Amount" := InterestAmount;
                    InterestBuffer.Description := 'FD INT - ' + Format(Account."FD Maturity Date", 0, ' <Day,2>-<Month Text,3>-<Year4> ');
                    InterestBuffer.Description := UpperCase(InterestBuffer.Description);
                    InterestBuffer."User ID" := USERID;
                    if InterestBuffer."Interest Amount" <> 0 then
                        InterestBuffer.Insert(true);
                end;
            end;
        end;
    end;


    procedure CloseNonRenewable(FDAccount: Record "Fixed Deposit Contract"; RunDate: Date; Jtemplate: Code[10]; Jbatch: Code[10])
    var
        AccountTypes: Record "Product Factory";
        FDType: Record "Fixed Deposit Type";
        GenJournalLine: Record "Gen. Journal Line";
        InterestBuffer: Record "Interest Buffer";
        FosaAcc: Record "Savings Accounts";
        Text0001: label 'Your Fixed deposit of ';
        Text0002: label ' has matured and amount transfered to your savings account on';
        GlobalFunctions: Codeunit "Global Functions";
        DocumentNo: Code[20];
        Wtax: Decimal;
        GrossInt: Decimal;
    begin
        if FDAccount."Fixed Deposit Status" = FDAccount."Fixed Deposit Status"::Closed then
            Error('The Fixed/Call Deposit is Closed, it has already been processed!');
        GrossInt := 0;
        Wtax := 0;

        Temp.Get(UserId);
        DocumentNo := 'FDINT' + '-' + CopyStr(Format(TODAY, 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2DMY(Today, 3));
        SavingsLedgerEntry.Reset;
        SavingsLedgerEntry.SetRange("Fixed Deposit Contract", FDAccount."No.");
        SavingsLedgerEntry.setrange("Document No.", DocumentNo);
        SavingsLedgerEntry.setrange("Posting Date", Today);
        if SavingsLedgerEntry.Find('-') then begin

            FDAccount."FD Maturity Date" := CalcDate(FDType.Duration, RunDate);
            FDAccount."FD Date Renewed" := RunDate;
            FDAccount."Fixed Deposit Status" := FDAccount."Fixed Deposit Status"::Active;
            //Account."FD Marked for Closure" := true;
            FDAccount.Modify;

            Message('Processed Successfully!');
        end else begin
            Jtemplate := Temp."Fixed/Call Journal Template";
            JBatch := Temp."Fixed/Call Journal Batch";

            if Jtemplate = '' then begin
                Error('Ensure the Fixed/Call Deposit Journal Template is set up in Banking User Setup');
            end;

            if JBatch = '' then begin
                Error('Ensure the Fixed/Call Deposit Journal Batch is set up in Banking User Setup');
            end;

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            GenJournalLine.DeleteAll;

            if FDAccount.Blocked <> FDAccount.Blocked::All then begin
                FDAccount.CalcFields(FDAccount."Balance (LCY)");
                if AccountTypes.Get(FDAccount."Product Type") then begin
                    if (AccountTypes."Product Category" = AccountTypes."product category"::"Fixed Deposit") then begin
                        if AccountTypes."Earns Interest" = true then begin
                            // if IsCallDeposit(FDAccount) then
                            //     RunDate := Today
                            // else
                            //     RunDate := FDAccount."FD Maturity Date";

                            if RunDate = 0D then
                                Error('Maturity Date must have a value in Fixed Deposit Contract.');

                            if FDAccount."FD Maturity Date" <= RunDate then begin
                                if FDType.Get(FDAccount."Fixed Deposit Type") then begin
                                    CalculateFDInterest(FDAccount, RunDate);

                                    AccountTypes.Reset;
                                    AccountTypes.SetRange(AccountTypes."Product ID", FDAccount."Product Type");
                                    if AccountTypes.Find('-') then begin

                                        AccountTypes.TestField("WithHolding Tax");
                                        AccountTypes.TestField("Withholding Tax Account");
                                        FDAccount.CalcFields("Untranfered Interest");
                                        GrossInt := FDAccount."Untranfered Interest";
                                        if GlobalFunctions.TaxExcemptions(FDAccount."Member No.") = true then
                                            Wtax := round((GrossInt * (AccountTypes."WithHolding Tax" / 100)), 1, '<')
                                        else
                                            WTax := 0;
                                        LineNo := LineNo + 10000;
                                        // 1. Credit Interest to FD less withholding tax (Tax Charged on member interest)
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Journal Batch Name" := Jbatch;
                                        GenJournalLine."Document No." := FDAccount."No.";
                                        GenJournalLine."External Document No." := DocumentNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                        GenJournalLine."Account No." := FDAccount."Fixed Deposit Account No.";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'FD gross interest - ' + Format(FDAccount."FD Maturity Date", 0, ' <Day,2>-<Month Text,3>-<Year4> ');
                                        GenJournalLine.Description := UpperCase(GenJournalLine.Description);
                                        GenJournalLine.Amount := -GrossInt;
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := AccountTypes."Interest Expense Account";
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                        GenJournalLine."Fixed Deposit Contract" := FDAccount."No.";
                                        GenJournalLine."Shortcut Dimension 1 Code" := FDAccount."Global Dimension 1 Code";
                                        GenJournalLine."Shortcut Dimension 2 Code" := FDAccount."Global Dimension 2 Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        //Withholding tax credit to tax account
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Journal Batch Name" := Jbatch;
                                        GenJournalLine."Document No." := FDAccount."No.";
                                        GenJournalLine."External Document No." := DocumentNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                        GenJournalLine."Account No." := FDAccount."Fixed Deposit Account No.";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'Withholding Tax';
                                        GenJournalLine.Description := UpperCase(GenJournalLine.Description);

                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := AccountTypes."Withholding Tax Account";
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                        GenJournalLine."Fixed Deposit Contract" := FDAccount."No.";
                                        GenJournalLine."Shortcut Dimension 1 Code" := FDAccount."Global Dimension 1 Code";
                                        GenJournalLine."Shortcut Dimension 2 Code" := FDAccount."Global Dimension 2 Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        // debit Principle from FD acc.
                                        FDAccount.CalcFields("Balance (LCY)", Balance, "Untranfered Interest");
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Journal Batch Name" := Jbatch;
                                        GenJournalLine."Document No." := FDAccount."No.";
                                        GenJournalLine."External Document No." := DocumentNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                        GenJournalLine."Account No." := FDAccount."Fixed Deposit Account No.";//Account."No."
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'Transfer principle from fixed';
                                        GenJournalLine.Description := UpperCase(GenJournalLine.Description);
                                        GenJournalLine.Amount := FDAccount."Balance (LCY)";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Fixed Deposit Contract" := FDAccount."No.";
                                        GenJournalLine."Shortcut Dimension 1 Code" := FDAccount."Global Dimension 1 Code";
                                        GenJournalLine."Shortcut Dimension 2 Code" := FDAccount."Global Dimension 2 Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        //bal
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Journal Batch Name" := Jbatch;
                                        GenJournalLine."Document No." := FDAccount."No.";
                                        GenJournalLine."External Document No." := DocumentNo;
                                        GenJournalLine."Account No." := FDAccount."FOSA Main Account No.";
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'Transfer principle from fixed';
                                        GenJournalLine.Description := UpperCase(GenJournalLine.Description);
                                        GenJournalLine.Amount := -FDAccount."Balance (LCY)";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Fixed Deposit Contract" := FDAccount."No.";
                                        GenJournalLine."Shortcut Dimension 1 Code" := FDAccount."Global Dimension 1 Code";
                                        GenJournalLine."Shortcut Dimension 2 Code" := FDAccount."Global Dimension 2 Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                        //TRANSFER net Int amount to member savings
                                        LineNo := LineNo + 10000;
                                        FDAccount.CalcFields("Balance (LCY)", Balance, "Untranfered Interest");
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Journal Batch Name" := Jbatch;
                                        GenJournalLine."Document No." := FDAccount."No.";
                                        GenJournalLine."External Document No." := DocumentNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                        GenJournalLine."Account No." := FDAccount."FOSA Main Account No.";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'Transfer net interest from Fixed';
                                        GenJournalLine.Description := UpperCase(GenJournalLine.Description);
                                        GenJournalLine.Amount := (GrossInt - Wtax) * -1;
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := '';
                                        GenJournalLine."Fixed Deposit Contract" := FDAccount."No.";
                                        GenJournalLine."Shortcut Dimension 1 Code" := FDAccount."Global Dimension 1 Code";
                                        GenJournalLine."Shortcut Dimension 2 Code" := FDAccount."Global Dimension 2 Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        //TRANSFER net Int amount to member savings
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Journal Batch Name" := Jbatch;
                                        GenJournalLine."Document No." := FDAccount."No.";
                                        GenJournalLine."External Document No." := DocumentNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                        GenJournalLine."Account No." := FDAccount."FOSA Main Account No.";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'Transfer net interest to Savings';
                                        GenJournalLine.Description := UpperCase(GenJournalLine.Description);
                                        GenJournalLine.Amount := (GrossInt - Wtax);
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := '';
                                        GenJournalLine."Fixed Deposit Contract" := FDAccount."No.";
                                        GenJournalLine."Shortcut Dimension 1 Code" := FDAccount."Global Dimension 1 Code";
                                        GenJournalLine."Shortcut Dimension 2 Code" := FDAccount."Global Dimension 2 Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                        //Post New
                                        GenJournalLine.Reset;
                                        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                                        GenJournalLine.SetRange("Journal Batch Name", Jbatch);
                                        if GenJournalLine.Find('-') then begin
                                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                                        end;
                                        //Post New
                                        msg := Text0001 + Format(FDAccount."Fixed Deposit Amount") + Text0002
                                        + Format(Today) + ' ' + Format(Time);

                                        if FDAccount."Transactional Mobile No" = '' then begin
                                            Memb.reset;
                                            Memb.setrange("No.", FDAccount."Member No.");
                                            if Memb.FindFirst() then begin

                                                if Memb."Transactional Mobile Number" <> '' then
                                                    SendSMS.SendSms(Source::FIXED_DEPOSIT_MATURITY, Memb."Transactional Mobile Number", msg, Format(FDAccount."No."), '', true, 0, false, 'CBS', FDAccount."No.", 'CBS')
                                                else
                                                    SendSMS.SendSms(Source::FIXED_DEPOSIT_MATURITY, Memb."Phone No.", msg, Format(FDAccount."No."), '', true, 0, false, 'CBS', FDAccount."No.", 'CBS')

                                            end;
                                        end
                                        else begin

                                            SendSMS.SendSms(Source::FIXED_DEPOSIT_MATURITY, FDAccount."Transactional Mobile No", msg, Format(FDAccount."No."), '', true, 0, false, 'CBS', FDAccount."No.", 'CBS');
                                        end;

                                        // SendSMS.SendSms(Source::FIXED_DEPOSIT_MATURITY, FDAccount."Transactional Mobile No", msg, Format(FDAccount."No."), '', true, 0, false, 'CBS', FDAccount."No.", 'CBS');

                                        FixedHistory(FDAccount);


                                        InterestBuffer.Reset;
                                        InterestBuffer.SetRange(InterestBuffer."Account No", FDAccount."No.");
                                        if InterestBuffer.Find('-') then
                                            InterestBuffer.ModifyAll(InterestBuffer.Transferred, true);
                                        if FDAccount."FD Maturity Date" = 0D then FDAccount."FD Maturity Date" := Today;
                                        FDAccount."FD Maturity Date" := CalcDate(FDType.Duration, FDAccount."FD Maturity Date");
                                        FDAccount."FD Maturity Instructions" := FDAccount."FD Maturity Instructions"::"Transfer all to Savings";
                                        FDAccount."Fixed Deposit Status" := FDAccount."fixed deposit status"::Closed;
                                        FDAccount."FD Marked for Closure" := true;
                                        FDAccount.Modify;

                                        Message('Processed Successfully!');

                                    end;
                                end;
                            end;
                        end
                        else
                            Error('This Product does not earn interest in Product Setup.');
                    end
                    else
                        Error('The Product Category must be Fixed Deposit.');
                end
                else
                    Error('The Product Type is not found.');
            end
            else
                Error('The FD Account is blocked.');

        end;
    end;

    procedure IsCallDeposit(FDContract: Record "Fixed Deposit Contract"): Boolean
    var
        FDType: Record "Fixed Deposit Type";
    begin
        FDType.Reset();
        FDType.SetRange(Code, FDContract."Fixed Deposit Type");
        FDType.SetRange("Call Deposit", true);
        exit(FDType.FindFirst())
    end;


    procedure Renew(Account: Record "Fixed Deposit Contract"; RunDate: Date; Jtemplate: Code[10]; Jbatch: Code[10])
    var
        AccountTypes: Record "Product Factory";
        FDType: Record "Fixed Deposit Type";
        GenJournalLine: Record "Gen. Journal Line";
        InterestBuffer: Record "Interest Buffer";
        Text0001: label 'Your Fixed deposit of ';
        Text0002: label ' has matured and interest transfered to your savings account and principal renewed on ';
        GlobalFunctions: Codeunit "Global Functions";
        DocumentNo: Code[20];
        FDCalculation: Record "FD Interest Calculation Rules";
        NoOfDays: Integer;
    begin

        if Account."Fixed Deposit Status" = Account."Fixed Deposit Status"::Closed then
            Error('The Fixed/Call Deposit is Closed, it has already been processed!');

        Temp.Get(UserId);
        DocumentNo := 'FDINT' + '-' + CopyStr(Format(TODAY, 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2DMY(Today, 3));
        SavingsLedgerEntry.Reset;
        SavingsLedgerEntry.SetRange("Fixed Deposit Contract", Account."No.");
        SavingsLedgerEntry.setrange("Document No.", DocumentNo);
        SavingsLedgerEntry.setrange("Posting Date", Today);
        if SavingsLedgerEntry.Find('-') then begin

            Account."FD Maturity Date" := CalcDate(FDType.Duration, RunDate);
            Account."FD Date Renewed" := RunDate;
            Account."Fixed Deposit Status" := Account."Fixed Deposit Status"::Active;
            //Account."FD Marked for Closure" := true;
            Account.Modify;

            Message('Processed Successfully!');
        end else begin
            Jtemplate := Temp."Fixed/Call Journal Template";
            JBatch := Temp."Fixed/Call Journal Batch";

            if Jtemplate = '' then begin
                Error('Ensure the Fixed/Call Deposit Journal Template is set up in Banking User Setup');
            end;

            if JBatch = '' then begin
                Error('Ensure the Fixed/Call Deposit Journal Batch is set up in Banking User Setup');
            end;

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            GenJournalLine.DeleteAll;

            if Account.Blocked <> Account.Blocked::All then begin
                if AccountTypes.Get(Account."Product Type") then begin
                    if AccountTypes."Product Category" = AccountTypes."product category"::"Fixed Deposit" = true then begin
                        if AccountTypes."Earns Interest" = true then
                            if IsCallDeposit(Account) then
                                RunDate := Today
                            else
                                RunDate := Account."FD Maturity Date";

                        if RunDate = 0D then
                            Error('Maturity Date must have a value in Fixed Deposit Contract.');

                        // Account.TestField("FD Maturity Date");
                        if Account."FD Maturity Date" <= RunDate then begin
                            if FDType.Get(Account."Fixed Deposit Type") then begin
                                CalculateFDInterest(Account, RunDate);

                                AccountTypes.Reset;
                                AccountTypes.SetRange(AccountTypes."Product ID", Account."Product Type");
                                if AccountTypes.Find('-') then begin
                                    AccountTypes.TestField("WithHolding Tax");
                                    AccountTypes.TestField("Withholding Tax Account");
                                    LineNo := LineNo + 10000;
                                    Account.CalcFields("Untranfered Interest");

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                    GenJournalLine."Document No." := Account."No.";
                                    GenJournalLine."External Document No." := DocumentNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                    GenJournalLine."Account No." := Account."Fixed Deposit Account No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'FD Interest - ' + Format(Account."FD Maturity Date", 0, ' <Day,2>-<Month Text,3>-<Year4> ');
                                    GenJournalLine.Description := UpperCase(GenJournalLine.Description);
                                    GenJournalLine.Amount := -Account."Untranfered Interest";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := AccountTypes."Interest Expense Account";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Fixed Deposit Contract" := Account."No.";
                                    GenJournalLine."Shortcut Dimension 1 Code" := Account."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code" := Account."Global Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;


                                    //Withholding tax
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                    GenJournalLine."Document No." := Account."No.";
                                    GenJournalLine."External Document No." := DocumentNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                    GenJournalLine."Account No." := Account."Fixed Deposit Account No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'Withholding Tax';
                                    GenJournalLine.Description := UpperCase(GenJournalLine.Description);
                                    if GlobalFunctions.TaxExcemptions(Account."Member No.") = true then
                                        GenJournalLine.Amount := 0
                                    else
                                        GenJournalLine.Amount := Account."Untranfered Interest" * (AccountTypes."WithHolding Tax" / 100);
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := AccountTypes."Withholding Tax Account";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Fixed Deposit Contract" := Account."No.";
                                    GenJournalLine."Shortcut Dimension 1 Code" := Account."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code" := Account."Global Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    //Transfer Interest to fosa Savings
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                    GenJournalLine."Document No." := Account."No.";
                                    GenJournalLine."External Document No." := DocumentNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                    GenJournalLine."Account No." := Account."Fixed Deposit Account No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'Transfer to Savings';
                                    GenJournalLine.Description := UpperCase(GenJournalLine.Description);
                                    GenJournalLine.Amount := Account."Untranfered Interest" - (Account."Untranfered Interest" * (AccountTypes."WithHolding Tax" / 100));
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                                    //GenJournalLine."Bal. Account No.":=AccountTypes."Interest Tax Account";
                                    //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Fixed Deposit Contract" := Account."No.";
                                    GenJournalLine."Shortcut Dimension 1 Code" := Account."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code" := Account."Global Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");

                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;


                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                    GenJournalLine."Document No." := Account."No.";
                                    GenJournalLine."External Document No." := Account."No.";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                    GenJournalLine."Account No." := Account."FOSA Main Account No.";//Account."No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'Transfer from fixed';
                                    GenJournalLine.Description := UpperCase(GenJournalLine.Description);
                                    GenJournalLine.Amount := (Account."Untranfered Interest" - (Account."Untranfered Interest" * (AccountTypes."WithHolding Tax" / 100))) * -1;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                                    //GenJournalLine."Bal. Account No.":=AccountTypes."Interest Tax Account";
                                    //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                    // GenJournalLine."Fixed Deposit Contract" := Account."No.";
                                    GenJournalLine."Shortcut Dimension 1 Code" := Account."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code" := Account."Global Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");

                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    //Transfer to savings


                                    //Post New
                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                                    GenJournalLine.SetRange("Journal Batch Name", Jbatch);
                                    if GenJournalLine.Find('-') then begin
                                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                                    end;

                                    if Account."Fixed Deposit Amount" > 0 then
                                        if Account."Transactional Mobile No" = '' then begin
                                            Memb.reset;
                                            Memb.setrange("No.", Account."Member No.");
                                            if Memb.FindFirst() then begin
                                                msg := Text0001 + Format(Account."Fixed Deposit Amount") + Text0002
                                           + Format(Today) + ' ' + Format(Time);
                                                if Memb."Transactional Mobile Number" <> '' then
                                                    SendSMS.SendSms(Source::FIXED_DEPOSIT_MATURITY, Memb."Transactional Mobile Number", msg, Format(Account."No."), '', true, 0, false, 'CBS', Account."No.", 'CBS')
                                                else
                                                    SendSMS.SendSms(Source::FIXED_DEPOSIT_MATURITY, Memb."Phone No.", msg, Format(Account."No."), '', true, 0, false, 'CBS', Account."No.", 'CBS')

                                            end;
                                        end
                                        else begin
                                            msg := Text0001 + Format(Account."Fixed Deposit Amount") + Text0002
                                           + Format(Today) + ' ' + Format(Time);

                                            SendSMS.SendSms(Source::FIXED_DEPOSIT_MATURITY, Account."Transactional Mobile No", msg, Format(Account."No."), '', true, 0, false, 'CBS', Account."No.", 'CBS');
                                        end;

                                    FixedHistory(Account);

                                    //Post New
                                    InterestBuffer.Reset;
                                    InterestBuffer.SetRange(InterestBuffer."Account No", Account."No.");
                                    if InterestBuffer.Find('-') then
                                        InterestBuffer.ModifyAll(InterestBuffer.Transferred, true);

                                    Account."FD Maturity Date" := CalcDate(FDType.Duration, RunDate);
                                    Account."Fixed Deposit Status" := Account."Fixed Deposit Status"::Active;
                                    Account."Application Date" := Today;
                                    // Account.Balance := Account."Fixed Deposit Amount";
                                    // Account."Balance (LCY)" := Account."Fixed Deposit Amount";
                                    Account."FD Date Renewed" := RunDate;

                                    FDType.Reset();
                                    FDType.SetRange(Code, Account."Fixed Deposit Type");
                                    if FDType.FindFirst() then begin
                                        FDCalculation.Reset();
                                        FDCalculation.SetRange(Code, FDType.Code);
                                        if FDCalculation.FindFirst() then begin
                                            //repeat
                                            case
                                                Account."Fixed Deposit Amount" of
                                                FDCalculation."Minimum Amount" .. FDCalculation."Maximum Amount":
                                                    begin
                                                        Account."Interest Rate" := FDCalculation."Interest Rate";
                                                    end;

                                            end;
                                        end;
                                    end;
                                    if Account."Application Date" <> 0D then begin
                                        NoOfDays := Abs(Account."FD Maturity Date" - Account."Application Date");
                                        Account."Forecasted Interest" := Account."Fixed Deposit Amount" * (Account."Interest Rate" / 100) * (NoOfDays / 365);
                                    end;
                                    Account.Modify;

                                    Message('Processed Successfully!');
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    procedure RollOver(Account: Record "Fixed Deposit Contract"; RunDate: Date; Jtemplate: Code[10]; Jbatch: Code[10])
    var
        AccountTypes: Record "Product Factory";
        FDType: Record "Fixed Deposit Type";
        GenJournalLine: Record "Gen. Journal Line";
        InterestBuffer: Record "Interest Buffer";
        Text0001: label 'Your Fixed deposit of ';
        Text0002: label ' has matured and has been renewed on';
        GlobalFunctions: Codeunit "Global Functions";
        DocumentNo: Code[20];
        SLedger: record "Savings Ledger Entry";
        WTaxDiv: Decimal;
        NoOfDays: Integer;
        FDCalculation: Record "FD Interest Calculation Rules";
    begin

        if Account."Fixed Deposit Status" = Account."Fixed Deposit Status"::Closed then
            Error('The Fixed/Call Deposit is Closed, it has already been processed!');
        DocumentNo := 'FDINT' + '-' + CopyStr(Format(TODAY, 0, '<Month Text>'), 1, 3) + ' ' + Format(Date2DMY(Today, 3));
        SavingsLedgerEntry.Reset;
        SavingsLedgerEntry.SetRange("Fixed Deposit Contract", Account."No.");
        SavingsLedgerEntry.setrange("External Document No.", DocumentNo);
        SavingsLedgerEntry.setrange("Posting Date", Today);
        if SavingsLedgerEntry.Find('-') then begin

            Account."FD Maturity Date" := CalcDate(FDType.Duration, RunDate);
            Account."FD Date Renewed" := RunDate;
            Account."Fixed Deposit Status" := Account."Fixed Deposit Status"::Active;
            //Account."FD Marked for Closure" := true;
            Account.Modify;

            Message('Processed Successfully!');
        end else begin


            Temp.Get(UserId);

            Jtemplate := Temp."Fixed/Call Journal Template";
            JBatch := Temp."Fixed/Call Journal Batch";

            if Jtemplate = '' then begin
                Error('Ensure the Fixed/Call Deposit Journal Template is set up in Banking User Setup');
            end;

            if JBatch = '' then begin
                Error('Ensure the Fixed/Call Deposit Journal Batch is set up in Banking User Setup');
            end;

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            GenJournalLine.DeleteAll;

            if Account.Blocked <> Account.Blocked::All then begin
                Account.CalcFields("Balance (LCY)");

                if AccountTypes.Get(Account."Product Type") then begin
                    if AccountTypes."Product Category" = AccountTypes."product category"::"Fixed Deposit" = true then begin
                        if AccountTypes."Earns Interest" = true then
                            Account.TestField("FD Maturity Date");

                        // if IsCallDeposit(Account) then
                        //     RunDate := Today
                        // else
                        //     RunDate := Account."FD Maturity Date";


                        if Account."FD Maturity Date" = 0D then
                            Error('Maturity Date must have a value in Fixed Deposit Contract.');
                        if Account."FD Maturity Date" <= RunDate then begin
                            if FDType.Get(Account."Fixed Deposit Type") then begin
                                CalculateFDInterest(Account, RunDate);

                                AccountTypes.Reset;
                                AccountTypes.SetRange(AccountTypes."Product ID", Account."Product Type");
                                if AccountTypes.Find('-') then begin
                                    AccountTypes.TestField("WithHolding Tax");
                                    AccountTypes.TestField("Withholding Tax Account");
                                    LineNo := LineNo + 10000;
                                    Account.CalcFields("Untranfered Interest");

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                    GenJournalLine."Document No." := Account."No.";
                                    GenJournalLine."External Document No." := DocumentNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                    GenJournalLine."Account No." := Account."Fixed Deposit Account No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'FD Interest - ' + Format(Account."FD Maturity Date", 0, ' <Day,2>-<Month Text,3>-<Year4> ');
                                    GenJournalLine.Description := UpperCase(GenJournalLine.Description);
                                    GenJournalLine.Amount := -Account."Untranfered Interest";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := AccountTypes."Interest Expense Account";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Fixed Deposit Contract" := Account."No.";
                                    GenJournalLine."Shortcut Dimension 1 Code" := Account."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code" := Account."Global Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;


                                    //Withholding tax
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                    GenJournalLine."Document No." := Account."No.";
                                    GenJournalLine."External Document No." := DocumentNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                    GenJournalLine."Account No." := Account."Fixed Deposit Account No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'Withholding Tax';
                                    GenJournalLine.Description := UpperCase(GenJournalLine.Description);
                                    if GlobalFunctions.TaxExcemptions(Account."Member No.") = true then
                                        GenJournalLine.Amount := 0
                                    else
                                        GenJournalLine.Amount := Account."Untranfered Interest" * (AccountTypes."WithHolding Tax" / 100);
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := AccountTypes."Withholding Tax Account";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Fixed Deposit Contract" := Account."No.";
                                    GenJournalLine."Shortcut Dimension 1 Code" := Account."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code" := Account."Global Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    //Post New
                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                                    GenJournalLine.SetRange("Journal Batch Name", Jbatch);
                                    if GenJournalLine.Find('-') then begin
                                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                                    end;

                                    //Post New
                                    if Account."Transactional Mobile No" = '' then begin
                                        Memb.reset;
                                        Memb.setrange("No.", Account."Member No.");
                                        if Memb.FindFirst() then begin
                                            msg := Text0001 + Format(Account."Balance (LCY)") + Text0002
                                                                               + Format(Today) + ' ' + Format(Time);
                                            if Memb."Transactional Mobile Number" <> '' then
                                                SendSMS.SendSms(Source::FIXED_DEPOSIT_MATURITY, Memb."Transactional Mobile Number", msg, Format(Account."No."), '', true, 0, false, 'CBS', Account."No.", 'CBS')
                                            else
                                                SendSMS.SendSms(Source::FIXED_DEPOSIT_MATURITY, Memb."Phone No.", msg, Format(Account."No."), '', true, 0, false, 'CBS', Account."No.", 'CBS')

                                        end;
                                    end
                                    else begin
                                        msg := Text0001 + Format(Account."Balance (LCY)") + Text0002
                                                                              + Format(Today) + ' ' + Format(Time);

                                        SendSMS.SendSms(Source::FIXED_DEPOSIT_MATURITY, Account."Transactional Mobile No", msg, Format(Account."No."), '', true, 0, false, 'CBS', Account."No.", 'CBS');
                                    end;


                                    FixedHistory(Account);

                                    InterestBuffer.Reset;
                                    InterestBuffer.SetRange(InterestBuffer."Account No", Account."No.");
                                    if InterestBuffer.Find('-') then
                                        InterestBuffer.ModifyAll(InterestBuffer.Transferred, true);

                                    Account."Application Date" := Today;
                                    Account."FD Maturity Date" := CalcDate(FDType.Duration, RunDate);
                                    Account."FD Date Renewed" := RunDate;
                                    Account."Fixed Deposit Status" := Account."Fixed Deposit Status"::Active;
                                    Account.calcfields("Balance (LCY)");
                                    Account."Fixed Deposit Amount" := Account."Balance (LCY)";

                                    //Account."FD Marked for Closure" := true;
                                    //New rate incase of chnages
                                    FDType.Reset();
                                    FDType.SetRange(Code, Account."Fixed Deposit Type");
                                    if FDType.FindFirst() then begin
                                        FDCalculation.Reset();
                                        FDCalculation.SetRange(Code, FDType.Code);
                                        if FDCalculation.FindFirst() then begin
                                            //repeat
                                            case
                                                Account."Fixed Deposit Amount" of
                                                FDCalculation."Minimum Amount" .. FDCalculation."Maximum Amount":
                                                    begin
                                                        Account."Interest Rate" := FDCalculation."Interest Rate";
                                                    end;

                                            end;
                                        end;
                                    end;
                                    if Account."Application Date" <> 0D then begin
                                        NoOfDays := Abs(Account."FD Maturity Date" - Account."Application Date");
                                        Account."Forecasted Interest" := Account."Fixed Deposit Amount" * (Account."Interest Rate" / 100) * (NoOfDays / 365);
                                    end;
                                    Account.Modify;
                                    Message('Processed Successfully!');
                                end;

                            end;
                        end;
                    end;
                end;
            end;
        end;

    end;

    procedure FixedHistory(Account: Record "Fixed Deposit Contract")
    var
        FixedHistory: Record "Fixed Deposit History";
        FixedHistNo: Integer;
    begin

        FixedHistory.Reset;
        if FixedHistory.Find('+') then
            FixedHistNo := FixedHistory.No;

        FixedHistNo := FixedHistNo + 1;

        FixedHistory.Init;
        FixedHistory.No := FixedHistNo;
        FixedHistory."Account No." := Account."No.";
        FixedHistory."Interest Earned" := Account."Untranfered Interest";
        FixedHistory."Fixed Deposit Type" := Account."Fixed Deposit Type";
        FixedHistory."Fixed Amount" := Account."Balance (LCY)";
        FixedHistory."FD Maturity Date" := Account."FD Maturity Date";
        FixedHistory."FD Duration" := Account."FD Duration";
        FixedHistory."FD Maturity Instructions" := Account."FD Maturity Instructions";
        FixedHistory."Registration Date" := Account."Registration Date";
        FixedHistory."Neg. Interest Rate" := Account."Neg. Interest Rate";
        FixedHistory.Insert;
    end;

    local procedure "****************Sacco_ Bank Cheque Posting***********************"()
    begin
    end;


    procedure PostCheques(ChReceiptH: Record "Cheque Receipts")
    var
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Salary Journal Batch is set up in Banking User Setup';
        GenJournalLine: Record "Gen. Journal Line";
        ChqRecLines: Record "Cheque Issue Lines";
        TCharges: Decimal;
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        CheqReg: Record "Cheques Register";
        AvailBal: Decimal;
        MinBalance: Decimal;
        Account: Record "Savings Accounts";
        ProdType: Record "Product Factory";
        MobNo: Code[20];
        Text0003: label 'Your Cheque of Amount ';
        Text0004: label ' has been paid ';
    begin
        // with ChReceiptH do
        begin

            Temp.Get(UserId);
            Jtemplate := Temp."Cashier Journal Template";
            JBatch := Temp."Cashier Journal Batch";

            if Jtemplate = '' then begin
                Error(Text0001);
            end;

            if JBatch = '' then begin
                Error(Text0002);
            end;

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            GenJournalLine.DeleteAll;

            ///////

            if Confirm('Are you sure you want post cheques', true) = true then begin



                ChqRecLines.Reset;
                ChqRecLines.SetRange(ChqRecLines."Chq Receipt No", ChReceiptH."No.");
                ChqRecLines.SetRange(ChqRecLines.Status, ChqRecLines.Status::Pending);

                if ChqRecLines.FindSet() then begin
                    repeat

                        if ChqRecLines."Un pay Code" = '' then begin
                            //Cheque Amounts

                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Document No." := ChReceiptH."No.";
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                            GenJournalLine."Account No." := ChqRecLines."Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := ChReceiptH."Transaction Date";
                            GenJournalLine."External Document No." := ChqRecLines."Cheque Serial No";
                            GenJournalLine.Description := 'Cheque Issued' + ChqRecLines."Cheque Serial No";
                            GenJournalLine.Amount := ChqRecLines.Amount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            //GenJournalLine."Shortcut Dimension 1 Code":='';
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                            GenJournalLine."Bal. Account No." := ChReceiptH."Clearing Bank";
                            //GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            //Charges
                            TCharges := 0;
                            TransactionCharges.Reset;
                            TransactionCharges.SetRange(TransactionCharges."Transaction Type", ChReceiptH."Transaction Type");
                            if TransactionCharges.FindSet() then begin
                                repeat
                                    LineNo := LineNo + 10000;
                                    ChargeAmount := 0;
                                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                                        ChargeAmount := (ChqRecLines.Amount * TransactionCharges."Percentage of Amount") * 0.01
                                    else
                                        ChargeAmount := TransactionCharges."Charge Amount";
                                    if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                                        TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                                        TariffDetails.Reset;
                                        TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                        if TariffDetails.FindSet() then begin
                                            repeat
                                                if (ChqRecLines.Amount >= TariffDetails."Lower Limit") and (ChqRecLines.Amount <= TariffDetails."Upper Limit") then begin
                                                    if TariffDetails."Use Percentage" = true then begin
                                                        ChargeAmount := ChqRecLines.Amount * TariffDetails.Percentage * 0.01;
                                                    end else begin
                                                        ChargeAmount := TariffDetails."Charge Amount";
                                                    end;
                                                end;
                                            until TariffDetails.Next = 0;
                                        end;
                                    end;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := JBatch;
                                    GenJournalLine."Document No." := ChReceiptH."No.";
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                    GenJournalLine."Account No." := ChqRecLines."Account No.";
                                    //GenJournalLine."External Document No.":="ID No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := ChReceiptH."Transaction Date";
                                    GenJournalLine.Description := TransactionCharges.Description;
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := ChargeAmount;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    //GenJournalLine."Shortcut Dimension 1 Code":=DActivity2;
                                    //GenJournalLine."Shortcut Dimension 2 Code":=DBranch2;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;



                                    if (TransactionCharges."Transaction Charge Category" <> TransactionCharges."transaction charge category"::"Stamp Duty") and
                                    (TransactionCharges."Recover Excise Duty" = true) then begin
                                        //Excise Duty
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Journal Batch Name" := JBatch;
                                        GenJournalLine."Document No." := ChReceiptH."No.";
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                                        GenJournalLine."Account No." := ChqRecLines."Account No.";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := ChReceiptH."Transaction Date";
                                        GenJournalLine.Description := 'Excise Duty';
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        GenJournalLine.Amount := (ChargeAmount * GenSetup."Excise Duty (%)") * 0.01;
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := GenSetup."Excise Duty G/L";
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                        // GenJournalLine."Shortcut Dimension 1 Code":=DActivity2;
                                        //GenJournalLine."Shortcut Dimension 2 Code":=DBranch2;
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        TCharges := TCharges + ChargeAmount;
                                    end;
                                until TransactionCharges.Next = 0;
                            end;


                            AvailBal := 0;
                            MinBalance := 0;

                            if Account.Get(ChqRecLines."Account No.") then begin
                                Account.CalcFields(Account.Balance, Account."Uncleared Cheques", Account."Authorised Over Draft", Account."Lien Placed");

                                ProdType.Reset;
                                ProdType.SetRange(ProdType."Product ID", Account."Product Type");
                                if ProdType.Find('-') then begin
                                    MinBalance := ProdType."Minimum Balance";

                                    AvailBal := (Account.Balance + Account."Authorised Over Draft") - (MinBalance + Account."Uncleared Cheques" + Account."Lien Placed");

                                    if AvailBal < ChqRecLines.Amount then
                                        Error('The transaction will result in overdrawing account %1', ChqRecLines."Account No.");
                                end;
                            end;
                        end;
                    until ChqRecLines.Next = 0;
                end;


                //Post New
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                end;

                //Mark cheque book register
                ChqRecLines.Reset;
                ChqRecLines.SetRange(ChqRecLines."Chq Receipt No", ChReceiptH."No.");
                ChqRecLines.SetRange(ChqRecLines.Status, ChqRecLines.Status::Pending);
                if ChqRecLines.FindSet() then begin
                    repeat
                        CheqReg.Reset;
                        CheqReg.SetRange(CheqReg."Cheque No.", ChqRecLines."Cheque Serial No");
                        if CheqReg.Find('-') then begin
                            CheqReg.Status := CheqReg.Status::Approved;
                            CheqReg."Approval Date" := Today;
                            CheqReg.Modify;
                        end;


                        if Account.Get(ChqRecLines."Account No.") then begin
                            MobNo := Account."Transactional Mobile No";
                        end;

                        msg := Text0004 + Format(Today) + ' ' + Format(Time)
                        + ' ' + COMPANYNAME;
                        SendSMS.SendSms(Source::"CHQ BOOK", MobNo, msg, Format(ChReceiptH."No."), '', true, 0, false, 'CBS', ChReceiptH."No.", 'CBS');


                    until ChqRecLines.Next = 0;
                end;


                ChReceiptH.Posted := true;
                ChReceiptH."Posted By" := UserId;
                ChReceiptH.Modify;

                Message('Transaction Posted Successfully');


            end;
            //////

        end;
    end;


    procedure PostUnpayCheques(ChReceiptH: Record "Cheque Receipts")
    var
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Salary Journal Batch is set up in Banking User Setup';
        GenJournalLine: Record "Gen. Journal Line";
        ChqRecLines: Record "Cheque Issue Lines";
        TCharges: Decimal;
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        CheqReg: Record "Cheques Register";
        ChequeCodes: Record "Cheque Return Codes";
        MobNo: Code[20];
        Account: Record "Savings Accounts";
        Text0003: label 'Your Cheque of Amount ';
        Text0004: label ' has been bounced ';
    begin
        //with ChReceiptH do
        begin

            Temp.Get(UserId);
            Jtemplate := Temp."Cashier Journal Template";
            JBatch := Temp."Cashier Journal Batch";

            if Jtemplate = '' then begin
                Error(Text0001);
            end;

            if JBatch = '' then begin
                Error(Text0002);
            end;

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            GenJournalLine.DeleteAll;

            /////////

            if Confirm('Are you sure you want to unpay accounts', false) = true then begin

                if UpperCase(UserId) = UpperCase(ChReceiptH."Posted By") then
                    Error('This must be done by another user');

                if Posted = false then
                    Error('It must be posted first');

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                GenJournalLine.DeleteAll;

                ChqRecLines.Reset;
                ChqRecLines.SetRange(ChqRecLines."Chq Receipt No", ChReceiptH."No.");
                ChqRecLines.SetRange(ChqRecLines.Status, ChqRecLines.Status::Pending);
                if ChqRecLines.FindSet() then begin
                    repeat

                        if ChqRecLines."Un pay Code" <> '' then begin


                            //Cheque Amounts

                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Document No." := ChReceiptH."No.";
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                            GenJournalLine."Account No." := ChqRecLines."Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := ChReceiptH."Transaction Date";
                            GenJournalLine."External Document No." := ChqRecLines."Cheque Serial No";
                            GenJournalLine.Description := 'Cheque Issued' + ChqRecLines."Cheque Serial No";
                            GenJournalLine.Amount := ChqRecLines.Amount * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            //GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                            GenJournalLine."Bal. Account No." := ChReceiptH."Clearing Bank";
                            //GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            //Post cheque processing charges

                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Document No." := ChReceiptH."No.";
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                            GenJournalLine."Account No." := ChqRecLines."Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := ChReceiptH."Transaction Date";
                            GenJournalLine."External Document No." := ChqRecLines."Cheque Serial No";
                            GenJournalLine.Description := 'Cheque unpay Commision';
                            GenJournalLine.Amount := ChqRecLines."Un Pay Charge Amount";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            //GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            if ChequeCodes.Get(ChqRecLines."Un pay Code") then begin
                                ChequeCodes.TestField(ChequeCodes."Bounced Charges GL Account");
                                GenJournalLine."Bal. Account No." := ChequeCodes."Bounced Charges GL Account";
                            end;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            //Excise duty
                            GenSetup.Get;

                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Document No." := ChReceiptH."No.";
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Savings;
                            GenJournalLine."Account No." := ChqRecLines."Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := ChReceiptH."Transaction Date";
                            GenJournalLine."External Document No." := ChqRecLines."Cheque Serial No";
                            GenJournalLine.Description := 'Excise Duty';
                            GenJournalLine.Amount := ChqRecLines."Un Pay Charge Amount" * (GenSetup."Excise Duty (%)" / 100);
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            //GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := GenSetup."Excise Duty G/L";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                        end;


                        if Account.Get(ChqRecLines."Account No.") then begin
                            MobNo := Account."Transactional Mobile No";
                        end;


                        msg := Text0003 + Format(ChqRecLines.Amount) + Text0004 + Format(Today) + ' ' + Format(Time)
                        + ' ' + COMPANYNAME;
                        SendSMS.SendSms(Source::"CHQ BOOK", MobNo, msg, Format(ChReceiptH."No."), '', true, 0, false, 'CBS', ChReceiptH."No.", 'CBS');
                    until ChqRecLines.Next = 0;
                end;


                //Post New
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                end;



                ChReceiptH."Unpaid By" := UserId;
                ChReceiptH.Unpaid := true;
                ChReceiptH.Modify;
            end;
            ////////

        end;
    end;

    local procedure "***********************************"()
    begin
    end;


    procedure getTransferStandingOrderLines(ElectronicFundsH: Record "RTGS Transfer Header")
    var
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        Text0003: label 'Ensure the Default Bank is set up in User Setup';
        StandingOrdHdr: Record "Standing Order Header";
        StandingOrdLine: Record "Standing Order Lines";
        Text0004: label 'The transaction has already been Processed.';
        ElectronicFundsL: Record "RTGS Transfer Lines";
    begin
        //with ElectronicFundsH do
        begin
            if ElectronicFundsH.Status = ElectronicFundsH.Status::Transferred then
                Error(Text0004);

            ElectronicFundsH.TestField(ElectronicFundsH."Account No.");
            ElectronicFundsH.TestField(ElectronicFundsH."Start Date");
            ElectronicFundsH.TestField(ElectronicFundsH."End Date");

            ElectronicFundsL.Reset;
            ElectronicFundsL.SetRange(ElectronicFundsL."Document No.", ElectronicFundsH."No.");
            ElectronicFundsL.SetFilter(ElectronicFundsL."Standing Order Register No", '<>%1', '');
            if ElectronicFundsL.Find('-') then
                ElectronicFundsL.DeleteAll;

            STORegister.Reset;
            STORegister.SetRange(STORegister.EFT, true);
            STORegister.SetRange(STORegister."Date Processed", ElectronicFundsH."Start Date", ElectronicFundsH."End Date");
            STORegister.SetRange(STORegister."Transfered to EFT", false);
            if STORegister.FindSet() then begin
                repeat
                    StandingOrdLine.Reset;
                    StandingOrdLine.SetRange(StandingOrdLine."Document No.", STORegister."Document No.");
                    StandingOrdLine.SetFilter(StandingOrdLine."Destination Account Type", '%1', StandingOrdLine."destination account type"::"G/L Account");
                    StandingOrdLine.SetFilter(StandingOrdLine."Destination Account No.", ElectronicFundsH."Account No.");
                    if StandingOrdLine.FindSet() then begin
                        repeat
                            if StandingOrdHdr.Get(StandingOrdLine."Document No.") then
                                EntrNo += 1;
                            ElectronicFundsL.Init;
                            ElectronicFundsL.No := '';
                            ElectronicFundsL."Document No." := ElectronicFundsH."No.";
                            ElectronicFundsL."Entered By" := UserId;
                            ElectronicFundsL."Account Type" := StandingOrdHdr."Source Account Type";
                            ElectronicFundsL.Validate(ElectronicFundsL."Account No.", StandingOrdHdr."Source Account No.");
                            ElectronicFundsL."External Account Name" := PadStr(STORegister.Remarks, 50);
                            ElectronicFundsL.Validate(ElectronicFundsL."Don't Charge", false);
                            ElectronicFundsL."Phone No." := '';
                            ElectronicFundsL.Validate(ElectronicFundsL.Amount, StandingOrdLine.Amount);
                            ElectronicFundsL.Validate(ElectronicFundsL."Bank Code", StandingOrdLine."Bank Code");
                            ElectronicFundsL."Branch Code" := StandingOrdLine."Branch Code";
                            ElectronicFundsL."External Account No." := Format(StandingOrdLine."Bank Account No.");
                            ElectronicFundsL."Account Name" := StandingOrdLine."Destination Account Name";
                            ElectronicFundsL."Standing Order Register No" := STORegister."No.";
                            ElectronicFundsL.Insert;
                        until StandingOrdLine.Next = 0;
                    end;
                until STORegister.Next = 0;
            end;
        end;
        StandingOrdLine.Reset;
        StandingOrdLine.SetRange("Document No.", ElectronicFundsL."Standing Order No");
        StandingOrdLine.SetFilter("Destination Account Type", '', StandingOrdLine."destination account type"::"G/L Account");
        if StandingOrdLine.FindFirst then begin
            repeat
                ElectronicFundsL."External Account No." := StandingOrdLine."Bank Account No.";
                ElectronicFundsL.Modify;

            until StandingOrdLine.Next = 0;

        end;
    end;


    procedure ElectronicFundsProcessing(ElectronicFundsH: Record "RTGS Transfer Header")
    var
        Text002: label 'Your application for fund transfer has been effect by ';
        Text003: label 'Follow up using Reference No. ';
        Text004: label 'The transaction has already been Processed.';
        ElectronicFundsL: Record "RTGS Transfer Lines";
        Text005: label 'Destnation account name of staff no %1 more than %2 characters.';
        Text006: label 'Destnation account of staff no %1 more than 14 characters.';
        Text007: label 'Posted successfully.';
        ChargeAmount: Decimal;
        TChargeAmount: Decimal;
        TransactionCharges: Record "Transaction Charges";
        TariffDetails: Record "Tiered Charges Lines";
        TCharges: Decimal;
        FundTransfer: label 'Fund Transfer';
        MobileNo: Code[20];
        CashierTransactions: Record "Cashier Transactions";
        ChargesNet: Decimal;
        Member: record Members;
    begin
        GenSetup.Get();
        TCharges := 0;
        Temp.Get(UserId);
        Temp.TestField(Temp."Cashier Journal Template");
        Temp.TestField(Temp."Cashier Journal Batch");
        Jtemplate := Temp."Cashier Journal Template";
        JBatch := Temp."Cashier Journal Batch";

        GenJLine.Reset;
        GenJLine.SetRange(GenJLine."Journal Template Name", Jtemplate);
        GenJLine.SetRange(GenJLine."Journal Batch Name", JBatch);
        GenJLine.DeleteAll;

        //with ElectronicFundsH do
        begin
            if ElectronicFundsH.Status = ElectronicFundsH.Status::Transferred then
                Error(Text004);
            ElectronicFundsH.CalcFields(ElectronicFundsH."Record Total");

            ElectronicFundsL.Reset;
            ElectronicFundsL.SetRange(ElectronicFundsL."Document No.", ElectronicFundsH."No.");
            if ElectronicFundsL.FindSet() then begin
                repeat
                    ElectronicFundsL.TestField(ElectronicFundsL."Account No.");
                    ElectronicFundsL.TestField(ElectronicFundsL."Account Name");
                    ElectronicFundsL.TestField(ElectronicFundsL.Amount);
                    ElectronicFundsL.TestField(ElectronicFundsL."Bank Code");
                    //ElectronicFundsL.TESTFIELD(ElectronicFundsL."Branch Code");
                    ElectronicFundsL.TestField(ElectronicFundsL."Bank Name");

                    // if StrLen(ElectronicFundsL."Account Name") > GenSetup."EFT Dest Acc Length" then
                    //     Error(Text005, ElectronicFundsL."Account No.", GenSetup."EFT Dest Acc Length");

                    // if StrLen(ElectronicFundsL."External Account No.") > 14 then
                    //     Error(Text006, ElectronicFundsL."External Account No.");

                    if ElectronicFundsL."Standing Order No" <> '' then begin
                        AccNo := GenSetup."External STO Account No.";
                        AccTypes := Acctypes::"G/L Account";

                    end else begin
                        AccNo := ElectronicFundsL."Account No.";
                        AccTypes := Acctypes::Savings;
                    end;

                    //Line Posting
                    ElectronicFundsJournal(Jtemplate, JBatch, Today, ElectronicFundsH."No.", '', AccTypes, AccNo,
                                           PadStr(ElectronicFundsH.Remarks, 50), ElectronicFundsL.Amount, '', '', BalAccountType::"G/L Account", '');

                    //Charge Posting
                    if not ElectronicFundsL."Don't Charge" then begin
                        ChargeAmount := 0;
                        ChargesNet := 0;
                        TransactionCharges.Reset;
                        TransactionCharges.SetRange(TransactionCharges."Transaction Type", ElectronicFundsH."Transaction Type");
                        if TransactionCharges.FindSet() then begin
                            repeat
                                ChargeAmount := 0;
                                if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" then
                                    ChargeAmount += (ElectronicFundsL.Amount * TransactionCharges."Percentage of Amount") * 0.01
                                else
                                    ChargeAmount += TransactionCharges."Charge Amount";

                                if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin
                                    TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");
                                    TariffDetails.Reset;
                                    TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                    if TariffDetails.FindSet() then begin
                                        repeat
                                            if (ChargeAmount >= TariffDetails."Lower Limit") and (ChargeAmount <= TariffDetails."Upper Limit") then begin
                                                if TariffDetails."Use Percentage" then
                                                    ChargeAmount += ElectronicFundsL.Amount * TariffDetails.Percentage * 0.01
                                                else
                                                    ChargeAmount += TariffDetails."Charge Amount";
                                            end;
                                        until TariffDetails.Next = 0;
                                    end;
                                end;
                                //DEBIT ACCOUNT
                                // ElectronicFundsJournal(Jtemplate, JBatch, Today, ElectronicFundsH."No.", '', ElectronicFundsL."Account Type", ElectronicFundsL."Account No.",
                                //                        PadStr(TransactionCharges.Description, 50), ElectronicFundsL."Charge Amount", ElectronicFundsH."Shortcut Dimension 1 Code", ElectronicFundsH."Shortcut Dimension 2 Code", Balaccounttype::"G/L Account", '');
                                // ChargesNet := ChargeAmount;//(ChargeAmount-ElectronicFundsL."Excise Duty")*-1;
                                //Debit Account
                                ElectronicFundsJournal(Jtemplate, JBatch, Today, ElectronicFundsH."No.", '', AccTypes, AccNo,
                                         PadStr('EFT To Account ' + ElectronicFundsL."External Account No." + format(TransactionCharges.Description), 50), ChargeAmount, '', '', BalAccountType::"G/L Account", '');

                                //credit charges acc
                                ElectronicFundsJournal(Jtemplate, JBatch, Today, ElectronicFundsH."No.", '', ElectronicFundsL."account type"::"G/L Account", TransactionCharges."G/L Account",
                                                        PadStr(FundTransfer + ' :- ' + TransactionCharges.Description, 50), ChargeAmount * -1, ElectronicFundsH."Shortcut Dimension 1 Code", ElectronicFundsH."Shortcut Dimension 2 Code", Balaccounttype::"G/L Account", '');

                                // CREDIT Excise Duty GL
                                IF TransactionCharges."Recover Excise Duty" then begin
                                    GenSetup.Get;
                                    ElectronicFundsJournal(Jtemplate, JBatch, Today, ElectronicFundsH."No.", '', ElectronicFundsL."account type"::"G/L Account", GenSetup."Excise Duty G/L",
                                                            PadStr(FundTransfer + ' :- ' + 'Excise Duty', 50), ChargeAmount * -(GenSetup."Excise Duty (%)" / 100), ElectronicFundsH."Shortcut Dimension 1 Code", ElectronicFundsH."Shortcut Dimension 2 Code", Balaccounttype::"G/L Account", '');

                                    ElectronicFundsJournal(Jtemplate, JBatch, Today, ElectronicFundsH."No.", '', AccTypes, AccNo,
                                                            PadStr(FundTransfer + ' :- ' + 'Excise Duty', 50), ChargeAmount * (GenSetup."Excise Duty (%)" / 100), ElectronicFundsH."Shortcut Dimension 1 Code", ElectronicFundsH."Shortcut Dimension 2 Code", Balaccounttype::"G/L Account", '');
                                end;

                            until TransactionCharges.Next = 0;
                            TCharges := ChargeAmount;
                        end;
                        /*
                          //Excise Duty on Charge Posting
                          GenSetup.GET;
                        {  ElectronicFundsJournal(Jtemplate,JBatch,TODAY,ElectronicFundsH."No.",'',ElectronicFundsL."Account Type",ElectronicFundsL."Account No.",
                                                 PADSTR('Excise Duty :- ' + FundTransfer +' - '+ ElectronicFundsL."Account No.",50),TCharges*(GenSetup."Excise Duty (%)"/100),"Shortcut Dimension 1 Code","Shortcut Dimension 2 Code",
                                                 BalAccountType::"G/L Account",GenSetup."Excise Duty G/L");}
                          ElectronicFundsJournal(Jtemplate,JBatch,TODAY,ElectronicFundsH."No.",'',ElectronicFundsL."Account Type"::"G/L Account",{ElectronicFundsL."Account No."}GenSetup."Excise Duty G/L",
                          PADSTR('Excise Duty :- ' + FundTransfer +' - '+ ElectronicFundsL."Account No.",50),ElectronicFundsL."Excise Duty"*-1{TCharges*(GenSetup."Excise Duty (%)"/100)},"Shortcut Dimension 1 Code","Shortcut Dimension 2 Code",
                          BalAccountType::"G/L Account",{GenSetup."Excise Duty G/L"}'');
                          */
                    end;

                    ElectronicFundsJournal(Jtemplate, JBatch, Today, ElectronicFundsH."No.", '', ElectronicFundsH."Account Type", ElectronicFundsH."Account No.",
                                  ElectronicFundsH.Remarks, -ElectronicFundsL.Amount, ElectronicFundsH."Shortcut Dimension 1 Code", ElectronicFundsH."Shortcut Dimension 2 Code", BalAccountType::"G/L Account", '');

                until ElectronicFundsL.Next = 0;
            end;

            //Header Posting

        end;
        GenJLine.Reset;
        GenJLine.SetRange(GenJLine."Journal Template Name", Jtemplate);
        GenJLine.SetRange(GenJLine."Journal Batch Name", JBatch);
        if GenJLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJLine);
        end;

        // Post := false;
        // Post := JournlPosted.PostedSuccessfully;
        // if Post then begin

        ElectronicFundsL.Reset;
        ElectronicFundsL.SetRange(ElectronicFundsL."Document No.", ElectronicFundsH."No.");
        ElectronicFundsL.SetRange(ElectronicFundsL.Transferred, false);
        if ElectronicFundsL.FindSet() then begin
            repeat

                case ElectronicFundsL."Account Type" of
                    ElectronicFundsL."account type"::Savings:
                        begin
                            if SavingsACC.Get(ElectronicFundsL."Account No.") then
                                if SavingsACC."Transactional Mobile No" <> '' then
                                    MobileNo := SavingsACC."Transactional Mobile No"
                                else begin
                                    if Member.Get(SavingsACC."Member No.") then begin
                                        MobileNo := Member."Phone No.";
                                    end;
                                end;

                            msg := Text002 + COMPANYNAME + ', ' + 'of ' + format(ElectronicFundsL.Amount) + '. ' + Text003 + ElectronicFundsH."No.";
                            SendSMS.SendSms(Source::EFT_EFFECTED, MobileNo, msg, Format(ElectronicFundsH."No."), '', true, 0, false, 'CBS', ElectronicFundsH."No.", 'CBS');
                        end;
                end;


                //ElectronicFundsL.Transferred:=TRUE; ElectronicFundsL.MODIFY;

                //* Mark the standing order register has transfered
                STORegister.Reset;
                STORegister.SetRange(STORegister."No.", ElectronicFundsL."Standing Order Register No");
                STORegister.SetRange(STORegister."Transfered to EFT", false);
                if STORegister.Find('-') then begin
                    STORegister."Transfered to EFT" := true;
                    STORegister.Modify;
                end;
                CashierTransactions.Reset;
                CashierTransactions.SetRange("Account No", ElectronicFundsL."Account No.");
                CashierTransactions.SetRange(Amount, (ElectronicFundsL.Amount + ElectronicFundsL."Charge Amount"));
                CashierTransactions.SetRange(Remarks, 'EFT Amount');
                CashierTransactions.SetRange(Payee, ElectronicFundsL."Document No.");
                CashierTransactions.SetRange("Cheque Status", CashierTransactions."cheque status"::Pending);

                if CashierTransactions.FindSet()
                  then begin
                    repeat
                        //ERROR('here');
                        CashierTransactions."Cheque Status" := CashierTransactions."cheque status"::Honoured;
                        CashierTransactions.Modify;
                    until CashierTransactions.Next = 0;
                end
            until ElectronicFundsL.Next = 0;
        end;

        ElectronicFundsH.Status := ElectronicFundsH.Status::Transferred;
        ElectronicFundsH."Date Transferred" := Today;
        ElectronicFundsH."Time Transferred" := Time;
        ElectronicFundsH."Transferred By" := UserId;
        ElectronicFundsH.Modify;


        // end;
        Message(Text007);

    end;


    procedure ElectronicFundsJournal(Jtemplate: Code[10]; JBatch: Code[10]; PostingDate: Date; DocNo: Code[10]; ExtDocNo: Code[10]; AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[20];
                                                                                                                                                     Desc: Text;
                                                                                                                                                     JnlAmount: Decimal;
                                                                                                                                                     GlobalDim1: Code[10];
                                                                                                                                                     GlobalDim2: Code[10];
                                                                                                                                                     BalAccountType: Enum "Gen. Journal Account Type";
                                                                                                                                                     BalAccountNo: Code[20])
    var
        Text0001: label 'Ensure the Cashier Journal Template is set up in Banking User Setup';
        Text0002: label 'Ensure the Cashier Journal Batch is set up in Banking User Setup';
        Text0003: label 'Ensure the Default Bank is set up in User Setup';
    begin
        LineNo += 1;
        GenJLine.Init;
        GenJLine."Journal Template Name" := Jtemplate;
        GenJLine."Journal Batch Name" := JBatch;
        GenJLine."Line No." := LineNo;
        GenJLine."Posting Date" := PostingDate;
        GenJLine."Document No." := DocNo;
        GenJLine."External Document No." := ExtDocNo;
        GenJLine."Account Type" := AccountType;
        GenJLine.Validate(GenJLine."Account No.", AccountNo);
        GenJLine.Description := Desc;
        GenJLine.Validate(GenJLine.Amount, JnlAmount);
        GenJLine.Validate(GenJLine."Shortcut Dimension 1 Code", GlobalDim1);
        GenJLine.Validate(GenJLine."Shortcut Dimension 2 Code", GlobalDim2);
        GenJLine."Bal. Account Type" := BalAccountType;
        GenJLine.Validate(GenJLine."Bal. Account No.", BalAccountNo);
        if GenJLine.Amount <> 0 then
            GenJLine.Insert;
    end;

    procedure GenerateYearSavingsInterest(SavingsInterestHeader: Record "Savings Interest Header")
    var
        InterestBuffer: Record "Savings Interest Buffer";
        SavingsAccounts: Record "Savings Accounts";
        Account: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        diaProgress: Dialog;
        MSGConfirmation: Label 'Confirm interest generation for period starting %1 and ending %2';
        Generating: Label 'Generating Account Interest #1##########';
        Year: Integer;
        Day: Integer;
        Month: Integer;
        TotalAccounts: Integer;
        ProcessedAccounts: Integer;
        ProgressPct: Integer;
    begin
        // Validate header fields
        ValidateInterestHeader(SavingsInterestHeader);

        if not Confirm(MSGConfirmation, true, SavingsInterestHeader."Start Date", SavingsInterestHeader."End Date") then
            exit;

        // Initialize year and day
        Year := Date2DMY(SavingsInterestHeader."End Date", 3);
        Day := 1;
        if Year = 2025 then
            Day := 5;

        // Clear existing buffer entries
        ClearInterestBuffer(SavingsInterestHeader."No.");

        // Validate and get product factory
        if not ProductFactory.Get(SavingsInterestHeader."Product Type") then
            exit;

        ValidateProductFactory(ProductFactory);

        // Process savings accounts

        SavingsAccounts.Reset();
        SavingsAccounts.SetLoadFields("No.", "Product Type", "Balance (LCY)", "Date Filter");
        SavingsAccounts.SetRange("Product Type", SavingsInterestHeader."Product Type");
        TotalAccounts := SavingsAccounts.Count;
        ProcessedAccounts := 0;
        diaProgress.Open(Generating);

        repeat
            ProcessedAccounts += 1;

            ProcessAccountInterest(
                SavingsAccounts,
                SavingsInterestHeader,
                ProductFactory,
                Year,
                Day
            );

            // Update progress every 10 accounts or every second
            if (ProcessedAccounts mod 10 = 0) or (ProcessedAccounts = TotalAccounts) then begin
                ProgressPct := Round(ProcessedAccounts / TotalAccounts * 100, 1);
                diaProgress.Update(1, ProgressPct);
            end;
        until SavingsAccounts.Next() = 0;

        diaProgress.Close();
        Message('Interest generation completed successfully!');
    end;

    local procedure ValidateInterestHeader(var Header: Record "Savings Interest Header")
    begin
        Header.TestField(Posted, false);
        Header.TestField("Start Date");
        Header.TestField("End Date");
        Header.TestField(Description);
        Header.TestField("Responsibility Center");
        Header.TestField("Shortcut Dimension 1 Code");
        Header.TestField("Document No.");
        Header.TestField("Shortcut Dimension 2 Code");
        Header.TestField("Product Type");
    end;

    local procedure ClearInterestBuffer(DocumentNo: Code[20])
    var
        InterestBuffer: Record "Savings Interest Buffer";
    begin
        InterestBuffer.SetRange(no, DocumentNo);
        InterestBuffer.DeleteAll();
    end;

    local procedure ValidateProductFactory(var Product: Record "Product Factory")
    begin
        Product.TestField("Product Class Type", Product."Product Class Type"::Savings);
        Product.TestField("Interest Expense Account");
        Product.TestField("Interest Payable Account");
        Product.TestField(Status, Product.Status::Active);

        if Product."Interest Rate (Min.)" <= 0 then
            Error('Product %1 must have a minimum interest rate to compute!', Product."Product ID");
    end;



    local procedure ProcessAccountInterest(
        var SavingsAccount: Record "Savings Accounts";
        var Header: Record "Savings Interest Header";
        var Product: Record "Product Factory";
        Year: Integer;
        StartDay: Integer)
    var
        Month: Integer;
        TotalAccruedInt: Decimal;
    begin
        TotalAccruedInt := 0;

        for Month := 1 to 12 do begin
            ProcessMonthlyInterest(
                SavingsAccount,
                Header,
                Product,
                Year,
                Month,
                StartDay,
                TotalAccruedInt
            );
        end;
    end;

    local procedure ProcessMonthlyInterest(
        var SavingsAccount: Record "Savings Accounts";
        var Header: Record "Savings Interest Header";
        var Product: Record "Product Factory";
        Year: Integer;
        Month: Integer;
        StartDay: Integer;
        var TotalAccruedInt: Decimal)
    var
        LowestBal: Decimal;
        AccruedInt: Decimal;
        StartDate: Date;
    begin
        StartDate := DMY2Date(StartDay, Month, Year);

        // Check if account qualifies for interest
        if not AccountQualifiesForInterest(SavingsAccount."No.", Month, Year, Product."Interest Calc Min Balance") then
            exit;

        // Calculate lowest balance for the month
        LowestBal := CalculateLowestMonthlyBalance(
            SavingsAccount."No.",
            StartDate,
            Product."Interest Calc Min Balance"
        );

        if LowestBal <= 0 then
            exit;

        // Calculate and save interest
        AccruedInt := Round(LowestBal * (Product."Interest Rate (Min.)" / 100) / 12, 0.01, '=');

        if AccruedInt <> 0 then begin
            CreateInterestBufferEntry(
                SavingsAccount,
                Header,
                Product,
                LowestBal,
                AccruedInt,
                CalcDate('CM', StartDate)
            );
            TotalAccruedInt += AccruedInt;
        end;
    end;

    local procedure AccountQualifiesForInterest(
        AccountNo: Code[20];
        Month: Integer;
        Year: Integer;
        MinBalance: Decimal): Boolean
    var
        Account: Record "Savings Accounts";
        CheckDates: array[3] of Date;
        i: Integer;
    begin
        // Check balances on 1st, 15th, and last day of month
        CheckDates[1] := DMY2Date(1, Month, Year);
        CheckDates[2] := DMY2Date(15, Month, Year);
        CheckDates[3] := CalcDate('CM', CheckDates[1]);

        for i := 1 to 3 do begin
            Account.Reset();
            Account.SetLoadFields("Date Filter", "Balance (LCY)");
            Account.SetRange("No.", AccountNo);
            Account.SetFilter("Date Filter", '..%1', CheckDates[i]);
            Account.SetFilter("Balance (LCY)", '<%1', MinBalance);

            if Account.FindFirst() then
                exit(false);
        end;

        exit(true);
    end;

    local procedure CalculateLowestMonthlyBalance(
        AccountNo: Code[20];
        StartDate: Date;
        MinBalance: Decimal): Decimal
    var
        Account: Record "Savings Accounts";
        CurrentDate: Date;
        EndDate: Date;
        CurrentBal: Decimal;
        LowestBal: Decimal;
        IsFirstDay: Boolean;
    begin
        LowestBal := 0;
        CurrentDate := StartDate;
        EndDate := CalcDate('CM', StartDate);
        IsFirstDay := true;

        while CurrentDate <= EndDate do begin
            Account.Reset();
            Account.SetLoadFields("Date Filter", "Balance (LCY)");
            Account.SetRange("No.", AccountNo);
            Account.SetFilter("Date Filter", '..%1', CurrentDate);

            if Account.FindFirst() then begin
                Account.CalcFields("Balance (LCY)");
                CurrentBal := Account."Balance (LCY)";

                if IsFirstDay then begin
                    LowestBal := CurrentBal;
                    IsFirstDay := false;
                end else if CurrentBal < LowestBal then
                        LowestBal := CurrentBal;

                // Early exit if balance drops below minimum
                if LowestBal < MinBalance then
                    exit(0);
            end;

            CurrentDate += 1;
        end;

        exit(LowestBal);
    end;

    procedure CreateInterestBufferEntry(
       var SavingsAccount: Record "Savings Accounts";
       var Header: Record "Savings Interest Header";
       var Product: Record "Product Factory";
       Balance: Decimal;
       InterestAmount: Decimal;
       InterestDate: Date)
    var
        InterestBuffer: Record "Savings Interest Buffer";
    begin
        InterestBuffer.Init();
        InterestBuffer.No := Header."No.";
        InterestBuffer."Account No" := SavingsAccount."No.";
        InterestBuffer.Name := SavingsAccount.Name;
        InterestBuffer."Account Type" := InterestBuffer."Account Type"::Savings;
        InterestBuffer."Bal. Account Type" := InterestBuffer."Bal. Account Type"::"G/L Account";
        InterestBuffer."Payable Account" := Product."Interest Payable Account";
        InterestBuffer."Expense Account" := Product."Interest Expense Account";
        InterestBuffer."Account Balance" := Balance;
        InterestBuffer."Interest Date" := InterestDate;
        InterestBuffer."Interest Amount" := InterestAmount;
        InterestBuffer.Blocked := SavingsAccount.Blocked;
        InterestBuffer.Description := Header.Description;
        InterestBuffer."Interest Rate" := Product."Interest Rate (Min.)";
        InterestBuffer."Product Factory Code" := Product."Product ID";
        InterestBuffer."Shortcut Dimension 1 Code" := SavingsAccount."Global Dimension 1 Code";
        InterestBuffer."Shortcut Dimension 2 Code" := SavingsAccount."Global Dimension 2 Code";
        //InterestBuffer."User ID" := UserId();
        InterestBuffer.Insert(true);
        Commit();
    end;


    procedure GenerateSavingssInterest(SavingsInterestHeader: Record "Savings Interest Header")
    var
        InterestBuffer: Record "Savings Interest Buffer";
        InterestBuffer2: Record "Savings Interest Buffer";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        PeriodicActivities: Codeunit "Periodic Activities";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        SavingsAccounts: Record "Savings Accounts";
        // FromDateS: Text[100];
        Datefilter2: Text[100];
        DateFilter: Text[100];
        ProductFactory: Record "Product Factory";
        ProductFactoryCode: Code[20];
        InterestRate: Decimal;
        PayableAccount: Code[20];
        ExpenseAccount: Code[20];
        BankingUserTemplate: Record "Banking User Template";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        JTemp: Code[20];
        JBatch: Code[20];
        PageEditable: Boolean;
        Members: Record Members;
        ErrNotApproved: label 'This document has not been approved';
        ErrNoEntries: label 'This Document has no Lines to post';
        MSGEntriesGenerated: label 'Entries Generated Successfully';
        MSGConfirmation: label 'Confirm interest Generation for period starting %1 and Ending %2';
        ErrPosted: label 'This document has already been posted';
        IntDays: Integer;
        BalAccount: Record "Savings Accounts";
        Bal: Decimal;
        Account: Record "Savings Accounts";
        // IntRate: Decimal;
        LowestBal: Decimal;
        MinBal: Boolean;
        RIntDays: Integer;
        AsAt: Date;
        StartDate: Date;
        AccruedInt: Decimal;
        Turn: Integer;
        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Generating Acc. Interest';
        diaProgress: Dialog;
        intProgress: Integer;
        Counter1: Integer;
        GeneratingDividends: label 'Generating Interest :';
        Counter2: Integer;
        PercentComplete: Decimal;
        MonthDays: Integer;
    begin
        SavingsInterestHeader.TestField(Posted, false);
        SavingsInterestHeader.TestField("Start Date");
        SavingsInterestHeader.TestField("End Date");
        SavingsInterestHeader.TestField(Description);
        SavingsInterestHeader.TestField("Responsibility Center");
        SavingsInterestHeader.TestField("Shortcut Dimension 1 Code");
        SavingsInterestHeader.TestField("Document No.");
        SavingsInterestHeader.TestField("Shortcut Dimension 2 Code");
        SavingsInterestHeader.TestField("Product Type");
        AsAt := SavingsInterestHeader."Start Date";
        //Turn:=0;
        IntDays := 0;
        RIntDays := 0;
        MonthDays := 0;

        if not Confirm(MSGConfirmation, true, SavingsInterestHeader."Start Date", SavingsInterestHeader."End Date") then
            exit;
        //Delete entries
        InterestBuffer2.Reset;
        InterestBuffer2.SetRange(InterestBuffer2.No, SavingsInterestHeader."No.");
        if InterestBuffer2.Find('-') then
            InterestBuffer2.DeleteAll;

        DateFilter := '..' + Format(SavingsInterestHeader."End Date");
        MonthDays := (CalcDate('<CM>', SavingsInterestHeader."Start Date") - SavingsInterestHeader."Start Date") + 1;
        SavingsAccounts.Reset;
        SavingsAccounts.SetCurrentKey("No.");
        SavingsAccounts.SetFilter(SavingsAccounts."Date Filter", DateFilter);
        if SavingsInterestHeader."Product Type" <> '' then
            SavingsAccounts.SetRange("Product Type", SavingsInterestHeader."Product Type");

        SavingsAccounts.SetAutoCalcFields(SavingsAccounts."Balance (LCY)");
        if SavingsAccounts.FindSet() then begin
            // % Progress:
            intProgressTotal := SavingsAccounts.COUNT;

            intProgressI := 0;
            TimeProgress := TIME;
            NoOfRecsProgress := intProgressTotal DIV 100;
            NoOfProgressed := 0;

            diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
            repeat
                if ProductFactory.Get(SavingsAccounts."Product Type") then begin//Product Found
                    ProductFactoryCode := ProductFactory."Product ID";
                    if (ProductFactory."Product Class Type" = ProductFactory."product class type"::Savings) //and (ProductFactory."Product Category" = ProductFactory."product category"::" ")
                      and (ProductFactory."Earns Interest" = true) and (ProductFactory.Status = ProductFactory.Status::Active) and (ProductFactory."Product Category" <> ProductFactory."Product Category"::"Fixed Deposit") then begin
                        ProductFactory.testfield("Interest Expense Account");
                        ProductFactory.TestField("Interest Payable Account");
                        if ProductFactory."Interest Rate (Min.)" <= 0 then error('The Product %1 must have min interest rate to compute!', ProductFactory."Product ID");
                        // SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)");
                        if SavingsAccounts."Balance (LCY)" > 0 then begin//BAL>0
                            Turn := 0;
                            IntDays := (SavingsInterestHeader."End Date" - SavingsInterestHeader."Start Date") + 1;
                            RIntDays := IntDays;
                            LowestBal := 0;
                            Bal := 0;

                            InterestRate := ProductFactory."Interest Rate (Min.)";
                            PayableAccount := ProductFactory."Interest Payable Account";
                            ExpenseAccount := ProductFactory."Interest Expense Account";
                            Datefilter2 := '';
                            AsAt := SavingsInterestHeader."Start Date";
                            repeat
                                RIntDays := RIntDays - 1;
                                Datefilter2 := '..' + Format(AsAt);
                                // MESSAGE(DateFilter);
                                Account.Reset;
                                Account.setcurrentkey("No.");
                                Account.SetRange(Account."No.", SavingsAccounts."No.");
                                Account.SetFilter(Account."Date Filter", Datefilter2);
                                if Account.Find('-') then begin//Account found
                                    Account.CalcFields(Account."Net Change (LCY)", Account."Balance (LCY)");
                                    Bal := Account."Balance (LCY)";
                                    // Account balance
                                    if Account."Balance (LCY)" >= ProductFactory."Interest Calc Min Balance" then begin // Balalnce is greater then bal in Product

                                        if Turn = 0 then begin
                                            LowestBal := Bal//Account."Net Change (LCY)"
                                        end
                                        else
                                            if LowestBal > Bal then
                                                LowestBal := Bal
                                    end;
                                end;
                                Turn += 1;
                                AsAt := CalcDate('1D', AsAt);

                                if LowestBal = 0 then
                                    break;
                            until RIntDays = 0;
                            if LowestBal > 0 then begin
                                InterestBuffer.Init;
                                InterestBuffer.No := SavingsInterestHeader."No.";
                                InterestBuffer."Account No" := SavingsAccounts."No.";
                                InterestBuffer.Name := SavingsAccounts.Name;
                                InterestBuffer."Account Type" := InterestBuffer."account type"::Savings;
                                InterestBuffer."Bal. Account Type" := InterestBuffer."bal. account type"::"G/L Account";
                                InterestBuffer."Payable Account" := PayableAccount;
                                InterestBuffer."Expense Account" := ExpenseAccount;
                                InterestBuffer."Account Balance" := LowestBal;//SavingsAccounts.Balance;
                                InterestBuffer.Blocked := SavingsAccounts.Blocked;
                                InterestBuffer.Description := SavingsInterestHeader.Description;
                                InterestBuffer."Interest Date" := CalcDate('<CM>', SavingsInterestHeader."Start Date");
                                InterestBuffer."Interest Rate" := InterestRate;
                                InterestBuffer."Interest Amount" := (LowestBal - ProductFactory."Interest Calc Min Balance") * (InterestRate / 100) * (MonthDays / 365);
                                InterestBuffer."Product Factory Code" := ProductFactoryCode;
                                if Members.Get(SavingsAccounts."Member No.") then begin
                                    InterestBuffer."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";//SavingsAccounts."Global Dimension 1 Code";
                                    InterestBuffer."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";//SavingsAccounts."Global Dimension 2 Code";
                                end;
                                InterestBuffer."User ID" := UserId;
                                if InterestBuffer."Interest Amount" <> 0 then
                                    InterestBuffer.Insert(true);
                            end;
                        end;//BAL>0
                    end;//end of prime account
                end;//End of Product Factory

                // DialogContinue
                intProgressI += 1;

                IF (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) THEN BEGIN
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := TIME;
                END;

            until SavingsAccounts.Next = 0;
        end;
        diaProgress.Close;
        Message(MSGEntriesGenerated);
    end;

    procedure PostSavingsInterest(SavingsInterestHeader: Record "Savings Interest Header")
    var
        InterestBuffer: Record "Savings Interest Buffer";
        InterestBuffer2: Record "Savings Interest Buffer";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        PeriodicActivities: Codeunit "Periodic Activities";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        SavingsAccounts: Record "Savings Accounts";
        FromDateS: Text[100];
        ToDateS: Text[100];
        DateFilter: Text[100];
        ProductFactory: Record "Product Factory";
        ProductFactoryCode: Code[20];
        InterestRate: Decimal;
        PayableAccount: Code[20];
        ExpenseAccount: Code[20];
        BankingUserTemplate: Record "Banking User Template";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        JTemp: Code[20];
        JBatch: Code[20];
        PageEditable: Boolean;
        Members: Record Members;
        ErrNotApproved: label 'This document has not been approved';
        ErrNoEntries: label 'This Document has no Lines to post';
        MSGEntriesGenerated: label 'Entries Generated Successfully';
        MSGConfirmation: label 'Confirm interest Generation for period starting %1 and Ending %2';
        ErrPosted: label 'This document has already been posted';
    begin

        if not Confirm('Do you want to post the journal lines?') = true then exit;
        begin
            if Posted = true then
                Error(ErrPosted);
            if SavingsInterestHeader.Status <> SavingsInterestHeader.Status::Approved then
                Error(ErrNotApproved);
            SavingsInterestHeader.CalcFields("Distributed Amount");
            if SavingsInterestHeader."Distributed Amount" = 0 then
                Error(ErrNoEntries);
            if BankingUserTemplate.Get(UserId) then begin
                BankingUserTemplate.Testfield("Interest Account Template");
                BankingUserTemplate.Testfield("Interest Account Batch");

                JTemp := BankingUserTemplate."Interest Account Template";
                JBatch := BankingUserTemplate."Interest Account Batch";
            end;

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", JTemp);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            GenJournalLine.DeleteAll(true);

            InterestBuffer.Reset;
            InterestBuffer.SetRange(InterestBuffer.No, SavingsInterestHeader."No.");
            InterestBuffer.setrange(posted, false);
            if InterestBuffer.Findset() then begin
                repeat
                    GenJournalLine.SetRange("Journal Template Name", JTemp);
                    GenJournalLine.SetRange("Journal Batch Name", JBatch);
                    GenJournalLine.DeleteAll(true);
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := JTemp;
                    GenJournalLine."Journal Batch Name" := JBatch;
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := InterestBuffer."Expense Account";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := SavingsInterestHeader."Document No.";
                    GenJournalLine."Posting Date" := SavingsInterestHeader."Posting Date";
                    GenJournalLine.Description := SavingsInterestHeader.Description;
                    GenJournalLine.Amount := InterestBuffer."Interest Amount";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := InterestBuffer."Payable Account";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := InterestBuffer."Shortcut Dimension 1 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine."Shortcut Dimension 2 Code" := InterestBuffer."Shortcut Dimension 2 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Post New
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", JTemp);
                    GenJournalLine.SetRange("Journal Batch Name", JBatch);
                    if GenJournalLine.Findset() then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                    end;
                    InterestBuffer.Posted := true;
                    InterestBuffer.Modify();
                    Commit();
                until InterestBuffer.Next = 0;
            end;



            SavingsInterestHeader.Posted := true;
            InterestBuffer.Posted := true;
            SavingsInterestHeader."Posted By" := UserId;
            SavingsInterestHeader."Posting Date" := Today;
            SavingsInterestHeader.Modify;
            Message('Posted Successfully');
        end;
    end;


    procedure GenerateEndYearInterest(EndYearTransferHeader: Record "End Year Transfer Header")
    var
        InterestBuffer: Record "End Year Interest Buffer";
        InterestBuffer2: Record "End Year Interest Buffer";
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        Members: Record Members;
        SavingsInterestBuffer: Record "Savings Interest Buffer";
        IntEarned: Decimal;
        ErrNotApproved: Label 'This document has not been approved';
        ErrNoEntries: Label 'This Document has no Lines to post';
        MSGEntriesGenerated: Label 'Entries Generated Successfully';
        MSGConfirmation: Label 'Confirm interest Generation for period starting %1 and Ending %2';
        ErrPosted: Label 'This document has already been posted';
    begin
        // Validate header fields
        ValidateEndYearTransferHeader(EndYearTransferHeader);

        // Confirm with user
        if not Confirm(MSGConfirmation, true, EndYearTransferHeader."Start Date", EndYearTransferHeader."End Date") then
            exit;

        // Check if already posted and delete existing entries
        if EndYearTransferHeader.Posted then
            Error(ErrPosted);

        DeleteExistingInterestEntries(EndYearTransferHeader."No.");

        // Get and validate product factory
        if not ProductFactory.Get(EndYearTransferHeader."Product Type") then
            exit;

        ValidateProductFactory(ProductFactory);

        // Process savings accounts
        ProcessSavingsAccountsInterest(EndYearTransferHeader, ProductFactory);

        Message(MSGEntriesGenerated);
    end;

    local procedure ValidateEndYearTransferHeader(var EndYearTransferHeader: Record "End Year Transfer Header")
    begin
        EndYearTransferHeader.TestField("Start Date");
        EndYearTransferHeader.TestField("End Date");
        EndYearTransferHeader.TestField(Description);
        EndYearTransferHeader.TestField("Responsibility Center");
        EndYearTransferHeader.TestField("Shortcut Dimension 1 Code");
        EndYearTransferHeader.TestField("Document No.");
        EndYearTransferHeader.TestField("Shortcut Dimension 2 Code");
    end;

    local procedure DeleteExistingInterestEntries(DocumentNo: Code[20])
    var
        InterestBuffer: Record "End Year Interest Buffer";
    begin
        InterestBuffer.Reset();
        InterestBuffer.SetRange(No, DocumentNo);
        if not InterestBuffer.IsEmpty() then
            InterestBuffer.DeleteAll();
    end;

    local procedure ProcessSavingsAccountsInterest(EndYearTransferHeader: Record "End Year Transfer Header"; ProductFactory: Record "Product Factory")
    var
        SavingsAccounts: Record "Savings Accounts";
        InterestBuffer: Record "End Year Interest Buffer";
        IntEarned: Decimal;
    begin
        SavingsAccounts.Reset();
        SavingsAccounts.SetLoadFields("No.", "Product Type", "Balance (LCY)");
        SavingsAccounts.SetRange("Product Type", EndYearTransferHeader."Product Type");
        SavingsAccounts.SetAutoCalcFields("Balance (LCY)");

        if SavingsAccounts.FindSet() then
            repeat
                IntEarned := CalculateAccountInterest(
                    SavingsAccounts."No.",
                    EndYearTransferHeader."Start Date",
                    EndYearTransferHeader."End Date"
                );

                if IntEarned <> 0 then
                    CreateInterestBufferEntry(
                        SavingsAccounts,
                        EndYearTransferHeader,
                        ProductFactory,
                        IntEarned
                    );
            until SavingsAccounts.Next() = 0;
    end;

    local procedure CalculateAccountInterest(AccountNo: Code[20]; StartDate: Date; EndDate: Date): Decimal
    var
        SavingsInterestBuffer: Record "Savings Interest Buffer";
    begin
        SavingsInterestBuffer.SetCurrentKey("Account No", "Interest Date");
        SavingsInterestBuffer.SetRange("Account No", AccountNo);
        SavingsInterestBuffer.SetRange("Interest Date", StartDate, EndDate);
        SavingsInterestBuffer.setrange(posted, true);
        SavingsInterestBuffer.CalcSums("Interest Amount");
        exit(SavingsInterestBuffer."Interest Amount");
    end;

    local procedure CreateInterestBufferEntry(
        SavingsAccounts: Record "Savings Accounts";
        EndYearTransferHeader: Record "End Year Transfer Header";
        ProductFactory: Record "Product Factory";
        IntEarned: Decimal)
    var
        InterestBuffer: Record "End Year Interest Buffer";
        Members: Record Members;
    begin
        InterestBuffer.Init();
        InterestBuffer."Account No" := SavingsAccounts."No.";
        InterestBuffer."Account Type" := InterestBuffer."account type"::Savings;
        InterestBuffer."Account Balance" := SavingsAccounts."Balance (LCY)";
        InterestBuffer."Bal. Account Type" := InterestBuffer."bal. account type"::"G/L Account";
        InterestBuffer.Blocked := SavingsAccounts.Blocked;
        InterestBuffer.Description := EndYearTransferHeader.Description;
        InterestBuffer."Interest Amount" := IntEarned;
        InterestBuffer.Wtax := round((IntEarned * (ProductFactory."WithHolding Tax" / 100)), 0.01, '=');
        InterestBuffer."Net Interest" := IntEarned - InterestBuffer.Wtax;
        InterestBuffer."Interest Date" := EndYearTransferHeader."End Date";
        InterestBuffer.Name := SavingsAccounts.Name;
        InterestBuffer.No := EndYearTransferHeader."No.";
        InterestBuffer."Payable Account" := ProductFactory."Interest Payable Account";
        InterestBuffer."Product Factory Code" := SavingsAccounts."Product Type";
        InterestBuffer."User ID" := UserId();

        // Set dimensions from member record
        if Members.Get(SavingsAccounts."Member No.") then begin
            InterestBuffer."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
            InterestBuffer."Shortcut Dimension 2 Code" := Members."Global Dimension 2 Code";
        end;

        InterestBuffer.Insert(true);
    end;

    procedure PostEndYearInterest(EndYearTransferHeader: Record "End Year Transfer Header")
    var
        InterestBuffer: Record "End Year Interest Buffer";
        InterestBuffer2: Record "End Year Interest Buffer";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        PeriodicActivities: Codeunit "Periodic Activities";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        SavingsAccounts: Record "Savings Accounts";
        FromDateS: Text[100];
        ToDateS: Text[100];
        DateFilter: Text[100];
        ProductFactory: Record "Product Factory";
        ProductFactoryCode: Code[20];
        InterestRate: Decimal;
        PayableAccount: Code[20];
        ExpenseAccount: Code[20];
        BankingUserTemplate: Record "Banking User Template";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        JTemp: Code[20];
        JBatch: Code[20];
        PageEditable: Boolean;
        Members: Record Members;
        SavingsInterestBuffer: Record "Savings Interest Buffer";
        IntEarned: Decimal;
        ErrNotApproved: label 'This document has not been approved';
        ErrNoEntries: label 'This Document has no Lines to post';
        MSGEntriesGenerated: label 'Entries Generated Successfully';
        MSGConfirmation: label 'Confirm interest Generation for period starting %1 and Ending %2';
        ErrPosted: label 'This document has already been posted';
        MSGPostedSuccessfully: label 'Posted Successfully.';
        Sav: Record "Savings Accounts";
        Blocked: boolean;
        BlockedEntr: Option " ",Credit,Debit,All;
        FosaAcc: record "Savings Accounts";
    begin
        if EndYearTransferHeader.Status <> EndYearTransferHeader.Status::Approved then
            Error(ErrNotApproved);
        if Posted = true then
            Error(ErrPosted);
        EndYearTransferHeader.CalcFields("Distributed Amount");
        if EndYearTransferHeader."Distributed Amount" = 0 then
            Error(ErrNoEntries);
        if BankingUserTemplate.Get(UserId) then begin
            BankingUserTemplate.TestField("Interest Account Template");
            BankingUserTemplate.TestField("Interest Account Batch");

            JTemp := BankingUserTemplate."Interest Account Template";
            JBatch := BankingUserTemplate."Interest Account Batch";
        end;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", JTemp);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        if GenJournalLine.Find('-') then
            GenJournalLine.DeleteAll;

        InterestBuffer.Reset;
        InterestBuffer.SetRange(InterestBuffer.No, EndYearTransferHeader."No.");
        InterestBuffer.setrange(posted, false);
        if InterestBuffer.FindSet() then begin
            repeat
                Blocked := false;
                BlockedEntr := BlockedEntr::" ";
                if Sav.get(InterestBuffer."Account No") then begin
                    Sav.CalcFields("Balance (LCY)");
                    // FosaAcc.Reset();
                    // FosaAcc.SetRange("Member No.", Sav."Member No.");
                    // FosaAcc.setrange("Product Type", '191');
                    // if FosaAcc.Find('-') then begin
                    //     if FosaAcc.Blocked <> FosaAcc.Blocked::" " then begin
                    //         Blocked := true;
                    //         BlockedEntr := FosaAcc.Blocked;
                    //         FosaAcc.Blocked := FosaAcc.Blocked::" ";
                    //         FosaAcc.modify;
                    //     end;
                    //     //Credit Account
                    //     LineNo := LineNo + 10000;
                    //     GenJournalLine.Init;
                    //     GenJournalLine."Journal Template Name" := JTemp;
                    //     GenJournalLine."Journal Batch Name" := JBatch;
                    //     GenJournalLine."Line No." := LineNo;
                    //     GenJournalLine."Account Type" := InterestBuffer."Account Type"::Savings;
                    //     GenJournalLine."Account No." := FosaAcc."No.";
                    //     GenJournalLine.Validate(GenJournalLine."Account No.");
                    //     GenJournalLine."Document No." := EndYearTransferHeader."Document No.";
                    //     GenJournalLine."Posting Date" := EndYearTransferHeader."Posting Date";
                    //     GenJournalLine.Description := EndYearTransferHeader.Description;
                    //     GenJournalLine.Amount := -InterestBuffer."Interest Amount";
                    //     GenJournalLine.Validate(GenJournalLine.Amount);
                    //     GenJournalLine."Bal. Account Type" := InterestBuffer."Bal. Account Type";
                    //     GenJournalLine."Bal. Account No." := InterestBuffer."Payable Account";
                    //     GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    //     GenJournalLine."Shortcut Dimension 1 Code" := InterestBuffer."Shortcut Dimension 1 Code";
                    //     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    //     GenJournalLine."Shortcut Dimension 2 Code" := InterestBuffer."Shortcut Dimension 2 Code";
                    //     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    //     if GenJournalLine.Amount <> 0 then
                    //         GenJournalLine.Insert;

                    //     //Withholding Tax
                    //     ProductFactory.Get(InterestBuffer."Product Factory Code");

                    //     // if Sav."Member No." = '' then Error('Member No. is blank for Account No. %1, Please correct this before posting.', Sav."No.");
                    //     // Memb.Reset;
                    //     // Memb.SetRange("No.", Sav."Member No.");
                    //     // // Memb.SetRange(exc);
                    //     // if Memb.Find('-') then begin

                    //     LineNo := LineNo + 10000;
                    //     GenJournalLine.Init;
                    //     GenJournalLine."Journal Template Name" := JTemp;
                    //     GenJournalLine."Journal Batch Name" := JBatch;
                    //     GenJournalLine."Line No." := LineNo;
                    //     GenJournalLine."Account Type" := InterestBuffer."Account Type"::Savings;
                    //     GenJournalLine."Account No." := FosaAcc."No.";
                    //     GenJournalLine.Validate(GenJournalLine."Account No.");
                    //     GenJournalLine."Document No." := EndYearTransferHeader."Document No.";
                    //     GenJournalLine."Posting Date" := EndYearTransferHeader."Posting Date";
                    //     GenJournalLine.Description := 'Wtax on interest.';
                    //     ProductFactory.Get(InterestBuffer."Product Factory Code");
                    //     GenJournalLine.Amount := Round((InterestBuffer."Interest Amount" * (ProductFactory."WithHolding Tax" / 100)), 0.01, '=');
                    //     GenJournalLine.Validate(GenJournalLine.Amount);
                    //     GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    //     GenJournalLine."Bal. Account No." := ProductFactory."Withholding Tax Account";
                    //     GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    //     GenJournalLine."Shortcut Dimension 1 Code" := InterestBuffer."Shortcut Dimension 1 Code";
                    //     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    //     GenJournalLine."Shortcut Dimension 2 Code" := InterestBuffer."Shortcut Dimension 2 Code";
                    //     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    //     if GenJournalLine.Amount <> 0 then begin
                    //         ProductFactory.TestField("Withholding Tax Account");
                    //         GenJournalLine.Insert;
                    //     end;


                    //     //take funds to ODS
                    //     LineNo := LineNo + 10000;
                    //     GenJournalLine.Init;
                    //     GenJournalLine."Journal Template Name" := JTemp;
                    //     GenJournalLine."Journal Batch Name" := JBatch;
                    //     GenJournalLine."Line No." := LineNo;
                    //     GenJournalLine."Account Type" := InterestBuffer."Account Type"::Savings;
                    //     GenJournalLine."Account No." := Sav."No.";
                    //     GenJournalLine.Validate(GenJournalLine."Account No.");
                    //     GenJournalLine."Document No." := EndYearTransferHeader."Document No.";
                    //     GenJournalLine."Posting Date" := EndYearTransferHeader."Posting Date";
                    //     GenJournalLine.Description := EndYearTransferHeader.Description;
                    //     ProductFactory.Get(InterestBuffer."Product Factory Code");
                    //     GenJournalLine.Amount := Sav."Balance (LCY)";
                    //     GenJournalLine.Validate(GenJournalLine.Amount);
                    //     GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    //     GenJournalLine."Bal. Account No." := '';
                    //     GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    //     GenJournalLine."Shortcut Dimension 1 Code" := InterestBuffer."Shortcut Dimension 1 Code";
                    //     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    //     GenJournalLine."Shortcut Dimension 2 Code" := InterestBuffer."Shortcut Dimension 2 Code";
                    //     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    //     if GenJournalLine.Amount <> 0 then begin
                    //         ProductFactory.TestField("Withholding Tax Account");
                    //         GenJournalLine.Insert;
                    //     end;

                    //     LineNo := LineNo + 10000;
                    //     GenJournalLine.Init;
                    //     GenJournalLine."Journal Template Name" := JTemp;
                    //     GenJournalLine."Journal Batch Name" := JBatch;
                    //     GenJournalLine."Line No." := LineNo;
                    //     GenJournalLine."Account Type" := InterestBuffer."Account Type"::Savings;
                    //     GenJournalLine."Account No." := FosaAcc."No.";
                    //     GenJournalLine.Validate(GenJournalLine."Account No.");
                    //     GenJournalLine."Document No." := EndYearTransferHeader."Document No.";
                    //     GenJournalLine."Posting Date" := EndYearTransferHeader."Posting Date";
                    //     GenJournalLine.Description := EndYearTransferHeader.Description;
                    //     ProductFactory.Get(InterestBuffer."Product Factory Code");
                    //     GenJournalLine.Amount := -Sav."Balance (LCY)";
                    //     GenJournalLine.Validate(GenJournalLine.Amount);
                    //     GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    //     GenJournalLine."Bal. Account No." := '';
                    //     GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    //     GenJournalLine."Shortcut Dimension 1 Code" := InterestBuffer."Shortcut Dimension 1 Code";
                    //     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    //     GenJournalLine."Shortcut Dimension 2 Code" := InterestBuffer."Shortcut Dimension 2 Code";
                    //     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    //     if GenJournalLine.Amount <> 0 then begin
                    //         ProductFactory.TestField("Withholding Tax Account");
                    //         GenJournalLine.Insert;
                    //     end;
                    //     // end;
                    //     //Post New
                    //     GenJournalLine.Reset;
                    //     GenJournalLine.SetRange("Journal Template Name", JTemp);
                    //     GenJournalLine.SetRange("Journal Batch Name", JBatch);
                    //     if GenJournalLine.Find('-') then begin
                    //         Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                    //     end;
                    //     //return block
                    //     if Blocked then begin
                    //         FosaAcc.Blocked := BlockedEntr;
                    //         FosaAcc.modify;
                    //     end;
                    // end
                    // else begin

                    BlockedEntr := BlockedEntr::" ";
                    if Sav.Blocked <> Sav.Blocked::" " then begin
                        Blocked := true;
                        BlockedEntr := Sav.Blocked;
                        Sav.Blocked := Sav.Blocked::" ";
                        Sav.modify;
                    end;
                    //Credit Account
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := JTemp;
                    GenJournalLine."Journal Batch Name" := JBatch;
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := InterestBuffer."Account Type"::Savings;
                    GenJournalLine."Account No." := Sav."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := EndYearTransferHeader."Document No.";
                    GenJournalLine."Posting Date" := EndYearTransferHeader."Posting Date";
                    GenJournalLine.Description := EndYearTransferHeader.Description;
                    GenJournalLine.Amount := -InterestBuffer."Interest Amount";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := InterestBuffer."Bal. Account Type";
                    GenJournalLine."Bal. Account No." := InterestBuffer."Payable Account";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := InterestBuffer."Shortcut Dimension 1 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine."Shortcut Dimension 2 Code" := InterestBuffer."Shortcut Dimension 2 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Withholding Tax
                    ProductFactory.Get(InterestBuffer."Product Factory Code");

                    // if Sav."Member No." = '' then Error('Member No. is blank for Account No. %1, Please correct this before posting.', Sav."No.");
                    // Memb.Reset;
                    // Memb.SetRange("No.", Sav."Member No.");
                    // // Memb.SetRange(exc);
                    // if Memb.Find('-') then begin

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := JTemp;
                    GenJournalLine."Journal Batch Name" := JBatch;
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := InterestBuffer."Account Type"::Savings;
                    GenJournalLine."Account No." := Sav."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := EndYearTransferHeader."Document No.";
                    GenJournalLine."Posting Date" := EndYearTransferHeader."Posting Date";
                    GenJournalLine.Description := EndYearTransferHeader.Description + ' Wtax ';
                    ProductFactory.Get(InterestBuffer."Product Factory Code");
                    GenJournalLine.Amount := Round((InterestBuffer."Interest Amount" * (ProductFactory."WithHolding Tax" / 100)), 0.01, '=');
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := ProductFactory."Withholding Tax Account";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := InterestBuffer."Shortcut Dimension 1 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine."Shortcut Dimension 2 Code" := InterestBuffer."Shortcut Dimension 2 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then begin
                        ProductFactory.TestField("Withholding Tax Account");
                        GenJournalLine.Insert;
                    end;

                    //Post New
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", JTemp);
                    GenJournalLine.SetRange("Journal Batch Name", JBatch);
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                    end;
                    //return block
                    if Blocked then begin
                        Sav.Blocked := BlockedEntr;
                        sav.modify;
                    end;
                    // end;
                end;

                InterestBuffer.Posted := true;
                InterestBuffer."User ID" := UserId;
                InterestBuffer.Modify;
                Commit;
            until InterestBuffer.Next = 0;
        end;

        Message(MSGPostedSuccessfully);
        EndYearTransferHeader.Posted := true;
        EndYearTransferHeader."Posted By" := UserId;
        EndYearTransferHeader."Posting Date" := Today;
        EndYearTransferHeader.Modify;
    end;

    procedure CollectATM(ATMApplications: Record "ATM Linking Applications")
    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        SavingsAccounts: Record "Savings Accounts";
        PeriodicActivities: Codeunit "Periodic Activities";
        BankingUserTemplate: Record "Banking User Template";
        JTemp: Code[20];
        JBatch: Code[20];
        ErrDocNotApproved: label 'This document has not been approved.';
        ErrLink: label 'Kindly Charge the ATM Fee.';
        ErrAlreadyCollected: label 'The ATM Card has already been collected.';
        CONFIRMIssue: label 'Are you sure you want to issue Card?';
        MSGOperationSuc: label 'Operation effected successfully.';
    begin
        // with ATMApplications do
        begin
            if ATMApplications.Status <> ATMApplications.Status::Approved then Error(ErrDocNotApproved);
            // if ATMApplications."ATM Charges Applied" <> true then Error(ErrLink);
            if ATMApplications.Collected = true then
                Error(ErrAlreadyCollected);

            if Confirm(CONFIRMIssue, false) = true then begin

                ATMApplications.Collected := true;
                ATMApplications."Card Issued" := true;
                ATMApplications."Date Collected" := Today;
                ATMApplications."Card Issued By" := UserId;
                ATMApplications."Card Status" := ATMApplications."card status"::Active;
                ATMApplications."Date Activated" := Today;
                ATMApplications.Modify;

                SavingsAccounts.Reset;
                SavingsAccounts.SetRange(SavingsAccounts."No.", ATMApplications."Account No");
                if SavingsAccounts.Find('-') then begin
                    //MESSAGE(FORMAT(SavingsAccounts."No."));
                    SavingsAccounts."ATM No." := ATMApplications."Card No";
                    SavingsAccounts.Modify;
                end;

                Message(MSGOperationSuc);
            end;
        end;
    end;


    procedure LinkATM(ATMLinking: record "ATM Linking Applications")
    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        SavingsAccounts: Record "Savings Accounts";
        PeriodicActivities: Codeunit "Periodic Activities";
        BankingUserTemplate: Record "Banking User Template";
        JTemp: Code[20];
        JBatch: Code[20];
        ErrPosted: label 'This document has not been approved.';
        ErrChargeATM: label 'Kindly Charge The ATM Fee.';
        ConfrmATMLink: label 'Are you sure you want to Link This ATM Card?';
        ErrATMLinked: label 'This ATM card is already linked.';
        MSGATMCardLinked: label 'ATM Card Successfully linked.';
        ErrOperationCancelled: label 'Operation cancelled';
        Txt004: label 'Your account has been linked to Sacco Link ATM.';
        ATMLinkingStatistics: Record "ATM Linking  Statistics";
        ATMCardStorage: Record "ATM Card Storage";
        ATMApplications: record "ATM Applications";
        msg: Text;
        SMSSource: enum "SMS Source";
        SendSMS: Codeunit SendSms;
        theMember: Record "Members";

    begin
        ATMApplications.reset;
        ATMApplications.setrange("No.", ATMLinking."ATM Application No.");
        if ATMApplications.FindFirst() then begin

            //with ATMApplications do
            if ATMLinking.Status <> ATMLinking.Status::Approved then Error(ErrPosted);
            IF ATMLinking."ATM Application No." <> '' then begin
                if ATMApplications."ATM Charges Applied" <> true then Error(ErrChargeATM);
            END;
            if Confirm(ConfrmATMLink, true) = true then begin
                if (ATMLinking."ATM Linked" = true) and (ATMLinking."ATM Delinked" = false) then Error(ErrATMLinked);
                ATMLinking.TestField("Card No");
                ATMLinking."Linked Date" := Today;
                ATMLinking."Linked By" := UserId;
                ATMLinking."Card Status" := ATMLinking."card status"::Active;
                ATMLinking."ATM Linked" := true;
                ATMLinking."ATM Delinked" := false;
                ATMLinking.Modify;


                ATMCardStorage.reset;
                ATMCardStorage.SetRange("Account No.", ATMLinking."Account No");
                ATMCardStorage.SetRange("Card Number", ATMLinking."Card No");
                if ATMCardStorage.FindFirst() then begin
                    ATMCardStorage.Linked := ATMLinking."ATM Linked";
                    //ATMCardStorage.DeLinked := ATMLinking."ATM Delinked";
                    ATMCardStorage.Modify();
                end
                else begin
                    ATMCardStorage.Init();
                    ATMCardStorage."Account No." := ATMLinking."Account No";
                    ATMCardStorage."Card Number" := ATMLinking."Card No";
                    ATMCardStorage."Member Name" := ATMLinking."Account Name";
                    ATMCardStorage.Linked := ATMLinking."ATM Linked";
                    //ATMCardStorage.DeLinked := ATMLinking."ATM Delinked";
                    ATMCardStorage.Insert();
                end;

                SavingsAccounts.Reset;
                SavingsAccounts.SetRange(SavingsAccounts."No.", ATMApplications."Account No");
                if SavingsAccounts.Find('-') then begin
                    SavingsAccounts."ATM No." := ATMApplications."Card No";
                    ATMApplications."Linked Date" := Today;
                    ATMApplications."Linked By" := UserId;
                    ATMApplications."ATM Delinked Date" := Today;
                    ATMApplications."Card Status" := ATMApplications."card status"::Active;
                    ATMApplications."ATM Linked" := true;
                    ATMApplications."ATM Delinked" := false;
                    ATMApplications.Modify;
                    // SavingsAccounts.Modify;
                    ATMLinkingStatistics.Init;
                    ATMLinkingStatistics."Account No." := SavingsAccounts."No.";
                    ATMLinkingStatistics."Activity Date" := Today;
                    ATMLinkingStatistics."ATM Application No." := ATMApplications."No.";
                    ATMLinkingStatistics."Linking Type" := ATMLinkingStatistics."linking type"::Linking;
                    ATMLinkingStatistics."User ID" := UserId;
                    ATMLinkingStatistics."Activity Time" := Time;
                    ATMLinkingStatistics.Insert(true);

                    // ATMLinkingStatistics.Init;
                    // ATMLinkingStatistics."Account No." := SavingsAccounts."No.";
                    // ATMLinkingStatistics."Activity Date" := Today;
                    // ATMLinkingStatistics."ATM Application No." := ATMApplications."No.";
                    // ATMLinkingStatistics."Linking Type" := ATMLinkingStatistics."linking type"::Linking;
                    // ATMLinkingStatistics."User ID" := UserId;
                    // ATMLinkingStatistics."Activity Time" := Time;
                    // ATMLinkingStatistics.Insert(true);

                    //send sms
                    // if SavingsACC.Get(ATMApplications."Account No") then begin
                    //     SendSMS.SendSms(Source::ATM_COLLECTION, SavingsACC."Mobile Phone No", Txt004, Format(ATMApplications."No."), '', true, 0, false, 'CBS', ATMApplications."No.", 'CBS');
                    // end;

                    Message(MSGATMCardLinked);

                    // ATM_LINKING SMS
                    theMember.Reset();
                    theMember.SetRange("Primary Identification", ATMLinking."Customer ID");
                    if theMember.FindFirst() then begin
                        if theMember."Phone No." <> '' then begin
                            msg := 'Dear ' + theMember."First Name" +
                            ', your ATM card has been linked to your account successfully. REF: '
                             + Format(ATMApplications."No.");

                            SendSMS.SendSms(
                                SMSSource::ATM_LINKING,
                                theMember."Phone No.",
                                msg,
                                Format(ATMApplications."No."),
                                '',
                                true,
                                220,
                                false,
                                'CBS',
                                ATMApplications."No.",
                                'CBS'
                            );
                        end;
                    end;
                end else
                    Error(ErrOperationCancelled);
            end;
        end;

    end;
    // end;


    procedure DeLinkATM(ATMApplications: Record "ATM Linking Applications")
    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        SavingsAccounts: Record "Savings Accounts";
        PeriodicActivities: Codeunit "Periodic Activities";
        BankingUserTemplate: Record "Banking User Template";
        JTemp: Code[20];
        JBatch: Code[20];
        ConfrmATMLink: label 'Are you sure you want to delink This ATM Card?';
        ErrATMLinked: label 'This ATM card is already dellinked.';
        MSGATMCardLinked: label 'ATM Card Successfully delinked.';
        ErrOperationCancelled: label 'Operation cancelled';
        Txt004: label 'Your Account has been Delinked from ATM. In case of any query contact your branch.';
        ATMLinkingStatistics: Record "ATM Linking  Statistics";
        ATMCardStorage: Record "ATM Card Storage";
        MyComment: Text;
        Selection: Integer;
        ReasonPage: Page "ATM Card Delink Reason";
    begin
        if ATMApplications.Status <> ATMApplications.Status::Approved then
            Error(ErrPosted);
        if Confirm(ConfrmATMLink, true) = true then begin
            if ATMApplications."ATM Delinked" = true then Error(ErrATMLinked);
            ATMApplications.TestField("Card No");
            Clear(ReasonPage);
            if ReasonPage.RunModal() = Action::OK then begin
                MyComment := ReasonPage.GetReason();

                ATMApplications."ATM Delinked" := true;
                ATMApplications."ATM Linked" := false;
                ATMApplications."Card Status" := ATMApplications."card status"::Frozen;
                ATMApplications.Modify;

                ATMCardStorage.reset;
                ATMCardStorage.SetRange("Account No.", ATMApplications."Account No");
                ATMCardStorage.SetRange("Card Number", ATMApplications."Card No");
                if ATMCardStorage.FindFirst() then begin
                    ATMCardStorage.Linked := ATMApplications."ATM Linked";
                    //ATMCardStorage.DeLinked := ATMLinking."ATM Delinked";
                    ATMCardStorage."Delinked On" := Today;
                    ATMCardStorage."Delinked By" := UserId;
                    ATMCardStorage.Reason := MyComment;
                    ATMCardStorage.Modify();
                end
                else begin
                    ATMCardStorage.Init();
                    ATMCardStorage."Account No." := ATMApplications."Account No";
                    ATMCardStorage."Card Number" := ATMApplications."Card No";
                    ATMCardStorage."Member Name" := ATMApplications."Account Name";

                    ATMCardStorage.Linked := ATMApplications."ATM Linked";
                    //ATMCardStorage.DeLinked := ATMLinking."ATM Delinked";
                    ATMCardStorage.Insert();
                end;

                SavingsAccounts.Reset;
                SavingsAccounts.SetRange(SavingsAccounts."No.", ATMApplications."Account No");
                if SavingsAccounts.Find('-') then begin
                    SavingsAccounts."ATM No." := '';
                    ATMApplications."ATM Delinked Date" := Today;
                    ATMApplications."Delinked By" := UserId;
                    ATMApplications."ATM Delinked" := true;
                    ATMApplications."ATM Linked" := false;
                    ATMApplications."Card Status" := ATMApplications."card status"::Frozen;
                    ATMApplications.Modify;
                    SavingsAccounts.Modify;
                    ATMLinkingStatistics.Init;
                    ATMLinkingStatistics."Account No." := SavingsAccounts."No.";
                    ATMLinkingStatistics."Activity Date" := Today;
                    ATMLinkingStatistics."ATM Application No." := ATMApplications."ATM Application No.";
                    ATMLinkingStatistics."Linking Type" := ATMLinkingStatistics."linking type"::Delinking;
                    ATMLinkingStatistics."User ID" := UserId;
                    ATMLinkingStatistics."Activity Time" := Time;
                    ATMLinkingStatistics."Reason for change" := MyComment;
                    ATMLinkingStatistics.Insert(true);
                    //send sms
                    if SavingsACC.Get(ATMApplications."Account No") then begin
                        SendSMS.SendSms(Source::ATM_COLLECTION, SavingsACC."Mobile Phone No", Txt004, Format(ATMApplications."No."), '', true, 0, false, 'CBS', ATMApplications."No.", 'CBS');
                    end;
                end;
                Message(MSGATMCardLinked);
            end else begin
                Message(ErrOperationCancelled);
            end;
        end;
    end;

    // end;


    procedure ChargeATMFee(ATMApplications: Record "ATM Applications")
    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        SavingsAccounts: Record "Savings Accounts";
        PeriodicActivities: Codeunit "Periodic Activities";
        BankingUserTemplate: Record "Banking User Template";
        JTemp: Code[20];
        JBatch: Code[20];
    begin
    end;

    local procedure "-"()
    begin
    end;


    procedure StatementCharges(SavingsAccounts: Record "Savings Accounts")
    var
        AvailableBal: Decimal;
        LineN: Integer;
        DocumentNo: Code[10];
        ExtDocumentNo: Code[10];
    begin
        Temp.Get(UserId);
        Jtemplate := Temp."Cashier Journal Template";
        JBatch := Temp."Cashier Journal Batch";

        GenJLine.Reset;
        GenJLine.SetRange(GenJLine."Journal Template Name", Jtemplate);
        GenJLine.SetRange(GenJLine."Journal Batch Name", JBatch);
        GenJLine.DeleteAll;

        if SavingsAccounts.Find('-') then begin
            SavingsAccounts.CalcFields(SavingsAccounts."Balance (LCY)", SavingsAccounts."Authorised Over Draft",
                                       SavingsAccounts."Uncleared Cheques", SavingsAccounts."ATM Transactions");

            AvailableBal := (SavingsAccounts."Balance (LCY)" + SavingsAccounts."Authorised Over Draft") -
                            (SavingsAccounts."Uncleared Cheques" + SavingsAccounts."ATM Transactions");//+MinBalance)


        end;
    end;

    local procedure "--"()
    begin
    end;


    procedure PostBBFClaims(BBFHeader: Record "Payments Header")
    var
        JournalPosting: Codeunit "Journal Posting";
        Template: Code[10];
        Batch: Code[10];
        OfficeTemp: Record "Cash Office User Template";
        ClaimLines: Record "BBF Claim Lines";
        GeneralSetUp: Record "General Set-Up";
        LineNo: Integer;
        KinDetails: Record "Next of KIN";
        ErrorOnPayMode: label 'Pay mode must be Bank or Cheque';
        MsgOnCompletePosting: label 'Application No. -%1- successfully posted.';
        SavingsAccounts: Record "Savings Accounts";
        CreditAccounts: Record "Credit Accounts";
        AccType: Enum "Gen. Journal Account Type";
        BBFRequisationLines: Record "BBF Requisation Header";
    begin

        // with BBFHeader do
        begin

            BBFHeader.TestField(Posted, false);
            BBFHeader.TestField(Status, BBFHeader.Status::Approved);
            BBFHeader.TestField("Payment Release Date", Today);

            // IF NOT ("Pay Mode"<>"Pay Mode"::Cheque) OR ("Pay Mode"<>"Pay Mode"::"Custom 4") THEN ERROR(ErrorOnPayMode);

            // BBFHeader.CalcFields("Total Payment Amount BBF");
            GeneralSetUp.Get();
            GeneralSetUp.TestField("Benevolent Claim Account");
            BBFHeader.TestField("Global Dimension 1 Code");
            BBFHeader.TestField("Shortcut Dimension 2 Code");
            // TESTFIELD("Payment Narration");

            Temp.Get(UserId);

            Temp.TestField("Cashier Journal Template");
            Temp.TestField("Cashier Journal Batch");

            Template := Temp."Cashier Journal Template";
            Batch := Temp."Cashier Journal Batch";

            if Confirm(MsgOnConfirmDialog, true) = false then
                exit;

            JournalPosting.ClearJournalLines(Template, Batch);

            ClaimLines.Reset;

            if ClaimLines.FindSet() then begin
                repeat


                    // if ClaimLines."BBF Entitlement Code" = '' then begin
                    //     LineNo := LineNo + 1;

                    //     JournalPosting.PostJournal(Template, Batch, LineNo, AccType, BBFHeader."No.", PadStr(ClaimLines.Name + ' Pay Acc No.' + ClaimLines."Account No", 50), ClaimLines."BBF Entitlement Paid" * -1,
                    //     ClaimLines."Account No", BBFHeader."Payment Release Date", "Gen. Journal Account Type"::"G/L Account", '', '',
                    //     BBFHeader."Global Dimension 1 Code", BBFHeader."Shortcut Dimension 2 Code", ClaimLines."Transaction Type", ClaimLines."Loan No.",
                    //     '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                    // end else begin
                    //     LineNo := LineNo + 1;
                    //     JournalPosting.PostJournal(Template, Batch, LineNo, "Gen. Journal Account Type"::"G/L Account", BBFHeader."No.", PadStr(ClaimLines.Name + ' Pay Acc No.' + ClaimLines."Account No", 50), ClaimLines."BBF Entitlement Paid" * -1,
                    //     GeneralSetUp."Benevolent Claim Account", BBFHeader."Payment Release Date", "Gen. Journal Account Type"::"G/L Account", '', '',
                    //     BBFHeader."Global Dimension 1 Code", BBFHeader."Shortcut Dimension 2 Code", ClaimLines."Transaction Type", ClaimLines."Loan No.",
                    //     '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                    // end;


                    if KinDetails.Find('-') then begin
                        KinDetails.Deceased := true;
                        KinDetails.Modify;//(Deceased,TRUE);
                                          //KinDetails.MODIFYALL(Deceased,TRUE);
                    end;
                until ClaimLines.Next = 0;

                //Debit Bank
                // BBFHeader.CalcFields("Total Payment Amount BBF");
                LineNo := LineNo + 1;

                // JournalPosting.PostJournal(Template, Batch, LineNo, BBFHeader."Account Type", BBFHeader."No.", PadStr(ClaimLines.Name, 50), BBFHeader."Total Payment Amount BBF",
                // BBFHeader."Account No.", BBFHeader."Payment Release Date", "Gen. Journal Account Type"::"G/L Account", '', '',
                // BBFHeader."Global Dimension 1 Code", BBFHeader."Shortcut Dimension 2 Code",
                // 0, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
            end;

            JournalPosting.LinesCompletePosting(Template, Batch);

            BBFRequisationLines.Reset;
            BBFRequisationLines.SetRange(No, BBFHeader."Requisation Doc No.");
            if BBFRequisationLines.Find('-') then begin
                BBFRequisationLines.Payed := true;
                BBFRequisationLines.Modify;
            end;

            Posted := true;
            BBFHeader."Date Posted" := Today;
            BBFHeader."Time Posted" := Time;
            BBFHeader."Posted By" := UserId;
            BBFHeader.Modify;
            if Posted = true then Message(MsgOnCompletePosting, BBFHeader."No.");

            Commit;
            /*
            RESET;
            SETFILTER("No.","No.");
            REPORT.RUN(52185720,TRUE,TRUE,BBFHeader);
            RESET;
            */

        end;

    end;


    procedure GenerateClaimLines(ClaimLines: Record "BBF Claim Lines")
    var
        ErrorOnMaxEntitlement: label 'Member has exhausted the Max. No. of -%1- entitlement under this category.Category is %2.';
        KinDetails: Record "Next of KIN";
        Entitlement: Record "BBF Entitlement";
        MaxKinNo: Integer;
    begin
        // with ClaimLines do
        begin


            // end;
        end
    end;


    procedure PostSinkClaims(BBFHeaderClaim: Record "BBF Requisation Header")
    var
        JournalPosting: Codeunit "Journal Posting";
        Template: Code[10];
        Batch: Code[10];
        OfficeTemp: Record "Cash Office User Template";
        ClaimLines: Record "BBF Requisation Lines";
        GeneralSetUp: Record "General Set-Up";
        LineNo: Integer;
        KinDetails: Record "Next of KIN";
        ErrorOnPayMode: label 'Pay mode must be Bank or Cheque';
        MsgOnCompletePosting: label 'Application No. -%1- successfully posted.';
        SavingsAccounts: Record "Savings Accounts";
        CreditAccounts: Record "Credit Accounts";
        AccType: Enum "Gen. Journal Account Type";
        BBFRequisationLines: Record "BBF Requisation Header";
        Members: Record Members;
        SinkFundReportInformation: Record "SinkFund Report Information";
        TransactionCharges: Record "Transaction Charges";
        TariffDetails: Record "Tiered Charges Lines";
        TCharges: Decimal;
        ChargeAmount: Decimal;
        TransactionTypes: Record "Transaction Types";
        Txt0001: label 'Excise Duty';
        BalAccType: Enum "Gen. Journal Account Type";
        TransType: Option " ",Loan,Repayment,"Interest Due","Interest Paid",Bills;
        AccNo: Code[10];
        BalAccNo: Code[10];
        BBFEntitlementSetUp: Record "BBF Entitlement SetUp";
        IncomeRecAccount: Code[30];
        MemberAmount: Decimal;
        SaccoAmount: Decimal;
    begin

        //with BBFHeaderClaim do
        begin
            //Mark Transaction Posted...
            SavingsLedgerEntry.Reset;
            SavingsLedgerEntry.SetRange("Document No.", BBFHeaderClaim.No);
            if SavingsLedgerEntry.Find('-') then begin
                Posted := true;
                BBFHeaderClaim.Modify;
            end else
                BBFHeaderClaim.TestField(Posted, false);
            BBFHeaderClaim.TestField(Status, BBFHeaderClaim.Status::Approved);
            //TESTFIELD("Payment Release Date",TODAY);

            GeneralSetUp.Get();
            GeneralSetUp.TestField("Benevolent Claim Account");
            BBFHeaderClaim.TestField("Global Dimension 1 Code");
            BBFHeaderClaim.TestField("Global Dimension 2 Code");

            Temp.Get(UserId);

            Temp.TestField("Cashier Journal Template");
            Temp.TestField("Cashier Journal Batch");

            Template := Temp."Cashier Journal Template";
            Batch := Temp."Cashier Journal Batch";

            if Confirm(MsgOnConfirmDialog, true) = false then
                exit;

            JournalPosting.ClearJournalLines(Template, Batch);

            MemberAmount := 0;
            SaccoAmount := 0;

            ClaimLines.Reset;
            ClaimLines.SetRange("Header No", BBFHeaderClaim.No);
            ClaimLines.SetRange(Posted, false);
            ClaimLines.SetRange(Deceased, false);
            if ClaimLines.FindSet() then begin
                repeat
                // if ClaimLines."BBF Entitlement Code" <> '' then begin
                //     ClaimLines.TestField(Name);
                //     ClaimLines.TestField("Account No.");
                //     ClaimLines.TestField("Pay To Name");
                //     ClaimLines.TestField("Pay To ID");

                //     if CreditAccounts.Get(ClaimLines."Account No.") then
                //         AccType := "Gen. Journal Account Type"::Credit
                //     else
                //         AccType := "Gen. Journal Account Type"::Savings;

                //     SaccoAmount := ClaimLines."Sacco Income Recovable";
                //     MemberAmount := ClaimLines."Total Amount" - SaccoAmount;

                //     LineNo := LineNo + 1;

                //     JournalPosting.PostJournal(Template, Batch, LineNo, AccType, BBFHeaderClaim.No, PadStr(ClaimLines."Pay To Name" + 'ID.' + ClaimLines."Pay To ID" + ' for ' + ClaimLines.Relationship + '-' + ClaimLines."Next of Kin", 50),
                //     (MemberAmount) * -1, ClaimLines."Account No.", BBFHeaderClaim."Payment Release Date", "Gen. Journal Account Type"::"G/L Account", '', '', BBFHeaderClaim."Global Dimension 1 Code", BBFHeaderClaim."Global Dimension 2 Code",

                //     ClaimLines."Transaction Type", ClaimLines."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                //     ClaimLines.Posted := true;
                //     ClaimLines.Deceased := true;
                //     ClaimLines.Modify;
                //     Posted := true;
                //     BBFHeaderClaim.Modify;

                //     KinDetails.Reset;
                //     KinDetails.SetRange(Name, ClaimLines."Next of Kin");
                //     KinDetails.SetRange("Record ID", ClaimLines."Member No");
                //     if KinDetails.Find('-') then begin
                //         KinDetails.ModifyAll(Deceased, true);
                //     end;
                //     //Debit GL
                //     LineNo := LineNo + 1;

                //     JournalPosting.PostJournal(Template, Batch, LineNo, "Gen. Journal Account Type"::Vendor, BBFHeaderClaim.No, PadStr(ClaimLines."Pay To Name" + 'ID.' + ClaimLines."Pay To ID" + ' for ' + ClaimLines.Relationship + '-' + ClaimLines."Next of Kin", 50), ClaimLines."Total Amount",
                //     GeneralSetUp."Benevolent Claim Account", BBFHeaderClaim."Payment Release Date", "Gen. Journal Account Type"::"G/L Account", '', '',
                //     BBFHeaderClaim."Global Dimension 1 Code", BBFHeaderClaim."Global Dimension 2 Code",

                //     0, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                //     BBFEntitlementSetUp.Reset;
                //     if BBFEntitlementSetUp.FindFirst then IncomeRecAccount := BBFEntitlementSetUp."Sacco G/L";
                //     LineNo := LineNo + 1;

                //     JournalPosting.PostJournal(Template, Batch, LineNo, "Gen. Journal Account Type"::"G/L Account", BBFHeaderClaim.No, PadStr(ClaimLines."Pay To Name" + 'ID.' + ClaimLines."Pay To ID" + ' for ' + ClaimLines.Relationship + '-' + ClaimLines."Next of Kin", 50),
                //     SaccoAmount * -1, IncomeRecAccount, BBFHeaderClaim."Payment Release Date", "Gen. Journal Account Type"::"G/L Account", '', '', BBFHeaderClaim."Global Dimension 1 Code", BBFHeaderClaim."Global Dimension 2 Code",

                //     ClaimLines."Transaction Type", ClaimLines."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");


                //     //bbf charge

                //     Temp.Get(UserId);

                //     Temp.TestField("Cashier Journal Template");
                //     Temp.TestField("Cashier Journal Batch");

                //     Template := Temp."Cashier Journal Template";
                //     Batch := Temp."Cashier Journal Batch";
                //     GeneralSetUp.Get();
                //     TransactionTypes.Reset;
                //     TransactionTypes.SetRange(TransactionTypes.Type, TransactionTypes.Type::"BBF Payment");
                //     TransactionTypes.SetRange(Code, GeneralSetUp."Sink Fund Process Charge");
                //     if TransactionTypes.Find('-') then begin
                //     end;

                //     //Charges
                //     TCharges := 0;

                //     TransactionCharges.Reset;
                //     TransactionCharges.SetRange(TransactionCharges."Transaction Type", TransactionTypes.Code);
                //     if TransactionCharges.FindSet() then begin
                //         repeat
                //             LineNo := LineNo + 10000;

                //             ChargeAmount := 0;
                //             if TransactionCharges."Charge Type" = TransactionCharges."charge type"::"% of Amount" = true then
                //                 ChargeAmount := (ClaimLines."BBF Entitlement" * TransactionCharges."Percentage of Amount") * 0.01
                //             else
                //                 ChargeAmount := TransactionCharges."Charge Amount";

                //             if TransactionCharges."Charge Type" = TransactionCharges."charge type"::Staggered then begin

                //                 TransactionCharges.TestField(TransactionCharges."Staggered Charge Code");

                //                 TariffDetails.Reset;
                //                 TariffDetails.SetRange(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                //                 if TariffDetails.FindSet() then begin
                //                     repeat
                //                         if (ClaimLines."BBF Entitlement" >= TariffDetails."Lower Limit") and (ClaimLines."BBF Entitlement" <= TariffDetails."Upper Limit") then begin
                //                             if TariffDetails."Use Percentage" = true then begin
                //                                 ChargeAmount := ClaimLines."BBF Entitlement" * TariffDetails.Percentage * 0.01;
                //                             end else begin
                //                                 ChargeAmount := TariffDetails."Charge Amount"
                //                             end;
                //                         end;
                //                     until TariffDetails.Next = 0;
                //                 end;
                //             end;



                //             if CreditAccounts.Get(ClaimLines."Account No.") then
                //                 AccType := "Gen. Journal Account Type"::Credit
                //             else
                //                 AccType := "Gen. Journal Account Type"::Savings;
                //             BalAccType := Balacctype::"G/L Account";
                //             LineNo := LineNo + 1;
                //             JournalPosting.PostJournal(Template, Batch, LineNo, AccType, BBFHeaderClaim.No,
                //             TransactionCharges.Description + '-' + ClaimLines."Account No.", ChargeAmount, ClaimLines."Account No.", BBFHeaderClaim."Payment Release Date", BalAccType,
                //             TransactionCharges."G/L Account", '', BBFHeaderClaim."Global Dimension 1 Code", BBFHeaderClaim."Global Dimension 2 Code", TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                //             if TransactionCharges."Recover Excise Duty" then begin
                //                 //Excise Duty
                //                 LineNo := LineNo + 1;
                //                 JournalPosting.PostJournal(Template, Batch, LineNo, AccType, BBFHeaderClaim.No,
                //                 'Excise Duty' + TransactionCharges.Description + '-' + ClaimLines."Account No.", (ChargeAmount * GeneralSetUp."Excise Duty (%)") * 0.01, ClaimLines."Account No.", BBFHeaderClaim."Payment Release Date", BalAccType,
                //                  GeneralSetUp."Excise Duty G/L", '', BBFHeaderClaim."Global Dimension 1 Code", BBFHeaderClaim."Global Dimension 2 Code", TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                //             end;
                //         until TransactionCharges.Next = 0;
                //     end;
                //     //bbf charge






                // end;
                until ClaimLines.Next = 0;

            end;

            JournalPosting.LinesCompletePosting(Template, Batch);
            /*
           BBFRequisationLines.RESET;
           BBFRequisationLines.SETRANGE(No,);
           IF BBFRequisationLines.FIND('-') THEN BEGIN
             BBFRequisationLines.Payed:=TRUE;
             BBFRequisationLines.MODIFY;
             END;
             */
            Posted := true;
            //"Date Posted":=TODAY;
            //"Time Posted":=TIME;
            //"Posted By":=USERID;
            BBFHeaderClaim.Modify;
            //IF BBFHeaderClaim.Type=BBFHeaderClaim.Type::"Principal Member" THEN BEGIN
            // if BBFHeaderClaim."Claim Option" = 'PRINCIPAL MEMBER' then begin
            //     if Members.Get(BBFHeaderClaim."Member No") then begin
            //         Members.Status := Members.Status::Deceased;
            //         Members.Modify;
            //     end;
            //     SavingsAccounts.Reset;
            //     SavingsAccounts.SetRange("Member No.", BBFHeaderClaim."Member No");
            //     SavingsAccounts.SetRange("Loan Disbursement Account", true);
            //     if SavingsAccounts.Find('-') then begin
            //         SavingsAccounts.Status := SavingsAccounts.Status::Frozen;
            //         SavingsAccounts."Status Change Reason" := 'Deceased awaiting documentation';
            //         SavingsAccounts.Modify;
            //     end;
            // end;


            if BBFHeaderClaim.Posted = true then Message(MsgOnCompletePosting, BBFHeaderClaim.No);

            // SinkFundReportInformation.Reset;
            // SinkFundReportInformation.SetRange(No, BBFHeaderClaim."Report Notice No");
            // if SinkFundReportInformation.Find('-') then begin
            //     if BBFHeaderClaim.Type = BBFHeaderClaim.Type::"Principal Member" then begin
            //         SinkFundReportInformation."Insurance Payment Status" := SinkFundReportInformation."insurance payment status"::"Principal Amount Paid";
            //         SinkFundReportInformation.Modify
            //     end else
            //         SinkFundReportInformation."Insurance Payment Status" := SinkFundReportInformation."insurance payment status"::"Beneficiary Claim Paid";
            //     SinkFundReportInformation.Modify;
            // end;




            //**COMMIT;
            /*
            RESET;
            SETFILTER("No.","No.");
            REPORT.RUN(52185720,TRUE,TRUE,BBFHeader);
            RESET;
            */
            if Members.Get(BBFHeaderClaim."Member No") then begin
                CompanyInformation.Get();
                msg := 'Dear member, your sink fund claim has been credited to your account. ';
                SendSMS.SendSms(Source::ACCOUNT_STATUS, Members."Phone No.", msg, Format(BBFHeaderClaim.No), '', true, 0, false, 'CBS', BBFHeaderClaim.No, 'CBS');
            end;
        end;

    end;


    procedure InitJournal(JTemplate: Code[10]; JBatch: Code[10])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", JTemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        if GenJournalLine.Find('-') then
            GenJournalLine.DeleteAll;
    end;

    procedure GetMemberDepositAccount(member: record Members): Code[20];
    var
        SavingsAccounts: Record "Savings Accounts";
    begin
        SavingsAccounts.RESET;
        SavingsAccounts.SETRANGE("Member No.", member."No.");
        SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
        if SavingsAccounts.FINDFIRST then
            exit(SavingsAccounts."No.")
        else
            exit('');
    end;



    procedure JournalInsert(Jtemplate: Code[20]; JBatch: Code[20]; DocNo: Code[20]; PDate: Date; AcctType: Enum "Gen. Journal Account Type"; AcctNo: Code[20];
                                                                                                               Desc: Text[150];
                                                                                                               BalAcctType: Enum "Gen. Journal Account Type";
                                                                                                               BalAcctNo: Code[20];
                                                                                                               Amt: Decimal;
                                                                                                               ExtDocNo: Code[20];
                                                                                                               Loan: Code[20];
                                                                                                               TransType: enum "Transaction Types";
                                                                                                               Dim1: Code[20];
                                                                                                               Dim2: Code[20];
                                                                                                               SystemCreated: Boolean)
    var
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
    begin

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        LineNo := GenJournalLine.Count;

        LineNo += 1;


        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := Jtemplate;
        GenJournalLine."Journal Batch Name" := JBatch;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Document No." := DocNo;
        GenJournalLine."Posting Date" := PDate;
        GenJournalLine."Account Type" := AcctType;
        GenJournalLine."Account No." := AcctNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine.Description := CopyStr(Desc, 1, 50);
        GenJournalLine."Bal. Account Type" := BalAcctType;
        GenJournalLine."Bal. Account No." := BalAcctNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine.Amount := Amt;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."External Document No." := ExtDocNo;
        GenJournalLine."Loan No" := Loan;
        GenJournalLine."Transaction Type" := TransType;
        GenJournalLine."Shortcut Dimension 1 Code" := Dim1;
        GenJournalLine."Shortcut Dimension 2 Code" := Dim2;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine."System-Created Entry" := SystemCreated;

        //MESSAGE('%1',GenJournalLine);
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure PostJournal(JTemplate: Code[10]; JBatch: Code[10]) Posted: Boolean
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        Posted := false;
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", JTemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
            Posted := true;
        end;
    end;

    procedure PostJournal(JTemplate: Code[10]; JBatch: Code[10]; ConfirmBeforePosting: Boolean) Posted: Boolean
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        Posted := false;
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", JTemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        if GenJournalLine.Find('-') then begin
            if ConfirmBeforePosting then
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine)
            else
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
            Posted := true;
        end;
    end;


    procedure PreviewJournal(JTemplate: Code[10]; JBatch: Code[10])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", JTemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        if GenJournalLine.Find('-') then begin
            Page.Run(Page::"General Journal", GenJournalLine);
        end;
    end;

    procedure CreateJournalBatch(JTemplate: Code[10]; JBatch: Code[10])
    var
        GenBatches: Record "Gen. Journal Batch";
    begin
        GenBatches.RESET;
        GenBatches.SETRANGE(GenBatches."Journal Template Name", Jtemplate);
        GenBatches.SETRANGE(GenBatches.Name, JBatch);
        IF GenBatches.FIND('-') = FALSE THEN BEGIN
            GenBatches.INIT;
            GenBatches."Journal Template Name" := Jtemplate;
            GenBatches.Name := JBatch;
            GenBatches.Description := 'ATM Transactions';
            GenBatches.VALIDATE(GenBatches."Journal Template Name");
            GenBatches.VALIDATE(GenBatches.Name);
            GenBatches.INSERT;
        END;

    end;


    procedure ddMMyyyy(Date: Date) NewDate: Text
    var
        d: Text;
        m: Text;
        y: Text;
    begin

        d := Format(Date2dmy(Date, 1));
        m := Format(Date2dmy(Date, 2));
        y := Format(Date2dmy(Date, 3));

        if StrLen(d) = 1 then
            d := '0' + d;

        if StrLen(m) = 1 then
            m := '0' + m;

        NewDate := d + '/' + m + '/' + y;
    end;

    procedure BlockUblock(AccountNos: code[20]; UnblockEventAct: boolean)
    var
        SavAcc: Record "Savings Accounts";
    begin
        if SavAcc.get(AccountNos) then begin
            if UnblockEventAct = true then begin
                SavAcc."Blocked Buffer" := SavAcc.Blocked;
                SavAcc.Blocked := SavAcc.Blocked::" ";
                SavAcc.Modify;
                if UnblockEventAct = false then begin
                    SavAcc."Blocked" := SavAcc."Blocked Buffer";
                    SavAcc."Blocked Buffer" := SavAcc."Blocked Buffer"::" ";
                    SavAcc.Modify;
                end;
            end;
        end;

    end;
}

