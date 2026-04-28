codeunit 52186506 "Sky Coop ATM Bridge"
{
    procedure HandleRequest(Request: Text): Text
    var
        RequestParser: JsonObject;
        RequestAction: JsonToken;
        RequestAPIId: JsonToken;
        RequestAPIDateTime: JsonToken;
        RequestPayload: JsonToken;
    begin
        RequestParser.ReadFrom(Request);
        RequestParser.SelectToken('$.action', RequestAction);
        RequestParser.SelectToken('$.api_request_id', RequestAPIId);
        RequestParser.SelectToken('$.api_request_date_time', RequestAPIDateTime);
        RequestParser.SelectToken('$.payload', RequestPayload);

        // API actions here
        case RequestAction.AsValue().AsText() of
            'ATM_BALANCE_ENQUIRY':
                exit(ATMBalanceEnquiry(RequestPayload.AsObject, RequestAPIId));
            'ATM_FUNDS_TRANSFER':
                exit(ATMFundsTransfer(RequestPayload.AsObject, RequestAPIId));
            'ATM_MINI_STATEMENT':
                exit(ATMMiniStatement(RequestPayload.AsObject, RequestAPIId));
            'CALL_SERVICE':
                exit(ATMPostTransactions(RequestPayload.AsObject, RequestAPIId));
            else
                exit(UnsupportedAction(RequestAction.AsValue.AsText))
        end;
    end;

    local procedure ATMBalanceEnquiry(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        service_name: JsonToken;
        message_id: JsonToken; // Coop reference. Should NOT be duplicated

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

        MemberSavingsAccount: Record "Savings Accounts";
        SkyATMTransactions: Record "Sky ATM Transactions Buffer";
        ServiceProviderRespCode: Enum "ATM Service Prov. Resp. Codes";
        ATMCardStorage: Record "ATM Card Storage";

        ResponseObject: JsonObject;
        ResponsePayload: JsonObject;
        GetBalanceResponse: JsonObject;
        OperationParameters: JsonObject;
        Institution: JsonObject;
        Account: JsonObject;
        AdditionalInfo: JsonArray;
        Response: Text;
    begin
        Payload.Get('service_name', service_name);
        Payload.Get('message_id', message_id);

        Payload.SelectToken('$.get_balance_request.operation_parameters.transaction_date', get_balance_request_operation_parameters_transaction_date);
        Payload.SelectToken('$.get_balance_request.operation_parameters.terminal_id', get_balance_request_operation_parameters_terminal_id);
        Payload.SelectToken('$.get_balance_request.operation_parameters.channel', get_balance_request_operation_parameters_channel);
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

        ATMCardStorage.Reset;
        ATMCardStorage.SetRange("Card Number", get_balance_request_account_debit_account.AsValue.AsText);
        ATMCardStorage.SetRange(Linked, true);

        if not ATMCardStorage.FindFirst then begin

            ServiceProviderRespCode := ServiceProviderRespCode::"Account does not exist";

            ResponsePayload.Add('message_id', message_id);
            ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
            ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

            OperationParameters.Add('transaction_date', GlobalFunctions.FormatISOATMDateTime(CurrentDateTime));
            OperationParameters.Add('transaction_reference', '');
            GetBalanceResponse.Add('operation_parameters', OperationParameters);

            Institution.Add('institution_code', get_balance_request_institution_institution_code);
            Institution.Add('institution_name', get_balance_request_institution_institution_name);
            GetBalanceResponse.Add('institution', Institution);


            Account.Add('debit_account', '');
            Account.Add('book_balance', '');
            Account.Add('cleared_balance', '');
            Account.Add('currency', '');
            GetBalanceResponse.Add('account', Account);

            GetBalanceResponse.Add('additional_info', AdditionalInfo);
            ResponsePayload.Add('get_balance_response', GetBalanceResponse);

            ResponseObject.Add('response_status', 'FAILED');
            ResponseObject.Add('response_status_description', 'Card details NOT yet linked to a member account!');
            ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
            ResponseObject.Add('destination_reference', GlobalFunctions.CleanGuid());
            ResponseObject.Add('payload', ResponsePayload);

        end else begin

            MemberSavingsAccount.Reset;
            MemberSavingsAccount.SetRange("No.", ATMCardStorage."Account No.");
            MemberSavingsAccount.SetRange(Status, MemberSavingsAccount.Status::Active);
            MemberSavingsAccount.SetRange(Blocked, MemberSavingsAccount.Blocked::" ");

            if MemberSavingsAccount.FindFirst then begin
                SkyATMTransactions.Reset;
                SkyATMTransactions.SetRange("Message ID", message_id.AsValue.AsText);

                if SkyATMTransactions.FindFirst then begin
                    ServiceProviderRespCode := ServiceProviderRespCode::"The parameters are not valid or they are missing.";

                    ResponsePayload.Add('message_id', message_id);
                    ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
                    ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

                    OperationParameters.Add('transaction_date', GlobalFunctions.FormatISOATMDateTime(CurrentDateTime));
                    OperationParameters.Add('transaction_reference', '');
                    GetBalanceResponse.Add('operation_parameters', OperationParameters);

                    Institution.Add('institution_code', get_balance_request_institution_institution_code);
                    Institution.Add('institution_name', get_balance_request_institution_institution_name);
                    GetBalanceResponse.Add('institution', Institution);


                    Account.Add('debit_account', '');
                    Account.Add('book_balance', '');
                    Account.Add('cleared_balance', '');
                    Account.Add('currency', '');
                    GetBalanceResponse.Add('account', Account);

                    GetBalanceResponse.Add('additional_info', AdditionalInfo);
                    ResponsePayload.Add('get_balance_response', GetBalanceResponse);

                    ResponseObject.Add('response_status', 'FAILED');
                    ResponseObject.Add('response_status_description', 'Transaction with API message id = ' + message_id.AsValue.AsText + ' already exists!');
                    ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
                    ResponseObject.Add('destination_reference', GlobalFunctions.CleanGuid);
                    ResponseObject.Add('payload', ResponsePayload);
                end else begin
                    SkyATMTransactions.Reset;

                    if (
                        // get_balance_request_posting_charge_amount.AsValue.AsDecimal > GlobalFunctions.GetSavingsAccountAvailableBalance(MemberSavingsAccount, true)
                        SkyCoopATMTrans.ValidateMinAccountBalance(
                            get_balance_request_posting_charge_amount.AsValue.AsDecimal,
                            MemberSavingsAccount,
                            get_balance_request_operation_parameters_terminal_id.AsValue.AsText,
                            get_balance_request_operation_parameters_channel.AsValue.AsText,
                            "Saccolink Transaction Types"::"Balance Enquiry_Sacco_Direct".AsInteger()
                        )
                    ) then begin
                        ServiceProviderRespCode := ServiceProviderRespCode::"Insufficient funds";

                        ResponsePayload.Add('message_id', message_id);
                        ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
                        ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

                        OperationParameters.Add('transaction_date', GlobalFunctions.FormatISOATMDateTime(CurrentDateTime));
                        OperationParameters.Add('transaction_reference', '');
                        GetBalanceResponse.Add('operation_parameters', OperationParameters);

                        Institution.Add('institution_code', get_balance_request_institution_institution_code);
                        Institution.Add('institution_name', get_balance_request_institution_institution_name);
                        GetBalanceResponse.Add('institution', Institution);


                        Account.Add('debit_account', '');
                        Account.Add('book_balance', '');
                        Account.Add('cleared_balance', '');
                        Account.Add('currency', '');
                        GetBalanceResponse.Add('account', Account);

                        GetBalanceResponse.Add('additional_info', AdditionalInfo);
                        ResponsePayload.Add('get_balance_response', GetBalanceResponse);

                        ResponseObject.Add('response_status', 'FAILED');
                        ResponseObject.Add('response_status_description', 'Insufficient funds to complete the transaction');
                        ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
                        ResponseObject.Add('destination_reference', GlobalFunctions.CleanGuid);
                        ResponseObject.Add('payload', ResponsePayload);
                    end else begin
                        SkyCoopATMTrans.LogBalanceEnquiry(SkyATMTransactions, Payload, APIRequestID, MemberSavingsAccount);

                        if SkyATMTransactions.Insert(true) then begin
                            Commit;

                            ServiceProviderRespCode := ServiceProviderRespCode::Success;

                            ResponsePayload.Add('message_id', message_id);
                            ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
                            ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

                            OperationParameters.Add('transaction_date', GlobalFunctions.FormatISOATMDateTime(CurrentDateTime));
                            OperationParameters.Add('transaction_reference', SkyATMTransactions."Transaction ID");
                            GetBalanceResponse.Add('operation_parameters', OperationParameters);

                            Institution.Add('institution_code', get_balance_request_institution_institution_code);
                            Institution.Add('institution_name', get_balance_request_institution_institution_name);
                            GetBalanceResponse.Add('institution', Institution);

                            MemberSavingsAccount.CalcFields("Balance (LCY)");

                            Account.Add('debit_account', ATMCardStorage."Card Number");
                            Account.Add('book_balance', MemberSavingsAccount."Balance (LCY)");
                            Account.Add('cleared_balance', GlobalFunctions.GetSavingsAccountAvailableBalance(MemberSavingsAccount, true));
                            Account.Add('currency', MemberSavingsAccount."Currency Code");
                            GetBalanceResponse.Add('account', Account);

                            GetBalanceResponse.Add('additional_info', AdditionalInfo);
                            ResponsePayload.Add('get_balance_response', GetBalanceResponse);

                            ResponseObject.Add('response_status', 'SUCCESS');
                            ResponseObject.Add('response_status_description', 'Request processed successfully');
                            ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
                            ResponseObject.Add('destination_reference', SkyATMTransactions."Transaction ID");
                            ResponseObject.Add('payload', ResponsePayload);
                        end else begin
                            ServiceProviderRespCode := ServiceProviderRespCode::"A severe problem has occurred.";

                            ResponsePayload.Add('message_id', message_id);
                            ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
                            ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

                            OperationParameters.Add('transaction_date', GlobalFunctions.FormatISOATMDateTime(CurrentDateTime));
                            OperationParameters.Add('transaction_reference', '');
                            GetBalanceResponse.Add('operation_parameters', OperationParameters);

                            Institution.Add('institution_code', get_balance_request_institution_institution_code);
                            Institution.Add('institution_name', get_balance_request_institution_institution_name);
                            GetBalanceResponse.Add('institution', Institution);


                            Account.Add('debit_account', '');
                            Account.Add('book_balance', '');
                            Account.Add('cleared_balance', '');
                            Account.Add('currency', '');
                            GetBalanceResponse.Add('account', Account);

                            GetBalanceResponse.Add('additional_info', AdditionalInfo);
                            ResponsePayload.Add('get_balance_response', GetBalanceResponse);

                            ResponseObject.Add('response_status', 'ERROR');
                            ResponseObject.Add('response_status_description', 'Unable to log the transaction at the moment. Transaction ref = ' + message_id.AsValue.AsText);
                            ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
                            ResponseObject.Add('destination_reference', GlobalFunctions.CleanGuid);
                            ResponseObject.Add('payload', ResponsePayload);
                        end;
                    end;
                end;
            end else begin
                ServiceProviderRespCode := ServiceProviderRespCode::"Account does not exist";

                ResponsePayload.Add('message_id', message_id);
                ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
                ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

                OperationParameters.Add('transaction_date', GlobalFunctions.FormatISOATMDateTime(CurrentDateTime));
                OperationParameters.Add('transaction_reference', '');
                GetBalanceResponse.Add('operation_parameters', OperationParameters);

                Institution.Add('institution_code', get_balance_request_institution_institution_code);
                Institution.Add('institution_name', get_balance_request_institution_institution_name);
                GetBalanceResponse.Add('institution', Institution);


                Account.Add('debit_account', '');
                Account.Add('book_balance', '');
                Account.Add('cleared_balance', '');
                Account.Add('currency', '');
                GetBalanceResponse.Add('account', Account);

                GetBalanceResponse.Add('additional_info', AdditionalInfo);
                ResponsePayload.Add('get_balance_response', GetBalanceResponse);

                ResponseObject.Add('response_status', 'FAILED');
                ResponseObject.Add('response_status_description', 'Member account NOT found!');
                ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
                ResponseObject.Add('destination_reference', GlobalFunctions.CleanGuid);
                ResponseObject.Add('payload', ResponsePayload);
            end;

        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure ATMFundsTransfer(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        service_name: JsonToken;
        message_id: JsonToken;

        send_funds_transfer_request_operation_parameters_transaction_date: JsonToken;
        send_funds_transfer_request_operation_parameters_terminal_id: JsonToken;
        send_funds_transfer_request_operation_parameters_channel: JsonToken;
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
        theSMS: Text;

        MemberSavingsAccount: Record "Savings Accounts";
        SkyATMTransactions: Record "Sky ATM Transactions Buffer";
        ServiceProviderRespCode: Enum "ATM Service Prov. Resp. Codes";
        ATMCardStorage: Record "ATM Card Storage";
        TheMember: Record Members;
        WithdrawalLimitSetup: Record "E-Channels Transaction Setup";

        ResponseObject: JsonObject;
        ResponsePayload: JsonObject;
        SendFundsTransferResponse: JsonObject;
        OperationParameters: JsonObject;
        Institution: JsonObject;
        Posting: JsonObject;
        AdditionalInfo: JsonArray;
        Response: Text;
    begin
        Payload.Get('service_name', service_name);
        Payload.Get('message_id', message_id);

        Payload.SelectToken('$.send_funds_transfer_request.operation_parameters.transaction_date', send_funds_transfer_request_operation_parameters_transaction_date);
        Payload.SelectToken('$.send_funds_transfer_request.operation_parameters.terminal_id', send_funds_transfer_request_operation_parameters_terminal_id);
        Payload.SelectToken('$.send_funds_transfer_request.operation_parameters.channel', send_funds_transfer_request_operation_parameters_channel);
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

        ATMCardStorage.Reset;
        ATMCardStorage.SetRange("Card Number", send_funds_transfer_request_posting_debit_account.AsValue.AsText);
        ATMCardStorage.SetRange(Linked, true);

        if not ATMCardStorage.FindFirst then begin

            ServiceProviderRespCode := ServiceProviderRespCode::"Account does not exist";

            ResponsePayload.Add('message_id', message_id);
            ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
            ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

            OperationParameters.Add('transaction_date', GlobalFunctions.FormatISOATMDateTime(CurrentDateTime));
            OperationParameters.Add('transaction_reference', '');
            SendFundsTransferResponse.Add('operation_parameters', OperationParameters);

            Institution.Add('institution_code', send_funds_transfer_request_institution_institution_code);
            Institution.Add('institution_name', send_funds_transfer_request_institution_institution_name);
            SendFundsTransferResponse.Add('institution', Institution);


            Posting.Add('debit_account', '');
            Posting.Add('amount', '');
            Posting.Add('cleared_balance', '');
            Posting.Add('credit_account', '');
            SendFundsTransferResponse.Add('posting', Posting);

            SendFundsTransferResponse.Add('additional_info', AdditionalInfo);
            ResponsePayload.Add('send_funds_transfer_response', SendFundsTransferResponse);

            ResponseObject.Add('response_status', 'FAILED');
            ResponseObject.Add('response_status_description', 'Card details NOT yet linked to a member account!');
            ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
            ResponseObject.Add('destination_reference', GlobalFunctions.CleanGuid);
            ResponseObject.Add('payload', ResponsePayload);

        end else begin

            MemberSavingsAccount.Reset;
            MemberSavingsAccount.SetRange("No.", ATMCardStorage."Account No.");
            MemberSavingsAccount.SetRange(Status, MemberSavingsAccount.Status::Active);
            MemberSavingsAccount.SetRange(Blocked, MemberSavingsAccount.Blocked::" ");

            if MemberSavingsAccount.FindFirst then begin
                // if not GlobalFunctions.CheckMemberSubflagTransactionAbility(MemberSavingsAccount."Member No.") then begin
                //     TheMember.Get(MemberSavingsAccount."Member No.");

                //     ServiceProviderRespCode := ServiceProviderRespCode::"Account does not exist";

                //     ResponsePayload.Add('message_id', message_id);
                //     ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
                //     ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

                //     OperationParameters.Add('transaction_date', GlobalFunctions.FormatISOATMDateTime(CurrentDateTime));
                //     OperationParameters.Add('transaction_reference', '');
                //     SendFundsTransferResponse.Add('operation_parameters', OperationParameters);

                //     Institution.Add('institution_code', send_funds_transfer_request_institution_institution_code);
                //     Institution.Add('institution_name', send_funds_transfer_request_institution_institution_name);
                //     SendFundsTransferResponse.Add('institution', Institution);


                //     Posting.Add('debit_account', '');
                //     Posting.Add('amount', '');
                //     Posting.Add('cleared_balance', '');
                //     Posting.Add('credit_account', '');
                //     SendFundsTransferResponse.Add('posting', Posting);

                //     SendFundsTransferResponse.Add('additional_info', AdditionalInfo);
                //     ResponsePayload.Add('send_funds_transfer_response', SendFundsTransferResponse);

                //     ResponseObject.Add('response_status', 'FAILED');
                //     ResponseObject.Add('response_status_description', 'The member is NOT allowed to transact. Current sub flag status is ' + Format(TheMember.Subflag));
                //     ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
                //     ResponseObject.Add('destination_reference', GlobalFunctions.CleanGuid);
                //     ResponseObject.Add('payload', ResponsePayload);

                //     AddDateTimeToResponse(ResponseObject);
                //     ResponseObject.WriteTo(Response);
                //     exit(Response);
                // end;

                // REVERSALS
                if send_funds_transfer_request_operation_parameters_transaction_type.AsValue.AsInteger = "Saccolink Transaction Types"::Reversal.AsInteger() then begin
                    SkyATMTransactions.Reset;
                    SkyCoopATMTrans.LogFundsTransfer(SkyATMTransactions, Payload, APIRequestID, MemberSavingsAccount);

                    if SkyATMTransactions.Insert(true) then begin
                        Commit;

                        ServiceProviderRespCode := ServiceProviderRespCode::"Accepted for reversal";

                        ResponsePayload.Add('message_id', message_id);
                        ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
                        ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

                        OperationParameters.Add('transaction_date', GlobalFunctions.FormatISOATMDateTime(CurrentDateTime));
                        OperationParameters.Add('transaction_reference', SkyATMTransactions."Transaction ID");
                        SendFundsTransferResponse.Add('operation_parameters', OperationParameters);

                        Institution.Add('institution_code', send_funds_transfer_request_institution_institution_code);
                        Institution.Add('institution_name', send_funds_transfer_request_institution_institution_name);
                        SendFundsTransferResponse.Add('institution', Institution);

                        MemberSavingsAccount.CalcFields("Balance (LCY)");

                        Posting.Add('debit_account', ATMCardStorage."Card Number");
                        Posting.Add('amount', send_funds_transfer_request_posting_charge_amount);
                        Posting.Add('cleared_balance', GlobalFunctions.GetSavingsAccountAvailableBalance(MemberSavingsAccount, true));
                        Posting.Add('credit_account', send_funds_transfer_request_posting_credit_account);
                        SendFundsTransferResponse.Add('posting', Posting);

                        SendFundsTransferResponse.Add('additional_info', AdditionalInfo);
                        ResponsePayload.Add('send_funds_transfer_response', SendFundsTransferResponse);

                        ResponseObject.Add('response_status', 'SUCCESS');
                        ResponseObject.Add('response_status_description', 'Request processed successfully');
                        ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
                        ResponseObject.Add('destination_reference', SkyATMTransactions."Transaction ID");
                        ResponseObject.Add('payload', ResponsePayload);
                    end else begin
                        ServiceProviderRespCode := ServiceProviderRespCode::"A severe problem has occurred.";

                        ResponsePayload.Add('message_id', message_id);
                        ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
                        ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

                        OperationParameters.Add('transaction_date', GlobalFunctions.FormatISOATMDateTime(CurrentDateTime));
                        OperationParameters.Add('transaction_reference', '');
                        SendFundsTransferResponse.Add('operation_parameters', OperationParameters);

                        Institution.Add('institution_code', send_funds_transfer_request_institution_institution_code);
                        Institution.Add('institution_name', send_funds_transfer_request_institution_institution_name);
                        SendFundsTransferResponse.Add('institution', Institution);


                        Posting.Add('debit_account', '');
                        Posting.Add('amount', '');
                        Posting.Add('cleared_balance', '');
                        Posting.Add('credit_account', '');
                        SendFundsTransferResponse.Add('posting', Posting);

                        SendFundsTransferResponse.Add('additional_info', AdditionalInfo);
                        ResponsePayload.Add('send_funds_transfer_response', SendFundsTransferResponse);

                        ResponseObject.Add('response_status', 'ERROR');
                        ResponseObject.Add('response_status_description', 'Unable to log the transaction at the moment. Transaction ref = ' + message_id.AsValue.AsText);
                        ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
                        ResponseObject.Add('destination_reference', GlobalFunctions.CleanGuid);
                        ResponseObject.Add('payload', ResponsePayload);
                    end;

                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;

                SkyATMTransactions.Reset;
                SkyATMTransactions.SetRange("Message ID", message_id.AsValue.AsText);

                if SkyATMTransactions.FindFirst then begin
                    ServiceProviderRespCode := ServiceProviderRespCode::"The parameters are not valid or they are missing.";

                    ResponsePayload.Add('message_id', message_id);
                    ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
                    ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

                    OperationParameters.Add('transaction_date', GlobalFunctions.FormatISOATMDateTime(CurrentDateTime));
                    OperationParameters.Add('transaction_reference', '');
                    SendFundsTransferResponse.Add('operation_parameters', OperationParameters);

                    Institution.Add('institution_code', send_funds_transfer_request_institution_institution_code);
                    Institution.Add('institution_name', send_funds_transfer_request_institution_institution_name);
                    SendFundsTransferResponse.Add('institution', Institution);


                    Posting.Add('debit_account', '');
                    Posting.Add('amount', '');
                    Posting.Add('cleared_balance', '');
                    Posting.Add('credit_account', '');
                    SendFundsTransferResponse.Add('posting', Posting);

                    SendFundsTransferResponse.Add('additional_info', AdditionalInfo);
                    ResponsePayload.Add('send_funds_transfer_response', SendFundsTransferResponse);

                    ResponseObject.Add('response_status', 'FAILED');
                    ResponseObject.Add('response_status_description', 'Transaction with API message id = ' + message_id.AsValue.AsText + ' already exists!');
                    ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
                    ResponseObject.Add('destination_reference', GlobalFunctions.CleanGuid);
                    ResponseObject.Add('payload', ResponsePayload);
                end else begin
                    SkyATMTransactions.Reset;

                    WithdrawalLimitSetup.FindFirst;

                    if (
                        // send_funds_transfer_request_posting_charge_amount.AsValue.AsDecimal > GlobalFunctions.GetSavingsAccountAvailableBalance(MemberSavingsAccount, true)
                        SkyCoopATMTrans.ValidateMinAccountBalance(
                            send_funds_transfer_request_posting_charge_amount.AsValue.AsDecimal,
                            MemberSavingsAccount,
                            send_funds_transfer_request_operation_parameters_terminal_id.AsValue.AsText,
                            send_funds_transfer_request_operation_parameters_channel.AsValue.AsText,
                            send_funds_transfer_request_operation_parameters_transaction_type.AsValue.AsInteger
                        )
                    ) then begin
                        ServiceProviderRespCode := ServiceProviderRespCode::"Insufficient funds";

                        ResponsePayload.Add('message_id', message_id);
                        ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
                        ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

                        OperationParameters.Add('transaction_date', GlobalFunctions.FormatISOATMDateTime(CurrentDateTime));
                        OperationParameters.Add('transaction_reference', '');
                        SendFundsTransferResponse.Add('operation_parameters', OperationParameters);

                        Institution.Add('institution_code', send_funds_transfer_request_institution_institution_code);
                        Institution.Add('institution_name', send_funds_transfer_request_institution_institution_name);
                        SendFundsTransferResponse.Add('institution', Institution);


                        Posting.Add('debit_account', '');
                        Posting.Add('amount', '');
                        Posting.Add('cleared_balance', '');
                        Posting.Add('credit_account', '');
                        SendFundsTransferResponse.Add('posting', Posting);

                        SendFundsTransferResponse.Add('additional_info', AdditionalInfo);
                        ResponsePayload.Add('send_funds_transfer_response', SendFundsTransferResponse);

                        ResponseObject.Add('response_status', 'FAILED');
                        ResponseObject.Add('response_status_description', 'Insufficient funds to complete the transaction');
                        ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
                        ResponseObject.Add('destination_reference', GlobalFunctions.CleanGuid);
                        ResponseObject.Add('payload', ResponsePayload);
                    end else
                        if (
                            // send_funds_transfer_request_posting_charge_amount.AsValue.AsDecimal > GlobalFunctions.GetSavingsAccountAvailableBalance(MemberSavingsAccount, true)
                            SkyCoopATMTrans.CheckWithdrawalTransactionLimitViolation(
                                send_funds_transfer_request_posting_charge_amount.AsValue.AsDecimal,
                                MemberSavingsAccount,
                                WithdrawalLimitSetup
                            )
                        ) then begin
                            ServiceProviderRespCode := ServiceProviderRespCode::"Daily limit reached";

                            ResponsePayload.Add('message_id', message_id);
                            ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
                            ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

                            OperationParameters.Add('transaction_date', GlobalFunctions.FormatISOATMDateTime(CurrentDateTime));
                            OperationParameters.Add('transaction_reference', '');
                            SendFundsTransferResponse.Add('operation_parameters', OperationParameters);

                            Institution.Add('institution_code', send_funds_transfer_request_institution_institution_code);
                            Institution.Add('institution_name', send_funds_transfer_request_institution_institution_name);
                            SendFundsTransferResponse.Add('institution', Institution);


                            Posting.Add('debit_account', '');
                            Posting.Add('amount', '');
                            Posting.Add('cleared_balance', '');
                            Posting.Add('credit_account', '');
                            SendFundsTransferResponse.Add('posting', Posting);

                            SendFundsTransferResponse.Add('additional_info', AdditionalInfo);
                            ResponsePayload.Add('send_funds_transfer_response', SendFundsTransferResponse);

                            ResponseObject.Add('response_status', 'FAILED');
                            ResponseObject.Add('response_status_description', 'The maximum limit allowed for this transaction is KES ' + Format(WithdrawalLimitSetup."ATM Withdrawal Limit"));
                            ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
                            ResponseObject.Add('destination_reference', GlobalFunctions.CleanGuid);
                            ResponseObject.Add('payload', ResponsePayload);
                        end else
                            if (
                                // send_funds_transfer_request_posting_charge_amount.AsValue.AsDecimal > GlobalFunctions.GetSavingsAccountAvailableBalance(MemberSavingsAccount, true)
                                SkyCoopATMTrans.CheckWithdrawalDailyTransactionLimitViolation(
                                    send_funds_transfer_request_posting_charge_amount.AsValue.AsDecimal,
                                    MemberSavingsAccount,
                                    WithdrawalLimitSetup
                                )
                            ) then begin
                                ServiceProviderRespCode := ServiceProviderRespCode::"Daily limit reached";

                                ResponsePayload.Add('message_id', message_id);
                                ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
                                ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

                                OperationParameters.Add('transaction_date', GlobalFunctions.FormatISOATMDateTime(CurrentDateTime));
                                OperationParameters.Add('transaction_reference', '');
                                SendFundsTransferResponse.Add('operation_parameters', OperationParameters);

                                Institution.Add('institution_code', send_funds_transfer_request_institution_institution_code);
                                Institution.Add('institution_name', send_funds_transfer_request_institution_institution_name);
                                SendFundsTransferResponse.Add('institution', Institution);


                                Posting.Add('debit_account', '');
                                Posting.Add('amount', '');
                                Posting.Add('cleared_balance', '');
                                Posting.Add('credit_account', '');
                                SendFundsTransferResponse.Add('posting', Posting);

                                SendFundsTransferResponse.Add('additional_info', AdditionalInfo);
                                ResponsePayload.Add('send_funds_transfer_response', SendFundsTransferResponse);

                                ResponseObject.Add('response_status', 'FAILED');
                                ResponseObject.Add('response_status_description', 'The maximum daily withdrawal limit allowed is KES ' + Format(WithdrawalLimitSetup."ATM Daily Withdrawals Limit"));
                                ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
                                ResponseObject.Add('destination_reference', GlobalFunctions.CleanGuid);
                                ResponseObject.Add('payload', ResponsePayload);
                            end else begin
                                SkyCoopATMTrans.LogFundsTransfer(SkyATMTransactions, Payload, APIRequestID, MemberSavingsAccount);

                                if SkyATMTransactions.Insert(true) then begin
                                    Commit;

                                    ServiceProviderRespCode := ServiceProviderRespCode::Success;

                                    ResponsePayload.Add('message_id', message_id);
                                    ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
                                    ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

                                    OperationParameters.Add('transaction_date', GlobalFunctions.FormatISOATMDateTime(CurrentDateTime));
                                    OperationParameters.Add('transaction_reference', SkyATMTransactions."Transaction ID");
                                    SendFundsTransferResponse.Add('operation_parameters', OperationParameters);

                                    Institution.Add('institution_code', send_funds_transfer_request_institution_institution_code);
                                    Institution.Add('institution_name', send_funds_transfer_request_institution_institution_name);
                                    SendFundsTransferResponse.Add('institution', Institution);

                                    MemberSavingsAccount.CalcFields("Balance (LCY)");

                                    // TODO: Get clarity here...
                                    Posting.Add('debit_account', ATMCardStorage."Card Number");
                                    Posting.Add('amount', send_funds_transfer_request_posting_charge_amount);
                                    Posting.Add('cleared_balance', GlobalFunctions.GetSavingsAccountAvailableBalance(MemberSavingsAccount, true));
                                    Posting.Add('credit_account', send_funds_transfer_request_posting_credit_account);
                                    SendFundsTransferResponse.Add('posting', Posting);

                                    SendFundsTransferResponse.Add('additional_info', AdditionalInfo);
                                    ResponsePayload.Add('send_funds_transfer_response', SendFundsTransferResponse);

                                    ResponseObject.Add('response_status', 'SUCCESS');
                                    ResponseObject.Add('response_status_description', 'Request processed successfully');
                                    ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
                                    ResponseObject.Add('destination_reference', SkyATMTransactions."Transaction ID");
                                    ResponseObject.Add('payload', ResponsePayload);
                                end else begin
                                    ServiceProviderRespCode := ServiceProviderRespCode::"A severe problem has occurred.";

                                    ResponsePayload.Add('message_id', message_id);
                                    ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
                                    ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

                                    OperationParameters.Add('transaction_date', GlobalFunctions.FormatISOATMDateTime(CurrentDateTime));
                                    OperationParameters.Add('transaction_reference', '');
                                    SendFundsTransferResponse.Add('operation_parameters', OperationParameters);

                                    Institution.Add('institution_code', send_funds_transfer_request_institution_institution_code);
                                    Institution.Add('institution_name', send_funds_transfer_request_institution_institution_name);
                                    SendFundsTransferResponse.Add('institution', Institution);


                                    Posting.Add('debit_account', '');
                                    Posting.Add('amount', '');
                                    Posting.Add('cleared_balance', '');
                                    Posting.Add('credit_account', '');
                                    SendFundsTransferResponse.Add('posting', Posting);

                                    SendFundsTransferResponse.Add('additional_info', AdditionalInfo);
                                    ResponsePayload.Add('send_funds_transfer_response', SendFundsTransferResponse);

                                    ResponseObject.Add('response_status', 'ERROR');
                                    ResponseObject.Add('response_status_description', 'Unable to log the transaction at the moment. Transaction ref = ' + message_id.AsValue.AsText);
                                    ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
                                    ResponseObject.Add('destination_reference', GlobalFunctions.CleanGuid);
                                    ResponseObject.Add('payload', ResponsePayload);
                                end;
                            end;
                end;
            end else begin
                ServiceProviderRespCode := ServiceProviderRespCode::"Account does not exist";

                ResponsePayload.Add('message_id', message_id);
                ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
                ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

                OperationParameters.Add('transaction_date', GlobalFunctions.FormatISOATMDateTime(CurrentDateTime));
                OperationParameters.Add('transaction_reference', '');
                SendFundsTransferResponse.Add('operation_parameters', OperationParameters);

                Institution.Add('institution_code', send_funds_transfer_request_institution_institution_code);
                Institution.Add('institution_name', send_funds_transfer_request_institution_institution_name);
                SendFundsTransferResponse.Add('institution', Institution);


                Posting.Add('debit_account', '');
                Posting.Add('amount', '');
                Posting.Add('cleared_balance', '');
                Posting.Add('credit_account', '');
                SendFundsTransferResponse.Add('posting', Posting);

                SendFundsTransferResponse.Add('additional_info', AdditionalInfo);
                ResponsePayload.Add('send_funds_transfer_response', SendFundsTransferResponse);

                ResponseObject.Add('response_status', 'FAILED');
                ResponseObject.Add('response_status_description', 'Member account NOT found!');
                ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
                ResponseObject.Add('destination_reference', GlobalFunctions.CleanGuid);
                ResponseObject.Add('payload', ResponsePayload);
            end;

        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure ATMMiniStatement(Payload: JsonObject; APIRequestID: JsonToken): Text
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

        ministatement_request_additional_info: JsonToken;
        ministatement_request_additional_info_text: Text;

        MemberSavingsAccount: Record "Savings Accounts";
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        SkyATMTransactions: Record "Sky ATM Transactions Buffer";
        ServiceProviderRespCode: Enum "ATM Service Prov. Resp. Codes";
        ATMCardStorage: Record "ATM Card Storage";

        Count: Integer;

        ResponseObject: JsonObject;
        ResponsePayload: JsonObject;
        MiniStatementResponse: JsonObject;
        AccountTransactions: JsonArray;
        AccountTransaction: JsonObject;
        AdditionalInfo: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('service_name', service_name);
        Payload.Get('message_id', message_id);

        Payload.SelectToken('$.ministatement_request.operation_parameters.transaction_date', ministatement_request_operation_parameters_transaction_date);
        Payload.SelectToken('$.ministatement_request.operation_parameters.max_number_rows', ministatement_request_operation_parameters_max_number_rows);
        Payload.SelectToken('$.ministatement_request.operation_parameters.terminal_id', ministatement_request_operation_parameters_terminal_id);
        Payload.SelectToken('$.ministatement_request.operation_parameters.channel', ministatement_request_operation_parameters_channel);
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

        ATMCardStorage.Reset;
        ATMCardStorage.SetRange("Card Number", ministatement_request_account_debit_account.AsValue.AsText);
        ATMCardStorage.SetRange(Linked, true);

        if not ATMCardStorage.FindFirst then begin

            ServiceProviderRespCode := ServiceProviderRespCode::"Account does not exist";

            ResponsePayload.Add('message_id', message_id);
            ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
            ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

            MiniStatementResponse.Add('account_transactions', AccountTransactions);
            MiniStatementResponse.Add('additional_info', AdditionalInfo);
            ResponsePayload.Add('ministatement_response', MiniStatementResponse);

            ResponseObject.Add('response_status', 'FAILED');
            ResponseObject.Add('response_status_description', 'Card details NOT yet linked to a member account!');
            ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
            ResponseObject.Add('destination_reference', GlobalFunctions.CleanGuid);
            ResponseObject.Add('payload', ResponsePayload);

        end else begin
            MemberSavingsAccount.Reset;
            MemberSavingsAccount.SetRange("No.", ATMCardStorage."Account No.");
            MemberSavingsAccount.SetRange(Status, MemberSavingsAccount.Status::Active);
            MemberSavingsAccount.SetRange(Blocked, MemberSavingsAccount.Blocked::" ");

            if MemberSavingsAccount.FindFirst then begin
                SkyATMTransactions.Reset;
                SkyATMTransactions.SetRange("Message ID", message_id.AsValue.AsText);

                if SkyATMTransactions.FindFirst then begin
                    ServiceProviderRespCode := ServiceProviderRespCode::"The parameters are not valid or they are missing.";

                    ResponsePayload.Add('message_id', message_id);
                    ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
                    ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

                    MiniStatementResponse.Add('account_transactions', AccountTransactions);
                    MiniStatementResponse.Add('additional_info', AdditionalInfo);
                    ResponsePayload.Add('ministatement_response', MiniStatementResponse);

                    ResponseObject.Add('response_status', 'FAILED');
                    ResponseObject.Add('response_status_description', 'Transaction with API message id = ' + message_id.AsValue.AsText + ' already exists!');
                    ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
                    ResponseObject.Add('destination_reference', GlobalFunctions.CleanGuid);
                    ResponseObject.Add('payload', ResponsePayload);
                end else begin
                    SkyATMTransactions.Reset;

                    if (
                        // ministatement_request_posting_charge_amount.AsValue.AsDecimal > GlobalFunctions.GetSavingsAccountAvailableBalance(MemberSavingsAccount, true)
                        SkyCoopATMTrans.ValidateMinAccountBalance(
                            ministatement_request_posting_charge_amount.AsValue.AsDecimal,
                            MemberSavingsAccount,
                            ministatement_request_operation_parameters_terminal_id.AsValue.AsText,
                            ministatement_request_operation_parameters_channel.AsValue.AsText,
                            "Saccolink Transaction types"::"Mini Statement Sacco direct".AsInteger()
                        )
                    ) then begin
                        ServiceProviderRespCode := ServiceProviderRespCode::"Insufficient funds";

                        ResponsePayload.Add('message_id', message_id);
                        ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
                        ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

                        MiniStatementResponse.Add('account_transactions', AccountTransactions);
                        MiniStatementResponse.Add('additional_info', AdditionalInfo);
                        ResponsePayload.Add('ministatement_response', MiniStatementResponse);

                        ResponseObject.Add('response_status', 'FAILED');
                        ResponseObject.Add('response_status_description', 'Insufficient funds to complete the transaction');
                        ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
                        ResponseObject.Add('destination_reference', GlobalFunctions.CleanGuid);
                        ResponseObject.Add('payload', ResponsePayload);
                    end else begin
                        SkyCoopATMTrans.LogMiniStatement(SkyATMTransactions, Payload, APIRequestID, MemberSavingsAccount);

                        if SkyATMTransactions.Insert(true) then begin
                            Commit;

                            ServiceProviderRespCode := ServiceProviderRespCode::Success;

                            ResponsePayload.Add('message_id', message_id);
                            ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
                            ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

                            SavingsLedgerEntry.Reset;
                            SavingsLedgerEntry.SetCurrentkey("Entry No.");
                            SavingsLedgerEntry.Ascending(false);
                            SavingsLedgerEntry.SetRange("Customer No.", MemberSavingsAccount."No.");

                            IF SavingsLedgerEntry.FindSet then begin
                                MemberSavingsAccount.CalcFields("Balance (LCY)", "Authorised Over Draft", "Uncleared Cheques", "ATM Transactions", "Lien Placed");

                                repeat begin
                                    Count += 1;

                                    AccountTransaction.Add('transaction_date', GlobalFunctions.FormatISODate(SavingsLedgerEntry."Document Date") + 'T00:00:00');
                                    AccountTransaction.Add('transaction_reference', SavingsLedgerEntry."Document No.");

                                    if SavingsLedgerEntry."Amount (LCY)" < 0 then begin
                                        AccountTransaction.Add('debit_credit_flag', 'CR');
                                    end else begin
                                        AccountTransaction.Add('debit_credit_flag', 'DR');
                                    end;

                                    AccountTransaction.Add('amount', Abs(SavingsLedgerEntry."Amount (LCY)"));
                                    AccountTransaction.Add('narration', SavingsLedgerEntry.Description);
                                    AccountTransaction.Add('posting_date', GlobalFunctions.FormatISODate(SavingsLedgerEntry."Posting Date") + 'T' + GlobalFunctions.FormatISOTime(SavingsLedgerEntry."Posting Time"));
                                    AccountTransaction.Add('book_balance', GlobalFunctions.GetRunningBalance(SavingsLedgerEntry."Entry No.", SavingsLedgerEntry."Customer No."));
                                    AccountTransaction.Add('cleared_running_balance', GlobalFunctions.GetRunningBalance(SavingsLedgerEntry."Entry No.", SavingsLedgerEntry."Customer No."));
                                    AccountTransaction.Add('channel_id', '');
                                    AccountTransaction.Add('account_name', MemberSavingsAccount.Name);
                                    AccountTransaction.Add('account_number', ATMCardStorage."Card Number");

                                    AccountTransactions.Add(AccountTransaction);
                                    // Reset
                                    AccountTransaction.ReadFrom('{}');
                                end until (Count = ministatement_request_operation_parameters_max_number_rows.AsValue.AsInteger) or (SavingsLedgerEntry.Next = 0);
                            end;

                            MiniStatementResponse.Add('account_transactions', AccountTransactions);
                            MiniStatementResponse.Add('additional_info', AdditionalInfo);
                            ResponsePayload.Add('ministatement_response', MiniStatementResponse);

                            ResponseObject.Add('response_status', 'SUCCESS');
                            ResponseObject.Add('response_status_description', 'Request processed successfully');
                            ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
                            ResponseObject.Add('destination_reference', SkyATMTransactions."Transaction ID");
                            ResponseObject.Add('payload', ResponsePayload);
                        end else begin
                            ServiceProviderRespCode := ServiceProviderRespCode::"A severe problem has occurred.";

                            ResponsePayload.Add('message_id', message_id);
                            ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
                            ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

                            MiniStatementResponse.Add('account_transactions', AccountTransactions);
                            MiniStatementResponse.Add('additional_info', AdditionalInfo);
                            ResponsePayload.Add('ministatement_response', MiniStatementResponse);

                            ResponseObject.Add('response_status', 'ERROR');
                            ResponseObject.Add('response_status_description', 'Unable to log the transaction at the moment. Transaction ref = ' + message_id.AsValue.AsText);
                            ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
                            ResponseObject.Add('destination_reference', GlobalFunctions.CleanGuid);
                            ResponseObject.Add('payload', ResponsePayload);
                        end;
                    end;
                end;
            end else begin
                ServiceProviderRespCode := ServiceProviderRespCode::"Account does not exist";

                ResponsePayload.Add('message_id', message_id);
                ResponsePayload.Add('status_code', ServiceProviderRespCode.AsInteger());
                ResponsePayload.Add('status_description', Format(ServiceProviderRespCode));

                MiniStatementResponse.Add('account_transactions', AccountTransactions);
                MiniStatementResponse.Add('additional_info', AdditionalInfo);
                ResponsePayload.Add('ministatement_response', MiniStatementResponse);

                ResponseObject.Add('response_status', 'FAILED');
                ResponseObject.Add('response_status_description', 'Member account NOT found!');
                ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
                ResponseObject.Add('destination_reference', GlobalFunctions.CleanGuid);
                ResponseObject.Add('payload', ResponsePayload);
            end;

        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure ATMPostTransactions(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        ResponseObject: JsonObject;
        ResponsePayload: JsonObject;
        Datum: JsonObject;
        Response: Text;

        Message: Text;

        // To be removed
        NCBAUAT: Codeunit "NCBA Integration";
    begin
        NCBAUAT.NCBAPostPension();

        Message := SkyCoopATMTrans.POSTATMTransactions();

        ResponseObject.Add('response_status', 'SUCCESS');
        ResponseObject.Add('response_status_description', Message);
        ResponseObject.Add('response_status_date', GlobalFunctions.FormatISODateTime(CurrentDateTime));
        ResponseObject.Add('destination_reference', GlobalFunctions.CleanGuid);
        ResponseObject.Add('payload', ResponsePayload);

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    // -----------------------------------------------------------------------------------------------------------------------------------------
    local procedure UnsupportedAction(RequestAction: Text): Text
    var
        ResponseObject: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        ResponseObject.Add('status', 'ERROR');
        ResponseObject.Add('description', 'The requested action ' + RequestAction + ' is NOT supported.');
        ResponseObject.Add('errors', Errors);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure AddDateTimeToResponse(var ResponseObject: JsonObject)
    begin
        ResponseObject.Add('date_time', GlobalFunctions.FormatISODateTime(CurrentDateTime));
    end;

    var
        VendorName: Label 'ATM Bridge - Sky World Limited';
        GlobalFunctions: Codeunit "Global Functions";
        SkyCoopATMTrans: Codeunit "Sky Coop ATM Transactions";
        SkySMS: Codeunit SendSms;
        SMSSource: enum "SMS Source";
}