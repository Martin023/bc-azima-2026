// codeunit 50100 "MobileBankingEngine"
// {
//     trigger OnRun()
//     begin

//     end;

//     var
//         Title: Label 'title';
//         Message: Label 'message';
//         Status: Label 'status';
//         Data: Label 'data';
//     // ################################################################################################
//     // MAIN FUNCTIONS
//     // ################################################################################################
//     procedure ProcessRequest(Request: Text) Response: Text;
//     var
//         RequestJson: JsonObject;
//         OutputJson: JsonObject;
//         RequestDataJson: JsonObject;
//         RequestAction: Text;
//         SessionId: Text;
//         SessionValid: Boolean;
//     begin
//         if not RequestJson.ReadFrom(Request) then
//             Error('Invalid Json Input');

//         SessionId := SelectJsonToken(RequestJson, '$.request.session_id').AsValue.AsText;
//         RequestAction := SelectJsonToken(RequestJson, '$.request.action').AsValue.AsText;

//         RequestDataJson := SelectJsonToken(RequestJson, '$.request.payload.data').AsObject();

//         ValidateRequestHash(RequestJson);

//         SessionValid := true;

//         if not (RequestAction in ['login']) then begin
//             SessionValid := ValidateUserSession(RequestJson);
//         end;

//         if SessionValid then begin
//             case RequestAction of
//                 'get-member-details':
//                     begin
//                         OutputJson := GetMemberDetails(RequestDataJson);
//                     end;
//                 'get-accounts':
//                     begin
//                         OutputJson := GetAccounts(RequestDataJson);
//                     end;
//                 'balance-enquiry':
//                     begin
//                         OutputJson := BalanceEnquiry(RequestDataJson);
//                     end;
//                 'statement-enquiry':
//                     begin
//                         OutputJson := StatementEnquiry(RequestDataJson);
//                     end;
//                 'pesa-out-request':
//                     begin
//                         OutputJson := PESAOUTRequest(RequestDataJson);
//                     end;
//                 'pesa-out-confirmation':
//                     begin
//                         OutputJson := PESAOUTConfirmation(RequestDataJson);
//                     end;
//                 'internal-funds-transfer':
//                     begin
//                         OutputJson := InternalFundsTransfer(RequestDataJson);
//                     end;
//                 'pesa-in-confirmation':
//                     begin
//                         OutputJson := PESAINConfirmation(RequestDataJson);
//                     end;
//                 'get-loan-types':
//                     begin
//                         OutputJson := GetLoanTypes(RequestDataJson);
//                     end;
//                 'check-loan-limit':
//                     begin
//                         OutputJson := CheckLoanLimit(RequestDataJson);
//                     end;
//                 'loan-application':
//                     begin
//                         OutputJson := LoanApplication(RequestDataJson);
//                     end;
//                 'get-outstanding-loans':
//                     begin
//                         OutputJson := GetOutstandingLoans(RequestDataJson);
//                     end;
//                 'get-transaction-charges':
//                     begin
//                         OutputJson := GetTransactionCharges(RequestDataJson);
//                     end;
//                 'virtual-member-registration':
//                     begin
//                         OutputJson := VirtualMemberRegistration(RequestDataJson);
//                     end;
//             end;
//         end
//         else begin
//             SetResponseStatus(OutputJson, 'error', '401 Unauthorized', 'Your request could not be processed');
//         end;

//         Response := WrapResponse(RequestJson, OutputJson);
//     end;


//     // ################################################################################################
//     // REQUEST PROCESSING PROCEDURES (MATUMBO)
//     // ################################################################################################
//     local procedure GetMemberDetails(RequestJson: JsonObject) ResponseJson: JsonObject
//     var
//         DataJson: JsonObject;
//         IdentifierType: Text;
//         Identifier: Text;
//     begin
//         IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
//         Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

//         if true then begin
//             SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

//             DataJson.Add('customer_type', 'INDIVIDUAL/REPRESENTATIVE/CORPORATE');
//             DataJson.Add('identifier_type', 'CUSTOMER_NO');
//             DataJson.Add('identifier', 'CH123456');
//             DataJson.Add('primary_identity_type', 'NATIONAL_ID/PASSPORT_NO');
//             DataJson.Add('primary_identity_no', '123456789');
//             DataJson.Add('title', 'Mr');
//             DataJson.Add('full_name', 'John Doe');
//             DataJson.Add('gender', 'Male');
//             DataJson.Add('date_of_birth', '1980-05-25');
//             DataJson.Add('primary_email_address', 'johndoe@chaisacco.com');
//             DataJson.Add('primary_mobile_number', '254712345678');
//             DataJson.Add('status', 'ACTIVE');
//             DataJson.Add('registration_date', '2011-10-16');
//             DataJson.Add('tax_authority', 'KRA');
//             DataJson.Add('tax_authority_pin_number', 'A122345678B');
//             DataJson.Add('branch_code', '100');
//             DataJson.Add('branch', 'NAIROBI');
//             DataJson.Add('main_savings_account_no', '30112345678910');
//         end
//         else begin
//             SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
//         end;
//         ResponseJson.Add(Data, DataJson);
//     end;

