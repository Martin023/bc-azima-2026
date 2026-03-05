codeunit 52186500 "CRM Integration"
{
    procedure HandleRequest(Request: Text): Text
    var
        RequestParser: JsonObject;
        RequestAction: JsonToken;
        RequestPayload: JsonToken;

        HasToken: Boolean;
        SampleMember: Record Members;
    begin
        if Request <> '' then begin
            RequestParser.ReadFrom(Request);
            HasToken := RequestParser.SelectToken('$.action', RequestAction);
            HasToken := RequestParser.SelectToken('$.payload', RequestPayload);

            // API actions here
            case RequestAction.AsValue().AsText() of
                'GET_DIMENSION_VALUES':
                    exit(GetDimensionValues(RequestPayload.AsObject));
                'GET_COUNTRIES':
                    exit(GetCountries);
                'GET_MEMBER_DELEGATE_ZONES':
                    exit(GetMemberDelegateZones);
                'GET_POST_CODES':
                    exit(GetPostCodes);
                'SEARCH_MEMBERS':
                    exit(SearchMembers(RequestPayload.AsObject));
                'GET_MEMBERS':
                    exit(GetMembers(RequestPayload.AsObject));
                'GET_MEMBER_DETAILS':
                    exit(GetMemberDetails(RequestPayload.AsObject));

                'CREATE_MEMBER_APPLICATION':
                    exit(CreateMemberApplication(RequestPayload.AsObject));
                'UPDATE_MEMBER_APPLICATION':
                    exit(UpdateMemberApplication(RequestPayload.AsObject));
                'GET_MEMBER_APPLICATIONS':
                    exit(GetMemberApplications(RequestPayload.AsObject));
                'GET_MEMBER_APPLICATION':
                    exit(GetMemberApplication(RequestPayload.AsObject));
                'MEMBER_EDIT_APPLICATION':
                    exit(CreateMemberEditApplication(RequestPayload.AsObject));
                'UPDATE_MEMBER_EDIT_APPLICATION':
                    exit(UpdateMemberEditApplication(RequestPayload.AsObject));
                'GET_MEMBER_EDIT_APPLICATIONS':
                    exit(GetMemberEditApplications(RequestPayload.AsObject));
                'GET_MEMBER_EDIT_APPLICATION':
                    exit(GetMemberEditApplication(RequestPayload.AsObject));
                'GET_NOK_BEN_NOM_RELATIONSHIPS':
                    exit(GetNokRelationships);
                'GET_MEMBER_EMPLOYERS':
                    exit(GetMemberEmployers);
                'GET_MEMBER_NATIONALITIES':
                    exit(GetMemberNationalities);
                'GET_MEMBER_RELIGIONS':
                    exit(GetMemberReligions);
                'GET_MEMBER_COUNTIES':
                    exit(GetMemberCounties);
                'GET_MEMBER_SUB_COUNTIES':
                    exit(GetMemberSubCounties(RequestPayload.AsObject));
                'GET_MEMBER_BANK_CODES':
                    exit(GetMemberBankCodes);
                'GET_MEMBER_BANK_BRANCHES':
                    exit(GetMemberBankBranches(RequestPayload.AsObject));
                'GET_MEMBER_CLASSES':
                    exit(GetMemberClasses);
                'GET_MEMBER_GROUPS':
                    exit(GetMemberGroups);
                'GET_MEMBER_RELATIONSHIP_MANAGERS':
                    exit(GetMemberRelationshipManagers);
                'GET_PRINCIPLE_MEMBERS':
                    exit(GetPrincipleMembers);
                'GET_MEMBER_SALUTATIONS':
                    exit(GetMemberSalutations);
                'GET_MEMBER_WORKSTATIONS':
                    exit(GetMemberWorkstations);
                'GET_MEMBER_DESIGNATIONS':
                    exit(GetMemberDesignations);
                'GET_LOAN_PRODUCTS':
                    exit(GetLoanProducts(RequestPayload.AsObject));
                'GET_LOAN_SECTORS':
                    exit(GetLoanSectors);
                'GET_LOAN_PURPOSES':
                    exit(GetLoanPurposes);
                'CREATE_LOAN_APPLICATION':
                    exit(CreateLoanApplication(RequestPayload.AsObject));
                'UPDATE_LOAN_APPLICATION':
                    exit(UpdateLoanApplication(RequestPayload.AsObject));
                'GET_LOAN_APPLICATIONS':
                    exit(GetLoanApplications(RequestPayload.AsObject));
                'GET_LOAN_APPLICATION':
                    exit(GetLoanApplication(RequestPayload.AsObject));
                'GET_MEMBER_NOK_BEN_NOM_LIST':
                    exit(GetMemberNOKList(RequestPayload.AsObject));
                'GET_MEMBER_WITHDRAWAL_REASONS':
                    exit(GetMemberWithdrawalReasons);
                'GET_MEMBER_LIABILITIES':
                    exit(GetMemberLiabilities(RequestPayload.AsObject));
                'CREATE_MEMBER_WITHDRAWAL_APPLICATION':
                    exit(CreateMemberWithdrawalApplication(RequestPayload.AsObject));
                'UPDATE_MEMBER_WITHDRAWAL_APPLICATION':
                    exit(UpdateMemberWithdrawalApplication(RequestPayload.AsObject));
                'GET_MEMBER_WITHDRAWALS':
                    exit(GetMemberWithdrawals(RequestPayload.AsObject));
                'GET_MEMBER_WITHDRAWAL':
                    exit(GetMemberWithdrawal(RequestPayload.AsObject));
                'CREATE_BBF_CLAIM_REQUEST':
                    exit(CreateBBFClaimRequest(RequestPayload.AsObject));
                'UPDATE_BBF_CLAIM_REQUEST':
                    exit(UpdateBBFClaimRequest(RequestPayload.AsObject));
                'GET_BBF_CLAIM_REQUESTS':
                    exit(GetBBFClaimRequests(RequestPayload.AsObject));
                'GET_BBF_CLAIM_REQUEST':
                    exit(GetBBFClaimRequest(RequestPayload.AsObject));
                'GET_MEMBER_LOANS_LIST':
                    exit(GetMemberLoansList(RequestPayload.AsObject));
                'GET_LOAN_GUARANTORS_LIST':
                    exit(GetLoanGuarantorsList(RequestPayload.AsObject));
                'GET_LOAN_COLLATERALS_LIST':
                    exit(GetLoanCollateralsList(RequestPayload.AsObject));
                'CREATE_LOAN_GUARANTOR_SUBSTITUTION_REQUEST':
                    exit(CreateLoanGuarantorSubstitutionRequest(RequestPayload.AsObject));
                'UPDATE_LOAN_GUARANTOR_SUBSTITUTION_REQUEST':
                    exit(UpdateLoanGuarantorSubstitutionRequest(RequestPayload.AsObject));
                'GET_LOAN_GUARANTOR_SUBSTITUTION_REQUESTS':
                    exit(GetLoanGuarantorSubstitutionRequests(RequestPayload.AsObject));
                'GET_LOAN_GUARANTOR_SUBSTITUTION_REQUEST':
                    exit(GetLoanGuarantorSubstitutionRequest(RequestPayload.AsObject));
                'GET_SAVINGS_PRODUCTS':
                    exit(GetSavingsProducts);
                'CREATE_SUB_ACCOUNT_REQUEST':
                    exit(CreateSubAccountRequest(RequestPayload.AsObject));
                'UPDATE_SUB_ACCOUNT_REQUEST':
                    exit(UpdateSubAccountRequest(RequestPayload.AsObject));
                'GET_SUB_ACCOUNT_REQUESTS':
                    exit(GetSubAccountRequests(RequestPayload.AsObject));
                'GET_SUB_ACCOUNT_REQUEST':
                    exit(GetSubAccountRequest(RequestPayload.AsObject));
                'CREATE_LOAN_VARIATION_REQUEST':
                    exit(CreateLoanVariationRequest(RequestPayload.AsObject));
                'UPDATE_LOAN_VARIATION_REQUEST':
                    exit(UpdateLoanVariationRequest(RequestPayload.AsObject));
                'GET_LOAN_VARIATION_REQUESTS':
                    exit(GetLoanVariationRequests(RequestPayload.AsObject));
                'GET_LOAN_VARIATION_REQUEST':
                    exit(GetLoanVariationRequest(RequestPayload.AsObject));
                'GET_MEMBER_ACCOUNTS_LIST':
                    exit(GetMemberAccountsList(RequestPayload.AsObject));
                'GET_MEMBER_ACCOUNT_STATEMENT':
                    exit(GetMemberAccountStatement(RequestPayload.AsObject));
                'GET_MEMBER_LOAN_STATEMENT':
                    exit(GetMemberLoanStatement(RequestPayload.AsObject));
                'GET_MEMBER_LOANS_GUARANTEED':
                    exit(GetMemberLoansGuaranteed(RequestPayload.AsObject));
                'CREATE_DEPOSIT_VARIATION_REQUEST':
                    exit(CreateDepositVariationRequest(RequestPayload.AsObject));
                'UPDATE_DEPOSIT_VARIATION_REQUEST':
                    exit(UpdateDepositVariationRequest(RequestPayload.AsObject));
                'GET_DEPOSIT_VARIATION_REQUESTS':
                    exit(GetDepositVariationRequests(RequestPayload.AsObject));
                'GET_DEPOSIT_VARIATION_REQUEST':
                    exit(GetDepositVariationRequest(RequestPayload.AsObject));
                'CREATE_SHARES_TRANSFER_REQUEST':
                    exit(CreateSharesTransferRequest(RequestPayload.AsObject));
                'UPDATE_SHARES_TRANSFER_REQUEST':
                    exit(UpdateSharesTransferRequest(RequestPayload.AsObject));
                'GET_SHARES_TRANSFER_REQUESTS':
                    exit(GetSharesTransferRequests(RequestPayload.AsObject));
                'GET_SHARES_TRANSFER_REQUEST':
                    exit(GetSharesTransferRequest(RequestPayload.AsObject));
                'SEARCH_DELEGATES':
                    exit(SearchDelegates(RequestPayload.AsObject));
                'SEARCH_EMPLOYEES':
                    exit(SearchEmployees(RequestPayload.AsObject));

                'QUEUE_SMS':
                    exit(QueueSMS(RequestPayload.AsObject));
                'GET_SMSES':
                    exit(GetSMSes(RequestPayload.AsObject));

                'GET_APPLICATION_TRAIL':
                    exit(GetApplicationTrail(RequestPayload.AsObject));

                'UPLOAD_APPLICATION_FILES':
                    exit(UploadApplicationFiles(RequestPayload.AsObject));
                'GET_APPLICATION_FILES':
                    exit(GetApplicationFiles(RequestPayload.AsObject));
                'GET_APPLICATION_FILE':
                    exit(GetApplicationFile(RequestPayload.AsObject));

                'GET_LEDGER_ENTRIES':
                    exit(GetLedgerEntries(RequestPayload.AsObject));
                'GET_FLAGS':
                    exit(GetFlags(RequestPayload.AsObject));

                // 'CREATE_MBANKING_WHITELIST_APPLICATION':
                //     exit(CreateMbankingWhitelistApplication(RequestPayload.AsObject));
                // 'GET_MBANKING_WHITELIST_APPLICATIONS':
                //     exit(GetMemberWhitelistApplications(RequestPayload.AsObject));
                // 'GET_MBANKING_WHITELIST_APPLICATION':
                //     exit(GetMemberWhitelistApplication(RequestPayload.AsObject));

                // REPORTS
                'GET_MEMBER_DETAILED_STATEMENT_REPORT':
                    exit(GetMemberDetailedStatementReport(RequestPayload.AsObject));
                'GET_MEMBER_LOAN_STATEMENT_REPORT':
                    exit(GetMemberLoanStatementReport(RequestPayload.AsObject));
                'GET_MEMBER_STATEMENT_NEW_REPORT':
                    exit(GetMemberStatementNewReport(RequestPayload.AsObject));
                'GET_LOAN_REPAYMENT_SCHEDULE_REPORT':
                    exit(GetLoanRepaymentScheduleReport(RequestPayload.AsObject));
                'GET_SAVINGS_ACCOUNT_STATEMENT_REPORT':
                    exit(GetSavingsAccountStatementReport(RequestPayload.AsObject));
                'GET_LOANS_GUARANTEED_REPORT':
                    exit(GetLoansGuaranteedReport(RequestPayload.AsObject));
                'GET_LOAN_GUARANTORS_REPORT':
                    exit(GetLoanGuarantorsReport(RequestPayload.AsObject));
                'GET_DIVIDEND_SLIP_REPORT':
                    exit(GetDividendSlipReport(RequestPayload.AsObject));

                'GET_MEMBER_SHARES_BY_CATEGORY_REPORT':
                    exit(GetMemberShareByCategoryReport(RequestPayload.AsObject));
                'GET_MEMBER_LIFETIME_VALUE_REPORT':
                    exit(GetMemberLifetimeValueReport(RequestPayload.AsObject));
                'GET_LOAN_PRODUCTS_REPORT':
                    exit(GetLoanProductsReport(RequestPayload.AsObject));
                'GET_DEPOSITS_ACC_OVER_TIME_REPORT':
                    exit(GetDepositsAccumulatedOverTimeReport(RequestPayload.AsObject));
                'GET_SAVINGS_PRODUCTS_REPORT':
                    exit(GetSavingsProductsReport(RequestPayload.AsObject));
                'GET_SALARY_ACCOUNTS_REPORT':
                    exit(GetSalaryAccountsReport(RequestPayload.AsObject));

                // REPORTS - Marketing
                'GET_MEMBER_COMMISSIONS_REPORT':
                    exit(GetMemberCommissionsReport(RequestPayload.AsObject));
                'GET_MEMBER_COMMISSIONS_REPORT_XLSX':
                    exit(GetMemberCommissionsReportXLSX(RequestPayload.AsObject));

                'GET_MEMBERS_WITHOUT_LOANS_REPORT':
                    exit(GetMemberWithoutLoansReport(RequestPayload.AsObject));
                'GET_SUB_ACCOUNT_COMMISSIONS_REPORT':
                    exit(GetSubAccountCommissionsReport(RequestPayload.AsObject));
                'GET_VARIATION_COMMISSIONS_REPORT':
                    exit(GetVariationCommissionsReport(RequestPayload.AsObject));
                'GET_CHANGE_OF_PAYPOINT_COMMISSIONS_REPORT':
                    exit(GetChangeOfPaypointCommissionsReport(RequestPayload.AsObject));

                // TAT Reports
                'GET_MEMBERSHIP_TAT_REPORT':
                    exit(GetMembershipTATReport(RequestPayload.AsObject));
                'GET_MEMBERSHIP_TAT_REPORT_XLSX':
                    exit(GetMembershipTATReportXLSX(RequestPayload.AsObject));
                'GET_LOANS_TAT_REPORT':
                    exit(GetLoansTATReport(RequestPayload.AsObject));
                'GET_LOANS_TAT_REPORT_XLSX':
                    exit(GetLoansTATReportXLSX(RequestPayload.AsObject));
                'GET_MEMBER_EDIT_TAT_REPORT':
                    exit(GetMemberEditTATReport(RequestPayload.AsObject));
                'GET_MEMBER_EDIT_TAT_REPORT_XLSX':
                    exit(GetMemberEditTATReportXLSX(RequestPayload.AsObject));
                'GET_BUSINESS_LOANS_TAT_REPORT':
                    exit(GetBusinessLoansTATReport(RequestPayload.AsObject));
                'GET_BUSINESS_LOANS_TAT_REPORT_XLSX':
                    exit(GetBusinessLoansTATReportXLSX(RequestPayload.AsObject));
                'GET_GUARANTOR_SUBSTITUTIONS_TAT_REPORT':
                    exit(GetGuarantorSubstitutionsTATReport(RequestPayload.AsObject));
                'GET_GUARANTOR_SUBSTITUTIONS_TAT_REPORT_XLSX':
                    exit(GetGuarantorSubstitutionsTATReportXLSX(RequestPayload.AsObject));
                'GET_MEMBER_READMISSION_TAT_REPORT':
                    exit(GetMemberReadmissionTATReport(RequestPayload.AsObject));
                'GET_MEMBER_READMISSION_TAT_REPORT_XLSX':
                    exit(GetMemberReadmissionTATReportXLSX(RequestPayload.AsObject));
                'GET_MEMBER_WITHDRAWAL_TAT_REPORT':
                    exit(GetMemberWithdrawalTATReport(RequestPayload.AsObject));
                'GET_MEMBER_WITHDRAWAL_TAT_REPORT_XLSX':
                    exit(GetMemberWithdrawalTATReportXLSX(RequestPayload.AsObject));

                'GET_BBF_TAT_REPORT':
                    exit(GetBBFTATReport(RequestPayload.AsObject));
                'GET_BBF_TAT_REPORT_XLSX':
                    exit(GetBBFTATReportXLSX(RequestPayload.AsObject));
                'GET_BBF_INSURANCE_TAT_REPORT':
                    exit(GetBBFInsuranceTATReport(RequestPayload.AsObject));
                'GET_BBF_INSURANCE_TAT_REPORT_XLSX':
                    exit(GetBBFInsuranceTATReportXLSX(RequestPayload.AsObject));
                'GET_BBF_RISK_TAT_REPORT':
                    exit(GetBBFRiskTATReport(RequestPayload.AsObject));
                'GET_BBF_RISK_TAT_REPORT_XLSX':
                    exit(GetBBFRiskTATReportXLSX(RequestPayload.AsObject));
                'GET_SHARE_TRANSFER_TAT_REPORT':
                    exit(GetShareTransferTATReport(RequestPayload.AsObject));
                'GET_SHARE_TRANSFER_TAT_REPORT_XLSX':
                    exit(GetShareTransferTATReportXLSX(RequestPayload.AsObject));
                'GET_DEPOSIT_VARIATIONS_TAT_REPORT':
                    exit(GetDepositVariationsTATReport(RequestPayload.AsObject));
                'GET_DEPOSIT_VARIATIONS_TAT_REPORT_XLSX':
                    exit(GetDepositVariationsTATReportXLSX(RequestPayload.AsObject));
                'GET_LOAN_VARIATIONS_TAT_REPORT':
                    exit(GetLoanVariationsTATReport(RequestPayload.AsObject));
                'GET_LOAN_VARIATIONS_TAT_REPORT_XLSX':
                    exit(GetLoanVariationsTATReportXLSX(RequestPayload.AsObject));

                'GET_MEMBER_MAJOR_MINOR_LOANS_COUNT':
                    exit(GetMemberMajorMinorLoansCount(RequestPayload.AsObject));

                'QUEUE_EMAIL':
                    exit(QueueEmail(RequestPayload.AsObject));
                'GET_EMAILS':
                    exit(GetEmails(RequestPayload.AsObject));
                else
                    exit(UnsupportedAction(RequestAction.AsValue.AsText));
            end;
        end else begin
            exit('');
        end;
    end;

    local procedure GetDimensionValues(Payload: JsonObject): Text
    var
        dimension_code: JsonToken;

        DimensionValues: Record "Dimension Value";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('dimension_code', dimension_code);

        DimensionValues.Reset;
        DimensionValues.SetRange("Dimension Code", dimension_code.AsValue.AsText);

        IF DimensionValues.FindSet then begin
            repeat begin
                Datum.Add('code', DimensionValues.Code);
                Datum.Add('name', DimensionValues.Name);

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until DimensionValues.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CreateMemberApplication(Payload: JsonObject): Text
    var
        crm_lead_ref_no: JsonToken;
        application_type: JsonToken;
        first_name: JsonToken;
        middle_name: JsonToken;
        other_names: JsonToken;
        current_address: JsonToken;
        permanent_address: JsonToken;
        phone_no: JsonToken;
        transactional_mobile_no: JsonToken;
        employer_code: JsonToken;
        date_of_birth: JsonToken;
        email_address: JsonToken;
        nationality: JsonToken;
        payroll_staff_no: JsonToken;
        primary_identification_type: JsonToken;
        secondary_identification_type: JsonToken;
        religion: JsonToken;
        primary_identification: JsonToken;
        secondary_identification: JsonToken;
        passport_expiry_date: JsonToken;
        office_telephone_no: JsonToken;
        marital_status: JsonToken;
        _gender: JsonToken;
        terms_of_employment: JsonToken;
        post_code: JsonToken;
        city: JsonToken;
        county: JsonToken;
        sub_county: JsonToken;
        bank_code: JsonToken;
        bank_branch_code: JsonToken;
        bank_account_no: JsonToken;
        kra_pin_number: JsonToken;
        recruited_by_type: JsonToken;
        recruited_by: JsonToken;
        type_of_application: JsonToken;
        principle_member: JsonToken;
        is_self_employed: JsonToken;
        crm_application_no: JsonToken;
        salutation: JsonToken;
        account_profile: JsonToken;
        account_type: JsonToken;
        member_class: JsonToken;
        is_from_another_sacco: JsonToken;
        crm_created_by: JsonToken;
        activity_code: JsonToken;
        branch_code: JsonToken;
        country_of_operation: JsonToken;
        work_station: JsonToken;
        employment_designation: JsonToken;
        delegates_zone: JsonToken;
        date_of_contribution_commencement: JsonToken;
        contribution_amount: JsonToken;
        crm_notes: JsonToken;
        crm_originating_branch: JsonToken;
        nok_beneficiary_nominee_info: JsonToken;
        nok_beneficiary_nominee: JsonToken;
        nok_beneficiary_nominee_identification_type: JsonToken;
        nok_beneficiary_nominee_identification_value: JsonToken;
        nok_beneficiary_nominee_full_names: JsonToken;
        nok_beneficiary_nominee_relationship: JsonToken;
        nok_beneficiary_nominee_date_of_birth: JsonToken;
        nok_beneficiary_nominee_address: JsonToken;
        nok_beneficiary_nominee_mobile_no: JsonToken;
        nok_beneficiary_nominee_email_address: JsonToken;
        nok_beneficiary_nominee_is_next_of_kin: JsonToken;
        nok_beneficiary_nominee_is_beneficiary: JsonToken;
        nok_beneficiary_nominee_is_contact_person: JsonToken;
        nok_beneficiary_nominee_is_nominee: JsonToken;
        nok_beneficiary_nominee_allocation: JsonToken;
        iprs_verified: JsonToken;

        KeyExists: Boolean;

        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        NewNo: Code[20];
        NewNoSeriesCode: Code[20];
        // CRMNewNo: Code[20];
        // CRMNewNoSeriesCode: Code[20];

        MemberApplication: Record "Member Application";
        NextofKinApplication: Record "Next of KIN Application";
        MemberImages: Record "Image Data";
        NextOfKin: Record "Next of KIN";
        Index: Integer;
        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        KeyExists := Payload.Get('crm_lead_ref_no', crm_lead_ref_no);
        KeyExists := Payload.Get('application_type', application_type);
        KeyExists := Payload.Get('first_name', first_name);
        KeyExists := Payload.Get('middle_name', middle_name);
        KeyExists := Payload.Get('other_names', other_names);
        KeyExists := Payload.Get('current_address', current_address);
        KeyExists := Payload.Get('permanent_address', permanent_address);
        KeyExists := Payload.Get('phone_no', phone_no);
        KeyExists := Payload.Get('transactional_mobile_no', transactional_mobile_no);
        KeyExists := Payload.Get('employer_code', employer_code);
        KeyExists := Payload.Get('date_of_birth', date_of_birth);
        KeyExists := Payload.Get('email_address', email_address);
        KeyExists := Payload.Get('nationality', nationality);
        KeyExists := Payload.Get('payroll_staff_no', payroll_staff_no);
        KeyExists := Payload.Get('primary_identification_type', primary_identification_type);
        KeyExists := Payload.Get('secondary_identification_type', secondary_identification_type);
        KeyExists := Payload.Get('religion', religion);
        KeyExists := Payload.Get('primary_identification', primary_identification);
        KeyExists := Payload.Get('secondary_identification', secondary_identification);
        KeyExists := Payload.Get('office_telephone_no', office_telephone_no);
        KeyExists := Payload.Get('marital_status', marital_status);
        KeyExists := Payload.Get('gender', _gender);
        KeyExists := Payload.Get('terms_of_employment', terms_of_employment);
        KeyExists := Payload.Get('post_code', post_code);
        KeyExists := Payload.Get('city', city);
        KeyExists := Payload.Get('county', county);
        KeyExists := Payload.Get('sub_county', sub_county);
        KeyExists := Payload.Get('bank_code', bank_code);
        KeyExists := Payload.Get('bank_branch_code', bank_branch_code);
        KeyExists := Payload.Get('bank_account_no', bank_account_no);
        KeyExists := Payload.Get('kra_pin_number', kra_pin_number);
        KeyExists := Payload.Get('recruited_by_type', recruited_by_type);
        KeyExists := Payload.Get('recruited_by', recruited_by);
        KeyExists := Payload.Get('type_of_application', type_of_application);
        KeyExists := Payload.Get('principle_member', principle_member);
        KeyExists := Payload.Get('is_self_employed', is_self_employed);
        KeyExists := Payload.Get('crm_application_no', crm_application_no);
        KeyExists := Payload.Get('salutation', salutation);
        KeyExists := Payload.Get('account_profile', account_profile);
        KeyExists := Payload.Get('account_type', account_type);
        KeyExists := Payload.Get('member_class', member_class);
        KeyExists := Payload.Get('is_from_another_sacco', is_from_another_sacco);
        KeyExists := Payload.Get('crm_created_by', crm_created_by);
        KeyExists := Payload.Get('branch_code', branch_code);
        KeyExists := Payload.Get('activity_code', activity_code);
        KeyExists := Payload.Get('country_of_operation', country_of_operation);
        KeyExists := Payload.Get('work_station', work_station);
        KeyExists := Payload.Get('employment_designation', employment_designation);
        KeyExists := Payload.Get('delegates_zone', delegates_zone);
        KeyExists := Payload.Get('date_of_contribution_commencement', date_of_contribution_commencement);
        KeyExists := Payload.Get('contribution_amount', contribution_amount);
        KeyExists := Payload.Get('crm_notes', crm_notes);
        KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);
        KeyExists := Payload.Get('passport_expiry_date', passport_expiry_date);
        KeyExists := Payload.Get('nok_beneficiary_nominee_info', nok_beneficiary_nominee_info);
        KeyExists := Payload.Get('iprs_verified', iprs_verified);

        MemberApplication.Init();

        SeriesSetup.Get;
        SeriesSetup.TestField(SeriesSetup."Member Application Nos.");
        NewNo := NoSeriesMgt.GetNextNo(SeriesSetup."Member Application Nos.");
        // NoSeriesMgt.InitSeries(SeriesSetup."Member Application Nos.", SeriesSetup."Member Application Nos.", 0D, NewNo, NewNoSeriesCode);

        MemberApplication."No." := NewNo;
        MemberApplication."No. Series" := NewNoSeriesCode;

        if crm_created_by.AsValue.AsText = '' then begin
            Error('ERR_401. Invalid application. Origination NOT accepted!');
        end;

        if application_type.AsValue.AsText = 'INDIVIDUAL' then begin
            // MemberApplication."Allocated Officer" := relationship_manager.AsValue.AsText;
            MemberApplication."Type of Application" := "Type of Application".FromInteger(type_of_application.AsValue.AsInteger);
            IF ((MemberApplication."Type of Application" = "Type of Application"::Readmission) OR (MemberApplication."Type of Application" = "Type of Application"::Nominee)) then begin
                MemberApplication."Principle Member" := principle_member.AsValue.AsText;
                MemberApplication."Old Member No." := principle_member.AsValue.AsText;

                MemberImages.Reset;

                MemberImages.SetRange("Member No", principle_member.AsValue.AsText);

                if MemberImages.FindFirst then begin
                    MemberApplication.Signature := MemberImages.Signature;
                    MemberApplication.Picture := MemberImages.Picture;
                end;
            end;

            // CRM - No Series
            // if MemberApplication."Type of Application" = MemberApplication."Type of Application"::Readmission then begin
            //     SeriesSetup.TestField(SeriesSetup."CRM - Member Readmission");
            //     NoSeriesMgt.InitSeries(SeriesSetup."CRM - Member Readmission", SeriesSetup."CRM - Member Readmission", 0D, CRMNewNo, CRMNewNoSeriesCode);
            // end else begin
            //     SeriesSetup.TestField(SeriesSetup."CRM - Member Applications");
            //     NoSeriesMgt.InitSeries(SeriesSetup."CRM - Member Applications", SeriesSetup."CRM - Member Applications", 0D, CRMNewNo, CRMNewNoSeriesCode);
            // end;

            // MemberApplication."CRM Application No." := CRMNewNo;
            // MemberApplication."CRM No. Series" := CRMNewNoSeriesCode;
            MemberApplication."CRM Application No." := NewNo;
            MemberApplication."CRM No. Series" := NewNoSeriesCode;

            MemberApplication."First Name" := first_name.AsValue.AsText;
            MemberApplication."Middle Name" := middle_name.AsValue.AsText;
            MemberApplication."Other Names" := other_names.AsValue.AsText;
            MemberApplication."Home Address" := permanent_address.AsValue.AsText;
            MemberApplication."Current Address" := current_address.AsValue.AsText;
            MemberApplication.Nationality := nationality.AsValue.AsText;
            MemberApplication."Phone No." := phone_no.AsValue.AsText;
            MemberApplication.Validate("Phone No.");
            MemberApplication."Country Of Operation" := country_of_operation.AsValue.AsText;

            if (MemberApplication."Country Of Operation" = 'KE') and (MemberApplication.Nationality = 'KE') then begin
                if (transactional_mobile_no.AsValue.AsText <> '') then begin
                    if GlobalFunctions.ValidateKenyanPhoneNumber(transactional_mobile_no.AsValue.AsText) then begin
                        MemberApplication."Transactional Mobile Number" := transactional_mobile_no.AsValue.AsText;
                        MemberApplication.Validate("Transactional Mobile Number");
                    end else begin
                        Error('Transactional mobile number MUST be in the format of 254xxxxxxxxx');
                    end;
                end;
            end;

            MemberApplication."Employer Code" := employer_code.AsValue.AsText;
            MemberApplication.Validate("Employer Code");
            MemberApplication."Member Class" := member_class.AsValue.AsText;
            MemberApplication.Validate("Member Class");

            if date_of_birth.AsValue.AsText <> '' then begin
                MemberApplication."Date of Birth" := date_of_birth.AsValue.AsDate;
                MemberApplication.Validate("Date of Birth");
            end;
            MemberApplication."E-Mail" := email_address.AsValue.AsText;
            MemberApplication.Validate("E-Mail");
            MemberApplication."Payroll/Staff No." := payroll_staff_no.AsValue.AsText;
            MemberApplication.Validate("Payroll/Staff No.");
            MemberApplication."Primary Identification Type" := "Identification Type".FromInteger(primary_identification_type.AsValue.AsInteger);
            MemberApplication.Validate("Primary Identification Type");

            MemberApplication."Secondary Identification Type" := "Identification Type".FromInteger(secondary_identification_type.AsValue.AsInteger);
            MemberApplication.Religion := religion.AsValue.AsText;
            MemberApplication."Primary Identification" := primary_identification.AsValue.AsText;
            MemberApplication.Validate("Primary Identification");
            MemberApplication."Secondary Identification" := secondary_identification.AsValue.AsText;
            MemberApplication.Validate("Secondary Identification");

            MemberApplication."Marital Status" := "Marital Status".FromInteger(marital_status.AsValue.AsInteger);
            MemberApplication.Gender := "Gender".FromInteger(_gender.AsValue.AsInteger);
            MemberApplication."Terms of Employment" := "Terms Of Employment".FromInteger(terms_of_employment.AsValue.AsInteger);
            MemberApplication."Post Code" := post_code.AsValue.AsText;
            MemberApplication.City := city.AsValue.AsText;
            MemberApplication.County := county.AsValue.AsText;
            MemberApplication."Sub-County" := sub_county.AsValue.AsText;

            MemberApplication."Bank Code" := bank_code.AsValue.AsText;
            MemberApplication.Validate("Bank Code");
            MemberApplication."Branch Code" := bank_branch_code.AsValue.AsText;
            MemberApplication.Validate("Branch Code");

            MemberApplication."Member Segment" := '';
            MemberApplication."Bank Account No." := bank_account_no.AsValue.AsText;
            MemberApplication."P.I.N Number" := kra_pin_number.AsValue.AsText;
            MemberApplication.Validate("P.I.N Number");

            MemberApplication."Recruited by Type" := "Recruited By".FromInteger(recruited_by_type.AsValue.AsInteger);
            MemberApplication."Recruited By" := recruited_by.AsValue.AsText;
            MemberApplication.Validate("Recruited By");

            MemberApplication."Self Employed" := is_self_employed.AsValue.AsBoolean;
            MemberApplication.Salutation := salutation.AsValue.AsText;
            MemberApplication."Account Profile" := account_profile.AsValue.AsInteger;
            MemberApplication."From Another Sacco" := is_from_another_sacco.AsValue.AsBoolean;
            MemberApplication."Created By" := crm_created_by.AsValue.AsText;
            MemberApplication."Office Telephone No." := office_telephone_no.AsValue.AsText;
            MemberApplication."Country Of Operation" := country_of_operation.AsValue.AsText;
            MemberApplication."Work Station" := work_station.AsValue.AsText;
            MemberApplication."Employment Designation" := employment_designation.AsValue.AsText;
            MemberApplication."Delegates Zone" := delegates_zone.AsValue.AsText;
            MemberApplication.Validate("Delegates Zone");

            // MemberApplication."CRM Application No." := crm_application_no.AsValue.AsText;
            MemberApplication."CRM Created By" := crm_created_by.AsValue.AsText;
            MemberApplication."CRM Originating Branch" := crm_originating_branch.AsValue.AsText;
            MemberApplication."CRM Notes" := crm_notes.AsValue.AsText;

            if date_of_contribution_commencement.AsValue.AsText <> '' then begin
                MemberApplication."Contribution Start Date" := date_of_contribution_commencement.AsValue.AsDate;
                MemberApplication.Validate("Contribution Start Date");
            end;
            if (not contribution_amount.AsValue.IsNull) then begin
                MemberApplication."Contribution Amount" := contribution_amount.AsValue.AsDecimal;
                MemberApplication.Validate("Contribution Amount");
            end else begin
                MemberApplication."Contribution Amount" := 0;
            end;

            MemberApplication.Status := MemberApplication.Status::Open;
            MemberApplication."Account Type" := MemberApplication."Account Type"::"Single Member Account";
            MemberApplication.Validate("Account Type");
            MemberApplication."Responsibility Center" := Format("Responsibility Center Enum"::RECORDS);
            MemberApplication."Application Date" := DT2Date(CurrentDateTime);
            MemberApplication."Global Dimension 1 Code" := branch_code.AsValue.AsText;
            MemberApplication.Validate("Global Dimension 1 Code");
            MemberApplication."Global Dimension 2 Code" := activity_code.AsValue.AsText;
            // MemberApplication.Validate("Global Dimension 2 Code");

            MemberApplication.Validate("First Name");
            MemberApplication.Validate("Middle Name");
            MemberApplication.Validate("Other Names");

            if date_of_birth.AsValue.AsText <> '' then begin
                MemberApplication."Date of Birth" := date_of_birth.AsValue.AsDate;
            end;

            if passport_expiry_date.AsValue.AsText <> '' then begin
                MemberApplication."Passport Expiry Date" := passport_expiry_date.AsValue.AsDate;
            end;
        end;

        if not crm_lead_ref_no.AsValue.IsNull then begin
            if crm_lead_ref_no.AsValue.AsText <> '' then begin
                MemberApplication."Source Aplication" := MemberApplication."Source Aplication"::"CRM - Sales";
                MemberApplication."CRM Lead Ref. No" := crm_lead_ref_no.AsValue.AsText;
            end else begin
                MemberApplication."Source Aplication" := MemberApplication."Source Aplication"::CRM;
            end;
        end else begin
            MemberApplication."Source Aplication" := MemberApplication."Source Aplication"::CRM;
        end;

        if not iprs_verified.AsValue.IsNull then begin
            MemberApplication."IPRS Verified" := iprs_verified.AsValue.AsBoolean;
        end else begin
            MemberApplication."IPRS Verified" := false;
        end;

        MemberApplication."Sent Back to CRM" := false;

        IF MemberApplication.Insert(true) then begin
            // Handle CRM branch assigmnent
            MemberApplication."Global Dimension 1 Code" := GlobalFunctions.GetMainBranchCodeFromCRMOrigination(MemberApplication."CRM Originating Branch");
            MemberApplication.Modify;

            // CRM Comments/Notes
            GlobalFunctions.InsertCommentRecord(
                MemberApplication."No.",
                crm_notes.AsValue.AsText,
                crm_created_by.AsValue.AsText,
                MemberApplication."Global Dimension 1 Code",
                MemberApplication."Global Dimension 2 Code",
                MemberApplication."Responsibility Center",
                false
            );

            // Next of Kin, Nominee, BBF
            IF nok_beneficiary_nominee_info.IsArray then begin
                for Index := 0 to (nok_beneficiary_nominee_info.AsArray.Count - 1) do begin
                    KeyExists := nok_beneficiary_nominee_info.AsArray.Get(Index, nok_beneficiary_nominee);

                    KeyExists := nok_beneficiary_nominee.AsObject.Get('identification_type', nok_beneficiary_nominee_identification_type);
                    KeyExists := nok_beneficiary_nominee.AsObject.Get('identification_value', nok_beneficiary_nominee_identification_value);
                    KeyExists := nok_beneficiary_nominee.AsObject.Get('full_names', nok_beneficiary_nominee_full_names);
                    KeyExists := nok_beneficiary_nominee.AsObject.Get('relationship', nok_beneficiary_nominee_relationship);
                    KeyExists := nok_beneficiary_nominee.AsObject.Get('date_of_birth', nok_beneficiary_nominee_date_of_birth);
                    KeyExists := nok_beneficiary_nominee.AsObject.Get('address', nok_beneficiary_nominee_address);
                    KeyExists := nok_beneficiary_nominee.AsObject.Get('mobile_no', nok_beneficiary_nominee_mobile_no);
                    KeyExists := nok_beneficiary_nominee.AsObject.Get('email_address', nok_beneficiary_nominee_email_address);
                    KeyExists := nok_beneficiary_nominee.AsObject.Get('is_next_of_kin', nok_beneficiary_nominee_is_next_of_kin);
                    KeyExists := nok_beneficiary_nominee.AsObject.Get('is_beneficiary', nok_beneficiary_nominee_is_beneficiary);
                    KeyExists := nok_beneficiary_nominee.AsObject.Get('is_contact_person', nok_beneficiary_nominee_is_contact_person);
                    KeyExists := nok_beneficiary_nominee.AsObject.Get('is_nominee', nok_beneficiary_nominee_is_nominee);
                    KeyExists := nok_beneficiary_nominee.AsObject.Get('allocation', nok_beneficiary_nominee_allocation);

                    NextofKinApplication.Init();

                    NextofKinApplication."Record ID" := NewNo;
                    NextofKinApplication."No." := Index + 1;

                    NextofKinApplication."Identification Type" := "Identification Type".FromInteger(nok_beneficiary_nominee_identification_type.AsValue.AsInteger);
                    NextofKinApplication.Identification := nok_beneficiary_nominee_identification_value.AsValue.AsText;
                    NextofKinApplication.Name := nok_beneficiary_nominee_full_names.AsValue.AsText;
                    NextofKinApplication.Relationship := nok_beneficiary_nominee_relationship.AsValue.AsText;
                    if nok_beneficiary_nominee_date_of_birth.AsValue.AsText <> '' then begin
                        NextofKinApplication."Date of Birth" := nok_beneficiary_nominee_date_of_birth.AsValue.AsDate;
                    end;
                    NextofKinApplication.Address := nok_beneficiary_nominee_address.AsValue.AsText;
                    NextofKinApplication.Telephone := nok_beneficiary_nominee_mobile_no.AsValue.AsText;
                    NextofKinApplication.Email := nok_beneficiary_nominee_email_address.AsValue.AsText;
                    NextofKinApplication."Is Next of Kin" := nok_beneficiary_nominee_is_next_of_kin.AsValue.AsBoolean;
                    NextofKinApplication."Is a Beneficiary" := nok_beneficiary_nominee_is_beneficiary.AsValue.AsBoolean;
                    NextofKinApplication."Is Contact Person" := nok_beneficiary_nominee_is_contact_person.AsValue.AsBoolean;
                    NextofKinApplication."Is Nominee" := nok_beneficiary_nominee_is_nominee.AsValue.AsBoolean;
                    NextofKinApplication.Allocation := nok_beneficiary_nominee_allocation.AsValue.AsDecimal;
                    NextofKinApplication.Deceased := NextofKin.Deceased;
                    NextofKinApplication.Removed := NextofKin.Removed;

                    KeyExists := NextofKinApplication.Insert(true);

                    NextofKinApplication.Reset();
                end;
            end;

            // Next of Kin - Initialize for readmission
            if MemberApplication."Type of Application" = "Type of Application"::Readmission then begin

                NextOfKin.Reset;
                NextOfKin.SetRange("Record ID", MemberApplication."Principle Member");

                if NextOfKin.FindSet then begin
                    repeat begin
                        NextofKinApplication.Init();

                        NextofKinApplication."Record ID" := NewNo;
                        NextofKinApplication."No." := Index + 1;

                        NextofKinApplication."Identification Type" := NextOfKin."Identification Type";
                        NextofKinApplication.Identification := NextOfKin.Identification;
                        NextofKinApplication.Name := NextOfKin.Name;
                        NextofKinApplication.Relationship := NextOfKin.Relationship;
                        NextofKinApplication."Date of Birth" := NextOfKin."Date of Birth";
                        NextofKinApplication.Address := NextofKin.Address;
                        NextofKinApplication.Telephone := NextofKin.Telephone;
                        NextofKinApplication.Email := NextofKin.Email;
                        NextofKinApplication."Is Next of Kin" := NextofKin."Is Next of Kin";
                        NextofKinApplication."Is a Beneficiary" := NextofKin."Is a Beneficiary";
                        NextofKinApplication."Is Contact Person" := NextofKin."Is Contact Person";
                        NextofKinApplication."Is Nominee" := NextofKin."Is Nominee";
                        NextofKinApplication.Allocation := NextofKin.Allocation;

                        KeyExists := NextofKinApplication.Insert(true);

                        NextofKinApplication.Reset();
                    end until NextOfKin.Next = 0;
                end;
            end;

            // EDMS scanned logs
            if MemberApplication."Type of Application" = MemberApplication."Type of Application"::"New Registration" then begin
                EDMSFunctions.EDMSScannedLog(
                    MemberApplication."No.",
                    "CRM Originations"::"Member Application",
                    '',
                    MemberApplication."CRM Created By",
                    MemberApplication."CRM Originating Branch"
                );
            end;

            if MemberApplication."Type of Application" = MemberApplication."Type of Application"::Readmission then begin
                EDMSFunctions.EDMSScannedLog(
                    MemberApplication."No.",
                    "CRM Originations"::"Member Readmission",
                    MemberApplication."Principle Member",
                    MemberApplication."CRM Created By",
                    MemberApplication."CRM Originating Branch"
                );
            end;

            if MemberApplication."Type of Application" = MemberApplication."Type of Application"::Nominee then begin
                EDMSFunctions.EDMSScannedLog(
                    MemberApplication."No.",
                    "CRM Originations"::Nominee,
                    '',
                    MemberApplication."CRM Created By",
                    MemberApplication."CRM Originating Branch"
                );
            end;

            MemberApplication.Reset();

            MemberApplication.SetRange("No.", NewNo);
            ResponseData.Add('application_number', MemberApplication."No.");
            ResponseData.Add('application_status', Format(MemberApplication.Status));

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Membership application with CRM application number ' + MemberApplication."No." + ' has been created successfully.');
            ResponseObject.Add('data', ResponseData);
            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
        end else begin
            // ResponseObject.Add('status', 'ERROR');
            // ResponseObject.Add('description', 'Unable to create membership application.');
            // ResponseObject.Add('errors', Errors);
            // AddDateTimeToResponse(ResponseObject);

            // ResponseObject.WriteTo(Response);

            Error('Unable to create membership application.');
        end;

        exit(Response);
    end;

    local procedure UpdateMemberApplication(Payload: JsonObject): Text
    var
        application_no: JsonToken;
        business_name: JsonToken;
        first_name: JsonToken;
        middle_name: JsonToken;
        other_names: JsonToken;
        current_address: JsonToken;
        permanent_address: JsonToken;
        phone_no: JsonToken;
        transactional_mobile_no: JsonToken;
        employer_code: JsonToken;
        date_of_birth: JsonToken;
        email_address: JsonToken;
        nationality: JsonToken;
        payroll_staff_no: JsonToken;
        primary_identification_type: JsonToken;
        secondary_identification_type: JsonToken;
        religion: JsonToken;
        primary_identification: JsonToken;
        secondary_identification: JsonToken;
        office_telephone_no: JsonToken;
        marital_status: JsonToken;
        _gender: JsonToken;
        terms_of_employment: JsonToken;
        post_code: JsonToken;
        city: JsonToken;
        county: JsonToken;
        sub_county: JsonToken;
        bank_code: JsonToken;
        bank_branch_code: JsonToken;
        bank_account_no: JsonToken;
        company_registration_no: JsonToken;
        kra_pin_number: JsonToken;
        recruited_by_type: JsonToken;
        recruited_by: JsonToken;
        type_of_application: JsonToken;
        principle_member: JsonToken;
        is_self_employed: JsonToken;
        crm_application_no: JsonToken;
        salutation: JsonToken;
        account_profile: JsonToken;
        account_type: JsonToken;
        member_class: JsonToken;
        is_from_another_sacco: JsonToken;
        crm_created_by: JsonToken;
        activity_code: JsonToken;
        branch_code: JsonToken;
        country_of_operation: JsonToken;
        work_station: JsonToken;
        employment_designation: JsonToken;
        delegates_zone: JsonToken;
        date_of_contribution_commencement: JsonToken;
        contribution_amount: JsonToken;
        crm_notes: JsonToken;
        crm_originating_branch: JsonToken;
        year_of_incorporation: JsonToken;
        passport_expiry_date: JsonToken;

        crm_updated_by: JsonToken;
        crm_updating_branch: JsonToken;

        nok_beneficiary_nominee_info: JsonToken;
        nok_beneficiary_nominee: JsonToken;
        nok_beneficiary_nominee_identification_type: JsonToken;
        nok_beneficiary_nominee_identification_value: JsonToken;
        nok_beneficiary_nominee_full_names: JsonToken;
        nok_beneficiary_nominee_relationship: JsonToken;
        nok_beneficiary_nominee_date_of_birth: JsonToken;
        nok_beneficiary_nominee_address: JsonToken;
        nok_beneficiary_nominee_mobile_no: JsonToken;
        nok_beneficiary_nominee_email_address: JsonToken;
        nok_beneficiary_nominee_is_next_of_kin: JsonToken;
        nok_beneficiary_nominee_is_beneficiary: JsonToken;
        nok_beneficiary_nominee_is_contact_person: JsonToken;
        nok_beneficiary_nominee_is_nominee: JsonToken;
        nok_beneficiary_nominee_allocation: JsonToken;
        iprs_verified: JsonToken;

        KeyExists: Boolean;

        MemberApplication: Record "Member Application";
        NextofKinApplication: Record "Next of KIN Application";
        MemberImages: Record "Image Data";
        NextOfKin: Record "Next of Kin";
        Index: Integer;
        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        KeyExists := Payload.Get('application_no', application_no);
        KeyExists := Payload.Get('business_name', business_name);
        KeyExists := Payload.Get('first_name', first_name);
        KeyExists := Payload.Get('middle_name', middle_name);
        KeyExists := Payload.Get('other_names', other_names);
        KeyExists := Payload.Get('current_address', current_address);
        KeyExists := Payload.Get('permanent_address', permanent_address);
        KeyExists := Payload.Get('phone_no', phone_no);
        KeyExists := Payload.Get('transactional_mobile_no', transactional_mobile_no);
        KeyExists := Payload.Get('employer_code', employer_code);
        KeyExists := Payload.Get('date_of_birth', date_of_birth);
        KeyExists := Payload.Get('email_address', email_address);
        KeyExists := Payload.Get('nationality', nationality);
        KeyExists := Payload.Get('payroll_staff_no', payroll_staff_no);
        KeyExists := Payload.Get('primary_identification_type', primary_identification_type);
        KeyExists := Payload.Get('secondary_identification_type', secondary_identification_type);
        KeyExists := Payload.Get('religion', religion);
        KeyExists := Payload.Get('primary_identification', primary_identification);
        KeyExists := Payload.Get('secondary_identification', secondary_identification);
        KeyExists := Payload.Get('office_telephone_no', office_telephone_no);
        KeyExists := Payload.Get('marital_status', marital_status);
        KeyExists := Payload.Get('gender', _gender);
        KeyExists := Payload.Get('terms_of_employment', terms_of_employment);
        KeyExists := Payload.Get('post_code', post_code);
        KeyExists := Payload.Get('city', city);
        KeyExists := Payload.Get('county', county);
        KeyExists := Payload.Get('sub_county', sub_county);
        KeyExists := Payload.Get('bank_code', bank_code);
        KeyExists := Payload.Get('bank_branch_code', bank_branch_code);
        KeyExists := Payload.Get('bank_account_no', bank_account_no);
        KeyExists := Payload.Get('company_registration_no', company_registration_no);
        KeyExists := Payload.Get('kra_pin_number', kra_pin_number);
        KeyExists := Payload.Get('recruited_by_type', recruited_by_type);
        KeyExists := Payload.Get('recruited_by', recruited_by);
        KeyExists := Payload.Get('type_of_application', type_of_application);
        KeyExists := Payload.Get('principle_member', principle_member);
        KeyExists := Payload.Get('is_self_employed', is_self_employed);
        KeyExists := Payload.Get('crm_application_no', crm_application_no);
        KeyExists := Payload.Get('salutation', salutation);
        KeyExists := Payload.Get('account_profile', account_profile);
        KeyExists := Payload.Get('account_type', account_type);
        KeyExists := Payload.Get('member_class', member_class);
        KeyExists := Payload.Get('is_from_another_sacco', is_from_another_sacco);
        KeyExists := Payload.Get('crm_created_by', crm_created_by);
        KeyExists := Payload.Get('branch_code', branch_code);
        KeyExists := Payload.Get('activity_code', activity_code);
        KeyExists := Payload.Get('country_of_operation', country_of_operation);
        KeyExists := Payload.Get('work_station', work_station);
        KeyExists := Payload.Get('employment_designation', employment_designation);
        KeyExists := Payload.Get('delegates_zone', delegates_zone);
        KeyExists := Payload.Get('date_of_contribution_commencement', date_of_contribution_commencement);
        KeyExists := Payload.Get('contribution_amount', contribution_amount);
        KeyExists := Payload.Get('crm_notes', crm_notes);
        KeyExists := Payload.Get('year_of_incorporation', year_of_incorporation);
        KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);
        KeyExists := Payload.Get('passport_expiry_date', passport_expiry_date);
        KeyExists := Payload.Get('nok_beneficiary_nominee_info', nok_beneficiary_nominee_info);

        KeyExists := Payload.Get('crm_updated_by', crm_updated_by);
        KeyExists := Payload.Get('crm_updating_branch', crm_updating_branch);
        KeyExists := Payload.Get('iprs_verified', iprs_verified);

        MemberApplication.Reset;

        MemberApplication.SetRange("No.", application_no.AsValue.AsText);
        MemberApplication.SetRange("Sent Back to CRM", true);

        if MemberApplication.FindFirst then begin
            MemberApplication."Type of Application" := "Type of Application".FromInteger(type_of_application.AsValue.AsInteger);

            MemberApplication."First Name" := first_name.AsValue.AsText;
            MemberApplication."Middle Name" := middle_name.AsValue.AsText;
            MemberApplication."Other Names" := other_names.AsValue.AsText;
            MemberApplication."Home Address" := permanent_address.AsValue.AsText;
            MemberApplication."Current Address" := current_address.AsValue.AsText;
            MemberApplication.Nationality := nationality.AsValue.AsText;
            MemberApplication."Phone No." := phone_no.AsValue.AsText;
            MemberApplication.Validate("Phone No.");
            MemberApplication."Country Of Operation" := country_of_operation.AsValue.AsText;

            if (MemberApplication."Country Of Operation" = 'KE') and (MemberApplication.Nationality = 'KE') then begin
                if (transactional_mobile_no.AsValue.AsText <> '') then begin
                    if GlobalFunctions.ValidateKenyanPhoneNumber(transactional_mobile_no.AsValue.AsText) then begin
                        MemberApplication."Transactional Mobile Number" := transactional_mobile_no.AsValue.AsText;
                        MemberApplication.Validate("Transactional Mobile Number");
                    end else begin
                        Error('Transactional mobile number MUST be in the format of 254xxxxxxxxx');
                    end;
                end;
            end;
            if (transactional_mobile_no.AsValue.AsText = '') then begin
                MemberApplication."Transactional Mobile Number" := '';
            end;

            MemberApplication."Employer Code" := employer_code.AsValue.AsText;
            MemberApplication.Validate("Employer Code");
            MemberApplication."Member Class" := member_class.AsValue.AsText;
            MemberApplication.Validate("Member Class");

            if date_of_birth.AsValue.AsText <> '' then begin
                MemberApplication."Date of Birth" := date_of_birth.AsValue.AsDate;
                MemberApplication.Validate("Date of Birth");
            end;
            MemberApplication."E-Mail" := email_address.AsValue.AsText;
            MemberApplication.Validate("E-Mail");
            MemberApplication."Payroll/Staff No." := payroll_staff_no.AsValue.AsText;
            MemberApplication.Validate("Payroll/Staff No.");
            MemberApplication."Primary Identification Type" := "Identification Type".FromInteger(primary_identification_type.AsValue.AsInteger);
            MemberApplication.Validate("Primary Identification Type");

            MemberApplication."Secondary Identification Type" := "Identification Type".FromInteger(secondary_identification_type.AsValue.AsInteger);
            MemberApplication.Religion := religion.AsValue.AsText;
            MemberApplication."Primary Identification" := primary_identification.AsValue.AsText;
            MemberApplication.Validate("Primary Identification");
            MemberApplication."Secondary Identification" := secondary_identification.AsValue.AsText;
            MemberApplication.Validate("Secondary Identification");

            MemberApplication."Marital Status" := "Marital Status".FromInteger(marital_status.AsValue.AsInteger);
            MemberApplication.Gender := "Gender".FromInteger(_gender.AsValue.AsInteger);
            MemberApplication."Terms of Employment" := "Terms Of Employment".FromInteger(terms_of_employment.AsValue.AsInteger);
            MemberApplication."Post Code" := post_code.AsValue.AsText;
            MemberApplication.City := city.AsValue.AsText;
            MemberApplication.County := county.AsValue.AsText;
            MemberApplication."Sub-County" := sub_county.AsValue.AsText;

            MemberApplication."Bank Code" := bank_code.AsValue.AsText;
            MemberApplication.Validate("Bank Code");
            MemberApplication."Branch Code" := bank_branch_code.AsValue.AsText;
            MemberApplication.Validate("Branch Code");

            MemberApplication."Member Segment" := '';
            MemberApplication."Bank Account No." := bank_account_no.AsValue.AsText;
            MemberApplication."P.I.N Number" := kra_pin_number.AsValue.AsText;
            MemberApplication.Validate("P.I.N Number");

            MemberApplication."Recruited by Type" := "Recruited By".FromInteger(recruited_by_type.AsValue.AsInteger);
            MemberApplication."Recruited By" := recruited_by.AsValue.AsText;
            MemberApplication.Validate("Recruited By");

            // MemberApplication."Allocated Officer" := relationship_manager.AsValue.AsText;
            MemberApplication."Type of Application" := "Type of Application".FromInteger(type_of_application.AsValue.AsInteger);
            IF ((MemberApplication."Type of Application" = "Type of Application"::Readmission) OR (MemberApplication."Type of Application" = "Type of Application"::Nominee)) then begin
                MemberApplication."Principle Member" := principle_member.AsValue.AsText;
                MemberApplication."Old Member No." := principle_member.AsValue.AsText;

                MemberImages.Reset;

                MemberImages.SetRange("Member No", principle_member.AsValue.AsText);

                if MemberImages.FindFirst then begin
                    MemberApplication.Signature := MemberImages.Signature;
                    MemberApplication.Picture := MemberImages.Picture;
                end;
            end;
            MemberApplication."Self Employed" := is_self_employed.AsValue.AsBoolean;
            MemberApplication.Salutation := salutation.AsValue.AsText;
            MemberApplication."Account Profile" := account_profile.AsValue.AsInteger;
            MemberApplication.Validate("Member Class");
            MemberApplication."From Another Sacco" := is_from_another_sacco.AsValue.AsBoolean;
            MemberApplication."Created By" := crm_created_by.AsValue.AsText;
            MemberApplication."Office Telephone No." := office_telephone_no.AsValue.AsText;
            MemberApplication."Country Of Operation" := country_of_operation.AsValue.AsText;
            MemberApplication."Work Station" := work_station.AsValue.AsText;
            MemberApplication."Employment Designation" := employment_designation.AsValue.AsText;
            MemberApplication."Delegates Zone" := delegates_zone.AsValue.AsText;
            MemberApplication.Validate("Delegates Zone");

            // MemberApplication."CRM Application No." := crm_application_no.AsValue.AsText;
            // MemberApplication."CRM Created By" := crm_created_by.AsValue.AsText;
            // MemberApplication."CRM Originating Branch" := crm_originating_branch.AsValue.AsText;
            MemberApplication."CRM Updated By" := crm_updated_by.AsValue.AsText;
            MemberApplication."CRM Updating Branch" := crm_updating_branch.AsValue.AsText;
            MemberApplication."CRM Notes" := crm_notes.AsValue.AsText;

            if date_of_contribution_commencement.AsValue.AsText <> '' then begin
                MemberApplication."Contribution Start Date" := date_of_contribution_commencement.AsValue.AsDate;
                MemberApplication.Validate("Contribution Start Date");
            end;
            if (not contribution_amount.AsValue.IsNull) then begin
                MemberApplication."Contribution Amount" := contribution_amount.AsValue.AsDecimal;
                MemberApplication.Validate("Contribution Amount");
            end else begin
                MemberApplication."Contribution Amount" := 0;
            end;

            MemberApplication.Status := MemberApplication.Status::Open;
            MemberApplication."Account Type" := MemberApplication."Account Type"::"Single Member Account";
            MemberApplication.Validate("Account Type");
            MemberApplication."Responsibility Center" := Format("Responsibility Center Enum"::RECORDS);
            // MemberApplication."Application Date" := DT2Date(CurrentDateTime);
            MemberApplication."Global Dimension 1 Code" := branch_code.AsValue.AsText;
            MemberApplication.Validate("Global Dimension 1 Code");
            MemberApplication."Global Dimension 2 Code" := activity_code.AsValue.AsText;
            // MemberApplication.Validate("Global Dimension 2 Code");

            MemberApplication.Validate("First Name");
            MemberApplication.Validate("Middle Name");
            MemberApplication.Validate("Other Names");

            if date_of_birth.AsValue.AsText <> '' then begin
                MemberApplication."Date of Birth" := date_of_birth.AsValue.AsDate;
            end;

            MemberApplication."Source Aplication" := MemberApplication."Source Aplication"::CRM;
            MemberApplication."Sent Back to CRM" := false;

            if passport_expiry_date.AsValue.AsText <> '' then begin
                MemberApplication."Passport Expiry Date" := passport_expiry_date.AsValue.AsDate;
            end;

            if not iprs_verified.AsValue.IsNull then begin
                MemberApplication."IPRS Verified" := iprs_verified.AsValue.AsBoolean;
            end else begin
                MemberApplication."IPRS Verified" := false;
            end;

            IF MemberApplication.Modify(true) then begin
                // Handle CRM branch assigmnent
                MemberApplication."Global Dimension 1 Code" := GlobalFunctions.GetMainBranchCodeFromCRMOrigination(MemberApplication."CRM Updating Branch");
                MemberApplication.Modify;

                // CRM Comments/Notes
                GlobalFunctions.InsertCommentRecord(
                    MemberApplication."No.",
                    crm_notes.AsValue.AsText,
                    crm_updated_by.AsValue.AsText,
                    MemberApplication."Global Dimension 1 Code",
                    MemberApplication."Global Dimension 2 Code",
                    MemberApplication."Responsibility Center",
                    false
                );

                // Next of Kin, Nominee, BBF
                IF nok_beneficiary_nominee_info.IsArray then begin
                    NextofKinApplication.Reset();

                    NextofKinApplication.SetRange("Record ID", MemberApplication."No.");

                    if NextofKinApplication.FindSet then begin
                        repeat begin
                            KeyExists := NextofKinApplication.Delete(true);
                        end until NextofKinApplication.Next = 0;
                    end;

                    for Index := 0 to (nok_beneficiary_nominee_info.AsArray.Count - 1) do begin
                        KeyExists := nok_beneficiary_nominee_info.AsArray.Get(Index, nok_beneficiary_nominee);

                        KeyExists := nok_beneficiary_nominee.AsObject.Get('identification_type', nok_beneficiary_nominee_identification_type);
                        KeyExists := nok_beneficiary_nominee.AsObject.Get('identification_value', nok_beneficiary_nominee_identification_value);
                        KeyExists := nok_beneficiary_nominee.AsObject.Get('full_names', nok_beneficiary_nominee_full_names);
                        KeyExists := nok_beneficiary_nominee.AsObject.Get('relationship', nok_beneficiary_nominee_relationship);
                        KeyExists := nok_beneficiary_nominee.AsObject.Get('date_of_birth', nok_beneficiary_nominee_date_of_birth);
                        KeyExists := nok_beneficiary_nominee.AsObject.Get('address', nok_beneficiary_nominee_address);
                        KeyExists := nok_beneficiary_nominee.AsObject.Get('mobile_no', nok_beneficiary_nominee_mobile_no);
                        KeyExists := nok_beneficiary_nominee.AsObject.Get('email_address', nok_beneficiary_nominee_email_address);
                        KeyExists := nok_beneficiary_nominee.AsObject.Get('is_next_of_kin', nok_beneficiary_nominee_is_next_of_kin);
                        KeyExists := nok_beneficiary_nominee.AsObject.Get('is_beneficiary', nok_beneficiary_nominee_is_beneficiary);
                        KeyExists := nok_beneficiary_nominee.AsObject.Get('is_contact_person', nok_beneficiary_nominee_is_contact_person);
                        KeyExists := nok_beneficiary_nominee.AsObject.Get('is_nominee', nok_beneficiary_nominee_is_nominee);
                        KeyExists := nok_beneficiary_nominee.AsObject.Get('allocation', nok_beneficiary_nominee_allocation);

                        Clear(NextofKinApplication);
                        NextofKinApplication.Init();

                        NextofKinApplication."Record ID" := MemberApplication."No.";
                        NextofKinApplication."No." := Index + 1;

                        NextofKinApplication."Identification Type" := "Identification Type".FromInteger(nok_beneficiary_nominee_identification_type.AsValue.AsInteger);
                        NextofKinApplication.Identification := nok_beneficiary_nominee_identification_value.AsValue.AsText;
                        NextofKinApplication.Name := nok_beneficiary_nominee_full_names.AsValue.AsText;
                        NextofKinApplication.Relationship := nok_beneficiary_nominee_relationship.AsValue.AsText;
                        if nok_beneficiary_nominee_date_of_birth.AsValue.AsText <> '' then begin
                            NextofKinApplication."Date of Birth" := nok_beneficiary_nominee_date_of_birth.AsValue.AsDate;
                        end;
                        NextofKinApplication.Address := nok_beneficiary_nominee_address.AsValue.AsText;
                        NextofKinApplication.Telephone := nok_beneficiary_nominee_mobile_no.AsValue.AsText;
                        NextofKinApplication.Email := nok_beneficiary_nominee_email_address.AsValue.AsText;
                        NextofKinApplication."Is Next of Kin" := nok_beneficiary_nominee_is_next_of_kin.AsValue.AsBoolean;
                        NextofKinApplication."Is a Beneficiary" := nok_beneficiary_nominee_is_beneficiary.AsValue.AsBoolean;
                        NextofKinApplication."Is Contact Person" := nok_beneficiary_nominee_is_contact_person.AsValue.AsBoolean;
                        NextofKinApplication."Is Nominee" := nok_beneficiary_nominee_is_nominee.AsValue.AsBoolean;
                        NextofKinApplication.Allocation := nok_beneficiary_nominee_allocation.AsValue.AsDecimal;
                        NextofKinApplication.Deceased := NextofKin.Deceased;
                        NextofKinApplication.Removed := NextofKin.Removed;

                        KeyExists := NextofKinApplication.Insert(true);

                        NextofKinApplication.Reset();
                    end;
                end;

                // Next of Kin - Initialize for readmission
                if MemberApplication."Type of Application" = "Type of Application"::Readmission then begin

                    NextOfKin.Reset;
                    NextOfKin.SetRange("Record ID", MemberApplication."Principle Member");

                    if NextOfKin.FindSet then begin
                        repeat begin
                            NextofKinApplication.Init();

                            NextofKinApplication."Record ID" := MemberApplication."No.";
                            NextofKinApplication."No." := Index + 1;

                            NextofKinApplication."Identification Type" := NextOfKin."Identification Type";
                            NextofKinApplication.Identification := NextOfKin.Identification;
                            NextofKinApplication.Name := NextOfKin.Name;
                            NextofKinApplication.Relationship := NextOfKin.Relationship;
                            NextofKinApplication."Date of Birth" := NextOfKin."Date of Birth";
                            NextofKinApplication.Address := NextofKin.Address;
                            NextofKinApplication.Telephone := NextofKin.Telephone;
                            NextofKinApplication.Email := NextofKin.Email;
                            NextofKinApplication."Is Next of Kin" := NextofKin."Is Next of Kin";
                            NextofKinApplication."Is a Beneficiary" := NextofKin."Is a Beneficiary";
                            NextofKinApplication."Is Contact Person" := NextofKin."Is Contact Person";
                            NextofKinApplication."Is Nominee" := NextofKin."Is Nominee";
                            NextofKinApplication.Allocation := NextofKin.Allocation;

                            KeyExists := NextofKinApplication.Insert(true);

                            NextofKinApplication.Reset();
                        end until NextOfKin.Next = 0;
                    end;
                end;

                MemberApplication.Reset();

                ResponseData.Add('application_number', MemberApplication."No.");
                ResponseData.Add('application_status', Format(MemberApplication.Status));

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('description', 'Membership application with CRM application number ' + MemberApplication."No." + ' has been updated successfully.');
                ResponseObject.Add('data', ResponseData);
                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
            end else begin
                // ResponseObject.Add('status', 'ERROR');
                // ResponseObject.Add('description', 'Unable to create membership application.');
                // ResponseObject.Add('errors', Errors);
                // AddDateTimeToResponse(ResponseObject);

                // ResponseObject.WriteTo(Response);

                Error('Unable to update membership application.');
            end;
        end else begin
            Error('Membership application with number %1 NOT available for CRM editing.', application_no.AsValue.AsText);

        end;

        exit(Response);
    end;

    local procedure GetMemberApplications(Payload: JsonObject): Text
    var
        filter_property: JsonToken;
        filter_value: JsonToken;
        start_date: JsonToken;
        end_date: JsonToken;
        page_number: JsonToken;
        page_size: JsonToken;
        crm_branch: JsonToken;

        KeyExists: Boolean;

        MemberApplications: Record "Member Application";
        Country: Record "Country/Region";

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;
        Count: Integer;
        FirstRow: Integer;
        LastRow: Integer;
        TotalFoundRecords: Integer;
        SearchString: Text;

        SLA: record "Defined SLA";
        Comment: record Comments;

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        Durationuptonow: Duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        KeyExists := Payload.Get('filter_property', filter_property);
        KeyExists := Payload.Get('filter_value', filter_value);
        KeyExists := Payload.Get('start_date', start_date);
        KeyExists := Payload.Get('end_date', end_date);
        KeyExists := Payload.Get('crm_branch', crm_branch);
        Payload.Get('page_number', page_number);
        Payload.Get('page_size', page_size);

        MemberApplications.Reset;
        MemberApplications.SetCurrentKey("Application Date");
        MemberApplications.SetAscending("Application Date", false);

        if KeyExists then begin
            if (crm_branch.AsValue.AsText <> 'ALL') then begin
                MemberApplications.SetRange(MemberApplications."CRM Originating Branch", crm_branch.AsValue.AsText);
            end;
        end;

        // Search Value
        if (not filter_property.AsValue.IsNull) and (not filter_value.AsValue.IsNull) then begin
            if (filter_property.AsValue.AsText <> '') and (filter_value.AsValue.AsText <> '') then begin
                SearchString := filter_value.AsValue.AsText;

                case filter_property.AsValue.AsText of
                    'application_no':
                        MemberApplications.SetRange(MemberApplications."No.", SearchString);
                    'crm_application_no':
                        MemberApplications.SetRange(MemberApplications."CRM Application No.", SearchString);
                    'name':
                        MemberApplications.SetRange(MemberApplications.Name, SearchString);
                    'email':
                        MemberApplications.SetRange(MemberApplications."E-Mail", SearchString);
                    'phone_no':
                        MemberApplications.SetRange(MemberApplications."Phone No.", SearchString);
                    'id_number':
                        begin
                            MemberApplications.SetRange("Primary Identification Type", MemberApplications."Primary Identification Type"::"ID Number");
                            MemberApplications.SetRange("Primary Identification", SearchString);

                            if not MemberApplications.FindFirst then begin
                                MemberApplications.Reset;
                                MemberApplications.SetRange("Secondary Identification Type", MemberApplications."Secondary Identification Type"::"ID Number");
                                MemberApplications.SetRange("Secondary Identification", SearchString);
                            end;
                        end;
                    'passport_number':
                        begin
                            MemberApplications.SetRange("Primary Identification Type", MemberApplications."Primary Identification Type"::"Passport No");
                            MemberApplications.SetRange("Primary Identification", SearchString);

                            if not MemberApplications.FindFirst then begin
                                MemberApplications.Reset;
                                MemberApplications.SetRange("Secondary Identification Type", MemberApplications."Secondary Identification Type"::"Passport No");
                                MemberApplications.SetRange("Secondary Identification", SearchString);
                            end;
                        end;
                    'birth_certificate_number':
                        begin
                            MemberApplications.SetRange("Primary Identification Type", MemberApplications."Primary Identification Type"::"Birth Certificate Number");
                            MemberApplications.SetRange("Primary Identification", SearchString);

                            if not MemberApplications.FindFirst then begin
                                MemberApplications.Reset;
                                MemberApplications.SetRange("Secondary Identification Type", MemberApplications."Secondary Identification Type"::"Birth Certificate Number");
                                MemberApplications.SetRange("Secondary Identification", SearchString);
                            end;
                        end;
                    'status':
                        MemberApplications.SetFilter(MemberApplications.Status, SearchString);
                    'kra_pin_number':
                        MemberApplications.SetRange(MemberApplications."P.I.N Number", SearchString);

                    'type_of_application_desc':
                        MemberApplications.SetFilter(MemberApplications."Type of Application", SearchString);
                    'type_of_application':
                        MemberApplications.SetFilter(MemberApplications."Type of Application", SearchString);
                    'source_of_application_desc':
                        MemberApplications.SetFilter(MemberApplications."Source Aplication", SearchString);
                    'source_of_application':
                        MemberApplications.SetFilter(MemberApplications."Source Aplication", SearchString);
                    'member_number':
                        MemberApplications.SetFilter(MemberApplications."Member No.", SearchString);
                    else
                        MemberApplications.SetRange(MemberApplications."No.", SearchString);
                end;
            end;
        end;

        // Start Date & End Date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));

                MemberApplications.SetFilter("Application Date", '>=%1&<=%2', StartDate, EndDate);
            end;
        end;

        MemberApplications.SetRange("Account Type", MemberApplications."Account Type"::"Single Member Account");
        MemberApplications.SetFilter(
            "Source Aplication",
            '=%1|%2|%3',
            MemberApplications."Source Aplication"::CRM,
            MemberApplications."Source Aplication"::"CRM - Sales"
        // MemberApplications."Source Aplication"::"Mwalimu Smart"
        );

        IF MemberApplications.FindSet then begin
            // Applications found
            Count := 0;
            FirstRow := ((page_number.AsValue.AsInteger - 1) * page_size.AsValue.AsInteger) + 1;
            LastRow := page_number.AsValue.AsInteger * page_size.AsValue.AsInteger;

            TotalFoundRecords := MemberApplications.Count;

            repeat begin
                Count += 1;

                if (Count >= FirstRow) and (Count <= LastRow) then begin
                    MemberApplications.CalcFields("Responsible Officer", "Supervisor ID");

                    Datum.Add('application_no', MemberApplications."No.");
                    Datum.Add('crm_application_no', MemberApplications."CRM Application No.");
                    Datum.Add('name', MemberApplications.Name);
                    Datum.Add('email', MemberApplications."E-Mail");
                    Datum.Add('type_of_application', MemberApplications."Type of Application".AsInteger);
                    Datum.Add('type_of_application_desc', Format(MemberApplications."Type of Application"));
                    Datum.Add('source_of_application', MemberApplications."Source Aplication");
                    Datum.Add('source_of_application_desc', Format(MemberApplications."Source Aplication"));
                    Datum.Add('application_date', MemberApplications."Application Date");
                    Datum.Add('primary_identification_type', Format(MemberApplications."Primary Identification Type"));
                    Datum.Add('primary_identification', MemberApplications."Primary Identification");
                    Datum.Add('secondary_identification_type', Format(MemberApplications."Secondary Identification Type"));
                    Datum.Add('secondary_identification', MemberApplications."Secondary Identification");
                    Datum.Add('kra_pin_number', MemberApplications."P.I.N Number");
                    Datum.Add('phone_no', MemberApplications."Phone No.");
                    Datum.Add('crm_created_by', MemberApplications."CRM Created By");
                    Datum.Add('crm_originating_branch', MemberApplications."CRM Originating Branch");
                    Datum.Add('responsible_officer', MemberApplications."Responsible Officer");
                    Datum.Add('supervisor_id', MemberApplications."Supervisor ID");
                    Datum.Add('status', Format(MemberApplications.Status));
                    Datum.Add('is_sent_back_to_crm', MemberApplications."Sent Back to CRM");
                    Datum.Add('iprs_verified', MemberApplications."IPRS Verified");

                    Datum.Add('nationality', MemberApplications.Nationality);
                    Country.Reset;
                    Country.SetRange(Code, MemberApplications.Nationality);
                    Country.SetLoadFields(Name);
                    if Country.FindFirst then begin
                        Datum.Add('nationality_desc', Country.Name);
                    end else begin
                        Datum.Add('nationality_desc', '');
                    end;

                    // SLA
                    WorkDays := 0;
                    SLADays := 0;
                    DelayDays := 0;
                    Durationuptonow := 0;
                    StatusComment := '';

                    SLA.reset();

                    case MemberApplications."Type of Application" of
                        MemberApplications."Type of Application"::Readmission:
                            SLA.SetRange("Origination Type", SLA."Origination Type"::"Member Readmission");
                        else
                            SLA.SetRange("Origination Type", SLA."Origination Type"::"New Registration");
                    end;


                    if SLA.findfirst() then
                        SLADays := SLA.SLA;

                    if (MemberApplications."Date Approved" <> 0D) and (MemberApplications."Application Date" <> 0D) and (MemberApplications."Application Time" <> 0T) and (MemberApplications."Approval Time" <> 0T) then begin
                        GlobalFunctions.HoursBetweenPeriods(MemberApplications."Application Date", MemberApplications."Application Time", MemberApplications."Date Approved", MemberApplications."Approval Time", Duration, WokedOnANonWorkingPeriod);
                        WorkDays := Duration;
                        DelayDays := WorkDays - (SLADays / 3);
                        IF DelayDays < 0 then DelayDays := 0;
                    end;
                    if MemberApplications."Application Date Time" <> 0DT then begin
                        Durationuptonow := CurrentDateTime - MemberApplications."Application Date Time";
                    end;

                    Comment.reset();
                    Comment.SetRange("Header No.", MemberApplications."No.");
                    If Comment.FindLast() then begin
                        StatusComment := Comment.Comment;
                    end;

                    Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
                    Datum.Add('SLA_days', Format(SLADays));
                    Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
                    Datum.Add('tat_status', Format(TAtStatus));
                    Datum.Add('duration_uptonow', Format(Durationuptonow));
                    Datum.Add('status_comment', StatusComment);
                    Datum.Add('priority', Format(Priority));

                    Data.Add(Datum);
                    // Reset
                    Datum.ReadFrom('{}');
                end;
            end until (Count = LastRow) or (MemberApplications.Next = 0);

            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberApplication(Payload: JsonObject): Text
    var
        application_number: JsonToken;

        SearchMember: Record "Member Application";
        ApplicationComments: Record Comments;
        BankCode: Record "Bank Code Structure";
        ElectoralZone: Record "Electoral Zones";
        Country: Record "Country/Region";
        County: Record "Segment/County/Dividend/Signat";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Comments: JsonArray;
        Comment: JsonObject;
        Response: Text;
    begin
        Payload.Get('application_number', application_number);

        SearchMember.Reset;
        SearchMember.SetRange("No.", application_number.AsValue.AsText);

        IF SearchMember.FindFirst() then begin
            SearchMember.CalcFields(
                "Supervisor ID",
                "Responsible Officer",
                "Employer Name",
                "Branch Name",
                "Activity Name");

            Datum.Add('application_no', SearchMember."No.");

            SearchMember.CalcFields("Member No.");
            Datum.Add('member_no', SearchMember."Member No.");

            Datum.Add('salutation', SearchMember.Salutation);
            Datum.Add('name', SearchMember.Name);
            Datum.Add('first_name', SearchMember."First Name");
            Datum.Add('middle_name', SearchMember."Middle Name");
            Datum.Add('other_names', SearchMember."Other Names");
            Datum.Add('primary_identification_type', SearchMember."Primary Identification Type".AsInteger);
            Datum.Add('primary_identification_type_desc', Format(SearchMember."Primary Identification Type"));
            Datum.Add('primary_identification', SearchMember."Primary Identification");
            Datum.Add('secondary_identification_type', SearchMember."Secondary Identification Type".AsInteger);
            Datum.Add('secondary_identification_type_desc', Format(SearchMember."Secondary Identification Type"));
            Datum.Add('secondary_identification', SearchMember."Secondary Identification");
            Datum.Add('passport_expiry_date', SearchMember."Passport Expiry Date");
            Datum.Add('current_address', SearchMember."Current Address");
            Datum.Add('home_address', SearchMember."Home Address");
            Datum.Add('phone_number', SearchMember."Phone No.");
            Datum.Add('transactional_mobile_no', SearchMember."Transactional Mobile Number");
            Datum.Add('office_telephone_number', SearchMember."Office Telephone No.");
            Datum.Add('email_address', SearchMember."E-Mail");
            Datum.Add('kra_pin_number', SearchMember."P.I.N Number");
            Datum.Add('payroll_staff_number', SearchMember."Payroll/Staff No.");
            Datum.Add('currency_code', SearchMember."Currency Code");
            Datum.Add('date_of_birth', GlobalFunctions.FormatISODate(SearchMember."Date of Birth"));
            Datum.Add('marital_status', SearchMember."Marital Status".AsInteger);
            Datum.Add('marital_status_desc', Format(SearchMember."Marital Status"));
            Datum.Add('gender', SearchMember.Gender.AsInteger);
            Datum.Add('gender_desc', Format(SearchMember.Gender));
            Datum.Add('post_code', SearchMember."Post Code");
            Datum.Add('status', SearchMember.Status.AsInteger);
            Datum.Add('status_desc', Format(SearchMember.Status));
            Datum.Add('is_self_employed', SearchMember."Self Employed");
            Datum.Add('employer_code', SearchMember."Employer Code");
            Datum.Add('employer_name', SearchMember."Employer Name");
            Datum.Add('employment_designation', SearchMember."Employment Designation");
            Datum.Add('terms_of_employment', SearchMember."Terms of Employment".AsInteger);
            Datum.Add('terms_of_employment_desc', Format(SearchMember."Terms of Employment"));

            Datum.Add('county', SearchMember.County);
            County.Reset;
            County.SetRange(Code, SearchMember.County);
            County.SetRange(Type, County.Type::County);
            if County.FindFirst then begin
                Datum.Add('county_desc', County.Description);
            end else begin
                Datum.Add('county_desc', '');
            end;

            Datum.Add('sub_county', SearchMember."Sub-County");
            County.Reset;
            County.SetRange(Code, SearchMember."Sub-County");
            County.SetRange(Type, County.Type::"Sub-County");
            if County.FindFirst then begin
                Datum.Add('sub_county_desc', County.Description);
            end else begin
                Datum.Add('sub_county_desc', '');
            end;


            Datum.Add('city', SearchMember.City);
            Datum.Add('work_station', SearchMember."Work Station");

            Datum.Add('country_of_operation', SearchMember."Country Of Operation");

            Country.Reset;
            Country.SetRange(Code, SearchMember."Country Of Operation");
            if Country.FindFirst then begin
                Datum.Add('country_of_operation_desc', Country.Name);
            end else begin
                Datum.Add('country_of_operation_desc', '');
            end;

            Datum.Add('nationality', SearchMember.Nationality);
            Country.Reset;
            Country.SetRange(Code, SearchMember.Nationality);
            Country.SetLoadFields(Name);
            if Country.FindFirst then begin
                Datum.Add('nationality_desc', Country.Name);
            end else begin
                Datum.Add('nationality_desc', '');
            end;

            Datum.Add('group_account_no', SearchMember."Group Account No.");
            Datum.Add('type_of_application', SearchMember."Type of Application".AsInteger);
            Datum.Add('type_of_application_desc', Format(SearchMember."Type of Application"));
            Datum.Add('member_class', SearchMember."Member Class");
            Datum.Add('account_type', SearchMember."Account Type");
            Datum.Add('account_type_desc', Format(SearchMember."Account Type"));
            Datum.Add('account_profile', SearchMember."Account Profile");
            Datum.Add('account_profile_desc', Format(SearchMember."Account Profile"));
            Datum.Add('religion', SearchMember.Religion);
            Datum.Add('created_by', SearchMember."Created By");

            Datum.Add('bank_code', SearchMember."Bank Code");

            BankCode.Reset;
            BankCode.SetRange("Parent Code", '');
            BankCode.SetRange(Code, SearchMember."Bank Code");
            if BankCode.FindFirst then begin
                Datum.Add('bank_code_desc', BankCode.Name);
            end else begin
                Datum.Add('bank_code_desc', '');
            end;

            // -----------------------------------------------

            Datum.Add('bank_branch_code', SearchMember."Branch Code");

            BankCode.Reset;
            BankCode.SetRange("Parent Code", SearchMember."Bank Code");
            BankCode.SetRange(Code, SearchMember."Branch Code");
            if BankCode.FindFirst then begin
                Datum.Add('bank_branch_code_desc', BankCode.Name);
            end else begin
                Datum.Add('bank_branch_code_desc', '');
            end;

            Datum.Add('bank_account_no', SearchMember."Bank Account No.");
            Datum.Add('is_from_another_sacco', SearchMember."From Another Sacco");
            Datum.Add('old_member_no', SearchMember."Old Member No.");
            Datum.Add('principle_member', SearchMember."Principle Member");
            Datum.Add('recruited_by_type', SearchMember."Recruited By Type".AsInteger);
            Datum.Add('recruited_by_type_desc', Format(SearchMember."Recruited By Type"));
            Datum.Add('recruited_by', SearchMember."Recruited By");
            Datum.Add('recruited_by_name', SearchMember."Recruited By Name");

            Datum.Add('delegate_zone', SearchMember."Delegates Zone");

            ElectoralZone.Reset;
            ElectoralZone.SetRange(Code, SearchMember."Delegates Zone");

            if ElectoralZone.FindFirst then begin
                Datum.Add('delegate_zone_desc', ElectoralZone."Electoral Zone Name");
            end else begin
                Datum.Add('delegate_zone_desc', '');
            end;

            Datum.Add('crm_application_no', SearchMember."CRM Application No.");
            Datum.Add('crm_created_by', SearchMember."CRM Created By");
            Datum.Add('crm_originating_branch', SearchMember."CRM Originating Branch");
            Datum.Add('crm_updated_by', SearchMember."CRM Updated By");
            Datum.Add('crm_updating_branch', SearchMember."CRM Updating Branch");
            Datum.Add('crm_notes', SearchMember."CRM Notes");
            Datum.Add('company_registration_no', SearchMember."Company Registration No.");
            Datum.Add('responsible_officer', SearchMember."Responsible Officer");
            Datum.Add('supervisor_id', SearchMember."Supervisor ID");
            Datum.Add('allocated_officer', SearchMember."Allocated Officer");
            Datum.Add('allocated_officer_name', SearchMember."Allocated Officer Name");
            Datum.Add('branch_code', SearchMember."Global Dimension 1 Code");
            Datum.Add('branch_name', SearchMember."Branch Name");
            Datum.Add('activity_code', SearchMember."Global Dimension 2 Code");
            Datum.Add('activity_name', SearchMember."Activity Name");
            Datum.Add('is_sent_back_to_crm', SearchMember."Sent Back to CRM");
            Datum.Add('date_of_contribution_commencement', SearchMember."Contribution Start Date");
            Datum.Add('contribution_amount', SearchMember."Contribution Amount");
            Datum.Add('permanent_address', SearchMember."Home Address");
            Datum.Add('source_of_application', SearchMember."Source Aplication");
            Datum.Add('source_of_application_desc', Format(SearchMember."Source Aplication"));
            Datum.Add('crm_lead_ref_no', SearchMember."CRM Lead Ref. No");
            Datum.Add('iprs_verified', SearchMember."IPRS Verified");

            // 2. BC approver user + datetime...

            ApplicationComments.Reset;

            ApplicationComments.SetRange("Header No.", SearchMember."No.");
            ApplicationComments.SetCurrentKey("Entry No.");
            ApplicationComments.SetAscending("Entry No.", false);

            if ApplicationComments.FindSet then begin
                repeat begin
                    Comment.Add('comment', ApplicationComments.Comment);
                    Comment.Add('commented_by', ApplicationComments."Commented By");
                    Comment.Add('date_time', GlobalFunctions.FormatISODateTime(ApplicationComments.Date));
                    Comment.Add('is_read', ApplicationComments."Viewd By Somebody Else");

                    Comments.Add(Comment);

                    // Reset
                    Comment.ReadFrom('{}');
                end until ApplicationComments.Next = 0;
            end;

            Datum.Add('comments', Comments);

            Datum.Add('created_at', SearchMember.SystemCreatedAt);
            Datum.Add('modified_at', SearchMember.SystemModifiedAt);
        end else begin
            Error('Member application with number %1 NOT found.', application_number.AsValue.AsText);
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    // TODO: Enhance
    // local procedure EditMemberBiodataApplication(Payload: JsonObject): Text
    // var
    //     member_number: JsonToken;
    //     business_name: JsonToken;
    //     first_name: JsonToken;
    //     middle_name: JsonToken;
    //     other_names: JsonToken;
    //     current_address: JsonToken;
    //     permanent_address: JsonToken;
    //     phone_no: JsonToken;
    //     employer_code: JsonToken;
    //     date_of_birth: JsonToken;
    //     email_address: JsonToken;
    //     nationality: JsonToken;
    //     payroll_staff_no: JsonToken;
    //     primary_identification_type: JsonToken;
    //     secondary_identification_type: JsonToken;
    //     religion: JsonToken;
    //     primary_identification: JsonToken;
    //     secondary_identification: JsonToken;
    //     office_telephone_no: JsonToken;
    //     marital_status: JsonToken;
    //     _gender: JsonToken;
    //     terms_of_employment: JsonToken;
    //     post_code: JsonToken;
    //     city: JsonToken;
    //     county: JsonToken;
    //     bank_code: JsonToken;
    //     bank_branch_code: JsonToken;
    //     member_segment: JsonToken;
    //     bank_account_no: JsonToken;
    //     company_registration_no: JsonToken;
    //     kra_pin_number: JsonToken;
    //     group_account_no: JsonToken;
    //     recruited_by_type: JsonToken;
    //     recruited_by: JsonToken;
    //     relationship_manager: JsonToken;
    //     type_of_application: JsonToken;
    //     principle_member: JsonToken;
    //     is_self_employed: JsonToken;
    //     crm_application_no: JsonToken;
    //     salutation: JsonToken;
    //     account_profile: JsonToken;
    //     account_type: JsonToken;
    //     member_class: JsonToken;
    //     is_from_another_sacco: JsonToken;
    //     crm_created_by: JsonToken;
    //     activity_code: JsonToken;
    //     branch_code: JsonToken;
    //     country_of_operation: JsonToken;
    //     work_station: JsonToken;
    //     employment_designation: JsonToken;
    //     delegates_zone: JsonToken;
    //     preferred_fosa_branch: JsonToken;
    //     date_of_contribution_commencement: JsonToken;
    //     crm_notes: JsonToken;
    //     crm_originating_branch: JsonToken;
    //     year_of_incorporation: JsonToken;

    //     KeyExists: Boolean;

    //     SeriesSetup: Record "Credit Nos. Series";
    //     NoSeriesMgt: Codeunit NoSeriesManagement;
    //     NewNo: Code[20];
    //     NewNoSeriesCode: Code[20];

    //     EditMember: Record Members;
    //     MemberTable: Record Members;
    //     TmpMemberTable: Record Members temporary;

    //     SystemEdits: Record "System Edits";
    //     SystemEditsCodeunit: Codeunit "System Editss";
    //     Action: Option SetFilter,PostChanges;
    //     RecRef: RecordRef;
    //     NewRecRef: RecordRef;

    //     ResponseObject: JsonObject;
    //     ResponseData: JsonObject;
    //     Errors: JsonArray;
    //     Response: Text;
    // begin
    //     KeyExists := Payload.Get('member_number', member_number);
    //     KeyExists := Payload.Get('business_name', business_name);
    //     KeyExists := Payload.Get('first_name', first_name);
    //     KeyExists := Payload.Get('middle_name', middle_name);
    //     KeyExists := Payload.Get('other_names', other_names);
    //     KeyExists := Payload.Get('current_address', current_address);
    //     KeyExists := Payload.Get('permanent_address', permanent_address);
    //     KeyExists := Payload.Get('phone_no', phone_no);
    //     KeyExists := Payload.Get('employer_code', employer_code);
    //     KeyExists := Payload.Get('date_of_birth', date_of_birth);
    //     KeyExists := Payload.Get('email_address', email_address);
    //     KeyExists := Payload.Get('nationality', nationality);
    //     KeyExists := Payload.Get('payroll_staff_no', payroll_staff_no);
    //     KeyExists := Payload.Get('primary_identification_type', primary_identification_type);
    //     KeyExists := Payload.Get('secondary_identification_type', secondary_identification_type);
    //     KeyExists := Payload.Get('religion', religion);
    //     KeyExists := Payload.Get('primary_identification', primary_identification);
    //     KeyExists := Payload.Get('secondary_identification', secondary_identification);
    //     KeyExists := Payload.Get('office_telephone_no', office_telephone_no);
    //     KeyExists := Payload.Get('marital_status', marital_status);
    //     KeyExists := Payload.Get('gender', _gender);
    //     KeyExists := Payload.Get('terms_of_employment', terms_of_employment);
    //     KeyExists := Payload.Get('post_code', post_code);
    //     KeyExists := Payload.Get('city', city);
    //     KeyExists := Payload.Get('county', county);
    //     KeyExists := Payload.Get('bank_code', bank_code);
    //     KeyExists := Payload.Get('bank_branch_code', bank_branch_code);
    //     KeyExists := Payload.Get('member_segment', member_segment);
    //     KeyExists := Payload.Get('bank_account_no', bank_account_no);
    //     KeyExists := Payload.Get('company_registration_no', company_registration_no);
    //     KeyExists := Payload.Get('kra_pin_number', kra_pin_number);
    //     KeyExists := Payload.Get('group_account_no', group_account_no);
    //     KeyExists := Payload.Get('recruited_by_type', recruited_by_type);
    //     KeyExists := Payload.Get('recruited_by', recruited_by);
    //     KeyExists := Payload.Get('relationship_manager', relationship_manager);
    //     KeyExists := Payload.Get('type_of_application', type_of_application);
    //     KeyExists := Payload.Get('principle_member', principle_member);
    //     KeyExists := Payload.Get('is_self_employed', is_self_employed);
    //     KeyExists := Payload.Get('crm_application_no', crm_application_no);
    //     KeyExists := Payload.Get('salutation', salutation);
    //     KeyExists := Payload.Get('account_profile', account_profile);
    //     KeyExists := Payload.Get('account_type', account_type);
    //     KeyExists := Payload.Get('member_class', member_class);
    //     KeyExists := Payload.Get('is_from_another_sacco', is_from_another_sacco);
    //     KeyExists := Payload.Get('crm_created_by', crm_created_by);
    //     KeyExists := Payload.Get('branch_code', branch_code);
    //     KeyExists := Payload.Get('activity_code', activity_code);
    //     KeyExists := Payload.Get('country_of_operation', country_of_operation);
    //     KeyExists := Payload.Get('work_station', work_station);
    //     KeyExists := Payload.Get('employment_designation', employment_designation);
    //     KeyExists := Payload.Get('delegates_zone', delegates_zone);
    //     KeyExists := Payload.Get('preferred_fosa_branch', preferred_fosa_branch);
    //     KeyExists := Payload.Get('date_of_contribution_commencement', date_of_contribution_commencement);
    //     KeyExists := Payload.Get('crm_notes', crm_notes);
    //     KeyExists := Payload.Get('year_of_incorporation', year_of_incorporation);
    //     KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);

    //     EditMember.Reset();

    //     EditMember.SetRange("No.", member_number.asValue.AsText);

    //     IF EditMember.FindFirst then begin
    //         SystemEdits.Init;

    //         SystemEdits."Table ID" := database::Members;
    //         SystemEdits.Validate("Table ID");

    //         SystemEdits.Comments := crm_notes.AsValue.AsText;
    //         SystemEdits.Status := SystemEdits.Status::Open;

    //         IF SystemEdits.Insert(true) then begin
    //             // Filters
    //             SystemEditsCodeunit.SetFilters(SystemEdits."Table ID", SystemEdits."No.", false, EditMember."No.");

    //             TmpMemberTable.Init();

    //             IF EditMember."Account Type" = EditMember."Account Type"::"Single Member Account" then begin
    //                 // Individual
    //                 TmpMemberTable."First Name" := first_name.AsValue.AsText;
    //                 TmpMemberTable."Middle Name" := middle_name.AsValue.AsText;
    //                 TmpMemberTable."Other Names" := other_names.AsValue.AsText;
    //                 TmpMemberTable."Home Address" := permanent_address.AsValue.AsText;
    //                 TmpMemberTable."Current Address" := current_address.AsValue.AsText;
    //                 TmpMemberTable."Phone No." := phone_no.AsValue.AsText;
    //                 TmpMemberTable."Employer Code" := employer_code.AsValue.AsText;
    //                 if date_of_birth.AsValue.AsText <> '' then begin
    //                     TmpMemberTable."Date of Birth" := date_of_birth.AsValue.AsDate;
    //                 end;
    //                 TmpMemberTable."E-Mail" := email_address.AsValue.AsText;
    //                 TmpMemberTable.Nationality := nationality.AsValue.AsText;
    //                 TmpMemberTable."Payroll/Staff No." := payroll_staff_no.AsValue.AsText;
    //                 TmpMemberTable."Primary Identification Type" := "Identification Type".FromInteger(primary_identification_type.AsValue.AsInteger);
    //                 TmpMemberTable."Secondary Identification Type" := "Identification Type".FromInteger(secondary_identification_type.AsValue.AsInteger);
    //                 TmpMemberTable.Religion := religion.AsValue.AsText;
    //                 TmpMemberTable."Primary Identification" := primary_identification.AsValue.AsText;
    //                 TmpMemberTable."Secondary Identification" := secondary_identification.AsValue.AsText;
    //                 TmpMemberTable."Marital Status" := "Marital Status".FromInteger(marital_status.AsValue.AsInteger);
    //                 TmpMemberTable.Gender := "Gender".FromInteger(_gender.AsValue.AsInteger);
    //                 TmpMemberTable."Terms of Employment" := "Terms Of Employment".FromInteger(terms_of_employment.AsValue.AsInteger);
    //                 TmpMemberTable."Post Code" := post_code.AsValue.AsText;
    //                 TmpMemberTable.City := city.AsValue.AsText;
    //                 TmpMemberTable.County := county.AsValue.AsText;
    //                 TmpMemberTable."Bank Code" := bank_code.AsValue.AsText;
    //                 TmpMemberTable."Branch Code" := bank_branch_code.AsValue.AsText;
    //                 TmpMemberTable."Member Segment" := '';
    //                 TmpMemberTable."Bank Account No." := bank_account_no.AsValue.AsText;
    //                 TmpMemberTable."P.I.N Number" := kra_pin_number.AsValue.AsText;
    //                 TmpMemberTable."Recruited by Type" := "Recruited By".FromInteger(recruited_by_type.AsValue.AsInteger);
    //                 TmpMemberTable."Recruited By" := recruited_by.AsValue.AsText;
    //                 TmpMemberTable."Allocated Officer" := relationship_manager.AsValue.AsText;
    //                 TmpMemberTable."Type of Application" := "Type of Application".FromInteger(type_of_application.AsValue.AsInteger);
    //                 IF TmpMemberTable."Type of Application" = "Type of Application"::Readmission then begin
    //                     TmpMemberTable."Principle Member" := principle_member.AsValue.AsText;
    //                     TmpMemberTable."Old Member No." := principle_member.AsValue.AsText;
    //                 end;
    //                 TmpMemberTable."Self Employed" := is_self_employed.AsValue.AsBoolean;
    //                 TmpMemberTable."CRM Application No." := crm_application_no.AsValue.AsText;
    //                 TmpMemberTable.Salutation := salutation.AsValue.AsText;
    //                 TmpMemberTable."Account Profile" := account_profile.AsValue.AsInteger;
    //                 TmpMemberTable."Member Class" := member_class.AsValue.AsText;
    //                 TmpMemberTable."From Another Sacco" := is_from_another_sacco.AsValue.AsBoolean;
    //                 TmpMemberTable."Created By" := crm_created_by.AsValue.AsText;
    //                 TmpMemberTable."Office Telephone No." := office_telephone_no.AsValue.AsText;
    //                 TmpMemberTable."Country Of Operation" := country_of_operation.AsValue.AsText;
    //                 TmpMemberTable."Work Station" := work_station.AsValue.AsText;
    //                 TmpMemberTable."Employment Designation" := employment_designation.AsValue.AsText;
    //                 TmpMemberTable."Delegates Zone" := delegates_zone.AsValue.AsText;

    //                 TmpMemberTable.Status := EditMember.Status;
    //                 TmpMemberTable."Account Type" := EditMember."Account Type";
    //                 // TmpMemberTable."Responsibility Center" := 'Customer Care';
    //                 // TmpMemberTable."Application Date" := DT2Date(CurrentDateTime);
    //                 TmpMemberTable."Global Dimension 1 Code" := branch_code.AsValue.AsText;
    //                 TmpMemberTable."Global Dimension 2 Code" := activity_code.AsValue.AsText;

    //                 TmpMemberTable.Validate("First Name");
    //                 TmpMemberTable.Validate("Middle Name");
    //                 TmpMemberTable.Validate("Other Names");

    //                 if date_of_birth.AsValue.AsText <> '' then begin
    //                     TmpMemberTable."Date of Birth" := date_of_birth.AsValue.AsDate;
    //                 end;
    //             end else begin
    //                 // Group
    //                 TmpMemberTable."First Name" := business_name.AsValue.AsText;
    //                 TmpMemberTable.Name := business_name.AsValue.AsText;
    //                 TmpMemberTable."Home Address" := permanent_address.AsValue.AsText;
    //                 TmpMemberTable."Current Address" := current_address.AsValue.AsText;
    //                 TmpMemberTable."Phone No." := phone_no.AsValue.AsText;
    //                 TmpMemberTable."E-Mail" := email_address.AsValue.AsText;
    //                 TmpMemberTable.Nationality := nationality.AsValue.AsText;
    //                 TmpMemberTable."Post Code" := post_code.AsValue.AsText;
    //                 TmpMemberTable.City := city.AsValue.AsText;
    //                 TmpMemberTable.County := county.AsValue.AsText;
    //                 TmpMemberTable."Bank Code" := bank_code.AsValue.AsText;
    //                 TmpMemberTable."Branch Code" := bank_branch_code.AsValue.AsText;
    //                 TmpMemberTable."Bank Account No." := bank_account_no.AsValue.AsText;
    //                 TmpMemberTable."Company Registration No." := company_registration_no.AsValue.AsText;
    //                 TmpMemberTable."P.I.N Number" := kra_pin_number.AsValue.AsText;
    //                 TmpMemberTable."Recruited by Type" := "Recruited By".FromInteger(recruited_by_type.AsValue.AsInteger);
    //                 TmpMemberTable."Recruited By" := recruited_by.AsValue.AsText;
    //                 TmpMemberTable."Allocated Officer" := relationship_manager.AsValue.AsText;
    //                 TmpMemberTable."Type of Application" := "Type of Application".FromInteger(type_of_application.AsValue.AsInteger);
    //                 IF TmpMemberTable."Type of Application" = "Type of Application"::Readmission then begin
    //                     TmpMemberTable."Principle Member" := principle_member.AsValue.AsText;
    //                     TmpMemberTable."Old Member No." := principle_member.AsValue.AsText;
    //                 end;
    //                 TmpMemberTable."CRM Application No." := crm_application_no.AsValue.AsText;
    //                 TmpMemberTable."Account Type" := account_type.AsValue.AsInteger;
    //                 TmpMemberTable."Account Profile" := account_profile.AsValue.AsInteger;
    //                 TmpMemberTable."Created By" := crm_created_by.AsValue.AsText;
    //                 TmpMemberTable."Office Telephone No." := office_telephone_no.AsValue.AsText;
    //                 TmpMemberTable."Country Of Operation" := country_of_operation.AsValue.AsText;
    //                 // TmpMemberTable."Year of Incorporation" := year_of_incorporation.AsValue.AsText;

    //                 TmpMemberTable.Status := EditMember.Status;
    //                 // TmpMemberTable."Responsibility Center" := 'Customer Care';
    //                 // TmpMemberTable."Application Date" := DT2Date(CurrentDateTime);
    //                 TmpMemberTable."Global Dimension 1 Code" := branch_code.AsValue.AsText;
    //                 TmpMemberTable."Global Dimension 2 Code" := activity_code.AsValue.AsText;
    //             end;

    //             // Set Filter Fields
    //             // Record fields**
    //             RecRef.Open(SystemEdits."Table ID");
    //             RecRef.Copy(EditMember);
    //             NewRecRef.Open(SystemEdits."Table ID");
    //             NewRecRef.Copy(TmpMemberTable);
    //             SystemEditsCodeunit.SetFilterFields(SystemEdits."Table ID", SystemEdits."No.", Action::SetFilter, RecRef, NewRecRef);

    //             // Exit(SystemEdits."No." + ' - Member with number = ' + EditMember."No." + ' edit request has been received successfully!');
    //             ResponseData.Add('application_status', Format(SystemEdits.Status));

    //             ResponseObject.Add('status', 'SUCCESS');
    //             ResponseObject.Add('description', 'Membership edit request with CRM application number ' + crm_application_no.AsValue.AsText + ' has been created successfully.');
    //             ResponseObject.Add('data', ResponseData);
    //             AddDateTimeToResponse(ResponseObject);

    //             ResponseObject.WriteTo(Response);
    //         end else begin
    //             // Error
    //             // ResponseObject.Add('status', 'ERROR');
    //             // ResponseObject.Add('description', 'Unable to create membership edit request');
    //             // ResponseObject.Add('errors', Errors);
    //             // AddDateTimeToResponse(ResponseObject);

    //             // ResponseObject.WriteTo(Response);

    //             Error('Unable to create membership edit request');
    //         end;
    //     end else begin
    //         Error('Unknown member with member number = %1', member_number.asValue.AsText);
    //     end;

    //     exit(Response);
    // end;

    // TODO: Solution for this
    // local procedure EditMemberNOKApplication(Payload: JsonObject): Text
    // var
    //     member_number: JsonToken;
    //     crm_application_no: JsonToken;
    //     crm_notes: JsonToken;
    //     crm_originating_branch: JsonToken;
    //     nok_beneficiary_nominee_info: JsonToken;
    //     nok_beneficiary_nominee: JsonToken;
    //     nok_beneficiary_nominee_action: JsonToken;
    //     nok_beneficiary_nominee_identification_type: JsonToken;
    //     nok_beneficiary_nominee_identification_value: JsonToken;
    //     nok_beneficiary_nominee_full_names: JsonToken;
    //     nok_beneficiary_nominee_relationship: JsonToken;
    //     nok_beneficiary_nominee_date_of_birth: JsonToken;
    //     nok_beneficiary_nominee_address: JsonToken;
    //     nok_beneficiary_nominee_mobile_no: JsonToken;
    //     nok_beneficiary_nominee_email_address: JsonToken;
    //     nok_beneficiary_nominee_is_next_of_kin: JsonToken;
    //     nok_beneficiary_nominee_is_beneficiary: JsonToken;
    //     nok_beneficiary_nominee_is_contact_person: JsonToken;
    //     nok_beneficiary_nominee_is_nominee: JsonToken;
    //     nok_beneficiary_nominee_allocation: JsonToken;

    //     KeyExists: Boolean;

    //     EditMember: Record Members;
    // begin
    //     KeyExists := Payload.Get('member_number', member_number);
    //     KeyExists := Payload.Get('crm_application_no', crm_application_no);
    //     KeyExists := Payload.Get('crm_notes', crm_notes);
    //     KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);
    //     KeyExists := Payload.Get('nok_beneficiary_nominee_info', nok_beneficiary_nominee_info);

    //     EditMember.Reset();

    //     EditMember.SetRange("No.", member_number.asValue.AsText);

    //     IF EditMember.FindFirst then begin
    //         Error('API still under development.');
    //     end else begin
    //         Error('Unknown member with member number = %1', member_number.asValue.AsText);
    //     end;
    // end;

    local procedure CreateMemberEditApplication(Payload: JsonObject): Text
    var
        member_number: JsonToken;
        type_of_edit: JsonToken;
        additional_information: JsonToken;
        crm_application_no: JsonToken;
        crm_created_by: JsonToken;
        crm_originating_branch: JsonToken;

        KeyExists: Boolean;

        EditMember: Record Members;
        CRMMemberEdit: Record "CRM Member Edit";
        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        KeyExists := Payload.Get('member_number', member_number);
        KeyExists := Payload.Get('type_of_edit', type_of_edit);
        KeyExists := Payload.Get('additional_information', additional_information);
        KeyExists := Payload.Get('crm_application_no', crm_application_no);
        KeyExists := Payload.Get('crm_created_by', crm_created_by);
        KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);

        EditMember.Reset();

        EditMember.SetRange("No.", member_number.asValue.AsText);

        IF EditMember.FindFirst then begin
            CRMMemberEdit.Init();

            CRMMemberEdit."Member No." := EditMember."No.";
            CRMMemberEdit.Validate("Member No.");

            CRMMemberEdit."Type of Edit" := type_of_edit.AsValue.AsInteger;
            CRMMemberEdit."Edit Information" := additional_information.AsValue.AsText;
            CRMMemberEdit."CRM No." := '';
            CRMMemberEdit."CRM Created By" := crm_created_by.AsValue.AsText;
            CRMMemberEdit."CRM Branch" := crm_originating_branch.AsValue.AsText;
            CRMMemberEdit."Change Complete" := False;

            CRMMemberEdit.Status := CRMMemberEdit.Status::Open;
            CRMMemberEdit."Responsibility Center" := Format("Responsibility Center Enum"::RECORDS);

            if crm_created_by.AsValue.AsText = '' then begin
                Error('ERR_401. Invalid application. Origination NOT accepted!');
            end;

            IF CRMMemberEdit.Insert(true) then begin
                CRMMemberEdit."CRM No." := CRMMemberEdit."No.";

                // Handle CRM branch assigmnent
                CRMMemberEdit."Global Dimension 1 Code" := GlobalFunctions.GetBranchCodeFromCRMOrigination(CRMMemberEdit."CRM Branch");
                CRMMemberEdit.Modify;

                // CRM Comments/Notes
                GlobalFunctions.InsertCommentRecord(
                    CRMMemberEdit."No.",
                    additional_information.AsValue.AsText,
                    crm_created_by.AsValue.AsText,
                    CRMMemberEdit."Global Dimension 1 Code",
                    CRMMemberEdit."Global Dimension 2 Code",
                    CRMMemberEdit."Responsibility Center",
                    false
                );

                EDMSFunctions.EDMSScannedLog(
                    CRMMemberEdit."No.",
                    "CRM Originations"::"Member Edit",
                    CRMMemberEdit."Member No.",
                    CRMMemberEdit."CRM Created By",
                    CRMMemberEdit."CRM Branch"
                );

                ResponseData.Add('application_status', Format(CRMMemberEdit.Status));
                ResponseData.Add('application_number', CRMMemberEdit."No.");

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('description', 'Member edit application with CRM application number ' + CRMMemberEdit."No." + ' has been created successfully.');
                ResponseObject.Add('data', ResponseData);
                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
            end else begin

                // ResponseObject.Add('status', 'ERROR');
                // ResponseObject.Add('description', 'Unable to create member edit application.');
                // ResponseObject.Add('errors', Errors);
                // AddDateTimeToResponse(ResponseObject);

                // ResponseObject.WriteTo(Response);

                Error('Unable to create member edit application.');
            end;
        end else begin
            Error('Unknown member with member number = %1', member_number.asValue.AsText);
        end;

        exit(Response);
    end;

    local procedure UpdateMemberEditApplication(Payload: JsonObject): Text
    var
        application_no: JsonToken;
        member_number: JsonToken;
        type_of_edit: JsonToken;
        additional_information: JsonToken;
        crm_application_no: JsonToken;
        crm_created_by: JsonToken;
        crm_originating_branch: JsonToken;

        KeyExists: Boolean;

        EditMember: Record Members;
        CRMMemberEdit: Record "CRM Member Edit";
        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        KeyExists := Payload.Get('application_no', application_no);
        KeyExists := Payload.Get('member_number', member_number);
        KeyExists := Payload.Get('type_of_edit', type_of_edit);
        KeyExists := Payload.Get('additional_information', additional_information);
        KeyExists := Payload.Get('crm_application_no', crm_application_no);
        KeyExists := Payload.Get('crm_created_by', crm_created_by);
        KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);

        EditMember.Reset();

        EditMember.SetRange("No.", member_number.asValue.AsText);

        IF EditMember.FindFirst then begin
            CRMMemberEdit.Reset;

            CRMMemberEdit.SetRange("No.", application_no.AsValue.AsText);
            CRMMemberEdit.SetRange("Sent Back to CRM", true);

            if CRMMemberEdit.FindFirst then begin
                CRMMemberEdit."Member No." := EditMember."No.";
                CRMMemberEdit.Validate("Member No.");

                CRMMemberEdit."Type of Edit" := type_of_edit.AsValue.AsInteger;
                CRMMemberEdit."Edit Information" := additional_information.AsValue.AsText;
                // CRMMemberEdit."CRM Created By" := crm_created_by.AsValue.AsText;
                CRMMemberEdit."CRM Branch" := crm_originating_branch.AsValue.AsText;
                CRMMemberEdit."Change Complete" := False;

                CRMMemberEdit.Status := CRMMemberEdit.Status::Open;
                CRMMemberEdit."Sent Back to CRM" := false;

                IF CRMMemberEdit.Modify(true) then begin
                    // Handle CRM branch assigmnent
                    CRMMemberEdit."Global Dimension 1 Code" := GlobalFunctions.GetBranchCodeFromCRMOrigination(CRMMemberEdit."CRM Branch");
                    CRMMemberEdit.Modify;

                    // CRM Comments/Notes
                    GlobalFunctions.InsertCommentRecord(
                        CRMMemberEdit."No.",
                        additional_information.AsValue.AsText,
                        crm_created_by.AsValue.AsText,
                        CRMMemberEdit."Global Dimension 1 Code",
                        CRMMemberEdit."Global Dimension 2 Code",
                        CRMMemberEdit."Responsibility Center",
                        false
                    );

                    ResponseData.Add('application_status', Format(CRMMemberEdit.Status));
                    ResponseData.Add('application_number', CRMMemberEdit."No.");

                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('description', 'Member edit application with CRM application number ' + CRMMemberEdit."No." + ' has been updated successfully.');
                    ResponseObject.Add('data', ResponseData);
                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                end else begin

                    // ResponseObject.Add('status', 'ERROR');
                    // ResponseObject.Add('description', 'Unable to create member edit application.');
                    // ResponseObject.Add('errors', Errors);
                    // AddDateTimeToResponse(ResponseObject);

                    // ResponseObject.WriteTo(Response);

                    Error('Unable to create member edit application.');
                end;
            end else begin
                Error('Member edit application with number %1 NOT available for CRM editing.', application_no.AsValue.AsText);
            end;

        end else begin
            Error('Unknown member with member number = %1', member_number.asValue.AsText);
        end;

        exit(Response);
    end;

    local procedure GetMemberEditApplications(Payload: JsonObject): Text
    var
        filter_property: JsonToken;
        filter_value: JsonToken;
        start_date: JsonToken;
        end_date: JsonToken;
        page_number: JsonToken;
        page_size: JsonToken;
        crm_branch: JsonToken;

        KeyExists: Boolean;

        CRMMemberEdits: Record "CRM Member Edit";
        SLA: record "Defined SLA";
        Comment: record Comments;

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;
        Count: Integer;
        FirstRow: Integer;
        LastRow: Integer;
        TotalFoundRecords: Integer;
        SearchString: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        KeyExists := Payload.Get('filter_property', filter_property);
        KeyExists := Payload.Get('filter_value', filter_value);
        KeyExists := Payload.Get('start_date', start_date);
        KeyExists := Payload.Get('end_date', end_date);
        KeyExists := Payload.Get('crm_branch', crm_branch);
        Payload.Get('page_number', page_number);
        Payload.Get('page_size', page_size);

        CRMMemberEdits.Reset;
        CRMMemberEdits.SetCurrentKey("Application Date");
        CRMMemberEdits.SetAscending("Application Date", false);

        if KeyExists then begin
            if (crm_branch.AsValue.AsText <> 'ALL') then begin
                CRMMemberEdits.SetRange(CRMMemberEdits."CRM Branch", crm_branch.AsValue.AsText);
            end;
        end;

        // Search Value
        if (not filter_property.AsValue.IsNull) and (not filter_value.AsValue.IsNull) then begin
            if (filter_property.AsValue.AsText <> '') and (filter_value.AsValue.AsText <> '') then begin
                SearchString := filter_value.AsValue.AsText;

                case filter_property.AsValue.AsText of
                    'application_no':
                        CRMMemberEdits.SetRange(CRMMemberEdits."No.", SearchString);
                    'crm_application_no':
                        CRMMemberEdits.SetRange(CRMMemberEdits."CRM No.", SearchString);
                    'member_no':
                        CRMMemberEdits.SetRange(CRMMemberEdits."Member No.", SearchString);
                    'status':
                        CRMMemberEdits.SetFilter(CRMMemberEdits.Status, SearchString);
                    else
                        CRMMemberEdits.SetRange(CRMMemberEdits."No.", SearchString);
                end;
                // Text fields
                // CRMMemberEdits.SetRange(CRMMemberEdits."No.", SearchString);
                // CRMMemberEdits.SetRange(CRMMemberEdits."Member No.", SearchString);
                // CRMMemberEdits.SetRange(CRMMemberEdits."Member Name", SearchString);
                // CRMMemberEdits.SetRange(CRMMemberEdits."CRM No.", SearchString);
            end;
        end;

        // Start Date & End Date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));

                CRMMemberEdits.SetFilter("Application Date", '>=%1&<=%2', StartDate, EndDate);
            end;
        end;

        IF CRMMemberEdits.FindSet then begin
            // Applications found
            Count := 0;
            FirstRow := ((page_number.AsValue.AsInteger - 1) * page_size.AsValue.AsInteger) + 1;
            LastRow := page_number.AsValue.AsInteger * page_size.AsValue.AsInteger;

            TotalFoundRecords := CRMMemberEdits.Count;

            repeat begin
                Count += 1;

                if (Count >= FirstRow) and (Count <= LastRow) then begin
                    CRMMemberEdits.CalcFields("Member Name", "Responsible Officer", "Supervisor ID");

                    Datum.Add('application_no', CRMMemberEdits."No.");
                    Datum.Add('crm_application_no', CRMMemberEdits."CRM No.");
                    Datum.Add('member_no', CRMMemberEdits."Member No.");
                    Datum.Add('member_name', CRMMemberEdits."Member Name");
                    Datum.Add('type_of_edit', Format(CRMMemberEdits."Type of Edit"));
                    Datum.Add('application_date', CRMMemberEdits."Application Date");
                    Datum.Add('crm_created_by', CRMMemberEdits."CRM Created By");
                    Datum.Add('crm_originating_branch', CRMMemberEdits."CRM Branch");
                    Datum.Add('responsible_officer', CRMMemberEdits."Responsible Officer");
                    Datum.Add('supervisor_id', CRMMemberEdits."Supervisor ID");
                    Datum.Add('status', Format(CRMMemberEdits.Status));
                    Datum.Add('is_sent_back_to_crm', CRMMemberEdits."Sent Back to CRM");

                    // SLA
                    WorkDays := 0;
                    SLADays := 0;
                    DelayDays := 0;
                    StatusComment := '';

                    SLA.reset();
                    SLA.SetRange("Origination Type", SLA."Origination Type"::"Member Edit");
                    if SLA.findfirst() then
                        SLADays := SLA.SLA;

                    if (CRMMemberEdits."Approval Date" <> 0D) and (CRMMemberEdits."Application Date" <> 0D) and (CRMMemberEdits."Application Time" <> 0T) and (CRMMemberEdits."Approval Time" <> 0T) then begin
                        Globalfunctions.HoursBetweenPeriods(CRMMemberEdits."Application Date", CRMMemberEdits."Application Time", CRMMemberEdits."Approval Date", CRMMemberEdits."Approval Time", Duration, WokedOnANonWorkingPeriod);
                        WorkDays := Duration;
                        DelayDays := WorkDays - (SLADays / 3);
                        IF DelayDays < 0 then DelayDays := 0;
                    end;

                    Comment.reset();
                    Comment.SetRange("Header No.", CRMMemberEdits."No.");
                    If Comment.FindLast() then begin
                        StatusComment := Comment.Comment;
                    end;


                    Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
                    Datum.Add('SLA_days', Format(SLADays));
                    Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
                    Datum.Add('tat_status', Format(TAtStatus));
                    Datum.Add('status_comment', StatusComment);
                    // Datum.Add('priority', Format(Priority));

                    Data.Add(Datum);
                    // Reset
                    Datum.ReadFrom('{}');
                end;
            end until (Count = LastRow) or (CRMMemberEdits.Next = 0);

            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberEditApplication(Payload: JsonObject): Text
    var
        application_number: JsonToken;

        CRMMemberEdit: Record "CRM Member Edit";
        ApplicationComments: Record Comments;

        Comments: JsonArray;
        Comment: JsonObject;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('application_number', application_number);

        CRMMemberEdit.Reset;
        CRMMemberEdit.SetRange("No.", application_number.AsValue.AsText);

        IF CRMMemberEdit.FindFirst() then begin
            CRMMemberEdit.CalcFields(
            "Responsible Officer",
            "Member Name",
            "Supervisor ID"
            );

            Datum.Add('no', CRMMemberEdit."No.");
            Datum.Add('crm_application_no', CRMMemberEdit."CRM No.");
            Datum.Add('member_no', CRMMemberEdit."Member No.");
            Datum.Add('member_name', CRMMemberEdit."Member Name");
            Datum.Add('type_of_edit', Format(CRMMemberEdit."Type of Edit"));
            Datum.Add('edit_information', CRMMemberEdit."Edit Information");
            Datum.Add('application_date', CRMMemberEdit."Application Date");
            Datum.Add('crm_created_by', CRMMemberEdit."CRM Created By");
            Datum.Add('crm_originating_branch', CRMMemberEdit."CRM Branch");
            Datum.Add('responsible_officer', CRMMemberEdit."Responsible Officer");
            Datum.Add('created_by', CRMMemberEdit."Created By");
            Datum.Add('supervisor_id', CRMMemberEdit."Supervisor ID");
            Datum.Add('is_change_complete', CRMMemberEdit."Change Complete");
            Datum.Add('status', Format(CRMMemberEdit.Status));
            Datum.Add('is_sent_back_to_crm', CRMMemberEdit."Sent Back to CRM");

            ApplicationComments.Reset;

            ApplicationComments.SetRange("Header No.", CRMMemberEdit."No.");
            ApplicationComments.SetCurrentKey("Entry No.");
            ApplicationComments.SetAscending("Entry No.", false);

            if ApplicationComments.FindSet then begin
                repeat begin
                    Comment.Add('comment', ApplicationComments.Comment);
                    Comment.Add('commented_by', ApplicationComments."Commented By");
                    Comment.Add('date_time', GlobalFunctions.FormatISODateTime(ApplicationComments.Date));
                    Comment.Add('is_read', ApplicationComments."Viewd By Somebody Else");

                    Comments.Add(Comment);

                    // Reset
                    Comment.ReadFrom('{}');
                end until ApplicationComments.Next = 0;
            end;

            Datum.Add('comments', Comments);

            Datum.Add('created_at', CRMMemberEdit.SystemCreatedAt);
            Datum.Add('modified_at', CRMMemberEdit.SystemModifiedAt);
        end else begin
            Error('Member edit application with number %1 NOT found.', application_number.AsValue.AsText);
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetNokRelationships(): Text
    var
        NOKRelationships: Record "BBF Entitlement";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        NOKRelationships.Reset;

        IF NOKRelationships.FindSet then begin
            repeat begin
                Datum.Add('code', NOKRelationships."Relationship Type");
                Datum.Add('relation', NOKRelationships."Relationship Type");
                Datum.Add('min_age', 0);
                Datum.Add('max_age', 0);
                Datum.Add('maximum_count_allowed', 0);
                Datum.Add('max_welfare_claim_amount', NOKRelationships.Amount);
                Datum.Add('claim_option', NOKRelationships."Claim Option");
                Datum.Add('claim_option_desc', Format(NOKRelationships."Claim Option"));
                Datum.Add('claim_type', NOKRelationships."Claim Type");
                Datum.Add('claim_type_desc', Format(NOKRelationships."Claim Type"));
                Datum.Add('start_date', NOKRelationships."Start Date");
                Datum.Add('end_date', NOKRelationships."End Date");

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until NOKRelationships.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberEmployers(): Text
    var
        CustomerEmployers: Record Customer;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        CustomerEmployers.Reset;

        CustomerEmployers.SetRange("Account Type", CustomerEmployers."Account Type"::Employer);
        IF CustomerEmployers.FindSet then begin
            repeat begin
                Datum.Add('employer_code', CustomerEmployers."No.");
                Datum.Add('employer_name', CustomerEmployers.Name);

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until CustomerEmployers.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberNationalities(): Text
    var
        Countries: Record "Country/Region";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Countries.Reset;

        IF Countries.FindSet then begin
            repeat begin
                Datum.Add('code', Countries.Code);
                Datum.Add('name', Countries.Name);

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until Countries.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetCountries(): Text
    var
        Countries: Record "Country/Region";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Countries.Reset;

        IF Countries.FindSet then begin
            repeat begin
                Datum.Add('code', Countries.Code);
                Datum.Add('name', Countries.Name);
                Datum.Add('iso_code', Countries."ISO Code");
                Datum.Add('iso_numeric_code', Countries."ISO Numeric Code");
                Datum.Add('eu_country_code', Countries."EU Country/Region Code");
                Datum.Add('intrastat_code', Countries."Intrastat Code");
                Datum.Add('address_format', Format(Countries."Address Format"));
                Datum.Add('contact_address_format', Format(Countries."Contact Address Format"));

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until Countries.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetPostCodes(): Text
    var
        PostCodes: Record "Post Code";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        PostCodes.Reset;

        IF PostCodes.FindSet then begin
            repeat begin
                Datum.Add('code', PostCodes.Code);
                Datum.Add('city', PostCodes.City);
                Datum.Add('search_city', PostCodes."Search City");
                Datum.Add('country_region_code', PostCodes."Country/Region Code");
                Datum.Add('county', PostCodes.County);
                Datum.Add('time_zone', PostCodes."Time Zone");

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until PostCodes.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberDelegateZones(): Text
    var
        ElectoralZones: Record "Electrol Zones/Area Svr Center";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        ElectoralZones.Reset;

        ElectoralZones.SetRange(Type, ElectoralZones.Type::"Electral Zone");

        IF ElectoralZones.FindSet then begin
            repeat begin
                // ElectoralZones.CalcFields("County Name", "Sub County Name");

                Datum.Add('code', ElectoralZones.Code);
                Datum.Add('name', ElectoralZones.Description);
                // Datum.Add('county', ElectoralZones.County);
                // Datum.Add('county_name', ElectoralZones."County Name");
                // Datum.Add('sub_county', ElectoralZones."Sub-County");
                // Datum.Add('sub_county_name', ElectoralZones."Sub County Name");

                Data.Add(Datum);
                // Reset
                Datum.ReadFrom('{}');
            end until ElectoralZones.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberReligions(): Text
    var
        HRLookup: Record "HR Lookup Values";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        HRLookup.Reset;

        HRLookup.SetRange(Type, HRLookup.Type::Religion);

        IF HRLookup.FindSet then begin
            repeat begin
                Datum.Add('code', HRLookup.Code);
                Datum.Add('name', HRLookup.Description);

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until HRLookup.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberCounties(): Text
    var
        Counties: Record "Segment/County/Dividend/Signat";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Counties.Reset;

        Counties.SetRange(Type, Counties.Type::County);

        IF Counties.FindSet then begin
            repeat begin
                Datum.Add('code', Counties.Code);
                Datum.Add('name', Counties.Description);

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until Counties.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberSubCounties(Payload: JsonObject): Text
    var
        county_code: JsonToken;

        Counties: Record "Segment/County/Dividend/Signat";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('county_code', county_code);

        Counties.Reset;
        Counties.SetRange(Type, Counties.Type::"Sub-County");
        Counties.SetRange(County, county_code.AsValue.AsText);

        IF Counties.FindSet then begin
            repeat begin
                Datum.Add('code', Counties.Code);
                Datum.Add('name', Counties.Description);

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until Counties.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberBankCodes(): Text
    var
        BankCodes: Record "Bank Code Structure";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        BankCodes.Reset;

        BankCodes.SetRange("Parent Code", '');

        IF BankCodes.FindSet then begin
            repeat begin
                Datum.Add('code', BankCodes.Code);
                Datum.Add('name', BankCodes.Name);

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until BankCodes.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberBankBranches(Payload: JsonObject): Text
    var
        bank_code: JsonToken;

        BankCodes: Record "Bank Code Structure";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('bank_code', bank_code);

        BankCodes.Reset;
        BankCodes.SetRange("Parent Code", bank_code.AsValue.AsText);

        IF BankCodes.FindSet then begin
            repeat begin
                Datum.Add('code', BankCodes.Code);
                Datum.Add('name', BankCodes.Name);

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until BankCodes.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberNOKList(Payload: JsonObject): Text
    var
        member_no: JsonToken;

        NOKList: Record "Next of KIN";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('member_no', member_no);

        NOKList.Reset;
        NOKList.SetRange("Record ID", member_no.AsValue.AsText);
        NOKList.SetRange(Removed, false);

        IF NOKList.FindSet then begin
            repeat begin
                Datum.Add('member_number', NOKList."Record ID");
                Datum.Add('full_names', NOKList.Name);
                Datum.Add('relationship', NOKList.Relationship);
                Datum.Add('date_of_birth', NOKList."Date of Birth");
                Datum.Add('address', NOKList.Address);
                Datum.Add('mobile_number', NOKList.Telephone);
                Datum.Add('email_address', NOKList.Email);
                Datum.Add('identification_type', NOKList."Identification Type".AsInteger);
                Datum.Add('identification_type_desc', Format(NOKList."Identification Type"));
                Datum.Add('identification', NOKList.Identification);
                Datum.Add('allocation', NOKList.Allocation);
                Datum.Add('is_deceased', NOKList.Deceased);
                Datum.Add('is_beneficiary', NOKList."Is a Beneficiary");
                Datum.Add('is_next_of_kin', NOKList."Is Next of Kin");
                // Datum.Add('is_nominee', NOKList."Is Nominee");
                Datum.Add('is_contact_person', NOKList."Is Contact Person");
                Datum.Add('is_removed', NOKList.Removed);
                Datum.Add('date_captured', NOKList."Date Captured");
                Datum.Add('date_modified', NOKList."Date Modified");

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until NOKList.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberClasses(): Text
    var
        MemberClasses: Record "Member Classes";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        MemberClasses.Reset;

        IF MemberClasses.FindSet then begin
            repeat begin
                Datum.Add('no', MemberClasses."No.");
                Datum.Add('entrance_fee', MemberClasses."Entrance Fee");
                Datum.Add('share_capital', MemberClasses."Share Capital");
                Datum.Add('max_installment', MemberClasses."Max. Installment");
                Datum.Add('default_share_capital', MemberClasses."Default Share Capital");
                Datum.Add('default_bosa_deposit', MemberClasses."Default BOSA Deposit");
                Datum.Add('bbf_joining_fee', MemberClasses."BBF Joining Fee");
                Datum.Add('is_checkoff', MemberClasses.Checkoff);
                Datum.Add('can_take_loan', MemberClasses."Can Take Loan");
                Datum.Add('acronym', MemberClasses.Acronym);
                Datum.Add('min_age', Format(MemberClasses."Minimum Age"));
                Datum.Add('member_class', Format(MemberClasses."Member Class"));

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until MemberClasses.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberGroups(): Text
    var
        GroupMembers: Record Members;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        GroupMembers.Reset;

        GroupMembers.SetFilter("Account Type", '<>%1', GroupMembers."Account Type"::"Single Member Account");

        IF GroupMembers.FindSet then begin
            repeat begin
                Datum.Add('no', GroupMembers."No.");
                Datum.Add('name', GroupMembers.Name);
                Datum.Add('account_type', Format(GroupMembers."Account Type"));

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until GroupMembers.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberRelationshipManagers(): Text
    var
        HREmployees: Record "HR Employees";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        HREmployees.Reset;

        // HREmployees.SetRange(Status, Format(HREmployees.Status::Active));

        IF HREmployees.FindSet then begin
            repeat begin
                Datum.Add('employee_no', HREmployees."No.");
                Datum.Add('name', HREmployees."Full Name");
                Datum.Add('gender', Format(HREmployees.Gender));
                Datum.Add('status', Format(HREmployees.Status));

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until HREmployees.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure SearchEmployees(Payload: JsonObject): Text
    var
        filter_property: JsonToken;
        filter_value: JsonToken;

        KeyExists: Boolean;

        SearchEmployee: Record "HR Employees";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        KeyExists := Payload.Get('filter_property', filter_property); // phone_number, primary_identification, email_address, kra_pin_number, pf_number
        KeyExists := Payload.Get('filter_value', filter_value);

        SearchEmployee.Reset;
        SearchEmployee.SetRange(Status, SearchEmployee.Status::Active);

        if (not filter_property.AsValue.IsNull) and (not filter_value.AsValue.IsNull) then begin
            if (filter_property.AsValue.AsText <> '') and (filter_value.AsValue.AsText <> '') then begin
                case filter_property.AsValue.AsText of
                    'phone_number':
                        SearchEmployee.SetFilter("Home Phone Number", filter_value.AsValue.AsText);
                    'id_number':
                        begin
                            SearchEmployee.SetRange("Primary Identification Type", SearchEmployee."Primary Identification Type"::"ID Number");
                            SearchEmployee.SetRange("Primary Identification", filter_value.AsValue.AsText);

                            if not SearchEmployee.FindFirst then begin
                                SearchEmployee.Reset;
                                SearchEmployee.SetRange("Secondary Identification Type", SearchEmployee."Secondary Identification Type"::"ID Number");
                                SearchEmployee.SetRange("Secondary Identification", filter_value.AsValue.AsText);
                            end;
                        end;
                    'passport_number':
                        begin
                            SearchEmployee.SetRange("Primary Identification Type", SearchEmployee."Primary Identification Type"::"Passport No");
                            SearchEmployee.SetRange("Primary Identification", filter_value.AsValue.AsText);

                            if not SearchEmployee.FindFirst then begin
                                SearchEmployee.Reset;
                                SearchEmployee.SetRange("Secondary Identification Type", SearchEmployee."Secondary Identification Type"::"Passport No");
                                SearchEmployee.SetRange("Secondary Identification", filter_value.AsValue.AsText);
                            end;
                        end;
                    'payroll_number':
                        SearchEmployee.SetRange("Sacco Staff No", filter_value.AsValue.AsText);
                    'email_address':
                        SearchEmployee.SetRange("E-Mail", filter_value.AsValue.AsText);
                    else
                        SearchEmployee.SetRange("No.", filter_value.AsValue.AsText);
                end;

                IF SearchEmployee.FindSet then begin
                    repeat begin
                        Datum.Add('no', SearchEmployee."No.");
                        Datum.Add('member_number', SearchEmployee."Member No.");
                        Datum.Add('full_names', SearchEmployee."Full Name");
                        Datum.Add('email', SearchEmployee."E-Mail");
                        Datum.Add('gender', Format(SearchEmployee.Gender));
                        Datum.Add('id_number', SearchEmployee."ID Number");
                        Datum.Add('status', Format(SearchEmployee.Status));

                        Data.Add(Datum);

                        // Reset
                        Datum.ReadFrom('{}');
                    end until SearchEmployee.Next = 0;
                end else begin
                    Error('Employee(s) with identification %1 = %2 NOT found.', filter_property.AsValue.AsText, filter_value.AsValue.AsText);
                end;
            end else begin
                IF SearchEmployee.FindSet then begin
                    repeat begin
                        Datum.Add('no', SearchEmployee."No.");
                        Datum.Add('member_number', SearchEmployee."Member No.");
                        Datum.Add('full_names', SearchEmployee."Full Name");
                        Datum.Add('email', SearchEmployee."E-Mail");
                        Datum.Add('gender', Format(SearchEmployee.Gender));
                        Datum.Add('id_number', SearchEmployee."ID Number");
                        Datum.Add('status', Format(SearchEmployee.Status));

                        Data.Add(Datum);

                        // Reset
                        Datum.ReadFrom('{}');
                    end until SearchEmployee.Next = 0;
                end;
            end;
        end else begin
            IF SearchEmployee.FindSet then begin
                repeat begin
                    Datum.Add('no', SearchEmployee."No.");
                    Datum.Add('member_number', SearchEmployee."Member No.");
                    Datum.Add('full_names', SearchEmployee."Full Name");
                    Datum.Add('email', SearchEmployee."E-Mail");
                    Datum.Add('gender', Format(SearchEmployee.Gender));
                    Datum.Add('id_number', SearchEmployee."ID Number");
                    Datum.Add('status', Format(SearchEmployee.Status));

                    Data.Add(Datum);

                    // Reset
                    Datum.ReadFrom('{}');
                end until SearchEmployee.Next = 0;
            end;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetPrincipleMembers(): Text
    var
        PrincipleMembers: Record Members;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        PrincipleMembers.Reset;

        PrincipleMembers.SetRange(Status, PrincipleMembers.Status::Closed);

        IF PrincipleMembers.FindSet then begin
            repeat begin
                Datum.Add('no', PrincipleMembers."No.");
                Datum.Add('salutation', PrincipleMembers.Salutation);
                Datum.Add('name', PrincipleMembers.Name);

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until PrincipleMembers.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberSalutations(): Text
    var
        Salutations: Record "Salutation Tittles";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Salutations.Reset;

        Salutations.SetRange(Type, Salutations.Type::Tittle);

        IF Salutations.FindSet then begin
            repeat begin
                Datum.Add('code', Salutations.Code);
                Datum.Add('name', Salutations.Description);

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until Salutations.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;


    local procedure GetMemberWorkstations(): Text
    var
        Workstations: Record "Electrol Zones/Area Svr Center";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Workstations.Reset;

        Workstations.SetRange(Type, Workstations.Type::"Work Station");
        ;

        IF Workstations.FindSet then begin
            repeat begin
                Datum.Add('code', Workstations.Code);
                Datum.Add('name', Workstations.Description);
                Datum.Add('type', Format(Workstations.Type));

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until Workstations.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberDesignations(): Text
    var
        Workstations: Record "Electrol Zones/Area Svr Center";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Workstations.Reset;

        Workstations.SetRange(Type, Workstations.Type::Designation);

        IF Workstations.FindSet then begin
            repeat begin
                Datum.Add('code', Workstations.Code);
                Datum.Add('name', Workstations.Description);
                Datum.Add('type', Format(Workstations.Type));

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until Workstations.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanProducts(Payload: JsonObject): Text
    var
        source_unit: JsonToken;

        ActiveLoanProducts: Record "Product Factory";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('source_unit', source_unit);

        ActiveLoanProducts.Reset;

        ActiveLoanProducts.SetRange("Product Class Type", ActiveLoanProducts."Product Class Type"::Loan);
        ActiveLoanProducts.SetRange(Status, ActiveLoanProducts.Status::Active);
        ActiveLoanProducts.SetRange("Is CRM Product", true);

        if source_unit.AsValue.AsInteger <> 0 then begin
            ActiveLoanProducts.SetRange("Source Unit", source_unit.AsValue.AsInteger);
        end;

        IF ActiveLoanProducts.FindSet then begin
            repeat begin

                Datum.Add('product_id', ActiveLoanProducts."Product ID");
                Datum.Add('loan_name', ActiveLoanProducts."Product Description");
                Datum.Add('product_class_type', Format(ActiveLoanProducts."Product Class Type"));
                Datum.Add('min_guarantors', ActiveLoanProducts."Minimum Guarantors");
                Datum.Add('max_guarantors', ActiveLoanProducts."Maximum Guarantors");
                Datum.Add('min_loan_amount', ActiveLoanProducts."Minimum Loan Amount");
                Datum.Add('max_loan_amount', ActiveLoanProducts."Maximum Loan Amount");
                Datum.Add('interest_min', ActiveLoanProducts."Interest Rate (Min.)");
                Datum.Add('interest_max', ActiveLoanProducts."Interest Rate (Max.)");
                Datum.Add('appraisal_type', Format(ActiveLoanProducts."Appraisal Parameter Type"));
                Datum.Add('interest_calculation_method', Format(ActiveLoanProducts."Interest Calculation Method"));
                Datum.Add('installments', ActiveLoanProducts."Ordinary Default Intallments");
                Datum.Add('category', Format(ActiveLoanProducts.Category));
                Datum.Add('loan_span', Format(ActiveLoanProducts."Loan Span"));
                Datum.Add('repayment_mode', Format(ActiveLoanProducts."Repay Mode"));
                Datum.Add('source_unit', Format(ActiveLoanProducts."Source Unit"));
                Datum.Add('priority', ActiveLoanProducts."Disbursement Priority");
                Datum.Add('status', Format(ActiveLoanProducts.Status));

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until ActiveLoanProducts.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanSectors(): Text
    var
        LoanSectorsMain: Record "Sectoral Classification";
        LoanSectorsSub1: Record "Sectoral Classification";
        LoanSectorsSub2: Record "Sectoral Classification";

        ResponseObject: JsonObject;

        Data: JsonArray;
        DataSub1: JsonArray;
        DataSub2: JsonArray;

        Datum: JsonObject;
        DatumSub1: JsonObject;
        DatumSub2: JsonObject;

        Response: Text;
    begin
        // Main Sector
        LoanSectorsMain.Reset;

        LoanSectorsMain.SetRange("Sector Level", LoanSectorsMain."Sector Level"::"Main Sector");

        IF LoanSectorsMain.FindSet then begin
            repeat begin
                Datum.Add('sector_code', LoanSectorsMain."Sector Code");
                Datum.Add('sector_description', LoanSectorsMain."Sector Description");
                Datum.Add('parent_sector', LoanSectorsMain."Parent Sector");
                Datum.Add('sector_level', Format(LoanSectorsMain."Sector Level"));

                // Sub Sector 1
                LoanSectorsSub1.Reset;
                LoanSectorsSub1.SetRange("Sector Level", LoanSectorsMain."Sector Level"::"Sub Sector Level 1");
                LoanSectorsSub1.SetRange("Parent Sector", LoanSectorsMain."Sector Code");

                IF LoanSectorsSub1.FindSet then begin
                    repeat begin
                        DatumSub1.Add('sector_code', LoanSectorsSub1."Sector Code");
                        DatumSub1.Add('sector_description', LoanSectorsSub1."Sector Description");
                        DatumSub1.Add('parent_sector', LoanSectorsSub1."Parent Sector");
                        DatumSub1.Add('sector_level', Format(LoanSectorsSub1."Sector Level"));

                        // Sub Sector 2
                        LoanSectorsSub2.Reset;
                        LoanSectorsSub2.SetRange("Sector Level", LoanSectorsMain."Sector Level"::"Sub Sector Level 2");
                        LoanSectorsSub2.SetRange("Parent Sector", LoanSectorsSub1."Sector Code");

                        IF LoanSectorsSub2.FindSet then begin
                            repeat begin
                                DatumSub2.Add('sector_code', LoanSectorsSub2."Sector Code");
                                DatumSub2.Add('sector_description', LoanSectorsSub2."Sector Description");
                                DatumSub2.Add('parent_sector', LoanSectorsSub2."Parent Sector");
                                DatumSub2.Add('sector_level', Format(LoanSectorsSub2."Sector Level"));

                                DataSub2.Add(DatumSub2);

                                // Reset
                                DatumSub2.ReadFrom('{}');
                            end until LoanSectorsSub2.Next = 0;
                        end;

                        DatumSub1.Add('sub_sectors', DataSub2);
                        DataSub1.Add(DatumSub1);

                        // Reset
                        DatumSub1.ReadFrom('{}');
                        DataSub2.ReadFrom('[]');
                    end until LoanSectorsSub1.Next = 0;
                end;

                Datum.Add('sub_sectors', DataSub1);
                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
                DataSub1.ReadFrom('[]');
            end until LoanSectorsMain.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanPurposes(): Text
    var
        LoanPurposes: Record "Loan Purpose";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        LoanPurposes.Reset;

        IF LoanPurposes.FindSet then begin
            repeat begin

                Datum.Add('code', LoanPurposes.Code);
                Datum.Add('description', LoanPurposes.Description);

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until LoanPurposes.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure SearchMembers(Payload: JsonObject): Text
    var
        filter_property: JsonToken;
        filter_value: JsonToken;

        SearchMembers: Record Members;
        DimensionValue: Record "Dimension Value";

        MemberLoaningDetails: JsonObject;

        MajorLoansCount: JsonToken;
        MinorLoansCount: JsonToken;
        MaxMajorLoansCount: JsonToken;
        MaxMinorLoansCount: JsonToken;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('filter_property', filter_property); // phone_number, primary_identification, email_address, kra_pin_number, pf_number
        Payload.Get('filter_value', filter_value);

        SearchMembers.Reset;
        // SearchMembers.SetRange(Status, Format(SearchMembers.Status::Active));

        case filter_property.AsValue.AsText of
            'phone_number':
                SearchMembers.SetRange("Phone No.", filter_value.AsValue.AsText);
            'primary_identification':
                SearchMembers.SetRange("Primary Identification", filter_value.AsValue.AsText);
            'email_address':
                SearchMembers.SetRange("E-Mail", filter_value.AsValue.AsText);
            'kra_pin_number':
                SearchMembers.SetRange("P.I.N Number", filter_value.AsValue.AsText);
            'pf_number':
                SearchMembers.SetRange("Payroll/Staff No.", filter_value.AsValue.AsText);
            'no':
                SearchMembers.SetRange("No.", filter_value.AsValue.AsText);
            'passport_number':
                begin
                    SearchMembers.SetRange("Primary Identification Type", SearchMembers."Primary Identification Type"::"Passport No");
                    SearchMembers.SetRange("Primary Identification", filter_value.AsValue.AsText);

                    if not SearchMembers.FindFirst then begin
                        SearchMembers.Reset;
                        SearchMembers.SetRange("Secondary Identification Type", SearchMembers."Secondary Identification Type"::"Passport No");
                        SearchMembers.SetRange("Secondary Identification", filter_value.AsValue.AsText);
                    end;
                end;
            'birth_certificate_number':
                begin
                    SearchMembers.SetRange("Primary Identification Type", SearchMembers."Primary Identification Type"::"Birth Certificate Number");
                    SearchMembers.SetRange("Primary Identification", filter_value.AsValue.AsText);

                    if not SearchMembers.FindFirst then begin
                        SearchMembers.Reset;
                        SearchMembers.SetRange("Secondary Identification Type", SearchMembers."Secondary Identification Type"::"Birth Certificate Number");
                        SearchMembers.SetRange("Secondary Identification", filter_value.AsValue.AsText);
                    end;
                end;
            'id_number':
                begin
                    SearchMembers.SetRange("Primary Identification Type", SearchMembers."Primary Identification Type"::"ID Number");
                    SearchMembers.SetRange("Primary Identification", filter_value.AsValue.AsText);

                    if not SearchMembers.FindFirst then begin
                        SearchMembers.Reset;
                        SearchMembers.SetRange("Secondary Identification Type", SearchMembers."Secondary Identification Type"::"ID Number");
                        SearchMembers.SetRange("Secondary Identification", filter_value.AsValue.AsText);
                    end;
                end;
            'employer_code':
                SearchMembers.SetRange("Employer Code", filter_value.AsValue.AsText);
            else
                SearchMembers.SetRange("No.", filter_value.AsValue.AsText);
        end;

        IF SearchMembers.FindSet then begin
            repeat begin
                Datum.Add('no', SearchMembers."No.");
                Datum.Add('name', SearchMembers.Name);
                Datum.Add('branch_code', SearchMembers."Global Dimension 1 Code");

                DimensionValue.Reset;
                DimensionValue.SetRange("Dimension Code", 'BRANCH');
                DimensionValue.SetRange(Code, SearchMembers."Global Dimension 1 Code");
                if DimensionValue.FindFirst then begin
                    Datum.Add('branch_name', DimensionValue.Name);
                end else begin
                    Datum.Add('branch_name', '');
                end;

                Datum.Add('primary_identification_type', Format(SearchMembers."Primary Identification Type"));
                Datum.Add('primary_identification', SearchMembers."Primary Identification");
                Datum.Add('secondary_identification_type', Format(SearchMembers."Secondary Identification Type"));
                Datum.Add('secondary_identification', SearchMembers."Secondary Identification");

                Datum.Add('email_address', SearchMembers."E-Mail");
                Datum.Add('phone_number', SearchMembers."Phone No.");
                Datum.Add('transactional_mobile_no', SearchMembers."Transactional Mobile Number");
                Datum.Add('kra_pin_number', SearchMembers."P.I.N Number");
                Datum.Add('pf_number', SearchMembers."Payroll/Staff No.");
                Datum.Add('status', Format(SearchMembers.Status));
                Datum.Add('sub_flag', Format(SearchMembers.Subflag));

                MemberLoaningDetails := GlobalFunctions.GetMemberMajorMinorLoansCount(SearchMembers."No.");

                MemberLoaningDetails.Get('major_loans_count', MajorLoansCount);
                MemberLoaningDetails.Get('minor_loans_count', MinorLoansCount);
                MemberLoaningDetails.Get('max_major_loans_count', MaxMajorLoansCount);
                MemberLoaningDetails.Get('max_minor_loans_count', MaxMinorLoansCount);

                Datum.Add('guarantorship_major_loans_count', MajorLoansCount);
                Datum.Add('guarantorship_minor_loans_count', MinorLoansCount);
                Datum.Add('guarantorship_max_major_loans_count', MaxMajorLoansCount);
                Datum.Add('guarantorship_max_minor_loans_count', MaxMinorLoansCount);

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until SearchMembers.Next = 0;
        end else begin
            Error('Member(s) with identification %1 = %2 NOT found.', filter_property.AsValue.AsText, filter_value.AsValue.AsText);
        end;
        ;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMembers(Payload: JsonObject): Text
    var
        filter_property: JsonToken;
        filter_value: JsonToken;
        page_number: JsonToken;
        page_size: JsonToken;

        SearchMembers: Record Members;
        DimensionValue: Record "Dimension Value";

        KeyExists: Boolean;

        Count: Integer;
        FirstRow: Integer;
        LastRow: Integer;
        TotalFoundRecords: Integer;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        KeyExists := Payload.Get('filter_property', filter_property); // phone_number, birth_certificate_number, id_number, passport_number, names, payroll_number, email_address, kra_pin_number, membership_number, company_reg_no
        KeyExists := Payload.Get('filter_value', filter_value);
        Payload.Get('page_number', page_number);
        Payload.Get('page_size', page_size);

        SearchMembers.Reset;

        if (not filter_property.AsValue.IsNull) and (not filter_value.AsValue.IsNull) then begin
            if (filter_property.AsValue.AsText <> '') and (filter_value.AsValue.AsText <> '') then begin

                case filter_property.AsValue.AsText of
                    'phone_number':
                        SearchMembers.SetRange("Phone No.", filter_value.AsValue.AsText);
                    'birth_certificate_number':
                        begin
                            SearchMembers.SetRange("Primary Identification Type", SearchMembers."Primary Identification Type"::"Birth Certificate Number");
                            SearchMembers.SetRange("Primary Identification", filter_value.AsValue.AsText);

                            if not SearchMembers.FindFirst then begin
                                SearchMembers.Reset;
                                SearchMembers.SetRange("Secondary Identification Type", SearchMembers."Secondary Identification Type"::"Birth Certificate Number");
                                SearchMembers.SetRange("Secondary Identification", filter_value.AsValue.AsText);
                            end;
                        end;
                    'id_number':
                        begin
                            SearchMembers.SetRange("Primary Identification Type", SearchMembers."Primary Identification Type"::"ID Number");
                            SearchMembers.SetRange("Primary Identification", filter_value.AsValue.AsText);

                            if not SearchMembers.FindFirst then begin
                                SearchMembers.Reset;
                                SearchMembers.SetRange("Secondary Identification Type", SearchMembers."Secondary Identification Type"::"ID Number");
                                SearchMembers.SetRange("Secondary Identification", filter_value.AsValue.AsText);
                            end;
                        end;
                    'passport_number':
                        begin
                            SearchMembers.SetRange("Primary Identification Type", SearchMembers."Primary Identification Type"::"Passport No");
                            SearchMembers.SetRange("Primary Identification", filter_value.AsValue.AsText);

                            if not SearchMembers.FindFirst then begin
                                SearchMembers.Reset;
                                SearchMembers.SetRange("Secondary Identification Type", SearchMembers."Secondary Identification Type"::"Passport No");
                                SearchMembers.SetRange("Secondary Identification", filter_value.AsValue.AsText);
                            end;
                        end;
                    'primary_identification':
                        begin
                            SearchMembers.SetRange("Primary Identification", filter_value.AsValue.AsText);
                        end;
                    'secondary_identification':
                        begin
                            SearchMembers.SetRange("Secondary Identification", filter_value.AsValue.AsText);
                        end;
                    'name':
                        SearchMembers.SetRange(Name, filter_value.AsValue.AsText);
                    'staff_pf_number':
                        begin
                            SearchMembers.SetRange("Payroll/Staff No.", filter_value.AsValue.AsText);
                        end;
                    'email_address':
                        SearchMembers.SetRange("E-Mail", filter_value.AsValue.AsText);
                    'kra_pin_number':
                        SearchMembers.SetRange("P.I.N Number", filter_value.AsValue.AsText);
                    'no':
                        SearchMembers.SetRange("No.", filter_value.AsValue.AsText);
                    'company_reg_no':
                        SearchMembers.SetRange("Company Registration No.", filter_value.AsValue.AsText);
                    'employer_code':
                        SearchMembers.SetRange("Employer Code", filter_value.AsValue.AsText);
                    'branch_code':
                        SearchMembers.SetRange("Global Dimension 1 Code", filter_value.AsValue.AsText);
                    else
                        SearchMembers.SetRange("No.", filter_value.AsValue.AsText);
                end;

            end;
        end;

        SearchMembers.SetCurrentKey("No.");
        SearchMembers.SetAscending("No.", false);

        IF SearchMembers.FindSet then begin
            Count := 0;
            FirstRow := ((page_number.AsValue.AsInteger - 1) * page_size.AsValue.AsInteger) + 1;
            LastRow := page_number.AsValue.AsInteger * page_size.AsValue.AsInteger;

            TotalFoundRecords := SearchMembers.Count;

            repeat begin
                Count += 1;

                if (Count >= FirstRow) and (Count <= LastRow) then begin
                    Datum.Add('no', SearchMembers."No.");
                    Datum.Add('salutation', SearchMembers.Salutation);
                    Datum.Add('first_name', SearchMembers."First Name");
                    Datum.Add('middle_name', SearchMembers."Middle Name");
                    Datum.Add('other_names', SearchMembers."Other Names");
                    Datum.Add('name', SearchMembers.Name);
                    Datum.Add('email_address', SearchMembers."E-Mail");
                    Datum.Add('phone_number', SearchMembers."Phone No.");
                    Datum.Add('kra_pin_number', SearchMembers."P.I.N Number");
                    Datum.Add('staff_pf_number', SearchMembers."Payroll/Staff No.");
                    Datum.Add('company_reg_no', SearchMembers."Company Registration No.");
                    Datum.Add('primary_identification_type', Format(SearchMembers."Primary Identification Type"));
                    Datum.Add('primary_identification', SearchMembers."Primary Identification");
                    Datum.Add('secondary_identification_type', Format(SearchMembers."Secondary Identification Type"));
                    Datum.Add('secondary_identification', SearchMembers."Secondary Identification");
                    Datum.Add('branch_code', SearchMembers."Global Dimension 1 Code");

                    DimensionValue.Reset;
                    DimensionValue.SetRange("Dimension Code", 'BRANCH');
                    DimensionValue.SetRange(Code, SearchMembers."Global Dimension 1 Code");
                    if DimensionValue.FindFirst then begin
                        Datum.Add('branch_name', DimensionValue.Name);
                    end else begin
                        Datum.Add('branch_name', '');
                    end;

                    Datum.Add('employer_code', SearchMembers."Employer Code");

                    SearchMembers.CalcFields("Employer Name");
                    Datum.Add('employer_name', SearchMembers."Employer Name");

                    Datum.Add('employment_designation', SearchMembers."Employment Designation");

                    Datum.Add('status', Format(SearchMembers.Status));
                    Datum.Add('sub_flag', Format(SearchMembers.Subflag));

                    Data.Add(Datum);
                    // Reset
                    Datum.ReadFrom('{}');
                end;
            end until (Count = LastRow) or (SearchMembers.Next = 0);

            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberDetails(Payload: JsonObject): Text
    var
        filter_property: JsonToken;
        filter_value: JsonToken;

        SearchMember: Record Members;
        SearchMemberApplication: Record "Member Application";
        SearchMemberImageData: Record "Image Data";
        DimensionValue: Record "Dimension Value";
        BankCode: Record "Bank Code Structure";
        ElectoralZone: Record "Electoral Zones";
        County: Record "Segment/County/Dividend/Signat";

        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;

        MemberLoaningDetails: JsonObject;

        MajorLoansCount: JsonToken;
        MinorLoansCount: JsonToken;
        MaxMajorLoansCount: JsonToken;
        MaxMinorLoansCount: JsonToken;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('filter_property', filter_property); // phone_number, birth_certificate_number, id_number, passport_number, names, payroll_number, email_address, kra_pin_number, membership_number, company_reg_no
        Payload.Get('filter_value', filter_value);

        SearchMember.Reset;

        case filter_property.AsValue.AsText of
            'phone_number':
                SearchMember.SetRange("Phone No.", filter_value.AsValue.AsText);
            'birth_certificate_number':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"Birth Certificate Number");
                    SearchMember.SetRange("Primary Identification", filter_value.AsValue.AsText);

                    if not SearchMember.FindFirst then begin
                        SearchMember.Reset;
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"Birth Certificate Number");
                        SearchMember.SetRange("Secondary Identification", filter_value.AsValue.AsText);
                    end;
                end;
            'id_number':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"ID Number");
                    SearchMember.SetRange("Primary Identification", filter_value.AsValue.AsText);

                    if not SearchMember.FindFirst then begin
                        SearchMember.Reset;
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"ID Number");
                        SearchMember.SetRange("Secondary Identification", filter_value.AsValue.AsText);
                    end;
                end;
            'passport_number':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"Passport No");
                    SearchMember.SetRange("Primary Identification", filter_value.AsValue.AsText);

                    if not SearchMember.FindFirst then begin
                        SearchMember.Reset;
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"Passport No");
                        SearchMember.SetRange("Secondary Identification", filter_value.AsValue.AsText);
                    end;
                end;
            'primary_identification':
                begin
                    SearchMember.SetRange("Primary Identification", filter_value.AsValue.AsText);
                end;
            'secondary_identification':
                begin
                    SearchMember.SetRange("Secondary Identification", filter_value.AsValue.AsText);
                end;
            'name':
                SearchMember.SetRange(Name, filter_value.AsValue.AsText);
            'payroll_staff_number':
                SearchMember.SetRange("Payroll/Staff No.", filter_value.AsValue.AsText);
            'email_address':
                SearchMember.SetRange("E-Mail", filter_value.AsValue.AsText);
            'kra_pin_number':
                SearchMember.SetRange("P.I.N Number", filter_value.AsValue.AsText);
            'member_no':
                SearchMember.SetRange("No.", filter_value.AsValue.AsText);
            'company_reg_no':
                SearchMember.SetRange("Company Registration No.", filter_value.AsValue.AsText);
            else
                SearchMember.SetRange("No.", filter_value.AsValue.AsText);
        end;

        IF SearchMember.FindFirst() then begin
            SearchMember.CalcFields(
                "Employer Name",
                "Last Transaction Date",
                "Any Physical Disability",
                "Branch Name",
                "Activity Name");

            Datum.Add('member_no', SearchMember."No.");
            Datum.Add('salutation', SearchMember.Salutation);
            Datum.Add('name', SearchMember.Name);
            Datum.Add('first_name', SearchMember."First Name");
            Datum.Add('middle_name', SearchMember."Middle Name");
            Datum.Add('other_names', SearchMember."Other Names");
            Datum.Add('primary_identification_type', SearchMember."Primary Identification Type".AsInteger);
            Datum.Add('primary_identification_type_desc', Format(SearchMember."Primary Identification Type"));
            Datum.Add('primary_identification', SearchMember."Primary Identification");
            Datum.Add('secondary_identification_type', SearchMember."Secondary Identification Type".AsInteger);
            Datum.Add('secondary_identification_type_desc', Format(SearchMember."Secondary Identification Type"));
            Datum.Add('secondary_identification', SearchMember."Secondary Identification");
            Datum.Add('passport_expiry_date', SearchMember."Passport Expiry Date");
            Datum.Add('current_address', SearchMember."Current Address");
            Datum.Add('permanent_address', SearchMember."Home Address");
            Datum.Add('phone_number', SearchMember."Phone No.");
            Datum.Add('transactional_mobile_no', SearchMember."Transactional Mobile Number");
            Datum.Add('office_telephone_number', SearchMember."Office Telephone No.");
            Datum.Add('email_address', SearchMember."E-Mail");
            Datum.Add('kra_pin_number', SearchMember."P.I.N Number");
            Datum.Add('payroll_staff_number', SearchMember."Payroll/Staff No.");
            Datum.Add('currency_code', SearchMember."Currency Code");
            Datum.Add('nationality', SearchMember.Nationality);
            Datum.Add('date_of_birth', GlobalFunctions.FormatISODate(SearchMember."Date of Birth"));
            Datum.Add('marital_status', SearchMember."Marital Status".AsInteger);
            Datum.Add('marital_status_desc', Format(SearchMember."Marital Status"));
            Datum.Add('gender', SearchMember.Gender.AsInteger);
            Datum.Add('gender_desc', Format(SearchMember.Gender));
            Datum.Add('blocked', SearchMember.Blocked);
            Datum.Add('branch_code', SearchMember."Branch Code");
            Datum.Add('branch_name', SearchMember."Branch Name");
            Datum.Add('post_code', SearchMember."Post Code");
            Datum.Add('status', SearchMember.Status.AsInteger);
            Datum.Add('status_desc', Format(SearchMember.Status));
            Datum.Add('sub_flag', SearchMember.Subflag.AsInteger);
            Datum.Add('sub_flag_desc', Format(SearchMember.Subflag));
            Datum.Add('is_self_employed', SearchMember."Self Employed");
            Datum.Add('employer_code', SearchMember."Employer Code");
            Datum.Add('employer_name', SearchMember."Employer Name");
            Datum.Add('employment_designation', SearchMember."Employment Designation");
            Datum.Add('terms_of_employment', SearchMember."Terms of Employment".AsInteger);
            Datum.Add('terms_of_employment_desc', Format(SearchMember."Terms of Employment"));

            Datum.Add('county', SearchMember.County);
            County.Reset;
            County.SetRange(Code, SearchMember.County);
            County.SetRange(Type, County.Type::County);
            if County.FindFirst then begin
                Datum.Add('county_desc', County.Description);
            end else begin
                Datum.Add('county_desc', '');
            end;

            Datum.Add('sub_county', SearchMember."Sub-County");
            County.Reset;
            County.SetRange(Code, SearchMember."Sub-County");
            County.SetRange(Type, County.Type::"Sub-County");
            if County.FindFirst then begin
                Datum.Add('sub_county_desc', County.Description);
            end else begin
                Datum.Add('sub_county_desc', '');
            end;

            Datum.Add('city', SearchMember.City);
            Datum.Add('work_station', SearchMember."Work Station");
            Datum.Add('country_of_operation', SearchMember."Country Of Operation");
            Datum.Add('account_category', SearchMember."Account Category".AsInteger);
            Datum.Add('account_category_desc', Format(SearchMember."Account Category"));
            Datum.Add('group_account_no', SearchMember."Group Account No.");
            Datum.Add('type_of_application', SearchMember."Type of Application".AsInteger);
            Datum.Add('type_of_application_desc', Format(SearchMember."Type of Application"));
            Datum.Add('member_class', SearchMember."Member Class");
            Datum.Add('account_type', SearchMember."Account Type");
            Datum.Add('account_type_desc', Format(SearchMember."Account Type"));
            Datum.Add('account_profile', SearchMember."Account Profile");
            Datum.Add('account_profile_desc', Format(SearchMember."Account Profile"));
            Datum.Add('religion', SearchMember.Religion);
            Datum.Add('created_by', SearchMember."Created By");
            Datum.Add('company_reg_no', SearchMember."Company Registration No.");

            // -----------------------------------------------

            Datum.Add('bank_code', SearchMember."Bank Code");

            BankCode.Reset;
            BankCode.SetRange("Parent Code", '');
            BankCode.SetRange(Code, SearchMember."Bank Code");
            if BankCode.FindFirst then begin
                Datum.Add('bank_code_desc', BankCode.Name);
            end else begin
                Datum.Add('bank_code_desc', '');
            end;

            // -----------------------------------------------

            Datum.Add('bank_branch_code', SearchMember."Branch Code");

            BankCode.Reset;
            BankCode.SetRange("Parent Code", SearchMember."Bank Code");
            BankCode.SetRange(Code, SearchMember."Branch Code");
            if BankCode.FindFirst then begin
                Datum.Add('bank_branch_code_desc', BankCode.Name);
            end else begin
                Datum.Add('bank_branch_code_desc', '');
            end;

            Datum.Add('bank_account_no', SearchMember."Bank Account No.");
            Datum.Add('rejoining_date', GlobalFunctions.FormatISODate(SearchMember."Rejoinig Date"));
            Datum.Add('is_from_another_sacco', SearchMember."From Another Sacco");
            Datum.Add('has_physical_disability', SearchMember."Any Physical Disability");
            Datum.Add('status_change_statistics', SearchMember."Status Change Statistics");
            Datum.Add('last_transaction_date', GlobalFunctions.FormatISODate(SearchMember."Last Transaction Date"));
            Datum.Add('old_member_no', SearchMember."Old Member No.");
            Datum.Add('principle_member', SearchMember."Principle Member");
            Datum.Add('recruited_by_type', SearchMember."Recruited By Type".AsInteger);
            Datum.Add('recruited_by_type_desc', Format(SearchMember."Recruited By Type"));
            Datum.Add('recruited_by', SearchMember."Recruited By");
            Datum.Add('recruited_by_name', SearchMember."Recruited By Name");
            Datum.Add('has_joined_business_loans', SearchMember."Has Joined Business Loans");

            Datum.Add('delegate_zone', SearchMember."Delegates Zone");

            ElectoralZone.Reset;
            ElectoralZone.SetRange(Code, SearchMember."Delegates Zone");

            if ElectoralZone.FindFirst then begin
                Datum.Add('delegate_zone_desc', ElectoralZone."Electoral Zone Name");
            end else begin
                Datum.Add('delegate_zone_desc', '');
            end;

            Datum.Add('crm_application_no', SearchMember."CRM Application No.");
            Datum.Add('company_registration_no', SearchMember."Company Registration No.");
            Datum.Add('allocated_officer', SearchMember."Allocated Officer");
            Datum.Add('allocated_officer_name', SearchMember."Allocated Officer Name");

            SearchMemberImageData.Reset;
            SearchMemberImageData.SetRange("Member No", SearchMember."No.");
            IF SearchMemberImageData.FindFirst then begin
                // Picture
                SearchMemberImageData.CalcFields(Picture);
                TempBlob.FromRecord(SearchMemberImageData, SearchMemberImageData.FieldNo(Picture));
                TempBlob.CreateInStream(InStr);
                Datum.Add('picture', Base64Convert.ToBase64(InStr));

                // Signature
                SearchMemberImageData.CalcFields(Signature);
                TempBlob.FromRecord(SearchMemberImageData, SearchMemberImageData.FieldNo(Signature));
                TempBlob.CreateInStream(InStr);
                Datum.Add('signature', Base64Convert.ToBase64(InStr));
            end else begin
                Datum.Add('picture', '');
                Datum.Add('signature', '');
            end;

            Datum.Add('registration_date', GlobalFunctions.FormatISODate(SearchMember."Registration Date"));

            SearchMemberApplication.Reset;
            SearchMemberApplication.SetRange("No.", SearchMember."Application No.");

            if SearchMemberApplication.FindFirst then begin
                Datum.Add('contribution_amount', SearchMemberApplication."Contribution Amount");
            end else begin
                Datum.Add('contribution_amount', 0.0);
            end;

            Datum.Add('contribution_start_date', GlobalFunctions.FormatISODate(SearchMember."Contribution Start Date"));
            Datum.Add('contribution_effective_date', GlobalFunctions.FormatISODate(SearchMember."Contribution Effective Date"));
            Datum.Add('preferred_fosa_branch', SearchMember."Global Dimension 1 Code");

            DimensionValue.Reset;
            DimensionValue.SetRange("Dimension Code", 'BRANCH');
            DimensionValue.SetRange(Code, SearchMember."Global Dimension 1 Code");
            if DimensionValue.FindFirst then begin
                Datum.Add('preferred_fosa_branch_desc', DimensionValue.Name);
            end else begin
                Datum.Add('preferred_fosa_branch_desc', '');
            end;

            MemberLoaningDetails := GlobalFunctions.GetMemberMajorMinorLoansCount(SearchMember."No.");

            MemberLoaningDetails.Get('major_loans_count', MajorLoansCount);
            MemberLoaningDetails.Get('minor_loans_count', MinorLoansCount);
            MemberLoaningDetails.Get('max_major_loans_count', MaxMajorLoansCount);
            MemberLoaningDetails.Get('max_minor_loans_count', MaxMinorLoansCount);

            Datum.Add('guarantorship_major_loans_count', MajorLoansCount);
            Datum.Add('guarantorship_minor_loans_count', MinorLoansCount);
            Datum.Add('guarantorship_max_major_loans_count', MaxMajorLoansCount);
            Datum.Add('guarantorship_max_minor_loans_count', MaxMinorLoansCount);


            Datum.Add('last_date_modified', SearchMember."Last Date Modified");
        end else begin
            Error('Member with identification %1 = %2 NOT found.', filter_property.AsValue.AsText, filter_value.AsValue.AsText);
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CreateLoanApplication(Payload: JsonObject): Text
    var
        member_number: JsonToken;
        loan_product_type: JsonToken;
        loan_requested_amount: JsonToken;
        loan_duration: JsonToken;
        loan_purpose: JsonToken;
        loan_priority: JsonToken;
        crm_application_no: JsonToken;
        guarantors: JsonToken;
        sasra_main_sector: JsonToken;
        sasra_sub_sector_1: JsonToken;
        sasra_sub_sector_2: JsonToken;
        self_guarantee: JsonToken;
        crm_notes: JsonToken;
        crm_originating_branch: JsonToken;
        crm_created_by: JsonToken;

        guarantor: JsonToken;
        guarantor_member_number: JsonToken;
        guarantor_amount: JsonToken;

        loans_to_be_cleared: JsonToken;
        loan_to_be_cleared: JsonToken;

        KeyExists: Boolean;

        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        // CRMNewNo: Code[20];
        // CRMNewNoSeriesCode: Code[20];

        LoanApplication: Record Loans;
        LoanProduct: Record "Product Factory";
        Member: Record Members;
        GuarantorsApplication: Record "Loan Guarantors and Security";
        GuarantorSavingsAccount: Record "Savings Accounts";
        Comment: Record "Loan Appraisal Comments";
        LoansToBeCleared: Record "Loans Top up";
        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        KeyExists := Payload.Get('member_number', member_number);
        KeyExists := Payload.Get('loan_product_type', loan_product_type);
        KeyExists := Payload.Get('loan_requested_amount', loan_requested_amount);
        KeyExists := Payload.Get('loan_duration', loan_duration);
        KeyExists := Payload.Get('loan_purpose', loan_purpose);
        KeyExists := Payload.Get('loan_priority', loan_priority);
        KeyExists := Payload.Get('sasra_main_sector', sasra_main_sector);
        KeyExists := Payload.Get('sasra_sub_sector_1', sasra_sub_sector_1);
        KeyExists := Payload.Get('sasra_sub_sector_2', sasra_sub_sector_2);
        KeyExists := Payload.Get('crm_application_no', crm_application_no);
        KeyExists := Payload.Get('crm_notes', crm_notes);
        KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);
        KeyExists := Payload.Get('crm_created_by', crm_created_by);

        KeyExists := Payload.Get('loans_to_be_cleared', loans_to_be_cleared);
        KeyExists := Payload.Get('guarantors', guarantors);

        Member.Reset;
        Member.SetRange("No.", member_number.AsValue.AsText);

        if Member.FindFirst then begin
            LoanApplication.Init;

            LoanApplication."Member No." := member_number.AsValue.AsText;
            LoanApplication.Validate("Member No."); //

            LoanApplication."Application Date" := DT2Date(CurrentDateTime);
            LoanApplication.Validate("Application Date");

            LoanApplication."Loan Product Type" := loan_product_type.AsValue.AsText;
            LoanProduct.Reset;
            LoanProduct.SetRange("Product ID", LoanApplication."Loan Product Type");

            if LoanProduct.FindFirst then begin
                LoanApplication."Source Unit" := LoanProduct."Source Unit";
                LoanApplication."Loan Product Type Name" := LoanProduct."Product Description";
            end else begin
                LoanApplication."Source Unit" := LoanApplication."Source Unit"::BOSA;
                LoanApplication."Loan Product Type Name" := '';
            end;

            LoanApplication."Source" := LoanApplication.Source::CREDIT;
            LoanApplication.Validate("Loan Product Type");

            LoanApplication.Status := LoanApplication.Status::Open;

            case LoanApplication."Source Unit" of
                LoanApplication."Source Unit"::BOSA:
                    begin
                        LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::BOSA);
                    end;
                LoanApplication."Source Unit"::FOSA:
                    begin
                        LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::FOSA);
                    end;
                LoanApplication."Source Unit"::"BUSINESS LOANS":
                    begin
                        LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::BLOANS);
                    end;
                LoanApplication."Source Unit"::"HR LOANS":
                    begin
                        LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::HR);
                    end;
                else
                    LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::BOSA);
            end;

            LoanApplication."Purpose of Loan" := loan_purpose.AsValue.AsText;
            LoanApplication."Loan Appl.form No." := '';
            LoanApplication."Comment for Exemptions" := '';

            if crm_created_by.AsValue.AsText = '' then begin
                Error('ERR_401. Invalid application. Origination NOT accepted!');
            end;

            LoanApplication."CRM Created By" := crm_created_by.AsValue.AsText;
            LoanApplication."CRM Originating Branch" := crm_originating_branch.AsValue.AsText;
            LoanApplication."CRM Notes" := crm_notes.AsValue.AsText;
            LoanApplication."CRM Priority" := loan_priority.AsValue.AsInteger;

            LoanApplication.Installments := loan_duration.AsValue.AsInteger;
            LoanApplication.Validate(Installments);

            LoanApplication."Main Sector" := sasra_main_sector.AsValue.AsText;
            LoanApplication.Validate("Main Sector");
            LoanApplication."Sub Sector Level1" := sasra_sub_sector_1.AsValue.AsText;
            LoanApplication.Validate("Sub Sector Level1");
            LoanApplication."Sub Sector Level2" := sasra_sub_sector_2.AsValue.AsText;
            LoanApplication.Validate("Sub Sector Level2");

            LoanApplication."Member Name" := Member.Name;
            LoanApplication.Validate("Member No.");

            // LoanApplication."Captured By" := crm_created_by.AsValue.AsText;
            LoanApplication."Captured By" := 'CRM';
            LoanApplication."CRM Created By" := crm_created_by.AsValue.AsText;

            // if LoanApplication."Source Unit" = LoanApplication."Source Unit"::FOSA then begin
            //     SeriesSetup.Get;
            //     SeriesSetup.TestField(SeriesSetup."CRM - FOSA Loan");
            //     NoSeriesMgt.InitSeries(SeriesSetup."CRM - FOSA Loan", SeriesSetup."CRM - FOSA Loan", 0D, CRMNewNo, CRMNewNoSeriesCode);
            // end else
            //     if LoanApplication."Source Unit" = LoanApplication."Source Unit"::BOSA then begin
            //         SeriesSetup.Get;
            //         SeriesSetup.TestField(SeriesSetup."CRM - BOSA Loan");
            //         NoSeriesMgt.InitSeries(SeriesSetup."CRM - BOSA Loan", SeriesSetup."CRM - BOSA Loan", 0D, CRMNewNo, CRMNewNoSeriesCode);
            //     end else begin
            //         SeriesSetup.Get;
            //         SeriesSetup.TestField(SeriesSetup."CRM - Loan Applications");
            //         NoSeriesMgt.InitSeries(SeriesSetup."CRM - Loan Applications", SeriesSetup."CRM - Loan Applications", 0D, CRMNewNo, CRMNewNoSeriesCode);
            //     end;

            // LoanApplication."CRM Application No." := CRMNewNo;
            // LoanApplication."CRM No. Series" := CRMNewNoSeriesCode;

            LoanApplication."Sent Back to CRM" := false;
            LoanApplication."Source Aplication" := LoanApplication."Source Aplication"::CRM;

            LoanApplication."Requested Amount" := loan_requested_amount.AsValue.AsInteger;
            LoanApplication.Validate("Requested Amount");

            IF LoanApplication.Insert(true) then begin
                LoanApplication."CRM Application No." := LoanApplication."Loan No.";
                LoanApplication."CRM No. Series" := LoanApplication."No. Series";

                LoanProduct.Reset;
                LoanProduct.SetRange("Product ID", LoanApplication."Loan Product Type");
                if LoanProduct.FindFirst then begin
                    LoanApplication."Global Dimension 2 Code" := LoanProduct."Global Dimension 2 Code";
                end else begin
                    LoanApplication."Global Dimension 2 Code" := LoanApplication."Responsibility Center";
                end;

                LoanApplication.Modify();

                // CRM Comments/Notes
                if crm_notes.AsValue.AsText <> '' then begin
                    Comment.Init;

                    Comment."Loan No." := LoanApplication."Loan No.";
                    Comment.Comment := crm_notes.AsValue.AsText;
                    Comment.Appraiser := crm_created_by.AsValue.AsText;
                    Comment."Entry Date" := Today;
                    Comment."Entry Time" := Time;
                    Comment.Commented := true;

                    Comment.Insert(false);
                end;

                // Guarantors
                foreach guarantor in guarantors.AsArray do begin
                    guarantor.AsObject.Get('member_number', guarantor_member_number);
                    guarantor.AsObject.Get('amount', guarantor_amount);

                    GuarantorsApplication.Init();

                    GuarantorSavingsAccount.Reset;
                    GuarantorSavingsAccount.SetRange("Member No.", guarantor_member_number.AsValue.AsText);
                    GuarantorSavingsAccount.SetFilter("Product Category", '=%1', GuarantorSavingsAccount."Product Category"::"BOSA Deposits");

                    IF GuarantorSavingsAccount.FindFirst then begin
                        GuarantorsApplication."Loan No" := LoanApplication."Loan No.";

                        GuarantorsApplication."Guarantor Type" := GuarantorsApplication."Guarantor Type"::Guarantor;
                        GuarantorsApplication.Validate("Guarantor Type");

                        GuarantorsApplication."Staff/Payroll No." := GuarantorSavingsAccount."Payroll/Staff No.";

                        GuarantorsApplication."Savings Account No./Member No." := GuarantorSavingsAccount."No.";

                        GuarantorsApplication."Amount Guaranteed" := guarantor_amount.AsValue.AsDecimal;

                        GuarantorsApplication.Name := GuarantorSavingsAccount.Name;
                        GuarantorsApplication.Date := DT2Date(CurrentDateTime);
                        GuarantorsApplication."Member No" := GuarantorSavingsAccount."Member No.";

                        KeyExists := GuarantorsApplication.Insert();
                    end;

                    GuarantorsApplication.Reset();
                end;

                // Loans to be cleared
                LoanApplication."Approved Amount" := LoanApplication."Requested Amount";
                LoanApplication.Modify;

                foreach loan_to_be_cleared in loans_to_be_cleared.AsArray do begin
                    LoansToBeCleared.Init;

                    LoansToBeCleared."Loan No." := LoanApplication."Loan No.";
                    LoansToBeCleared."Client Code" := LoanApplication."Member No.";
                    LoansToBeCleared."Loan Top Up" := loan_to_be_cleared.AsValue.AsText;

                    LoansToBeCleared.Validate("Loan Top Up");
                    LoansToBeCleared.Validate("Principle Top Up");
                    LoansToBeCleared.Validate("Interest Top Up");

                    LoansToBeCleared.Insert;
                end;

                if LoanApplication."Source Unit" = LoanApplication."Source Unit"::"BUSINESS LOANS" then begin

                    EDMSFunctions.EDMSScannedLog(
                        LoanApplication."Loan No.",
                        "CRM Originations"::"Business Loans Application",
                        LoanApplication."Member No.",
                        LoanApplication."CRM Created By",
                        LoanApplication."CRM Originating Branch"
                    );

                end else begin

                    EDMSFunctions.EDMSScannedLog(
                        LoanApplication."Loan No.",
                        "CRM Originations"::"Loan Application",
                        LoanApplication."Member No.",
                        LoanApplication."CRM Created By",
                        LoanApplication."CRM Originating Branch"
                    );

                end;

                // Handle CRM branch assigmnent
                LoanApplication."Global Dimension 1 Code" := GlobalFunctions.GetBranchCodeFromCRMOrigination(LoanApplication."CRM Originating Branch");
                LoanApplication.Modify;

                LoanApplication.Reset();

                LoanApplication.SetRange("Loan No.", LoanApplication."Loan No.");
                ResponseData.Add('application_number', LoanApplication."Loan No.");
                ResponseData.Add('application_status', Format(LoanApplication.Status));

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('description', 'Loan application with CRM application number ' + LoanApplication."Loan No." + ' has been created successfully.');
                ResponseObject.Add('data', ResponseData);
                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
            end else begin
                Error('Unable to create loan application.');
            end;
        end else begin

            Error('Unknown member with member number ' + member_number.AsValue.AsText);
        end;

        exit(Response);
    end;

    local procedure UpdateLoanApplication(Payload: JsonObject): Text
    var
        application_no: JsonToken;
        member_number: JsonToken;
        loan_product_type: JsonToken;
        loan_requested_amount: JsonToken;
        loan_duration: JsonToken;
        loan_purpose: JsonToken;
        loan_priority: JsonToken;
        crm_application_no: JsonToken;
        guarantors: JsonToken;
        sasra_main_sector: JsonToken;
        sasra_sub_sector_1: JsonToken;
        sasra_sub_sector_2: JsonToken;
        self_guarantee: JsonToken;
        crm_notes: JsonToken;
        crm_originating_branch: JsonToken;
        crm_created_by: JsonToken;

        guarantor: JsonToken;
        guarantor_member_number: JsonToken;
        guarantor_amount: JsonToken;

        loans_to_be_cleared: JsonToken;
        loan_to_be_cleared: JsonToken;

        KeyExists: Boolean;

        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        // CRMNewNo: Code[20];
        // CRMNewNoSeriesCode: Code[20];

        LoanApplication: Record Loans;
        LoanProduct: Record "Product Factory";
        Member: Record Members;
        GuarantorsApplication: Record "Loan Guarantors and Security";
        GuarantorSavingsAccount: Record "Savings Accounts";
        Comment: Record "Loan Appraisal Comments";
        LoansToBeCleared: Record "Loans Top up";

        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        KeyExists := Payload.Get('application_no', application_no);
        KeyExists := Payload.Get('member_number', member_number);
        KeyExists := Payload.Get('loan_product_type', loan_product_type);
        KeyExists := Payload.Get('loan_requested_amount', loan_requested_amount);
        KeyExists := Payload.Get('loan_duration', loan_duration);
        KeyExists := Payload.Get('loan_purpose', loan_purpose);
        KeyExists := Payload.Get('loan_priority', loan_priority);
        KeyExists := Payload.Get('sasra_main_sector', sasra_main_sector);
        KeyExists := Payload.Get('sasra_sub_sector_1', sasra_sub_sector_1);
        KeyExists := Payload.Get('sasra_sub_sector_2', sasra_sub_sector_2);
        KeyExists := Payload.Get('crm_application_no', crm_application_no);
        KeyExists := Payload.Get('crm_notes', crm_notes);
        KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);
        KeyExists := Payload.Get('crm_created_by', crm_created_by);
        KeyExists := Payload.Get('loans_to_be_cleared', loans_to_be_cleared);

        KeyExists := Payload.Get('guarantors', guarantors);

        Member.Reset;
        Member.SetRange("No.", member_number.AsValue.AsText);

        if Member.FindFirst then begin
            LoanApplication.Reset;

            LoanApplication.SetRange("Loan No.", application_no.AsValue.AsText);
            LoanApplication.SetRange("Sent Back to CRM", true);

            if LoanApplication.FindFirst then begin
                LoanApplication."Member No." := member_number.AsValue.AsText;
                LoanApplication.Validate("Member No."); //

                LoanApplication."Application Date" := DT2Date(CurrentDateTime);
                LoanApplication.Validate("Application Date");

                LoanApplication."Loan Product Type" := loan_product_type.AsValue.AsText;
                LoanProduct.Reset;
                LoanProduct.SetRange("Product ID", LoanApplication."Loan Product Type");

                if LoanProduct.FindFirst then begin
                    LoanApplication."Source Unit" := LoanProduct."Source Unit";
                    LoanApplication."Loan Product Type Name" := LoanProduct."Product Description";
                end else begin
                    LoanApplication."Source Unit" := LoanApplication."Source Unit"::BOSA;
                    LoanApplication."Loan Product Type Name" := '';
                end;

                LoanApplication."Source" := LoanApplication.Source::CREDIT;
                LoanApplication.Validate("Loan Product Type");

                LoanApplication.Status := LoanApplication.Status::Open;

                case LoanApplication."Source Unit" of
                    LoanApplication."Source Unit"::BOSA:
                        begin
                            LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::BOSA);
                        end;
                    LoanApplication."Source Unit"::FOSA:
                        begin
                            LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::FOSA);
                        end;
                    LoanApplication."Source Unit"::"BUSINESS LOANS":
                        begin
                            LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::BLOANS);
                        end;
                    LoanApplication."Source Unit"::"HR LOANS":
                        begin
                            LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::HR);
                        end;
                    else
                        LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::BOSA);
                end;

                LoanApplication."Purpose of Loan" := loan_purpose.AsValue.AsText;
                LoanApplication."Loan Appl.form No." := '';
                LoanApplication."Comment for Exemptions" := '';

                // LoanApplication."CRM Created By" := crm_created_by.AsValue.AsText;
                LoanApplication."CRM Originating Branch" := crm_originating_branch.AsValue.AsText;
                LoanApplication."CRM Notes" := crm_notes.AsValue.AsText;
                LoanApplication."CRM Priority" := loan_priority.AsValue.AsInteger;

                LoanApplication.Installments := loan_duration.AsValue.AsInteger;
                LoanApplication.Validate(Installments);

                LoanApplication."Main Sector" := sasra_main_sector.AsValue.AsText;
                LoanApplication.Validate("Main Sector");
                LoanApplication."Sub Sector Level1" := sasra_sub_sector_1.AsValue.AsText;
                LoanApplication.Validate("Sub Sector Level1");
                LoanApplication."Sub Sector Level2" := sasra_sub_sector_2.AsValue.AsText;
                LoanApplication.Validate("Sub Sector Level2");

                LoanApplication."Member Name" := Member.Name;
                LoanApplication.Validate("Member No.");

                // LoanApplication."Captured By" := crm_created_by.AsValue.AsText;
                LoanApplication."Captured By" := 'CRM';
                // LoanApplication."CRM Created By" := crm_created_by.AsValue.AsText;

                LoanApplication."Sent Back to CRM" := false;
                LoanApplication."Source Aplication" := LoanApplication."Source Aplication"::CRM;

                // LoanApplication."Amount To Disburse" := 0;
                LoanApplication."Requested Amount" := loan_requested_amount.AsValue.AsInteger;
                LoanApplication.Validate("Requested Amount");

                IF LoanApplication.Modify(true) then begin
                    // CRM Comments/Notes
                    if crm_notes.AsValue.AsText <> '' then begin
                        Comment.Init;

                        Comment."Loan No." := LoanApplication."Loan No.";
                        Comment.Comment := crm_notes.AsValue.AsText;
                        Comment.Appraiser := crm_created_by.AsValue.AsText;
                        Comment."Entry Date" := Today;
                        Comment."Entry Time" := Time;
                        Comment.Commented := true;

                        Comment.Insert(false);
                    end;


                    // Guarantors
                    GuarantorsApplication.Reset;
                    GuarantorsApplication.SetRange("Loan No", LoanApplication."Loan No.");

                    if GuarantorsApplication.FindSet then begin
                        repeat begin
                            KeyExists := GuarantorsApplication.Delete(true);
                        end until GuarantorsApplication.Next = 0;
                    end;

                    foreach guarantor in guarantors.AsArray do begin
                        guarantor.AsObject.Get('member_number', guarantor_member_number);
                        guarantor.AsObject.Get('amount', guarantor_amount);

                        Clear(GuarantorsApplication);
                        GuarantorsApplication.Init();

                        GuarantorSavingsAccount.Reset;
                        GuarantorSavingsAccount.SetRange("Member No.", guarantor_member_number.AsValue.AsText);
                        GuarantorSavingsAccount.SetFilter("Product Category", '=%1', GuarantorSavingsAccount."Product Category"::"BOSA Deposits");

                        IF GuarantorSavingsAccount.FindFirst then begin
                            GuarantorsApplication."Loan No" := LoanApplication."Loan No.";

                            GuarantorsApplication."Guarantor Type" := GuarantorsApplication."Guarantor Type"::Guarantor;
                            GuarantorsApplication.Validate("Guarantor Type");

                            GuarantorsApplication."Staff/Payroll No." := GuarantorSavingsAccount."Payroll/Staff No.";

                            GuarantorsApplication."Savings Account No./Member No." := GuarantorSavingsAccount."No.";

                            GuarantorsApplication."Amount Guaranteed" := guarantor_amount.AsValue.AsDecimal;

                            GuarantorsApplication.Name := GuarantorSavingsAccount.Name;
                            GuarantorsApplication.Date := DT2Date(CurrentDateTime);
                            GuarantorsApplication."Member No" := GuarantorSavingsAccount."Member No.";

                            KeyExists := GuarantorsApplication.Insert();
                        end;

                        GuarantorsApplication.Reset();
                    end;

                    // Loans to be cleared
                    LoansToBeCleared.Reset;
                    LoansToBeCleared.SetRange("Loan No.", LoanApplication."Loan No.");

                    if LoansToBeCleared.FindSet then begin
                        repeat begin
                            KeyExists := LoansToBeCleared.Delete(true);
                        end until LoansToBeCleared.Next = 0;
                    end;

                    LoanApplication."Approved Amount" := LoanApplication."Requested Amount";

                    LoanProduct.Reset;
                    LoanProduct.SetRange("Product ID", LoanApplication."Loan Product Type");
                    if LoanProduct.FindFirst then begin
                        LoanApplication."Global Dimension 2 Code" := LoanProduct."Global Dimension 2 Code";
                    end else begin
                        LoanApplication."Global Dimension 2 Code" := LoanApplication."Responsibility Center";
                    end;

                    LoanApplication.Modify;

                    foreach loan_to_be_cleared in loans_to_be_cleared.AsArray do begin
                        Clear(LoansToBeCleared);
                        LoansToBeCleared.Init;

                        LoansToBeCleared."Loan No." := LoanApplication."Loan No.";
                        LoansToBeCleared."Client Code" := LoanApplication."Member No.";
                        LoansToBeCleared."Loan Top Up" := loan_to_be_cleared.AsValue.AsText;

                        LoansToBeCleared.Validate("Loan Top Up");
                        LoansToBeCleared.Validate("Principle Top Up");
                        LoansToBeCleared.Validate("Interest Top Up");

                        LoansToBeCleared.Insert;
                    end;

                    // Handle CRM branch assigmnent
                    LoanApplication."Global Dimension 1 Code" := GlobalFunctions.GetBranchCodeFromCRMOrigination(LoanApplication."CRM Originating Branch");
                    LoanApplication.Modify;

                    LoanApplication.Reset();

                    LoanApplication.SetRange("Loan No.", LoanApplication."Loan No.");
                    ResponseData.Add('application_number', LoanApplication."Loan No.");
                    ResponseData.Add('application_status', Format(LoanApplication.Status));

                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('description', 'Loan application with CRM application number ' + LoanApplication."Loan No." + ' has been updated successfully.');
                    ResponseObject.Add('data', ResponseData);
                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                end else begin
                    Error('Unable to update loan application.');
                end;
            end else begin
                Error('Loan application with loan no %1 is NOT available for editing', LoanApplication."Loan No.");
            end;
        end else begin
            Error('Unknown member with member number ' + member_number.AsValue.AsText);
        end;

        exit(Response);
    end;

    local procedure GetLoanApplications(Payload: JsonObject): Text
    var
        filter_property: JsonToken;
        filter_value: JsonToken;
        start_date: JsonToken;
        end_date: JsonToken;
        page_number: JsonToken;
        page_size: JsonToken;
        crm_branch: JsonToken;

        KeyExists: Boolean;

        LoanApplications: Record Loans;
        HREmployees: record "HR Employees";
        SLA: record "Defined SLA";
        Comment: record "Loan Appraisal Comments";
        TheProduct: Record "Product Factory";

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        Durationuptonow: Duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;
        Count: Integer;
        FirstRow: Integer;
        LastRow: Integer;
        TotalFoundRecords: Integer;
        SearchString: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        KeyExists := Payload.Get('filter_property', filter_property);
        KeyExists := Payload.Get('filter_value', filter_value);
        KeyExists := Payload.Get('start_date', start_date);
        KeyExists := Payload.Get('end_date', end_date);
        KeyExists := Payload.Get('crm_branch', crm_branch);
        Payload.Get('page_number', page_number);
        Payload.Get('page_size', page_size);

        LoanApplications.Reset;
        LoanApplications.SetCurrentKey("Application Date");
        LoanApplications.SetAscending("Application Date", false);
        LoanApplications.SetFilter("CRM Application No.", '<>%1', '');
        LoanApplications.SetFilter("Source Unit", '<>%1', LoanApplications."Source Unit"::"HR LOANS");

        if KeyExists then begin
            if (crm_branch.AsValue.AsText <> 'ALL') then begin
                LoanApplications.SetRange(LoanApplications."CRM Originating Branch", crm_branch.AsValue.AsText);
            end;
        end;
        // Search Value
        if (not filter_property.AsValue.IsNull) and (not filter_value.AsValue.IsNull) then begin
            if (filter_property.AsValue.AsText <> '') and (filter_value.AsValue.AsText <> '') then begin
                SearchString := filter_value.AsValue.AsText;

                case filter_property.AsValue.AsText of
                    'application_no':
                        LoanApplications.SetRange(LoanApplications."Loan No.", SearchString);
                    'loan_no':
                        LoanApplications.SetRange(LoanApplications."Loan No.", SearchString);
                    'crm_application_no':
                        LoanApplications.SetRange(LoanApplications."CRM Application No.", SearchString);
                    'member_number':
                        LoanApplications.SetRange(LoanApplications."Member No.", SearchString);
                    'status':
                        LoanApplications.SetFilter(LoanApplications.Status, SearchString);
                    'source_of_application_desc':
                        LoanApplications.SetFilter(LoanApplications."Source Aplication", SearchString);
                    'source_of_application':
                        LoanApplications.SetFilter(LoanApplications."Source Aplication", SearchString);
                    else
                        LoanApplications.SetRange(LoanApplications."Loan No.", SearchString);
                end;
            end;
        end;


        // Start Date & End Date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));

                LoanApplications.SetFilter("Application Date", '>=%1&<=%2', StartDate, EndDate);
            end;
        end;

        IF LoanApplications.FindSet then begin
            // Applications found
            Count := 0;
            FirstRow := ((page_number.AsValue.AsInteger - 1) * page_size.AsValue.AsInteger) + 1;
            LastRow := page_number.AsValue.AsInteger * page_size.AsValue.AsInteger;

            TotalFoundRecords := LoanApplications.Count;

            repeat begin
                Count += 1;

                if (Count >= FirstRow) and (Count <= LastRow) then begin
                    LoanApplications.CalcFields(
                        "Responsible Officer",
                        "Total Balance",
                        "Last Repayment Date",
                        "Total Loan Balance",
                        "Total Disbursed"
                        );

                    Datum.Add('application_no', LoanApplications."Loan No.");
                    Datum.Add('loan_no', LoanApplications."Loan No.");
                    Datum.Add('crm_application_no', LoanApplications."CRM Application No.");
                    Datum.Add('product_name', LoanApplications."Loan Product Type Name");
                    Datum.Add('member_number', LoanApplications."Member No.");
                    Datum.Add('member_name', LoanApplications."Member Name");
                    Datum.Add('amount_applied', LoanApplications."Requested Amount");
                    Datum.Add('application_date', LoanApplications."Application Date");
                    Datum.Add('total_disbursed', LoanApplications."Total Disbursed");
                    Datum.Add('total_balance', LoanApplications."Total Balance");
                    Datum.Add('total_loan_balance', LoanApplications."Total Loan Balance");
                    Datum.Add('last_repayment_date', LoanApplications."Last Repayment Date");
                    Datum.Add('crm_created_by', LoanApplications."CRM Created By");
                    Datum.Add('crm_originating_branch', LoanApplications."CRM Originating Branch");

                    if LoanApplications."Responsible Officer" <> '' then begin
                        Datum.Add('responsible_officer', LoanApplications."Responsible Officer");
                    end else begin
                        if LoanApplications."Relation Officer" <> '' then begin
                            HREmployees.Reset;
                            HREmployees.Get(LoanApplications."Relation Officer");

                            Datum.Add('responsible_officer', HREmployees."Full Name");
                        end else begin
                            Datum.Add('responsible_officer', LoanApplications."Current User");
                        end;
                    end;

                    Datum.Add('supervisor_id', LoanApplications."Approved By");
                    Datum.Add('posted', LoanApplications.Posted);
                    Datum.Add('posted_by', LoanApplications."Posted By");
                    Datum.Add('status', Format(LoanApplications.Status));
                    Datum.Add('is_sent_back_to_crm', LoanApplications."Sent Back to CRM");
                    Datum.Add('source_of_application', LoanApplications."Source Aplication");
                    Datum.Add('source_of_application_desc', Format(LoanApplications."Source Aplication"));
                    Datum.Add('loan_priority', LoanApplications."CRM Priority");
                    Datum.Add('loan_priority_desc', Format(LoanApplications."CRM Priority"));

                    // SLA
                    WorkDays := 0;
                    SLADays := 0;
                    DelayDays := 0;
                    Durationuptonow := 0;
                    StatusComment := '';

                    TheProduct.Reset;
                    TheProduct.SetRange("Product ID", LoanApplications."Loan Product Type");
                    // TheProduct.SetLoadFields("Product ID", "CRM Product SLA Timeline");
                    // TheProduct.SetAutoCalcFields("CRM Product SLA Timeline");

                    if TheProduct.FindFirst then begin
                        // SLADays := TheProduct."CRM Product SLA Timeline";
                    end;

                    if SLADays = 0 then begin
                        SLA.reset();

                        case LoanApplications."Source Unit" of
                            LoanApplications."Source Unit"::"BUSINESS LOANS":
                                begin
                                    SLA.SetRange("Origination Type", SLA."Origination Type"::"BUSINESS LOANS");
                                end;
                            else
                                SLA.SetRange("Origination Type", SLA."Origination Type"::Loans);
                        end;

                        if SLA.findfirst() then
                            SLADays := SLA.SLA;
                    end;

                    if (LoanApplications."Disbursement Date" <> 0D) and (LoanApplications."Application Date" <> 0D) and (LoanApplications."Application Time" <> 0T) and (LoanApplications."disbursement time" <> 0T) then begin
                        Globalfunctions.HoursBetweenPeriods(LoanApplications."Application Date", LoanApplications."Application Time", LoanApplications."Disbursement Date", LoanApplications."disbursement time", Duration, WokedOnANonWorkingPeriod);
                        WorkDays := Duration;
                        DelayDays := WorkDays - (SLADays / 3);
                        IF DelayDays < 0 then DelayDays := 0;
                    end;

                    Durationuptonow := CurrentDateTime - LoanApplications."Application Date Time";

                    Comment.reset();
                    Comment.SetRange("Loan No.", LoanApplications."Loan No.");
                    If Comment.FindLast() then begin
                        StatusComment := Comment.Comment;
                    end;

                    Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
                    Datum.Add('SLA_days', Format(SLADays));
                    Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
                    Datum.Add('duration_uptonow', Format(Durationuptonow));
                    Datum.Add('tat_status', Format(TAtStatus));
                    Datum.Add('status_comment', StatusComment);
                    Datum.Add('priority', Format(Priority));

                    Data.Add(Datum);
                    // Reset
                    Datum.ReadFrom('{}');
                end;
            end until (Count = LastRow) or (LoanApplications.Next = 0);

            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanApplication(Payload: JsonObject): Text
    var
        application_number: JsonToken;

        SearchLoan: Record Loans;
        GuarantorsApplication: Record "Loan Guarantors and Security";
        ApplicationComments: Record "Loan Appraisal Comments";
        LoansTopUp: Record "Loans Top up";
        HREmployees: Record "HR Employees";

        Comments: JsonArray;
        Comment: JsonObject;
        Guarantors: JsonArray;
        Guarantor: JsonObject;
        LoansToBeCleared: JsonArray;
        LoanToBeCleared: JsonObject;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('application_number', application_number);

        SearchLoan.Reset;
        SearchLoan.SetRange("Loan No.", application_number.AsValue.AsText);

        IF SearchLoan.FindFirst() then begin
            SearchLoan.CalcFields(
            "Responsible Officer",
            "Total Balance",
            "Last Repayment Date",
            "Total TopUp",
            "Total Loan Balance",
            "Last Pay Date",
            "Loan Amount",
            "Interest Paid",
            "Principle Paid",
            "Days In Arrears",
            "Total Disbursed"
            );

            Datum.Add('loan_no', SearchLoan."Loan No.");
            Datum.Add('member_number', SearchLoan."Member No.");
            Datum.Add('member_name', SearchLoan."Member Name");
            Datum.Add('loan_product_type', SearchLoan."Loan Product Type");
            Datum.Add('loan_product_name', SearchLoan."Loan Product Type Name");
            Datum.Add('loan_requested_amount', SearchLoan."Requested Amount");
            Datum.Add('loan_duration', SearchLoan.Installments);
            Datum.Add('loan_purpose', SearchLoan."Purpose of Loan");

            Datum.Add('total_balance', SearchLoan."Total Balance");
            Datum.Add('last_repayment_date', SearchLoan."Last Repayment Date");
            Datum.Add('topup_amount', SearchLoan."Total TopUp");
            Datum.Add('total_loan_balance', SearchLoan."Total Loan Balance");
            Datum.Add('last_payment_date', SearchLoan."Last Pay Date");
            Datum.Add('loan_amount', SearchLoan."Loan Amount");
            Datum.Add('total_interest_paid', SearchLoan."Interest Paid");
            Datum.Add('total_principle_paid', SearchLoan."Principle Paid");
            Datum.Add('days_in_arrears', SearchLoan."Days In Arrears");
            Datum.Add('total_disbursed_amount', SearchLoan."Total Disbursed");

            Datum.Add('sasra_main_sector', SearchLoan."Main Sector");
            Datum.Add('sasra_main_sector_desc', SearchLoan."Main Sector Description");
            Datum.Add('sasra_sub_sector_1', SearchLoan."Sub Sector Level1");
            Datum.Add('sasra_sub_sector_1_desc', SearchLoan."Sub Sector Level1 Description");
            Datum.Add('sasra_sub_sector_2', SearchLoan."Sub Sector Level2");
            Datum.Add('sasra_sub_sector_2_desc', SearchLoan."Sub Sector Level2 Description");
            Datum.Add('self_guarantee', SearchLoan."Self Guarantee");
            Datum.Add('application_date', GlobalFunctions.FormatDate(SearchLoan."Application Date"));
            Datum.Add('source_unit', SearchLoan."Source Unit");
            Datum.Add('source_unit_desc', Format(SearchLoan."Source Unit"));
            Datum.Add('captured_by', SearchLoan."Captured By");
            Datum.Add('status', Format(SearchLoan.Status));
            Datum.Add('status_desc', Format(SearchLoan.Status));

            if SearchLoan."Responsible Officer" <> '' then begin
                Datum.Add('responsible_officer', SearchLoan."Responsible Officer");
            end else begin
                if SearchLoan."Relation Officer" <> '' then begin
                    HREmployees.Reset;
                    HREmployees.Get(SearchLoan."Relation Officer");

                    Datum.Add('responsible_officer', HREmployees."Full Name");
                end else begin
                    Datum.Add('responsible_officer', SearchLoan."Current User");
                end;
            end;

            Datum.Add('supervisor_id', SearchLoan."Approved By");
            Datum.Add('crm_application_no', SearchLoan."CRM Application No.");
            Datum.Add('crm_created_by', SearchLoan."CRM Created By");
            Datum.Add('crm_originating_branch', SearchLoan."CRM Originating Branch");
            Datum.Add('crm_notes', SearchLoan."CRM Notes");
            Datum.Add('is_sent_back_to_crm', SearchLoan."Sent Back to CRM");
            Datum.Add('posted', SearchLoan.Posted);
            Datum.Add('posted_by', SearchLoan."Posted By");
            Datum.Add('source_of_application', SearchLoan."Source Aplication");
            Datum.Add('source_of_application_desc', Format(SearchLoan."Source Aplication"));
            Datum.Add('loan_priority', SearchLoan."CRM Priority");
            Datum.Add('loan_priority_desc', Format(SearchLoan."CRM Priority"));

            ApplicationComments.Reset;

            ApplicationComments.SetRange("Loan No.", SearchLoan."Loan No.");
            ApplicationComments.SetCurrentKey("Entry No.");
            ApplicationComments.SetAscending("Entry No.", false);

            if ApplicationComments.FindSet then begin
                repeat begin
                    Comment.Add('comment', ApplicationComments.Comment);
                    Comment.Add('commented_by', ApplicationComments.Appraiser);
                    Comment.Add('date_time', GlobalFunctions.FormatISODateTime(ApplicationComments.SystemCreatedAt));

                    Comment.Add('is_read', ApplicationComments.Commented);

                    Comments.Add(Comment);

                    // Reset
                    Comment.ReadFrom('{}');
                end until ApplicationComments.Next = 0;
            end;
            Datum.Add('comments', Comments);

            GuarantorsApplication.Reset;
            GuarantorsApplication.SetRange("Loan No", SearchLoan."Loan No.");

            if GuarantorsApplication.FindSet then begin
                repeat begin
                    Guarantor.Add('member_number', GuarantorsApplication."Member No");
                    Guarantor.Add('amount', GuarantorsApplication."Amount Guaranteed");

                    Guarantors.Add(Guarantor);

                    // Reset
                    Guarantor.ReadFrom('{}');
                end until GuarantorsApplication.Next = 0;
            end;
            Datum.Add('guarantors', Guarantors);

            // Loans 2 be cleared
            LoansTopUp.Reset;
            LoansTopUp.SetRange("Loan No.", SearchLoan."Loan No.");

            if LoansTopUp.FindSet then begin
                repeat begin
                    LoanToBeCleared.Add('loan_number', LoansTopUp."Loan No.");
                    LoanToBeCleared.Add('loan_top_up', LoansTopUp."Loan Top Up");
                    LoanToBeCleared.Add('member_number', LoansTopUp."Client Code");
                    LoanToBeCleared.Add('loan_type', LoansTopUp."Loan Type");
                    LoanToBeCleared.Add('loan_product_type', LoansTopUp."Loan Product Type Name");
                    LoanToBeCleared.Add('principle_top_up', LoansTopUp."Principle Top Up");
                    LoanToBeCleared.Add('interest_top_up', LoansTopUp."Interest Top Up");
                    LoanToBeCleared.Add('total_top_up', LoansTopUp."Total Top Up");

                    LoansToBeCleared.Add(LoanToBeCleared);

                    // Reset
                    LoanToBeCleared.ReadFrom('{}');
                end until LoansTopUp.Next = 0;
            end;
            Datum.Add('loans_to_be_cleared', LoansToBeCleared);

            Datum.Add('created_at', SearchLoan.SystemCreatedAt);
            Datum.Add('modified_at', SearchLoan.SystemModifiedAt);
        end else begin
            Error('Loan application with number %1 NOT found.', application_number.AsValue.AsText);
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberLiabilities(Payload: JsonObject): Text
    var
        member_number: JsonToken;

        Member: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        Loans: Record Loans;

        GeneralSetUp: Record "General Set-Up";
        TransactionCharge: Decimal;

        MemberDeposits: Decimal;
        OutstandingBalance: Decimal;
        OutstandingInterest: Decimal;

        FullWithdrawalFees: Decimal;
        PartialWithdrawalFees: Decimal;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('member_number', member_number);

        Member.Reset;
        Member.SetRange("No.", member_number.AsValue.AsText);

        IF Member.FindFirst() then begin
            // Datum.Add('withdrawal_no', MemberWithdrawal."No.");
            // if Member.Subflag = Member.Subflag::Defaulter then Error('Member status is %1. Kindly clear your liabilities.', Member.Subflag);

            SavingsAccounts.Reset;
            SavingsAccounts.SetRange(SavingsAccounts."Member No.", Member."No.");
            SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
            if SavingsAccounts.Find('-') then begin
                SavingsAccounts.CalcFields("Balance (LCY)");
                MemberDeposits := SavingsAccounts."Balance (LCY)";
            end else
                MemberDeposits := 0;

            Loans.CalcFields("Total Loan Balance");

            Loans.Reset;
            Loans.SetRange("Member No.", Member."No.");
            Loans.SetRange(Posted, true);
            Loans.SetFilter("Total Loan Balance", '>0');
            if Loans.Find('-') then begin
                repeat
                    Loans.CalcFields("Outstanding Balance");
                    OutstandingBalance += Loans."Outstanding Balance";
                    Loans.CalcFields("Outstanding Interest");
                    OutstandingInterest += Loans."Outstanding Interest";
                until Loans.Next = 0;
            end;

            Datum.Add('member_name', Member.Name);
            Datum.Add('total_deposits', MemberDeposits);
            Datum.Add('total_loans', (OutstandingBalance + OutstandingInterest));

            GeneralSetUp.Get();
            FullWithdrawalFees := GeneralSetUp."Withdrawal Fee" + (GeneralSetUp."Withdrawal Fee" * 0.01 * GeneralSetUp."Excise Duty (%)");

            GeneralSetUp.TestField(GeneralSetUp."Partial Account Fee");
            TransactionCharge := GlobalFunctions.GetTransactionCharge(GeneralSetUp."Partial Account Fee", 0);
            PartialWithdrawalFees := TransactionCharge + (TransactionCharge * GeneralSetUp."Excise Duty (%)" * 0.01);

            Datum.Add('full_withdrawal_fees', FullWithdrawalFees);
            Datum.Add('partial_withdrawal_fees', PartialWithdrawalFees);
        end else begin
            Error('Member with number %1 NOT found.', member_number.AsValue.AsText);
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CreateMemberWithdrawalApplication(Payload: JsonObject): Text
    var
        member_number: JsonToken;
        notice_type: JsonToken;
        percentage: JsonToken;
        reason_for_withdrawal: JsonToken;
        remarks: JsonToken;
        crm_application_no: JsonToken;
        crm_notes: JsonToken;
        crm_created_by: JsonToken;
        crm_originating_branch: JsonToken;
        employer_liability: JsonToken;

        KeyExists: Boolean;

        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        NewNo: Code[20];
        NewNoSeriesCode: Code[20];
        // CRMNewNo: Code[20];
        // CRMNewNoSeriesCode: Code[20];

        MemberWithdrawalApplication: Record "Member withdrawal Notice";
        Member: Record Members;
        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        KeyExists := Payload.Get('member_number', member_number);
        KeyExists := Payload.Get('notice_type', notice_type);
        KeyExists := Payload.Get('percentage', percentage);
        KeyExists := Payload.Get('reason_for_withdrawal', reason_for_withdrawal);
        KeyExists := Payload.Get('remarks', remarks);
        KeyExists := Payload.Get('crm_application_no', crm_application_no);
        KeyExists := Payload.Get('crm_notes', crm_notes);
        KeyExists := Payload.Get('crm_created_by', crm_created_by);
        KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);
        KeyExists := Payload.Get('employer_liability', employer_liability);

        if crm_created_by.AsValue.AsText = '' then begin
            Error('ERR_401. Invalid application. Origination NOT accepted!');
        end;

        Member.Reset;
        Member.SetRange("No.", member_number.AsValue.AsText);

        if Member.FindFirst then begin
            MemberWithdrawalApplication.Init();

            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Withdrawal Notice");
            NewNo := NoSeriesMgt.GetNextNo(SeriesSetup."Withdrawal Notice");
            // NoSeriesMgt.InitSeries(SeriesSetup."Withdrawal Notice", SeriesSetup."Withdrawal Notice", 0D, NewNo, NewNoSeriesCode);

            MemberWithdrawalApplication."No." := NewNo;

            // MemberWithdrawalApplication."CRM Application No." := crm_application_no.AsValue.AsText;
            MemberWithdrawalApplication."CRM Created By" := crm_created_by.AsValue.AsText;
            MemberWithdrawalApplication."CRM Originating Branch" := crm_originating_branch.AsValue.AsText;
            MemberWithdrawalApplication."CRM Notes" := crm_notes.AsValue.AsText;

            MemberWithdrawalApplication."Member No." := member_number.AsValue.AsText;
            MemberWithdrawalApplication.Name := Member.Name;
            MemberWithdrawalApplication."Staff No." := Member."Payroll/Staff No.";
            MemberWithdrawalApplication."Global Dimension 1 Code" := Member."Global Dimension 1 Code";
            MemberWithdrawalApplication."Global Dimension 2 Code" := Member."Global Dimension 2 Code";
            MemberWithdrawalApplication.Validate("Member No.");

            MemberWithdrawalApplication."Notice Type" := notice_type.AsValue.AsInteger; //' ,Normal Withdrawal,Partial Withdrawal'
            MemberWithdrawalApplication.Percentage := percentage.AsValue.AsDecimal;
            MemberWithdrawalApplication.Validate(Percentage);

            MemberWithdrawalApplication."Reason for withdrawal" := reason_for_withdrawal.AsValue.AsText;
            MemberWithdrawalApplication."Remarks" := remarks.AsValue.AsText;

            MemberWithdrawalApplication."Employer Liability" := employer_liability.AsValue.AsDecimal;

            MemberWithdrawalApplication."Withdrawal Notice Date" := DT2Date(CurrentDateTime);
            MemberWithdrawalApplication.Validate("Withdrawal Notice Date");
            MemberWithdrawalApplication."Entered By" := UserId;
            MemberWithdrawalApplication."Date Entered" := DT2Date(CurrentDateTime);
            MemberWithdrawalApplication."Time Entered" := DT2Time(CurrentDateTime);
            MemberWithdrawalApplication."Date Modified" := DT2Date(CurrentDateTime);
            MemberWithdrawalApplication.Status := MemberWithdrawalApplication.Status::Open;
            // MemberWithdrawalApplication.Status := MemberWithdrawalApplication.Status::Approved;
            MemberWithdrawalApplication."No. Series" := NewNoSeriesCode;

            // CRM - No Series
            // SeriesSetup.TestField(SeriesSetup."CRM - Member Withdrawals");
            // NoSeriesMgt.InitSeries(SeriesSetup."CRM - Member Withdrawals", SeriesSetup."CRM - Member Withdrawals", 0D, CRMNewNo, CRMNewNoSeriesCode);

            // MemberWithdrawalApplication."CRM Application No." := CRMNewNo;
            // MemberWithdrawalApplication."CRM No. Series" := CRMNewNoSeriesCode;

            case MemberWithdrawalApplication."Notice Type" of
                MemberWithdrawalApplication."Notice Type"::"Withdrawal - Normal":
                    begin
                        MemberWithdrawalApplication."Global Dimension 2 Code" := GlobalFunctions.GetCRMOriginationLandingDepartment(CRMOriginationType::"Member Withdrawal");
                    end;

                MemberWithdrawalApplication."Notice Type"::"Withdrawal - 1st Partial":
                    begin
                        MemberWithdrawalApplication."Global Dimension 2 Code" := GlobalFunctions.GetCRMOriginationLandingDepartment(CRMOriginationType::"Member Withdrawal - 1st Partial");
                    end;

                MemberWithdrawalApplication."Notice Type"::"Withdrawal - 2nd Partial":
                    begin
                        MemberWithdrawalApplication."Global Dimension 2 Code" := GlobalFunctions.GetCRMOriginationLandingDepartment(CRMOriginationType::"Member Withdrawal - 2nd Partial");
                    end;
            end;

            IF MemberWithdrawalApplication.Insert(true) then begin
                MemberWithdrawalApplication."CRM Application No." := MemberWithdrawalApplication."No.";
                MemberWithdrawalApplication."CRM No. Series" := MemberWithdrawalApplication."No. Series";

                case MemberWithdrawalApplication."Notice Type" of
                    MemberWithdrawalApplication."Notice Type"::"Withdrawal - Normal":
                        begin
                            MemberWithdrawalApplication."Global Dimension 2 Code" := GlobalFunctions.GetCRMOriginationLandingDepartment(CRMOriginationType::"Member Withdrawal");
                        end;

                    MemberWithdrawalApplication."Notice Type"::"Withdrawal - 1st Partial":
                        begin
                            MemberWithdrawalApplication."Global Dimension 2 Code" := GlobalFunctions.GetCRMOriginationLandingDepartment(CRMOriginationType::"Member Withdrawal - 1st Partial");
                        end;

                    MemberWithdrawalApplication."Notice Type"::"Withdrawal - 2nd Partial":
                        begin
                            MemberWithdrawalApplication."Global Dimension 2 Code" := GlobalFunctions.GetCRMOriginationLandingDepartment(CRMOriginationType::"Member Withdrawal - 2nd Partial");
                        end;
                end;

                MemberWithdrawalApplication.Modify(true);

                // CRM Comments/Notes
                GlobalFunctions.InsertCommentRecord(
                    MemberWithdrawalApplication."No.",
                    crm_notes.AsValue.AsText,
                    crm_created_by.AsValue.AsText,
                    MemberWithdrawalApplication."Global Dimension 1 Code",
                    MemberWithdrawalApplication."Global Dimension 2 Code",
                    '',
                    false
                );

                EDMSFunctions.EDMSScannedLog(
                    MemberWithdrawalApplication."No.",
                    "CRM Originations"::"Member Withdrawal",
                    MemberWithdrawalApplication."Member No.",
                    MemberWithdrawalApplication."CRM Created By",
                    MemberWithdrawalApplication."CRM Originating Branch"
                );

                // Handle CRM branch assigmnent
                MemberWithdrawalApplication."Global Dimension 1 Code" := GlobalFunctions.GetBranchCodeFromCRMOrigination(MemberWithdrawalApplication."CRM Originating Branch");
                MemberWithdrawalApplication.Modify;

                MemberWithdrawalApplication.Reset();

                MemberWithdrawalApplication.SetRange("No.", NewNo);
                ResponseData.Add('application_number', MemberWithdrawalApplication."No.");
                ResponseData.Add('application_status', Format(MemberWithdrawalApplication.Status));

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('description', 'Member withdrawal application with CRM application number ' + MemberWithdrawalApplication."No." + ' has been created successfully.');
                ResponseObject.Add('data', ResponseData);
                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
            end else begin
                // ResponseObject.Add('status', 'ERROR');
                // ResponseObject.Add('description', 'Unable to create member withdrawal application.');
                // ResponseObject.Add('errors', Errors);
                // AddDateTimeToResponse(ResponseObject);

                // ResponseObject.WriteTo(Response);

                Error('Unable to create member withdrawal application.');
            end;
        end else begin
            // ResponseObject.Add('status', 'ERROR');
            // ResponseObject.Add('description', 'Unknown member with member number ' + member_number.AsValue.AsText);
            // ResponseObject.Add('errors', Errors);
            // AddDateTimeToResponse(ResponseObject);

            // ResponseObject.WriteTo(Response);

            Error('Unknown member with member number ' + member_number.AsValue.AsText);
        end;

        exit(Response);
    end;

    local procedure UpdateMemberWithdrawalApplication(Payload: JsonObject): Text
    var
        application_no: JsonToken;
        member_number: JsonToken;
        notice_type: JsonToken;
        percentage: JsonToken;
        reason_for_withdrawal: JsonToken;
        remarks: JsonToken;
        crm_application_no: JsonToken;
        crm_notes: JsonToken;
        crm_created_by: JsonToken;
        crm_originating_branch: JsonToken;
        employer_liability: JsonToken;

        KeyExists: Boolean;

        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        NewNo: Code[20];
        NewNoSeriesCode: Code[20];
        // CRMNewNo: Code[20];
        // CRMNewNoSeriesCode: Code[20];

        MemberWithdrawalApplication: Record "Member withdrawal Notice";
        Member: Record Members;
        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        KeyExists := Payload.Get('application_no', application_no);
        KeyExists := Payload.Get('member_number', member_number);
        KeyExists := Payload.Get('notice_type', notice_type);
        KeyExists := Payload.Get('percentage', percentage);
        KeyExists := Payload.Get('reason_for_withdrawal', reason_for_withdrawal);
        KeyExists := Payload.Get('remarks', remarks);
        KeyExists := Payload.Get('crm_application_no', crm_application_no);
        KeyExists := Payload.Get('crm_notes', crm_notes);
        KeyExists := Payload.Get('crm_created_by', crm_created_by);
        KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);
        KeyExists := Payload.Get('employer_liability', employer_liability);

        Member.Reset;
        Member.SetRange("No.", member_number.AsValue.AsText);

        if Member.FindFirst then begin
            MemberWithdrawalApplication.Reset;

            MemberWithdrawalApplication.SetRange("No.", application_no.AsValue.AsText);
            MemberWithdrawalApplication.SetRange("Sent Back to CRM", true);

            if MemberWithdrawalApplication.FindFirst then begin
                // MemberWithdrawalApplication."CRM Created By" := crm_created_by.AsValue.AsText;
                MemberWithdrawalApplication."CRM Originating Branch" := crm_originating_branch.AsValue.AsText;
                MemberWithdrawalApplication."CRM Notes" := crm_notes.AsValue.AsText;

                MemberWithdrawalApplication."Member No." := member_number.AsValue.AsText;
                MemberWithdrawalApplication.Name := Member.Name;
                MemberWithdrawalApplication."Staff No." := Member."Payroll/Staff No.";
                MemberWithdrawalApplication."Global Dimension 1 Code" := Member."Global Dimension 1 Code";
                MemberWithdrawalApplication."Global Dimension 2 Code" := Member."Global Dimension 2 Code";
                MemberWithdrawalApplication.Validate("Member No.");

                MemberWithdrawalApplication."Notice Type" := notice_type.AsValue.AsInteger; //' ,Normal Withdrawal,Partial Withdrawal'
                MemberWithdrawalApplication.Percentage := percentage.AsValue.AsDecimal;
                MemberWithdrawalApplication.Validate(Percentage);

                MemberWithdrawalApplication."Reason for withdrawal" := reason_for_withdrawal.AsValue.AsText;
                MemberWithdrawalApplication."Remarks" := remarks.AsValue.AsText;

                MemberWithdrawalApplication."Employer Liability" := employer_liability.AsValue.AsDecimal;

                MemberWithdrawalApplication."Withdrawal Notice Date" := DT2Date(CurrentDateTime);
                MemberWithdrawalApplication.Validate("Withdrawal Notice Date");
                MemberWithdrawalApplication."Entered By" := UserId;
                MemberWithdrawalApplication."Date Entered" := DT2Date(CurrentDateTime);
                MemberWithdrawalApplication."Time Entered" := DT2Time(CurrentDateTime);
                MemberWithdrawalApplication."Date Modified" := DT2Date(CurrentDateTime);
                MemberWithdrawalApplication.Status := MemberWithdrawalApplication.Status::Open;
                // MemberWithdrawalApplication.Status := MemberWithdrawalApplication.Status::Approved;
                MemberWithdrawalApplication."No. Series" := NewNoSeriesCode;

                MemberWithdrawalApplication."Sent Back to CRM" := false;

                IF MemberWithdrawalApplication.Modify(True) then begin
                    // CRM Comments/Notes
                    GlobalFunctions.InsertCommentRecord(
                        MemberWithdrawalApplication."No.",
                        crm_notes.AsValue.AsText,
                        crm_created_by.AsValue.AsText,
                        MemberWithdrawalApplication."Global Dimension 1 Code",
                        MemberWithdrawalApplication."Global Dimension 2 Code",
                        '',
                        false
                    );

                    // Handle CRM branch assigmnent
                    MemberWithdrawalApplication."Global Dimension 1 Code" := GlobalFunctions.GetBranchCodeFromCRMOrigination(MemberWithdrawalApplication."CRM Originating Branch");
                    MemberWithdrawalApplication.Modify;

                    MemberWithdrawalApplication.Reset();

                    MemberWithdrawalApplication.SetRange("No.", NewNo);
                    ResponseData.Add('application_number', MemberWithdrawalApplication."No.");
                    ResponseData.Add('application_status', Format(MemberWithdrawalApplication.Status));

                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('description', 'Member withdrawal application with CRM application number ' + MemberWithdrawalApplication."No." + ' has been updated successfully.');
                    ResponseObject.Add('data', ResponseData);
                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                end else begin
                    Error('Unable to update member withdrawal application.');
                end;
            end else begin
                Error('Member withdrawal application with number %1 is NOT available for editing', application_no.AsValue.AsText);
            end;
        end else begin
            Error('Unknown member with member number ' + member_number.AsValue.AsText);
        end;

        exit(Response);
    end;

    local procedure GetMemberWithdrawalReasons(): Text
    var
        MemberWithdrawalReasons: Record "Withdrawal Reason";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        MemberWithdrawalReasons.Reset;

        IF MemberWithdrawalReasons.FindSet then begin
            repeat begin

                Datum.Add('code', MemberWithdrawalReasons.Description);
                Datum.Add('description', MemberWithdrawalReasons.Description);

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until MemberWithdrawalReasons.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberWithdrawals(Payload: JsonObject): Text
    var
        filter_property: JsonToken;
        filter_value: JsonToken;
        start_date: JsonToken;
        end_date: JsonToken;
        page_number: JsonToken;
        page_size: JsonToken;
        crm_branch: JsonToken;

        KeyExists: Boolean;

        MemberWithdrawals: Record "Member withdrawal Notice";
        MemberClosure: Record "Membership Closure";
        ApplicationTrails: Record "Approval Entry";
        SLA: record "Defined SLA";
        Comment: record "Comments";

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;
        EmployerCode: Text;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;
        Count: Integer;
        FirstRow: Integer;
        LastRow: Integer;
        TotalFoundRecords: Integer;
        SearchString: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        KeyExists := Payload.Get('filter_property', filter_property);
        KeyExists := Payload.Get('filter_value', filter_value);
        KeyExists := Payload.Get('start_date', start_date);
        KeyExists := Payload.Get('end_date', end_date);
        KeyExists := Payload.Get('crm_branch', crm_branch);
        Payload.Get('page_number', page_number);
        Payload.Get('page_size', page_size);

        MemberWithdrawals.Reset;
        MemberWithdrawals.SetCurrentKey("Withdrawal Notice Date");
        MemberWithdrawals.SetAscending("Withdrawal Notice Date", false);

        if KeyExists then begin
            if (crm_branch.AsValue.AsText <> 'ALL') then begin
                MemberWithdrawals.SetRange(MemberWithdrawals."CRM Originating Branch", crm_branch.AsValue.AsText);
            end;
        end;
        // Search Value
        if (not filter_property.AsValue.IsNull) and (not filter_value.AsValue.IsNull) then begin
            if (filter_property.AsValue.AsText <> '') and (filter_value.AsValue.AsText <> '') then begin
                SearchString := filter_value.AsValue.AsText;

                case filter_property.AsValue.AsText of
                    'application_no':
                        MemberWithdrawals.SetRange(MemberWithdrawals."No.", SearchString);
                    'crm_application_no':
                        MemberWithdrawals.SetRange(MemberWithdrawals."CRM Application No.", SearchString);
                    'member_number':
                        MemberWithdrawals.SetRange(MemberWithdrawals."Member No.", SearchString);
                    'status':
                        MemberWithdrawals.SetFilter(MemberWithdrawals.Status, SearchString);
                    else
                        MemberWithdrawals.SetRange(MemberWithdrawals."No.", SearchString);
                end;
            end;
        end;

        // Start Date & End Date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));

                MemberWithdrawals.SetFilter("Withdrawal Notice Date", '>=%1&<=%2', StartDate, EndDate);
            end;
        end;

        IF MemberWithdrawals.FindSet then begin
            // Withdrawals found
            Count := 0;
            FirstRow := ((page_number.AsValue.AsInteger - 1) * page_size.AsValue.AsInteger) + 1;
            LastRow := page_number.AsValue.AsInteger * page_size.AsValue.AsInteger;

            TotalFoundRecords := MemberWithdrawals.Count;

            repeat begin
                Count += 1;

                if (Count >= FirstRow) and (Count <= LastRow) then begin
                    Datum.Add('application_no', MemberWithdrawals."No.");
                    Datum.Add('crm_application_no', MemberWithdrawals."CRM Application No.");
                    Datum.Add('member_number', MemberWithdrawals."Member No.");
                    Datum.Add('member_name', MemberWithdrawals.Name);
                    Datum.Add('notice_date', MemberWithdrawals."Withdrawal Notice Date");
                    Datum.Add('crm_created_by', MemberWithdrawals."CRM Created By");
                    Datum.Add('crm_originating_branch', MemberWithdrawals."CRM Originating Branch");
                    Datum.Add('status', Format(MemberWithdrawals.Status));

                    MemberClosure.Reset;
                    MemberClosure.SetRange("Notice Number", MemberWithdrawals."No.");
                    if MemberClosure.FindFirst then begin
                        Datum.Add('closure_status', Format(MemberClosure.Status));
                    end else begin
                        Datum.Add('closure_status', '');
                    end;

                    Datum.Add('is_sent_back_to_crm', MemberWithdrawals."Sent Back to CRM");

                    // ---------------------------------------------------------------------------------------------------

                    ApplicationTrails.Reset;

                    MemberClosure.Reset;
                    MemberClosure.SetRange("Notice Number", MemberWithdrawals."No.");
                    if MemberClosure.FindFirst then begin
                        ApplicationTrails.SetFilter("Document No.", '=%1|%2', MemberWithdrawals."No.", MemberClosure."No.");
                    end else begin
                        ApplicationTrails.SetRange("Document No.", MemberWithdrawals."No.");
                    end;

                    if ApplicationTrails.FindLast then begin
                        Datum.Add('responsible_officer', ApplicationTrails."Sender ID");
                        Datum.Add('supervisor_id', ApplicationTrails."Approver ID");
                    end else begin
                        MemberWithdrawals.CalcFields(
                            "Responsible Officer",
                            "Supervisor ID"
                        );
                        Datum.Add('responsible_officer', MemberWithdrawals."Responsible Officer");
                        Datum.Add('supervisor_id', MemberWithdrawals."Supervisor ID");
                    end;

                    // ---------------------------------------------------------------------------------------------------

                    // SLA
                    WorkDays := 0;
                    SLADays := 0;
                    DelayDays := 0;
                    EmployerCode := '';
                    StatusComment := '';

                    SLA.reset();
                    SLA.SetRange("Origination Type", SLA."Origination Type"::"Membership Withdrawal");
                    if SLA.findfirst() then
                        SLADays := SLA.SLA;

                    if (MemberWithdrawals."Maturity Date" <> 0D) and (MemberWithdrawals."Date Entered" <> 0D) and (MemberWithdrawals."Time Entered" <> 0T) and (MemberWithdrawals."Maturity Time" <> 0T) then begin
                        Globalfunctions.HoursBetweenPeriods(MemberWithdrawals."Date Entered", MemberWithdrawals."Time Entered", MemberWithdrawals."Maturity Date", MemberWithdrawals."Maturity Time", Duration, WokedOnANonWorkingPeriod);
                        WorkDays := Duration;
                        DelayDays := WorkDays - (SLADays / 3);
                        IF DelayDays < 0 then DelayDays := 0;
                    end;

                    Comment.reset();
                    Comment.SetRange("Header No.", MemberWithdrawals."No.");
                    If Comment.FindLast() then begin
                        StatusComment := Comment.Comment;
                    end;

                    Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
                    Datum.Add('SLA_days', Format(SLADays));
                    Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
                    Datum.Add('tat_status', Format(TAtStatus));
                    Datum.Add('status_comment', StatusComment);
                    Datum.Add('priority', Format(Priority));

                    Data.Add(Datum);
                    // Reset
                    Datum.ReadFrom('{}');
                end;
            end until (Count = LastRow) or (MemberWithdrawals.Next = 0);

            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberWithdrawal(Payload: JsonObject): Text
    var
        withdrawal_number: JsonToken;

        MemberWithdrawal: Record "Member withdrawal Notice";
        MemberClosure: Record "Membership Closure";
        ApplicationComments: Record Comments;
        CFDepartments: Record "CF Tracker";
        ApplicationTrails: Record "Approval Entry";

        Departments: JsonArray;
        Department: JsonObject;

        Comments: JsonArray;
        Comment: JsonObject;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('withdrawal_number', withdrawal_number);

        MemberWithdrawal.Reset;
        MemberWithdrawal.SetRange("No.", withdrawal_number.AsValue.AsText);

        IF MemberWithdrawal.FindFirst() then begin
            Datum.Add('withdrawal_no', MemberWithdrawal."No.");
            Datum.Add('member_no', MemberWithdrawal."Member No.");
            Datum.Add('member_name', MemberWithdrawal."Name");
            Datum.Add('staff_no', MemberWithdrawal."Staff No.");
            Datum.Add('notice_type', MemberWithdrawal."Notice Type");
            Datum.Add('notice_type_desc', Format(MemberWithdrawal."Notice Type"));
            Datum.Add('reason_for_withdrawal', MemberWithdrawal."Reason for withdrawal");
            Datum.Add('withdrawal_notice_date', GlobalFunctions.FormatISODate(MemberWithdrawal."Withdrawal Notice Date"));
            Datum.Add('maturity_date', GlobalFunctions.FormatISODate(MemberWithdrawal."Maturity Date"));
            Datum.Add('percentage', MemberWithdrawal.Percentage);
            Datum.Add('status', MemberWithdrawal.Status.AsInteger);
            Datum.Add('status_desc', Format(MemberWithdrawal.Status));
            Datum.Add('remarks', MemberWithdrawal.Remarks);

            Datum.Add('loan_outstanding_balance', MemberWithdrawal."Loans Outstanding Balance");
            Datum.Add('loan_outstanding_interest', MemberWithdrawal."Loans Outstanding Interest");
            Datum.Add('member_deposit', MemberWithdrawal."Member Deposit");
            Datum.Add('employer_liability', MemberWithdrawal."Employer Liability");

            Datum.Add('rejection_remarks', MemberWithdrawal."Rejection Remarks");

            Datum.Add('crm_application_no', MemberWithdrawal."CRM Application No.");
            Datum.Add('crm_created_by', MemberWithdrawal."CRM Created By");
            Datum.Add('crm_originating_branch', MemberWithdrawal."CRM Originating Branch");
            Datum.Add('crm_notes', MemberWithdrawal."CRM Notes");

            Datum.Add('is_notice_finalized', MemberWithdrawal."Notice Finalized");
            Datum.Add('date_time_finalized', GlobalFunctions.FormatISODateTime(MemberWithdrawal."DateTime Finalized"));
            Datum.Add('finalized_by', MemberWithdrawal."Finalized By");
            Datum.Add('is_sent_back_to_crm', MemberWithdrawal."Sent Back to CRM");

            ApplicationTrails.Reset;

            MemberClosure.Reset;
            MemberClosure.SetRange("Notice Number", MemberWithdrawal."No.");
            if MemberClosure.FindFirst then begin
                ApplicationTrails.SetFilter("Document No.", '=%1|%2', MemberWithdrawal."No.", MemberClosure."No.");
            end else begin
                ApplicationTrails.SetRange("Document No.", MemberWithdrawal."No.");
            end;

            if ApplicationTrails.FindLast then begin
                Datum.Add('responsible_officer', ApplicationTrails."Sender ID");
                Datum.Add('supervisor_id', ApplicationTrails."Approver ID");
            end else begin
                MemberWithdrawal.CalcFields(
                    "Responsible Officer",
                    "Supervisor ID"
                );
                Datum.Add('responsible_officer', MemberWithdrawal."Responsible Officer");
                Datum.Add('supervisor_id', MemberWithdrawal."Supervisor ID");
            end;

            MemberClosure.Reset;
            MemberClosure.SetRange("Notice Number", MemberWithdrawal."No.");
            if MemberClosure.FindFirst then begin
                Datum.Add('closure_status', Format(MemberClosure.Status));
            end else begin
                Datum.Add('closure_status', '');
            end;

            ApplicationComments.Reset;

            MemberClosure.Reset;
            MemberClosure.SetRange("Notice Number", MemberWithdrawal."No.");
            if MemberClosure.FindFirst then begin
                ApplicationComments.SetFilter("Header No.", '=%1|%2', MemberWithdrawal."No.", MemberClosure."No.");
            end else begin
                ApplicationComments.SetRange("Header No.", MemberWithdrawal."No.");
            end;

            ApplicationComments.SetCurrentKey("Entry No.");
            ApplicationComments.SetAscending("Entry No.", false);

            if ApplicationComments.FindSet then begin
                repeat begin
                    Comment.Add('comment', ApplicationComments.Comment);
                    Comment.Add('commented_by', ApplicationComments."Commented By");
                    Comment.Add('date_time', GlobalFunctions.FormatISODateTime(ApplicationComments.Date));
                    Comment.Add('is_read', ApplicationComments."Viewd By Somebody Else");

                    Comments.Add(Comment);

                    // Reset
                    Comment.ReadFrom('{}');
                end until ApplicationComments.Next = 0;
            end;

            Datum.Add('comments', Comments);

            // Department Tracker
            CFDepartments.Reset;

            MemberClosure.Reset;
            MemberClosure.SetRange("Notice Number", MemberWithdrawal."No.");
            if MemberClosure.FindFirst then begin
                CFDepartments.SetFilter("Header No.", '=%1|%2', MemberWithdrawal."No.", MemberClosure."No.");
            end else begin
                CFDepartments.SetRange("Header No.", MemberWithdrawal."No.");
            end;

            CFDepartments.SetCurrentKey("Entry No.");
            CFDepartments.SetAscending("Entry No.", false);

            if CFDepartments.FindSet then begin
                repeat begin
                    Department.Add('entry_no', CFDepartments."Entry No.");
                    Department.Add('header_no', CFDepartments."Header No.");
                    Department.Add('at_department', CFDepartments."At Department");
                    Department.Add('current_department', CFDepartments."Current Department");
                    Department.Add('forwarded_by', CFDepartments."Forwarded By");
                    Department.Add('time_forwarded', GlobalFunctions.FormatISODateTime(CFDepartments."Time Forwarded"));
                    Department.Add('viewed_by_recepient', CFDepartments."Viewed By Recepient");

                    Departments.Add(Department);

                    // Reset
                    Department.ReadFrom('{}');
                end until CFDepartments.Next = 0;
            end;

            Datum.Add('departments', Departments);

            Datum.Add('created_at', MemberWithdrawal.SystemCreatedAt);
            Datum.Add('modified_at', MemberWithdrawal.SystemModifiedAt);
        end else begin
            Error('Member withdrawal application with number %1 NOT found.', withdrawal_number.AsValue.AsText);
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CreateBBFClaimRequest(Payload: JsonObject): Text
    var
        crm_application_no: JsonToken;
        crm_notes: JsonToken;
        crm_created_by: JsonToken;
        crm_originating_branch: JsonToken;
        type_of_claim: JsonToken;
        contributor_member_no: JsonToken;
        is_contributor_deceased: JsonToken;
        deceased_particulars_identification_type: JsonToken;
        deceased_particulars_identification: JsonToken;
        date_of_death: JsonToken;
        death_certificate_number: JsonToken;
        is_contributor_claimant: JsonToken;
        claimant_particulars_identification_type: JsonToken;
        claimant_particulars_identification: JsonToken;
        claimant_particulars_name: JsonToken;
        claimant_particulars_relationship: JsonToken; // FRIEND,RELATIVE

        KeyExists: Boolean;

        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        NewNo: Code[20];
        NewNoSeriesCode: Code[20];
        // CRMNewNo: Code[20];
        // CRMNewNoSeriesCode: Code[20];

        theBBFOrigination: enum "CRM Originations";

        SinkFundApplication: Record "SinkFund Report Information";
        NOK: Record "Next of KIN";
        ContributorMember: Record Members;
        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        KeyExists := Payload.Get('crm_application_no', crm_application_no);
        KeyExists := Payload.Get('crm_notes', crm_notes);
        KeyExists := Payload.Get('crm_created_by', crm_created_by);
        KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);
        KeyExists := Payload.Get('type_of_claim', type_of_claim);
        KeyExists := Payload.Get('contributor_member_no', contributor_member_no);
        KeyExists := Payload.Get('is_contributor_deceased', is_contributor_deceased);
        KeyExists := Payload.SelectToken('$.deceased_particulars.identification_type', deceased_particulars_identification_type);
        KeyExists := Payload.SelectToken('$.deceased_particulars.identification', deceased_particulars_identification);
        KeyExists := Payload.Get('date_of_death', date_of_death);
        KeyExists := Payload.Get('death_certificate_number', death_certificate_number);
        KeyExists := Payload.Get('is_contributor_claimant', is_contributor_claimant);
        KeyExists := Payload.SelectToken('$.claimant_particulars.identification_type', claimant_particulars_identification_type);
        KeyExists := Payload.SelectToken('$.claimant_particulars.identification', claimant_particulars_identification);
        KeyExists := Payload.SelectToken('$.claimant_particulars.name', claimant_particulars_name);
        KeyExists := Payload.SelectToken('$.claimant_particulars.relationship', claimant_particulars_relationship);

        if crm_created_by.AsValue.AsText = '' then begin
            Error('ERR_401. Invalid application. Origination NOT accepted!');
        end;

        ContributorMember.Reset;
        ContributorMember.SetRange("No.", contributor_member_no.AsValue.AsText);

        if ContributorMember.FindFirst then begin
            SinkFundApplication.Init();

            // SeriesSetup.Get;
            // SeriesSetup.TestField(SeriesSetup."BBF Report");
            // NoSeriesMgt.InitSeries(SeriesSetup."BBF Report", SeriesSetup."BBF Report", 0D, NewNo, NewNoSeriesCode);

            // SinkFundApplication.No := NewNo;
            // SinkFundApplication."No. Series" := NewNoSeriesCode;

            SinkFundApplication."Claim Type" := type_of_claim.AsValue.AsInteger;

            SeriesSetup.Get;
            if SinkFundApplication."Claim Type" = SinkFundApplication."Claim Type"::"Risk Claim" then
                SeriesSetup.TestField(SeriesSetup."Sink Fund Nos.")
            else if SinkFundApplication."Claim Type" = SinkFundApplication."Claim Type"::"BBF - Insurance Claim" then
                SeriesSetup.TestField(SeriesSetup."BBF Insurance Nos.")
            else
                SeriesSetup.TestField(SeriesSetup."BBF Report");

            if SinkFundApplication."Claim Type" = SinkFundApplication."Claim Type"::"Risk Claim" then
                SinkFundApplication.No := NoSeriesMgt.GetNextNo(SeriesSetup."Sink Fund Nos.")
                // NoSeriesMgt.InitSeries(SeriesSetup."Sink Fund Nos.", SeriesSetup."Sink Fund Nos.", 0D, SinkFundApplication.No, SinkFundApplication."No. Series")
            else if SinkFundApplication."Claim Type" = SinkFundApplication."Claim Type"::"BBF - Insurance Claim" then
                SinkFundApplication.No := NoSeriesMgt.GetNextNo(SeriesSetup."BBF Insurance Nos.")
                // NoSeriesMgt.InitSeries(SeriesSetup."BBF Insurance Nos.", SeriesSetup."BBF Insurance Nos.", 0D, SinkFundApplication.No, SinkFundApplication."No. Series")
            else
                SinkFundApplication.No := NoSeriesMgt.GetNextNo(SeriesSetup."BBF Report");
                // NoSeriesMgt.InitSeries(SeriesSetup."BBF Report", SeriesSetup."BBF Report", 0D, SinkFundApplication.No, SinkFundApplication."No. Series");

            // SinkFundApplication."CRM Application No." := crm_application_no.AsValue.AsText;
            SinkFundApplication."CRM Created By" := crm_created_by.AsValue.AsText;
            SinkFundApplication."CRM Originating Branch" := crm_originating_branch.AsValue.AsText;
            SinkFundApplication."CRM Notes" := crm_notes.AsValue.AsText;

            SinkFundApplication."Claim Type" := type_of_claim.AsValue.AsInteger;
            if (SinkFundApplication."Claim Type" = SinkFundApplication."Claim Type"::"BBF - Principle Claim") or
            (SinkFundApplication."Claim Type" = SinkFundApplication."Claim Type"::"Risk Claim") then begin
                SinkFundApplication.Relationship := 'SELF';
            end;

            SinkFundApplication."Member No" := contributor_member_no.AsValue.AsText;
            SinkFundApplication.Validate("Member No");
            // SinkFundApplication."Staff No." := ContributorMember."Payroll/Staff No.";

            SinkFundApplication."Date of Death" := date_of_death.AsValue.AsDate;
            // SinkFundApplication.Validate("Date of Death");

            IF (is_contributor_deceased.AsValue.AsBoolean = true) then begin
                IF StrLen(ContributorMember.Name) > 0 then begin
                    SinkFundApplication."Deceased Person" := ContributorMember.Name;
                end else begin
                    SinkFundApplication."Deceased Person" := ContributorMember."First Name" + ' ' + ContributorMember."Middle Name" + ' ' + ContributorMember."Other Names";
                    SinkFundApplication."Deceased Person" := SinkFundApplication."Deceased Person".Trim();
                end;

                // SinkFundApplication."Claim Type" := SinkFundApplication."Claim Type"::"BBF - Principle Claim";
                SinkFundApplication."Claim Type" := type_of_claim.AsValue.AsInteger;
                SinkFundApplication.Relationship := 'SELF';
            end else begin
                //deceased_particulars - NOK
                NOK.Reset;
                NOK.SetRange("Record ID", ContributorMember."No.");
                NOK.SetFilter("Identification Type", deceased_particulars_identification_type.AsValue.AsText);
                NOK.SetRange(Identification, deceased_particulars_identification.AsValue.AsText);

                if NOK.FindFirst then begin
                    if SinkFundApplication."Claim Type" = SinkFundApplication."Claim Type"::"BBF - Dependant Claim" then begin
                        if NOK.Removed or NOK.Deceased then begin
                            if Nok.Removed then begin
                                Error('Ineligible next of kin. Removed = %1',
                                    Format(NOK.Removed)
                                );
                            end;
                            if Nok.Deceased then begin
                                Error('Ineligible next of kin. Deceased = %1',
                                    Format(NOK.Deceased)
                                );
                            end;
                        end;
                    end else begin
                        if Nok.Removed then begin
                            Error('Ineligible next of kin. Removed = %1',
                                Format(NOK.Removed)
                            );
                        end;
                    end;

                    SinkFundApplication."Deceased Person" := NOK.Name;

                    SinkFundApplication."Next of KIN" := NOK.Identification;
                    SinkFundApplication.Validate("Next of KIN");
                end else begin
                    Error('The deceased with particulars %1 = %2 NOT found within the member BBF beneficiaries list.',
                    deceased_particulars_identification_type.AsValue.AsText,
                    deceased_particulars_identification.AsValue.AsText);
                end;

                // SinkFundApplication."Claim Type" := SinkFundApplication."Claim Type"::"BBF - Dependant Claim";
                SinkFundApplication."Claim Type" := type_of_claim.AsValue.AsInteger;
            end;

            SinkFundApplication."Burial Permit Number" := death_certificate_number.asValue.asText;

            IF (is_contributor_claimant.AsValue.AsBoolean = true) then begin
                IF StrLen(ContributorMember.Name) > 0 then begin
                    SinkFundApplication."Reported By Name" := ContributorMember.Name;
                end else begin
                    SinkFundApplication."Reported By Name" := ContributorMember."First Name" + ' ' + ContributorMember."Middle Name" + ' ' + ContributorMember."Other Names";
                    SinkFundApplication."Reported By Name" := SinkFundApplication."Reported By Name".Trim();
                end;
                SinkFundApplication."Reported By ID No" := ContributorMember."Primary Identification";
                SinkFundApplication.Validate("Reported By ID No");
                SinkFundApplication."Reported By Relationship" := 'SELF';
            end else begin
                //claimant_particulars - NOK
                NOK.Reset;
                NOK.SetRange("Record ID", ContributorMember."No.");
                NOK.SetFilter("Identification Type", claimant_particulars_identification_type.AsValue.AsText);
                NOK.SetRange(Identification, claimant_particulars_identification.AsValue.AsText);

                if NOK.FindFirst then begin
                    SinkFundApplication."Reported By Name" := NOK.Name;
                    SinkFundApplication."Reported By ID No" := NOK.Identification;
                    SinkFundApplication.Validate("Reported By ID No");
                    SinkFundApplication."Reported By Relationship" := NOK.Relationship;
                end else begin
                    // Error('The claimant with particulars %1 = %2 NOT found within the member BBF beneficiaries list.',
                    // claimant_particulars_identification_type.AsValue.AsText,
                    // claimant_particulars_identification.AsValue.AsText);
                    SinkFundApplication."Reported By Name" := claimant_particulars_name.AsValue.AsText;
                    SinkFundApplication."Reported By ID No" := claimant_particulars_identification.AsValue.AsText;
                    SinkFundApplication.Validate("Reported By ID No");
                    SinkFundApplication."Reported By Relationship" := claimant_particulars_relationship.AsValue.AsText;
                end;
            end;
            SinkFundApplication.Status := SinkFundApplication.Status::Open;
            SinkFundApplication."Captured By" := crm_created_by.AsValue.AsText;
            SinkFundApplication.Date := Today;

            // CRM - No Series
            // SeriesSetup.TestField(SeriesSetup."CRM - BBF Claims");
            // NoSeriesMgt.InitSeries(SeriesSetup."CRM - BBF Claims", SeriesSetup."CRM - BBF Claims", 0D, CRMNewNo, CRMNewNoSeriesCode);

            // SinkFundApplication."CRM Application No." := CRMNewNo;
            // SinkFundApplication."CRM No. Series" := CRMNewNoSeriesCode;

            SinkFundApplication.Validate("Claim Type");
            Payload.WriteTo(SinkFundApplication."CRM Payload");

            SinkFundApplication."Date of Death" := date_of_death.AsValue.AsDate;
            SinkFundApplication.Validate("Date of Death");

            if SinkFundApplication."Claim Type" = SinkFundApplication."Claim Type"::"BBF - Dependant Claim" then begin
                SinkFundApplication."Global Dimension 2 Code" := GlobalFunctions.GetCRMOriginationLandingDepartment(CRMOriginationType::"BBF Claim - Dependant");
                SinkFundApplication."Originating Department" := GlobalFunctions.GetCRMOriginationLandingDepartment(CRMOriginationType::"BBF Claim - Dependant");
                SinkFundApplication."Current Department" := GlobalFunctions.GetCRMOriginationLandingDepartment(CRMOriginationType::"BBF Claim - Dependant");
            end;

            if SinkFundApplication."Claim Type" = SinkFundApplication."Claim Type"::"BBF - Principle Claim" then begin
                SinkFundApplication."Global Dimension 2 Code" := GlobalFunctions.GetCRMOriginationLandingDepartment(CRMOriginationType::"BBF Claim - Principle");
                SinkFundApplication."Originating Department" := GlobalFunctions.GetCRMOriginationLandingDepartment(CRMOriginationType::"BBF Claim - Principle");
                SinkFundApplication."Current Department" := GlobalFunctions.GetCRMOriginationLandingDepartment(CRMOriginationType::"BBF Claim - Principle");
            end;

            if SinkFundApplication."Claim Type" = SinkFundApplication."Claim Type"::"Risk Claim" then begin
                SinkFundApplication."Global Dimension 2 Code" := GlobalFunctions.GetCRMOriginationLandingDepartment(CRMOriginationType::"BBF Claim - Risk");
                SinkFundApplication."Originating Department" := GlobalFunctions.GetCRMOriginationLandingDepartment(CRMOriginationType::"BBF Claim - Risk");
                SinkFundApplication."Current Department" := GlobalFunctions.GetCRMOriginationLandingDepartment(CRMOriginationType::"BBF Claim - Risk");
            end;

            if SinkFundApplication."Claim Type" = SinkFundApplication."Claim Type"::"BBF - Insurance Claim" then begin
                SinkFundApplication."Global Dimension 2 Code" := GlobalFunctions.GetCRMOriginationLandingDepartment(CRMOriginationType::"BBF Claim - Insurance");
                SinkFundApplication."Originating Department" := GlobalFunctions.GetCRMOriginationLandingDepartment(CRMOriginationType::"BBF Claim - Insurance");
                SinkFundApplication."Current Department" := GlobalFunctions.GetCRMOriginationLandingDepartment(CRMOriginationType::"BBF Claim - Insurance");
            end;

            IF SinkFundApplication.Insert(true) then begin
                SinkFundApplication."CRM Application No." := SinkFundApplication.No;
                SinkFundApplication."CRM No. Series" := SinkFundApplication."No. Series";

                // Handle CRM branch assigmnent
                SinkFundApplication."Global Dimension 1 Code" := GlobalFunctions.GetBranchCodeFromCRMOrigination(SinkFundApplication."CRM Originating Branch");
                SinkFundApplication.Modify;

                // CRM Comments/Notes
                GlobalFunctions.InsertCommentRecord(
                    SinkFundApplication."No",
                    crm_notes.AsValue.AsText,
                    crm_created_by.AsValue.AsText,
                    SinkFundApplication."Global Dimension 1 Code",
                    SinkFundApplication."Global Dimension 2 Code",
                    SinkFundApplication."Responsibily Center",
                    false
                );

                // EDMS
                theBBFOrigination := theBBFOrigination::"BBF Claim";

                if SinkFundApplication."Claim Type" = SinkFundApplication."Claim Type"::"BBF - Dependant Claim" then begin
                    theBBFOrigination := theBBFOrigination::"BBF Claim - Dependant";
                end;

                if SinkFundApplication."Claim Type" = SinkFundApplication."Claim Type"::"BBF - Principle Claim" then begin
                    theBBFOrigination := theBBFOrigination::"BBF Claim - Principle";
                end;

                if SinkFundApplication."Claim Type" = SinkFundApplication."Claim Type"::"Risk Claim" then begin
                    theBBFOrigination := theBBFOrigination::"BBF Claim - Risk";
                end;

                if SinkFundApplication."Claim Type" = SinkFundApplication."Claim Type"::"BBF - Insurance Claim" then begin
                    theBBFOrigination := theBBFOrigination::"BBF Claim - Insurance";
                end;

                EDMSFunctions.EDMSScannedLog(
                    SinkFundApplication."No",
                    theBBFOrigination,
                    SinkFundApplication."Member No",
                    SinkFundApplication."CRM Created By",
                    SinkFundApplication."CRM Originating Branch"
                );

                ResponseData.Add('application_number', SinkFundApplication."No");
                ResponseData.Add('application_status', Format(SinkFundApplication.Status));

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('description', 'BBF claim request application with CRM application number ' + SinkFundApplication."No" + ' has been created successfully.');
                ResponseObject.Add('data', ResponseData);
                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
            end else begin
                Error('Unable to create %1 request application.', Format(SinkFundApplication."Claim Type"));
            end;
        end else begin
            Error('Unknown member with member number ' + contributor_member_no.AsValue.AsText);
        end;

        exit(Response);
    end;

    local procedure UpdateBBFClaimRequest(Payload: JsonObject): Text
    var
        application_no: JsonToken;
        crm_application_no: JsonToken;
        crm_notes: JsonToken;
        crm_created_by: JsonToken;
        crm_originating_branch: JsonToken;
        type_of_claim: JsonToken;
        contributor_member_no: JsonToken;
        is_contributor_deceased: JsonToken;
        deceased_particulars_identification_type: JsonToken;
        deceased_particulars_identification: JsonToken;
        date_of_death: JsonToken;
        death_certificate_number: JsonToken;
        is_contributor_claimant: JsonToken;
        claimant_particulars_identification_type: JsonToken;
        claimant_particulars_identification: JsonToken;
        claimant_particulars_name: JsonToken;
        claimant_particulars_relationship: JsonToken; // FRIEND,RELATIVE

        KeyExists: Boolean;

        SinkFundApplication: Record "SinkFund Report Information";
        NOK: Record "Next of KIN";
        ContributorMember: Record Members;
        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        KeyExists := Payload.Get('application_no', application_no);
        KeyExists := Payload.Get('crm_application_no', crm_application_no);
        KeyExists := Payload.Get('crm_notes', crm_notes);
        KeyExists := Payload.Get('crm_created_by', crm_created_by);
        KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);
        KeyExists := Payload.Get('type_of_claim', type_of_claim);
        KeyExists := Payload.Get('contributor_member_no', contributor_member_no);
        KeyExists := Payload.Get('is_contributor_deceased', is_contributor_deceased);
        KeyExists := Payload.SelectToken('$.deceased_particulars.identification_type', deceased_particulars_identification_type);
        KeyExists := Payload.SelectToken('$.deceased_particulars.identification', deceased_particulars_identification);
        KeyExists := Payload.Get('date_of_death', date_of_death);
        KeyExists := Payload.Get('death_certificate_number', death_certificate_number);
        KeyExists := Payload.Get('is_contributor_claimant', is_contributor_claimant);
        KeyExists := Payload.SelectToken('$.claimant_particulars.identification_type', claimant_particulars_identification_type);
        KeyExists := Payload.SelectToken('$.claimant_particulars.identification', claimant_particulars_identification);
        KeyExists := Payload.SelectToken('$.claimant_particulars.name', claimant_particulars_name);
        KeyExists := Payload.SelectToken('$.claimant_particulars.relationship', claimant_particulars_relationship);

        ContributorMember.Reset;
        ContributorMember.SetRange("No.", contributor_member_no.AsValue.AsText);

        if ContributorMember.FindFirst then begin
            SinkFundApplication.Reset;

            SinkFundApplication.SetRange(No, application_no.AsValue.AsText);
            SinkFundApplication.SetRange("Sent Back to CRM", true);

            if SinkFundApplication.FindFirst then begin

                // SinkFundApplication."CRM Created By" := crm_created_by.AsValue.AsText;
                SinkFundApplication."CRM Originating Branch" := crm_originating_branch.AsValue.AsText;
                SinkFundApplication."CRM Notes" := crm_notes.AsValue.AsText;

                SinkFundApplication."Claim Type" := type_of_claim.AsValue.AsInteger;
                if (SinkFundApplication."Claim Type" = SinkFundApplication."Claim Type"::"BBF - Principle Claim") or
                (SinkFundApplication."Claim Type" = SinkFundApplication."Claim Type"::"Risk Claim") then begin
                    SinkFundApplication.Relationship := 'SELF';
                end;

                SinkFundApplication."Member No" := contributor_member_no.AsValue.AsText;
                SinkFundApplication.Validate("Member No");
                // SinkFundApplication."Staff No." := ContributorMember."Payroll/Staff No.";

                SinkFundApplication."Date of Death" := date_of_death.AsValue.AsDate;

                IF (is_contributor_deceased.AsValue.AsBoolean = true) then begin
                    IF StrLen(ContributorMember.Name) > 0 then begin
                        SinkFundApplication."Deceased Person" := ContributorMember.Name;
                    end else begin
                        SinkFundApplication."Deceased Person" := ContributorMember."First Name" + ' ' + ContributorMember."Middle Name" + ' ' + ContributorMember."Other Names";
                        SinkFundApplication."Deceased Person" := SinkFundApplication."Deceased Person".Trim();
                    end;

                    // SinkFundApplication."Claim Type" := SinkFundApplication."Claim Type"::"BBF - Principle Claim";
                    SinkFundApplication."Claim Type" := type_of_claim.AsValue.AsInteger;
                    SinkFundApplication.Relationship := 'SELF';
                end else begin
                    //deceased_particulars - NOK
                    NOK.Reset;
                    NOK.SetRange("Record ID", ContributorMember."No.");
                    NOK.SetFilter("Identification Type", deceased_particulars_identification_type.AsValue.AsText);
                    NOK.SetRange(Identification, deceased_particulars_identification.AsValue.AsText);

                    if NOK.FindFirst then begin
                        if SinkFundApplication."Claim Type" = SinkFundApplication."Claim Type"::"BBF - Dependant Claim" then begin
                            if NOK.Removed or NOK.Deceased then begin
                                if Nok.Removed then begin
                                    Error('Ineligible next of kin. Removed = %1',
                                        Format(NOK.Removed)
                                    );
                                end;
                                if Nok.Deceased then begin
                                    Error('Ineligible next of kin. Deceased = %1',
                                        Format(NOK.Deceased)
                                    );
                                end;
                            end;
                        end else begin
                            if Nok.Removed then begin
                                Error('Ineligible next of kin. Removed = %1',
                                    Format(NOK.Removed)
                                );
                            end;
                        end;

                        SinkFundApplication."Deceased Person" := NOK.Name;

                        SinkFundApplication."Next of KIN" := NOK.Identification;
                        SinkFundApplication.Validate("Next of KIN");
                    end else begin
                        Error('The deceased with particulars %1 = %2 NOT found within the member BBF beneficiaries list.',
                        deceased_particulars_identification_type.AsValue.AsText,
                        deceased_particulars_identification.AsValue.AsText);
                    end;

                    // SinkFundApplication."Claim Type" := SinkFundApplication."Claim Type"::"BBF - Dependant Claim";
                    SinkFundApplication."Claim Type" := type_of_claim.AsValue.AsInteger;
                end;

                SinkFundApplication."Burial Permit Number" := death_certificate_number.asValue.asText;

                IF (is_contributor_claimant.AsValue.AsBoolean = true) then begin
                    IF StrLen(ContributorMember.Name) > 0 then begin
                        SinkFundApplication."Reported By Name" := ContributorMember.Name;
                    end else begin
                        SinkFundApplication."Reported By Name" := ContributorMember."First Name" + ' ' + ContributorMember."Middle Name" + ' ' + ContributorMember."Other Names";
                        SinkFundApplication."Reported By Name" := SinkFundApplication."Reported By Name".Trim();
                    end;
                    SinkFundApplication."Reported By ID No" := ContributorMember."Primary Identification";
                    SinkFundApplication.Validate("Reported By ID No");
                    SinkFundApplication."Reported By Relationship" := 'SELF';
                end else begin
                    //claimant_particulars - NOK
                    NOK.Reset;
                    NOK.SetRange("Record ID", ContributorMember."No.");
                    NOK.SetFilter("Identification Type", claimant_particulars_identification_type.AsValue.AsText);
                    NOK.SetRange(Identification, claimant_particulars_identification.AsValue.AsText);

                    if NOK.FindFirst then begin
                        SinkFundApplication."Reported By Name" := NOK.Name;
                        SinkFundApplication."Reported By ID No" := NOK.Identification;
                        SinkFundApplication.Validate("Reported By ID No");
                        SinkFundApplication."Reported By Relationship" := NOK.Relationship;
                    end else begin
                        // Error('The claimant with particulars %1 = %2 NOT found within the member BBF beneficiaries list.',
                        // claimant_particulars_identification_type.AsValue.AsText,
                        // claimant_particulars_identification.AsValue.AsText);
                        SinkFundApplication."Reported By Name" := claimant_particulars_name.AsValue.AsText;
                        SinkFundApplication."Reported By ID No" := claimant_particulars_identification.AsValue.AsText;
                        SinkFundApplication.Validate("Reported By ID No");
                        SinkFundApplication."Reported By Relationship" := claimant_particulars_relationship.AsValue.AsText;
                    end;
                end;

                SinkFundApplication.Status := SinkFundApplication.Status::Open;
                // SinkFundApplication."Captured By" := UserId;
                SinkFundApplication."Captured By" := crm_created_by.AsValue.AsText;
                SinkFundApplication.Date := Today;

                SinkFundApplication."Sent Back to CRM" := false;

                SinkFundApplication.Validate("Claim Type");
                Payload.WriteTo(SinkFundApplication."CRM Payload");

                SinkFundApplication."Date of Death" := date_of_death.AsValue.AsDate;
                SinkFundApplication.Validate("Date of Death");

                IF SinkFundApplication.Modify(true) then begin
                    // Handle CRM branch assigmnent
                    SinkFundApplication."Global Dimension 1 Code" := GlobalFunctions.GetBranchCodeFromCRMOrigination(SinkFundApplication."CRM Originating Branch");
                    SinkFundApplication.Modify;

                    // CRM Comments/Notes
                    GlobalFunctions.InsertCommentRecord(
                        SinkFundApplication."No",
                        crm_notes.AsValue.AsText,
                        crm_created_by.AsValue.AsText,
                        SinkFundApplication."Global Dimension 1 Code",
                        SinkFundApplication."Global Dimension 2 Code",
                        SinkFundApplication."Responsibily Center",
                        false
                    );

                    ResponseData.Add('application_number', SinkFundApplication."No");
                    ResponseData.Add('application_status', Format(SinkFundApplication.Status));

                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('description', 'BBF claim request application with CRM application number ' + SinkFundApplication."No" + ' has been updated successfully.');
                    ResponseObject.Add('data', ResponseData);
                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                end else begin
                    Error('Unable to update BBF claim request application.');
                end;

            end else begin
                Error('BBF claim request application with number %1 is NOT available for editing', application_no.AsValue.AsText);
            end;
        end else begin
            Error('Unknown member with member number ' + contributor_member_no.AsValue.AsText);
        end;

        exit(Response);
    end;

    local procedure GetBBFClaimRequests(Payload: JsonObject): Text
    var
        filter_property: JsonToken;
        filter_value: JsonToken;
        start_date: JsonToken;
        end_date: JsonToken;
        page_number: JsonToken;
        page_size: JsonToken;
        crm_branch: JsonToken;

        KeyExists: Boolean;

        BBFClaimRequests: Record "SinkFund Report Information";
        ApplicationTrails: record "Approval Entry";
        SLA: record "Defined SLA";
        Comment: record "Comments";

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;
        Count: Integer;
        FirstRow: Integer;
        LastRow: Integer;
        TotalFoundRecords: Integer;
        SearchString: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        KeyExists := Payload.Get('filter_property', filter_property);
        KeyExists := Payload.Get('filter_value', filter_value);
        KeyExists := Payload.Get('start_date', start_date);
        KeyExists := Payload.Get('end_date', end_date);
        KeyExists := Payload.Get('crm_branch', crm_branch);
        Payload.Get('page_number', page_number);
        Payload.Get('page_size', page_size);

        BBFClaimRequests.Reset;
        BBFClaimRequests.SetCurrentKey(No);
        BBFClaimRequests.SetAscending(No, false);

        if KeyExists then begin
            if (crm_branch.AsValue.AsText <> 'ALL') then begin
                BBFClaimRequests.SetRange(BBFClaimRequests."CRM Originating Branch", crm_branch.AsValue.AsText);
            end;
        end;

        // Search Value
        if (not filter_property.AsValue.IsNull) and (not filter_value.AsValue.IsNull) then begin
            if (filter_property.AsValue.AsText <> '') and (filter_value.AsValue.AsText <> '') then begin
                SearchString := filter_value.AsValue.AsText;

                case filter_property.AsValue.AsText of
                    'application_no':
                        BBFClaimRequests.SetRange(BBFClaimRequests."No", SearchString);
                    'crm_application_no':
                        BBFClaimRequests.SetRange(BBFClaimRequests."CRM Application No.", SearchString);
                    'contributor_member_no':
                        BBFClaimRequests.SetRange(BBFClaimRequests."Member No", SearchString);
                    'status':
                        BBFClaimRequests.SetFilter(BBFClaimRequests.Status, SearchString);
                    else
                        BBFClaimRequests.SetRange(BBFClaimRequests."No", SearchString);
                end;
            end;
        end;

        // Start Date & End Date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));

                BBFClaimRequests.SetFilter(Date, '>=%1&<=%2', StartDate, EndDate);
            end;
        end;

        BBFClaimRequests.SetFilter("CRM Payload", '<>%1', '');

        IF BBFClaimRequests.FindSet then begin
            // Data found
            Count := 0;
            FirstRow := ((page_number.AsValue.AsInteger - 1) * page_size.AsValue.AsInteger) + 1;
            LastRow := page_number.AsValue.AsInteger * page_size.AsValue.AsInteger;

            TotalFoundRecords := BBFClaimRequests.Count;

            repeat begin
                Count += 1;

                if (Count >= FirstRow) and (Count <= LastRow) then begin
                    BBFClaimRequests.CalcFields("Member Name");

                    Datum.Add('application_no', BBFClaimRequests."No");
                    Datum.Add('crm_application_no', BBFClaimRequests."CRM Application No.");
                    Datum.Add('claim_type', Format(BBFClaimRequests."Claim Type"));
                    Datum.Add('contributor_member_no', BBFClaimRequests."Member No");
                    Datum.Add('contributor_member_name', BBFClaimRequests."Member Name");
                    Datum.Add('deceased_person', BBFClaimRequests."Deceased Person");
                    Datum.Add('date_of_death', BBFClaimRequests."Date of Death");
                    Datum.Add('death_certificate_number', BBFClaimRequests."Burial Permit Number");
                    Datum.Add('reported_by', BBFClaimRequests."Reported By Name");
                    Datum.Add('crm_created_by', BBFClaimRequests."CRM Created By");
                    Datum.Add('crm_originating_branch', BBFClaimRequests."CRM Originating Branch");
                    Datum.Add('status', Format(BBFClaimRequests.Status));
                    Datum.Add('captured_by', BBFClaimRequests."Captured By");
                    Datum.Add('posted', BBFClaimRequests.Posted);
                    Datum.Add('posted_by', BBFClaimRequests."Posted By");
                    Datum.Add('date', GlobalFunctions.FormatISODate(BBFClaimRequests.Date));
                    Datum.Add('is_sent_back_to_crm', BBFClaimRequests."Sent Back to CRM");

                    ApplicationTrails.Reset;

                    ApplicationTrails.SetRange("Document No.", BBFClaimRequests."No");

                    if ApplicationTrails.FindLast then begin
                        Datum.Add('responsible_officer', ApplicationTrails."Sender ID");
                        Datum.Add('supervisor_id', ApplicationTrails."Approver ID");
                    end else begin
                        BBFClaimRequests.CalcFields(
                            "Responsible Officer",
                            "Supervisor ID"
                        );
                        Datum.Add('responsible_officer', BBFClaimRequests."Responsible Officer");
                        Datum.Add('supervisor_id', BBFClaimRequests."Supervisor ID");
                    end;
                    Datum.Add('document_stage', Format(BBFClaimRequests."Document Stage"));
                    Datum.Add('account_closure_date', BBFClaimRequests."Account Closure Date");
                    Datum.Add('originating_department', BBFClaimRequests."Originating Department");
                    Datum.Add('current_department', BBFClaimRequests."Current Department");

                    // SLA
                    WorkDays := 0;
                    SLADays := 0;
                    DelayDays := 0;
                    StatusComment := '';

                    SLA.reset();

                    case BBFClaimRequests."Claim Type" of
                        BBFClaimRequests."Claim Type"::"BBF - Insurance Claim":
                            SLA.SetRange("Origination Type", SLA."Origination Type"::"Insurance Claim");
                        BBFClaimRequests."Claim Type"::"Risk Claim":
                            SLA.SetRange("Origination Type", SLA."Origination Type"::"Risk Claim");
                        else
                            SLA.SetRange("Origination Type", SLA."Origination Type"::"BBF Claim");
                    end;

                    if SLA.findfirst() then
                        SLADays := SLA.SLA;

                    if (BBFClaimRequests."Date Posted" <> 0D) and (BBFClaimRequests.Date <> 0D) and (BBFClaimRequests."Application Time" <> 0T) and (BBFClaimRequests."Time Posted" <> 0T) then begin
                        Globalfunctions.HoursBetweenPeriods(BBFClaimRequests.Date, BBFClaimRequests."Application Time", BBFClaimRequests."Date Posted", BBFClaimRequests."Time Posted", Duration, WokedOnANonWorkingPeriod);
                        WorkDays := Duration;
                        DelayDays := WorkDays - (SLADays / 3);
                        IF DelayDays < 0 then DelayDays := 0;
                    end;

                    Comment.reset();
                    Comment.SetRange("Header No.", BBFClaimRequests.No);
                    If Comment.FindLast() then begin
                        StatusComment := Comment.Comment;
                    end;

                    Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
                    Datum.Add('SLA_days', Format(SLADays));
                    Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
                    Datum.Add('tat_status', Format(TAtStatus));
                    Datum.Add('status_comment', StatusComment);
                    Datum.Add('priority', Format(Priority));

                    Data.Add(Datum);
                    // Reset
                    Datum.ReadFrom('{}');
                end;
            end until (Count = LastRow) or (BBFClaimRequests.Next = 0);

            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetBBFClaimRequest(Payload: JsonObject): Text
    var
        application_number: JsonToken;

        BBFClaimRequest: Record "SinkFund Report Information";
        ApplicationComments: Record Comments;
        ContributorMember: Record Members;
        CFDepartments: Record "CF Tracker";
        ApplicationTrails: Record "Approval Entry";

        Comments: JsonArray;
        Comment: JsonObject;

        Departments: JsonArray;
        Department: JsonObject;

        CRMPayloadParser: JsonObject;
        is_contributor_deceased: JsonToken;
        deceased_particulars: JsonToken;
        is_contributor_claimant: JsonToken;
        claimant_particulars: JsonToken;

        Datum: JsonObject;
        Response: Text;
        ResponseObject: JsonObject;
    begin
        Payload.Get('application_number', application_number);

        BBFClaimRequest.Reset;
        BBFClaimRequest.SetRange("No", application_number.AsValue.AsText);
        BBFClaimRequest.SetFilter("CRM Payload", '<>%1', '');

        IF BBFClaimRequest.FindFirst() then begin
            BBFClaimRequest.CalcFields("Member Name");

            Datum.Add('application_no', BBFClaimRequest."No");
            Datum.Add('type_of_claim', BBFClaimRequest."Claim Type");
            Datum.Add('type_of_claim_desc', Format(BBFClaimRequest."Claim Type"));
            Datum.Add('contributor_member_no', BBFClaimRequest."Member No");

            if BBFClaimRequest."CRM Payload" <> '' then begin
                CRMPayloadParser.ReadFrom(BBFClaimRequest."CRM Payload");

                CRMPayloadParser.Get('is_contributor_deceased', is_contributor_deceased);
                Datum.Add('is_contributor_deceased', is_contributor_deceased);

                IF (is_contributor_deceased.AsValue.AsBoolean = true) then begin
                    ContributorMember.Reset;
                    ContributorMember.SetRange("No.", BBFClaimRequest."Member No");

                    if ContributorMember.FindFirst then begin
                        deceased_particulars.ReadFrom('{}');

                        deceased_particulars.AsObject.Add('identification_type', ContributorMember."Primary Identification Type".AsInteger());
                        deceased_particulars.AsObject.Add('identification_type_desc', Format(ContributorMember."Primary Identification Type"));
                        deceased_particulars.AsObject.Add('identification', ContributorMember."Primary Identification");
                    end;
                end else begin
                    CRMPayloadParser.Get('deceased_particulars', deceased_particulars);
                end;
                Datum.Add('deceased_particulars', deceased_particulars);

                CRMPayloadParser.Get('is_contributor_claimant', is_contributor_claimant);
                Datum.Add('is_contributor_claimant', is_contributor_claimant);

                CRMPayloadParser.Get('claimant_particulars', claimant_particulars);
                IF (is_contributor_claimant.AsValue.AsBoolean = true) then begin
                    ContributorMember.Reset;
                    ContributorMember.SetRange("No.", BBFClaimRequest."Member No");

                    if ContributorMember.FindFirst then begin
                        claimant_particulars.ReadFrom('{}');

                        claimant_particulars.AsObject.Add('identification_type', ContributorMember."Primary Identification Type".AsInteger());
                        claimant_particulars.AsObject.Add('identification_type_desc', Format(ContributorMember."Primary Identification Type"));
                        claimant_particulars.AsObject.Add('identification', ContributorMember."Primary Identification");
                    end;
                end else begin
                    CRMPayloadParser.Get('claimant_particulars', claimant_particulars);
                end;
                Datum.Add('claimant_particulars', claimant_particulars);
            end;

            Datum.Add('contributor_member_name', BBFClaimRequest."Member Name");
            Datum.Add('deceased_person', BBFClaimRequest."Deceased Person");
            Datum.Add('date_of_death', BBFClaimRequest."Date of Death");
            Datum.Add('death_certificate_number', BBFClaimRequest."Burial Permit Number");
            Datum.Add('reported_by', BBFClaimRequest."Reported By Name");
            Datum.Add('reported_by_id_number', BBFClaimRequest."Reported By ID No");
            Datum.Add('reported_by_relationship', BBFClaimRequest."Reported By Relationship");
            Datum.Add('status', BBFClaimRequest.Status.AsInteger);
            Datum.Add('status_desc', Format(BBFClaimRequest.Status));
            Datum.Add('captured_by', BBFClaimRequest."Captured By");
            Datum.Add('date', GlobalFunctions.FormatISODate(BBFClaimRequest.Date));
            Datum.Add('date_posted', GlobalFunctions.FormatISODate(BBFClaimRequest."Date Posted"));
            Datum.Add('posted_by', BBFClaimRequest."Posted By");

            Datum.Add('claim_amount', BBFClaimRequest."BBF Claim Amount");

            Datum.Add('branch_code', BBFClaimRequest."Global Dimension 1 Code");
            Datum.Add('activity_code', BBFClaimRequest."Global Dimension 2 Code");
            Datum.Add('responsibility_center', BBFClaimRequest."Responsibily Center");

            Datum.Add('crm_application_no', BBFClaimRequest."CRM Application No.");
            Datum.Add('crm_created_by', BBFClaimRequest."CRM Created By");
            Datum.Add('crm_originating_branch', BBFClaimRequest."CRM Originating Branch");
            Datum.Add('crm_notes', BBFClaimRequest."CRM Notes");

            Datum.Add('is_sent_back_to_crm', BBFClaimRequest."Sent Back to CRM");

            // ---------------------------------------------------------------------------

            ApplicationTrails.Reset;

            ApplicationTrails.SetRange("Document No.", BBFClaimRequest."No");

            if ApplicationTrails.FindLast then begin
                Datum.Add('responsible_officer', ApplicationTrails."Sender ID");
                Datum.Add('supervisor_id', ApplicationTrails."Approver ID");
            end else begin
                BBFClaimRequest.CalcFields(
                    "Responsible Officer",
                    "Supervisor ID"
                );
                Datum.Add('responsible_officer', BBFClaimRequest."Responsible Officer");
                Datum.Add('supervisor_id', BBFClaimRequest."Supervisor ID");
            end;

            // ---------------------------------------------------------------------------

            Datum.Add('document_stage', Format(BBFClaimRequest."Document Stage"));
            Datum.Add('account_closure_date', BBFClaimRequest."Account Closure Date");

            Datum.Add('originating_department', BBFClaimRequest."Originating Department");
            Datum.Add('current_department', BBFClaimRequest."Current Department");

            // Comments
            ApplicationComments.Reset;

            ApplicationComments.SetRange("Header No.", BBFClaimRequest."No");
            ApplicationComments.SetCurrentKey("Entry No.");
            ApplicationComments.SetAscending("Entry No.", false);

            if ApplicationComments.FindSet then begin
                repeat begin
                    Comment.Add('comment', ApplicationComments.Comment);
                    Comment.Add('commented_by', ApplicationComments."Commented By");
                    Comment.Add('date_time', GlobalFunctions.FormatISODateTime(ApplicationComments.Date));
                    Comment.Add('is_read', ApplicationComments."Viewd By Somebody Else");

                    Comments.Add(Comment);

                    // Reset
                    Comment.ReadFrom('{}');
                end until ApplicationComments.Next = 0;
            end;

            Datum.Add('comments', Comments);

            // Department Tracker
            CFDepartments.Reset;

            CFDepartments.SetRange("Header No.", BBFClaimRequest."No");
            CFDepartments.SetCurrentKey("Entry No.");
            CFDepartments.SetAscending("Entry No.", false);

            if CFDepartments.FindSet then begin
                repeat begin
                    Department.Add('entry_no', CFDepartments."Entry No.");
                    Department.Add('header_no', CFDepartments."Header No.");
                    Department.Add('at_department', CFDepartments."At Department");
                    Department.Add('current_department', CFDepartments."Current Department");
                    Department.Add('forwarded_by', CFDepartments."Forwarded By");
                    Department.Add('time_forwarded', GlobalFunctions.FormatISODateTime(CFDepartments."Time Forwarded"));
                    Department.Add('viewed_by_recepient', CFDepartments."Viewed By Recepient");

                    Departments.Add(Department);

                    // Reset
                    Department.ReadFrom('{}');
                end until CFDepartments.Next = 0;
            end;

            Datum.Add('departments', Departments);

            Datum.Add('created_at', BBFClaimRequest.SystemCreatedAt);
            Datum.Add('modified_at', BBFClaimRequest.SystemModifiedAt);
        end else begin
            Error('BBF claim request application with number %1 NOT found.', application_number.AsValue.AsText);
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberLoansList(Payload: JsonObject): Text
    var
        member_no: JsonToken;

        LoansList: Record Loans;
        ActualLoanSchedule: Codeunit ActualLoanSchedule;
        PPlusIAmount: Decimal;
        FutureInterest: Decimal;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('member_no', member_no);

        LoansList.Reset;
        LoansList.SetRange("Member No.", member_no.AsValue.AsText);
        LoansList.SetFilter("Total Balance", '>0'); // Active loans
        LoansList.SetFilter("Outstanding Balance", '>0'); // Active loans

        IF LoansList.FindSet then begin
            repeat begin
                Datum.Add('loan_no', LoansList."Loan No.");
                Datum.Add('loan_product', LoansList."Loan Product Type");
                Datum.Add('loan_product_name', LoansList."Loan Product Type Name");
                Datum.Add('member_name', LoansList."Member Name");
                Datum.Add('application_date', LoansList."Application Date");
                Datum.Add('disbursement_date', LoansList."Disbursement Date");
                Datum.Add('expected_completion_date', LoansList."Expected Date of Completion");
                Datum.Add('applied_amount', LoansList."Requested Amount");
                Datum.Add('approved_amount', LoansList."Approved Amount");
                Datum.Add('interest', LoansList.Interest);
                Datum.Add('repayment_amount', LoansList.Repayment);
                Datum.Add('installments', LoansList.Installments);

                LoansList.CalcFields("Loans Category-SASRA");
                Datum.Add('loan_performance', Format(LoansList."Loans Category-SASRA"));
                Datum.Add('loan_sasra', Format(LoansList."Loans Category-SASRA"));

                LoansList.CalcFields("Outstanding Balance");
                Datum.Add('outstanding_balance', LoansList."Outstanding Balance");

                LoansList.CalcFields("Outstanding Interest");
                Datum.Add('outstanding_interest', LoansList."Outstanding Interest");

                LoansList.CalcFields("Total Loan Balance");
                Datum.Add('total_loan_balance', LoansList."Total Loan Balance");

                LoansList.CalcFields("Outstanding Bills");
                Datum.Add('outstanding_bills', LoansList."Outstanding Bills");

                LoansList.CalcFields("Amount In Arreas SACCO", "Amount In Arreas SASRA");
                Datum.Add('amount_in_arrears', LoansList."Amount In Arreas SACCO");
                Datum.Add('amount_in_arrears_sasra', LoansList."Amount In Arreas SASRA");

                Datum.Add('crm_application_no', LoansList."CRM Application No.");

                Datum.Add('status', Format(LoansList.Status));

                Datum.Add('prorata', LoansList."Prorata Amount");

                PPlusIAmount := 0;
                FutureInterest := 0;

                if LoansList.Installments <> 0 then begin
                    FutureInterest := ActualLoanSchedule.GenerateFutureInterest(LoansList);
                    PPlusIAmount := LoansList."Outstanding Balance" + FutureInterest;

                    Datum.Add('future_principal', LoansList."Outstanding Balance");
                    Datum.Add('future_interest', FutureInterest);
                    Datum.Add('future_repayment', PPlusIAmount);
                end else begin
                    Datum.Add('future_principal', LoansList."Outstanding Balance");
                    Datum.Add('future_interest', 0);
                    Datum.Add('future_repayment', 0);
                end;

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until LoansList.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanGuarantorsList(Payload: JsonObject): Text
    var
        loan_no: JsonToken;

        LoanGuarantorsList: Record "Loan Guarantors and Security";
        TheLoan: Record Loans;
        LoanGuar: Record "Loan Guarantors and Security";
        MajorLoans: Integer;
        MinorLoans: Integer;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('loan_no', loan_no);

        LoanGuarantorsList.Reset;
        LoanGuarantorsList.SetRange("Loan No", loan_no.AsValue.AsText);
        LoanGuarantorsList.SetRange("Guarantor Type", LoanGuarantorsList."Guarantor Type"::Guarantor);

        IF LoanGuarantorsList.FindSet then begin
            repeat begin
                Datum.Add('loan_no', LoanGuarantorsList."Loan No");
                Datum.Add('guarantor_name', LoanGuarantorsList.Name);
                Datum.Add('guarantor_member_number', LoanGuarantorsList."Member No");

                LoanGuarantorsList.CalcFields("No Of Loans Guaranteed", "Outstanding Balance", "Total Loan Balance");
                Datum.Add('number_of_loans_guaranteed', LoanGuarantorsList."No Of Loans Guaranteed");

                MajorLoans := 0;
                MinorLoans := 0;

                LoanGuar.Reset;
                // LoanGuar.SetRange("Savings Account No./Member No.", LoanGuarantorsList."Savings Account No./Member No.");
                LoanGuar.SetRange("Member No", LoanGuarantorsList."Member No");
                LoanGuar.SetRange(Substituted, false);
                LoanGuar.SetFilter("Outstanding Balance", '>0');
                if LoanGuar.FindSet then begin
                    repeat
                        if TheLoan.Get(LoanGuar."Loan No") then begin
                            TheLoan.CalcFields("Outstanding Balance");
                            if (TheLoan.Posted = true) and (TheLoan."Outstanding Balance" > 0) then begin
                                TheLoan.CalcFields("Loan Span");
                                if TheLoan."Loan Span" = TheLoan."Loan Span"::Major then
                                    MajorLoans += 1;
                                if TheLoan."Loan Span" = TheLoan."Loan Span"::Minor then
                                    MinorLoans += 1;
                            end;
                        end;
                    until LoanGuar.Next = 0;
                end;

                Datum.Add('number_of_major_loans_guaranteed', MajorLoans);
                Datum.Add('number_of_minor_loans_guaranteed', MinorLoans);

                Datum.Add('amount_guaranteed', LoanGuarantorsList."Amount Guaranteed");

                Datum.Add('outstanding_balance', LoanGuarantorsList."Outstanding Balance");
                Datum.Add('total_loan_balance', LoanGuarantorsList."Total Loan Balance");

                Datum.Add('is_self_guarantee', LoanGuarantorsList."Self Guarantee");
                Datum.Add('is_substituted', LoanGuarantorsList.Substituted);
                Datum.Add('substituted_guarantor', LoanGuarantorsList."Member Substituted");
                Datum.Add('date_substituted', LoanGuarantorsList."Date Substituted");

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until LoanGuarantorsList.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanCollateralsList(Payload: JsonObject): Text
    var
        loan_no: JsonToken;

        LoanGuarantorsList: Record "Loan Guarantors and Security";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('loan_no', loan_no);

        LoanGuarantorsList.Reset;
        LoanGuarantorsList.SetRange("Loan No", loan_no.AsValue.AsText);
        LoanGuarantorsList.SetRange("Guarantor Type", LoanGuarantorsList."Guarantor Type"::Collateral);

        IF LoanGuarantorsList.FindSet then begin
            repeat begin
                Datum.Add('loan_no', LoanGuarantorsList."Loan No");
                Datum.Add('guarantor_name', LoanGuarantorsList.Name);
                Datum.Add('guarantor_member_number', LoanGuarantorsList."Member No");

                LoanGuarantorsList.CalcFields(
                    "No Of Loans Guaranteed",
                    "Outstanding Balance", "Total Loan Balance",
                    "Collateral Value", "Collateral Name"
                    );
                Datum.Add('number_of_loans_guaranteed', LoanGuarantorsList."No Of Loans Guaranteed");

                Datum.Add('number_of_major_loans_guaranteed', LoanGuarantorsList."No Of Major Loans Guaranteed");
                Datum.Add('number_of_minor_loans_guaranteed', LoanGuarantorsList."No Of Minor Loans Guaranteed");
                Datum.Add('amount_guaranteed', LoanGuarantorsList."Amount Guaranteed");

                Datum.Add('outstanding_balance', LoanGuarantorsList."Outstanding Balance");
                Datum.Add('total_loan_balance', LoanGuarantorsList."Total Loan Balance");

                Datum.Add('is_self_guarantee', LoanGuarantorsList."Self Guarantee");
                Datum.Add('is_substituted', LoanGuarantorsList.Substituted);
                Datum.Add('substituted_guarantor', LoanGuarantorsList."Member Substituted");
                Datum.Add('date_substituted', LoanGuarantorsList."Date Substituted");

                Datum.Add('collateral_reg_no', LoanGuarantorsList."Collateral Reg. No.");
                Datum.Add('collateral_value', LoanGuarantorsList."Collateral Value");
                Datum.Add('collateral_name', LoanGuarantorsList."Collateral Name");

                LoanGuarantorsList.CalcFields("Source Unit", "Loan Type", "Loan Product Name");
                Datum.Add('source_unit', LoanGuarantorsList."Source Unit");
                Datum.Add('loan_type', LoanGuarantorsList."Loan Type");
                Datum.Add('loan_product_name', LoanGuarantorsList."Loan Product Name");

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until LoanGuarantorsList.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CreateLoanGuarantorSubstitutionRequest(Payload: JsonObject): Text
    var
        crm_application_no: JsonToken;
        member_no: JsonToken;
        member_loan: JsonToken;
        crm_notes: JsonToken;
        crm_originating_branch: JsonToken;
        crm_created_by: JsonToken;
        new_guarantors: JsonToken;
        new_guarantor: JsonToken;
        new_guarantor_member_number: JsonToken;
        new_guarantor_amount: JsonToken;
        new_guarantor_substituted_member_number: JsonToken;

        KeyExists: Boolean;

        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        NewNo: Code[20];
        NewNoSeriesCode: Code[20];
        // CRMNewNo: Code[20];
        // CRMNewNoSeriesCode: Code[20];

        LoaneeMember: Record Members;
        LoaneeLoan: Record Loans;
        LoanGuarantorSubstitution: Record "Guarantors Substitution";
        LoanGuarantors: Record "Loan Guarantors Sub";
        SubstitutedLoanGuarantor: Record "Loan Guarantors Sub";
        NewLoanGuarantorSavingsAccount: Record "Savings Accounts";
        LGSec: Record "Loan Guarantors and Security";
        Comment: Record "Loan Appraisal Comments";
        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        KeyExists := Payload.Get('crm_application_no', crm_application_no);
        KeyExists := Payload.Get('member_no', member_no);
        KeyExists := Payload.Get('member_loan', member_loan);
        KeyExists := Payload.Get('crm_notes', crm_notes);
        KeyExists := Payload.Get('crm_created_by', crm_created_by);
        KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);
        KeyExists := Payload.Get('new_guarantors', new_guarantors);

        LoaneeMember.Reset;
        LoaneeMember.SetRange("No.", member_no.AsValue.AsText);

        if LoaneeMember.FindFirst then begin
            LoaneeLoan.Reset;
            LoaneeLoan.SetRange("Member No.", LoaneeMember."No.");
            LoaneeLoan.SetRange("Loan No.", member_loan.AsValue.AsText);
            // LoaneeLoan.SetFilter(Status, '=%1|%2' , LoaneeLoan.Status::Approved, LoaneeLoan.Status::Posted);

            IF LoaneeLoan.FindFirst then begin
                LoanGuarantorSubstitution.Init;

                SeriesSetup.Get;
                SeriesSetup.TestField(SeriesSetup."Guarantors Substitution");
                NewNo := NoSeriesMgt.GetNextNo(SeriesSetup."Guarantors Substitution");
                // NoSeriesMgt.InitSeries(SeriesSetup."Guarantors Substitution", SeriesSetup."Guarantors Substitution", 0D, NewNo, NewNoSeriesCode);

                LoanGuarantorSubstitution."No." := NewNo;
                LoanGuarantorSubstitution."No. Series" := NewNoSeriesCode;

                LoanGuarantorSubstitution."Loan No." := LoaneeLoan."Loan No.";
                LoanGuarantorSubstitution."Member No." := LoaneeLoan."Member No.";
                LoanGuarantorSubstitution.Validate("Loan No.");

                LoanGuarantorSubstitution."Loan Account No." := LoaneeLoan."Loan Account";
                LoanGuarantorSubstitution.Name := LoaneeLoan."Member Name";
                // LoanGuarantorSubstitution."Account Status" := LoaneeLoan.Status;
                LoanGuarantorSubstitution.Status := LoanGuarantorSubstitution.Status::Open;
                LoanGuarantorSubstitution."Posted By" := '';

                // LoanGuarantorSubstitution."CRM Application No." := crm_application_no.AsValue.AsText;
                LoanGuarantorSubstitution."CRM Created By" := crm_created_by.AsValue.AsText;
                LoanGuarantorSubstitution."CRM Originating Branch" := crm_originating_branch.AsValue.AsText;
                LoanGuarantorSubstitution."CRM Notes" := crm_notes.AsValue.AsText;

                if crm_created_by.AsValue.AsText = '' then begin
                    Error('ERR_401. Invalid application. Origination NOT accepted!');
                end;

                // CRM - No Series
                // SeriesSetup.TestField(SeriesSetup."CRM - Loan Guarantor Subs");
                // NoSeriesMgt.InitSeries(SeriesSetup."CRM - Loan Guarantor Subs", SeriesSetup."CRM - Loan Guarantor Subs", 0D, CRMNewNo, CRMNewNoSeriesCode);

                // LoanGuarantorSubstitution."CRM Application No." := CRMNewNo;
                // LoanGuarantorSubstitution."CRM No. Series" := CRMNewNoSeriesCode;

                IF LoanGuarantorSubstitution.Insert(true) then begin
                    // LoanGuarantorSubstitution."Captured By" := LoanGuarantorSubstitution."CRM Created By";
                    LoanGuarantorSubstitution."Captured By" := 'CRM';
                    LoanGuarantorSubstitution."CRM Application No." := LoanGuarantorSubstitution."No.";
                    LoanGuarantorSubstitution."CRM No. Series" := LoanGuarantorSubstitution."No. Series";
                    LoanGuarantorSubstitution."CRM Created By" := LoanGuarantorSubstitution."CRM Created By";

                    LoanGuarantorSubstitution.Modify;

                    // CRM Comments/Notes
                    if crm_notes.AsValue.AsText <> '' then begin
                        Comment.Init;

                        Comment."Loan No." := LoaneeLoan."Loan No.";
                        Comment.Comment := crm_notes.AsValue.AsText;
                        Comment.Appraiser := crm_created_by.AsValue.AsText;
                        Comment."Entry Date" := Today;
                        Comment."Entry Time" := Time;
                        Comment.Commented := true;

                        Comment.Insert(false);
                    end;

                    foreach new_guarantor in new_guarantors.AsArray do begin
                        // {
                        //     "guarantor_member_number": "MB002",
                        //     "amount": 100.00,
                        //     "substituted_member_number": "MB0001"
                        // }
                        KeyExists := new_guarantor.SelectToken('new_guarantor_member_number', new_guarantor_member_number);
                        KeyExists := new_guarantor.SelectToken('new_guarantor_amount', new_guarantor_amount);
                        KeyExists := new_guarantor.SelectToken('substituted_guarantor_member_number', new_guarantor_substituted_member_number);

                        LoanGuarantors.Reset;
                        LoanGuarantors.Init;

                        LoanGuarantors."No." := NewNo;

                        NewLoanGuarantorSavingsAccount.SetRange("Member No.", new_guarantor_member_number.AsValue.AsText);
                        NewLoanGuarantorSavingsAccount.SetRange("Can Guarantee Loan", true);

                        if LoaneeLoan."Source Unit" = LoaneeLoan."Source Unit"::"BUSINESS LOANS" then begin
                            NewLoanGuarantorSavingsAccount.SetRange("Product Category", NewLoanGuarantorSavingsAccount."Product Category"::"Business Deposits");
                        end else begin
                            NewLoanGuarantorSavingsAccount.SetRange("Product Category", NewLoanGuarantorSavingsAccount."Product Category"::"BOSA Deposits");
                        end;

                        IF NewLoanGuarantorSavingsAccount.FindFirst then begin
                            LoanGuarantors."Savings Account No." := NewLoanGuarantorSavingsAccount."No.";
                            LoanGuarantors.Validate("Savings Account No.");
                            LoanGuarantors."Member No" := NewLoanGuarantorSavingsAccount."Member No.";
                        end else begin
                            Error('Guarantor with member number %1 does NOT have a savings account', new_guarantor_member_number.AsValue.AsText);
                        end;

                        LoanGuarantors."Loan No" := LoaneeLoan."Loan No.";

                        LoanGuarantors.Validate("Member No");

                        LGSec.Reset;
                        LGSec.SetRange("Loan No", LoaneeLoan."Loan No.");
                        LGSec.SetRange("Member No", new_guarantor_substituted_member_number.AsValue.AsText);

                        if LGSec.FindFirst then begin
                            LoanGuarantors."Guarantor Type" := LoanGuarantors."Guarantor Type"::Guarantor;
                            LoanGuarantors."Member Substituted" := LGSec."Savings Account No./Member No.";
                            LoanGuarantors.Validate("Member Substituted");

                            SubstitutedLoanGuarantor.Reset;
                            SubstitutedLoanGuarantor.SetRange("Loan No", LoanGuarantors."Loan No");
                            SubstitutedLoanGuarantor.SetRange("Savings Account No.", LoanGuarantors."Member Substituted");

                            if SubstitutedLoanGuarantor.FindFirst then begin
                                SubstitutedLoanGuarantor.Substituted := true;
                                SubstitutedLoanGuarantor.Modify(false);
                            end;
                        end else begin
                            Error('Guarantor with member number %1 does NOT have a savings account', new_guarantor_substituted_member_number.AsValue.AsText);
                        end;

                        LoanGuarantors.Substituted := false;
                        LoanGuarantors.Validate(Substituted);

                        LoanGuarantors."Amount Guaranteed" := new_guarantor_amount.AsValue.AsDecimal;
                        LoanGuarantors."SMS Sent" := false;

                        LoanGuarantors.Insert(true);
                    end;

                    // LoanGuarantorSubstitution.CalcFields("Member No.");
                    EDMSFunctions.EDMSScannedLog(
                        LoanGuarantorSubstitution."No.",
                        "CRM Originations"::"Loan Guarantor Substitution",
                        LoaneeLoan."Member No.",
                        LoanGuarantorSubstitution."CRM Created By",
                        LoanGuarantorSubstitution."CRM Originating Branch"
                    );

                    // Handle CRM branch assigmnent
                    LoanGuarantorSubstitution."Global Dimension 1 Code" := GlobalFunctions.GetBranchCodeFromCRMOrigination(LoanGuarantorSubstitution."CRM Originating Branch");
                    LoanGuarantorSubstitution."Global Dimension 2 Code" := LoaneeLoan."Global Dimension 2 Code";

                    LoanGuarantorSubstitution.Modify;

                    LoanGuarantorSubstitution.Reset;

                    LoanGuarantorSubstitution.SetRange("No.", NewNo);
                    ResponseData.Add('application_number', LoanGuarantorSubstitution."No.");
                    ResponseData.Add('application_status', Format(LoanGuarantorSubstitution.Status));

                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('description', 'Loan guarantor substitution application with CRM application number ' + LoanGuarantorSubstitution."No." + ' has been created successfully.');
                    ResponseObject.Add('data', ResponseData);
                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                end else begin
                    Error('Unable to create loan guarantor substitution application.');
                end;

            end else begin
                Error('Unknown loan with loan number ' + member_loan.AsValue.AsText);
            end;
        end else begin
            Error('Unknown member with member number ' + member_no.AsValue.AsText);
        end;
        exit(Response);
    end;

    local procedure UpdateLoanGuarantorSubstitutionRequest(Payload: JsonObject): Text
    var
        application_no: JsonToken;
        crm_application_no: JsonToken;
        member_no: JsonToken;
        member_loan: JsonToken;
        crm_notes: JsonToken;
        crm_originating_branch: JsonToken;
        crm_created_by: JsonToken;
        new_guarantors: JsonToken;
        new_guarantor: JsonToken;
        new_guarantor_member_number: JsonToken;
        new_guarantor_amount: JsonToken;
        new_guarantor_substituted_member_number: JsonToken;

        KeyExists: Boolean;

        LoaneeMember: Record Members;
        LoaneeLoan: Record Loans;
        LoanGuarantorSubstitution: Record "Guarantors Substitution";
        LoanGuarantors: Record "Loan Guarantors Sub";
        SubstitutedLoanGuarantor: Record "Loan Guarantors Sub";
        NewLoanGuarantorSavingsAccount: Record "Savings Accounts";
        LGSec: Record "Loan Guarantors and Security";
        Comment: Record "Loan Appraisal Comments";
        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        KeyExists := Payload.Get('application_no', application_no);
        KeyExists := Payload.Get('crm_application_no', crm_application_no);
        KeyExists := Payload.Get('member_no', member_no);
        KeyExists := Payload.Get('member_loan', member_loan);
        KeyExists := Payload.Get('crm_notes', crm_notes);
        KeyExists := Payload.Get('crm_created_by', crm_created_by);
        KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);
        KeyExists := Payload.Get('new_guarantors', new_guarantors);

        LoaneeMember.Reset;
        LoaneeMember.SetRange("No.", member_no.AsValue.AsText);

        if LoaneeMember.FindFirst then begin
            LoaneeLoan.Reset;
            LoaneeLoan.SetRange("Member No.", LoaneeMember."No.");
            LoaneeLoan.SetRange("Loan No.", member_loan.AsValue.AsText);
            // LoaneeLoan.SetFilter(Status, '=%1|%2' , LoaneeLoan.Status::Approved, LoaneeLoan.Status::Posted);

            IF LoaneeLoan.FindFirst then begin
                LoanGuarantorSubstitution.Reset;
                LoanGuarantorSubstitution.SetRange("No.", application_no.AsValue.AsText);
                LoanGuarantorSubstitution.SetRange("Sent Back to CRM", true);

                if LoanGuarantorSubstitution.FindFirst then begin
                    LoanGuarantorSubstitution."Loan No." := LoaneeLoan."Loan No.";
                    LoanGuarantorSubstitution."Member No." := LoaneeLoan."Member No.";
                    LoanGuarantorSubstitution.Validate("Loan No.");

                    LoanGuarantorSubstitution."Loan Account No." := LoaneeLoan."Loan Account";
                    LoanGuarantorSubstitution.Name := LoaneeLoan."Member Name";
                    // LoanGuarantorSubstitution."Account Status" := LoaneeLoan.Status;
                    LoanGuarantorSubstitution.Status := LoanGuarantorSubstitution.Status::Open;
                    LoanGuarantorSubstitution."Posted By" := '';

                    // LoanGuarantorSubstitution."CRM Application No." := crm_application_no.AsValue.AsText;
                    // LoanGuarantorSubstitution."CRM Created By" := crm_created_by.AsValue.AsText;
                    LoanGuarantorSubstitution."CRM Originating Branch" := crm_originating_branch.AsValue.AsText;
                    LoanGuarantorSubstitution."CRM Notes" := crm_notes.AsValue.AsText;

                    LoanGuarantorSubstitution."Sent Back to CRM" := false;

                    IF LoanGuarantorSubstitution.Modify(true) then begin
                        // LoanGuarantorSubstitution."Captured By" := LoanGuarantorSubstitution."CRM Created By";
                        LoanGuarantorSubstitution."Captured By" := 'CRM';
                        LoanGuarantorSubstitution."CRM Created By" := LoanGuarantorSubstitution."CRM Created By";
                        LoanGuarantorSubstitution.Modify;

                        // CRM Comments/Notes
                        if crm_notes.AsValue.AsText <> '' then begin
                            Comment.Init;

                            Comment."Loan No." := LoaneeLoan."Loan No.";
                            Comment.Comment := crm_notes.AsValue.AsText;
                            Comment.Appraiser := crm_created_by.AsValue.AsText;
                            Comment."Entry Date" := Today;
                            Comment."Entry Time" := Time;
                            Comment.Commented := true;

                            Comment.Insert(false);
                        end;

                        // Guarantors
                        // LoanGuarantors.Reset;
                        // LoanGuarantors.SetRange("Loan No", LoaneeLoan."Loan No.");
                        // LoanGuarantors.SetRange("No.", LoanGuarantorSubstitution."No.");

                        // if LoanGuarantors.FindSet then begin
                        //     repeat begin
                        //         KeyExists := LoanGuarantors.Delete(true);
                        //     end until LoanGuarantors.Next = 0;
                        // end;

                        foreach new_guarantor in new_guarantors.AsArray do begin
                            // {
                            //     "guarantor_member_number": "MB002",
                            //     "amount": 100.00,
                            //     "substituted_member_number": "MB0001"
                            // }
                            KeyExists := new_guarantor.SelectToken('new_guarantor_member_number', new_guarantor_member_number);
                            KeyExists := new_guarantor.SelectToken('new_guarantor_amount', new_guarantor_amount);
                            KeyExists := new_guarantor.SelectToken('substituted_guarantor_member_number', new_guarantor_substituted_member_number);

                            // -----------------------------------------------------------------------------------

                            LoanGuarantors.Reset;
                            LoanGuarantors.SetRange("Loan No", LoaneeLoan."Loan No.");
                            LoanGuarantors.SetRange("No.", LoanGuarantorSubstitution."No.");
                            LoanGuarantors.SetRange("Member No", new_guarantor_member_number.AsValue.AsText);
                            if LoanGuarantors.FindSet then begin
                                repeat begin
                                    KeyExists := LoanGuarantors.Delete(true);
                                end until LoanGuarantors.Next = 0;
                            end;

                            // -----------------------------------------------------------------------------------

                            Clear(LoanGuarantors);
                            LoanGuarantors.Init;

                            LoanGuarantors."No." := LoanGuarantorSubstitution."No.";

                            NewLoanGuarantorSavingsAccount.SetRange("Member No.", new_guarantor_member_number.AsValue.AsText);
                            NewLoanGuarantorSavingsAccount.SetRange("Can Guarantee Loan", true);

                            if LoaneeLoan."Source Unit" = LoaneeLoan."Source Unit"::"BUSINESS LOANS" then begin
                                NewLoanGuarantorSavingsAccount.SetRange("Product Category", NewLoanGuarantorSavingsAccount."Product Category"::"Business Deposits");
                            end else begin
                                NewLoanGuarantorSavingsAccount.SetRange("Product Category", NewLoanGuarantorSavingsAccount."Product Category"::"BOSA Deposits");
                            end;

                            IF NewLoanGuarantorSavingsAccount.FindFirst then begin
                                LoanGuarantors."Savings Account No." := NewLoanGuarantorSavingsAccount."No.";
                                LoanGuarantors.Validate("Savings Account No.");
                                LoanGuarantors."Member No" := NewLoanGuarantorSavingsAccount."Member No.";
                            end else begin
                                Error('Guarantor with member number %1 does NOT have a savings account', new_guarantor_member_number.AsValue.AsText);
                            end;

                            LoanGuarantors."Loan No" := LoaneeLoan."Loan No.";

                            LoanGuarantors.Validate("Member No");

                            LGSec.Reset;
                            LGSec.SetRange("Loan No", LoaneeLoan."Loan No.");
                            LGSec.SetRange("Member No", new_guarantor_substituted_member_number.AsValue.AsText);

                            if LGSec.FindFirst then begin
                                LoanGuarantors."Guarantor Type" := LoanGuarantors."Guarantor Type"::Guarantor;
                                LoanGuarantors."Member Substituted" := LGSec."Savings Account No./Member No.";
                                LoanGuarantors.Validate("Member Substituted");

                                SubstitutedLoanGuarantor.Reset;
                                SubstitutedLoanGuarantor.SetRange("Loan No", LoanGuarantors."Loan No");
                                SubstitutedLoanGuarantor.SetRange("Savings Account No.", LoanGuarantors."Member Substituted");

                                if SubstitutedLoanGuarantor.FindFirst then begin
                                    SubstitutedLoanGuarantor.Substituted := true;
                                    SubstitutedLoanGuarantor.Modify(false);
                                end;
                            end else begin
                                Error('Guarantor with member number %1 does NOT have a savings account', new_guarantor_substituted_member_number.AsValue.AsText);
                            end;

                            LoanGuarantors.Substituted := false;
                            LoanGuarantors.Validate(Substituted);

                            LoanGuarantors."Amount Guaranteed" := new_guarantor_amount.AsValue.AsDecimal;
                            LoanGuarantors."SMS Sent" := false;

                            LoanGuarantors.Insert(true);
                        end;

                        // Handle CRM branch assigmnent
                        LoanGuarantorSubstitution."Global Dimension 1 Code" := GlobalFunctions.GetBranchCodeFromCRMOrigination(LoanGuarantorSubstitution."CRM Originating Branch");
                        LoanGuarantorSubstitution."Global Dimension 2 Code" := LoaneeLoan."Global Dimension 2 Code";
                        LoanGuarantorSubstitution.Modify;

                        LoanGuarantorSubstitution.Reset;

                        LoanGuarantorSubstitution.SetRange("No.", LoanGuarantorSubstitution."No.");
                        ResponseData.Add('application_number', LoanGuarantorSubstitution."No.");
                        ResponseData.Add('application_status', Format(LoanGuarantorSubstitution.Status));

                        ResponseObject.Add('status', 'SUCCESS');
                        ResponseObject.Add('description', 'Loan guarantor substitution application with CRM application number ' + LoanGuarantorSubstitution."No." + ' has been updated successfully.');
                        ResponseObject.Add('data', ResponseData);
                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                    end else begin
                        Error('Unable to update loan guarantor substitution application.');
                    end;
                end else begin
                    Error('Loan guarantor substitution request with application no %1 is NOT available for editing', application_no.AsValue.AsText);
                end;

                ;
            end else begin
                Error('Unknown loan with loan number ' + member_loan.AsValue.AsText);
            end;
        end else begin
            Error('Unknown member with member number ' + member_no.AsValue.AsText);
        end;
        exit(Response);
    end;

    local procedure GetLoanGuarantorSubstitutionRequests(Payload: JsonObject): Text
    var
        filter_property: JsonToken;
        filter_value: JsonToken;
        start_date: JsonToken;
        end_date: JsonToken;
        page_number: JsonToken;
        page_size: JsonToken;
        crm_branch: JsonToken;

        KeyExists: Boolean;

        LoanGuarantorSubstitutionRequests: Record "Guarantors Substitution";
        SLA: record "Defined SLA";
        Comment: record "Comments";
        LoaneeLoan: Record Loans;

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;
        Count: Integer;
        FirstRow: Integer;
        LastRow: Integer;
        TotalFoundRecords: Integer;
        SearchString: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        KeyExists := Payload.Get('filter_property', filter_property);
        KeyExists := Payload.Get('filter_value', filter_value);
        KeyExists := Payload.Get('start_date', start_date);
        KeyExists := Payload.Get('end_date', end_date);
        KeyExists := Payload.Get('crm_branch', crm_branch);
        Payload.Get('page_number', page_number);
        Payload.Get('page_size', page_size);

        LoanGuarantorSubstitutionRequests.Reset;
        LoanGuarantorSubstitutionRequests.SetCurrentKey(Date);
        LoanGuarantorSubstitutionRequests.SetAscending(Date, false);

        if KeyExists then begin
            if (crm_branch.AsValue.AsText <> 'ALL') then begin
                LoanGuarantorSubstitutionRequests.SetRange(LoanGuarantorSubstitutionRequests."CRM Originating Branch", crm_branch.AsValue.AsText);
            end;
        end;

        // Search Value
        if (not filter_property.AsValue.IsNull) and (not filter_value.AsValue.IsNull) then begin
            if (filter_property.AsValue.AsText <> '') and (filter_value.AsValue.AsText <> '') then begin
                SearchString := filter_value.AsValue.AsText;

                case filter_property.AsValue.AsText of
                    'application_no':
                        LoanGuarantorSubstitutionRequests.SetRange(LoanGuarantorSubstitutionRequests."No.", SearchString);
                    'loan_no':
                        LoanGuarantorSubstitutionRequests.SetRange(LoanGuarantorSubstitutionRequests."Loan No.", SearchString);
                    'crm_application_no':
                        LoanGuarantorSubstitutionRequests.SetRange(LoanGuarantorSubstitutionRequests."CRM Application No.", SearchString);
                    'status':
                        LoanGuarantorSubstitutionRequests.SetFilter(LoanGuarantorSubstitutionRequests.Status, SearchString);
                    'member_number':
                        LoanGuarantorSubstitutionRequests.SetRange(LoanGuarantorSubstitutionRequests."Member No.", SearchString);
                    else
                        LoanGuarantorSubstitutionRequests.SetRange(LoanGuarantorSubstitutionRequests."No.", SearchString);
                end;
            end;
        end;

        // Start Date & End Date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));

                LoanGuarantorSubstitutionRequests.SetFilter(Date, '>=%1&<=%2', StartDate, EndDate);
            end;
        end;

        IF LoanGuarantorSubstitutionRequests.FindSet then begin
            // Data found
            Count := 0;
            FirstRow := ((page_number.AsValue.AsInteger - 1) * page_size.AsValue.AsInteger) + 1;
            LastRow := page_number.AsValue.AsInteger * page_size.AsValue.AsInteger;

            TotalFoundRecords := LoanGuarantorSubstitutionRequests.Count;

            repeat begin
                Count += 1;

                if (Count >= FirstRow) and (Count <= LastRow) then begin
                    Datum.Add('application_no', LoanGuarantorSubstitutionRequests."No.");
                    Datum.Add('loan_no', LoanGuarantorSubstitutionRequests."Loan No.");
                    Datum.Add('name', LoanGuarantorSubstitutionRequests.Name);

                    LoaneeLoan.Reset;
                    LoaneeLoan.SetRange("Loan No.", LoanGuarantorSubstitutionRequests."Loan No.");
                    if LoaneeLoan.FindFirst then begin
                        Datum.Add('member_number', LoaneeLoan."Member No.");
                    end else begin
                        Datum.Add('member_number', '');
                    end;

                    Datum.Add('crm_application_no', LoanGuarantorSubstitutionRequests."CRM Application No.");
                    Datum.Add('crm_created_by', LoanGuarantorSubstitutionRequests."CRM Created By");
                    Datum.Add('crm_originating_branch', LoanGuarantorSubstitutionRequests."CRM Originating Branch");
                    Datum.Add('account_status', Format(LoanGuarantorSubstitutionRequests."Account Status"));
                    Datum.Add('status', Format(LoanGuarantorSubstitutionRequests.Status));

                    LoanGuarantorSubstitutionRequests.CalcFields("Responsible Officer", "Supervisor ID");

                    Datum.Add('responsible_officer', LoanGuarantorSubstitutionRequests."Responsible Officer");
                    Datum.Add('supervisor_id', LoanGuarantorSubstitutionRequests."Supervisor ID");

                    Datum.Add('captured_by', LoanGuarantorSubstitutionRequests."Captured By");
                    Datum.Add('posted', LoanGuarantorSubstitutionRequests.Posted);
                    Datum.Add('posted_by', LoanGuarantorSubstitutionRequests."Posted By");
                    Datum.Add('date', GlobalFunctions.FormatISODate(LoanGuarantorSubstitutionRequests.Date));
                    Datum.Add('is_sent_back_to_crm', LoanGuarantorSubstitutionRequests."Sent Back to CRM");

                    // SLA
                    WorkDays := 0;
                    SLADays := 0;
                    DelayDays := 0;
                    StatusComment := '';

                    SLA.reset();
                    SLA.SetRange("Origination Type", SLA."Origination Type"::"Guarantor Substitution");
                    if SLA.findfirst() then
                        SLADays := SLA.SLA;

                    if (LoanGuarantorSubstitutionRequests."Approval Date" <> 0D) and (LoanGuarantorSubstitutionRequests.Date <> 0D) and (LoanGuarantorSubstitutionRequests."Application Time" <> 0T) and (LoanGuarantorSubstitutionRequests."Approval time" <> 0T) then begin
                        Globalfunctions.HoursBetweenPeriods(LoanGuarantorSubstitutionRequests.Date, LoanGuarantorSubstitutionRequests."Application Time", LoanGuarantorSubstitutionRequests."Approval Date", LoanGuarantorSubstitutionRequests."Approval Time", Duration, WokedOnANonWorkingPeriod);
                        WorkDays := Duration;
                        DelayDays := WorkDays - (SLADays / 3);
                        IF DelayDays < 0 then DelayDays := 0;
                    end;

                    Comment.reset();
                    Comment.SetRange("Header No.", LoanGuarantorSubstitutionRequests."No.");
                    If Comment.FindLast() then begin
                        StatusComment := Comment.Comment;
                    end;

                    Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
                    Datum.Add('SLA_days', Format(SLADays));
                    Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
                    Datum.Add('tat_status', Format(TAtStatus));
                    Datum.Add('status_comment', StatusComment);
                    Datum.Add('priority', Format(Priority));

                    Data.Add(Datum);
                    // Reset
                    Datum.ReadFrom('{}');
                end;
            end until (Count = LastRow) or (LoanGuarantorSubstitutionRequests.Next = 0);

            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanGuarantorSubstitutionRequest(Payload: JsonObject): Text
    var
        application_number: JsonToken;

        LoanGuarantorSubstitutionRequest: Record "Guarantors Substitution";
        LoanGuarantors: Record "Loan Guarantors Sub";
        SubstitutedLoanGuarantor: Record "Loan Guarantors Sub";
        ApplicationComments: Record "Loan Appraisal Comments";
        LoaneeLoan: Record Loans;
        LoanGuarantorsList: Record "Loan Guarantors and Security";

        new_guarantors: JsonArray;
        new_guarantor: JsonObject;
        Comments: JsonArray;
        Comment: JsonObject;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('application_number', application_number);

        LoanGuarantorSubstitutionRequest.Reset;
        LoanGuarantorSubstitutionRequest.SetRange("No.", application_number.AsValue.AsText);

        IF LoanGuarantorSubstitutionRequest.FindFirst() then begin
            Datum.Add('application_no', LoanGuarantorSubstitutionRequest."No.");
            Datum.Add('loan_no', LoanGuarantorSubstitutionRequest."Loan No.");

            LoaneeLoan.Reset;
            LoaneeLoan.SetRange("Loan No.", LoanGuarantorSubstitutionRequest."Loan No.");
            if LoaneeLoan.FindFirst then begin
                Datum.Add('member_number', LoaneeLoan."Member No.");
            end else begin
                Datum.Add('member_number', '');
            end;

            Datum.Add('name', LoanGuarantorSubstitutionRequest.Name);

            Datum.Add('crm_application_no', LoanGuarantorSubstitutionRequest."CRM Application No.");
            Datum.Add('crm_created_by', LoanGuarantorSubstitutionRequest."CRM Created By");
            Datum.Add('crm_originating_branch', LoanGuarantorSubstitutionRequest."CRM Originating Branch");
            Datum.Add('crm_notes', LoanGuarantorSubstitutionRequest."CRM Notes");
            Datum.Add('account_status', LoanGuarantorSubstitutionRequest."Account Status");
            Datum.Add('account_status_desc', Format(LoanGuarantorSubstitutionRequest."Account Status"));
            Datum.Add('status', Format(LoanGuarantorSubstitutionRequest.Status));
            Datum.Add('status_desc', Format(LoanGuarantorSubstitutionRequest.Status));
            Datum.Add('captured_by', LoanGuarantorSubstitutionRequest."Captured By");
            Datum.Add('posted', LoanGuarantorSubstitutionRequest.Posted);
            Datum.Add('posted_by', LoanGuarantorSubstitutionRequest."Posted By");
            Datum.Add('date', GlobalFunctions.FormatISODate(LoanGuarantorSubstitutionRequest.Date));

            LoanGuarantorSubstitutionRequest.CalcFields("Responsible Officer", "Supervisor ID");

            Datum.Add('responsible_officer', LoanGuarantorSubstitutionRequest."Responsible Officer");
            Datum.Add('supervisor_id', LoanGuarantorSubstitutionRequest."Supervisor ID");

            Datum.Add('responsibility_center', LoanGuarantorSubstitutionRequest."Responsibility Centre");
            Datum.Add('activity_code', LoanGuarantorSubstitutionRequest."Global Dimension 2 Code");
            Datum.Add('branch_code', LoanGuarantorSubstitutionRequest."Global Dimension 1 Code");
            Datum.Add('is_sent_back_to_crm', LoanGuarantorSubstitutionRequest."Sent Back to CRM");

            LoanGuarantors.Reset;
            LoanGuarantors.SetRange("Loan No", LoanGuarantorSubstitutionRequest."Loan No.");

            IF LoanGuarantors.FindSet then begin
                repeat begin
                    LoanGuarantorsList.Reset;
                    LoanGuarantorsList.SetRange("Loan No", LoanGuarantors."Loan No");
                    LoanGuarantorsList.SetRange("Member No", LoanGuarantors."Member No");

                    new_guarantor.Add('entry_no', LoanGuarantors."No.");
                    new_guarantor.Add('loan_no', LoanGuarantors."Loan No");
                    new_guarantor.Add('guarantor_name', LoanGuarantors.Name);
                    new_guarantor.Add('guarantor_member_number', LoanGuarantors."Member No");

                    LoanGuarantors.CalcFields("Outstanding Balance");
                    new_guarantor.Add('number_of_loans_guaranteed', LoanGuarantors."No Of Loans Guaranteed");

                    new_guarantor.Add('amount_guaranteed', LoanGuarantors."Amount Guaranteed");

                    new_guarantor.Add('outstanding_balance', LoanGuarantors."Outstanding Balance");

                    new_guarantor.Add('is_substituted', LoanGuarantors.Substituted);
                    new_guarantor.Add('substituted_guarantor', LoanGuarantors."Member Substituted");


                    new_guarantor.Add('member_no', LoanGuarantors."Member No");
                    new_guarantor.Add('name', LoanGuarantors.Name);
                    new_guarantor.Add('id_number', LoanGuarantors."ID No.");
                    new_guarantor.Add('staff_payroll_no', LoanGuarantors."Staff/Payroll No.");

                    if LoanGuarantors."Member Substituted" <> '' then begin
                        SubstitutedLoanGuarantor.Reset;
                        SubstitutedLoanGuarantor.SetRange("Loan No", LoanGuarantors."Loan No");
                        SubstitutedLoanGuarantor.SetRange("Savings Account No.", LoanGuarantors."Member Substituted");

                        if SubstitutedLoanGuarantor.FindFirst then begin
                            new_guarantor.Add('substituted_member_no', SubstitutedLoanGuarantor."Member No");
                            new_guarantor.Add('substituted_member_name', SubstitutedLoanGuarantor.Name);
                        end else begin
                            new_guarantor.Add('substituted_member_no', '');
                            new_guarantor.Add('substituted_member_name', '');
                        end;
                    end else begin
                        new_guarantor.Add('substituted_member_no', '');
                        new_guarantor.Add('substituted_member_name', '');
                    end;

                    if LoanGuarantorsList.FindFirst then begin
                        new_guarantor.Add('number_of_major_loans_guaranteed', LoanGuarantorsList."No Of Major Loans Guaranteed");
                        new_guarantor.Add('number_of_minor_loans_guaranteed', LoanGuarantorsList."No Of Minor Loans Guaranteed");

                        new_guarantor.Add('total_loan_balance', LoanGuarantorsList."Total Loan Balance");

                        new_guarantor.Add('is_self_guarantee', LoanGuarantorsList."Self Guarantee");

                        new_guarantor.Add('date_substituted', LoanGuarantorsList."Date Substituted");
                    end else begin
                        new_guarantor.Add('number_of_major_loans_guaranteed', 0);
                        new_guarantor.Add('number_of_minor_loans_guaranteed', 0);

                        new_guarantor.Add('total_loan_balance', 0);

                        new_guarantor.Add('is_self_guarantee', false);

                        new_guarantor.Add('date_substituted', 0D);
                    end;

                    new_guarantors.Add(new_guarantor);

                    // Reset
                    new_guarantor.ReadFrom('{}');
                end until LoanGuarantors.Next = 0;
            end;

            Datum.Add('guarantors', new_guarantors);

            ApplicationComments.Reset;

            ApplicationComments.SetRange("Loan No.", LoaneeLoan."Loan No.");
            ApplicationComments.SetCurrentKey("Entry No.");
            ApplicationComments.SetAscending("Entry No.", false);

            if ApplicationComments.FindSet then begin
                repeat begin
                    Comment.Add('comment', ApplicationComments.Comment);
                    Comment.Add('commented_by', ApplicationComments.Appraiser);
                    Comment.Add('date_time', GlobalFunctions.FormatISODateTime(ApplicationComments.SystemCreatedAt));
                    Comment.Add('is_read', ApplicationComments.Commented);

                    Comments.Add(Comment);

                    // Reset
                    Comment.ReadFrom('{}');
                end until ApplicationComments.Next = 0;
            end;

            Datum.Add('comments', Comments);

            Datum.Add('created_at', LoanGuarantorSubstitutionRequest.SystemCreatedAt);
            Datum.Add('modified_at', LoanGuarantorSubstitutionRequest.SystemModifiedAt);
        end else begin
            Error('Loan Guarantor request application with number %1 NOT found.', application_number.AsValue.AsText);
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetSavingsProducts(): Text
    var
        ActiveSavingsProducts: Record "Product Factory";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        ActiveSavingsProducts.Reset;

        ActiveSavingsProducts.SetRange("Product Class Type", ActiveSavingsProducts."Product Class Type"::Savings);
        ActiveSavingsProducts.SetRange(Status, ActiveSavingsProducts.Status::Active);
        ActiveSavingsProducts.SetFilter("Auto Open Account", '<>%1', true);

        IF ActiveSavingsProducts.FindSet then begin
            repeat begin

                Datum.Add('product_id', ActiveSavingsProducts."Product ID");
                Datum.Add('product_name', ActiveSavingsProducts."Product Description");
                Datum.Add('product_class_type', Format(ActiveSavingsProducts."Product Class Type"));
                Datum.Add('category', Format(ActiveSavingsProducts.Category));
                Datum.Add('status', Format(ActiveSavingsProducts.Status));
                Datum.Add('minimum_contribution_amount', ActiveSavingsProducts."Minimum Contribution");
                Datum.Add('minimum_balance', ActiveSavingsProducts."Minimum Balance");

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until ActiveSavingsProducts.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CreateSubAccountRequest(Payload: JsonObject): Text
    var
        member_number: JsonToken;
        application_type: JsonToken;
        product_type: JsonToken;
        contribution_amount: JsonToken;
        effective_from: JsonToken;
        account_branch: JsonToken;
        crm_application_no: JsonToken;
        crm_notes: JsonToken;
        crm_created_by: JsonToken;
        crm_originating_branch: JsonToken;
        //signatories: JsonToken;
        // signatory: JsonToken;
        // signatory_account_type: JsonToken;

        // signatory_member_no: JsonToken;

        // signatory_first_name: JsonToken;
        // signatory_middle_name: JsonToken;
        // signatory_other_names: JsonToken;
        // signatory_id_number: JsonToken;
        // signatory_phone_number: JsonToken;
        // signatory_dob: JsonToken;
        // signatory_staff_no: JsonToken;
        // signatory_kra_pin: JsonToken;

        // signatory_designation: JsonToken;
        // signatory_is_signatory: JsonToken;
        // signatory_must_sign: JsonToken;
        // signatory_must_be_present: JsonToken;
        // signatory_picture: JsonToken;
        // signatory_signature: JsonToken;

        KeyExists: Boolean;
        Count: Integer;

        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        Base64Convert: Codeunit "Base64 Convert";
        StoreImageRef: FieldRef;
        StoreRecRef: RecordRef;

        SavingsAccountApplication: Record "Savings Account Application";
        SignatoryApplication: Record "Signatory Application";
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        NewNo: Code[20];
        NewNoSeriesCode: Code[20];
        // CRMNewNo: Code[20];
        // CRMNewNoSeriesCode: Code[20];

        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        // SA000086 - Group Account - Group Member Application Card

        KeyExists := Payload.Get('member_number', member_number);
        KeyExists := Payload.Get('application_type', application_type); //"Group Account","SavCol Account";
        KeyExists := Payload.Get('account_branch', account_branch);
        KeyExists := Payload.Get('crm_application_no', crm_application_no);
        KeyExists := Payload.Get('crm_created_by', crm_created_by);
        KeyExists := Payload.Get('crm_notes', crm_notes);
        KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);
        KeyExists := Payload.Get('contribution_amount', contribution_amount);
        KeyExists := Payload.Get('product_type', product_type);
        KeyExists := Payload.Get('effective_from', effective_from);
        // KeyExists := Payload.Get('signatories', signatories);

        SavingsAccountApplication.Init;

        SeriesSetup.Get;
        SeriesSetup.TestField(SeriesSetup."Accounts Application");
        NewNo := NoSeriesMgt.GetNextNo(SeriesSetup."Accounts Application");
        // NoSeriesMgt.InitSeries(SeriesSetup."Accounts Application", SeriesSetup."Accounts Application", 0D, NewNo, NewNoSeriesCode);

        SavingsAccountApplication."No." := NewNo;
        SavingsAccountApplication."No. Series" := NewNoSeriesCode;

        SavingsAccountApplication."Member No." := member_number.AsValue.AsText;
        SavingsAccountApplication.Validate("Member No.");

        SavingsAccountApplication."Application Type" := application_type.asValue.AsInteger;

        SavingsAccountApplication."Product Type" := product_type.AsValue.AsText;
        SavingsAccountApplication.Validate("Product Type");


        // SavingsAccountApplication."CRM Application No." := crm_application_no.AsValue.AsText;
        SavingsAccountApplication."CRM Created By" := crm_created_by.AsValue.AsText;
        SavingsAccountApplication."CRM Originating Branch" := crm_originating_branch.AsValue.AsText;
        SavingsAccountApplication."CRM Notes" := crm_notes.AsValue.AsText;

        if crm_created_by.AsValue.AsText = '' then begin
            Error('ERR_401. Invalid application. Origination NOT accepted!');
        end;

        SavingsAccountApplication."Monthly Contribution" := contribution_amount.AsValue.AsDecimal;

        IF (not effective_from.AsValue.IsNull) then begin
            SavingsAccountApplication."Effective Date" := effective_from.AsValue.AsDate;
        end;

        SavingsAccountApplication.Status := SavingsAccountApplication.Status::Open;

        // CRM - No Series
        // SeriesSetup.TestField(SeriesSetup."CRM - Sub Account Reqs");
        // NoSeriesMgt.InitSeries(SeriesSetup."CRM - Sub Account Reqs", SeriesSetup."CRM - Sub Account Reqs", 0D, CRMNewNo, CRMNewNoSeriesCode);

        // SavingsAccountApplication."CRM Application No." := CRMNewNo;
        // SavingsAccountApplication."CRM No. Series" := CRMNewNoSeriesCode;

        IF SavingsAccountApplication.Insert(true) then begin
            SavingsAccountApplication."Created By" := SavingsAccountApplication."CRM Created By";
            SavingsAccountApplication."Global Dimension 1 Code" := account_branch.AsValue.AsText; // Branch
            SavingsAccountApplication."Global Dimension 2 Code" := Format("Responsibility Center Enum"::FOSA); // Activity Code
            SavingsAccountApplication."Responsibility Center" := Format("Responsibility Center Enum"::FOSA); // Responsibility Center

            SavingsAccountApplication."CRM Application No." := SavingsAccountApplication."No.";
            SavingsAccountApplication."CRM No. Series" := SavingsAccountApplication."No. Series";

            SavingsAccountApplication.Modify;

            // CRM Comments/Notes
            GlobalFunctions.InsertCommentRecord(
                SavingsAccountApplication."No.",
                crm_notes.AsValue.AsText,
                crm_created_by.AsValue.AsText,
                SavingsAccountApplication."Global Dimension 1 Code",
                SavingsAccountApplication."Global Dimension 2 Code",
                SavingsAccountApplication."Responsibility Center",
                false
            );

            // Joint Accounts
            // if signatories.IsArray then begin
            //     Count := 0;

            //     foreach signatory in signatories.AsArray do begin
            //         KeyExists := signatory.SelectToken('account_type', signatory_account_type);

            //         SignatoryApplication.Reset;
            //         SignatoryApplication.Init;

            //         Count := Count + 1;

            //         SignatoryApplication."Account No" := SavingsAccountApplication."No.";
            //         SignatoryApplication."Account Type" := signatory_account_type.AsValue.AsInteger;

            //         if SignatoryApplication."Account Type" = SignatoryApplication."Account Type"::"Member" then begin
            //             KeyExists := signatory.SelectToken('member_no', signatory_member_no);

            //             SignatoryApplication."Entry No" := Count;
            //             SignatoryApplication."Member No." := signatory_member_no.AsValue.AsText;
            //             SignatoryApplication.Validate("Member No.");
            //         end;

            //         if SignatoryApplication."Account Type" = SignatoryApplication."Account Type"::"Non-Member" then begin
            //             KeyExists := signatory.SelectToken('first_name', signatory_first_name);
            //             KeyExists := signatory.SelectToken('middle_name', signatory_middle_name);
            //             KeyExists := signatory.SelectToken('other_names', signatory_other_names);
            //             KeyExists := signatory.SelectToken('id_number', signatory_id_number);
            //             KeyExists := signatory.SelectToken('phone_number', signatory_phone_number);
            //             KeyExists := signatory.SelectToken('dob', signatory_dob);
            //             KeyExists := signatory.SelectToken('staff_no', signatory_staff_no);
            //             KeyExists := signatory.SelectToken('kra_pin', signatory_kra_pin);
            //             KeyExists := signatory.SelectToken('picture', signatory_picture);
            //             KeyExists := signatory.SelectToken('signature', signatory_signature);

            //             SignatoryApplication."Entry No" := Count;

            //             SignatoryApplication."First Name" := signatory_first_name.AsValue.AsText;
            //             SignatoryApplication.Validate("First Name");
            //             SignatoryApplication."Second Name" := signatory_middle_name.AsValue.AsText;
            //             SignatoryApplication.Validate("Second Name");
            //             SignatoryApplication."Other Names" := signatory_other_names.AsValue.AsText;
            //             SignatoryApplication.Validate("Other Names");
            //             SignatoryApplication."ID Number" := signatory_id_number.AsValue.AsText;
            //             SignatoryApplication."Phone No." := signatory_phone_number.AsValue.AsText;
            //             SignatoryApplication."Date Of Birth" := signatory_dob.AsValue.AsDate;
            //             SignatoryApplication."Staff/Payroll" := signatory_staff_no.AsValue.AsText;
            //             SignatoryApplication."PIN Number" := signatory_kra_pin.AsValue.AsText;

            //             // Picture ---------------------------------------------------------------------------
            //             TempBlob.CreateOutStream(OutStr);
            //             Base64Convert.FromBase64(signatory_picture.AsValue.AsText, OutStr);

            //             Clear(SignatoryApplication.Picture);

            //             // Store.Image - Blob DataType
            //             StoreRecRef.Open(52185697);
            //             StoreImageRef := StoreRecRef.Field(SignatoryApplication.FieldNo(Picture));

            //             TempBlob.ToFieldRef(StoreImageRef);
            //             StoreImageRef.TestField();

            //             SignatoryApplication.Picture := StoreImageRef.Value;
            //             SignatoryApplication.TestField(Picture);

            //             // Signature -------------------------------------------------------------------------
            //             TempBlob.CreateOutStream(OutStr);
            //             Base64Convert.FromBase64(signatory_signature.AsValue.AsText, OutStr);

            //             Clear(SignatoryApplication.Signature);

            //             // Store.Image - Blob DataType
            //             // StoreRecRef.Open(52185697);
            //             StoreImageRef := StoreRecRef.Field(SignatoryApplication.FieldNo(Signature));

            //             TempBlob.ToFieldRef(StoreImageRef);
            //             StoreImageRef.TestField();

            //             SignatoryApplication.Signature := StoreImageRef.Value;
            //             SignatoryApplication.TestField(Signature);
            //         end;

            //         KeyExists := signatory.SelectToken('designation', signatory_designation);
            //         KeyExists := signatory.SelectToken('is_signatory', signatory_is_signatory);
            //         KeyExists := signatory.SelectToken('must_sign', signatory_must_sign);
            //         KeyExists := signatory.SelectToken('must_be_present', signatory_must_be_present);

            //         SignatoryApplication.Type := signatory_designation.AsValue.AsInteger;
            //         SignatoryApplication.Signatory := signatory_is_signatory.AsValue.AsBoolean;
            //         SignatoryApplication."Must Sign" := signatory_must_sign.AsValue.AsBoolean;
            //         SignatoryApplication."Must be Present" := signatory_must_be_present.AsValue.AsBoolean;

            //         SignatoryApplication.Insert(true);
            //     end;
            // end;

            EDMSFunctions.EDMSScannedLog(
                SavingsAccountApplication."No.",
                "CRM Originations"::"Sub Account",
                SavingsAccountApplication."Member No.",
                SavingsAccountApplication."CRM Created By",
                SavingsAccountApplication."CRM Originating Branch"
            );

            // Handle CRM branch assigmnent
            SavingsAccountApplication."Global Dimension 1 Code" := GlobalFunctions.GetBranchCodeFromCRMOrigination(SavingsAccountApplication."CRM Originating Branch");
            SavingsAccountApplication.Modify;

            SavingsAccountApplication.Reset;

            SavingsAccountApplication.SetRange("No.", NewNo);
            ResponseData.Add('application_number', SavingsAccountApplication."No.");
            ResponseData.Add('application_status', Format(SavingsAccountApplication.Status));

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Savings account application with CRM application number ' + SavingsAccountApplication."No." + ' has been created successfully.');
            ResponseObject.Add('data', ResponseData);
            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
        end else begin
            // ResponseObject.Add('status', 'ERROR');
            // ResponseObject.Add('description', 'Unable to create savings account application.');
            // ResponseObject.Add('errors', Errors);
            // AddDateTimeToResponse(ResponseObject);

            // ResponseObject.WriteTo(Response);

            Error('Unable to create savings account application.');
        end;

        exit(Response);
    end;

    local procedure UpdateSubAccountRequest(Payload: JsonObject): Text
    var
        application_no: JsonToken;
        member_number: JsonToken;
        application_type: JsonToken;
        product_type: JsonToken;
        contribution_amount: JsonToken;
        effective_from: JsonToken;
        account_branch: JsonToken;
        crm_application_no: JsonToken;
        crm_notes: JsonToken;
        crm_created_by: JsonToken;
        crm_originating_branch: JsonToken;
        // signatories: JsonToken;
        // signatory: JsonToken;
        // signatory_account_type: JsonToken;

        // signatory_member_no: JsonToken;

        // signatory_first_name: JsonToken;
        // signatory_middle_name: JsonToken;
        // signatory_other_names: JsonToken;
        // signatory_id_number: JsonToken;
        // signatory_phone_number: JsonToken;
        // signatory_dob: JsonToken;
        // signatory_staff_no: JsonToken;
        // signatory_kra_pin: JsonToken;

        // signatory_designation: JsonToken;
        // signatory_is_signatory: JsonToken;
        // signatory_must_sign: JsonToken;
        // signatory_must_be_present: JsonToken;
        // signatory_picture: JsonToken;
        // signatory_signature: JsonToken;

        KeyExists: Boolean;
        Count: Integer;

        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        Base64Convert: Codeunit "Base64 Convert";
        StoreImageRef: FieldRef;
        StoreRecRef: RecordRef;

        SavingsAccountApplication: Record "Savings Account Application";
        SignatoryApplication: Record "Signatory Application";
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        NewNo: Code[20];
        NewNoSeriesCode: Code[20];
        // CRMNewNo: Code[20];
        // CRMNewNoSeriesCode: Code[20];

        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        KeyExists := Payload.Get('application_no', application_no);
        KeyExists := Payload.Get('member_number', member_number);
        KeyExists := Payload.Get('application_type', application_type); //"Group Account","SavCol Account";
        KeyExists := Payload.Get('account_branch', account_branch);
        KeyExists := Payload.Get('crm_application_no', crm_application_no);
        KeyExists := Payload.Get('crm_created_by', crm_created_by);
        KeyExists := Payload.Get('crm_notes', crm_notes);
        KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);
        KeyExists := Payload.Get('contribution_amount', contribution_amount);
        KeyExists := Payload.Get('product_type', product_type);
        KeyExists := Payload.Get('effective_from', effective_from);
        // KeyExists := Payload.Get('signatories', signatories);

        SavingsAccountApplication.Reset;

        SavingsAccountApplication.SetRange("No.", application_no.AsValue.AsText);
        SavingsAccountApplication.SetRange("Sent Back to CRM", true);

        if SavingsAccountApplication.FindFirst then begin
            SavingsAccountApplication."Member No." := member_number.AsValue.AsText;
            SavingsAccountApplication.Validate("Member No.");

            SavingsAccountApplication."Application Type" := application_type.asValue.AsInteger;

            SavingsAccountApplication."Product Type" := product_type.AsValue.AsText;
            SavingsAccountApplication.Validate("Product Type");


            // SavingsAccountApplication."CRM Application No." := crm_application_no.AsValue.AsText;
            // SavingsAccountApplication."CRM Created By" := crm_created_by.AsValue.AsText;
            SavingsAccountApplication."CRM Originating Branch" := crm_originating_branch.AsValue.AsText;
            SavingsAccountApplication."CRM Notes" := crm_notes.AsValue.AsText;

            SavingsAccountApplication."Monthly Contribution" := contribution_amount.AsValue.AsDecimal;

            IF (not effective_from.AsValue.IsNull) then begin
                SavingsAccountApplication."Effective Date" := effective_from.AsValue.AsDate;
            end;

            SavingsAccountApplication.Status := SavingsAccountApplication.Status::Open;
            SavingsAccountApplication."Sent Back to CRM" := false;

            IF SavingsAccountApplication.Modify(true) then begin
                SavingsAccountApplication."Created By" := SavingsAccountApplication."CRM Created By";
                SavingsAccountApplication."Global Dimension 1 Code" := account_branch.AsValue.AsText; // Branch
                SavingsAccountApplication."Global Dimension 2 Code" := Format("Responsibility Center Enum"::FOSA); // Activity Code
                SavingsAccountApplication."Responsibility Center" := Format("Responsibility Center Enum"::FOSA); // Responsibility Center

                SavingsAccountApplication.Modify(true);

                // CRM Comments/Notes
                GlobalFunctions.InsertCommentRecord(
                    SavingsAccountApplication."No.",
                    crm_notes.AsValue.AsText,
                    crm_created_by.AsValue.AsText,
                    SavingsAccountApplication."Global Dimension 1 Code",
                    SavingsAccountApplication."Global Dimension 2 Code",
                    SavingsAccountApplication."Responsibility Center",
                    false
                );

                // Joint Accounts
                // if signatories.IsArray then begin
                //     Count := 0;

                //     SignatoryApplication.Reset();

                //     SignatoryApplication.SetRange("Account No", SavingsAccountApplication."No.");

                //     if SignatoryApplication.FindSet then begin
                //         repeat begin
                //             KeyExists := SignatoryApplication.Delete(true);
                //         end until SignatoryApplication.Next = 0;
                //     end;

                //     foreach signatory in signatories.AsArray do begin
                //         KeyExists := signatory.SelectToken('account_type', signatory_account_type);

                //         SignatoryApplication.Reset;
                //         SignatoryApplication.Init;

                //         Count := Count + 1;

                //         SignatoryApplication."Account No" := SavingsAccountApplication."No.";
                //         SignatoryApplication."Account Type" := signatory_account_type.AsValue.AsInteger;

                //         if SignatoryApplication."Account Type" = SignatoryApplication."Account Type"::"Member" then begin
                //             KeyExists := signatory.SelectToken('member_no', signatory_member_no);

                //             SignatoryApplication."Entry No" := Count;
                //             SignatoryApplication."Member No." := signatory_member_no.AsValue.AsText;
                //             SignatoryApplication.Validate("Member No.");
                //         end;

                //         if SignatoryApplication."Account Type" = SignatoryApplication."Account Type"::"Non-Member" then begin
                //             KeyExists := signatory.SelectToken('first_name', signatory_first_name);
                //             KeyExists := signatory.SelectToken('middle_name', signatory_middle_name);
                //             KeyExists := signatory.SelectToken('other_names', signatory_other_names);
                //             KeyExists := signatory.SelectToken('id_number', signatory_id_number);
                //             KeyExists := signatory.SelectToken('phone_number', signatory_phone_number);
                //             KeyExists := signatory.SelectToken('dob', signatory_dob);
                //             KeyExists := signatory.SelectToken('staff_no', signatory_staff_no);
                //             KeyExists := signatory.SelectToken('kra_pin', signatory_kra_pin);
                //             KeyExists := signatory.SelectToken('picture', signatory_picture);
                //             KeyExists := signatory.SelectToken('signature', signatory_signature);

                //             SignatoryApplication."Entry No" := Count;

                //             SignatoryApplication."First Name" := signatory_first_name.AsValue.AsText;
                //             SignatoryApplication.Validate("First Name");
                //             SignatoryApplication."Second Name" := signatory_middle_name.AsValue.AsText;
                //             SignatoryApplication.Validate("Second Name");
                //             SignatoryApplication."Other Names" := signatory_other_names.AsValue.AsText;
                //             SignatoryApplication.Validate("Other Names");
                //             SignatoryApplication."ID Number" := signatory_id_number.AsValue.AsText;
                //             SignatoryApplication."Phone No." := signatory_phone_number.AsValue.AsText;
                //             SignatoryApplication."Date Of Birth" := signatory_dob.AsValue.AsDate;
                //             SignatoryApplication."Staff/Payroll" := signatory_staff_no.AsValue.AsText;
                //             SignatoryApplication."PIN Number" := signatory_kra_pin.AsValue.AsText;

                //             // Picture ---------------------------------------------------------------------------
                //             TempBlob.CreateOutStream(OutStr);
                //             Base64Convert.FromBase64(signatory_picture.AsValue.AsText, OutStr);

                //             Clear(SignatoryApplication.Picture);

                //             // Store.Image - Blob DataType
                //             StoreRecRef.Open(52185697);
                //             StoreImageRef := StoreRecRef.Field(SignatoryApplication.FieldNo(Picture));

                //             TempBlob.ToFieldRef(StoreImageRef);
                //             StoreImageRef.TestField();

                //             SignatoryApplication.Picture := StoreImageRef.Value;
                //             SignatoryApplication.TestField(Picture);

                //             // Signature -------------------------------------------------------------------------
                //             TempBlob.CreateOutStream(OutStr);
                //             Base64Convert.FromBase64(signatory_signature.AsValue.AsText, OutStr);

                //             Clear(SignatoryApplication.Signature);

                //             // Store.Image - Blob DataType
                //             // StoreRecRef.Open(52185697);
                //             StoreImageRef := StoreRecRef.Field(SignatoryApplication.FieldNo(Signature));

                //             TempBlob.ToFieldRef(StoreImageRef);
                //             StoreImageRef.TestField();

                //             SignatoryApplication.Signature := StoreImageRef.Value;
                //             SignatoryApplication.TestField(Signature);
                //         end;

                //         KeyExists := signatory.SelectToken('designation', signatory_designation);
                //         KeyExists := signatory.SelectToken('is_signatory', signatory_is_signatory);
                //         KeyExists := signatory.SelectToken('must_sign', signatory_must_sign);
                //         KeyExists := signatory.SelectToken('must_be_present', signatory_must_be_present);

                //         SignatoryApplication.Type := signatory_designation.AsValue.AsInteger;
                //         SignatoryApplication.Signatory := signatory_is_signatory.AsValue.AsBoolean;
                //         SignatoryApplication."Must Sign" := signatory_must_sign.AsValue.AsBoolean;
                //         SignatoryApplication."Must be Present" := signatory_must_be_present.AsValue.AsBoolean;

                //         SignatoryApplication.Insert(true);
                //     end;
                // end;

                // Handle CRM branch assigmnent
                SavingsAccountApplication."Global Dimension 1 Code" := GlobalFunctions.GetBranchCodeFromCRMOrigination(SavingsAccountApplication."CRM Originating Branch");
                SavingsAccountApplication.Modify;

                SavingsAccountApplication.Reset;

                SavingsAccountApplication.SetRange("No.", NewNo);
                ResponseData.Add('application_number', SavingsAccountApplication."No.");
                ResponseData.Add('application_status', Format(SavingsAccountApplication.Status));

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('description', 'Savings account application with CRM application number ' + SavingsAccountApplication."No." + ' has been updated successfully.');
                ResponseObject.Add('data', ResponseData);
                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
            end else begin
                Error('Unable to update savings account application.');
            end;
        end else begin
            Error('Savings account application with no %1 is NOT available for editing', application_no.AsValue.AsText);
        end;
        exit(Response);
    end;

    local procedure GetSubAccountRequests(Payload: JsonObject): Text
    var
        filter_property: JsonToken;
        filter_value: JsonToken;
        start_date: JsonToken;
        end_date: JsonToken;
        page_number: JsonToken;
        page_size: JsonToken;
        crm_branch: JsonToken;

        KeyExists: Boolean;

        SubAccountRequests: Record "Savings Account Application";

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;
        Count: Integer;
        FirstRow: Integer;
        LastRow: Integer;
        TotalFoundRecords: Integer;
        SearchString: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        KeyExists := Payload.Get('filter_property', filter_property);
        KeyExists := Payload.Get('filter_value', filter_value);
        KeyExists := Payload.Get('start_date', start_date);
        KeyExists := Payload.Get('end_date', end_date);
        KeyExists := Payload.Get('crm_branch', crm_branch);
        Payload.Get('page_number', page_number);
        Payload.Get('page_size', page_size);

        SubAccountRequests.Reset;
        SubAccountRequests.SetCurrentKey("Application Date");
        SubAccountRequests.SetAscending("Application Date", false);

        if KeyExists then begin
            if (crm_branch.AsValue.AsText <> 'ALL') then begin
                SubAccountRequests.SetRange(SubAccountRequests."CRM Originating Branch", crm_branch.AsValue.AsText);
            end;
        end;

        // Search Value
        if (not filter_property.AsValue.IsNull) and (not filter_value.AsValue.IsNull) then begin
            if (filter_property.AsValue.AsText <> '') and (filter_value.AsValue.AsText <> '') then begin
                SearchString := filter_value.AsValue.AsText;

                case filter_property.AsValue.AsText of
                    'application_no':
                        SubAccountRequests.SetRange(SubAccountRequests."No.", SearchString);
                    'crm_application_no':
                        SubAccountRequests.SetRange(SubAccountRequests."CRM Application No.", SearchString);
                    'member_no':
                        SubAccountRequests.SetRange(SubAccountRequests."Member No.", SearchString);
                    'status':
                        SubAccountRequests.SetFilter(SubAccountRequests.Status, SearchString);
                    else
                        SubAccountRequests.SetRange(SubAccountRequests."No.", SearchString);
                end;
            end;
        end;

        // Start Date & End Date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));

                SubAccountRequests.SetFilter("Application Date", '>=%1&<=%2', StartDate, EndDate);
            end;
        end;

        IF SubAccountRequests.FindSet then begin
            // Data found
            Count := 0;
            FirstRow := ((page_number.AsValue.AsInteger - 1) * page_size.AsValue.AsInteger) + 1;
            LastRow := page_number.AsValue.AsInteger * page_size.AsValue.AsInteger;

            TotalFoundRecords := SubAccountRequests.Count;

            repeat begin
                Count += 1;

                if (Count >= FirstRow) and (Count <= LastRow) then begin
                    Datum.Add('application_no', SubAccountRequests."No.");
                    Datum.Add('application_type', Format(SubAccountRequests."Application Type"));
                    Datum.Add('member_no', SubAccountRequests."Member No.");
                    Datum.Add('name', SubAccountRequests.Name);

                    Datum.Add('product_type', SubAccountRequests."Product Type");
                    Datum.Add('product_name', SubAccountRequests."Product Name");

                    Datum.Add('crm_application_no', SubAccountRequests."CRM Application No.");
                    Datum.Add('crm_created_by', SubAccountRequests."CRM Created By");
                    Datum.Add('crm_originating_branch', SubAccountRequests."CRM Originating Branch");
                    Datum.Add('status', Format(SubAccountRequests.Status));
                    Datum.Add('application_date', GlobalFunctions.FormatISODate(SubAccountRequests."Application Date"));
                    Datum.Add('effective_date', GlobalFunctions.FormatISODate(SubAccountRequests."Effective Date"));

                    Datum.Add('activity_code', SubAccountRequests."Global Dimension 2 Code");
                    Datum.Add('branch_code', SubAccountRequests."Global Dimension 1 Code");
                    Datum.Add('is_sent_back_to_crm', SubAccountRequests."Sent Back to CRM");

                    Datum.Add('responsible_officer', '');
                    Datum.Add('supervisor_id', '');

                    Data.Add(Datum);
                    // Reset
                    Datum.ReadFrom('{}');
                end;
            end until (Count = LastRow) or (SubAccountRequests.Next = 0);

            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetSubAccountRequest(Payload: JsonObject): Text
    var
        application_number: JsonToken;

        SubAccountRequest: Record "Savings Account Application";
        ApplicationComments: Record Comments;

        new_guarantors: JsonArray;
        new_guarantor: JsonObject;
        Comments: JsonArray;
        Comment: JsonObject;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('application_number', application_number);

        SubAccountRequest.Reset;
        SubAccountRequest.SetRange("No.", application_number.AsValue.AsText);

        IF SubAccountRequest.FindFirst() then begin
            Datum.Add('application_no', SubAccountRequest."No.");
            Datum.Add('application_type', SubAccountRequest."Application Type");
            Datum.Add('application_type_desc', Format(SubAccountRequest."Application Type"));
            Datum.Add('account_branch', SubAccountRequest."Global Dimension 1 Code");
            Datum.Add('contribution_amount', SubAccountRequest."Monthly Contribution");
            Datum.Add('member_number', SubAccountRequest."Member No.");
            Datum.Add('name', SubAccountRequest.Name);

            Datum.Add('product_type', SubAccountRequest."Product Type");
            Datum.Add('product_name', SubAccountRequest."Product Name");

            Datum.Add('crm_application_no', SubAccountRequest."CRM Application No.");
            Datum.Add('crm_created_by', SubAccountRequest."CRM Created By");
            Datum.Add('crm_originating_branch', SubAccountRequest."CRM Originating Branch");
            Datum.Add('crm_notes', SubAccountRequest."CRM Notes");
            Datum.Add('status', SubAccountRequest.Status);
            Datum.Add('status_desc', Format(SubAccountRequest.Status));
            Datum.Add('application_date', GlobalFunctions.FormatISODate(SubAccountRequest."Application Date"));
            Datum.Add('effective_from', GlobalFunctions.FormatISODate(SubAccountRequest."Effective Date"));

            Datum.Add('activity_code', SubAccountRequest."Global Dimension 2 Code");
            Datum.Add('branch_code', SubAccountRequest."Global Dimension 1 Code");

            Datum.Add('is_sent_back_to_crm', SubAccountRequest."Sent Back to CRM");

            Datum.Add('responsible_officer', '');
            Datum.Add('supervisor_id', '');

            ApplicationComments.Reset;

            ApplicationComments.SetRange("Header No.", SubAccountRequest."No.");
            ApplicationComments.SetCurrentKey("Entry No.");
            ApplicationComments.SetAscending("Entry No.", false);

            if ApplicationComments.FindSet then begin
                repeat begin
                    Comment.Add('comment', ApplicationComments.Comment);
                    Comment.Add('commented_by', ApplicationComments."Commented By");
                    Comment.Add('date_time', GlobalFunctions.FormatISODateTime(ApplicationComments.Date));
                    Comment.Add('is_read', ApplicationComments."Viewd By Somebody Else");

                    Comments.Add(Comment);

                    // Reset
                    Comment.ReadFrom('{}');
                end until ApplicationComments.Next = 0;
            end;

            Datum.Add('comments', Comments);

            Datum.Add('created_at', SubAccountRequest.SystemCreatedAt);
            Datum.Add('modified_at', SubAccountRequest.SystemModifiedAt);
        end else begin
            Error('Sub account request application with number %1 NOT found.', application_number.AsValue.AsText);
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CreateLoanVariationRequest(Payload: JsonObject): Text
    var
        member_number: JsonToken;
        member_loan: JsonToken;
        new_deduction_amount: JsonToken;
        // effective_date: JsonToken;
        crm_application_no: JsonToken;
        crm_notes: JsonToken;
        crm_originating_branch: JsonToken;
        crm_created_by: JsonToken;
        variation_action: JsonToken;

        KeyExists: Boolean;

        Variations: Record "Product Variations";
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        NewNo: Code[20];
        NewNoSeriesCode: Code[20];
        // CRMNewNo: Code[20];
        // CRMNewNoSeriesCode: Code[20];

        EditMember: Record Members;
        EditMemberLoan: Record Loans;
        Comment: Record "Loan Appraisal Comments";
        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        KeyExists := Payload.Get('member_number', member_number);
        KeyExists := Payload.Get('member_loan', member_loan);
        KeyExists := Payload.Get('new_deduction_amount', new_deduction_amount);
        // KeyExists := Payload.Get('effective_date', effective_date);
        KeyExists := Payload.Get('crm_application_no', crm_application_no);
        KeyExists := Payload.Get('crm_notes', crm_notes);
        KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);
        KeyExists := Payload.Get('crm_created_by', crm_created_by);
        KeyExists := Payload.Get('variation_action', variation_action);

        EditMember.Reset();

        EditMember.SetRange("No.", member_number.asValue.AsText);

        IF EditMember.FindFirst then begin
            EditMemberLoan.Reset();
            EditMemberLoan.SetRange("Member No.", EditMember."No.");
            EditMemberLoan.SetRange("Loan No.", member_loan.AsValue.AsText);
            // EditMemberLoan.SetRange(Status, EditMemberLoan.Status::Approved);

            IF EditMemberLoan.FindFirst then begin
                Variations.Init;

                Variations."Variation Type" := Variations."Variation Type"::Loan;

                // SeriesSetup.Get;
                // SeriesSetup.TestField(SeriesSetup.Variations);
                // NoSeriesMgt.InitSeries(SeriesSetup.Variations, SeriesSetup.Variations, 0D, NewNo, NewNoSeriesCode);

                Variations."No." := '';
                Variations."No. Series" := '';

                // Variations."CRM Application No." := crm_application_no.AsValue.AsText;
                Variations."CRM Notes" := crm_notes.AsValue.AsText;
                Variations."CRM Originating Branch" := crm_originating_branch.AsValue.AsText;
                Variations."CRM Created By" := crm_created_by.AsValue.AsText;

                if crm_created_by.AsValue.AsText = '' then begin
                    Error('ERR_401. Invalid application. Origination NOT accepted!');
                end;

                Variations."Member No." := member_number.asValue.AsText;
                Variations.Validate("Member No.");

                // Variations."Effective Date" := effective_date.AsValue.AsDate;
                Variations."Account No" := EditMemberLoan."Loan No.";
                Variations.Validate("Account No");
                Variations."Amount On" := new_deduction_amount.AsValue.AsDecimal;
                Variations.Validate("Amount On");

                Variations."Application Date" := Today;
                Variations.Validate("Application Date");

                Variations.Status := Variations.Status::Open;
                // Variations.Status := Variations.Status::Approved;

                // CRM - No Series
                // SeriesSetup.TestField(SeriesSetup."CRM - Loan Variation Reqs");
                // NoSeriesMgt.InitSeries(SeriesSetup."CRM - Loan Variation Reqs", SeriesSetup."CRM - Loan Variation Reqs", 0D, CRMNewNo, CRMNewNoSeriesCode);

                // Variations."CRM Application No." := CRMNewNo;
                // Variations."CRM No. Series" := CRMNewNoSeriesCode;

                Variations."Variation Action" := variation_action.AsValue.AsInteger;

                IF Variations.Insert(true) then begin
                    Variations."CRM Application No." := Variations."No.";
                    Variations."CRM No. Series" := Variations."No. Series";
                    Variations.Modify();

                    // CRM Comments/Notes
                    if crm_notes.AsValue.AsText <> '' then begin
                        Comment.Init;

                        Comment."Loan No." := Variations."No.";
                        Comment.Comment := crm_notes.AsValue.AsText;
                        Comment.Appraiser := crm_created_by.AsValue.AsText;
                        Comment."Entry Date" := Today;
                        Comment."Entry Time" := Time;
                        Comment.Commented := true;

                        Comment.Insert(false);
                    end;

                    EDMSFunctions.EDMSScannedLog(
                        Variations."No.",
                        "CRM Originations"::"Loan Variation",
                        Variations."Member No.",
                        Variations."CRM Created By",
                        Variations."CRM Originating Branch"
                    );

                    // Handle CRM branch assigmnent
                    Variations."Global Dimension 1 Code" := GlobalFunctions.GetBranchCodeFromCRMOrigination(Variations."CRM Originating Branch");
                    Variations.Modify;

                    Variations.Reset;

                    Variations.SetRange("No.", NewNo);
                    ResponseData.Add('application_number', Variations."No.");
                    ResponseData.Add('application_status', Format(Variations.Status));

                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('description', 'Loan variation application with CRM application number ' + Variations."No." + ' has been created successfully.');
                    ResponseObject.Add('data', ResponseData);
                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                end else begin
                    Error('Unable to create loan variation application.');
                end;
            end else begin
                Error('Unknown member loan with loan number = %1', member_loan.asValue.AsText);
            end;
        end else begin
            Error('Unknown member with member number = %1', member_number.asValue.AsText);
        end;

        exit(Response);
    end;

    local procedure UpdateLoanVariationRequest(Payload: JsonObject): Text
    var
        application_no: JsonToken;
        member_number: JsonToken;
        member_loan: JsonToken;
        new_deduction_amount: JsonToken;
        // effective_date: JsonToken;
        crm_application_no: JsonToken;
        crm_notes: JsonToken;
        crm_originating_branch: JsonToken;
        crm_created_by: JsonToken;
        variation_action: JsonToken;

        KeyExists: Boolean;

        Variations: Record "Product Variations";
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        NewNo: Code[20];
        NewNoSeriesCode: Code[20];
        // CRMNewNo: Code[20];
        // CRMNewNoSeriesCode: Code[20];

        EditMember: Record Members;
        EditMemberLoan: Record Loans;
        Comment: Record "Loan Appraisal Comments";
        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        KeyExists := Payload.Get('application_no', application_no);
        KeyExists := Payload.Get('member_number', member_number);
        KeyExists := Payload.Get('member_loan', member_loan);
        KeyExists := Payload.Get('new_deduction_amount', new_deduction_amount);
        // KeyExists := Payload.Get('effective_date', effective_date);
        KeyExists := Payload.Get('crm_application_no', crm_application_no);
        KeyExists := Payload.Get('crm_notes', crm_notes);
        KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);
        KeyExists := Payload.Get('crm_created_by', crm_created_by);
        KeyExists := Payload.Get('variation_action', variation_action);

        EditMember.Reset();

        EditMember.SetRange("No.", member_number.asValue.AsText);

        IF EditMember.FindFirst then begin
            EditMemberLoan.Reset();
            EditMemberLoan.SetRange("Member No.", EditMember."No.");
            EditMemberLoan.SetRange("Loan No.", member_loan.AsValue.AsText);
            // EditMemberLoan.SetRange(Status, EditMemberLoan.Status::Approved);

            IF EditMemberLoan.FindFirst then begin
                Variations.Reset;

                Variations.SetRange("No.", application_no.AsValue.AsText);
                Variations.SetRange("Sent Back to CRM", true);

                if Variations.FindFirst then begin
                    // Variations."CRM Application No." := crm_application_no.AsValue.AsText;
                    Variations."CRM Notes" := crm_notes.AsValue.AsText;
                    Variations."CRM Originating Branch" := crm_originating_branch.AsValue.AsText;
                    // Variations."CRM Created By" := crm_created_by.AsValue.AsText;

                    Variations."Member No." := member_number.asValue.AsText;
                    Variations.Validate("Member No.");
                    Variations."Variation Type" := Variations."Variation Type"::Loan;

                    // Variations."Effective Date" := effective_date.AsValue.AsDate;
                    Variations."Account No" := EditMemberLoan."Loan No.";
                    Variations.Validate("Account No");
                    Variations."Amount On" := new_deduction_amount.AsValue.AsDecimal;
                    Variations.Validate("Amount On");

                    Variations."Application Date" := Today;
                    Variations.Validate("Application Date");

                    Variations.Status := Variations.Status::Open;
                    // Variations.Status := Variations.Status::Approved;
                    Variations."Sent Back to CRM" := false;

                    Variations."Variation Action" := variation_action.AsValue.AsInteger;

                    IF Variations.Modify(true) then begin
                        // CRM Comments/Notes
                        if crm_notes.AsValue.AsText <> '' then begin
                            Comment.Init;

                            Comment."Loan No." := Variations."No.";
                            Comment.Comment := crm_notes.AsValue.AsText;
                            Comment.Appraiser := crm_created_by.AsValue.AsText;
                            Comment."Entry Date" := Today;
                            Comment."Entry Time" := Time;
                            Comment.Commented := true;

                            Comment.Insert(false);
                        end;

                        // Handle CRM branch assigmnent
                        Variations."Global Dimension 1 Code" := GlobalFunctions.GetBranchCodeFromCRMOrigination(Variations."CRM Originating Branch");
                        Variations.Modify;

                        Variations.Reset;

                        Variations.SetRange("No.", NewNo);
                        ResponseData.Add('application_number', Variations."No.");
                        ResponseData.Add('application_status', Format(Variations.Status));

                        ResponseObject.Add('status', 'SUCCESS');
                        ResponseObject.Add('description', 'Loan variation application with CRM application number ' + Variations."No." + ' has been updated successfully.');
                        ResponseObject.Add('data', ResponseData);
                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                    end else begin
                        Error('Unable to update loan variation application.');
                    end;
                end else begin
                    Error('Loan Variation Request with application number = %1 is NOT available for editing', application_no.asValue.AsText);
                end;
            end else begin
                Error('Unknown member loan with loan number = %1', member_loan.asValue.AsText);
            end;
        end else begin
            Error('Unknown member with member number = %1', member_number.asValue.AsText);
        end;

        exit(Response);
    end;

    local procedure GetLoanVariationRequests(Payload: JsonObject): Text
    var
        filter_property: JsonToken;
        filter_value: JsonToken;
        start_date: JsonToken;
        end_date: JsonToken;
        page_number: JsonToken;
        page_size: JsonToken;
        crm_branch: JsonToken;

        KeyExists: Boolean;

        LoanVariationRequests: Record "Product Variations";
        ApplicationTrails: record "Approval Entry";
        SLA: record "Defined SLA";
        Comment: record "Comments";

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;
        VariationTime: Time;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;
        Count: Integer;
        FirstRow: Integer;
        LastRow: Integer;
        TotalFoundRecords: Integer;
        SearchString: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        KeyExists := Payload.Get('filter_property', filter_property);
        KeyExists := Payload.Get('filter_value', filter_value);
        KeyExists := Payload.Get('start_date', start_date);
        KeyExists := Payload.Get('end_date', end_date);
        KeyExists := Payload.Get('crm_branch', crm_branch);
        Payload.Get('page_number', page_number);
        Payload.Get('page_size', page_size);

        LoanVariationRequests.Reset;
        LoanVariationRequests.SetCurrentKey("Application Date");
        LoanVariationRequests.SetAscending("Application Date", false);
        LoanVariationRequests.SetRange("Variation Type", LoanVariationRequests."Variation Type"::Loan);

        if KeyExists then begin
            if (crm_branch.AsValue.AsText <> 'ALL') then begin
                LoanVariationRequests.SetRange(LoanVariationRequests."CRM Originating Branch", crm_branch.AsValue.AsText);
            end;
        end;

        // Search Value
        if (not filter_property.AsValue.IsNull) and (not filter_value.AsValue.IsNull) then begin
            if (filter_property.AsValue.AsText <> '') and (filter_value.AsValue.AsText <> '') then begin
                SearchString := filter_value.AsValue.AsText;

                case filter_property.AsValue.AsText of
                    'application_no':
                        LoanVariationRequests.SetRange(LoanVariationRequests."No.", SearchString);
                    'crm_application_no':
                        LoanVariationRequests.SetRange(LoanVariationRequests."CRM Application No.", SearchString);
                    'member_no':
                        LoanVariationRequests.SetRange(LoanVariationRequests."Member No.", SearchString);
                    'loan_no':
                        LoanVariationRequests.SetRange(LoanVariationRequests."Account No", SearchString);
                    'account_no':
                        LoanVariationRequests.SetRange(LoanVariationRequests."Account No", SearchString);
                    'status':
                        LoanVariationRequests.SetFilter(LoanVariationRequests.Status, SearchString);
                    else
                        LoanVariationRequests.SetRange(LoanVariationRequests."No.", SearchString);
                end;
            end;
        end;

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                LoanVariationRequests.SetFilter("Application Date", '>=%1&<=%2', StartDate, EndDate);
            end;
        end;

        IF LoanVariationRequests.FindSet then begin
            // Data found
            Count := 0;
            FirstRow := ((page_number.AsValue.AsInteger - 1) * page_size.AsValue.AsInteger) + 1;
            LastRow := page_number.AsValue.AsInteger * page_size.AsValue.AsInteger;

            TotalFoundRecords := LoanVariationRequests.Count;

            repeat begin
                Count += 1;

                if (Count >= FirstRow) and (Count <= LastRow) then begin
                    LoanVariationRequests.CalcFields("Responsible Officer", "Supervisor ID");

                    Datum.Add('application_no', LoanVariationRequests."No.");
                    Datum.Add('variation_type', Format(LoanVariationRequests."Variation Type"));
                    Datum.Add('account_no', LoanVariationRequests."Account No");
                    Datum.Add('member_no', LoanVariationRequests."Member No.");
                    Datum.Add('member_name', LoanVariationRequests."Member Name");
                    Datum.Add('product_type', LoanVariationRequests."Product Type");
                    Datum.Add('product_name', LoanVariationRequests."Product Name");

                    Datum.Add('amount_on', LoanVariationRequests."Amount On");
                    Datum.Add('amount_off', LoanVariationRequests."Amount Off");

                    Datum.Add('crm_application_no', LoanVariationRequests."CRM Application No.");
                    Datum.Add('crm_created_by', LoanVariationRequests."CRM Created By");
                    Datum.Add('crm_originating_branch', LoanVariationRequests."CRM Originating Branch");
                    Datum.Add('status', Format(LoanVariationRequests.Status));
                    Datum.Add('application_date', GlobalFunctions.FormatISODate(LoanVariationRequests."Application Date"));
                    Datum.Add('effective_date', GlobalFunctions.FormatISODate(LoanVariationRequests."Effective Month"));

                    Datum.Add('activity_code', LoanVariationRequests."Global Dimension 2 Code");
                    Datum.Add('branch_code', LoanVariationRequests."Global Dimension 1 Code");
                    Datum.Add('posted', LoanVariationRequests.Posted);
                    Datum.Add('is_sent_back_to_crm', LoanVariationRequests."Sent Back to CRM");

                    Datum.Add('variation_action', LoanVariationRequests."Variation Action");
                    Datum.Add('variation_action_desc', Format(LoanVariationRequests."Variation Action"));


                    ApplicationTrails.Reset;

                    ApplicationTrails.SetRange("Document No.", LoanVariationRequests."No.");

                    if ApplicationTrails.FindLast then begin
                        Datum.Add('responsible_officer', ApplicationTrails."Sender ID");
                        Datum.Add('supervisor_id', ApplicationTrails."Approver ID");
                    end else begin
                        Datum.Add('responsible_officer', LoanVariationRequests."Responsible Officer");
                        Datum.Add('supervisor_id', LoanVariationRequests."Supervisor ID");
                    end;

                    // SLA
                    WorkDays := 0;
                    SLADays := 0;
                    DelayDays := 0;
                    StatusComment := '';

                    if LoanVariationRequests."Application Time" <> 0DT then begin
                        VariationTime := system.DT2Time(LoanVariationRequests."Application Time");
                    end;
                    SLA.reset();
                    SLA.SetRange("Origination Type", SLA."Origination Type"::"Loan Variation");
                    if SLA.findfirst() then
                        SLADays := SLA.SLA;

                    If (LoanVariationRequests."Application Date" <> 0D) and (VariationTime <> 0T) and (LoanVariationRequests."Posting Date" <> 0D) and (LoanVariationRequests."Posting Time" <> 0T) then begin
                        Globalfunctions.HoursBetweenPeriods(LoanVariationRequests."Application Date", VariationTime, LoanVariationRequests."Posting Date", LoanVariationRequests."Posting Time", Duration, WokedOnANonWorkingPeriod);
                        WorkDays := Duration;
                        DelayDays := WorkDays - (SLADays / 3);
                        IF DelayDays < 0 then DelayDays := 0;
                    end;

                    Comment.reset();
                    Comment.SetRange("Header No.", LoanVariationRequests."No.");
                    If Comment.FindLast() then begin
                        StatusComment := Comment.Comment;
                    end;

                    Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
                    Datum.Add('SLA_days', Format(SLADays));
                    Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
                    Datum.Add('tat_status', Format(TAtStatus));
                    Datum.Add('status_comment', StatusComment);
                    Datum.Add('priority', Format(Priority));

                    Data.Add(Datum);
                    // Reset
                    Datum.ReadFrom('{}');
                end;
            end until (Count = LastRow) or (LoanVariationRequests.Next = 0);

            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanVariationRequest(Payload: JsonObject): Text
    var
        application_number: JsonToken;

        LoanVariationRequest: Record "Product Variations";
        ApplicationComments: Record "Loan Appraisal Comments";
        ApplicationTrails: record "Approval Entry";

        new_guarantors: JsonArray;
        new_guarantor: JsonObject;
        Comments: JsonArray;
        Comment: JsonObject;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('application_number', application_number);

        LoanVariationRequest.Reset;
        LoanVariationRequest.SetRange("No.", application_number.AsValue.AsText);
        LoanVariationRequest.SetFilter("Variation Type", '=%1', LoanVariationRequest."Variation Type"::Loan);

        IF LoanVariationRequest.FindFirst() then begin
            LoanVariationRequest.CalcFields("Responsible Officer");

            Datum.Add('application_no', LoanVariationRequest."No.");
            Datum.Add('variation_type', LoanVariationRequest."Variation Type");
            Datum.Add('variation_type_desc', Format(LoanVariationRequest."Variation Type"));
            Datum.Add('member_loan', LoanVariationRequest."Account No");
            Datum.Add('member_number', LoanVariationRequest."Member No.");
            Datum.Add('member_name', LoanVariationRequest."Member Name");
            Datum.Add('product_type', LoanVariationRequest."Product Type");
            Datum.Add('product_name', LoanVariationRequest."Product Name");

            Datum.Add('reference', LoanVariationRequest.Reference);
            Datum.Add('new_deduction_amount', LoanVariationRequest."Amount On");
            Datum.Add('amount_off', LoanVariationRequest."Amount Off");

            Datum.Add('crm_application_no', LoanVariationRequest."CRM Application No.");
            Datum.Add('crm_notes', LoanVariationRequest."CRM Notes");
            Datum.Add('crm_created_by', LoanVariationRequest."CRM Created By");
            Datum.Add('crm_originating_branch', LoanVariationRequest."CRM Originating Branch");
            Datum.Add('status', LoanVariationRequest.Status);
            Datum.Add('status_desc', Format(LoanVariationRequest.Status));
            Datum.Add('application_date', GlobalFunctions.FormatISODate(LoanVariationRequest."Application Date"));
            Datum.Add('effective_date', GlobalFunctions.FormatISODate(LoanVariationRequest."Effective month"));

            Datum.Add('activity_code', LoanVariationRequest."Global Dimension 2 Code");
            Datum.Add('branch_code', LoanVariationRequest."Global Dimension 1 Code");
            Datum.Add('posted', LoanVariationRequest.Posted);
            Datum.Add('is_sent_back_to_crm', LoanVariationRequest."Sent Back to CRM");

            LoanVariationRequest.CalcFields("Responsible Officer", "Supervisor ID");


            ApplicationTrails.Reset;

            ApplicationTrails.SetRange("Document No.", LoanVariationRequest."No.");

            if ApplicationTrails.FindLast then begin
                Datum.Add('responsible_officer', ApplicationTrails."Sender ID");
                Datum.Add('supervisor_id', ApplicationTrails."Approver ID");
            end else begin
                Datum.Add('responsible_officer', LoanVariationRequest."Responsible Officer");
                Datum.Add('supervisor_id', LoanVariationRequest."Supervisor ID");
            end;

            Datum.Add('variation_action', LoanVariationRequest."Variation Action");
            Datum.Add('variation_action_desc', Format(LoanVariationRequest."Variation Action"));

            ApplicationComments.Reset;

            ApplicationComments.SetRange("Loan No.", LoanVariationRequest."No.");
            ApplicationComments.SetCurrentKey("Entry No.");
            ApplicationComments.SetAscending("Entry No.", false);

            if ApplicationComments.FindSet then begin
                repeat begin
                    Comment.Add('comment', ApplicationComments.Comment);
                    Comment.Add('commented_by', ApplicationComments.Appraiser);
                    Comment.Add('date_time', GlobalFunctions.FormatISODateTime(ApplicationComments.SystemCreatedAt));

                    Comment.Add('is_read', ApplicationComments.Commented);

                    Comments.Add(Comment);

                    // Reset
                    Comment.ReadFrom('{}');
                end until ApplicationComments.Next = 0;
            end;

            Datum.Add('comments', Comments);

            Datum.Add('created_at', LoanVariationRequest.SystemCreatedAt);
            Datum.Add('modified_at', LoanVariationRequest.SystemModifiedAt);
        end else begin
            Error('Loan variation request application with number %1 NOT found.', application_number.AsValue.AsText);
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberAccountsList(Payload: JsonObject): Text
    var
        member_no: JsonToken;

        AccountsList: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        OneMonthInstallment: Record "One Month Installment";
        CashTrans: record "Cashier Transactions";

        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;

        TotalSurety: Decimal;
        TotalBlockedAmount: Decimal;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        BlockedAmounts: JsonArray;
        BlockedAmount: JsonObject;
        Response: Text;
    begin
        Payload.Get('member_no', member_no);

        AccountsList.Reset;
        AccountsList.SetRange("Member No.", member_no.AsValue.AsText);

        AccountsList.SetAutoCalcFields(
            "Balance (LCY)",
            "Authorised Over Draft",
            "Uncleared Cheques",
            "ATM Transactions",
            "Lien Placed",
            "Coop Transactions",
            "One Month Installment"
        );

        IF AccountsList.FindSet then begin
            repeat begin
                Datum.Add('account_no', AccountsList."No.");
                Datum.Add('account_name', AccountsList.Name);
                Datum.Add('account_status', Format(AccountsList.Status));

                AccountsList.CalcFields("Balance (LCY)", "Last Transaction Date");
                Datum.Add('account_balance', AccountsList."Balance (LCY)");
                Datum.Add('available_balance', GlobalFunctions.GetSavingsAccountAvailableBalance(AccountsList, false));

                Datum.Add('monthly_contribution', AccountsList."Monthly Contribution");
                Datum.Add('outstanding_interest', AccountsList."Outstanding Interest");
                Datum.Add('product_type', AccountsList."Product Type");
                Datum.Add('product_name', AccountsList."Product Name");
                Datum.Add('product_category', Format(AccountsList."Product Category"));

                ProductFactory.Reset;
                ProductFactory.SetRange("Product ID", AccountsList."Product Type");
                ProductFactory.SetRange("Variation Allowed", true);

                if ProductFactory.FindFirst then begin
                    Datum.Add('is_variation_allowed', ProductFactory."Variation Allowed");
                end else begin
                    Datum.Add('is_variation_allowed', false);
                end;

                Datum.Add('registration_date', AccountsList."Registration Date");
                Datum.Add('last_transaction_date', AccountsList."Last Transaction Date");
                Datum.Add('last_date_modified', AccountsList."Last Date Modified");

                if AccountsList."Product Category" = AccountsList."Product Category"::"BOSA Deposits" then begin

                    OneMonthInstallment.Reset();
                    OneMonthInstallment.SetRange("Member No.", AccountsList."Member No.");
                    OneMonthInstallment.SetRange("Account No.", AccountsList."No.");
                    OneMonthInstallment.SetRange(Type, OneMonthInstallment.Type::Surety);
                    OneMonthInstallment.SetRange("Funds Status", OneMonthInstallment."Funds Status"::WithHeld);
                    OneMonthInstallment.SetFilter(Total, '>%1', 0);
                    // if OneMonthInstallment.Find('-') THEN begin
                    //     Datum.Add('has_surety', true);
                    //     Datum.Add('surety_amount', OneMonthInstallment.Total);
                    // end;
                    if OneMonthInstallment.FindSet THEN begin
                        Datum.Add('has_surety', true);
                        TotalSurety := 0;

                        repeat begin
                            TotalSurety += OneMonthInstallment.Total;
                        end until OneMonthInstallment.Next = 0;

                        Datum.Add('surety_amount', TotalSurety);
                    end else begin
                        Datum.Add('has_surety', false);
                        Datum.Add('surety_amount', 0);
                    end;

                end else begin
                    Datum.Add('has_surety', false);
                    Datum.Add('surety_amount', 0);
                end;

                Datum.Add('prorata', CustomCuesCodeunit.Prorata(AccountsList."Member No.", AccountsList."Product Type"));

                // Blocked amounts
                OneMonthInstallment.Reset();
                OneMonthInstallment.SetRange("Member No.", AccountsList."Member No.");
                OneMonthInstallment.SetRange("Account No.", AccountsList."No.");
                OneMonthInstallment.SetRange("Funds Status", OneMonthInstallment."Funds Status"::WithHeld);

                Clear(BlockedAmounts);
                Clear(TotalBlockedAmount);

                if OneMonthInstallment.Findset then begin
                    repeat begin
                        Clear(BlockedAmount);

                        BlockedAmount.Add('record_no', OneMonthInstallment."Record No.");
                        BlockedAmount.Add('member_no', OneMonthInstallment."Member No.");
                        BlockedAmount.Add('total_amount', OneMonthInstallment.Total);
                        BlockedAmount.Add('funds_status', Format(OneMonthInstallment."Funds Status"));
                        BlockedAmount.Add('status', Format(OneMonthInstallment.Status));
                        BlockedAmount.Add('type', Format(OneMonthInstallment.Type));
                        BlockedAmount.Add('comments', OneMonthInstallment."Held Funds Comments");

                        TotalBlockedAmount += OneMonthInstallment.Total;

                        BlockedAmounts.Add(BlockedAmount);
                    end until OneMonthInstallment.Next = 0;
                end;

                //
                CashTrans.Reset;
                CashTrans.SetRange("Account No", AccountsList."No.");
                CashTrans.SetRange(Posted, true);
                CashTrans.SetFilter(Type, '=%1|%2|%3', CashTrans.Type::Lien, CashTrans.Type::"Cheque Deposit", CashTrans.Type::"Credit Cheque");
                CashTrans.SetRange("Cheque Status", CashTrans."Cheque Status"::Pending);

                if CashTrans.Findset then begin
                    repeat begin
                        Clear(BlockedAmount);

                        BlockedAmount.Add('record_no', CashTrans."No");
                        BlockedAmount.Add('member_no', CashTrans."Member No.");
                        BlockedAmount.Add('total_amount', CashTrans.Amount);
                        BlockedAmount.Add('funds_status', Format(CashTrans."Status"));
                        BlockedAmount.Add('status', Format(CashTrans.Status));
                        BlockedAmount.Add('type', Format(CashTrans.Type));
                        BlockedAmount.Add('comments', CashTrans.Remarks);

                        TotalBlockedAmount += CashTrans.Amount;

                        BlockedAmounts.Add(BlockedAmount);
                    end until CashTrans.Next = 0;
                end;


                Datum.Add('total_blocked_amount', TotalBlockedAmount);
                Datum.Add('blocked_amounts', BlockedAmounts);
                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until AccountsList.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberAccountStatement(Payload: JsonObject): Text
    var
        account_number: JsonToken;
        page_number: JsonToken;
        page_size: JsonToken;

        MemberAccount: Record "Savings Accounts";
        SavingsLedgerEntry: Record "Savings Ledger Entry";

        Count: Integer;
        FirstRow: Integer;
        LastRow: Integer;
        TotalFoundRecords: Integer;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('account_number', account_number);
        Payload.Get('page_number', page_number);
        Payload.Get('page_size', page_size);

        MemberAccount.Reset;
        MemberAccount.SetRange("No.", account_number.AsValue.AsText);

        IF MemberAccount.FindSet then begin
            // Account found
            Count := 0;
            FirstRow := ((page_number.AsValue.AsInteger - 1) * page_size.AsValue.AsInteger) + 1;
            LastRow := page_number.AsValue.AsInteger * page_size.AsValue.AsInteger;

            SavingsLedgerEntry.Reset;
            SavingsLedgerEntry.SetCurrentkey("Entry No.");
            SavingsLedgerEntry.Ascending(false);
            SavingsLedgerEntry.SetRange("Customer No.", MemberAccount."No.");

            IF SavingsLedgerEntry.FindSet then begin
                TotalFoundRecords := SavingsLedgerEntry.Count;
                MemberAccount.CalcFields("Balance (LCY)", "Authorised Over Draft", "Uncleared Cheques", "ATM Transactions", "Lien Placed");

                repeat begin
                    Count += 1;

                    if (Count >= FirstRow) and (Count <= LastRow) then begin
                        Datum.Add('entry_no', SavingsLedgerEntry."Entry No.");
                        Datum.Add('document_no', SavingsLedgerEntry."Document No.");
                        Datum.Add('posting_date', Format(SavingsLedgerEntry."Posting Date"));
                        Datum.Add('description', SavingsLedgerEntry.Description);
                        Datum.Add('amount', Abs(SavingsLedgerEntry."Amount (LCY)"));
                        Datum.Add('running_balance', GlobalFunctions.GetRunningBalance(SavingsLedgerEntry."Entry No.", SavingsLedgerEntry."Customer No."));

                        IF SavingsLedgerEntry.Amount < 0 then begin
                            Datum.Add('entry_type', 'Credit');
                        end else begin
                            Datum.Add('entry_type', 'Debit');
                        end;

                        Data.Add(Datum);
                        // Reset
                        Datum.ReadFrom('{}');
                    end;
                end until (Count = LastRow) or (SavingsLedgerEntry.Next = 0);
            end;

            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            // ResponseObject.Add('status', 'ERROR');
            // ResponseObject.Add('description', 'Member account NOT found');
            // ResponseObject.Add('data', Data);
            // AddDateTimeToResponse(ResponseObject);

            Error('Member account NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberLoanStatement(Payload: JsonObject): Text
    var
        loan_number: JsonToken;
        page_number: JsonToken;
        page_size: JsonToken;

        Loan: Record Loans;
        CreditLedgerEntry: Record "Credit Ledger Entry";

        Count: Integer;
        FirstRow: Integer;
        LastRow: Integer;
        TotalFoundRecords: Integer;
        RunningBalance: Decimal;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('loan_number', loan_number);
        Payload.Get('page_number', page_number);
        Payload.Get('page_size', page_size);

        Loan.Reset;
        Loan.SetRange("Loan No.", loan_number.AsValue.AsText);

        IF Loan.FindSet then begin
            // Loan found
            Count := 0;
            FirstRow := ((page_number.AsValue.AsInteger - 1) * page_size.AsValue.AsInteger) + 1;
            LastRow := page_number.AsValue.AsInteger * page_size.AsValue.AsInteger;

            CreditLedgerEntry.Reset;
            CreditLedgerEntry.SetCurrentkey("Entry No.");
            CreditLedgerEntry.Ascending(false);
            CreditLedgerEntry.SetRange("Loan No", Loan."Loan No.");
            CreditLedgerEntry.SetFilter("Transaction Type", '<>%1', CreditLedgerEntry."Transaction Type"::Bills);

            IF CreditLedgerEntry.FindSet then begin
                TotalFoundRecords := CreditLedgerEntry.Count;

                repeat begin
                    Count += 1;

                    if (Count >= FirstRow) and (Count <= LastRow) then begin
                        RunningBalance := GlobalFunctions.GetLoanRunningBal(CreditLedgerEntry."Entry No.", Loan."Loan No.");

                        Datum.Add('loan_no', Loan."Loan No.");
                        Datum.Add('entry_no', CreditLedgerEntry."Entry No.");
                        Datum.Add('document_no', CreditLedgerEntry."Document No.");
                        Datum.Add('posting_date', Format(CreditLedgerEntry."Posting Date"));
                        Datum.Add('description', CreditLedgerEntry.Description);
                        Datum.Add('amount', Abs(CreditLedgerEntry.Amount));
                        Datum.Add('running_balance', RunningBalance);

                        IF CreditLedgerEntry.Amount < 0 then begin
                            Datum.Add('entry_type', 'Credit');
                        end else begin
                            Datum.Add('entry_type', 'Debit');
                        end;

                        Data.Add(Datum);
                        // Reset
                        Datum.ReadFrom('{}');
                    end;
                end until (Count = LastRow) or (CreditLedgerEntry.Next = 0);
            end;

            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            // ResponseObject.Add('status', 'ERROR');
            // ResponseObject.Add('description', 'Member loan NOT found');
            // ResponseObject.Add('data', Data);
            // AddDateTimeToResponse(ResponseObject);

            Error('Member loan NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberLoansGuaranteed(Payload: JsonObject): Text
    var
        member_number: JsonToken;

        LoanGuarantorsList: Record "Loan Guarantors and Security";
        Loan: Record Loans;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('member_number', member_number);

        LoanGuarantorsList.Reset;
        LoanGuarantorsList.SetRange("Member No", member_number.AsValue.AsText);
        LoanGuarantorsList.SetFilter("Total Loan Balance", '>0');
        LoanGuarantorsList.SetRange(Substituted, false);

        IF LoanGuarantorsList.FindSet then begin
            repeat begin
                Datum.Add('loan_no', LoanGuarantorsList."Loan No");

                Loan.Reset;
                Loan.SetRange("Loan No.", LoanGuarantorsList."Loan No");

                if Loan.FindFirst then begin
                    Loan.CalcFields("Loans Category-SASRA");

                    Datum.Add('loan_product_code', Loan."Loan Product Type");
                    Datum.Add('loan_product_type', Loan."Loan Product Type Name");
                    Datum.Add('loan_performance', Format(Loan."Loans Category-SASRA"));
                    Datum.Add('loan_expected_date_of_completion', Loan."Expected Date of Completion");
                end else begin
                    Datum.Add('loan_product_code', '');
                    Datum.Add('loan_product_type', '');
                    Datum.Add('loan_performance', '');
                    Datum.Add('loan_expected_date_of_completion', '');
                end;

                Datum.Add('loanee_name', LoanGuarantorsList."Loanee Name");
                Datum.Add('loanee_member_number', LoanGuarantorsList."Member Guaranteed");
                Datum.Add('amount_guaranteed', LoanGuarantorsList."Amount Guaranteed");
                Datum.Add('guarantor_type', LoanGuarantorsList."Guarantor Type");
                Datum.Add('substituted', LoanGuarantorsList.Substituted);
                Datum.Add('substituted_by', LoanGuarantorsList."Substituted By");

                LoanGuarantorsList.CalcFields("Outstanding Balance", "Total Loan Balance");
                Datum.Add('outstanding_balance', LoanGuarantorsList."Outstanding Balance");
                Datum.Add('total_loan_balance', LoanGuarantorsList."Total Loan Balance");

                LoanGuarantorsList.CalcFields("No Of Loans Guaranteed", "Outstanding Balance", "Total Loan Balance");
                Datum.Add('number_of_loans_guaranteed', LoanGuarantorsList."No Of Loans Guaranteed");

                Datum.Add('number_of_major_loans_guaranteed', LoanGuarantorsList."No Of Major Loans Guaranteed");
                Datum.Add('number_of_minor_loans_guaranteed', LoanGuarantorsList."No Of Minor Loans Guaranteed");

                Datum.Add('date', LoanGuarantorsList.Date);

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until LoanGuarantorsList.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CreateDepositVariationRequest(Payload: JsonObject): Text
    var
        member_number: JsonToken;
        deposit_account: JsonToken;
        new_contribution_amount: JsonToken;
        // effective_date: JsonToken;
        crm_application_no: JsonToken;
        crm_notes: JsonToken;
        crm_created_by: JsonToken;
        crm_originating_branch: JsonToken;
        variation_action: JsonToken;

        KeyExists: Boolean;

        Variations: Record "Product Variations";
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        NewNo: Code[20];
        NewNoSeriesCode: Code[20];
        // CRMNewNo: Code[20];
        // CRMNewNoSeriesCode: Code[20];

        EditMember: Record Members;
        EditMemberAccount: Record "Savings Accounts";
        Comment: Record "Loan Appraisal Comments";
        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        KeyExists := Payload.Get('member_number', member_number);
        KeyExists := Payload.Get('deposit_account', deposit_account);
        KeyExists := Payload.Get('new_contribution_amount', new_contribution_amount);
        // KeyExists := Payload.Get('effective_date', effective_date);
        KeyExists := Payload.Get('crm_application_no', crm_application_no);
        KeyExists := Payload.Get('crm_notes', crm_notes);
        KeyExists := Payload.Get('crm_created_by', crm_created_by);
        KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);
        KeyExists := Payload.Get('variation_action', variation_action);

        EditMember.Reset();

        EditMember.SetRange("No.", member_number.asValue.AsText);

        IF EditMember.FindFirst then begin
            EditMemberAccount.Reset();
            EditMemberAccount.SetRange("Member No.", EditMember."No.");
            EditMemberAccount.SetRange("No.", deposit_account.AsValue.AsText);
            // EditMemberAccount.SetRange(Status, Format(EditMemberAccount.Status::Active));
            // EditMemberAccount.SetRange("Product Category", Format(EditMemberAccount."Product Category"::"BOSA Deposits"));

            IF EditMemberAccount.FindFirst then begin
                Variations.Init;

                Variations."Variation Type" := Variations."Variation Type"::Savings;

                // SeriesSetup.Get;
                // SeriesSetup.TestField(SeriesSetup.Variations);
                // NoSeriesMgt.InitSeries(SeriesSetup.Variations, SeriesSetup.Variations, 0D, NewNo, NewNoSeriesCode);

                Variations."No." := '';
                Variations."No. Series" := '';

                // Variations."CRM Application No." := crm_application_no.AsValue.AsText;
                Variations."CRM Notes" := crm_notes.AsValue.AsText;
                Variations."CRM Originating Branch" := crm_originating_branch.AsValue.AsText;
                Variations."CRM Created By" := crm_created_by.AsValue.AsText;

                if crm_created_by.AsValue.AsText = '' then begin
                    Error('ERR_401. Invalid application. Origination NOT accepted!');
                end;

                Variations."Member No." := member_number.asValue.AsText;
                Variations.Validate("Member No.");

                // Variations."Effective Date" := effective_date.AsValue.AsDate;
                Variations."Account No" := EditMemberAccount."No.";
                Variations.Validate("Account No");
                Variations."Amount On" := new_contribution_amount.AsValue.AsDecimal;
                Variations.Validate("Amount On");

                Variations."Application Date" := Today;
                Variations.Validate("Application Date");

                Variations.Status := Variations.Status::Open;
                // Variations.Status := Variations.Status::Approved;

                // CRM - No Series
                // SeriesSetup.TestField(SeriesSetup."CRM - Deposit Variation Reqs");
                // NoSeriesMgt.InitSeries(SeriesSetup."CRM - Deposit Variation Reqs", SeriesSetup."CRM - Deposit Variation Reqs", 0D, CRMNewNo, CRMNewNoSeriesCode);

                // Variations."CRM Application No." := CRMNewNo;
                // Variations."CRM No. Series" := CRMNewNoSeriesCode;

                Variations."Variation Action" := variation_action.AsValue.AsInteger;

                IF Variations.Insert(true) then begin
                    Variations."CRM Application No." := Variations."No.";
                    Variations."CRM No. Series" := Variations."No. Series";
                    Variations.Modify;

                    // CRM Comments/Notes
                    if crm_notes.AsValue.AsText <> '' then begin
                        Comment.Init;

                        Comment."Loan No." := Variations."No.";
                        Comment.Comment := crm_notes.AsValue.AsText;
                        Comment.Appraiser := crm_created_by.AsValue.AsText;
                        Comment."Entry Date" := Today;
                        Comment."Entry Time" := Time;
                        Comment.Commented := true;

                        Comment.Insert(false);
                    end;

                    EDMSFunctions.EDMSScannedLog(
                        Variations."No.",
                        "CRM Originations"::"Deposit Variation",
                        Variations."Member No.",
                        Variations."CRM Created By",
                        Variations."CRM Originating Branch"
                    );

                    // Handle CRM branch assigmnent
                    Variations."Global Dimension 1 Code" := GlobalFunctions.GetBranchCodeFromCRMOrigination(Variations."CRM Originating Branch");
                    Variations.Modify;

                    Variations.Reset;

                    Variations.SetRange("No.", NewNo);
                    ResponseData.Add('application_number', Variations."No.");
                    ResponseData.Add('application_status', Format(Variations.Status));

                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('description', 'Deposit variation application with CRM application number ' + Variations."No." + ' has been created successfully.');
                    ResponseObject.Add('data', ResponseData);
                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                end else begin
                    // ResponseObject.Add('status', 'ERROR');
                    // ResponseObject.Add('description', 'Unable to create deposit variation application.');
                    // ResponseObject.Add('errors', Errors);
                    // AddDateTimeToResponse(ResponseObject);

                    // ResponseObject.WriteTo(Response);

                    Error('Unable to create deposit variation application.');
                end;
            end else begin
                Error('Unknown member account with account number = %1', deposit_account.asValue.AsText);
            end;
        end else begin
            Error('Unknown member with member number = %1', member_number.asValue.AsText);
        end;

        exit(Response);
    end;

    local procedure UpdateDepositVariationRequest(Payload: JsonObject): Text
    var
        application_no: JsonToken;
        member_number: JsonToken;
        deposit_account: JsonToken;
        new_contribution_amount: JsonToken;
        // effective_date: JsonToken;
        crm_application_no: JsonToken;
        crm_notes: JsonToken;
        crm_created_by: JsonToken;
        crm_originating_branch: JsonToken;
        variation_action: JsonToken;

        KeyExists: Boolean;

        Variations: Record "Product Variations";
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        NewNo: Code[20];
        NewNoSeriesCode: Code[20];
        // CRMNewNo: Code[20];
        // CRMNewNoSeriesCode: Code[20];

        EditMember: Record Members;
        EditMemberAccount: Record "Savings Accounts";
        Comment: Record "Loan Appraisal Comments";
        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        KeyExists := Payload.Get('application_no', application_no);
        KeyExists := Payload.Get('member_number', member_number);
        KeyExists := Payload.Get('deposit_account', deposit_account);
        KeyExists := Payload.Get('new_contribution_amount', new_contribution_amount);
        // KeyExists := Payload.Get('effective_date', effective_date);
        KeyExists := Payload.Get('crm_application_no', crm_application_no);
        KeyExists := Payload.Get('crm_notes', crm_notes);
        KeyExists := Payload.Get('crm_created_by', crm_created_by);
        KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);
        KeyExists := Payload.Get('variation_action', variation_action);

        EditMember.Reset();

        EditMember.SetRange("No.", member_number.asValue.AsText);

        IF EditMember.FindFirst then begin
            EditMemberAccount.Reset();
            EditMemberAccount.SetRange("Member No.", EditMember."No.");
            EditMemberAccount.SetRange("No.", deposit_account.AsValue.AsText);
            // EditMemberAccount.SetRange(Status, Format(EditMemberAccount.Status::Active));
            // EditMemberAccount.SetRange("Product Category", Format(EditMemberAccount."Product Category"::"BOSA Deposits"));

            IF EditMemberAccount.FindFirst then begin
                Variations.Reset;

                Variations.SetRange("No.", application_no.AsValue.AsText);
                Variations.SetRange("Sent Back to CRM", true);

                if Variations.FindFirst then begin
                    // Variations."CRM Application No." := crm_application_no.AsValue.AsText;
                    Variations."CRM Notes" := crm_notes.AsValue.AsText;
                    Variations."CRM Originating Branch" := crm_originating_branch.AsValue.AsText;
                    // Variations."CRM Created By" := crm_created_by.AsValue.AsText;

                    Variations."Member No." := member_number.asValue.AsText;
                    Variations.Validate("Member No.");
                    Variations."Variation Type" := Variations."Variation Type"::Savings;

                    // Variations."Effective Date" := effective_date.AsValue.AsDate;
                    Variations."Account No" := EditMemberAccount."No.";
                    Variations.Validate("Account No");
                    Variations."Amount On" := new_contribution_amount.AsValue.AsDecimal;
                    Variations.Validate("Amount On");

                    Variations."Application Date" := Today;
                    Variations.Validate("Application Date");

                    Variations.Status := Variations.Status::Open;
                    // Variations.Status := Variations.Status::Approved;
                    Variations."Sent Back to CRM" := false;

                    Variations."Variation Action" := variation_action.AsValue.AsInteger;

                    IF Variations.Modify(true) then begin
                        // CRM Comments/Notes
                        if crm_notes.AsValue.AsText <> '' then begin
                            Comment.Init;

                            Comment."Loan No." := Variations."No.";
                            Comment.Comment := crm_notes.AsValue.AsText;
                            Comment.Appraiser := crm_created_by.AsValue.AsText;
                            Comment."Entry Date" := Today;
                            Comment."Entry Time" := Time;
                            Comment.Commented := true;

                            Comment.Insert(false);
                        end;

                        // Handle CRM branch assigmnent
                        Variations."Global Dimension 1 Code" := GlobalFunctions.GetBranchCodeFromCRMOrigination(Variations."CRM Originating Branch");
                        Variations.Modify;

                        Variations.Reset;

                        Variations.SetRange("No.", NewNo);
                        ResponseData.Add('application_number', Variations."No.");
                        ResponseData.Add('application_status', Format(Variations.Status));

                        ResponseObject.Add('status', 'SUCCESS');
                        ResponseObject.Add('description', 'Deposit variation application with CRM application number ' + Variations."No." + ' has been updated successfully.');
                        ResponseObject.Add('data', ResponseData);
                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                    end else begin
                        Error('Unable to update deposit variation application.');
                    end;
                end else begin
                    Error('Deposit Variation Request with application number = %1 is NOT available for editing', application_no.asValue.AsText);
                end;
            end else begin
                Error('Unknown member account with account number = %1', deposit_account.asValue.AsText);
            end;
        end else begin
            Error('Unknown member with member number = %1', member_number.asValue.AsText);
        end;

        exit(Response);
    end;

    local procedure GetDepositVariationRequests(Payload: JsonObject): Text
    var
        filter_property: JsonToken;
        filter_value: JsonToken;
        start_date: JsonToken;
        end_date: JsonToken;
        page_number: JsonToken;
        page_size: JsonToken;
        crm_branch: JsonToken;

        KeyExists: Boolean;

        SavingsVariationRequests: Record "Product Variations";
        SLA: record "Defined SLA";
        Comment: record "Comments";
        ApplicationTrails: record "Approval Entry";

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;
        EmployerCode: Text;
        VariationTime: Time;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;
        Count: Integer;
        FirstRow: Integer;
        LastRow: Integer;
        TotalFoundRecords: Integer;
        SearchString: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        KeyExists := Payload.Get('filter_property', filter_property);
        KeyExists := Payload.Get('filter_value', filter_value);
        KeyExists := Payload.Get('start_date', start_date);
        KeyExists := Payload.Get('end_date', end_date);
        KeyExists := Payload.Get('crm_branch', crm_branch);
        Payload.Get('page_number', page_number);
        Payload.Get('page_size', page_size);

        SavingsVariationRequests.Reset;
        SavingsVariationRequests.SetCurrentKey("Application Date");
        SavingsVariationRequests.SetAscending("Application Date", false);
        SavingsVariationRequests.SetFilter("Variation Type", '=%1', SavingsVariationRequests."Variation Type"::Savings);

        if KeyExists then begin
            if (crm_branch.AsValue.AsText <> 'ALL') then begin
                SavingsVariationRequests.SetRange(SavingsVariationRequests."CRM Originating Branch", crm_branch.AsValue.AsText);
            end;
        end;

        // Search Value
        if (not filter_property.AsValue.IsNull) and (not filter_value.AsValue.IsNull) then begin
            if (filter_property.AsValue.AsText <> '') and (filter_value.AsValue.AsText <> '') then begin
                SearchString := filter_value.AsValue.AsText;

                case filter_property.AsValue.AsText of
                    'application_no':
                        SavingsVariationRequests.SetRange(SavingsVariationRequests."No.", SearchString);
                    'crm_application_no':
                        SavingsVariationRequests.SetRange(SavingsVariationRequests."CRM Application No.", SearchString);
                    'member_no':
                        SavingsVariationRequests.SetRange(SavingsVariationRequests."Member No.", SearchString);
                    'account_no':
                        SavingsVariationRequests.SetRange(SavingsVariationRequests."Account No", SearchString);
                    'status':
                        SavingsVariationRequests.SetFilter(SavingsVariationRequests.Status, SearchString);
                    else
                        SavingsVariationRequests.SetRange(SavingsVariationRequests."No.", SearchString);
                end;
            end;
        end;

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                SavingsVariationRequests.SetFilter("Application Date", '>=%1&<=%2', StartDate, EndDate);
            end;
        end;

        IF SavingsVariationRequests.FindSet then begin
            // Data found
            Count := 0;
            FirstRow := ((page_number.AsValue.AsInteger - 1) * page_size.AsValue.AsInteger) + 1;
            LastRow := page_number.AsValue.AsInteger * page_size.AsValue.AsInteger;

            TotalFoundRecords := SavingsVariationRequests.Count;

            repeat begin
                Count += 1;

                if (Count >= FirstRow) and (Count <= LastRow) then begin
                    SavingsVariationRequests.CalcFields("Responsible Officer", "Supervisor ID");

                    Datum.Add('application_no', SavingsVariationRequests."No.");
                    Datum.Add('variation_type', Format(SavingsVariationRequests."Variation Type"));
                    Datum.Add('account_no', SavingsVariationRequests."Account No");
                    Datum.Add('member_no', SavingsVariationRequests."Member No.");
                    Datum.Add('member_name', SavingsVariationRequests."Member Name");
                    Datum.Add('product_type', SavingsVariationRequests."Product Type");
                    Datum.Add('product_name', SavingsVariationRequests."Product Name");

                    Datum.Add('amount_on', SavingsVariationRequests."Amount On");
                    Datum.Add('amount_off', SavingsVariationRequests."Amount Off");

                    Datum.Add('crm_application_no', SavingsVariationRequests."CRM Application No.");
                    Datum.Add('crm_created_by', SavingsVariationRequests."CRM Created By");
                    Datum.Add('crm_originating_branch', SavingsVariationRequests."CRM Originating Branch");
                    Datum.Add('status', Format(SavingsVariationRequests.Status));
                    Datum.Add('application_date', GlobalFunctions.FormatISODate(SavingsVariationRequests."Application Date"));
                    Datum.Add('effective_date', GlobalFunctions.FormatISODate(SavingsVariationRequests."Effective month"));

                    Datum.Add('activity_code', SavingsVariationRequests."Global Dimension 2 Code");
                    Datum.Add('branch_code', SavingsVariationRequests."Global Dimension 1 Code");
                    Datum.Add('posted', SavingsVariationRequests.Posted);
                    Datum.Add('is_sent_back_to_crm', SavingsVariationRequests."Sent Back to CRM");

                    Datum.Add('variation_action', SavingsVariationRequests."Variation Action");
                    Datum.Add('variation_action_desc', Format(SavingsVariationRequests."Variation Action"));

                    ApplicationTrails.Reset;

                    ApplicationTrails.SetRange("Document No.", SavingsVariationRequests."No.");

                    if ApplicationTrails.FindLast then begin
                        Datum.Add('responsible_officer', ApplicationTrails."Sender ID");
                        Datum.Add('supervisor_id', ApplicationTrails."Approver ID");
                    end else begin
                        Datum.Add('responsible_officer', SavingsVariationRequests."Responsible Officer");
                        Datum.Add('supervisor_id', SavingsVariationRequests."Supervisor ID");
                    end;

                    // SLA
                    WorkDays := 0;
                    SLADays := 0;
                    DelayDays := 0;
                    EmployerCode := '';
                    StatusComment := '';

                    if SavingsVariationRequests."Application Time" <> 0DT then begin
                        VariationTime := system.DT2Time(SavingsVariationRequests."Application Time");
                    end;
                    SLA.reset();
                    SLA.SetRange("Origination Type", SLA."Origination Type"::"Deposit Variation");
                    if SLA.findfirst() then
                        SLADays := SLA.SLA;

                    If (SavingsVariationRequests."Application Date" <> 0D) and (VariationTime <> 0T) and (SavingsVariationRequests."Posting Date" <> 0D) and (SavingsVariationRequests."Posting Time" <> 0T) then begin
                        Globalfunctions.HoursBetweenPeriods(SavingsVariationRequests."Application Date", VariationTime, SavingsVariationRequests."Posting Date", SavingsVariationRequests."Posting Time", Duration, WokedOnANonWorkingPeriod);
                        WorkDays := Duration;
                        DelayDays := WorkDays - (SLADays / 3);
                        IF DelayDays < 0 then DelayDays := 0;
                    end;

                    Comment.reset();
                    Comment.SetRange("Header No.", SavingsVariationRequests."No.");
                    If Comment.FindLast() then begin
                        StatusComment := Comment.Comment;
                    end;

                    Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
                    Datum.Add('SLA_days', Format(SLADays));
                    Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
                    Datum.Add('tat_status', Format(TAtStatus));
                    Datum.Add('status_comment', StatusComment);
                    Datum.Add('priority', Format(Priority));

                    Data.Add(Datum);
                    // Reset
                    Datum.ReadFrom('{}');
                end;
            end until (Count = LastRow) or (SavingsVariationRequests.Next = 0);

            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetDepositVariationRequest(Payload: JsonObject): Text
    var
        application_number: JsonToken;

        DepositVariationRequest: Record "Product Variations";
        ApplicationComments: Record "Loan Appraisal Comments";
        ApplicationTrails: Record "Approval Entry";

        new_guarantors: JsonArray;
        new_guarantor: JsonObject;
        Comments: JsonArray;
        Comment: JsonObject;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('application_number', application_number);

        DepositVariationRequest.Reset;
        DepositVariationRequest.SetRange("No.", application_number.AsValue.AsText);
        DepositVariationRequest.SetFilter("Variation Type", '=%1', DepositVariationRequest."Variation Type"::Savings);

        IF DepositVariationRequest.FindFirst() then begin
            DepositVariationRequest.CalcFields("Responsible Officer", "Supervisor ID");

            Datum.Add('application_no', DepositVariationRequest."No.");
            Datum.Add('variation_type', DepositVariationRequest."Variation Type");
            Datum.Add('variation_type_desc', Format(DepositVariationRequest."Variation Type"));
            Datum.Add('deposit_account', DepositVariationRequest."Account No");
            Datum.Add('member_number', DepositVariationRequest."Member No.");
            Datum.Add('member_name', DepositVariationRequest."Member Name");
            Datum.Add('product_type', DepositVariationRequest."Product Type");
            Datum.Add('product_name', DepositVariationRequest."Product Name");

            Datum.Add('reference', DepositVariationRequest.Reference);
            Datum.Add('new_contribution_amount', DepositVariationRequest."Amount On");
            Datum.Add('amount_off', DepositVariationRequest."Amount Off");

            Datum.Add('crm_application_no', DepositVariationRequest."CRM Application No.");
            Datum.Add('crm_notes', DepositVariationRequest."CRM Notes");
            Datum.Add('crm_created_by', DepositVariationRequest."CRM Created By");
            Datum.Add('crm_originating_branch', DepositVariationRequest."CRM Originating Branch");
            Datum.Add('status', DepositVariationRequest.Status);
            Datum.Add('status_desc', Format(DepositVariationRequest.Status));
            Datum.Add('application_date', GlobalFunctions.FormatISODate(DepositVariationRequest."Application Date"));
            Datum.Add('effective_date', GlobalFunctions.FormatISODate(DepositVariationRequest."Effective month"));

            Datum.Add('activity_code', DepositVariationRequest."Global Dimension 2 Code");
            Datum.Add('branch_code', DepositVariationRequest."Global Dimension 1 Code");
            Datum.Add('posted', DepositVariationRequest.Posted);
            Datum.Add('is_sent_back_to_crm', DepositVariationRequest."Sent Back to CRM");


            ApplicationTrails.Reset;

            ApplicationTrails.SetRange("Document No.", DepositVariationRequest."No.");

            if ApplicationTrails.FindLast then begin
                Datum.Add('responsible_officer', ApplicationTrails."Sender ID");
                Datum.Add('supervisor_id', ApplicationTrails."Approver ID");
            end else begin
                Datum.Add('responsible_officer', DepositVariationRequest."Responsible Officer");
                Datum.Add('supervisor_id', DepositVariationRequest."Supervisor ID");
            end;

            Datum.Add('variation_action', DepositVariationRequest."Variation Action");
            Datum.Add('variation_action_desc', Format(DepositVariationRequest."Variation Action"));

            ApplicationComments.Reset;

            ApplicationComments.SetRange("Loan No.", DepositVariationRequest."No.");
            ApplicationComments.SetCurrentKey("Entry No.");
            ApplicationComments.SetAscending("Entry No.", false);

            if ApplicationComments.FindSet then begin
                repeat begin
                    Comment.Add('comment', ApplicationComments.Comment);
                    Comment.Add('commented_by', ApplicationComments.Appraiser);
                    Comment.Add('date_time', GlobalFunctions.FormatISODateTime(ApplicationComments.SystemCreatedAt));

                    Comment.Add('is_read', ApplicationComments.Commented);

                    Comments.Add(Comment);

                    // Reset
                    Comment.ReadFrom('{}');
                end until ApplicationComments.Next = 0;
            end;
            Datum.Add('comments', Comments);

            Datum.Add('created_at', DepositVariationRequest.SystemCreatedAt);
            Datum.Add('modified_at', DepositVariationRequest.SystemModifiedAt);
        end else begin
            Error('Deposit variation request application with number %1 NOT found.', application_number.AsValue.AsText);
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CreateSharesTransferRequest(Payload: JsonObject): Text
    var
        seller_member_number: JsonToken;
        buyer_list: JsonToken;
        buyer: JsonToken;
        buyer_member_number: JsonToken;
        buyer_transfer_amount: JsonToken;
        receipt_number: JsonToken;
        crm_application_no: JsonToken;
        crm_notes: JsonToken;
        crm_created_by: JsonToken;
        crm_originating_branch: JsonToken;

        KeyExists: Boolean;

        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        NewNo: Code[20];
        NewNoSeriesCode: Code[20];
        // CRMNewNo: Code[20];
        // CRMNewNoSeriesCode: Code[20];

        SellerMember: Record Members;
        SellerMemberAccount: Record "Savings Accounts";
        BuyerMember: Record Members;
        BuyerMemberAccount: Record "Savings Accounts";
        ProductCategory: enum "Product Categories";
        ShareCapitalTransfer: Record "Share Capital Transfer Buffer";
        ShareCapitalTransferLine: Record "Share Capital Transfer Lines";
        Comment: Record "Loan Appraisal Comments";
        CashTrans: Record "Cashier Transactions";
        Index: Integer;
        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        KeyExists := Payload.Get('seller_member_number', seller_member_number);
        KeyExists := Payload.Get('buyer_list', buyer_list);
        KeyExists := Payload.Get('receipt_number', receipt_number);
        KeyExists := Payload.Get('crm_application_no', crm_application_no);
        KeyExists := Payload.Get('crm_notes', crm_notes);
        KeyExists := Payload.Get('crm_created_by', crm_created_by);
        KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);

        SellerMember.Reset;

        SellerMember.SetRange("No.", seller_member_number.asValue.AsText);

        IF SellerMember.FindFirst then begin
            IF buyer_list.IsArray then begin
                IF buyer_list.AsArray.Count <= 0 then begin
                    Error('Expecting at least one member to transfer shares to.');
                end;

                // Share Capital Transfer
                ShareCapitalTransfer.Init;

                SeriesSetup.Get;
                SeriesSetup.TestField(SeriesSetup."Share Capital Transfer No");
                NewNo := NoSeriesMgt.GetNextNo(SeriesSetup."Share Capital Transfer No");
                // NoSeriesMgt.InitSeries(SeriesSetup."Share Capital Transfer No", SeriesSetup."Share Capital Transfer No", 0D, NewNo, NewNoSeriesCode);

                ShareCapitalTransfer."Document No" := NewNo;
                ShareCapitalTransfer."No. Series" := NewNoSeriesCode;

                SellerMemberAccount.Reset;
                SellerMemberAccount.SetRange("Product Category", SellerMemberAccount."Product Category"::"Share Capital");
                SellerMemberAccount.SetRange("Member No.", SellerMember."No.");
                IF SellerMemberAccount.FindFirst then begin
                    ShareCapitalTransfer."Source Account No" := SellerMemberAccount."No.";
                    ShareCapitalTransfer.Validate("Source Account No");
                end;

                // ShareCapitalTransfer."CRM Application No." := crm_application_no.AsValue.AsText;
                ShareCapitalTransfer."CRM Notes" := crm_notes.AsValue.AsText;
                ShareCapitalTransfer."CRM Originating Branch" := crm_originating_branch.AsValue.AsText;
                ShareCapitalTransfer."CRM Created By" := crm_created_by.AsValue.AsText;

                if crm_created_by.AsValue.AsText = '' then begin
                    Error('ERR_401. Invalid application. Origination NOT accepted!');
                end;

                ShareCapitalTransfer."Source Mobile Number" := SellerMember."Phone No.";
                ShareCapitalTransfer.Status := ShareCapitalTransfer.Status::Open;

                // CRM - No Series
                // SeriesSetup.TestField(SeriesSetup."CRM - Share Transfer Reqs");
                // NoSeriesMgt.InitSeries(SeriesSetup."CRM - Share Transfer Reqs", SeriesSetup."CRM - Share Transfer Reqs", 0D, CRMNewNo, CRMNewNoSeriesCode);

                // ShareCapitalTransfer."CRM Application No." := CRMNewNo;
                // ShareCapitalTransfer."CRM No. Series" := CRMNewNoSeriesCode;

                ShareCapitalTransfer."Reference No" := receipt_number.AsValue.AsText;

                CashTrans.Reset;
                CashTrans.SetRange(No, receipt_number.AsValue.AsText);
                if CashTrans.FindFirst then begin
                    if CashTrans.Posted <> true then begin
                        Error('Receipt number %1 is unposted!', receipt_number.AsValue.AsText);
                    end;
                    if CashTrans.Type <> CashTrans.Type::"Credit Receipt" then begin
                        Error('Invalid. Receipt number %1 is of type %2', receipt_number.AsValue.AsText, CashTrans.Type);
                    end;
                end else begin
                    Error('Receipt number %1 does not exist!', receipt_number.AsValue.AsText);
                end;
                ShareCapitalTransfer.Validate("Reference No");

                IF ShareCapitalTransfer.Insert(true) then begin
                    ShareCapitalTransfer."CRM Application No." := ShareCapitalTransfer."Document No";
                    ShareCapitalTransfer."CRM No. Series" := ShareCapitalTransfer."No. Series";
                    ShareCapitalTransfer.Modify;
                    // CRM Comments/Notes
                    // GlobalFunctions.InsertCommentRecord(
                    //     ShareCapitalTransfer."Document No",
                    //     crm_notes.AsValue.AsText,
                    //     crm_created_by.AsValue.AsText,
                    //     ShareCapitalTransfer."Global Dimension 1 Code",
                    //     ShareCapitalTransfer."Global Dimension 2 Code",
                    //     '',
                    //     false
                    // );

                    if crm_notes.AsValue.AsText <> '' then begin
                        Comment.Init;

                        Comment."Loan No." := ShareCapitalTransfer."Document No";
                        Comment.Comment := crm_notes.AsValue.AsText;
                        Comment.Appraiser := crm_created_by.AsValue.AsText;
                        Comment."Entry Date" := Today;
                        Comment."Entry Time" := Time;
                        Comment.Commented := true;

                        Comment.Insert(false);
                    end;

                    // Buyer lines
                    for Index := 0 to (buyer_list.AsArray.Count - 1) do begin
                        buyer_list.AsArray.Get(Index, buyer);

                        buyer.AsObject.Get('member_number', buyer_member_number);
                        buyer.AsObject.Get('transfer_amount', buyer_transfer_amount);

                        ShareCapitalTransferLine.Init;

                        ShareCapitalTransferLine."Document No." := ShareCapitalTransfer."Document No";
                        ShareCapitalTransferLine."Destination Member No" := buyer_member_number.AsValue.AsText;
                        ShareCapitalTransferLine.Validate("Destination Member No");
                        // BuyerMember.Reset();
                        // BuyerMember.SetRange("No.", buyer_member_number.AsValue.AsText);
                        // ShareCapitalTransferLine."Destination Member Name" := BuyerMember.Name;
                        // ShareCapitalTransferLine."Mobile No" := BuyerMember."Phone No.";
                        // ShareCapitalTransferLine."ID No" := BuyerMember."Primary Identification";

                        // BuyerMemberAccount.Reset();
                        // BuyerMemberAccount.SetRange("Member No.", BuyerMember."No.");
                        // BuyerMemberAccount.SetRange("Product Category", Format(ProductCategory::"Transfered Share Capital"));
                        // ShareCapitalTransferLine."Account No" := BuyerMemberAccount."No.";

                        ShareCapitalTransferLine."Allocation Amount" := buyer_transfer_amount.AsValue.AsDecimal;

                        KeyExists := ShareCapitalTransferLine.Insert;

                        ShareCapitalTransferLine.Reset;
                    end;

                    EDMSFunctions.EDMSScannedLog(
                        ShareCapitalTransfer."Document No",
                        "CRM Originations"::"Share Transfer",
                        ShareCapitalTransfer."Source Member No",
                        ShareCapitalTransfer."CRM Created By",
                        ShareCapitalTransfer."CRM Originating Branch"
                    );

                    // Handle CRM branch assigmnent
                    ShareCapitalTransfer."Global Dimension 1 Code" := GlobalFunctions.GetBranchCodeFromCRMOrigination(ShareCapitalTransfer."CRM Originating Branch");
                    ShareCapitalTransfer.Modify;

                    ShareCapitalTransfer.Reset();

                    ShareCapitalTransfer.SetRange("Document No", NewNo);
                    ResponseData.Add('application_number', ShareCapitalTransfer."Document No");
                    ResponseData.Add('application_status', Format(ShareCapitalTransfer.Status));

                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('description', 'Share capital transfer application with CRM application number ' + ShareCapitalTransfer."Document No" + ' has been created successfully.');
                    ResponseObject.Add('data', ResponseData);
                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                end else begin
                    // ResponseObject.Add('status', 'ERROR');
                    // ResponseObject.Add('description', 'Unable to create share capital transfer application.');
                    // ResponseObject.Add('errors', Errors);
                    // AddDateTimeToResponse(ResponseObject);

                    // ResponseObject.WriteTo(Response);

                    Error('Unable to create share capital transfer application.');
                end;

            end else begin
                Error('Expecting buyer_list value to be an array/list data type');
            end;
        end else begin
            Error('Unknown seller member with member number = %1', seller_member_number.asValue.AsText);
        end;

        exit(Response);
    end;

    local procedure UpdateSharesTransferRequest(Payload: JsonObject): Text
    var
        application_no: JsonToken;
        seller_member_number: JsonToken;
        buyer_list: JsonToken;
        buyer: JsonToken;
        buyer_member_number: JsonToken;
        buyer_transfer_amount: JsonToken;
        receipt_number: JsonToken;
        crm_application_no: JsonToken;
        crm_notes: JsonToken;
        crm_created_by: JsonToken;
        crm_originating_branch: JsonToken;

        KeyExists: Boolean;

        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        NewNo: Code[20];
        NewNoSeriesCode: Code[20];
        // CRMNewNo: Code[20];
        // CRMNewNoSeriesCode: Code[20];

        SellerMember: Record Members;
        SellerMemberAccount: Record "Savings Accounts";
        BuyerMember: Record Members;
        BuyerMemberAccount: Record "Savings Accounts";
        ProductCategory: enum "Product Categories";
        ShareCapitalTransfer: Record "Share Capital Transfer Buffer";
        ShareCapitalTransferLine: Record "Share Capital Transfer Lines";
        CashTrans: Record "Cashier Transactions";
        Comment: Record "Loan Appraisal Comments";
        Index: Integer;
        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        KeyExists := Payload.Get('application_no', application_no);
        KeyExists := Payload.Get('seller_member_number', seller_member_number);
        KeyExists := Payload.Get('buyer_list', buyer_list);
        KeyExists := Payload.Get('receipt_number', receipt_number);
        KeyExists := Payload.Get('crm_application_no', crm_application_no);
        KeyExists := Payload.Get('crm_notes', crm_notes);
        KeyExists := Payload.Get('crm_created_by', crm_created_by);
        KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);

        SellerMember.Reset;

        SellerMember.SetRange("No.", seller_member_number.asValue.AsText);

        IF SellerMember.FindFirst then begin
            IF buyer_list.IsArray then begin
                IF buyer_list.AsArray.Count <= 0 then begin
                    Error('Expecting at least one member to transfer shares to.');
                end;

                // Share Capital Transfer
                ShareCapitalTransfer.Reset;

                ShareCapitalTransfer.SetRange("Document No", application_no.AsValue.AsText);
                ShareCapitalTransfer.SetRange("Sent Back to CRM", true);

                if ShareCapitalTransfer.FindFirst then begin
                    SellerMemberAccount.Reset;
                    SellerMemberAccount.SetRange("Product Category", SellerMemberAccount."Product Category"::"Share Capital");
                    SellerMemberAccount.SetRange("Member No.", SellerMember."No.");
                    IF SellerMemberAccount.FindFirst then begin
                        ShareCapitalTransfer."Source Account No" := SellerMemberAccount."No.";
                        ShareCapitalTransfer.Validate("Source Account No");
                    end;

                    // ShareCapitalTransfer."CRM Application No." := crm_application_no.AsValue.AsText;
                    ShareCapitalTransfer."CRM Notes" := crm_notes.AsValue.AsText;
                    ShareCapitalTransfer."CRM Originating Branch" := crm_originating_branch.AsValue.AsText;
                    // ShareCapitalTransfer."CRM Created By" := crm_created_by.AsValue.AsText;

                    ShareCapitalTransfer."Source Mobile Number" := SellerMember."Phone No.";
                    ShareCapitalTransfer.Status := ShareCapitalTransfer.Status::Open;

                    ShareCapitalTransfer."Sent Back to CRM" := false;

                    ShareCapitalTransfer."Reference No" := receipt_number.AsValue.AsText;
                    CashTrans.Reset;
                    CashTrans.SetRange(No, receipt_number.AsValue.AsText);
                    if CashTrans.FindFirst then begin
                        if CashTrans.Posted <> true then begin
                            Error('Receipt number %1 is unposted!', receipt_number.AsValue.AsText);
                        end;
                        if CashTrans.Type <> CashTrans.Type::"Credit Receipt" then begin
                            Error('Invalid. Receipt number %1 is of type %2', receipt_number.AsValue.AsText, CashTrans.Type);
                        end;
                    end else begin
                        Error('Receipt number %1 does not exist!', receipt_number.AsValue.AsText);
                    end;
                    ShareCapitalTransfer.Validate("Reference No");

                    IF ShareCapitalTransfer.Modify(true) then begin
                        // CRM Comments/Notes
                        // GlobalFunctions.InsertCommentRecord(
                        //     ShareCapitalTransfer."Document No",
                        //     crm_notes.AsValue.AsText,
                        //     crm_created_by.AsValue.AsText,
                        //     ShareCapitalTransfer."Global Dimension 1 Code",
                        //     ShareCapitalTransfer."Global Dimension 2 Code",
                        //     '',
                        //     false
                        // );
                        if crm_notes.AsValue.AsText <> '' then begin
                            Comment.Init;

                            Comment."Loan No." := ShareCapitalTransfer."Document No";
                            Comment.Comment := crm_notes.AsValue.AsText;
                            Comment.Appraiser := crm_created_by.AsValue.AsText;
                            Comment."Entry Date" := Today;
                            Comment."Entry Time" := Time;
                            Comment.Commented := true;

                            Comment.Insert(false);
                        end;

                        // Buyer lines
                        ShareCapitalTransferLine.Reset();

                        ShareCapitalTransferLine.SetRange("Document No.", ShareCapitalTransfer."Document No");

                        if ShareCapitalTransferLine.FindSet then begin
                            repeat begin
                                KeyExists := ShareCapitalTransferLine.Delete(true);
                            end until ShareCapitalTransferLine.Next = 0;
                        end;

                        for Index := 0 to (buyer_list.AsArray.Count - 1) do begin
                            buyer_list.AsArray.Get(Index, buyer);

                            buyer.AsObject.Get('member_number', buyer_member_number);
                            buyer.AsObject.Get('transfer_amount', buyer_transfer_amount);

                            Clear(ShareCapitalTransferLine);

                            ShareCapitalTransferLine.Init;

                            ShareCapitalTransferLine."Document No." := ShareCapitalTransfer."Document No";
                            ShareCapitalTransferLine."Destination Member No" := buyer_member_number.AsValue.AsText;
                            ShareCapitalTransferLine.Validate("Destination Member No");
                            // BuyerMember.Reset();
                            // BuyerMember.SetRange("No.", buyer_member_number.AsValue.AsText);
                            // ShareCapitalTransferLine."Destination Member Name" := BuyerMember.Name;
                            // ShareCapitalTransferLine."Mobile No" := BuyerMember."Phone No.";
                            // ShareCapitalTransferLine."ID No" := BuyerMember."Primary Identification";

                            // BuyerMemberAccount.Reset();
                            // BuyerMemberAccount.SetRange("Member No.", BuyerMember."No.");
                            // BuyerMemberAccount.SetRange("Product Category", Format(ProductCategory::"Transfered Share Capital"));
                            // ShareCapitalTransferLine."Account No" := BuyerMemberAccount."No.";

                            ShareCapitalTransferLine."Allocation Amount" := buyer_transfer_amount.AsValue.AsDecimal;

                            KeyExists := ShareCapitalTransferLine.Insert;

                            ShareCapitalTransferLine.Reset;
                        end;

                        // Handle CRM branch assigmnent
                        ShareCapitalTransfer."Global Dimension 1 Code" := GlobalFunctions.GetBranchCodeFromCRMOrigination(ShareCapitalTransfer."CRM Originating Branch");
                        ShareCapitalTransfer.Modify;

                        ShareCapitalTransfer.Reset();

                        ShareCapitalTransfer.SetRange("Document No", NewNo);
                        ResponseData.Add('application_number', ShareCapitalTransfer."Document No");
                        ResponseData.Add('application_status', Format(ShareCapitalTransfer.Status));

                        ResponseObject.Add('status', 'SUCCESS');
                        ResponseObject.Add('description', 'Share capital transfer application with CRM application number ' + ShareCapitalTransfer."Document No" + ' has been updated successfully.');
                        ResponseObject.Add('data', ResponseData);
                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                    end else begin
                        Error('Unable to edit share capital transfer application.');
                    end;
                end else begin
                    Error('Share capital transfer request with the number %1 is NOT available for editing', application_no.AsValue.AsText);
                end;
            end else begin
                Error('Expecting buyer_list value to be an array/list data type');
            end;
        end else begin
            Error('Unknown seller member with member number = %1', seller_member_number.asValue.AsText);
        end;

        exit(Response);
    end;

    local procedure GetSharesTransferRequests(Payload: JsonObject): Text
    var
        filter_property: JsonToken;
        filter_value: JsonToken;
        start_date: JsonToken;
        end_date: JsonToken;
        page_number: JsonToken;
        page_size: JsonToken;
        crm_branch: JsonToken;

        KeyExists: Boolean;

        ShareCapitalTransfer: Record "Share Capital Transfer Buffer";
        SLA: record "Defined SLA";
        Comment: record "Comments";
        ApplicationTrails: record "Approval Entry";

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;
        Count: Integer;
        FirstRow: Integer;
        LastRow: Integer;
        TotalFoundRecords: Integer;
        SearchString: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        KeyExists := Payload.Get('filter_property', filter_property);
        KeyExists := Payload.Get('filter_value', filter_value);
        KeyExists := Payload.Get('start_date', start_date);
        KeyExists := Payload.Get('end_date', end_date);
        KeyExists := Payload.Get('crm_branch', crm_branch);
        Payload.Get('page_number', page_number);
        Payload.Get('page_size', page_size);

        ShareCapitalTransfer.Reset;
        ShareCapitalTransfer.SetCurrentKey("Document No");
        ShareCapitalTransfer.SetAscending("Document No", false);

        if KeyExists then begin
            if (crm_branch.AsValue.AsText <> 'ALL') then begin
                ShareCapitalTransfer.SetRange(ShareCapitalTransfer."CRM Originating Branch", crm_branch.AsValue.AsText);
            end;
        end;

        // Search Value
        if (not filter_property.AsValue.IsNull) and (not filter_value.AsValue.IsNull) then begin
            if (filter_property.AsValue.AsText <> '') and (filter_value.AsValue.AsText <> '') then begin
                SearchString := filter_value.AsValue.AsText;

                case filter_property.AsValue.AsText of
                    'application_no':
                        ShareCapitalTransfer.SetRange(ShareCapitalTransfer."Document No", SearchString);
                    'crm_application_no':
                        ShareCapitalTransfer.SetRange(ShareCapitalTransfer."CRM Application No.", SearchString);
                    'source_member_no':
                        ShareCapitalTransfer.SetRange(ShareCapitalTransfer."Source Member No", SearchString);
                    'source_mobile_number':
                        ShareCapitalTransfer.SetRange(ShareCapitalTransfer."Source Mobile Number", SearchString);
                    'status':
                        ShareCapitalTransfer.SetFilter(ShareCapitalTransfer.Status, SearchString);
                    else
                        ShareCapitalTransfer.SetRange(ShareCapitalTransfer."Document No", SearchString);
                end;
            end;
        end;

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                // ShareCapitalTransfer.SetRange("Application Date", '>=%1&<=%2', StartDate, EndDate);
            end;
        end;

        IF ShareCapitalTransfer.FindSet then begin
            // Data found
            Count := 0;
            FirstRow := ((page_number.AsValue.AsInteger - 1) * page_size.AsValue.AsInteger) + 1;
            LastRow := page_number.AsValue.AsInteger * page_size.AsValue.AsInteger;

            TotalFoundRecords := ShareCapitalTransfer.Count;

            repeat begin
                Count += 1;

                if (Count >= FirstRow) and (Count <= LastRow) then begin
                    ShareCapitalTransfer.CalcFields("Responsible Officer", "Supervisor ID");

                    Datum.Add('application_no', ShareCapitalTransfer."Document No");

                    Datum.Add('receipt_number', ShareCapitalTransfer."Reference No");

                    Datum.Add('source_account_no', ShareCapitalTransfer."Source Account No");
                    Datum.Add('source_member_name', ShareCapitalTransfer."Source Member Name");
                    Datum.Add('source_member_no', ShareCapitalTransfer."Source Member No");
                    Datum.Add('source_account_balance', ShareCapitalTransfer."Source Balance");
                    Datum.Add('source_mobile_number', ShareCapitalTransfer."Source Mobile Number");

                    Datum.Add('crm_application_no', ShareCapitalTransfer."CRM Application No.");
                    Datum.Add('crm_created_by', ShareCapitalTransfer."CRM Created By");
                    Datum.Add('crm_originating_branch', ShareCapitalTransfer."CRM Originating Branch");
                    Datum.Add('status', Format(ShareCapitalTransfer.Status));
                    Datum.Add('application_date', GlobalFunctions.FormatISODate(ShareCapitalTransfer."Application Date"));

                    Datum.Add('activity_code', ShareCapitalTransfer."Global Dimension 2 Code");
                    Datum.Add('branch_code', ShareCapitalTransfer."Global Dimension 1 Code");
                    Datum.Add('posted', ShareCapitalTransfer.Posted);
                    Datum.Add('is_sent_back_to_crm', ShareCapitalTransfer."Sent Back to CRM");

                    ApplicationTrails.Reset;

                    ApplicationTrails.SetRange("Document No.", ShareCapitalTransfer."Document No");

                    if ApplicationTrails.FindLast then begin
                        Datum.Add('responsible_officer', ApplicationTrails."Sender ID");
                        Datum.Add('supervisor_id', ApplicationTrails."Approver ID");
                    end else begin
                        Datum.Add('responsible_officer', ShareCapitalTransfer."Responsible Officer");
                        Datum.Add('supervisor_id', ShareCapitalTransfer."Supervisor ID");
                    end;

                    // SLA
                    WorkDays := 0;
                    SLADays := 0;
                    DelayDays := 0;
                    StatusComment := '';

                    SLA.reset();
                    SLA.SetRange("Origination Type", SLA."Origination Type"::"Institutional Capital");
                    if SLA.findfirst() then
                        SLADays := SLA.SLA;

                    if (ShareCapitalTransfer."Posting Date" <> 0D) and (ShareCapitalTransfer."Application Date" <> 0D) and (ShareCapitalTransfer."Application Time" <> 0T) and (ShareCapitalTransfer."Posting Time" <> 0T) then begin
                        Globalfunctions.HoursBetweenPeriods(ShareCapitalTransfer."Application Date", ShareCapitalTransfer."Application Time", ShareCapitalTransfer."Posting Date", ShareCapitalTransfer."Posting Time", Duration, WokedOnANonWorkingPeriod);
                        WorkDays := Duration;
                        DelayDays := WorkDays - (SLADays / 3);
                        IF DelayDays < 0 then DelayDays := 0;
                    end;

                    Comment.reset();
                    Comment.SetRange("Header No.", ShareCapitalTransfer."Document No");
                    If Comment.FindLast() then begin
                        StatusComment := Comment.Comment;
                    end;

                    Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
                    Datum.Add('SLA_days', Format(SLADays));
                    Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
                    Datum.Add('tat_status', Format(TAtStatus));
                    Datum.Add('status_comment', StatusComment);
                    Datum.Add('priority', Format(Priority));

                    Data.Add(Datum);
                    // Reset
                    Datum.ReadFrom('{}');
                end;
            end until (Count = LastRow) or (ShareCapitalTransfer.Next = 0);

            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetSharesTransferRequest(Payload: JsonObject): Text
    var
        application_number: JsonToken;

        ShareCapitalTransfer: Record "Share Capital Transfer Buffer";
        ShareCapitalTransferLine: Record "Share Capital Transfer Lines";
        ApplicationComments: Record "Loan Appraisal Comments";

        Comments: JsonArray;
        Comment: JsonObject;
        Buyers: JsonArray;
        Buyer: JsonObject;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('application_number', application_number);

        ShareCapitalTransfer.Reset;
        ShareCapitalTransfer.SetRange("Document No", application_number.AsValue.AsText);

        IF ShareCapitalTransfer.FindFirst() then begin
            ShareCapitalTransfer.CalcFields("Responsible Officer", "Supervisor ID");

            Datum.Add('application_no', ShareCapitalTransfer."Document No");

            Datum.Add('receipt_number', ShareCapitalTransfer."Reference No");

            Datum.Add('seller_member_number', ShareCapitalTransfer."Source Member No");

            Datum.Add('source_account_no', ShareCapitalTransfer."Source Account No");
            Datum.Add('source_member_name', ShareCapitalTransfer."Source Member Name");
            Datum.Add('source_member_no', ShareCapitalTransfer."Source Member No");
            Datum.Add('source_account_balance', ShareCapitalTransfer."Source Balance");
            Datum.Add('source_mobile_number', ShareCapitalTransfer."Source Mobile Number");

            Datum.Add('crm_application_no', ShareCapitalTransfer."CRM Application No.");
            Datum.Add('crm_created_by', ShareCapitalTransfer."CRM Created By");
            Datum.Add('crm_notes', ShareCapitalTransfer."CRM Notes");
            Datum.Add('crm_originating_branch', ShareCapitalTransfer."CRM Originating Branch");
            Datum.Add('status', Format(ShareCapitalTransfer.Status));
            Datum.Add('status_desc', Format(ShareCapitalTransfer.Status));
            Datum.Add('application_date', GlobalFunctions.FormatISODate(ShareCapitalTransfer."Application Date"));

            Datum.Add('activity_code', ShareCapitalTransfer."Global Dimension 2 Code");
            Datum.Add('branch_code', ShareCapitalTransfer."Global Dimension 1 Code");
            Datum.Add('posted', ShareCapitalTransfer.Posted);
            Datum.Add('is_sent_back_to_crm', ShareCapitalTransfer."Sent Back to CRM");

            Datum.Add('responsible_officer', ShareCapitalTransfer."Responsible Officer");
            Datum.Add('supervisor_id', ShareCapitalTransfer."Supervisor ID");

            ApplicationComments.Reset;

            ApplicationComments.SetRange("Loan No.", ShareCapitalTransfer."Document No");
            ApplicationComments.SetCurrentKey("Entry No.");
            ApplicationComments.SetAscending("Entry No.", false);

            if ApplicationComments.FindSet then begin
                repeat begin
                    Comment.Add('comment', ApplicationComments.Comment);
                    Comment.Add('commented_by', ApplicationComments.Appraiser);
                    Comment.Add('date_time', GlobalFunctions.FormatISODateTime(ApplicationComments.SystemCreatedAt));

                    Comment.Add('is_read', ApplicationComments.Commented);

                    Comments.Add(Comment);

                    // Reset
                    Comment.ReadFrom('{}');
                end until ApplicationComments.Next = 0;
            end;
            Datum.Add('comments', Comments);


            ShareCapitalTransferLine.Reset;
            ShareCapitalTransferLine.SetRange("Document No.", ShareCapitalTransfer."Document No");

            if ShareCapitalTransferLine.FindSet then begin
                repeat begin
                    Buyer.Add('no', ShareCapitalTransferLine.No);
                    Buyer.Add('document_no', ShareCapitalTransferLine."Document No.");
                    Buyer.Add('member_number', ShareCapitalTransferLine."Destination Member No");
                    Buyer.Add('member_name', ShareCapitalTransferLine."Destination Member Name");
                    Buyer.Add('account_number', ShareCapitalTransferLine."Account No");
                    Buyer.Add('mobile_no', ShareCapitalTransferLine."Mobile No");
                    Buyer.Add('transfer_amount', ShareCapitalTransferLine."Allocation Amount");
                    Buyer.Add('date', ShareCapitalTransferLine."Application Date");

                    Buyers.Add(Buyer);

                    // Reset
                    Buyer.ReadFrom('{}');
                end until ShareCapitalTransferLine.Next = 0;
            end;

            Datum.Add('buyer_list', Buyers);

            Datum.Add('created_at', ShareCapitalTransfer.SystemCreatedAt);
            Datum.Add('modified_at', ShareCapitalTransfer.SystemModifiedAt);
        end else begin
            Error('Share transfer request application with number %1 NOT found.', application_number.AsValue.AsText);
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure SearchDelegates(Payload: JsonObject): Text
    var
        filter_property: JsonToken;
        filter_value: JsonToken;

        KeyExists: Boolean;

        SearchMembers: Record Members;
        SearchDelegate: Record "Delegate Officials";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        KeyExists := Payload.Get('filter_property', filter_property); // phone_number, primary_identification, email_address, kra_pin_number, pf_number
        KeyExists := Payload.Get('filter_value', filter_value);

        SearchMembers.Reset;

        if (not filter_property.AsValue.IsNull) and (not filter_value.AsValue.IsNull) then begin
            if (filter_property.AsValue.AsText <> '') and (filter_value.AsValue.AsText <> '') then begin
                case filter_property.AsValue.AsText of
                    'phone_number':
                        SearchMembers.SetRange("Phone No.", filter_value.AsValue.AsText);
                    'id_number':
                        begin
                            SearchMembers.SetRange("Primary Identification Type", SearchMembers."Primary Identification Type"::"ID Number");
                            SearchMembers.SetRange("Primary Identification", filter_value.AsValue.AsText);

                            if not SearchMembers.FindFirst then begin
                                SearchMembers.Reset;
                                SearchMembers.SetRange("Secondary Identification Type", SearchMembers."Secondary Identification Type"::"ID Number");
                                SearchMembers.SetRange("Secondary Identification", filter_value.AsValue.AsText);
                            end;
                        end;
                    'passport_number':
                        begin
                            SearchMembers.SetRange("Primary Identification Type", SearchMembers."Primary Identification Type"::"Passport No");
                            SearchMembers.SetRange("Primary Identification", filter_value.AsValue.AsText);

                            if not SearchMembers.FindFirst then begin
                                SearchMembers.Reset;
                                SearchMembers.SetRange("Secondary Identification Type", SearchMembers."Secondary Identification Type"::"Passport No");
                                SearchMembers.SetRange("Secondary Identification", filter_value.AsValue.AsText);
                            end;
                        end;
                    'payroll_number':
                        SearchMembers.SetRange("Payroll/Staff No.", filter_value.AsValue.AsText);
                    'email_address':
                        SearchMembers.SetRange("E-Mail", filter_value.AsValue.AsText);
                    'membership_number':
                        SearchMembers.SetRange("No.", filter_value.AsValue.AsText);
                    else
                        SearchMembers.SetRange("No.", filter_value.AsValue.AsText);
                end;

                IF SearchMembers.FindSet then begin
                    repeat begin
                        SearchDelegate.Reset;
                        SearchDelegate.SetRange("Member Number", SearchMembers."No.");

                        IF SearchDelegate.FindSet then begin
                            repeat begin
                                SearchDelegate.CalcFields("Delegate Official Name", "Electoral Zone Name", "ID No.");

                                Datum.Add('member_number', SearchDelegate."Member Number");
                                Datum.Add('id_number', SearchDelegate."ID No.");
                                Datum.Add('official_name', SearchDelegate."Delegate Official Name");

                                Datum.Add('electoral_zone', SearchDelegate."Electoral Zone");
                                Datum.Add('electoral_zone_name', SearchDelegate."Electoral Zone Name");
                                Datum.Add('position', SearchDelegate.Position);
                                Datum.Add('appointment_date', SearchDelegate."Appointment Date");
                                Datum.Add('expiry_date', SearchDelegate."Expiry Date");
                                Datum.Add('status', Format(SearchDelegate.Status));
                                Datum.Add('is_retired', SearchDelegate.Retired);

                                Data.Add(Datum);

                                // Reset
                                Datum.ReadFrom('{}');
                            end until SearchDelegate.Next = 0;
                        end;
                    end until SearchMembers.Next = 0;
                end else begin
                    Error('Delegate(s) with identification %1 = %2 NOT found.', filter_property.AsValue.AsText, filter_value.AsValue.AsText);
                end;
            end;
        end else begin
            SearchDelegate.Reset;

            IF SearchDelegate.FindSet then begin
                repeat begin
                    SearchDelegate.CalcFields("Delegate Official Name", "Electoral Zone Name", "ID No.");

                    Datum.Add('member_number', SearchDelegate."Member Number");
                    Datum.Add('id_number', SearchDelegate."ID No.");
                    Datum.Add('official_name', SearchDelegate."Delegate Official Name");

                    Datum.Add('electoral_zone', SearchDelegate."Electoral Zone");

                    Datum.Add('electoral_zone_name', SearchDelegate."Electoral Zone Name");
                    Datum.Add('position', SearchDelegate.Position);
                    Datum.Add('appointment_date', SearchDelegate."Appointment Date");
                    Datum.Add('expiry_date', SearchDelegate."Expiry Date");
                    Datum.Add('status', Format(SearchDelegate.Status));
                    Datum.Add('is_retired', SearchDelegate.Retired);

                    Data.Add(Datum);

                    // Reset
                    Datum.ReadFrom('{}');
                end until SearchDelegate.Next = 0;
            end;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    // SMS
    local procedure QueueSMS(Payload: JsonObject): Text
    var
        SkySMS: CodeUnit SendSms;
        Source: enum "SMS Source";

        phone_number: JsonToken;
        sms: JsonToken;
        crm_reference: JsonToken;

        KeyExists: Boolean;
        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        // Source: enum "SMS Source"; 
        // Telephone: Text[200]; 
        // Textsms: Text; 
        // Reference: Text[30]; 
        // AccNo: Text[30]; 
        // Chargeable: Boolean; 
        // Priority: Integer; 
        // ChargeMember: Boolean; 
        // RequestApplication: Text[30]; 
        // RequestCorrelationID: Text[50]; 
        // SourceApplication: Text[30]

        KeyExists := Payload.Get('phone_number', phone_number);
        KeyExists := Payload.Get('sms', sms);
        KeyExists := Payload.Get('crm_reference', crm_reference);

        SkySMS.SendSms(
            Source::CRM,
            phone_number.AsValue.AsText,
            sms.AsValue.AsText,
            GlobalFunctions.CleanGuid(),
            '',
            false,
            0,
            false,
            'CRM',
            crm_reference.AsValue.AsText,
            'CRM'
        );

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'SMS has been queued successfully!');
        ResponseObject.Add('data', ResponseData);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetSMSes(Payload: JsonObject): Text
    var
        filter_property: JsonToken;
        filter_value: JsonToken;
        start_date: JsonToken;
        end_date: JsonToken;
        page_number: JsonToken;
        page_size: JsonToken;

        KeyExists: Boolean;

        SkySMSMessages: Record "Sky SMS Messages";

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;
        Count: Integer;
        FirstRow: Integer;
        LastRow: Integer;
        TotalFoundRecords: Integer;
        SearchString: Text;
        SMSSource: enum "SMS Source";

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        KeyExists := Payload.Get('filter_property', filter_property);
        KeyExists := Payload.Get('filter_value', filter_value);
        KeyExists := Payload.Get('start_date', start_date);
        KeyExists := Payload.Get('end_date', end_date);
        Payload.Get('page_number', page_number);
        Payload.Get('page_size', page_size);

        SkySMSMessages.Reset;
        SkySMSMessages.SetCurrentKey(msg_status_date);
        SkySMSMessages.SetAscending(msg_status_date, false);

        // Search Value
        if (not filter_property.AsValue.IsNull) and (not filter_value.AsValue.IsNull) then begin
            if (filter_property.AsValue.AsText <> '') and (filter_value.AsValue.AsText <> '') then begin
                SearchString := filter_value.AsValue.AsText;

                case filter_property.AsValue.AsText of
                    'sender':
                        SkySMSMessages.SetRange(SkySMSMessages.sender, SearchString);
                    'receiver':
                        SkySMSMessages.SetRange(SkySMSMessages.receiver, SearchString);
                end;
            end;
        end;

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                SkySMSMessages.SetFilter("SMS Date", '>=%1&<=%2', StartDate, EndDate);
            end;
        end;

        SkySMSMessages.SetRange("Source", SMSSource::CRM);

        IF SkySMSMessages.FindSet then begin
            // Data found
            Count := 0;
            FirstRow := ((page_number.AsValue.AsInteger - 1) * page_size.AsValue.AsInteger) + 1;
            LastRow := page_number.AsValue.AsInteger * page_size.AsValue.AsInteger;

            TotalFoundRecords := SkySMSMessages.Count;

            repeat begin
                Count += 1;

                if (Count >= FirstRow) and (Count <= LastRow) then begin
                    Datum.Add('msg', SkySMSMessages.msg);
                    Datum.Add('sender', SkySMSMessages.sender);
                    Datum.Add('receiver', SkySMSMessages.receiver);
                    Datum.Add('msg_type', SkySMSMessages.msg_type);
                    Datum.Add('msg_category', SkySMSMessages.msg_category);
                    Datum.Add('msg_priority', SkySMSMessages.msg_priority);
                    Datum.Add('msg_status_date', GlobalFunctions.FormatISODateTime(SkySMSMessages.msg_status_date));

                    Data.Add(Datum);
                    // Reset
                    Datum.ReadFrom('{}');
                end;
            end until (Count = LastRow) or (SkySMSMessages.Next = 0);

            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetApplicationTrail(Payload: JsonObject): Text
    var
        application_no: JsonToken;

        ApplicationTrails: Record "Approval Entry";
        CRMMemberEdit: Record "CRM Member Edit";
        SystemEdit: Record "System Edits";

        MWNotice: Record "Member withdrawal Notice";
        MClosure: Record "Membership Closure";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('application_no', application_no);

        ApplicationTrails.Reset;

        CRMMemberEdit.Reset;
        CRMMemberEdit.SetRange("No.", application_no.AsValue.AsText);
        if CRMMemberEdit.FindFirst then begin
            SystemEdit.Reset;
            SystemEdit.SetRange("CRM No", CRMMemberEdit."No.");
            if SystemEdit.FindFirst then begin
                ApplicationTrails.SetRange("Document No.", SystemEdit."No.");
            end else begin
                ApplicationTrails.SetRange("Document No.", application_no.AsValue.AsText);
            end;
        end else begin
            ApplicationTrails.SetRange("Document No.", application_no.AsValue.AsText);
        end;

        MWNotice.Reset;
        MWNotice.SetRange("No.", application_no.AsValue.AsText);
        if MWNotice.FindFirst then begin
            MClosure.Reset;
            MClosure.SetRange("Notice Number", MWNotice."No.");

            if MClosure.FindFirst then begin
                ApplicationTrails.Reset;

                ApplicationTrails.SetFilter("Document No.", '=%1|%2', application_no.AsValue.AsText, MClosure."No.");
            end;
        end;

        IF ApplicationTrails.FindSet then begin
            repeat begin
                Datum.Add('entry_no', ApplicationTrails."Entry No.");
                Datum.Add('document_no', ApplicationTrails."Document No.");
                Datum.Add('sequence_no', ApplicationTrails."Sequence No.");
                Datum.Add('approval_code', ApplicationTrails."Approval Code");
                Datum.Add('sender_id', ApplicationTrails."Sender ID");
                Datum.Add('approver_id', ApplicationTrails."Approver ID");
                Datum.Add('status', Format(ApplicationTrails.Status));
                Datum.Add('date_time_sent_for_approval', GlobalFunctions.FormatISODateTime(ApplicationTrails."Date-Time Sent for Approval"));
                Datum.Add('last_date_time_modified', GlobalFunctions.FormatISODateTime(ApplicationTrails."Last Date-Time Modified"));
                Datum.Add('last_modified_by_user_id', ApplicationTrails."Last Modified By User ID");
                Datum.Add('approval_due_date', GlobalFunctions.FormatISODate(ApplicationTrails."Due Date"));

                Datum.Add('created_at', GlobalFunctions.FormatISODateTime(ApplicationTrails.SystemCreatedAt));
                Datum.Add('modified_at', GlobalFunctions.FormatISODateTime(ApplicationTrails.SystemModifiedAt));

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until ApplicationTrails.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    // Mbanking whitelist
    // local procedure CreateMbankingWhitelistApplication(Payload: JsonObject): Text
    // var
    //     member_number: JsonToken;
    //     crm_created_by: JsonToken;
    //     crm_originating_branch: JsonToken;
    //     crm_notes: JsonToken;

    //     KeyExists: Boolean;

    //     EditMember: Record Members;
    //     CRMMbankingWhitelistApp: Record "M-Banking Whitelist App";
    //     ResponseObject: JsonObject;
    //     ResponseData: JsonObject;
    //     Errors: JsonArray;
    //     Response: Text;
    // begin
    //     KeyExists := Payload.Get('member_number', member_number);
    //     KeyExists := Payload.Get('crm_created_by', crm_created_by);
    //     KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);
    //     KeyExists := Payload.Get('crm_notes', crm_notes);

    //     EditMember.Reset();

    //     EditMember.SetRange("No.", member_number.asValue.AsText);

    //     IF EditMember.FindFirst then begin
    //         CRMMbankingWhitelistApp.Init();

    //         CRMMbankingWhitelistApp."Member No." := EditMember."No.";
    //         CRMMbankingWhitelistApp.Validate("Member No.");

    //         CRMMbankingWhitelistApp."CRM Created By" := crm_created_by.AsValue.AsText;
    //         CRMMbankingWhitelistApp."CRM Originating Branch" := crm_originating_branch.AsValue.AsText;
    //         CRMMbankingWhitelistApp."CRM Notes" := crm_notes.AsValue.AsText;

    //         if crm_created_by.AsValue.AsText = '' then begin
    //             Error('ERR_401. Invalid application. Origination NOT accepted!');
    //         end;

    //         CRMMbankingWhitelistApp.Status := CRMMbankingWhitelistApp.Status::Open;

    //         IF CRMMbankingWhitelistApp.Insert(true) then begin
    //             // Handle CRM branch assigmnent
    //             CRMMbankingWhitelistApp."Global Dimension 1 Code" := GlobalFunctions.GetBranchCodeFromCRMOrigination(CRMMbankingWhitelistApp."CRM Originating Branch");
    //             CRMMbankingWhitelistApp.Modify;

    //             // CRM Comments/Notes
    //             GlobalFunctions.InsertCommentRecord(
    //                 CRMMbankingWhitelistApp."No.",
    //                 crm_notes.AsValue.AsText,
    //                 crm_created_by.AsValue.AsText,
    //                 CRMMbankingWhitelistApp."Global Dimension 1 Code",
    //                 CRMMbankingWhitelistApp."Global Dimension 2 Code",
    //                 '',
    //                 false
    //             );

    //             EDMSFunctions.EDMSScannedLog(
    //                 CRMMbankingWhitelistApp."No.",
    //                 "CRM Originations"::"M-Hela Whitelist Application",
    //                 CRMMbankingWhitelistApp."Member No.",
    //                 CRMMbankingWhitelistApp."CRM Created By",
    //                 CRMMbankingWhitelistApp."CRM Originating Branch"
    //             );

    //             ResponseData.Add('application_status', Format(CRMMbankingWhitelistApp.Status));
    //             ResponseData.Add('application_number', CRMMbankingWhitelistApp."No.");

    //             ResponseObject.Add('status', 'SUCCESS');
    //             ResponseObject.Add('description', 'Mobile banking whitelist application with CRM application number ' + CRMMbankingWhitelistApp."No." + ' has been created successfully.');
    //             ResponseObject.Add('data', ResponseData);
    //             AddDateTimeToResponse(ResponseObject);

    //             ResponseObject.WriteTo(Response);
    //         end else begin
    //             Error('Unable to create mobile banking whitelist application.');
    //         end;
    //     end else begin
    //         Error('Unknown member with member number = %1', member_number.asValue.AsText);
    //     end;

    //     exit(Response);
    // end;

    // local procedure GetMemberWhitelistApplications(Payload: JsonObject): Text
    // var
    //     filter_property: JsonToken;
    //     filter_value: JsonToken;
    //     start_date: JsonToken;
    //     end_date: JsonToken;
    //     page_number: JsonToken;
    //     page_size: JsonToken;
    //     crm_branch: JsonToken;

    //     KeyExists: Boolean;

    //     CRMMbankingWhitelistApps: Record "M-Banking Whitelist App";
    //     SLA: record "Defined SLA";
    //     Comment: record Comments;

    //     WorkDays: duration;
    //     SLADays: duration;
    //     DelayDays: duration;
    //     StatusComment: Text;
    //     WokedOnANonWorkingPeriod: Boolean;
    //     Duration: duration;
    //     TAtStatus: Option open,closed;
    //     Priority: Option Urgent,High,Normal;

    //     StartDateTimeParts: List of [Text];
    //     StartDate: Date;
    //     EndDateTimeParts: List of [Text];
    //     EndDate: Date;
    //     Count: Integer;
    //     FirstRow: Integer;
    //     LastRow: Integer;
    //     TotalFoundRecords: Integer;
    //     SearchString: Text;

    //     ResponseObject: JsonObject;
    //     PaginationObject: JsonObject;
    //     Data: JsonArray;
    //     Datum: JsonObject;
    //     Response: Text;
    // begin
    //     KeyExists := Payload.Get('filter_property', filter_property);
    //     KeyExists := Payload.Get('filter_value', filter_value);
    //     KeyExists := Payload.Get('start_date', start_date);
    //     KeyExists := Payload.Get('end_date', end_date);
    //     KeyExists := Payload.Get('crm_branch', crm_branch);
    //     Payload.Get('page_number', page_number);
    //     Payload.Get('page_size', page_size);

    //     CRMMbankingWhitelistApps.Reset;
    //     CRMMbankingWhitelistApps.SetCurrentKey("Application Date");
    //     CRMMbankingWhitelistApps.SetAscending("Application Date", false);

    //     if KeyExists then begin
    //         if (crm_branch.AsValue.AsText <> 'ALL') then begin
    //             CRMMbankingWhitelistApps.SetRange(CRMMbankingWhitelistApps."CRM Originating Branch", crm_branch.AsValue.AsText);
    //         end;
    //     end;

    //     // Search Value
    //     if (not filter_property.AsValue.IsNull) and (not filter_value.AsValue.IsNull) then begin
    //         if (filter_property.AsValue.AsText <> '') and (filter_value.AsValue.AsText <> '') then begin
    //             SearchString := filter_value.AsValue.AsText;

    //             case filter_property.AsValue.AsText of
    //                 'application_no':
    //                     CRMMbankingWhitelistApps.SetRange(CRMMbankingWhitelistApps."No.", SearchString);
    //                 'member_no':
    //                     CRMMbankingWhitelistApps.SetRange(CRMMbankingWhitelistApps."Member No.", SearchString);
    //                 'status':
    //                     CRMMbankingWhitelistApps.SetFilter(CRMMbankingWhitelistApps.Status, SearchString);
    //                 else
    //                     CRMMbankingWhitelistApps.SetRange(CRMMbankingWhitelistApps."No.", SearchString);
    //             end;
    //             // Text fields
    //             // CRMMemberEdits.SetRange(CRMMemberEdits."No.", SearchString);
    //             // CRMMemberEdits.SetRange(CRMMemberEdits."Member No.", SearchString);
    //             // CRMMemberEdits.SetRange(CRMMemberEdits."Member Name", SearchString);
    //             // CRMMemberEdits.SetRange(CRMMemberEdits."CRM No.", SearchString);
    //         end;
    //     end;

    //     // Start Date & End Date
    //     if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
    //         if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
    //             StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
    //             EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

    //             Evaluate(StartDate, StartDateTimeParts.Get(1));
    //             Evaluate(EndDate, EndDateTimeParts.Get(1));

    //             CRMMbankingWhitelistApps.SetFilter("Application Date", '>=%1&<=%2', StartDate, EndDate);
    //         end;
    //     end;

    //     IF CRMMbankingWhitelistApps.FindSet then begin
    //         // Applications found
    //         Count := 0;
    //         FirstRow := ((page_number.AsValue.AsInteger - 1) * page_size.AsValue.AsInteger) + 1;
    //         LastRow := page_number.AsValue.AsInteger * page_size.AsValue.AsInteger;

    //         TotalFoundRecords := CRMMbankingWhitelistApps.Count;

    //         repeat begin
    //             Count += 1;

    //             if (Count >= FirstRow) and (Count <= LastRow) then begin
    //                 CRMMbankingWhitelistApps.CalcFields(
    //         "Responsible Officer",
    //         "Supervisor ID"
    //         );

    //                 Datum.Add('application_no', CRMMbankingWhitelistApps."No.");
    //                 Datum.Add('member_no', CRMMbankingWhitelistApps."Member No.");
    //                 Datum.Add('member_name', CRMMbankingWhitelistApps."Full Names");
    //                 Datum.Add('transactional_mobile_no', CRMMbankingWhitelistApps."Transactional Mobile No.");
    //                 Datum.Add('primary_identification_type', Format(CRMMbankingWhitelistApps."Primary Identification Type"));
    //                 Datum.Add('primary_identification', CRMMbankingWhitelistApps."Primary Identification");
    //                 Datum.Add('application_date', CRMMbankingWhitelistApps."Application Date");
    //                 Datum.Add('crm_created_by', CRMMbankingWhitelistApps."CRM Created By");
    //                 Datum.Add('crm_originating_branch', CRMMbankingWhitelistApps."CRM Originating Branch");
    //                 Datum.Add('responsible_officer', CRMMbankingWhitelistApps."Responsible Officer");
    //                 Datum.Add('supervisor_id', CRMMbankingWhitelistApps."Supervisor ID");
    //                 Datum.Add('status', Format(CRMMbankingWhitelistApps.Status));
    //                 Datum.Add('is_whitelisted', CRMMbankingWhitelistApps."Is Whitelisted");
    //                 Datum.Add('whitelist_reference', CRMMbankingWhitelistApps."Whitelist Reference ID");

    //                 // SLA
    //                 WorkDays := 0;
    //                 SLADays := 0;
    //                 DelayDays := 0;
    //                 StatusComment := '';

    //                 SLA.reset();
    //                 // SLA.SetRange("Origination Type", SLA."Origination Type"::"M-Hela Whitelist");
    //                 if SLA.findfirst() then
    //                     SLADays := SLA.SLA;

    //                 if (CRMMbankingWhitelistApps."Approval Date" <> 0D) and (CRMMbankingWhitelistApps."Application Date" <> 0D) and (CRMMbankingWhitelistApps."Application Time" <> 0T) and (CRMMbankingWhitelistApps."Approval Time" <> 0T) then begin
    //                     Globalfunctions.HoursBetweenPeriods(CRMMbankingWhitelistApps."Application Date", CRMMbankingWhitelistApps."Application Time", CRMMbankingWhitelistApps."Approval Date", CRMMbankingWhitelistApps."Approval Time", Duration, WokedOnANonWorkingPeriod);
    //                     WorkDays := Duration;
    //                     DelayDays := WorkDays - (SLADays / 3);
    //                     IF DelayDays < 0 then DelayDays := 0;
    //                 end;

    //                 Comment.reset();
    //                 Comment.SetRange("Header No.", CRMMbankingWhitelistApps."No.");
    //                 If Comment.FindLast() then begin
    //                     StatusComment := Comment.Comment;
    //                 end;


    //                 Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
    //                 Datum.Add('SLA_days', Format(SLADays));
    //                 Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
    //                 Datum.Add('tat_status', Format(TAtStatus));
    //                 Datum.Add('status_comment', StatusComment);
    //                 // Datum.Add('priority', Format(Priority));

    //                 Data.Add(Datum);
    //                 // Reset
    //                 Datum.ReadFrom('{}');
    //             end;
    //         end until (Count = LastRow) or (CRMMbankingWhitelistApps.Next = 0);

    //         PaginationObject.Add('page', page_number);
    //         PaginationObject.Add('page_size', page_size);
    //         PaginationObject.Add('total', TotalFoundRecords);
    //         PaginationObject.Add('data', Data);

    //         ResponseObject.Add('status', 'SUCCESS');
    //         ResponseObject.Add('description', 'Request is successful');
    //         ResponseObject.Add('data', PaginationObject);
    //         AddDateTimeToResponse(ResponseObject);
    //     end else begin
    //         PaginationObject.Add('page', page_number);
    //         PaginationObject.Add('page_size', page_size);
    //         PaginationObject.Add('total', TotalFoundRecords);
    //         PaginationObject.Add('data', Data);

    //         ResponseObject.Add('status', 'SUCCESS');
    //         ResponseObject.Add('description', 'Request is successful');
    //         ResponseObject.Add('data', PaginationObject);
    //         AddDateTimeToResponse(ResponseObject);
    //     end;

    //     ResponseObject.WriteTo(Response);

    //     exit(Response);
    // end;

    // local procedure GetMemberWhitelistApplication(Payload: JsonObject): Text
    // var
    //     application_number: JsonToken;

    //     CRMMbankingWhitelistApp: Record "M-Banking Whitelist App";
    //     ApplicationComments: Record Comments;

    //     Comments: JsonArray;
    //     Comment: JsonObject;

    //     ResponseObject: JsonObject;
    //     Datum: JsonObject;
    //     Response: Text;
    // begin
    //     Payload.Get('application_number', application_number);

    //     CRMMbankingWhitelistApp.Reset;
    //     CRMMbankingWhitelistApp.SetRange("No.", application_number.AsValue.AsText);

    //     IF CRMMbankingWhitelistApp.FindFirst() then begin
    //         CRMMbankingWhitelistApp.CalcFields(
    //         "Responsible Officer",
    //         "Supervisor ID"
    //         );

    //         Datum.Add('no', CRMMbankingWhitelistApp."No.");
    //         Datum.Add('member_no', CRMMbankingWhitelistApp."Member No.");
    //         Datum.Add('member_name', CRMMbankingWhitelistApp."Full Names");
    //         Datum.Add('transactional_mobile_no', CRMMbankingWhitelistApp."Transactional Mobile No.");
    //         Datum.Add('primary_identification_type', Format(CRMMbankingWhitelistApp."Primary Identification Type"));
    //         Datum.Add('primary_identification', CRMMbankingWhitelistApp."Primary Identification");
    //         Datum.Add('application_date', CRMMbankingWhitelistApp."Application Date");
    //         Datum.Add('crm_created_by', CRMMbankingWhitelistApp."CRM Created By");
    //         Datum.Add('crm_originating_branch', CRMMbankingWhitelistApp."CRM Originating Branch");
    //         Datum.Add('responsible_officer', CRMMbankingWhitelistApp."Responsible Officer");
    //         Datum.Add('supervisor_id', CRMMbankingWhitelistApp."Supervisor ID");
    //         Datum.Add('status', Format(CRMMbankingWhitelistApp.Status));
    //         Datum.Add('is_whitelisted', CRMMbankingWhitelistApp."Is Whitelisted");
    //         Datum.Add('whitelist_reference', CRMMbankingWhitelistApp."Whitelist Reference ID");

    //         ApplicationComments.Reset;

    //         ApplicationComments.SetRange("Header No.", CRMMbankingWhitelistApp."No.");
    //         ApplicationComments.SetCurrentKey("Entry No.");
    //         ApplicationComments.SetAscending("Entry No.", false);

    //         if ApplicationComments.FindSet then begin
    //             repeat begin
    //                 Comment.Add('comment', ApplicationComments.Comment);
    //                 Comment.Add('commented_by', ApplicationComments."Commented By");
    //                 Comment.Add('date_time', GlobalFunctions.FormatISODateTime(ApplicationComments.Date));
    //                 Comment.Add('is_read', ApplicationComments."Viewd By Somebody Else");

    //                 Comments.Add(Comment);

    //                 // Reset
    //                 Comment.ReadFrom('{}');
    //             end until ApplicationComments.Next = 0;
    //         end;

    //         Datum.Add('comments', Comments);

    //         Datum.Add('created_at', CRMMbankingWhitelistApp.SystemCreatedAt);
    //         Datum.Add('modified_at', CRMMbankingWhitelistApp.SystemModifiedAt);
    //     end else begin
    //         Error('M-Hela whitelist application with number %1 NOT found.', application_number.AsValue.AsText);
    //     end;

    //     ResponseObject.Add('status', 'SUCCESS');
    //     ResponseObject.Add('description', 'Request is successful');
    //     ResponseObject.Add('data', Datum);
    //     AddDateTimeToResponse(ResponseObject);

    //     ResponseObject.WriteTo(Response);

    //     exit(Response);
    // end;

    // EDMS
    local procedure UploadApplicationFiles(Payload: JsonObject): Text
    var
        application_no: JsonToken;
        application_type: JsonToken;
        files: JsonToken;
        file: JsonToken;
        file_name: JsonToken;
        file_contents: JsonToken;

        ApplicationFiles: Record "EDMS Files";

        MemberApplication: Record "Member Application";
        MemberApplicationCard: Page "Member Application Single";
        MemberEditRequest: Record "CRM Member Edit";
        MemberEditCard: Page "CRM Member Edit";
        LoanApplication: Record Loans;
        LoanApplicationCard: Page "Loan Application Card";
        MemberWithdrawal: Record "Member withdrawal Notice";
        MemberWithdrawalCard: Page "Member withdrawal Notice";
        BBFClaim: Record "SinkFund Report Information";
        BBFClaimCard: Page "SinkFund Notice";
        LGSRequest: Record "Guarantors Substitution";
        LGSRequestCard: Page "Guarantor Substitution";
        SARequest: Record "Savings Account Application";
        SARequestCard: Page "Savings Acc. Application Card";
        VariationsRequest: Record "Product Variations";
        VariationsRequestCard: Page Variations;
        ShareTransRequest: Record "Share Capital Transfer Buffer";
        ShareTransRequestCard: Page "Share Capital Transfer Card";

        CRMFunctions: Codeunit "CRM Functions";
        CRMMemberNo: JsonToken;
        ResponseData: JsonToken;

        ApplicantMember: Record Members;

        IDNumber: Text;
        PFNumber: Text;

        EDMSFunctions: Codeunit "EDMS Functions";
        EDMSFileTypes: enum "EDMS File Types";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('application_no', application_no);
        Payload.Get('application_type', application_type);
        Payload.Get('files', files);

        if files.AsArray.Count = 0 then begin
            Error('At least one file is required to be uploaded to EDMS');
        end;

        foreach file in files.AsArray() do begin
            file.AsObject.Get('name', file_name);

            if EDMSFunctions.GetFileTypeFromFileName(file_name.AsValue.AsText) = EDMSFileTypes::" " then begin
                Error('Unsupported file type for uploading the file = %1', file_name.AsValue.AsText);
            end;
        end;

        foreach file in files.AsArray() do begin
            file.AsObject.Get('name', file_name);
            file.AsObject.Get('contents', file_contents);

            case application_type.AsValue.AsText of
                'MEMBER_APPLICATION':
                    begin
                        MemberApplication.Reset;

                        MemberApplication.SetRange("No.", application_no.AsValue.AsText);

                        if MemberApplication.FindFirst then begin
                            MemberApplicationCard.UploadToEDMS(MemberApplication, file_name.AsValue.AsText, file_contents.AsValue.AsText);
                        end else begin
                            Error('%1 with the application number %2 is NOT found', application_type.AsValue.AsText, application_no.AsValue.AsText);
                        end;
                    end;
                'MEMBER_EDIT_REQUEST':
                    begin
                        MemberEditRequest.Reset;

                        MemberEditRequest.SetRange("No.", application_no.AsValue.AsText);

                        if MemberEditRequest.FindFirst then begin
                            MemberEditCard.UploadToEDMS(MemberEditRequest, file_name.AsValue.AsText, file_contents.AsValue.AsText);
                        end else begin
                            Error('%1 with the application number %2 is NOT found', application_type.AsValue.AsText, application_no.AsValue.AsText);
                        end;
                    end;
                'LOAN_APPLICATION':
                    begin
                        LoanApplication.Reset;

                        LoanApplication.SetRange("Loan No.", application_no.AsValue.AsText);

                        if LoanApplication.FindFirst then begin
                            LoanApplicationCard.UploadToEDMS(LoanApplication, file_name.AsValue.AsText, file_contents.AsValue.AsText);
                        end else begin
                            Error('%1 with the application number %2 is NOT found', application_type.AsValue.AsText, application_no.AsValue.AsText);
                        end;
                    end;
                'MEMBER_WITHDRAWAL_APPLICATION':
                    begin
                        MemberWithdrawal.Reset;

                        MemberWithdrawal.SetRange("No.", application_no.AsValue.AsText);

                        if MemberWithdrawal.FindFirst then begin
                            MemberWithdrawalCard.UploadToEDMS(MemberWithdrawal, file_name.AsValue.AsText, file_contents.AsValue.AsText);
                        end else begin
                            Error('%1 with the application number %2 is NOT found', application_type.AsValue.AsText, application_no.AsValue.AsText);
                        end;
                    end;
                'BBF_CLAIM_REQUEST':
                    begin
                        BBFClaim.Reset;

                        BBFClaim.SetRange(No, application_no.AsValue.AsText);

                        if BBFClaim.FindFirst then begin
                            BBFClaimCard.UploadToEDMS(BBFClaim, file_name.AsValue.AsText, file_contents.AsValue.AsText);
                        end else begin
                            Error('%1 with the application number %2 is NOT found', application_type.AsValue.AsText, application_no.AsValue.AsText);
                        end;
                    end;
                'LOAN_GUARANTOR_SUBSTITUTION_REQUEST':
                    begin
                        LGSRequest.Reset;

                        LGSRequest.SetRange("No.", application_no.AsValue.AsText);

                        if LGSRequest.FindFirst then begin
                            LGSRequestCard.UploadToEDMS(LGSRequest, file_name.AsValue.AsText, file_contents.AsValue.AsText);
                        end else begin
                            Error('%1 with the application number %2 is NOT found', application_type.AsValue.AsText, application_no.AsValue.AsText);
                        end;
                    end;
                'SUB_ACCOUNT_REQUEST':
                    begin
                        SARequest.Reset;

                        SARequest.SetRange("No.", application_no.AsValue.AsText);

                        if SARequest.FindFirst then begin
                            SARequestCard.UploadToEDMS(SARequest, file_name.AsValue.AsText, file_contents.AsValue.AsText);
                        end else begin
                            Error('%1 with the application number %2 is NOT found', application_type.AsValue.AsText, application_no.AsValue.AsText);
                        end;
                    end;
                'VARIATION_REQUEST':
                    begin
                        VariationsRequest.Reset;

                        VariationsRequest.SetRange("No.", application_no.AsValue.AsText);

                        if VariationsRequest.FindFirst then begin
                            VariationsRequestCard.UploadToEDMS(VariationsRequest, file_name.AsValue.AsText, file_contents.AsValue.AsText);
                        end else begin
                            Error('%1 with the application number %2 is NOT found', application_type.AsValue.AsText, application_no.AsValue.AsText);
                        end;
                    end;
                'SHARES_TRANSFER_REQUEST':
                    begin
                        ShareTransRequest.Reset;

                        ShareTransRequest.SetRange("Document No", application_no.AsValue.AsText);

                        if ShareTransRequest.FindFirst then begin
                            ShareTransRequestCard.UploadToEDMS(ShareTransRequest, file_name.AsValue.AsText, file_contents.AsValue.AsText);
                        end else begin
                            Error('%1 with the application number %2 is NOT found', application_type.AsValue.AsText, application_no.AsValue.AsText);
                        end;
                    end;
                // Online
                'CRM_CASE':
                    begin
                        ResponseData := CRMFunctions.CRMGetCaseDetails(application_no.AsValue.AsText);
                        if ResponseData.IsObject then begin
                            // {
                            //     "casetitle": "Arrears deducted erroneously.",
                            //     "caseno": "CRMCASE29",
                            //     "membername": "JAMES NYAMAHI MUGANDAH",
                            //     "memberno": "071695",
                            //     "category": "Service Related Complain",
                            //     "subcategory": "Refunds",
                            //     "department": "FINANCE",
                            //     "origin": "WhatsApp",
                            //     "originatingbranch": "UPPERHILL",
                            //     "description": "Erroneous deduction of arrears amounts."
                            // }
                            ResponseData.AsObject.Get('memberno', CRMMemberNo);

                            ApplicantMember.Reset;
                            ApplicantMember.SetRange("No.", CRMMemberNo.AsValue.AsText);

                            if ApplicantMember.FindFirst then begin
                                if ApplicantMember."Primary Identification Type" = ApplicantMember."Primary Identification Type"::"ID Number" then begin
                                    IDNumber := ApplicantMember."Primary Identification";
                                end else
                                    if ApplicantMember."Secondary Identification Type" = ApplicantMember."Secondary Identification Type"::"ID Number" then begin
                                        IDNumber := ApplicantMember."Secondary Identification";
                                    end else begin
                                        IDNumber := ApplicantMember."Primary Identification";
                                    end;

                                if ApplicantMember."Payroll/Staff No." <> '' then begin
                                    PFNumber := ApplicantMember."Payroll/Staff No.";
                                end else begin
                                    PFNumber := IDNumber;
                                end;

                                EDMSFunctions.EDMSMemberFileUpload(
                                        IDNumber,
                                        ApplicantMember.Name,
                                        'CC',
                                        PfNumber,
                                        ApplicantMember."No.",
                                        application_no.AsValue.AsText,
                                        file_name.AsValue.AsText,
                                        file_contents.AsValue.AsText
                                    );
                            end;
                        end
                    end;
                'CRM_PARCEL':
                    begin
                        ResponseData := CRMFunctions.CRMGetParcelDetails(application_no.AsValue.AsText);
                        if ResponseData.IsObject then begin
                            // {
                            //     "sourcetype": "Individual",
                            //     "membername": "ESTHER OMBAJO MALO",
                            //     "memberno": "026222",
                            //     "corporatename": null,
                            //     "parceltype": "Payments",
                            //     "datereceived": "2024-03-20T05:00:00Z",
                            //     "description": "TGH",
                            //     "receivedby": "MNS CE Test User 2",
                            //     "followupdepartment": "CUSTOMER CARE",
                            //     "parcelno": "CRMPR1"
                            // }
                            ResponseData.AsObject.Get('memberno', CRMMemberNo);

                            ApplicantMember.Reset;
                            ApplicantMember.SetRange("No.", CRMMemberNo.AsValue.AsText);

                            if ApplicantMember.FindFirst then begin
                                if ApplicantMember."Primary Identification Type" = ApplicantMember."Primary Identification Type"::"ID Number" then begin
                                    IDNumber := ApplicantMember."Primary Identification";
                                end else
                                    if ApplicantMember."Secondary Identification Type" = ApplicantMember."Secondary Identification Type"::"ID Number" then begin
                                        IDNumber := ApplicantMember."Secondary Identification";
                                    end else begin
                                        IDNumber := ApplicantMember."Primary Identification";
                                    end;

                                if ApplicantMember."Payroll/Staff No." <> '' then begin
                                    PFNumber := ApplicantMember."Payroll/Staff No.";
                                end else begin
                                    PFNumber := IDNumber;
                                end;

                                EDMSFunctions.EDMSMemberFileUpload(
                                        IDNumber,
                                        ApplicantMember.Name,
                                        'CP',
                                        PfNumber,
                                        ApplicantMember."No.",
                                        application_no.AsValue.AsText,
                                        file_name.AsValue.AsText,
                                        file_contents.AsValue.AsText
                                    );
                            end;
                        end
                    end;
            end;
        end;

        Datum.Add('message', 'File(s) have been uploaded successfully to EDMS');

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetApplicationFiles(Payload: JsonObject): Text
    var
        application_no: JsonToken;

        ApplicationFiles: Record "EDMS Files";

        EDMSFunctions: Codeunit "EDMS Functions";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('application_no', application_no);

        // Load/Refresh files list from EDMS
        EDMSFunctions.EDMSFileList(application_no.AsValue.AsText, Format("EDMS Data Classes"::" "));

        ApplicationFiles.Reset;

        ApplicationFiles.SetRange("Application No.", application_no.AsValue.AsText);
        IF ApplicationFiles.FindSet then begin
            repeat begin
                Datum.Add('entry_no', ApplicationFiles."Entry No.");
                Datum.Add('application_no', ApplicationFiles."Application No.");
                Datum.Add('edms_document_id', ApplicationFiles."EDMS Document ID");
                Datum.Add('edms_document_name', ApplicationFiles."EDMS Document Name");
                Datum.Add('edms_file_type', Format(ApplicationFiles."EDMS File Type"));
                Datum.Add('created_at', GlobalFunctions.FormatISODateTime(ApplicationFiles.SystemCreatedAt));

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until ApplicationFiles.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetApplicationFile(Payload: JsonObject): Text
    var
        edms_document_id: JsonToken;

        ApplicationFile: Record "EDMS Files";

        EDMSFunctions: Codeunit "EDMS Functions";
        FileB64: Text;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('edms_document_id', edms_document_id);

        // Load/Refresh file from EDMS
        FileB64 := EDMSFunctions.EDMSFileView(edms_document_id.AsValue.AsText);

        ApplicationFile.Reset;

        ApplicationFile.SetRange("EDMS Document ID", edms_document_id.AsValue.AsText);

        IF ApplicationFile.FindFirst then begin
            Datum.Add('entry_no', ApplicationFile."Entry No.");
            Datum.Add('application_no', ApplicationFile."Application No.");
            Datum.Add('edms_document_id', ApplicationFile."EDMS Document ID");
            Datum.Add('edms_document_name', ApplicationFile."EDMS Document Name");
            Datum.Add('edms_file_type', Format(ApplicationFile."EDMS File Type"));
            Datum.Add('file', FileB64);
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;


    // local procedure GetMemberDetailedStatementReport(Payload: JsonObject): Text
    // var
    //     account_number: JsonToken;
    //     page_number: JsonToken;
    //     page_size: JsonToken;

    //     MemberAccount: Record "Savings Accounts";
    //     SavingsLedgerEntry: Record "Savings Ledger Entry";

    //     Count: Integer;
    //     FirstRow: Integer;
    //     LastRow: Integer;
    //     TotalFoundRecords: Integer;

    //     RecRef: RecordRef;
    //     BlobOutStream: OutStream;
    //     BlobInStream: InStream;
    //     Base64Convert: Codeunit "Base64 Convert";
    //     TempBlob: Codeunit "Temp Blob";
    //     FileContentsB64: Text;

    //     ResponseObject: JsonObject;
    //     PaginationObject: JsonObject;
    //     Data: JsonArray;
    //     Datum: JsonObject;
    //     Response: Text;
    // begin
    //     Payload.Get('account_number', account_number);
    //     Payload.Get('page_number', page_number);
    //     Payload.Get('page_size', page_size);

    //     MemberAccount.Reset;
    //     MemberAccount.SetRange("No.", account_number.AsValue.AsText);

    //     IF MemberAccount.FindSet then begin
    //         // Account found
    //         Count := 0;
    //         FirstRow := ((page_number.AsValue.AsInteger - 1) * page_size.AsValue.AsInteger) + 1;
    //         LastRow := page_number.AsValue.AsInteger * page_size.AsValue.AsInteger;

    //         SavingsLedgerEntry.Reset;
    //         SavingsLedgerEntry.SetCurrentkey("Entry No.");
    //         SavingsLedgerEntry.Ascending(false);
    //         SavingsLedgerEntry.SetRange("Customer No.", MemberAccount."No.");

    //         // PDF Report
    //         // TempBlob.CreateOutStream(BlobOutStream, );
    //         // RecRef.GetTable(SavingsLedgerEntry);
    //         // Report.SaveAs(Report::"Member's Statement", '', ReportFormat::Pdf, BlobOutStream, RecRef);

    //         TempBlob.CreateInStream(BlobInStream);
    //         TempBlob.CreateOutStream(BlobOutStream, );
    //         RecRef.GetTable(MemberAccount);
    //         Report.SaveAs(Report::"Member's Statement", '', ReportFormat::Pdf, BlobOutStream, RecRef);

    //         // Report.SaveAs(Report::"Member Statement", '', ReportFormat::Pdf, BlobOutStream, RecRef);
    //         // Report.SaveAs(Report::"Member Statement New", '', ReportFormat::Pdf, BlobOutStream, RecRef);
    //         // Report.SaveAs(Report::"Member Statement-Detailed", '', ReportFormat::Pdf, BlobOutStream, RecRef);
    //         // Report.SaveAs(Report::"Member Statement-H.Users", '', ReportFormat::Pdf, BlobOutStream, RecRef);

    //         CopyStream(BlobOutStream, BlobInStream);

    //         TempBlob.CreateInStream(BlobInStream);
    //         FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

    //         PaginationObject.Add('file', FileContentsB64);

    //         ResponseObject.Add('status', 'SUCCESS');
    //         ResponseObject.Add('description', 'Request is successful');
    //         ResponseObject.Add('data', PaginationObject);
    //         AddDateTimeToResponse(ResponseObject);
    //     end else begin
    //         // ResponseObject.Add('status', 'ERROR');
    //         // ResponseObject.Add('description', 'Member account NOT found');
    //         // ResponseObject.Add('data', Data);
    //         // AddDateTimeToResponse(ResponseObject);

    //         Error('Member account NOT found');
    //     end;

    //     ResponseObject.WriteTo(Response);

    //     exit(Response);
    // end;

    local procedure GetLedgerEntries(Payload: JsonObject): Text
    var
        document_no: JsonToken;

        GLEntries: Record "G/L Entry";

        Count: Integer;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('document_no', document_no);

        GLEntries.Reset;
        GLEntries.SetRange("Document No.", document_no.AsValue.AsText);

        IF GLEntries.FindSet then begin
            Count := 0;
            repeat begin

                Count += 1;

                Datum.Add('document_no', GLEntries."Document No.");
                Datum.Add('description', GLEntries.Description);
                Datum.Add('amount', GLEntries.Amount);
                Datum.Add('debit_amount', GLEntries."Debit Amount");
                Datum.Add('credit_amount', GLEntries."Credit Amount");
                Datum.Add('document_date', GLEntries."Document Date");
                Datum.Add('posting_date', GLEntries."Posting Date");
                Datum.Add('source_type', Format(GLEntries."Source Type"));
                Datum.Add('gl_account', GLEntries."G/L Account No.");

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until (GLEntries.Next = 0) or (Count = 2);
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetFlags(Payload: JsonObject): Text
    var
        reference_no: JsonToken;

        Entries: Record "Loanee Infomation Base";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('reference_no', reference_no);

        Entries.Reset;
        Entries.SetRange("Member No.", reference_no.AsValue.AsText);

        IF Entries.FindSet then begin
            repeat begin
                Datum.Add('reference_no', Entries."Member No.");
                Datum.Add('info', Entries.Info);
                Datum.Add('date', Entries.Date);
                Datum.Add('captured_by', Entries."Captured By");

                if (Entries."Expiry Date" = 0D) or (Entries."Expiry Date" > Today) then begin
                    Data.Add(Datum);
                end;

                // Reset
                Datum.ReadFrom('{}');
            end until Entries.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    // ---------------------------- REPORTS ------------------------------------------------------------------------
    local procedure GetMemberDetailedStatementReport(Payload: JsonObject): Text
    var
        member_number: JsonToken;

        TheMember: record Members;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('member_number', member_number);

        TheMember.Reset;
        TheMember.SetRange("No.", member_number.AsValue.AsText);

        IF TheMember.FindFirst then begin
            RecRef.GetTable(TheMember);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Member Detailed Statement", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Member with number %1 NOT found', member_number.AsValue.AsText);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberLoanStatementReport(Payload: JsonObject): Text
    var
        member_number: JsonToken;

        TheMember: record Members;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('member_number', member_number);

        TheMember.Reset;
        TheMember.SetRange("No.", member_number.AsValue.AsText);

        IF TheMember.FindFirst then begin
            RecRef.GetTable(TheMember);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"CRM Member Loan Statement", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Member with number %1 NOT found', member_number.AsValue.AsText);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberStatementNewReport(Payload: JsonObject): Text
    var
        member_number: JsonToken;

        TheMember: record Members;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('member_number', member_number);

        TheMember.Reset;
        TheMember.SetRange("No.", member_number.AsValue.AsText);

        IF TheMember.FindFirst then begin
            RecRef.GetTable(TheMember);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Member and loan Statement", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Member with number %1 NOT found', member_number.AsValue.AsText);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberCardReport(Payload: JsonObject): Text
    var
        member_number: JsonToken;

        TheMember: record Members;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('member_number', member_number);

        TheMember.Reset;
        TheMember.SetRange("No.", member_number.AsValue.AsText);

        IF TheMember.FindFirst then begin
            RecRef.GetTable(TheMember);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Member Card", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Member with number %1 NOT found', member_number.AsValue.AsText);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetDividendSlipReport(Payload: JsonObject): Text
    var
        member_number: JsonToken;
        year: JsonToken;

        TheMember: record Members;
        TheDividendProgression: Record "Dividend Progression";

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('member_number', member_number);
        Payload.Get('year', year);

        TheMember.Reset;
        TheMember.SetRange("No.", member_number.AsValue.AsText);

        IF TheMember.FindFirst then begin
            TheDividendProgression.Reset;

            TheDividendProgression.SetRange("Member No", TheMember."No.");
            TheDividendProgression.SetRange(Year, year.AsValue.AsInteger);

            if TheDividendProgression.FindSet then begin
                RecRef.GetTable(TheDividendProgression);

                BlobOutStream := TempBlob.CreateOutStream;
                Report.SaveAs(Report::"Dividend Slip B64", '', ReportFormat::Pdf, BlobOutStream, RecRef);

                BlobInStream := TempBlob.CreateInStream;
                FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

                PaginationObject.Add('record_count', TheDividendProgression.Count);
                PaginationObject.Add('file', FileContentsB64);

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('description', 'Request is successful');
                ResponseObject.Add('data', PaginationObject);
                AddDateTimeToResponse(ResponseObject);
            end else begin
                Error('Dividend records for member: %1 for the year: %2 NOT available at the moment', TheMember."No.", year.AsValue.AsInteger);
            end;
        end else begin
            Error('Member with number %1 NOT found', member_number.AsValue.AsText);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanRepaymentScheduleReport(Payload: JsonObject): Text
    var
        loan_number: JsonToken;

        TheLoan: record Loans;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('loan_number', loan_number);

        TheLoan.Reset;
        TheLoan.SetRange("Loan No.", loan_number.AsValue.AsText);

        IF TheLoan.FindFirst then begin
            RecRef.GetTable(TheLoan);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"CRM Loan RePayment Schedule", '', ReportFormat::Pdf, BlobOutStream, RecRef);
            // Report.SaveAs(Report::"Repayment Schedule", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Loan with number %1 NOT found', loan_number.AsValue.AsText);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetSavingsAccountStatementReport(Payload: JsonObject): Text
    var
        member_number: JsonToken;

        TheMember: record Members;
        TheAccounts: record "Savings Accounts";

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('member_number', member_number);

        TheMember.Reset;
        TheMember.SetRange("No.", member_number.AsValue.AsText);

        IF TheMember.FindFirst then begin
            TheAccounts.SetRange("Member No.", TheMember."No.");

            if TheAccounts.FindSet then begin
                RecRef.GetTable(TheAccounts);

                BlobOutStream := TempBlob.CreateOutStream;
                Report.SaveAs(Report::"CRM Savings's Statement", '', ReportFormat::Pdf, BlobOutStream, RecRef);

                BlobInStream := TempBlob.CreateInStream;
                FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

                PaginationObject.Add('record_count', TheAccounts.Count);
                PaginationObject.Add('file', FileContentsB64);

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('description', 'Request is successful');
                ResponseObject.Add('data', PaginationObject);
                AddDateTimeToResponse(ResponseObject);
            end else begin
                Error('Member with number %1 does NOT have any savings accounts');
            end;
        end else begin
            Error('Member with number %1 NOT found', member_number.AsValue.AsText);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoansGuaranteedReport(Payload: JsonObject): Text
    var
        member_number: JsonToken;

        TheMember: record Members;
        LoanGuarantorsList: Record "Loan Guarantors and Security";
        Loan: Record Loans;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('member_number', member_number);

        TheMember.Reset;
        TheMember.SetRange("No.", member_number.AsValue.AsText);

        IF TheMember.FindFirst then begin
            RecRef.GetTable(TheMember);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"CRM Loan Guaranteed", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Member with number %1 NOT found', member_number.AsValue.AsText);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanGuarantorsReport(Payload: JsonObject): Text
    var
        loan_number: JsonToken;

        LoanGuarantorsList: Record "Loan Guarantors and Security";
        Loan: Record Loans;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('loan_number', loan_number);

        Loan.Reset;
        Loan.SetRange("Loan No.", loan_number.AsValue.AsText);


        IF Loan.FindFirst then begin
            LoanGuarantorsList.Reset;
            LoanGuarantorsList.SetRange("Loan No", loan_number.AsValue.AsText);
            LoanGuarantorsList.Findset;

            RecRef.GetTable(Loan);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"CRM Loan Guarators Reports", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Loan with number %1 NOT found', loan_number.AsValue.AsText);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberCheckoffAdviceVarianceReport(Payload: JsonObject): Text
    var
        member_number: JsonToken;

        TheMember: record Members;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('member_number', member_number);

        TheMember.Reset;
        TheMember.SetRange("No.", member_number.AsValue.AsText);

        IF TheMember.FindFirst then begin
            RecRef.GetTable(TheMember);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Checkoff Advice Variance", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Member with number %1 NOT found', member_number.AsValue.AsText);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;


    local procedure GetMemberShareByCategoryReport(Payload: JsonObject): Text
    var
        the_parameter_value: JsonToken;

        TheMember: record Members;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        KeyExists: Boolean;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        TheMember.Reset;

        KeyExists := Payload.Get('member_number', the_parameter_value);
        if KeyExists then begin
            TheMember.SetRange("No.", the_parameter_value.AsValue.AsText);
        end;

        KeyExists := Payload.Get('employer_code', the_parameter_value);
        if KeyExists then begin
            TheMember.SetRange("Employer Code", the_parameter_value.AsValue.AsText);
        end;

        KeyExists := Payload.Get('status', the_parameter_value);
        if KeyExists then begin
            TheMember.SetRange(Status, the_parameter_value.AsValue.AsInteger);
        end;

        KeyExists := Payload.Get('religion', the_parameter_value);
        if KeyExists then begin
            TheMember.SetRange(Religion, the_parameter_value.AsValue.AsText);
        end;

        IF TheMember.FindSet then begin
            RecRef.GetTable(TheMember);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Member Share By Category", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheMember.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Data with the given parameter value is NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;


    local procedure GetMemberLifetimeValueReport(Payload: JsonObject): Text
    var
        the_parameter_value: JsonToken;

        TheMember: record Members;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        KeyExists: Boolean;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        TheMember.Reset;

        KeyExists := Payload.Get('member_number', the_parameter_value);
        if KeyExists then begin
            TheMember.SetRange("No.", the_parameter_value.AsValue.AsText);
        end else begin
            Error('Unsupported search parameter');
        end;

        // KeyExists := Payload.Get('employer_code', the_parameter_value);
        // if KeyExists then begin
        //     TheMember.SetRange("Employer Code", the_parameter_value.AsValue.AsText);
        // end;

        // KeyExists := Payload.Get('status', the_parameter_value);
        // if KeyExists then begin
        //     TheMember.SetRange(Status, the_parameter_value.AsValue.AsInteger);
        // end;

        // KeyExists := Payload.Get('religion', the_parameter_value);
        // if KeyExists then begin
        //     TheMember.SetRange(Religion, the_parameter_value.AsValue.AsText);
        // end;

        IF TheMember.FindSet then begin
            RecRef.GetTable(TheMember);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Ind Member Lifetime Value Rep", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheMember.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Data with the given parameter value is NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanProductsReport(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMember: record "Product Factory";

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        XmlDoc: XmlDocument;
        OStream: OutStream;
        ReportParameters: Text;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMember.Reset;
        // TheMember.SetCurrentKey("Disbursement Date");
        // TheMember.SetAscending("Disbursement Date", false);
        // TheMember.SetRange(Posted, true);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end else begin
            Error('Missing start date and/or end date');
        end;

        IF TheMember.FindSet then begin
            RecRef.GetTable(TheMember);

            // Code to get sample XML parameters for the report
            // XmlParameters := Report.RunRequestPage(Report::"Loan Products Report");
            // Message(XmlParameters);
            XmlDocument.ReadFrom(
                '<ReportParameters name="Loan Products Report" id="' + Format(Report::"Loan Products Report") +
                '"><Options><Field name="StartDate">' + GlobalFunctions.FormatISODate(StartDate) +
                '</Field><Field name="EndDate">' + GlobalFunctions.FormatISODate(EndDate) + '</Field></Options><DataItems>' +
                '<DataItem name="Product Factory">VERSION(1) SORTING(Field1)</DataItem></DataItems></ReportParameters>', XmlDoc);

            XmlDoc.WriteTo(ReportParameters);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(
                Report::"Loan Products Report", ReportParameters,
                ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheMember.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Loans created within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetDepositsAccumulatedOverTimeReport(Payload: JsonObject): Text
    var
        the_parameter_value: JsonToken;

        TheMember: record Members;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        KeyExists: Boolean;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        TheMember.Reset;

        KeyExists := Payload.Get('member_number', the_parameter_value);
        if KeyExists then begin
            TheMember.SetRange("No.", the_parameter_value.AsValue.AsText);
        end;

        KeyExists := Payload.Get('employer_code', the_parameter_value);
        if KeyExists then begin
            TheMember.SetRange("Employer Code", the_parameter_value.AsValue.AsText);
        end;

        KeyExists := Payload.Get('status', the_parameter_value);
        if KeyExists then begin
            TheMember.SetRange(Status, the_parameter_value.AsValue.AsInteger);
        end;

        KeyExists := Payload.Get('religion', the_parameter_value);
        if KeyExists then begin
            TheMember.SetRange(Religion, the_parameter_value.AsValue.AsText);
        end;

        IF TheMember.FindSet then begin
            RecRef.GetTable(TheMember);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Deposits Accumulated Over Time", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheMember.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Data with the given parameter value is NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetSavingsProductsReport(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMember: record "Savings Accounts";

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMember.Reset;
        TheMember.SetCurrentKey("Registration Date");
        TheMember.SetAscending("Registration Date", false);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMember.SetFilter("Registration Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        // TheMember.SetFilter("Product Category", '%1|%2|%3', TheMember."Product Category"::SAYE, TheMember."Product Category"::"Fixed Deposit", TheMember."Product Category"::"Junior Account");

        IF TheMember.FindSet then begin
            RecRef.GetTable(TheMember);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Savings Products Report", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheMember.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Accounts created within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetSalaryAccountsReport(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMember: record "Savings Accounts";

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMember.Reset;
        TheMember.SetCurrentKey("Registration Date");
        TheMember.SetAscending("Registration Date", false);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMember.SetFilter("Registration Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        // TheMember.SetFilter("Product Category", '%1', TheMember."Product Category"::"FOSA Account");

        IF TheMember.FindSet then begin
            RecRef.GetTable(TheMember);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Salary Accounts Report", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheMember.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Salary Accounts created within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberCommissionsReport(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMember: record Members;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMember.Reset;
        TheMember.SetCurrentKey("Registration Date");
        TheMember.SetAscending("Registration Date", false);
        // TheMember.SetFilter("Recruited by Type", '<>%1', TheMember."Recruited By Type"::" ");
        // TheMember.SetFilter("Recruited by Type", '<>%1', TheMember."Recruited By Type"::Self);

        // TheMember.SetFilter(
        //     "Recruited by Type", 
        //     '%1|%2|%3|%4|%5|%6|%7', 
        //     TheMember."Recruited By Type"::"Board Member",
        //     TheMember."Recruited By Type"::Delegates,
        //     TheMember."Recruited By Type"::Others,
        //     TheMember."Recruited By Type"::Parent,
        //     TheMember."Recruited By Type"::"Sales Representative",
        //     TheMember."Recruited By Type"::Spouse,
        //     TheMember."Recruited By Type"::Staff
        //     );

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMember.SetFilter("Registration Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheMember.FindSet then begin
            RecRef.GetTable(TheMember);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Marketing Commission", '', ReportFormat::Pdf, BlobOutStream, RecRef);
            // Report.SaveAs(Report::"Marketing Commission", '', ReportFormat::Excel, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheMember.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Members created within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    //.........................

    local procedure GetMemberCommissionsReportXLSX(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMember: record Members;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        FileContentsB64: Text;

        myInt: Integer;
        CI: Record "Company Information";
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SavingsAccount: Record "Savings Accounts";
        AmountContributed: Decimal;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        ContributionDate: Date;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        ContributionDate := 0D;
        AmountContributed := 0;
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMember.Reset;
        TheMember.SetCurrentKey("Registration Date");
        TheMember.SetAscending("Registration Date", false);

        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMember.SetFilter("Registration Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheMember.FindSet then begin
            repeat begin
                SavingsAccount.RESET;
                SavingsAccount.SETRANGE("Member No.", TheMember."No.");
                SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Entrance Fee");
                if SavingsAccount.Find('-') then begin
                    SavingsAccount.CalcFields("Balance (LCY)");
                    AmountContributed := SavingsAccount."Balance (LCY)";
                    if AmountContributed < SavingsAccount."Monthly Contribution" then
                        AmountContributed := 0;

                    SavingsLedgerEntry.RESET;
                    SavingsLedgerEntry.SETRANGE("Member No.", TheMember."No.");
                    SavingsLedgerEntry.SetRange(Reversed, FALSE);
                    SavingsLedgerEntry.SetRange("Customer Posting Group", 'REG');
                    if SavingsLedgerEntry.FindLast() then
                        ContributionDate := SavingsLedgerEntry."Posting Date";

                    RecRef.GetTable(TheMember);
                    Clear(Datum);

                    Datum.Add('product_type', TheMember."No.");
                    Datum.Add('product_name', TheMember."Recruited By Name");
                    Datum.Add('member_no', TheMember."Recruited By");
                    Datum.Add('member_name', TheMember.Name);
                    Datum.Add('application_date', TheMember."Registration Date");
                    Datum.Add('application_time', TheMember."Phone No.");
                    Datum.Add('status', Format(TheMember.Status));
                    Datum.Add('approved_by', TheMember."Approved By");
                    Datum.Add('employer_code', TheMember."Employer Code");
                    Datum.Add('contribution_date', ContributionDate);
                    Datum.Add('contributed_amount', AmountContributed);

                    Data.Add(Datum);
                end;
                // else begin
                //     Error('Member recruited within the given time period NOT found');
                // end;
            end until TheMember.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    //........................
    local procedure GetSubAccountCommissionsReport(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMember: record "Savings Account Application";

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMember.Reset;
        TheMember.SetCurrentKey("Application Date");
        TheMember.SetAscending("Application Date", false);
        TheMember.SetFilter("Recruited by Type", '<>%1', TheMember."Recruited By Type"::"None");
        TheMember.SetFilter("Recruited by Type", '<>%1', TheMember."Recruited By Type"::Self);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMember.SetFilter("Application Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheMember.FindSet then begin
            RecRef.GetTable(TheMember);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Sub Accounts Commission", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheMember.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Sub account applications created within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetSubAccountCommissionsReportXLSX(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMember: record "Savings Account Application";

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMember.Reset;
        TheMember.SetCurrentKey("Application Date");
        TheMember.SetAscending("Application Date", false);
        TheMember.SetFilter("Recruited by Type", '<>%1', TheMember."Recruited By Type"::"None");
        TheMember.SetFilter("Recruited by Type", '<>%1', TheMember."Recruited By Type"::Self);

        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMember.SetFilter("Application Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheMember.FindSet then begin
            RecRef.GetTable(TheMember);
            Clear(Datum);

            Datum.Add('product_type', TheMember."No.");
            Datum.Add('product_name', TheMember."Recruited By Name");
            Datum.Add('member_no', TheMember."Recruited By");
            Datum.Add('member_name', TheMember.Name);
            Datum.Add('application_date', TheMember."Registration Date");
            Datum.Add('application_time', TheMember."Phone No.");
            Datum.Add('status', Format(TheMember.Status));
            Datum.Add('approved_by', TheMember."Account Category");
            Datum.Add('employer_code', TheMember."Account Category");
            //Datum.Add('contribution_date', TheMember.ba);
            //Datum.Add('contributed_amount', TheMember.b);

            Data.Add(Datum);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetVariationCommissionsReport(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMember: record "Product Variations";

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMember.Reset;
        TheMember.SetCurrentKey("Application Date");
        TheMember.SetAscending("Application Date", false);
        TheMember.SetFilter("Recruited by Type", '<>%1', TheMember."Recruited By Type"::"None");
        TheMember.SetFilter("Recruited by Type", '<>%1', TheMember."Recruited By Type"::Self);

        // TheMember.SetFilter(
        //     "Recruited by Type", 
        //     '%1|%2|%3|%4|%5|%6|%7', 
        //     TheMember."Recruited By Type"::"Board Member",
        //     TheMember."Recruited By Type"::Delegates,
        //     TheMember."Recruited By Type"::Others,
        //     TheMember."Recruited By Type"::Parent,
        //     TheMember."Recruited By Type"::"Sales Representative",
        //     TheMember."Recruited By Type"::Spouse,
        //     TheMember."Recruited By Type"::Staff
        //     );

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMember.SetFilter("Application Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheMember.FindSet then begin
            RecRef.GetTable(TheMember);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Share Variation Commission", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheMember.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Variation applications created within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetChangeOfPaypointCommissionsReport(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMember: record "Salary Agreement";

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMember.Reset;
        TheMember.SetCurrentKey("Date Captured");
        TheMember.SetAscending("Date Captured", false);
        TheMember.SetFilter("Recruited by Type", '<>%1', TheMember."Recruited By Type"::Self);

        // TheMember.SetFilter(
        //     "Recruited by Type", 
        //     '%1|%2|%3|%4|%5|%6|%7', 
        //     TheMember."Recruited By Type"::"Board Member",
        //     TheMember."Recruited By Type"::Delegates,
        //     TheMember."Recruited By Type"::Others,
        //     TheMember."Recruited By Type"::Parent,
        //     TheMember."Recruited By Type"::"Sales Representative",
        //     TheMember."Recruited By Type"::Spouse,
        //     TheMember."Recruited By Type"::Staff
        //     );

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMember.SetFilter("Date Captured", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheMember.FindSet then begin
            RecRef.GetTable(TheMember);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Change Paypoint Commission", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheMember.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Change of paypoint applications created within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberWithoutLoansReport(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMember: record Members;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMember.Reset;
        TheMember.SetCurrentKey("Registration Date");
        TheMember.SetAscending("Registration Date", false);
        TheMember.SetFilter("Loan Balances", '<=0');

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMember.SetFilter("Registration Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheMember.FindSet then begin
            RecRef.GetTable(TheMember);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Members Without Loan Report", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheMember.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Unable to fetch members at the moment');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMembershipTATReport(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMembers: record Members;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMembers.Reset;
        TheMembers.SetCurrentKey("Registration Date");
        TheMembers.SetAscending("Registration Date", false);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMembers.SetFilter("Registration Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheMembers.FindSet then begin
            RecRef.GetTable(TheMembers);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"CRM Member TAT Report ", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheMembers.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Members created within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMembershipTATReportXLSX(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMembers: record Members;
        TheMemberApplication: record "Member Application";
        SLA: record "Defined SLA";
        Comment: record Comments;
        Globalfunctions: Codeunit "Global Functions";

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        Durationuptonow: Duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMembers.Reset;
        TheMembers.SetCurrentKey("Registration Date");
        TheMembers.SetAscending("Registration Date", false);


        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMembers.SetFilter("Registration Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;
        IF TheMembers.FindSet then begin
            repeat begin
                Clear(Datum);
                WorkDays := 0;
                SLADays := 0;
                DelayDays := 0;
                Durationuptonow := 0;
                StatusComment := '';

                TheMemberApplication.Reset;
                TheMemberApplication.SetRange("No.", TheMembers."CRM Application No.");

                if TheMemberApplication.FindFirst then begin
                    SLA.reset();
                    SLA.SetRange("Origination Type", SLA."Origination Type"::"New Registration");
                    if SLA.findfirst() then
                        SLADays := SLA.SLA;

                    if (TheMemberApplication."Date Approved" <> 0D) and (TheMemberApplication."Application Date" <> 0D) and (TheMemberApplication."Application Time" <> 0T) and (TheMemberApplication."Approval Time" <> 0T) then begin
                        GlobalFunctions.HoursBetweenPeriods(TheMemberApplication."Application Date", TheMemberApplication."Application Time", TheMemberApplication."Date Approved", TheMemberApplication."Approval Time", Duration, WokedOnANonWorkingPeriod);
                        WorkDays := Duration;
                        DelayDays := WorkDays - (SLADays / 3);
                        IF DelayDays < 0 then DelayDays := 0;
                    end;
                    if TheMemberApplication."Application Date Time" <> 0DT then begin
                        Durationuptonow := CurrentDateTime - TheMemberApplication."Application Date Time";
                    end;


                    Comment.reset();
                    Comment.SetRange("Header No.", TheMemberApplication."No.");
                    If Comment.FindLast() then begin
                        StatusComment := Comment.Comment;
                    end;

                    Datum.Add('member_no', TheMembers."No.");
                    Datum.Add('member_name', TheMembers.Name);
                    Datum.Add('application_date', GlobalFunctions.FormatISODate(TheMemberApplication."Application Date"));
                    Datum.Add('application_time', TheMemberApplication."Application Time");
                    Datum.Add('application_no', TheMemberApplication."No.");
                    Datum.Add('originating_branch', TheMemberApplication."CRM Originating Branch");
                    Datum.Add('created_by', TheMemberApplication."CRM Created By");
                    Datum.Add('status', Format(TheMembers.Status));
                    Datum.Add('action_date', TheMemberApplication."Date Approved");
                    Datum.Add('action_time', TheMemberApplication."Approval Time");
                    Datum.Add('approved_by', TheMembers."Approved By");
                    Datum.Add('employer_code', TheMemberApplication."Employer Code");
                    TheMemberApplication.CalcFields("Employer Name");
                    Datum.Add('employer_name', TheMemberApplication."Employer Name");

                    Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
                    Datum.Add('SLA_days', Format(SLADays));
                    Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
                    Datum.Add('tat_status', Format(TAtStatus));
                    Datum.Add('duration_uptonow', Format(Durationuptonow));
                    Datum.Add('status_comment', StatusComment);
                    Datum.Add('priority', Format(Priority));

                    Data.Add(Datum);
                end;
            end until TheMembers.Next = 0;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', Data);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Members created within the given time period NOT found');
        end;
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoansTATReport(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheLoan: record Loans;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;
        FileLength: Integer;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheLoan.Reset;
        TheLoan.SetCurrentKey("Application Date");
        TheLoan.SetAscending("Application Date", false);
        TheLoan.SetRange(Posted, true);
        TheLoan.SetRange("Mobile Loan", false);
        TheLoan.SetFilter("Source Aplication", '=%1|%2',
            TheLoan."Source Aplication"::CRM,
            TheLoan."Source Aplication"::"Mwalimu Smart"
        );

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheLoan.SetFilter("Application Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheLoan.FindSet then begin
            RecRef.GetTable(TheLoan);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Loans TAT", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);
            FileLength := TempBlob.Length;

            PaginationObject.Add('record_count', TheLoan.Count);
            PaginationObject.Add('file_length', FileLength);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Loans disbursed within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoansTATReportXLSX(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheLoan: record Loans;
        SLA: record "Defined SLA";
        Comment: record "Loan Appraisal Comments";
        TheMember: record members;
        TheProduct: Record "Product Factory";

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        Durationuptonow: Duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheLoan.Reset;
        TheLoan.SetCurrentKey("Application Date");
        TheLoan.SetAscending("Application Date", false);
        TheLoan.SetRange(Posted, true);
        TheLoan.SetRange("Mobile Loan", false);
        TheLoan.SetFilter("Source Aplication", '=%1|%2',
            TheLoan."Source Aplication"::CRM,
            TheLoan."Source Aplication"::"Mwalimu Smart"
        );

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheLoan.SetFilter("Application Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheLoan.FindSet then begin
            repeat begin
                Clear(Datum);

                WorkDays := 0;
                SLADays := 0;
                DelayDays := 0;
                Durationuptonow := 0;
                StatusComment := '';

                TheProduct.Reset;
                TheProduct.SetRange("Product ID", TheLoan."Loan Product Type");
                // TheProduct.SetLoadFields("Product ID", "CRM Product SLA Timeline");
                // TheProduct.SetAutoCalcFields("CRM Product SLA Timeline");

                if TheProduct.FindFirst then begin
                    // SLADays := TheProduct."CRM Product SLA Timeline";
                end;

                if SLADays = 0 then begin
                    SLA.reset();
                    SLA.SetRange("Origination Type", SLA."Origination Type"::Loans);
                    if SLA.findfirst() then
                        SLADays := SLA.SLA;
                end;

                if (TheLoan."Disbursement Date" <> 0D) and (TheLoan."Application Date" <> 0D) and (TheLoan."Application Time" <> 0T) and (TheLoan."disbursement time" <> 0T) then begin
                    Globalfunctions.HoursBetweenPeriods(TheLoan."Application Date", TheLoan."Application Time", TheLoan."Disbursement Date", TheLoan."disbursement time", Duration, WokedOnANonWorkingPeriod);
                    WorkDays := Duration;
                    DelayDays := WorkDays - (SLADays / 3);
                    IF DelayDays < 0 then DelayDays := 0;
                end;

                //if (TheLoan."Application Date" <> 0D) and (TheLoan."Application Time" <> 0T) and (TheLoan."disbursement time" = 0T) and (TheLoan."Disbursement Date" = 0D) then begin
                // GlobalFunctions.HoursBetweenPeriods(TheLoan."Application Date", TheLoan."Application Time", TheLoan."Disbursement Date", TheLoan."disbursement time", Duration, WokedOnANonWorkingPeriod);
                Durationuptonow := CurrentDateTime - TheLoan."Application Date Time";
                //end;

                if TheMember.Get(TheLoan."Member No.") then begin
                end;

                Comment.reset();
                Comment.SetRange("Loan No.", TheLoan."Loan No.");
                If Comment.FindLast() then begin
                    StatusComment := Comment.Comment;
                end;

                Datum.Add('loan_product_type', TheLoan."Loan Product Type");
                Datum.Add('loan_product_type_name', TheLoan."Loan Product Type Name");
                Datum.Add('member_no', TheLoan."Member No.");
                Datum.Add('member_name', TheLoan."Member Name");
                Datum.Add('application_date', TheLoan."Application Date");
                Datum.Add('application_time', TheLoan."Application Time");
                Datum.Add('application_no', TheLoan."Loan No.");
                Datum.Add('crm_originating_branch', TheLoan."CRM Originating Branch");
                Datum.Add('crm_created_by', TheLoan."CRM Created By");
                Datum.Add('status', Format(TheLoan.Status));
                Datum.Add('action_date', TheLoan."Disbursement Date");
                Datum.Add('action_time', TheLoan."disbursement time");
                Datum.Add('approved_by', TheLoan."Approved By");
                Datum.Add('employer_code', TheLoan."Employer Code");

                TheMember.CalcFields("Employer Name");
                Datum.Add('employer_name', TheMember."Employer Name");

                Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
                Datum.Add('SLA_days', Format(SLADays));
                Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
                Datum.Add('duration_uptonow', Format(Durationuptonow));
                Datum.Add('tat_status', Format(TAtStatus));
                Datum.Add('status_comment', StatusComment);
                Datum.Add('priority', Format(Priority));

                Data.Add(Datum);
            end until TheLoan.Next = 0;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', Data);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Loans disbursed within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberEditTATReport(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMembers: record "CRM Member Edit";

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMembers.Reset;
        TheMembers.SetCurrentKey("Application Date");
        TheMembers.SetAscending("Application Date", false);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMembers.SetFilter("Application Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;
        TheMembers.SetRange(Status, TheMembers.Status::Approved);

        IF TheMembers.FindSet then begin
            RecRef.GetTable(TheMembers);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Member Edit TAT Report", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheMembers.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Member edits created within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberEditTATReportXLSX(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMembers: record "CRM Member Edit";
        SLA: record "Defined SLA";
        Comment: record Comments;
        TheMember: Record members;

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMembers.Reset;
        TheMembers.SetCurrentKey("Application Date");
        TheMembers.SetAscending("Application Date", false);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMembers.SetFilter("Application Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;
        TheMembers.SetRange(Status, TheMembers.Status::Approved);

        IF TheMembers.FindSet then begin
            repeat begin
                Clear(Datum);

                WorkDays := 0;
                SLADays := 0;
                DelayDays := 0;
                StatusComment := '';

                SLA.reset();
                SLA.SetRange("Origination Type", SLA."Origination Type"::"Member Edit");
                if SLA.findfirst() then
                    SLADays := SLA.SLA;

                if (TheMembers."Approval Date" <> 0D) and (TheMembers."Application Date" <> 0D) and (TheMembers."Application Time" <> 0T) and (TheMembers."Approval Time" <> 0T) then begin
                    Globalfunctions.HoursBetweenPeriods(TheMembers."Application Date", TheMembers."Application Time", TheMembers."Approval Date", TheMembers."Approval Time", Duration, WokedOnANonWorkingPeriod);
                    WorkDays := Duration;
                    DelayDays := WorkDays - (SLADays / 3);
                    IF DelayDays < 0 then DelayDays := 0;
                end;

                Comment.reset();
                Comment.SetRange("Header No.", TheMembers."No.");
                If Comment.FindLast() then begin
                    StatusComment := Comment.Comment;
                end;

                if TheMember.Get(TheMembers."Member No.") then begin
                end;

                TheMembers.CalcFields("Member Name");

                Datum.Add('member_no', TheMembers."Member No.");
                Datum.Add('member_name', TheMembers."Member Name");
                Datum.Add('application_date', GlobalFunctions.FormatISODate(TheMembers."Application Date"));
                Datum.Add('application_time', GlobalFunctions.FormatISOTime(TheMembers."Application Time"));
                Datum.Add('application_no', TheMembers."No.");

                Datum.Add('crm_originating_branch', TheMembers."CRM Branch");
                Datum.Add('crm_created_by', TheMembers."CRM Created By");
                Datum.Add('status', Format(TheMembers.Status));

                Datum.Add('action_date', GlobalFunctions.FormatISODate(TheMembers."Approval Date"));
                Datum.Add('action_time', GlobalFunctions.FormatISOTime(TheMembers."Approval Time"));
                Datum.Add('approved_by', TheMembers."Approved By");
                // Datum.Add('employer_code', TheMembers.Employer);
                Datum.Add('employer_code', TheMember."Employer Code");
                TheMember.CalcFields("Employer Name");
                Datum.Add('employer_name', TheMember."Employer Name");

                Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
                Datum.Add('SLA_days', Format(SLADays));
                Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
                Datum.Add('tat_status', Format(TAtStatus));
                Datum.Add('status_comment', StatusComment);
                // Datum.Add('priority', Format(Priority));

                Data.Add(Datum);
            end until TheMembers.Next = 0;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', Data);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Member edits created within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetBusinessLoansTATReport(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheLoan: record Loans;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheLoan.Reset;
        TheLoan.SetRange("Source Unit", TheLoan."Source Unit"::"BUSINESS LOANS");
        TheLoan.SetRange(Posted, true);
        TheLoan.SetCurrentKey("Disbursement Date");
        TheLoan.SetAscending("Disbursement Date", false);
        TheLoan.SetRange("Mobile Loan", false);
        TheLoan.SetFilter("Source Aplication", '=%1|%2',
            TheLoan."Source Aplication"::CRM,
            TheLoan."Source Aplication"::"Mwalimu Smart"
        );

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheLoan.SetFilter("Disbursement Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheLoan.FindSet then begin
            RecRef.GetTable(TheLoan);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Business Loans TAT", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheLoan.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Loans disbursed within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetBusinessLoansTATReportXLSX(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheLoan: record Loans;
        SLA: record "Defined SLA";
        Comment: record "Loan Appraisal Comments";
        TheMember: record members;
        TheProduct: record "Product Factory";

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheLoan.Reset;
        TheLoan.SetRange("Source Unit", TheLoan."Source Unit"::"BUSINESS LOANS");
        TheLoan.SetRange(Posted, true);
        TheLoan.SetCurrentKey("Disbursement Date");
        TheLoan.SetAscending("Disbursement Date", false);
        TheLoan.SetRange("Mobile Loan", false);
        TheLoan.SetFilter("Source Aplication", '=%1|%2',
            TheLoan."Source Aplication"::CRM,
            TheLoan."Source Aplication"::"Mwalimu Smart"
        );

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheLoan.SetFilter("Disbursement Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheLoan.FindSet then begin
            repeat begin
                Clear(Datum);

                WorkDays := 0;
                SLADays := 0;
                DelayDays := 0;
                StatusComment := '';

                TheProduct.Reset;
                TheProduct.SetRange("Product ID", TheLoan."Loan Product Type");
                // TheProduct.SetLoadFields("Product ID", "CRM Product SLA Timeline");
                // TheProduct.SetAutoCalcFields("CRM Product SLA Timeline");

                if TheProduct.FindFirst then begin
                    // SLADays := TheProduct."CRM Product SLA Timeline";
                end;

                if SLADays = 0 then begin
                    SLA.reset();
                    SLA.SetRange("Origination Type", SLA."Origination Type"::"BUSINESS LOANS");
                    if SLA.findfirst() then
                        SLADays := SLA.SLA;
                end;

                if (TheLoan."Disbursement Date" <> 0D) and (TheLoan."Application Date" <> 0D) and (TheLoan."Application Time" <> 0T) and (TheLoan."disbursement time" <> 0T) then begin
                    Globalfunctions.HoursBetweenPeriods(TheLoan."Application Date", TheLoan."Application Time", TheLoan."Disbursement Date", TheLoan."disbursement time", Duration, WokedOnANonWorkingPeriod);
                    WorkDays := Duration;
                    DelayDays := WorkDays - (SLADays / 3);
                    IF DelayDays < 0 then DelayDays := 0;
                end;

                if TheMember.Get(TheLoan."Member No.") then begin
                end;

                Comment.reset();
                Comment.SetRange("Loan No.", TheLoan."Loan No.");
                If Comment.FindLast() then begin
                    StatusComment := Comment.Comment;
                end;

                Datum.Add('loan_product_type', TheLoan."Loan Product Type");
                Datum.Add('loan_product_type_name', TheLoan."Loan Product Type Name");
                Datum.Add('member_no', TheLoan."Member No.");
                Datum.Add('member_name', TheLoan."Member Name");
                Datum.Add('application_date', TheLoan."Application Date");
                Datum.Add('application_time', TheLoan."Application Time");
                Datum.Add('application_no', TheLoan."Loan No.");
                Datum.Add('crm_originating_branch', TheLoan."CRM Originating Branch");
                Datum.Add('crm_created_by', TheLoan."CRM Created By");
                Datum.Add('status', Format(TheLoan.Status));
                Datum.Add('action_date', TheLoan."Disbursement Date");
                Datum.Add('action_time', TheLoan."disbursement time");
                Datum.Add('approved_by', TheLoan."Approved By");
                Datum.Add('employer_code', TheLoan."Employer Code");

                TheMember.CalcFields("Employer Name");
                Datum.Add('employer_name', TheMember."Employer Name");

                Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
                Datum.Add('SLA_days', Format(SLADays));
                Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
                Datum.Add('tat_status', Format(TAtStatus));
                Datum.Add('status_comment', StatusComment);
                Datum.Add('priority', Format(Priority));

                Data.Add(Datum);
            end until TheLoan.Next = 0;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', Data);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Loans disbursed within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberReadmissionTATReport(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMembers: record "Member Application";

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMembers.Reset;
        TheMembers.SetRange("Type of Application", TheMembers."Type of Application"::Readmission);
        TheMembers.SetRange(Status, TheMembers.Status::Approved);
        TheMembers.SetCurrentKey("Application Date");
        TheMembers.SetAscending("Application Date", false);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMembers.SetFilter("Application Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheMembers.FindSet then begin
            RecRef.GetTable(TheMembers);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Member Readmission TAT", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheMembers.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Member readmissions initiated within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberReadmissionTATReportXLSX(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMembers: record "Member Application";
        SLA: record "Defined SLA";
        Comment: record "Comments";

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMembers.Reset;
        TheMembers.SetRange("Type of Application", TheMembers."Type of Application"::Readmission);
        TheMembers.SetRange(Status, TheMembers.Status::Approved);
        TheMembers.SetCurrentKey("Application Date");
        TheMembers.SetAscending("Application Date", false);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMembers.SetFilter("Application Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheMembers.FindSet then begin
            repeat begin
                Clear(Datum);
                WorkDays := 0;
                SLADays := 0;
                DelayDays := 0;
                StatusComment := '';

                SLA.reset();
                SLA.SetRange("Origination Type", SLA."Origination Type"::"Member Readmission");
                if SLA.findfirst() then
                    SLADays := SLA.SLA;

                if (TheMembers."Date Approved" <> 0D) and (TheMembers."Application Date" <> 0D) and (TheMembers."Application Time" <> 0T) and (TheMembers."Approval Time" <> 0T) then begin
                    Globalfunctions.HoursBetweenPeriods(TheMembers."Application Date", TheMembers."Application Time", TheMembers."Date Approved", TheMembers."Approval Time", Duration, WokedOnANonWorkingPeriod);
                    WorkDays := Duration;
                    DelayDays := WorkDays - (SLADays / 3);
                    IF DelayDays < 0 then DelayDays := 0;
                end;
                Comment.reset();
                Comment.SetRange("Header No.", TheMembers."No.");
                If Comment.FindLast() then begin
                    StatusComment := Comment.Comment;
                end;

                TheMembers.CalcFields("Employer Name");

                Datum.Add('member_no', TheMembers."No.");
                Datum.Add('member_name', TheMembers.Name);
                Datum.Add('application_date', GlobalFunctions.FormatISODate(TheMembers."Application Date"));
                Datum.Add('application_time', TheMembers."Application Time");
                Datum.Add('application_no', TheMembers."No.");
                Datum.Add('originating_branch', TheMembers."CRM Originating Branch");
                Datum.Add('created_by', TheMembers."CRM Created By");
                Datum.Add('status', Format(TheMembers.Status));
                Datum.Add('action_date', TheMembers."Date Approved");
                Datum.Add('action_time', TheMembers."Approval Time");
                Datum.Add('approved_by', TheMembers."Approved By");
                Datum.Add('employer_code', TheMembers."Employer Code");
                Datum.Add('employer_name', TheMembers."Employer Name");

                Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
                Datum.Add('SLA_days', Format(SLADays));
                Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
                Datum.Add('tat_status', Format(TAtStatus));
                Datum.Add('status_comment', StatusComment);
                Datum.Add('priority', Format(Priority));

                Data.Add(Datum);
            end until TheMembers.Next = 0;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', Data);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Member readmissions initiated within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberWithdrawalTATReport(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMembers: record "Member withdrawal Notice";

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMembers.Reset;
        TheMembers.SetRange(Status, TheMembers.Status::Approved);
        TheMembers.SetCurrentKey("Withdrawal Notice Date");
        TheMembers.SetAscending("Withdrawal Notice Date", false);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMembers.SetFilter("Withdrawal Notice Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheMembers.FindSet then begin
            RecRef.GetTable(TheMembers);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Member Withdrawal TAT", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheMembers.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Member readmissions initiated within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberWithdrawalTATReportXLSX(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMembers: record "Member withdrawal Notice";
        SLA: record "Defined SLA";
        Comment: record "Comments";
        Member: Record Members;

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;
        EmployerCode: Text;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMembers.Reset;
        TheMembers.SetRange(Status, TheMembers.Status::Approved);
        TheMembers.SetCurrentKey("Withdrawal Notice Date");
        TheMembers.SetAscending("Withdrawal Notice Date", false);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMembers.SetFilter("Withdrawal Notice Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheMembers.FindSet then begin
            repeat begin
                Clear(Datum);
                WorkDays := 0;
                SLADays := 0;
                DelayDays := 0;
                EmployerCode := '';
                StatusComment := '';

                SLA.reset();
                SLA.SetRange("Origination Type", SLA."Origination Type"::"Membership Withdrawal");
                if SLA.findfirst() then
                    SLADays := SLA.SLA;

                if (TheMembers."Maturity Date" <> 0D) and (TheMembers."Date Entered" <> 0D) and (TheMembers."Time Entered" <> 0T) and (TheMembers."Maturity Time" <> 0T) then begin
                    Globalfunctions.HoursBetweenPeriods(TheMembers."Date Entered", TheMembers."Time Entered", TheMembers."Maturity Date", TheMembers."Maturity Time", Duration, WokedOnANonWorkingPeriod);
                    WorkDays := Duration;
                    DelayDays := WorkDays - (SLADays / 3);
                    IF DelayDays < 0 then DelayDays := 0;
                end;
                If Member.get(TheMembers."Member No.") then
                    EmployerCode := Member."Employer Code";
                Comment.reset();
                Comment.SetRange("Header No.", TheMembers."No.");
                If Comment.FindLast() then begin
                    StatusComment := Comment.Comment;
                end;

                Datum.Add('crm_application_no', TheMembers."CRM Application No.");
                Datum.Add('member_no', TheMembers."Member No.");
                Datum.Add('member_name', TheMembers.Name);
                Datum.Add('application_date', GlobalFunctions.FormatISODate(TheMembers."Date Entered"));
                Datum.Add('application_time', TheMembers."Time Entered");
                Datum.Add('application_no', TheMembers."No.");
                Datum.Add('originating_branch', TheMembers."CRM Originating Branch");
                Datum.Add('created_by', TheMembers."CRM Created By");
                Datum.Add('status', Format(TheMembers.Status));
                Datum.Add('action_date', TheMembers."Maturity Date");
                Datum.Add('action_time', TheMembers."maturity time");
                Datum.Add('approved_by', TheMembers."Finalized By");
                Datum.Add('employer_code', EmployerCode);
                Member.CalcFields("Employer Name");
                Datum.Add('employer_name', Member."Employer Name");
                Datum.Add('withdrawal_time', TheMembers."withdrawal time");
                Datum.Add('withdrawal_notice_date', TheMembers."Withdrawal Notice Date");

                Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
                Datum.Add('SLA_days', Format(SLADays));
                Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
                Datum.Add('tat_status', Format(TAtStatus));
                Datum.Add('status_comment', StatusComment);
                Datum.Add('priority', Format(Priority));

                Data.Add(Datum);
            end until TheMembers.Next = 0;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', data);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Member withdrawals initiated within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetBBFTATReport(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMembers: record "SinkFund Report Information";

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMembers.Reset;
        // TheMembers.SetRange(Posted, true);
        TheMembers.SetFilter(
            "Claim Type",
            '=%1|%2',
            TheMembers."Claim Type"::"BBF - Dependant Claim",
            TheMembers."Claim Type"::"BBF - Principle Claim");
        TheMembers.SetCurrentKey(Date);
        TheMembers.SetAscending(Date, false);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMembers.SetFilter(Date, '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheMembers.FindSet then begin
            RecRef.GetTable(TheMembers);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"BBF TAT", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheMembers.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('BBF claims initiated and posted within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetBBFTATReportXLSX(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMembers: record "SinkFund Report Information";
        SLA: record "Defined SLA";
        Comment: record "Comments";
        Member: Record Members;

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;
        EmployerCode: Text;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMembers.Reset;
        // TheMembers.SetRange(Posted, true);
        TheMembers.SetFilter(
            "Claim Type",
            '=%1|%2',
            TheMembers."Claim Type"::"BBF - Dependant Claim",
            TheMembers."Claim Type"::"BBF - Principle Claim");
        TheMembers.SetCurrentKey(Date);
        TheMembers.SetAscending(Date, false);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMembers.SetFilter(Date, '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheMembers.FindSet then begin
            repeat begin
                Clear(Datum);
                WorkDays := 0;
                SLADays := 0;
                DelayDays := 0;
                EmployerCode := '';
                StatusComment := '';

                SLA.reset();
                SLA.SetRange("Origination Type", SLA."Origination Type"::"BBF Claim");
                if SLA.findfirst() then
                    SLADays := SLA.SLA;

                if (TheMembers."Date Posted" <> 0D) and (TheMembers.Date <> 0D) and (TheMembers."Application Time" <> 0T) and (TheMembers."Time Posted" <> 0T) then begin
                    Globalfunctions.HoursBetweenPeriods(TheMembers.Date, TheMembers."Application Time", TheMembers."Date Posted", TheMembers."Time Posted", Duration, WokedOnANonWorkingPeriod);
                    WorkDays := Duration;
                    DelayDays := WorkDays - (SLADays / 3);
                    IF DelayDays < 0 then DelayDays := 0;
                end;
                If Member.get(TheMembers."Member No") then
                    EmployerCode := Member."Employer Code";

                Comment.reset();
                Comment.SetRange("Header No.", TheMembers.No);
                If Comment.FindLast() then begin
                    StatusComment := Comment.Comment;
                end;

                Datum.Add('member_no', Member."No.");
                Datum.Add('member_name', Member.Name);
                Datum.Add('application_date', GlobalFunctions.FormatISODate(TheMembers.Date));
                Datum.Add('application_time', TheMembers."Application Time");
                Datum.Add('application_no', TheMembers.No);
                Datum.Add('originating_branch', TheMembers."CRM Originating Branch");
                Datum.Add('created_by', TheMembers."CRM Created By");
                Datum.Add('status', Format(TheMembers.Status));
                Datum.Add('action_date', TheMembers."Date Posted");
                Datum.Add('action_time', TheMembers."Time Posted");
                Datum.Add('approved_by', TheMembers."Approved By");
                Datum.Add('employer_code', EmployerCode);
                Member.CalcFields("Employer Name");
                Datum.Add('employer_name', Member."Employer Name");

                Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
                Datum.Add('SLA_days', Format(SLADays));
                Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
                Datum.Add('tat_status', Format(TAtStatus));
                Datum.Add('status_comment', StatusComment);
                Datum.Add('priority', Format(Priority));

                Data.Add(Datum);
            end until TheMembers.Next = 0;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', Data);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('BBF claims initiated and posted within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetBBFInsuranceTATReport(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMembers: record "SinkFund Report Information";

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMembers.Reset;
        // TheMembers.SetRange(Posted, true);
        TheMembers.SetRange("Claim Type", TheMembers."Claim Type"::"BBF - Insurance Claim");
        TheMembers.SetCurrentKey(Date);
        TheMembers.SetAscending(Date, false);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMembers.SetFilter(Date, '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheMembers.FindSet then begin
            RecRef.GetTable(TheMembers);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"BBF Insurance TAT", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheMembers.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('BBF insurance claims initiated and posted within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetBBFInsuranceTATReportXLSX(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMembers: record "SinkFund Report Information";
        SLA: record "Defined SLA";
        Comment: record "Comments";
        Member: Record Members;

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;
        EmployerCode: Text;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMembers.Reset;
        // TheMembers.SetRange(Posted, true);
        TheMembers.SetFilter(
            "Claim Type",
            '=%1',
            TheMembers."Claim Type"::"BBF - Insurance Claim");
        TheMembers.SetCurrentKey(Date);
        TheMembers.SetAscending(Date, false);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMembers.SetFilter(Date, '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheMembers.FindSet then begin
            repeat begin
                Clear(Datum);
                WorkDays := 0;
                SLADays := 0;
                DelayDays := 0;
                EmployerCode := '';
                StatusComment := '';

                SLA.reset();
                SLA.SetRange("Origination Type", SLA."Origination Type"::"Insurance Claim");
                if SLA.findfirst() then
                    SLADays := SLA.SLA;

                if (TheMembers."Date Posted" <> 0D) and (TheMembers.Date <> 0D) and (TheMembers."Application Time" <> 0T) and (TheMembers."Time Posted" <> 0T) then begin
                    Globalfunctions.HoursBetweenPeriods(TheMembers.Date, TheMembers."Application Time", TheMembers."Date Posted", TheMembers."Time Posted", Duration, WokedOnANonWorkingPeriod);
                    WorkDays := Duration;
                    DelayDays := WorkDays - (SLADays / 3);
                    IF DelayDays < 0 then DelayDays := 0;
                end;
                If Member.get(TheMembers."Member No") then
                    EmployerCode := Member."Employer Code";

                Comment.reset();
                Comment.SetRange("Header No.", TheMembers.No);
                If Comment.FindLast() then begin
                    StatusComment := Comment.Comment;
                end;

                Datum.Add('member_no', Member."No.");
                Datum.Add('member_name', Member.Name);
                Datum.Add('application_date', GlobalFunctions.FormatISODate(TheMembers.Date));
                Datum.Add('application_time', TheMembers."Application Time");
                Datum.Add('application_no', TheMembers.No);
                Datum.Add('originating_branch', TheMembers."CRM Originating Branch");
                Datum.Add('created_by', TheMembers."CRM Created By");
                Datum.Add('status', Format(TheMembers.Status));
                Datum.Add('action_date', TheMembers."Date Posted");
                Datum.Add('action_time', TheMembers."Time Posted");
                Datum.Add('approved_by', TheMembers."Approved By");
                Datum.Add('employer_code', EmployerCode);
                Member.CalcFields("Employer Name");
                Datum.Add('employer_name', Member."Employer Name");

                Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
                Datum.Add('SLA_days', Format(SLADays));
                Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
                Datum.Add('tat_status', Format(TAtStatus));
                Datum.Add('status_comment', StatusComment);
                Datum.Add('priority', Format(Priority));

                Data.Add(Datum);
            end until TheMembers.Next = 0;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', Data);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('BBF insurance claims initiated and posted within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetShareTransferTATReport(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMembers: record "Share Capital Transfer Buffer";

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMembers.Reset;
        TheMembers.SetRange(Posted, true);
        TheMembers.SetCurrentKey("Application Date");
        TheMembers.SetAscending("Application Date", false);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMembers.SetFilter("Application Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheMembers.FindSet then begin
            RecRef.GetTable(TheMembers);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Institutional Capital TAT", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheMembers.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Institutional capital transfers initiated within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetShareTransferTATReportXLSX(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMembers: record "Share Capital Transfer Buffer";
        SLA: record "Defined SLA";
        Comment: record "Comments";
        Member: Record Members;

        ShareCapitalLines: Record "Share Capital Transfer Lines";
        DestinationMember: Record Members;

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;
        EmployerCode: Text;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMembers.Reset;
        TheMembers.SetRange(Posted, true);
        TheMembers.SetCurrentKey("Application Date");
        TheMembers.SetAscending("Application Date", false);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMembers.SetFilter("Application Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheMembers.FindSet then begin
            repeat begin
                ShareCapitalLines.Reset;
                ShareCapitalLines.SetRange("Document No.", TheMembers."Document No");

                repeat begin
                    Clear(Datum);
                    WorkDays := 0;
                    SLADays := 0;
                    DelayDays := 0;
                    EmployerCode := '';
                    StatusComment := '';

                    SLA.reset();
                    SLA.SetRange("Origination Type", SLA."Origination Type"::"Institutional Capital");
                    if SLA.findfirst() then
                        SLADays := SLA.SLA;

                    if (theMembers."Posting Date" <> 0D) and (theMembers."Application Date" <> 0D) and (theMembers."Application Time" <> 0T) and (theMembers."Posting Time" <> 0T) then begin
                        Globalfunctions.HoursBetweenPeriods(theMembers."Application Date", theMembers."Application Time", theMembers."Posting Date", theMembers."Posting Time", Duration, WokedOnANonWorkingPeriod);
                        WorkDays := Duration;
                        DelayDays := WorkDays - (SLADays / 3);
                        IF DelayDays < 0 then DelayDays := 0;
                    end;
                    If Member.get(TheMembers."Source Member No") then
                        EmployerCode := Member."Employer Code";
                    If DestinationMember.get(ShareCapitalLines."Destination Member No") then
                        EmployerCode := Member."Employer Code";

                    Comment.reset();
                    Comment.SetRange("Header No.", TheMembers."Document No");
                    If Comment.FindLast() then begin
                        StatusComment := Comment.Comment;
                    end;

                    Datum.Add('member_no', Member."No.");
                    Datum.Add('member_name', Member.Name);
                    Datum.Add('destination_member_no', DestinationMember."No.");
                    Datum.Add('destination_member_name', DestinationMember.Name);
                    Datum.Add('application_date', GlobalFunctions.FormatISODate(TheMembers."Application Date"));
                    Datum.Add('application_time', TheMembers."Application Time");
                    Datum.Add('application_no', TheMembers."Document No");
                    Datum.Add('originating_branch', TheMembers."CRM Originating Branch");
                    Datum.Add('created_by', TheMembers."CRM Created By");
                    Datum.Add('status', Format(TheMembers.Status));
                    Datum.Add('action_date', TheMembers."Posting Date");
                    Datum.Add('action_time', TheMembers."Posting Time");
                    Datum.Add('approved_by', TheMembers."Approved By");
                    Datum.Add('employer_code', EmployerCode);
                    Member.CalcFields("Employer Name");
                    Datum.Add('employer_name', Member."Employer Name");

                    Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
                    Datum.Add('SLA_days', Format(SLADays));
                    Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
                    Datum.Add('tat_status', Format(TAtStatus));
                    Datum.Add('status_comment', StatusComment);
                    Datum.Add('priority', Format(Priority));

                    Data.Add(Datum);

                end until ShareCapitalLines.Next = 0;

            end until TheMembers.Next = 0;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', Data);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Institutional capital transfers initiated within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetBBFRiskTATReport(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMembers: record "SinkFund Report Information";
        SLA: record "Defined SLA";
        Comment: record "Comments";
        Member: Record Members;

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;
        EmployerCode: Text;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMembers.Reset;
        // TheMembers.SetRange(Posted, true);
        TheMembers.SetRange("Claim Type", TheMembers."Claim Type"::"Risk Claim");
        TheMembers.SetCurrentKey(Date);
        TheMembers.SetAscending(Date, false);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMembers.SetFilter(Date, '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheMembers.FindSet then begin
            RecRef.GetTable(TheMembers);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Risk Claim TAT Report", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheMembers.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('BBF risk claims initiated and posted within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetBBFRiskTATReportXLSX(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheMembers: record "SinkFund Report Information";
        SLA: record "Defined SLA";
        Comment: record "Comments";
        Member: Record Members;

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;
        EmployerCode: Text;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheMembers.Reset;
        // TheMembers.SetRange(Posted, true);
        TheMembers.SetFilter(
            "Claim Type",
            '=%1',
            TheMembers."Claim Type"::"Risk Claim");
        TheMembers.SetCurrentKey(Date);
        TheMembers.SetAscending(Date, false);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheMembers.SetFilter(Date, '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheMembers.FindSet then begin
            repeat begin
                Clear(Datum);
                WorkDays := 0;
                SLADays := 0;
                DelayDays := 0;
                EmployerCode := '';
                StatusComment := '';

                SLA.reset();
                SLA.SetRange("Origination Type", SLA."Origination Type"::"Risk Claim");
                if SLA.findfirst() then
                    SLADays := SLA.SLA;

                if (TheMembers."Date Posted" <> 0D) and (TheMembers.Date <> 0D) and (TheMembers."Application Time" <> 0T) and (TheMembers."Time Posted" <> 0T) then begin
                    Globalfunctions.HoursBetweenPeriods(TheMembers.Date, TheMembers."Application Time", TheMembers."Date Posted", TheMembers."Time Posted", Duration, WokedOnANonWorkingPeriod);
                    WorkDays := Duration;
                    DelayDays := WorkDays - (SLADays / 3);
                    IF DelayDays < 0 then DelayDays := 0;
                end;
                If Member.get(TheMembers."Member No") then
                    EmployerCode := Member."Employer Code";

                Comment.reset();
                Comment.SetRange("Header No.", TheMembers.No);
                If Comment.FindLast() then begin
                    StatusComment := Comment.Comment;
                end;

                Datum.Add('member_no', Member."No.");
                Datum.Add('member_name', Member.Name);
                Datum.Add('application_date', GlobalFunctions.FormatISODate(TheMembers.Date));
                Datum.Add('application_time', TheMembers."Application Time");
                Datum.Add('application_no', TheMembers.No);
                Datum.Add('originating_branch', TheMembers."CRM Originating Branch");
                Datum.Add('created_by', TheMembers."CRM Created By");
                Datum.Add('status', Format(TheMembers.Status));
                Datum.Add('action_date', TheMembers."Date Posted");
                Datum.Add('action_time', TheMembers."Time Posted");
                Datum.Add('approved_by', TheMembers."Approved By");
                Datum.Add('employer_code', EmployerCode);
                Member.CalcFields("Employer Name");
                Datum.Add('employer_name', Member."Employer Name");

                Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
                Datum.Add('SLA_days', Format(SLADays));
                Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
                Datum.Add('tat_status', Format(TAtStatus));
                Datum.Add('status_comment', StatusComment);
                Datum.Add('priority', Format(Priority));

                Data.Add(Datum);
            end until TheMembers.Next = 0;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', Data);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('BBF risk claims initiated and posted within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetDepositVariationsTATReport(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheLoan: record "Product Variations";

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheLoan.Reset;
        TheLoan.SetCurrentKey("Application Date");
        TheLoan.SetAscending("Application Date", false);
        TheLoan.SetRange("Variation Type", TheLoan."Variation Type"::Savings);
        // TheLoan.SetRange(Posted, true);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheLoan.SetFilter("Application Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheLoan.FindSet then begin
            RecRef.GetTable(TheLoan);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Deposit Variation ", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheLoan.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Deposit variations requests within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetDepositVariationsTATReportXLSX(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheLoan: record "Product Variations";
        SLA: record "Defined SLA";
        Comment: record "Comments";
        Member: Record Members;

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;
        EmployerCode: Text;
        VariationTime: Time;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheLoan.Reset;
        TheLoan.SetCurrentKey("Application Date");
        TheLoan.SetAscending("Application Date", false);
        TheLoan.SetRange("Variation Type", TheLoan."Variation Type"::Savings);
        // TheLoan.SetRange(Posted, true);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheLoan.SetFilter("Application Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheLoan.FindSet then begin
            repeat begin
                Clear(Datum);
                WorkDays := 0;
                SLADays := 0;
                DelayDays := 0;
                EmployerCode := '';
                StatusComment := '';

                if TheLoan."Application Time" <> 0DT then begin
                    VariationTime := system.DT2Time(TheLoan."Application Time");
                end;
                SLA.reset();
                SLA.SetRange("Origination Type", SLA."Origination Type"::"Deposit Variation");
                if SLA.findfirst() then
                    SLADays := SLA.SLA;

                If (TheLoan."Application Date" <> 0D) and (VariationTime <> 0T) and (TheLoan."Posting Date" <> 0D) and (TheLoan."Posting Time" <> 0T) then begin
                    Globalfunctions.HoursBetweenPeriods(TheLoan."Application Date", VariationTime, TheLoan."Posting Date", TheLoan."Posting Time", Duration, WokedOnANonWorkingPeriod);
                    WorkDays := Duration;
                    DelayDays := WorkDays - (SLADays / 3);
                    IF DelayDays < 0 then DelayDays := 0;
                end;
                If Member.get(TheLoan."Member No.") then
                    EmployerCode := Member."Employer Code";

                Comment.reset();
                Comment.SetRange("Header No.", TheLoan."No.");
                If Comment.FindLast() then begin
                    StatusComment := Comment.Comment;
                end;

                Datum.Add('product_type', TheLoan."Product Type");
                Datum.Add('product_name', TheLoan."Product Name");
                Datum.Add('member_no', Member."No.");
                Datum.Add('member_name', Member.Name);
                Datum.Add('application_date', GlobalFunctions.FormatISODate(TheLoan."Application Date"));
                Datum.Add('application_time', VariationTime);
                Datum.Add('application_no', TheLoan."No.");
                Datum.Add('originating_branch', TheLoan."CRM Originating Branch");
                Datum.Add('created_by', TheLoan."CRM Created By");
                Datum.Add('status', Format(TheLoan.Status));
                Datum.Add('action_date', TheLoan."Posting Date");
                Datum.Add('action_time', TheLoan."Posting Time");
                Datum.Add('approved_by', TheLoan."Approved By");
                Datum.Add('employer_code', EmployerCode);
                Member.CalcFields("Employer Name");
                Datum.Add('employer_name', Member."Employer Name");

                Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
                Datum.Add('SLA_days', Format(SLADays));
                Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
                Datum.Add('tat_status', Format(TAtStatus));
                Datum.Add('status_comment', StatusComment);
                Datum.Add('priority', Format(Priority));

                Data.Add(Datum);
            end until TheLoan.Next = 0;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', Data);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Deposit variations requests within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanVariationsTATReport(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheLoan: record "Product Variations";

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheLoan.Reset;
        TheLoan.SetCurrentKey("Application Date");
        TheLoan.SetAscending("Application Date", false);
        TheLoan.SetRange("Variation Type", TheLoan."Variation Type"::Loan);
        // TheLoan.SetRange(Posted, true);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheLoan.SetFilter("Application Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheLoan.FindSet then begin
            RecRef.GetTable(TheLoan);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::" Loan Variation TAT", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheLoan.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Loan variations requests within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanVariationsTATReportXLSX(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheLoan: record "Product Variations";
        SLA: record "Defined SLA";
        Comment: record "Comments";
        Member: Record Members;

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;
        EmployerCode: Text;
        VariationTime: Time;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheLoan.Reset;
        TheLoan.SetCurrentKey("Application Date");
        TheLoan.SetAscending("Application Date", false);
        TheLoan.SetRange("Variation Type", TheLoan."Variation Type"::Loan);
        // TheLoan.SetRange(Posted, true);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheLoan.SetFilter("Application Date", '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheLoan.FindSet then begin
            repeat begin
                Clear(Datum);
                WorkDays := 0;
                SLADays := 0;
                DelayDays := 0;
                EmployerCode := '';
                StatusComment := '';

                if TheLoan."Application Time" <> 0DT then begin
                    VariationTime := system.DT2Time(TheLoan."Application Time");
                end;
                SLA.reset();
                SLA.SetRange("Origination Type", SLA."Origination Type"::"Loan Variation");
                if SLA.findfirst() then
                    SLADays := SLA.SLA;

                If (TheLoan."Application Date" <> 0D) and (VariationTime <> 0T) and (TheLoan."Posting Date" <> 0D) and (TheLoan."Posting Time" <> 0T) then begin
                    Globalfunctions.HoursBetweenPeriods(TheLoan."Application Date", VariationTime, TheLoan."Posting Date", TheLoan."Posting Time", Duration, WokedOnANonWorkingPeriod);
                    WorkDays := Duration;
                    DelayDays := WorkDays - (SLADays / 3);
                    IF DelayDays < 0 then DelayDays := 0;
                end;
                If Member.get(TheLoan."Member No.") then
                    EmployerCode := Member."Employer Code";

                Comment.reset();
                Comment.SetRange("Header No.", TheLoan."No.");
                If Comment.FindLast() then begin
                    StatusComment := Comment.Comment;
                end;

                Datum.Add('product_type', TheLoan."Product Type");
                Datum.Add('product_name', TheLoan."Product Name");
                Datum.Add('member_no', Member."No.");
                Datum.Add('member_name', Member.Name);
                Datum.Add('application_date', GlobalFunctions.FormatISODate(TheLoan."Application Date"));
                Datum.Add('application_time', VariationTime);
                Datum.Add('application_no', TheLoan."No.");
                Datum.Add('originating_branch', TheLoan."CRM Originating Branch");
                Datum.Add('created_by', TheLoan."CRM Created By");
                Datum.Add('status', Format(TheLoan.Status));
                Datum.Add('action_date', TheLoan."Posting Date");
                Datum.Add('action_time', TheLoan."Posting Time");
                Datum.Add('approved_by', TheLoan."Approved By");
                Datum.Add('employer_code', EmployerCode);
                Member.CalcFields("Employer Name");
                Datum.Add('employer_name', Member."Employer Name");

                Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
                Datum.Add('SLA_days', Format(SLADays));
                Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
                Datum.Add('tat_status', Format(TAtStatus));
                Datum.Add('status_comment', StatusComment);
                Datum.Add('priority', Format(Priority));

                Data.Add(Datum);
            end until TheLoan.Next = 0;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', Data);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Loan variations requests within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetGuarantorSubstitutionsTATReport(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheRecords: record "Guarantors Substitution";

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheRecords.Reset;
        TheRecords.SetCurrentKey(Date);
        TheRecords.SetAscending(Date, false);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheRecords.SetFilter(Date, '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheRecords.FindSet then begin
            RecRef.GetTable(TheRecords);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Guarantor Substitution TAT", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            PaginationObject.Add('record_count', TheRecords.Count);
            PaginationObject.Add('file', FileContentsB64);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Guarantor substitutions within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetGuarantorSubstitutionsTATReportXLSX(Payload: JsonObject): Text
    var
        start_date: JsonToken;
        end_date: JsonToken;

        TheRecords: record "Guarantors Substitution";
        SLA: record "Defined SLA";
        Comment: record "Comments";
        TheMember: Record members;
        TheLoan: Record loans;

        WorkDays: duration;
        SLADays: duration;
        DelayDays: duration;
        StatusComment: Text;
        WokedOnANonWorkingPeriod: Boolean;
        Duration: duration;
        TAtStatus: Option open,closed;
        Priority: Option Urgent,High,Normal;

        LoanName: Text[100];
        EmployerCode: Code[60];

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);

        TheRecords.Reset;
        TheRecords.SetRange(Posted, true);
        TheRecords.SetCurrentKey(Date);
        TheRecords.SetAscending(Date, false);

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                TheRecords.SetFilter(Date, '>=%1&<=%2', StartDate, EndDate);
            end else begin
                Error('Invalid start date and/or end date');
            end;
        end;

        IF TheRecords.FindSet then begin
            repeat begin
                Clear(Datum);

                WorkDays := 0;
                SLADays := 0;
                DelayDays := 0;
                EmployerCode := '';
                LoanName := '';
                StatusComment := '';

                SLA.reset();
                SLA.SetRange("Origination Type", SLA."Origination Type"::"Guarantor Substitution");
                if SLA.findfirst() then
                    SLADays := SLA.SLA;

                if (TheRecords."Approval Date" <> 0D) and (TheRecords.Date <> 0D) and (TheRecords."Application Time" <> 0T) and (TheRecords."Approval time" <> 0T) then begin
                    Globalfunctions.HoursBetweenPeriods(TheRecords.Date, TheRecords."Application Time", TheRecords."Approval Date", TheRecords."Approval Time", Duration, WokedOnANonWorkingPeriod);
                    WorkDays := Duration;
                    DelayDays := WorkDays - (SLADays / 3);
                    IF DelayDays < 0 then DelayDays := 0;
                end;

                If TheMember.get(TheRecords."Member No.") then
                    EmployerCode := TheMember."Employer Code";
                if TheLoan.get(TheRecords."Loan No.") then
                    LoanName := TheLoan."Loan Product Type Name";

                Comment.reset();
                Comment.SetRange("Header No.", TheRecords."No.");
                If Comment.FindLast() then begin
                    StatusComment := Comment.Comment;
                end;

                Datum.Add('product_type', TheLoan."Loan Product Type");
                Datum.Add('product_name', TheLoan."Loan Product Type Name");
                Datum.Add('member_no', TheMember."No.");
                Datum.Add('member_name', TheMember.Name);
                Datum.Add('application_date', TheRecords.SystemCreatedAt);
                Datum.Add('application_time', TheRecords."Application Time");
                Datum.Add('application_no', TheRecords."No.");
                Datum.Add('crm_originating_branch', TheRecords."CRM Originating Branch");
                Datum.Add('crm_created_by', TheRecords."CRM Created By");
                Datum.Add('status', Format(TheRecords.Status));
                Datum.Add('action_date', TheRecords."CRM Application No.");
                Datum.Add('action_time', TheRecords."AppLication Time");
                Datum.Add('approved_by', TheRecords."Approved By");
                Datum.Add('employer_code', TheMember."Employer Code");

                TheMember.CalcFields("Employer Name");
                Datum.Add('employer_name', TheMember."Employer Name");

                Datum.Add('work_days', GlobalFunctions.ConvertMillisecondsToCustomDays(WorkDays));
                Datum.Add('SLA_days', Format(SLADays));
                Datum.Add('delay_days', GlobalFunctions.ConvertMillisecondsToCustomDays(DelayDays));
                Datum.Add('tat_status', Format(TAtStatus));
                Datum.Add('status_comment', StatusComment);
                Datum.Add('priority', Format(Priority));

                Data.Add(Datum);
            end until TheRecords.Next = 0;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', Data);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            Error('Guarantor substitutions within the given time period NOT found');
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    // ------------------------------------------------------------------------------------------------------------------------------
    local procedure QueueEmail(Payload: JsonObject): Text
    var
        SkyEmail: CodeUnit "Sky Send Email";

        receiver_email_address: JsonToken;
        subject: JsonToken;
        content: JsonToken;
        content_type: JsonToken;
        email_category: JsonToken;
        request_application: JsonToken;
        attachments: JsonToken;

        KeyExists: Boolean;

        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        KeyExists := Payload.Get('receiver_email_address', receiver_email_address);
        KeyExists := Payload.Get('subject', subject);
        KeyExists := Payload.Get('content', content);
        KeyExists := Payload.Get('content_type', content_type);
        KeyExists := Payload.Get('email_category', email_category);
        KeyExists := Payload.Get('request_application', request_application);
        KeyExists := Payload.Get('attachments', attachments);

        // procedure QueueOutgoingEmail(
        //     ReceiverEmailAddress: Text;
        //     Subject: Text;
        //     ContentType: Text; // TEXT, HTML
        //     EmailCategory: Text;
        //     RequestApplication: Text
        SkyEmail.QueueOutgoingEmailWithAttachments(
            receiver_email_address.AsValue.AsText,
            subject.AsValue.AsText,
            content.AsValue.AsText,
            content_type.AsValue.AsText,
            email_category.AsValue.AsText,
            request_application.AsValue.AsText,
            attachments
        );

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Email has been queued successfully!');
        ResponseObject.Add('data', ResponseData);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetEmails(Payload: JsonObject): Text
    var
        filter_property: JsonToken;
        filter_value: JsonToken;
        start_date: JsonToken;
        end_date: JsonToken;
        page_number: JsonToken;
        page_size: JsonToken;

        KeyExists: Boolean;

        SkyEmails: Record "Sky Email Buffer";

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;
        Count: Integer;
        FirstRow: Integer;
        LastRow: Integer;
        TotalFoundRecords: Integer;
        SearchString: Text;

        ResponseObject: JsonObject;
        PaginationObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        KeyExists := Payload.Get('filter_property', filter_property);
        KeyExists := Payload.Get('filter_value', filter_value);
        KeyExists := Payload.Get('start_date', start_date);
        KeyExists := Payload.Get('end_date', end_date);
        Payload.Get('page_number', page_number);
        Payload.Get('page_size', page_size);

        SkyEmails.Reset;
        SkyEmails.SetCurrentKey(status_date);
        SkyEmails.SetAscending(status_date, false);

        // Search Value
        if (not filter_property.AsValue.IsNull) and (not filter_value.AsValue.IsNull) then begin
            if (filter_property.AsValue.AsText <> '') and (filter_value.AsValue.AsText <> '') then begin
                SearchString := filter_value.AsValue.AsText;

                case filter_property.AsValue.AsText of
                    'receiver_email_address':
                        SkyEmails.SetRange(SkyEmails.receiver_email_addresses, SearchString);
                end;
            end;
        end;

        // Start date & End date
        if (not start_date.AsValue.IsNull) AND (not end_date.AsValue.IsNull) then begin
            if (start_date.AsValue.AsText <> '') AND (end_date.AsValue.AsText <> '') then begin
                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));
                SkyEmails.SetFilter(bc_date, '>=%1&<=%2', StartDate, EndDate);
            end;
        end;

        SkyEmails.SetRange(request_application, 'CRM');

        IF SkyEmails.FindSet then begin
            // Data found
            Count := 0;
            FirstRow := ((page_number.AsValue.AsInteger - 1) * page_size.AsValue.AsInteger) + 1;
            LastRow := page_number.AsValue.AsInteger * page_size.AsValue.AsInteger;

            TotalFoundRecords := SkyEmails.Count;

            repeat begin
                Count += 1;

                if (Count >= FirstRow) and (Count <= LastRow) then begin
                    Datum.Add('originator_id', SkyEmails.originator_id);
                    Datum.Add('status_code', SkyEmails.status_code);
                    Datum.Add('status_name', SkyEmails.status_name);
                    Datum.Add('status_description', SkyEmails.status_description);
                    Datum.Add('sender_email_name', SkyEmails.sender_email_name);
                    Datum.Add('sender_email_address', SkyEmails.sender_email_address);
                    Datum.Add('email_type', SkyEmails.email_type);
                    Datum.Add('email_subject', SkyEmails.email_subject);
                    Datum.Add('email_message_body', SkyEmails.email_message_body);
                    Datum.Add('receiver_email_addresses', SkyEmails.receiver_email_addresses);
                    Datum.Add('schedule_email', SkyEmails.schedule_email);
                    Datum.Add('date_scheduled', SkyEmails.date_scheduled);
                    Datum.Add('status_date', GlobalFunctions.FormatISODateTime(SkyEmails.status_date));
                    Datum.Add('date_created', GlobalFunctions.FormatISODateTime(SkyEmails.date_created));

                    SkyEmails.CalcFields(attachments);
                    if SkyEmails.attachments.HasValue then begin
                        Datum.Add('has_attachment', true);
                    end else begin
                        Datum.Add('has_attachment', false);
                    end;

                    Data.Add(Datum);
                    // Reset
                    Datum.ReadFrom('{}');
                end;
            end until (Count = LastRow) or (SkyEmails.Next = 0);

            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end else begin
            PaginationObject.Add('page', page_number);
            PaginationObject.Add('page_size', page_size);
            PaginationObject.Add('total', TotalFoundRecords);
            PaginationObject.Add('data', Data);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('description', 'Request is successful');
            ResponseObject.Add('data', PaginationObject);
            AddDateTimeToResponse(ResponseObject);
        end;

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberMajorMinorLoansCount(Payload: JsonObject): Text
    var
        member_number: JsonToken;

        MemberLoaningDetails: JsonObject;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('member_number', member_number);

        MemberLoaningDetails := GlobalFunctions.GetMemberMajorMinorLoansCount(member_number.AsValue.AsText);

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', MemberLoaningDetails);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    // GLOBAL
    local procedure UnsupportedAction(RequestAction: Text): Text
    var
        ResponseObject: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        // ResponseObject.Add('status', 'ERROR');
        // ResponseObject.Add('description', 'The requested action ' + RequestAction + ' is NOT supported.');
        // ResponseObject.Add('errors', Errors);
        // AddDateTimeToResponse(ResponseObject);

        // ResponseObject.WriteTo(Response);

        // exit(Response);

        Error('The requested action ' + RequestAction + ' is NOT supported.');

        exit(Response);
    end;

    local procedure AddDateTimeToResponse(var ResponseObject: JsonObject)
    begin
        ResponseObject.Add('date_time', GlobalFunctions.FormatISODateTime(CurrentDateTime));
    end;

    local procedure TrimAndTruncateString(strVal: Text; maxLength: Integer): Text
    var
        TrimmedText: Text;
    begin
        // Trim leading and trailing spaces
        TrimmedText := strVal.Trim();

        // Truncate to a maximum of maxLength characters
        if STRLEN(TrimmedText) > maxLength then begin
            TrimmedText := COPYSTR(TrimmedText, 1, maxLength);
        end;

        exit(TrimmedText)
    end;

    var
        LoginToken: Text;
        VendorName: Label 'CRM - Dynamics 365';
        GlobalFunctions: Codeunit "Global Functions";
        EDMSFunctions: Codeunit "EDMS Functions";
        CRMOriginationType: Enum "CRM Originations";

        CFPage: Page "DMU CF Page";
}