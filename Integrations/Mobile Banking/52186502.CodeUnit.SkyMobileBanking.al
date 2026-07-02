codeunit 52186502 "Sky Mobile Banking Integration"
{
    procedure HandleRequest(Request: Text): Text
    var
        RequestParser: JsonObject;
        RequestAction: JsonToken;
        RequestAPIId: JsonToken;
        RequestPayload: JsonToken;
    begin
        RequestParser.ReadFrom(Request);
        RequestParser.SelectToken('$.action', RequestAction);
        RequestParser.SelectToken('$.api_request_id', RequestAPIId);
        RequestParser.SelectToken('$.payload', RequestPayload);

        // API actions here
        case RequestAction.AsValue().AsText() of
            'GET_MEMBER_DETAILS':
                exit(GetMemberDetails(RequestPayload.AsObject, RequestAPIId));
            'GET_DEPOSIT_ACCOUNTS':
                exit(GetDepositAccounts(RequestPayload.AsObject, RequestAPIId));
            'VALIDATE_ACCOUNT':
                exit(ValidateAccount(RequestPayload.AsObject, RequestAPIId));
            'BALANCE_ENQUIRY':
                exit(BalanceEnquiry(RequestPayload.AsObject, RequestAPIId));
            'ACCOUNT_MINI_STATEMENT':
                exit(AccountMiniStatement(RequestPayload.AsObject, RequestAPIId));
            'ACCOUNT_FULL_STATEMENT':
                exit(AccountFullStatement(RequestPayload.AsObject, RequestAPIId));
            'WITHDRAWAL':
                exit(Withdrawal(RequestPayload.AsObject, RequestAPIId));
            'WITHDRAWAL_RESULT':
                exit(WithdrawalResult(RequestPayload.AsObject, RequestAPIId));
            'IFT_ACCOUNT_TO_ACCOUNT':
                exit(IFTAccountToAccount(RequestPayload.AsObject, RequestAPIId));
            'IFT_LOAN_REPAYMENT':
                exit(IFTLoanRepayment(RequestPayload.AsObject, RequestAPIId));
            'DEPOSIT':
                exit(Deposit(RequestPayload.AsObject, RequestAPIId));
            'GET_LOAN_TYPES':
                exit(GetLoanTypes(RequestPayload.AsObject, RequestAPIId));
            'GET_LOAN_PURPOSES':
                exit(GetLoanPurposes(RequestPayload.AsObject, RequestAPIId));
            'CHECK_LOAN_LIMIT':
                exit(CheckLoanLimit(RequestPayload.AsObject, RequestAPIId));
            'LOAN_APPLICATION':
                exit(LoanApplication(RequestPayload.AsObject, RequestAPIId));
            'GET_LOANS_IN_SERVICE':
                exit(GetLoansInService(RequestPayload.AsObject, RequestAPIId));
            'LOAN_BALANCE_ENQUIRY':
                exit(LoanBalanceEnquiry(RequestPayload.AsObject, RequestAPIId));
            'LOAN_MINI_STATEMENT':
                exit(LoanMiniStatement(RequestPayload.AsObject, RequestAPIId));
            'LOAN_FULL_STATEMENT':
                exit(LoanFullStatement(RequestPayload.AsObject, RequestAPIId));
            'GET_CHARGES':
                exit(GetCharges(RequestPayload.AsObject, RequestAPIId));
            'CALL_SERVICE':
                exit(PostMpesaTransactions(RequestPayload.AsObject, RequestAPIId));

            // LOAN APPLICATION + GUARANTORSHIP
            'GET_LOAN_APPLICATION_PRODUCTS':
                exit(GetLoanApplicationProducts(RequestPayload.AsObject, RequestAPIId));
            'VALIDATE_GUARANTOR_ELIGIBILITY_REQUEST':
                exit(ValidateGuarantorEligibilityRequest(RequestPayload.AsObject));
            'CREATE_LOAN_APPLICATION_REQUEST':
                exit(CreateLoanApplicationRequest(RequestPayload.AsObject, RequestAPIId));
            'GET_LOAN_APPLICATION_REQUESTS':
                exit(GetLoanApplicationRequests(RequestPayload.AsObject, RequestAPIId));
            'GET_LOAN_APPLICATION_REQUEST':
                exit(GetLoanApplicationRequest(RequestPayload.AsObject, RequestAPIId));
            'EDIT_LOAN_APPLICATION_REQUEST':
                exit(EditLoanApplicationRequest(RequestPayload.AsObject, RequestAPIId));
            'CANCEL_LOAN_APPLICATION_REQUEST':
                exit(CancelLoanApplicationRequest(RequestPayload.AsObject, RequestAPIId));
            'MANAGE_LOAN_APPLICATION_GUARANTORS_REQUEST':
                exit(ManageLoanGuarantorsRequest(RequestPayload.AsObject, RequestAPIId));
            'GET_LOAN_GUARANTORSHIP_REQUESTS':
                exit(GetLoanGuarantorshipRequests(RequestPayload.AsObject, RequestAPIId));
            'GET_LOAN_GUARANTORSHIP_REQUEST':
                exit(GetLoanGuarantorshipRequest(RequestPayload.AsObject, RequestAPIId));
            'ACTION_LOAN_GUARANTORSHIP_REQUEST':
                exit(ActionLoanGuarantorshipRequest(RequestPayload.AsObject, RequestAPIId));

            // Standing Orders
            'GET_STANDING_ORDER_SOURCE_ACCOUNTS':
                exit(GetSTOSourceAccounts(RequestPayload.AsObject));
            'GET_STANDING_ORDER_INCOME_TYPES':
                exit(GetSTOIncomeTypes(RequestPayload.AsObject));
            'CREATE_STANDING_ORDER_REQUEST':
                exit(CreateStandingOrderRequest(RequestPayload.AsObject));
            'GET_STANDING_ORDER_REQUESTS':
                exit(GetStandingOrderRequests(RequestPayload.AsObject));
            'GET_STANDING_ORDER_REQUEST':
                exit(GetStandingOrderRequest(RequestPayload.AsObject));
            'CANCEL_STANDING_ORDER_REQUEST':
                exit(CancelStandingOrderRequest(RequestPayload.AsObject));

            // Fixed Deposit Contracts
            'GET_FD_ACCOUNTS':
                exit(GetFDAccountsList(RequestPayload.AsObject));
            'GET_FD_MATURITY_INSTRUCTIONS':
                exit(GetFDAccountMaturityInstructions(RequestPayload.AsObject));
            'UPDATE_FD_MATURITY_INSTRUCTION_REQUEST':
                exit(UpdateFDAccountMaturityRequest(RequestPayload.AsObject));

            // PIn Reset
            'CHECK_PIN_RESET_ABILITY':
                exit(CheckPINResetAbilityRequest(RequestPayload.AsObject));
            'PROCESS_PIN_RESET_REQUEST':
                exit(ProcessPINResetRequest(RequestPayload.AsObject));

            // 'TEST':
            //     exit(Test)
            else
                exit(UnsupportedAction(RequestAction.AsValue.AsText))
        end;
    end;

    local procedure GetMemberDetails(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        DimensionValues: Record "Dimension Value";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO, NATIONAL_ID, PASSPORT_NO, GROWER_NO
        Payload.Get('identifier', identifier);

        if identifier.AsValue.AsText = '' then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Identifier value must NOT be empty!');

            ResponseObject.Add('response_payload', Datum);
            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;

        SearchMember.Reset;

        case identifier_type.AsValue.AsText of
            'MSISDN':
                begin
                    SearchMember.SetRange("Transactional Mobile Number", identifier.AsValue.AsText);
                end;
            'CUSTOMER_NO':
                SearchMember.SetRange("No.", identifier.AsValue.AsText);
            'NATIONAL_ID':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"ID Number");
                    SearchMember.SetRange("Primary Identification", identifier.AsValue.AsText);

                    if not SearchMember.FindFirst then begin
                        SearchMember.Reset;
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"ID Number");
                        SearchMember.SetRange("Secondary Identification", identifier.AsValue.AsText);
                    end;
                end;
            'PASSPORT_NO':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"Passport No");
                    SearchMember.SetRange("Primary Identification", identifier.AsValue.AsText);

                    if not SearchMember.FindFirst then begin
                        SearchMember.Reset;
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"Passport No");
                        SearchMember.SetRange("Secondary Identification", identifier.AsValue.AsText);
                    end;
                end;
            'GROWER_NO':
                SearchMember.SetRange("Payroll/Staff No.", identifier.AsValue.AsText);
            else
        end;

        SearchMember.SetLoadFields(
            "Account Type", "No.", "Primary Identification Type", "Primary Identification",
            Salutation, Name, gender, "Date of Birth", "E-Mail", "Phone No.", Status,
            "Registration Date", "P.I.N Number", "Branch Code", "Transactional Mobile Number"
        );

        IF SearchMember.HasFilter and SearchMember.FindFirst() then begin
            if SearchMember."Account Type" = SearchMember."Account Type"::"Single Member Account" then begin
                Datum.Add('customer_type', 'INDIVIDUAL');
            end else begin
                Datum.Add('customer_type', 'CORPORATE');
            end;

            Datum.Add('identifier_type', 'CUSTOMER_NO');
            Datum.Add('identifier', SearchMember."No.");

            case SearchMember."Primary Identification Type" of
                SearchMember."Primary Identification Type"::"ID Number":
                    begin
                        Datum.Add('primary_identity_type', 'NATIONAL_ID');
                        Datum.Add('primary_identity_no', SearchMember."Primary Identification");
                    end;
                SearchMember."Primary Identification Type"::"Passport No":
                    begin
                        Datum.Add('primary_identity_type', 'PASSPORT_NO');
                        Datum.Add('primary_identity_no', SearchMember."Primary Identification");
                    end;
                else begin
                    Datum.Add('primary_identity_type', 'OTHER');
                    Datum.Add('primary_identity_no', SearchMember."Primary Identification");
                end;
            end;

            Datum.Add('title', SearchMember.Salutation);
            Datum.Add('full_name', SearchMember.Name);
            Datum.Add('gender', Format(SearchMember.Gender).ToUpper);
            Datum.Add('date_of_birth', GlobalFunctions.FormatISODate(SearchMember."Date of Birth"));
            Datum.Add('primary_email_address', SearchMember."E-Mail");

            if SearchMember."Transactional Mobile Number" <> '' then begin
                Datum.Add('primary_mobile_number', SearchMember."Transactional Mobile Number");
            end else begin
                if SearchMember."Phone No." <> '' then begin
                    Datum.Add('primary_mobile_number', SearchMember."Phone No.");
                end else begin
                    Datum.Add('primary_mobile_number', '');
                end;
            end;

            Datum.Add('status', Format(SearchMember.Status).ToUpper);
            Datum.Add('registration_date', GlobalFunctions.FormatISODate(SearchMember."Registration Date"));
            Datum.Add('tax_authority', 'KRA');
            Datum.Add('tax_authority_pin_number', SearchMember."P.I.N Number");

            Datum.Add('branch_code', SearchMember."Branch Code");
            DimensionValues.Reset;
            DimensionValues.SetRange("Dimension Code", BranchDimensionCode);
            DimensionValues.SetRange(Code, SearchMember."Branch Code");
            if DimensionValues.FindFirst then begin
                Datum.Add('branch', DimensionValues.Name);
            end else begin
                Datum.Add('branch', SearchMember."Branch Code");
            end;

            Datum.Add('main_savings_account_no', SkyMbankingTrans.GetMemberFosaAcc(SearchMember));
            Datum.Add('main_deposits_account_no', SkyMbankingTrans.GetMemberDepositsAcc(SearchMember));

            ResponseObject.Add('request_status', 'SUCCESS');
        end else begin
            ResponseObject.Add('request_status', 'NOT_FOUND');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        ResponseObject.Add('response_payload', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetDepositAccounts(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        account_type: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        apply_charges: JsonToken;

        SearchMember: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        FOSAAccount: Record "Savings Accounts";
        SavingsProduct: Record "Product Factory";

        TotalCharges: Decimal;
        FosaAcc: Text;

        IsWithdrawable: Boolean;
        IsDepositable: Boolean;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;

        GlobalFunctions: Codeunit "Global Functions";
    begin
        Payload.Get('account_type', account_type); // FOSA, BOSA, WITHDRAWABLE, DEPOSIT, ALL, BUSINESS
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO, ID_NUMBER
        Payload.Get('identifier', identifier);
        Payload.Get('apply_charges', apply_charges);

        GetMemberRecordV2(SearchMember, identifier_type.AsValue.AsText, identifier.AsValue.AsText, '');

        IF SearchMember.FindFirst then begin
            SavingsAccounts.Reset;
            SavingsAccounts.SetRange("Member No.", SearchMember."No.");

            SavingsAccounts.SetLoadFields(
              "Product Type", Name, "Product Name", "No.", "Global Dimension 2 Code", Status,
              "Balance (LCY)", "Authorised Over Draft", "Uncleared Cheques", "ATM Transactions", "Lien Placed",
              "Coop Transactions", "One Month Installment", "Product Category"
            );

            SavingsAccounts.SetAutoCalcFields(
              "Balance (LCY)", "Authorised Over Draft", "Uncleared Cheques", "ATM Transactions", "Lien Placed",
              "Coop Transactions", "One Month Installment", "Sort Order"
            );

            SavingsAccounts.SetCurrentKey("Sort Order");
            SavingsAccounts.SetAscending("Sort Order", true);

            IF SavingsAccounts.FindSet then begin
                repeat begin
                    IsWithdrawable := false;
                    IsDepositable := false;

                    SavingsProduct.Reset;
                    SavingsProduct.SetRange("Product ID", SavingsAccounts."Product Type");

                    SavingsProduct.SetLoadFields(
                        "USSD Product Name", "Channels Ext. Transfer Options", "Channels Int. Transfer Options",
                        "Product ID", "Product Description", "Is USSD Product", Category,
                        "Product Category"
                    );

                    Datum.Add('account_name', SavingsAccounts.Name);

                    if SavingsProduct.FindFirst and (SavingsProduct."USSD Product Name" <> '') then begin
                        Datum.Add('account_label', SavingsProduct."USSD Product Name");
                    end else begin
                        Datum.Add('account_label', SavingsAccounts."Product Name");
                    end;

                    Datum.Add('account_number', SavingsAccounts."No.");
                    Datum.Add('account_type', SavingsAccounts."Global Dimension 2 Code");

                    if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"Share Capital" then begin
                        Datum.Add('account_balance', SavingsAccounts."Balance (LCY)");
                    end else begin
                        Datum.Add('account_balance', GlobalFunctions.GetSavingsAccountAvailableBalance(SavingsAccounts, false));
                    end;

                    Datum.Add('book_balance', SavingsAccounts."Balance (LCY)");
                    Datum.Add('account_status', Format(SavingsAccounts.Status).ToUpper);

                    if SavingsProduct.FindFirst then begin
                        if (SavingsProduct."Channels Ext. Transfer Options" = SavingsProduct."Channels Ext. Transfer Options"::"All - Deposit + Withdrawal") OR
                    (SavingsProduct."Channels Ext. Transfer Options" = SavingsProduct."Channels Ext. Transfer Options"::"Withdrawals Only") then begin
                            Datum.Add('can_withdraw', 'YES');
                            IsWithdrawable := true;
                        end else begin
                            Datum.Add('can_withdraw', 'NO');
                        end;
                        Datum.Add('max_withdrawable_amount', GlobalFunctions.GetSavingsAccountAvailableBalance(SavingsAccounts, false));

                        if (SavingsProduct."Channels Ext. Transfer Options" = SavingsProduct."Channels Ext. Transfer Options"::"All - Deposit + Withdrawal") OR
                        (SavingsProduct."Channels Ext. Transfer Options" = SavingsProduct."Channels Ext. Transfer Options"::"Deposit Only") then begin
                            Datum.Add('can_deposit', 'YES');
                            IsDepositable := true;
                        end else begin
                            Datum.Add('can_deposit', 'NO');
                        end;
                        Datum.Add('max_deposit_amount', 999999999999L);

                        if (SavingsProduct."Channels Int. Transfer Options" = SavingsProduct."Channels Int. Transfer Options"::"All - Deposit + Withdrawal") OR
                    (SavingsProduct."Channels Int. Transfer Options" = SavingsProduct."Channels Int. Transfer Options"::"Withdrawals Only") then begin
                            Datum.Add('can_withdraw_ift', 'YES');
                            IsWithdrawable := true;

                            // Shares trading only to withdrawn members
                            if (SavingsProduct."Product Category" = SavingsProduct."Product Category"::"Share Capital") and
                        (SearchMember.Subflag <> SearchMember.Subflag::Withdrawal)
                        then begin
                                Datum.Replace('can_withdraw_ift', 'NO');
                                IsWithdrawable := false;
                            end;
                        end else begin
                            Datum.Add('can_withdraw_ift', 'NO');
                        end;

                        if (SavingsProduct."Channels Int. Transfer Options" = SavingsProduct."Channels Int. Transfer Options"::"All - Deposit + Withdrawal") OR
                        (SavingsProduct."Channels Int. Transfer Options" = SavingsProduct."Channels Int. Transfer Options"::"Deposit Only") then begin
                            Datum.Add('can_deposit_ift', 'YES');
                            IsDepositable := true;
                        end else begin
                            Datum.Add('can_deposit_ift', 'NO');
                        end;
                    end;
                    Datum.Add('product_id', SavingsProduct."Product ID");
                    Datum.Add('product_name', SavingsProduct."Product Description");

                    case SavingsAccounts."Product Category" of
                        SavingsAccounts."Product Category"::"Benevolent (BBF)",
                        SavingsAccounts."Product Category"::Risk:
                            Datum.Add('show_balance', false);
                        else
                            Datum.Add('show_balance', true);
                    end;

                    if SavingsProduct."Is USSD Product" then begin
                        case account_type.AsValue.AsText of
                            'FOSA':
                                begin
                                    if (SavingsProduct.Category = SavingsProduct.Category::"FOSA Account") OR
                                    (SavingsProduct.Category = SavingsProduct.Category::"FOSA Sub Account") then begin
                                        Data.Add(Datum);
                                    end;
                                end;
                            'BOSA':
                                begin
                                    if SavingsProduct.Category = SavingsProduct.Category::"BOSA Account" then begin
                                        Data.Add(Datum);
                                    end;
                                end;
                            'WITHDRAWABLE':
                                begin
                                    if IsWithdrawable then begin
                                        Data.Add(Datum);
                                    end;
                                end;
                            'DEPOSIT':
                                begin
                                    if IsDepositable then begin
                                        Data.Add(Datum);
                                    end;
                                end;
                            'ALL':
                                begin
                                    Data.Add(Datum);
                                end;
                            else
                        end;
                    end;

                    // Reset
                    Datum.ReadFrom('{}');
                end until SavingsAccounts.Next = 0;
            end;

            // Apply charges
            if apply_charges.AsValue.AsBoolean then begin
                TotalCharges := SkyMbankingTrans.GetTransChargesPreview('SINGLE_ACCOUNT_BALANCE_ENQUIRY', 0, '', SearchMember, '').Get(1);
                if TotalCharges > 0 then begin
                    if CheckFOSASavingsAccountBlocked(SearchMember, 'DEBIT') then begin
                        ResponseObject.Add('request_status', 'BLOCKED');
                        Datum.Add('error_message', 'Account is blocked from debit transactions.');
                        ResponseObject.Add('response_payload', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;

                    // Log the transaction
                    FosaAcc := SkyMbankingTrans.GetMemberFosaAcc(SearchMember);

                    FOSAAccount.Reset;
                    FOSAAccount.SetRange("No.", FosaAcc);
                    if FOSAAccount.FindFirst() then begin
                        // INSUFFICIENT_BAL
                        if SkyMbankingTrans.ValidateMinAccountBalance(
                            0,
                            FOSAAccount,
                            'SINGLE_ACCOUNT_BALANCE_ENQUIRY',
                            SearchMember,
                            ''
                        ) then begin
                            ResponseObject.Add('request_status', 'INSUFFICIENT_BAL');
                            Datum.Add('error_message', 'FOSA Account has insufficient balance to complete the transaction.');
                            ResponseObject.Add('response_payload', Datum);

                            AddDateTimeToResponse(ResponseObject);

                            ResponseObject.WriteTo(Response);
                            exit(Response);
                        end;

                        SkyMbankingTrans.LogAccountBalanceEnquiry(
                            APIRequestID.AsValue.AsText,
                            identifier_type.AsValue.AsText,
                            identifier.AsValue.AsText,
                            FosaAcc,
                            SearchMember
                        );
                    end;
                end;
            end;


            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('response_payload', Data);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure ValidateAccount(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        account_number: JsonToken;
        // identifier_type: JsonToken;
        // identifier: JsonToken;

        // SearchMember: Record Members;
        SavingsAccount: Record "Savings Accounts";
        SavingsProduct: Record "Product Factory";
        AccountOwner: Record Members;

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('account_number', account_number);
        // Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        // Payload.Get('identifier', identifier);

        // GetMemberRecord(SearchMember, identifier_type.AsValue.AsText, identifier.AsValue.AsText, '');

        // IF SearchMember.FindFirst then begin
        SavingsAccount.Reset;
        SavingsAccount.FilterGroup := -1;
        SavingsAccount.SetRange("No.", account_number.AsValue.AsText);
        SavingsAccount.SetRange("Old Account No", account_number.AsValue.AsText);

        SavingsAccount.SetLoadFields(
            "Product Type", Name, "No.", "Product Name", Status, "Member No.", "Balance (LCY)", "Product Category"
        );

        if SavingsAccount.FindFirst then begin
            SavingsProduct.Reset;
            SavingsProduct.SetRange("Product ID", SavingsAccount."Product Type");

            Datum.Add('account_name', SavingsAccount.Name);

            SavingsProduct.SetLoadFields(
                "USSD Product Name", "Channels Ext. Transfer Options", "Channels Int. Transfer Options"
            );

            if SavingsProduct.FindFirst and (SavingsProduct."USSD Product Name" <> '') then begin
                Datum.Add('account_label', SavingsProduct."USSD Product Name");
            end else begin
                Datum.Add('account_label', SavingsAccount."Product Name");
            end;

            Datum.Add('account_number', SavingsAccount."No.");
            Datum.Add('account_type', SavingsAccount."Product Type");
            Datum.Add('account_type_name', SavingsAccount."Product Name");
            Datum.Add('account_status', Format(SavingsAccount.Status).ToUpper);

            if SavingsAccount."Product Category" = SavingsAccount."Product Category"::"Share Capital" then begin
                Datum.Add('account_balance', SavingsAccount."Balance (LCY)");
            end else begin
                Datum.Add('account_balance', GlobalFunctions.GetSavingsAccountAvailableBalance(SavingsAccount, true));
            end;

            SavingsAccount.CalcFields("Balance (LCY)");
            Datum.Add('book_balance', SavingsAccount."Balance (LCY)");

            if SavingsProduct.FindFirst then begin
                if (SavingsProduct."Channels Ext. Transfer Options" = SavingsProduct."Channels Ext. Transfer Options"::"All - Deposit + Withdrawal") OR
                (SavingsProduct."Channels Ext. Transfer Options" = SavingsProduct."Channels Ext. Transfer Options"::"Deposit Only") then begin
                    Datum.Add('can_deposit', 'YES');
                end else begin
                    Datum.Add('can_deposit', 'NO');
                end;

                if (SavingsProduct."Channels Int. Transfer Options" = SavingsProduct."Channels Int. Transfer Options"::"All - Deposit + Withdrawal") OR
                (SavingsProduct."Channels Int. Transfer Options" = SavingsProduct."Channels Int. Transfer Options"::"Deposit Only") then begin
                    Datum.Add('can_deposit_ift', 'YES');
                end else begin
                    Datum.Add('can_deposit_ift', 'NO');
                end;
            end;
            Datum.Add('max_deposit_amount', 999999L);

            AccountOwner.Reset;
            AccountOwner.SetRange("No.", SavingsAccount."Member No.");
            AccountOwner.SetLoadFields(
                Name, "Phone No.", "Primary Identification Type", "Primary Identification",
                "Secondary Identification Type", "Secondary Identification"
            );

            if AccountOwner.FindFirst then begin
                MemberDetails.Add('full_name', AccountOwner.Name);
                MemberDetails.Add('mobile_number', AccountOwner."Phone No.");
                if AccountOwner."Primary Identification Type" = AccountOwner."Primary Identification Type"::"ID Number" then begin
                    MemberDetails.Add('id_number', AccountOwner."Primary Identification");
                end else
                    if AccountOwner."Secondary Identification Type" = AccountOwner."Secondary Identification Type"::"ID Number" then begin
                        MemberDetails.Add('id_number', AccountOwner."Secondary Identification");
                    end else begin
                        MemberDetails.Add('id_number', '');
                    end;
                MemberDetails.Add('member_number', AccountOwner."No.");



            end else begin
                MemberDetails.Add('full_name', '');
                MemberDetails.Add('mobile_number', '');
                MemberDetails.Add('id_number', '');
                MemberDetails.Add('member_number', '');

            end;
            Datum.Add('member_details', MemberDetails);

            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('response_payload', Datum);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Account with number ' + account_number.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;
        // end else begin
        //     ResponseObject.Add('request_status', 'ERROR');
        //     Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        //     ResponseObject.Add('response_payload', Datum);
        // end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure BalanceEnquiry(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        account_number: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        SavingsAccount: Record "Savings Accounts";
        FOSAAccount: Record "Savings Accounts";
        FosaAcc: Text;
        TotalCharges: Decimal;

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        // Database.SelectLatestVersion();

        Payload.Get('account_number', account_number);
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);

        GetMemberRecordV2(SearchMember, identifier_type.AsValue.AsText, identifier.AsValue.AsText, '');

        IF SearchMember.FindFirst then begin
            if CheckFOSASavingsAccountBlocked(SearchMember, 'DEBIT') then begin
                ResponseObject.Add('request_status', 'BLOCKED');
                Datum.Add('error_message', 'Account is blocked from debit transactions.');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            SavingsAccount.Reset;
            SavingsAccount.SetRange("No.", account_number.AsValue.AsText);
            SavingsAccount.SetRange("Member No.", SearchMember."No.");

            if SavingsAccount.FindFirst then begin
                TotalCharges := SkyMbankingTrans.GetTransChargesPreview('SINGLE_ACCOUNT_BALANCE_ENQUIRY', 0, SavingsAccount."No.", SearchMember, '').Get(1);
                if TotalCharges > 0 then begin
                    // Log the transaction
                    FosaAcc := SkyMbankingTrans.GetMemberFosaAcc(SearchMember);

                    FOSAAccount.Reset;
                    FOSAAccount.SetRange("No.", FosaAcc);
                    if FOSAAccount.FindFirst() then begin
                        // INSUFFICIENT_BAL
                        if SkyMbankingTrans.ValidateMinAccountBalance(
                            0,
                            FOSAAccount,
                            'SINGLE_ACCOUNT_BALANCE_ENQUIRY',
                            SearchMember,
                            ''
                        ) then begin
                            ResponseObject.Add('request_status', 'INSUFFICIENT_BAL');
                            Datum.Add('error_message', 'FOSA Account has insufficient balance to complete the transaction.');
                            ResponseObject.Add('response_payload', Datum);

                            AddDateTimeToResponse(ResponseObject);

                            ResponseObject.WriteTo(Response);
                            exit(Response);
                        end;

                        SkyMbankingTrans.LogAccountBalanceEnquiry(
                            APIRequestID.AsValue.AsText,
                            identifier_type.AsValue.AsText,
                            identifier.AsValue.AsText,
                            account_number.AsValue.AsText,
                            SearchMember
                        );
                    end;
                end;

                Datum.Add('account_name', SavingsAccount.Name);
                Datum.Add('account_label', SavingsAccount."Product Name");
                Datum.Add('account_number', SavingsAccount."No.");
                Datum.Add('account_type', SavingsAccount."Product Type");

                if SavingsAccount."Product Category" = SavingsAccount."Product Category"::"Share Capital" then begin
                    SavingsAccount.CalcFields("Balance (LCY)");
                    Datum.Add('account_balance', SavingsAccount."Balance (LCY)");
                end else begin
                    Datum.Add('account_balance', GlobalFunctions.GetSavingsAccountAvailableBalance(SavingsAccount, true));
                end;

                SavingsAccount.CalcFields("Balance (LCY)");
                Datum.Add('book_balance', SavingsAccount."Balance (LCY)");

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('response_payload', Datum);
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Account with number ' + account_number.AsValue.AsText + ' NOT found for the given member');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure AccountMiniStatement(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        account_number: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        number_of_transactions: JsonToken;

        SearchMember: Record Members;
        SavingsAccount: Record "Savings Accounts";
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        FOSAAccount: Record "Savings Accounts";

        Count: Integer;
        FosaAcc: Text;
        TotalCharges: Decimal;

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Transactions: JsonArray;
        Transaction: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('account_number', account_number);
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);
        Payload.Get('number_of_transactions', number_of_transactions);

        GetMemberRecordV2(SearchMember, identifier_type.AsValue.AsText, identifier.AsValue.AsText, '');

        IF SearchMember.FindFirst then begin
            if CheckFOSASavingsAccountBlocked(SearchMember, 'DEBIT') then begin
                ResponseObject.Add('request_status', 'BLOCKED');
                Datum.Add('error_message', 'Account is blocked from debit transactions.');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            SavingsAccount.Reset;
            SavingsAccount.SetRange("No.", account_number.AsValue.AsText);
            SavingsAccount.SetRange("Member No.", SearchMember."No.");

            SavingsAccount.SetLoadFields(
                Name, "No.", "Balance (LCY)", "Authorised Over Draft", "Uncleared Cheques", "ATM Transactions", "Lien Placed", "Product Category"
            );
            SavingsAccount.SetAutoCalcFields("Balance (LCY)", "Authorised Over Draft", "Uncleared Cheques", "ATM Transactions", "Lien Placed");

            if SavingsAccount.FindFirst then begin
                TotalCharges := SkyMbankingTrans.GetTransChargesPreview('ACCOUNT_MINI_STATEMENT', 0, SavingsAccount."No.", SearchMember, '').Get(1);
                FosaAcc := SkyMbankingTrans.GetMemberFosaAcc(SearchMember);
                if TotalCharges > 0 then begin
                    FOSAAccount.Reset;
                    FOSAAccount.SetRange("No.", FosaAcc);
                    if FOSAAccount.FindFirst() then begin
                        // INSUFFICIENT_BAL
                        if SkyMbankingTrans.ValidateMinAccountBalance(
                            0,
                            FOSAAccount,
                            'ACCOUNT_MINI_STATEMENT',
                            SearchMember,
                            ''
                        ) then begin
                            ResponseObject.Add('request_status', 'INSUFFICIENT_BAL');
                            Datum.Add('error_message', 'FOSA Account has insufficient balance to complete the transaction.');
                            ResponseObject.Add('response_payload', Datum);

                            AddDateTimeToResponse(ResponseObject);

                            ResponseObject.WriteTo(Response);
                            exit(Response);
                        end;
                    end;
                end;

                Datum.Add('account_name', SavingsAccount.Name);
                Datum.Add('account_number', SavingsAccount."No.");

                if SavingsAccount."Product Category" = SavingsAccount."Product Category"::"Share Capital" then begin
                    Datum.Add('available_balance', SavingsAccount."Balance (LCY)");
                end else begin
                    Datum.Add('available_balance', GlobalFunctions.GetSavingsAccountAvailableBalance(SavingsAccount, false));
                end;

                Datum.Add('book_balance', SavingsAccount."Balance (LCY)");

                SavingsLedgerEntry.Reset;
                SavingsLedgerEntry.SetCurrentkey("Entry No.");
                SavingsLedgerEntry.Ascending(false);
                SavingsLedgerEntry.SetRange("Customer No.", SavingsAccount."No.");

                SavingsLedgerEntry.SetLoadFields(
                    "Document No.", "Posting Date", "Posting Time", "Amount (LCY)",
                    "Entry No.", "Customer No.", Description
                );

                IF SavingsLedgerEntry.FindSet then begin
                    repeat begin
                        Count += 1;

                        Transaction.Add('transaction_reference', SavingsLedgerEntry."Document No.");
                        Transaction.Add('transaction_date', GlobalFunctions.FormatISODate(SavingsLedgerEntry."Posting Date"));
                        Transaction.Add('transaction_time', GlobalFunctions.FormatISOTime(SavingsLedgerEntry."Posting Time"));

                        if SavingsLedgerEntry."Amount (LCY)" < 0 then begin
                            Transaction.Add('transaction_amount', Abs(SavingsLedgerEntry."Amount (LCY)"));
                            Transaction.Add('transaction_type', 'CREDIT');
                        end else begin
                            Transaction.Add('transaction_amount', SavingsLedgerEntry."Amount (LCY)");
                            Transaction.Add('transaction_type', 'DEBIT');
                        end;

                        Transaction.Add('running_balance', GlobalFunctions.GetRunningBalance(SavingsLedgerEntry."Entry No.", SavingsLedgerEntry."Customer No."));
                        Transaction.Add('transaction_description', SavingsLedgerEntry.Description);
                        Transaction.Add('other_details', SavingsLedgerEntry.Description);

                        Transactions.Add(Transaction);
                        // Reset
                        Transaction.ReadFrom('{}');
                    end until (Count = number_of_transactions.AsValue.AsInteger) or (SavingsLedgerEntry.Next = 0);
                end;

                Datum.Add('transactions', Transactions);

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('response_payload', Datum);

                // Log the transaction
                // Currently MNS only FOSA account balance enquiry is charged
                if TotalCharges > 0 then begin
                    if FosaAcc = SavingsAccount."No." then begin
                        SkyMbankingTrans.LogAccountMiniStatement(
                            APIRequestID.AsValue.AsText,
                            identifier_type.AsValue.AsText,
                            identifier.AsValue.AsText,
                            account_number.AsValue.AsText,
                            SearchMember
                        );
                    end;
                end;
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Account with number ' + account_number.AsValue.AsText + ' NOT found for the given member');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure AccountFullStatement(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        account_number: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        start_date: JsonToken;
        end_date: JsonToken;

        SearchMember: Record Members;
        SavingsAccount: Record "Savings Accounts";
        SavingsLedgerEntry: Record "Savings Ledger Entry";

        FosaAcc: Text;
        FosaAccount: Record "Savings Accounts";
        TotalCharges: Decimal;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Transactions: JsonArray;
        Transaction: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('account_number', account_number);
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        GetMemberRecordV2(SearchMember, identifier_type.AsValue.AsText, identifier.AsValue.AsText, '');

        IF SearchMember.FindFirst then begin
            if CheckFOSASavingsAccountBlocked(SearchMember, 'DEBIT') then begin
                ResponseObject.Add('request_status', 'BLOCKED');
                Datum.Add('error_message', 'Account is blocked from debit transactions.');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            SavingsAccount.Reset;
            SavingsAccount.SetRange("No.", account_number.AsValue.AsText);
            SavingsAccount.SetRange("Member No.", SearchMember."No.");

            SavingsAccount.SetLoadFields(
                Name, "No.", "Balance (LCY)", "Authorised Over Draft", "Uncleared Cheques", "ATM Transactions", "Lien Placed", "Product Category"
            );
            SavingsAccount.SetAutoCalcFields("Balance (LCY)", "Authorised Over Draft", "Uncleared Cheques", "ATM Transactions", "Lien Placed");

            if SavingsAccount.FindFirst then begin
                TotalCharges := SkyMbankingTrans.GetTransChargesPreview('ACCOUNT_FULL_STATEMENT', 0, SavingsAccount."No.", SearchMember, '').Get(1);
                FosaAcc := SkyMbankingTrans.GetMemberFosaAcc(SearchMember);

                if TotalCharges > 0 then begin
                    FosaAccount.Reset;
                    FosaAccount.SetRange("No.", FosaAcc);
                    if FosaAccount.FindFirst then begin
                        // INSUFFICIENT_BAL
                        if SkyMbankingTrans.ValidateMinAccountBalance(
                            0,
                            FosaAccount,
                            'ACCOUNT_FULL_STATEMENT',
                            SearchMember,
                            ''
                        ) then begin
                            ResponseObject.Add('request_status', 'INSUFFICIENT_BAL');
                            Datum.Add('error_message', 'Account has insufficient balance to complete the transaction.');
                            ResponseObject.Add('response_payload', Datum);

                            AddDateTimeToResponse(ResponseObject);

                            ResponseObject.WriteTo(Response);
                            exit(Response);
                        end;
                    end;
                end;

                Datum.Add('account_name', SavingsAccount.Name);
                Datum.Add('account_number', SavingsAccount."No.");

                if SavingsAccount."Product Category" = SavingsAccount."Product Category"::"Share Capital" then begin
                    Datum.Add('available_balance', SavingsAccount."Balance (LCY)");
                end else begin
                    Datum.Add('available_balance', GlobalFunctions.GetSavingsAccountAvailableBalance(SavingsAccount, false));
                end;

                Datum.Add('book_balance', SavingsAccount."Balance (LCY)");

                SavingsLedgerEntry.Reset;
                SavingsLedgerEntry.SetCurrentkey("Entry No.");
                SavingsLedgerEntry.Ascending(false);
                SavingsLedgerEntry.SetRange("Customer No.", SavingsAccount."No.");

                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));

                SavingsLedgerEntry.SetFilter("Posting Date", '>=%1&<=%2', StartDate, EndDate);

                SavingsLedgerEntry.SetLoadFields(
                    "Document No.", "Posting Date", "Posting Time", "Amount (LCY)",
                    "Entry No.", "Customer No.", Description
                );

                IF SavingsLedgerEntry.FindSet then begin
                    repeat begin
                        Transaction.Add('transaction_reference', SavingsLedgerEntry."Document No.");
                        Transaction.Add('transaction_date', GlobalFunctions.FormatISODate(SavingsLedgerEntry."Posting Date"));
                        Transaction.Add('transaction_time', GlobalFunctions.FormatISOTime(SavingsLedgerEntry."Posting Time"));

                        if SavingsLedgerEntry."Amount (LCY)" < 0 then begin
                            Transaction.Add('transaction_amount', Abs(SavingsLedgerEntry."Amount (LCY)"));
                            Transaction.Add('transaction_type', 'CREDIT');
                        end else begin
                            Transaction.Add('transaction_amount', SavingsLedgerEntry."Amount (LCY)");
                            Transaction.Add('transaction_type', 'DEBIT');
                        end;

                        Transaction.Add('running_balance', GlobalFunctions.GetRunningBalance(SavingsLedgerEntry."Entry No.", SavingsLedgerEntry."Customer No."));
                        Transaction.Add('transaction_description', SavingsLedgerEntry.Description);
                        Transaction.Add('other_details', SavingsLedgerEntry.Description);

                        Transactions.Add(Transaction);
                        // Reset
                        Transaction.ReadFrom('{}');
                    end until (SavingsLedgerEntry.Next = 0);
                end;

                Datum.Add('transactions', Transactions);

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('response_payload', Datum);

                if TotalCharges > 0 then begin
                    // Log the transaction
                    SkyMbankingTrans.LogAccountFullStatement(
                        APIRequestID.AsValue.AsText,
                        identifier_type.AsValue.AsText,
                        identifier.AsValue.AsText,
                        account_number.AsValue.AsText,
                        SearchMember
                    );
                end;
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Account with number ' + account_number.AsValue.AsText + ' NOT found for the given member');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    // Withdrawal ------------------------------------------------------------------------------------------------------------------
    local procedure Withdrawal(Payload: JsonObject; APIRequestID: JsonToken): Text
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

        MpesaTrans: Record "Sky M-Banking Trans. Buffer";
        SourceSavingsAccount: Record "Savings Accounts";
        InitiatorMember: Record Members;
        SavingsProduct: Record "Product Factory";
        IsSourceAccActive: Boolean;
        theSMS: Text;
        WithdrawalLimit: Record "E-Channels Transaction Setup";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
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

        GetMemberRecordV2(InitiatorMember, transaction_initiator_details_identifier_type.AsValue.AsText, transaction_initiator_details_identifier.AsValue.AsText, '');

        // if not GlobalFunctions.CheckMemberSubflagTransactionAbility(InitiatorMember."No.") then begin
        //     ResponseObject.Add('request_status', 'BLOCKED');
        //     Datum.Add('error_message', 'The member is NOT allowed to transact. Current sub-flag status is ' + Format(InitiatorMember.Subflag));
        //     ResponseObject.Add('response_payload', Datum);

        //     AddDateTimeToResponse(ResponseObject);

        //     ResponseObject.WriteTo(Response);

        //     exit(Response);
        // end;

        // Validations
        if amount.AsValue.AsDecimal <= 0 then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Transaction amount must be greater than zero');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;

        // DUPLICATE
        MpesaTrans.Reset;
        MpesaTrans.SetRange(MpesaTrans."Originator ID", originator_id.AsValue.AsText);

        MpesaTrans.SetLoadFields("Originator ID");

        if MpesaTrans.FindFirst then begin
            ResponseObject.Add('request_status', 'DUPLICATE');
            Datum.Add('error_message', 'This transaction already exists. Originator ID = ' + MpesaTrans."Originator ID");
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // INVALID_ACCOUNT
        SourceSavingsAccount.Reset;
        SourceSavingsAccount.SetRange("No.", transaction_source_details_account.AsValue.AsText);

        SourceSavingsAccount.SetLoadFields(
            "Product Type",
            "Member No.",
            Status,
            Blocked,
            "Balance (LCY)",
                "Authorised Over Draft",
                "Uncleared Cheques",
                "ATM Transactions",
                "Lien Placed",
                "Coop Transactions",
                "One Month Installment"
        );

        if not SourceSavingsAccount.FindFirst then begin
            ResponseObject.Add('request_status', 'INVALID_ACCOUNT');
            Datum.Add('error_message', 'Account with identifier number ' + transaction_source_details_account.AsValue.AsText + ' does not exist!');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end else begin
            // Is withdrawable?
            SavingsProduct.Reset;
            SavingsProduct.SetRange("Product ID", SourceSavingsAccount."Product Type");

            SavingsProduct.SetLoadFields(
                "Channels Ext. Transfer Options"
            );

            if SavingsProduct.FindFirst then begin
                if (SavingsProduct."Channels Ext. Transfer Options" = SavingsProduct."Channels Ext. Transfer Options"::"Deposit Only") OR
            (SavingsProduct."Channels Ext. Transfer Options" = SavingsProduct."Channels Ext. Transfer Options"::None)
            then begin
                    ResponseObject.Add('request_status', 'INVALID_ACCOUNT');
                    Datum.Add('error_message', 'Account with identifier number ' + transaction_source_details_account.AsValue.AsText + ' is NOT withdrawable!');
                    ResponseObject.Add('response_payload', Datum);

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end;

            // Does it belong to the member?
            if SourceSavingsAccount."Member No." <> InitiatorMember."No." then begin
                ResponseObject.Add('request_status', 'INVALID_ACCOUNT');
                Datum.Add('error_message', 'Account with identifier number ' + transaction_source_details_account.AsValue.AsText + ' does NOT belong to the given member');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // Is it active?
            case SourceSavingsAccount.Status of
                SourceSavingsAccount.Status::Active, SourceSavingsAccount.Status::New:
                    IsSourceAccActive := true;
                else
                    IsSourceAccActive := false;
            end;

            if not IsSourceAccActive then begin
                ResponseObject.Add('request_status', 'ACCOUNT_NOT_ACTIVE');
                Datum.Add('error_message', 'Account with identifier number ' + transaction_source_details_account.AsValue.AsText + ' is NOT active. Current status is ' + Format(SourceSavingsAccount.Status));
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // BLOCKED
            if (SourceSavingsAccount.Blocked = SourceSavingsAccount.Blocked::All) OR
            (SourceSavingsAccount.Blocked = SourceSavingsAccount.Blocked::Debit) then begin
                ResponseObject.Add('request_status', 'BLOCKED');
                Datum.Add('error_message', 'Account with identifier number ' + transaction_source_details_account.AsValue.AsText + ' is blocked from withdrawal transactions.');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // INSUFFICIENT_BAL
            if SkyMbankingTrans.ValidateMinAccountBalance(
                amount.AsValue.AsDecimal,
                SourceSavingsAccount,
                category.AsValue.AsText,
                InitiatorMember,
                transaction_receiver_details_identifier.AsValue.AsText
            )
             then begin
                ResponseObject.Add('request_status', 'INSUFFICIENT_BAL');
                Datum.Add('error_message', 'Account has insufficient balance to complete the transaction.');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // WITHDRAWAL_LIMIT_VIOLATION
            WithdrawalLimit.FindFirst;

            if SkyMbankingTrans.CheckWithdrawalTransactionLimitViolation(
                amount.AsValue.AsDecimal,
                SourceSavingsAccount,
                WithdrawalLimit
            )
             then begin
                ResponseObject.Add('request_status', 'WITHDRAWAL_LIMIT_VIOLATION');
                Datum.Add('error_message', 'The requested transaction amount exceeds the maximum withdrawal limit of KES ' + Format(WithdrawalLimit."Mobile Withdrawal Limit"));
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            if SkyMbankingTrans.CheckWithdrawalDailyTransactionLimitViolation(
                amount.AsValue.AsDecimal,
                SourceSavingsAccount,
                WithdrawalLimit
            )
             then begin
                ResponseObject.Add('request_status', 'WITHDRAWAL_LIMIT_VIOLATION');
                Datum.Add('error_message', 'The requested transaction amount exceeds the maximum daily withdrawal limit of KES ' + Format(WithdrawalLimit."Mobile Daily Withdrawal Limit"));
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end;

        // Log the transaction
        MpesaTrans.Reset;
        SkyMbankingTrans.LogWithdrawalRequest(MpesaTrans, Payload, APIRequestID);

        // Handle required validation
        if MpesaTrans.Insert(true) then begin
            Commit;

            ResponseObject.Add('request_status', 'SUCCESS');

            Datum.Add('transaction_reference', MpesaTrans."Transaction ID");
            Datum.Add('transaction_status_description', 'Withdrawal processed successfully');
            Datum.Add('transaction_status_date_time', GlobalFunctions.FormatISODateTime(CurrentDateTime));

            ResponseObject.Add('response_payload', Datum);

            // SMS
            /*
            theSMS := 'Dear member, your ' +
            Format(MpesaTrans."Transaction Type") +
            ' request of KES ' +
            Format(MpesaTrans."Transaction Amount") +
            ' has been received successfully. Kindly wait shortly as we process this request. Transaction ID: ' +
            MpesaTrans."Transaction Source Reference";

            SkySMS.SendSms(
                SMSSource::WITHDRAWAL,
                MpesaTrans."Initiator Identifier",
                theSMS,
                MpesaTrans."Transaction Source Reference",
                '',
                true,
                0,
                true,
                'MBANKING',
                MpesaTrans."Originator ID",
                'CBS'
            );
            */
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Unable to insert MPESA transaction');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure WithdrawalResult(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        originator_id: JsonToken;
        transaction_status: JsonToken;
        transaction_status_description: JsonToken;

        // Beneficiary
        transaction_beneficiary_details_identifier_type: JsonToken;
        transaction_beneficiary_details_identifier: JsonToken;
        transaction_beneficiary_details_name: JsonToken;
        transaction_beneficiary_details_other_details: JsonToken;

        beneficiary_reference: JsonToken;
        transaction_date_time: JsonToken;

        MpesaTrans: Record "Sky M-Banking Trans. Buffer";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
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

        // Check initial withdrawal request exists
        MpesaTrans.Reset;
        MpesaTrans.SetRange("Originator ID", originator_id.AsValue.AsText);
        // MpesaTrans.SetRange("Transaction ID", originator_id.AsValue.AsText);

        if MpesaTrans.FindFirst then begin
            // Check if duplicate
            if MpesaTrans.Posted then begin
                ResponseObject.Add('request_status', 'DUPLICATE');

                Datum.Add('transaction_status', 'DUPLICATE');
                Datum.Add('transaction_status_description', 'Transaction with Originator ID ' + originator_id.AsValue.AsText + ' has already been posted');
                Datum.Add('transaction_status_date_time', GlobalFunctions.FormatISODateTime(CurrentDateTime));

                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end else begin
                SkyMbankingTrans.ProcessWithdrawalResult(Payload, APIRequestID, MpesaTrans);

                ResponseObject.Add('request_status', 'SUCCESS');

                Datum.Add('transaction_status', 'SUCCESS');
                Datum.Add('transaction_status_description', 'Result processed successfully');
                Datum.Add('transaction_status_date_time', GlobalFunctions.FormatISODateTime(CurrentDateTime));

                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end else begin
            ResponseObject.Add('request_status', 'FAILED');

            Datum.Add('transaction_status', 'FAILED');
            Datum.Add('transaction_status_description', 'Transaction with Originator ID ' + originator_id.AsValue.AsText + ' does not exist!');
            Datum.Add('transaction_status_date_time', GlobalFunctions.FormatISODateTime(CurrentDateTime));

            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        ResponseObject.Add('request_status', 'ERROR');

        Datum.Add('transaction_status', 'ERROR');
        Datum.Add('transaction_status_description', 'Error. Unable to process the transaction at the moment');
        Datum.Add('transaction_status_date_time', GlobalFunctions.FormatISODateTime(CurrentDateTime));

        ResponseObject.Add('response_payload', Datum);

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    // IFT -------------------------------------------------------------------------------------------------------------------------
    local procedure IFTAccountToAccount(Payload: JsonObject; APIRequestID: JsonToken): Text
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

        InitiatorMember: Record Members;
        SourceSavingsAccount: Record "Savings Accounts";
        IsSourceAccActive: Boolean;
        DestinationSavingsAccount: Record "Savings Accounts";
        IsDestinationAccActive: Boolean;
        SavingsProduct: Record "Product Factory";
        MpesaTrans: Record "Sky M-Banking Trans. Buffer";

        MobileTransTypes: Record "Mobile Transaction Types";
        MobileTransLines: Record "Mobile Transaction Types Lines";
        TotalCharges: Decimal;
        currCharges: List of [decimal];

        IsSharesTrading: Boolean;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
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

        GetMemberRecordV2(
           InitiatorMember,
           identifier_type.AsValue.AsText,
           identifier.AsValue.AsText,
           'Transaction initiator');

        // if not GlobalFunctions.CheckMemberSubflagTransactionAbility(InitiatorMember."No.") then begin
        //     // Support shares trading
        //     if InitiatorMember.Subflag <> InitiatorMember.Subflag::Withdrawal then begin
        //         ResponseObject.Add('request_status', 'BLOCKED');
        //         Datum.Add('error_message', 'The member is NOT allowed to transact. Current sub-flag status is ' + Format(InitiatorMember.Subflag));
        //         ResponseObject.Add('response_payload', Datum);

        //         AddDateTimeToResponse(ResponseObject);

        //         ResponseObject.WriteTo(Response);

        //         exit(Response);
        //     end;
        // end;

        // Validations
        if amount.AsValue.AsDecimal <= 0 then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Transaction amount must be greater than zero');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;

        if source_account.AsValue.AsText = destination_account.AsValue.AsText then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Source account and destination account must be different');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;

        // DUPLICATE / IFT_REQUEST_EXISTS
        MpesaTrans.Reset;
        MpesaTrans.SetRange(MpesaTrans."Originator ID", originator_id.AsValue.AsText);
        MpesaTrans.SetLoadFields("Originator ID");

        if MpesaTrans.FindFirst then begin
            ResponseObject.Add('request_status', 'IFT_REQUEST_EXISTS');
            Datum.Add('error_message', 'This transaction already exists. Originator ID = ' + MpesaTrans."Originator ID");
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // Source Account
        SourceSavingsAccount.Reset;
        SourceSavingsAccount.SetRange("No.", source_account.AsValue.AsText);

        SourceSavingsAccount.SetLoadFields(
            "Product Type", "Member No.", Status, Blocked,
            "Balance (LCY)",
                "Authorised Over Draft",
                "Uncleared Cheques",
                "ATM Transactions",
                "Lien Placed",
                "Coop Transactions",
                "One Month Installment"
        );

        if not SourceSavingsAccount.FindFirst then begin
            // ACCOUNT_NOT_FOUND
            ResponseObject.Add('request_status', 'ACCOUNT_NOT_FOUND');
            Datum.Add('error_message', 'Account with identifier number ' + source_account.AsValue.AsText + ' does not exist!');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end else begin
            // Is withdrawable?
            SavingsProduct.Reset;
            SavingsProduct.SetRange("Product ID", SourceSavingsAccount."Product Type");

            SavingsProduct.SetLoadFields("Channels Int. Transfer Options");

            if SavingsProduct.FindFirst then begin
                // Determine if it is shares trading process
                if SavingsProduct."Product Category" = SavingsProduct."Product Category"::"Share Capital" then begin
                    IsSharesTrading := true;
                end;

                if (SavingsProduct."Channels Int. Transfer Options" = SavingsProduct."Channels Int. Transfer Options"::"Deposit Only") OR
            (SavingsProduct."Channels Int. Transfer Options" = SavingsProduct."Channels Int. Transfer Options"::None)
            then begin
                    ResponseObject.Add('request_status', 'INVALID_ACCOUNT');
                    Datum.Add('error_message', 'Account with identifier number ' + source_account.AsValue.AsText + ' is NOT withdrawable!');
                    ResponseObject.Add('response_payload', Datum);

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end;

            // Does it belong to the member?
            if SourceSavingsAccount."Member No." <> InitiatorMember."No." then begin
                ResponseObject.Add('request_status', 'INVALID_ACCOUNT');
                Datum.Add('error_message', 'Account with identifier number ' + source_account.AsValue.AsText + ' does NOT belong to the given member');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // Is it active?
            case SourceSavingsAccount.Status of
                SourceSavingsAccount.Status::Active, SourceSavingsAccount.Status::New:
                    IsSourceAccActive := true;
                else
                    IsSourceAccActive := false;
            end;

            if IsSharesTrading then begin
                IsSourceAccActive := true;
            end;

            // if SavingsProduct."Product Category" = SavingsProduct."Product Category"::Kesasa then begin
            //     IsSourceAccActive := true;
            // end;

            if not IsSourceAccActive then begin
                ResponseObject.Add('request_status', 'ACCOUNT_NOT_ACTIVE');
                Datum.Add('error_message', 'Account with identifier number ' + source_account.AsValue.AsText + ' is NOT active. Current status is ' + Format(SourceSavingsAccount.Status));
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // BLOCKED
            if (SourceSavingsAccount.Blocked = SourceSavingsAccount.Blocked::All) OR
            (SourceSavingsAccount.Blocked = SourceSavingsAccount.Blocked::Debit) then begin
                ResponseObject.Add('request_status', 'BLOCKED');
                Datum.Add('error_message', 'Account with identifier number ' + source_account.AsValue.AsText + ' is blocked from withdrawal transactions.');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // INSUFFICIENT_BAL
            if SkyMbankingTrans.ValidateMinAccountBalance(
                amount.AsValue.AsDecimal,
                SourceSavingsAccount,
                'IFT_ACCOUNT_TO_ACCOUNT',
                InitiatorMember,
                ''
            ) then begin
                ResponseObject.Add('request_status', 'INSUFFICIENT_BAL');
                Datum.Add('error_message', 'Account has insufficient balance to complete the transaction.');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end;

        // Destination Account
        DestinationSavingsAccount.Reset;
        DestinationSavingsAccount.SetRange("No.", destination_account.AsValue.AsText);

        DestinationSavingsAccount.SetLoadFields(
            "Product Type", Blocked
        );
        if not DestinationSavingsAccount.FindFirst then begin
            // ACCOUNT_NOT_FOUND
            ResponseObject.Add('request_status', 'ACCOUNT_NOT_FOUND');
            Datum.Add('error_message', 'Destination account with identifier number ' + destination_account.AsValue.AsText + ' does not exist!');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end else begin
            // Is depositable?
            SavingsProduct.Reset;
            SavingsProduct.SetRange("Product ID", DestinationSavingsAccount."Product Type");

            SavingsProduct.SetLoadFields("Channels Int. Transfer Options");

            if SavingsProduct.FindFirst then begin
                // Destination account must be share capital for shares trading process!
                if IsSharesTrading then begin
                    if SavingsProduct."Product Category" <> SavingsProduct."Product Category"::"Share Capital" then begin
                        ResponseObject.Add('request_status', 'INVALID_ACCOUNT');
                        Datum.Add('error_message', 'Destination account with identifier number ' + destination_account.AsValue.AsText + ' must be a share capital account!');
                        ResponseObject.Add('response_payload', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
                end;

                if (SavingsProduct."Channels Int. Transfer Options" = SavingsProduct."Channels Int. Transfer Options"::"Withdrawals Only") OR
            (SavingsProduct."Channels Int. Transfer Options" = SavingsProduct."Channels Int. Transfer Options"::None)
            then begin
                    ResponseObject.Add('request_status', 'INVALID_ACCOUNT');
                    Datum.Add('error_message', 'Destination account with identifier number ' + destination_account.AsValue.AsText + ' does NOT allow deposits!');
                    ResponseObject.Add('response_payload', Datum);

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end;

            // Is it active?
            // case DestinationSavingsAccount.Status of
            //     DestinationSavingsAccount.Status::Active, DestinationSavingsAccount.Status::New:
            //         IsDestinationAccActive := true;
            //     else
            //         IsDestinationAccActive := false;
            // end;

            // if not IsDestinationAccActive then begin
            //     ResponseObject.Add('request_status', 'DEST_ACCOUNT_NOT_ACTIVE');
            //     Datum.Add('error_message', 'Destination account with identifier number ' + destination_account.AsValue.AsText + ' is NOT active. Current status is ' + Format(DestinationSavingsAccount.Status));
            //     ResponseObject.Add('response_payload', Datum);

            //     AddDateTimeToResponse(ResponseObject);

            //     ResponseObject.WriteTo(Response);
            //     exit(Response);
            // end;

            // BLOCKED
            if (DestinationSavingsAccount.Blocked = DestinationSavingsAccount.Blocked::All) OR
            (DestinationSavingsAccount.Blocked = DestinationSavingsAccount.Blocked::Credit) then begin
                ResponseObject.Add('request_status', 'BLOCKED');
                Datum.Add('error_message', 'Destination account with identifier number ' + destination_account.AsValue.AsText + ' is blocked from deposit transactions.');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end;

        // Process the request
        MpesaTrans.Reset;
        SkyMbankingTrans.LogIFTAccountToAccount(MpesaTrans, Payload, APIRequestID);

        MobileTransTypes.Reset;
        MobileTransTypes.SetRange(Type, MpesaTrans."Transaction Type");
        if MobileTransTypes.FindFirst then begin

            MobileTransLines.Reset();
            MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);
            MobileTransLines.SetFilter("Account No.", '<>%1', '');
            if MobileTransLines.Findset() then begin
                TotalCharges := 0;
                repeat
                    currCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, amount.AsValue.AsDecimal);
                    TotalCharges += currCharges.Get(1);
                until MobileTransLines.next = 0;
            end;
        end;

        if amount.AsValue.AsDecimal <= TotalCharges then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Transaction amount must be greater than ' + Format(TotalCharges));
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;

        if MpesaTrans.Insert(true) then begin
            Commit;

            ResponseObject.Add('request_status', 'SUCCESS');

            Datum.Add('transaction_reference', MpesaTrans."Transaction ID");
            Datum.Add('transaction_status', 'SUCCESS');
            Datum.Add('transaction_status_description', 'Internal Funds Transfer request received successfully');
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Unable to process the transaction at the moment');
        end;

        ResponseObject.Add('response_payload', Datum);

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure IFTLoanRepayment(Payload: JsonObject; APIRequestID: JsonToken): Text
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

        InitiatorMember: Record Members;
        SourceSavingsAccount: Record "Savings Accounts";
        IsSourceAccActive: Boolean;
        DestinationLoanAccount: Record Loans;
        IsDestinationAccActive: Boolean;
        SavingsProduct: Record "Product Factory";
        MpesaTrans: Record "Sky M-Banking Trans. Buffer";

        MobileTransTypes: Record "Mobile Transaction Types";
        MobileTransLines: Record "Mobile Transaction Types Lines";
        TotalCharges: Decimal;
        currCharges: List of [decimal];

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
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

        GetMemberRecordV2(
            InitiatorMember,
            identifier_type.AsValue.AsText,
            identifier.AsValue.AsText,
            'Transaction initiator');

        // if not GlobalFunctions.CheckMemberSubflagTransactionAbility(InitiatorMember."No.") then begin
        //     ResponseObject.Add('request_status', 'BLOCKED');
        //     Datum.Add('error_message', 'The member is NOT allowed to transact. Current sub-flag status is ' + Format(InitiatorMember.Subflag));
        //     ResponseObject.Add('response_payload', Datum);

        //     AddDateTimeToResponse(ResponseObject);

        //     ResponseObject.WriteTo(Response);

        //     exit(Response);
        // end;

        // Validations
        if amount.AsValue.AsDecimal <= 0 then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Transaction amount must be greater than zero');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;

        // DUPLICATE / IFT_REQUEST_EXISTS
        MpesaTrans.Reset;
        MpesaTrans.SetRange(MpesaTrans."Originator ID", originator_id.AsValue.AsText);
        MpesaTrans.SetLoadFields("Originator ID");
        if MpesaTrans.FindFirst then begin
            ResponseObject.Add('request_status', 'IFT_REQUEST_EXISTS');
            Datum.Add('error_message', 'This transaction already exists. Originator ID = ' + MpesaTrans."Originator ID");
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // Source Account
        SourceSavingsAccount.Reset;
        SourceSavingsAccount.SetRange("No.", source_account.AsValue.AsText);

        SourceSavingsAccount.SetLoadFields(
            "Product Type", "Member No.", Status, Blocked,
            "Balance (LCY)",
            "Authorised Over Draft",
            "Uncleared Cheques",
            "ATM Transactions",
            "Lien Placed",
            "Coop Transactions",
            "One Month Installment"
        );

        if not SourceSavingsAccount.FindFirst then begin
            // ACCOUNT_NOT_FOUND
            ResponseObject.Add('request_status', 'ACCOUNT_NOT_FOUND');
            Datum.Add('error_message', 'Account with identifier number ' + source_account.AsValue.AsText + ' does not exist!');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end else begin
            // Is withdrawable?
            SavingsProduct.Reset;
            SavingsProduct.SetRange("Product ID", SourceSavingsAccount."Product Type");

            SavingsProduct.SetLoadFields("Channels Int. Transfer Options");

            if SavingsProduct.FindFirst then begin
                if (SavingsProduct."Channels Int. Transfer Options" = SavingsProduct."Channels Int. Transfer Options"::"Deposit Only") OR
            (SavingsProduct."Channels Int. Transfer Options" = SavingsProduct."Channels Int. Transfer Options"::None)
            then begin
                    ResponseObject.Add('request_status', 'INVALID_ACCOUNT');
                    Datum.Add('error_message', 'Account with identifier number ' + source_account.AsValue.AsText + ' is NOT withdrawable!');
                    ResponseObject.Add('response_payload', Datum);

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end;

            // Does it belong to the member?
            if SourceSavingsAccount."Member No." <> InitiatorMember."No." then begin
                ResponseObject.Add('request_status', 'INVALID_ACCOUNT');
                Datum.Add('error_message', 'Account with identifier number ' + source_account.AsValue.AsText + ' does NOT belong to the given member');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // Is it active?
            case SourceSavingsAccount.Status of
                SourceSavingsAccount.Status::Active, SourceSavingsAccount.Status::New:
                    IsSourceAccActive := true;
                else
                    IsSourceAccActive := false;
            end;

            if not IsSourceAccActive then begin
                ResponseObject.Add('request_status', 'ACCOUNT_NOT_ACTIVE');
                Datum.Add('error_message', 'Account with identifier number ' + source_account.AsValue.AsText + ' is NOT active. Current status is ' + Format(SourceSavingsAccount.Status));
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // BLOCKED
            if (SourceSavingsAccount.Blocked = SourceSavingsAccount.Blocked::All) OR
            (SourceSavingsAccount.Blocked = SourceSavingsAccount.Blocked::Debit) then begin
                ResponseObject.Add('request_status', 'BLOCKED');
                Datum.Add('error_message', 'Account with identifier number ' + source_account.AsValue.AsText + ' is blocked from withdrawal transactions.');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // INSUFFICIENT_BAL
            if SkyMbankingTrans.ValidateMinAccountBalance(
                amount.AsValue.AsDecimal,
                SourceSavingsAccount,
                'IFT_LOAN_REPAYMENT',
                InitiatorMember,
                ''
            ) then begin
                ResponseObject.Add('request_status', 'INSUFFICIENT_BAL');
                Datum.Add('error_message', 'Account has insufficient balance to complete the transaction.');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end;

        // Destination Account - Loan
        DestinationLoanAccount.Reset;
        DestinationLoanAccount.SetRange("Loan No.", destination_account.AsValue.AsText);

        DestinationLoanAccount.SetLoadFields(Status, Posted);

        if not DestinationLoanAccount.FindFirst then begin
            // ACCOUNT_NOT_FOUND
            ResponseObject.Add('request_status', 'ACCOUNT_NOT_FOUND');
            Datum.Add('error_message', 'Loan account with identifier number ' + destination_account.AsValue.AsText + ' does not exist!');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end else begin
            // Is it active?
            case DestinationLoanAccount.Status of
                DestinationLoanAccount.Status::Approved:
                    IsDestinationAccActive := true;
                else
                    IsDestinationAccActive := false;
            end;

            if DestinationLoanAccount.Posted = false then begin
                IsDestinationAccActive := false;
            end else begin
                IsDestinationAccActive := true;
            end;

            if not IsDestinationAccActive then begin
                ResponseObject.Add('request_status', 'DEST_ACCOUNT_NOT_ACTIVE');
                Datum.Add('error_message', 'Loan account with identifier number ' + destination_account.AsValue.AsText + ' is NOT approved. Current status is ' + Format(DestinationLoanAccount.Status));
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end;

        MpesaTrans.Reset;
        SkyMbankingTrans.LogIFTLoanRepayment(MpesaTrans, Payload, APIRequestID);

        MobileTransTypes.Reset;
        MobileTransTypes.SetRange(Type, MpesaTrans."Transaction Type");
        if MobileTransTypes.FindFirst then begin

            MobileTransLines.Reset();
            MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);
            MobileTransLines.SetFilter("Account No.", '<>%1', '');
            if MobileTransLines.Findset() then begin
                TotalCharges := 0;
                repeat
                    currCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, amount.AsValue.AsDecimal);
                    TotalCharges += currCharges.Get(1);
                until MobileTransLines.next = 0;
            end;
        end;

        if amount.AsValue.AsDecimal <= TotalCharges then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Transaction amount must be greater than ' + Format(TotalCharges));
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;

        if MpesaTrans.Insert(true) then begin
            Commit;

            ResponseObject.Add('request_status', 'SUCCESS');

            Datum.Add('transaction_reference', MpesaTrans."Transaction ID");
            Datum.Add('transaction_status', 'SUCCESS');
            Datum.Add('transaction_status_description', 'Internal Loan Repayment request received successfully');
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Unable to process the transaction at the moment');
        end;

        ResponseObject.Add('response_payload', Datum);

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    // Paybill Deposits------------------------------------------------------------------------------------------------------------
    local procedure Deposit(Payload: JsonObject; APIRequestID: JsonToken): Text
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

        MpesaDepositTrans: Record "Sky M-Banking Trans. Buffer";
        BeneficiarySavingsAccount: Record "Savings Accounts";
        BeneficiaryLoanAccount: Record Loans;
        IsLoanRepayment: Boolean;
        AccountOwner: record Members;
        Settings: Record "Sky Background Process Manager";
        theSMS: Text;

        ResponseObject: JsonObject;
        AccountOwnerDetails: JsonObject;
        Datum: JsonObject;
        Response: Text;
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

        // Validations
        if amount.AsValue.AsDecimal <= 0 then begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Transaction amount must be greater than zero');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;

        // DUPLICATE
        MpesaDepositTrans.Reset;
        MpesaDepositTrans.SetRange(MpesaDepositTrans."Originator ID", originator_id.AsValue.AsText);
        MpesaDepositTrans.SetLoadFields("Originator ID");
        if MpesaDepositTrans.FindFirst then begin
            ResponseObject.Add('request_status', 'DUPLICATE');
            Datum.Add('error_message', 'This transaction already exists. Originator ID = ' + MpesaDepositTrans."Originator ID");
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // INVALID_ACCOUNT
        BeneficiarySavingsAccount.Reset;
        BeneficiarySavingsAccount.SetRange("No.", transaction_beneficiary_details_account.AsValue.AsText);
        BeneficiarySavingsAccount.SetLoadFields("No.");
        if not BeneficiarySavingsAccount.FindFirst then begin
            // Check if it is loan account
            BeneficiaryLoanAccount.Reset;
            BeneficiaryLoanAccount.SetRange("Loan No.", transaction_beneficiary_details_account.AsValue.AsText);
            BeneficiaryLoanAccount.SetLoadFields("Loan No.");
            if not BeneficiaryLoanAccount.FindFirst then begin
                // ResponseObject.Add('request_status', 'INVALID_ACCOUNT');
                // Datum.Add('error_message', 'Beneficiary account with identifier number ' + transaction_beneficiary_details_account.AsValue.AsText + ' does not exist!');
                // ResponseObject.Add('response_payload', Datum);

                // AddDateTimeToResponse(ResponseObject);

                // ResponseObject.WriteTo(Response);
                // exit(Response);
                IsLoanRepayment := false;
            end else begin
                IsLoanRepayment := true;
            end;
        end else begin
            IsLoanRepayment := false;
        end;

        // ACCOUNT_NOT_ACTIVE
        BeneficiarySavingsAccount.Reset;
        BeneficiarySavingsAccount.SetRange("No.", transaction_beneficiary_details_account.AsValue.AsText);
        BeneficiarySavingsAccount.SetRange(Status, BeneficiarySavingsAccount.Status::Closed);
        BeneficiarySavingsAccount.SetLoadFields(Status);
        if BeneficiarySavingsAccount.FindFirst then begin
            ResponseObject.Add('request_status', 'ACCOUNT_NOT_ACTIVE');
            Datum.Add('error_message', 'Account with identifier number ' + transaction_beneficiary_details_account.AsValue.AsText + ' is NOT active. Current status is ' + Format(BeneficiarySavingsAccount.Status));
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // BLOCKED
        BeneficiarySavingsAccount.Reset;
        BeneficiarySavingsAccount.SetRange("No.", transaction_beneficiary_details_account.AsValue.AsText);
        BeneficiarySavingsAccount.SetFilter(Blocked, '=%1|%2', BeneficiarySavingsAccount.Blocked::All, BeneficiarySavingsAccount.Blocked::Credit);
        BeneficiarySavingsAccount.SetLoadFields("No.");
        if BeneficiarySavingsAccount.FindFirst then begin
            ResponseObject.Add('request_status', 'BLOCKED');
            Datum.Add('error_message', 'Account with identifier number ' + transaction_beneficiary_details_account.AsValue.AsText + ' is blocked from deposit transactions.');
            ResponseObject.Add('response_payload', Datum);

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        MpesaDepositTrans.Reset;
        SkyMbankingTrans.LogDepositRequest(MpesaDepositTrans, Payload, APIRequestID, IsLoanRepayment);

        if MpesaDepositTrans.Insert(true) then begin
            ResponseObject.Add('request_status', 'SUCCESS');

            Datum.Add('transaction_reference', MpesaDepositTrans."Transaction ID");
            Datum.Add('transaction_status_description', 'Deposit processed successfully');
            Datum.Add('transaction_status_date_time', GlobalFunctions.FormatISODateTime(CurrentDateTime));

            if IsLoanRepayment then begin
                BeneficiaryLoanAccount.Reset;
                BeneficiaryLoanAccount.SetRange("Loan No.", MpesaDepositTrans."Beneficiary Account");
                BeneficiaryLoanAccount.SetLoadFields(
                    "Loan No.", "Loan Product Type Name", "Member No."
                );

                if BeneficiaryLoanAccount.FindFirst then begin
                    Datum.Add('account_number', BeneficiaryLoanAccount."Loan No.");
                    Datum.Add('account_name', BeneficiaryLoanAccount."Loan Product Type Name");
                    Datum.Add('product_type', 'LOAN');

                    AccountOwner.Reset;
                    AccountOwner.SetRange("No.", BeneficiaryLoanAccount."Member No.");
                    AccountOwner.SetLoadFields(Name, "Phone No.", "Primary Identification");

                    if AccountOwner.FindFirst then begin
                        AccountOwnerDetails.Add('full_name', AccountOwner.Name);
                        AccountOwnerDetails.Add('mobile_number', AccountOwner."Phone No.");
                        AccountOwnerDetails.Add('id_number', AccountOwner."Primary Identification");

                        Datum.Add('account_owner_details', AccountOwnerDetails);

                        if Settings.FindFirst then begin
                            if Settings."Disable Mob. Dep. Post" then begin
                                // Deposit SMS when posting is disabled
                                theSMS := StrSubstNo(
                                    'Dear %1, a %2 of KES %3 has been received from %4, %7 on %5. Mpesa ref: %6',
                                    AccountOwner.Name,
                                    Format(MpesaDepositTrans."Transaction Type"),
                                    MpesaDepositTrans."Transaction Amount",
                                    MpesaDepositTrans."Initiator Identifier",
                                    GlobalFunctions.FormatISODateTime(MpesaDepositTrans."Transaction Date Time"),
                                    MpesaDepositTrans."Transaction Source Reference",
                                    MpesaDepositTrans."Initiator Name"
                                );

                                if AccountOwner."Transactional Mobile Number" <> '' then begin
                                    SkySMS.SendSms(
                                        SMSSource::DEPOSIT_CONFIRMATION,
                                        AccountOwner."Transactional Mobile Number",
                                        theSMS,
                                        MpesaDepositTrans."Transaction Source Reference",
                                        '',
                                        true,
                                        0,
                                        true,
                                        'MBANKING',
                                        MpesaDepositTrans."Originator ID",
                                        'CBS'
                                    );
                                end else if AccountOwner."Phone No." <> '' then begin
                                    SkySMS.SendSms(
                                        SMSSource::DEPOSIT_CONFIRMATION,
                                        AccountOwner."Phone No.",
                                        theSMS,
                                        MpesaDepositTrans."Transaction Source Reference",
                                        '',
                                        true,
                                        0,
                                        true,
                                        'MBANKING',
                                        MpesaDepositTrans."Originator ID",
                                        'CBS'
                                    );
                                end;
                            end;
                        end;
                    end;
                end;
            end else begin
                BeneficiarySavingsAccount.Reset;
                BeneficiarySavingsAccount.SetRange("No.", MpesaDepositTrans."Beneficiary Account");
                BeneficiarySavingsAccount.SetLoadFields("No.", Name, "Member No.");

                if BeneficiarySavingsAccount.FindFirst then begin
                    Datum.Add('account_number', BeneficiarySavingsAccount."No.");
                    Datum.Add('account_name', BeneficiarySavingsAccount.Name);
                    Datum.Add('product_type', 'DEPOSIT');

                    AccountOwner.Reset;
                    AccountOwner.SetRange("No.", BeneficiarySavingsAccount."Member No.");
                    AccountOwner.SetLoadFields(Name, "Phone No.", "Primary Identification");

                    if AccountOwner.FindFirst then begin
                        AccountOwnerDetails.Add('full_name', AccountOwner.Name);
                        AccountOwnerDetails.Add('mobile_number', AccountOwner."Phone No.");
                        AccountOwnerDetails.Add('id_number', AccountOwner."Primary Identification");

                        Datum.Add('account_owner_details', AccountOwnerDetails);

                        if Settings.FindFirst then begin
                            if Settings."Disable Mob. Dep. Post" then begin
                                // Deposit SMS when posting is disabled
                                theSMS := StrSubstNo(
                                    'Dear %1, an %2 of KES %3 has been received from %4, %7 on %5. Mpesa ref: %6',
                                    AccountOwner.Name,
                                    Format(MpesaDepositTrans."Transaction Type"),
                                    MpesaDepositTrans."Transaction Amount",
                                    MpesaDepositTrans."Initiator Identifier",
                                    GlobalFunctions.FormatISODateTime(MpesaDepositTrans."Transaction Date Time"),
                                    MpesaDepositTrans."Transaction Source Reference",
                                    MpesaDepositTrans."Initiator Name"
                                );

                                if AccountOwner."Transactional Mobile Number" <> '' then begin
                                    SkySMS.SendSms(
                                        SMSSource::DEPOSIT_CONFIRMATION,
                                        AccountOwner."Transactional Mobile Number",
                                        theSMS,
                                        MpesaDepositTrans."Transaction Source Reference",
                                        '',
                                        true,
                                        0,
                                        true,
                                        'MBANKING',
                                        MpesaDepositTrans."Originator ID",
                                        'CBS'
                                    );
                                end else if AccountOwner."Phone No." <> '' then begin
                                    SkySMS.SendSms(
                                        SMSSource::DEPOSIT_CONFIRMATION,
                                        AccountOwner."Phone No.",
                                        theSMS,
                                        MpesaDepositTrans."Transaction Source Reference",
                                        '',
                                        true,
                                        0,
                                        true,
                                        'MBANKING',
                                        MpesaDepositTrans."Originator ID",
                                        'CBS'
                                    );
                                end;
                            end;
                        end;
                    end;
                end else begin
                    Datum.Add('account_number', transaction_beneficiary_details_account);
                    Datum.Add('account_name', transaction_beneficiary_details_name);
                    Datum.Add('product_type', 'DEPOSIT');

                    AccountOwnerDetails.Add('full_name', '');
                    AccountOwnerDetails.Add('mobile_number', '');
                    AccountOwnerDetails.Add('id_number', '');

                    Datum.Add('account_owner_details', AccountOwnerDetails);
                end;
            end;

            ResponseObject.Add('response_payload', Datum);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Unable to insert MPESA transaction');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    // ---------------------------------------------------------------------------------------------------------------------------
    local procedure GetLoanTypes(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        MobileLoanProducts: Record "Product Factory";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);

        GetMemberRecordV2(
            SearchMember,
            identifier_type.AsValue.AsText,
            identifier.AsValue.AsText,
            ''
        );

        IF SearchMember.FindFirst() then begin
            MobileLoanProducts.Reset;
            MobileLoanProducts.SetRange("Product Class Type", MobileLoanProducts."Product Class Type"::Loan);
            MobileLoanProducts.SetRange(Status, MobileLoanProducts.Status::Active);
            MobileLoanProducts.SetRange("Mobile Loan", true);

            if SearchMember."Employer Code" = 'RETIREE' then begin
                // Pension only
                MobileLoanProducts.Setfilter("Salary Income Types", '%1|%2', MobileLoanProducts."Salary Income Types"::Pension, MobileLoanProducts."Salary Income Types"::Dividend);
            end else begin
                // Salaried
                MobileLoanProducts.Setfilter("Salary Income Types", '%1|%2', MobileLoanProducts."Salary Income Types"::Salary, MobileLoanProducts."Salary Income Types"::Dividend);
            end;

            MobileLoanProducts.SetLoadFields(
                "Product ID", "Product Description", "Minimum Loan Amount", "Mobile Max. Loan Amount", "Maximum Loan Amount"
            );

            IF MobileLoanProducts.FindSet then begin
                repeat begin
                    Datum.Add('loan_type_id', MobileLoanProducts."Product ID");
                    Datum.Add('loan_type_name', MobileLoanProducts."Product Description");
                    Datum.Add('loan_type_min_amount', MobileLoanProducts."Minimum Loan Amount");

                    if MobileLoanProducts."Mobile Max. Loan Amount" <> 0 then begin
                        Datum.Add('loan_type_max_amount', MobileLoanProducts."Mobile Max. Loan Amount");
                    end else
                        if MobileLoanProducts."Maximum Loan Amount" <> 0 then begin
                            Datum.Add('loan_type_max_amount', MobileLoanProducts."Maximum Loan Amount");
                        end else begin
                            Datum.Add('loan_type_max_amount', 0);
                        end;

                    Data.Add(Datum);

                    // Reset
                    Datum.ReadFrom('{}');
                end until MobileLoanProducts.Next = 0;
            end;


            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('response_payload', Data);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanPurposes(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        MobileLoanPurposes: Record "Loan Purpose";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);

        GetMemberRecordV2(
            SearchMember,
            identifier_type.AsValue.AsText,
            identifier.AsValue.AsText,
            ''
        );

        IF SearchMember.FindFirst() then begin
            MobileLoanPurposes.Reset;
            MobileLoanPurposes.SetRange("Available On Mobile", true);

            MobileLoanPurposes.SetLoadFields(Code, Description);

            IF MobileLoanPurposes.FindSet then begin
                repeat begin
                    Datum.Add('code', MobileLoanPurposes.Code);
                    Datum.Add('description', MobileLoanPurposes.Description);

                    Data.Add(Datum);

                    // Reset
                    Datum.ReadFrom('{}');
                end until MobileLoanPurposes.Next = 0;
            end;


            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('response_payload', Data);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CheckLoanLimit(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        originator_id: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        loan_type_id: JsonToken;

        SearchMember: Record Members;
        MobileLoanProduct: Record "Product Factory";
        ProductSupportedClasses: Record "Product Supported Classes";
        MemberClass: Record "Member Classes";
        BlockedEmployers: Record "Blocked Employers";

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Datum: JsonObject;
        Response: Text;

        SalaryAmount: Decimal;
        EligibilityFailReason: Text;
    begin
        Payload.Get('originator_id', originator_id);
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);
        Payload.Get('loan_type_id', loan_type_id);

        GetMemberRecordV2(
            SearchMember,
            identifier_type.AsValue.AsText,
            identifier.AsValue.AsText,
            ''
        );

        IF SearchMember.FindFirst then begin
            // memberclass filter
            MemberClass.Reset();
            MemberClass.SetRange("No.", SearchMember."Member Class");
            MemberClass.SetLoadFields("Member Class");
            if MemberClass.FindFirst() then begin
            end;

            MobileLoanProduct.Reset;
            MobileLoanProduct.SetRange("Product ID", loan_type_id.AsValue.AsText);

            MobileLoanProduct.SetLoadFields(
                "Product ID", "Product Description", "Minimum Loan Amount", "Mobile Max. Loan Amount", "Maximum Loan Amount", "Mobile Loan", "FosaLoan Multiplier"
            );

            if MobileLoanProduct.FindFirst then begin
                // MemberClass product filter
                ProductSupportedClasses.Reset();
                ProductSupportedClasses.SetRange("Product ID", MobileLoanProduct."Product ID");
                ProductSupportedClasses.SetRange("Class Category", SearchMember."Member Class");
                if ProductSupportedClasses.IsEmpty() then begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', 'Loan product with ID = ' + loan_type_id.AsValue.AsText + ' is NOT available to ' + Format(SearchMember."Member Class") + ' Members');
                    ResponseObject.Add('response_payload', Datum);
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;

                // BlockedEmployers product filter 
                BlockedEmployers.Reset();
                BlockedEmployers.SetRange("Product ID", MobileLoanProduct."Product ID");
                BlockedEmployers.SetRange("Employer Code", SearchMember."Employer Code");
                if not BlockedEmployers.IsEmpty() then begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', 'Loan product with ID = ' + loan_type_id.AsValue.AsText + ' is NOT available to ' + SearchMember."Employer Code" + ' Employees');
                    ResponseObject.Add('response_payload', Datum);
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;

                Datum.Add('loan_type_id', MobileLoanProduct."Product ID");
                Datum.Add('loan_name', MobileLoanProduct."Product Description");

                if MobileLoanProduct."Mobile Loan" then begin
                    Datum.Add('eligible_amount', SkyMbankingTrans.GetLoansQualifyAmount(SearchMember."No.", MobileLoanProduct."Product ID", 0, EligibilityFailReason));
                end else begin
                    SalaryAmount := GuarantorSalaryEligibility(loan_type_id.AsValue.AsText, SearchMember, 0, EligibilityFailReason);

                    if SalaryAmount > MobileLoanProduct."Maximum Loan Amount" then begin
                        SalaryAmount := MobileLoanProduct."Maximum Loan Amount";
                    end;
                    Datum.Add('eligible_amount', SalaryAmount);
                end;

                Datum.Add('eligibility_fail_reason', EligibilityFailReason);

                Datum.Add('loan_type_min_amount', MobileLoanProduct."Minimum Loan Amount");

                if MobileLoanProduct."Mobile Max. Loan Amount" <> 0 then begin
                    Datum.Add('loan_type_max_amount', MobileLoanProduct."Mobile Max. Loan Amount");
                end else
                    if MobileLoanProduct."Maximum Loan Amount" <> 0 then begin
                        Datum.Add('loan_type_max_amount', MobileLoanProduct."Maximum Loan Amount");
                    end else begin
                        Datum.Add('loan_type_max_amount', 0);
                    end;

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('response_payload', Datum);
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Loan product with ID = ' + loan_type_id.AsValue.AsText + ' NOT found!');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure LoanApplication(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        originator_id: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        loan_type_id: JsonToken;
        amount: JsonToken;
        source_reference: JsonToken;
        request_application: JsonToken;
        transaction_date_time: JsonToken;
        mobile_loan_purpose: JsonToken;

        KeyExists: Boolean;

        SearchMember: Record Members;
        MobileLoanProduct: Record "Product Factory";
        TheLoan: Record Loans;
        TheLoanPurposes: Record "Loan Purpose";
        MobileLoanPurpose: Text;
        theSMS: Text;
        MemberClass: Record "Member Classes";
        BlockedEmployers: Record "Blocked Employers";
        ProductSupportedClasses: Record "Product Supported Classes";

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Datum: JsonObject;
        Response: Text;
        EligibilityFailReason: Text;
    begin
        Payload.Get('originator_id', originator_id);
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);
        Payload.Get('loan_type_id', loan_type_id);
        Payload.Get('amount', amount);
        Payload.Get('source_reference', source_reference);
        Payload.Get('request_application', request_application);
        Payload.Get('transaction_date_time', transaction_date_time);
        KeyExists := Payload.Get('mobile_loan_purpose', mobile_loan_purpose);

        MobileLoanPurpose := '';
        TheLoanPurposes.Reset;
        TheLoanPurposes.SetRange("Available On Mobile", true);
        if TheLoanPurposes.FindFirst then begin
            MobileLoanPurpose := TheLoanPurposes.Code;
        end;
        if KeyExists then begin
            MobileLoanPurpose := mobile_loan_purpose.AsValue.AsText;
        end;

        GetMemberRecordV2(
            SearchMember,
            identifier_type.AsValue.AsText,
            identifier.AsValue.AsText,
            ''
        );

        IF SearchMember.FindFirst then begin
            if CheckFOSASavingsAccountBlocked(SearchMember, 'CREDIT') then begin
                ResponseObject.Add('request_status', 'BLOCKED');
                Datum.Add('error_message', 'Account is blocked from credit transactions.');
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
            MemberClass.Reset(); // member class filter
            MemberClass.SetRange("No.", SearchMember."Member Class"); // member class filter
            MemberClass.SetLoadFields("Member Class");
            if MemberClass.FindFirst() then begin // member class filter
            end;

            MobileLoanProduct.Reset;
            MobileLoanProduct.SetRange("Product ID", loan_type_id.AsValue.AsText);
            MobileLoanProduct.SetRange("Mobile Loan", true);

            MobileLoanProduct.SetLoadFields(
                "Product ID", "Mobile Max. Loan Amount", "Minimum Loan Amount"
            );

            if MobileLoanProduct.FindFirst then begin
                // MemberClass product filter
                ProductSupportedClasses.Reset();
                ProductSupportedClasses.SetRange("Product ID", MobileLoanProduct."Product ID");
                ProductSupportedClasses.SetRange("Class Category", SearchMember."Member Class");
                if ProductSupportedClasses.IsEmpty() then begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', 'Loan product with ID = ' + loan_type_id.AsValue.AsText + ' is NOT available to ' + Format(SearchMember."Member Class") + ' Members');
                    ResponseObject.Add('response_payload', Datum);
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;

                // BlockedEmployers product filter 
                BlockedEmployers.Reset();
                BlockedEmployers.SetRange("Product ID", MobileLoanProduct."Product ID");
                BlockedEmployers.SetRange("Employer Code", SearchMember."Employer Code");
                if not BlockedEmployers.IsEmpty() then begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', 'Loan product with ID = ' + loan_type_id.AsValue.AsText + ' is NOT available to ' + SearchMember."Employer Code" + ' Employees');
                    ResponseObject.Add('response_payload', Datum);
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;

                // Check loan Limit
                if SkyMbankingTrans.GetLoansQualifyAmount(SearchMember."No.", MobileLoanProduct."Product ID", 0, EligibilityFailReason) < amount.AsValue.AsDecimal then begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', 'Loan amount exceeds the maximum limit allowed for the member of ' + Format(SkyMbankingTrans.GetLoansQualifyAmount(SearchMember."No.", MobileLoanProduct."Product ID", 0, EligibilityFailReason)));
                    ResponseObject.Add('response_payload', Datum);

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
                // Check Max Appliable Amount for loan
                if amount.AsValue.AsDecimal > MobileLoanProduct."Mobile Max. Loan Amount" then begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', 'Loan amount exceeds the maximum limit allowed for the loan product of ' + Format(MobileLoanProduct."Mobile Max. Loan Amount"));
                    ResponseObject.Add('response_payload', Datum);

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
                // Check Min Appliable Amount for loan
                if amount.AsValue.AsDecimal < MobileLoanProduct."Minimum Loan Amount" then begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', 'Loan amount is less than the minimum limit allowed for the loan product of ' + Format(MobileLoanProduct."Minimum Loan Amount"));
                    ResponseObject.Add('response_payload', Datum);

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
                // if Conditions are met then create loan application
                if SkyMbankingTrans.BufferLoanApplication(
                    SearchMember."No.", MobileLoanProduct."Product ID",
                    amount.AsValue.AsDecimal,
                    source_reference.AsValue.AsText,
                    MobileLoanPurpose) then begin

                    Datum.Add('transaction_reference', GlobalFunctions.CleanGuid);

                    TheLoan.Reset;

                    TheLoan.SetRange("Member No.", SearchMember."No.");
                    TheLoan.SetRange("Loan Product Type", MobileLoanProduct."Product ID");
                    TheLoan.SetRange(Posted, false);
                    TheLoan.SetRange("Requested Amount", amount.AsValue.AsDecimal);
                    TheLoan.SetRange("Loanee Message", source_reference.AsValue.AsText);

                    TheLoan.SetLoadFields(
                        "Loan No.",
                        "Loan Product Type Name",
                        "Requested Amount"
                    );

                    if TheLoan.FindFirst then begin
                        Datum.Add('loan_serial_number', TheLoan."Loan No.");
                    end else begin
                        Datum.Add('loan_serial_number', '');
                    end;

                    Datum.Add('loan_type_id', MobileLoanProduct."Product ID");
                    Datum.Add('loan_name', MobileLoanProduct."Product Description");
                    // Datum.Add('amount', 0);
                    Datum.Add('amount', amount.AsValue.AsDecimal);

                    ResponseObject.Add('request_status', 'SUCCESS');
                    ResponseObject.Add('response_payload', Datum);


                    // SMS
                    // theSMS := 'Dear member, your ' +
                    // TheLoan."Loan Product Type Name"
                    // + ' loan application request of KES ' +
                    // Format(TheLoan."Requested Amount") +
                    // ' has been received successfully. Kindly wait shortly as we process this request. Transaction ID: ' +
                    // TheLoan."Loan No.";

                    // if SearchMember."Phone No." <> '' then begin
                    //     SkySMS.SendSms(
                    //         SMSSource::LOAN_APPLICATION,
                    //         SearchMember."Phone No.",
                    //         theSMS,
                    //         TheLoan."Loan No.",
                    //         '',
                    //         true,
                    //         0,
                    //         true,
                    //         'MBANKING',
                    //         originator_id.AsValue.AsText,
                    //         'CBS'
                    //     );
                    // end else begin
                    //     if SearchMember."Transactional Mobile Number" <> '' then begin
                    //         SkySMS.SendSms(
                    //             SMSSource::LOAN_APPLICATION,
                    //             SearchMember."Transactional Mobile Number",
                    //             theSMS,
                    //             TheLoan."Loan No.",
                    //             '',
                    //             true,
                    //             0,
                    //             true,
                    //             'MBANKING',
                    //             originator_id.AsValue.AsText,
                    //             'CBS'
                    //         );
                    //     end
                    // end;
                end else begin
                    ResponseObject.Add('request_status', 'FAILED');
                    Datum.Add('error_message', 'Loan creation failed');
                    ResponseObject.Add('response_payload', Datum);
                end;

            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Loan product with ID = ' + loan_type_id.AsValue.AsText + ' NOT available for mobile application!');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoansInService(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        MemberLoans: Record Loans;
        MobileTransLines: Record "Mobile Transaction Types Lines";
        TotalCharges: Decimal;
        MobileTransTypes: Record "Mobile Transaction Types";
        currCharges: List of [decimal];
        TotalChargesIFT: Decimal;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);

        GetMemberRecordV2(
            SearchMember,
            identifier_type.AsValue.AsText,
            identifier.AsValue.AsText,
            ''
        );

        IF SearchMember.FindFirst then begin
            MemberLoans.Reset;
            MemberLoans.SetRange("Member No.", SearchMember."No.");
            MemberLoans.SetFilter("Total Balance", '>0');

            MemberLoans.SetLoadFields(
                "Loan No.", "Loan Product Type", "Loan Product Type Name", "Approved Amount",
                "Outstanding Balance", Repayment, "Loan Interest Repayment", "Outstanding Bills", "Disbursement Date",
                "Expected Date of Completion", "Outstanding Interest", "Loans Category-SASRA",
                "Daily Interest", "Total Loan Balance"
            );
            MemberLoans.SetAutoCalcFields(
                "Outstanding Balance", "Outstanding Bills", "Loans Category-SASRA", "Outstanding Interest", "Daily Interest",
                "Total Loan Balance"
            );

            IF MemberLoans.FindSet then begin
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Loan Repayment");
                if MobileTransTypes.FindFirst then begin
                    MobileTransLines.Reset();
                    MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);
                    MobileTransLines.SetFilter("Account No.", '<>%1', '');
                    if MobileTransLines.Findset() then begin
                        TotalCharges := 0;
                        repeat
                            currCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, MemberLoans."Outstanding Balance");
                            TotalCharges += currCharges.Get(1);
                        until MobileTransLines.next = 0;
                    end;
                end;

                MobileTransTypes.Reset;
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Pay Loan From Account");
                if MobileTransTypes.FindFirst then begin
                    MobileTransLines.Reset();
                    MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);
                    MobileTransLines.SetFilter("Account No.", '<>%1', '');
                    if MobileTransLines.Findset() then begin
                        TotalChargesIFT := 0;
                        repeat
                            currCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, MemberLoans."Outstanding Balance");
                            TotalChargesIFT += currCharges.Get(1);
                        until MobileTransLines.next = 0;
                    end;
                end;

                repeat begin
                    Datum.Add('loan_serial_number', MemberLoans."Loan No.");
                    Datum.Add('loan_type_id', MemberLoans."Loan Product Type");
                    Datum.Add('loan_type_name', MemberLoans."Loan Product Type Name");
                    Datum.Add('loan_amount', MemberLoans."Approved Amount");

                    Datum.Add('loan_balance', MemberLoans."Total Loan Balance");
                    Datum.Add('loan_repayment_charges', TotalCharges);
                    Datum.Add('total_repayment', MemberLoans."Outstanding Balance" + TotalCharges);

                    Datum.Add('loan_repayment_charges_ift', TotalChargesIFT);
                    Datum.Add('total_repayment_ift', MemberLoans."Outstanding Balance" + TotalChargesIFT);

                    Datum.Add('installment_amount', MemberLoans.Repayment);
                    Datum.Add('interest_amount', MemberLoans."Outstanding Interest" + MemberLoans."Daily Interest");
                    Datum.Add('loan_defaulted_amount', MemberLoans."Outstanding Bills");

                    Datum.Add('loan_issued_date', GlobalFunctions.FormatISODate(MemberLoans."Disbursement Date"));
                    Datum.Add('loan_end_date', GlobalFunctions.FormatISODate(MemberLoans."Expected Date of Completion"));

                    Datum.Add('loan_performance', Format(MemberLoans."Loans Category-SASRA"));
                    Datum.Add('loan_performance_description', Format(MemberLoans."Loans Category-SASRA"));

                    Data.Add(Datum);

                    // Reset
                    Datum.ReadFrom('{}');
                end until MemberLoans.Next = 0;
            end;


            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('response_payload', Data);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure LoanBalanceEnquiry(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        loan_serial_number: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        MemberLoan: Record Loans;
        TotalCharges: Decimal;

        SavingsAccount: Record "Savings Accounts";
        FosaAcc: Text;

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('loan_serial_number', loan_serial_number);
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);

        GetMemberRecordV2(
            SearchMember,
            identifier_type.AsValue.AsText,
            identifier.AsValue.AsText,
            ''
        );

        IF SearchMember.FindFirst then begin
            MemberLoan.Reset;
            MemberLoan.SetRange("Loan No.", loan_serial_number.AsValue.AsText);
            MemberLoan.SetRange("Member No.", SearchMember."No.");

            MemberLoan.SetLoadFields(
                "Loan No.", "Loan Product Type Name", "Member Name", Repayment, "Outstanding Balance", "Outstanding Interest", "Daily Interest"
            );

            MemberLoan.SetAutoCalcFields(
                "Outstanding Balance", "Outstanding Interest", "Daily Interest"
            );

            if MemberLoan.FindFirst then begin
                // "loan_serial_number": "LN0239201",
                // "loan_type_name": "Development Loan",
                // "account_label": "Development(LN0239201)",
                // "loan_balance": 16000.00,
                // "installment_amount ": 10000.00,
                // "interest_amount ": 500.00
                Datum.Add('loan_serial_number', MemberLoan."Loan No.");
                Datum.Add('loan_type_name', MemberLoan."Loan Product Type Name");
                Datum.Add('account_label', MemberLoan."Member Name");
                Datum.Add('loan_balance', MemberLoan."Outstanding Balance");
                Datum.Add('installment_amount', MemberLoan.Repayment);
                Datum.Add('interest_amount', MemberLoan."Outstanding Interest" + MemberLoan."Daily Interest");

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('response_payload', Datum);

                TotalCharges := SkyMbankingTrans.GetTransChargesPreview('LOAN_BALANCE_ENQUIRY', 0, '', SearchMember, '').Get(1);
                if TotalCharges > 0 then begin
                    FosaAcc := SkyMbankingTrans.GetMemberFosaAcc(SearchMember);

                    SavingsAccount.Reset;
                    SavingsAccount.SetRange("No.", FosaAcc);
                    if SavingsAccount.FindFirst then begin
                        // INSUFFICIENT_BAL
                        if SkyMbankingTrans.ValidateMinAccountBalance(
                            0,
                            SavingsAccount,
                            'LOAN_BALANCE_ENQUIRY',
                            SearchMember,
                            ''
                        ) then begin
                            ResponseObject.Remove('request_status');
                            ResponseObject.Remove('response_payload');
                            ResponseObject.Add('request_status', 'INSUFFICIENT_BAL');
                            Datum.Add('error_message', 'FOSA Account has insufficient balance to complete the transaction.');
                            ResponseObject.Add('response_payload', Datum);

                            AddDateTimeToResponse(ResponseObject);

                            ResponseObject.WriteTo(Response);
                            exit(Response);
                        end;
                    end;

                    if CheckFOSASavingsAccountBlocked(SearchMember, 'DEBIT') then begin
                        ResponseObject.Remove('request_status');
                        ResponseObject.Remove('response_payload');
                        ResponseObject.Add('request_status', 'BLOCKED');
                        Datum.Add('error_message', 'Account is blocked from debit transactions.');
                        ResponseObject.Add('response_payload', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;

                    // Log the transaction
                    SkyMbankingTrans.LogLoanBalanceEnquiry(
                        APIRequestID.AsValue.AsText,
                        identifier_type.AsValue.AsText,
                        identifier.AsValue.AsText,
                        loan_serial_number.AsValue.AsText,
                        SearchMember
                    );
                end;
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Loan with serial number ' + loan_serial_number.AsValue.AsText + ' NOT found for the given member');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure LoanMiniStatement(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        loan_serial_number: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        number_of_transactions: JsonToken;

        TotalCharges: Decimal;

        SearchMember: Record Members;
        LoanAccount: Record Loans;
        CreditLedgerEntry: Record "Credit Ledger Entry";

        SavingsAccount: Record "Savings Accounts";
        FosaAcc: Text;

        Count: Integer;

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Transactions: JsonArray;
        Transaction: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('loan_serial_number', loan_serial_number);
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);
        Payload.Get('number_of_transactions', number_of_transactions);

        GetMemberRecordV2(
            SearchMember,
            identifier_type.AsValue.AsText,
            identifier.AsValue.AsText,
            ''
        );

        IF SearchMember.FindFirst then begin
            LoanAccount.Reset;
            LoanAccount.SetRange("Loan No.", loan_serial_number.AsValue.AsText);
            LoanAccount.SetRange("Member No.", SearchMember."No.");

            LoanAccount.SetLoadFields(
                "Loan Product Type Name", "Loan No.", "Approved Amount", "Outstanding Balance", "Outstanding Interest", "Daily Interest",
                Repayment
            );
            LoanAccount.SetAutoCalcFields(
                "Outstanding Balance", "Outstanding Interest", "Daily Interest"
            );

            if LoanAccount.FindFirst then begin
                Datum.Add('loan_name', LoanAccount."Loan Product Type Name");
                Datum.Add('loan_serial_number', LoanAccount."Loan No.");
                Datum.Add('loan_amount', LoanAccount."Approved Amount");
                Datum.Add('loan_balance', LoanAccount."Outstanding Balance");
                Datum.Add('installment_amount', LoanAccount.Repayment);
                Datum.Add('interest_amount', LoanAccount."Outstanding Interest" + LoanAccount."Daily Interest");

                CreditLedgerEntry.Reset;
                CreditLedgerEntry.SetCurrentkey("Entry No.");
                CreditLedgerEntry.Ascending(false);
                CreditLedgerEntry.SetRange("Loan No", LoanAccount."Loan No.");
                CreditLedgerEntry.SetFilter("Transaction Type", '<>%1', CreditLedgerEntry."Transaction Type"::Bills);

                CreditLedgerEntry.SetLoadFields(
                    "Document No.", "Posting Date", "Posting Time", Amount, "Entry No.", Description
                );

                IF CreditLedgerEntry.FindSet then begin

                    repeat begin
                        Count += 1;

                        Transaction.Add('transaction_reference', CreditLedgerEntry."Document No.");
                        Transaction.Add('transaction_date', GlobalFunctions.FormatISODate(CreditLedgerEntry."Posting Date"));
                        Transaction.Add('transaction_time', GlobalFunctions.FormatISOTime(CreditLedgerEntry."Posting Time"));

                        if CreditLedgerEntry.Amount > 0 then begin
                            Transaction.Add('transaction_amount', CreditLedgerEntry.Amount);
                            Transaction.Add('transaction_type', 'CREDIT');
                        end else begin
                            Transaction.Add('transaction_amount', Abs(CreditLedgerEntry.Amount));
                            Transaction.Add('transaction_type', 'DEBIT');
                        end;

                        Transaction.Add('running_balance', GlobalFunctions.GetLoanRunningBal(CreditLedgerEntry."Entry No.", LoanAccount."Loan No."));
                        Transaction.Add('transaction_description', CreditLedgerEntry.Description);
                        Transaction.Add('other_details', CreditLedgerEntry.Description);

                        Transactions.Add(Transaction);
                        // Reset
                        Transaction.ReadFrom('{}');
                    end until (Count = number_of_transactions.AsValue.AsInteger) or (CreditLedgerEntry.Next = 0);
                end;

                Datum.Add('transactions', Transactions);

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('response_payload', Datum);

                TotalCharges := SkyMbankingTrans.GetTransChargesPreview('LOAN_MINI_STATEMENT', 0, '', SearchMember, '').Get(1);
                if TotalCharges > 0 then begin
                    FosaAcc := SkyMbankingTrans.GetMemberFosaAcc(SearchMember);

                    SavingsAccount.Reset;
                    SavingsAccount.SetRange("No.", FosaAcc);
                    if SavingsAccount.FindFirst then begin
                        // INSUFFICIENT_BAL
                        if SkyMbankingTrans.ValidateMinAccountBalance(
                            0,
                            SavingsAccount,
                            'LOAN_MINI_STATEMENT',
                            SearchMember,
                            ''
                        ) then begin
                            ResponseObject.Remove('request_status');
                            ResponseObject.Remove('response_payload');
                            ResponseObject.Add('request_status', 'INSUFFICIENT_BAL');
                            Datum.Add('error_message', 'FOSA Account has insufficient balance to complete the transaction.');
                            ResponseObject.Add('response_payload', Datum);

                            AddDateTimeToResponse(ResponseObject);

                            ResponseObject.WriteTo(Response);
                            exit(Response);
                        end;
                    end;

                    if CheckFOSASavingsAccountBlocked(SearchMember, 'DEBIT') then begin
                        ResponseObject.Remove('request_status');
                        ResponseObject.Remove('response_payload');
                        ResponseObject.Add('request_status', 'BLOCKED');
                        Datum.Add('error_message', 'Account is blocked from debit transactions.');
                        ResponseObject.Add('response_payload', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;

                    // Log the transaction
                    SkyMbankingTrans.LogLoanMiniStatement(
                        APIRequestID.AsValue.AsText,
                        identifier_type.AsValue.AsText,
                        identifier.AsValue.AsText,
                        loan_serial_number.AsValue.AsText,
                        SearchMember
                    );
                end;
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Loan with number ' + loan_serial_number.AsValue.AsText + ' NOT found for the given member');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure LoanFullStatement(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        loan_serial_number: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        start_date: JsonToken;
        end_date: JsonToken;

        SearchMember: Record Members;
        LoanAccount: Record Loans;
        CreditLedgerEntry: Record "Credit Ledger Entry";
        TotalCharges: Decimal;

        FosaAcc: Text;
        SavingsAccount: record "Savings Accounts";

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Transactions: JsonArray;
        Transaction: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('loan_serial_number', loan_serial_number);
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        GetMemberRecordV2(
            SearchMember,
            identifier_type.AsValue.AsText,
            identifier.AsValue.AsText,
            ''
        );

        IF SearchMember.FindFirst then begin
            LoanAccount.Reset;
            LoanAccount.SetRange("Loan No.", loan_serial_number.AsValue.AsText);
            LoanAccount.SetRange("Member No.", SearchMember."No.");

            LoanAccount.SetLoadFields(
                "Loan Product Type Name", "Loan No.", "Approved Amount", "Outstanding Balance", "Outstanding Interest", "Daily Interest",
                Repayment
                );
            LoanAccount.SetAutoCalcFields(
                "Outstanding Balance", "Outstanding Interest",
                "Daily Interest"
            );

            if LoanAccount.FindFirst then begin
                Datum.Add('loan_name', LoanAccount."Loan Product Type Name");
                Datum.Add('loan_serial_number', LoanAccount."Loan No.");
                Datum.Add('loan_amount', LoanAccount."Approved Amount");
                Datum.Add('loan_balance', LoanAccount."Outstanding Balance");
                Datum.Add('installment_amount', LoanAccount.Repayment);
                Datum.Add('interest_amount', LoanAccount."Outstanding Interest" + LoanAccount."Daily Interest");

                CreditLedgerEntry.Reset;
                CreditLedgerEntry.SetCurrentkey("Entry No.");
                CreditLedgerEntry.Ascending(false);
                CreditLedgerEntry.SetRange("Loan No", LoanAccount."Loan No.");
                CreditLedgerEntry.SetFilter("Transaction Type", '<>%1', CreditLedgerEntry."Transaction Type"::Bills);

                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));

                CreditLedgerEntry.SetFilter("Posting Date", '>=%1&<=%2', StartDate, EndDate);

                CreditLedgerEntry.SetLoadFields(
                    "Document No.", "Posting Date", "Posting Time", Amount, "Entry No.", Description
                );


                IF CreditLedgerEntry.FindSet then begin
                    repeat begin
                        Transaction.Add('transaction_reference', CreditLedgerEntry."Document No.");
                        Transaction.Add('transaction_date', GlobalFunctions.FormatISODate(CreditLedgerEntry."Posting Date"));
                        Transaction.Add('transaction_time', GlobalFunctions.FormatISOTime(CreditLedgerEntry."Posting Time"));

                        if CreditLedgerEntry.Amount > 0 then begin
                            Transaction.Add('transaction_amount', CreditLedgerEntry.Amount);
                            Transaction.Add('transaction_type', 'CREDIT');
                        end else begin
                            Transaction.Add('transaction_amount', Abs(CreditLedgerEntry.Amount));
                            Transaction.Add('transaction_type', 'DEBIT');
                        end;

                        Transaction.Add('running_balance', GlobalFunctions.GetLoanRunningBal(CreditLedgerEntry."Entry No.", LoanAccount."Loan No."));
                        Transaction.Add('transaction_description', CreditLedgerEntry.Description);
                        Transaction.Add('other_details', CreditLedgerEntry.Description);

                        Transactions.Add(Transaction);
                        // Reset
                        Transaction.ReadFrom('{}');
                    end until (CreditLedgerEntry.Next = 0);
                end;

                Datum.Add('transactions', Transactions);

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('response_payload', Datum);

                TotalCharges := SkyMbankingTrans.GetTransChargesPreview('LOAN_FULL_STATEMENT', 0, '', SearchMember, '').Get(1);
                if TotalCharges > 0 then begin
                    FosaAcc := SkyMbankingTrans.GetMemberFosaAcc(SearchMember);

                    SavingsAccount.Reset;
                    SavingsAccount.SetRange("No.", FosaAcc);
                    if SavingsAccount.FindFirst then begin
                        // INSUFFICIENT_BAL
                        if SkyMbankingTrans.ValidateMinAccountBalance(
                            0,
                            SavingsAccount,
                            'LOAN_FULL_STATEMENT',
                            SearchMember,
                            ''
                        ) then begin
                            ResponseObject.Remove('request_status');
                            ResponseObject.Remove('response_payload');
                            ResponseObject.Add('request_status', 'INSUFFICIENT_BAL');
                            Datum.Add('error_message', 'FOSA Account has insufficient balance to complete the transaction.');
                            ResponseObject.Add('response_payload', Datum);

                            AddDateTimeToResponse(ResponseObject);

                            ResponseObject.WriteTo(Response);
                            exit(Response);
                        end;
                    end;

                    if CheckFOSASavingsAccountBlocked(SearchMember, 'DEBIT') then begin
                        ResponseObject.Remove('request_status');
                        ResponseObject.Remove('response_payload');
                        ResponseObject.Add('request_status', 'BLOCKED');
                        Datum.Add('error_message', 'Account is blocked from debit transactions.');
                        ResponseObject.Add('response_payload', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;

                    // Log the transaction
                    SkyMbankingTrans.LogLoanFullStatement(
                        APIRequestID.AsValue.AsText,
                        identifier_type.AsValue.AsText,
                        identifier.AsValue.AsText,
                        loan_serial_number.AsValue.AsText,
                        SearchMember
                    );
                end;
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Loan with number ' + loan_serial_number.AsValue.AsText + ' NOT found for the given member');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetCharges(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        account_number: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        charge_action: JsonToken;
        amount: JsonToken;
        receiver_identifier: JsonToken;

        SearchMember: Record Members;
        ChargesInfo: List of [decimal];

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Datum: JsonObject;
        Response: Text;

        ReceiverIdentifierExists: Boolean;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);
        Payload.Get('account_number', account_number);
        Payload.Get('charge_action', charge_action);
        Payload.Get('amount', amount);
        ReceiverIdentifierExists := Payload.Get('receiver_identifier', receiver_identifier);

        GetMemberRecordV2(
            SearchMember,
            identifier_type.AsValue.AsText,
            identifier.AsValue.AsText,
            ''
        );

        SearchMember.SetLoadFields("No.");

        IF SearchMember.FindFirst then begin
            //ChargesInfo := SkyMbankingTrans.GetTransChargesPreview(charge_action.AsValue.AsText, amount.AsValue.AsDecimal, account_number.AsValue.AsText, SearchMember);
            if ReceiverIdentifierExists then begin
                ChargesInfo := SkyMbankingTrans.GetTransChargesPreview(charge_action.AsValue.AsText, amount.AsValue.AsDecimal, account_number.AsValue.AsText, SearchMember, receiver_identifier.AsValue.AsText);
            end else begin
                ChargesInfo := SkyMbankingTrans.GetTransChargesPreview(charge_action.AsValue.AsText, amount.AsValue.AsDecimal, account_number.AsValue.AsText, SearchMember, '');
            end;
            Datum.Add('charge_amount', ChargesInfo.Get(1) - ChargesInfo.Get(2));
            Datum.Add('excise_duty', ChargesInfo.Get(2));
            Datum.Add('total_charges', (ChargesInfo.Get(1)));

            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('response_payload', Datum);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure PostMpesaTransactions(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        CallServiceID: JsonToken;
        MpesaTransBuffer: Record "Sky M-Banking Trans. Buffer";
        MobileTransTypes: Record "Mobile Transaction Types";
        MobileTransLines: Record "Mobile Transaction Types Lines";
        BankingUserSetup: Record "Banking User Template";
        SaccoTrans: codeunit "Sacco Transactions";
        pfac: Record "Product Factory";
        LoansProcess: Codeunit "Loans Process";
        // templates - receipts and loans
        JTemplate: Text;
        JBatch: Text;
        LoanTemp: Text;
        LoanBatch: Text;
        // user details
        AccType: enum "Gen. Journal Account Type";
        UserSetup: Record "User Setup";
        Dim1: Code[20];
        Dim2: Code[20];
        TransactionType: enum "Transaction Types";
        TotalCharges: Decimal;
        TotalExciseDuty: Decimal;

        JournalPosting: Codeunit "Journal Posting";
        theSMS: Text;
        GLEntry: Record "G/L Entry";

        theCharge: Decimal;
        theReference: Text[20];

        Response: Text;
        ResponseData: JsonObject;
        Datum: JsonObject;
        SuccessMessage: text;
        genSetUp: Record "General Set-up";
        Loan: Record Loans;
        TotalCreditAmount: Decimal;
        FosaAcc: code[50];
        MobileLoanBuffer: Record "Mobile loan App. Buffer";
        SavingsAccounts: Record "Savings Accounts";
        LoanApplicant: Record Members;
        HasChargeType: Boolean;

        // IFT
        TheSourceMember: Record Members;
        TheDestinationMember: Record Members;
        TheDestinationSavings: Record "Savings Accounts";
        TheDestinationLoan: Record Loans;

        Description: Text[150];

        currCharges: List of [decimal];

        PostingBatchSize: Integer;
        PostingBatchCounter: Integer;
        RecordsCount: Integer;

        Settings: Record "Sky Background Process Manager";
        BeneficiarySavingsAccount: record "Savings Accounts";
        BeneficiaryLoan: record Loans;
        ReceiverSMSNo: Text;

        DepositTransBuffer: Record "Sky M-Banking Trans. Buffer";

        DepositMember: Record Members;
    begin
        // Database.SelectLatestVersion();
        PostingBatchSize := 25;

        Payload.Get('service_id', CallServiceID);
        TotalCreditAmount := 0;
        FosaAcc := '';
        SuccessMessage := 'There are 0 transactions of service ' + CallServiceID.AsValue.AsText + ' that can be processed at the moment.';

        //Get Posting Prerequisites for Mpesa Transactions
        if SkyMbankingTrans.CheckGenSetupAndExciseDuty = false then begin
            SuccessMessage := 'Excise Duty G/L Account is not set in the General Setup';
            ResponseData.Add('request_status', 'ERROR');
            ResponseData.Add('request_status_description', SuccessMessage);
            Datum.Add('error_message', SuccessMessage);
            ResponseData.Add('response_payload', Datum);
            ResponseData.WriteTo(Response);
            exit(Response);
        end;

        // Get General Setup
        if genSetUp.Get() = false then begin
            Error('Unable to retrieve General Setup');
        end;

        // Get Banking User Setup
        if BankingUserSetup.Get(UserId) = false then begin
            Error('User ID = %1 not setup in Banking User Setup', UserId);
        end;

        // Get User Setup
        if UserSetup.Get(UserId) = false then begin
            Error('User ID = %1 not setup in User Setup', UserId);
        end;

        Dim1 := UserSetup."Global Dimension 1 Code";
        Dim2 := UserSetup."Global Dimension 2 Code"; // FOSA

        // Dim1 := '301';
        // Dim2 := 'FOSA';

        JTemplate := BankingUserSetup."Cashier Journal Template";
        JBatch := BankingUserSetup."Cashier Journal Batch";
        LoanTemp := BankingUserSetup."Loans Template";
        LoanBatch := BankingUserSetup."Loans Batch";

        if (JTemplate = '') or (JBatch = '') then
            error('Cashier Journal Template and Batch must be set in the Banking User Setup');
        if (LoanTemp = '') or (LoanBatch = '') then
            error('Loans Template and Batch must be set in the Banking User Setup');

        // Check posting date is current!!!
        // if UserSetup."Allow Posting From" <> Today then begin
        //     UserSetup."Allow Posting From" := Today;
        //     UserSetup.Modify;
        // end;
        if UserSetup."Allow Posting To" <> Today then begin
            UserSetup."Allow Posting To" := Today;
            UserSetup.Modify;
        end;

        //Start Transaction Posting
        MobileTransTypes.Reset();
        MobileTransTypes.SetRange("Channel type", MobileTransTypes."Channel type"::Mobile);
        case CallServiceID.AsValue.AsText of
            'MOBILE_LOAN_DISBURSEMENT':
                begin
                    if Settings.FindFirst then begin
                        if Settings."Disable Mob. Loan Disb." then begin
                            ResponseData.Add('request_status', 'SUCCESS');
                            ResponseData.Add('request_status_description', 'MOBILE_LOAN_DISBURSEMENT posting has been disabled at the moment');
                            ResponseData.WriteTo(Response);
                            exit(Response);
                        end;
                    end;

                    // Moble Loan Disbursements
                    MobileTransTypes.SetRange(type, MobileTransTypes.Type::"Loan Disbursement");
                    MobileTransTypes.SetLoadFields(Code);
                    if MobileTransTypes.FindFirst() then begin
                        HasChargeType := true;
                    end else begin
                        HasChargeType := false;
                    end;

                    MobileLoanBuffer.Reset();
                    MobileLoanBuffer.SetRange(Posted, false);
                    MobileLoanBuffer.SetRange(Status, MobileLoanBuffer.Status::Approved);
                    MobileLoanBuffer.SetRange(Deactivated, false);
                    // MobileLoanBuffer.SetAscending("Entry No", GlobalFunctions.GetRandomBoolean);
                    MobileLoanBuffer.SetCurrentKey("Try Posting Count", "Entry No");
                    MobileLoanBuffer.SetAscending("Try Posting Count", true);
                    MobileLoanBuffer.SetAscending("Entry No", GlobalFunctions.GetRandomBoolean);
                    if MobileLoanBuffer.FindSet(true) then begin
                        PostingBatchCounter := 0;
                        RecordsCount := MobileLoanBuffer.Count;
                        // SuccessMessage := Format(MobileLoanBuffer.Count) + ' Loan Disbursement(s) were processed Successfully';
                        repeat
                            // Check prerequisites
                            loan.reset;
                            loan.SetRange("Loan No.", MobileLoanBuffer."Loan No.");
                            Loan.SetLoadFields("Loan No.", "Loan Product Type Name");
                            if not loan.FindFirst then begin
                                MobileLoanBuffer.Posted := false;
                                MobileLoanBuffer."Needs Change" := true;
                                MobileLoanBuffer."Needs Change Reason" := 'The loan was not found';
                                MobileLoanBuffer.Modify();
                            end;

                            MobileLoanBuffer."Try Posting Count" += 1;
                            if MobileLoanBuffer."Try Posting Count" >= 10 then begin
                                MobileLoanBuffer.Remarks := 'Max. Posting Attempts of ' + Format(MobileLoanBuffer."Try Posting Count") + ' reached!';
                                MobileLoanBuffer.Posted := true;
                                MobileLoanBuffer.Deactivated := true;
                                MobileLoanBuffer."Deactivated By" := UserId;
                                MobileLoanBuffer."Date Posted" := CurrentDateTime;

                                theSMS := 'Dear member, your ' +
                                    Loan."Loan Product Type Name" +
                                    ' of KES ' +
                                    Format(MobileLoanBuffer.Amount) +
                                    ' applied on ' + GlobalFunctions.FormatISODate(MobileLoanBuffer."Date Entered") +
                                    ' at ' + GlobalFunctions.FormatISOTime(MobileLoanBuffer."Time Entered") +
                                    ' was unsuccessful. Please try again later. Ref: ' + Loan."Loan No.";

                                LoanApplicant.Reset;
                                LoanApplicant.SetRange("No.", MobileLoanBuffer."Member No.");
                                LoanApplicant.SetLoadFields("Phone No.", "Transactional Mobile Number");
                                if LoanApplicant.FindFirst then begin
                                    SkySMS.SendSms(
                                        SMSSource::LOAN_REJECTED,
                                        LoanApplicant."Transactional Mobile Number",
                                        theSMS,
                                        Loan."Loan No.",
                                        '',
                                        true,
                                        0,
                                        true,
                                        'MBANKING',
                                        MobileLoanBuffer."Session ID",
                                        'CBS'
                                    );
                                end;

                                Loan.Status := Loan.Status::Rejected;
                                Loan."Loan Rejection Reason" := 'MBANKING POSTING LIMIT';
                                Loan.Modify;
                            end;
                            MobileLoanBuffer.Modify();
                            Commit;

                            if MobileLoanBuffer.Posted = false then begin
                                if MobileLoanBuffer.Installments = 0 then begin
                                    if SkyMbankingTrans.PostLoan(MobileLoanBuffer."Loan No.", LoanTemp, LoanBatch, MobileLoanBuffer."Session ID", HasChargeType) then begin
                                        MobileLoanBuffer.Posted := true;
                                        MobileLoanBuffer."Date Posted" := CurrentDateTime;
                                        MobileLoanBuffer.Modify();

                                        theSMS := 'Dear member, your ' +
                                        Loan."Loan Product Type Name" +
                                        ' of KES ' +
                                        Format(MobileLoanBuffer.Amount) +
                                        ' applied on ' + GlobalFunctions.FormatISODate(MobileLoanBuffer."Date Entered") +
                                        ' at ' + GlobalFunctions.FormatISOTime(MobileLoanBuffer."Time Entered") +
                                        ' has been approved and disbursed to your savings account. Ref: ' + Loan."Loan No.";

                                        LoanApplicant.Reset;
                                        LoanApplicant.SetRange("No.", MobileLoanBuffer."Member No.");
                                        LoanApplicant.SetLoadFields("Phone No.", "Transactional Mobile Number");
                                        if LoanApplicant.FindFirst then begin
                                            SkySMS.SendSms(
                                                SMSSource::LOAN_POSTED,
                                                LoanApplicant."Transactional Mobile Number",
                                                theSMS,
                                                Loan."Loan No.",
                                                '',
                                                true,
                                                0,
                                                true,
                                                'MBANKING',
                                                MobileLoanBuffer."Session ID",
                                                'CBS'
                                            );
                                        end;

                                        Commit;
                                        SkyMbankingTrans.GenerateSchedule(Loan);
                                    end else begin
                                        MobileLoanBuffer.Posted := false;
                                        MobileLoanBuffer."Needs Change" := true;
                                        MobileLoanBuffer."Needs Change Reason" := 'The record was not able to post';
                                        MobileLoanBuffer.Modify();
                                    end;
                                end else begin
                                    // FOSA M-Loan
                                    if SkyMbankingTrans.PostLoan2(MobileLoanBuffer."Loan No.", LoanTemp, LoanBatch, MobileLoanBuffer."Session ID", HasChargeType) then begin
                                        MobileLoanBuffer.Posted := true;
                                        MobileLoanBuffer."Date Posted" := CurrentDateTime;
                                        MobileLoanBuffer.Modify();

                                        theSMS := 'Dear member, your ' +
                                        Loan."Loan Product Type Name" +
                                        ' of KES ' +
                                        Format(MobileLoanBuffer."Approved Amount") +
                                        ' applied on ' + GlobalFunctions.FormatISODate(MobileLoanBuffer."Date Entered") +
                                        ' at ' + GlobalFunctions.FormatISOTime(MobileLoanBuffer."Time Entered") +
                                        ' has been approved and disbursed to your savings account. Ref: ' + Loan."Loan No.";

                                        LoanApplicant.Reset;
                                        LoanApplicant.SetRange("No.", MobileLoanBuffer."Member No.");
                                        LoanApplicant.SetLoadFields("Transactional Mobile Number");
                                        if LoanApplicant.FindFirst then begin
                                            SkySMS.SendSms(
                                                SMSSource::LOAN_POSTED,
                                                LoanApplicant."Transactional Mobile Number",
                                                theSMS,
                                                Loan."Loan No.",
                                                '',
                                                true,
                                                0,
                                                true,
                                                'MBANKING',
                                                MobileLoanBuffer."Session ID",
                                                'CBS'
                                            );
                                        end;

                                        Commit;
                                        SkyMbankingTrans.GenerateSchedule(Loan);
                                    end else begin
                                        MobileLoanBuffer.Posted := false;
                                        MobileLoanBuffer."Needs Change" := true;
                                        MobileLoanBuffer."Needs Change Reason" := 'The record was not able to post';
                                        MobileLoanBuffer.Modify();
                                    end;
                                end;
                            end;

                            PostingBatchCounter += 1;
                        until (MobileLoanBuffer.next = 0) OR (PostingBatchCounter = PostingBatchSize);

                        if RecordsCount < PostingBatchSize then begin
                            SuccessMessage := Format(RecordsCount) + ' Loan Disbursement(s) were processed Successfully';
                        end else begin
                            SuccessMessage := Format(PostingBatchSize) + ' out of ' + Format(RecordsCount) + ' Loan Disbursement(s) were processed Successfully';
                        end;
                    end else begin
                        SuccessMessage := '0 Loan Disbursements were processed';
                    end;
                end;
            // Mpesa Deposits:
            'MPESA_DEPOSITS':
                begin
                    if Settings.FindFirst then begin
                        if Settings."Disable Mob. Dep. Post" then begin
                            ResponseData.Add('request_status', 'SUCCESS');
                            ResponseData.Add('request_status_description', 'MPESA_DEPOSITS posting has been disabled at the moment');
                            ResponseData.WriteTo(Response);
                            exit(Response);
                        end;
                    end;

                    // Check transaction type availability to allow charges and Posting bank
                    MobileTransTypes.SetFilter(Type, '%1|%2|%3', MobileTransTypes.Type::"Mpesa Deposit", MobileTransTypes.Type::"Coop B2B Deposit", MobileTransTypes.Type::"Coop P2F Deposit");
                    MobileTransTypes.SetLoadFields(Code);
                    if not MobileTransTypes.FindFirst then begin
                        ResponseData.Add('request_status', 'ERROR');
                        ResponseData.Add('request_status_description', 'Mobile transaction type for MPESA/COOP deposits has NOT been set!');

                        Datum.Add('error_message', 'Mobile transaction type for MPESA deposits has NOT been set!');
                        ResponseData.Add('response_payload', Datum);

                        ResponseData.WriteTo(Response);
                        exit(Response);
                    end;

                    MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Self PIN Reset");
                    MobileTransTypes.SetLoadFields(Code);
                    if not MobileTransTypes.FindFirst then begin
                        ResponseData.Add('request_status', 'ERROR');
                        ResponseData.Add('request_status_description', 'Mobile transaction type for MPESA self PIN reset has NOT been set!');

                        Datum.Add('error_message', 'Mobile transaction type for MPESA self pin reset has NOT been set!');
                        ResponseData.Add('response_payload', Datum);

                        ResponseData.WriteTo(Response);
                        exit(Response);
                    end;

                    DepositTransBuffer.Reset();
                    DepositTransBuffer.SetRange("Posted", false);
                    DepositTransBuffer.SetRange("Needs Change", false);
                    DepositTransBuffer.SetFilter("Transaction Status", '=%1|%2', DepositTransBuffer."Transaction Status"::CONFIRMED, DepositTransBuffer."Transaction Status"::REVERSE_CONFIRMED);
                    DepositTransBuffer.SetRange("Transaction Type", DepositTransBuffer."Transaction Type"::"Mpesa Deposit");
                    DepositTransBuffer.SetFilter("Transaction Type", '%1|%2|%3|%4', DepositTransBuffer."Transaction Type"::"Mpesa Deposit", DepositTransBuffer."Transaction Type"::"Coop B2B Deposit", DepositTransBuffer."Transaction Type"::"Coop P2F Deposit", DepositTransBuffer."Transaction Type"::"Self PIN Reset");
                    DepositTransBuffer.SetCurrentKey("Try Posting Count", "Transaction Date Time");
                    DepositTransBuffer.SetAscending("Try Posting Count", true);
                    DepositTransBuffer.SetAscending("Transaction Date Time", true);
                    if DepositTransBuffer.FindSet(True) then begin
                        //
                        PostingBatchCounter := 0;
                        RecordsCount := DepositTransBuffer.Count;
                        // SuccessMessage := Format(DepositTransBuffer.Count) + ' Mpesa Deposit(s) were processed successfully';
                        repeat
                            DepositTransBuffer."Try Posting Count" += 1;
                            if DepositTransBuffer."Try Posting Count" >= 100 then begin
                                DepositTransBuffer."Needs Change" := true;
                                DepositTransBuffer."Needs Change Reason" := 'Erroneous deposit';
                            end;
                            DepositTransBuffer.Modify;
                            Commit;
                            MpesaTransBuffer.Get(DepositTransBuffer."No.");

                            TotalCharges := 0;
                            theReference := CopyStr(MpesaTransBuffer."Originator ID", 1, 19);

                            MobileTransTypes.Reset;
                            MobileTransTypes.SetRange(Type, MpesaTransBuffer."Transaction Type");
                            MobileTransTypes.FindFirst;

                            GLEntry.Reset;
                            GLEntry.SetRange("Document No.", theReference);
                            GLEntry.SetLoadFields("Entry No.");
                            if GLEntry.FindFirst then begin
                                MpesaTransBuffer.Posted := true;
                                MpesaTransBuffer."Posting Date" := Today;
                                MpesaTransBuffer."Posting Time" := time;
                                MpesaTransBuffer."Posted By" := UserID;
                                MpesaTransBuffer.Modify();

                                // SMS
                                BeneficiarySavingsAccount.Reset;
                                BeneficiarySavingsAccount.SetRange("No.", MpesaTransBuffer."Savings Account");
                                BeneficiarySavingsAccount.SetLoadFields(
                                    "No.",
                                    "Name",
                                    "Product Name",
                                    "Member No.",
                                    "Product Type",
                                    "Global Dimension 2 Code",
                                    Status,
                                    "Balance (LCY)",
                                    "Authorised Over Draft",
                                    "Uncleared Cheques",
                                    "ATM Transactions",
                                    "Lien Placed",
                                    "Coop Transactions",
                                    "One Month Installment",
                                    "Product Category"
                                );

                                if BeneficiarySavingsAccount.FindFirst then begin
                                    /*
                                    Receiver SMS: Dear [Member name], your [Product name] [Account number] has been credited with KES [Amount] received from [Phone number], [Name] on [date+time]. Mpesa ref: [Mpesa Ref]
                                    */
                                    TheDestinationMember.Reset;
                                    TheDestinationMember.SetRange("No.", BeneficiarySavingsAccount."Member No.");
                                    TheDestinationMember.SetLoadFields(Name, "Phone No.", "Transactional Mobile Number");

                                    if TheDestinationMember.FindFirst then begin
                                        /*
                                        Dear [FIRST_NAME], Confirmed [MPESA REF] of KSHs [AMOUNT] Credited to [AC NUMBER]  [NAME OF THE HOLDER] on [TIMESTAMP]. Thank you . Dial *882# to get more.
                                        */

                                        if (
                                            (MpesaTransBuffer."Initiator Identifier" = TheDestinationMember."Transactional Mobile Number") or
                                            (MpesaTransBuffer."Initiator Identifier" = TheDestinationMember."Phone No.")
                                        ) then begin
                                            theSMS := 'Dear ' + TheDestinationMember."First Name" +
                                            ', Confirmed ' + MpesaTransBuffer."Originator ID" +
                                            ' of KSHs ' + Format(MpesaTransBuffer."Transaction Amount") +
                                            ' Credited to ' + BeneficiarySavingsAccount."No." + ' ' +
                                            BeneficiarySavingsAccount."Name" +
                                            ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                            ' Thank you . Dial *882# to get more.';
                                        end else begin
                                            theSMS := 'Dear ' + TheDestinationMember."First Name" +
                                            ', You have received KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                            ' from ' + MpesaTransBuffer."Source Name" +
                                            ' to your ' + BeneficiarySavingsAccount."Product Name" +
                                            ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                            '. REF: ' + MpesaTransBuffer."Transaction Source Reference" +
                                            ' Thank you . Dial *882# to get more.';

                                            if MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Coop B2B Deposit" then begin
                                                theSMS := 'Dear ' + TheDestinationMember."First Name" +
                                            ', You have received KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                            ' from Coop Bank (B2B) ' +
                                            ' to your ' + BeneficiarySavingsAccount."Product Name" +
                                            ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                            '. REF: ' + MpesaTransBuffer."Originator ID" +
                                            ' Thank you . Dial *882# to get more.';
                                            end;
                                            if MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Coop P2F Deposit" then begin
                                                theSMS := 'Dear ' + TheDestinationMember."First Name" +
                                            ', You have received KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                            ' from Coop Bank (P2F) ' +
                                            ' to your ' + BeneficiarySavingsAccount."Product Name" +
                                            ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                            '. REF: ' + MpesaTransBuffer."Originator ID" +
                                            ' Thank you . Dial *882# to get more.';
                                            end;
                                        end;



                                        if TheDestinationMember."Phone No." <> '' then begin
                                            ReceiverSMSNo := TheDestinationMember."Phone No.";
                                            SkySMS.SendSms(
                                                SMSSource::DEPOSIT_CONFIRMATION,
                                                TheDestinationMember."Phone No.",
                                                theSMS,
                                                MpesaTransBuffer."Transaction Source Reference",
                                                '',
                                                true,
                                                0,
                                                true,
                                                'MBANKING',
                                                MpesaTransBuffer."Originator ID",
                                                'CBS'
                                            );
                                        end else begin
                                            if TheDestinationMember."Transactional Mobile Number" <> '' then begin
                                                ReceiverSMSNo := TheDestinationMember."Transactional Mobile Number";
                                                SkySMS.SendSms(
                                                    SMSSource::DEPOSIT_CONFIRMATION,
                                                    TheDestinationMember."Transactional Mobile Number",
                                                    theSMS,
                                                    MpesaTransBuffer."Transaction Source Reference",
                                                    '',
                                                    true,
                                                    0,
                                                    true,
                                                    'MBANKING',
                                                    MpesaTransBuffer."Originator ID",
                                                    'CBS'
                                                );
                                            end;
                                        end;

                                        if MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Mpesa Deposit" then begin
                                            if ReceiverSMSNo <> MpesaTransBuffer."Initiator Identifier" then begin
                                                // Your M-Pesa Deposit of KES [AMOUNT] to Paybill [PAYBILL_NUMBER] ([SACCO_NAME]) for account [ACCOUNT_NUMBER] was received successfully on [DATE]. M-Pesa Ref: [MPESA_REFERENCE_NUMBER] Ref: [REFERENCE].
                                                if TheDestinationMember."Old Account Name" <> '' then
                                                    BeneficiarySavingsAccount.Name := TheDestinationMember."Old Account Name";

                                                theSMS := 'Your M-Pesa Deposit of KES ' +
                                                Format(MpesaTransBuffer."Transaction Amount") +
                                                ' to Paybill ' +
                                                MpesaTransBuffer."Receiver Identifier" +
                                                ' (' + ' Azima Sacco' +
                                                ') for account ' +
                                                MpesaTransBuffer."Savings Account" +
                                                ' was received successfully on ' +
                                                GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                '. M-Pesa Ref: ' +
                                                MpesaTransBuffer."Transaction Source Reference" +
                                                ' Ref: ' +
                                                MpesaTransBuffer."Transaction Source Reference";

                                                SkySMS.SendSms(
                                                    SMSSource::DEPOSIT_CONFIRMATION,
                                                    MpesaTransBuffer."Initiator Identifier",
                                                    theSMS,
                                                    MpesaTransBuffer."Transaction Source Reference",
                                                    '',
                                                    true,
                                                    0,
                                                    true,
                                                    'MBANKING',
                                                    MpesaTransBuffer."Originator ID",
                                                    'CBS'
                                                );
                                            end;
                                        end;
                                    end;
                                end;
                            end else begin

                                if MpesaTransBuffer."Transaction Type" <> MpesaTransBuffer."Transaction Type"::"Self PIN Reset" then begin
                                    if SavingsAccounts.get(MpesaTransBuffer."Savings Account") then begin
                                        SaccoTrans.InitJournal(JTemplate, JBatch);
                                        Dim1 := SavingsAccounts."Global Dimension 1 Code";
                                        Dim2 := SavingsAccounts."Global Dimension 2 Code";
                                        Description := CopyStr(MpesaTransBuffer."Transaction Description", 1, 150);
                                        // Deb Bank Acc.
                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::"Bank Account", MobileTransTypes."Bank Account", Description, AccType::"G/L Account", '', MpesaTransBuffer."Transaction Amount", theReference, '', TransactionType::" ", Dim1, Dim2, true);

                                        TotalExciseDuty := 0;
                                        if Description = '' then begin
                                            if MobileTransTypes.Description <> '' then
                                                Description := CopyStr(MobileTransTypes.Description, 1, 150)
                                            else
                                                Description := Format(MpesaTransBuffer."Transaction Type");
                                        end;

                                        // Check if deposit is less than the charges
                                        MobileTransLines.Reset();
                                        MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);
                                        MobileTransLines.SetFilter("Account No.", '<>%1', '');
                                        if MobileTransLines.Findset() then begin
                                            TotalCharges := 0;
                                            repeat
                                                currCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, MpesaTransBuffer."Transaction Amount");
                                                TotalCharges += currCharges.Get(1);
                                            until MobileTransLines.next = 0;
                                        end;

                                        if TotalCharges >= MpesaTransBuffer."Transaction Amount" then begin
                                            TotalCharges := MpesaTransBuffer."Transaction Amount";

                                            // Charges if Any
                                            MobileTransLines.Reset();
                                            MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);
                                            MobileTransLines.SetFilter("Account No.", '<>%1', '');
                                            if MobileTransLines.Findset() then begin
                                                repeat
                                                    currCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, MpesaTransBuffer."Transaction Amount");
                                                    if currCharges.Get(1) <= TotalCharges then begin
                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, MobileTransLines."Account Type", MobileTransLines."Account No.", MobileTransLines.Description, AccType::"G/L Account", '', -(currCharges.Get(1) - currCharges.Get(2)), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                        if MobileTransLines."Recover Excise Duty" then begin
                                                            TotalExciseDuty += currCharges.Get(2);
                                                            SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::"G/L Account", genSetUp."Excise Duty G/L", 'Excise duty on charges', MobileTransLines."Account Type", ''/*MobileTransLines."Account No."*/, -currCharges.Get(2), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                        end;
                                                    end else begin
                                                        //
                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, MobileTransLines."Account Type", MobileTransLines."Account No.", MobileTransLines.Description, AccType::"G/L Account", '', -(TotalCharges), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                    end;

                                                    TotalCharges -= currCharges.Get(1);
                                                    Clear(currCharges);
                                                until (MobileTransLines.next = 0) or (TotalCharges <= 0);
                                            end;
                                        end else begin
                                            // Charges if Any
                                            MobileTransLines.Reset();
                                            MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);
                                            MobileTransLines.SetFilter("Account No.", '<>%1', '');
                                            if MobileTransLines.Findset() then begin
                                                TotalCharges := 0;
                                                repeat
                                                    currCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, MpesaTransBuffer."Transaction Amount");
                                                    if currCharges.Get(1) > 0 then begin
                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, MobileTransLines."Account Type", MobileTransLines."Account No.", MobileTransLines.Description, AccType::"G/L Account", '', -(currCharges.Get(1) - currCharges.Get(2)), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                        TotalCharges += currCharges.Get(1);
                                                        if MobileTransLines."Recover Excise Duty" then begin
                                                            TotalExciseDuty += currCharges.Get(2);
                                                            SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::"G/L Account", genSetUp."Excise Duty G/L", 'Excise duty on charges', MobileTransLines."Account Type", ''/*MobileTransLines."Account No."*/, -currCharges.Get(2), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                        end;
                                                    end;

                                                    Clear(currCharges);
                                                until MobileTransLines.next = 0;

                                                if TotalCharges > 0 then begin
                                                    if TotalCharges < MpesaTransBuffer."Transaction Amount" then begin
                                                        // Split Vendor + Beneficiary Account
                                                        // Cr Member acc.
                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", Description, AccType::"G/L Account", '', -(MpesaTransBuffer."Transaction Amount"), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", MobileTransTypes.Description, AccType::"G/L Account", '', (TotalCharges /*- TotalExciseDuty*/), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                        // if TotalExciseDuty > 0 then begin
                                                        //     SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", CopyStr(MobileTransTypes.Description + ' - Excise Duty', 1, 150), AccType::"G/L Account", '', TotalExciseDuty, theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                        // end;
                                                    end;
                                                end else begin
                                                    // Cr Member acc.
                                                    SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", Description, AccType::"G/L Account", '', -MpesaTransBuffer."Transaction Amount", theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                end;
                                            end else begin
                                                // Cr Member acc.
                                                SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", Description, AccType::"G/L Account", '', -MpesaTransBuffer."Transaction Amount", theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                            end;
                                        end;

                                        if SaccoTrans.PostJournal(JTemplate, JBatch) then begin
                                            MpesaTransBuffer.Posted := true;
                                            MpesaTransBuffer."Posting Date" := Today;
                                            MpesaTransBuffer."Posting Time" := time;
                                            MpesaTransBuffer."Posted By" := UserID;
                                            MpesaTransBuffer."Needs Change" := false;
                                            MpesaTransBuffer.Modify();

                                            // SMS
                                            BeneficiarySavingsAccount.Reset;
                                            BeneficiarySavingsAccount.SetRange("No.", MpesaTransBuffer."Savings Account");
                                            BeneficiarySavingsAccount.SetLoadFields(
                                                "No.",
                                                "Name",
                                                "Product Name",
                                                "Member No.",
                                                "Product Type",
                                                "Global Dimension 2 Code",
                                                Status,
                                                "Balance (LCY)",
                                                "Authorised Over Draft",
                                                "Uncleared Cheques",
                                                "ATM Transactions",
                                                "Lien Placed",
                                                "Coop Transactions",
                                                "One Month Installment",
                                                "Product Category"
                                            );

                                            if BeneficiarySavingsAccount.FindFirst then begin
                                                /*
                                                Receiver SMS: Dear [Member name], your [Product name] [Account number] has been credited with KES [Amount] received from [Phone number], [Name] on [date+time]. Mpesa ref: [Mpesa Ref]
                                                */
                                                TheDestinationMember.Reset;
                                                TheDestinationMember.SetRange("No.", BeneficiarySavingsAccount."Member No.");
                                                TheDestinationMember.SetLoadFields(Name, "Phone No.", "Transactional Mobile Number");

                                                if TheDestinationMember.FindFirst then begin

                                                    if (
                                           (MpesaTransBuffer."Initiator Identifier" = TheDestinationMember."Transactional Mobile Number") or
                                           (MpesaTransBuffer."Initiator Identifier" = TheDestinationMember."Phone No.")
                                       ) then begin
                                                        theSMS := 'Dear ' + TheDestinationMember."First Name" +
                                                        ', Confirmed ' + MpesaTransBuffer."Originator ID" +
                                                        ' of KSHs ' + Format(MpesaTransBuffer."Transaction Amount") +
                                                        ' Credited to ' + BeneficiarySavingsAccount."No." + ' ' +
                                                        BeneficiarySavingsAccount."Name" +
                                                        ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                        ' Thank you . Dial *882# to get more.';
                                                    end else begin
                                                        theSMS := 'Dear ' + TheDestinationMember."First Name" +
                                                        ', You have received KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                                        ' from ' + MpesaTransBuffer."Source Name" +
                                                        ' to your ' + BeneficiarySavingsAccount."Product Name" +
                                                        ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                        '. REF: ' + MpesaTransBuffer."Transaction Source Reference" +
                                                        ' Thank you . Dial *882# to get more.';

                                                        if MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Coop B2B Deposit" then begin
                                                            theSMS := 'Dear ' + TheDestinationMember."First Name" +
                                                        ', You have received KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                                        ' from Coop Bank (B2B) ' +
                                                        ' to your ' + BeneficiarySavingsAccount."Product Name" +
                                                        ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                        '. REF: ' + MpesaTransBuffer."Originator ID" +
                                                        ' Thank you . Dial *882# to get more.';
                                                        end;
                                                        if MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Coop P2F Deposit" then begin
                                                            theSMS := 'Dear ' + TheDestinationMember."First Name" +
                                                        ', You have received KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                                        ' from Coop Bank (P2F) ' +
                                                        ' to your ' + BeneficiarySavingsAccount."Product Name" +
                                                        ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                        '. REF: ' + MpesaTransBuffer."Originator ID" +
                                                        ' Thank you . Dial *882# to get more.';
                                                        end;
                                                    end;

                                                    if TheDestinationMember."Phone No." <> '' then begin
                                                        ReceiverSMSNo := TheDestinationMember."Phone No.";
                                                        SkySMS.SendSms(
                                                            SMSSource::DEPOSIT_CONFIRMATION,
                                                            TheDestinationMember."Phone No.",
                                                            theSMS,
                                                            MpesaTransBuffer."Transaction Source Reference",
                                                            '',
                                                            true,
                                                            0,
                                                            true,
                                                            'MBANKING',
                                                            MpesaTransBuffer."Originator ID",
                                                            'CBS'
                                                        );
                                                    end else begin
                                                        if TheDestinationMember."Transactional Mobile Number" <> '' then begin
                                                            ReceiverSMSNo := TheDestinationMember."Transactional Mobile Number";
                                                            SkySMS.SendSms(
                                                                SMSSource::DEPOSIT_CONFIRMATION,
                                                                TheDestinationMember."Transactional Mobile Number",
                                                                theSMS,
                                                                MpesaTransBuffer."Transaction Source Reference",
                                                                '',
                                                                true,
                                                                0,
                                                                true,
                                                                'MBANKING',
                                                                MpesaTransBuffer."Originator ID",
                                                                'CBS'
                                                            );
                                                        end;
                                                    end;
                                                    if MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Mpesa Deposit" then begin
                                                        if ReceiverSMSNo <> MpesaTransBuffer."Initiator Identifier" then begin

                                                            theSMS := 'Your M-Pesa Deposit of KES ' +
                                                            Format(MpesaTransBuffer."Transaction Amount") +
                                                            ' to Paybill ' +
                                                            MpesaTransBuffer."Receiver Identifier" +
                                                            ' (' + ' Azima Sacco' +
                                                            ') for account ' +
                                                            MpesaTransBuffer."Savings Account" +
                                                            ' has received successfully on ' +
                                                            GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                            '. M-Pesa Ref: ' +
                                                            MpesaTransBuffer."Transaction Source Reference" +
                                                            ' Ref: ' +
                                                            MpesaTransBuffer."Transaction Source Reference";

                                                            SkySMS.SendSms(
                                                                SMSSource::DEPOSIT_CONFIRMATION,
                                                                MpesaTransBuffer."Initiator Identifier",
                                                                theSMS,
                                                                MpesaTransBuffer."Transaction Source Reference",
                                                                '',
                                                                true,
                                                                0,
                                                                true,
                                                                'MBANKING',
                                                                MpesaTransBuffer."Originator ID",
                                                                'CBS'
                                                            );
                                                        end;
                                                    end;
                                                end;
                                            end;

                                        end else begin
                                            GLEntry.Reset;
                                            GLEntry.SetRange("Document No.", theReference);
                                            GLEntry.SetLoadFields("Entry No.");
                                            if GLEntry.FindFirst then begin
                                                MpesaTransBuffer.Posted := true;
                                                MpesaTransBuffer."Posting Date" := Today;
                                                MpesaTransBuffer."Posting Time" := time;
                                                MpesaTransBuffer."Posted By" := UserID;
                                                MpesaTransBuffer.Modify();

                                                // SMS
                                                BeneficiarySavingsAccount.Reset;
                                                BeneficiarySavingsAccount.SetRange("No.", MpesaTransBuffer."Savings Account");
                                                BeneficiarySavingsAccount.SetLoadFields(
                                                    "No.",
                                                    "Name",
                                                    "Product Name",
                                                    "Member No.",
                                                    "Product Type",
                                                    "Global Dimension 2 Code",
                                                    Status,
                                                    "Balance (LCY)",
                                                    "Authorised Over Draft",
                                                    "Uncleared Cheques",
                                                    "ATM Transactions",
                                                    "Lien Placed",
                                                    "Coop Transactions",
                                                    "One Month Installment",
                                                    "Product Category"
                                                );

                                                if BeneficiarySavingsAccount.FindFirst then begin
                                                    /*
                                                    Receiver SMS: Dear [Member name], your [Product name] [Account number] has been credited with KES [Amount] received from [Phone number], [Name] on [date+time]. Mpesa ref: [Mpesa Ref]
                                                    */
                                                    TheDestinationMember.Reset;
                                                    TheDestinationMember.SetRange("No.", BeneficiarySavingsAccount."Member No.");
                                                    TheDestinationMember.SetLoadFields(Name, "Phone No.", "Transactional Mobile Number");

                                                    if TheDestinationMember.FindFirst then begin

                                                        if (
                                           (MpesaTransBuffer."Initiator Identifier" = TheDestinationMember."Transactional Mobile Number") or
                                           (MpesaTransBuffer."Initiator Identifier" = TheDestinationMember."Phone No.")
                                       ) then begin
                                                            theSMS := 'Dear ' + TheDestinationMember."First Name" +
                                                            ', Confirmed ' + MpesaTransBuffer."Originator ID" +
                                                            ' of KSHs ' + Format(MpesaTransBuffer."Transaction Amount") +
                                                            ' Credited to ' + BeneficiarySavingsAccount."No." + ' ' +
                                                            BeneficiarySavingsAccount."Name" +
                                                            ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                            ' Thank you . Dial *882# to get more.';
                                                        end else begin
                                                            theSMS := 'Dear ' + TheDestinationMember."First Name" +
                                                            ', You have received KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                                            ' from ' + MpesaTransBuffer."Source Name" +
                                                            ' to your ' + BeneficiarySavingsAccount."Product Name" +
                                                            ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                            '. REF: ' + MpesaTransBuffer."Transaction Source Reference" +
                                                            ' Thank you . Dial *882# to get more.';

                                                            if MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Coop B2B Deposit" then begin
                                                                theSMS := 'Dear ' + TheDestinationMember."First Name" +
                                                            ', You have received KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                                            ' from Coop Bank (B2B) ' +
                                                            ' to your ' + BeneficiarySavingsAccount."Product Name" +
                                                            ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                            '. REF: ' + MpesaTransBuffer."Originator ID" +
                                                            ' Thank you . Dial *882# to get more.';
                                                            end;
                                                            if MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Coop P2F Deposit" then begin
                                                                theSMS := 'Dear ' + TheDestinationMember."First Name" +
                                                            ', You have received KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                                            ' from Coop Bank (P2F) ' +
                                                            ' to your ' + BeneficiarySavingsAccount."Product Name" +
                                                            ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                            '. REF: ' + MpesaTransBuffer."Originator ID" +
                                                            ' Thank you . Dial *882# to get more.';
                                                            end;
                                                        end;


                                                        if TheDestinationMember."Phone No." <> '' then begin
                                                            ReceiverSMSNo := TheDestinationMember."Phone No.";
                                                            SkySMS.SendSms(
                                                                SMSSource::DEPOSIT_CONFIRMATION,
                                                                TheDestinationMember."Phone No.",
                                                                theSMS,
                                                                MpesaTransBuffer."Transaction Source Reference",
                                                                '',
                                                                true,
                                                                0,
                                                                true,
                                                                'MBANKING',
                                                                MpesaTransBuffer."Originator ID",
                                                                'CBS'
                                                            );
                                                        end else begin
                                                            if TheDestinationMember."Transactional Mobile Number" <> '' then begin
                                                                ReceiverSMSNo := TheDestinationMember."Transactional Mobile Number";
                                                                SkySMS.SendSms(
                                                                    SMSSource::DEPOSIT_CONFIRMATION,
                                                                    TheDestinationMember."Transactional Mobile Number",
                                                                    theSMS,
                                                                    MpesaTransBuffer."Transaction Source Reference",
                                                                    '',
                                                                    true,
                                                                    0,
                                                                    true,
                                                                    'MBANKING',
                                                                    MpesaTransBuffer."Originator ID",
                                                                    'CBS'
                                                                );
                                                            end;
                                                        end;
                                                        if MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Mpesa Deposit" then begin
                                                            if ReceiverSMSNo <> MpesaTransBuffer."Initiator Identifier" then begin

                                                                // Your M-Pesa Deposit of KES [AMOUNT] to Paybill [PAYBILL_NUMBER] (Azima Sacco) for account [ACCOUNT_NUMBER] was received successfully on [DATE]. M-Pesa Ref: [MPESA_REFERENCE_NUMBER] Ref: [REFERENCE]
                                                                theSMS := 'Your M-Pesa Deposit of KES ' +
                                                                Format(MpesaTransBuffer."Transaction Amount") +
                                                                ' to Paybill ' +
                                                                MpesaTransBuffer."Receiver Identifier" +
                                                                ' (Azima Sacco) for account ' +
                                                                MpesaTransBuffer."Originator ID" +
                                                                ' was received successfully on ' +
                                                                GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                '. M-Pesa Ref: ' +
                                                                MpesaTransBuffer."Transaction Source Reference" +
                                                                ' Ref: ' +
                                                                MpesaTransBuffer."Originator ID";

                                                                SkySMS.SendSms(
                                                                    SMSSource::DEPOSIT_CONFIRMATION,
                                                                    MpesaTransBuffer."Initiator Identifier",
                                                                    theSMS,
                                                                    MpesaTransBuffer."Transaction Source Reference",
                                                                    '',
                                                                    true,
                                                                    0,
                                                                    true,
                                                                    'MBANKING',
                                                                    MpesaTransBuffer."Originator ID",
                                                                    'CBS'
                                                                );
                                                            end;
                                                        end;
                                                    end;
                                                end;

                                            end else begin
                                                MpesaTransBuffer."Try Posting Count" := MpesaTransBuffer."Try Posting Count" + 1;
                                                MpesaTransBuffer."Needs Change" := true;
                                                MpesaTransBuffer."Needs Change Reason" := 'The record was not able to post';
                                                MpesaTransBuffer.Modify();
                                            end;
                                        end;
                                    end else begin
                                        MpesaTransBuffer."Try Posting Count" := MpesaTransBuffer."Try Posting Count" + 1;
                                        MpesaTransBuffer."Needs Change" := true;
                                        MpesaTransBuffer."Needs Change Reason" := 'The beneficiary account was not found in Savings Accounts list';
                                        MpesaTransBuffer.Modify();
                                    end;
                                end else begin

                                    if MpesaTransBuffer."Transaction Type" <> MpesaTransBuffer."Transaction Type"::"Self PIN Reset" then begin
                                        // Other deposits
                                        if SavingsAccounts.get(MpesaTransBuffer."Savings Account") then begin
                                            SaccoTrans.InitJournal(JTemplate, JBatch);
                                            Dim1 := SavingsAccounts."Global Dimension 1 Code";
                                            Dim2 := SavingsAccounts."Global Dimension 2 Code";
                                            Description := CopyStr(MpesaTransBuffer."Transaction Description", 1, 150);
                                            // Deb Bank Acc.
                                            SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, MpesaTransBuffer."Transaction Date", AccType::"Bank Account", MobileTransTypes."Bank Account", Description, AccType::"G/L Account", '', MpesaTransBuffer."Transaction Amount", theReference, '', TransactionType::" ", Dim1, Dim2, true);

                                            TotalExciseDuty := 0;
                                            if Description = '' then begin
                                                if MobileTransTypes.Description <> '' then
                                                    Description := CopyStr(MobileTransTypes.Description, 1, 150)
                                                else
                                                    Description := Format(MpesaTransBuffer."Transaction Type");
                                            end;

                                            if MpesaTransBuffer."Transaction Type" <> MpesaTransBuffer."Transaction Type"::"Mpesa Deposit" then begin
                                                Description := CopyStr(Format(MpesaTransBuffer."Transaction Type") + ' ' + MpesaTransBuffer."Originator ID", 1, 150);
                                            end;

                                            // Check if deposit is less than the charges
                                            MobileTransLines.Reset();
                                            MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);
                                            MobileTransLines.SetFilter("Account No.", '<>%1', '');
                                            if MobileTransLines.Findset() then begin
                                                TotalCharges := 0;
                                                repeat
                                                    currCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, MpesaTransBuffer."Transaction Amount");
                                                    TotalCharges += currCharges.Get(1);
                                                until MobileTransLines.next = 0;
                                            end;

                                            if TotalCharges >= MpesaTransBuffer."Transaction Amount" then begin
                                                TotalCharges := MpesaTransBuffer."Transaction Amount";

                                                // Charges if Any
                                                MobileTransLines.Reset();
                                                MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);
                                                MobileTransLines.SetFilter("Account No.", '<>%1', '');
                                                if MobileTransLines.Findset() then begin
                                                    repeat
                                                        currCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, MpesaTransBuffer."Transaction Amount");
                                                        if currCharges.Get(1) <= TotalCharges then begin
                                                            SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, MpesaTransBuffer."Transaction Date", MobileTransLines."Account Type", MobileTransLines."Account No.", MobileTransLines.Description, AccType::"G/L Account", '', -(currCharges.Get(1) - currCharges.Get(2) - currCharges.Get(3)), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                            if MobileTransLines."Sky Revenue Share" then
                                                                SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Vendor, MobileTransLines."Sky Revenue Account No.", 'Sky World ' + MobileTransLines.Description, AccType::"G/L Account", '', -currCharges.Get(3), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                            if MobileTransLines."Recover Excise Duty" then begin
                                                                TotalExciseDuty += currCharges.Get(2);
                                                                SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, MpesaTransBuffer."Transaction Date", AccType::"G/L Account", genSetUp."Excise Duty G/L", 'Excise duty on charges', MobileTransLines."Account Type", ''/*MobileTransLines."Account No."*/, -currCharges.Get(2), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                            end;
                                                        end else begin
                                                            //
                                                            SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, MpesaTransBuffer."Transaction Date", MobileTransLines."Account Type", MobileTransLines."Account No.", MobileTransLines.Description, AccType::"G/L Account", '', -(TotalCharges), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                        end;

                                                        TotalCharges -= currCharges.Get(1);
                                                        Clear(currCharges);
                                                    until (MobileTransLines.next = 0) or (TotalCharges <= 0);
                                                end;
                                            end else begin
                                                // Charges if Any
                                                MobileTransLines.Reset();
                                                MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);
                                                MobileTransLines.SetFilter("Account No.", '<>%1', '');
                                                if MobileTransLines.Findset() then begin
                                                    TotalCharges := 0;
                                                    repeat
                                                        currCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, MpesaTransBuffer."Transaction Amount");
                                                        if currCharges.Get(1) > 0 then begin
                                                            SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, MpesaTransBuffer."Transaction Date", MobileTransLines."Account Type", MobileTransLines."Account No.", MobileTransLines.Description, AccType::"G/L Account", '', -(currCharges.Get(1) - currCharges.Get(2) - currCharges.Get(3)), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                            if MobileTransLines."Sky Revenue Share" then
                                                                SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Vendor, MobileTransLines."Sky Revenue Account No.", 'Sky World ' + MobileTransLines.Description, AccType::"G/L Account", '', -currCharges.Get(3), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                            TotalCharges += currCharges.Get(1);
                                                            if MobileTransLines."Recover Excise Duty" then begin
                                                                TotalExciseDuty += currCharges.Get(2);
                                                                SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, MpesaTransBuffer."Transaction Date", AccType::"G/L Account", genSetUp."Excise Duty G/L", 'Excise duty on charges', MobileTransLines."Account Type", ''/*MobileTransLines."Account No."*/, -currCharges.Get(2), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                            end;
                                                        end;

                                                        Clear(currCharges);
                                                    until MobileTransLines.next = 0;

                                                    if TotalCharges > 0 then begin
                                                        if TotalCharges < MpesaTransBuffer."Transaction Amount" then begin
                                                            // Split Vendor + Beneficiary Account
                                                            // Cr Member acc.
                                                            SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, MpesaTransBuffer."Transaction Date", AccType::Savings, MpesaTransBuffer."Savings Account", Description, AccType::"G/L Account", '', -(MpesaTransBuffer."Transaction Amount"), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                            SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, MpesaTransBuffer."Transaction Date", AccType::Savings, MpesaTransBuffer."Savings Account", MobileTransTypes.Description, AccType::"G/L Account", '', (TotalCharges /*- TotalExciseDuty*/), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                            // if TotalExciseDuty > 0 then begin
                                                            //     SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, MpesaTransBuffer."Transaction Date", AccType::Savings, MpesaTransBuffer."Savings Account", CopyStr(MobileTransTypes.Description + ' - Excise Duty', 1, 150), AccType::"G/L Account", '', TotalExciseDuty, theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                            // end;
                                                        end;
                                                    end else begin
                                                        // Cr Member acc.
                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, MpesaTransBuffer."Transaction Date", AccType::Savings, MpesaTransBuffer."Savings Account", Description, AccType::"G/L Account", '', -MpesaTransBuffer."Transaction Amount", theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                    end;
                                                end else begin
                                                    // Cr Member acc.
                                                    SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, MpesaTransBuffer."Transaction Date", AccType::Savings, MpesaTransBuffer."Savings Account", Description, AccType::"G/L Account", '', -MpesaTransBuffer."Transaction Amount", theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                end;
                                            end;

                                            if SaccoTrans.PostJournal(JTemplate, JBatch) then begin
                                                MpesaTransBuffer.Posted := true;
                                                MpesaTransBuffer."Posting Date" := Today;
                                                MpesaTransBuffer."Posting Time" := time;
                                                MpesaTransBuffer."Posted By" := UserID;
                                                MpesaTransBuffer."Needs Change" := false;
                                                MpesaTransBuffer.Modify();

                                                // SMS
                                                BeneficiarySavingsAccount.Reset;
                                                BeneficiarySavingsAccount.SetRange("No.", MpesaTransBuffer."Savings Account");
                                                BeneficiarySavingsAccount.SetLoadFields(
                                                    "No.",
                                                    "Name",
                                                    "Product Name",
                                                    "Member No.",
                                                    "Product Type",
                                                    "Global Dimension 2 Code",
                                                    Status,
                                                    "Balance (LCY)",
                                                    "Authorised Over Draft",
                                                    "Uncleared Cheques",
                                                    "ATM Transactions",
                                                    "Lien Placed",
                                                    "Coop Transactions",
                                                    "One Month Installment",
                                                    "Product Category"
                                                );

                                                if BeneficiarySavingsAccount.FindFirst then begin
                                                    /*
                                                    Receiver SMS: Dear [Member name], your [Product name] [Account number] has been credited with KES [Amount] received from [Phone number], [Name] on [date+time]. Mpesa ref: [Mpesa Ref]
                                                    */
                                                    TheDestinationMember.Reset;
                                                    TheDestinationMember.SetRange("No.", BeneficiarySavingsAccount."Member No.");
                                                    TheDestinationMember.SetLoadFields(Name, "Phone No.", "Transactional Mobile Number");

                                                    if TheDestinationMember.FindFirst then begin

                                                        if (
                                                            (MpesaTransBuffer."Initiator Identifier" = TheDestinationMember."Transactional Mobile Number") or
                                                            (MpesaTransBuffer."Initiator Identifier" = TheDestinationMember."Phone No.")
                                                        ) then begin
                                                            theSMS := 'Dear ' + TheDestinationMember."First Name" +
                                                            ', You have successfully deposited KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                                            ' to your ' + BeneficiarySavingsAccount."Product Name" +
                                                            ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                            '. REF: ' + MpesaTransBuffer."Transaction Source Reference" +
                                                            '. Thank you ';
                                                        end else begin
                                                            theSMS := 'Dear ' + TheDestinationMember."First Name" +
                                                            ', You have received KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                                            ' from ' + MpesaTransBuffer."Source Name" +
                                                            ' to your ' + BeneficiarySavingsAccount."Product Name" +
                                                            ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                            '. REF: ' + MpesaTransBuffer."Transaction Source Reference" +
                                                            '. Thank you ';

                                                            if MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Coop B2B Deposit" then begin
                                                                theSMS := 'Dear ' + TheDestinationMember."First Name" +
                                                            ', You have received KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                                            ' from Coop Bank (B2B) ' +
                                                            ' to your ' + BeneficiarySavingsAccount."Product Name" +
                                                            ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                            '. REF: ' + MpesaTransBuffer."Originator ID" +
                                                            '. Thank you ';
                                                            end;
                                                            if MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Coop P2F Deposit" then begin
                                                                theSMS := 'Dear ' + TheDestinationMember."First Name" +
                                                            ', You have received KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                                            ' from Coop Bank (P2F) ' +
                                                            ' to your ' + BeneficiarySavingsAccount."Product Name" +
                                                            ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                            '. REF: ' + MpesaTransBuffer."Originator ID" +
                                                            '. Thank you ';
                                                            end;
                                                        end;

                                                        if TheDestinationMember."Phone No." <> '' then begin
                                                            ReceiverSMSNo := TheDestinationMember."Phone No.";
                                                            SkySMS.SendSms(
                                                                SMSSource::DEPOSIT_CONFIRMATION,
                                                                TheDestinationMember."Phone No.",
                                                                theSMS,
                                                                MpesaTransBuffer."Transaction Source Reference",
                                                                '',
                                                                true,
                                                                0,
                                                                true,
                                                                'MBANKING',
                                                                MpesaTransBuffer."Originator ID",
                                                                'CBS'
                                                            );
                                                        end else begin
                                                            if TheDestinationMember."Transactional Mobile Number" <> '' then begin
                                                                ReceiverSMSNo := TheDestinationMember."Transactional Mobile Number";
                                                                SkySMS.SendSms(
                                                                    SMSSource::DEPOSIT_CONFIRMATION,
                                                                    TheDestinationMember."Transactional Mobile Number",
                                                                    theSMS,
                                                                    MpesaTransBuffer."Transaction Source Reference",
                                                                    '',
                                                                    true,
                                                                    0,
                                                                    true,
                                                                    'MBANKING',
                                                                    MpesaTransBuffer."Originator ID",
                                                                    'CBS'
                                                                );
                                                            end;
                                                        end;

                                                        if ReceiverSMSNo <> MpesaTransBuffer."Initiator Identifier" then begin

                                                            // Dear [FIRST_NAME], Confirmed [MPESA REF] of KSHs [AMOUNT] Credited to [AC NUMBER]  [NAME OF THE HOLDER] on [TIMESTAMP]. Welcome to bank with us
                                                            theSMS := 'Dear ' + MpesaTransBuffer."Initiator Identifier" +
                                                            ', Confirmed ' + MpesaTransBuffer."Transaction Source Reference" +
                                                            ' of KSHs ' + Format(MpesaTransBuffer."Transaction Amount") +
                                                            ' Credited to ' + BeneficiarySavingsAccount."No." +
                                                            ' ' + BeneficiarySavingsAccount."Name" +
                                                            ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                            '. Welcome to bank with us';

                                                            if MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Mpesa Deposit" then begin
                                                                SkySMS.SendSms(
                                                                    SMSSource::DEPOSIT_CONFIRMATION,
                                                                    MpesaTransBuffer."Initiator Identifier",
                                                                    theSMS,
                                                                    MpesaTransBuffer."Transaction Source Reference",
                                                                    '',
                                                                    true,
                                                                    0,
                                                                    true,
                                                                    'MBANKING',
                                                                    MpesaTransBuffer."Originator ID",
                                                                    'CBS'
                                                                );
                                                            end;
                                                        end;
                                                    end;
                                                end;

                                            end else begin
                                                GLEntry.Reset;
                                                GLEntry.SetRange("Document No.", theReference);
                                                GLEntry.SetLoadFields("Entry No.");
                                                if GLEntry.FindFirst then begin
                                                    MpesaTransBuffer.Posted := true;
                                                    MpesaTransBuffer."Posting Date" := Today;
                                                    MpesaTransBuffer."Posting Time" := time;
                                                    MpesaTransBuffer."Posted By" := UserID;
                                                    MpesaTransBuffer.Modify();

                                                    // SMS
                                                    BeneficiarySavingsAccount.Reset;
                                                    BeneficiarySavingsAccount.SetRange("No.", MpesaTransBuffer."Savings Account");
                                                    BeneficiarySavingsAccount.SetLoadFields(
                                                        "No.",
                                                        "Name",
                                                        "Product Name",
                                                        "Member No.",
                                                        "Product Type",
                                                        "Global Dimension 2 Code",
                                                        Status,
                                                        "Balance (LCY)",
                                                        "Authorised Over Draft",
                                                        "Uncleared Cheques",
                                                        "ATM Transactions",
                                                        "Lien Placed",
                                                        "Coop Transactions",
                                                        "One Month Installment",
                                                        "Product Category"
                                                    );

                                                    if BeneficiarySavingsAccount.FindFirst then begin
                                                        /*
                                                        Receiver SMS: Dear [Member name], your [Product name] [Account number] has been credited with KES [Amount] received from [Phone number], [Name] on [date+time]. Mpesa ref: [Mpesa Ref]
                                                        */
                                                        TheDestinationMember.Reset;
                                                        TheDestinationMember.SetRange("No.", BeneficiarySavingsAccount."Member No.");
                                                        TheDestinationMember.SetLoadFields(Name, "Phone No.", "Transactional Mobile Number");

                                                        if TheDestinationMember.FindFirst then begin

                                                            if (
                                                                (MpesaTransBuffer."Initiator Identifier" = TheDestinationMember."Transactional Mobile Number") or
                                                                (MpesaTransBuffer."Initiator Identifier" = TheDestinationMember."Phone No.")
                                                            ) then begin
                                                                theSMS := 'Dear ' + TheDestinationMember."First Name" +
                                                                ', You have successfully deposited KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                                                ' to your ' + BeneficiarySavingsAccount."Product Name" +
                                                                ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                '. REF: ' + MpesaTransBuffer."Transaction Source Reference" +
                                                                '. Thank you ';
                                                            end else begin
                                                                theSMS := 'Dear ' + TheDestinationMember."First Name" +
                                                                ', You have received KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                                                ' from ' + MpesaTransBuffer."Source Name" +
                                                                ' to your ' + BeneficiarySavingsAccount."Product Name" +
                                                                ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                '. REF: ' + MpesaTransBuffer."Transaction Source Reference" +
                                                                '. Thank you ';

                                                                if MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Coop B2B Deposit" then begin
                                                                    theSMS := 'Dear ' + TheDestinationMember."First Name" +
                                                                ', You have received KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                                                ' from Coop Bank (B2B) ' +
                                                                ' to your ' + BeneficiarySavingsAccount."Product Name" +
                                                                ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                '. REF: ' + MpesaTransBuffer."Originator ID" +
                                                                '. Thank you ';
                                                                end;
                                                                if MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Coop P2F Deposit" then begin
                                                                    theSMS := 'Dear ' + TheDestinationMember."First Name" +
                                                                ', You have received KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                                                ' from Coop Bank (P2F) ' +
                                                                ' to your ' + BeneficiarySavingsAccount."Product Name" +
                                                                ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                '. REF: ' + MpesaTransBuffer."Originator ID" +
                                                                '. Thank you ';
                                                                end;
                                                            end;

                                                            if TheDestinationMember."Phone No." <> '' then begin
                                                                ReceiverSMSNo := TheDestinationMember."Phone No.";
                                                                SkySMS.SendSms(
                                                                    SMSSource::DEPOSIT_CONFIRMATION,
                                                                    TheDestinationMember."Phone No.",
                                                                    theSMS,
                                                                    MpesaTransBuffer."Transaction Source Reference",
                                                                    '',
                                                                    true,
                                                                    0,
                                                                    true,
                                                                    'MBANKING',
                                                                    MpesaTransBuffer."Originator ID",
                                                                    'CBS'
                                                                );
                                                            end else begin
                                                                if TheDestinationMember."Transactional Mobile Number" <> '' then begin
                                                                    ReceiverSMSNo := TheDestinationMember."Transactional Mobile Number";
                                                                    SkySMS.SendSms(
                                                                        SMSSource::DEPOSIT_CONFIRMATION,
                                                                        TheDestinationMember."Transactional Mobile Number",
                                                                        theSMS,
                                                                        MpesaTransBuffer."Transaction Source Reference",
                                                                        '',
                                                                        true,
                                                                        0,
                                                                        true,
                                                                        'MBANKING',
                                                                        MpesaTransBuffer."Originator ID",
                                                                        'CBS'
                                                                    );
                                                                end;
                                                            end;

                                                            if ReceiverSMSNo <> MpesaTransBuffer."Initiator Identifier" then begin
                                                                // Dear [FIRST_NAME], Confirmed [MPESA REF] of KSHs [AMOUNT] Credited to [AC NUMBER]  [NAME OF THE HOLDER] on [TIMESTAMP]. Welcome to bank with us
                                                                theSMS := 'Dear ' + MpesaTransBuffer."Initiator Identifier" +
                                                                ', Confirmed ' + MpesaTransBuffer."Transaction Source Reference" +
                                                                ' of KSHs ' + Format(MpesaTransBuffer."Transaction Amount") +
                                                                ' Credited to ' + BeneficiarySavingsAccount."No." +
                                                                ' ' + BeneficiarySavingsAccount."Name" +
                                                                ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                '. Welcome to bank with us';

                                                                if MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Mpesa Deposit" then begin
                                                                    SkySMS.SendSms(
                                                                        SMSSource::DEPOSIT_CONFIRMATION,
                                                                        MpesaTransBuffer."Initiator Identifier",
                                                                        theSMS,
                                                                        MpesaTransBuffer."Transaction Source Reference",
                                                                        '',
                                                                        true,
                                                                        0,
                                                                        true,
                                                                        'MBANKING',
                                                                        MpesaTransBuffer."Originator ID",
                                                                        'CBS'
                                                                    );
                                                                end;
                                                            end;
                                                        end;
                                                    end;

                                                end else begin
                                                    MpesaTransBuffer."Try Posting Count" := MpesaTransBuffer."Try Posting Count" + 1;
                                                    MpesaTransBuffer."Needs Change" := true;
                                                    MpesaTransBuffer."Needs Change Reason" := 'The record was not able to post';
                                                    MpesaTransBuffer.Modify();
                                                end;
                                            end;
                                        end else begin
                                            MpesaTransBuffer."Try Posting Count" := MpesaTransBuffer."Try Posting Count" + 1;
                                            MpesaTransBuffer."Needs Change" := true;
                                            MpesaTransBuffer."Needs Change Reason" := 'The beneficiary account was not found in Savings Accounts list';

                                            // Update BOSA
                                            DepositMember.Reset;
                                            DepositMember.SetRange("Primary Identification", MpesaTransBuffer."Savings Account");
                                            DepositMember.SetLoadFields("No.", "Primary Identification");
                                            if DepositMember.FindFirst then begin
                                                MpesaTransBuffer."Savings Account" := SkyMbankingTrans.GetMemberDepositsAcc(DepositMember);
                                                MpesaTransBuffer."Needs Change" := false;
                                                MpesaTransBuffer."Needs Change Reason" := '';
                                            end;

                                            // Update BOSA
                                            DepositMember.Reset;
                                            DepositMember.SetRange("Payroll/Staff No.", MpesaTransBuffer."Savings Account");
                                            DepositMember.SetLoadFields("No.", "Primary Identification");
                                            if DepositMember.FindFirst then begin
                                                MpesaTransBuffer."Savings Account" := SkyMbankingTrans.GetMemberDepositsAcc(DepositMember);
                                                MpesaTransBuffer."Needs Change" := false;
                                                MpesaTransBuffer."Needs Change Reason" := '';
                                            end;

                                            theSMS := 'The account number ' + MpesaTransBuffer."Savings Account" +
                                            ' for your deposit transaction of Ksh ' + Format(MpesaTransBuffer."Transaction Amount") +
                                            ' with ref ' + MpesaTransBuffer."Transaction Source Reference" +
                                            ' does not exist.';

                                            if MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Mpesa Deposit" then begin
                                                SkySMS.SendSms(
                                                    SMSSource::DEPOSIT_CONFIRMATION,
                                                    MpesaTransBuffer."Initiator Identifier",
                                                    theSMS,
                                                    MpesaTransBuffer."Transaction Source Reference",
                                                    '',
                                                    true,
                                                    0,
                                                    true,
                                                    'MBANKING',
                                                    MpesaTransBuffer."Originator ID",
                                                    'CBS'
                                                );
                                            end;

                                            MpesaTransBuffer.Modify;
                                        end;
                                    end else begin
                                        // Self PIN reset
                                        MobileTransTypes.Reset;
                                        MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Self PIN Reset");
                                        MobileTransTypes.FindFirst();

                                        SaccoTrans.InitJournal(JTemplate, JBatch);
                                        Description := CopyStr(MpesaTransBuffer."Transaction Description", 1, 150);

                                        // Charges if Any
                                        MobileTransLines.Reset();
                                        MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);
                                        MobileTransLines.SetFilter("Account No.", '<>%1', '');
                                        if MobileTransLines.Findset() then begin
                                            TotalCharges := 0;
                                            repeat
                                                currCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, MpesaTransBuffer."Transaction Amount");
                                                if currCharges.Get(1) > 0 then begin
                                                    SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, MobileTransLines."Account Type", MobileTransLines."Account No.", MobileTransLines.Description, AccType::"G/L Account", '', -(currCharges.Get(1) - currCharges.Get(2) - currCharges.Get(3)), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                    if MobileTransLines."Sky Revenue Share" then
                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Vendor, MobileTransLines."Sky Revenue Account No.", 'Sky World ' + MobileTransLines.Description, AccType::"G/L Account", '', -currCharges.Get(3), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                    TotalCharges += currCharges.Get(1);
                                                    if MobileTransLines."Recover Excise Duty" then
                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::"G/L Account", genSetUp."Excise Duty G/L", 'Excise duty ' + MobileTransLines.Description, MobileTransLines."Account Type", ''/*MobileTransLines."Account No."*/, -currCharges.Get(2), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                end;

                                                Clear(currCharges);
                                            until MobileTransLines.next = 0;
                                            if TotalCharges > 0 then begin
                                                SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::"Bank Account", MobileTransTypes."Bank Account", MobileTransTypes.Description, AccType::"G/L Account", '', TotalCharges, theReference, '', TransactionType::" ", Dim1, Dim2, true);

                                                if SaccoTrans.PostJournal(JTemplate, JBatch) then begin
                                                    MpesaTransBuffer.Posted := true;
                                                    MpesaTransBuffer."Posting Date" := Today;
                                                    MpesaTransBuffer."Posting Time" := time;
                                                    MpesaTransBuffer."Posted By" := UserID;
                                                    MpesaTransBuffer.Modify();
                                                end else begin
                                                    GLEntry.Reset;
                                                    GLEntry.SetRange("Document No.", theReference);
                                                    GLEntry.SetLoadFields("Entry No.");
                                                    if GLEntry.FindFirst then begin
                                                        MpesaTransBuffer.Posted := true;
                                                        MpesaTransBuffer."Posting Date" := Today;
                                                        MpesaTransBuffer."Posting Time" := time;
                                                        MpesaTransBuffer."Posted By" := UserID;
                                                        MpesaTransBuffer.Modify();
                                                    end else begin
                                                        MpesaTransBuffer."Try Posting Count" := MpesaTransBuffer."Try Posting Count" + 1;
                                                        MpesaTransBuffer."Needs Change" := true;
                                                        MpesaTransBuffer."Needs Change Reason" := 'The record was not able to post';
                                                        MpesaTransBuffer.Modify();
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;

                            PostingBatchCounter += 1;
                        until (DepositTransBuffer.Next() = 0) OR (PostingBatchCounter = PostingBatchSize);

                        if RecordsCount < PostingBatchSize then begin
                            SuccessMessage := Format(RecordsCount) + ' Mpesa Deposit(s) were processed successfully';
                        end else begin
                            SuccessMessage := Format(PostingBatchSize) + ' out of ' + Format(RecordsCount) + ' Mpesa Deposit(s) were processed successfully';
                        end;
                    end else begin
                        SuccessMessage := '0 Mpesa Deposits to process at the moment';
                    end;
                end;
            'LOAN_REPAYMENT': //Loan repayment*
                begin
                    if Settings.FindFirst then begin
                        if Settings."Disable Mob. Dep. Post" then begin
                            ResponseData.Add('request_status', 'SUCCESS');
                            ResponseData.Add('request_status_description', 'LOAN_REPAYMENT posting has been disabled at the moment');
                            ResponseData.WriteTo(Response);
                            exit(Response);
                        end;
                    end;

                    Loan.reset;
                    MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Loan Repayment");
                    if not MobileTransTypes.FindFirst() then begin
                        ResponseData.Add('request_status', 'ERROR');
                        ResponseData.Add('request_status_description', 'Mobile transaction type for MPESA deposits has NOT been set!');

                        Datum.Add('error_message', 'Mobile transaction type for MPESA deposits has NOT been set!');
                        ResponseData.Add('response_payload', Datum);

                        ResponseData.WriteTo(Response);
                        exit(Response);
                    end else begin
                        HasChargeType := true;
                    end;

                    DepositTransBuffer.Reset();
                    DepositTransBuffer.SetRange("Posted", false);
                    DepositTransBuffer.SetRange("Needs Change", false);
                    DepositTransBuffer.SetFilter("Transaction Status", '=%1|%2', DepositTransBuffer."Transaction Status"::CONFIRMED, DepositTransBuffer."Transaction Status"::REVERSE_CONFIRMED);
                    DepositTransBuffer.SetRange("Transaction Type", DepositTransBuffer."Transaction Type"::"Loan Repayment");
                    DepositTransBuffer.SetCurrentKey("Try Posting Count", "Transaction Date Time");
                    DepositTransBuffer.SetAscending("Try Posting Count", true);
                    DepositTransBuffer.SetAscending("Transaction Date Time", true);
                    if DepositTransBuffer.FindSet(true) then begin
                        PostingBatchCounter := 0;
                        RecordsCount := DepositTransBuffer.Count;
                        // SuccessMessage := Format(DepositTransBuffer.Count) + ' loan repayment(s) were processed successfully';
                        repeat
                            DepositTransBuffer."Try Posting Count" += 1;
                            if DepositTransBuffer."Try Posting Count" >= 1000 then begin
                                DepositTransBuffer."Needs Change" := true;
                                DepositTransBuffer."Needs Change Reason" := 'Erroneous deposit';
                            end;
                            DepositTransBuffer.Modify;
                            Commit;
                            MpesaTransBuffer.Get(DepositTransBuffer."No.");

                            TotalCharges := 0;
                            theReference := CopyStr(MpesaTransBuffer."Transaction Source Reference", 1, 19);

                            GLEntry.Reset;
                            GLEntry.SetRange("Document No.", theReference);
                            GLEntry.SetLoadFields("Entry No.");
                            if GLEntry.FindFirst then begin
                                MpesaTransBuffer.Posted := true;
                                MpesaTransBuffer."Posting Date" := Today;
                                MpesaTransBuffer."Posting Time" := time;
                                MpesaTransBuffer."Posted By" := UserID;
                                MpesaTransBuffer.Modify();

                                // SMS
                                BeneficiaryLoan.Reset;
                                BeneficiaryLoan.SetRange("Loan No.", MpesaTransBuffer."Loan No.");
                                BeneficiaryLoan.SetLoadFields("Member No.", "Loan Product Type Name", "Loan No.", "Member Name");

                                if BeneficiaryLoan.FindFirst then begin
                                    /*
                                    Receiver SMS: Dear [Member name], your [Product name] [Account number] has been credited with KES [Amount] received from [Phone number], [Name] on [date+time]. Mpesa ref: [Mpesa Ref]
                                    */
                                    TheDestinationMember.Reset;
                                    TheDestinationMember.SetRange("No.", BeneficiaryLoan."Member No.");
                                    TheDestinationMember.SetLoadFields(Name, "Phone No.", "Transactional Mobile Number");

                                    if TheDestinationMember.FindFirst then begin
                                        theSMS := 'Dear ' + TheDestinationMember.Name +
                                        ', a loan repayment of KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                        ' for your loan ' + BeneficiaryLoan."Loan Product Type Name" +
                                        ' ' + BeneficiaryLoan."Loan No." +
                                        ' has been received from ' + MpesaTransBuffer."Initiator Identifier" +
                                        ', ' + MpesaTransBuffer."Initiator Name" +
                                        ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                        '. Mpesa ref: ' + MpesaTransBuffer."Transaction Source Reference";

                                        if TheDestinationMember."Phone No." <> '' then begin
                                            ReceiverSMSNo := TheDestinationMember."Phone No.";
                                            SkySMS.SendSms(
                                                SMSSource::DEPOSIT_CONFIRMATION,
                                                TheDestinationMember."Phone No.",
                                                theSMS,
                                                MpesaTransBuffer."Transaction Source Reference",
                                                '',
                                                true,
                                                0,
                                                true,
                                                'MBANKING',
                                                MpesaTransBuffer."Originator ID",
                                                'CBS'
                                            );
                                        end else begin
                                            if TheDestinationMember."Transactional Mobile Number" <> '' then begin
                                                ReceiverSMSNo := TheDestinationMember."Transactional Mobile Number";
                                                SkySMS.SendSms(
                                                    SMSSource::DEPOSIT_CONFIRMATION,
                                                    TheDestinationMember."Transactional Mobile Number",
                                                    theSMS,
                                                    MpesaTransBuffer."Transaction Source Reference",
                                                    '',
                                                    true,
                                                    0,
                                                    true,
                                                    'MBANKING',
                                                    MpesaTransBuffer."Originator ID",
                                                    'CBS'
                                                );
                                            end;
                                        end;

                                        if ReceiverSMSNo <> MpesaTransBuffer."Initiator Identifier" then begin
                                            /*
                                            Sender SMS: Your MPESA deposit of KES [Amount] to paybill 541900 for [Account name] on [date+time] has been received. Mpesa ref: [Mpesa Ref]
                                            */
                                            theSMS := 'Your MPESA loan repayment of KES ' +
                                            Format(MpesaTransBuffer."Transaction Amount") +
                                            ' to paybill ' +
                                            MpesaTransBuffer."Receiver Identifier" +
                                            ' for ' +
                                            BeneficiaryLoan."Loan No." +
                                            ' on ' +
                                            GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                            ' has been received. MPESA ref: ' +
                                            MpesaTransBuffer."Transaction Source Reference";

                                            SkySMS.SendSms(
                                                SMSSource::DEPOSIT_CONFIRMATION,
                                                MpesaTransBuffer."Initiator Identifier",
                                                theSMS,
                                                MpesaTransBuffer."Transaction Source Reference",
                                                '',
                                                true,
                                                0,
                                                true,
                                                'MBANKING',
                                                MpesaTransBuffer."Originator ID",
                                                'CBS'
                                            );
                                        end;
                                    end;
                                end;
                            end else begin

                                if SkyMbankingTrans.ProcessLoanRepayment(MpesaTransBuffer) then begin
                                    Description := CopyStr(MpesaTransBuffer."Transaction Description", 1, 150);
                                    if Description = '' then begin
                                        if MobileTransTypes.Description <> '' then
                                            Description := CopyStr(MobileTransTypes.Description, 1, 150)
                                        else
                                            Description := Format(MpesaTransBuffer."Transaction Type");
                                    end;
                                    Loan.get(MpesaTransBuffer."Loan No.");
                                    Dim1 := Loan."Global Dimension 1 Code";
                                    Dim2 := Loan."Global Dimension 2 Code";
                                    // Insert Journals and Post
                                    TotalCreditAmount := MpesaTransBuffer."Transaction Amount";
                                    SaccoTrans.InitJournal(LoanTemp, LoanBatch);
                                    // Deb Bank Acc.
                                    SaccoTrans.JournalInsert(LoanTemp, LoanBatch, theReference, Today, AccType::"Bank Account", MobileTransTypes."Bank Account", Description, AccType::"G/L Account", '', MpesaTransBuffer."Transaction Amount", theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                    TotalExciseDuty := 0;

                                    // Check if deposit is less than the charges
                                    MobileTransLines.Reset();
                                    MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);
                                    MobileTransLines.SetFilter("Account No.", '<>%1', '');
                                    if MobileTransLines.Findset() then begin
                                        TotalCharges := 0;
                                        repeat
                                            currCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, MpesaTransBuffer."Transaction Amount");
                                            TotalCharges += currCharges.Get(1);
                                        until MobileTransLines.next = 0;
                                    end;

                                    if TotalCharges >= MpesaTransBuffer."Transaction Amount" then begin
                                        TotalCharges := MpesaTransBuffer."Transaction Amount";

                                        // Charges if Any
                                        MobileTransLines.Reset();
                                        MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);
                                        MobileTransLines.SetFilter("Account No.", '<>%1', '');
                                        if MobileTransLines.Findset() then begin
                                            repeat
                                                currCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, MpesaTransBuffer."Transaction Amount");
                                                if currCharges.Get(1) <= TotalCharges then begin
                                                    SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, MobileTransLines."Account Type", MobileTransLines."Account No.", MobileTransLines.Description, AccType::"G/L Account", '', -(currCharges.Get(1) - currCharges.Get(2) - currCharges.Get(3)), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                    if MobileTransLines."Sky Revenue Share" then
                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Vendor, MobileTransLines."Sky Revenue Account No.", 'Sky World ' + MobileTransLines.Description, AccType::"G/L Account", '', -currCharges.Get(3), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                    if MobileTransLines."Recover Excise Duty" then begin
                                                        TotalExciseDuty += currCharges.Get(2);
                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::"G/L Account", genSetUp."Excise Duty G/L", 'Excise duty on charges', MobileTransLines."Account Type", ''/*MobileTransLines."Account No."*/, -currCharges.Get(2), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                    end;
                                                end else begin
                                                    //
                                                    SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, MobileTransLines."Account Type", MobileTransLines."Account No.", MobileTransLines.Description, AccType::"G/L Account", '', -(TotalCharges), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                end;

                                                TotalCharges -= currCharges.Get(1);
                                                Clear(currCharges);
                                            until (MobileTransLines.next = 0) or (TotalCharges <= 0);
                                        end;
                                    end else begin

                                        if HasChargeType then begin
                                            // Charges if Any
                                            MobileTransLines.Reset();
                                            MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);
                                            MobileTransLines.SetFilter("Account No.", '<>%1', '');
                                            if MobileTransLines.FindSet then begin
                                                TotalCharges := 0;
                                                repeat
                                                    Clear(currCharges);

                                                    currCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, MpesaTransBuffer."Transaction Amount");
                                                    if currCharges.Get(1) > 0 then begin
                                                        SaccoTrans.JournalInsert(LoanTemp, LoanBatch, theReference, Today, MobileTransLines."Account Type", MobileTransLines."Account No.", MobileTransLines.Description, AccType::"G/L Account", '', -(currCharges.Get(1) - currCharges.Get(2) - currCharges.Get(3)), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                        if MobileTransLines."Sky Revenue Share" then
                                                            SaccoTrans.JournalInsert(LoanTemp, LoanBatch, theReference, Today, AccType::Vendor, MobileTransLines."Sky Revenue Account No.", 'Sky World ' + MobileTransLines.Description, AccType::"G/L Account", '', -currCharges.Get(3), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                        TotalCharges += currCharges.Get(1);
                                                        if MobileTransLines."Recover Excise Duty" then begin
                                                            TotalExciseDuty += currCharges.Get(2);
                                                            SaccoTrans.JournalInsert(LoanTemp, LoanBatch, theReference, Today, AccType::"G/L Account", genSetUp."Excise Duty G/L", 'Excise duty on charges', MobileTransLines."Account Type", ''/*MobileTransLines."Account No."*/, -currCharges.Get(2), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                        end;
                                                    end;
                                                until MobileTransLines.next = 0;

                                                if TotalCharges > 0 then begin
                                                    TotalCreditAmount -= TotalCharges;
                                                end;
                                            end;
                                        end;

                                        if TotalCreditAmount > 0 then begin
                                            // Cr loan Oustanding Bal
                                            Loan.calcfields("Outstanding Balance", "Outstanding Interest", "Daily Interest");
                                            //Capitalize daily Interest
                                            if Loan."Daily Interest" > 0 then begin
                                                if pfac.get(Loan."Loan Product Type") then
                                                    if pfac."Loan Interest Account [G/L]" <> '' then begin
                                                        SaccoTrans.JournalInsert(LoanTemp, LoanBatch, theReference, Today, AccType::Credit, MpesaTransBuffer."Loan Account", 'Daily Loan Interest Capitalized. ' + Loan."Loan No.", AccType::"G/L Account", pfac."Loan Interest Account [G/L]", loan."Daily Interest", theReference, Loan."Loan No.", TransactionType::"Interest Due", Dim1, Dim2, true);
                                                        LoansProcess.ClearDailyInterest(Loan."Loan No.");
                                                    end;
                                            end;
                                            loan."Outstanding Interest" := Loan."Outstanding Interest" + loan."Daily Interest";
                                            if TotalCreditAmount >= (Loan."Outstanding Interest") then begin
                                                SaccoTrans.JournalInsert(LoanTemp, LoanBatch, theReference, Today, AccType::Credit, MpesaTransBuffer."Loan Account", Description, AccType::"G/L Account", '', -(Loan."Outstanding Interest"), theReference, Loan."Loan No.", TransactionType::"Interest Paid", Dim1, Dim2, true);
                                                TotalCreditAmount -= (Loan."Outstanding Interest");
                                                if TotalCreditAmount > Loan."Outstanding Balance" then begin
                                                    SaccoTrans.JournalInsert(LoanTemp, LoanBatch, theReference, Today, AccType::Credit, MpesaTransBuffer."Loan Account", Description, AccType::"G/L Account", '', -Loan."Outstanding Balance", theReference, Loan."Loan No.", TransactionType::Repayment, Dim1, Dim2, true);
                                                    TotalCreditAmount -= Loan."Outstanding Balance";
                                                    //Post the rest into FOSA ACC.
                                                    //get member fosa acc.
                                                    LoanApplicant.Reset;
                                                    LoanApplicant.Get(Loan."Member No.");
                                                    FosaAcc := SkyMbankingTrans.GetMemberFosaAcc(LoanApplicant);
                                                    SaccoTrans.JournalInsert(LoanTemp, LoanBatch, theReference, Today, AccType::Savings, FosaAcc, Description, AccType::"G/L Account", '', -TotalCreditAmount, theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                end else
                                                    SaccoTrans.JournalInsert(LoanTemp, LoanBatch, theReference, Today, AccType::Credit, MpesaTransBuffer."Loan Account", Description, AccType::"G/L Account", '', -TotalCreditAmount, theReference, Loan."Loan No.", TransactionType::Repayment, Dim1, Dim2, true);
                                            end
                                            else
                                                SaccoTrans.JournalInsert(LoanTemp, LoanBatch, theReference, Today, AccType::Credit, MpesaTransBuffer."Loan Account", Description, AccType::"G/L Account", '', -TotalCreditAmount, theReference, Loan."Loan No.", TransactionType::"Interest Paid", Dim1, Dim2, true);
                                        end;

                                    end;

                                    if SaccoTrans.PostJournal(LoanTemp, LoanBatch) then begin
                                        MpesaTransBuffer.Posted := true;
                                        MpesaTransBuffer."Posting Date" := Today;
                                        MpesaTransBuffer."Posting Time" := time;
                                        MpesaTransBuffer."Posted By" := UserID;
                                        MpesaTransBuffer."Needs Change" := false;
                                        MpesaTransBuffer.Modify();

                                        // SMS
                                        BeneficiaryLoan.Reset;
                                        BeneficiaryLoan.SetRange("Loan No.", MpesaTransBuffer."Loan No.");
                                        BeneficiaryLoan.SetLoadFields("Member No.", "Loan Product Type Name", "Loan No.", "Member Name");

                                        if BeneficiaryLoan.FindFirst then begin
                                            /*
                                            Receiver SMS: Dear [Member name], your [Product name] [Account number] has been credited with KES [Amount] received from [Phone number], [Name] on [date+time]. Mpesa ref: [Mpesa Ref]
                                            */
                                            TheDestinationMember.Reset;
                                            TheDestinationMember.SetRange("No.", BeneficiaryLoan."Member No.");
                                            TheDestinationMember.SetLoadFields(Name, "Phone No.", "Transactional Mobile Number");

                                            if TheDestinationMember.FindFirst then begin
                                                theSMS := 'Dear ' + TheDestinationMember.Name +
                                        ', a loan repayment of KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                        ' for your loan ' + BeneficiaryLoan."Loan Product Type Name" +
                                        ' ' + BeneficiaryLoan."Loan No." +
                                        ' has been received from ' + MpesaTransBuffer."Initiator Identifier" +
                                        ', ' + MpesaTransBuffer."Initiator Name" +
                                        ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                        '. Mpesa ref: ' + MpesaTransBuffer."Transaction Source Reference";

                                                if TheDestinationMember."Phone No." <> '' then begin
                                                    ReceiverSMSNo := TheDestinationMember."Phone No.";
                                                    SkySMS.SendSms(
                                                        SMSSource::DEPOSIT_CONFIRMATION,
                                                        TheDestinationMember."Phone No.",
                                                        theSMS,
                                                        MpesaTransBuffer."Transaction Source Reference",
                                                        '',
                                                        true,
                                                        0,
                                                        true,
                                                        'MBANKING',
                                                        MpesaTransBuffer."Originator ID",
                                                        'CBS'
                                                    );
                                                end else begin
                                                    if TheDestinationMember."Transactional Mobile Number" <> '' then begin
                                                        ReceiverSMSNo := TheDestinationMember."Transactional Mobile Number";
                                                        SkySMS.SendSms(
                                                            SMSSource::DEPOSIT_CONFIRMATION,
                                                            TheDestinationMember."Transactional Mobile Number",
                                                            theSMS,
                                                            MpesaTransBuffer."Transaction Source Reference",
                                                            '',
                                                            true,
                                                            0,
                                                            true,
                                                            'MBANKING',
                                                            MpesaTransBuffer."Originator ID",
                                                            'CBS'
                                                        );
                                                    end;
                                                end;

                                                if ReceiverSMSNo <> MpesaTransBuffer."Initiator Identifier" then begin
                                                    /*
                                                    Sender SMS: Your MPESA deposit of KES [Amount] to paybill 541900 for [Account name] on [date+time] has been received. Mpesa ref: [Mpesa Ref]
                                                    */
                                                    theSMS := 'Your MPESA loan repayment of KES ' +
                                                    Format(MpesaTransBuffer."Transaction Amount") +
                                                    ' to paybill ' +
                                                    MpesaTransBuffer."Receiver Identifier" +
                                                    ' for ' +
                                                    BeneficiaryLoan."Loan No." +
                                                    ' on ' +
                                                    GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                    ' has been received. MPESA ref: ' +
                                                    MpesaTransBuffer."Transaction Source Reference";

                                                    SkySMS.SendSms(
                                                        SMSSource::DEPOSIT_CONFIRMATION,
                                                        MpesaTransBuffer."Initiator Identifier",
                                                        theSMS,
                                                        MpesaTransBuffer."Transaction Source Reference",
                                                        '',
                                                        true,
                                                        0,
                                                        true,
                                                        'MBANKING',
                                                        MpesaTransBuffer."Originator ID",
                                                        'CBS'
                                                    );
                                                end;
                                            end;
                                        end;
                                    end else begin
                                        GLEntry.Reset;
                                        GLEntry.SetRange("Document No.", theReference);
                                        GLEntry.SetLoadFields("Entry No.");
                                        if GLEntry.FindFirst then begin
                                            MpesaTransBuffer.Posted := true;
                                            MpesaTransBuffer."Posting Date" := Today;
                                            MpesaTransBuffer."Posting Time" := time;
                                            MpesaTransBuffer."Posted By" := UserID;
                                            MpesaTransBuffer.Modify();

                                            // SMS
                                            BeneficiaryLoan.Reset;
                                            BeneficiaryLoan.SetRange("Loan No.", MpesaTransBuffer."Loan No.");
                                            BeneficiaryLoan.SetLoadFields("Member No.", "Loan Product Type Name", "Loan No.", "Member Name");

                                            if BeneficiaryLoan.FindFirst then begin
                                                /*
                                                Receiver SMS: Dear [Member name], your [Product name] [Account number] has been credited with KES [Amount] received from [Phone number], [Name] on [date+time]. Mpesa ref: [Mpesa Ref]
                                                */
                                                TheDestinationMember.Reset;
                                                TheDestinationMember.SetRange("No.", BeneficiaryLoan."Member No.");
                                                TheDestinationMember.SetLoadFields(Name, "Phone No.", "Transactional Mobile Number");

                                                if TheDestinationMember.FindFirst then begin
                                                    theSMS := 'Dear ' + TheDestinationMember.Name +
                                        ', a loan repayment of KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                        ' for your loan ' + BeneficiaryLoan."Loan Product Type Name" +
                                        ' ' + BeneficiaryLoan."Loan No." +
                                        ' has been received from ' + MpesaTransBuffer."Initiator Identifier" +
                                        ', ' + MpesaTransBuffer."Initiator Name" +
                                        ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                        '. Mpesa ref: ' + MpesaTransBuffer."Transaction Source Reference";

                                                    if TheDestinationMember."Phone No." <> '' then begin
                                                        ReceiverSMSNo := TheDestinationMember."Phone No.";
                                                        SkySMS.SendSms(
                                                            SMSSource::DEPOSIT_CONFIRMATION,
                                                            TheDestinationMember."Phone No.",
                                                            theSMS,
                                                            MpesaTransBuffer."Transaction Source Reference",
                                                            '',
                                                            true,
                                                            0,
                                                            true,
                                                            'MBANKING',
                                                            MpesaTransBuffer."Originator ID",
                                                            'CBS'
                                                        );
                                                    end else begin
                                                        if TheDestinationMember."Transactional Mobile Number" <> '' then begin
                                                            ReceiverSMSNo := TheDestinationMember."Transactional Mobile Number";
                                                            SkySMS.SendSms(
                                                                SMSSource::DEPOSIT_CONFIRMATION,
                                                                TheDestinationMember."Transactional Mobile Number",
                                                                theSMS,
                                                                MpesaTransBuffer."Transaction Source Reference",
                                                                '',
                                                                true,
                                                                0,
                                                                true,
                                                                'MBANKING',
                                                                MpesaTransBuffer."Originator ID",
                                                                'CBS'
                                                            );
                                                        end;
                                                    end;

                                                    if ReceiverSMSNo <> MpesaTransBuffer."Initiator Identifier" then begin
                                                        /*
                                                        Sender SMS: Your MPESA deposit of KES [Amount] to paybill 541900 for [Account name] on [date+time] has been received. Mpesa ref: [Mpesa Ref]
                                                        */
                                                        theSMS := 'Your MPESA loan repayment of KES ' +
                                                        Format(MpesaTransBuffer."Transaction Amount") +
                                                        ' to paybill ' +
                                                        MpesaTransBuffer."Receiver Identifier" +
                                                        ' for ' +
                                                        BeneficiaryLoan."Loan No." +
                                                        ' on ' +
                                                        GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                        ' has been received. MPESA ref: ' +
                                                        MpesaTransBuffer."Transaction Source Reference";

                                                        SkySMS.SendSms(
                                                            SMSSource::DEPOSIT_CONFIRMATION,
                                                            MpesaTransBuffer."Initiator Identifier",
                                                            theSMS,
                                                            MpesaTransBuffer."Transaction Source Reference",
                                                            '',
                                                            true,
                                                            0,
                                                            true,
                                                            'MBANKING',
                                                            MpesaTransBuffer."Originator ID",
                                                            'CBS'
                                                        );
                                                    end;
                                                end;
                                            end;
                                        end else begin
                                            MpesaTransBuffer."Try Posting Count" := MpesaTransBuffer."Try Posting Count" + 1;
                                            MpesaTransBuffer."Needs Change" := true;
                                            MpesaTransBuffer."Needs Change Reason" := 'The record was not able to post';
                                            MpesaTransBuffer.Modify();
                                        end;
                                    end;
                                end;
                            end;

                            PostingBatchCounter += 1;
                        until (DepositTransBuffer.next = 0) OR (PostingBatchCounter = PostingBatchSize);


                        if RecordsCount < PostingBatchSize then begin
                            SuccessMessage := Format(RecordsCount) + ' loan repayments(s) were processed successfully';
                        end else begin
                            SuccessMessage := Format(PostingBatchSize) + ' out of ' + Format(RecordsCount) + ' loan repayment(s) were processed successfully';
                        end;
                    end else begin
                        SuccessMessage := '0 Loan repayments were processed';
                    end;
                end;
            'WITHDRAWAL':
                //Withdrawal transactions - DONE
                begin
                    if Settings.FindFirst then begin
                        if Settings."Disable Mob. Wtd. Post" then begin
                            // Process reversals only
                            MpesaTransBuffer.Reset();
                            MpesaTransBuffer.SetRange("Posted", false);
                            MpesaTransBuffer.SetRange("Needs Change", false);
                            MpesaTransBuffer.SetFilter("Transaction Status", '=%1', MpesaTransBuffer."Transaction Status"::REVERSE_CONFIRMED);
                            MpesaTransBuffer.SetFilter(
                                "Transaction Type",
                                '%1|%2|%3|%4|%5|%6',
                                MpesaTransBuffer."Transaction Type"::Airtime,
                                MpesaTransBuffer."Transaction Type"::"Mpesa Withdrawal",
                                MpesaTransBuffer."Transaction Type"::"Bank Transfer",
                                MpesaTransBuffer."Transaction Type"::"Utility Payment",
                                MpesaTransBuffer."Transaction Type"::"Till Payment",
                                MpesaTransBuffer."Transaction Type"::"Gaming Utility Payment"
                            );
                            MpesaTransBuffer.SetCurrentKey("Try Posting Count", "Transaction Date Time");
                            MpesaTransBuffer.SetAscending("Try Posting Count", true);
                            MpesaTransBuffer.SetAscending("Transaction Date Time", true);

                            if MpesaTransBuffer.FindSet(true) then begin
                                repeat begin
                                    MpesaTransBuffer.Posted := true;
                                    MpesaTransBuffer."Posting Date" := Today;
                                    MpesaTransBuffer."Posting Time" := time;
                                    MpesaTransBuffer."Posted By" := UserID;
                                    MpesaTransBuffer.Modify();

                                    // Mobile Money Reversal transaction Ref: [REFERENCE] Date: [TIMESTAMP] has been performed

                                    theSMS := ' Mobile Money Reversal transaction Ref:' + MpesaTransBuffer."Beneficiary Reference" +
                                     'Date: ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                     ' has been performed. Ref: ';

                                    if (MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Till Payment") and (MpesaTransBuffer."Receiver Name" <> '') then begin
                                        theSMS := ' Mobile Money Reversal transaction Ref:' + MpesaTransBuffer."Beneficiary Reference" +
                                        'Date: ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                        ' has been performed. Ref: ';
                                    end;

                                    if (MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Gaming Utility Payment") and (MpesaTransBuffer."Receiver Name" <> '') then begin
                                        theSMS := ' Mobile Money Reversal transaction Ref:' + MpesaTransBuffer."Beneficiary Reference" +
                                        'Date: ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                        ' has been performed. Ref: ';
                                    end;

                                    SkySMS.SendSms(
                                        SMSSource::MPESA_WITHDRAWAL_REVERSAL,
                                        MpesaTransBuffer."Initiator Identifier",
                                        theSMS,
                                        MpesaTransBuffer."Beneficiary Reference",
                                        '',
                                        true,
                                        0,
                                        true,
                                        'MBANKING',
                                        MpesaTransBuffer."Originator ID",
                                        'CBS'
                                    );
                                end until MpesaTransBuffer.Next = 0;
                            end;

                            ResponseData.Add('request_status', 'SUCCESS');
                            ResponseData.Add('request_status_description', 'WITHDRAWAL posting has been disabled at the moment');
                            ResponseData.WriteTo(Response);
                            exit(Response);
                        end;
                    end;

                    MobileTransTypes.SetFilter(Type, '%1|%2|%3|%4|%5|%6',
                        MobileTransTypes.Type::Airtime,
                        MobileTransTypes.Type::"Mpesa Withdrawal",
                        MobileTransTypes.Type::"Bank Transfer",
                        MobileTransTypes.Type::"Utility Payment",
                        MobileTransTypes.Type::"Till Payment",
                        MobileTransTypes.Type::"Gaming Utility Payment"
                    );
                    if MobileTransTypes.FindSet then begin
                        repeat
                            MpesaTransBuffer.Reset();
                            MpesaTransBuffer.SetRange("Posted", false);
                            MpesaTransBuffer.SetRange("Needs Change", false);
                            MpesaTransBuffer.SetFilter("Transaction Status", '=%1|%2', MpesaTransBuffer."Transaction Status"::CONFIRMED, MpesaTransBuffer."Transaction Status"::REVERSE_CONFIRMED);
                            MpesaTransBuffer.SetRange("Transaction Type", MobileTransTypes.Type);
                            MpesaTransBuffer.SetCurrentKey("Try Posting Count", "Transaction Date Time");
                            MpesaTransBuffer.SetAscending("Try Posting Count", true);
                            MpesaTransBuffer.SetAscending("Transaction Date Time", true);
                            if MpesaTransBuffer.findset(true) then begin
                                PostingBatchCounter := 0;
                                repeat
                                    TotalCharges := 0;

                                    if MpesaTransBuffer."Beneficiary Reference" <> '' then
                                        theReference := CopyStr(MpesaTransBuffer."Beneficiary Reference", 1, 19)
                                    else if MpesaTransBuffer."Originator ID" <> '' then
                                        theReference := CopyStr(MpesaTransBuffer."Originator ID", 1, 19)
                                    else begin
                                        MpesaTransBuffer."Try Posting Count" += 1;
                                        MpesaTransBuffer."Needs Change" := true;
                                        MpesaTransBuffer."Needs Change Reason" := 'Missing reference number for withdrawal transaction';
                                        MpesaTransBuffer.Modify();
                                        PostingBatchCounter += 1;
                                    end;

                                    GLEntry.Reset;
                                    GLEntry.SetRange("Document No.", theReference);
                                    GLEntry.SetLoadFields("Entry No.");
                                    if GLEntry.FindFirst then begin
                                        MpesaTransBuffer.Posted := true;
                                        MpesaTransBuffer."Posting Date" := Today;
                                        MpesaTransBuffer."Posting Time" := time;
                                        MpesaTransBuffer."Posted By" := UserID;
                                        MpesaTransBuffer.Modify();

                                        // SMS
                                        BeneficiarySavingsAccount.Reset;
                                        BeneficiarySavingsAccount.SetRange("No.", MpesaTransBuffer."Savings Account");
                                        BeneficiarySavingsAccount.SetLoadFields(
                                            "No.",
                                            "Name",
                                            "Product Name",
                                            "Member No.",
                                            "Product Type",
                                            "Global Dimension 2 Code",
                                            Status,
                                            "Balance (LCY)",
                                            "Authorised Over Draft",
                                            "Uncleared Cheques",
                                            "ATM Transactions",
                                            "Lien Placed",
                                            "Coop Transactions",
                                            "One Month Installment",
                                            "Product Category"
                                        );
                                        if BeneficiarySavingsAccount.FindFirst then begin
                                            //    Dear [FIRST_NAME], Mobile banking cash withdrawal ID [MPESA REF] of KSHs [AMOUNT] to [FULL_NAME] from your FOSA account [AC NUMBER] on [TIMESTAMP]

                                            theSMS := 'Dear ' + TheSourceMember."First Name" +
                                             ', Mobile banking cash withdrawal ID ' + MpesaTransBuffer."Beneficiary Reference" +
                                             ' of KES ' + Format(MpesaTransBuffer."Transaction Amount")
                                             + ' to ' + MpesaTransBuffer."Receiver Identifier" +
                                             ' from your FOSA account ' + BeneficiarySavingsAccount."No." +
                                             ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time");

                                            if (MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Till Payment") and (MpesaTransBuffer."Receiver Name" <> '') then begin
                                                theSMS := 'Dear ' + TheSourceMember."First Name" + ', Your ' +
                                                Format(MpesaTransBuffer."Transaction Type") +
                                                ' request of KES ' +
                                                Format(MpesaTransBuffer."Transaction Amount") +
                                                ' to ' + MpesaTransBuffer."Receiver Identifier" +
                                                ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                ' has been completed successfully. MPESA ref: ' + MpesaTransBuffer."Beneficiary Reference" + '. Ref: ' + theReference;
                                            end;

                                            if (MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Gaming Utility Payment") and (MpesaTransBuffer."Receiver Name" <> '') then begin
                                                theSMS := 'Dear ' + TheSourceMember."First Name" + ', Your ' +
                                            Format(MpesaTransBuffer."Transaction Type") +
                                            ' request of KES ' +
                                            Format(MpesaTransBuffer."Transaction Amount") +
                                            ' to ' + MpesaTransBuffer."Receiver Identifier" +
                                            ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                            ' has been completed successfully. MPESA ref: ' + MpesaTransBuffer."Beneficiary Reference" + '. Ref: ' + theReference;
                                            end;

                                            if MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Bank Transfer" then begin
                                                SkySMS.SendSms(
                                                    SMSSource::BANK_TRANSFER,
                                                    MpesaTransBuffer."Initiator Identifier",
                                                    theSMS,
                                                    MpesaTransBuffer."Beneficiary Reference",
                                                    '',
                                                    true,
                                                    0,
                                                    true,
                                                    'MBANKING',
                                                    MpesaTransBuffer."Originator ID",
                                                    'CBS'
                                                );
                                            end else begin
                                                SkySMS.SendSms(
                                                    SMSSource::MPESA_WITHDRAWAL,
                                                    MpesaTransBuffer."Initiator Identifier",
                                                    theSMS,
                                                    MpesaTransBuffer."Beneficiary Reference",
                                                    '',
                                                    true,
                                                    0,
                                                    true,
                                                    'MBANKING',
                                                    MpesaTransBuffer."Originator ID",
                                                    'CBS'
                                                );
                                            end;

                                            // Other Number

                                            if MpesaTransBuffer."Initiator Identifier" <> MpesaTransBuffer."Beneficiary Identifier" then begin
                                                if SavingsAccounts.Get(MpesaTransBuffer."Savings Account") then
                                                    TheSourceMember.Get(SavingsAccounts."Member No.");

                                                theSMS := 'You have received KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                                    ' on your account ' + MpesaTransBuffer."Beneficiary Identifier" +
                                                    ' from ' + TheSourceMember.Name + ' ' + MpesaTransBuffer."Initiator Identifier" +
                                                    ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                    '. M-PESA Ref: ' + MpesaTransBuffer."Beneficiary Reference" +
                                                    '. Ref: ' + theReference;

                                                SkySMS.SendSms(
                                                    SMSSource::MPESA_WITHDRAWAL,
                                                    MpesaTransBuffer."Beneficiary Identifier",
                                                    theSMS,
                                                    MpesaTransBuffer."Beneficiary Reference",
                                                    '',
                                                    true,
                                                    0,
                                                    true,
                                                    'MBANKING',
                                                    MpesaTransBuffer."Originator ID",
                                                    'CBS'
                                                );
                                            end;
                                        end;
                                    end else begin
                                        if SavingsAccounts.get(MpesaTransBuffer."Source Account") then begin
                                            Dim1 := SavingsAccounts."Global Dimension 1 Code";
                                            Dim2 := SavingsAccounts."Global Dimension 2 Code";
                                            case MpesaTransBuffer."Transaction Status" of
                                                MpesaTransBuffer."Transaction Status"::CONFIRMED:
                                                    begin
                                                        SaccoTrans.InitJournal(JTemplate, JBatch);
                                                        Description := CopyStr(MpesaTransBuffer."Transaction Description", 1, 150);
                                                        if Description = '' then begin
                                                            if MobileTransTypes.Description <> '' then
                                                                Description := CopyStr(MobileTransTypes.Description, 1, 150)
                                                            else
                                                                Description := Format(MpesaTransBuffer."Transaction Type");
                                                        end;
                                                        // Db Member account.
                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Source Account", Description, AccType::"G/L Account", '', MpesaTransBuffer."Transaction Amount", theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                        // Cr Bank Acc.
                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::"Bank Account", MobileTransTypes."Bank Account", Description, AccType::"G/L Account", '', -MpesaTransBuffer."Transaction Amount", theReference, '', TransactionType::" ", Dim1, Dim2, true);

                                                        TotalExciseDuty := 0;

                                                        // Charges if Any
                                                        MobileTransLines.Reset();
                                                        MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);
                                                        MobileTransLines.SetFilter("Account No.", '<>%1', '');
                                                        if MobileTransLines.FindSet then begin
                                                            TotalCharges := 0;
                                                            repeat
                                                                Clear(currCharges);

                                                                currCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, MpesaTransBuffer."Transaction Amount");

                                                                if currCharges.Get(1) > 0 then begin
                                                                    SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, MobileTransLines."Account Type", MobileTransLines."Account No.", MobileTransLines.Description, AccType::"G/L Account", '', -(currCharges.Get(1) - currCharges.Get(2) - currCharges.Get(3)), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                    if MobileTransLines."Sky Revenue Share" then
                                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Vendor, MobileTransLines."Sky Revenue Account No.", 'Sky World ' + MobileTransLines.Description, AccType::"G/L Account", '', -currCharges.Get(3), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                    TotalCharges += currCharges.Get(1);
                                                                    if MobileTransLines."Recover Excise Duty" then begin
                                                                        TotalExciseDuty += currCharges.Get(2);
                                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::"G/L Account", genSetUp."Excise Duty G/L", 'Excise duty on charges', MobileTransLines."Account Type", '' /*MobileTransLines."Account No."*/, -currCharges.Get(2), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                    end;
                                                                end;
                                                            until MobileTransLines.next = 0;

                                                            if TotalCharges <> 0 then begin
                                                                case MpesaTransBuffer."Transaction Type" of
                                                                    MpesaTransBuffer."Transaction Type"::"Mpesa Withdrawal":
                                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Source Account", MobileTransTypes.Description, AccType::"G/L Account", '', (TotalCharges /*- TotalExciseDuty*/), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                    MpesaTransBuffer."Transaction Type"::"Bank Transfer":
                                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Source Account", MobileTransTypes.Description, AccType::"G/L Account", '', (TotalCharges  /*- TotalExciseDuty*/), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                    MpesaTransBuffer."Transaction Type"::"Utility Payment":
                                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Source Account", MobileTransTypes.Description, AccType::"G/L Account", '', (TotalCharges  /*- TotalExciseDuty*/), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                    MpesaTransBuffer."Transaction Type"::Airtime:
                                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Source Account", MobileTransTypes.Description, AccType::"G/L Account", '', (TotalCharges  /*- TotalExciseDuty*/), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                    MpesaTransBuffer."Transaction Type"::"Till Payment":
                                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Source Account", MobileTransTypes.Description, AccType::"G/L Account", '', (TotalCharges   /*- TotalExciseDuty*/), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                    MpesaTransBuffer."Transaction Type"::"Gaming Utility Payment":
                                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Source Account", MobileTransTypes.Description, AccType::"G/L Account", '', (TotalCharges   /*- TotalExciseDuty*/), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                    else
                                                                end;

                                                                // if TotalExciseDuty > 0 then begin
                                                                //     SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", CopyStr(MobileTransTypes.Description + ' - Excise Duty', 1, 150), AccType::"G/L Account", '', TotalExciseDuty, theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                // end;
                                                            end;
                                                        end;
                                                        if SaccoTrans.PostJournal(JTemplate, JBatch) then begin
                                                            MpesaTransBuffer.Posted := true;
                                                            MpesaTransBuffer."Posting Date" := Today;
                                                            MpesaTransBuffer."Posting Time" := time;
                                                            MpesaTransBuffer."Posted By" := UserID;
                                                            MpesaTransBuffer.Modify();

                                                            BeneficiarySavingsAccount.Reset;
                                                            BeneficiarySavingsAccount.SetRange("No.", MpesaTransBuffer."Savings Account");
                                                            BeneficiarySavingsAccount.SetLoadFields(
                                                                "No.",
                                                                "Name",
                                                                "Product Name",
                                                                "Member No.",
                                                                "Product Type",
                                                                "Global Dimension 2 Code",
                                                                Status,
                                                                "Balance (LCY)",
                                                                "Authorised Over Draft",
                                                                "Uncleared Cheques",
                                                                "ATM Transactions",
                                                                "Lien Placed",
                                                                "Coop Transactions",
                                                                "One Month Installment",
                                                                "Product Category"
                                                            );

                                                            if BeneficiarySavingsAccount.FindFirst then begin

                                                                if SavingsAccounts.Get(MpesaTransBuffer."Savings Account") then
                                                                    TheSourceMember.Get(SavingsAccounts."Member No.");

                                                                /*

                                                                Dear [MEMBER_NAME],
                                                                Your M-PESA Withdrawal request of KES [AMOUNT] 
                                                                to [RECEIVER_IDENTIFIER] on [DATE] has been completed successfully. 
                                                                M-PESA Ref: [BENEFICIARY_REFERENCE]. Ref: [REFERENCE]

                                                                */

                                                                // Dear [FIRST_NAME], Mobile banking cash withdrawal ID [MPESA REF] of KSHs [AMOUNT] to [OTHER NUMBER FULL_NAME] from your FOSA account [ACC NUMBER] on [TIMESTAMP]


                                                                theSMS := 'Dear ' + TheSourceMember."First Name" +
                                                               ', Mobile banking cash withdrawal ID ' + MpesaTransBuffer."Beneficiary Reference" +
                                                               ' of KES ' + Format(MpesaTransBuffer."Transaction Amount")
                                                               + ' to ' + MpesaTransBuffer."Receiver Identifier" +
                                                               ' from your FOSA account ' + BeneficiarySavingsAccount."No." +
                                                               ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time");


                                                                if (MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Till Payment") and (MpesaTransBuffer."Receiver Name" <> '') then begin
                                                                    theSMS := 'Dear ' + TheSourceMember."First Name" + ', Your ' +
                                                                    Format(MpesaTransBuffer."Transaction Type") +
                                                                    ' to ' + MpesaTransBuffer."Receiver Identifier" +
                                                                    ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                    ' has been completed successfully. MPESA ref: ' + MpesaTransBuffer."Beneficiary Reference" +
                                                                    '. Ref: ' + theReference;
                                                                end;

                                                                if (MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Gaming Utility Payment") and (MpesaTransBuffer."Receiver Name" <> '') then begin
                                                                    theSMS := 'Dear ' + TheSourceMember."First Name" + ', Your ' +
                                                                Format(MpesaTransBuffer."Transaction Type") +
                                                                ' to ' + MpesaTransBuffer."Receiver Identifier" +
                                                                ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                ' has been completed successfully. MPESA ref: ' + MpesaTransBuffer."Beneficiary Reference" +
                                                                '. Ref: ' + theReference;
                                                                end;

                                                                if MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Bank Transfer" then begin
                                                                    /*

                                                                     Dear [MEMBER_NAME],
                                                                     Your Bank Transfer request of KES [AMOUNT] to [RECEIVER_IDENTIFIER] - [RECEIVER_NAME] A/C
                                                                     [RECEIVER_ACCOUNT] on [DATE] has been completed successfully. M-PESA Ref: [BENEFICIARY_REFERENCE]. 
                                                                     Ref: [REFERENCE]

                                                                    */

                                                                    theSMS := 'Dear ' + TheSourceMember.Name +
                                                                    ', Your Bank Transfer request of KES ' +
                                                                    Format(MpesaTransBuffer."Transaction Amount") +
                                                                    ' to ' + MpesaTransBuffer."Receiver Identifier" +
                                                                    ' - ' + MpesaTransBuffer."Receiver Name" +
                                                                    ' A/C ' + MpesaTransBuffer."Receiver Account" +
                                                                    ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                    ' has been completed successfully. M-PESA Ref: ' + MpesaTransBuffer."Beneficiary Reference" +
                                                                    '. Ref: ' + theReference;

                                                                    SkySMS.SendSms(
                                                                        SMSSource::BANK_TRANSFER,
                                                                        MpesaTransBuffer."Initiator Identifier",
                                                                        theSMS,
                                                                        MpesaTransBuffer."Beneficiary Reference",
                                                                        '',
                                                                        true,
                                                                        0,
                                                                        true,
                                                                        'MBANKING',
                                                                        MpesaTransBuffer."Originator ID",
                                                                        'CBS'
                                                                    );

                                                                    if MpesaTransBuffer."Initiator Identifier" <> MpesaTransBuffer."Beneficiary Identifier" then begin
                                                                        if SavingsAccounts.Get(MpesaTransBuffer."Savings Account") then
                                                                            TheSourceMember.Get(SavingsAccounts."Member No.");

                                                                        theSMS := 'You have received KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                                                            ' on your account ' + MpesaTransBuffer."Beneficiary Identifier" +
                                                                            ' from ' + TheSourceMember."First Name" + ' ' + MpesaTransBuffer."Initiator Identifier" +
                                                                            ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                            '. M-PESA Ref: ' + MpesaTransBuffer."Beneficiary Reference" +
                                                                            '. Ref: ' + theReference;

                                                                        SkySMS.SendSms(
                                                                            SMSSource::MPESA_WITHDRAWAL,
                                                                            MpesaTransBuffer."Beneficiary Identifier",
                                                                            theSMS,
                                                                            MpesaTransBuffer."Beneficiary Reference",
                                                                            '',
                                                                            true,
                                                                            0,
                                                                            true,
                                                                            'MBANKING',
                                                                            MpesaTransBuffer."Originator ID",
                                                                            'CBS'
                                                                        );
                                                                    end;
                                                                end else begin
                                                                    SkySMS.SendSms(
                                                                        SMSSource::MPESA_WITHDRAWAL,
                                                                        MpesaTransBuffer."Initiator Identifier",
                                                                        theSMS,
                                                                        MpesaTransBuffer."Beneficiary Reference",
                                                                        '',
                                                                        true,
                                                                        0,
                                                                        true,
                                                                        'MBANKING',
                                                                        MpesaTransBuffer."Originator ID",
                                                                        'CBS'
                                                                    );
                                                                end;
                                                                // Other Number 
                                                                if MpesaTransBuffer."Initiator Identifier" <> MpesaTransBuffer."Beneficiary Identifier" then begin
                                                                    if SavingsAccounts.Get(MpesaTransBuffer."Savings Account") then
                                                                        TheSourceMember.Get(SavingsAccounts."Member No.");

                                                                    theSMS := 'You have received KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                                                        ' on your account ' + MpesaTransBuffer."Beneficiary Identifier" +
                                                                        ' from ' + TheSourceMember.Name + ' ' + MpesaTransBuffer."Initiator Identifier" +
                                                                        ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                        '. M-PESA Ref: ' + MpesaTransBuffer."Beneficiary Reference" +
                                                                        '. Ref: ' + theReference;

                                                                    SkySMS.SendSms(
                                                                        SMSSource::MPESA_WITHDRAWAL,
                                                                        MpesaTransBuffer."Beneficiary Identifier",
                                                                        theSMS,
                                                                        MpesaTransBuffer."Beneficiary Reference",
                                                                        '',
                                                                        true,
                                                                        0,
                                                                        true,
                                                                        'MBANKING',
                                                                        MpesaTransBuffer."Originator ID",
                                                                        'CBS'
                                                                    );
                                                                end;
                                                            end;
                                                        end else begin
                                                            GLEntry.Reset;
                                                            GLEntry.SetRange("Document No.", theReference);
                                                            GLEntry.SetLoadFields("Entry No.");
                                                            if GLEntry.FindFirst then begin
                                                                MpesaTransBuffer.Posted := true;
                                                                MpesaTransBuffer."Posting Date" := Today;
                                                                MpesaTransBuffer."Posting Time" := time;
                                                                MpesaTransBuffer."Posted By" := UserID;
                                                                MpesaTransBuffer.Modify();

                                                                BeneficiarySavingsAccount.Reset;
                                                                BeneficiarySavingsAccount.SetRange("No.", MpesaTransBuffer."Savings Account");
                                                                BeneficiarySavingsAccount.SetLoadFields(
                                                                    "No.",
                                                                    "Name",
                                                                    "Product Name",
                                                                    "Member No.",
                                                                    "Product Type",
                                                                    "Global Dimension 2 Code",
                                                                    Status,
                                                                    "Balance (LCY)",
                                                                    "Authorised Over Draft",
                                                                    "Uncleared Cheques",
                                                                    "ATM Transactions",
                                                                    "Lien Placed",
                                                                    "Coop Transactions",
                                                                    "One Month Installment",
                                                                    "Product Category"
                                                                );

                                                                if BeneficiarySavingsAccount.FindFirst then begin

                                                                    theSMS := 'Dear ' + TheSourceMember.Name + ', Your ' +
                                                                    Format(MpesaTransBuffer."Transaction Type") +
                                                                    ' request of KES ' +
                                                                    Format(MpesaTransBuffer."Transaction Amount") +
                                                                    ' to ' + MpesaTransBuffer."Receiver Identifier" +
                                                                    ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                    ' has been completed successfully. MPESA ref: ' + MpesaTransBuffer."Beneficiary Reference";

                                                                    if (MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Till Payment") and (MpesaTransBuffer."Receiver Name" <> '') then begin
                                                                        theSMS := 'Dear ' + TheSourceMember.Name + ', Your ' +
                                                                        Format(MpesaTransBuffer."Transaction Type") +
                                                                        ' request of KES ' +
                                                                        Format(MpesaTransBuffer."Transaction Amount") +
                                                                        ' to ' + MpesaTransBuffer."Receiver Identifier" +
                                                                        ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                        ' has been completed successfully. MPESA ref: ' + MpesaTransBuffer."Beneficiary Reference";
                                                                    end;

                                                                    if (MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Gaming Utility Payment") and (MpesaTransBuffer."Receiver Name" <> '') then begin
                                                                        theSMS := 'Dear ' + TheSourceMember.Name + ', Your ' +
                                                                    Format(MpesaTransBuffer."Transaction Type") +
                                                                    ' request of KES ' +
                                                                    Format(MpesaTransBuffer."Transaction Amount") +
                                                                    ' to ' + MpesaTransBuffer."Receiver Identifier" +
                                                                    ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                    ' has been completed successfully. MPESA ref: ' + MpesaTransBuffer."Beneficiary Reference";
                                                                    end;

                                                                    if MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Bank Transfer" then begin
                                                                        SkySMS.SendSms(
                                                                            SMSSource::BANK_TRANSFER,
                                                                            MpesaTransBuffer."Initiator Identifier",
                                                                            theSMS,
                                                                            MpesaTransBuffer."Beneficiary Reference",
                                                                            '',
                                                                            true,
                                                                            0,
                                                                            true,
                                                                            'MBANKING',
                                                                            MpesaTransBuffer."Originator ID",
                                                                            'CBS'
                                                                        );
                                                                    end else begin
                                                                        SkySMS.SendSms(
                                                                            SMSSource::MPESA_WITHDRAWAL,
                                                                            MpesaTransBuffer."Initiator Identifier",
                                                                            theSMS,
                                                                            MpesaTransBuffer."Beneficiary Reference",
                                                                            '',
                                                                            true,
                                                                            0,
                                                                            true,
                                                                            'MBANKING',
                                                                            MpesaTransBuffer."Originator ID",
                                                                            'CBS'
                                                                        );
                                                                    end
                                                                end;
                                                                if MpesaTransBuffer."Initiator Identifier" <> MpesaTransBuffer."Beneficiary Identifier" then begin
                                                                    if SavingsAccounts.Get(MpesaTransBuffer."Savings Account") then
                                                                        TheSourceMember.Get(SavingsAccounts."Member No.");

                                                                    theSMS := 'You have received KES ' + Format(MpesaTransBuffer."Transaction Amount") +
                                                                        ' on your account ' + MpesaTransBuffer."Beneficiary Identifier" +
                                                                        ' from ' + TheSourceMember.Name + ' ' + MpesaTransBuffer."Initiator Identifier" +
                                                                        ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                        '. M-PESA Ref: ' + MpesaTransBuffer."Beneficiary Reference" +
                                                                        '. Ref: ' + theReference;

                                                                    SkySMS.SendSms(
                                                                        SMSSource::MPESA_WITHDRAWAL,
                                                                        MpesaTransBuffer."Beneficiary Identifier",
                                                                        theSMS,
                                                                        MpesaTransBuffer."Beneficiary Reference",
                                                                        '',
                                                                        true,
                                                                        0,
                                                                        true,
                                                                        'MBANKING',
                                                                        MpesaTransBuffer."Originator ID",
                                                                        'CBS'
                                                                    );
                                                                end;
                                                            end else begin
                                                                MpesaTransBuffer."Try Posting Count" := MpesaTransBuffer."Try Posting Count" + 1;
                                                                MpesaTransBuffer."Needs Change" := true;
                                                                MpesaTransBuffer."Needs Change Reason" := 'The record was not able to post';
                                                                MpesaTransBuffer.Modify();
                                                            end;
                                                        end;
                                                    end;
                                                MpesaTransBuffer."Transaction Status"::REVERSE_CONFIRMED:
                                                    begin
                                                        MpesaTransBuffer.Posted := true;
                                                        MpesaTransBuffer."Posting Date" := Today;
                                                        MpesaTransBuffer."Posting Time" := time;
                                                        MpesaTransBuffer."Posted By" := UserID;
                                                        MpesaTransBuffer.Modify();

                                                        // theSMS := 'Dear ' + TheSourceMember.Name + ', Your ' +
                                                        // Format(MpesaTransBuffer."Transaction Type") +
                                                        //     ' request of KES ' +
                                                        //     Format(MpesaTransBuffer."Transaction Amount") +
                                                        //     ' done on ' +
                                                        //     GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                        //     ' has been reversed. Ref: ' + MpesaTransBuffer."Beneficiary Reference";

                                                        // Dear [MEMBER_NAME], your Cash Withdrawal request of KES [AMOUNT] on [DATE] has been REVERSED. Dial [USSD_CODE] to check your balance. Ref: [REFERENCE] Date: [DATE]

                                                        if SavingsAccounts.Get(MpesaTransBuffer."Savings Account") then
                                                            TheSourceMember.Get(SavingsAccounts."Member No.");

                                                        theSMS := ' Mobile Money Reversal transaction Ref:' + MpesaTransBuffer."Beneficiary Reference" +
                                                        'Date: ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                        ' has been performed. Ref: ';

                                                        if (MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Till Payment") and (MpesaTransBuffer."Receiver Name" <> '') then begin
                                                            theSMS := 'Dear ' + TheSourceMember.Name + ', Your ' +
                                                            Format(MpesaTransBuffer."Transaction Type") +
                                                            ' request of KES ' +
                                                            Format(MpesaTransBuffer."Transaction Amount") +
                                                            ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                            ' has been reversed. Ref: ' + MpesaTransBuffer."Beneficiary Reference";
                                                        end;

                                                        if (MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Gaming Utility Payment") and (MpesaTransBuffer."Receiver Name" <> '') then begin
                                                            theSMS := 'Dear ' + TheSourceMember.Name + ', Your ' +
                                                            Format(MpesaTransBuffer."Transaction Type") +
                                                             ' request of KES ' +
                                                            Format(MpesaTransBuffer."Transaction Amount") +
                                                            ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                            ' has been reversed. Ref: ' + MpesaTransBuffer."Beneficiary Reference";
                                                        end;

                                                        SkySMS.SendSms(
                                                            SMSSource::MPESA_WITHDRAWAL_REVERSAL,
                                                            MpesaTransBuffer."Initiator Identifier",
                                                            theSMS,
                                                            MpesaTransBuffer."Beneficiary Reference",
                                                            '',
                                                            true,
                                                            0,
                                                            true,
                                                            'MBANKING',
                                                            MpesaTransBuffer."Originator ID",
                                                            'CBS'
                                                        );
                                                    end;
                                            end;
                                        end else begin
                                            MpesaTransBuffer."Try Posting Count" := MpesaTransBuffer."Try Posting Count" + 1;
                                            MpesaTransBuffer."Needs Change" := true;
                                            MpesaTransBuffer."Needs Change Reason" := 'The source account was not found in Savings Accounts list';
                                            MpesaTransBuffer.Modify();
                                        end;
                                    end;

                                    PostingBatchCounter += 1;
                                until (MpesaTransBuffer.next = 0) OR (PostingBatchCounter = (PostingBatchSize DIV 4));
                            end;
                        until MobileTransTypes.next = 0;
                        SuccessMessage := 'Mpesa Withdrawal/utility payments were processed Successfully';
                        Commit();
                        // PIN Resets
                        PostPINResets();
                    end else begin
                        ResponseData.Add('request_status', 'FAILED');
                        ResponseData.Add('request_status_description', 'Transaction type for Mpesa Withdrawals and other utilities is not available');

                        Datum.Add('error_message', 'Transaction type for Mpesa Withdrawals and other utilities is not available');
                        ResponseData.Add('response_payload', Datum);
                        ResponseData.WriteTo(Response);
                        exit(Response);
                    end;
                end;
            'INTERNAL':
                //Other transactions*
                begin
                    if Settings.FindFirst then begin
                        if Settings."Disable Mob. Internal Post" then begin
                            ResponseData.Add('request_status', 'SUCCESS');
                            ResponseData.Add('request_status_description', 'INTERNAL posting has been disabled at the moment');
                            ResponseData.WriteTo(Response);
                            exit(Response);
                        end;
                    end;

                    MobileTransTypes.SetFilter(
                        Type,
                        '=%1|%2|%3|%4|%5|%6|%7|%8|%9',
                        MobileTransTypes.Type::"Account Balance Enquiry",
                        MobileTransTypes.Type::"Account Mini-Statement",
                        MobileTransTypes.Type::"Account Full-Statement",
                        MobileTransTypes.Type::"Account Transfer", //
                        MobileTransTypes.Type::"Pay Loan From Account", //
                        MobileTransTypes.Type::"Loan Balance Enquiry",
                        MobileTransTypes.Type::"Loan Mini-Statement",
                        MobileTransTypes.Type::"Loan Full-Statement",
                        MobileTransTypes.Type::"KESASA Account Transfer"
                    );
                    if MobileTransTypes.FindSet then begin
                        repeat
                            MpesaTransBuffer.Reset();
                            MpesaTransBuffer.SetRange("Posted", false);
                            MpesaTransBuffer.SetRange("Needs Change", false);
                            MpesaTransBuffer.SetFilter("Transaction Status", '=%1|%2', MpesaTransBuffer."Transaction Status"::CONFIRMED, MpesaTransBuffer."Transaction Status"::REVERSE_CONFIRMED);
                            MpesaTransBuffer.SetRange("Transaction Type", MobileTransTypes.Type);
                            MpesaTransBuffer.SetCurrentKey("Try Posting Count", "Transaction Date Time");
                            MpesaTransBuffer.SetAscending("Try Posting Count", true);
                            MpesaTransBuffer.SetAscending("Transaction Date Time", true);
                            if MpesaTransBuffer.FindSet(true) then begin
                                PostingBatchCounter := 0;

                                repeat
                                    TotalCharges := 0;
                                    theReference := CopyStr(MpesaTransBuffer."Originator ID", 1, 19);
                                    GLEntry.Reset;
                                    GLEntry.SetRange("Document No.", theReference);
                                    GLEntry.SetLoadFields("Entry No.");
                                    if GLEntry.FindFirst then begin
                                        MpesaTransBuffer.Posted := true;
                                        MpesaTransBuffer."Posting Date" := Today;
                                        MpesaTransBuffer."Posting Time" := time;
                                        MpesaTransBuffer."Posted By" := UserID;
                                        MpesaTransBuffer.Modify();
                                        // IFT SMS
                                        if (MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Account Transfer") OR
                                        (MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Kesasa Account Transfer") OR
                                        (MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Pay Loan From Account") then begin
                                            if SavingsAccounts.get(MpesaTransBuffer."Savings Account") then begin
                                                if TheSourceMember.Get(SavingsAccounts."Member No.") then begin
                                                    case MpesaTransBuffer."Transaction Type" of
                                                        MpesaTransBuffer."Transaction Type"::"Account Transfer",
                                                        MpesaTransBuffer."Transaction Type"::"Kesasa Account Transfer":
                                                            begin
                                                                /*
                                                                Jambo [FIRST_NAME], REF: [REFERENCE], 
                                                                you have successfully transferred Kshs. [AMOUNT] 
                                                                 to [OTHER MEMBER NAME], 
                                                                 your available balance is Ksh [AMOUNT] on [TIMESTAMP]. 
                                                                */

                                                                theSMS := 'Jambo ' + TheSourceMember."First Name".ToUpper() +
                                                                ', you have successfully transferred Kshs. ' +
                                                                Format(MpesaTransBuffer."Transaction Amount" - MpesaTransBuffer."Total Charges") +
                                                                 ' to ' + TheDestinationSavings."Name" +
                                                                ', your available balance is Ksh ' + Format(GlobalFunctions.GetSavingsAccountAvailableBalance(SavingsAccounts, true)) +
                                                                ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time");

                                                                SkySMS.SendSms(
                                                                    SMSSource::IFT_ACCOUNT,
                                                                    TheSourceMember."Transactional Mobile Number",
                                                                    theSMS,
                                                                    theReference,
                                                                    '',
                                                                    true,
                                                                    0,
                                                                    true,
                                                                    'MBANKING',
                                                                    MpesaTransBuffer."Originator ID",
                                                                    'CBS'
                                                                );
                                                            end;
                                                        MpesaTransBuffer."Transaction Type"::"Pay Loan From Account":
                                                            begin
                                                                theSMS := 'Jambo  ' + TheSourceMember."First Name".ToUpper() +
                                                                    ', your internal loan repayment request of KES ' +
                                                                    Format(MpesaTransBuffer."Transaction Amount" - MpesaTransBuffer."Total Charges") +
                                                                    ' from ' + SavingsAccounts."Product Name" + ' ' + MpesaTransBuffer."Savings Account" +
                                                                    ' to ' + SavingsAccounts."Product Name" + ' ' + MpesaTransBuffer."Loan Account" +
                                                                    ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                    ' has been completed successfully. Ref: ' + theReference;

                                                                SkySMS.SendSms(
                                                                    SMSSource::IFT_LOAN,
                                                                    TheSourceMember."Transactional Mobile Number",
                                                                    theSMS,
                                                                    theReference,
                                                                    '',
                                                                    true,
                                                                    0,
                                                                    true,
                                                                    'MBANKING',
                                                                    MpesaTransBuffer."Originator ID",
                                                                    'CBS'
                                                                );
                                                            end;

                                                    end;

                                                    // Destination - Savings
                                                    if MpesaTransBuffer."Destination Account" <> '' then begin
                                                        if TheDestinationSavings.Get(MpesaTransBuffer."Destination Account") then begin
                                                            if TheSourceMember."No." <> TheDestinationSavings."Member No." then begin
                                                                if TheDestinationMember.Get(TheDestinationSavings."Member No.") then begin
                                                                    theSMS := 'Jambo ' + TheDestinationMember."First Name".ToUpper() +
                                                                        ', ' + TheSourceMember.Name.ToUpper() + ' has transferred KES ' +
                                                                        Format(MpesaTransBuffer."Transaction Amount" - MpesaTransBuffer."Total Charges") +
                                                                        ' to your account no. ' + TheDestinationSavings."No." +
                                                                        ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                        '. Ref: ' + theReference;

                                                                    SkySMS.SendSms(
                                                                        SMSSource::IFT_ACCOUNT,
                                                                        TheDestinationMember."Transactional Mobile Number",
                                                                        theSMS,
                                                                        theReference,
                                                                        '',
                                                                        true,
                                                                        0,
                                                                        true,
                                                                        'MBANKING',
                                                                        MpesaTransBuffer."Originator ID",
                                                                        'CBS'
                                                                    );
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                    // Destination - Loan
                                                    if MpesaTransBuffer."Loan No." <> '' then begin
                                                        if TheDestinationLoan.Get(MpesaTransBuffer."Loan No.") then begin
                                                            if TheSourceMember."No." <> TheDestinationLoan."Member No." then begin
                                                                if TheDestinationMember.Get(TheDestinationSavings."Member No.") then begin
                                                                    theSMS := 'Jambo ' + TheDestinationMember."First Name".ToUpper() +
                                                            ',' + TheSourceMember.Name.ToUpper() + ' has transferred KES ' +
                                                            Format(MpesaTransBuffer."Transaction Amount" - MpesaTransBuffer."Total Charges") +
                                                            ' for repayment of your loan no. ' + TheDestinationLoan."Loan No." +
                                                            ' on ' +
                                                            GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                            '. Ref: ' + theReference;

                                                                    SkySMS.SendSms(
                                                                        SMSSource::IFT_LOAN,
                                                                        TheDestinationMember."Transactional Mobile Number",
                                                                        theSMS,
                                                                        theReference,
                                                                        '',
                                                                        true,
                                                                        0,
                                                                        true,
                                                                        'MBANKING',
                                                                        MpesaTransBuffer."Originator ID",
                                                                        'CBS'
                                                                    );
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end else begin

                                        if SavingsAccounts.get(MpesaTransBuffer."Savings Account") then begin
                                            Dim1 := SavingsAccounts."Global Dimension 1 Code";
                                            Dim2 := SavingsAccounts."Global Dimension 2 Code";
                                            case MpesaTransBuffer."Transaction Status" of
                                                MpesaTransBuffer."Transaction Status"::CONFIRMED:
                                                    begin
                                                        SaccoTrans.InitJournal(JTemplate, JBatch);

                                                        theReference := CopyStr(MpesaTransBuffer."Originator ID", 1, 19);
                                                        TotalCreditAmount := MpesaTransBuffer."Transaction Amount";
                                                        Description := CopyStr(MpesaTransBuffer."Transaction Description", 1, 150);
                                                        TotalExciseDuty := 0;

                                                        if Description = '' then begin
                                                            if MobileTransTypes.Description <> '' then
                                                                Description := CopyStr(MobileTransTypes.Description, 1, 150)
                                                            else
                                                                Description := Format(MpesaTransBuffer."Transaction Type");
                                                        end;

                                                        // Check if credit amount is less than the charges
                                                        MobileTransLines.Reset();
                                                        MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);
                                                        MobileTransLines.SetFilter("Account No.", '<>%1', '');
                                                        if MobileTransLines.Findset() then begin
                                                            TotalCharges := 0;
                                                            repeat
                                                                currCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, MpesaTransBuffer."Transaction Amount");
                                                                TotalCharges += currCharges.Get(1);
                                                            until MobileTransLines.next = 0;
                                                        end;

                                                        if TotalCharges >= MpesaTransBuffer."Transaction Amount" then begin
                                                            if MpesaTransBuffer."Transaction Amount" = 0 then begin
                                                                MpesaTransBuffer."Transaction Amount" := TotalCharges;
                                                            end;
                                                            TotalCharges := MpesaTransBuffer."Transaction Amount";
                                                            // Charges if Any
                                                            MobileTransLines.Reset();
                                                            MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);
                                                            MobileTransLines.SetFilter("Account No.", '<>%1', '');
                                                            if MobileTransLines.Findset() then begin
                                                                repeat
                                                                    currCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, MpesaTransBuffer."Transaction Amount");
                                                                    if currCharges.Get(1) <= TotalCharges then begin
                                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, MobileTransLines."Account Type", MobileTransLines."Account No.", MobileTransLines.Description, AccType::"G/L Account", '', -(currCharges.Get(1) - currCharges.Get(2) - currCharges.Get(3)), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                        if MobileTransLines."Sky Revenue Share" then
                                                                            SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Vendor, MobileTransLines."Sky Revenue Account No.", 'Sky World ' + MobileTransLines.Description, AccType::"G/L Account", '', -currCharges.Get(3), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                        if MobileTransLines."Recover Excise Duty" then begin
                                                                            TotalExciseDuty += currCharges.Get(2);
                                                                            SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::"G/L Account", genSetUp."Excise Duty G/L", 'Excise duty on charges', MobileTransLines."Account Type", ''/*MobileTransLines."Account No."*/, -currCharges.Get(2), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                        end;
                                                                    end else begin
                                                                        //
                                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, MobileTransLines."Account Type", MobileTransLines."Account No.", MobileTransLines.Description, AccType::"G/L Account", '', -(TotalCharges), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                    end;

                                                                    TotalCharges -= currCharges.Get(1);
                                                                    Clear(currCharges);
                                                                until (MobileTransLines.next = 0) or (TotalCharges <= 0);
                                                            end;

                                                            case MpesaTransBuffer."Transaction Type" of
                                                                MpesaTransBuffer."Transaction Type"::"Account Balance Enquiry":
                                                                    SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", Description, AccType::"G/L Account", '', MpesaTransBuffer."Transaction Amount", theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                MpesaTransBuffer."Transaction Type"::"Account Mini-Statement":
                                                                    SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", Description, AccType::"G/L Account", '', MpesaTransBuffer."Transaction Amount", theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                MpesaTransBuffer."Transaction Type"::"Account Full-Statement":
                                                                    SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", Description, AccType::"G/L Account", '', MpesaTransBuffer."Transaction Amount", theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                MpesaTransBuffer."Transaction Type"::"Account Transfer",
                                                                MpesaTransBuffer."Transaction Type"::"Kesasa Account Transfer":
                                                                    SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", Description, AccType::"G/L Account", '', MpesaTransBuffer."Transaction Amount", theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                MpesaTransBuffer."Transaction Type"::"Pay Loan From Account":
                                                                    SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", Description, AccType::"G/L Account", '', MpesaTransBuffer."Transaction Amount", theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                MpesaTransBuffer."Transaction Type"::"Loan Balance Enquiry":
                                                                    SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", Description, AccType::"G/L Account", '', MpesaTransBuffer."Transaction Amount", theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                MpesaTransBuffer."Transaction Type"::"Loan Mini-Statement":
                                                                    SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", Description, AccType::"G/L Account", '', MpesaTransBuffer."Transaction Amount", theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                MpesaTransBuffer."Transaction Type"::"Loan Full-Statement":
                                                                    SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", Description, AccType::"G/L Account", '', MpesaTransBuffer."Transaction Amount", theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                else
                                                            end;

                                                            // Recompute total charges
                                                            MobileTransLines.Reset();
                                                            MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);
                                                            MobileTransLines.SetFilter("Account No.", '<>%1', '');
                                                            if MobileTransLines.Findset() then begin
                                                                TotalCharges := 0;
                                                                repeat
                                                                    currCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, MpesaTransBuffer."Transaction Amount");
                                                                    TotalCharges += currCharges.Get(1);
                                                                until MobileTransLines.next = 0;
                                                            end;
                                                        end else begin
                                                            // Charges if Any
                                                            MobileTransLines.Reset();
                                                            MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);
                                                            MobileTransLines.SetFilter("Account No.", '<>%1', '');
                                                            if MobileTransLines.Findset() then begin
                                                                TotalCharges := 0;
                                                                repeat
                                                                    currCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, MpesaTransBuffer."Transaction Amount");
                                                                    theCharge := currCharges.Get(1);

                                                                    if theCharge > 0 then begin
                                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, MobileTransLines."Account Type", MobileTransLines."Account No.", MobileTransLines.Description, AccType::"G/L Account", '', -(theCharge - currCharges.Get(2) - currCharges.Get(3)), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                        if MobileTransLines."Sky Revenue Share" then
                                                                            SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Vendor, MobileTransLines."Sky Revenue Account No.", 'Sky World ' + MobileTransLines.Description, AccType::"G/L Account", '', -currCharges.Get(3), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                        TotalCharges += theCharge;
                                                                        if MobileTransLines."Recover Excise Duty" then begin
                                                                            TotalExciseDuty += currCharges.Get(2);
                                                                            SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::"G/L Account", genSetUp."Excise Duty G/L", 'Excise duty on charges', MobileTransLines."Account Type", ''/*MobileTransLines."Account No."*/, -currCharges.Get(2), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                        end;
                                                                    end;
                                                                until MobileTransLines.next = 0;

                                                                if TotalCharges > 0 then begin
                                                                    case MpesaTransBuffer."Transaction Type" of
                                                                        MpesaTransBuffer."Transaction Type"::"Account Balance Enquiry":
                                                                            SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", MobileTransTypes.Description, AccType::"G/L Account", '', (TotalCharges /*- TotalExciseDuty*/), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                        MpesaTransBuffer."Transaction Type"::"Account Mini-Statement":
                                                                            SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", MobileTransTypes.Description, AccType::"G/L Account", '', (TotalCharges /*- TotalExciseDuty*/), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                        MpesaTransBuffer."Transaction Type"::"Account Full-Statement":
                                                                            SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", MobileTransTypes.Description, AccType::"G/L Account", '', (TotalCharges /*- TotalExciseDuty*/), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                        MpesaTransBuffer."Transaction Type"::"Account Transfer",
                                                                        MpesaTransBuffer."Transaction Type"::"Kesasa Account Transfer":
                                                                            SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", MobileTransTypes.Description, AccType::"G/L Account", '', (TotalCharges /*- TotalExciseDuty*/), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                        MpesaTransBuffer."Transaction Type"::"Pay Loan From Account":
                                                                            SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", MobileTransTypes.Description, AccType::"G/L Account", '', (TotalCharges /*- TotalExciseDuty*/), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                        MpesaTransBuffer."Transaction Type"::"Loan Balance Enquiry":
                                                                            SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", MobileTransTypes.Description, AccType::"G/L Account", '', (TotalCharges /*- TotalExciseDuty*/), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                        MpesaTransBuffer."Transaction Type"::"Loan Mini-Statement":
                                                                            SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", MobileTransTypes.Description, AccType::"G/L Account", '', (TotalCharges /*- TotalExciseDuty*/), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                        MpesaTransBuffer."Transaction Type"::"Loan Full-Statement":
                                                                            SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", MobileTransTypes.Description, AccType::"G/L Account", '', (TotalCharges /*- TotalExciseDuty*/), theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                        else
                                                                    end;
                                                                    // if TotalExciseDuty > 0 then begin
                                                                    //     SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", CopyStr(MobileTransTypes.Description + ' - Excise Duty', 1, 150), AccType::"G/L Account", '', TotalExciseDuty, theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                    // end;
                                                                    // TotalCreditAmount -= TotalCharges;
                                                                end;
                                                            end;

                                                            case MpesaTransBuffer."Transaction Type" of
                                                                MpesaTransBuffer."Transaction Type"::"Account Balance Enquiry":
                                                                    begin
                                                                        //theReference := 'ACC BAL ENQ';
                                                                    end;
                                                                MpesaTransBuffer."Transaction Type"::"Account Mini-Statement":
                                                                    begin
                                                                        //theReference := 'ACC MINI STAT';
                                                                    end;
                                                                MpesaTransBuffer."Transaction Type"::"Account Full-Statement":
                                                                    begin
                                                                        //theReference := 'ACC FULL STAT';
                                                                    end;
                                                                MpesaTransBuffer."Transaction Type"::"Account Transfer",
                                                                MpesaTransBuffer."Transaction Type"::"Kesasa Account Transfer":
                                                                    begin
                                                                        //theReference := 'INT ACC TRANSFER';
                                                                        // Db Source account.
                                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", 'Internal funds transfer to acc. ' + MpesaTransBuffer."Destination Account", AccType::"G/L Account", '', TotalCreditAmount, theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                        // Cr Dest Acc.
                                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Destination Account", 'Internal funds transfer from acc. ' + MpesaTransBuffer."Savings Account", AccType::"G/L Account", '', -TotalCreditAmount, theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                    end;
                                                                MpesaTransBuffer."Transaction Type"::"Pay Loan From Account":
                                                                    begin
                                                                        //theReference := 'INT ACC TO LOAN';
                                                                        // Db Source account.
                                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, MpesaTransBuffer."Savings Account", 'Internal loan repayment to loan ' + MpesaTransBuffer."Loan No.", AccType::"G/L Account", '', TotalCreditAmount, theReference, '', TransactionType::" ", Dim1, Dim2, true);

                                                                        if loan."Outstanding Interest" < 0 then loan."Outstanding Interest" := 0;
                                                                        // Cr loan Oustanding Bal
                                                                        Loan.get(MpesaTransBuffer."Loan No.");
                                                                        Loan.calcfields("Outstanding Balance", "Outstanding Interest", "Daily Interest");
                                                                        if TotalCreditAmount > 0 then begin
                                                                            if Loan."Daily Interest" > 0 then begin
                                                                                if pfac.get(Loan."Loan Product Type") then
                                                                                    if pfac."Loan Interest Account [G/L]" <> '' then begin
                                                                                        SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Credit, MpesaTransBuffer."Loan Account", 'Daily Loan Interest Capitalized. ' + Loan."Loan No.", AccType::"G/L Account", pfac."Loan Interest Account [G/L]", loan."Daily Interest", theReference, Loan."Loan No.", TransactionType::"Interest Due", Dim1, Dim2, true);
                                                                                        LoansProcess.ClearDailyInterest(Loan."Loan No.");
                                                                                    end;
                                                                            end;
                                                                            loan."Outstanding Interest" := loan."Outstanding Interest" + loan."Daily Interest";
                                                                            if loan."Outstanding Interest" > TotalCreditAmount then
                                                                                Loan."Outstanding Interest" := TotalCreditAmount;

                                                                            SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Credit, MpesaTransBuffer."Loan Account", 'Interest. Internal loan repayment from acc. ' + MpesaTransBuffer."Savings Account", AccType::"G/L Account", '', -Loan."Outstanding Interest", theReference, Loan."Loan No.", TransactionType::"Interest Paid", Dim1, Dim2, true);
                                                                            TotalCreditAmount -= Loan."Outstanding Interest";
                                                                            if TotalCreditAmount > 0 then begin
                                                                                if Loan."Outstanding Balance" > TotalCreditAmount then
                                                                                    Loan."Outstanding Balance" := TotalCreditAmount;
                                                                                SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Credit, MpesaTransBuffer."Loan Account", 'Outstanding Balance. Internal loan repayment from acc. ' + MpesaTransBuffer."Savings Account", AccType::"G/L Account", '', -Loan."Outstanding Balance", theReference, Loan."Loan No.", TransactionType::Repayment, Dim1, Dim2, true);
                                                                                TotalCreditAmount -= Loan."Outstanding Balance";
                                                                            end;
                                                                            if TotalCreditAmount > 0 then begin
                                                                                //Post the rest into FOSA ACC.
                                                                                //get member fosa acc.
                                                                                LoanApplicant.Reset;
                                                                                LoanApplicant.Get(Loan."Member No.");
                                                                                FosaAcc := SkyMbankingTrans.GetMemberFosaAcc(LoanApplicant);
                                                                                SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Savings, FosaAcc, MpesaTransBuffer."Loan No." + ': Excess loan repayment', AccType::"G/L Account", '', -TotalCreditAmount, theReference, '', TransactionType::" ", Dim1, Dim2, true);
                                                                            end;// else
                                                                                // SaccoTrans.JournalInsert(JTemplate, JBatch, theReference, Today, AccType::Credit, MpesaTransBuffer."Loan Account", 'Internal loan repayment from acc. ' + MpesaTransBuffer."Savings Account", AccType::"G/L Account", '', -TotalCreditAmount, theReference, Loan."Loan No.", TransactionType::Repayment, Dim1, Dim2, true);
                                                                        end;
                                                                    end;
                                                                MpesaTransBuffer."Transaction Type"::"Loan Balance Enquiry":
                                                                    begin
                                                                        //theReference := 'LOAN BAL ENQ';
                                                                    end;
                                                                MpesaTransBuffer."Transaction Type"::"Loan Mini-Statement":
                                                                    begin
                                                                        //theReference := 'LOAN MINI STAT';
                                                                    end;
                                                                MpesaTransBuffer."Transaction Type"::"Loan Full-Statement":
                                                                    begin
                                                                        //theReference := 'LOAN FULL STAT';
                                                                    end;
                                                                else
                                                            end;
                                                        end;

                                                        if (TotalCharges = 0) and (MpesaTransBuffer."Transaction Amount" = 0) then begin
                                                            MpesaTransBuffer.Posted := true;
                                                            MpesaTransBuffer."Posting Date" := Today;
                                                            MpesaTransBuffer."Posting Time" := time;
                                                            MpesaTransBuffer."Posted By" := UserID;
                                                            MpesaTransBuffer.Modify();
                                                        end else begin
                                                            if SaccoTrans.PostJournal(JTemplate, JBatch) then begin
                                                                MpesaTransBuffer.Posted := true;
                                                                MpesaTransBuffer."Posting Date" := Today;
                                                                MpesaTransBuffer."Posting Time" := time;
                                                                MpesaTransBuffer."Posted By" := UserID;
                                                                MpesaTransBuffer.Modify();

                                                                // IFT SMS
                                                                if (MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Account Transfer") OR
                                                                (MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Kesasa Account Transfer") OR
                                                                (MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Pay Loan From Account") then begin
                                                                    // if SavingsAccounts.get(MpesaTransBuffer."Savings Account") then begin
                                                                    if TheSourceMember.Get(SavingsAccounts."Member No.") then begin
                                                                        case MpesaTransBuffer."Transaction Type" of
                                                                            MpesaTransBuffer."Transaction Type"::"Account Transfer",
                                                                            MpesaTransBuffer."Transaction Type"::"Kesasa Account Transfer":
                                                                                begin

                                                                                    if MpesaTransBuffer."Destination Account" <> '' then begin
                                                                                        TheDestinationSavings.Get(MpesaTransBuffer."Destination Account");
                                                                                    end;

                                                                                    theSMS := 'Jambo ' + TheSourceMember."First Name".ToUpper() + ', '
                                                                                   + MpesaTransBuffer."Originator ID" +
                                                                                   ', you have successfully transferred Kshs. ' +
                                                                                   Format(MpesaTransBuffer."Transaction Amount" - MpesaTransBuffer."Total Charges") +
                                                                                   ' to ' + TheDestinationSavings."Name" +
                                                                                   ', your available balance is Ksh ' + Format(GlobalFunctions.GetSavingsAccountAvailableBalance(SavingsAccounts, true)) +
                                                                                   ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time");

                                                                                    SkySMS.SendSms(
                                                                                        SMSSource::IFT_ACCOUNT,
                                                                                        TheSourceMember."Transactional Mobile Number",
                                                                                        theSMS,
                                                                                        theReference,
                                                                                        '',
                                                                                        true,
                                                                                        0,
                                                                                        true,
                                                                                        'MBANKING',
                                                                                        MpesaTransBuffer."Originator ID",
                                                                                        'CBS'
                                                                                    );
                                                                                end;
                                                                            MpesaTransBuffer."Transaction Type"::"Pay Loan From Account":
                                                                                begin
                                                                                    if MpesaTransBuffer."Loan No." <> '' then begin
                                                                                        if TheDestinationLoan.Get(MpesaTransBuffer."Loan No.") then begin
                                                                                            theSMS := 'Jambo ' + TheSourceMember."First Name".ToUpper() +
                                                                                            ', your internal loan repayment request of KES ' +
                                                                                                Format(MpesaTransBuffer."Transaction Amount" - MpesaTransBuffer."Total Charges") +
                                                                                                ' from ' + SavingsAccounts."Product Name" + ' ' + MpesaTransBuffer."Savings Account" +
                                                                                                ' to ' + TheDestinationLoan."Loan Product Type Name" + ' ' + MpesaTransBuffer."Loan No." +
                                                                                                ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                                                ' has been completed successfully. Ref: ' + theReference;

                                                                                            SkySMS.SendSms(
                                                                                                SMSSource::IFT_LOAN,
                                                                                                TheSourceMember."Transactional Mobile Number",
                                                                                                theSMS,
                                                                                                theReference,
                                                                                                '',
                                                                                                true,
                                                                                                0,
                                                                                                true,
                                                                                                'MBANKING',
                                                                                                MpesaTransBuffer."Originator ID",
                                                                                                'CBS'
                                                                                            );
                                                                                        end;
                                                                                    end;
                                                                                end;

                                                                        end;

                                                                        // Destination - Savings
                                                                        if MpesaTransBuffer."Destination Account" <> '' then begin
                                                                            if TheDestinationSavings.Get(MpesaTransBuffer."Destination Account") then begin
                                                                                if TheSourceMember."No." <> TheDestinationSavings."Member No." then begin
                                                                                    if TheDestinationMember.Get(TheDestinationSavings."Member No.") then begin
                                                                                        theSMS := 'Jambo ' + TheDestinationMember."First Name".ToUpper() +
                                                                                         ', ' + TheSourceMember.Name.ToUpper() + ' has transferred KES ' +
                                                                                         Format(MpesaTransBuffer."Transaction Amount" - MpesaTransBuffer."Total Charges") +
                                                                                         ' to your ' + TheDestinationSavings."Product Name" + ' ' + TheDestinationSavings."No." +
                                                                                         ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                                         '. Ref: ' + theReference;

                                                                                        SkySMS.SendSms(
                                                                                            SMSSource::IFT_ACCOUNT,
                                                                                            TheDestinationMember."Transactional Mobile Number",
                                                                                            theSMS,
                                                                                            theReference,
                                                                                            '',
                                                                                            true,
                                                                                            0,
                                                                                            true,
                                                                                            'MBANKING',
                                                                                            MpesaTransBuffer."Originator ID",
                                                                                            'CBS'
                                                                                        );
                                                                                    end;
                                                                                end;
                                                                            end;
                                                                        end;
                                                                        // Destination - Loan
                                                                        if MpesaTransBuffer."Loan No." <> '' then begin
                                                                            if TheDestinationLoan.Get(MpesaTransBuffer."Loan No.") then begin
                                                                                if TheSourceMember."No." <> TheDestinationLoan."Member No." then begin
                                                                                    if TheDestinationMember.Get(TheDestinationSavings."Member No.") then begin
                                                                                        theSMS := 'Jambo ' + TheDestinationMember."First Name".ToUpper() +
                                                                                ',' + TheSourceMember.Name.ToUpper() + ' has transferred KES ' +
                                                                                Format(MpesaTransBuffer."Transaction Amount" - MpesaTransBuffer."Total Charges") +
                                                                                ' for repayment of your loan no. ' + TheDestinationLoan."Loan No." +
                                                                                ' on ' +
                                                                                GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                                '. Ref: ' + theReference;

                                                                                        SkySMS.SendSms(
                                                                                            SMSSource::IFT_LOAN,
                                                                                            TheDestinationMember."Transactional Mobile Number",
                                                                                            theSMS,
                                                                                            theReference,
                                                                                            '',
                                                                                            true,
                                                                                            0,
                                                                                            true,
                                                                                            'MBANKING',
                                                                                            MpesaTransBuffer."Originator ID",
                                                                                            'CBS'
                                                                                        );
                                                                                    end;
                                                                                end;
                                                                            end;
                                                                        end;
                                                                    end;
                                                                    // end;
                                                                end;
                                                            end else begin
                                                                GLEntry.Reset;
                                                                GLEntry.SetRange("Document No.", theReference);
                                                                GLEntry.SetLoadFields("Entry No.");
                                                                if GLEntry.FindFirst then begin
                                                                    MpesaTransBuffer.Posted := true;
                                                                    MpesaTransBuffer."Posting Date" := Today;
                                                                    MpesaTransBuffer."Posting Time" := time;
                                                                    MpesaTransBuffer."Posted By" := UserID;
                                                                    MpesaTransBuffer.Modify();

                                                                    // IFT SMS
                                                                    if (MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Account Transfer") OR
                                                                    (MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Kesasa Account Transfer") OR
                                                                    (MpesaTransBuffer."Transaction Type" = MpesaTransBuffer."Transaction Type"::"Pay Loan From Account") then begin
                                                                        // if SavingsAccounts.get(MpesaTransBuffer."Savings Account") then begin
                                                                        if TheSourceMember.Get(SavingsAccounts."Member No.") then begin
                                                                            case MpesaTransBuffer."Transaction Type" of
                                                                                MpesaTransBuffer."Transaction Type"::"Account Transfer",
                                                                                MpesaTransBuffer."Transaction Type"::"Kesasa Account Transfer":
                                                                                    begin
                                                                                        theSMS := 'Jambo ' + TheSourceMember."First Name".ToUpper() + ', '
                                                                                            + MpesaTransBuffer."Originator ID" +
                                                                                            ', you have successfully transferred Kshs. ' +
                                                                                            Format(MpesaTransBuffer."Transaction Amount" - MpesaTransBuffer."Total Charges") +
                                                                                            ' to ' + TheDestinationSavings."Name" +
                                                                                            ', your available balance is Ksh ' + Format(GlobalFunctions.GetSavingsAccountAvailableBalance(SavingsAccounts, true)) +
                                                                                            ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time");
                                                                                        SkySMS.SendSms(
                                                                                            SMSSource::IFT_ACCOUNT,
                                                                                            TheSourceMember."Transactional Mobile Number",
                                                                                            theSMS,
                                                                                            theReference,
                                                                                            '',
                                                                                            true,
                                                                                            0,
                                                                                            true,
                                                                                            'MBANKING',
                                                                                            MpesaTransBuffer."Originator ID",
                                                                                            'CBS'
                                                                                        );
                                                                                    end;
                                                                                MpesaTransBuffer."Transaction Type"::"Pay Loan From Account":
                                                                                    begin
                                                                                        if MpesaTransBuffer."Loan No." <> '' then begin
                                                                                            if TheDestinationLoan.Get(MpesaTransBuffer."Loan No.") then begin
                                                                                                theSMS := 'Jambo ' + TheSourceMember."First Name".ToUpper() +
                                                                                                ', your internal loan repayment request of KES ' +
                                                                                                    Format(MpesaTransBuffer."Transaction Amount" - MpesaTransBuffer."Total Charges") +
                                                                                                    ' from ' + SavingsAccounts."Product Name" + ' ' + MpesaTransBuffer."Savings Account" +
                                                                                                    ' to ' + TheDestinationLoan."Loan Product Type Name" + ' ' + MpesaTransBuffer."Loan No." +
                                                                                                    ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                                                    ' has been completed successfully. Ref: ' + theReference;

                                                                                                SkySMS.SendSms(
                                                                                                    SMSSource::IFT_LOAN,
                                                                                                    TheSourceMember."Transactional Mobile Number",
                                                                                                    theSMS,
                                                                                                    theReference,
                                                                                                    '',
                                                                                                    true,
                                                                                                    0,
                                                                                                    true,
                                                                                                    'MBANKING',
                                                                                                    MpesaTransBuffer."Originator ID",
                                                                                                    'CBS'
                                                                                                );
                                                                                            end;
                                                                                        end;
                                                                                    end;

                                                                            end;

                                                                            // Destination - Savings
                                                                            if MpesaTransBuffer."Destination Account" <> '' then begin
                                                                                if TheDestinationSavings.Get(MpesaTransBuffer."Destination Account") then begin
                                                                                    if TheSourceMember."No." <> TheDestinationSavings."Member No." then begin
                                                                                        if TheDestinationMember.Get(TheDestinationSavings."Member No.") then begin
                                                                                            theSMS := 'Jambo ' + TheDestinationMember."First Name".ToUpper() +
                                                                                    ', ' + TheSourceMember.Name.ToUpper() + ' has transferred KES ' +
                                                                                    Format(MpesaTransBuffer."Transaction Amount" - MpesaTransBuffer."Total Charges") +
                                                                                    ' to your account no. ' + TheDestinationSavings."No." +
                                                                                    ' on ' + GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                                    '. Ref: ' + theReference;

                                                                                            SkySMS.SendSms(
                                                                                                SMSSource::IFT_ACCOUNT,
                                                                                                TheDestinationMember."Transactional Mobile Number",
                                                                                                theSMS,
                                                                                                theReference,
                                                                                                '',
                                                                                                true,
                                                                                                0,
                                                                                                true,
                                                                                                'MBANKING',
                                                                                                MpesaTransBuffer."Originator ID",
                                                                                                'CBS'
                                                                                            );
                                                                                        end;
                                                                                    end;
                                                                                end;
                                                                            end;
                                                                            // Destination - Loan
                                                                            if MpesaTransBuffer."Loan No." <> '' then begin
                                                                                if TheDestinationLoan.Get(MpesaTransBuffer."Loan No.") then begin
                                                                                    if TheSourceMember."No." <> TheDestinationLoan."Member No." then begin
                                                                                        if TheDestinationMember.Get(TheDestinationSavings."Member No.") then begin
                                                                                            theSMS := 'Jambo ' + TheDestinationMember."First Name".ToUpper() +
                                                                                    ',' + TheSourceMember.Name.ToUpper() + ' has transferred KES ' +
                                                                                    Format(MpesaTransBuffer."Transaction Amount" - MpesaTransBuffer."Total Charges") +
                                                                                    ' for repayment of your loan no. ' + TheDestinationLoan."Loan No." +
                                                                                    ' on ' +
                                                                                    GlobalFunctions.FormatISODateTime(MpesaTransBuffer."Transaction Date Time") +
                                                                                    '. Ref: ' + theReference;

                                                                                            SkySMS.SendSms(
                                                                                                SMSSource::IFT_LOAN,
                                                                                                TheDestinationMember."Transactional Mobile Number",
                                                                                                theSMS,
                                                                                                theReference,
                                                                                                '',
                                                                                                true,
                                                                                                0,
                                                                                                true,
                                                                                                'MBANKING',
                                                                                                MpesaTransBuffer."Originator ID",
                                                                                                'CBS'
                                                                                            );
                                                                                        end;
                                                                                    end;
                                                                                end;
                                                                            end;
                                                                        end;
                                                                        // end;
                                                                    end;
                                                                end else begin
                                                                    MpesaTransBuffer."Try Posting Count" := MpesaTransBuffer."Try Posting Count" + 1;
                                                                    MpesaTransBuffer."Needs Change" := true;
                                                                    MpesaTransBuffer."Needs Change Reason" := 'The record was not able to post';
                                                                    MpesaTransBuffer.Modify();
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                            end;
                                        end else begin
                                            MpesaTransBuffer."Needs Change" := true;
                                            MpesaTransBuffer."Needs Change Reason" := 'The savings account was not found in Savings Accounts list';
                                            MpesaTransBuffer.Modify();
                                        end;
                                    end;

                                    PostingBatchCounter += 1;
                                until (MpesaTransBuffer.next = 0) OR (PostingBatchCounter = (PostingBatchSize DIV 8));
                            end;
                        until MobileTransTypes.next = 0;
                        SuccessMessage := 'Internal transfers were processed successfully';
                    end else begin
                        ResponseData.Add('request_status', 'FAILED');
                        ResponseData.Add('request_status_description', 'Transaction type for internal transfers is not available');

                        Datum.Add('error_message', 'Transaction type for internal transfers is not available');
                        ResponseData.Add('response_payload', Datum);
                        ResponseData.WriteTo(Response);
                        exit(Response);
                    end;
                end;
            else begin
                ResponseData.Add('request_status', 'FAILED');
                ResponseData.Add('request_status_description', 'The requested CallServiceID ' + CallServiceID.AsValue.AsText + ' is NOT supported.');
                ResponseData.WriteTo(Response);
                exit(Response);
            end;
        end;

        ResponseData.Add('request_status', 'SUCCESS');
        ResponseData.Add('request_status_description', SuccessMessage);
        ResponseData.WriteTo(Response);
        exit(Response);
    end;

    // local procedure Test(): Text
    // var
    //     MpesaTransBuffer: Record "Sky M-Banking Trans. Buffer";
    // begin
    //     MpesaTransBuffer.Reset;

    //     MpesaTransBuffer.SetRange(Posted, true);
    //     MpesaTransBuffer.SetRange("Transaction Type", MpesaTransBuffer."Transaction Type"::"Mpesa Deposit");
    //     // MpesaTransBuffer.SetCurrentKey("Try Posting Count");
    //     // MpesaTransBuffer.SetAscending("Try Posting Count", true);
    //     if MpesaTransBuffer.FindSet(True) then begin
    //         repeat
    //             // Perform operations that require locking the record
    //             // MpesaTransBuffer."Try Posting Count" := MpesaTransBuffer."Try Posting Count" + 1;
    //             MpesaTransBuffer.Posted := false;
    //             MpesaTransBuffer."Posted By" := '';
    //             MpesaTransBuffer."Posting Date" := 0D;
    //             MpesaTransBuffer."Posting Time" := 0T;
    //             MpesaTransBuffer.Modify();-
    //         until MpesaTransBuffer.Next() = 0;
    //     end;

    //     exit('DONE');
    // end;

    // LOAN APPLICATIONS
    local procedure GetLoanApplicationProducts(Payload: JsonObject;
    APIRequestID:
        JsonToken):
            Text
    var
        identifier_type: JsonToken;
        identifier:
                JsonToken;

        SearchMember:
                Record Members;
        MemberRec:
                Record Members;
        BlockedEmployer:
                Record "Blocked Employers";
        MemberClasses:
                Record "Member Classes";
        ProductFactory:
                Record "Product Factory";
        ProductSupportedClasses:
                Record "Product Supported Classes";

        ResponseObject:
                JsonObject;
        Data:
                JsonArray;
        Datum:
                JsonObject;
        Response:
                Text;
        ResponseText:
                Text;
        ResponseDescription:
                Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            if SearchMember.Status = SearchMember.Status::Deceased then begin // Deceased
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' is Deceased');
                ResponseObject.Add('response_payload', Datum);
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
            if SearchMember.Status = SearchMember.Status::Dormant then begin // Dormant
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' is Dormant');
                ResponseObject.Add('response_payload', Datum);
                ResponseObject.Add('response_payload', Datum);
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
            if (SearchMember.Status = SearchMember.Status::Dormant) and (SearchMember.Subflag = SearchMember.Subflag::Defaulter) then begin // Defaulter
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' is a Defaulter');
                ResponseObject.Add('response_payload', Datum);
                ResponseObject.Add('response_payload', Datum);
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
            // filter products by member class, filter out blocked employers 6918 -6926
            MemberClasses.Reset();
            MemberClasses.SetRange("No.", SearchMember."Member Class");
            MemberClasses.SetLoadFields("Member Class");
            if not MemberClasses.FindFirst() then begin
                // error
            end;

            ProductFactory.Reset;
            ProductFactory.SetRange("Product Class Type", ProductFactory."Product Class Type"::Loan);
            ProductFactory.SetRange(Status, ProductFactory.Status::Active);
            ProductFactory.SetRange("Mobile Loan", false);
            ProductFactory.SetRange("Is CRM Product", true);

            if ProductFactory.FindSet then begin
                repeat begin
                    ProductSupportedClasses.Reset(); // filter products by member class
                    ProductSupportedClasses.SetRange("Product ID", ProductFactory."Product ID"); // filter products by member class
                    ProductSupportedClasses.SetRange("Class Category", SearchMember."Member Class");
                    if not ProductSupportedClasses.IsEmpty() then begin // filter products by member class
                        BlockedEmployer.Reset(); // filter out blocked employers
                        BlockedEmployer.SetRange("Employer Code", SearchMember."Employer Code"); // filter out blocked employers
                        BlockedEmployer.SetRange("Product ID", ProductFactory."Product ID"); // filter out blocked employers
                        if BlockedEmployer.IsEmpty() then begin // filter out blocked employers
                            Clear(Datum);

                            Datum.Add('product_id', ProductFactory."Product ID");
                            Datum.Add('product_name', ProductFactory."Product Description");
                            Datum.Add('minimum_guarantors', ProductFactory."Minimum Guarantors");
                            Datum.Add('maximum_guarantors', ProductFactory."Maximum Guarantors");
                            Datum.Add('minimum_amount', ProductFactory."Minimum Loan Amount");
                            Datum.Add('maximum_amount', ProductFactory."Maximum Loan Amount");
                            Datum.Add('repayment_frequency', Format(ProductFactory."Repayment Frequency"));
                            Datum.Add('min_interest_rate', Format(ProductFactory."Interest Rate (Min.)"));
                            Datum.Add('maximum_installments', ProductFactory."Ordinary Default Intallments");
                            Datum.Add('interest_calculation_method', Format(ProductFactory."Interest Calculation Method"));

                            Data.Add(Datum);
                        end; // filter out blocked employers
                    end; // filter products by member class
                end until ProductFactory.Next = 0;
            end;

            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('request_status_description', 'Loan application product list has been fetched successfully');
            ResponseObject.Add('response_payload', Data);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure ValidateGuarantorEligibilityRequest(Payload: JsonObject): Text
    var
        member_no: JsonToken;
        loan_type_id: JsonToken;

        SearchMember: Record Members;
        MobileLoanProduct: Record "Product Factory";
        SalaryAmount: decimal;

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Datum: JsonObject;
        Response: Text;

        ResponseText: Text;
        ResponseDescription: Text;

        FailReason: Text;
    begin
        Payload.Get('member_no', member_no);
        Payload.Get('loan_type_id', loan_type_id);

        SearchMember.Reset;
        SearchMember.SetRange("No.", member_no.asValue.Astext);
        SearchMember.SetRange(Status, SearchMember.Status::Active);
        SearchMember.SetFilter(Subflag,
            '=%1|%2|%3',
            SearchMember.Subflag::"First time",
            SearchMember.Subflag::Rejoined,
            SearchMember.Subflag::"Partial withdrawn"
        );
        SearchMember.SetFilter("Employer Code", '<>%1', 'SACCO_STAFF'); // Omit staff

        IF SearchMember.FindFirst then begin
            SalaryAmount := GuarantorSalaryEligibility(loan_type_id.AsValue.AsText, SearchMember, 0, FailReason);

            if SalaryAmount <= 0 then begin
                Datum.Add('eligible', false);
                Datum.Add('eligible_fail_reason', FailReason);
            end else begin
                Datum.Add('eligible', true);
                Datum.Add('eligible_fail_reason', '');
            end;

            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('response_payload', Datum);
        end else begin
            SearchMember.Reset;
            SearchMember.SetRange("No.", member_no.asValue.Astext);

            IF SearchMember.FindFirst then begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('request_status_description', 'Member with no. ' + member_no.AsValue.AsText + ' NOT eligible.');
                ResponseObject.Add('response_payload', Datum);
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('request_status_description', 'Member with no. ' + member_no.AsValue.AsText + ' NOT found!');
                ResponseObject.Add('response_payload', Datum);
            end;
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure GuarantorSalaryEligibility(LoanTypeID: Text; SearchMember: Record Members; Installments: Integer; var FailReason: Text): Decimal
    var
        SalAvg: decimal;
        SalaryAmount: decimal;
        SalaryAccount: record "Savings Accounts";
        FosaAccount: Text;
        BosaAccount: Text;
        SalaryLines: Record "Salary Lines";
        ProdFac: record "Product Factory";
        STOAmount: decimal;
        LoanRec: decimal;
        SalaryType: Enum "Salary Income Types";

        MinDateProduct: Date;
        MinDateMember: Date;
        Members: Record Members;

        GenSetup: Record "General Set-Up";
    begin
        SalAvg := 0;
        SalaryAmount := 0;
        FosaAccount := SkyMbankingTrans.GetMemberFosaAcc(SearchMember);

        if ProdFac.Get(LoanTypeID) then begin
            Installments := ProdFac."Ordinary Default Intallments";

            if ProdFac."Source Unit" = ProdFac."Source Unit"::FOSA then begin
                // Validate Age Requirements
                Members.Reset;
                Members.SetRange("No.", SearchMember."No.");
                Members.SetLoadFields(
                    "No.", "Date of Birth", "Allow Retiree M-Loans"
                );

                if Members.Find('-') then begin
                    if Format(ProdFac."Max. Member Age") <> '' then begin
                        MinDateMember := CalcDate('-' + Format(ProdFac."Ordinary Default Intallments") + 'M', Members."Date of Birth");
                        MinDateProduct := CalcDate('-' + Format(ProdFac."Max. Member Age"), Today);
                        if MinDateMember < MinDateProduct then begin
                            if not Members."Allow Retiree M-Loans" then begin
                                FailReason := StrSubstNo('Member NOT eligible due to age requirements. Maximum age allowed is: %1', Format(ProdFac."Max. Member Age"));
                                EXIT(0);
                            end;
                        end;
                    end;
                end;

                SalaryAccount.Reset;
                SalaryAccount.SetRange("No.", FosaAccount);
                if SalaryAccount.FindFirst then begin
                    SalaryType := ProdFac."Salary Income Types";
                    SalAvg := GlobalFunctions.GetSmallestSalary(SalaryAccount."No.", SalaryType);
                    STOAmount := SkyMbankingTrans.ComputeSTODeductions(SalaryAccount."No.");
                    LoanRec := SkyMbankingTrans.ComputeLoanDeductions(SalaryAccount."Member No.");

                    FailReason := StrSubstNo('Member NOT eligible due to salary requirements.');

                    IF (SalaryAccount.Status <> SalaryAccount.Status::Active) OR (SalaryAccount.Blocked <> SalaryAccount.Blocked::" ") THEN BEGIN
                        SalaryAmount := 0;
                    END else begin
                        //Get last salary amount
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("Member No.", SalaryAccount."Member No.");
                        SalaryLines.SETRANGE(Posted, TRUE);
                        SalaryLines.Setfilter("Income Type", '<>%1&<>%2', SalaryLines."Income Type"::" ", SalaryLines."Income Type"::Claims);
                        if Format(ProdFac."Salary Period") <> '' then begin
                            SalaryLines.SETRANGE("Posting Date", CALCDATE(('-' + format(ProdFac."Salary Period")), TODAY), TODAY);
                        end;
                        SalaryLines.SetLoadFields(Amount);
                        IF SalaryLines.FINDLAST THEN BEGIN
                            SalaryAmount := SalaryLines.Amount - (STOAmount + LoanRec);
                        END;
                        SalAvg := SalAvg - (STOAmount + LoanRec);
                        IF SalaryAmount > SalAvg THEN
                            SalaryAmount := SalAvg;
                    end;
                end;

                if Installments <> 0 then begin
                    SalaryAmount := SalaryAmount * Installments;
                end;
            end;

            if ProdFac."Source Unit" = ProdFac."Source Unit"::BOSA then begin
                BosaAccount := SkyMbankingTrans.GetMemberDepositsAcc(SearchMember);

                SalaryAccount.Reset;
                SalaryAccount.SetRange("No.", BosaAccount);
                if SalaryAccount.FindFirst then begin
                    SalaryAmount := GlobalFunctions.GetSavingsAccountAvailableGuarantorshipBalance(SalaryAccount, true)
                end;

                GenSetup.Get;
                if GenSetup."Maximum Amount to Guarantee" > 0 then begin
                    FailReason := StrSubstNo('Member NOT eligible due to guarantorship requirements. Maximum guarantorship amount is KES %1', GenSetup."Maximum Amount to Guarantee");
                end;
            end;
        end;

        if SalaryAmount < 0 then begin
            exit(0);
        end;
        exit(SalaryAmount);
    end;

    local procedure CreateLoanApplicationRequest(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        loan_product: JsonToken;
        loan_purpose: JsonToken;
        installments: JsonToken;
        requested_amount: JsonToken;
        sasra_main_sector: JsonToken;
        sasra_sub_sector_1: JsonToken;
        sasra_sub_sector_2: JsonToken;
        is_self_guarantee: JsonToken;

        loans_to_be_cleared: JsonToken;
        loan_to_be_cleared: JsonToken;

        files: JsonToken;
        file: JsonToken;
        file_name: JsonToken;
        file_contents: JsonToken;

        guarantors: JsonToken;
        guarantor: JsonToken;
        guarantor_member_number: JsonToken;

        SearchMember: record Members;
        TheLoanApplication: record "Sky Channels Loan Applications";
        TheLoanGuarantorshipRequest: Record "Sky Loan Guarantor Requests";

        SalaryAmount: decimal;
        GuarantorMember: Record Members;
        MobileLoanProduct: Record "Product Factory";
        LoansToBeCleared: Record Loans;
        TopupAmount: Decimal;

        TheLoanApplicationDocuments: Record "Channel Application Documents";
        EDMSFunctions: Codeunit "EDMS Functions";
        EDMSFileTypes: enum "EDMS File Types";
        ExistingLoanApplications: Record "Sky Channels Loan Applications";

        KeyExists: Boolean;
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        Base64Convert: Codeunit "Base64 Convert";

        StoreImageRef: FieldRef;
        StoreRecRef: RecordRef;

        KeyExists1: Boolean;
        KeyExists2: Boolean;
        KeyExists3: Boolean;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;

        FailReason: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('loan_product', loan_product);
        Payload.Get('loan_purpose', loan_purpose);
        Payload.Get('installments', installments);
        Payload.Get('requested_amount', requested_amount);
        Payload.Get('guarantors', guarantors);
        KeyExists1 := Payload.Get('sasra_main_sector', sasra_main_sector);
        KeyExists1 := Payload.Get('sasra_sub_sector_1', sasra_sub_sector_1);
        KeyExists1 := Payload.Get('sasra_sub_sector_2', sasra_sub_sector_2);
        KeyExists2 := Payload.Get('is_self_guarantee', is_self_guarantee);
        KeyExists3 := Payload.Get('loans_to_be_cleared', loans_to_be_cleared);
        KeyExists := Payload.Get('files', files);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            ExistingLoanApplications.Reset;
            ExistingLoanApplications.SetRange("Member No.", SearchMember."No.");
            ExistingLoanApplications.SetFilter(Status,
            '%1|%2',
            ExistingLoanApplications.Status::Open,
            ExistingLoanApplications.Status::"Pending Approval");
            if ExistingLoanApplications.FindFirst then begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', StrSubstNo('There is an ongoing loan application %2 at status = %1', ExistingLoanApplications.Status, ExistingLoanApplications."Application No."));
                ResponseObject.Add('response_payload', Datum);

                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);

                exit(Response);
            end;

            TheLoanApplication.Init;

            TheLoanApplication."Member No." := SearchMember."No.";
            TheLoanApplication."Loan Product Type" := loan_product.AsValue.AsText;
            TheLoanApplication."Loan Purpose" := loan_purpose.AsValue.AsText;
            TheLoanApplication.Installments := installments.AsValue.AsInteger;
            TheLoanApplication."Requested Amount" := requested_amount.AsValue.AsDecimal;
            TheLoanApplication."Source Application" := TheLoanApplication."Source Application"::"Member Portal";

            if KeyExists1 then begin
                TheLoanApplication."Main Sector" := sasra_main_sector.AsValue.AsText;
                TheLoanApplication."Sub Sector Level1" := sasra_sub_sector_1.AsValue.AsText;
                TheLoanApplication."Sub Sector Level2" := sasra_sub_sector_2.AsValue.AsText;
            end;

            if KeyExists2 then begin
                TheLoanApplication."Is Self Guarantee" := is_self_guarantee.AsValue.AsBoolean;
            end;

            if GlobalFunctions.IsFOSALoanProduct(loan_product.AsValue.AsText) then begin
                TheLoanApplication."Is Self Guarantee" := false;
            end;

            // Validate loan guarantors
            foreach guarantor in guarantors.AsArray do begin
                if TheLoanApplication."Is Self Guarantee" then begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', 'You may NOT add a list of guarantors for self guaranteed loan application');
                    ResponseObject.Add('response_payload', Datum);

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;

                guarantor.AsObject.Get('member_number', guarantor_member_number);

                SalaryAmount := 0;

                GuarantorMember.Reset;
                GuarantorMember.SetRange("No.", guarantor_member_number.AsValue.AsText);
                if GuarantorMember.FindFirst then begin
                    SalaryAmount := GuarantorSalaryEligibility(loan_product.AsValue.AsText, GuarantorMember, 0, FailReason);

                    if SalaryAmount <= 0 then begin
                        ResponseObject.Add('request_status', 'ERROR');
                        Datum.Add('error_message', 'Member with no. ' + guarantor_member_number.AsValue.AsText + ' is NOT eligible for guarantorship due to deposits/salary requirements!' + FailReason);
                        ResponseObject.Add('response_payload', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
                end;
            end;

            if KeyExists3 then begin
                // Loan Top up
                if loans_to_be_cleared.IsArray then begin
                    loans_to_be_cleared.WriteTo(TheLoanApplication."Loan Top Up");

                    foreach loan_to_be_cleared in loans_to_be_cleared.AsArray do begin
                        LoansToBeCleared.Reset;
                        LoansToBeCleared.SetRange("Loan No.", loan_to_be_cleared.AsValue.AsText);
                        LoansToBeCleared.SetFilter("Total Balance", '>0');
                        LoansToBeCleared.SetRange(Posted, true);
                        LoansToBeCleared.SetAutoCalcFields("Total Balance");

                        if LoansToBeCleared.FindFirst then begin
                            TopupAmount += LoansToBeCleared."Total Balance";
                        end;
                    end;

                    if (TopupAmount * 1.5) > (TheLoanApplication."Requested Amount") then begin
                        ResponseObject.Add('request_status', 'ERROR');
                        Datum.Add('error_message', 'The requested amount is insufficient to top up the requested loan(s)');
                        ResponseObject.Add('response_payload', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
                end;

                if GlobalFunctions.IsFOSALoanProduct(loan_product.AsValue.AsText) then begin
                    TheLoanApplication."Is Self Guarantee" := false;
                end;
            end;

            if TheLoanApplication.Insert(true) then begin
                // Guarantor requests
                foreach guarantor in guarantors.AsArray do begin
                    guarantor.AsObject.Get('member_number', guarantor_member_number);

                    TheLoanGuarantorshipRequest.Reset;
                    Clear(TheLoanGuarantorshipRequest);
                    TheLoanGuarantorshipRequest.Init;

                    TheLoanGuarantorshipRequest."Member No." := guarantor_member_number.AsValue.AsText;

                    TheLoanGuarantorshipRequest.Status := TheLoanGuarantorshipRequest.Status::Open;
                    TheLoanGuarantorshipRequest."Status Date Time" := CurrentDateTime;
                    TheLoanGuarantorshipRequest."Loan Application No." := TheLoanApplication."Application No.";

                    TheLoanGuarantorshipRequest.Insert(true);
                    Commit;
                end;

                if TheLoanApplication."Is Self Guarantee" then begin
                    TheLoanApplication.ProcessSelfGuarantorship();
                end;

                // Files
                if KeyExists then begin

                    foreach file in files.AsArray() do begin
                        file.AsObject.Get('name', file_name);

                        if EDMSFunctions.GetFileTypeFromFileName(file_name.AsValue.AsText) = EDMSFileTypes::" " then begin
                            ResponseObject.Add('request_status', 'ERROR');
                            Datum.Add('error_message', 'Unsupported file type for uploading the file = ' + file_name.AsValue.AsText);
                            ResponseObject.Add('response_payload', Datum);

                            AddDateTimeToResponse(ResponseObject);
                            ResponseObject.WriteTo(Response);

                            exit(Response);
                        end;
                    end;

                    foreach file in files.AsArray() do begin
                        file.AsObject.Get('name', file_name);
                        file.AsObject.Get('contents', file_contents);

                        TheLoanApplicationDocuments.Reset;
                        Clear(TheLoanApplicationDocuments);
                        TheLoanApplicationDocuments.Init;

                        TheLoanApplicationDocuments."Application Type" := TheLoanApplicationDocuments."Application Type"::"Loan Application";
                        TheLoanApplicationDocuments."Application No." := TheLoanApplication."Application No.";
                        TheLoanApplicationDocuments."Document Name" := file_name.AsValue.AsText;

                        // B64 to Blob
                        TempBlob.CreateOutStream(OutStr);
                        Base64Convert.FromBase64(file_contents.AsValue.AsText, OutStr);
                        Clear(TheLoanApplicationDocuments.Document);
                        StoreRecRef.Open(52186564);
                        StoreImageRef := StoreRecRef.Field(TheLoanApplicationDocuments.FieldNo(Document));
                        TempBlob.ToFieldRef(StoreImageRef);
                        StoreImageRef.TestField();

                        TheLoanApplicationDocuments.Document := StoreImageRef.Value;
                        TheLoanApplicationDocuments."Document Extension" := EDMSFunctions.GetFileTypeFromFileName(file_name.AsValue.AsText);

                        TheLoanApplicationDocuments.Insert(true);
                        // Commit;

                        Clear(TempBlob);
                        Clear(OutStr);
                        Clear(Base64Convert);
                        Clear(StoreRecRef);
                        Clear(StoreImageRef);
                    end;

                end;

                Datum.Add('application_no', TheLoanApplication."Application No.");

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('request_status_description', 'Loan application request has been created successfully');
                ResponseObject.Add('response_payload', Datum);
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Unable to create loan application request at the moment.');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', ResponseText);
            ResponseObject.Add('request_status_description', ResponseDescription);
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanApplicationRequests(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        TheLoanApplications: Record "Sky Channels Loan Applications";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheLoanApplications.Reset;
            TheLoanApplications.SetRange("Member No.", SearchMember."No.");
            TheLoanApplications.SetFilter(Status, '=%1|%2', TheLoanApplications.Status::Open, TheLoanApplications.Status::"Pending Approval");

            if TheLoanApplications.FindSet then begin
                repeat begin
                    Clear(Datum);

                    TheLoanApplications.CalcFields(
                        "Loan Product Name",
                        "Member Name"
                    );
                    Datum.Add('application_no', TheLoanApplications."Application No.");
                    Datum.Add('member_no', TheLoanApplications."Member No.");
                    Datum.Add('member_name', TheLoanApplications."Member Name");
                    Datum.Add('application_date_time', GlobalFunctions.FormatISODateTime(TheLoanApplications."Application Date Time"));
                    Datum.Add('loan_product_type', TheLoanApplications."Loan Product Type");
                    Datum.Add('loan_product_name', TheLoanApplications."Loan Product Name");
                    Datum.Add('requested_amount', TheLoanApplications."Requested Amount");
                    Datum.Add('eligible_amount', TheLoanApplications."Eligible Amount");

                    Datum.Add('loan_purpose', TheLoanApplications."Loan Purpose");
                    Datum.Add('installments', TheLoanApplications.Installments);
                    Datum.Add('status', Format(TheLoanApplications.Status));

                    Data.Add(Datum);
                end until TheLoanApplications.Next = 0;
            end;

            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('request_status_description', 'Loan application request list has been fetched successfully');
            ResponseObject.Add('response_payload', Data);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanApplicationRequest(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;

        SearchMember: Record Members;
        TheLoanApplications: Record "Sky Channels Loan Applications";
        GuarantorRequests: Record "Sky Loan Guarantor Requests";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Guarantors: JsonArray;
        Guarantor: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('application_no', application_no);

        SearchMember.Reset;
        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheLoanApplications.Reset;
            TheLoanApplications.SetRange("Member No.", SearchMember."No.");
            TheLoanApplications.SetFilter(Status, '=%1|%2', TheLoanApplications.Status::Open, TheLoanApplications.Status::"Pending Approval");
            TheLoanApplications.SetRange("Application No.");

            if TheLoanApplications.FindFirst then begin
                TheLoanApplications.CalcFields(
                    "Loan Product Name",
                    "Member Name"
                );
                Datum.Add('application_no', TheLoanApplications."Application No.");
                Datum.Add('member_no', TheLoanApplications."Member No.");
                Datum.Add('member_name', TheLoanApplications."Member Name");
                Datum.Add('application_date_time', GlobalFunctions.FormatISODateTime(TheLoanApplications."Application Date Time"));
                Datum.Add('loan_product_type', TheLoanApplications."Loan Product Type");
                Datum.Add('loan_product_name', TheLoanApplications."Loan Product Name");
                Datum.Add('requested_amount', TheLoanApplications."Requested Amount");
                Datum.Add('eligible_amount', TheLoanApplications."Eligible Amount");
                Datum.Add('loan_purpose', TheLoanApplications."Loan Purpose");
                Datum.Add('installments', TheLoanApplications.Installments);
                Datum.Add('status', Format(TheLoanApplications.Status));

                GuarantorRequests.Reset;
                GuarantorRequests.SetRange("Loan Application No.", TheLoanApplications."Application No.");
                if GuarantorRequests.FindSet then begin
                    repeat begin
                        Clear(Guarantor);

                        GuarantorRequests.CalcFields("Member Name");
                        Guarantor.Add('entry_no', GuarantorRequests."Entry No.");
                        Guarantor.Add('member_number', GuarantorRequests."Member No.");

                        if SearchMember.Get(GuarantorRequests."Member No.") then
                            Guarantor.Add('phone_number', SearchMember."Phone No.")
                        else
                            Guarantor.Add('phone_number', '');

                        Guarantor.Add('member_name', GuarantorRequests."Member Name");
                        Guarantor.Add('request_status', Format(GuarantorRequests.Status));
                        Guarantor.Add('request_status_date_time', GlobalFunctions.FormatISODateTime(GuarantorRequests."Status Date Time"));

                        Guarantors.Add(Guarantor);
                    end until GuarantorRequests.Next = 0;
                end;
                Datum.Add('guarantorship_requests', Guarantors);

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('request_status_description', 'Loan application request has been fetched successfully');
                ResponseObject.Add('response_payload', Datum);
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Loan application request ' + application_no.AsValue.AsText + ' NOT found');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure EditLoanApplicationRequest(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;
        requested_amount: JsonToken;

        SearchMember: record Members;
        TheLoanApplication: Record "Sky Channels Loan Applications";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('application_no', application_no);
        Payload.Get('requested_amount', requested_amount);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheLoanApplication.Reset;

            TheLoanApplication.SetRange("Application No.", application_no.AsValue.AsText);
            TheLoanApplication.SetRange(Status, TheLoanApplication.Status::Open);

            if TheLoanApplication.FindFirst then begin
                TheLoanApplication."Requested Amount" := requested_amount.AsValue.AsInteger;

                if TheLoanApplication.Modify(true) then begin
                    ResponseObject.Add('request_status', 'SUCCESS');
                    ResponseObject.Add('request_status_description', 'Loan application request has been updated successfully');
                end else begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', 'Unable to update loan application request at the moment');
                    ResponseObject.Add('response_payload', Datum);
                end;
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'The loan application ' + application_no.AsValue.AsText + ' is NOT available for update');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', ResponseText);
            ResponseObject.Add('request_status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CancelLoanApplicationRequest(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;

        SearchMember: record Members;
        TheLoanApplication: Record "Sky Channels Loan Applications";
        TheLoanGuarantorshipRequests: Record "Sky Loan Guarantor Requests";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('application_no', application_no);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheLoanApplication.Reset;

            TheLoanApplication.SetRange("Application No.", application_no.AsValue.AsText);
            TheLoanApplication.SetRange(Status, TheLoanApplication.Status::Open);

            if TheLoanApplication.FindFirst then begin
                TheLoanGuarantorshipRequests.Reset;

                TheLoanGuarantorshipRequests.SetRange("Loan Application No.", TheLoanApplication."Application No.");
                if TheLoanGuarantorshipRequests.FindSet then begin
                    repeat begin
                        TheLoanGuarantorshipRequests.Delete(true);
                    end until TheLoanGuarantorshipRequests.Next = 0;
                end;

                if TheLoanApplication.Delete(true) then begin
                    ResponseObject.Add('request_status', 'SUCCESS');
                    ResponseObject.Add('request_status_description', 'Loan application request has been cancelled successfully');
                end else begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', 'Unable to cancel loan application request at the moment');
                    ResponseObject.Add('response_payload', Datum);
                end;
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'The loan application ' + application_no.AsValue.AsText + ' is NOT available for cancellation');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', ResponseText);
            ResponseObject.Add('request_status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure ManageLoanGuarantorsRequest(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;
        action: JsonToken;
        guarantor_member_number: JsonToken;

        SearchMember: Record Members;
        TheLoanGuarantorshipRequest: Record "Sky Loan Guarantor Requests";
        TheLoanApplication: Record "Sky Channels Loan Applications";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('application_no', application_no);
        Payload.Get('action', action); // ADD, REMOVE
        Payload.Get('guarantor_member_number', guarantor_member_number);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            if TheLoanApplication.Get(application_no.AsValue.AsText) then begin
                case action.AsValue.AsText of
                    'ADD':
                        begin
                            TheLoanGuarantorshipRequest.Init;

                            TheLoanGuarantorshipRequest."Member No." := guarantor_member_number.AsValue.AsText;

                            TheLoanGuarantorshipRequest.Status := TheLoanGuarantorshipRequest.Status::Open;
                            TheLoanGuarantorshipRequest."Status Date Time" := CurrentDateTime;
                            TheLoanGuarantorshipRequest."Loan Application No." := TheLoanApplication."Application No.";

                            if TheLoanGuarantorshipRequest.Insert(true) then begin
                                ResponseObject.Add('request_status', 'SUCCESS');
                                ResponseObject.Add('request_status_description', 'Loan guarantor has been added successfully');
                            end else begin
                                ResponseObject.Add('request_status', 'ERROR');
                                Datum.Add('error_message', 'Error. Unable to add loan guarantor at the moment.');
                                ResponseObject.Add('response_payload', Datum);
                            end;
                        end;
                    'REMOVE':
                        begin
                            TheLoanGuarantorshipRequest.Reset;

                            TheLoanGuarantorshipRequest.SetRange("Member No.", guarantor_member_number.AsValue.AsText);
                            TheLoanGuarantorshipRequest.SetRange(Status, TheLoanGuarantorshipRequest.Status::Open);
                            TheLoanGuarantorshipRequest.SetRange("Loan Application No.", TheLoanApplication."Application No.");

                            if TheLoanGuarantorshipRequest.FindFirst then begin
                                if TheLoanGuarantorshipRequest.Delete(true) then begin
                                    ResponseObject.Add('request_status', 'SUCCESS');
                                    ResponseObject.Add('request_status_description', 'Loan guarantor has been removed successfully');
                                end else begin
                                    ResponseObject.Add('request_status', 'ERROR');
                                    Datum.Add('error_message', 'Error. Unable to remove loan guarantorship request');
                                    ResponseObject.Add('response_payload', Datum);
                                end;
                            end else begin
                                ResponseObject.Add('request_status', 'ERROR');
                                Datum.Add('error_message', 'Loan guarantorship request NOT found');
                                ResponseObject.Add('response_payload', Datum);
                            end;
                        end;
                    else
                end;
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Loan application with no ' + application_no.AsValue.AsText + ' NOT found');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanGuarantorshipRequests(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        TheLoanGuarantorshipRequests: Record "Sky Loan Guarantor Requests";
        TheLoanApplications: Record "Sky Channels Loan Applications";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheLoanGuarantorshipRequests.Reset;
            TheLoanGuarantorshipRequests.SetRange("Member No.", SearchMember."No.");
            TheLoanGuarantorshipRequests.SetRange(Status, TheLoanGuarantorshipRequests.Status::Open);

            if TheLoanGuarantorshipRequests.FindSet then begin
                repeat begin
                    Clear(Datum);

                    TheLoanApplications.Get(TheLoanGuarantorshipRequests."Loan Application No.");
                    TheLoanApplications.CalcFields(
                        "Loan Product Name",
                        "Member Name"
                    );

                    Datum.Add('entry_no', TheLoanGuarantorshipRequests."Entry No.");
                    Datum.Add('application_no', TheLoanApplications."Application No.");
                    Datum.Add('member_no', TheLoanApplications."Member No.");
                    Datum.Add('member_name', TheLoanApplications."Member Name");
                    Datum.Add('application_date_time', GlobalFunctions.FormatISODateTime(TheLoanApplications."Application Date Time"));
                    Datum.Add('loan_product_type', TheLoanApplications."Loan Product Type");
                    Datum.Add('loan_product_name', TheLoanApplications."Loan Product Name");
                    Datum.Add('requested_amount', TheLoanApplications."Requested Amount");
                    Datum.Add('loan_purpose', TheLoanApplications."Loan Purpose");
                    Datum.Add('installments', TheLoanApplications.Installments);
                    Datum.Add('status', Format(TheLoanGuarantorshipRequests.Status));
                    Datum.Add('status_date', GlobalFunctions.FormatISODateTime(TheLoanGuarantorshipRequests."Status Date Time"));

                    Data.Add(Datum);
                end until TheLoanGuarantorshipRequests.Next = 0;
            end;

            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('request_status_description', 'Loan guarantorship request list has been fetched successfully');
            ResponseObject.Add('response_payload', Data);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanGuarantorshipRequest(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;

        SearchMember: Record Members;
        TheLoanGuarantorshipRequests: Record "Sky Loan Guarantor Requests";
        TheLoanApplications: Record "Sky Channels Loan Applications";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('application_no', application_no);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheLoanGuarantorshipRequests.Reset;
            TheLoanGuarantorshipRequests.SetRange("Member No.", SearchMember."No.");
            TheLoanGuarantorshipRequests.SetRange(Status, TheLoanGuarantorshipRequests.Status::Open);
            TheLoanGuarantorshipRequests.SetRange("Loan Application No.", application_no.AsValue.AsText);

            if TheLoanGuarantorshipRequests.FindFirst then begin
                TheLoanApplications.Get(TheLoanGuarantorshipRequests."Loan Application No.");
                TheLoanApplications.CalcFields(
                    "Loan Product Name",
                    "Member Name"
                );

                Datum.Add('entry_no', TheLoanGuarantorshipRequests."Entry No.");
                Datum.Add('application_no', TheLoanApplications."Application No.");
                Datum.Add('member_no', TheLoanApplications."Member No.");
                Datum.Add('member_name', TheLoanApplications."Member Name");
                Datum.Add('application_date_time', GlobalFunctions.FormatISODateTime(TheLoanApplications."Application Date Time"));
                Datum.Add('loan_product_type', TheLoanApplications."Loan Product Type");
                Datum.Add('loan_product_name', TheLoanApplications."Loan Product Name");
                Datum.Add('requested_amount', TheLoanApplications."Requested Amount");
                Datum.Add('loan_purpose', TheLoanApplications."Loan Purpose");
                Datum.Add('installments', TheLoanApplications.Installments);
                Datum.Add('status', Format(TheLoanGuarantorshipRequests.Status));
                Datum.Add('status_date', GlobalFunctions.FormatISODateTime(TheLoanGuarantorshipRequests."Status Date Time"));

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('request_status_description', 'Loan guarantorship request has been fetched successfully');
                ResponseObject.Add('response_payload', Datum);
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Loan guarantorship request with number ' + application_no.AsValue.AsText + ' is NOT found');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure ActionLoanGuarantorshipRequest(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;
        action: JsonToken;

        SearchMember: Record Members;
        TheLoanGuarantorshipRequests: Record "Sky Loan Guarantor Requests";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('application_no', application_no);
        Payload.Get('action', action);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheLoanGuarantorshipRequests.Reset;
            TheLoanGuarantorshipRequests.SetRange("Member No.", SearchMember."No.");
            TheLoanGuarantorshipRequests.SetRange(Status, TheLoanGuarantorshipRequests.Status::Open);
            TheLoanGuarantorshipRequests.SetRange("Loan Application No.", application_no.AsValue.AsText);

            if TheLoanGuarantorshipRequests.FindFirst then begin
                case action.AsValue.AsText of
                    'ACCEPT':
                        begin
                            TheLoanGuarantorshipRequests.Status := TheLoanGuarantorshipRequests.Status::Accepted;
                        end;
                    'REJECT':
                        begin
                            TheLoanGuarantorshipRequests.Status := TheLoanGuarantorshipRequests.Status::Rejected;
                        end;
                    else begin
                        ResponseObject.Add('request_status', 'ERROR');
                        Datum.Add('error_message', 'Unsupported action. Supported actions are: ACCEPT and REJECT');
                        ResponseObject.Add('response_payload', Datum);
                    end;
                end;

                if TheLoanGuarantorshipRequests.Modify(true) then begin
                    ResponseObject.Add('request_status', 'SUCCESS');
                    ResponseObject.Add('request_status_description', 'Loan guarantorship request has been actioned successfully');
                end else begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', 'Unable to action the loan guarantorship request at the moment');
                    ResponseObject.Add('response_payload', Datum);
                end;
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Loan guarantorship request NOT found');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    // Standing Orders
    local procedure GetSTOSourceAccounts(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        TheSTOAccounts: record "Savings Accounts";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheSTOAccounts.Reset;

            TheSTOAccounts.SetRange("Member No.", SearchMember."No.");
            TheSTOAccounts.SetRange("Product Category", TheSTOAccounts."Product Category"::"FOSA Account");
            TheSTOAccounts.SetRange(Status, TheSTOAccounts.Status::Active);

            if TheSTOAccounts.FindSet then begin
                repeat begin
                    Clear(Datum);

                    Datum.Add('account_no', TheSTOAccounts."No.");
                    Datum.Add('account_name', TheSTOAccounts.Name);
                    Datum.Add('account_type', TheSTOAccounts."Product Name");
                    Datum.Add('status', Format(TheSTOAccounts.Status));
                    Datum.Add('available_balance', GlobalFunctions.GetSavingsAccountAvailableBalance(TheSTOAccounts, true));

                    Data.Add(Datum);
                end until TheSTOAccounts.Next = 0;
            end;

            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('request_status_description', 'STO source accounts list has been fetched successfully');
            ResponseObject.Add('response_payload', Data);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetSTOIncomeTypes(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            // Salary,Direct Debit,SAYE,Periodic,Pension
            Clear(Datum);
            Datum.Add('code', 0);
            Datum.Add('description', 'Salary');
            Data.Add(Datum);

            Clear(Datum);
            Datum.Add('code', 1);
            Datum.Add('description', 'Direct Debit');
            Data.Add(Datum);

            Clear(Datum);
            Datum.Add('code', 2);
            Datum.Add('description', 'SAYE');
            Data.Add(Datum);

            Clear(Datum);
            Datum.Add('code', 3);
            Datum.Add('description', 'Periodic');
            Data.Add(Datum);

            Clear(Datum);
            Datum.Add('code', 4);
            Datum.Add('description', 'Pension');
            Data.Add(Datum);

            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('request_status_description', 'STO income types list has been fetched successfully');
            ResponseObject.Add('response_payload', Data);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CreateStandingOrderRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        source_account: JsonToken;
        income_type: JsonToken;
        frequency: JsonToken;
        duration: JsonToken;
        start_date: JsonToken;
        description: JsonToken;
        amount: JsonToken;

        destinations: JsonToken;
        destination: JsonToken;
        destination_account_type: JsonToken;
        destination_account_no: JsonToken;
        destination_amount: JsonToken;

        SearchMember: record Members;
        TheSTORequest: Record "Standing Order Header";
        TheSTOLines: Record "Standing Order Lines";
        NoSeriesMgt: Codeunit "No. Series";
        SeriesSetup: Record "Banking No Setup";
        TheMemberFosaAccount: Record "Savings Accounts";
        TheMemberLoan: Record Loans;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('source_account', source_account);
        Payload.Get('income_type', income_type);
        Payload.Get('frequency', frequency);
        Payload.Get('duration', duration);
        Payload.Get('start_date', start_date);
        Payload.Get('description', description);
        Payload.Get('amount', amount);
        Payload.Get('destinations', destinations);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin

            TheSTORequest.Init;

            SeriesSetup.Get;
            SeriesSetup.TestField("Standing Order Nos.");

            TheSTORequest."No. Series" := SeriesSetup."Standing Order Nos.";
            TheSTORequest."No." := NoSeriesMgt.GetNextNo(TheSTORequest."No. Series");

            TheSTORequest."Source Account Type" := TheSTORequest."Source Account Type"::Savings;

            TheMemberFosaAccount.Reset;
            TheMemberFosaAccount.SetRange("Product Category", TheMemberFosaAccount."Product Category"::"FOSA Account");
            TheMemberFosaAccount.SetRange("Member No.", SearchMember."No.");

            if TheMemberFosaAccount.FindFirst then begin
                TheSTORequest."Source Account No." := TheMemberFosaAccount."No.";
                TheSTORequest.Validate("Source Account No.");
            end else begin
                Error('FOSA source account cannot be found!');
            end;

            TheSTORequest.Description := description.AsValue.AsText;
            TheSTORequest.Amount := amount.AsValue.AsDecimal;
            TheSTORequest."Standing Order Type" := income_type.AsValue.AsInteger;

            Evaluate(TheSTORequest."Frequency (Months)", Format(frequency.AsValue.AsInteger) + 'M');
            TheSTORequest."Effective/Start Date" := start_date.AsValue.AsDate;
            TheSTORequest.Validate("Effective/Start Date");
            Evaluate(TheSTORequest."Duration (Months)", Format(duration.AsValue.AsInteger) + 'M');
            TheSTORequest.Validate("Duration (Months)");

            TheSTORequest."Standing Order Type" := TheSTORequest."Standing Order Type"::Internal;
            // TheSTORequest.Type := TheSTORequest.Type::" ";
            // TheSTORequest.Validate(Type);
            TheSTORequest."Transaction Type" := 'STO';
            TheSTORequest."Global Dimension 1 Code" := SearchMember."Global Dimension 1 Code";
            TheSTORequest."Global Dimension 2 Code" := 'FOSA';
            TheSTORequest.Status := TheSTORequest.Status::Open;
            TheSTORequest."Source Application" := TheSTORequest."Source Application"::"Mobile Banking";

            if TheSTORequest.Insert(true) then begin

                TheSTORequest."Standing Order Type" := income_type.AsValue.AsInteger;
                TheSTORequest."Global Dimension 1 Code" := SearchMember."Global Dimension 1 Code";
                TheSTORequest."Global Dimension 2 Code" := 'FOSA';
                TheSTORequest.Status := TheSTORequest.Status::Open;
                TheSTORequest.Modify;

                foreach destination in destinations.AsArray do begin
                    destination.AsObject.Get('destination_account_type', destination_account_type);
                    destination.AsObject.Get('destination_account_no', destination_account_no);
                    destination.AsObject.Get('amount', destination_amount);

                    TheSTOLines.Init();

                    TheSTOLines."Document No." := TheSTOrequest."No.";
                    if destination_account_type.AsValue.AsText = 'SAVINGS' then begin
                        TheSTOLines."Destination Account Type" := TheSTOLines."Destination Account Type"::Savings;
                        TheSTOLines.Validate("Destination Account Type");

                        TheSTOLines."Destination Account No." := destination_account_no.AsValue.AsText;
                        TheSTOLines.Validate("Destination Account No.");
                    end;
                    if destination_account_type.AsValue.AsText = 'LOAN' then begin
                        TheSTOLines."Destination Account Type" := TheSTOLines."Destination Account Type"::Credit;
                        TheSTOLines.Validate("Destination Account Type");

                        if TheMemberLoan.Get(destination_account_no.AsValue.AsText) then begin
                            TheSTOLines."Destination Account No." := TheMemberLoan."Loan Account";
                            TheSTOLines.Validate("Destination Account No.");

                            TheSTOLines."Loan No." := TheMemberLoan."Loan No.";
                        end else begin
                            Error('Destination loan account %1 NOT found', destination_account_no.AsValue.AsText);
                        end;
                    end;

                    TheSTOLines.Amount := destination_amount.AsValue.AsDecimal;
                    TheSTOLines.Validate(Amount);

                    TheSTOLines."Member No" := TheSTORequest."Member No.";

                    TheSTOLines.Insert(true);
                end;

                Datum.Add('application_no', TheSTORequest."No.");

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('request_status_description', 'STO application request is successful');
                ResponseObject.Add('response_payload', Datum);
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Unable to create STO application request at the moment.');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', ResponseText);
            ResponseObject.Add('request_status_description', ResponseDescription);
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetStandingOrderRequests(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        TheSTORequests: Record "Standing Order Header";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheSTORequests.Reset;
            TheSTORequests.SetRange("Member No.", SearchMember."No.");
            TheSTORequests.SetFilter(Status, '=%1|%2', TheSTORequests.Status::Open, TheSTORequests.Status::Pending);
            TheSTORequests.SetFilter("Source Application", '=%1|%2', TheSTORequests."Source Application"::"Member Portal", TheSTORequests."Source Application"::"Mobile Banking");

            if TheSTORequests.FindSet then begin
                repeat begin
                    Clear(Datum);

                    Datum.Add('application_no', TheSTORequests."No.");
                    Datum.Add('member_no', TheSTORequests."Member No.");
                    Datum.Add('source_account', TheSTORequests."Source Account No.");
                    Datum.Add('source_account_name', TheSTORequests."Source Account Name");
                    Datum.Add('income_type', Format(TheSTORequests."Income Type"));
                    Datum.Add('frequency', Format(TheSTORequests."Frequency (Months)"));
                    Datum.Add('duration', Format(TheSTORequests."Duration (Months)"));
                    Datum.Add('start_date', GlobalFunctions.FormatISODate(TheSTORequests."Effective/Start Date"));
                    Datum.Add('amount', TheSTORequests.Amount);
                    Datum.Add('application_date', GlobalFunctions.FormatISODate(TheSTORequests."Application Date"));
                    Datum.Add('status', Format(TheSTORequests.Status));
                    Datum.Add('description', TheSTORequests.Description);

                    Data.Add(Datum);
                end until TheSTORequests.Next = 0;
            end;

            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('request_status_description', 'STO application request list has been fetched successfully');
            ResponseObject.Add('response_payload', Data);
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetStandingOrderRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;

        SearchMember: Record Members;
        TheSTORequests: Record "Standing Order Header";
        TheSTOLines: Record "Standing Order Lines";
        TheMemberFosaAccount: Record "Savings Accounts";
        TheMemberLoanAccount: Record "Credit Accounts";
        TheMemberLoan: Record Loans;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Destinations: JsonArray;
        Destination: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('application_no', application_no);

        SearchMember.Reset;
        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheSTORequests.Reset;

            TheSTORequests.SetRange("No.", application_no.AsValue.AsText);
            TheSTORequests.SetRange("Member No.", SearchMember."No.");
            TheSTORequests.SetFilter(Status, '=%1|%2', TheSTORequests.Status::Open, TheSTORequests.Status::Pending);
            TheSTORequests.SetFilter("Source Application", '=%1|%2', TheSTORequests."Source Application"::"Member Portal", TheSTORequests."Source Application"::"Mobile Banking");

            if TheSTORequests.FindFirst then begin
                Datum.Add('application_no', TheSTORequests."No.");
                Datum.Add('member_no', TheSTORequests."Member No.");
                Datum.Add('source_account', TheSTORequests."Source Account No.");
                Datum.Add('source_account_name', TheSTORequests."Source Account Name");
                Datum.Add('income_type', Format(TheSTORequests."Income Type"));
                Datum.Add('frequency', Format(TheSTORequests."Frequency (Months)"));
                Datum.Add('duration', Format(TheSTORequests."Duration (Months)"));
                Datum.Add('start_date', GlobalFunctions.FormatISODate(TheSTORequests."Effective/Start Date"));
                Datum.Add('amount', TheSTORequests.Amount);
                Datum.Add('application_date', GlobalFunctions.FormatISODate(TheSTORequests."Application Date"));
                Datum.Add('status', Format(TheSTORequests.Status));
                Datum.Add('description', TheSTORequests.Description);

                TheSTOLines.Reset;
                TheSTOLines.SetRange("Document No.", TheSTORequests."No.");

                if TheSTOLines.FindSet then begin
                    repeat begin
                        Clear(Destination);

                        Destination.Add('entry_no', TheSTOLines."Entry No.");
                        Destination.Add('document_no', TheSTOLines."Document No.");
                        Destination.Add('destination_account_type', Format(TheSTOLines."Destination Account Type"));
                        Destination.Add('destination_account_no', TheSTOLines."Destination Account No.");

                        if TheSTOLines."Destination Account Type" = TheSTOLines."Destination Account Type"::Savings then begin
                            if TheMemberFosaAccount.Get(TheSTOLines."Destination Account No.") then begin
                                Destination.Add('destination_account_name', TheMemberFosaAccount.Name);
                                Destination.Add('destination_account_product_name', TheMemberFosaAccount."Product Name");
                                Destination.Add('destination_account_status', Format(TheMemberFosaAccount.Status));
                            end;
                        end;

                        if TheSTOLines."Destination Account Type" = TheSTOLines."Destination Account Type"::Credit then begin
                            if TheMemberLoanAccount.Get(TheSTOLines."Destination Account No.") then begin
                                TheMemberLoan.Reset;
                                TheMemberLoan.SetRange("Loan Account", TheMemberLoanAccount."No.");

                                if TheMemberLoan.FindFirst then begin
                                    Destination.Add('destination_account_name', TheMemberLoan."Member Name");
                                    Destination.Add('destination_account_product_name', TheMemberLoan."Loan Product Type Name");
                                    Destination.Add('destination_account_status', Format(TheMemberLoan.Status));
                                end;
                            end;
                        end;

                        Destinations.Add(Destination);
                    end until TheSTOLines.Next = 0;
                end;

                Datum.Add('destinations', Destinations);

                ResponseObject.Add('request_status', 'SUCCESS');
                ResponseObject.Add('request_status_description', 'STO application request has been fetched successfully');
                ResponseObject.Add('response_payload', Datum);
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'STO application request ' + application_no.AsValue.AsText + ' NOT found');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CancelStandingOrderRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;

        SearchMember: Record Members;
        TheSTORequests: Record "Standing Order Header";
        TheSTOLines: Record "Standing Order Lines";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('application_no', application_no);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheSTORequests.Reset;

            TheSTORequests.SetRange("No.", application_no.AsValue.AsText);
            TheSTORequests.SetRange(Status, TheSTORequests.Status::Open);

            if TheSTORequests.FindFirst then begin
                TheSTOLines.Reset;

                TheSTOLines.SetRange("Document No.", TheSTORequests."No.");
                if TheSTOLines.FindSet then begin
                    repeat begin
                        TheSTOLines.Delete(true);
                    end until TheSTOLines.Next = 0;
                end;

                if TheSTORequests.Delete(true) then begin
                    ResponseObject.Add('request_status', 'SUCCESS');
                    ResponseObject.Add('request_status_description', 'STO application request has been cancelled successfully');
                    ResponseObject.Add('response_payload', Datum);
                end else begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', 'Unable to cancel STO application request at the moment');
                    ResponseObject.Add('response_payload', Datum);
                end;
            end else begin
                ResponseObject.Add('request_status', 'NOT_FOUND');
                ResponseObject.Add('request_status_description', 'The STO application ' + application_no.AsValue.AsText + ' is NOT available for cancellation');
            end;
        end else begin
            ResponseObject.Add('request_status', ResponseText);
            ResponseObject.Add('request_status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    // Fixed Deposits

    local procedure GetFDAccountsList(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        FDAccountsList: Record "Fixed Deposit Contract";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            FDAccountsList.Reset;
            FDAccountsList.SetRange(Status, FDAccountsList.Status::Approved);
            FDAccountsList.SetRange("Fixed Deposit Status", FDAccountsList."Fixed Deposit Status"::Active);
            FDAccountsList.SetRange("Member No.", SearchMember."No.");

            FDAccountsList.SetAutoCalcFields(
                Balance
            );

            if FDAccountsList.FindSet then begin
                repeat begin
                    Clear(Datum);

                    Datum.Add('account_no', FDAccountsList."No.");
                    Datum.Add('account_name', FDAccountsList.Name);
                    Datum.Add('fixed_amount', FDAccountsList."Fixed Deposit Amount");
                    Datum.Add('balance', FDAccountsList.Balance);
                    Datum.Add('member_no', FDAccountsList."Member No.");
                    Datum.Add('status', Format(FDAccountsList."Fixed Deposit Status"));
                    Datum.Add('product_type', FDAccountsList."Product Type");
                    Datum.Add('product_name', FDAccountsList."Product Name");
                    Datum.Add('registration_date', GlobalFunctions.FormatISODate(FDAccountsList."Registration Date"));
                    Datum.Add('expected_maturity_date', GlobalFunctions.FormatISODate(FDAccountsList."Expected Maturity Date"));
                    Datum.Add('maturity_instructions', Format(FDAccountsList."FD Maturity Instructions"));

                    Data.Add(Datum);
                end until FDAccountsList.Next = 0;
            end;

            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Fixed deposit accounts list has been fetched successfully');
        end else begin
            ResponseObject.Add('request_status', 'NOT_FOUND');
            ResponseObject.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        ResponseObject.Add('response_payload', Data);

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetFDAccountMaturityInstructions(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            // "Transfer all to Savings","Renew Principal","Renew Principal & Interest";
            Clear(Datum);
            Datum.Add('code', 1);
            Datum.Add('description', 'Transfer All to Savings Account');
            Data.Add(Datum);

            Clear(Datum);
            Datum.Add('code', 2);
            Datum.Add('description', 'Renew Principal Amount');
            Data.Add(Datum);

            Clear(Datum);
            Datum.Add('code', 3);
            Datum.Add('description', 'Renew Principal + Interest Amount');
            Data.Add(Datum);

            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('status_description', 'FD Account maturity instructions list has been fetched successfully');
        end else begin
            ResponseObject.Add('request_status', 'NOT_FOUND');
            ResponseObject.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        ResponseObject.Add('response_payload', Data);

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure UpdateFDAccountMaturityRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        account_no: JsonToken;
        maturity_instruction: JsonToken;

        SearchMember: Record Members;
        FDAccount: Record "Fixed Deposit Contract";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('account_no', account_no);
        Payload.Get('maturity_instruction', maturity_instruction);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            FDAccount.Reset;

            FDAccount.SetRange("No.", account_no.AsValue.AsText);
            FDAccount.SetRange("Member No.", SearchMember."No.");
            FDAccount.SetRange("Fixed Deposit Status", FDAccount."Fixed Deposit Status"::Active);

            if FDAccount.FindFirst then begin
                FDAccount."FD Maturity Instructions" := maturity_instruction.AsValue.AsInteger;

                if FDAccount.Modify(true) then begin
                    ResponseObject.Add('request_status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Fixed deposit maturity request has been updated successfully');
                end else begin
                    ResponseObject.Add('request_status', 'ERROR');
                    ResponseObject.Add('error_message', GetLastErrorText(true));
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end else begin
                ResponseObject.Add('request_status', 'NOT_FOUND');
                ResponseObject.Add('error_message', 'The fixed deposit account ' + account_no.AsValue.AsText + ' is NOT available for update');
            end;
        end else begin
            ResponseObject.Add('request_status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        ResponseObject.Add('response_payload', Datum);

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CheckPINResetAbilityRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: record Members;

        GenSetup: Record "General Set-Up";
        TransactionTypes: Record "Transaction Types";
        TransactionCharges: Record "Transaction Charges";
        SavingsAccount: Record "Savings Accounts";

        TotalCharges: Decimal;
        CanResetPin: Boolean;
        AvailableBalance: Decimal;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            GenSetup.Get;
            TransactionTypes.Reset;
            TransactionTypes.SetRange(Code, GenSetup."Mobile Banking PIN Reset");
            if TransactionTypes.FindSet then begin
                repeat begin
                    TransactionCharges.Reset;
                    TransactionCharges.SetRange("Transaction Type", TransactionTypes.Code);
                    if TransactionCharges.FindSet then begin
                        repeat begin

                            TotalCharges += TransactionCharges."Charge Amount";

                            if TransactionCharges."Recover Excise Duty" then begin
                                TotalCharges += (TransactionCharges."Charge Amount") * GenSetup."Transfer Excise Duty (%)" * 0.01;
                            end;

                        end until TransactionCharges.Next = 0;
                    end;
                end until TransactionTypes.Next = 0;
            end;

            SavingsAccount.Reset;
            SavingsAccount.SetRange("No.", SkyMbankingTrans.GetMemberFosaAcc(SearchMember));
            if SavingsAccount.FindFirst then begin
                AvailableBalance := GlobalFunctions.GetSavingsAccountAvailableBalance(SavingsAccount, true);
                if AvailableBalance > TotalCharges then begin
                    CanResetPin := true;
                end;
            end;

            Datum.Add('can_reset_pin', CanResetPin);
            Datum.Add('available_balance', AvailableBalance);
            Datum.Add('total_charge', TotalCharges);

            ResponseObject.Add('request_status', 'SUCCESS');
            ResponseObject.Add('request_status_description', 'Request is successful');
            ResponseObject.Add('response_payload', Datum);
        end else begin
            ResponseObject.Add('request_status', ResponseText);
            ResponseObject.Add('request_status_description', ResponseDescription);
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure ProcessPINResetRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        smp_reference: JsonToken;

        SearchMember: record Members;

        GenSetup: Record "General Set-Up";
        TransactionTypes: Record "Transaction Types";
        TransactionCharges: Record "Transaction Charges";
        SavingsAccount: Record "Savings Accounts";

        SkyPINResetBuffer: Record "Sky PIN Reset Buffer";

        FosaAccountNo: Text;

        TotalCharges: Decimal;
        CanResetPin: Boolean;
        AvailableBalance: Decimal;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('smp_reference', smp_reference);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            FosaAccountNo := SkyMbankingTrans.GetMemberFosaAcc(SearchMember);
            if FosaAccountNo <> '' then begin
                // 1. Log PIN reset to buffer
                SkyPINResetBuffer.Init;

                SkyPINResetBuffer."Savings Account No." := FosaAccountNo;
                SkyPINResetBuffer."SMP Reference" := smp_reference.AsValue.AsText;
                SkyPINResetBuffer."Is Processed?" := false;

                if SkyPINResetBuffer.Insert(true) then begin
                    ResponseObject.Add('request_status', 'SUCCESS');
                    ResponseObject.Add('request_status_description', 'PIN reset request is successful');
                    ResponseObject.Add('response_payload', Datum);
                end else begin
                    ResponseObject.Add('request_status', 'ERROR');
                    ResponseObject.Add('request_status_description', 'Unable to log the PIN reset request at the moment!');
                    ResponseObject.Add('response_payload', Datum);
                end;
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                ResponseObject.Add('request_status_description', 'Member does not have a FOSA savings account!');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', ResponseText);
            ResponseObject.Add('request_status_description', ResponseDescription);
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure PostPINResets()
    var
        SkyPINResetBuffer: Record "Sky PIN Reset Buffer";
        SavingsAccounts: Record "Savings Accounts";
        TransactionCharges: Record "Transaction Charges";
        TransactionTypes: Record "Transaction Types";

        GenSetup: Record "General Set-Up";
        Temp: Record "Banking User Template";
        Jtemplate: Code[20];
        Jbatch: Code[20];
        GenJnlLine: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        DActivity2: Code[20];
        DBranch2: Code[20];
        LineNo: Integer;
        AccType: Enum "Gen. Journal Account Type";
        AccNo: Code[20];
        TransType: Enum "Transaction Types";
        BalAccType: Enum "Gen. Journal Account Type";
        BalAccNo: Code[20];
        Amt: Decimal;
        JournalPosting: Codeunit "Journal Posting";
        SaccoTrans: Codeunit "Sacco Transactions";
        GLEntry: Record "G/L Entry";
    begin
        // PIN reset
        SkyPINResetBuffer.Reset;
        SkyPINResetBuffer.SetRange("Is Processed?", false);
        if SkyPINResetBuffer.FindSet(true) then begin
            GenSetup.Get;
            Temp.Get(UserId);
            Jtemplate := Temp."Cashier Journal Template";
            JBatch := Temp."Cashier Journal Batch";

            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
            GenJnlLine.DeleteAll;

            repeat begin
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("No.", SkyPINResetBuffer."Savings Account No.");
                SavingsAccounts.SetLoadFields(
                    "No.",
                    "Member No.",
                    "Global Dimension 1 Code",
                    "Global Dimension 2 Code"
                );
                SavingsAccounts.SetAutoCalcFields("Balance (LCY)");
                if SavingsAccounts.FindFirst then begin
                    DocNo := CopyStr(SkyPINResetBuffer."SMP Reference", 1, 19);

                    GLEntry.Reset;
                    GLEntry.SetRange("Document No.", DocNo);
                    GLEntry.SetLoadFields("Entry No.");
                    if GLEntry.FindFirst then begin
                        SkyPINResetBuffer."Is Processed?" := true;
                        SkyPINResetBuffer.Modify;
                    end else begin
                        // Post here...
                        TransactionTypes.Reset;
                        TransactionTypes.SetRange(Code, GenSetup."Mobile Banking PIN Reset");
                        if TransactionTypes.FindSet then begin
                            repeat begin
                                TransactionCharges.Reset;
                                TransactionCharges.SetRange("Transaction Type", TransactionTypes.Code);
                                if TransactionCharges.FindSet then begin
                                    repeat begin

                                        if SavingsAccounts."Balance (LCY)" >= TransactionCharges."Charge Amount" then begin
                                            //
                                            PDate := Today;
                                            DActivity2 := SavingsAccounts."Global Dimension 1 Code"; // Branch
                                            DBranch2 := SavingsAccounts."Global Dimension 2 Code"; // Activity

                                            LineNo := LineNo + 10000;
                                            AccType := Acctype::"G/L Account";
                                            AccNo := TransactionCharges."G/L Account";
                                            TransType := Transtype::" ";
                                            BalAccType := Balacctype::"G/L Account";
                                            BalAccNo := '';
                                            Amt := TransactionCharges."Charge Amount";
                                            Amt := Amt * -1;
                                            JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, CopyStr((SavingsAccounts."Member No." + ':' + TransactionCharges.Description), 1, 50), Amt, AccNo, PDate, BalAccType,
                                          BalAccNo, '', DActivity2, DBranch2, TransType, DocNo, '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                            LineNo := LineNo + 10000;
                                            AccType := Acctype::Savings;
                                            AccNo := SavingsAccounts."No.";
                                            TransType := Transtype::" ";
                                            BalAccType := Balacctype::"G/L Account";
                                            BalAccNo := '';
                                            Amt := TransactionCharges."Charge Amount";

                                            JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, CopyStr((SavingsAccounts."Member No." + ':' + TransactionCharges.Description), 1, 50), Amt, AccNo, PDate, BalAccType,
                                          BalAccNo, '', DActivity2, DBranch2, TransType, DocNo, '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                            if TransactionCharges."Recover Excise Duty" = true then begin
                                                GenSetup.TestField("Excise Duty G/L");
                                                GenSetup.TestField("Transfer Excise Duty (%)");
                                                LineNo := LineNo + 10000;
                                                AccType := Acctype::"G/L Account";
                                                Amt := TransactionCharges."Charge Amount";
                                                AccNo := GenSetup."Excise Duty G/L";
                                                TransType := Transtype::" ";
                                                BalAccType := Balacctype::"G/L Account";
                                                BalAccNo := '';
                                                Amt := Amt * GenSetup."Transfer Excise Duty (%)" * 0.01;
                                                JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, CopyStr((SavingsAccounts."Member No." + ':' + TransactionCharges.Description + '-Excise Duty'), 1, 50), Amt * -1, AccNo, PDate, BalAccType,
                                                BalAccNo, '', DActivity2, DBranch2, TransType, DocNo, '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                                LineNo := LineNo + 10000;
                                                GenSetup.TestField("Excise Duty G/L");
                                                GenSetup.TestField("Transfer Excise Duty (%)");
                                                Amt := TransactionCharges."Charge Amount";
                                                AccType := Acctype::Savings;
                                                AccNo := SavingsAccounts."No.";
                                                TransType := Transtype::" ";
                                                BalAccType := Balacctype::Savings;
                                                BalAccNo := '';
                                                Amt := Amt * GenSetup."Transfer Excise Duty (%)" * 0.01;
                                                JournalPosting.PostJournal(Jtemplate, Jbatch, LineNo, AccType, DocNo, CopyStr((SavingsAccounts."Member No." + ':' + TransactionCharges.Description + '-Excise Duty'), 1, 50), Amt, AccNo, PDate, BalAccType,
                                                BalAccNo, '', DActivity2, DBranch2, TransType, DocNo, '', '', "Gen. Journal Account Type"::"G/L Account", '', "Gen. Journal Account Type"::"G/L Account");

                                            end;

                                            if SaccoTrans.PostJournal(JTemplate, JBatch) then begin
                                                SkyPINResetBuffer."Is Processed?" := true;
                                                SkyPINResetBuffer.Modify;
                                            end;
                                        end;

                                    end until TransactionCharges.Next = 0;
                                end;
                            end until TransactionTypes.Next = 0;
                        end;
                    end;
                end;
            end until (SkyPINResetBuffer.Next = 0);
        end;
    end;

    // COMMON

    local procedure MemberExists(identifier_type: Text; identifier: Text; var SearchMember: Record Members; var ResponseText: Text; var ResponseDescription: Text): Boolean
    begin
        if identifier = '' then begin
            ResponseText := 'ERROR';
            ResponseDescription := 'Identifier value must NOT be empty!';
            exit(false);
        end;

        SearchMember.Reset;

        case identifier_type of
            'MSISDN':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("Transactional Mobile Number", identifier);
                    SearchMember.SetRange("Phone No.", identifier);
                end;
            'CUSTOMER_NO', 'MEMBER_NO':
                SearchMember.SetRange("No.", identifier);
            'NATIONAL_ID', 'ID_NUMBER':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"ID Number");
                    SearchMember.SetRange("Primary Identification", identifier);

                    if not SearchMember.FindFirst() then begin
                        SearchMember.Reset;
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"ID Number");
                        SearchMember.SetRange("Secondary Identification", identifier);
                    end;
                end;
            'PASSPORT_NO':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"Passport No");
                    SearchMember.SetRange("Primary Identification", identifier);

                    if not SearchMember.FindFirst() then begin
                        SearchMember.Reset;
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"Passport No");
                        SearchMember.SetRange("Secondary Identification", identifier);
                    end;
                end;
            'GROWER_NO':
                SearchMember.SetRange("Payroll/Staff No.", identifier);
            else begin
                ResponseText := 'ERROR';
                ResponseDescription := 'Identifier type ' + identifier_type + ' is not valid';
                exit(false);
            end;
        end;

        if SearchMember.HasFilter and SearchMember.FindFirst() then begin
            ResponseText := 'SUCCESS';
            ResponseDescription := 'Member with' + identifier_type + ' ' + identifier + ' cannot be found';
            exit(true);
        end else begin
            ResponseText := 'FAILED';
            ResponseDescription := 'Member with ' + identifier_type + ' ' + identifier + ' cannot be found';
            exit(false);
        end;
    end;

    // ------------------------------------------------------------------------------------------------
    local procedure GetMemberRecord(var SearchMember: Record Members; IdentifierType: Text; Identifier: Text; MemberTypeLabel: Text): Record "Members"
    begin
        if Identifier = '' then begin
            Error('Identifier value must NOT be empty!');
        end;

        SearchMember.Reset;

        case IdentifierType of
            'MSISDN':
                begin
                    // SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("Transactional Mobile Number", Identifier);
                    // SearchMember.SetRange("Phone No.", Identifier);

                end;

            'CUSTOMER_NO', 'MEMBER_NO':
                SearchMember.SetRange("No.", Identifier);
            'NATIONAL_ID', 'ID_NUMBER':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"ID Number");
                    SearchMember.SetRange("Primary Identification", Identifier);

                    if not SearchMember.FindFirst then begin
                        SearchMember.Reset;
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"ID Number");
                        SearchMember.SetRange("Secondary Identification", Identifier);
                    end;
                end;
            'PASSPORT_NO':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"Passport No");
                    SearchMember.SetRange("Primary Identification", Identifier);

                    if not SearchMember.FindFirst then begin
                        SearchMember.Reset;
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"Passport No");
                        SearchMember.SetRange("Secondary Identification", Identifier);
                    end;
                end;
            else
        end;

        // exit(SearchMember);
        SearchMember.SetLoadFields("No.", Subflag, "Phone No.", "Transactional Mobile Number", "Employer Code");

        if SearchMember.FindSet then begin
            exit(SearchMember);
        end else begin
            if MemberTypeLabel = '' then begin
                MemberTypeLabel := 'Member';
            end;

            Error('%3 with identifier %1 = %2 NOT found!', IdentifierType, Identifier, MemberTypeLabel);
        end;
    end;

    local procedure GetMemberRecordV2(var SearchMember: Record Members; IdentifierType: Text; Identifier: Text; MemberTypeLabel: Text): Boolean
    var
        FormattedNo: Text;
    begin
        if Identifier = '' then
            exit(false);

        SearchMember.Reset();

        case IdentifierType of
            'MSISDN':
                begin
                    SearchMember.SetRange("Transactional Mobile Number", Identifier);
                end;

            'CUSTOMER_NO', 'MEMBER_NO':
                begin
                    SearchMember.SetRange("No.", Identifier);
                end;
            'NATIONAL_ID', 'ID_NUMBER':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"ID Number");
                    SearchMember.SetRange("Primary Identification", Identifier);

                    if SearchMember.FindFirst() = false then begin
                        SearchMember.Reset();
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"ID Number");
                        SearchMember.SetRange("Secondary Identification", Identifier);
                    end;
                end;

            'PASSPORT_NO':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"Passport No");
                    SearchMember.SetRange("Primary Identification", Identifier);

                    if SearchMember.FindFirst() = false then begin
                        SearchMember.Reset();
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"Passport No");
                        SearchMember.SetRange("Secondary Identification", Identifier);
                    end;
                end;
        end;

        SearchMember.SetLoadFields("No.", Subflag, "Phone No.", "Transactional Mobile Number", "Employer Code");

        exit(SearchMember.FindFirst());
    end;

    local procedure CheckFOSASavingsAccountBlocked(SearchMember: Record Members; BlockType: Text): Boolean
    var
        FosaAcc: Text;
        MemberSavAcc: Record "Savings Accounts";
    begin
        FosaAcc := SkyMbankingTrans.GetMemberFosaAcc(SearchMember);

        if FosaAcc <> '' then begin

            MemberSavAcc.Reset;
            MemberSavAcc.SetRange("No.", FosaAcc);
            MemberSavAcc.SetRange("Member No.", SearchMember."No.");
            case BlockType of
                'ALL':
                    begin
                        MemberSavAcc.SetRange(Blocked, MemberSavAcc.Blocked::All);
                    end;
                'CREDIT':
                    begin
                        MemberSavAcc.SetFilter(Blocked, '=%1|%2', MemberSavAcc.Blocked::All, MemberSavAcc.Blocked::Credit);
                    end;
                'DEBIT':
                    begin
                        MemberSavAcc.SetFilter(Blocked, '=%1|%2', MemberSavAcc.Blocked::All, MemberSavAcc.Blocked::Debit);
                    end;
                else
                    exit(false);
            end;

            MemberSavAcc.SetLoadFields("No.");
            if MemberSavAcc.FindFirst then begin
                exit(true);
            end;

        end;

    end;

    // local procedure FormatPhoneNo(Telephone: Text[50]): Text[50]
    // begin
    //     Telephone := DelChr(Telephone, '=', ' ');

    //     if StrLen(Telephone) = 12 then begin
    //         exit(Telephone);
    //     end;
    //     if StrLen(Telephone) = 13 then begin
    //         Telephone := CopyStr(Telephone, 2, 12);
    //         exit(Telephone);
    //     end;
    //     if StrLen(Telephone) = 10 then begin
    //         if CopyStr(Telephone, 1, 1) = '0' then
    //             Telephone := '254' + CopyStr(Telephone, 2, 9);
    //         exit(Telephone);
    //     end;

    //     if StrLen(Telephone) = 9 then begin
    //         if CopyStr(Telephone, 1, 1) = '7' then
    //             Telephone := '254' + Telephone;
    //         exit(Telephone);
    //     end;
    //     if StrLen(Telephone) > 13 then begin
    //         Telephone := CopyStr(Telephone, StrLen(Telephone) - 9, 10);
    //         if CopyStr(Telephone, 1, 1) = '0' then
    //             Telephone := '254' + CopyStr(Telephone, 2, 9);
    //         exit(Telephone);
    //     end;
    // end;



    local procedure UnsupportedAction(RequestAction: Text): Text
    var
        ResponseObject: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        ResponseObject.Add('request_status', 'ERROR');
        ResponseObject.Add('request_status_description', 'The requested action ' + RequestAction + ' is NOT supported.');
        ResponseObject.Add('errors', Errors);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure AddDateTimeToResponse(var ResponseObject: JsonObject)
    begin
        ResponseObject.Add('date_time', GlobalFunctions.FormatISODateTime(CurrentDateTime));
    end;

    [EventSubscriber(ObjectType::Table, Database::"Credit Ledger Entry", 'OnAfterInsertEvent', '', true, true)]
    local procedure SubscribeToCreditLedgerEntryInsertEvent(var Rec: Record "Credit Ledger Entry")
    var
        theSkyLogBuffer: Record "Sky Interest Log Buffer";
    begin
        if ((Rec."Transaction Type" = Rec."Transaction Type"::"Interest Paid")) then begin
            // Log interest payments for processing later...
            theSkyLogBuffer.Init;
            theSkyLogBuffer."Credit Ledger Entry No." := Rec."Entry No.";
            theSkyLogBuffer."Is Processed?" := false;
            theSkyLogBuffer.Insert(true);
        end;
    end;

    local procedure PostSkyLoansInterest()
    var
        theSkyLogBuffer: Record "Sky Interest Log Buffer";
        theCreditLedgerEntry: Record "Credit Ledger Entry";
        theLoan: Record Loans;
        MobileTransTypes: Record "Mobile Transaction Types";

        LineNo: Integer;
        JnlPosting: Codeunit "Journal Posting";
        LoanTemp: Text;
        LoanBatch: Text;
        BankingUserSetup: Record "Banking User Template";
        AccType: Enum "Gen. Journal Account Type";
        TransType: enum "Transaction Types";
        SkyLoanInterestRate: Decimal;
        ProductFactory: Record "Product Factory";
        DocNo: Text;
        GLEntry: Record "G/L Entry";
        SaccoTrans: Codeunit "Sacco Transactions";

        GenSetup: Record "General Set-Up";

        PostingBatchSize: Integer;
        PostingBatchCounter: Integer;
        RecordsCount: Integer;

        SkyLedgerEntries: Record "Vendor Ledger Entry";
    begin
        if GenSetup.Get then begin
            if BankingUserSetup.get(UserId) then begin
                theSkyLogBuffer.Reset;
                theSkyLogBuffer.SetRange("Is Processed?", false);
                theSkyLogBuffer.SetAscending("Entry No.", true);
                if theSkyLogBuffer.FindSet then begin
                    PostingBatchCounter := 0;
                    RecordsCount := theSkyLogBuffer.Count;
                    PostingBatchSize := 10;

                    LoanTemp := BankingUserSetup."Loans Template";
                    LoanBatch := BankingUserSetup."Loans Batch";
                    SkyLoanInterestRate := 0.2;// 0.1; // default

                    if GenSetup."Sky Loan Interest Rate (%)" = 0 then begin
                        theSkyLogBuffer.ModifyAll("Is Processed?", true);
                        Commit;
                        exit;
                    end else begin
                        SkyLoanInterestRate := (GenSetup."Sky Loan Interest Rate (%)") / 100;
                    end;

                    repeat begin

                        DocNo := Format(theSkyLogBuffer."Credit Ledger Entry No.");
                        DocNo := CopyStr('SKY_' + DocNo, 1, 19);

                        GLEntry.Reset;
                        GLEntry.SetRange("Document No.", DocNo);
                        GLEntry.SetLoadFields("Entry No.");
                        if not GLEntry.FindFirst then begin
                            theCreditLedgerEntry.Reset;
                            theCreditLedgerEntry.SetRange("Entry No.", theSkyLogBuffer."Credit Ledger Entry No.");
                            theCreditLedgerEntry.SetLoadFields("Loan No", "Document No.", "Transaction Type", Amount);

                            if theCreditLedgerEntry.FindFirst then begin
                                theLoan.Reset;
                                theLoan.SetRange("Loan No.", theCreditLedgerEntry."Loan No");
                                theLoan.SetLoadFields(
                                    "Loan No.", "Loan Product Type",
                                    "Mobile Loan", "Source Aplication", "Member No."
                                );

                                if theLoan.FindFirst then begin

                                    if theLoan."Mobile Loan" or
                                (theLoan."Source Aplication" <> theLoan."Source Aplication"::BC) then begin
                                        // Check vendor ledger entries for initial interest revenue
                                        SkyLedgerEntries.Reset;
                                        SkyLedgerEntries.SetRange("Vendor No.", MobileTransTypes."Loan Int. Vendor Account No.");
                                        SkyLedgerEntries.SetRange("External Document No.", theLoan."Loan No.");
                                        if SkyLedgerEntries.FindFirst() then begin

                                            // Skip recovery of subsequent interest payments
                                            theSkyLogBuffer."Is Processed?" := true;
                                            theSkyLogBuffer.Modify;
                                            Commit;

                                        end else begin

                                            // Revenue share on initial interest
                                            // 10% interest to Sky World:

                                            MobileTransTypes.Reset;
                                            MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Loan Disbursement");
                                            if MobileTransTypes.FindFirst then begin
                                                if MobileTransTypes."Loan Int. Vendor Account No." <> '' then begin
                                                    ProductFactory.Reset;
                                                    ProductFactory.SetRange("Product ID", theLoan."Loan Product Type");
                                                    ProductFactory.SetLoadFields("Loan Interest Account [G/L]");
                                                    if ProductFactory.FindFirst then begin
                                                        SaccoTrans.InitJournal(LoanTemp, LoanBatch);

                                                        LineNo += 1000;
                                                        JnlPosting.PostJournal(
                                                            LoanTemp,
                                                            LoanBatch,
                                                            LineNo,
                                                            AccType::"G/L Account",
                                                            DocNo,
                                                            'Revenue share on loan interest ' + theLoan."Loan No." + ' ' + format(theLoan."Member No."),
                                                            (SkyLoanInterestRate * (-theCreditLedgerEntry.Amount)),
                                                            ProductFactory."Loan Interest Account [G/L]",
                                                            Today,
                                                            AccType::"Vendor",
                                                            MobileTransTypes."Loan Int. Vendor Account No.",
                                                            theLoan."Loan No.",
                                                            theLoan."Global Dimension 1 Code",
                                                            theLoan."Global Dimension 2 Code",
                                                            TransType::" ",
                                                            theLoan."Loan No.",
                                                            '',
                                                            '',
                                                            "Gen. Journal Account Type"::"G/L Account",
                                                            '',
                                                            "Gen. Journal Account Type"::"G/L Account"
                                                        );

                                                        if SaccoTrans.PostJournal(LoanTemp, LoanBatch) then begin
                                                            theSkyLogBuffer."Is Processed?" := true;
                                                            theSkyLogBuffer.Modify;
                                                            Commit;
                                                        end;
                                                    end;
                                                end;
                                            end;

                                        end;
                                    end else begin
                                        theSkyLogBuffer."Is Processed?" := true;
                                        theSkyLogBuffer.Modify;
                                        Commit;
                                    end;

                                end;
                            end;
                        end else begin
                            theSkyLogBuffer."Is Processed?" := true;
                            theSkyLogBuffer.Modify;
                            Commit;
                        end;

                        PostingBatchCounter += 1;
                    end until (theSkyLogBuffer.Next = 0) OR (PostingBatchCounter = PostingBatchSize);
                end;
            end;
        end;
    end;

    var
        BranchDimensionCode: Label 'BRANCH';
        VendorName: Label 'Mobile Banking - Sky World Limited';
        GlobalFunctions: Codeunit "Global Functions";
        SkyMbankingTrans: Codeunit "Sky M-Banking Transactions";
        SkySMS: Codeunit SendSms;
        SMSSource: enum "SMS Source";
}