//     // ------------------------------------------------------------------------------------------------
//     local procedure GetAccounts(RequestJson: JsonObject) ResponseJson: JsonObject
//     var
//         DataJson: JsonObject;
//         AccountType: Text;
//         IdentifierType: Text;
//         Identifier: Text;
//         AccountsArray: JsonArray;
//         AccountObject: JsonObject;
//         Iterator: Integer;
//     begin
//         Iterator := 0;

//         AccountType := SelectJsonToken(RequestJson, '$.account_type').AsValue.AsText;
//         IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
//         Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

//         if true then begin
//             SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

//             repeat
//                 AccountObject.Add('account_name', 'Ordinary Salary Account');
//                 AccountObject.Add('account_label', 'Salary Account');
//                 AccountObject.Add('account_number', '41-02392-0093-01');
//                 AccountObject.Add('account_type', '');
//                 AccountObject.Add('account_balance', 16000.00);
//                 AccountObject.Add('account_status', 'ACTIVE');
//                 AccountObject.Add('can_withdraw', 'YES');
//                 AccountObject.Add('max_withdrawable_amount', 15500.00);
//                 AccountObject.Add('can_deposit', 'YES');
//                 AccountObject.Add('max_deposit_amount', 5000000.00);

//                 AccountsArray.Add(AccountObject);
//                 Clear(AccountObject);
//                 Iterator := Iterator + 1;
//             until Iterator = 2;

//             DataJson.Add('accounts', AccountsArray);

//         end
//         else begin
//             SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
//         end;
//         ResponseJson.Add(Data, DataJson);
//     end;

//     // ------------------------------------------------------------------------------------------------
//     local procedure BalanceEnquiry(RequestJson: JsonObject) ResponseJson: JsonObject
//     var
//         DataJson: JsonObject;
//         IdentifierType: Text;
//         Identifier: Text;
//         AccountType: Text;
//         AccountNumber: Text;
//     begin
//         IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
//         Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
//         AccountType := SelectJsonToken(RequestJson, '$.account_type').AsValue.AsText;
//         AccountNumber := SelectJsonToken(RequestJson, '$.account_number').AsValue.AsText;

//         if true then begin
//             SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

//             DataJson.Add('account_name', 'Ordinary Salary Account');
//             DataJson.Add('account_label', 'Salary Account');
//             DataJson.Add('account_number', '41-02392-0093-01');
//             DataJson.Add('account_type', '');
//             DataJson.Add('account_balance', 16000.00);
//         end
//         else begin
//             SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
//         end;
//         ResponseJson.Add(Data, DataJson);
//     end;

//     // ------------------------------------------------------------------------------------------------
//     local procedure StatementEnquiry(RequestJson: JsonObject) ResponseJson: JsonObject
//     var
//         DataJson: JsonObject;
//         IdentifierType: Text;
//         Identifier: Text;
//         AccountType: Text;
//         AccountNumber: Text;
//         NumberOfTransactions: Integer;
//         StartDate: DateTime;
//         EndDate: DateTime;
//         StatementType: Text;

//         TransactionsArray: JsonArray;
//         TransactionObject: JsonObject;
//         Iterator: Integer;
//     begin
//         Iterator := 0;

//         IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
//         Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
//         AccountType := SelectJsonToken(RequestJson, '$.account_type').AsValue.AsText;
//         AccountNumber := SelectJsonToken(RequestJson, '$.account_number').AsValue.AsText;
//         NumberOfTransactions := SelectJsonToken(RequestJson, '$.number_of_transactions').AsValue.AsInteger();
//         StartDate := SelectJsonToken(RequestJson, '$.start_date').AsValue.AsDateTime;
//         EndDate := SelectJsonToken(RequestJson, '$.end_date').AsValue.AsDateTime;
//         StatementType := SelectJsonToken(RequestJson, '$.statement_type').AsValue.AsText;

//         if true then begin
//             SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

//             DataJson.Add('account_name', 'Salary Account');
//             DataJson.Add('account_number', '41-02392-0093-01');
//             DataJson.Add('available_balance', 3300.00);

