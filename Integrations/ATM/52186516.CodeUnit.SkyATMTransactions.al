codeunit 52186516 "Sky Coop ATM Transactions"
{
    procedure LogBalanceEnquiry(
        var SkyATMTransactions: Record "Sky ATM Transactions Buffer";
        Payload: JsonObject;
        APIRequestID: JsonToken;
        var MemberSavingsAccount: Record "Savings Accounts"
    )
    var
        service_name: JsonToken;
        message_id: JsonToken; // Coop reference. Should never be duplicated

        get_balance_request_operation_parameters_transaction_date: JsonToken;
        get_balance_request_operation_parameters_terminal_id: JsonToken;
        get_balance_request_operation_parameters_channel: JsonToken;
        get_balance_request_account_credit_account: JsonToken;
        get_balance_request_account_debit_account: JsonToken;
        get_balance_request_institution_institution_code: JsonToken;
        get_balance_request_institution_institution_name: JsonToken;
        get_balance_request_posting_charge_amount: JsonToken;
        get_balance_request_posting_charge_currency: JsonToken;
        get_balance_request_posting_fee_amount: JsonToken;
        get_balance_request_posting_fee_currency: JsonToken;
        get_balance_request_posting_narrative: JsonToken;
        get_balance_request_additional_info: JsonToken;
        get_balance_request_additional_info_text: Text;
        get_balance_request_operation_parameters_location: JsonToken;
    begin
        Payload.Get('service_name', service_name);
        Payload.Get('message_id', message_id);

        Payload.SelectToken('$.get_balance_request.operation_parameters.transaction_date', get_balance_request_operation_parameters_transaction_date);
        Payload.SelectToken('$.get_balance_request.operation_parameters.terminal_id', get_balance_request_operation_parameters_terminal_id);
        Payload.SelectToken('$.get_balance_request.operation_parameters.channel', get_balance_request_operation_parameters_channel);
        Payload.SelectToken('$.get_balance_request.operation_parameters.location', get_balance_request_operation_parameters_location);
        Payload.SelectToken('$.get_balance_request.account.credit_account', get_balance_request_account_credit_account);
        Payload.SelectToken('$.get_balance_request.account.debit_account', get_balance_request_account_debit_account);
        Payload.SelectToken('$.get_balance_request.institution.institution_code', get_balance_request_institution_institution_code);
        Payload.SelectToken('$.get_balance_request.institution.institution_name', get_balance_request_institution_institution_name);
        Payload.SelectToken('$.get_balance_request.posting.charge_amount', get_balance_request_posting_charge_amount);
        Payload.SelectToken('$.get_balance_request.posting.charge_currency', get_balance_request_posting_charge_currency);
        Payload.SelectToken('$.get_balance_request.posting.fee_amount', get_balance_request_posting_fee_amount);
        Payload.SelectToken('$.get_balance_request.posting.fee_currency', get_balance_request_posting_fee_currency);
        Payload.SelectToken('$.get_balance_request.posting.narrative', get_balance_request_posting_narrative);
        Payload.SelectToken('$.get_balance_request.additional_info', get_balance_request_additional_info);

        SkyATMTransactions.Init;

        SkyATMTransactions."Service Name" := service_name.AsValue.AsText;
        SkyATMTransactions."Message ID" := message_id.AsValue.AsText;

        Evaluate(SkyATMTransactions."Transaction Date Time", get_balance_request_operation_parameters_transaction_date.AsValue.AsText);
        // SkyATMTransactions."Transaction Date Time" := get_balance_request_operation_parameters_transaction_date.AsValue.AsDateTime;

        SkyATMTransactions."Terminal ID" := get_balance_request_operation_parameters_terminal_id.AsValue.AsText;
        SkyATMTransactions.Channel := get_balance_request_operation_parameters_channel.AsValue.AsText;
        SkyATMTransactions."Credit Account" := get_balance_request_account_credit_account.AsValue.AsText;
        SkyATMTransactions."Debit Account" := get_balance_request_account_debit_account.AsValue.AsText;
        SkyATMTransactions."Institution Code" := get_balance_request_institution_institution_code.AsValue.AsText;
        SkyATMTransactions."Institution Name" := get_balance_request_institution_institution_name.AsValue.AsText;
        SkyATMTransactions."Charge Amount" := get_balance_request_posting_charge_amount.AsValue.AsDecimal;
        SkyATMTransactions."Charge Currency" := get_balance_request_posting_charge_currency.AsValue.AsText;
        SkyATMTransactions."Fee Amount" := get_balance_request_posting_fee_amount.AsValue.AsDecimal;
        SkyATMTransactions."Fee Currency" := get_balance_request_posting_fee_currency.AsValue.AsText;
        SkyATMTransactions."Transaction Narration" := get_balance_request_posting_narrative.AsValue.AsText;

        get_balance_request_additional_info.WriteTo(get_balance_request_additional_info_text);
        SkyATMTransactions."Additional Info" := get_balance_request_additional_info_text;

        SkyATMTransactions.Location := get_balance_request_operation_parameters_location.AsValue.AsText;

        SkyATMTransactions."API Request ID" := APIRequestID.AsValue.AsText;

        SkyATMTransactions."Transaction ID" := GlobalFunctions.CleanGuid;
        SkyATMTransactions."Saccolink Transaction Type" := "Saccolink Transaction Types"::"Balance Enquiry_Sacco_Direct";
        SkyATMTransactions."Transaction Date" := Today;
        SkyATMTransactions."Transaction Time" := Time;
        SkyATMTransactions.Posted := false;
        SkyATMTransactions."Member Savings Account" := MemberSavingsAccount."No.";
    end;

    procedure LogFundsTransfer(
        var SkyATMTransactions: Record "Sky ATM Transactions Buffer";
        Payload: JsonObject;
        APIRequestID: JsonToken;
        var MemberSavingsAccount: Record "Savings Accounts"
    )
    var
        service_name: JsonToken;
        message_id: JsonToken;

        send_funds_transfer_request_operation_parameters_transaction_date: JsonToken;
        send_funds_transfer_request_operation_parameters_terminal_id: JsonToken;
        send_funds_transfer_request_operation_parameters_channel: JsonToken;
        send_funds_transfer_request_operation_parameters_location: JsonToken;
        send_funds_transfer_request_operation_parameters_connection_mode: JsonToken;
        send_funds_transfer_request_operation_parameters_transaction_type: JsonToken;
        send_funds_transfer_request_operation_parameters_original_message_id: JsonToken;

        send_funds_transfer_request_institution_institution_code: JsonToken;
        send_funds_transfer_request_institution_institution_name: JsonToken;

        send_funds_transfer_request_posting_debit_account: JsonToken;
        send_funds_transfer_request_posting_amount: JsonToken;
        send_funds_transfer_request_posting_currency: JsonToken;
        send_funds_transfer_request_posting_credit_account: JsonToken;
        send_funds_transfer_request_posting_charge_amount: JsonToken;
        send_funds_transfer_request_posting_charge_currency: JsonToken;
        send_funds_transfer_request_posting_fee_amount: JsonToken;
        send_funds_transfer_request_posting_fee_currency: JsonToken;
        send_funds_transfer_request_posting_narrative1: JsonToken;
        send_funds_transfer_request_posting_narrarive2: JsonToken;

        send_funds_transfer_request_additional_info: JsonToken;
        send_funds_transfer_request_additional_info_text: Text;
    begin
        Payload.Get('service_name', service_name);
        Payload.Get('message_id', message_id);

        Payload.SelectToken('$.send_funds_transfer_request.operation_parameters.transaction_date', send_funds_transfer_request_operation_parameters_transaction_date);
        Payload.SelectToken('$.send_funds_transfer_request.operation_parameters.terminal_id', send_funds_transfer_request_operation_parameters_terminal_id);
        Payload.SelectToken('$.send_funds_transfer_request.operation_parameters.channel', send_funds_transfer_request_operation_parameters_channel);
        Payload.SelectToken('$.send_funds_transfer_request.operation_parameters.location', send_funds_transfer_request_operation_parameters_location);
        Payload.SelectToken('$.send_funds_transfer_request.operation_parameters.connection_mode', send_funds_transfer_request_operation_parameters_connection_mode);
        Payload.SelectToken('$.send_funds_transfer_request.operation_parameters.transaction_type', send_funds_transfer_request_operation_parameters_transaction_type);
        Payload.SelectToken('$.send_funds_transfer_request.operation_parameters.original_message_id', send_funds_transfer_request_operation_parameters_original_message_id);
        Payload.SelectToken('$.send_funds_transfer_request.institution.institution_code', send_funds_transfer_request_institution_institution_code);
        Payload.SelectToken('$.send_funds_transfer_request.institution.institution_name', send_funds_transfer_request_institution_institution_name);
        Payload.SelectToken('$.send_funds_transfer_request.posting.debit_account', send_funds_transfer_request_posting_debit_account);
        Payload.SelectToken('$.send_funds_transfer_request.posting.amount', send_funds_transfer_request_posting_amount);
        Payload.SelectToken('$.send_funds_transfer_request.posting.currency', send_funds_transfer_request_posting_currency);
        Payload.SelectToken('$.send_funds_transfer_request.posting.credit_account', send_funds_transfer_request_posting_credit_account);
        Payload.SelectToken('$.send_funds_transfer_request.posting.charge_amount', send_funds_transfer_request_posting_charge_amount);
        Payload.SelectToken('$.send_funds_transfer_request.posting.charge_currency', send_funds_transfer_request_posting_charge_currency);
        Payload.SelectToken('$.send_funds_transfer_request.posting.fee_amount', send_funds_transfer_request_posting_fee_amount);
        Payload.SelectToken('$.send_funds_transfer_request.posting.fee_currency', send_funds_transfer_request_posting_fee_currency);
        Payload.SelectToken('$.send_funds_transfer_request.posting.narrative1', send_funds_transfer_request_posting_narrative1);
        Payload.SelectToken('$.send_funds_transfer_request.posting.narrarive2', send_funds_transfer_request_posting_narrarive2);
        Payload.SelectToken('$.send_funds_transfer_request.additional_info', send_funds_transfer_request_additional_info);


        SkyATMTransactions.Init;

        SkyATMTransactions."Service Name" := service_name.AsValue.AsText;
        SkyATMTransactions."Message ID" := message_id.AsValue.AsText;

        Evaluate(SkyATMTransactions."Transaction Date Time", send_funds_transfer_request_operation_parameters_transaction_date.AsValue.AsText);
        // SkyATMTransactions."Transaction Date Time" := send_funds_transfer_request_operation_parameters_transaction_date.AsValue.AsDateTime;

        SkyATMTransactions."Terminal ID" := send_funds_transfer_request_operation_parameters_terminal_id.AsValue.AsText;
        SkyATMTransactions.Channel := send_funds_transfer_request_operation_parameters_channel.AsValue.AsText;
        SkyATMTransactions."Connection Mode" := send_funds_transfer_request_operation_parameters_connection_mode.AsValue.AsText;
        SkyATMTransactions."Saccolink Transaction Type" := "Saccolink Transaction Types".FromInteger(send_funds_transfer_request_operation_parameters_transaction_type.AsValue.AsInteger);
        SkyATMTransactions."Original Message ID" := send_funds_transfer_request_operation_parameters_original_message_id.AsValue.AsText;
        SkyATMTransactions."Credit Account" := send_funds_transfer_request_posting_credit_account.AsValue.AsText;
        SkyATMTransactions.Amount := send_funds_transfer_request_posting_amount.AsValue.AsDecimal;
        SkyATMTransactions.Currency := send_funds_transfer_request_posting_currency.AsValue.AsText;
        SkyATMTransactions."Debit Account" := send_funds_transfer_request_posting_debit_account.AsValue.AsText;
        SkyATMTransactions."Institution Code" := send_funds_transfer_request_institution_institution_code.AsValue.AsText;
        SkyATMTransactions."Institution Name" := send_funds_transfer_request_institution_institution_name.AsValue.AsText;
        SkyATMTransactions."Charge Amount" := send_funds_transfer_request_posting_charge_amount.AsValue.AsDecimal;
        SkyATMTransactions."Charge Currency" := send_funds_transfer_request_posting_charge_currency.AsValue.AsText;
        SkyATMTransactions."Fee Amount" := send_funds_transfer_request_posting_fee_amount.AsValue.AsDecimal;
        SkyATMTransactions."Fee Currency" := send_funds_transfer_request_posting_fee_currency.AsValue.AsText;
        SkyATMTransactions."Transaction Narration" := send_funds_transfer_request_posting_narrative1.AsValue.AsText + '.' + send_funds_transfer_request_posting_narrarive2.AsValue.AsText;

        send_funds_transfer_request_additional_info.WriteTo(send_funds_transfer_request_additional_info_text);
        SkyATMTransactions."Additional Info" := send_funds_transfer_request_additional_info_text;

        SkyATMTransactions.Location := send_funds_transfer_request_operation_parameters_location.AsValue.AsText;

        SkyATMTransactions."API Request ID" := APIRequestID.AsValue.AsText;

        SkyATMTransactions."Transaction ID" := GlobalFunctions.CleanGuid;
        SkyATMTransactions."Transaction Date" := Today;
        SkyATMTransactions."Transaction Time" := Time;
        SkyATMTransactions.Posted := false;
        SkyATMTransactions."Member Savings Account" := MemberSavingsAccount."No.";
    end;

    procedure LogMiniStatement(
        var SkyATMTransactions: Record "Sky ATM Transactions Buffer";
        Payload: JsonObject;
        APIRequestID: JsonToken;
        var MemberSavingsAccount: Record "Savings Accounts"
    )
    var
        service_name: JsonToken;
        message_id: JsonToken;
        ministatement_request_operation_parameters_transaction_date: JsonToken;
        ministatement_request_operation_parameters_max_number_rows: JsonToken;
        ministatement_request_account_credit_account: JsonToken;
        ministatement_request_account_debit_account: JsonToken;
        ministatement_request_account_mobile_number: JsonToken;
        ministatement_request_institution_institution_code: JsonToken;
        ministatement_request_posting_charge_amount: JsonToken;
        ministatement_request_posting_charge_currency: JsonToken;
        ministatement_request_posting_fee_amount: JsonToken;
        ministatement_request_posting_fee_currency: JsonToken;
        ministatement_request_posting_narrative: JsonToken;
        ministatement_request_operation_parameters_terminal_id: JsonToken;
        ministatement_request_operation_parameters_channel: JsonToken;
        ministatement_request_operation_parameters_location: JsonToken;

        ministatement_request_additional_info: JsonToken;
        ministatement_request_additional_info_text: Text;
    begin
        Payload.Get('service_name', service_name);
        Payload.Get('message_id', message_id);

        Payload.SelectToken('$.ministatement_request.operation_parameters.transaction_date', ministatement_request_operation_parameters_transaction_date);
        Payload.SelectToken('$.ministatement_request.operation_parameters.max_number_rows', ministatement_request_operation_parameters_max_number_rows);
        Payload.SelectToken('$.ministatement_request.operation_parameters.terminal_id', ministatement_request_operation_parameters_terminal_id);
        Payload.SelectToken('$.ministatement_request.operation_parameters.channel', ministatement_request_operation_parameters_channel);
        Payload.SelectToken('$.ministatement_request.operation_parameters.location', ministatement_request_operation_parameters_location);
        Payload.SelectToken('$.ministatement_request.account.credit_account', ministatement_request_account_credit_account);
        Payload.SelectToken('$.ministatement_request.account.debit_account', ministatement_request_account_debit_account);
        Payload.SelectToken('$.ministatement_request.account.mobile_number', ministatement_request_account_mobile_number);
        Payload.SelectToken('$.ministatement_request.institution.institution_code', ministatement_request_institution_institution_code);
        Payload.SelectToken('$.ministatement_request.posting.charge_amount', ministatement_request_posting_charge_amount);
        Payload.SelectToken('$.ministatement_request.posting.charge_currency', ministatement_request_posting_charge_currency);
        Payload.SelectToken('$.ministatement_request.posting.fee_amount', ministatement_request_posting_fee_amount);
        Payload.SelectToken('$.ministatement_request.posting.fee_currency', ministatement_request_posting_fee_currency);
        Payload.SelectToken('$.ministatement_request.posting.narrative', ministatement_request_posting_narrative);
        Payload.SelectToken('$.ministatement_request.additional_info', ministatement_request_additional_info);

        SkyATMTransactions.Init;

        SkyATMTransactions."Service Name" := service_name.AsValue.AsText;
        SkyATMTransactions."Message ID" := message_id.AsValue.AsText;

        Evaluate(SkyATMTransactions."Transaction Date Time", ministatement_request_operation_parameters_transaction_date.AsValue.AsText);
        // SkyATMTransactions."Transaction Date Time" := ministatement_request_operation_parameters_transaction_date.AsValue.AsDateTime;

        SkyATMTransactions."Terminal ID" := ministatement_request_operation_parameters_terminal_id.AsValue.AsText;
        SkyATMTransactions.Channel := ministatement_request_operation_parameters_channel.AsValue.AsText;
        SkyATMTransactions."Connection Mode" := '';
        SkyATMTransactions."Saccolink Transaction Type" := SkyATMTransactions."Saccolink Transaction Type"::"Mini Statement Sacco direct";
        SkyATMTransactions."Original Message ID" := '';
        SkyATMTransactions."Credit Account" := ministatement_request_account_credit_account.AsValue.AsText;
        SkyATMTransactions.Amount := 0;
        SkyATMTransactions.Currency := '';
        SkyATMTransactions."Debit Account" := ministatement_request_account_debit_account.AsValue.AsText;
        SkyATMTransactions."Institution Code" := ministatement_request_institution_institution_code.AsValue.AsText;
        SkyATMTransactions."Institution Name" := ministatement_request_institution_institution_code.AsValue.AsText;
        SkyATMTransactions."Charge Amount" := ministatement_request_posting_charge_amount.AsValue.AsDecimal;
        SkyATMTransactions."Charge Currency" := ministatement_request_posting_charge_currency.AsValue.AsText;
        SkyATMTransactions."Fee Amount" := ministatement_request_posting_fee_amount.AsValue.AsDecimal;
        SkyATMTransactions."Fee Currency" := ministatement_request_posting_fee_currency.AsValue.AsText;
        SkyATMTransactions."Transaction Narration" := ministatement_request_posting_narrative.AsValue.AsText;
        SkyATMTransactions."Mobile Number" := ministatement_request_account_mobile_number.AsValue.AsText;

        ministatement_request_additional_info.WriteTo(ministatement_request_additional_info_text);
        SkyATMTransactions."Additional Info" := ministatement_request_additional_info_text;

        SkyATMTransactions.Location := ministatement_request_operation_parameters_location.AsValue.AsText;

        SkyATMTransactions."API Request ID" := APIRequestID.AsValue.AsText;

        SkyATMTransactions."Transaction ID" := GlobalFunctions.CleanGuid;
        SkyATMTransactions."Transaction Date" := Today;
        SkyATMTransactions."Transaction Time" := Time;
        SkyATMTransactions.Posted := false;
        SkyATMTransactions."Member Savings Account" := MemberSavingsAccount."No.";
    end;

    procedure POSTATMTransactions(): Text
    var
        ATMTrans: Record "Sky ATM Transactions Buffer";
        ReversedATMTrans: Record "Sky ATM Transactions Buffer";
        DocNo: Text[20];
        theSMS: Text;
        TheMember: Record members;
        theTransactionType: Text;
        GLEntry: Record "G/L Entry";
        CurrCharges: List of [decimal];
        UserSetup: Record "User Setup";
        BankingUserSetup: Record "Banking User Template";

        Settings: Record "Sky Background Process Manager";

        TotalExciseDuty: Decimal;
    begin
        if Settings.FindFirst then begin
            if Settings."Disable ATM. Post" then begin
                exit('ATM transactions have been disabled at the moment');
            end;
        end;

        GenSetup.Get;

        if not BankingUserSetup.get(UserId) then begin
            Error('User ID = %1  not setup in BankingUserSetup', UserId);
        end;

        if not UserSetup.get(UserId) then begin
            Error('User ID = %1  not setup in UserSetup', UserId);
        end;

        // Check posting date is current!!!
        if UserSetup."Allow Posting From" <> Today then begin
            UserSetup."Allow Posting From" := Today;
            UserSetup.Modify;
        end;
        if UserSetup."Allow Posting To" <> Today then begin
            UserSetup."Allow Posting To" := Today;
            UserSetup.Modify;
        end;

        JTemplate := BankingUserSetup."Cashier Journal Template";
        JBatch := BankingUserSetup."Cashier Journal Batch";
        SaccoTransactions.INITJournal(Jtemplate, JBatch);
        SaccoTransactions.CreateJournalBatch(Jtemplate, JBatch);
        ATMTrans.reset;
        ATMTrans.SetRange(Posted, false);
        ATMTrans.SetRange("Is Coop Reversal", false);
        ATMTrans.SetCurrentKey("Try Posting Count", "Transaction Date Time");
        ATMTrans.SetAscending("Try Posting Count", true);
        ATMTrans.SetAscending("Transaction Date Time", true);
        if ATMTrans.FindSet(true) then begin
            repeat
                // Check for posting
                DocNo := CopyStr(ATMTrans."Message ID", 1, 20);

                GLEntry.Reset;
                GLEntry.SetRange("Document No.", DocNo);
                GLEntry.SetLoadFields("Entry No.");
                if GLEntry.FindFirst then begin
                    ATMTrans.Posted := true;
                    ATMTrans."Posting Remarks" := 'Posted';
                    ATMTrans."Posting Date" := Today;
                    ATMTrans."Posting Time" := time;
                    ATMTrans."Posted By" := UserID;
                    ATMTrans.Modify();

                    if (
                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::" ") or
                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"ATM Withdrawal") or
                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"ATM Utility") or
                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"POS Deposit") or
                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"POS Withdrawal") or
                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"POS Utility") or
                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"VISA ATM Withdrawal") or
                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"VISA Purchase")
                    ) then begin
                        if SavingsAcc.get(ATMTrans."Member Savings Account") then begin
                            if TheMember.Get(SavingsAcc."Member No.") then begin
                                theTransactionType := Format(ATMTrans."Transaction Type");
                                if (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::" ") then begin
                                    theTransactionType := 'ATM transaction';
                                end;
                                if ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"ATM Utility" then begin
                                    theTransactionType := 'ATM Utility payment';
                                end;
                                if ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"POS Utility" then begin
                                    theTransactionType := 'POS Utility payment';
                                end;
                                if (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"VISA Purchase") and (ATMTrans."Device Transaction Type" = ATMTrans."Device Transaction Type"::POS) then begin
                                    theTransactionType := 'POS Purchase';
                                end;

                                // SMS
                                if ATMTrans.Location <> '' then begin
                                    theSMS := 'Dear member, your ' + theTransactionType + ' request of KES ' +
                                    Format(ATMTrans."Charge Amount") +
                                    ' done at ' + ATMTrans.Location +
                                    ' on ' + GlobalFunctions.FormatISODateTime(ATMTrans."Transaction Date Time") +
                                    ' has been processed successfully. Transaction ID: ' +
                                    ATMTrans."Document No.";
                                end else begin
                                    theSMS := 'Dear member, your ' + theTransactionType + ' request of KES ' +
                                    Format(ATMTrans."Charge Amount") +
                                    ' done on ' + GlobalFunctions.FormatISODateTime(ATMTrans."Transaction Date Time") +
                                    ' has been processed successfully. Transaction ID: ' +
                                    ATMTrans."Document No.";
                                end;

                                SkySMS.SendSms(
                                    SMSSource::WITHDRAWAL,
                                    TheMember."Transactional Mobile Number",
                                    theSMS,
                                    ATMTrans."Document No.",
                                    '',
                                    true,
                                    0,
                                    true,
                                    'ATM',
                                    ATMTrans."Transaction ID",
                                    'CBS'
                                );
                            end;
                        end;
                    end;
                end else begin
                    TotalCharges := 0;
                    TotalExciseDuty := 0;

                    ATMTransactionType.Reset;
                    ATMTransactionType.SetRange("ATM Transaction Type", ATMTrans."Transaction Type");
                    ATMTransactionType.SetRange("Channel type", ATMTransactionType."Channel type"::ATM);
                    if ATMTransactionType.Find('-') then begin

                        if SavingsAcc.get(ATMTrans."Member Savings Account") then begin
                            case ATMTrans."Transaction Type" of
                                ATMTrans."Transaction Type"::"POS Deposit":
                                    DepMultiplier := -1;
                                else
                                    DepMultiplier := 1;
                            end;

                            AccType := Acctype::Savings;
                            AccNo := ATMTrans."Member Savings Account";
                            TransType := TransType::" ";
                            BalAccType := Balacctype::"Bank Account";
                            BalAccNo := ATMTransactionType."Bank Account";
                            Amt := ATMTrans."Charge Amount" * DepMultiplier;
                            LineNo := LineNo + 10000;
                            Descr := ATMTrans."Transaction Narration";
                            Descr := CopyStr(Descr, 1, 50);
                            DocNo := CopyStr(ATMTrans."Message ID", 1, 20);

                            if Descr = '' then begin
                                Descr := 'Saccolink Transaction';
                                ATMTrans."Transaction Narration" := Descr;
                                ATMTrans.Modify;
                            end;

                            if Amt <> 0 then begin
                                JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, DocNo, Descr, Amt, AccNo, Today, BalAccType,
                              BalAccNo, '', SavingsAcc."Global Dimension 1 Code", SavingsAcc."Global Dimension 2 Code", TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account",
                               '', "Gen. Journal Account Type"::"G/L Account");
                            end;

                            //To handle charges here
                            // Charges if Any
                            MobileTransLines.Reset();
                            MobileTransLines.SetRange("Transaction Type", ATMTransactionType.Code);
                            TotalCharges := 0;

                            if MobileTransLines.FindSet then begin
                                repeat
                                    CurrCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, ATMTrans."Charge Amount");
                                    if CurrCharges.Get(1) > 0 then begin
                                        SaccoTransactions.JournalInsert(JTemplate, JBatch, DocNo, Today, MobileTransLines."Account Type",
                                        MobileTransLines."Account No.", MobileTransLines.Description, AccType::"G/L Account", '',
                                         -(CurrCharges.Get(1) - CurrCharges.Get(2)), DocNo, '',
                                        TransType, SavingsAcc."Global Dimension 1 Code", SavingsAcc."Global Dimension 2 Code", true);

                                        TotalCharges += CurrCharges.Get(1);

                                        if MobileTransLines."Recover Excise Duty" then begin
                                            SaccoTransactions.JournalInsert(JTemplate, JBatch, DocNo, Today, AccType::"G/L Account", genSetUp."Excise Duty G/L",
                                         'Excise duty - ' + MobileTransLines.Description, MobileTransLines."Account Type", /*MobileTransLines."Account No."*/ '',
                                          -CurrCharges.Get(2), DocNo, '',
                                          TransType, SavingsAcc."Global Dimension 1 Code", SavingsAcc."Global Dimension 2 Code", true);

                                          TotalExciseDuty += currCharges.Get(2);
                                        end;
                                    end;
                                until MobileTransLines.next = 0;

                                if TotalCharges > 0 then begin
                                    SaccoTransactions.JournalInsert(JTemplate, JBatch, DocNo, Today, AccType::Savings, SavingsAcc."No.",
                                    ATMTransactionType.Description, AccType::"G/L Account", '', (TotalCharges - TotalExciseDuty), DocNo,
                                    '', TransType, SavingsAcc."Global Dimension 1 Code", SavingsAcc."Global Dimension 2 Code", true);

                                    if TotalExciseDuty > 0 then begin
                                        SaccoTransactions.JournalInsert(JTemplate, JBatch, DocNo, Today, AccType::Savings, SavingsAcc."No.",
                                    CopyStr(ATMTransactionType.Description + ' - Excise Duty', 1, 150), AccType::"G/L Account", '', TotalExciseDuty, DocNo,
                                    '', TransType, SavingsAcc."Global Dimension 1 Code", SavingsAcc."Global Dimension 2 Code", true);
                                    end;
                                end;
                            end;

                            if SaccoTransactions.PostJournal(JTemplate, JBatch) then begin
                                ATMTrans.Posted := true;
                                ATMTrans."Posting Date" := Today;
                                ATMTrans."Posting Time" := time;
                                ATMTrans."Posted By" := UserID;
                                ATMTrans.Modify();

                                if (
                                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::" ") or
                                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"ATM Withdrawal") or
                                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"ATM Utility") or
                                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"POS Deposit") or
                                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"POS Withdrawal") or
                                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"POS Utility") or
                                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"VISA ATM Withdrawal") or
                                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"VISA Purchase")
                                ) then begin
                                    TheMember.Get(SavingsAcc."Member No.");

                                    theTransactionType := Format(ATMTrans."Transaction Type");
                                    if (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::" ") then begin
                                        theTransactionType := 'ATM transaction';
                                    end;
                                    if ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"ATM Utility" then begin
                                        theTransactionType := 'ATM Utility payment';
                                    end;
                                    if ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"POS Utility" then begin
                                        theTransactionType := 'POS Utility payment';
                                    end;
                                    if (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"VISA Purchase") and (ATMTrans."Device Transaction Type" = ATMTrans."Device Transaction Type"::POS) then begin
                                        theTransactionType := 'POS Purchase';
                                    end;

                                    // SMS
                                    if ATMTrans.Location <> '' then begin
                                        theSMS := 'Dear member, your ' + theTransactionType + ' request of KES ' +
                                        Format(ATMTrans."Charge Amount") +
                                        ' done at ' + ATMTrans.Location +
                                        ' on ' + GlobalFunctions.FormatISODateTime(ATMTrans."Transaction Date Time") +
                                        ' has been processed successfully. Transaction ID: ' +
                                        ATMTrans."Document No.";
                                    end else begin
                                        theSMS := 'Dear member, your ' + theTransactionType + ' request of KES ' +
                                        Format(ATMTrans."Charge Amount") +
                                        ' done on ' + GlobalFunctions.FormatISODateTime(ATMTrans."Transaction Date Time") +
                                        ' has been processed successfully. Transaction ID: ' +
                                        ATMTrans."Document No.";
                                    end;

                                    SkySMS.SendSms(
                                        SMSSource::WITHDRAWAL,
                                        TheMember."Transactional Mobile Number",
                                        theSMS,
                                        ATMTrans."Document No.",
                                        '',
                                        true,
                                        0,
                                        true,
                                        'ATM',
                                        ATMTrans."Transaction ID",
                                        'CBS'
                                    );
                                end;

                            end else begin
                                GLEntry.Reset;

                                GLEntry.SetRange("Document No.", DocNo);
                                GLEntry.SetLoadFields("Entry No.");
                                if GLEntry.FindFirst then begin
                                    ATMTrans.Posted := true;
                                    ATMTrans."Posting Remarks" := 'Posted';
                                    ATMTrans."Posting Date" := Today;
                                    ATMTrans."Posting Time" := time;
                                    ATMTrans."Posted By" := UserID;
                                    ATMTrans.Modify();

                                    if (
                                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::" ") or
                                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"ATM Withdrawal") or
                                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"ATM Utility") or
                                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"POS Deposit") or
                                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"POS Withdrawal") or
                                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"POS Utility") or
                                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"VISA ATM Withdrawal") or
                                    (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"VISA Purchase")
                                    ) then begin
                                        TheMember.Get(SavingsAcc."Member No.");

                                        theTransactionType := Format(ATMTrans."Transaction Type");
                                        if (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::" ") then begin
                                            theTransactionType := 'ATM transaction';
                                        end;
                                        if ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"ATM Utility" then begin
                                            theTransactionType := 'ATM Utility payment';
                                        end;
                                        if ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"POS Utility" then begin
                                            theTransactionType := 'POS Utility payment';
                                        end;
                                        if (ATMTrans."Transaction Type" = ATMTrans."Transaction Type"::"VISA Purchase") and (ATMTrans."Device Transaction Type" = ATMTrans."Device Transaction Type"::POS) then begin
                                            theTransactionType := 'POS Purchase';
                                        end;

                                        // SMS
                                        if ATMTrans.Location <> '' then begin
                                            theSMS := 'Dear member, your ' + theTransactionType + ' request of KES ' +
                                            Format(ATMTrans."Charge Amount") +
                                            ' done at ' + ATMTrans.Location +
                                            ' on ' + GlobalFunctions.FormatISODateTime(ATMTrans."Transaction Date Time") +
                                            ' has been processed successfully. Transaction ID: ' +
                                            ATMTrans."Document No.";
                                        end else begin
                                            theSMS := 'Dear member, your ' + theTransactionType + ' request of KES ' +
                                            Format(ATMTrans."Charge Amount") +
                                            ' done on ' + GlobalFunctions.FormatISODateTime(ATMTrans."Transaction Date Time") +
                                            ' has been processed successfully. Transaction ID: ' +
                                            ATMTrans."Document No.";
                                        end;

                                        SkySMS.SendSms(
                                            SMSSource::WITHDRAWAL,
                                            TheMember."Transactional Mobile Number",
                                            theSMS,
                                            ATMTrans."Document No.",
                                            '',
                                            true,
                                            0,
                                            true,
                                            'ATM',
                                            ATMTrans."Transaction ID",
                                            'CBS'
                                        );
                                    end;
                                end else begin
                                    if (Amt = 0) and (TotalCharges = 0) then begin
                                        ATMTrans.Posted := true;
                                        ATMTrans."Posting Remarks" := 'Posted with amount = ' + Format(Amt) + ' and total charges = ' + Format(TotalCharges);
                                        ATMTrans."Posting Date" := Today;
                                        ATMTrans."Posting Time" := time;
                                        ATMTrans."Posted By" := UserID;
                                        ATMTrans.Modify();
                                    end else begin
                                        ATMTrans."Try Posting Count" := ATMTrans."Try Posting Count" + 1;
                                        ATMTrans.Posted := false;
                                        ATMTrans."Posting Remarks" := 'The record cound not able to post, check for technical errors.';
                                        ATMTrans."Posted By" := UserID;
                                        ATMTrans.Modify();
                                    end;
                                end;
                            end;
                        end else begin
                            ATMTrans."Try Posting Count" := ATMTrans."Try Posting Count" + 1;
                            ATMTrans."Posting Remarks" := 'Failed: Savings Account not found.';
                            ATMTrans.Posted := false;
                            ATMTrans."Posting Date" := Today;
                            ATMTrans."Posting Time" := time;
                            ATMTrans."Posted By" := UserID;
                            ATMTrans.Modify;
                        end;

                    end else begin
                        ATMTrans."Try Posting Count" := ATMTrans."Try Posting Count" + 1;
                        ATMTrans.Posted := false;
                        ATMTrans."Posting Remarks" := 'Posting Failed: Related transaction type = ' + Format(ATMTrans."Transaction Type") + ' not found.';
                        ATMTrans."Posted By" := UserID;
                        ATMTrans.Modify;
                    end;
                end;
            until ATMTrans.Next = 0;
        end;

        // REVERSALS
        ATMTrans.reset;
        ATMTrans.SetRange(Posted, false);
        ATMTrans.SetRange("Is Coop Reversal", true);
        ATMTrans.SetCurrentKey("Try Posting Count", "Transaction Date Time");
        ATMTrans.SetAscending("Try Posting Count", true);
        ATMTrans.SetAscending("Transaction Date Time", true);
        if ATMTrans.FindSet(true) then begin
            repeat begin
                // Check for posting
                DocNo := CopyStr('R' + ATMTrans."Message ID", 1, 20);

                GLEntry.Reset;
                GLEntry.SetRange("Document No.", DocNo);
                GLEntry.SetLoadFields("Entry No.");
                if GLEntry.FindFirst then begin

                    ReversedATMTrans.Reset;
                    ReversedATMTrans.SetFilter("Message ID", '=%1|%2', ATMTrans."Original Message ID", ATMTrans."Message ID");
                    ReversedATMTrans.SetRange(Posted, true);
                    ReversedATMTrans.SetRange(Reversed, false);
                    ReversedATMTrans.SetRange("Is Coop Reversal", false);

                    if ReversedATMTrans.FindFirst then begin
                        ATMTrans.Posted := true;
                        ATMTrans."Posting Remarks" := 'Posted';
                        ATMTrans."Posting Date" := Today;
                        ATMTrans."Posting Time" := time;
                        ATMTrans."Posted By" := UserID;
                        ATMTrans.Modify();

                        ReversedATMTrans.Reversed := true;
                        ReversedATMTrans."Reversed Date" := Today;
                        ReversedATMTrans."Reversed Time" := time;
                        ReversedATMTrans."Reversed By" := UserID;
                        ReversedATMTrans.Modify();

                        if (
                        (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::" ") or
                        (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"ATM Withdrawal") or
                        (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"ATM Utility") or
                        (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"POS Deposit") or
                        (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"POS Withdrawal") or
                        (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"POS Utility") or
                        (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"VISA ATM Withdrawal") or
                        (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"VISA Purchase")
                        ) then begin
                            if SavingsAcc.get(ATMTrans."Member Savings Account") then begin
                                if TheMember.Get(SavingsAcc."Member No.") then begin
                                    theTransactionType := Format(ReversedATMTrans."Transaction Type");
                                    if (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::" ") then begin
                                        theTransactionType := 'ATM transaction';
                                    end;
                                    if ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"ATM Utility" then begin
                                        theTransactionType := 'ATM Utility payment';
                                    end;
                                    if ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"POS Utility" then begin
                                        theTransactionType := 'POS Utility payment';
                                    end;
                                    if (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"VISA Purchase") and
                                (ReversedATMTrans."Device Transaction Type" = ReversedATMTrans."Device Transaction Type"::POS) then begin
                                        theTransactionType := 'POS Purchase';
                                    end;

                                    // SMS
                                    if ReversedATMTrans.Location <> '' then begin
                                        theSMS := 'Dear member, your ' + theTransactionType + ' request of KES ' +
                                            Format(ReversedATMTrans."Charge Amount") +
                                            ' done at ' + ReversedATMTrans.Location +
                                            ' on ' + GlobalFunctions.FormatISODateTime(ReversedATMTrans."Transaction Date Time") +
                                            ' has been reversed successfully. Transaction ID: ' +
                                            ReversedATMTrans."Document No.";
                                    end else begin
                                        theSMS := 'Dear member, your ' + theTransactionType + ' request of KES ' +
                                        Format(ReversedATMTrans."Charge Amount") +
                                        ' done on ' + GlobalFunctions.FormatISODateTime(ReversedATMTrans."Transaction Date Time") +
                                        ' has been reversed successfully. Transaction ID: ' +
                                        ReversedATMTrans."Document No.";
                                    end;

                                    SkySMS.SendSms(
                                        SMSSource::WITHDRAWAL,
                                        TheMember."Transactional Mobile Number",
                                        theSMS,
                                        ReversedATMTrans."Document No.",
                                        '',
                                        true,
                                        0,
                                        true,
                                        'ATM',
                                        ReversedATMTrans."Transaction ID",
                                        'CBS'
                                    );
                                end;
                            end;
                        end;
                    end else begin
                        ATMTrans."Try Posting Count" := ATMTrans."Try Posting Count" + 1;
                        ATMTrans.Posted := true;
                        ATMTrans."Posting Remarks" := 'Failed: Transaction to reverse NOT found or has already been reversed';
                        ATMTrans."Posted By" := UserID;
                        ATMTrans.Modify;
                    end;

                end else begin

                    TotalCharges := 0;

                    ReversedATMTrans.Reset;
                    ReversedATMTrans.SetFilter("Message ID", '=%1|%2', ATMTrans."Original Message ID", ATMTrans."Message ID");
                    ReversedATMTrans.SetRange(Posted, true);
                    ReversedATMTrans.SetRange(Reversed, false);
                    ReversedATMTrans.SetRange("Is Coop Reversal", false);

                    if ReversedATMTrans.FindFirst then begin
                        ATMTransactionType.Reset;
                        ATMTransactionType.SetRange("ATM Transaction Type", ReversedATMTrans."Transaction Type");
                        ATMTransactionType.SetRange("Channel type", ATMTransactionType."Channel type"::ATM);
                        if ATMTransactionType.Find('-') then begin

                            if SavingsAcc.get(ReversedATMTrans."Member Savings Account") then begin
                                case ReversedATMTrans."Transaction Type" of
                                    ReversedATMTrans."Transaction Type"::"POS Deposit":
                                        DepMultiplier := -1;
                                    else
                                        DepMultiplier := 1;
                                end;

                                AccType := Acctype::Savings;
                                AccNo := ReversedATMTrans."Member Savings Account";
                                TransType := TransType::" ";
                                BalAccType := Balacctype::"Bank Account";
                                BalAccNo := ATMTransactionType."Bank Account";
                                Amt := ReversedATMTrans."Charge Amount";
                                LineNo := LineNo + 10000;
                                Descr := 'Reversal:' + ReversedATMTrans."Transaction Narration";
                                Descr := CopyStr(Descr, 1, 50);
                                DocNo := CopyStr('R' + ATMTrans."Message ID", 1, 20);

                                if Amt <> 0 then begin
                                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType, DocNo, Descr, -Amt, AccNo, Today, BalAccType,
                                  BalAccNo, '', SavingsAcc."Global Dimension 1 Code", SavingsAcc."Global Dimension 2 Code", TransType, '', '', '', "Gen. Journal Account Type"::"G/L Account",
                                   '', "Gen. Journal Account Type"::"G/L Account");
                                end;

                                //To handle charges here
                                // Charges if Any
                                MobileTransLines.Reset();
                                MobileTransLines.SetRange("Transaction Type", ATMTransactionType.Code);
                                if MobileTransLines.FindSet then begin
                                    TotalCharges := 0;
                                    repeat
                                        CurrCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, ReversedATMTrans."Charge Amount");

                                        if CurrCharges.Get(1) > 0 then begin
                                            SaccoTransactions.JournalInsert(JTemplate, JBatch, DocNo, Today, MobileTransLines."Account Type",
                                        MobileTransLines."Account No.", 'Reversal: ' + MobileTransLines.Description, AccType::"G/L Account", '',
                                         (CurrCharges.Get(1) - CurrCharges.Get(2)), DocNo, '',
                                        TransType, SavingsAcc."Global Dimension 1 Code", SavingsAcc."Global Dimension 2 Code", true);

                                            TotalCharges += CurrCharges.Get(1);

                                            if MobileTransLines."Recover Excise Duty" then begin
                                                SaccoTransactions.JournalInsert(JTemplate, JBatch, DocNo, Today, AccType::"G/L Account", genSetUp."Excise Duty G/L",
                                                 'Reversal: Excise duty - ' + MobileTransLines.Description, MobileTransLines."Account Type", ''/*MobileTransLines."Account No."*/,
                                                  CurrCharges.Get(2), DocNo, '',
                                                  TransType, SavingsAcc."Global Dimension 1 Code", SavingsAcc."Global Dimension 2 Code", true);
                                            end;
                                        end;
                                    until MobileTransLines.next = 0;

                                    if TotalCharges > 0 then begin
                                        SaccoTransactions.JournalInsert(JTemplate, JBatch, DocNo, Today, AccType::Savings, SavingsAcc."No.",
                                     'Reversal: ' + ATMTransactionType.Description, AccType::"G/L Account", '', -TotalCharges, DocNo,
                                      '', TransType, SavingsAcc."Global Dimension 1 Code", SavingsAcc."Global Dimension 2 Code", true);
                                    end;
                                end;

                                if SaccoTransactions.PostJournal(JTemplate, JBatch) then begin
                                    ATMTrans.Posted := true;
                                    ATMTrans."Posting Date" := Today;
                                    ATMTrans."Posting Time" := time;
                                    ATMTrans."Posted By" := UserID;
                                    ATMTrans.Modify();

                                    ReversedATMTrans.Reversed := true;
                                    ReversedATMTrans."Reversed Date" := Today;
                                    ReversedATMTrans."Reversed Time" := time;
                                    ReversedATMTrans."Reversed By" := UserID;
                                    ReversedATMTrans.Modify();

                                    if (
                                    (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::" ") or
                                    (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"ATM Withdrawal") or
                                    (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"ATM Utility") or
                                    (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"POS Deposit") or
                                    (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"POS Withdrawal") or
                                    (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"POS Utility") or
                                    (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"VISA ATM Withdrawal") or
                                    (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"VISA Purchase")
                                ) then begin
                                        TheMember.Get(SavingsAcc."Member No.");

                                        theTransactionType := Format(ReversedATMTrans."Transaction Type");
                                        if (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::" ") then begin
                                            theTransactionType := 'ATM transaction';
                                        end;
                                        if ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"ATM Utility" then begin
                                            theTransactionType := 'ATM Utility payment';
                                        end;
                                        if ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"POS Utility" then begin
                                            theTransactionType := 'POS Utility payment';
                                        end;
                                        if (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"VISA Purchase") and
                                        (ReversedATMTrans."Device Transaction Type" = ReversedATMTrans."Device Transaction Type"::POS) then begin
                                            theTransactionType := 'POS Purchase';
                                        end;

                                        // SMS
                                        if ReversedATMTrans.Location <> '' then begin
                                            theSMS := 'Dear member, your ' + theTransactionType + ' request of KES ' +
                                             Format(ReversedATMTrans."Charge Amount") +
                                             ' done at ' + ReversedATMTrans.Location +
                                             ' on ' + GlobalFunctions.FormatISODateTime(ReversedATMTrans."Transaction Date Time") +
                                             ' has been reversed successfully. Transaction ID: ' +
                                             ReversedATMTrans."Document No.";
                                        end else begin
                                            theSMS := 'Dear member, your ' + theTransactionType + ' request of KES ' +
                                            Format(ReversedATMTrans."Charge Amount") +
                                            ' done on ' + GlobalFunctions.FormatISODateTime(ReversedATMTrans."Transaction Date Time") +
                                            ' has been reversed successfully. Transaction ID: ' +
                                            ReversedATMTrans."Document No.";
                                        end;


                                        SkySMS.SendSms(
                                            SMSSource::WITHDRAWAL,
                                            TheMember."Transactional Mobile Number",
                                            theSMS,
                                            ReversedATMTrans."Document No.",
                                            '',
                                            true,
                                            0,
                                            true,
                                            'ATM',
                                            ReversedATMTrans."Transaction ID",
                                            'CBS'
                                        );
                                    end;
                                end else begin
                                    GLEntry.Reset;

                                    GLEntry.SetRange("Document No.", DocNo);
                                    GLEntry.SetLoadFields("Entry No.");
                                    if GLEntry.FindFirst then begin
                                        ATMTrans.Posted := true;
                                        ATMTrans."Posting Remarks" := 'Posted';
                                        ATMTrans."Posting Date" := Today;
                                        ATMTrans."Posting Time" := time;
                                        ATMTrans."Posted By" := UserID;
                                        ATMTrans.Modify();

                                        ReversedATMTrans.Reversed := true;
                                        ReversedATMTrans."Reversed Date" := Today;
                                        ReversedATMTrans."Reversed Time" := time;
                                        ReversedATMTrans."Reversed By" := UserID;
                                        ReversedATMTrans.Modify();

                                        if (
                                        (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::" ") or
                                        (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"ATM Withdrawal") or
                                        (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"ATM Utility") or
                                        (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"POS Deposit") or
                                        (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"POS Withdrawal") or
                                        (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"POS Utility") or
                                        (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"VISA ATM Withdrawal") or
                                        (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"VISA Purchase")
                                        ) then begin
                                            TheMember.Get(SavingsAcc."Member No.");

                                            theTransactionType := Format(ReversedATMTrans."Transaction Type");
                                            if (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::" ") then begin
                                                theTransactionType := 'ATM transaction';
                                            end;
                                            if ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"ATM Utility" then begin
                                                theTransactionType := 'ATM Utility payment';
                                            end;
                                            if ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"POS Utility" then begin
                                                theTransactionType := 'POS Utility payment';
                                            end;
                                            if (ReversedATMTrans."Transaction Type" = ReversedATMTrans."Transaction Type"::"VISA Purchase") and
                                        (ReversedATMTrans."Device Transaction Type" = ReversedATMTrans."Device Transaction Type"::POS) then begin
                                                theTransactionType := 'POS Purchase';
                                            end;

                                            // SMS
                                            if ReversedATMTrans.Location <> '' then begin
                                                theSMS := 'Dear member, your ' + theTransactionType + ' request of KES ' +
                                                    Format(ReversedATMTrans."Charge Amount") +
                                                    ' done at ' + ReversedATMTrans.Location +
                                                    ' on ' + GlobalFunctions.FormatISODateTime(ReversedATMTrans."Transaction Date Time") +
                                                    ' has been reversed successfully. Transaction ID: ' +
                                                    ReversedATMTrans."Document No.";
                                            end else begin
                                                theSMS := 'Dear member, your ' + theTransactionType + ' request of KES ' +
                                                Format(ReversedATMTrans."Charge Amount") +
                                                ' done on ' + GlobalFunctions.FormatISODateTime(ReversedATMTrans."Transaction Date Time") +
                                                ' has been reversed successfully. Transaction ID: ' +
                                                ReversedATMTrans."Document No.";
                                            end;

                                            SkySMS.SendSms(
                                                SMSSource::WITHDRAWAL,
                                                TheMember."Transactional Mobile Number",
                                                theSMS,
                                                ReversedATMTrans."Document No.",
                                                '',
                                                true,
                                                0,
                                                true,
                                                'ATM',
                                                ReversedATMTrans."Transaction ID",
                                                'CBS'
                                            );
                                        end;
                                    end else begin
                                        ATMTrans."Try Posting Count" := ATMTrans."Try Posting Count" + 1;
                                        ATMTrans.Posted := false;
                                        ATMTrans."Posting Remarks" := 'The record cound not able to post, check for technical errors.';
                                        ATMTrans."Posted By" := UserID;
                                        ATMTrans.Modify();
                                    end;
                                end;
                            end else begin
                                ATMTrans."Try Posting Count" := ATMTrans."Try Posting Count" + 1;
                                ATMTrans."Posting Remarks" := 'Failed: Savings Account not found.';
                                ATMTrans.Posted := false;
                                ATMTrans."Posting Date" := Today;
                                ATMTrans."Posting Time" := time;
                                ATMTrans."Posted By" := UserID;
                                ATMTrans.Modify;

                            end;

                        end else begin
                            ATMTrans."Try Posting Count" := ATMTrans."Try Posting Count" + 1;
                            ATMTrans.Posted := false;
                            ATMTrans."Posting Remarks" := 'Failed: Related transaction type = ' + Format(ATMTrans."Transaction Type") + ' not found.';
                            ATMTrans."Posted By" := UserID;
                            ATMTrans.Modify;
                        end;

                    end else begin
                        ATMTrans."Try Posting Count" := ATMTrans."Try Posting Count" + 1;
                        ATMTrans.Posted := true;
                        ATMTrans."Posting Remarks" := 'Failed: Transaction to reverse NOT found or has already been reversed';
                        ATMTrans."Posted By" := UserID;
                        ATMTrans.Modify;
                    end;

                end;
            end until ATMTrans.Next = 0;
        end;

        exit('Request has been processed successfully');
    end;

    // ATM withdrawal limits...
    procedure GetTransChargesPreview(
        ChargeAmount: Decimal;
        "Terminal ID": Text[50];
        Channel: Text[50];
        SaccolinkTransactionType: Integer
    ): Decimal
    var
        CurrCharges: List of [Decimal];
        ATMTransactionType: Record "Mobile Transaction Types";
        TerminalType: Text;
        "Saccolink Transaction Type": enum "Saccolink Transaction Types";
    begin
        "Saccolink Transaction Type" := "Saccolink Transaction Types".FromInteger(SaccolinkTransactionType);

        TerminalType := CopyStr("Terminal ID", 1, 3).ToUpper();
        case TerminalType of
            'ATM':
                begin
                    if "Saccolink Transaction Type" = "Saccolink Transaction Type"::"Balance Enquiry_Sacco_Direct" then begin
                        ATMTransactionType.SetRange("ATM Transaction Type", ATMTransactionType."ATM Transaction Type"::"ATM Balance");
                    end else
                        if ("Saccolink Transaction Type" = "Saccolink Transaction Type"::"Cash Withdrawal") or
                        ("Saccolink Transaction Type" = "Saccolink Transaction Type"::"Cardless ATM withdrawal") then begin
                            ATMTransactionType.SetRange("ATM Transaction Type", ATMTransactionType."ATM Transaction Type"::"ATM Withdrawal");
                        end else
                            if "Saccolink Transaction Type" = "Saccolink Transaction Type"::"Mini Statement Sacco direct" then begin
                                ATMTransactionType.SetRange("ATM Transaction Type", ATMTransactionType."ATM Transaction Type"::"ATM Ministatement");
                            end else begin
                                case "Saccolink Transaction Type" of
                                    "Saccolink Transaction Type"::"KPLC prepaid",
                                    "Saccolink Transaction Type"::"KPLC postpaid",
                                    "Saccolink Transaction Type"::DSTV,
                                    "Saccolink Transaction Type"::ZUKU,
                                    "Saccolink Transaction Type"::"Safaricom Airtime purchase",
                                    "Saccolink Transaction Type"::"Airtel Airtime purchase",
                                    "Saccolink Transaction Type"::"Nairobi water bill payment":
                                        begin
                                            ATMTransactionType.SetRange("ATM Transaction Type", ATMTransactionType."ATM Transaction Type"::"ATM Utility");
                                        end;
                                    else
                                        // "Transaction Type" := "Transaction Type"::" ";
                                        // "Transaction Narration" := 'Other ATM transaction';
                                        exit(0);
                                end;
                            end;
                end;
            'POS':
                begin
                    if "Saccolink Transaction Type" = "Saccolink Transaction Type"::"Balance Enquiry_Sacco_Direct" then begin
                        ATMTransactionType.SetRange("ATM Transaction Type", ATMTransactionType."ATM Transaction Type"::"POS Balance");
                    end else
                        if ("Saccolink Transaction Type" = "Saccolink Transaction Type"::"Cash Withdrawal") or
                        ("Saccolink Transaction Type" = "Saccolink Transaction Type"::"Cardless ATM withdrawal") then begin
                            ATMTransactionType.SetRange("ATM Transaction Type", ATMTransactionType."ATM Transaction Type"::"POS Withdrawal");
                        end else
                            if "Saccolink Transaction Type" = "Saccolink Transaction Type"::"Mini Statement Sacco direct" then begin
                                ATMTransactionType.SetRange("ATM Transaction Type", ATMTransactionType."ATM Transaction Type"::"POS Ministatement");
                            end else
                                if "Saccolink Transaction Type" = "Saccolink Transaction Type"::"POS Cash deposit" then begin
                                    ATMTransactionType.SetRange("ATM Transaction Type", ATMTransactionType."ATM Transaction Type"::"POS Deposit");
                                end else begin
                                    case "Saccolink Transaction Type" of
                                        "Saccolink Transaction Type"::"KPLC prepaid",
                                        "Saccolink Transaction Type"::"KPLC postpaid",
                                        "Saccolink Transaction Type"::DSTV,
                                        "Saccolink Transaction Type"::ZUKU,
                                        "Saccolink Transaction Type"::"Safaricom Airtime purchase",
                                        "Saccolink Transaction Type"::"Airtel Airtime purchase",
                                        "Saccolink Transaction Type"::"Nairobi water bill payment":
                                            begin
                                                ATMTransactionType.SetRange("ATM Transaction Type", ATMTransactionType."ATM Transaction Type"::"POS Utility");
                                            end;
                                        else
                                            // "Transaction Type" := "Transaction Type"::" ";
                                            // "Transaction Narration" := 'Other ATM transaction';
                                            exit(0);
                                    end;
                                end;
                end;
            else begin
                TerminalType := CopyStr(Channel, 1, 3).ToUpper();

                case TerminalType of
                    'ATM':
                        begin
                            if "Saccolink Transaction Type" = "Saccolink Transaction Type"::"Balance Enquiry_Sacco_Direct" then begin
                                ATMTransactionType.SetRange("ATM Transaction Type", ATMTransactionType."ATM Transaction Type"::"ATM Balance");
                            end else
                                if ("Saccolink Transaction Type" = "Saccolink Transaction Type"::"Cash Withdrawal") or
                                ("Saccolink Transaction Type" = "Saccolink Transaction Type"::"Cardless ATM withdrawal") then begin
                                    ATMTransactionType.SetRange("ATM Transaction Type", ATMTransactionType."ATM Transaction Type"::"ATM Withdrawal");
                                end else
                                    if "Saccolink Transaction Type" = "Saccolink Transaction Type"::"Mini Statement Sacco direct" then begin
                                        ATMTransactionType.SetRange("ATM Transaction Type", ATMTransactionType."ATM Transaction Type"::"ATM Ministatement");
                                    end else begin
                                        case "Saccolink Transaction Type" of
                                            "Saccolink Transaction Type"::"KPLC prepaid",
                                            "Saccolink Transaction Type"::"KPLC postpaid",
                                            "Saccolink Transaction Type"::DSTV,
                                            "Saccolink Transaction Type"::ZUKU,
                                            "Saccolink Transaction Type"::"Safaricom Airtime purchase",
                                            "Saccolink Transaction Type"::"Airtel Airtime purchase",
                                            "Saccolink Transaction Type"::"Nairobi water bill payment":
                                                begin
                                                    ATMTransactionType.SetRange("ATM Transaction Type", ATMTransactionType."ATM Transaction Type"::"ATM Utility");
                                                end;
                                            else
                                                // "Transaction Type" := "Transaction Type"::" ";
                                                // "Transaction Narration" := 'Other ATM transaction';
                                                exit(0);
                                        end;
                                    end;
                        end;
                    'POS':
                        begin
                            if "Saccolink Transaction Type" = "Saccolink Transaction Type"::"Balance Enquiry_Sacco_Direct" then begin
                                ATMTransactionType.SetRange("ATM Transaction Type", ATMTransactionType."ATM Transaction Type"::"POS Balance");
                            end else
                                if ("Saccolink Transaction Type" = "Saccolink Transaction Type"::"Cash Withdrawal") or
                                ("Saccolink Transaction Type" = "Saccolink Transaction Type"::"Cardless ATM withdrawal") then begin
                                    ATMTransactionType.SetRange("ATM Transaction Type", ATMTransactionType."ATM Transaction Type"::"POS Withdrawal");
                                end else
                                    if "Saccolink Transaction Type" = "Saccolink Transaction Type"::"Mini Statement Sacco direct" then begin
                                        ATMTransactionType.SetRange("ATM Transaction Type", ATMTransactionType."ATM Transaction Type"::"POS Ministatement");
                                    end else
                                        if "Saccolink Transaction Type" = "Saccolink Transaction Type"::"POS Cash deposit" then begin
                                            ATMTransactionType.SetRange("ATM Transaction Type", ATMTransactionType."ATM Transaction Type"::"POS Deposit");
                                        end else begin
                                            case "Saccolink Transaction Type" of
                                                "Saccolink Transaction Type"::"KPLC prepaid",
                                                "Saccolink Transaction Type"::"KPLC postpaid",
                                                "Saccolink Transaction Type"::DSTV,
                                                "Saccolink Transaction Type"::ZUKU,
                                                "Saccolink Transaction Type"::"Safaricom Airtime purchase",
                                                "Saccolink Transaction Type"::"Airtel Airtime purchase",
                                                "Saccolink Transaction Type"::"Nairobi water bill payment":
                                                    begin
                                                        ATMTransactionType.SetRange("ATM Transaction Type", ATMTransactionType."ATM Transaction Type"::"POS Utility");
                                                    end;
                                                else
                                                    // "Transaction Type" := "Transaction Type"::" ";
                                                    // "Transaction Narration" := 'Other ATM transaction';
                                                    exit(0);
                                            end;
                                        end;
                        end;
                    else
                        // VISA
                        if "Saccolink Transaction Type" = "Saccolink Transaction Type"::"Balance Enquiry_Sacco_Direct" then begin
                            ATMTransactionType.SetRange("ATM Transaction Type", ATMTransactionType."ATM Transaction Type"::"VISA ATM Balance");
                        end else
                            if ("Saccolink Transaction Type" = "Saccolink Transaction Type"::"Cash Withdrawal") or
                            ("Saccolink Transaction Type" = "Saccolink Transaction Type"::"Cardless ATM withdrawal") then begin
                                ATMTransactionType.SetRange("ATM Transaction Type", ATMTransactionType."ATM Transaction Type"::"VISA ATM Withdrawal");
                            end else
                                if "Saccolink Transaction Type" = "Saccolink Transaction Type"::"Mini Statement Sacco direct" then begin
                                    ATMTransactionType.SetRange("ATM Transaction Type", ATMTransactionType."ATM Transaction Type"::"VISA ATM Ministatement");
                                end else
                                    if "Saccolink Transaction Type" = "Saccolink Transaction Type"::"VISA purchases" then begin
                                        ATMTransactionType.SetRange("ATM Transaction Type", ATMTransactionType."ATM Transaction Type"::"VISA Purchase");
                                    end else begin
                                        // "Transaction Type" := "Transaction Type"::" ";
                                        // "Transaction Narration" := 'Other ATM transaction';
                                        exit(0);
                                    end;
                end;
            end;
        end;

        if ATMTransactionType.FindFirst then begin
            MobileTransLines.Reset();
            MobileTransLines.SetRange("Transaction Type", ATMTransactionType.Code);
            TotalCharges := 0;

            if MobileTransLines.FindSet then begin
                repeat
                    CurrCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, ChargeAmount);
                    if CurrCharges.Get(1) > 0 then begin
                        TotalCharges += CurrCharges.Get(1);
                    end;
                until MobileTransLines.next = 0;
            end;
        end;

        exit(TotalCharges);
    end;

    procedure ValidateMinAccountBalance(
        requestAmount: Decimal;
        var theSavingsAccount: Record "Savings Accounts";
        "Terminal ID": Text[50];
        Channel: Text[50];
        SaccolinkTransactionType: Integer
    ): Boolean
    var
        totalCost: Decimal;
    begin
        totalCost := GetTransChargesPreview(
            requestAmount,
            "Terminal ID",
            Channel,
            SaccolinkTransactionType
        ) + requestAmount;

        exit(totalCost > GlobalFunctions.GetSavingsAccountAvailableBalance(theSavingsAccount, true));
    end;

    procedure CheckWithdrawalTransactionLimitViolation(
        requestAmount: Decimal;
        var theSavingsAccount: Record "Savings Accounts";
        var WithdrawalLimitSetup: Record "E-Channels Transaction Setup"
    ): Boolean
    begin
        if theSavingsAccount."ATM Withdrawal Limit" > 0 then begin
            // Temporary variable store
            WithdrawalLimitSetup."ATM Withdrawal Limit" := theSavingsAccount."ATM Withdrawal Limit";
        end;

        exit(
            requestAmount > WithdrawalLimitSetup."ATM Withdrawal Limit"
        );
    end;

    procedure CheckWithdrawalDailyTransactionLimitViolation(
        requestAmount: Decimal;
        var theSavingsAccount: Record "Savings Accounts";
        var WithdrawalLimitSetup: Record "E-Channels Transaction Setup"
    ): Boolean
    var
        todaysATMWithdrawals: Record "Sky ATM Transactions Buffer";
    begin
        if theSavingsAccount."ATM Daily Withdrawals Limit" > 0 then begin
            // Temporary variable store
            WithdrawalLimitSetup."ATM Daily Withdrawals Limit" := theSavingsAccount."ATM Daily Withdrawals Limit";
        end;

        todaysATMWithdrawals.SetRange("Member Savings Account", theSavingsAccount."No.");
        todaysATMWithdrawals.SetRange("Transaction Date", Today);
        todaysATMWithdrawals.SetFilter("Transaction Type",
            '=%1|%2|%3|%4|%5|%6',
            todaysATMWithdrawals."Transaction Type"::"ATM Utility",
            todaysATMWithdrawals."Transaction Type"::"ATM Withdrawal",
            todaysATMWithdrawals."Transaction Type"::"POS Utility",
            todaysATMWithdrawals."Transaction Type"::"POS Withdrawal",
            todaysATMWithdrawals."Transaction Type"::"VISA ATM Withdrawal",
            todaysATMWithdrawals."Transaction Type"::"VISA Purchase"
        );
        todaysATMWithdrawals.SetRange("Is Coop Reversal", false);
        todaysATMWithdrawals.SetRange(Reversed, false);

        todaysATMWithdrawals.CalcSums("Charge Amount");

        exit(
            (todaysATMWithdrawals."Charge Amount" + requestAmount) > WithdrawalLimitSetup."ATM Daily Withdrawals Limit"
        );
    end;

    // Card Hashing - TEST
    procedure GenerateSHA256(CardNumber: Text) HashedCardNumber: Text
    var
        CryptoMgmnt: Codeunit "Cryptography Management";
        HashAlgo: enum "Hash Algorithm";
    begin
        HashedCardNumber := CryptoMgmnt.GenerateHash(CardNumber, HashAlgo::SHA256.AsInteger());
    end;

    var
        GlobalFunctions: Codeunit "Global Functions";
        DepMultiplier: Integer;

        Jtemplate: CODE[30];
        JBatch: CODE[30];
        GenJournalLine: Record "Gen. Journal Line";
        GenBatches: Record "Gen. Journal Batch";
        SaccoTransactions: Codeunit "Sacco Transactions";
        ATMTransactionType: Record "Mobile Transaction Types";
        MobileTransLines: Record "Mobile Transaction Types Lines";
        JournalPosting: Codeunit "Journal Posting";
        TransType: Enum "Transaction Types";
        AccType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        SkyMbankingTrans: Codeunit "Sky M-Banking Transactions";
        AccNo: Code[20];
        BalAccNo: Code[20];
        TotalCharges: Decimal;
        Amt: Decimal;
        Descr: Text;
        GenSetup: Record "General Set-Up";
        LineNo: Integer;
        Members: Record Members;
        SendSMS: Codeunit SendSms;
        Source: Enum "SMS Source";
        SavingsAcc: Record "Savings Accounts";
        JournalPostingSucc: Codeunit "Journal Post Successful";
        Post: Boolean;
        SkySMS: Codeunit SendSms;
        SMSSource: enum "SMS Source";
}