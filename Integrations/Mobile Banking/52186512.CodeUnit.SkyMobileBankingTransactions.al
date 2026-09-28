codeunit 52186512 "Sky M-Banking Transactions"
{
    procedure LogAccountBalanceEnquiry(
        APIRequestID: Text;
        IdentifierType: Text;
        Identifier: Text;
        SavingsAccountNumber: Text;
        sourceApplication: Text;
        var theMember: Record Members
    )
    var
        SkyTrans: Record "Sky M-Banking Trans. Buffer";
        GFunc: Codeunit "Global Functions";
    begin
        // Log the transaction
        SkyTrans.Init;

        SkyTrans."API Request ID" := APIRequestID;
        SkyTrans."Originator ID" := APIRequestID;

        SkyTrans."Transaction ID" := GFunc.CleanGuid;

        SkyTrans."Identifier Type" := IdentifierType;
        SkyTrans."Identifier" := Identifier;
        SkyTrans."Savings Account" := GetMemberFosaAcc(theMember);
        SkyTrans."Beneficiary Account" := SavingsAccountNumber;


        SkyTrans."Transaction Type" := "Sky M-Banking Trans Types"::"Account Balance Enquiry";
        SkyTrans."Transaction Date Time" := CurrentDateTime;
        SkyTrans."Transaction Date" := Today;
        SkyTrans."Transaction Time" := Time;
        SkyTrans."Transaction Status" := SkyTrans."Transaction Status"::CONFIRMED;
        SkyTrans."Source Application" := sourceApplication;
        SkyTrans.Posted := false;
        // SkyTrans.Reversed := false;

        SkyTrans.Insert(true);
    end;

    procedure LogAccountMiniStatement(
        APIRequestID: Text;
        IdentifierType: Text;
        Identifier: Text;
        SavingsAccountNumber: Text;
        var theMember: Record Members
    )
    var
        SkyTrans: Record "Sky M-Banking Trans. Buffer";
        GFunc: Codeunit "Global Functions";
    begin
        // Log the transaction
        SkyTrans.Init;

        SkyTrans."API Request ID" := APIRequestID;
        SkyTrans."Originator ID" := APIRequestID;

        SkyTrans."Transaction ID" := GFunc.CleanGuid;

        SkyTrans."Identifier Type" := IdentifierType;
        SkyTrans."Identifier" := Identifier;
        SkyTrans."Savings Account" := GetMemberFosaAcc(theMember);
        SkyTrans."Beneficiary Account" := SavingsAccountNumber;


        SkyTrans."Transaction Type" := "Sky M-Banking Trans Types"::"Account Mini-Statement";
        SkyTrans."Transaction Date Time" := CurrentDateTime;
        SkyTrans."Transaction Date" := Today;
        SkyTrans."Transaction Time" := Time;
        SkyTrans."Transaction Status" := SkyTrans."Transaction Status"::CONFIRMED;
        SkyTrans.Posted := false;
        // SkyTrans.Reversed := false;

        SkyTrans.Insert(true);
    end;

    procedure LogAccountFullStatement(
        APIRequestID: Text;
        IdentifierType: Text;
        Identifier: Text;
        SavingsAccountNumber: Text;
        SourceApplication: Text;
        var theMember: Record Members
    )
    var
        SkyTrans: Record "Sky M-Banking Trans. Buffer";
        GFunc: Codeunit "Global Functions";
    begin
        // Log the transaction
        SkyTrans.Init;

        SkyTrans."API Request ID" := APIRequestID;
        SkyTrans."Originator ID" := APIRequestID;

        SkyTrans."Transaction ID" := GFunc.CleanGuid;

        SkyTrans."Identifier Type" := IdentifierType;
        SkyTrans."Identifier" := Identifier;
        SkyTrans."Savings Account" := GetMemberFosaAcc(theMember);
        SkyTrans."Beneficiary Account" := SavingsAccountNumber;


        SkyTrans."Transaction Type" := "Sky M-Banking Trans Types"::"Account Full-Statement";
        SkyTrans."Transaction Date Time" := CurrentDateTime;
        SkyTrans."Transaction Date" := Today;
        SkyTrans."Transaction Time" := Time;
        SkyTrans."Transaction Status" := SkyTrans."Transaction Status"::CONFIRMED;
        SkyTrans."Source Application" := SourceApplication;
        SkyTrans.Posted := false;
        // SkyTrans.Reversed := false;

        SkyTrans.Insert(true);
    end;

    procedure LogWithdrawalRequest(
        var MpesaTrans: Record "Sky M-Banking Trans. Buffer";
        Payload: JsonObject;
        APIRequestID: JsonToken
    )
    var
        originator_id: JsonToken;
        pesa_type: JsonToken;
        action: JsonToken;
        command: JsonToken;
        // sensitivity: JsonToken;
        // charge: JsonToken;
        // identifier_type: JsonToken;
        // identifier: JsonToken;

        // Initiator
        transaction_initiator_details_identifier_type: JsonToken;
        transaction_initiator_details_identifier: JsonToken;
        transaction_initiator_details_account: JsonToken;
        transaction_initiator_details_name: JsonToken;
        transaction_initiator_details_reference: JsonToken;
        transaction_initiator_details_other_details: JsonToken;
        // Source
        transaction_source_details_identifier_type: JsonToken;
        transaction_source_details_identifier: JsonToken;
        transaction_source_details_account: JsonToken;
        transaction_source_details_name: JsonToken;
        transaction_source_details_reference: JsonToken;
        transaction_source_details_other_details: JsonToken;
        // Sender
        transaction_sender_details_identifier_type: JsonToken;
        transaction_sender_details_identifier: JsonToken;
        transaction_sender_details_account: JsonToken;
        transaction_sender_details_name: JsonToken;
        transaction_sender_details_reference: JsonToken;
        transaction_sender_details_other_details: JsonToken;
        // Receiver
        transaction_receiver_details_identifier_type: JsonToken;
        transaction_receiver_details_identifier: JsonToken;
        transaction_receiver_details_account: JsonToken;
        transaction_receiver_details_name: JsonToken;
        transaction_receiver_details_reference: JsonToken;
        transaction_receiver_details_other_details: JsonToken;
        // Beneficiary
        transaction_beneficiary_details_identifier_type: JsonToken;
        transaction_beneficiary_details_identifier: JsonToken;
        transaction_beneficiary_details_account: JsonToken;
        transaction_beneficiary_details_name: JsonToken;
        transaction_beneficiary_details_reference: JsonToken;
        transaction_beneficiary_details_other_details: JsonToken;

        amount: JsonToken;
        transaction_description: JsonToken;
        category: JsonToken;
        source_reference: JsonToken;
        request_application: JsonToken;
        source_application: JsonToken;
        transaction_date_time: JsonToken;

        GamingPaybills: Record "Gaming Paybills Setup";
    begin
        Payload.Get('originator_id', originator_id);
        Payload.Get('pesa_type', pesa_type);
        Payload.Get('action', action);
        Payload.Get('command', command);
        // Payload.Get('sensitivity', sensitivity);
        // Payload.Get('charge', charge);
        // Payload.Get('identifier_type', identifier_type);
        // Payload.Get('identifier', identifier);

        Payload.SelectToken('$.transaction_initiator_details.identifier_type', transaction_initiator_details_identifier_type);
        Payload.SelectToken('$.transaction_initiator_details.identifier', transaction_initiator_details_identifier);
        Payload.SelectToken('$.transaction_initiator_details.account', transaction_initiator_details_account);
        Payload.SelectToken('$.transaction_initiator_details.name', transaction_initiator_details_name);
        Payload.SelectToken('$.transaction_initiator_details.reference', transaction_initiator_details_reference);
        Payload.SelectToken('$.transaction_initiator_details.other_details', transaction_initiator_details_other_details);

        Payload.SelectToken('$.transaction_source_details.identifier_type', transaction_source_details_identifier_type);
        Payload.SelectToken('$.transaction_source_details.identifier', transaction_source_details_identifier);
        Payload.SelectToken('$.transaction_source_details.account', transaction_source_details_account);
        Payload.SelectToken('$.transaction_source_details.name', transaction_source_details_name);
        Payload.SelectToken('$.transaction_source_details.reference', transaction_source_details_reference);
        Payload.SelectToken('$.transaction_source_details.other_details', transaction_source_details_other_details);

        Payload.SelectToken('$.transaction_sender_details.identifier_type', transaction_sender_details_identifier_type);
        Payload.SelectToken('$.transaction_sender_details.identifier', transaction_sender_details_identifier);
        Payload.SelectToken('$.transaction_sender_details.account', transaction_sender_details_account);
        Payload.SelectToken('$.transaction_sender_details.name', transaction_sender_details_name);
        Payload.SelectToken('$.transaction_sender_details.reference', transaction_sender_details_reference);
        Payload.SelectToken('$.transaction_sender_details.other_details', transaction_sender_details_other_details);

        Payload.SelectToken('$.transaction_receiver_details.identifier_type', transaction_receiver_details_identifier_type);
        Payload.SelectToken('$.transaction_receiver_details.identifier', transaction_receiver_details_identifier);
        Payload.SelectToken('$.transaction_receiver_details.account', transaction_receiver_details_account);
        Payload.SelectToken('$.transaction_receiver_details.name', transaction_receiver_details_name);
        Payload.SelectToken('$.transaction_receiver_details.reference', transaction_receiver_details_reference);
        Payload.SelectToken('$.transaction_receiver_details.other_details', transaction_receiver_details_other_details);

        Payload.SelectToken('$.transaction_beneficiary_details.identifier_type', transaction_beneficiary_details_identifier_type);
        Payload.SelectToken('$.transaction_beneficiary_details.identifier', transaction_beneficiary_details_identifier);
        Payload.SelectToken('$.transaction_beneficiary_details.account', transaction_beneficiary_details_account);
        Payload.SelectToken('$.transaction_beneficiary_details.name', transaction_beneficiary_details_name);
        Payload.SelectToken('$.transaction_beneficiary_details.reference', transaction_beneficiary_details_reference);
        Payload.SelectToken('$.transaction_beneficiary_details.other_details', transaction_beneficiary_details_other_details);

        Payload.Get('amount', amount);
        Payload.Get('transaction_description', transaction_description);
        Payload.Get('category', category);
        Payload.Get('source_reference', source_reference);
        Payload.Get('request_application', request_application);
        Payload.Get('source_application', source_application);
        Payload.Get('transaction_date_time', transaction_date_time);

        MpesaTrans.Init;

        MpesaTrans."Transaction Type" := MpesaTrans."Transaction Type"::" ";
        MpesaTrans."Transaction Status" := MpesaTrans."Transaction Status"::" ";

        MpesaTrans."API Request ID" := APIRequestID.AsValue.AsText;
        MpesaTrans."Transaction ID" := GlobalFunctions.CleanGuid;

        MpesaTrans."Originator ID" := originator_id.AsValue.AsText;
        MpesaTrans."PESA Type" := pesa_type.AsValue.AsText;
        MpesaTrans.Action := action.AsValue.AsText;
        MpesaTrans.Command := command.AsValue.AsText;
        // MpesaDepositTrans.Sensitivity := sensitivity.AsValue.AsText;
        // MpesaDepositTrans.Charge := charge.AsValue.AsDecimal;
        // MpesaDepositTrans."Identifier Type" := identifier_type.AsValue.AsText;
        // MpesaDepositTrans.Identifier := identifier.AsValue.AsText;

        MpesaTrans."Initiator Identifier Type" := transaction_initiator_details_identifier_type.AsValue.AsText;
        MpesaTrans."Initiator Identifier" := transaction_initiator_details_identifier.AsValue.AsText;
        MpesaTrans."Initiator Account" := transaction_initiator_details_account.AsValue.AsText;
        MpesaTrans."Initiator Name" := transaction_initiator_details_name.AsValue.AsText;
        MpesaTrans."Initiator Reference" := transaction_initiator_details_reference.AsValue.AsText;
        MpesaTrans."Initiator Other Details" := transaction_initiator_details_other_details.AsValue.AsText;

        MpesaTrans."Source Identifier Type" := transaction_source_details_identifier_type.AsValue.AsText;
        MpesaTrans."Source Identifier" := transaction_source_details_identifier.AsValue.AsText;
        MpesaTrans."Source Account" := transaction_source_details_account.AsValue.AsText;
        MpesaTrans."Source Name" := transaction_source_details_name.AsValue.AsText;
        MpesaTrans."Source Reference" := transaction_source_details_reference.AsValue.AsText;
        MpesaTrans."Source Other Details" := transaction_source_details_other_details.AsValue.AsText;

        MpesaTrans."Sender Identifier Type" := transaction_sender_details_identifier_type.AsValue.AsText;
        MpesaTrans."Sender Identifier" := transaction_sender_details_identifier.AsValue.AsText;
        MpesaTrans."Sender Account" := transaction_sender_details_account.AsValue.AsText;
        MpesaTrans."Sender Name" := transaction_sender_details_name.AsValue.AsText;
        MpesaTrans."Sender Reference" := transaction_sender_details_reference.AsValue.AsText;
        MpesaTrans."Sender Other Details" := transaction_sender_details_other_details.AsValue.AsText;

        MpesaTrans."Receiver Identifier Type" := transaction_receiver_details_identifier_type.AsValue.AsText;
        MpesaTrans."Receiver Identifier" := transaction_receiver_details_identifier.AsValue.AsText;
        MpesaTrans."Receiver Account" := transaction_receiver_details_account.AsValue.AsText;
        MpesaTrans."Receiver Name" := transaction_receiver_details_name.AsValue.AsText;
        MpesaTrans."Receiver Reference" := transaction_receiver_details_reference.AsValue.AsText;
        MpesaTrans."Receiver Other Details" := transaction_receiver_details_other_details.AsValue.AsText;

        MpesaTrans."Beneficiary Identifier Type" := transaction_beneficiary_details_identifier_type.AsValue.AsText;
        MpesaTrans."Beneficiary Identifier" := transaction_beneficiary_details_identifier.AsValue.AsText;
        MpesaTrans."Beneficiary Account" := transaction_beneficiary_details_account.AsValue.AsText;
        MpesaTrans."Beneficiary Name" := transaction_beneficiary_details_name.AsValue.AsText;
        MpesaTrans."Beneficiary Reference" := transaction_beneficiary_details_reference.AsValue.AsText;
        MpesaTrans."Beneficiary Other Details" := transaction_beneficiary_details_other_details.AsValue.AsText;

        MpesaTrans."Transaction Amount" := amount.AsValue.AsDecimal;
        MpesaTrans."Transaction Description" := transaction_description.AsValue.AsText;
        MpesaTrans."Transaction Category" := category.AsValue.AsText;
        MpesaTrans."Transaction Source Reference" := source_reference.AsValue.AsText;
        MpesaTrans."Request Application" := request_application.AsValue.AsText;
        MpesaTrans."Source Application" := source_application.AsValue.AsText;

        Evaluate(MpesaTrans."Transaction Date Time", transaction_date_time.AsValue.AsText);
        MpesaTrans."Transaction Date" := DT2Date(MpesaTrans."Transaction Date Time");
        MpesaTrans."Transaction Time" := DT2Time(MpesaTrans."Transaction Date Time");

        MpesaTrans.Posted := false;
        // MpesaTrans.Reversed := false;

        case MpesaTrans."Transaction Category" of
            'MPESA_WITHDRAWAL':
                MpesaTrans."Transaction Type" := MpesaTrans."Transaction Type"::"Mpesa Withdrawal";
            'BILL_PAYMENT':
                begin
                    MpesaTrans."Transaction Type" := MpesaTrans."Transaction Type"::"Utility Payment";

                    GamingPaybills.Reset;
                    GamingPaybills.SetRange("Paybill / Till No.", MpesaTrans."Receiver Identifier");
                    if GamingPaybills.FindFirst then begin
                        MpesaTrans."Transaction Type" := MpesaTrans."Transaction Type"::"Gaming Utility Payment";
                    end;
                end;
            'BANK_TRANSFER':
                MpesaTrans."Transaction Type" := MpesaTrans."Transaction Type"::"Bank Transfer";
            'AIRTIME_PURCHASE':
                MpesaTrans."Transaction Type" := MpesaTrans."Transaction Type"::Airtime;
            'MPESA_C2B_DEPOSIT':
                MpesaTrans."Transaction Type" := MpesaTrans."Transaction Type"::"Mpesa Deposit";
            'TILL_PAYMENT':
                begin
                    MpesaTrans."Transaction Type" := MpesaTrans."Transaction Type"::"Till Payment";

                    GamingPaybills.Reset;
                    GamingPaybills.SetRange("Paybill / Till No.", MpesaTrans."Receiver Identifier");
                    if GamingPaybills.FindFirst then begin
                        MpesaTrans."Transaction Type" := MpesaTrans."Transaction Type"::"Gaming Utility Payment";
                    end;
                end;
        end;

        MpesaTrans."Savings Account" := MpesaTrans."Source Account";
    end;

    procedure ProcessWithdrawalResult(
        Payload: JsonObject;
        APIRequestID: JsonToken;
        var WithdrawalTrans: Record "Sky M-Banking Trans. Buffer"
    )
    var
        originator_id: JsonToken;
        transaction_status: JsonToken; // CONFIRMED, REVERSE_CONFIRMED
        transaction_status_description: JsonToken;

        // Beneficiary details update
        transaction_beneficiary_details_identifier_type: JsonToken;
        transaction_beneficiary_details_identifier: JsonToken;
        transaction_beneficiary_details_name: JsonToken;
        transaction_beneficiary_details_other_details: JsonToken;

        beneficiary_reference: JsonToken;
        transaction_date_time: JsonToken;
    begin
        Payload.Get('originator_id', originator_id);
        Payload.Get('transaction_status', transaction_status);
        Payload.Get('transaction_status_description', transaction_status_description);

        Payload.SelectToken('$.transaction_beneficiary_details.identifier_type', transaction_beneficiary_details_identifier_type);
        Payload.SelectToken('$.transaction_beneficiary_details.identifier', transaction_beneficiary_details_identifier);
        Payload.SelectToken('$.transaction_beneficiary_details.name', transaction_beneficiary_details_name);
        Payload.SelectToken('$.transaction_beneficiary_details.other_details', transaction_beneficiary_details_other_details);

        Payload.Get('beneficiary_reference', beneficiary_reference);
        Payload.Get('transaction_date_time', transaction_date_time);

        if transaction_status.AsValue.AsText = 'CONFIRMED' then begin
            // Log details
            WithdrawalTrans."Beneficiary Identifier Type" := transaction_beneficiary_details_identifier_type.AsValue.AsText;
            WithdrawalTrans."Beneficiary Identifier" := transaction_beneficiary_details_identifier.AsValue.AsText;
            WithdrawalTrans."Beneficiary Name" := transaction_beneficiary_details_name.AsValue.AsText;
            WithdrawalTrans."Beneficiary Other details" := transaction_beneficiary_details_other_details.AsValue.AsText;
            WithdrawalTrans."Beneficiary Reference" := beneficiary_reference.AsValue.AsText;

            Evaluate(WithdrawalTrans."Transaction Date Time", transaction_date_time.AsValue.AsText);

            // Mark for posting
            WithdrawalTrans."Transaction Status" := WithdrawalTrans."Transaction Status"::CONFIRMED;
            WithdrawalTrans.Modify(true);
        end;

        if transaction_status.AsValue.AsText = 'REVERSE_CONFIRMED' then begin
            Evaluate(WithdrawalTrans."Transaction Date Time", transaction_date_time.AsValue.AsText);

            // Mark for posting - reversal
            WithdrawalTrans."Transaction Status" := WithdrawalTrans."Transaction Status"::REVERSE_CONFIRMED;
            WithdrawalTrans.Modify(true);
        end;
    end;

    procedure LogIFTAccountToAccount(
        var MpesaTrans: Record "Sky M-Banking Trans. Buffer";
        Payload: JsonObject;
        APIRequestID: JsonToken
    )
    var
        originator_id: JsonToken;

        identifier_type: JsonToken;
        identifier: JsonToken;
        source_account: JsonToken;

        destination_account: JsonToken;
        amount: JsonToken;
        source_reference: JsonToken;
        request_application: JsonToken;
        source_application: JsonToken;
        transaction_description: JsonToken;
        transaction_date_time: JsonToken;
    begin
        Payload.Get('originator_id', originator_id);
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('source_account', source_account);
        Payload.Get('destination_account', destination_account);
        Payload.Get('amount', amount);
        Payload.Get('source_reference', source_reference);
        Payload.Get('request_application', request_application);
        Payload.Get('source_application', source_application);
        Payload.Get('transaction_description', transaction_description);
        Payload.Get('transaction_date_time', transaction_date_time);

        MpesaTrans.Init;

        MpesaTrans."Transaction Type" := MpesaTrans."Transaction Type"::"Account Transfer";

        MpesaTrans."API Request ID" := APIRequestID.AsValue.AsText;
        MpesaTrans."Transaction ID" := GlobalFunctions.CleanGuid;

        MpesaTrans."Originator ID" := originator_id.AsValue.AsText;
        MpesaTrans."Identifier Type" := identifier_type.AsValue.AsText;
        MpesaTrans.Identifier := identifier.AsValue.AsText;

        MpesaTrans."Savings Account" := source_account.AsValue.AsText;
        MpesaTrans."Destination Account" := destination_account.AsValue.AsText;

        if GlobalFunctions.IsKesasaAccount(MpesaTrans."Savings Account") then begin
            MpesaTrans."Transaction Type" := MpesaTrans."Transaction Type"::"KESASA Account Transfer";
        end;

        MpesaTrans."Transaction Amount" := amount.AsValue.AsDecimal;
        MpesaTrans."Transaction Description" := transaction_description.AsValue.AsText;
        MpesaTrans."Transaction Source Reference" := source_reference.AsValue.AsText;
        MpesaTrans."Request Application" := request_application.AsValue.AsText;
        MpesaTrans."Source Application" := source_application.AsValue.AsText;

        Evaluate(MpesaTrans."Transaction Date Time", transaction_date_time.AsValue.AsText);
        MpesaTrans."Transaction Date" := DT2Date(MpesaTrans."Transaction Date Time");
        MpesaTrans."Transaction Time" := DT2Time(MpesaTrans."Transaction Date Time");

        MpesaTrans."Transaction Status" := MpesaTrans."Transaction Status"::CONFIRMED;
        MpesaTrans.Posted := false;
        // MpesaTrans.Reversed := false;
    end;

    procedure DividenceAdvanceQualification(MemberNo: Code[30]; Productyp: Code[20]) QualifiedAmount: Decimal
    var
        myInt: Integer;
        DividenceAd: Record "Dividend Progression";
        ProductSet: Record "Product Factory";
        loansProcess: Codeunit "Loans Process";
    begin
        QualifiedAmount := 0;
        if ProductSet.Get(Productyp) then begin
            // DividenceAd.Reset();
            // DividenceAd.SetRange("Member No", MemberNo);
            // if DividenceAd.find('-') then begin
            //     QualifiedAmount := ProductSet."FosaLoan Multiplier" * DividenceAd."Net Dividends";
            //     exit(QualifiedAmount);
            // end else
            //     exit(QualifiedAmount);
            QualifiedAmount := Round((loansProcess.ComputeDividendsDiscounting(MemberNo, ProductSet."Product ID", true)), 1, '<');
            exit(QualifiedAmount);
        end;

    end;

    procedure LogIFTLoanRepayment(
        var MpesaTrans: Record "Sky M-Banking Trans. Buffer";
        Payload: JsonObject;
        APIRequestID: JsonToken
    )
    var
        originator_id: JsonToken;

        identifier_type: JsonToken;
        identifier: JsonToken;
        source_account: JsonToken;

        destination_account: JsonToken;
        amount: JsonToken;
        source_reference: JsonToken;
        request_application: JsonToken;
        source_application: JsonToken;
        transaction_description: JsonToken;
        transaction_date_time: JsonToken;

        theLoan: Record Loans;
    begin
        Payload.Get('originator_id', originator_id);
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('source_account', source_account);
        Payload.Get('destination_account', destination_account);
        Payload.Get('amount', amount);
        Payload.Get('source_reference', source_reference);
        Payload.Get('request_application', request_application);
        Payload.Get('source_application', source_application);
        Payload.Get('transaction_description', transaction_description);
        Payload.Get('transaction_date_time', transaction_date_time);

        MpesaTrans.Init;

        MpesaTrans."Transaction Type" := MpesaTrans."Transaction Type"::"Pay Loan From Account";

        MpesaTrans."API Request ID" := APIRequestID.AsValue.AsText;
        MpesaTrans."Transaction ID" := GlobalFunctions.CleanGuid;

        MpesaTrans."Originator ID" := originator_id.AsValue.AsText;
        MpesaTrans."Identifier Type" := identifier_type.AsValue.AsText;
        MpesaTrans.Identifier := identifier.AsValue.AsText;

        MpesaTrans."Savings Account" := source_account.AsValue.AsText;
        MpesaTrans."Loan No." := destination_account.AsValue.AsText;

        theLoan.Reset;
        theLoan.SetRange("Loan No.", MpesaTrans."Loan No.");
        if theLoan.FindFirst then begin
            MpesaTrans."Loan Account" := theLoan."Loan Account";
        end else begin
            MpesaTrans."Loan Account" := '';
        end;

        MpesaTrans."Transaction Amount" := amount.AsValue.AsDecimal;
        MpesaTrans."Transaction Description" := transaction_description.AsValue.AsText;
        MpesaTrans."Transaction Source Reference" := source_reference.AsValue.AsText;
        MpesaTrans."Request Application" := request_application.AsValue.AsText;
        MpesaTrans."Source Application" := source_application.AsValue.AsText;

        Evaluate(MpesaTrans."Transaction Date Time", transaction_date_time.AsValue.AsText);
        MpesaTrans."Transaction Date" := DT2Date(MpesaTrans."Transaction Date Time");
        MpesaTrans."Transaction Time" := DT2Time(MpesaTrans."Transaction Date Time");

        MpesaTrans."Transaction Status" := MpesaTrans."Transaction Status"::CONFIRMED;
        MpesaTrans.Posted := false;
        // MpesaTrans.Reversed := false;
    end;

    procedure LogDepositRequest(
        var MpesaDepositTrans: Record "Sky M-Banking Trans. Buffer";
        Payload: JsonObject;
        APIRequestID: JsonToken;
        IsLoanRepayment: Boolean
    )
    var
        originator_id: JsonToken;
        pesa_type: JsonToken;
        action: JsonToken;
        command: JsonToken;
        sensitivity: JsonToken;
        charge: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        // Initiator
        transaction_initiator_details_identifier_type: JsonToken;
        transaction_initiator_details_identifier: JsonToken;
        transaction_initiator_details_account: JsonToken;
        transaction_initiator_details_name: JsonToken;
        transaction_initiator_details_reference: JsonToken;
        transaction_initiator_details_other_details: JsonToken;
        // Source
        transaction_source_details_identifier_type: JsonToken;
        transaction_source_details_identifier: JsonToken;
        transaction_source_details_account: JsonToken;
        transaction_source_details_name: JsonToken;
        transaction_source_details_reference: JsonToken;
        transaction_source_details_other_details: JsonToken;
        // Sender
        transaction_sender_details_identifier_type: JsonToken;
        transaction_sender_details_identifier: JsonToken;
        transaction_sender_details_account: JsonToken;
        transaction_sender_details_name: JsonToken;
        transaction_sender_details_reference: JsonToken;
        transaction_sender_details_other_details: JsonToken;
        // Receiver
        transaction_receiver_details_identifier_type: JsonToken;
        transaction_receiver_details_identifier: JsonToken;
        transaction_receiver_details_account: JsonToken;
        transaction_receiver_details_name: JsonToken;
        transaction_receiver_details_reference: JsonToken;
        transaction_receiver_details_other_details: JsonToken;
        // Beneficiary
        transaction_beneficiary_details_identifier_type: JsonToken;
        transaction_beneficiary_details_identifier: JsonToken;
        transaction_beneficiary_details_account: JsonToken;
        transaction_beneficiary_details_name: JsonToken;
        transaction_beneficiary_details_reference: JsonToken;
        transaction_beneficiary_details_other_details: JsonToken;

        amount: JsonToken;
        transaction_description: JsonToken;
        category: JsonToken;
        source_reference: JsonToken;
        request_application: JsonToken;
        source_application: JsonToken;
        transaction_date_time: JsonToken;

        BeneficiaryLoanAccount: Record Loans;
        TheBeneficiary: Record Members;
        TheBeneficiaryIdentifierNo: Text;
        BeneficiarySavingsAccount: Record "Savings Accounts";
        BeneficiaryLoans: Record Loans;

        MobileDepositkeywordSetup: Record "Mobile Deposits Keywords Setup";
        ExitKeywordSearch: Text;
        SearchAccount: Text;

        DepositType: Text;
        DepositIdNo: Text;
    begin
        Payload.Get('originator_id', originator_id);
        Payload.Get('pesa_type', pesa_type);
        Payload.Get('action', action);
        Payload.Get('command', command);
        Payload.Get('sensitivity', sensitivity);
        Payload.Get('charge', charge);
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);

        Payload.SelectToken('$.transaction_initiator_details.identifier_type', transaction_initiator_details_identifier_type);
        Payload.SelectToken('$.transaction_initiator_details.identifier', transaction_initiator_details_identifier);
        Payload.SelectToken('$.transaction_initiator_details.account', transaction_initiator_details_account);
        Payload.SelectToken('$.transaction_initiator_details.name', transaction_initiator_details_name);
        Payload.SelectToken('$.transaction_initiator_details.reference', transaction_initiator_details_reference);
        Payload.SelectToken('$.transaction_initiator_details.other_details', transaction_initiator_details_other_details);

        Payload.SelectToken('$.transaction_source_details.identifier_type', transaction_source_details_identifier_type);
        Payload.SelectToken('$.transaction_source_details.identifier', transaction_source_details_identifier);
        Payload.SelectToken('$.transaction_source_details.account', transaction_source_details_account);
        Payload.SelectToken('$.transaction_source_details.name', transaction_source_details_name);
        Payload.SelectToken('$.transaction_source_details.reference', transaction_source_details_reference);
        Payload.SelectToken('$.transaction_source_details.other_details', transaction_source_details_other_details);

        Payload.SelectToken('$.transaction_sender_details.identifier_type', transaction_sender_details_identifier_type);
        Payload.SelectToken('$.transaction_sender_details.identifier', transaction_sender_details_identifier);
        Payload.SelectToken('$.transaction_sender_details.account', transaction_sender_details_account);
        Payload.SelectToken('$.transaction_sender_details.name', transaction_sender_details_name);
        Payload.SelectToken('$.transaction_sender_details.reference', transaction_sender_details_reference);
        Payload.SelectToken('$.transaction_sender_details.other_details', transaction_sender_details_other_details);

        Payload.SelectToken('$.transaction_receiver_details.identifier_type', transaction_receiver_details_identifier_type);
        Payload.SelectToken('$.transaction_receiver_details.identifier', transaction_receiver_details_identifier);
        Payload.SelectToken('$.transaction_receiver_details.account', transaction_receiver_details_account);
        Payload.SelectToken('$.transaction_receiver_details.name', transaction_receiver_details_name);
        Payload.SelectToken('$.transaction_receiver_details.reference', transaction_receiver_details_reference);
        Payload.SelectToken('$.transaction_receiver_details.other_details', transaction_receiver_details_other_details);

        Payload.SelectToken('$.transaction_beneficiary_details.identifier_type', transaction_beneficiary_details_identifier_type);
        Payload.SelectToken('$.transaction_beneficiary_details.identifier', transaction_beneficiary_details_identifier);
        Payload.SelectToken('$.transaction_beneficiary_details.account', transaction_beneficiary_details_account);
        Payload.SelectToken('$.transaction_beneficiary_details.name', transaction_beneficiary_details_name);
        Payload.SelectToken('$.transaction_beneficiary_details.reference', transaction_beneficiary_details_reference);
        Payload.SelectToken('$.transaction_beneficiary_details.other_details', transaction_beneficiary_details_other_details);

        Payload.Get('amount', amount);
        Payload.Get('transaction_description', transaction_description);
        Payload.Get('category', category);
        Payload.Get('source_reference', source_reference);
        Payload.Get('request_application', request_application);
        Payload.Get('source_application', source_application);
        Payload.Get('transaction_date_time', transaction_date_time);

        MpesaDepositTrans.Init;

        MpesaDepositTrans."API Request ID" := APIRequestID.AsValue.AsText;
        MpesaDepositTrans."Transaction ID" := GlobalFunctions.CleanGuid;

        MpesaDepositTrans."Originator ID" := originator_id.AsValue.AsText;
        MpesaDepositTrans."PESA Type" := pesa_type.AsValue.AsText;
        MpesaDepositTrans.Action := action.AsValue.AsText;
        MpesaDepositTrans.Command := command.AsValue.AsText;
        MpesaDepositTrans.Sensitivity := sensitivity.AsValue.AsText;
        MpesaDepositTrans.Charge := charge.AsValue.AsDecimal;
        MpesaDepositTrans."Identifier Type" := identifier_type.AsValue.AsText;
        MpesaDepositTrans.Identifier := identifier.AsValue.AsText;

        MpesaDepositTrans."Initiator Identifier Type" := transaction_initiator_details_identifier_type.AsValue.AsText;
        MpesaDepositTrans."Initiator Identifier" := transaction_initiator_details_identifier.AsValue.AsText;
        MpesaDepositTrans."Initiator Account" := transaction_initiator_details_account.AsValue.AsText;
        MpesaDepositTrans."Initiator Name" := transaction_initiator_details_name.AsValue.AsText;
        MpesaDepositTrans."Initiator Reference" := transaction_initiator_details_reference.AsValue.AsText;
        MpesaDepositTrans."Initiator Other Details" := transaction_initiator_details_other_details.AsValue.AsText;

        MpesaDepositTrans."Source Identifier Type" := transaction_source_details_identifier_type.AsValue.AsText;
        MpesaDepositTrans."Source Identifier" := transaction_source_details_identifier.AsValue.AsText;
        MpesaDepositTrans."Source Account" := transaction_source_details_account.AsValue.AsText;
        MpesaDepositTrans."Source Name" := transaction_source_details_name.AsValue.AsText;
        MpesaDepositTrans."Source Reference" := transaction_source_details_reference.AsValue.AsText;
        MpesaDepositTrans."Source Other Details" := transaction_source_details_other_details.AsValue.AsText;

        MpesaDepositTrans."Sender Identifier Type" := transaction_sender_details_identifier_type.AsValue.AsText;
        MpesaDepositTrans."Sender Identifier" := transaction_sender_details_identifier.AsValue.AsText;
        MpesaDepositTrans."Sender Account" := transaction_sender_details_account.AsValue.AsText;
        MpesaDepositTrans."Sender Name" := transaction_sender_details_name.AsValue.AsText;
        MpesaDepositTrans."Sender Reference" := transaction_sender_details_reference.AsValue.AsText;
        MpesaDepositTrans."Sender Other Details" := transaction_sender_details_other_details.AsValue.AsText;

        MpesaDepositTrans."Receiver Identifier Type" := transaction_receiver_details_identifier_type.AsValue.AsText;
        MpesaDepositTrans."Receiver Identifier" := transaction_receiver_details_identifier.AsValue.AsText;
        MpesaDepositTrans."Receiver Account" := transaction_receiver_details_account.AsValue.AsText;
        MpesaDepositTrans."Receiver Name" := transaction_receiver_details_name.AsValue.AsText;
        MpesaDepositTrans."Receiver Reference" := transaction_receiver_details_reference.AsValue.AsText;
        MpesaDepositTrans."Receiver Other Details" := transaction_receiver_details_other_details.AsValue.AsText;

        MpesaDepositTrans."Beneficiary Identifier Type" := transaction_beneficiary_details_identifier_type.AsValue.AsText;
        MpesaDepositTrans."Beneficiary Identifier" := transaction_beneficiary_details_identifier.AsValue.AsText;
        MpesaDepositTrans."Beneficiary Account" := transaction_beneficiary_details_account.AsValue.AsText;
        MpesaDepositTrans."Beneficiary Name" := transaction_beneficiary_details_name.AsValue.AsText;
        MpesaDepositTrans."Beneficiary Reference" := transaction_beneficiary_details_reference.AsValue.AsText;
        MpesaDepositTrans."Beneficiary Other Details" := transaction_beneficiary_details_other_details.AsValue.AsText;

        MpesaDepositTrans."Transaction Amount" := amount.AsValue.AsDecimal;
        MpesaDepositTrans."Transaction Description" := transaction_description.AsValue.AsText;
        MpesaDepositTrans."Transaction Category" := category.AsValue.AsText;
        MpesaDepositTrans."Transaction Source Reference" := source_reference.AsValue.AsText;
        MpesaDepositTrans."Request Application" := request_application.AsValue.AsText;
        MpesaDepositTrans."Source Application" := source_application.AsValue.AsText;

        Evaluate(MpesaDepositTrans."Transaction Date Time", transaction_date_time.AsValue.AsText);
        MpesaDepositTrans."Transaction Date" := DT2Date(MpesaDepositTrans."Transaction Date Time");
        MpesaDepositTrans."Transaction Time" := DT2Time(MpesaDepositTrans."Transaction Date Time");

        if IsLoanRepayment then begin
            // Loan Info
            BeneficiaryLoanAccount.Reset;
            BeneficiaryLoanAccount.SetRange("Loan No.", transaction_beneficiary_details_account.AsValue.AsText);

            BeneficiaryLoanAccount.SetLoadFields(
                "Loan No.",
                "Loan Account"
            );

            if BeneficiaryLoanAccount.FindFirst then begin
                MpesaDepositTrans."Loan No." := BeneficiaryLoanAccount."Loan No.";
                MpesaDepositTrans."Loan Account" := BeneficiaryLoanAccount."Loan Account";
            end;

            MpesaDepositTrans."Transaction Type" := MpesaDepositTrans."Transaction Type"::"Loan Repayment";
        end else begin
            MpesaDepositTrans."Savings Account" := MpesaDepositTrans."Beneficiary Account";
            MpesaDepositTrans."Transaction Type" := MpesaDepositTrans."Transaction Type"::"Mpesa Deposit";

            if MpesaDepositTrans."Transaction Category".ToUpper <> 'PIN_RESET' then begin
                // Other Deposits
                // Coop B2B
                if MpesaDepositTrans."Transaction Category" = 'COOP_DEPOSIT_B2B' then begin
                    MpesaDepositTrans."Transaction Type" := MpesaDepositTrans."Transaction Type"::"Coop B2B Deposit";
                end;

                // Coop P2F
                if MpesaDepositTrans."Transaction Category" = 'COOP_DEPOSIT_P2F' then begin
                    MpesaDepositTrans."Transaction Type" := MpesaDepositTrans."Transaction Type"::"Coop P2F Deposit";
                end;

                if MpesaDepositTrans."Transaction Type" = MpesaDepositTrans."Transaction Type"::"Mpesa Deposit" then begin
                    BeneficiarySavingsAccount.Reset;
                    BeneficiarySavingsAccount.SetRange("No.", MpesaDepositTrans."Savings Account");
                    BeneficiarySavingsAccount.SetLoadFields("No.");
                    if not BeneficiarySavingsAccount.FindFirst then begin
                        // Search using old account no
                        BeneficiarySavingsAccount.Reset;
                        BeneficiarySavingsAccount.SetRange("Old Account No", MpesaDepositTrans."Savings Account");
                        BeneficiarySavingsAccount.SetFilter(Status, '<>%1', BeneficiarySavingsAccount.Status::Closed);
                        BeneficiarySavingsAccount.SetRange(Blocked, BeneficiarySavingsAccount.Blocked::" ");
                        BeneficiarySavingsAccount.SetLoadFields("No.");
                        if BeneficiarySavingsAccount.FindFirst then begin
                            // Search using old account no
                            MpesaDepositTrans."Savings Account" := BeneficiarySavingsAccount."No.";
                        end else begin
                            // Check deposit keywords
                            MobileDepositkeywordSetup.Reset;
                            if MobileDepositkeywordSetup.FindSet() then begin
                                ExitKeywordSearch := '';

                                repeat begin
                                    SearchAccount := MpesaDepositTrans."Beneficiary Account".ToUpper();
                                    // E.g 12345ADV
                                    if MobileDepositkeywordSetup."Member Identifier Position" = MobileDepositkeywordSetup."Member Identifier Position"::Prefix then begin
                                        if SearchAccount.EndsWith(MobileDepositkeywordSetup.Keyword) then begin
                                            ExitKeywordSearch := MobileDepositkeywordSetup.Keyword;
                                        end;
                                    end;

                                    // E.g ADV12345
                                    if MobileDepositkeywordSetup."Member Identifier Position" = MobileDepositkeywordSetup."Member Identifier Position"::Suffix then begin
                                        if SearchAccount.StartsWith(MobileDepositkeywordSetup.Keyword) then begin
                                            ExitKeywordSearch := MobileDepositkeywordSetup.Keyword;
                                        end;
                                    end;
                                end until (ExitKeywordSearch <> '') or (MobileDepositkeywordSetup.Next() = 0);
                            end;

                            if ExitKeywordSearch <> '' then begin
                                MobileDepositkeywordSetup.Reset;
                                MobileDepositkeywordSetup.Get(ExitKeywordSearch);
                                //
                                TheBeneficiaryIdentifierNo := SearchAccount.Replace(MobileDepositkeywordSetup.Keyword, '').Trim();

                                TheBeneficiary.Reset;

                                if MobileDepositkeywordSetup."Member Identifier Type" = MobileDepositkeywordSetup."Member Identifier Type"::"Group Account No." then begin
                                    TheBeneficiary.FilterGroup := -1;
                                    TheBeneficiary.SetRange("No.", TheBeneficiaryIdentifierNo);
                                    TheBeneficiary.SetRange("Old Member No.", TheBeneficiaryIdentifierNo);
                                end else begin
                                    TheBeneficiary.SetRange("Primary Identification", TheBeneficiaryIdentifierNo);
                                    TheBeneficiary.SetRange("Primary Identification Type", MobileDepositkeywordSetup."Member Identifier Type");
                                end;

                                TheBeneficiary.SetLoadFields("No.");

                                if TheBeneficiary.FindFirst then begin
                                    if MobileDepositkeywordSetup."Product Class Type" = MobileDepositkeywordSetup."Product Class Type"::Loan then begin

                                        BeneficiaryLoans.Reset;
                                        BeneficiaryLoans.SetRange("Member No.", TheBeneficiary."No.");
                                        BeneficiaryLoans.SetRange("Loan Product Type", MobileDepositkeywordSetup."Product Code");
                                        BeneficiaryLoans.SetFilter("Total Loan Balance", '>0');
                                        BeneficiaryLoans.SetLoadFields("Loan No.", "Loan Account");

                                        if BeneficiaryLoans.FindFirst() then begin
                                            MpesaDepositTrans."Transaction Type" := MpesaDepositTrans."Transaction Type"::"Loan Repayment";
                                            MpesaDepositTrans."Loan No." := BeneficiaryLoans."Loan No.";
                                            MpesaDepositTrans."Loan Account" := BeneficiaryLoans."Loan Account";
                                            MpesaDepositTrans."Savings Account" := '';
                                        end;
                                    end;

                                    if MobileDepositkeywordSetup."Product Class Type" = MobileDepositkeywordSetup."Product Class Type"::Savings then begin
                                        MpesaDepositTrans."Transaction Type" := MpesaDepositTrans."Transaction Type"::"Mpesa Deposit";

                                        BeneficiarySavingsAccount.Reset;
                                        BeneficiarySavingsAccount.SetRange("Member No.", TheBeneficiary."No.");
                                        BeneficiarySavingsAccount.SetRange("Product Type", MobileDepositkeywordSetup."Product Code");
                                        BeneficiarySavingsAccount.SetFilter(Status, '<>%1', BeneficiarySavingsAccount.Status::Closed);
                                        BeneficiarySavingsAccount.SetRange(Blocked, BeneficiarySavingsAccount.Blocked::" ");
                                        BeneficiarySavingsAccount.SetLoadFields("No.");
                                        if BeneficiarySavingsAccount.FindFirst then begin
                                            MpesaDepositTrans."Savings Account" := BeneficiarySavingsAccount."No.";
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end else begin
                // Pin Reset
                MpesaDepositTrans."Savings Account" := '';
                MpesaDepositTrans."Transaction Type" := MpesaDepositTrans."Transaction Type"::"Self PIN Reset";
            end;
        end;

        MpesaDepositTrans."Transaction Status" := MpesaDepositTrans."Transaction Status"::CONFIRMED;
        MpesaDepositTrans.Posted := false;
    end;

    procedure LogLoanBalanceEnquiry(
        APIRequestID: Text;
        IdentifierType: Text;
        Identifier: Text;
        LoanNumber: Text;
        SourceApplication: Text;
        theMember: Record Members
    )
    var
        SkyTrans: Record "Sky M-Banking Trans. Buffer";
        GFunc: Codeunit "Global Functions";

        theLoan: Record Loans;
    begin
        // Log the transaction
        SkyTrans.Init;

        SkyTrans."API Request ID" := APIRequestID;
        SkyTrans."Originator ID" := APIRequestID;

        SkyTrans."Transaction ID" := GFunc.CleanGuid;

        SkyTrans."Identifier Type" := IdentifierType;
        SkyTrans."Identifier" := Identifier;

        SkyTrans."Savings Account" := GetMemberFosaAcc(theMember);

        theLoan.Reset;
        theLoan.SetRange("Loan No.", LoanNumber);
        theLoan.SetLoadFields("Loan No.", "Loan Account");

        if theLoan.FindFirst then begin
            SkyTrans."Loan No." := theLoan."Loan No.";
            SkyTrans."Loan Account" := theLoan."Loan Account";
        end;

        SkyTrans."Transaction Type" := "Sky M-Banking Trans Types"::"Loan Balance Enquiry";
        SkyTrans."Transaction Date Time" := CurrentDateTime;
        SkyTrans."Transaction Date" := Today;
        SkyTrans."Transaction Time" := Time;
        SkyTrans."Transaction Status" := SkyTrans."Transaction Status"::CONFIRMED;
        SkyTrans."Source Application" := SourceApplication;
        SkyTrans.Posted := false;
        // SkyTrans.Reversed := false;

        SkyTrans.Insert(true);
    end;

    procedure LogLoanMiniStatement(
        APIRequestID: Text;
        IdentifierType: Text;
        Identifier: Text;
        LoanNumber: Text;
        theMember: Record Members
    )
    var
        SkyTrans: Record "Sky M-Banking Trans. Buffer";
        GFunc: Codeunit "Global Functions";

        theLoan: Record Loans;
    begin
        // Log the transaction
        SkyTrans.Init;

        SkyTrans."API Request ID" := APIRequestID;
        SkyTrans."Originator ID" := APIRequestID;

        SkyTrans."Transaction ID" := GFunc.CleanGuid;

        SkyTrans."Identifier Type" := IdentifierType;
        SkyTrans."Identifier" := Identifier;

        SkyTrans."Savings Account" := GetMemberFosaAcc(theMember);

        theLoan.Reset;
        theLoan.SetRange("Loan No.", LoanNumber);

        if theLoan.FindFirst then begin
            SkyTrans."Loan No." := theLoan."Loan No.";
            SkyTrans."Loan Account" := theLoan."Loan Account";
        end;


        SkyTrans."Transaction Type" := "Sky M-Banking Trans Types"::"Loan Mini-Statement";
        SkyTrans."Transaction Date Time" := CurrentDateTime;
        SkyTrans."Transaction Date" := Today;
        SkyTrans."Transaction Time" := Time;
        SkyTrans."Transaction Status" := SkyTrans."Transaction Status"::CONFIRMED;
        SkyTrans.Posted := false;
        // SkyTrans.Reversed := false;

        SkyTrans.Insert(true);
    end;

    procedure LogLoanFullStatement(
        APIRequestID: Text;
        IdentifierType: Text;
        Identifier: Text;
        LoanNumber: Text;
        SourceApplication: Text;
        theMember: Record Members
    )
    var
        SkyTrans: Record "Sky M-Banking Trans. Buffer";
        GFunc: Codeunit "Global Functions";

        theLoan: Record Loans;
    begin
        // Log the transaction
        SkyTrans.Init;

        SkyTrans."API Request ID" := APIRequestID;
        SkyTrans."Originator ID" := APIRequestID;

        SkyTrans."Transaction ID" := GFunc.CleanGuid;

        SkyTrans."Identifier Type" := IdentifierType;
        SkyTrans."Identifier" := Identifier;

        SkyTrans."Savings Account" := GetMemberFosaAcc(theMember);

        theLoan.Reset;
        theLoan.SetRange("Loan No.", LoanNumber);

        theLoan.SetLoadFields("Loan No.", "Loan Account");

        if theLoan.FindFirst then begin
            SkyTrans."Loan No." := theLoan."Loan No.";
            SkyTrans."Loan Account" := theLoan."Loan Account";
        end;

        SkyTrans."Transaction Type" := "Sky M-Banking Trans Types"::"Loan Full-Statement";
        SkyTrans."Transaction Date Time" := CurrentDateTime;
        SkyTrans."Transaction Date" := Today;
        SkyTrans."Transaction Time" := Time;
        SkyTrans."Transaction Status" := SkyTrans."Transaction Status"::CONFIRMED;
        SkyTrans."Source Application" := SourceApplication;
        SkyTrans.Posted := false;
        // SkyTrans.Reversed := false;

        SkyTrans.Insert(true);
    end;

    // Get transactions Charges
    procedure GetMpesaTransCharges(var MobileTransLines: Record "Mobile Transaction Types Lines"; TransactionAmount: Decimal; AccountNo: Text; SourceApplication: Text): List of [decimal]
    var
        ChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        genSetUp: record "General Set-up";
        ExciseDuty: Decimal;
        TotalCharges: List of [decimal];
        SkyRevenue: Decimal;
        GFunc: Codeunit "Global Functions";
    begin
        ChargeAmount := 0;
        ExciseDuty := 0;
        clear(TotalCharges);

        if (MobileTransLines."Excempt From Charges" and GFunc.IsStaffAccount(AccountNo)) or (SourceApplication = 'MAPP') then begin
            TotalCharges.Add(0);
            TotalCharges.Add(0);
            TotalCharges.Add(0);
            totalCharges.Add(0);
            exit(TotalCharges);
        end;

        case MobileTransLines."Charge Type" of
            MobileTransLines."Charge Type"::"Flat Amount":
                ChargeAmount := Round(MobileTransLines."Charge Amount", 0.01, '>');

            MobileTransLines."Charge Type"::"% of Amount":
                ChargeAmount := Round((MobileTransLines."Percentage of Amount" / 100) * (TransactionAmount), 0.01, '>');
            MobileTransLines."Charge Type"::Staggered:
                begin
                    MobileTransLines.TestField(MobileTransLines."Staggered Charge Code");
                    TariffDetails.Reset;
                    TariffDetails.SetRange(Code, MobileTransLines."Staggered Charge Code");
                    if TariffDetails.FindSet then begin
                        repeat
                            if (TransactionAmount >= TariffDetails."Lower Limit") and (TransactionAmount <= TariffDetails."Upper Limit") then begin
                                if TariffDetails."Use Percentage" = true then begin
                                    ChargeAmount := Round((TransactionAmount * TariffDetails.Percentage * 0.01), 0.01, '>');
                                end else begin
                                    ChargeAmount := Round(TariffDetails."Charge Amount", 0.01, '>');
                                end;
                            end;
                        until TariffDetails.Next = 0;
                    end;
                end;
        end;
        // Check for min and max charge amounts
        if ChargeAmount < MobileTransLines."Minimum Amount" then
            ChargeAmount := MobileTransLines."Minimum Amount";

        IF MobileTransLines."Maximum Amount" > 0 THEN begin
            if ChargeAmount > MobileTransLines."Maximum Amount" then
                ChargeAmount := MobileTransLines."Maximum Amount";
        end;

        if MobileTransLines."Sky Revenue Share" then begin
            SkyRevenue := round((ChargeAmount * MobileTransLines."Sky Revenue Share %" * 0.01), 0.01, '>');
        end;
        if MobileTransLines."Recover Excise Duty" then begin
            genSetUp.Get();
            if MobileTransLines.useFinancialChargesExciseDuty then begin
                if genSetUp."Excise Duty (%)" > 0 then begin
                    ExciseDuty := round(ChargeAmount * genSetUp."Excise Duty (%)" * 0.01);
                end;
            end else begin
                if genSetUp."Transfer Excise Duty (%)" > 0 then begin
                    ExciseDuty := round(ChargeAmount * genSetUp."Transfer Excise Duty (%)" * 0.01);
                end;
            end;

            // ExciseDuty := round(((ChargeAmount - SkyRevenue) * genSetUp."Excise Duty (%)" * 0.01) / (1 + (genSetUp."Excise Duty (%)" * 0.01)), 0.01, '>');

        end;
        TotalCharges.Add(ChargeAmount + ExciseDuty + SkyRevenue);
        TotalCharges.Add(ExciseDuty);
        TotalCharges.Add(SkyRevenue);
        totalCharges.Add(ChargeAmount);

        exit(TotalCharges);
    end;
    // Process Loan deposits
    procedure ProcessLoanRepayment(var MpesaTransactionBuffer: Record "Sky M-Banking Trans. Buffer"): Boolean
    var
        Loans: record Loans;
        ProductFactory: record "Product Factory";
        CreditAccounts: record "Credit Accounts";
    begin
        // Get loan account
        if (MpesaTransactionBuffer."Loan Account" = '') or not (CreditAccounts.get(MpesaTransactionBuffer."Loan Account")) then begin
            MpesaTransactionBuffer."Try Posting Count" := MpesaTransactionBuffer."Try Posting Count" + 1;
            MpesaTransactionBuffer."Needs Change" := true;
            MpesaTransactionBuffer."Needs Change Reason" := 'Loan account not found';
            MpesaTransactionBuffer.Modify(true);
            exit(false);
        end;
        // get the loan
        Loans.Reset;
        Loans.SetRange("Loan No.", MpesaTransactionBuffer."Loan No.");
        // Loans.SetLoadFields("Daily Interest", "Loan Product Type");
        // Loans.SetAutoCalcFields("Daily Interest");
        if Loans.FindFirst then begin
            // Post Loan Interests
            // Loans.CALCFIELDS("Daily Interest");
            //if Loans."Daily Interest" > 0 then begin
            if (not productFactory.GET(Loans."Loan Product Type")) then begin
                MpesaTransactionBuffer."Try Posting Count" := MpesaTransactionBuffer."Try Posting Count" + 1;
                MpesaTransactionBuffer."Needs Change" := true;
                MpesaTransactionBuffer."Needs Change Reason" := 'Loan product not found / loan interest account not set';
                MpesaTransactionBuffer.Modify(true);
                exit(false);
            end;

            //end;
            exit(true);
        end else begin
            MpesaTransactionBuffer."Try Posting Count" := MpesaTransactionBuffer."Try Posting Count" + 1;
            MpesaTransactionBuffer."Needs Change" := true;
            MpesaTransactionBuffer."Needs Change Reason" := 'Loan not found';
            MpesaTransactionBuffer.Modify(true);
            exit(false);
        end;
    end;
    // Get Member primary fosa acc
    procedure GetMemberFosaAcc(Member: record Members): text
    var
        SavingsAccounts: record "Savings Accounts";
    begin

        SavingsAccounts.RESET;
        SavingsAccounts.SETRANGE("Member No.", Member."No.");
        SavingsAccounts.SetRange("Loan Disbursement Account", true);
        SavingsAccounts.SetLoadFields("No.");
        if SavingsAccounts.FINDFIRST then begin
            exit(SavingsAccounts."No.")
        end else begin
            SavingsAccounts.RESET;
            savingsAccounts.SETRANGE("Member No.", Member."No.");
            SavingsAccounts.SetFilter("Product Type", '%1|%2', '191', '195');
            savingsAccounts.SetCurrentKey(blocked, Status, "Product Type");
            if SavingsAccounts.FINDFIRST then
                exit(SavingsAccounts."No.");
        end;

    end;
    // Get Member primary bosa acc
    procedure GetMemberDepositsAcc(Member: record Members): text
    var
        SavingsAccounts: record "Savings Accounts";
        FosaProduct: Record "Product Factory";
    begin
        FosaProduct.Reset;
        FosaProduct.SetRange("Product Category", FosaProduct."Product Category"::"BOSA Deposits");
        FosaProduct.SetRange("Auto Open Account", true); // Main Bosa Acc.

        FosaProduct.SetLoadFields("Product ID");
        if not FosaProduct.FindFirst then begin
            exit('');
        end;

        SavingsAccounts.RESET;
        SavingsAccounts.SETRANGE("Member No.", Member."No.");
        SavingsAccounts.SETRANGE("Product Type", FosaProduct."Product ID");

        SavingsAccounts.SetLoadFields("No.");
        if SavingsAccounts.FINDFIRST then
            exit(SavingsAccounts."No.")
        else
            exit('');
    end;

    // Get Member shares acc
    procedure GetMemberSharesAcc(Member: record Members): text
    var
        SavingsAccounts: record "Savings Accounts";
        FosaProduct: Record "Product Factory";
    begin
        FosaProduct.Reset;
        FosaProduct.SetRange("Product Category", FosaProduct."Product Category"::"Share Capital");
        FosaProduct.SetRange("Auto Open Account", true); // Main Acc.

        FosaProduct.SetLoadFields("Product ID");
        if not FosaProduct.FindFirst then begin
            exit('');
        end;

        SavingsAccounts.RESET;
        SavingsAccounts.SETRANGE("Member No.", Member."No.");
        SavingsAccounts.SETRANGE("Product Type", FosaProduct."Product ID");

        SavingsAccounts.SetLoadFields("No.");
        if SavingsAccounts.FINDFIRST then
            exit(SavingsAccounts."No.")
        else
            exit('');
    end;

    // Get Member Registration Fee Account
    procedure GetMemberRegFeeAcc(Member: record Members): text
    var
        SavingsAccounts: record "Savings Accounts";
        FosaProduct: Record "Product Factory";
    begin
        FosaProduct.Reset;
        FosaProduct.SetRange("Product Category", FosaProduct."Product Category"::"Entrance Fee");
        FosaProduct.SetRange("Auto Open Account", true); // Main Acc.

        FosaProduct.SetLoadFields("Product ID");
        if not FosaProduct.FindFirst then begin
            exit('');
        end;

        SavingsAccounts.RESET;
        SavingsAccounts.SETRANGE("Member No.", Member."No.");
        SavingsAccounts.SETRANGE("Product Type", FosaProduct."Product ID");

        SavingsAccounts.SetLoadFields("No.");
        if SavingsAccounts.FINDFIRST then
            exit(SavingsAccounts."No.")
        else
            exit('');
    end;

    // Get Member primary biashara acc
    procedure GetMemberBiasharaAcc(Member: record Members): text
    var
        SavingsAccounts: record "Savings Accounts";
        FosaProduct: Record "Product Factory";
    begin
        FosaProduct.Reset;
        // FosaProduct.SetRange("Product Category", FosaProduct."Product Category"::"Biashara Account");
        FosaProduct.SetRange("Product ID", '011');
        // FosaProduct.SetRange("Auto Open Account", true);

        FosaProduct.SetLoadFields("Product ID");
        if not FosaProduct.FindFirst then begin
            exit('');
        end;

        SavingsAccounts.RESET;
        SavingsAccounts.SETRANGE("Member No.", Member."No.");
        SavingsAccounts.SETRANGE("Product Type", FosaProduct."Product ID");

        SavingsAccounts.SetLoadFields("No.");
        if SavingsAccounts.FINDFIRST then
            exit(SavingsAccounts."No.")
        else
            exit('');
    end;
    //

    // Get Member business loans deposit acc
    procedure GetMemberBusinessDepositsAcc(Member: record Members): text
    var
        SavingsAccounts: record "Savings Accounts";
        FosaProduct: Record "Product Factory";
    begin
        FosaProduct.Reset;
        FosaProduct.SetRange("Product Category", FosaProduct."Product Category"::"Business Deposits");
        // FosaProduct.SetRange("Auto Open Account", true); // Main Bosa Acc.

        FosaProduct.SetLoadFields("Product ID");
        if not FosaProduct.FindFirst then begin
            exit('');
        end;

        SavingsAccounts.RESET;
        SavingsAccounts.SETRANGE("Member No.", Member."No.");
        SavingsAccounts.SETRANGE("Product Type", FosaProduct."Product ID");

        SavingsAccounts.SetLoadFields("No.");
        if SavingsAccounts.FINDFIRST then
            exit(SavingsAccounts."No.")
        else
            exit('');
    end;

    //Post daily interests
    procedure PostDailyInterests(var LoanRec: record Loans): Text
    var
        ProductFac: record "Product Factory";
        LineNo: Integer;
        BankingUserSetUp: Record "Banking User Template";
        AccType: enum "Gen. Journal Account Type";
        LoanProcess: Codeunit "Loans Process";
        JournalPosting: Codeunit "Journal Posting";
        JTemplate: Code[20];
        JBatch: Code[20];
        Dim1: Code[50];
        Dim2: Code[50];
        TransType: enum "Transaction Types";
        UserSetUp: record "User Setup";
        genjnline: Record "Gen. Journal Line";
    begin
        BankingUserSetUp.get(UserId);
        JBatch := BankingUserSetUp."Bills Batch";
        JTemplate := BankingUserSetUp."Bills Template";
        Dim1 := UserSetUp."Global Dimension 1 Code";
        Dim2 := UserSetUp."Global Dimension 2 Code";
        LineNo := 0;

        genjnline.SetRange("Journal Template Name", JTemplate);
        genjnline.SetRange("Journal Batch Name", JBatch);
        if genjnline.FindLast() then
            LineNo := genjnline."Line No." + 1000;

        if ProductFac.get(LoanRec."Loan Product Type") then begin
            if ProductFac."Loan Interest Account [G/L]" <> '' then begin
                LoanRec.calcfields("Daily Interest");
                if LoanRec."Daily Interest" > 0 then begin
                    JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AccType::Credit, LoanRec."Loan No.", 'Daily Interest Capitalized_' + LoanRec."Loan No.", LoanRec."Daily Interest", LoanRec."Loan Account", Today, AccType::Credit,
                               ProductFac."Loan Interest Account [G/L]", LoanRec."Loan No.", Dim1, Dim2, TransType::"Interest Due", LoanRec."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                    LoanProcess.ClearDailyInterest(LoanRec."Loan No.");
                end;
            end;
        end;
    end;

    // Mobile loan limit
    procedure GetLoansQualifyAmount(MemberNo: Code[20]; ProductID: Code[10]; Installments: Integer; var EligibilityFailReason: Text) QualifiedAmount: Decimal
    var
        Members: Record Members;
        PFac: Record "Product Factory";
        ProdFac: Record "Product Factory";
        amtQualified: Decimal;
        saccoAccount: Record "Savings Accounts";
        STOAmount: Decimal;
        SalAvg: Decimal;
        LoanRec: Decimal;
        SalaryAmount: Decimal;
        GenSetUp: Record "General Set-Up";
        RelatedProduct: Record "Loan Products to Bridge";
        LoanApp: Record Loans;
        OrdinaryAccounts: Record "Savings Accounts";
        SalaryLines: Record "Salary Lines";
        SalaryHeader: Record "Salary Header";
        Loans: Record Loans;
        Incomsal: Enum "Salary Income Types";
        Globalfunc: Codeunit "Global Functions";
        MobileLoanBuffer: record "Mobile loan App. Buffer";
        TotalExisting: decimal;

        MinDateProduct: Date;
        MinDateMember: Date;

        TotArrears: Decimal;
        LoanArr: record loans;
        msg: text;
        SendSMS: Codeunit SendSms;
        Netamt: decimal;

        LoanAvailability: Record "Loan Product Availability";
        CurrentMonthInt: Integer;
        CurrentMonthEnum: Enum "Loan Month";
        AllowedMonths: Text;
        DepositCap: Decimal;
        ExistingLoanBalance: Decimal;

    begin
        TotalExisting := 0;
        DepositCap := 0;
        Message('Deposit Cap: %1', DepositCap);
        if not GenSetUp.GET then begin
            EligibilityFailReason := 'General Setup NOT complete';
            QualifiedAmount := 0;
            EXIT(QualifiedAmount);
        end;
        if not ProdFac.GET(ProductID) then begin
            EligibilityFailReason := 'Loan Product NOT found';
            QualifiedAmount := 0;
            EXIT(QualifiedAmount);
        end;

        // Check mobile loan buffer for unposted loans application
        MobileLoanBuffer.Reset;
        MobileLoanBuffer.SetRange("Member No.", MemberNo);
        MobileLoanBuffer.SetRange(Posted, false);
        MobileLoanBuffer.SetLoadFields("Entry No");

        if MobileLoanBuffer.FindFirst then begin
            EligibilityFailReason := 'There is an ongoing mobile loan application being processed';
            Message('There is an ongoing mobile loan application being processed');
            QualifiedAmount := 0;
            EXIT(QualifiedAmount);
        end;

        // Check unposted loans with outstanding balance
        LoanApp.RESET;
        LoanApp.SETRANGE("Member No.", MemberNo);
        LoanApp.SETRANGE(Posted, false);
        LoanApp.SETRANGE("Loan Product Type", ProductID);
        LoanApp.SETFILTER("Outstanding Balance", '>0');
        LoanApp.SetLoadFields("Loan No.", Posted);

        if LoanApp.FindFirst then begin
            LoanApp.Posted := true;
            LoanApp.Modify;

            EligibilityFailReason := 'There is ongoing mobile loan application being processed';
            Message('There is ongoing mobile loan application being processed');
            QualifiedAmount := 0;
            EXIT(QualifiedAmount);
        end;
        Message('No ongoing mobile loan applications found');

        amtQualified := 0;
        STOAmount := 0;
        SalAvg := 0;
        LoanRec := 0;
        SalaryAmount := 0;

        Members.Reset;
        Members.SetRange("No.", MemberNo);

        Members.SetLoadFields(
            "No.", Status, Subflag, "Date of Birth", "Allow Retiree M-Loans"
        );

        if Members.Find('-') then begin
            Message('Member Found: %1', Members."No.");
            IF Members.Status <> Members.Status::Active THEN BEGIN
                EligibilityFailReason := StrSubstNo('Applicant NOT Active. Status is %1', Members.Status);
                Message('Applicant NOT Active. Status is %1', Members.Status);
                QualifiedAmount := 0;
                EXIT(QualifiedAmount);
            END else begin
                // Active Status - Check Subflags
                Message('Member Subflag: %1', Members.Subflag);
                if not (
                    (Members.Subflag = Members.Subflag::"First time") or
                    (Members.Subflag = Members.Subflag::Rejoined) or
                    (Members.Subflag = Members.Subflag::"Partial withdrawn")
                ) then begin
                    EligibilityFailReason := StrSubstNo('You are not eligible because your Sub-Status is %1', Members.Subflag);
                    Message('Applicant NOT eligible. Sub-Status is %1', Members.Subflag);
                    QualifiedAmount := 0;
                    EXIT(QualifiedAmount);
                end;
            end;

            if Format(ProdFac."Minimum Application Period") <> '' then begin
                if CalcDate(ProdFac."Minimum Application Period", Members."Registration Date") > Today then begin
                    EligibilityFailReason := StrSubstNo(
                        'You are not eligible. Minimum membership period required is %1',
                        Format(ProdFac."Minimum Application Period")
                    );
                    QualifiedAmount := 0;
                    EXIT(QualifiedAmount);
                end;
            end;

            // Validate Age Requirements
            if Format(ProdFac."Max. Member Age") <> '' then begin
                MinDateMember := CalcDate('-' + Format(ProdFac."Ordinary Default Intallments") + 'M', Members."Date of Birth");
                MinDateProduct := CalcDate('-' + Format(ProdFac."Max. Member Age"), Today);
                if MinDateMember < MinDateProduct then begin
                    if not Members."Allow Retiree M-Loans" then begin
                        EligibilityFailReason := StrSubstNo('Applicant NOT eligible due to age requirements. Maximum applicant age allowed is: %1', Format(ProdFac."Max. Member Age"));
                        Message('Applicant NOT eligible due to age requirements. Maximum applicant age allowed is: %1', Format(ProdFac."Max. Member Age"));
                        QualifiedAmount := 0;
                        EXIT(QualifiedAmount);
                    end;
                end;
            end;

            // Get and check Member deposit balance
            if ProdFac."Type of Discounting" <> ProdFac."Type of Discounting"::"Dividend Discounting" then begin
                OrdinaryAccounts.RESET;
                OrdinaryAccounts.SETRANGE("Member No.", Members."No.");
                OrdinaryAccounts.SETRANGE("Product Category", OrdinaryAccounts."Product Category"::"BOSA Deposits");
                OrdinaryAccounts.SetLoadFields(Balance);
                if OrdinaryAccounts.FINDFIRST() then begin
                    OrdinaryAccounts.CALCFIELDS(Balance);
                    Message('Ordinary Accounts Balance: %1', Format(OrdinaryAccounts.Balance));

                    if OrdinaryAccounts.Balance = 0 then begin
                        EligibilityFailReason := 'You are not eligible because you have no deposit balance.';
                        QualifiedAmount := 0;
                        EXIT(QualifiedAmount);
                    end;

                    if OrdinaryAccounts.Balance < ProdFac."Minimum Deposit Balance" then begin
                        EligibilityFailReason := StrSubstNo(
                            'You are not eligible. Minimum deposit required is KES %1.',
                            Format(ProdFac."Minimum Deposit Balance")
                        );
                        QualifiedAmount := 0;
                        EXIT(QualifiedAmount);
                    end;
                end;
            end;
            // Find FOSA transactional account
            saccoAccount.RESET;
            saccoAccount.SETRANGE(saccoAccount."Member No.", Members."No.");
            saccoAccount.SetRange("Product Category", saccoAccount."Product Category"::"FOSA Account");
            saccoAccount.SetCurrentKey(Blocked);
            saccoAccount.setrange("Loan Disbursement Account", true);
            // saccoAccount.SetRange("Product Type", '191');
            Message('Searching for FOSA transactional account for Member: %1', Members."No.");

            saccoAccount.SetLoadFields(
                "No.", "Member No.", Status, Blocked
            );

            IF saccoAccount.FIND('-') THEN BEGIN

                STOAmount := ComputeSTODeductions(saccoAccount."No.");
                Message('STO Amount: %1', Format(STOAmount));

                if ProdFac."Salary Income Types" = ProdFac."Salary Income Types"::Pension then begin
                    SalAvg := Globalfunc.GetSmallestSalary(saccoAccount."No.", Incomsal::Pension);
                    Message('Pension Average: %1', Format(SalAvg));
                end else begin
                    SalAvg := Globalfunc.GetSmallestSalary(saccoAccount."No.", Incomsal::Salary);
                    Message('Salary Average: %1', Format(SalAvg));
                end;

                Message('Least Salary Rate %: %1', Format(ProdFac."Least Sal Rate %"));
                if ProdFac."Least Sal Rate %" <> 0 then begin
                    SalAvg := (ProdFac."Least Sal Rate %" / 100) * SalAvg;
                    message('Salary Average after applying least salary rate: %1', Format(SalAvg));
                end;

                LoanRec := ComputeLoanDeductions(saccoAccount."Member No.");
                Message('Loan Deductions: %1', Format(LoanRec));

                IF (saccoAccount.Status <> saccoAccount.Status::Active) OR (saccoAccount.Blocked <> saccoAccount.Blocked::" ") THEN BEGIN
                    EligibilityFailReason := StrSubstNo('Applicant NOT eligible. Transaction account status is %.', Format(saccoAccount.Status));
                    if saccoAccount.Blocked <> saccoAccount.Blocked::" " then begin
                        EligibilityFailReason := StrSubstNo('You are not eligible. Transaction account is blocked');
                    end;
                    QualifiedAmount := 0;
                    EXIT(QualifiedAmount);
                END;

                //confirm if loan exist of same type
                if ProdFac."Type of Discounting" <> ProdFac."Type of Discounting"::"Dividend Discounting" then begin
                    Message('Type of Discounting: %1', Format(ProdFac."Type of Discounting"));

                    RelatedProduct.RESET;
                    RelatedProduct.SETRANGE("Product Code", ProductID);
                    RelatedProduct.SetLoadFields("Product To Bridge");

                    IF RelatedProduct.FINDSET THEN BEGIN
                        REPEAT
                            LoanApp.RESET;
                            LoanApp.SETRANGE("Member No.", saccoAccount."Member No.");
                            LoanApp.SETRANGE(Posted, TRUE);
                            LoanApp.SETRANGE("Loan Product Type", RelatedProduct."Product To Bridge");
                            LoanApp.SETFILTER("Outstanding Balance", '>0');
                            LoanApp.SetLoadFields("Loan No.");
                            IF LoanApp.FINDSET THEN BEGIN
                                REPEAT
                                    Message('Allow Multiple Running Loans: %1', Format(ProdFac."Allow Multiple Running Loans"));
                                    IF ProdFac."Allow Multiple Running Loans" = FALSE THEN BEGIN
                                        EligibilityFailReason := StrSubstNo('You are not eligible due to having related loan product');
                                        Message('Applicant NOT eligible due to having related loan product');
                                        QualifiedAmount := 0;
                                        EXIT(QualifiedAmount);
                                    END;
                                UNTIL LoanApp.NEXT = 0;
                            END;
                        UNTIL RelatedProduct.NEXT = 0;
                    END;
                end else begin
                    // Azima Mazao Loan
                    Message('Is Available in Month: %1', ProdFac."IsAvailableInMonth");

                    if ProdFac."IsAvailableInMonth" then begin
                        CurrentMonthInt := Date2DMY(Today(), 2);
                        Evaluate(CurrentMonthEnum, Format(CurrentMonthInt));

                        LoanAvailability.SetRange("Loan Product Code", ProductID);
                        LoanAvailability.SetRange(Accessible, true);

                        if LoanAvailability.FindSet() then begin
                            repeat
                                if AllowedMonths <> '' then
                                    AllowedMonths += ', ';
                                AllowedMonths += Format(LoanAvailability.Month);
                            until LoanAvailability.Next() = 0;
                        end;

                        LoanAvailability.Reset();
                        LoanAvailability.SetRange("Loan Product Code", ProductID);
                        LoanAvailability.SetRange(Month, CurrentMonthEnum);
                        LoanAvailability.SetRange(Accessible, true);

                        if not LoanAvailability.FindFirst() then begin
                            EligibilityFailReason :=
                              StrSubstNo(
                                '%1 is only available in: %2',
                                ProdFac."Product Description",
                                AllowedMonths
                              );
                            Message('%1 is only available in: %2',
                              ProdFac."Product Description",
                              AllowedMonths
                              );
                            QualifiedAmount := 0;
                            exit(QualifiedAmount);
                        end;
                    end;
                    // Azima Mazao Loan

                    // LoanApp.RESET;
                    // LoanApp.SETRANGE(LoanApp."Member No.", MemberNo);
                    // // Exclude guarantor loans as they will always be loss- According to FINANCE-kenneth
                    // LoanApp.Setfilter("Loan Product Type", '<>%1&<>%2', 'BGL', 'FGL');
                    // LoanApp.SetFilter("Loans Category-SASRA", '%1|%2|%3', LoanApp."Loans Category-SASRA"::Substandard, LoanApp."Loans Category-SASRA"::Doubtful, LoanApp."Loans Category-SASRA"::Loss);
                    // LoanApp.SETFILTER(LoanApp."Outstanding Balance", '>0');
                    // LoanApp.SetLoadFields("Loan No.");
                    // IF LoanApp.FIND('-') THEN BEGIN
                    //     EligibilityFailReason := StrSubstNo('Applicant NOT eligible due to non-performant loans');
                    //     exit(QualifiedAmount);
                    // END;

                    QualifiedAmount := DividenceAdvanceQualification(MemberNo, ProductID);
                    Message('Qualified Amount: %1', Format(QualifiedAmount));

                    // Check arrears amt existing
                    // The arrears not to restrict qualification but recover all arrears.
                    // if QualifiedAmount > 0 then begin
                    //     TotArrears := 0;
                    //     Netamt := 0;
                    //     LoanArr.Reset();
                    //     LoanArr.setRange("Member No.", Members."No.");
                    //     LoanArr.SetFilter("Loan Product Type", '<>FGL&<>BGL'); // Todo 
                    //     Message('Loan product type filter: %1', Format(LoanArr.GetFilter("Loan Product Type")));
                    //     LoanArr.CalcFields("Total Balance", "Amount In Arreas SASRA", "Loans Category-SASRA");
                    //     //LoanArr.SetFilter("Loans Category-SASRA", '<>%1', loans."Loans Category-SASRA"::Perfoming);
                    //     LoanArr.SetFilter("Total Balance", '>0');
                    //     //LoanArr.setfilter("Amount In Arreas SASRA", '>500');
                    //     if LoanArr.findset() then begin
                    //         repeat
                    //             LoanArr.CalcFields("Amount In Arreas SASRA");
                    //             TotArrears += LoanArr."Amount In Arreas SASRA";
                    //         until LoanArr.next() = 0;
                    //     end;
                    //     if TotArrears > 0 then begin
                    //         Netamt := QualifiedAmount - TotArrears;
                    //         if Netamt < 0 then Netamt := 0;
                    //         msg := 'Dear ' + Members."First Name" + ', your loan qualification amount is KES.' + Format(QualifiedAmount) + ' and your total loan arrears is. ' + format(round(TotArrears, 1, '>')) +
                    //         '. The net amount to be disbursed is ' + Format(round(QualifiedAmount - TotArrears));
                    //         SendSMS.SendSms(SMSSource::MBANKING, Members."Phone No.", msg, Format(Members."No."), '', true, 220, false, 'CBS', Members."No.", 'CBS');
                    //     end;
                    // end;

                    if QualifiedAmount > ProdFac."Maximum Loan Amount" then
                        QualifiedAmount := ProdFac."Maximum Loan Amount";

                    if QualifiedAmount < ProdFac."Minimum Loan Amount" then begin
                        EligibilityFailReason := StrSubstNo(
                            'You are not eligible. Qualified amount KES %1 is below the minimum of KES %2',
                            Format(Round(QualifiedAmount, 1)),
                            Format(ProdFac."Minimum Loan Amount")
                        );
                        QualifiedAmount := 0;
                    end else
                        EligibilityFailReason := '';

                    exit(QualifiedAmount);
                    Message('Qualified Amount: %1', Format(QualifiedAmount));
                end;

                //Exisiting loans
                Message('Type of Discounting: %1', Format(ProdFac."Type of Discounting"));
                if ProdFac."Type of Discounting" <> ProdFac."Type of Discounting"::"Dividend Discounting" then begin

                    if not ProdFac."Allow Multiple Running Loans" then begin
                        Loans.RESET;
                        Loans.SETRANGE(Loans."Member No.", saccoAccount."Member No.");
                        Loans.SETRANGE(Loans."Loan Product Type", ProductID);
                        Loans.SETRANGE(Loans.Posted, TRUE);
                        Loans.SETFILTER("Outstanding Balance", '>0');
                        Loans.SetLoadFields("Loan No.");
                        IF Loans.FIND('-') THEN BEGIN
                            EligibilityFailReason := StrSubstNo('You are not eligible due to existing %1 loan', ProdFac."Product Description");
                            QualifiedAmount := 0;
                            EXIT(QualifiedAmount);
                        END;
                    end;

                    // Biashara Loan Qualification
                    Message('Use Contribution Qualification: %1', Format(ProdFac."Use Contribution Qualification"));
                    if ProdFac."Use Contribution Qualification" then begin
                        QualifiedAmount := GetBiasharaQualifiedAmount(
                            MemberNo,
                            ProductID,
                            saccoAccount."No.",
                            EligibilityFailReason
                        );
                        exit(QualifiedAmount);
                    end;

                    // if ProdFac."Product ID" = '062' then begin
                    //     QualifiedAmount := GetEmergencyLoanQualifiedAmount(
                    //         MemberNo,
                    //         ProductID,
                    //         saccoAccount."No.",
                    //         EligibilityFailReason
                    //     );
                    //     exit(QualifiedAmount);
                    // end;

                    Message('Requires Salary Processing: %1', Format(ProdFac."Requires Salary Processing"));
                    if ProdFac."Requires Salary Processing" = false then begin
                        EligibilityFailReason := '';
                        QualifiedAmount := ProdFac."Maximum Loan Amount";
                        Message('Qualified Amount: %1', Format(QualifiedAmount));

                        Message('Deposit Qualifier %: %1', Format(ProdFac."Deposit Qualifier %"));

                        if ProdFac."Deposit Qualifier %" > 0 then begin
                            OrdinaryAccounts.Reset();
                            OrdinaryAccounts.SetRange("Member No.", Members."No.");
                            OrdinaryAccounts.SetRange("Product Category", OrdinaryAccounts."Product Category"::"BOSA Deposits");
                            OrdinaryAccounts.SetLoadFields(Balance);
                            if OrdinaryAccounts.FindFirst() then begin
                                OrdinaryAccounts.CalcFields(Balance);
                                DepositCap := Round(OrdinaryAccounts.Balance * (ProdFac."Deposit Qualifier %" / 100), 1);
                                if DepositCap > ProdFac."Maximum Loan Amount" then
                                    DepositCap := ProdFac."Maximum Loan Amount";
                                if DepositCap < QualifiedAmount then
                                    QualifiedAmount := DepositCap;
                            end;
                        end;

                        exit(QualifiedAmount);
                    end;

                    if SalAvg <= 0 then begin
                        EligibilityFailReason := StrSubstNo('You are not eligible due to salary requirements');
                        Message('SalAvg <= 0. Applicant NOT eligible due to salary requirements');
                        QualifiedAmount := 0;
                        EXIT(QualifiedAmount);
                    end;

                    // Weekend Njema Loan
                    Message('Appraisal - Omit Deductions: %1', Format(ProdFac."Appraisal - Omit Deductions"));
                    if ProdFac."Appraisal - Omit Deductions" then begin
                        STOAmount := 0;
                        LoanRec := 0;

                        if ProdFac."Allow Multiple Running Loans" then begin
                            Loans.RESET;
                            Loans.SETRANGE(Loans."Member No.", saccoAccount."Member No.");
                            Loans.SETRANGE(Loans."Loan Product Type", ProductID);
                            Loans.SETRANGE(Loans.Posted, TRUE);
                            Loans.SETFILTER("Outstanding Balance", '>0');
                            Loans.SetLoadFields("Loan No.", "Outstanding Balance", "Total Loan Balance");
                            Loans.SetAutoCalcFields("Outstanding Balance", "Total Loan Balance");
                            IF Loans.FINDSET THEN BEGIN
                                repeat begin
                                    LoanRec += Loans."Total Loan Balance";
                                end until Loans.Next = 0;
                            END;
                        end;

                        if LoanRec > ProdFac."Maximum Loan Amount" then begin
                            EligibilityFailReason := StrSubstNo('You are not eligible due to existing %1 loan(s)', ProdFac."Product Description");
                            QualifiedAmount := 0;
                            EXIT(QualifiedAmount);
                        end;

                        SalAvg := ProdFac."Maximum Loan Amount";
                    end;

                    SalAvg := SalAvg - (STOAmount + LoanRec);
                    Message('Salary Average after deductions: %1', Format(SalAvg));

                    amtQualified := SalAvg * (ProdFac."Net Salary Multiplier %" / 100);
                    message('Qualified Amount before deposit cap: %1', Format(amtQualified));

                    IF amtQualified < 0 THEN
                        amtQualified := 0;

                    if QualifiedAmount > ProdFac."Maximum Loan Amount" then begin
                        QualifiedAmount := ProdFac."Maximum Loan Amount";
                        Message('Qualified Amount after applying maximum loan amount: %1', Format(QualifiedAmount));
                    end;

                    if ProdFac."Deposit Qualifier %" > 0 then begin
                        OrdinaryAccounts.Reset();
                        OrdinaryAccounts.SetRange("Member No.", Members."No.");
                        OrdinaryAccounts.SetRange("Product Category", OrdinaryAccounts."Product Category"::"BOSA Deposits");
                        OrdinaryAccounts.SetLoadFields(Balance);
                        if OrdinaryAccounts.FindFirst() then begin
                            OrdinaryAccounts.CalcFields(Balance);
                            DepositCap := Round(OrdinaryAccounts.Balance * (ProdFac."Deposit Qualifier %" / 100), 1);
                            Message('Deposit Cap based on deposit qualifier %: %1', Format(DepositCap));
                            if DepositCap > ProdFac."Maximum Loan Amount" then
                                DepositCap := ProdFac."Maximum Loan Amount";
                            Message('Deposit Cap after applying maximum loan amount: %1', Format(DepositCap));
                            if DepositCap < amtQualified then
                                amtQualified := DepositCap;
                            Message('Qualified Amount after applying deposit cap: %1', Format(amtQualified));
                        end;
                    end;

                    if amtQualified > ProdFac."Maximum Loan Amount" then
                        amtQualified := ProdFac."Maximum Loan Amount";


                    EligibilityFailReason := '';
                    QualifiedAmount := amtQualified;
                    EXIT(QualifiedAmount);
                end;
            END ELSE BEGIN
                EligibilityFailReason := StrSubstNo('You are not eligible. FOSA transactional account NOT found');
                QualifiedAmount := 0;
                EXIT(QualifiedAmount);
            END;
        end;
        //Max all mobile loans to deposit Balance - #866 Pension Advance Eligibility
        OrdinaryAccounts.RESET;
        OrdinaryAccounts.SETRANGE("Member No.", Members."No.");
        OrdinaryAccounts.SETRANGE("Product Category", OrdinaryAccounts."Product Category"::"BOSA Deposits");
        OrdinaryAccounts.SetLoadFields(Balance);
        IF OrdinaryAccounts.FINDFIRST THEN BEGIN
            OrdinaryAccounts.CALCFIELDS(Balance);

            if ProdFac."Deposit Qualifier %" > 0 then begin
                amtQualified := Round(OrdinaryAccounts.Balance * (ProdFac."Deposit Qualifier %" / 100), 1);
                Message('Qualified Amount based on deposit qualifier %: %1', Format(amtQualified));
            end else begin
                amtQualified := OrdinaryAccounts.Balance;
            end;

            iF OrdinaryAccounts.Balance < amtQualified then begin
                amtQualified := OrdinaryAccounts.Balance;
                Message('Qualified Amount adjusted to deposit balance: %1', Format(amtQualified));
            end;

            if amtQualified > ProdFac."Maximum Loan Amount" then
                amtQualified := ProdFac."Maximum Loan Amount";
            Message('Qualified Amount after applying maximum loan amount: %1', Format(amtQualified));

            if amtQualified <= 0 then begin
                EligibilityFailReason := StrSubstNo(
                    'You are not eligible. %1% of your deposit balance KES %2 qualifies you for KES %3',
                    Format(ProdFac."Deposit Qualifier %", 0, '<Integer>'),
                    Format(OrdinaryAccounts.Balance, 0, '<Precision,2:2><Standard Format,0>'),
                    Format(Round(OrdinaryAccounts.Balance * (ProdFac."Deposit Qualifier %" / 100), 1), 0, '<Precision,2:2><Standard Format,0>')
                );
                Message('Applicant NOT eligible. %1% of your deposit balance KES %2 qualifies you for KES %3',
                    Format(ProdFac."Deposit Qualifier %", 0, '<Integer>'),
                    Format(OrdinaryAccounts.Balance, 0, '<Precision,2:2><Standard Format,0>'),
                    Format(Round(OrdinaryAccounts.Balance * (ProdFac."Deposit Qualifier %" / 100), 1), 0, '<Precision,2:2><Standard Format,0>')
                );
                QualifiedAmount := 0;
                exit(QualifiedAmount);
            end;

            EligibilityFailReason := '';
        END;
        exit(amtQualified);
        Message('Qualified Amount: %1', Format(amtQualified));
    end;

    procedure GetLoansQualifyAmount2(MemberNo: Code[20]; ProductID: Code[10]; Installments: Integer; var EligibilityFailReason: Text) QualifiedAmount: Decimal
    var
        Members: Record Members;
        PFac: Record "Product Factory";
        ProdFac: Record "Product Factory";
        amtQualified: Decimal;
        saccoAccount: Record "Savings Accounts";
        STOAmount: Decimal;
        SalAvg: Decimal;
        LoanRec: Decimal;
        SalaryAmount: Decimal;
        GenSetUp: Record "General Set-Up";
        RelatedProduct: Record "Related Product";
        // RelatedProduct: Record "Loan Products to Bridge";   // to recheck
        LoanApp: Record Loans;
        OrdinaryAccounts: Record "Savings Accounts";
        SalaryLines: Record "Salary Lines";
        SalaryHeader: Record "Salary Header";
        Loans: Record Loans;
        Incomsal: Enum "Salary Income Types";
        Globalfunc: Codeunit "Global Functions";
        MobileLoanBuffer: record "Mobile loan App. Buffer";
        // MLoanSetup: Record "M-Loan Setup";

        ExistingFOSAMLoan: record loans;
        InterestRepayment: Decimal;
        LoanRepayment: Decimal;
        TLoanRepayment: Decimal;
        ExistingFOSAMLoanAmount: Decimal;
        DepositCap: Decimal;
    begin
        if not GenSetUp.GET then begin
            EligibilityFailReason := 'General Setup NOT complete';
            QualifiedAmount := 0;
            EXIT(QualifiedAmount);
        end;
        if not ProdFac.GET(ProductID) then begin
            EligibilityFailReason := 'This loan product is currently unavailable';
            QualifiedAmount := 0;
            EXIT(QualifiedAmount);
        end;

        // Check mobile loan buffer for unposted loans application
        MobileLoanBuffer.Reset;
        MobileLoanBuffer.SetRange("Member No.", MemberNo);
        MobileLoanBuffer.SetRange(Posted, false);
        MobileLoanBuffer.SetLoadFields("Entry No");

        if MobileLoanBuffer.FindFirst then begin
            EligibilityFailReason := 'There is an ongoing mobile loan application being processed';
            QualifiedAmount := 0;
            EXIT(QualifiedAmount);
        end;

        // Check unposted loans with outstanding balance
        LoanApp.RESET;
        LoanApp.SETRANGE("Member No.", MemberNo);
        LoanApp.SETRANGE(Posted, false);
        LoanApp.SETRANGE("Loan Product Type", ProductID);
        LoanApp.SETFILTER("Total Loan Balance", '>0');
        LoanApp.SetLoadFields("Loan No.", Posted);

        if LoanApp.FindFirst then begin
            LoanApp.Posted := true;
            LoanApp.Modify;

            EligibilityFailReason := 'You have a loan application already in progress';
            QualifiedAmount := 0;
            EXIT(QualifiedAmount);
        end;

        amtQualified := 0;
        STOAmount := 0;
        SalAvg := 0;
        LoanRec := 0;
        SalaryAmount := 0;

        Members.Reset;
        Members.SetRange("No.", MemberNo);

        Members.SetLoadFields(
            "No.", Status, Subflag, "Registration Date"
        );

        if Members.Find('-') then begin
            IF Members.Status <> Members.Status::Active THEN BEGIN
                EligibilityFailReason := 'Your membership is not active';
                QualifiedAmount := 0;
                EXIT(QualifiedAmount);
            END else begin
                // Active Status - Check Subflags
                if not (
                    (Members.Subflag = Members.Subflag::"First time") or
                    (Members.Subflag = Members.Subflag::Rejoined) or
                    (Members.Subflag = Members.Subflag::"Partial withdrawn")
                ) then begin
                    EligibilityFailReason := StrSubstNo('You are not eligible because your Sub-Status is %1', Members.Subflag);
                    QualifiedAmount := 0;
                    EXIT(QualifiedAmount);
                end;
            end;

            /*
        	To qualify for this loan, member must have been in membership minimum period of 3 months
            */
            if Format(ProdFac."Minimum Application Period") <> '' then begin
                if CalcDate(ProdFac."Minimum Application Period", Members."Registration Date") > Today then begin
                    EligibilityFailReason := StrSubstNo(
                        'You are not eligible. Minimum membership period required is %1',
                        Format(ProdFac."Minimum Application Period")
                    );
                    QualifiedAmount := 0;
                    EXIT(QualifiedAmount);
                end;
            end;

            //Get and check Member deposit balance
            OrdinaryAccounts.RESET;
            OrdinaryAccounts.SETRANGE("Member No.", Members."No.");
            OrdinaryAccounts.SETRANGE("Product Category", OrdinaryAccounts."Product Category"::"BOSA Deposits");
            OrdinaryAccounts.SetLoadFields(Balance);
            IF OrdinaryAccounts.FINDFIRST THEN BEGIN
                OrdinaryAccounts.CALCFIELDS(Balance);
                IF OrdinaryAccounts.Balance < ProdFac."Minimum Deposit Balance" THEN BEGIN
                    EligibilityFailReason := 'Your savings balance is below the minimum required for this loan';
                    QualifiedAmount := 0;
                    EXIT(QualifiedAmount);
                END else begin
                    if ProdFac."Minimum Dep. Contribution %" > 0 then begin
                        QualifiedAmount := (ProdFac."Minimum Dep. Contribution %" / 100) * OrdinaryAccounts.Balance;
                    end;
                end;
            END;

            saccoAccount.RESET;
            saccoAccount.SETRANGE(saccoAccount."Member No.", Members."No.");
            saccoAccount.SetRange("Product Category", saccoAccount."Product Category"::"FOSA Account");
            saccoAccount.SetCurrentKey(Blocked);
            saccoAccount.setrange("Loan Disbursement Account", true);
            // saccoAccount.SetRange("Product Type", '191');

            saccoAccount.SetLoadFields(
                "No.", "Member No.", Status, Blocked
            );
            IF saccoAccount.FIND('-') THEN BEGIN
                IF (saccoAccount.Status <> saccoAccount.Status::Active) OR (saccoAccount.Blocked <> saccoAccount.Blocked::" ") THEN BEGIN
                    EligibilityFailReason := 'Your FOSA account is not active';
                    QualifiedAmount := 0;
                    EXIT(QualifiedAmount);
                END;

                STOAmount := 0;// ComputeSTODeductions(saccoAccount."No.");
                Message('DEBUG: STOAmount = %1', STOAmount);
                /*
                To qualify for this loan, member must have channeled the salary at FOSA for at least one month
                and the average net salary of subsequent month up to the 12th month after the 12th,
                the last salary is not considered
                */
                SalAvg := Globalfunc.GetAzimaSMSLoanSalaryAverage(saccoAccount."No.", Incomsal::Salary);
                Message('DEBUG: Raw SalAvg from GetAzimaSMSLoanSalaryAverage = %1', SalAvg);
                LoanRec := 0;// ComputeLoanDeductions(saccoAccount."Member No.");
                Message('DEBUG: LoanRec (before existing FOSA loan deduction) = %1', LoanRec);

                // Handle existing fosa mloan to be cleared after topup
                ExistingFOSAMLoan.Reset;
                ExistingFOSAMLoan.SETRANGE("Member No.", MemberNo);
                ExistingFOSAMLoan.SETFILTER("Total Loan Balance", '>0');
                ExistingFOSAMLoan.SETRANGE("Loan Product Type", ProductID);
                ExistingFOSAMLoan.SETRANGE(Posted, true);
                ExistingFOSAMLoan.SetLoadFields(
                    "Total Balance", "Loan Product Type", Repayment, "Outstanding Interest", Repayment, Installments, "Outstanding Balance"
                );
                ExistingFOSAMLoan.SetAutoCalcFields(
                    "Total Balance", "Outstanding Interest", "Outstanding Balance"
                );

                if ExistingFOSAMLoan.Findset then begin
                    repeat begin
                        InterestRepayment := 0;
                        LoanRepayment := 0;
                        // LoanRepayment := ExistingFOSAMLoan.Repayment;

                        // IF ExistingFOSAMLoan."Outstanding Interest" > 0 THEN BEGIN
                        //     LoanRepayment := ExistingFOSAMLoan.Repayment;

                        //     IF ExistingFOSAMLoan.Installments = 1 THEN
                        //         LoanRepayment := ExistingFOSAMLoan."Outstanding Balance";
                        //     IF LoanRepayment < 0 THEN
                        //         LoanRepayment := 0;
                        // END;
                        // IF LoanRepayment > ExistingFOSAMLoan."Total Balance" THEN
                        LoanRepayment := ExistingFOSAMLoan."Total Balance";
                        TLoanRepayment += LoanRepayment;
                    end until ExistingFOSAMLoan.Next = 0;

                    // if ProdFac."Repay Mode" in [
                    //     ProdFac."Repay Mode"::Salary,
                    //     ProdFac."Repay Mode"::"Mobile Money"
                    // ] then begin
                    LoanRec -= TLoanRepayment;

                    if LoanRec < 0 then
                        LoanRec := 0;

                    Message('DEBUG: TLoanRepayment (existing FOSA loans) = %1, LoanRec after deduction = %2', TLoanRepayment, LoanRec);
                    // end;
                end;

                //confirm if loan exist of same type
                if ProdFac."Type of Discounting" <> ProdFac."Type of Discounting"::"Dividend Discounting" then begin

                    RelatedProduct.RESET;
                    RelatedProduct.SETRANGE("Product Code", ProductID);

                    RelatedProduct.SetLoadFields("Related Product Code");

                    IF RelatedProduct.FINDSET THEN BEGIN
                        REPEAT
                            LoanApp.RESET;
                            LoanApp.SETRANGE("Member No.", saccoAccount."Member No.");
                            LoanApp.SETRANGE(Posted, TRUE);
                            LoanApp.SETRANGE("Loan Product Type", RelatedProduct."Related Product Code");
                            LoanApp.SETFILTER("Total Loan Balance", '>0');
                            LoanApp.SetLoadFields("Loan No.");
                            IF LoanApp.FINDSET THEN BEGIN
                                REPEAT
                                    IF ProdFac."Allow Multiple Running Loans" = FALSE THEN BEGIN
                                        EligibilityFailReason := 'You already have a running loan of this type';
                                        QualifiedAmount := 0;
                                        EXIT(QualifiedAmount);
                                    END;
                                UNTIL LoanApp.NEXT = 0;
                            END;
                        UNTIL RelatedProduct.NEXT = 0;
                    END;
                end else begin
                    LoanApp.RESET;
                    LoanApp.SETRANGE(LoanApp."Member No.", MemberNo);
                    LoanApp.SetFilter("Loans Category-SASRA", '%1|%2|%3', LoanApp."Loans Category-SASRA"::Substandard, LoanApp."Loans Category-SASRA"::Doubtful, LoanApp."Loans Category-SASRA"::Loss);
                    LoanApp.SETFILTER(LoanApp."Total Loan Balance", '>0');
                    LoanApp.SetLoadFields("Loan No.");
                    IF LoanApp.FIND('-') THEN BEGIN
                        EligibilityFailReason := 'You have non-performing loans and are not eligible';
                        QualifiedAmount := 0;
                        exit(QualifiedAmount);
                    END;
                    QualifiedAmount := DividenceAdvanceQualification(MemberNo, ProductID);
                    if QualifiedAmount <= 0 then begin
                        EligibilityFailReason := 'You do not have sufficient dividends to qualify for this loan';
                        QualifiedAmount := 0;
                    end;
                    exit(QualifiedAmount);
                end;

                //Exisiting loans
                if ProdFac."Type of Discounting" <> ProdFac."Type of Discounting"::"Dividend Discounting" then begin
                    // Loans.RESET;
                    // Loans.SETRANGE(Loans."Member No.", saccoAccount."Member No.");
                    // Loans.SETRANGE(Loans."Loan Product Type", ProductID);
                    // Loans.SETRANGE(Loans.Posted, TRUE);
                    // Loans.SETFILTER("Total Loan Balance", '>0');
                    // Loans.SetLoadFields("Loan No.");
                    // IF Loans.FIND('-') THEN BEGIN
                    //     QualifiedAmount := 0;
                    //     EXIT(QualifiedAmount);
                    // END;
                    if ProdFac."Requires Salary Processing" = false then begin
                        Message('DEBUG: Deposit-based path. QualifiedAmount (from deposit contribution) = %1, Maximum Loan Amount = %2', QualifiedAmount, ProdFac."Maximum Loan Amount");
                        if QualifiedAmount > ProdFac."Maximum Loan Amount" then begin
                            QualifiedAmount := ProdFac."Maximum Loan Amount";
                        end;

                        ExistingFOSAMLoanAmount := GlobalFunctions.GetMemberLoanProductTotalBalance(
                            MemberNo,
                            ProductID
                        );
                        Message('DEBUG: QualifiedAmount after cap = %1, ExistingFOSAMLoanAmount = %2', QualifiedAmount, ExistingFOSAMLoanAmount);

                        if ExistingFOSAMLoanAmount >= QualifiedAmount then begin
                            EligibilityFailReason := 'Your maximum eligibility has already been used up by your existing loan balance';
                            QualifiedAmount := 0;
                            Message('DEBUG: FAIL - %1', EligibilityFailReason);
                            exit(QualifiedAmount);
                        end;

                        Message('DEBUG: Final QualifiedAmount (deposit-based) = %1', QualifiedAmount - ExistingFOSAMLoanAmount);
                        exit(QualifiedAmount - ExistingFOSAMLoanAmount);
                    end;
                    /*
                    this loan qualifies off the average net salary only
                    GetAzimaSMSLoanSalaryAverage - last salary amount is not applicable here
                    */

                    // SalaryLines.RESET;
                    // SalaryLines.SETRANGE("Member No.", saccoAccount."Member No.");
                    // SalaryLines.SETRANGE(Posted, TRUE);
                    // SalaryLines.SETRANGE("Posting Date", CALCDATE(('-' + format(ProdFac."Salary Period")), TODAY), TODAY);
                    // SalaryLines.SetLoadFields(Amount);
                    // SalaryLines.SetCurrentKey(Amount);
                    // IF SalaryLines.FINDLAST THEN BEGIN
                    //     SalaryAmount := SalaryLines.Amount - (STOAmount + LoanRec);
                    // END;

                    SalAvg := SalAvg - (STOAmount + LoanRec);
                    SalaryAmount := SalAvg;
                    Message('DEBUG: Net SalaryAmount (SalAvg - STOAmount - LoanRec) = %1', SalaryAmount);

                    // if MLoanSetup.Get(ProdFac."Product ID", Installments) then begin
                    //     // Temporary Variable
                    //     ProdFac."Net Salary Multiplier %" := MLoanSetup."Net Salary Multiplier %";
                    // end;
                    // amtQualified := SalaryAmount * (ProdFac."Net Salary Multiplier %" / 100) * Installments;
                    amtQualified := SalaryAmount * (ProdFac."Net Salary Multiplier %" / 100);
                    IF amtQualified < 0 THEN amtQualified := 0;
                    QualifiedAmount := amtQualified;
                    Message('DEBUG: amtQualified (SalaryAmount x Net Salary Multiplier %1 pct) = %2', ProdFac."Net Salary Multiplier %", QualifiedAmount);

                    if QualifiedAmount > ProdFac."Maximum Loan Amount" then begin
                        QualifiedAmount := ProdFac."Maximum Loan Amount";
                    end;
                    Message('DEBUG: QualifiedAmount after Maximum Loan Amount cap (%1) = %2', ProdFac."Maximum Loan Amount", QualifiedAmount);

                    /*
                    The loan shall be secured by own deposits up to 80% with minimum of Ksh 3,000
                    */
                    if ProdFac."Deposit Qualifier %" > 0 then begin
                        OrdinaryAccounts.Reset();
                        OrdinaryAccounts.SetRange("Member No.", Members."No.");
                        OrdinaryAccounts.SetRange("Product Category", OrdinaryAccounts."Product Category"::"BOSA Deposits");
                        OrdinaryAccounts.SetLoadFields(Balance);
                        if OrdinaryAccounts.FindFirst() then begin
                            OrdinaryAccounts.CalcFields(Balance);
                            DepositCap := Round(OrdinaryAccounts.Balance * (ProdFac."Deposit Qualifier %" / 100), 1);
                            if DepositCap > ProdFac."Maximum Loan Amount" then
                                DepositCap := ProdFac."Maximum Loan Amount";

                            if QualifiedAmount > DepositCap then
                                QualifiedAmount := DepositCap;
                            Message('DEBUG: DepositCap = %1, QualifiedAmount after deposit qualifier cap = %2', DepositCap, QualifiedAmount);
                        end;
                    end;

                    /*
                    the loan can be topped up only if the maximum
                    eligibility is not already exhausted by the existing running balance on this product
                    */
                    ExistingFOSAMLoanAmount := GlobalFunctions.GetMemberLoanProductTotalBalance(
                        MemberNo,
                        ProductID
                    );
                    Message('DEBUG: ExistingFOSAMLoanAmount = %1, QualifiedAmount before top-up check = %2', ExistingFOSAMLoanAmount, QualifiedAmount);

                    if ExistingFOSAMLoanAmount >= QualifiedAmount then begin
                        EligibilityFailReason := StrSubstNo(
                            'You are not eligible for a top up. Your maximum eligibility of KES %1 has already been exhausted by your existing loan balance of KES %2',
                            Format(QualifiedAmount, 0, '<Precision,2:2><Standard Format,0>'),
                            Format(ExistingFOSAMLoanAmount, 0, '<Precision,2:2><Standard Format,0>')
                        );
                        QualifiedAmount := 0;
                        Message('DEBUG: FAIL - %1', EligibilityFailReason);
                        EXIT(QualifiedAmount);
                    end;

                    // QualifiedAmount -= ExistingFOSAMLoanAmount;
                    Message('DEBUG: Final QualifiedAmount (salary-based) = %1', QualifiedAmount);
                    EXIT(QualifiedAmount);
                end;
            END ELSE BEGIN
                EligibilityFailReason := 'You don''t have an active FOSA account';
                QualifiedAmount := 0;
                EXIT(QualifiedAmount);
            END;
        end else begin
            EligibilityFailReason := 'Member not found';
        end;
        exit(amtQualified);
    end;

    procedure BufferLoanApplication2(
         MemberNo: Code[50];
         LoanProductID: Code[50];
         RequestedAmount: Decimal;
         SourceReference: Text;
         MobileLoanPurpose: Text;
         Installments: Integer
     ): Boolean
    var
        MobileLoanBuffer: record "Mobile loan App. Buffer";
        LoanProduct: Record "Product Factory";
        TheMember: record Members;
        msg: Text;
        FosaAcc: Text;
        ExistingFOSAMLoanAmount: Decimal;
    begin
        // check for duplicate Applications

        // MobileLoanBuffer.RESET;
        // MobileLoanBuffer.SETRANGE("Member No.", MemberNo);
        // MobileLoanBuffer.SETRANGE(Deactivated, FALSE);
        // MobileLoanBuffer.SETRANGE("Loan Product Type", LoanProductType);
        // MobileLoanBuffer.SetRange(Status, MobileLoanBuffer.Status::Pending);
        // if MobileLoanBuffer.FIND('-') then begin
        //     exit(MobileLoanBuffer."Loan No.");
        // end;
        TheMember.Get(MemberNo);
        FosaAcc := GetMemberFosaAcc(TheMember);

        ExistingFOSAMLoanAmount := GlobalFunctions.GetMemberLoanProductTotalBalance(
            MemberNo,
            LoanProductID
        );

        MobileLoanBuffer.Init;
        MobileLoanBuffer."Member No." := MemberNo;
        MobileLoanBuffer."Loan Product Type" := LoanProductID;
        MobileLoanBuffer.Amount := RequestedAmount;
        /*
         Top-up: Approved Amount is the requested amount only - "Loans Top up" clears the existing balance separately. Confirmed by Paul.
        */
        // MobileLoanBuffer."Approved Amount" := RequestedAmount + ExistingFOSAMLoanAmount;
        MobileLoanBuffer."Approved Amount" := RequestedAmount;
        MobileLoanBuffer."Session ID" := SourceReference;
        MobileLoanBuffer.Status := MobileLoanBuffer.Status::Approved;
        MobileLoanBuffer.Posted := false;
        MobileLoanBuffer."Time Entered" := Time;
        MobileLoanBuffer."Date Entered" := Today;
        MobileLoanBuffer."Loan No." := '';
        MobileLoanBuffer."Loan Purpose" := MobileLoanPurpose;
        MobileLoanBuffer."Account Name" := TheMember.Name;
        MobileLoanBuffer.Installments := Installments;
        MobileLoanBuffer."Account No" := FosaAcc;

        // LoanProduct.SetRange("Product ID", LoanProductID);
        // MobileLoanBuffer."Needs Guarantors" := LoanProduct."Mobile Loan Req. Guar.";
        // if MobileLoanBuffer."Needs Guarantors" then begin
        //     LoanProduct.TestField("Mobile Min. Guarantors");
        //     MobileLoanBuffer.Status := MobileLoanBuffer.Status::"Pending Guarantors";
        //     MobileLoanBuffer."Expected Guarantors" := GetNumberOfGuarantors(LoanProduct."Product ID", RequestedAmount);
        // end;

        if MobileLoanBuffer.Insert(true) then begin
            // if LoanProduct."Mobile Loan Req. Guar." then begin

            //     msg := 'Dear member, To add guarantors to your ' + MobileLoanBuffer."Loan Name" + ' request of KES ' + Format(MobileLoanBuffer.Amount) + ', Please dial *816# or use our Mobile App.' +
            //           'Login > Loans > Add / Remove Guarantors. ' +
            //           'REF: ' + MobileLoanBuffer."Loan No.";
            //     SendSMS.SendSms(SMSSource::MBANKING, TheMember."Phone No.", msg, Format(MobileLoanBuffer."Loan No."), '', true, 220, false, 'CBS', MobileLoanBuffer."Loan No.", 'CBS');

            //     msg := 'Minimum required guarantors is ' + Format(MobileLoanBuffer."Expected Guarantors") + '. In the event their total deposits won''t be sufficient, you''ll'
            //     + ' be required to add one or more.REF: ' + MobileLoanBuffer."Loan No.";
            //     SendSMS.SendSms(SMSSource::MBANKING, TheMember."Phone No.", msg, Format(MobileLoanBuffer."Loan No."), '', true, 220, false, 'CBS', MobileLoanBuffer."Loan No.", 'CBS');

            // end;

            //if CreateLoanRecord2(MobileLoanBuffer, LoanProductID, Installments) then
            exit(true)
            // else
            //     exit(false);
        end else
            exit(false);
    end;
    // Create applied loan record
    procedure CreateLoanRecord2(var MobileLoanBuffer: Record "Mobile loan App. Buffer"; LoanProdID: code[50]; Installments: Integer): Boolean
    var
        Loans: Record Loans;
        ProductFactory: Record "Product Factory";
        CreditAccounts: record "Credit Accounts";
        LoansProcess: Codeunit "Loans Process";
        NoSeries: record "No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        LoanNo: Code[50];
        MobileLnNoSeries: record "Credit Nos. Series";
        Members: Record Members;
        UserSetUp: Record "User Setup";
        InstallmentFrequency: Text;
        InstallmentPeriod: DateFormula;
        MobileLoanPurposes: Record "Loan Purpose";

        ExistingFOSAMLoan: record loans;
        LoansToBeCleared: Record "Loans Top up";
    begin
        //InstallmentPeriod := '';
        InstallmentFrequency := '';
        MobileLnNoSeries.get;
        ProductFactory.get(LoanProdID);
        Members.get(MobileLoanBuffer."Member No.");
        UserSetUp.get(UserId);

        Loans.Init();
        Loans."No. Series" := MobileLnNoSeries."Mobile Loan Nos.";
        LoanNo := NoSeriesMgt.GetNextNo(Loans."No. Series");
        Loans."Loan No." := LoanNo;
        Loans."Mobile Loan" := true;
        Loans."Member No." := MobileLoanBuffer."Member No.";
        Loans."Member Name" := Members.Name;
        Loans."Interest Calculation Method" := ProductFactory."Interest Calculation Method";
        Loans."Loan Product Type" := LoanProdID;
        Loans."Loan Product Type Name" := ProductFactory."Product Description";
        Loans."Purpose of Loan" := MobileLoanBuffer."Loan Purpose";
        Loans."Loan Account" := LoansProcess.CreateLoanAccount(MobileLoanBuffer."Member No.", LoanProdID);
        Loans.Interest := ProductFactory."Interest Rate (Max.)";
        Loans."Loan Span" := ProductFactory."Loan Span";
        Loans."Application Date" := Today;
        Loans."Disbursement Date" := Today;
        Loans."disbursement time" := Time;
        Loans."Approved Amount" := MobileLoanBuffer."Approved Amount";
        Loans."Staff No" := Members."Payroll/Staff No.";
        Loans."Requested Amount" := MobileLoanBuffer."Approved Amount";
        Loans."Approved Amount" := MobileLoanBuffer."Approved Amount";
        Loans."Amount To Disburse" := MobileLoanBuffer."Approved Amount";
        Loans."Disbursement Account No" := MobileLoanBuffer."Account No";
        Loans.Status := Loans.Status::Approved;
        Loans."Captured By" := UpperCase(UserId);
        Loans."Global Dimension 1 Code" := Members."Global Dimension 1 Code";

        Loans."Global Dimension 2 Code" := Format(ProductFactory."Source Unit");
        Loans.Source := Loans.Source::BANKING;
        Loans."Recovery Mode" := ProductFactory."Repay Mode";
        Loans."Recovery Priority" := ProductFactory."Recovery Priority";

        if (Installments > ProductFactory."Ordinary Default Intallments") or (Installments <= 0) then begin
            Installments := ProductFactory."Ordinary Default Intallments";
        end;
        Loans.Installments := Installments;
        Loans."Repayment Frequency" := ProductFactory."Repayment Frequency";

        case
            Loans."Repayment Frequency" of
            Loans."Repayment Frequency"::Monthly:
                begin
                    Loans."Repayment Start Date" := CALCDATE('1M', Today);
                    InstallmentFrequency := 'M';
                    evaluate(InstallmentPeriod, '1M');
                end;
            Loans."Repayment Frequency"::Daily:
                begin
                    Loans."Repayment Start Date" := CALCDATE('1D', Today);
                    InstallmentFrequency := 'D';
                    Evaluate(InstallmentPeriod, '1D');
                end;
            Loans."Repayment Frequency"::Weekly:
                begin
                    Loans."Repayment Start Date" := CALCDATE('1W', Today);
                    InstallmentFrequency := 'W';
                    Evaluate(InstallmentPeriod, '1W');
                end;
            else begin
                Loans."Repayment Start Date" := CALCDATE('1M', Today);
                InstallmentFrequency := 'M';
                Evaluate(InstallmentPeriod, '1M');
            end;
        end;
        Loans."Expected Date of Completion" := CALCDATE(Format(Loans.Installments) + InstallmentFrequency, Loans."Repayment Start Date");
        if (Loans.Installments = 1) and (Loans."Repayment Frequency" = Loans."Repayment Frequency"::Monthly) then begin
            Loans."Expected Date of Completion" := CalcDate('<1M>', Loans."Disbursement Date");
            Loans."Repayment Start Date" := CalcDate('<1M>', Loans."Disbursement Date");
        end;
        Loans."Installment Period" := ProductFactory."Installment Repayment Interval";
        if Format(Loans."Installment Period") = '' then
            Loans."Installment Period" := InstallmentPeriod;

        if Loans."Purpose of Loan" <> '' then begin
            MobileLoanPurposes.Reset;
            MobileLoanPurposes.SetRange(Code, Loans."Purpose of Loan");

            MobileLoanPurposes.SetLoadFields(
                "Main Sector",
                "Sub Sector Level1",
                "Sub Sector Level2",
                "Main Sector Description",
                "Sub Sector Level1 Description",
                "Sub Sector Level2 Description"
            );

            if MobileLoanPurposes.FindFirst then begin
                Loans."Main Sector" := MobileLoanPurposes."Main Sector";
                Loans."Main Sector Description" := MobileLoanPurposes."Main Sector Description";
                Loans."Sub Sector Level1" := MobileLoanPurposes."Sub Sector Level1";
                Loans."Sub Sector Level1 Description" := MobileLoanPurposes."Sub Sector Level1 Description";
                Loans."Sub Sector Level2" := MobileLoanPurposes."Sub Sector Level2";
                Loans."Sub Sector Level2 Description" := MobileLoanPurposes."Sub Sector Level2 Description";
            end;
        end;

        Loans.Validate("Disbursement Date");
        Loans.Validate("Approved Amount");

        // Source Unit
        Loans."Source Unit" := ProductFactory."Source Unit";
        Loans."Compute Interest Due on Postin" := ProductFactory."Compute Interest Due on Postin";
        Loans."Loanee Message" := MobileLoanBuffer."Session ID";

        if Loans.Insert then begin
            // Handle existing fosa mloan to be cleared after topup
            ExistingFOSAMLoan.Reset;
            ExistingFOSAMLoan.SETRANGE("Member No.", Loans."Member No.");
            ExistingFOSAMLoan.SETFILTER("Total Loan Balance", '>0');
            ExistingFOSAMLoan.SETRANGE("Loan Product Type", Loans."Loan Product Type");
            ExistingFOSAMLoan.SETRANGE(Posted, true);
            ExistingFOSAMLoan.SetLoadFields("Loan No.");


            if ExistingFOSAMLoan.Findset then begin
                repeat begin
                    LoansToBeCleared.Init;

                    LoansToBeCleared."Loan No." := Loans."Loan No.";
                    LoansToBeCleared."Client Code" := Loans."Member No.";
                    LoansToBeCleared."Loan Top Up" := ExistingFOSAMLoan."Loan No.";

                    LoansToBeCleared.Validate("Loan Top Up");
                    LoansToBeCleared.Validate("Principle Top Up");
                    LoansToBeCleared.Validate("Interest Top Up");

                    if LoansToBeCleared.Insert then begin
                    end;
                end until ExistingFOSAMLoan.Next = 0;
            end;

            MobileLoanBuffer."Loan No." := Loans."Loan No.";
            MobileLoanBuffer."Interest Recoverd Upfront" := ProductFactory."Interest Recovered Upfront";
            if ProductFactory."Mobile Min. Guarantors" > 0 then begin
                MobileLoanBuffer."Needs Guarantors" := true;
                MobileLoanBuffer."Expected Guarantors" := ProductFactory."Mobile Min. Guarantors";
            end;
            MobileLoanBuffer."Loan Record Created?" := true;
            MobileLoanBuffer.Modify(true);
            exit(true);
        end else begin
            exit(false);
        end;
    end;

    procedure ComputeSTODeductions(AccountNo: Code[20]): Decimal
    var
        AmountToDeduct: Decimal;
        ObjStandingOrders: Record "Standing Order Header";
    begin
        //GET STOS
        AmountToDeduct := 0;
        ObjStandingOrders.RESET;
        ObjStandingOrders.SETCURRENTKEY("No.", "Source Account No.");
        ObjStandingOrders.SETRANGE("Source Account No.", AccountNo);
        ObjStandingOrders.SETRANGE(Status, ObjStandingOrders.Status::Approved);
        //ObjStandingOrders.SETRANGE("Income Type",'');
        ObjStandingOrders.SetLoadFields(Amount);
        IF ObjStandingOrders.FINDSET THEN BEGIN
            REPEAT
                AmountToDeduct += ObjStandingOrders.Amount;
            UNTIL ObjStandingOrders.NEXT = 0;
        END;
        EXIT(AmountToDeduct);
    end;

    procedure ComputeLoanDeductions(MemeberNo: Code[20]): Decimal
    var
        InterestRepayment: Decimal;
        LoanRepayment: Decimal;
        TInterestRepayment: Decimal;
        TLoanRepayment: Decimal;
        LoanApp: Record Loans;
        LoanProductsSetup: Record "Product Factory";
    begin
        InterestRepayment := 0;
        LoanRepayment := 0;
        TInterestRepayment := 0;
        TLoanRepayment := 0;
        LoanApp.RESET;
        LoanApp.SETCURRENTKEY(Source, "Disbursement Date", "Loan Product Type", "Member No.", "Employer Code");
        LoanApp.SETFILTER(LoanApp."Recovery Mode", '%1|%2', LoanApp."Recovery Mode"::Salary, LoanApp."Recovery Mode"::"Mobile Money");
        LoanApp.SETRANGE(LoanApp."Member No.", MemeberNo);
        LoanApp.SETFILTER(LoanApp."Outstanding Balance", '>0');
        LoanApp.SETAUTOCALCFIELDS("Outstanding Balance", "Outstanding Interest");
        //LoanApp.SETRANGE("Mobile Loan",FALSE);
        LoanApp.SetLoadFields(
            "Total Balance", "Loan Product Type", Repayment, "Outstanding Interest", Repayment, Installments, "Outstanding Balance"
        );
        LoanApp.SetAutoCalcFields(
            "Total Balance", "Outstanding Interest", "Outstanding Balance"
        );

        IF LoanApp.FINDSET THEN BEGIN
            REPEAT
                // LoanApp.CALCFIELDS("Total Balance");
                IF LoanProductsSetup.GET(LoanApp."Loan Product Type") THEN BEGIN
                    InterestRepayment := 0;
                    LoanRepayment := 0;
                    LoanRepayment := LoanApp.Repayment;

                    IF LoanApp."Outstanding Interest" > 0 THEN BEGIN
                        LoanRepayment := LoanApp.Repayment;

                        IF LoanApp.Installments = 1 THEN
                            LoanRepayment := LoanApp."Outstanding Balance";
                        IF LoanRepayment < 0 THEN
                            LoanRepayment := 0;
                    END;
                    IF LoanRepayment > LoanApp."Total Balance" THEN
                        LoanRepayment := LoanApp."Total Balance";
                    TLoanRepayment += LoanRepayment;
                    // END;
                END;
            UNTIL LoanApp.NEXT = 0;
        END;
        EXIT(TLoanRepayment);
    end;

    procedure SalaryQualification(AccountNo: Code[20]): Decimal
    var
        SalAvg: Decimal;
        MonthI: Decimal;
        MonthII: Decimal;
        MonthIII: Decimal;
        SalStart: Date;
        SalStartII: Date;
        SalStartIII: Date;
        SalBufferI: Record "Salary Lines";
        SalBufferII: Record "Salary Lines";
        SalBuffer: Record "Salary Lines";
        SalBufferIII: Record "Salary Lines";
    begin
        SalAvg := 0;
        MonthI := 0;
        MonthII := 0;
        MonthIII := 0;
        SalStart := 0D;
        SalStartII := 0D;
        SalStartIII := 0D;

        SalBuffer.RESET;
        SalBuffer.SETCURRENTKEY(SalBuffer.Date);
        SalBuffer.SETRANGE(SalBuffer."Account No.", AccountNo);
        SalBuffer.SETRANGE("Posting Date", (CALCDATE('-3M', CALCDATE('-CM', TODAY))), TODAY);
        SalBuffer.SETFILTER(Amount, '>0');
        SalBuffer.SETRANGE(Posted, TRUE);
        IF SalBuffer.FIND('-') THEN BEGIN
            SalStart := SalBuffer."Posting Date";
        END;
        IF SalStart = 0D THEN SalStart := CALCDATE('1M', TODAY);
        SalStart := CALCDATE('-CM', SalStart);
        SalStartII := CALCDATE('1M', SalStart);
        SalStartIII := CALCDATE('2M', SalStart);
        MonthI := 0;
        SalBufferI.RESET;
        SalBufferI.SETRANGE(SalBufferI."Account No.", AccountNo);
        SalBufferI.SETRANGE("Posting Date", SalStart, CALCDATE('CM', SalStart));
        SalBufferI.SETFILTER(Amount, '>0');
        SalBufferI.SETRANGE(Posted, TRUE);
        SalBufferI.CALCSUMS(Amount);
        MonthI := SalBufferI.Amount;
        // MESSAGE(FORMAT(MonthI);

        MonthII := 0;
        SalBufferII.RESET;
        SalBufferII.SETRANGE(SalBufferII."Account No.", AccountNo);
        SalBufferII.SETRANGE("Posting Date", SalStartII, CALCDATE('CM', SalStartII));
        SalBufferII.SETFILTER(Amount, '>0');
        SalBufferII.SETRANGE(Posted, TRUE);
        SalBufferII.CALCSUMS(Amount);
        MonthII := SalBufferII.Amount;
        MonthIII := 0;
        SalBufferIII.RESET;
        SalBufferIII.SETRANGE(SalBufferIII."Account No.", AccountNo);
        SalBufferIII.SETRANGE("Posting Date", SalStartIII, CALCDATE('CM', SalStartIII));
        SalBufferIII.SETFILTER(Amount, '>0');
        SalBufferIII.SETRANGE(Posted, TRUE);
        SalBufferIII.CALCSUMS(Amount);
        MonthIII := SalBufferIII.Amount;
        // MESSAGE('%1 and %2 and %3',MonthI,MonthII,MonthIII);
        IF (MonthI > MonthII) AND (MonthII > 0) THEN
            MonthI := MonthII;

        IF (MonthI > MonthIII) AND (MonthIII > 0) THEN
            MonthI := MonthIII;
        IF (MonthI <= 0) then
            MonthI := 0;

        EXIT(MonthI);
    end;

    procedure GetTransChargesPreview(TransactionType: Text; TransactionAmount: Decimal; AccountNumber: Text; SearchMember: Record Members; ReceiverPaybillTill: Text; SourceApplication: Text): List of [decimal]
    var
        TotalCharges: List of [decimal];
        MobileTransLines: Record "Mobile Transaction Types Lines";
        MobileTransTypes: Record "Mobile Transaction Types";
        SumOfCharge: decimal;
        ExciseDuty: decimal;
        FosaAcc: Text;
        CurrCharges: List of [Decimal];

        GamingPaybills: Record "Gaming Paybills Setup";
    begin
        //Action to check the charge applicable
        // 1.	MPESA_WITHDRAWAL
        // 2.	AIRTIME_PURCHASE
        // 3.	BILL_PAYMENT
        // 4.	BANK_TRANSFER
        // 5.	IFT_ACCOUNT_TO_ACCOUNT
        // 6.	DEPOSIT
        // 7.	SINGLE_ACCOUNT_BALANCE_ENQUIRY
        // 8.	ACCOUNT_MINI_STATEMENT
        // 9.	ACCOUNT_FULL_STATEMENT
        // 10.	LOAN_BALANCE_ENQUIRY
        // 11.	LOAN_MINI_STATEMENT
        // 12.	LOAN_FULL_STATEMENT
        // 13.	LOAN_APPLICATION
        // 14.	IFT_LOAN_REPAYMENT
        // 15.	CHECK_LOAN_LIMIT
        // 16.	GUARANTORSHIP_ABILITY_ENQUIRY
        // 17.  GAMING_UTILITY_PAYMENT
        MobileTransTypes.Reset;
        case TransactionType of
            'MPESA_WITHDRAWAL':
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Mpesa Withdrawal");
            'AIRTIME_PURCHASE':
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::Airtime);
            'BILL_PAYMENT':
                begin
                    MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Utility Payment");
                    GamingPaybills.Reset;
                    GamingPaybills.SetRange("Paybill / Till No.", ReceiverPaybillTill);
                    if GamingPaybills.FindFirst then begin
                        MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Gaming Utility Payment");
                    end;
                end;
            'BANK_TRANSFER':
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Bank Transfer");
            'IFT_ACCOUNT_TO_ACCOUNT':
                begin
                    if GlobalFunctions.IsKesasaAccount(AccountNumber) then begin
                        MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Kesasa Account Transfer");
                    end else begin
                        MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Account Transfer");
                    end;
                end;
            'DEPOSIT':
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Mpesa Deposit");
            'COOP_DEPOSIT_B2B':
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Coop B2B Deposit");
            'COOP_DEPOSIT_P2F':
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Coop P2F Deposit");
            'LOAN_REPAYMENT':
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Loan Repayment");
            'TILL_PAYMENT':
                begin
                    MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Till Payment");
                    GamingPaybills.Reset;
                    GamingPaybills.SetRange("Paybill / Till No.", ReceiverPaybillTill);
                    if GamingPaybills.FindFirst then begin
                        MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Gaming Utility Payment");
                    end;
                end;
            'SINGLE_ACCOUNT_BALANCE_ENQUIRY':
                begin
                    MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Account Balance Enquiry");
                end;
            'ACCOUNT_MINI_STATEMENT':
                begin
                    MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Account Mini-Statement");
                end;
            'ACCOUNT_FULL_STATEMENT':
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Account Full-Statement");
            'LOAN_BALANCE_ENQUIRY':
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Loan Balance Enquiry");
            'LOAN_MINI_STATEMENT':
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Loan Mini-Statement");
            'LOAN_FULL_STATEMENT':
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Loan Full-Statement");
            'LOAN_APPLICATION':
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Loan Application");
            'IFT_LOAN_REPAYMENT':
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Pay Loan From Account");
            'CHECK_LOAN_LIMIT':
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Loan Limit Check");
            'GUARANTORSHIP_ABILITY_ENQUIRY':
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Guarantorship Ability Enquiry");
            'SMP_MEMBER_REGISTRATION':
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"SMP Registration");
            'SMP_PIN_RESET':
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"SMP PIN Reset");
            'PIN_RESET':
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Self PIN Reset");
            'GAMING_UTILITY_PAYMENT':
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Gaming Utility Payment");
            // "Loan Disbursement"
            'LOAN_DISBURSEMENT':
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Loan Disbursement");
        end;

        MobileTransTypes.SetLoadFields(Code);

        if MobileTransTypes.FindFirst then begin
            SumOfCharge := 0;
            ExciseDuty := 0;

            // Charges if Any
            MobileTransLines.Reset();
            MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);

            if MobileTransLines.FindSet then begin
                repeat
                    CurrCharges := GetMpesaTransCharges(MobileTransLines, TransactionAmount, AccountNumber, SourceApplication);
                    if CurrCharges.Get(1) > 0 then begin
                        SumOfCharge += CurrCharges.Get(1);
                    end;
                    if CurrCharges.Get(2) > 0 then begin
                        ExciseDuty += CurrCharges.Get(2);
                    end;
                until MobileTransLines.Next = 0;
            end;

            TotalCharges.Add(SumOfCharge);
            TotalCharges.Add(ExciseDuty);
        end else begin
            TotalCharges.Add(0);
            TotalCharges.Add(0);
        end;

        exit(TotalCharges);
    end;

    // Create Mobile Loan account and buffer
    procedure BufferLoanApplication(
        MemberNo: Code[50];
        LoanProductID: Code[50];
        RequestedAmount: Decimal;
        SourceReference: Text;
        MobileLoanPurpose: Text
    ): Boolean
    var
        MobileLoanBuffer: record "Mobile loan App. Buffer";
        LoanProduct: Record "Product Factory";
        TheMember: record Members;
        msg: Text;
    begin
        // check for duplicate Applications

        // MobileLoanBuffer.RESET;
        // MobileLoanBuffer.SETRANGE("Member No.", MemberNo);
        // MobileLoanBuffer.SETRANGE(Deactivated, FALSE);
        // MobileLoanBuffer.SETRANGE("Loan Product Type", LoanProductType);
        // MobileLoanBuffer.SetRange(Status, MobileLoanBuffer.Status::Pending);
        // if MobileLoanBuffer.FIND('-') then begin
        //     exit(MobileLoanBuffer."Loan No.");
        // end;
        TheMember.Get(MemberNo);

        MobileLoanBuffer.Init;
        MobileLoanBuffer."Member No." := MemberNo;
        MobileLoanBuffer."Loan Product Type" := LoanProductID;
        MobileLoanBuffer.Amount := RequestedAmount;
        MobileLoanBuffer."Approved Amount" := RequestedAmount;
        MobileLoanBuffer."Session ID" := SourceReference;
        MobileLoanBuffer.Status := MobileLoanBuffer.Status::Approved;
        MobileLoanBuffer.Posted := false;
        MobileLoanBuffer."Time Entered" := Time;
        MobileLoanBuffer."Date Entered" := Today;
        MobileLoanBuffer."Loan No." := '';
        MobileLoanBuffer."Loan Purpose" := MobileLoanPurpose;
        MobileLoanBuffer."Account Name" := TheMember.Name;
        MobileLoanBuffer."Employer Code" := TheMember."Employer Code";

        // LoanProduct.SetRange("Product ID", LoanProductID);
        // MobileLoanBuffer."Needs Guarantors" := LoanProduct."Mobile Loan Req. Guar.";
        // if MobileLoanBuffer."Needs Guarantors" then begin
        //     LoanProduct.TestField("Mobile Min. Guarantors");
        //     MobileLoanBuffer.Status := MobileLoanBuffer.Status::"Pending Guarantors";
        //     MobileLoanBuffer."Expected Guarantors" := GetNumberOfGuarantors(LoanProduct."Product ID", RequestedAmount);
        // end;

        if MobileLoanBuffer.Insert(true) then begin
            // if LoanProduct."Mobile Loan Req. Guar." then begin

            //     msg := 'Dear member, To add guarantors to your ' + MobileLoanBuffer."Loan Name" + ' request of KES ' + Format(MobileLoanBuffer.Amount) + ', Please dial *839# or use our Mobile App.' +
            //           'Login > Loans > Add / Remove Guarantors. ' +
            //           'REF: ' + MobileLoanBuffer."Loan No.";
            //     SendSMS.SendSms(SMSSource::MBANKING, TheMember."Phone No.", msg, Format(MobileLoanBuffer."Loan No."), '', true, 220, false, 'CBS', MobileLoanBuffer."Loan No.", 'CBS');

            //     msg := 'Minimum required guarantors is ' + Format(MobileLoanBuffer."Expected Guarantors") + '. In the event their total deposits won''t be sufficient, you''ll'
            //     + ' be required to add one or more.REF: ' + MobileLoanBuffer."Loan No.";
            //     SendSMS.SendSms(SMSSource::MBANKING, TheMember."Phone No.", msg, Format(MobileLoanBuffer."Loan No."), '', true, 220, false, 'CBS', MobileLoanBuffer."Loan No.", 'CBS');

            // end;

            if CreateLoanRecord(MobileLoanBuffer, LoanProductID) then
                exit(true)
            else
                exit(false);
        end else
            exit(false);
    end;
    // Create applied loan record
    procedure CreateLoanRecord(MobileLoanBuffer: Record "Mobile loan App. Buffer"; LoanProdID: code[50]): Boolean
    var
        Loans: Record Loans;
        ProductFactory: Record "Product Factory";
        CreditAccounts: record "Credit Accounts";
        LoansProcess: Codeunit "Loans Process";
        NoSeries: record "No. Series";
        NoSeriesMgt: Codeunit "No. Series";
        LoanNo: Code[50];
        MobileLnNoSeries: record "Credit Nos. Series";
        Members: Record Members;
        UserSetUp: Record "User Setup";
        InstallmentFrequency: Text;
        InstallmentPeriod: DateFormula;
        MobileLoanPurposes: Record "Loan Purpose";
    begin
        //InstallmentPeriod := '';
        InstallmentFrequency := '';
        MobileLnNoSeries.get;
        ProductFactory.get(LoanProdID);
        Members.get(MobileLoanBuffer."Member No.");
        UserSetUp.get(UserId);

        Loans.Init();

        Loans."No. Series" := MobileLnNoSeries."Mobile Loan Nos.";
        LoanNo := NoSeriesMgt.GetNextNo(Loans."No. Series");

        Loans."Loan No." := LoanNo;
        Loans."Mobile Loan" := true;
        Loans."Member No." := MobileLoanBuffer."Member No.";
        Loans."Member Name" := Members.Name;
        Loans."Interest Calculation Method" := ProductFactory."Interest Calculation Method";
        Loans."Loan Product Type" := LoanProdID;
        Loans."Loan Product Type Name" := ProductFactory."Product Description";
        Loans."Purpose of Loan" := MobileLoanBuffer."Loan Purpose";
        Loans."Loan Account" := LoansProcess.CreateLoanAccount(MobileLoanBuffer."Member No.", LoanProdID);
        Loans.Interest := ProductFactory."Interest Rate (Min.)";
        Loans."Loan Span" := ProductFactory."Loan Span";
        Loans."Application Date" := Today;
        Loans."Disbursement Date" := Today;
        Loans."Approved Amount" := MobileLoanBuffer.Amount;
        Loans."Staff No" := Members."Payroll/Staff No.";
        Loans."Requested Amount" := MobileLoanBuffer.Amount;
        Loans."Approved Amount" := MobileLoanBuffer.Amount;
        Loans."Disbursement Account No" := MobileLoanBuffer."Account No";
        Loans.Status := Loans.Status::Approved;
        Loans."Captured By" := UpperCase(UserId);
        Loans."Global Dimension 1 Code" := Members."Global Dimension 1 Code";
        Loans."Employer Code" := MobileLoanBuffer."Employer Code";
        Loans."ID No." := Members."Primary Identification";
        Loans."Global Dimension 2 Code" := Format(ProductFactory."Source Unit");
        Loans.Source := Loans.Source::BANKING;
        Loans."Recovery Mode" := ProductFactory."Repay Mode";
        Loans."Recovery Priority" := ProductFactory."Recovery Priority";
        Loans.Installments := ProductFactory."Ordinary Default Intallments";
        Loans."Repayment Frequency" := ProductFactory."Repayment Frequency";
        Loans."Source Aplication" := Loans."Source Aplication"::"Mbanking - APP";//dafault to app for reporting
        case
            Loans."Repayment Frequency" of
            Loans."Repayment Frequency"::Monthly:
                begin
                    Loans."Repayment Start Date" := CALCDATE('1M', Today);
                    InstallmentFrequency := 'M';
                    evaluate(InstallmentPeriod, '1M');
                end;
            Loans."Repayment Frequency"::Daily:
                begin
                    Loans."Repayment Start Date" := CALCDATE('1D', Today);
                    InstallmentFrequency := 'D';
                    Evaluate(InstallmentPeriod, '1D');
                end;
            Loans."Repayment Frequency"::Weekly:
                begin
                    Loans."Repayment Start Date" := CALCDATE('1W', Today);
                    InstallmentFrequency := 'W';
                    Evaluate(InstallmentPeriod, '1W');
                end;
            else begin
                Loans."Repayment Start Date" := CALCDATE('1M', Today);
                InstallmentFrequency := 'M';
                Evaluate(InstallmentPeriod, '1M');
            end;
        end;
        Loans."Expected Date of Completion" := CALCDATE(Format(Loans.Installments) + InstallmentFrequency, Loans."Repayment Start Date");
        Loans."Installment Period" := ProductFactory."Installment Repayment Interval";
        if Format(Loans."Installment Period") = '' then
            Loans."Installment Period" := InstallmentPeriod;

        if Loans."Purpose of Loan" <> '' then begin
            MobileLoanPurposes.Reset;
            MobileLoanPurposes.SetRange(Code, Loans."Purpose of Loan");

            MobileLoanPurposes.SetLoadFields(
                "Main Sector",
                "Sub Sector Level1",
                "Sub Sector Level2",
                "Main Sector Description",
                "Sub Sector Level1 Description",
                "Sub Sector Level2 Description"
            );

            if MobileLoanPurposes.FindFirst then begin
                Loans."Main Sector" := MobileLoanPurposes."Main Sector";
                Loans."Main Sector Description" := MobileLoanPurposes."Main Sector Description";
                Loans."Sub Sector Level1" := MobileLoanPurposes."Sub Sector Level1";
                Loans."Sub Sector Level1 Description" := MobileLoanPurposes."Sub Sector Level1 Description";
                Loans."Sub Sector Level2" := MobileLoanPurposes."Sub Sector Level2";
                Loans."Sub Sector Level2 Description" := MobileLoanPurposes."Sub Sector Level2 Description";
            end;
        end;
        if Loans."Main Sector" = '' then begin
            MobileLoanPurposes.Reset;
            MobileLoanPurposes.SetRange("Available On Mobile", true);

            MobileLoanPurposes.SetLoadFields(
                "Main Sector",
                "Sub Sector Level1",
                "Sub Sector Level2",
                "Main Sector Description",
                "Sub Sector Level1 Description",
                "Sub Sector Level2 Description"
            );

            if MobileLoanPurposes.FindFirst then begin
                Loans."Main Sector" := MobileLoanPurposes."Main Sector";
                Loans."Main Sector Description" := MobileLoanPurposes."Main Sector Description";
                Loans."Sub Sector Level1" := MobileLoanPurposes."Sub Sector Level1";
                Loans."Sub Sector Level1 Description" := MobileLoanPurposes."Sub Sector Level1 Description";
                Loans."Sub Sector Level2" := MobileLoanPurposes."Sub Sector Level2";
                Loans."Sub Sector Level2 Description" := MobileLoanPurposes."Sub Sector Level2 Description";
            end;
        end;

        Loans.Validate("Disbursement Date");
        Loans.Validate("Approved Amount");

        // Source Unit
        Loans."Source Unit" := ProductFactory."Source Unit";
        Loans."Compute Interest Due on Postin" := ProductFactory."Compute Interest Due on Postin";
        Loans."Loanee Message" := MobileLoanBuffer."Session ID";

        if Loans.Insert then begin
            MobileLoanBuffer."Loan No." := Loans."Loan No.";
            MobileLoanBuffer."Interest Recoverd Upfront" := ProductFactory."Interest Recovered Upfront";
            if ProductFactory."Mobile Min. Guarantors" > 0 then begin
                MobileLoanBuffer."Needs Guarantors" := true;
                MobileLoanBuffer."Expected Guarantors" := ProductFactory."Mobile Min. Guarantors";
            end;
            MobileLoanBuffer.Modify(true);
            exit(true);
        end else begin
            exit(false);
        end;
    end;

    procedure PostLoan(LoanNo: Code[50]; Template: Code[50]; Batch: Code[50]; SessionID: Text[50]; HasChargeType: boolean): Boolean
    var
        Loans: Record Loans;
        ProductFactory: Record "Product Factory";
        TotalInterest: Decimal;
        AccType: Enum "Gen. Journal Account Type";
        TransType: enum "Transaction Types";
        LineNo: Integer;
        JnlPosting: Codeunit "Journal Posting";
        Members: record Members;
        FosaAcc: code[50];
        DocNo: Text[20];
        GLEntry: Record "G/L Entry";
        MobileTransTypes: Record "Mobile Transaction Types";
        MobileTransLines: Record "Mobile Transaction Types Lines";
        TotalCharges: Decimal;
        genSetUp: Record "General Set-up";
        RemainingDays: Integer;
        DaysPast: Integer;
        EndMonth: Date;
        TMonthDays: Integer;
        Amt: Decimal;
        TransCharge: Record "Transaction Charges";
        PrCharges: Record "Loan Product Charges";
        BalAccType: Enum "Gen. Journal Account Type";
        AccNo: Code[20];
        BalAccNo: Code[20];
        TCharges: Decimal;
        PaySched: Record "Schedule of Loan Payment";
        PCharges: Record "Loan Product Charges";
        TotalComputedCharges: Decimal;
        TotalCleared: Decimal;
        OtherComms: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        ExcemptCharges: Boolean;
        Cust: Record Customer;
        LoanArr: record Loans;
        LoanII: record Loans;
        MaxAmt: Decimal;
        RunBal: Decimal;
        GenJournalLine: record "Gen. Journal Line";
        AmtDeducted: Decimal;
        loansProcess: Codeunit "Loans Process";
        SASRAarr: Decimal;
        AsAtDate: Date;
        ChargeStmtDesc: Text[100];
        LineChargeAmt: Decimal;
    begin
        Loans.get(LoanNo);
        Members.get(Loans."Member No.");
        ProductFactory.get(Loans."Loan Product Type");
        FosaAcc := GetMemberFosaAcc(Members);
        LineNo := 0;

        DocNo := CopyStr(SessionID, 1, 19);
        // DocNo := Loans."Loan No.";
        // Check if loan already posted
        GLEntry.Reset;
        GLEntry.SetRange("Document No.", DocNo);
        GLEntry.SetLoadFields("Entry No.");
        if GLEntry.FindFirst then begin
            Loans.Posted := true;
            Loans.Modify;
            exit(true);
        end;

        SaccoTrans.InitJournal(Template, Batch);
        // Debit Loan Account
        LineNo := 1000;
        JnlPosting.PostJournal(Template, Batch, LineNo, AccType::Credit, DocNo, 'Loan disbursement for ' + Loans."Loan No." + ' ' + format(Loans."Member No."), Loans."Approved Amount",
         Loans."Loan Account", Today, AccType::"G/L Account", '', LoanNo, Loans."Global Dimension 1 Code", Loans."Global Dimension 2 Code", TransType::Loan, LoanNo, '', '',
          "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

        // Credit Fosa Account
        LineNo += 1000;
        JnlPosting.PostJournal(Template, Batch, LineNo, AccType::Savings, DocNo, 'Loan disbursement for ' + Loans."Loan No." + ' ' + format(Loans."Member No."), -Loans."Approved Amount",
        FosaAcc, Today, AccType::"G/L Account", '', '', Loans."Global Dimension 1 Code", Loans."Global Dimension 2 Code", TransType::" ", '', '', '',
        "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

        Loans."Net Amount" := Loans."Approved Amount";
        //Loan Charges
        PCharges.Reset;
        PCharges.SetRange(PCharges."Product Code", Loans."Loan Product Type");
        PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::General);
        //PCharges.SetRange(PCharges."Charge Description", 'Posting Loan Interest.');
        if PCharges.FindSet then begin
            repeat
                //Non Prorate
                if PCharges.Prorate = PCharges.Prorate::" " then begin
                    LineNo := LineNo + 10000;

                    TransType := Transtype::" ";
                    AccType := Balacctype::Savings;
                    AccNo := FosaAcc;//Loans."Disbursement Account No";
                    BalAccType := Acctype::"G/L Account";
                    BalAccNo := PCharges."Charges G_L Account";
                    if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                        Amt := (Loans."Approved Amount" * (PCharges.Percentage / 100))
                    else
                        if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                            Amt := PCharges."Charge Amount"
                        else
                            if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin
                                PCharges.TestField(PCharges."Staggered Charge Code");
                                TariffDetails.Reset;
                                TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                if TariffDetails.FindSet then begin
                                    repeat
                                        if (Loans."Approved Amount" >= TariffDetails."Lower Limit") and (Loans."Approved Amount" <= TariffDetails."Upper Limit") then begin
                                            if TariffDetails."Use Percentage" = true then begin
                                                Amt := Loans."Approved Amount" * TariffDetails.Percentage * 0.01;
                                            end else begin
                                                Amt := TariffDetails."Charge Amount";
                                            end;
                                        end
                                    until TariffDetails.Next = 0;
                                end;
                            end;

                    if ExcemptCharges = true then
                        Amt := 0;

                    if amt > 0 then Loans."Net Amount" -= Amt;

                    SaccoTrans.JournalInsert(Template, Batch, DocNo, Today, AccType, AccNo, CopyStr((PCharges."Charge Description"), 1, 50), BalAccType, BalAccNo, Amt, DocNo, '', TransType::" ", Loans."Global Dimension 1 Code", Loans."Global Dimension 2 Code", true);


                    //If excise duty involved
                    if PCharges."Effect Excise Duty" = PCharges."effect excise duty"::Yes then begin
                        GenSetup.Get();
                        GenSetup.TestField("Excise Duty G/L");
                        GenSetup.TestField("Excise Duty (%)");
                        LineNo := LineNo + 10000;
                        AccType := Acctype::Savings;
                        AccNo := FosaAcc;
                        TransType := Transtype::" ";
                        BalAccType := Balacctype::"G/L Account";
                        BalAccNo := GenSetup."Excise Duty G/L";
                        Amt := Amt * GenSetup."Excise Duty (%)" * 0.01;

                        if amt > 0 then Loans."Net Amount" -= Amt;

                        SaccoTrans.JournalInsert(Template, Batch, DocNo, Today, AccType, AccNo, CopyStr((PCharges."Charge Description" + '-Excise Duty'), 1, 50), AccType::"G/L Account", BalAccNo, Amt, DocNo, '', TransType::" ", Loans."Global Dimension 1 Code", Loans."Global Dimension 2 Code", true);

                    end;
                end;
            until PCharges.Next = 0;
        end;
        //End of Charges
        if HasChargeType then begin
            // Loan disbursement charges here...

            genSetUp.get();
            MobileTransTypes.Reset;
            MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Loan Disbursement");
            if MobileTransTypes.FindFirst then begin
                MobileTransLines.Reset();
                MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);
                if MobileTransLines.FindSet then begin
                    TotalCharges := 0;
                    repeat begin
                        // LineNo += 1000;

                        SaccoTrans.JournalInsert(Template, Batch, DocNo, Today, MobileTransLines."Account Type", MobileTransLines."Account No.", MobileTransLines.Description, AccType::"G/L Account", '', -GetMpesaTransCharges(MobileTransLines, Loans."Approved Amount", FosaAcc, '').Get(4), DocNo, '', TransType::" ", Loans."Global Dimension 1 Code", Loans."Global Dimension 2 Code", true);
                        TotalCharges += GetMpesaTransCharges(MobileTransLines, Loans."Approved Amount", FosaAcc, '').Get(1);
                        if MobileTransLines."Recover Excise Duty" then
                            SaccoTrans.JournalInsert(Template, Batch, DocNo, Today, AccType::"G/L Account", genSetUp."Excise Duty G/L", 'Excise duty on loan disbursement charges', MobileTransLines."Account Type", ''/*MobileTransLines."Account No."*/, -GetMpesaTransCharges(MobileTransLines, Loans."Approved Amount", FosaAcc, '').Get(2), DocNo, '', TransType::" ", Loans."Global Dimension 1 Code", Loans."Global Dimension 2 Code", true);

                        // Itemise the member-statement (savings) side: one line per configured charge
                        ChargeStmtDesc := MobileTransLines.Description;
                        if ChargeStmtDesc = '' then
                            ChargeStmtDesc := MobileTransTypes.Description;
                        LineChargeAmt := GetMpesaTransCharges(MobileTransLines, Loans."Approved Amount", FosaAcc, '').Get(1);
                        if LineChargeAmt <> 0 then
                            SaccoTrans.JournalInsert(Template, Batch, DocNo, Today, AccType::Savings, FosaAcc, ChargeStmtDesc, AccType::"G/L Account", '', LineChargeAmt, DocNo, '', TransType::" ", Loans."Global Dimension 1 Code", Loans."Global Dimension 2 Code", true);
                    end until MobileTransLines.Next = 0;
                end;
            end;
        end;

        // if interest is upfront then post interest:
        if ProductFactory."Interest Recovered Upfront" then begin
            TotalInterest := CalculateUpfrontInterest(LoanNo);
            // post interest:
            LineNo += 1000;
            JnlPosting.PostJournal(Template, Batch, LineNo, AccType::Credit, DocNo, 'Upfront Interest Charged on ' + Loans."Loan No." + ' ' + format(Loans."Member No."), TotalInterest,
             Loans."Loan Account", Today, AccType::"G/L Account", ProductFactory."Loan Interest Account [G/L]", LoanNo, Loans."Global Dimension 1 Code", Loans."Global Dimension 2 Code", TransType::"Interest Due", LoanNo, '', '',
              "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

            // Recover Upfront interest
            LineNo += 1000;
            JnlPosting.PostJournal(Template, Batch, LineNo, AccType::credit, DocNo, 'Upfront Interest recovered on ' + Loans."Loan No." + ' ' + format(Loans."Member No."), -TotalInterest,
             Loans."Loan Account", Today, AccType::"G/L Account", '', LoanNo, Loans."Global Dimension 1 Code", Loans."Global Dimension 2 Code", TransType::"Interest Paid", LoanNo, '', '',
              "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

            LineNo += 1000;
            JnlPosting.PostJournal(Template, Batch, LineNo, AccType::Savings, DocNo, 'Upfront Interest recovered on ' + Loans."Loan No." + ' ' + format(Loans."Member No."), TotalInterest,
             FosaAcc, Today, AccType::"G/L Account", '', '', Loans."Global Dimension 1 Code", Loans."Global Dimension 2 Code", TransType::" ", LoanNo, '', '',
              "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

            Loans."Net Amount" -= TotalInterest;
        end;

        //Get if interest due is posted on disbursement from setups
        if ProductFactory.Get(Loans."Loan Product Type") then begin
            if ProductFactory."Compute Interest Due on Postin" = ProductFactory."compute interest due on postin"::"Full Interest" then begin
                Amt := 0;

                Amt := Loans."Approved Amount" * Loans.Interest / 12 * 0.01;
                LineNo += 1000;
                LineNo += 1000;
                JnlPosting.PostJournal(Template, Batch, LineNo, AccType::Credit, DocNo, 'Upfront Interest Charged on ' + Loans."Loan No." + ' ' + format(Loans."Member No."), Amt,
                 Loans."Loan Account", Today, AccType::"G/L Account", ProductFactory."Loan Interest Account [G/L]", LoanNo, Loans."Global Dimension 1 Code", Loans."Global Dimension 2 Code", TransType::"Interest Due", Loans."Loan No.", '', '',
                  "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
            end else
                if ProductFactory."Compute Interest Due on Postin" = ProductFactory."compute interest due on postin"::"Pro-rata" then begin
                    //PRORATED DAYS
                    EndMonth := CalcDate('-1D', CalcDate('1M', Dmy2date(1, Date2dmy(Today, 2), Date2dmy(Today, 3))));
                    RemainingDays := DaysPast + (EndMonth - Today) + 1;
                    TMonthDays := Date2dmy(EndMonth, 1);
                    Amt := 0;

                    Amt := Loans."Approved Amount" * Loans.Interest / 12 * 0.01 * RemainingDays / TMonthDays;
                    LineNo += 1000;
                    JnlPosting.PostJournal(Template, Batch, LineNo, AccType::Credit, DocNo, 'Upfront Interest Charged on ' + Loans."Loan No." + ' ' + format(Loans."Member No."), Amt,
                     Loans."Loan Account", Today, AccType::"G/L Account", ProductFactory."Loan Interest Account [G/L]", LoanNo, Loans."Global Dimension 1 Code", Loans."Global Dimension 2 Code", TransType::"Interest Due", Loans."Loan No.", '', '',
                      "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                end
                ELSE
                    IF ProductFactory."Compute Interest Due on Postin" = ProductFactory."Compute Interest Due on Postin"::"Full Period Interest" THEN BEGIN
                        Amt := 0;
                        Amt := Loans."Approved Amount" * loans.Interest / 12 * 0.01 * Loans.Installments;
                        LineNo += 1000;
                        JnlPosting.PostJournal(Template, Batch, LineNo, AccType::Credit, DocNo, 'Upfront Interest Charged on ' + Loans."Loan No." + ' ' + format(Loans."Member No."), Amt,
                         Loans."Loan Account", Today, AccType::"G/L Account", ProductFactory."Loan Interest Account [G/L]", LoanNo, Loans."Global Dimension 1 Code", Loans."Global Dimension 2 Code", TransType::"Interest Due", Loans."Loan No.", '', '',
                          "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                    END;
        end;
        if ProductFactory."Type of Discounting" = ProductFactory."Type of Discounting"::"Dividend Discounting" then begin
            // update & recover loan arrears as at date 7 from beginning of month.
            // if Date2DMY(Today, 1) >= 8 then
            //     AsAtDate := calcdate('-CM', Today) + 6
            // else
            AsAtDate := Today;

            LoanII.Reset();
            LoanII.SetRange("Member No.", Members."No.");
            LoanII.CalcFields("Total Balance");
            LoanII.SetFilter("Total Balance", '>0');
            if LoanII.FindSet() then begin
                repeat
                    loansProcess.CalculateLoanArrears(LoanII, SASRAarr, SASRAarr, AsAtDate, true);
                until LoanII.next = 0;
            end;

            RunBal := Loans."Net Amount";
            // LoanII.Reset();
            // LoanII.SetRange("Member No.", Members."No.");
            // LoanII.SetRange("Loan Product Type", Loans."Loan Product Type");
            // LoanII.setfilter("Disbursement Date", '%1..%2', calcdate('-CY', Today), Today);
            // if not LoanII.findfirst() then begin
            LoanArr.Reset();
            LoanArr.setRange("Member No.", Loans."Member No.");
            // LoanArr.SetCurrentKey("Disbursement Date");
            // LoanArr.SetAscending("Disbursement Date", true);
            LoanArr.SetFilter("Loan Product Type", '<>FGL&<>BGL');
            //LoanArr.CalcFields("Loans Category-SASRA");
            //LoanArr.SetFilter("Loans Category-SASRA", '<>%1', LoanArr."Loans Category-SASRA"::Perfoming);
            LoanArr.CalcFields("Total Balance", "Amount In Arreas SASRA");
            LoanArr.SetFilter("Total Balance", '>0');
            LoanArr.setfilter("Amount In Arreas SASRA", '>500');
            if LoanArr.findset() then begin
                repeat
                    MaxAmt := 0;
                    AmtDeducted := 0;
                    LoanArr.CalcFields("Outstanding Balance", "Outstanding Interest", "Amount In Arreas SASRA");
                    MaxAmt := LoanArr."Amount In Arreas SASRA";
                    if RunBal > 0 then begin
                        if RunBal <= MaxAmt then begin
                            if (LoanArr."Outstanding Interest") > 0 then begin
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Template;
                                GenJournalLine."Journal Batch Name" := Batch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine."Document No." := DocNo;
                                GenJournalLine."External Document No." := Loans."Loan No.";
                                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Credit;
                                GenJournalLine.Validate(GenJournalLine."Account No.", LoanArr."Loan Account");
                                GenJournalLine.Description := PadStr('Loan arrears recovery from:-' + Loans."Loan No." + '-' +
                                                             Format(GenJournalLine."transaction type"::"Interest Paid"), 50);


                                if LoanArr."Outstanding Interest" >= RunBal then begin
                                    GenJournalLine.Amount := RunBal * -1;
                                    AmtDeducted += RunBal;
                                    RunBal := 0;
                                end
                                else begin
                                    GenJournalLine.Amount := LoanArr."Outstanding Interest" * -1;
                                    RunBal -= Abs(LoanArr."Outstanding Interest");
                                    AmtDeducted += Abs(LoanArr."Outstanding Interest");
                                end;
                                GenJournalLine.validate(Amount);
                                GenJournalLine.Validate(GenJournalLine."Loan No", LoanArr."Loan No.");
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", Loans."Global Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", Loans."Global Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                            end;

                            if (LoanArr."Outstanding Balance" > 0) then begin
                                if RunBal > 0 then begin
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Template;
                                    GenJournalLine."Journal Batch Name" := Batch;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine."Document No." := DocNo;
                                    GenJournalLine."External Document No." := Loans."Loan No.";
                                    GenJournalLine."Account Type" := GenJournalLine."Account Type"::Credit;
                                    GenJournalLine.Validate(GenJournalLine."Account No.", LoanArr."Loan Account");
                                    GenJournalLine.Description := PadStr('Loan Arrears recovery from :-' + Loans."Loan No." + '-' +
                                                                 Format(GenJournalLine."transaction type"::Repayment), 50);

                                    if LoanArr."Outstanding Balance" >= RunBal then begin
                                        GenJournalLine.Amount := RunBal * -1;
                                        AmtDeducted += RunBal;
                                        RunBal := 0;
                                    end
                                    else begin
                                        GenJournalLine.Amount := LoanArr."Outstanding Balance" * -1;
                                        RunBal -= Abs(LoanArr."Outstanding Balance");
                                        AmtDeducted += Abs(LoanArr."Outstanding Balance");
                                    end;
                                    GenJournalLine.validate(Amount);
                                    GenJournalLine.Validate(GenJournalLine."Loan No", LoanArr."Loan No.");
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", Loans."Global Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", Loans."Global Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;
                            end;
                        end
                        else begin
                            LoanArr.CalcFields("Total Balance", "Outstanding Balance", "Outstanding Interest");
                            if LoanArr."Total Balance" > 0 then begin
                                if (LoanArr."Outstanding Interest") > 0 then begin
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Template;
                                    GenJournalLine."Journal Batch Name" := Batch;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine."Document No." := DocNo;
                                    GenJournalLine."External Document No." := Loans."Loan No.";
                                    GenJournalLine."Account Type" := GenJournalLine."Account Type"::Credit;
                                    GenJournalLine.Validate(GenJournalLine."Account No.", LoanArr."Loan Account");
                                    GenJournalLine.Description := PadStr('Loan Arrears recovery from :-' + Loans."Loan No." + '-' +
                                                                 Format(GenJournalLine."transaction type"::"Interest Paid"), 50);

                                    if LoanArr."Outstanding Interest" >= MaxAmt then begin
                                        GenJournalLine.Amount := MaxAmt * -1;
                                        AmtDeducted += MaxAmt;
                                        RunBal -= MaxAmt;
                                        MaxAmt := 0;
                                    end
                                    else begin
                                        GenJournalLine.Amount := LoanArr."Outstanding Interest" * -1;
                                        RunBal -= Abs(LoanArr."Outstanding Interest");
                                        AmtDeducted += Abs(LoanArr."Outstanding Interest");
                                        MaxAmt -= Abs(LoanArr."Outstanding Interest");
                                    end;
                                    GenJournalLine.Validate(Amount);
                                    GenJournalLine.Validate(GenJournalLine."Loan No", LoanArr."Loan No.");
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", Loans."Global Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", Loans."Global Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;

                                if (LoanArr."Outstanding Balance" > 0) then begin
                                    if RunBal > 0 then begin
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := Template;
                                        GenJournalLine."Journal Batch Name" := Batch;
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine."Document No." := DocNo;
                                        GenJournalLine."External Document No." := Loans."Loan No.";
                                        GenJournalLine."Account Type" := genjournalline."Account Type"::Credit;
                                        GenJournalLine.Validate(GenJournalLine."Account No.", LoanArr."Loan Account");
                                        GenJournalLine.Description := PadStr('Loan Arrears recovery from :-' + Loans."Loan No." + '-' +
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
                                        if LoanArr."Outstanding Balance" >= MaxAmt then begin
                                            GenJournalLine.Amount := MaxAmt * -1;
                                            AmtDeducted += MaxAmt;
                                            RunBal -= MaxAmt;
                                            MaxAmt := 0;
                                        end
                                        else begin
                                            GenJournalLine.Amount := LoanArr."Outstanding Balance" * -1;
                                            RunBal -= Abs(LoanArr."Outstanding Balance");
                                            AmtDeducted += Abs(LoanArr."Outstanding Balance");
                                            MaxAmt -= Abs(LoanArr."Outstanding Balance");
                                        end;
                                        GenJournalLine.Validate(Amount);
                                        GenJournalLine.Validate(GenJournalLine."Loan No", LoanArr."Loan No.");
                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Repayment;
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", Loans."Global Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", Loans."Global Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                    end;
                                end;
                            end;
                        end;
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := Template;
                        GenJournalLine."Journal Batch Name" := Batch;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Document No." := DocNo;
                        GenJournalLine."External Document No." := loans."Loan No.";
                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Savings;
                        GenJournalLine.Validate(GenJournalLine."Account No.", FosaAcc);
                        //GenJournalLine.Description:='Source:-'+STOHead."Source Account Name";
                        GenJournalLine.Description := PadStr('Arrears recovery for ' + loanArr."Loan No.", 50);
                        GenJournalLine.Validate(GenJournalLine.Amount, AmtDeducted);
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", Loans."Global Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", Loans."Global Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    end;
                until LoanArr.next = 0;
            end;
            //end;

        end;

        if SaccoTrans.PostJournal(Template, Batch) then begin
            Loans.Posted := true;
            Loans.Modify;
            exit(true);
        end
        else begin
            GLEntry.Reset;
            GLEntry.SetRange("Document No.", DocNo);
            GLEntry.SetLoadFields("Entry No.");
            if GLEntry.FindFirst then begin
                Loans.Posted := true;
                Loans.Modify;
                exit(true);
            end;
            exit(false);
        end;
    end;

    procedure PostLoan2(LoanNo: Code[50]; Template: Code[50]; Batch: Code[50]; SessionID: Text[50]; HasChargeType: boolean): Boolean
    var
        Loans: Record Loans;
        ProductFactory: Record "Product Factory";
        TotalInterest: Decimal;
        AccType: Enum "Gen. Journal Account Type";
        TransType: enum "Transaction Types";
        LineNo: Integer;
        JnlPosting: Codeunit "Journal Posting";
        Members: record Members;
        FosaAcc: code[50];
        DocNo: Text[20];
        GLEntry: Record "G/L Entry";
        MobileTransTypes: Record "Mobile Transaction Types";
        MobileTransLines: Record "Mobile Transaction Types Lines";
        TotalCharges: Decimal;
        genSetUp: Record "General Set-up";
        RemainingDays: Integer;
        DaysPast: Integer;
        EndMonth: Date;
        TMonthDays: Integer;
        Amt: Decimal;
        TransCharge: Record "Transaction Charges";
        PrCharges: Record "Loan Product Charges";
        BalAccType: Enum "Gen. Journal Account Type";
        AccNo: Code[20];
        BalAccNo: Code[20];
        TCharges: Decimal;
        PaySched: Record "Schedule of Loan Payment";
        PCharges: Record "Loan Product Charges";
        TotalComputedCharges: Decimal;
        TotalCleared: Decimal;
        OtherComms: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        ExcemptCharges: Boolean;
        Cust: Record Customer;
        LoansProcess: Codeunit "Loans Process";

        LoansToBeCleared: Record "Loans Top up";
        LnTopUp: Record Loans;
        ChargeStmtDesc: Text[100];
        LineChargeAmt: Decimal;
    begin
        Loans.get(LoanNo);
        Members.get(Loans."Member No.");
        ProductFactory.get(Loans."Loan Product Type");
        FosaAcc := GetMemberFosaAcc(Members);
        LineNo := 0;

        DocNo := LoanNo;
        // DocNo := Loans."Loan No.";
        // Check if loan already posted
        GLEntry.Reset;
        GLEntry.SetRange("Document No.", DocNo);
        GLEntry.SetLoadFields("Entry No.");
        if GLEntry.FindFirst then begin
            Loans.Posted := true;
            Loans.Modify;
            exit(true);
        end;

        // Clear zero balance topups
        LoansToBeCleared.Reset;
        LoansToBeCleared.SetRange("Loan No.", Loans."Loan No.");
        LoansToBeCleared.SetLoadFields("Loan Top Up");
        if LoansToBeCleared.FindSet then begin
            repeat begin
                LnTopUp.Reset;
                LnTopUp.SetRange("Loan No.", LoansToBeCleared."Loan Top Up");
                LnTopUp.SetLoadFields("Total Loan Balance");
                LnTopUp.SetAutoCalcFields("Total Loan Balance");
                if LnTopUp.FindFirst then begin
                    if LnTopUp."Total Loan Balance" <= 0 then begin
                        LoansToBeCleared.Delete;
                    end;
                end;

            end until LoansToBeCleared.Next = 0;
        end;

        LoansProcess.PostLoanNormal(LoanNo);

        GLEntry.Reset;
        GLEntry.SetRange("Document No.", DocNo);
        GLEntry.SetLoadFields("Entry No.");
        if GLEntry.FindFirst then begin
            // Only post charges after loan is disbursed
            SaccoTrans.InitJournal(Template, Batch);
            //End of Charges
            if HasChargeType then begin
                // Loan disbursement charges here...

                genSetUp.get();
                MobileTransTypes.Reset;
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Loan Disbursement");
                if MobileTransTypes.FindFirst then begin
                    MobileTransLines.Reset();
                    MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);
                    if MobileTransLines.FindSet then begin
                        TotalCharges := 0;
                        repeat begin
                            // LineNo += 1000;

                            SaccoTrans.JournalInsert(Template, Batch, DocNo, Today, MobileTransLines."Account Type", MobileTransLines."Account No.", MobileTransLines.Description, AccType::"G/L Account", '', -(GetMpesaTransCharges(MobileTransLines, Loans."Approved Amount", FosaAcc, '').Get(1) - GetMpesaTransCharges(MobileTransLines, Loans."Approved Amount", FosaAcc, '').Get(2)), DocNo, '', TransType::" ", Loans."Global Dimension 1 Code", Loans."Global Dimension 2 Code", true);
                            TotalCharges += GetMpesaTransCharges(MobileTransLines, Loans."Approved Amount", FosaAcc, '').Get(1);
                            if MobileTransLines."Recover Excise Duty" then
                                SaccoTrans.JournalInsert(Template, Batch, DocNo, Today, AccType::"G/L Account", genSetUp."Excise Duty G/L", 'Excise duty on loan disbursement charges', MobileTransLines."Account Type", ''/*MobileTransLines."Account No."*/, -GetMpesaTransCharges(MobileTransLines, Loans."Approved Amount", FosaAcc, '').Get(2), DocNo, '', TransType::" ", Loans."Global Dimension 1 Code", Loans."Global Dimension 2 Code", true);

                            // Itemise the member-statement (savings) side: one line per configured charge
                            ChargeStmtDesc := MobileTransLines.Description;
                            if ChargeStmtDesc = '' then
                                ChargeStmtDesc := MobileTransTypes.Description;
                            LineChargeAmt := GetMpesaTransCharges(MobileTransLines, Loans."Approved Amount", FosaAcc, '').Get(1);
                            if LineChargeAmt <> 0 then
                                SaccoTrans.JournalInsert(Template, Batch, DocNo, Today, AccType::Savings, FosaAcc, ChargeStmtDesc, AccType::"G/L Account", '', LineChargeAmt, DocNo, '', TransType::" ", Loans."Global Dimension 1 Code", Loans."Global Dimension 2 Code", true);
                        end until MobileTransLines.Next = 0;
                    end;
                end;
            end;

            if SaccoTrans.PostJournal(Template, Batch) then begin
                // Refresh: PostLoanNormal already modified this record.
                Loans.Get(LoanNo);
                Loans.Posted := true;
                Loans.Modify;
                exit(true);
            end else begin
                GLEntry.Reset;
                GLEntry.SetRange("Document No.", DocNo);
                GLEntry.SetLoadFields("Entry No.");
                if GLEntry.FindFirst then begin
                    Loans.Get(LoanNo);
                    Loans.Posted := true;
                    Loans.Modify;
                    exit(true);
                end;
                exit(false);
            end;

        end else begin
            exit(false);
        end;

        // if SaccoTrans.PostJournal(Template, Batch) then begin
        //     Loans.Posted := true;
        //     Loans.Modify;
        //     exit(true);
        // end
        // else begin
        //     GLEntry.Reset;
        //     GLEntry.SetRange("Document No.", DocNo);
        //     GLEntry.SetLoadFields("Entry No.");
        //     if GLEntry.FindFirst then begin
        //         Loans.Posted := true;
        //         Loans.Modify;
        //         exit(true);
        //     end;
        //     exit(false);
        // end;
    end;

    procedure CalculateUpfrontInterest(LoanNo: code[50]): Decimal
    var
        ProductFactory: Record "Product Factory";
        MonthlyRepayment: Decimal;
        Loan: record Loans;
        TotalInterest: Decimal;
        LoanInstallments: Integer;
        upfrontrate: Decimal;
        LoanAvailability: Record "Loan Product Availability";
        CurrentMonthInt: Integer;
        CurrentMonthEnum: Enum "Loan Month";
    begin
        Loan.get(LoanNo);
        ProductFactory.get(Loan."Loan Product Type");
        Loan.TestField(Interest);
        Loan.TestField(Installments);

        LoanInstallments := Loan.Installments;
        //
        case Loan."Interest Calculation Method" of
            Loan."Interest Calculation Method"::Amortised:
                begin
                    repeat
                        MonthlyRepayment := Round((Loan.Interest / 12 / 100) / (1 - Power((1 + (loan.Interest / 12 / 100)), -(Loan.Installments))) * (Loan."Approved Amount"), 1, '>');
                        TotalInterest += Round((MonthlyRepayment * Loan.Installments) - Loan."Approved Amount", 0.01, '>');
                        LoanInstallments -= 1;
                    until LoanInstallments = 0;
                    exit(TotalInterest);
                end;
            // Reducing Balance and Reducing Flat will be calculated the same way due to same Principal amount
            // Loan."Interest Calculation Method"::"Straight Line", Loan."Interest Calculation Method"::"Reducing Balance", Loan."Interest Calculation Method"::"Reducing Flat":
            //     begin
            //         CalculateUpfrontInterestReducing(LoanNo);
            //     end;

            //see if this will work

            Loan."Interest Calculation Method"::"Straight Line", Loan."Interest Calculation Method"::"Reducing Balance", Loan."Interest Calculation Method"::"Reducing Flat":
                begin
                    repeat
                        ProductFactory.Get(Loan."Loan Product Type");
                        upfrontrate := ProductFactory."Upfront Interest Rate";

                        if ProductFactory."IsAvailableInMonth" then begin
                            CurrentMonthInt := Date2DMY(Today(), 2);
                            Evaluate(CurrentMonthEnum, Format(CurrentMonthInt));

                            LoanAvailability.Reset();
                            LoanAvailability.SetRange("Loan Product Code", Loan."Loan Product Type");
                            LoanAvailability.SetRange(Month, CurrentMonthEnum);
                            if LoanAvailability.FindFirst() then
                                upfrontrate := LoanAvailability."Upfront Interest Rate";
                        end;

                        if upfrontrate <> 0 then begin
                            TotalInterest += Round(((upfrontrate / 100) * Loan."Approved Amount"), 0.01, '>');
                            LoanInstallments -= 1;
                        end else begin
                            TotalInterest += Round(((Loan.Interest / 100) * Loan."Approved Amount"), 0.01, '>');
                            LoanInstallments -= 1;
                        end;

                    until LoanInstallments = 0;
                    exit(TotalInterest);
                end;
        // end of see if this will work
        // Loan."Interest Calculation Method"::"Straight Line", Loan."Interest Calculation Method"::"Reducing Balance", Loan."Interest Calculation Method"::"Reducing Flat":
        //     begin
        //         repeat
        //             TotalInterest += Round(((Loan.Interest / 100) * Loan."Approved Amount"), 0.01, '>');
        //             LoanInstallments -= 1;
        //         until LoanInstallments = 0;
        //         exit(TotalInterest);
        //     end;
        end;
    end;
    //other one
    procedure CalculateUpfrontInterestReducing(LoanNo: Code[50]): Decimal
    var
        ProductFactory: Record "Product Factory";
        MonthlyRepayment: Decimal;
        Loan: Record Loans;
        TotalInterest: Decimal;
        LoanInstallments: Integer;
        RemainingPrincipal: Decimal;
        UpfrontInterest: Decimal;
        MonthlyInterest: Decimal;
        upfrontrate: Decimal;
    begin
        Loan.Get(LoanNo);
        ProductFactory.Get(Loan."Loan Product Type");
        upfrontrate := ProductFactory."Upfront Interest Rate";
        Loan.TestField(Interest);
        Loan.TestField(Installments);

        LoanInstallments := Loan.Installments;

        // Step 1: Calculate 10% upfront interest
        UpfrontInterest := Round((upfrontrate / 100) * Loan."Approved Amount", 0.01, '>');

        // Step 2: Deduct upfront interest and set remaining principal
        RemainingPrincipal := Loan."Approved Amount" - UpfrontInterest;

        // Add upfront interest to total
        TotalInterest := UpfrontInterest;

        // Step 3: Apply 14% monthly interest on reducing balance
        if Loan."Interest Calculation Method" in [Loan."Interest Calculation Method"::"Reducing Balance", Loan."Interest Calculation Method"::"Reducing Flat"] then begin
            repeat
                // Calculate monthly interest on remaining principal
                MonthlyInterest := Round((Loan.Interest / 100 / 12) * RemainingPrincipal, 0.01, '>');
                TotalInterest += MonthlyInterest;

                // Deduct principal portion (assuming equal installment payments)
                RemainingPrincipal := RemainingPrincipal - (Loan."Approved Amount" / Loan.Installments);

                LoanInstallments -= 1;
            until LoanInstallments = 0;
        end;

        exit(TotalInterest);
    end;

    //
    // get All prerequisites for loan application
    //1. general setup and excise duty
    procedure CheckGenSetupAndExciseDuty(): Boolean
    var
        GenSetUp: Record "General Set-up";
    begin
        if not GenSetUp.get then
            exit(false)
        else begin
            if GenSetUp."Excise Duty G/L" = '' then
                exit(false)
            else
                exit(true);
        end;
    end;

    procedure GetNumberOfGuarantors(ProductID: Code[30]; AppliedAmount: Decimal) Guarantors: Decimal
    var
        MobileGuarantorsSetup: Record "Mobile Guarantors Setup";
        ProductFactory: Record "Product Factory";
    begin
        MobileGuarantorsSetup.Reset;
        MobileGuarantorsSetup.SetRange("Product Code", ProductID);
        MobileGuarantorsSetup.SetFilter("Lower Limit", '<%1', AppliedAmount);
        MobileGuarantorsSetup.SetFilter("Upper Limit", '>=%1', AppliedAmount);
        if MobileGuarantorsSetup.FindFirst then
            Guarantors := MobileGuarantorsSetup."No. of Guarantors"
        else begin
            if ProductFactory.Get(ProductID) then begin
                Guarantors := ProductFactory."Mobile Max. Guarantors";
            end;
        end;
    end;

    procedure AddRemoveMobileLoanGuarantor(LoanNo: Text; MobileNo: Code[20]; "Action": Code[20]) ResponseObject: JsonObject
    var
        SkyMobileLoans: Record "Mobile loan App. Buffer";
        TheGuarantor: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        LoanType: Record "Product Factory";
        MobileLoanGuarantors: Record "Mobile Loan Guarantors";
        RemGuar: Integer;
        SavAcc: Record "Savings Accounts";
        msg: Text;
        Loans: Record Loans;
        LoanG: Record "Loan Guarantors and Security";
        DepAc: Code[20];
        successText: Text;

        Datum: JsonObject;
    begin

        MobileNo := GetGuarantorMobileNo(MobileNo);

        if StrLen(MobileNo) <> 13 then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Invalid phone No.');
            ResponseObject.Add('response_payload', Datum);
            exit;
        end;


        TheGuarantor.Reset;
        TheGuarantor.SetFilter("Phone No.", '*' + MobileNo);
        if TheGuarantor.FindFirst then begin
            /*
            IF Members.Status<>Members.Status::Active THEN BEGIN
                Return := 'ERROR::::1.'+Members.Name+' is not qualified to Guarantee';
                EXIT;
            END;


            Loans.RESET;
            Loans.SETRANGE("Member No.",Members."No.");
            Loans.SETFILTER("Outstanding Balance",'>0');
            Loans.SETFILTER("Loans Category-SASRA",'<>%1&<>%2',Loans."Loans Category-SASRA"::Perfoming,Loans."Loans Category-SASRA"::Watch);
            IF Loans.FINDFIRST THEN BEGIN
                Return := 'ERROR::::2.'+Members.Name+' is not qualified to Guarantee';
                EXIT;
            END;


            LoanG.RESET;
            LoanG.SETRANGE("Member No",Members."No.");
            LoanG.SETFILTER("Outstanding Balance",'>0');
            LoanG.SETRANGE("Self Guarantee",FALSE);
            IF LoanG.FINDFIRST THEN BEGIN
                IF LoanG.COUNT > 20  THEN BEGIN
                    Return := 'ERROR::::3.'+Members.Name+' is not qualified to Guarantee';
                    EXIT;
                END;
            END;



            LoanG.RESET;
            LoanG.SETRANGE("Member No",Members."No.");
            LoanG.SETFILTER("Outstanding Balance",'>0');
            LoanG.SETRANGE("Self Guarantee",TRUE);
            IF LoanG.FINDFIRST THEN BEGIN
                Return := 'ERROR::::4.'+Members.Name+' is not qualified to Guarantee';
                EXIT;
            END;
            */


        end
        else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member NOT found');
            ResponseObject.Add('response_payload', Datum);
            exit;
        end;

        SkyMobileLoans.SetRange("Loan No.", LoanNo);

        if SkyMobileLoans.FindFirst then begin
            LoanType.Get(SkyMobileLoans."Loan Product Type");
            HMember.Get(SkyMobileLoans."Member No.");

            if Action = 'DISCARD' then begin
                msg := 'Dear member, Your ' + LoanType."USSD Product Name" + ' request has been cancelled.';
                SkyMobileLoans.Remarks := 'Loan Discarded';
                SkyMobileLoans.Status := SkyMobileLoans.Status::Failed;
                SkyMobileLoans.Posted := true;
                SkyMobileLoans."Date Posted" := CurrentDatetime;//TODAY;
                SkyMobileLoans."Message Text" := msg;
                SendSMS.SendSms(SMSSource::MBANKING, SkyMobileLoans."Telephone No", msg, Format(SkyMobileLoans."Entry No"), '', true, 220, false, 'CBS', Format(SkyMobileLoans."Entry No"), 'CBS');
                SkyMobileLoans.Modify;

                ResponseObject.Add('request_status', 'SUCCESS');
                Datum.Add('message', 'Request is successful');
                ResponseObject.Add('response_payload', Datum);
                exit;

                exit;
            end;
            if SkyMobileLoans."Member No." = TheGuarantor."No." then begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'You are not allowed to guarantee your own loan');
                ResponseObject.Add('response_payload', Datum);
                exit;
            end;

            DepAc := '';
            if LoanType."Minimum Guarantor Deposits" > 0 then begin
                SavAcc.Reset;
                SavAcc.SetRange("Member No.", TheGuarantor."No.");
                SavAcc.SetRange("Product Category", SavAcc."Product Category"::"BOSA Deposits");
                if SavAcc.FindFirst then begin
                    SavAcc.CalcFields("Balance (LCY)");
                    if SavAcc."Balance (LCY)" < LoanType."Minimum Guarantor Deposits" then begin
                        ResponseObject.Add('request_status', 'ERROR');
                        Datum.Add('error_message', TheGuarantor.Name + ' is not qualified to Guarantee');
                        ResponseObject.Add('response_payload', Datum);
                        exit;
                    end;
                    DepAc := SavAcc."No.";
                end;

                if DepAc = '' then begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', TheGuarantor.Name + ' is not qualified to Guarantee');
                    ResponseObject.Add('response_payload', Datum);
                    exit;
                end;
            end;


            successText := 'Your Request to add ' + TheGuarantor.Name + ' has been received successfully';

            MobileLoanGuarantors.Reset;
            MobileLoanGuarantors.SetRange("Loan Entry No.", SkyMobileLoans."Entry No");
            MobileLoanGuarantors.SetRange("Guarantor Member No.", TheGuarantor."No.");
            if MobileLoanGuarantors.FindFirst then begin
                if Action = 'REMOVE' then begin
                    MobileLoanGuarantors.Delete;

                    ResponseObject.Add('request_status', 'SUCCESS');
                    Datum.Add('message', 'Your Request to Remove ' + TheGuarantor.Name + ' has been received successfully');
                    ResponseObject.Add('response_payload', Datum);

                    msg := 'Dear member, You have removed ' + MobileLoanGuarantors."Guarantor Name" +
                        ' from your guarantorship request on ' + SkyMobileLoans."Loan Name" + ' loan amounting to KES ' + Format(SkyMobileLoans.Amount) + ' on ' + Format(Today) + ' ' + Format(Time) +
                        'REF: ' + Format(SkyMobileLoans."Loan No.");
                    SendSMS.SendSms(SMSSource::MBANKING, HMember."Phone No.", msg, Format(HMember."No."), '', true, 220, false, 'CBS', HMember."No.", 'CBS');


                    msg := 'Dear ' + Format(MobileLoanGuarantors."Guarantor Name") + ',' + HMember.Name +
                    ' has cancelled your guarantorship request on ' + SkyMobileLoans."Loan Name" + ' loan amounting to KES ' + Format(SkyMobileLoans.Amount) + ' on ' + Format(Today) + ' ' + Format(Time) +
                    ' Please Accept/Decline By dialing *839#. REF: ' + Format(SkyMobileLoans."Loan No.");
                    SendSMS.SendSms(SMSSource::MBANKING, MobileLoanGuarantors."Guarantor Mobile No.", msg, Format(HMember."No."), '', true, 220, false, 'CBS', HMember."No.", 'CBS');


                end
                else
                    if Action = 'ADD' then begin
                        MobileLoanGuarantors."Loan Entry No." := SkyMobileLoans."Entry No";
                        MobileLoanGuarantors."Guarantor Mobile No." := MobileNo;
                        MobileLoanGuarantors."Guarantor Dep. A/C" := DepAc;
                        MobileLoanGuarantors.Validate("Guarantor Member No.", TheGuarantor."No.");
                        MobileLoanGuarantors."Loan Product" := SkyMobileLoans."Loan Product Type";
                        MobileLoanGuarantors."Loan Product Name" := '';
                        MobileLoanGuarantors."Guarantor Name" := TheGuarantor.Name;
                        MobileLoanGuarantors."Date Created" := CurrentDatetime;
                        MobileLoanGuarantors.Modify;

                        if MobileLoanGuarantors."Guarantor Accepted" = MobileLoanGuarantors."guarantor accepted"::Pending then begin
                            ResponseObject.Add('request_status', 'SUCCESS');
                            Datum.Add('message', successText);
                            ResponseObject.Add('response_payload', Datum);
                        end;
                        if MobileLoanGuarantors."Guarantor Accepted" = MobileLoanGuarantors."guarantor accepted"::No then begin
                            MobileLoanGuarantors."Guarantor Accepted" := MobileLoanGuarantors."guarantor accepted"::Pending;
                            MobileLoanGuarantors.Modify;
                            ResponseObject.Add('request_status', 'SUCCESS');
                            Datum.Add('message', successText);
                            ResponseObject.Add('response_payload', Datum);
                        end;
                        if MobileLoanGuarantors."Guarantor Accepted" = MobileLoanGuarantors."guarantor accepted"::Yes then begin
                            ResponseObject.Add('request_status', 'SUCCESS');
                            Datum.Add('message', successText);
                            ResponseObject.Add('response_payload', Datum);
                        end;



                        msg := 'Dear member, You have Requested ' + MobileLoanGuarantors."Guarantor Name" +
                            ' to be your Guarantor on ' + SkyMobileLoans."Loan Name" + ' amounting to KES ' + Format(SkyMobileLoans.Amount) + ' on ' + Format(Today) + ' ' + Format(Time) +
                            ' Please notify them to Accept By dialing *839#. REF: ' + Format(SkyMobileLoans."Loan No.");
                        SendSMS.SendSms(SMSSource::MBANKING, HMember."Phone No.", msg, SkyMobileLoans."Loan No.", '', true, 220, false, 'CBS', HMember."No.", 'CBS');



                        msg := 'Dear member, ' + SkyMobileLoans."Account Name" +
                        ' is Requesting your Guarantorship on ' + SkyMobileLoans."Loan Name" + ' amounting to KES ' + Format(SkyMobileLoans.Amount) + ' on ' + Format(Today) + ' ' + Format(Time) +
                        ' Please Accept by dialing *839#, Select Loans Option. REF: ' + Format(SkyMobileLoans."Entry No");
                        SendSMS.SendSms(SMSSource::MBANKING, MobileLoanGuarantors."Guarantor Mobile No.", msg, SkyMobileLoans."Loan No.", '', true, 220, false, 'CBS', HMember."No.", 'CBS');
                    end;
            end
            else begin
                MobileLoanGuarantors.Init;
                MobileLoanGuarantors."Loan Entry No." := SkyMobileLoans."Entry No";
                MobileLoanGuarantors."Guarantor Mobile No." := MobileNo;
                MobileLoanGuarantors.Validate("Guarantor Member No.", HMember."No.");
                MobileLoanGuarantors."Loan Product" := SkyMobileLoans."Loan Product Type";
                MobileLoanGuarantors."Loan Product Name" := '';
                MobileLoanGuarantors."Guarantor Name" := HMember."First Name" + ' ' + HMember."Other Names";
                MobileLoanGuarantors."Date Created" := CurrentDatetime;
                MobileLoanGuarantors.Insert;

                ResponseObject.Add('request_status', 'SUCCESS');
                Datum.Add('message', successText);
                ResponseObject.Add('response_payload', Datum);


                msg := 'Dear member, You have Requested ' + MobileLoanGuarantors."Guarantor Name" +
                    ' to be your Guarantor on ' + SkyMobileLoans."Loan Name" + ' amounting to KES ' + Format(SkyMobileLoans.Amount) + ' on ' + Format(Today) + ' ' + Format(Time) +
                    ' Please notify them to Accept By dialing *839#. REF: ' + Format(SkyMobileLoans."Loan No.");
                SendSMS.SendSms(SMSSource::MBANKING, HMember."Phone No.", msg, Format(SkyMobileLoans."Loan No."), '', true, 220, false, 'CBS', SkyMobileLoans."Loan No.", 'CBS');


                msg := 'Dear ' + Format(MobileLoanGuarantors."Guarantor Name") + ',' + HMember.Name +
                ' is Requesting your Guarantorship on ' + SkyMobileLoans."Loan Name" + ' amounting to KES ' + Format(SkyMobileLoans.Amount) + ' on ' + Format(Today) + ' ' + Format(Time) +
                ' Please Accept/Decline By dialing *839#. REF: ' + Format(SkyMobileLoans."Loan No.");
                SendSMS.SendSms(SMSSource::MBANKING, MobileLoanGuarantors."Guarantor Mobile No.", msg, Format(SkyMobileLoans."Loan No."), '', true, 220, false, 'CBS', SkyMobileLoans."Loan No.", 'CBS');

            end;
        end;

    end;

    local procedure GetGuarantorMobileNo(MobileNo: Code[20]): Text
    begin

        if StrLen(MobileNo) = 10 then begin
            if CopyStr(MobileNo, 1, 1) = '0' then
                MobileNo := '+254' + CopyStr(MobileNo, 2, 9);
        end
        else
            if StrLen(MobileNo) = 12 then begin
                if CopyStr(MobileNo, 1, 3) = '254' then
                    MobileNo := '+' + MobileNo;
            end
            else
                if StrLen(MobileNo) = 13 then begin
                    if CopyStr(MobileNo, 1, 4) = '+254' then
                        MobileNo := MobileNo;
                end;

        exit(MobileNo);
    end;

    procedure ValidateMinAccountBalance(
        requestAmount: Decimal;
        var theSavingsAccount: Record "Savings Accounts";
        theTransactionCategory: Text;
        var SearchMember: record Members;
        ReceiverPaybillTill: Text
    ): Boolean
    var
        theCharges: List of [Decimal];
        totalCost: Decimal;
    begin
        theCharges := GetTransChargesPreview(
            theTransactionCategory,
            requestAmount,
            theSavingsAccount."No.",
            SearchMember,
            ReceiverPaybillTill,
            ''
        );

        totalCost := theCharges.Get(1) + requestAmount;

        exit(totalCost > GlobalFunctions.GetSavingsAccountAvailableBalance(theSavingsAccount, true));
    end;

    procedure CheckWithdrawalTransactionLimitViolation(
        requestAmount: Decimal;
        var theSavingsAccount: Record "Savings Accounts";
        var WithdrawalLimitSetup: Record "E-Channels Transaction Setup"
    ): Boolean
    begin
        if theSavingsAccount."Mobile Withdrawal Limit" > 0 then begin
            // Temporary variable store
            WithdrawalLimitSetup."Mobile Withdrawal Limit" := theSavingsAccount."Mobile Withdrawal Limit";
        end;

        exit(
            requestAmount > WithdrawalLimitSetup."Mobile Withdrawal Limit"
        );
    end;

    procedure CheckWithdrawalDailyTransactionLimitViolation(
        requestAmount: Decimal;
        var theSavingsAccount: Record "Savings Accounts";
        var WithdrawalLimitSetup: Record "E-Channels Transaction Setup"
    ): Boolean
    var
        todaysMpesaWithdrawals: Record "Sky M-Banking Trans. Buffer";
    begin
        if theSavingsAccount."Mobile Daily Withdrawal Limit" > 0 then begin
            // Temporary variable store
            WithdrawalLimitSetup."Mobile Daily Withdrawal Limit" := theSavingsAccount."Mobile Daily Withdrawal Limit";
        end;

        todaysMpesaWithdrawals.SetRange("Savings Account", theSavingsAccount."No.");
        todaysMpesaWithdrawals.SetRange("Transaction Date", Today);
        todaysMpesaWithdrawals.SetFilter("Transaction Type",
            '=%1|%2|%3|%4|%5|%6',
            todaysMpesaWithdrawals."Transaction Type"::Airtime,
            todaysMpesaWithdrawals."Transaction Type"::"Bank Transfer",
            todaysMpesaWithdrawals."Transaction Type"::"Mpesa Withdrawal",
            todaysMpesaWithdrawals."Transaction Type"::"Utility Payment",
            todaysMpesaWithdrawals."Transaction Type"::"Till Payment",
            todaysMpesaWithdrawals."Transaction Type"::"Gaming Utility Payment"
        );
        todaysMpesaWithdrawals.SetFilter("Transaction Status", '<>%1', todaysMpesaWithdrawals."Transaction Status"::REVERSE_CONFIRMED);

        todaysMpesaWithdrawals.CalcSums("Transaction Amount");

        exit(
            (todaysMpesaWithdrawals."Transaction Amount" + requestAmount) > WithdrawalLimitSetup."Mobile Daily Withdrawal Limit"
        );
    end;

    procedure LoanAutoRecovery(Loans: Record Loans)
    var
        Members: Record Members;
        Savings: Record "Savings Accounts";
        ProductSetup: Record "Product Factory";
        AvailableBal: Decimal;
        StandingOrderHeader: Record "Standing Order Header";
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        GenJournalLine: Record "Gen. Journal Line";
        BalAccountType: Enum "Gen. Journal Account Type";
        LoanApps: Record Loans;
        LoanInterest: Decimal;
        LoanPrinciple: Decimal;
        TChargeAmount: Decimal;
        AmountDedu: Decimal;
        LoanPrincipal: Decimal;
        LoanRepayment: Decimal;
        TransTypes: Record "Transaction Types";
        SavingsACCS: Record "Savings Accounts";
        THESavings: Record "Savings Accounts";
        AmtDeducted: Decimal;
        TransactionTypes: record "Transaction Types";
        AccNo: Code[20];
        LineNo: Integer;
        Amt: Decimal;
        Pfact: Record "Product Factory";
        JournalPosting: Codeunit "Journal Posting";
        AcctType: Enum "Gen. Journal Account Type";
        TransType: Enum "Transaction Types";
        BalAccType: Enum "Gen. Journal Account Type";
        LRepayment: Decimal;
        BalAccNo: Code[20];
        LoansProcess: Codeunit "Loans Process";
        Temp: Record "Banking User Template";
        Jtemplate: Code[30];
        JBatch: Code[30];
        UserSetup: Record "User Setup";
        DBranch: Code[20];
        DActivity: Code[20];
        DocNo: Code[20];
        Pdate: Date;
        Interest: Decimal;
        RunBal: Decimal;
    begin
        Loans.CalcFields("Total Balance", "Daily Interest", "Amount In Arreas SACCO");
        if ((Loans."Total Balance" + Loans."Daily Interest") > 0) and (Loans."Source Unit" = Loans."Source Unit"::FOSA) then begin
            if Loans."Expected Date of Completion" = 0D then begin
                if (Loans.Installments > 0) and (Loans."Disbursement Date" <> 0D) then
                    Loans."Expected Date of Completion" := CalcDate((Format(Loans.Installments) + 'M'), Loans."Disbursement Date") else
                    Loans."Expected Date of Completion" := Today;
            end;
            Pdate := Today;
            DocNo := Loans."Loan No.";

            Temp.get(UserId);
            Jtemplate := Temp."Loan Recovery Template";
            JBatch := Temp."Loan Recovery Batch";

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", JTemplate);
            GenJournalLine.SetRange("Journal Batch Name", JBatch);
            GenJournalLine.DeleteAll;

            if Loans."Expected Date of Completion" <= today then begin
                if ProductSetup.Get(Loans."Loan Product Type") then begin
                    if (ProductSetup."Loan Disbt Account Code" <> '') and (ProductSetup."Mobile Loan" = true) then begin
                        Savings.Reset();
                        Savings.SetRange("Member No.", Loans."Member No.");
                        Savings.SetRange("Product Type", ProductSetup."Loan Disbt Account Code");
                        if Savings.Find('-') then begin
                            AvailableBal := Savings.GetAvailableBalance(Savings."No.");
                            if AvailableBal > 0 then begin
                                RunBal := AvailableBal;
                                LineNo += 1;
                                if AvailableBal > 0 then begin
                                    // Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest", "Daily Interest");
                                    if (Loans."Outstanding Interest" + Loans."Daily Interest") > 0 then begin
                                        //Capitalize Interest
                                        if Loans."Daily Interest" > 0 then begin
                                            Amt := 0;
                                            // Accrue Interest;
                                            Pfact.Get(Loans."Loan Product Type");
                                            Pfact.TestField("Loan Interest Account [G/L]");
                                            AcctType := AcctType::Credit;
                                            TransType := TransType::"Interest Due";
                                            LineNo := LineNo + 10000;
                                            AccNo := Loans."Loan Account";
                                            BalAccType := BalAccType::"G/L Account";
                                            BalAccNo := Pfact."Loan Interest Account [G/L]";
                                            Amt := Loans."Daily Interest";

                                            JournalPosting.PostJournal(Jtemplate, JBatch, LineNo, AcctType, CopyStr(DocNo, 1, 14),
                                            CopyStr('Daily Interest Capitalized', 1, 50), Amt, AccNo, PDate, BalAccType,
                                            BalAccNo, Loans."Loan No.", Loans."Global Dimension 1 Code", Loans."Global Dimension 2 Code", TransType, Loans."Loan No.", '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");
                                            LoansProcess.ClearDailyInterest(Loans."Loan No.");
                                        end;
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
                                            GenJournalLine."Shortcut Dimension 1 Code" := loans."Global Dimension 1 Code";
                                            GenJournalLine."Shortcut Dimension 2 Code" := loans."Global Dimension 2 Code";
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
                                            GenJournalLine."Account No." := Savings."No.";
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
                                            GenJournalLine."Shortcut Dimension 1 Code" := loans."Global Dimension 1 Code";
                                            GenJournalLine."Shortcut Dimension 2 Code" := loans."Global Dimension 2 Code";
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
                                            // LRepayment := Loans."Amount In Arreas SACCO";
                                            // if LRepayment = 0 then LRepayment := Loans.Repayment;
                                            // IF LRepayment <= 0 THEN BEGIN
                                            //     if Loans.Installments <= 0 then Loans.Installments := 1;
                                            //     LRepayment := ROUND((Loans."Approved Amount" / Loans.Installments), 0.01, '>');
                                            // end;
                                            LRepayment := Loans."Outstanding Balance";

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
                                                GenJournalLine."Shortcut Dimension 1 Code" := Loans."Global Dimension 1 Code";
                                                GenJournalLine."Shortcut Dimension 2 Code" := Loans."Global Dimension 2 Code";
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
                                                GenJournalLine."Account No." := Savings."No.";
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
                                                GenJournalLine."Shortcut Dimension 1 Code" := Loans."Global Dimension 1 Code";
                                                GenJournalLine."Shortcut Dimension 2 Code" := Loans."Global Dimension 2 Code";
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
                                LineNo += 1;
                            end;

                        end;
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
            end;

        end;
    end;

    procedure GenerateSchedule(LoansR: Record Loans)
    var
        RSchedule: Record "Ideal Repayment Schedule";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        RepaymentDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        GeneralSetUp: Record "General Set-Up";
        CreateSchedule: Boolean;

        NewDate: Date;
    begin
        RunDate := 0D;
        QCounter := 0;
        QCounter := 3;

        GeneralSetUp.Get;

        CreateSchedule := true;

        if (LoansR."Disbursement Date" = 0D) or (LoansR.Interest = 0) or (LoansR.Installments = 0) then
            CreateSchedule := false;

        if CreateSchedule then begin

            //LoansR.TestField("Disbursement Date");

            LoanAmount := LoansR."Approved Amount";
            if LoansR."Loan Rescheduled" then begin
                InterestRate := LoansR.Interest;
            end else
                InterestRate := LoansR.Interest;

            RepayPeriod := LoansR.Installments;
            InitialInstal := LoansR.Installments;
            LBalance := LoansR."Approved Amount";

            // RunDate := Today;
            RunDate := CalcDate('1M', CalcDate('<CM>', LoansR."Disbursement Date"));

            InstalNo := 0;

            //Repayment Frequency
            repeat
                InstalNo := InstalNo + 1;
                if LoansR.Interest = 0 then LoansR."Interest Calculation Method" := LoansR."Interest Calculation Method"::"Straight Line";

                if LoansR."Interest Calculation Method" = LoansR."Interest Calculation Method"::Amortised then begin

                    LoansR.TestField(Interest);
                    LoansR.TestField(Installments);
                    TotalMRepay := Round((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                    LInterest := Round(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                    LPrincipal := TotalMRepay - LInterest;
                end;

                if LoansR."Interest Calculation Method" = LoansR."Interest Calculation Method"::"Straight Line" then begin
                    LoansR.TestField(Interest);
                    LoansR.TestField(Installments);
                    LPrincipal := LoanAmount / RepayPeriod;
                    LInterest := (InterestRate / 12 / 100) * LoanAmount;
                    //Grace Period Interest
                    //LInterest:=(LInterest*InitialInstal)/(InitialInstal-InitialGraceInt);
                end;

                if LoansR."Interest Calculation Method" = LoansR."Interest Calculation Method"::"Reducing Balance" then begin
                    LoansR.TestField(Interest);
                    LoansR.TestField(Installments);
                    LPrincipal := LoanAmount / RepayPeriod;
                    LInterest := (InterestRate / 12 / 100) * LBalance;
                end;

                if LoansR."Interest Calculation Method" = LoansR."Interest Calculation Method"::"Reducing Flat" then begin
                    LoansR.TestField(Interest);
                    LoansR.TestField(Installments);
                    LPrincipal := Round(LoanAmount / RepayPeriod, 1.0, '>');
                    LInterest := Round(((LoanAmount * InterestRate / 12 / 100) + (LPrincipal * InterestRate / 12 / 100)) / 2, 1.0, '>');
                    LoansR.Repayment := LPrincipal + LInterest;
                end;
                //kma

                //Grace Period
                if GrPrinciple > 0 then begin
                    LPrincipal := 0
                end else begin
                    //IF "Instalment Period" <> InPeriod THEN
                    LBalance := LBalance - LPrincipal;

                end;

                if GrInterest > 0 then
                    LInterest := 0;

                GrPrinciple := GrPrinciple - 1;
                GrInterest := GrInterest - 1;

                Evaluate(RepayCode, Format(InstalNo));

                RSchedule.Init;
                RSchedule."Repayment Code" := RepayCode;
                RSchedule."Repayment Date" := RunDate;
                RSchedule."Principal Repayment" := LPrincipal;
                RSchedule."Monthly Interest" := LInterest;
                RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                RSchedule."Ideal Loan Bal" := LBalance;

                RSchedule."Loan No." := LoansR."Loan No.";
                RSchedule."Loan Amount" := LoanAmount;
                RSchedule."Instalment No" := InstalNo;
                RSchedule."Member No." := LoansR."Member No.";
                RSchedule."Loan Category" := LoansR."Loan Product Type";

                if RSchedule.Insert then begin
                    Commit;

                    // Repayment Frequency
                    if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else
                        if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::Weekly then
                            RunDate := CalcDate('1W', RunDate)
                        else
                            if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::Monthly then
                                RunDate := CalcDate('1M+CM', RunDate)
                            else
                                if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::Quarterly then
                                    RunDate := CalcDate('1Q', RunDate)
                                else
                                    if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::"Bi-Annual" then
                                        RunDate := CalcDate('6M', RunDate)
                                    else
                                        if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::Yearly then
                                            RunDate := CalcDate('1Y', RunDate);
                end;

            until LBalance < 1;
        end;
    end;

    local procedure GetBiasharaQualifiedAmount(MemberNo: Code[20]; ProductID: Code[10]; FOSAAccountNo: Code[20]; var EligibilityFailReason: Text): Decimal
    var
        ProdFac: Record "Product Factory";
        SavAccounts: Record "Savings Accounts";
        SavLedger: Record "Savings Ledger Entry";
        Members: Record Members;
        MonthStart: Date;
        MonthEnd: Date;
        BOSACredits: Decimal;
        MonthCredits: Decimal;
        TotalCredits: Decimal;
        QualifiedAmount: Decimal;
        ActiveMonths: Integer;
        DepositCap: Decimal;
        i: Integer;
        MonthLabel: Text;
        MonthLabels: array[3] of Text;
        MonthCreditsValues: array[3] of Decimal;
        BOSACreditsValues: array[3] of Decimal;
        MonthSummaries: array[3] of Text;
    begin
        QualifiedAmount := 0;
        TotalCredits := 0;
        ActiveMonths := 0;
        DepositCap := 0;

        ProdFac.GET(ProductID);

        // if FOSAAccountNo = '' then begin
        //     EligibilityFailReason := 'FOSA account is required to assess eligibility';
        //     exit(0);
        // end;

        Members.Reset();
        Members.SetRange("No.", MemberNo);
        Members.SetLoadFields("No.", "Employer Code", "Account Type", "Deposit Contribution Met");
        if not Members.FindFirst() then begin
            EligibilityFailReason := 'Member NOT found';
            Message('Debug: Member %1 not found.', MemberNo);
            exit(0);
        end;

        for i := 1 to 3 do begin
            MonthStart := DMY2Date(1,
                Date2DMY(CalcDate('<-' + Format(i) + 'M>', Today()), 2),
                Date2DMY(CalcDate('<-' + Format(i) + 'M>', Today()), 3)
            );
            MonthEnd := CalcDate('<CM>', MonthStart);
            MonthLabel := Format(MonthStart, 0, '<Month Text> <Year4>');
            BOSACredits := 0;

            // BOSA Deposit credits
            SavAccounts.Reset();
            SavAccounts.SetRange("Member No.", MemberNo);
            SavAccounts.SetRange("Product Category", SavAccounts."Product Category"::"BOSA Deposits");
            SavAccounts.SetLoadFields("No.");
            if SavAccounts.FindSet() then
                repeat
                    SavLedger.Reset();
                    SavLedger.SetRange("Customer No.", SavAccounts."No.");
                    SavLedger.SetRange("Posting Date", MonthStart, MonthEnd);
                    SavLedger.SetRange(Reversed, false);
                    SavLedger.SetFilter("Credit Amount", '>0');
                    SavLedger.CalcSums("Credit Amount");
                    BOSACredits += SavLedger."Credit Amount";
                until SavAccounts.Next() = 0;

            MonthCredits := BOSACredits;

            MonthLabels[i] := MonthLabel;
            MonthCreditsValues[i] := MonthCredits;
            BOSACreditsValues[i] := BOSACredits;
            MonthSummaries[i] := StrSubstNo('%1: BOSA=%2', MonthLabel, BOSACredits);
            TotalCredits += MonthCredits;

            if BOSACredits > 0 then
                ActiveMonths += 1
            else begin
                EligibilityFailReason := StrSubstNo('No deposits were received into your Deposit account in %1.', MonthLabel);

                if not Members."Deposit Contribution Met" then begin
                    Message('Debug Failure:\Month 1 (%1)\Month 2 (%2)\Month 3 (%3)\\Total Credits: %4\Status: Failed at %5 (%6)',
                        MonthSummaries[1], MonthSummaries[2], MonthSummaries[3],
                        TotalCredits, MonthLabel, EligibilityFailReason);
                    exit(0);
                end;
            end;
        end;

        Message('Debug Credit Summary:\Month 1 (%1)\Month 2 (%2)\Month 3 (%3)\\Total Credits: %4',
            MonthSummaries[1], MonthSummaries[2], MonthSummaries[3], TotalCredits);

        if (ActiveMonths < 3) and not Members."Deposit Contribution Met" then begin
            EligibilityFailReason :=
                'You are not eligible. Deposits are required for 3 consecutive months';
            exit(0);
        end;

        QualifiedAmount := Round(TotalCredits, 1);

        if QualifiedAmount > ProdFac."Maximum Loan Amount" then begin
            QualifiedAmount := ProdFac."Maximum Loan Amount";
            Message('Debug: Capped by Product Max Loan Amount = %1', QualifiedAmount);
        end;

        if ProdFac."Deposit Qualifier %" > 0 then begin
            SavAccounts.Reset();
            SavAccounts.SetRange("Member No.", MemberNo);
            SavAccounts.SetRange("Product Category", SavAccounts."Product Category"::"BOSA Deposits");
            SavAccounts.SetLoadFields(Balance);
            if SavAccounts.FindFirst() then begin
                SavAccounts.CalcFields(Balance);
                DepositCap := Round(SavAccounts.Balance * (ProdFac."Deposit Qualifier %" / 100), 1);
                Message('Debug: BOSA Deposits Balance = %1, Deposit Cap (%2%) = %3', SavAccounts.Balance, ProdFac."Deposit Qualifier %", DepositCap);

                if DepositCap > ProdFac."Maximum Loan Amount" then
                    DepositCap := ProdFac."Maximum Loan Amount";

                QualifiedAmount := DepositCap;
                Message('Debug: Qualified Amount set to Deposit Cap = %1', QualifiedAmount);
            end;
        end;

        if QualifiedAmount < ProdFac."Minimum Loan Amount" then begin
            EligibilityFailReason := StrSubstNo(
                'You are not eligible. Qualified amount KES %1 is below the minimum of KES %2',
                Format(Round(QualifiedAmount, 1)),
                Format(ProdFac."Minimum Loan Amount")
            );
            Message('Debug: Qualified amount %1 is below product minimum %2', QualifiedAmount, ProdFac."Minimum Loan Amount");
            exit(0);
        end;

        EligibilityFailReason := 'Eligible';
        Message('Debug: Member is Eligible. Final Qualified Amount = %1', QualifiedAmount);
        exit(QualifiedAmount);
    end;

    procedure GetMemberLoanBalance(MemberNo: Code[20]; ProductID: Code[10]): Decimal
    var
        LoanApp: Record Loans;
        TotalBalance: Decimal;
    begin
        TotalBalance := 0;

        LoanApp.Reset;
        LoanApp.SetRange("Member No.", MemberNo);
        LoanApp.SetRange("Loan Product Type", ProductID);
        LoanApp.SetRange(Posted, true);
        LoanApp.SetFilter("Total Loan Balance", '>0');
        LoanApp.SetAutoCalcFields("Total Loan Balance");
        LoanApp.SetLoadFields("Loan No.", "Total Loan Balance");

        if LoanApp.FindSet() then begin
            repeat
                TotalBalance += LoanApp."Total Loan Balance";
            until LoanApp.Next() = 0;
        end;

        exit(TotalBalance);
    end;

    procedure GetEmergencyLoanQualifiedAmount(
    MemberNo: Code[20];
    ProductID: Code[10];
    FOSAAccountNo: Code[20];
    var EligibilityFailReason: Text
): Decimal
    var
        Members: Record Members;
        ProdFac: Record "Product Factory";
        FOSAAccount: Record "Savings Accounts";
        SavLedger: Record "Savings Ledger Entry";
        Globalfunc: Codeunit "Global Functions";
        Incomsal: Enum "Salary Income Types";
        AbilityAmount: Decimal;
        QualifiedAmount: Decimal;
        DepositCap: Decimal;
        AvgFOSACredits: Decimal;
        TotalCredits: Decimal;
        StartDate: Date;
        SalaryRatePct: Decimal;
        FOSACreditsRatePct: Decimal;
    begin
        QualifiedAmount := 0;
        AbilityAmount := 0;
        DepositCap := 0;
        SalaryRatePct := 66;
        FOSACreditsRatePct := 50;

        if not ProdFac.GET(ProductID) then begin
            EligibilityFailReason := 'Loan Product NOT found';
            exit(0);
        end;

        Members.Reset();
        Members.SetRange("No.", MemberNo);
        Members.SetLoadFields("No.", "Member Class");
        if not Members.FindFirst() then begin
            EligibilityFailReason := 'Member NOT found';
            exit(0);
        end;

        // Class A -> 66% of salary (standard working hours)
        // All others (Class B) -> 50% of average FOSA statement credits
        case Members."Member Class" of
            'CLASSA':
                begin
                    AbilityAmount := Globalfunc.GetSmallestSalary(FOSAAccountNo, Incomsal::Salary);
                    AbilityAmount := (SalaryRatePct / 100) * AbilityAmount;
                end;
            'CLASSB':
                begin
                    StartDate := CalcDate('<-12M>', Today());
                    TotalCredits := 0;

                    SavLedger.Reset();
                    SavLedger.SetRange("Customer No.", FOSAAccountNo);
                    SavLedger.SetRange("Posting Date", StartDate, Today());
                    SavLedger.SetFilter("Credit Amount", '>0');
                    SavLedger.CalcSums("Credit Amount");
                    TotalCredits := SavLedger."Credit Amount";

                    AvgFOSACredits := Round(TotalCredits / 12, 1);
                    AbilityAmount := (FOSACreditsRatePct / 100) * AvgFOSACredits;
                end;
            else begin
                EligibilityFailReason := StrSubstNo('Member Class %1 is NOT supported for this loan product', Members."Member Class");
                exit(0);
            end;
        end;

        if AbilityAmount <= 0 then begin
            EligibilityFailReason := 'You are not eligible due to salary or FOSA statement credits. Qualified amount KES 0 is below the minimum of KES ' +
                Format(ProdFac."Minimum Loan Amount");
            exit(0);
        end;

        QualifiedAmount := AbilityAmount;

        if QualifiedAmount > ProdFac."Maximum Loan Amount" then
            QualifiedAmount := ProdFac."Maximum Loan Amount";

        // 3X Deposits cap - FOSA balance only, Deposit Qualifier % = 300 on Product Factory
        if ProdFac."Deposit Qualifier %" > 0 then begin
            FOSAAccount.Reset();
            FOSAAccount.SetRange("No.", FOSAAccountNo);
            FOSAAccount.SetLoadFields(Balance);
            if FOSAAccount.FindFirst() then begin
                FOSAAccount.CalcFields(Balance);
                DepositCap := Round(FOSAAccount.Balance * (ProdFac."Deposit Qualifier %" / 100), 1);

                if DepositCap > ProdFac."Maximum Loan Amount" then
                    DepositCap := ProdFac."Maximum Loan Amount";

                if DepositCap < QualifiedAmount then
                    QualifiedAmount := DepositCap;
            end else begin
                EligibilityFailReason := 'You are not eligible. FOSA account NOT found';
                exit(0);
            end;
        end;

        if QualifiedAmount < ProdFac."Minimum Loan Amount" then begin
            EligibilityFailReason := StrSubstNo(
                'You are not eligible. Qualified amount KES %1 is below the minimum of KES %2',
                Format(Round(QualifiedAmount, 1)),
                Format(ProdFac."Minimum Loan Amount")
            );
            exit(0);
        end;

        EligibilityFailReason := '';
        exit(QualifiedAmount);
    end;


    var
        GlobalFunctions: Codeunit "Global Functions";
        SaccoTrans: Codeunit "Sacco Transactions";
        HMember: Record Members;
        SMSSource: enum "SMS Source";
        SendSMS: Codeunit SendSms;
}