//             repeat
//                 TransactionObject.Add('transaction_reference', '9225-40A8F0293DCC');
//                 TransactionObject.Add('transaction_date', '2021-01-03');
//                 TransactionObject.Add('transaction_time', '11:00:00');
//                 TransactionObject.Add('transaction_amount', -10300.00);
//                 TransactionObject.Add('running_balance', 5050.00);
//                 TransactionObject.Add('transaction_description', 'ATM Withdrawal from A/C 41-02392-0093-01');
//                 TransactionObject.Add('other_details', 'Withdrawal via ATM - Nyahururu Terminal');

//                 TransactionsArray.Add(TransactionObject);
//                 Clear(TransactionObject);
//                 Iterator := Iterator + 1;
//             until Iterator = 5;

//             DataJson.Add('transactions', TransactionsArray);
//             DataJson.Add('pdf', 'base-64-data==');
//         end
//         else begin
//             SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
//         end;
//         ResponseJson.Add(Data, DataJson);
//     end;

//     // ------------------------------------------------------------------------------------------------
//     local procedure PESAOUTRequest(RequestJson: JsonObject) ResponseJson: JsonObject
//     var
//         DataJson: JsonObject;

//         OriginatorID: Text;
//         ProductID: Text;
//         PesaType: Text;
//         TransactionAction: Text;
//         Command: Text;
//         TransactionInitiatorIdentifierType: Text;
//         TransactionInitiatorIdentifier: Text;
//         TransactionInitiatorAccount: Text;
//         TransactionInitiatorName: Text;
//         TransactionInitiatorReference: Text;
//         TransactionSourceIdentifierType: Text;
//         TransactionSourceIdentifier: Text;
//         TransactionSourceAccount: Text;
//         TransactionSourceName: Text;
//         TransactionSenderIdentifierType: Text;
//         TransactionSenderIdentifier: Text;
//         TransactionSenderAccount: Text;
//         TransactionSenderName: Text;
//         TransactionReceiverIdentifierType: Text;
//         TransactionReceiverIdentifier: Text;
//         TransactionReceiverAccount: Text;
//         TransactionReceiverName: Text;
//         TransactionBeneficiaryIdentifierType: Text;
//         TransactionBeneficiaryIdentifier: Text;
//         TransactionBeneficiaryAccount: Text;
//         TransactionBeneficiaryName: Text;
//         Amount: Decimal;
//         Category: Text;
//         TransactionDescription: Text;
//         SourceReference: Text;
//         RequestApplication: Text;
//         SourceApplication: Text;
//         TransactionDateTime: Text;
//     begin
//         OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
//         ProductID := SelectJsonToken(RequestJson, '$.product_id').AsValue.AsText;
//         PesaType := SelectJsonToken(RequestJson, '$.pesa_type').AsValue.AsText;
//         TransactionAction := SelectJsonToken(RequestJson, '$.action').AsValue.AsText;
//         Command := SelectJsonToken(RequestJson, '$.command').AsValue.AsText;

//         TransactionInitiatorIdentifierType := SelectJsonToken(RequestJson, '$.transaction_initiator_details.identifier_type').AsValue.AsText;
//         TransactionInitiatorIdentifier := SelectJsonToken(RequestJson, '$.transaction_initiator_details.identifier').AsValue.AsText;
//         TransactionInitiatorAccount := SelectJsonToken(RequestJson, '$.transaction_initiator_details.account').AsValue.AsText;
//         TransactionInitiatorName := SelectJsonToken(RequestJson, '$.transaction_initiator_details.name').AsValue.AsText;
//         TransactionInitiatorReference := SelectJsonToken(RequestJson, '$.transaction_initiator_details.reference').AsValue.AsText;

//         TransactionSourceIdentifierType := SelectJsonToken(RequestJson, '$.transaction_source_details.identifier_type').AsValue.AsText;
//         TransactionSourceIdentifier := SelectJsonToken(RequestJson, '$.transaction_source_details.identifier').AsValue.AsText;
//         TransactionSourceAccount := SelectJsonToken(RequestJson, '$.transaction_source_details.account').AsValue.AsText;
//         TransactionSourceName := SelectJsonToken(RequestJson, '$.transaction_source_details.name').AsValue.AsText;

//         TransactionSenderIdentifierType := SelectJsonToken(RequestJson, '$.transaction_sender_details.identifier_type').AsValue.AsText;
//         TransactionSenderIdentifier := SelectJsonToken(RequestJson, '$.transaction_sender_details.identifier').AsValue.AsText;
//         TransactionSenderAccount := SelectJsonToken(RequestJson, '$.transaction_sender_details.account').AsValue.AsText;
//         TransactionSenderName := SelectJsonToken(RequestJson, '$.transaction_sender_details.name').AsValue.AsText;

//         TransactionReceiverIdentifierType := SelectJsonToken(RequestJson, '$.transaction_receiver_details.identifier_type').AsValue.AsText;
//         TransactionReceiverIdentifier := SelectJsonToken(RequestJson, '$.transaction_receiver_details.identifier').AsValue.AsText;
//         TransactionReceiverAccount := SelectJsonToken(RequestJson, '$.transaction_receiver_details.account').AsValue.AsText;
//         TransactionReceiverName := SelectJsonToken(RequestJson, '$.transaction_receiver_details.name').AsValue.AsText;

//         TransactionBeneficiaryIdentifierType := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier_type').AsValue.AsText;
//         TransactionBeneficiaryIdentifier := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier').AsValue.AsText;
//         TransactionBeneficiaryAccount := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.account').AsValue.AsText;
//         TransactionBeneficiaryName := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.name').AsValue.AsText;

//         Amount := SelectJsonToken(RequestJson, '$.amount').AsValue.AsDecimal;
//         Category := SelectJsonToken(RequestJson, '$.category').AsValue.AsText;
//         TransactionDescription := SelectJsonToken(RequestJson, '$.transaction_description').AsValue.AsText;
//         SourceReference := SelectJsonToken(RequestJson, '$.source_reference').AsValue.AsText;
//         RequestApplication := SelectJsonToken(RequestJson, '$.request_application').AsValue.AsText;
//         SourceApplication := SelectJsonToken(RequestJson, '$.source_application').AsValue.AsText;
//         TransactionDateTime := SelectJsonToken(RequestJson, '$.transaction_date_time').AsValue.AsText;

//         if true then begin
//             SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

//             DataJson.Add('transaction_reference', '53f4bf31-79fa-40cb-b935-06792911d5b3');
//             DataJson.Add('transaction_status_description', 'Withdrawal processed successfully');
//             DataJson.Add('transaction_date_time', '2020-01-02 12:34:46');
//         end
//         else begin
//             SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
//         end;
//         ResponseJson.Add(Data, DataJson);
//     end;

//     // ------------------------------------------------------------------------------------------------
//     local procedure PESAOUTConfirmation(RequestJson: JsonObject) ResponseJson: JsonObject
//     var
//         DataJson: JsonObject;
//         OriginatorID: Text;
//         TransactionStatus: Text;
//         TransactionStatusDescription: Text;
//         BeneficiaryIdentifierType: Text;
//         BeneficiaryIdentifier: Text;
//         BeneficiaryName: Text;
//         BeneficiaryReference: Text;
//         TransactionDateTime: Text;
//     begin
//         OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
//         TransactionStatus := SelectJsonToken(RequestJson, '$.transaction_status').AsValue.AsText;
//         TransactionStatusDescription := SelectJsonToken(RequestJson, '$.transaction_status_description').AsValue.AsText;

//         BeneficiaryIdentifierType := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier_type').AsValue.AsText;
//         BeneficiaryIdentifier := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier').AsValue.AsText;
//         BeneficiaryName := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.name').AsValue.AsText;

//         BeneficiaryReference := SelectJsonToken(RequestJson, '$.beneficiary_reference').AsValue.AsText;
//         TransactionDateTime := SelectJsonToken(RequestJson, '$.transaction_date_time').AsValue.AsText;

//         if true then begin
//             SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

//             DataJson.Add('transaction_status', 'SUCCESS/DUPLICATE/ERROR/FAILED');
//             DataJson.Add('transaction_status_description', 'Result processed successfully');
//             DataJson.Add('transaction_date_time', '2020-01-02 12:34:46');
//         end
//         else begin
//             SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
//         end;
//         ResponseJson.Add(Data, DataJson);
//     end;

//     // ------------------------------------------------------------------------------------------------
//     local procedure InternalFundsTransfer(RequestJson: JsonObject) ResponseJson: JsonObject
//     var
//         DataJson: JsonObject;
//         OriginatorID: Text;
//         IdentifierType: Text;
//         Identifier: Text;
//         SourceAccount: Text;
//         DestinationAccount: Text;
//         Amount: Decimal;
//         SourceReference: Text;
//         RequestApplication: Text;
//         SourceApplication: Text;
//         TransactionDescription: Text;
//         TransactionDateTime: Text;
//     begin
//         OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
//         IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
//         Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
//         SourceAccount := SelectJsonToken(RequestJson, '$.source_account').AsValue.AsText;
//         DestinationAccount := SelectJsonToken(RequestJson, '$.destination_account').AsValue.AsText;
//         Amount := SelectJsonToken(RequestJson, '$.amount').AsValue.AsDecimal;
//         SourceReference := SelectJsonToken(RequestJson, '$.source_reference').AsValue.AsText;
//         RequestApplication := SelectJsonToken(RequestJson, '$.request_application').AsValue.AsText;
//         SourceApplication := SelectJsonToken(RequestJson, '$.source_application').AsValue.AsText;
//         TransactionDescription := SelectJsonToken(RequestJson, '$.transaction_description').AsValue.AsText;
//         TransactionDateTime := SelectJsonToken(RequestJson, '$.transaction_date_time').AsValue.AsText;

//         if true then begin
//             SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

//             DataJson.Add('transaction_reference', '53f4bf31-79fa-40cb-b935-06792911d5b3');
//             DataJson.Add('transaction_status', 'SUCCESS/DUPLICATE/ERROR/FAILED');
//             DataJson.Add('transaction_status_description', 'Withdrawal processed successfully');
//         end
//         else begin
//             SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
//         end;
//         ResponseJson.Add(Data, DataJson);
//     end;

//     // ------------------------------------------------------------------------------------------------
//     local procedure PESAINConfirmation(RequestJson: JsonObject) ResponseJson: JsonObject
//     var
//         DataJson: JsonObject;
//         OriginatorID: Text;
//         PesaType: Text;
//         TransactionAction: Text;
//         Command: Text;
//         Sensitivity: Text;
//         Charge: Decimal;
//         IdentifierType: Text;
//         Identifier: Text;
//         TransactionInitiatorIdentifierType: Text;
//         TransactionInitiatorIdentifier: Text;
//         TransactionInitiatorAccount: Text;
//         TransactionInitiatorName: Text;
//         TransactionInitiatorReference: Text;
//         TransactionSourceIdentifierType: Text;
//         TransactionSourceIdentifier: Text;
//         TransactionSourceAccount: Text;
//         TransactionSourceName: Text;
//         TransactionSourceReference: Text;
//         TransactionSenderIdentifierType: Text;
//         TransactionSenderIdentifier: Text;
//         TransactionSenderAccount: Text;
//         TransactionSenderName: Text;
//         TransactionSenderReference: Text;
//         TransactionReceiverIdentifierType: Text;
//         TransactionReceiverIdentifier: Text;
//         TransactionReceiverAccount: Text;
//         TransactionReceiverName: Text;
//         TransactionBeneficiaryIdentifierType: Text;
//         TransactionBeneficiaryIdentifier: Text;
//         TransactionBeneficiaryAccount: Text;
//         TransactionBeneficiaryName: Text;
//         Amount: Decimal;
//         TransactionDescription: Text;
//         SourceReference: Text;
//         RequestApplication: Text;
//         SourceApplication: Text;
//         TransactionDateTime: Text;
//     begin
//         OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
//         PesaType := SelectJsonToken(RequestJson, '$.pesa_type').AsValue.AsText;
//         TransactionAction := SelectJsonToken(RequestJson, '$.action').AsValue.AsText;
//         Command := SelectJsonToken(RequestJson, '$.command').AsValue.AsText;
//         Sensitivity := SelectJsonToken(RequestJson, '$.sensitivity').AsValue.AsText;
//         Charge := SelectJsonToken(RequestJson, '$.charge').AsValue.AsDecimal;
//         IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
//         Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

//         TransactionInitiatorIdentifierType := SelectJsonToken(RequestJson, '$.transaction_initiator_details.identifier_type').AsValue.AsText;
//         TransactionInitiatorIdentifier := SelectJsonToken(RequestJson, '$.transaction_initiator_details.identifier').AsValue.AsText;
//         TransactionInitiatorAccount := SelectJsonToken(RequestJson, '$.transaction_initiator_details.account').AsValue.AsText;
//         TransactionInitiatorName := SelectJsonToken(RequestJson, '$.transaction_initiator_details.name').AsValue.AsText;
//         TransactionInitiatorReference := SelectJsonToken(RequestJson, '$.transaction_initiator_details.reference').AsValue.AsText;

//         TransactionSourceIdentifierType := SelectJsonToken(RequestJson, '$.transaction_source_details.identifier_type').AsValue.AsText;
//         TransactionSourceIdentifier := SelectJsonToken(RequestJson, '$.transaction_source_details.identifier').AsValue.AsText;
//         TransactionSourceAccount := SelectJsonToken(RequestJson, '$.transaction_source_details.account').AsValue.AsText;
//         TransactionSourceName := SelectJsonToken(RequestJson, '$.transaction_source_details.name').AsValue.AsText;
//         TransactionSourceReference := SelectJsonToken(RequestJson, '$.transaction_source_details.reference').AsValue.AsText;

//         TransactionSenderIdentifierType := SelectJsonToken(RequestJson, '$.transaction_sender_details.identifier_type').AsValue.AsText;
//         TransactionSenderIdentifier := SelectJsonToken(RequestJson, '$.transaction_sender_details.identifier').AsValue.AsText;
//         TransactionSenderAccount := SelectJsonToken(RequestJson, '$.transaction_sender_details.account').AsValue.AsText;
//         TransactionSenderName := SelectJsonToken(RequestJson, '$.transaction_sender_details.name').AsValue.AsText;
//         TransactionSenderReference := SelectJsonToken(RequestJson, '$.transaction_sender_details.reference').AsValue.AsText;

//         TransactionReceiverIdentifierType := SelectJsonToken(RequestJson, '$.transaction_receiver_details.identifier_type').AsValue.AsText;
//         TransactionReceiverIdentifier := SelectJsonToken(RequestJson, '$.transaction_receiver_details.identifier').AsValue.AsText;
//         TransactionReceiverAccount := SelectJsonToken(RequestJson, '$.transaction_receiver_details.account').AsValue.AsText;
//         TransactionReceiverName := SelectJsonToken(RequestJson, '$.transaction_receiver_details.name').AsValue.AsText;

//         TransactionBeneficiaryIdentifierType := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier_type').AsValue.AsText;
//         TransactionBeneficiaryIdentifier := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.identifier').AsValue.AsText;
//         TransactionBeneficiaryAccount := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.account').AsValue.AsText;
//         TransactionBeneficiaryName := SelectJsonToken(RequestJson, '$.transaction_beneficiary_details.name').AsValue.AsText;

//         Amount := SelectJsonToken(RequestJson, '$.amount').AsValue.AsDecimal;
//         TransactionDescription := SelectJsonToken(RequestJson, '$.transaction_description').AsValue.AsText;
//         SourceReference := SelectJsonToken(RequestJson, '$.source_reference').AsValue.AsText;
//         RequestApplication := SelectJsonToken(RequestJson, '$.request_application').AsValue.AsText;
//         SourceApplication := SelectJsonToken(RequestJson, '$.source_application').AsValue.AsText;
//         TransactionDateTime := SelectJsonToken(RequestJson, '$.transaction_date_time').AsValue.AsText;

//         if true then begin
//             SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

//             DataJson.Add('transaction_reference', '53f4bf31-79fa-40cb-b935-06792911d5b3');
//             DataJson.Add('transaction_status', 'SUCCESS/DUPLICATE/ERROR/FAILED');
//             DataJson.Add('transaction_status_description', 'Withdrawal processed successfully');
//             DataJson.Add('transaction_date_time', '2020-01-02 12:34:46');
//         end
//         else begin
//             SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
//         end;
//         ResponseJson.Add(Data, DataJson);
//     end;

//     // ------------------------------------------------------------------------------------------------
//     local procedure GetLoanTypes(RequestJson: JsonObject) ResponseJson: JsonObject
//     var
//         DataJson: JsonObject;
//         IdentifierType: Text;
//         Identifier: Text;
//         LoanTypesArray: JsonArray;
//         LoanTypeObject: JsonObject;
//         Iterator: Integer;
//     begin
//         Iterator := 0;

//         IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
//         Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

//         if true then begin
//             SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

//             repeat
//                 LoanTypeObject.Add('loan_type_id', '1000');
//                 LoanTypeObject.Add('loan_type_name', 'NORMAL LOAN');
//                 LoanTypeObject.Add('loan_type_min_amount', 100.00);
//                 LoanTypeObject.Add('loan_type_max_amount', 9999999.00);

//                 LoanTypesArray.Add(LoanTypeObject);
//                 Clear(LoanTypeObject);
//                 Iterator := Iterator + 1;
//             until Iterator = 2;
//             DataJson.Add('loan_types', LoanTypesArray);
//         end
//         else begin
//             SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
//         end;
//         ResponseJson.Add(Data, DataJson);
//     end;

//     // ------------------------------------------------------------------------------------------------
//     local procedure CheckLoanLimit(RequestJson: JsonObject) ResponseJson: JsonObject
//     var
//         DataJson: JsonObject;
//         OriginatorID: Text;
//         IdentifierType: Text;
//         Identifier: Text;
//         LoanTypeID: Text;
//     begin
//         OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
//         IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
//         Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
//         LoanTypeID := SelectJsonToken(RequestJson, '$.loan_type_id').AsValue.AsText;

//         if true then begin
//             SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

//             DataJson.Add('loan_type_id', '1200');
//             DataJson.Add('loan_name', 'Mobile Loan');
//             DataJson.Add('eligible_amount', 125500.00);
//         end
//         else begin
//             SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
//         end;
//         ResponseJson.Add(Data, DataJson);
//     end;

//     // ------------------------------------------------------------------------------------------------
//     local procedure LoanApplication(RequestJson: JsonObject) ResponseJson: JsonObject
//     var
//         DataJson: JsonObject;
//         OriginatorID: Text;
//         IdentifierType: Text;
//         Identifier: Text;
//         LoanTypeID: Text;
//         Amount: Decimal;
//         SourceReference: Text;
//         RequestApplication: Text;
//         TransactionDateTime: Text;
//     begin
//         OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
//         IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
//         Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;
//         LoanTypeID := SelectJsonToken(RequestJson, '$.loan_type_id').AsValue.AsText;
//         Amount := SelectJsonToken(RequestJson, '$.amount').AsValue.AsDecimal;
//         SourceReference := SelectJsonToken(RequestJson, '$.source_reference').AsValue.AsText;
//         RequestApplication := SelectJsonToken(RequestJson, '$.request_application').AsValue.AsText;
//         TransactionDateTime := SelectJsonToken(RequestJson, '$.transaction_date_time').AsValue.AsText;


//         if true then begin
//             SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

//             DataJson.Add('transaction_reference', '2cc-b972-457a-998f-7fb6fa932167');
//             DataJson.Add('loan_serial_number', 'LN:12345-45645');
//             DataJson.Add('loan_type_id', '1200');
//             DataJson.Add('loan_name', 'SUPA LOAN');
//             DataJson.Add('amount', 125000.00);
//         end
//         else begin
//             SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
//         end;
//         ResponseJson.Add(Data, DataJson);
//     end;

//     // ------------------------------------------------------------------------------------------------
//     local procedure GetOutstandingLoans(RequestJson: JsonObject) ResponseJson: JsonObject
//     var
//         DataJson: JsonObject;
//         IdentifierType: Text;
//         Identifier: Text;
//         LoansArray: JsonArray;
//         LoanObject: JsonObject;
//         Iterator: Integer;
//     begin
//         Iterator := 0;

//         IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
//         Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

//         if true then begin
//             SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

//             repeat
//                 LoanObject.Add('loan_serial_number', 'N:203813:03:2020');
//                 LoanObject.Add('loan_type_id', 'N');
//                 LoanObject.Add('loan_type_name', 'NORMAL LOAN');
//                 LoanObject.Add('loan_amount', 120000.00);
//                 LoanObject.Add('loan_balance', 35000.00);
//                 LoanObject.Add('installment_amount', 10000.00);
//                 LoanObject.Add('loan_defaulted_amount', 0.00);
//                 LoanObject.Add('loan_issued_date', '2021-01-03 08:45:15');
//                 LoanObject.Add('loan_end_date', '2021-10-03 08:45:15');
//                 LoanObject.Add('loan_performance', 'PERFORMING/NOT_PERFORMING');
//                 LoanObject.Add('loan_performance_description', 'Loan is performing');

//                 LoansArray.Add(LoanObject);
//                 Clear(LoanObject);
//                 Iterator := Iterator + 1;
//             until Iterator = 3;

//             DataJson.Add('loans', LoansArray);

//         end
//         else begin
//             SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
//         end;
//         ResponseJson.Add(Data, DataJson);
//     end;

//     // ------------------------------------------------------------------------------------------------
//     local procedure GetTransactionCharges(RequestJson: JsonObject) ResponseJson: JsonObject
//     var
//         DataJson: JsonObject;
//         IdentifierType: Text;
//         Identifier: Text;
//         TranscationType: Text;
//         TransactionAmount: Decimal;
//     begin
//         IdentifierType := SelectJsonToken(RequestJson, '$.identifier_type').AsValue.AsText;
//         Identifier := SelectJsonToken(RequestJson, '$.identifier').AsValue.AsText;

//         if true then begin
//             SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');

//             DataJson.Add('total_charge_amount', 34.00);
//         end
//         else begin
//             SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
//         end;
//         ResponseJson.Add(Data, DataJson);
//     end;


//     // ------------------------------------------------------------------------------------------------
//     local procedure VirtualMemberRegistration(RequestJson: JsonObject) ResponseJson: JsonObject
//     var
//         DataJson: JsonObject;
//         OriginatorID: Text;
//         MobileNumber: Text;
//         Name: Text;
//         NationalIDNumber: Text;
//         EmailAddress: Text;
//         ReferrerMobileNumber: Text;
//     begin
//         OriginatorID := SelectJsonToken(RequestJson, '$.originator_id').AsValue.AsText;
//         MobileNumber := SelectJsonToken(RequestJson, '$.mobile_number').AsValue.AsText;
//         Name := SelectJsonToken(RequestJson, '$.name').AsValue.AsText;
//         NationalIDNumber := SelectJsonToken(RequestJson, '$.national_id_number').AsValue.AsText;
//         EmailAddress := SelectJsonToken(RequestJson, '$.email_address').AsValue.AsText;
//         ReferrerMobileNumber := SelectJsonToken(RequestJson, '$.referrer_mobile_number').AsValue.AsText;


//         if true then begin
//             SetResponseStatus(ResponseJson, 'success', 'Success', 'Request processed successfully');
//         end
//         else begin
//             SetResponseStatus(ResponseJson, 'error', 'Error', 'An error occurred');
//         end;
//         ResponseJson.Add(Data, DataJson);
//     end;

//     // ################################################################################################
//     // RESPONSE GENERATION PROCEDURE
//     // ################################################################################################
//     local procedure WrapResponse(RequestJson: JsonObject; ResponseJson: JsonObject) Wrapped: Text;
//     var
//         ResponseInnerJson: JsonObject;
//         WrappedJson: JsonObject;
//         PayloadJson: JsonObject;

//         RequestAction: Text;
//         RequestId: Text;
//         ResponseStatus: Text;
//         ResponsePayload: Text;
//         ResponseHash: Text;
//     begin
//         RequestId := SelectJsonToken(RequestJson, '$.request.id').AsValue.AsText;
//         RequestAction := SelectJsonToken(RequestJson, '$.request.action').AsValue.AsText;

//         ResponseStatus := SelectJsonToken(ResponseJson, '$.' + Status).AsValue.AsText;

//         ResponseJson.Remove(Status);

//         PayloadJson.WriteTo(ResponsePayload);
//         ResponseHash := Sha256Hash(ResponsePayload);

//         ResponseInnerJson.Add('id', RequestId);
//         ResponseInnerJson.Add('action', RequestAction);
//         ResponseInnerJson.Add('status', ResponseStatus);
//         ResponseInnerJson.Add('hash', ResponseHash);
//         ResponseInnerJson.Add('timestamp', CurrentDateTime);
//         ResponseInnerJson.Add('payload', ResponseJson);

//         WrappedJson.Add('response', ResponseInnerJson);
//         WrappedJson.WriteTo(Wrapped);
//     end;

//     // SUPPORTING PROCEDURES
//     // ------------------------------------------------------------------------------------------------

//     local procedure SetResponseStatus(var ResponseJson: JsonObject; TheStatus: Text; TheTitle: Text; TheMessage: Text)
//     begin
//         ResponseJson.Add(Status, TheStatus);
//         ResponseJson.Add(Title, TheTitle);
//         ResponseJson.Add(Message, TheMessage);
//     end;

//     local procedure ValidateUserSession(RequestJson: JsonObject) Response: Boolean
//     var
//         UserName: Text;
//         SessionId: Text;
//         Employee: Record Employee;
//     begin
//         UserName := SelectJsonToken(RequestJson, '$.request.user').AsValue.AsText;
//         SessionId := SelectJsonToken(RequestJson, '$.request.session_id').AsValue.AsText;

//         Response := true;
//     end;

//     local procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text) JsonToken: JsonToken;
//     begin
//         if not JsonObject.Get(TokenKey, JsonToken) then
//             Error('Could not find a token with key %1', TokenKey);
//     end;

//     local procedure SelectJsonToken(JsonObject: JsonObject; Path: text) JsonToken: JsonToken;
//     begin
//         if not JsonObject.SelectToken(Path, JsonToken) then
//             Error('Could not find a token with path %1', Path);
//     end;

//     local procedure ValidateRequestHash(RequestJson: JsonObject)
//     var
//         PayLoadJson: JsonObject;
//         PayLoad: Text;
//         HashFromPayload: Text;
//         HashedPayload: Text;
//     begin
//         exit;
//         HashFromPayload := SelectJsonToken(RequestJson, '$.request.hash').AsValue.AsText;
//         PayLoadJson := SelectJsonToken(RequestJson, '$.request.payload').AsObject;
//         PayLoadJson.WriteTo(PayLoad);
//         HashedPayload := Sha256Hash(PayLoad);

//         if HashedPayload <> HashFromPayload then
//             Error('Payload hash mismatch');
//     end;

//     local procedure Sha256Hash(ClearText: Text): Text
//     var
//         CryptographyManagement: codeunit "Cryptography Management";
//         HashAlgorithmType: option MD5,SHA1,SHA256,SHA384,SHA512;
//     begin
//         exit(Text.LowerCase(CryptographyManagement.GenerateHash(ClearText, HashAlgorithmType::SHA256)));
//     end;
// }
