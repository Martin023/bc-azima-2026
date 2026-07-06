codeunit 52186507 "Members Portal Integration"
{
    procedure HandleRequest(Request: Text): Text
    var
        RequestParser: JsonObject;
        RequestAction: JsonToken;
        RequestPayload: JsonToken;
        // RequestAPIId: JsonToken;
        HasToken: Boolean;
    begin
        if Request <> '' then begin
            RequestParser.ReadFrom(Request);
            RequestParser.SelectToken('$.action', RequestAction);
            // RequestParser.SelectToken('$.api_request_id', RequestAPIId);
            RequestParser.SelectToken('$.payload', RequestPayload);

            // API actions here
            case RequestAction.AsValue().AsText() of
                'SEARCH_MEMBER':
                    exit(SearchMember(RequestPayload.AsObject));
                'GET_MEMBER_GROUPS':
                    exit(GetMemberGroups(RequestPayload.AsObject));
                'GET_GROUP_MEMBERS':
                    exit(GetGroupMembers(RequestPayload.AsObject));
                'GET_MEMBER_DETAILS':
                    exit(GetMemberDetails(RequestPayload.AsObject));
                'GET_MEMBER_PROFILE_PHOTO':
                    exit(GetMemberProfilePhoto(RequestPayload.AsObject));
                'GET_MEMBER_PROFILE_SIGNATURE':
                    exit(GetMemberProfileSignature(RequestPayload.AsObject));
                'VALIDATE_ACCOUNT':
                    exit(ValidateAccount(RequestPayload.AsObject));
                'GET_ACCOUNTS':
                    exit(GetAccountsList(RequestPayload.AsObject));
                'GET_ACCOUNT_DETAILS':
                    exit(GetAccountDetails(RequestPayload.AsObject));
                'GET_ACCOUNT_STATEMENT':
                    exit(GetAccountStatement(RequestPayload.AsObject));
                'GET_ACCOUNT_STATEMENT_REPORT':
                    exit(GetAccountStatementReport(RequestPayload.AsObject));
                'GET_LOANS':
                    exit(GetLoansList(RequestPayload.AsObject));
                'GET_LOAN_DETAILS':
                    exit(GetLoanDetails(RequestPayload.AsObject));
                'GET_LOAN_STATEMENT':
                    exit(GetLoanStatement(RequestPayload.AsObject));
                'GET_LOAN_STATEMENT_REPORT':
                    exit(GetLoanStatementReport(RequestPayload.AsObject));
                'GET_LOAN_GUARANTORS':
                    exit(GetLoanGuarantors(RequestPayload.AsObject));
                'GET_LOANS_GUARANTEED':
                    exit(GetLoansGuaranteed(RequestPayload.AsObject));
                'GET_LOAN_TYPES':
                    exit(GetLoanTypes(RequestPayload.AsObject));
                'GET_LOAN_CALCULATOR_PARAMETERS':
                    exit(GetLoanCalcParams(RequestPayload.AsObject));
                'GET_LOAN_PURPOSES':
                    exit(GetLoanPurposes(RequestPayload.AsObject));
                'GET_DIVIDEND_PAYSLIP_PERIODS':
                    exit(GetDividendPayslipPeriods(RequestPayload.AsObject));
                'GET_DIVIDEND_PAYSLIP_REPORT':
                    exit(GetDividendPayslipReport(RequestPayload.AsObject));
                'GET_TRANSACTION_CHARGES':
                    exit(GetTransactionCharges(RequestPayload.AsObject));
                'INTERNAL_FUNDS_TRANSFER':
                    exit(InternalFundsTransfer(RequestPayload.AsObject));
                'GET_LOAN_REPAYMENT_SCHEDULE_REPORT':
                    exit(GetLoanRepaymentScheduleReport(RequestPayload.AsObject));
                'GET_MEMBER_RELIGIONS':
                    exit(GetMemberReligions(RequestPayload.AsObject));
                'GET_MEMBER_NATIONALITIES':
                    exit(GetMemberNationalities);
                'GET_MEMBER_CLASSES':
                    exit(GetMemberClasses);
                'MEMBER_REGISTRATION':
                    exit(CreateMemberApplication(RequestPayload.AsObject));
                'VALIDATE_MEMBER_REGISTRATION':
                    exit(ValidateMemberApplication(RequestPayload.AsObject));

                // STAFF
                'GET_STAFF_PAYSLIP_PERIODS':
                    exit(GetStaffPayslipPeriods(RequestPayload.AsObject));
                'GET_STAFF_PAYSLIP_REPORT':
                    exit(GetStaffPayslipReport(RequestPayload.AsObject));

                'GET_STAFF_P9_PERIODS':
                    exit(GetStaffP9Periods(RequestPayload.AsObject));
                'GET_STAFF_P9_REPORT':
                    exit(GetStaffP9Report(RequestPayload.AsObject));

                // Staff leave
                'GET_STAFF_LEAVE_TYPES':
                    exit(GetStaffLeaveTypes(RequestPayload.AsObject));
                'GET_STAFF_LEAVE_RELIEVER':
                    exit(GetStaffLeaveReliever(RequestPayload.AsObject));
                'GET_STAFF_LEAVE_STATISTICS':
                    exit(GetStaffLeaveStatistics(RequestPayload.AsObject));
                'CREATE_STAFF_LEAVE_APPLICATION_REQUEST':
                    exit(CreateStaffLeaveApplicationRequest(RequestPayload.AsObject));
                'GET_STAFF_LEAVE_APPLICATION_REQUESTS':
                    exit(GetStaffLeaveApplicationRequests(RequestPayload.AsObject));
                'CANCEL_STAFF_LEAVE_APPLICATION_REQUEST':
                    exit(CancelStaffLeaveApplicationRequest(RequestPayload.AsObject));
                'GET_STAFF_LEAVE_CALCULATION_REQUEST':
                    exit(GetStaffLeaveCalculationRequest(RequestPayload.AsObject));

                // Staff Loans
                'GET_STAFF_LOAN_APPLICATION_PRODUCTS':
                    exit(GetStaffLoanApplicationProducts(RequestPayload.AsObject));
                'GET_LOAN_SECTORS':
                    exit(GetLoanSectors(RequestPayload.AsObject));
                'CREATE_STAFF_LOAN_APPLICATION_REQUEST':
                    exit(CreateStaffLoanApplicationRequest(RequestPayload.AsObject));
                'GET_STAFF_LOAN_APPLICATION_REQUESTS':
                    exit(GetStaffLoanApplicationRequests(RequestPayload.AsObject));

                // LOAN APPLICATION + GUARANTORSHIP
                'GET_NET_SALARY_AMOUNT':
                    exit(GetNetSalaryAmount(RequestPayload.AsObject));
                'GET_MOBILE_LOAN_QUALIFICATION_AMOUNT':
                    exit(GetMobileLoanQualificationAmount(RequestPayload.AsObject));
                'GET_LOAN_APPLICATION_PRODUCTS':
                    exit(GetLoanApplicationProducts(RequestPayload.AsObject));
                'VALIDATE_GUARANTOR_ELIGIBILITY_REQUEST':
                    exit(ValidateGuarantorEligibilityRequest(RequestPayload.AsObject));
                'CREATE_LOAN_APPLICATION_REQUEST':
                    exit(CreateLoanApplicationRequest(RequestPayload.AsObject));
                'GET_LOAN_APPLICATION_REQUESTS':
                    exit(GetLoanApplicationRequests(RequestPayload.AsObject));
                'GET_LOAN_APPLICATION_REQUEST':
                    exit(GetLoanApplicationRequest(RequestPayload.AsObject));
                'EDIT_LOAN_APPLICATION_REQUEST':
                    exit(EditLoanApplicationRequest(RequestPayload.AsObject));
                'CANCEL_LOAN_APPLICATION_REQUEST':
                    exit(CancelLoanApplicationRequest(RequestPayload.AsObject));
                'MANAGE_LOAN_APPLICATION_GUARANTORS_REQUEST':
                    exit(ManageLoanGuarantorsRequest(RequestPayload.AsObject));
                'GET_LOAN_GUARANTORSHIP_REQUESTS':
                    exit(GetLoanGuarantorshipRequests(RequestPayload.AsObject));
                'GET_LOAN_GUARANTORSHIP_REQUEST':
                    exit(GetLoanGuarantorshipRequest(RequestPayload.AsObject));
                'ACTION_LOAN_GUARANTORSHIP_REQUEST':
                    exit(ActionLoanGuarantorshipRequest(RequestPayload.AsObject));

                // Loan guarantor substitution
                'CREATE_LOAN_GUARANTOR_SUBSTITUTION_REQUEST':
                    exit(CreateLoanGuarantorSubstitutionRequest(RequestPayload.AsObject));
                'GET_LOAN_GUARANTOR_SUBSTITUTION_REQUESTS':
                    exit(GetLoanGuarantorSubstitutionRequests(RequestPayload.AsObject));
                'CANCEL_LOAN_GUARANTOR_SUBSTITUTION_REQUEST':
                    exit(CancelLoanGuarantorSubstitutionRequest(RequestPayload.AsObject));

                'MANAGE_LOAN_GUARANTORSHIP_SUBSTITUTION_REQUEST':
                    exit(ManageLoanGuarantorshipSubstitutionRequest(RequestPayload.AsObject));
                'GET_LOAN_GUARANTORSHIP_SUBSTITUTION_REQUESTS':
                    exit(GetLoanGuarantorshipSubstitutionRequests(RequestPayload.AsObject));
                'GET_LOAN_GUARANTORSHIP_SUBSTITUTION_REQUEST':
                    exit(GetLoanGuarantorshipSubstitutionRequest(RequestPayload.AsObject));
                'ACTION_LOAN_GUARANTORSHIP_SUBSTITUTION_REQUEST':
                    exit(ActionLoanGuarantorshipSubstitutionRequest(RequestPayload.AsObject));

                //Loan Variations
                'CREATE_LOAN_VARIATION_REQUEST':
                    exit(CreateLoanVariationRequest(RequestPayload.AsObject));
                'GET_LOAN_VARIATION_REQUESTS':
                    exit(GetLoanVariationRequests(RequestPayload.AsObject));
                'CANCEL_LOAN_VARIATION_REQUEST':
                    exit(CancelLoanVariationRequest(RequestPayload.AsObject));

                //Savings Variations
                'GET_MEMBER_MIN_DEPOSIT_LIMIT_REQUEST':
                    exit(GetMemberMinDepositLimitRequest(RequestPayload.AsObject));
                'CREATE_DEPOSIT_VARIATION_REQUEST':
                    exit(CreateDepositVariationRequest(RequestPayload.AsObject));
                'GET_DEPOSIT_VARIATION_REQUESTS':
                    exit(GetDepositVariationRequests(RequestPayload.AsObject));
                'CANCEL_DEPOSIT_VARIATION_REQUEST':
                    exit(CancelDepositVariationRequest(RequestPayload.AsObject()));

                // Next of Kin
                'GET_NEXT_OF_KIN':
                    exit(GetMemberNOKList(RequestPayload.AsObject));
                'GET_NEXT_OF_KIN_IDENTIFICATION_TYPES':
                    exit(GetNOKIdentificationTypes(RequestPayload.AsObject));
                'GET_NEXT_OF_KIN_RELATIONSHIPS':
                    exit(GetNokRelationships(RequestPayload.AsObject));
                'CREATE_NEXT_OF_KIN_APPLICATION_REQUEST':
                    exit(CreateNextOfKinApplicationRequest(RequestPayload.AsObject));
                'GET_NEXT_OF_KIN_APPLICATION_REQUESTS':
                    exit(GetNextOfKinApplicationRequests(RequestPayload.AsObject));
                'GET_NEXT_OF_KIN_APPLICATION_REQUEST':
                    exit(GetNextOfKinApplicationRequest(RequestPayload.AsObject));
                'CANCEL_NEXT_OF_KIN_APPLICATION_REQUEST':
                    exit(CancelNextOfKinApplicationRequest(RequestPayload.AsObject));

                'UPDATE_NEXT_OF_KIN_APPLICATION_REQUEST':
                    exit(UpdateNextOfKinApplicationRequest(RequestPayload.AsObject));
                'DELETE_NEXT_OF_KIN_APPLICATION_REQUEST':
                    exit(DeleteNextOfKinApplicationRequest(RequestPayload.AsObject));

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

                // Store Requisitions
                'GET_STORE_REQUISITION_ITEMS':
                    exit(GetStoreRequisitionItems(RequestPayload.AsObject));
                'CREATE_STORE_REQUISITION_REQUEST':
                    exit(CreateStoreRequisitionRequest(RequestPayload.AsObject));
                'GET_STORE_REQUISITION_REQUESTS':
                    exit(GetStoreRequisitionRequests(RequestPayload.AsObject));
                'GET_STORE_REQUISITION_REQUEST':
                    exit(GetStoreRequisitionRequest(RequestPayload.AsObject));
                'CANCEL_STORE_REQUISITION_REQUEST':
                    exit(CancelStoreRequisitionRequest(RequestPayload.AsObject));

                // Share Certificate
                'GET_SHARE_CERTIFICATE_REPORT':
                    exit(GetShareCertificateReport(RequestPayload.AsObject));

                // Fixed Deposit Contracts
                'GET_FD_ACCOUNTS':
                    exit(GetFDAccountsList(RequestPayload.AsObject));
                'GET_FD_MATURITY_INSTRUCTIONS':
                    exit(GetFDAccountMaturityInstructions(RequestPayload.AsObject));
                'UPDATE_FD_MATURITY_INSTRUCTION_REQUEST':
                    exit(UpdateFDAccountMaturityRequest(RequestPayload.AsObject));

                'CREATE_MEMBER_EDIT_SIGNATURE_REQUEST':
                    exit(CreateMemberEditSignatureRequest(RequestPayload.AsObject));

                'CREATE_MEMBER_EDIT_PICTURE_REQUEST':
                    exit(CreateMemberEditPictureRequest(RequestPayload.AsObject));

                // Loan Calc
                'LOAN_CALCULATOR':
                    exit(LoanCalculator(RequestPayload.AsObject));

                'TEST':
                    exit(Test);

                else
                    exit(UnsupportedAction(RequestAction.AsValue.AsText))
            end;

        end else begin
            exit('');
        end;
    end;

    local procedure Test(): Text
    var
        TheLoanApplicationDocuments: Record "Channel Application Documents";
        EDMSFunctions: Codeunit "EDMS Functions";
        EDMSFileTypes: enum "EDMS File Types";

        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        RecRef: RecordRef;
        XmlDoc: XmlDocument;
        ReportParameters: Text;

        StoreImageRef: FieldRef;
        StoreRecRef: RecordRef;
        Base64Convert: Codeunit "Base64 Convert";

        LoanNo: Label 'LN00000310';
        LoanApplication: Record Loans;

        MAppNo: Label 'MA0000027';
        MemberApplication: Record "Member Application";
    begin
        // // Loan app test
        LoanApplication.Reset;
        LoanApplication.SetRange("Loan No.", LoanNo);
        if LoanApplication.FindFirst() then begin
            TheLoanApplicationDocuments.Reset;
            Clear(TheLoanApplicationDocuments);
            TheLoanApplicationDocuments.Init;

            TheLoanApplicationDocuments."Application Type" := TheLoanApplicationDocuments."Application Type"::"Loan Application";
            TheLoanApplicationDocuments."Application No." := LoanNo;
            TheLoanApplicationDocuments."Document Name" := StrSubstNo('%1-LoanApplicationForm.pdf', LoanNo);

            XmlDocument.ReadFrom(
                StrSubstNo(
                    '<ReportParameters name="Loan Application Report" id="%1"><DataItems><DataItem name="Loans">VERSION(1) SORTING(Field1) WHERE(Field1=1(%2))</DataItem><DataItem name="LoanGuarantors">VERSION(1) SORTING(Field1,Field2,Field26,Field27)</DataItem><DataItem name="Loans Top up">VERSION(1) SORTING(Field1,Field3,Field2)</DataItem></DataItems></ReportParameters>',
                    Report::"Loan Application Report",
                    LoanNo
                ),
                XmlDoc
            );
            XmlDoc.WriteTo(ReportParameters);

            // Blob
            TempBlob.CreateOutStream(OutStr);
            Clear(TheLoanApplicationDocuments.Document);
            StoreRecRef.Open(52186564);
            StoreImageRef := StoreRecRef.Field(TheLoanApplicationDocuments.FieldNo(Document));
            RecRef.GetTable(LoanApplication);
            Report.SaveAs(Report::"Loan Application Report", ReportParameters, ReportFormat::Pdf, OutStr, RecRef);
            TempBlob.ToFieldRef(StoreImageRef);
            StoreImageRef.TestField();

            TheLoanApplicationDocuments.Document := StoreImageRef.Value;
            TheLoanApplicationDocuments."Document Extension" := EDMSFunctions.GetFileTypeFromFileName(TheLoanApplicationDocuments."Document Name");

            TheLoanApplicationDocuments.Insert(true);

            Clear(TempBlob);
            Clear(OutStr);
            Clear(Base64Convert);
            Clear(StoreRecRef);
            Clear(StoreImageRef);
            Clear(RecRef);
        end;

        // Member app test
        MemberApplication.Reset;
        MemberApplication.SetRange("No.", MAppNo);
        if MemberApplication.FindFirst() then begin
            TheLoanApplicationDocuments.Reset;
            Clear(TheLoanApplicationDocuments);
            TheLoanApplicationDocuments.Init;

            TheLoanApplicationDocuments."Application Type" := TheLoanApplicationDocuments."Application Type"::"Member Application";
            TheLoanApplicationDocuments."Application No." := MAppNo;
            TheLoanApplicationDocuments."Document Name" := StrSubstNo('%1-MemberApplicationForm.pdf', MAppNo);

            XmlDocument.ReadFrom(
                StrSubstNo(
                    '<ReportParameters name="Online M Application Report" id="%1"><DataItems><DataItem name="Member Application">VERSION(1) SORTING(Field1) WHERE(Field1=1(%2))</DataItem><DataItem name="Next of KIN Application">VERSION(1) SORTING(Field1,Field15)</DataItem></DataItems></ReportParameters>',
                    Report::"Online M Application Report",
                    MemberApplication."No."
                ),
                XmlDoc
            );
            XmlDoc.WriteTo(ReportParameters);

            // Blob
            TempBlob.CreateOutStream(OutStr);
            Clear(TheLoanApplicationDocuments.Document);
            StoreRecRef.Open(52186564);
            StoreImageRef := StoreRecRef.Field(TheLoanApplicationDocuments.FieldNo(Document));
            RecRef.GetTable(MemberApplication);
            Report.SaveAs(Report::"Online M Application Report", ReportParameters, ReportFormat::Pdf, OutStr, RecRef);
            TempBlob.ToFieldRef(StoreImageRef);
            StoreImageRef.TestField();

            TheLoanApplicationDocuments.Document := StoreImageRef.Value;
            TheLoanApplicationDocuments."Document Extension" := EDMSFunctions.GetFileTypeFromFileName(TheLoanApplicationDocuments."Document Name");

            TheLoanApplicationDocuments.Insert(true);

            Clear(TempBlob);
            Clear(OutStr);
            Clear(Base64Convert);
            Clear(StoreRecRef);
            Clear(StoreImageRef);
            Clear(RecRef);
        end;
    end;

    // APIS
    local procedure SearchMember(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        search_identifier_type: JsonToken;
        search_identifier: JsonToken;

        RequestingMember: Record Members;
        SearchMember: Record Members;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        StaffDetails: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO, NATIONAL_ID, PASSPORT_NO, GROWER_NO
        Payload.Get('identifier', identifier);
        Payload.Get('search_identifier_type', search_identifier_type); // MSISDN, CUSTOMER_NO, NATIONAL_ID, PASSPORT_NO, GROWER_NO
        Payload.Get('search_identifier', search_identifier);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, RequestingMember, ResponseText, ResponseDescription) then begin
            if MemberExists(search_identifier_type.AsValue.AsText, search_identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
                Datum.Add('identifier_type', 'CUSTOMER_NO');
                Datum.Add('identifier', SearchMember."No.");
                Datum.Add('full_name', SearchMember.Name);
                Datum.Add('primary_email_address', SearchMember."E-Mail");
                Datum.Add('primary_mobile_number', SearchMember."Phone No.");

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Member’s details have been fetched successfully');
            end else begin
                ResponseObject.Add('status', ResponseText);
                ResponseObject.Add('status_description', ResponseDescription);
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberGroups(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        RequestingMember: Record Members;
        SignatoriesRec: Record "Account Signatories";
        SearchGroup: Record Members;

        Data: JsonArray;
        Datum: JsonObject;
        MemberDatum: JsonObject;
        ResponseObject: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
        MemberGroupsList: List of [Text];
        groupAccountNo: text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO, NATIONAL_ID, PASSPORT_NO, GROWER_NO
        Payload.Get('identifier', identifier);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, RequestingMember, ResponseText, ResponseDescription) then begin
            Clear(MemberGroupsList);
            SignatoriesRec.Reset();
            SignatoriesRec.SetRange("Member No.", identifier.AsValue.AsText);

            if SignatoriesRec.FindSet() then begin
                repeat

                    if SearchGroup.Get(SignatoriesRec."Account No") then begin
                        Clear(Datum);
                        Datum.Add('group_name', SearchGroup."Name");
                        Datum.Add('group_account_no', SignatoriesRec."Account No");
                        Data.Add(Datum);
                    end;
                until SignatoriesRec.Next() = 0;

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Groups for the member have been fetched successfully');
                ResponseObject.Add('data', Data);
            end else begin
                ResponseObject.Add('status', 'FAILED');
                ResponseObject.Add('status_description', 'No groups found for the given member');
            end;
        end else begin
            ResponseObject.Add('status', 'FAILED');
            ResponseObject.Add('status_description', 'Requesting member not found');
        end;
        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure GetGroupMembers(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        RequestingMember: Record Members;
        // SearchMember: Record Members;
        SignatoriesRec: Record "Account Signatories";
        ResponseObject: JsonObject;
        Datum: JsonObject;
        Data: JsonArray;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
        ResponseData: JsonObject;
        AddedMembers: List of [Text];
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO, NATIONAL_ID, PASSPORT_NO, GROWER_NO
        Payload.Get('identifier', identifier);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, RequestingMember, ResponseText, ResponseDescription) then begin
            SignatoriesRec.Reset();
            SignatoriesRec.SetRange("Account No", RequestingMember."No.");

            if SignatoriesRec.FindSet() then begin
                repeat
                    Clear(Datum);

                    Datum.Add('full_name', SignatoriesRec.Names);
                    Datum.Add('member_number', SignatoriesRec."Member No.");
                    Datum.Add('position', format(SignatoriesRec."Type"));

                    Data.Add(Datum);
                until SignatoriesRec.Next() = 0;

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('data', Data);
            end else begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'No members found for the given group');
            end;
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;
    end;


    local procedure GetMemberDetails(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        DimensionValues: Record "Dimension Value";
        TheEmployee: Record "HR Employees";
        SignatoriesRec: Record "Account Signatories";
        SearchGroup: Record Members;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        GroupDatum: JsonObject;
        GroupData: JsonArray;
        StaffDetails: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO, NATIONAL_ID, PASSPORT_NO, GROWER_NO
        Payload.Get('identifier', identifier);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            if SearchMember."Account Type" = SearchMember."Account Type"::"Single Member Account" then begin
                Datum.Add('customer_type', 'INDIVIDUAL');
            end else begin
                Datum.Add('customer_type', 'CORPORATE');
            end;

            Datum.Add('identifier_type', 'CUSTOMER_NO');
            Datum.Add('identifier', SearchMember."No.");
            Datum.Add('title', SearchMember.Salutation);
            Datum.Add('full_name', SearchMember.Name);
            Datum.Add('gender', Format(SearchMember.Gender).ToUpper);
            Datum.Add('date_of_birth', GlobalFunctions.FormatISODate(SearchMember."Date of Birth"));
            Datum.Add('primary_email_address', SearchMember."E-Mail");
            Datum.Add('primary_mobile_number', SearchMember."Phone No.");
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
            Datum.Add('member_class', SearchMember."Member Class");
            Datum.Add('main_savings_account_no', SkyMbankingTrans.GetMemberFosaAcc(SearchMember));
            Datum.Add('main_deposits_account_no', SkyMbankingTrans.GetMemberDepositsAcc(SearchMember));

            // Staff details
            if IsMemberAStaff(SearchMember) then begin
                Datum.Add('is_staff', true);

                TheEmployee.Reset;
                TheEmployee.SetRange("Member No.", SearchMember."No.");

                if TheEmployee.FindFirst then begin
                    StaffDetails.Add('employee_no', TheEmployee."No.");
                    StaffDetails.Add('email', TheEmployee."E-Mail");
                    StaffDetails.Add('status', Format(TheEmployee.Status).ToUpper);

                    Datum.Add('staff_details', StaffDetails);
                end;
            end else begin
                Datum.Add('is_staff', false);
            end;

            // Member Groups
            SignatoriesRec.Reset();
            SignatoriesRec.SetRange("Member No.", SearchMember."No.");

            if SignatoriesRec.FindSet() then begin
                repeat
                    Clear(SearchGroup);
                    SearchGroup.SetLoadFields(Name, "No.");
                    if SearchGroup.Get(SignatoriesRec."Account No") then begin
                        Clear(GroupDatum);
                        GroupDatum.Add('group_name', SearchGroup."Name");
                        GroupDatum.Add('group_no', SearchGroup."No.");
                        GroupData.Add(GroupDatum);
                    end;
                until SignatoriesRec.Next() = 0;
            end;

            Datum.Add('groups', GroupData);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Member’s Details list has been fetched successfully');
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberProfilePhoto(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        SearchMemberImageData: Record "Image Data";

        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        case identifier_type.AsValue.AsText of
            'MSISDN':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("Transactional Mobile Number", identifier.AsValue.AsText);
                    SearchMember.SetRange("Phone No.", identifier.AsValue.AsText);
                end;
            'MEMBER_NO', 'GROUP_NO':
                SearchMember.SetRange("No.", identifier.AsValue.AsText);
            'EMAIL':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("E-Mail", identifier.AsValue.AsText);
                    SearchMember.SetRange("Office E-Mail", identifier.AsValue.AsText);
                end;
            'ID_NO':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"ID Number");
                    SearchMember.SetRange("Primary Identification", identifier.AsValue.AsText);

                    if not SearchMember.FindFirst then begin
                        SearchMember.Reset;
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"ID Number");
                        SearchMember.SetRange("Secondary Identification", identifier.AsValue.AsText);
                    end;
                end;
            'PAYROLL_NO':
                SearchMember.SetRange("Payroll/Staff No.", identifier.AsValue.AsText);
            else
        end;

        IF SearchMember.HasFilter and SearchMember.FindFirst() then begin

            SearchMemberImageData.Reset;
            SearchMemberImageData.SetRange("Member No", SearchMember."No.");
            IF SearchMemberImageData.FindFirst then begin
                // Picture
                SearchMemberImageData.CalcFields(Picture);
                TempBlob.FromRecord(SearchMemberImageData, SearchMemberImageData.FieldNo(Picture));
                TempBlob.CreateInStream(InStr);
                Datum.Add('picture', Base64Convert.ToBase64(InStr));
            end else begin
                Datum.Add('picture', '');
            end;

            Datum.Add('picture_extension', 'PNG');

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Member’s photo has been fetched successfully');
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberProfileSignature(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        SearchMemberImageData: Record "Image Data";

        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        case identifier_type.AsValue.AsText of
            'MSISDN':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("Transactional Mobile Number", identifier.AsValue.AsText);
                    SearchMember.SetRange("Phone No.", identifier.AsValue.AsText);
                end;
            'MEMBER_NO', 'GROUP_NO':
                SearchMember.SetRange("No.", identifier.AsValue.AsText);
            'EMAIL':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("E-Mail", identifier.AsValue.AsText);
                    SearchMember.SetRange("Office E-Mail", identifier.AsValue.AsText);
                end;
            'ID_NO':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"ID Number");
                    SearchMember.SetRange("Primary Identification", identifier.AsValue.AsText);

                    if not SearchMember.FindFirst then begin
                        SearchMember.Reset;
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"ID Number");
                        SearchMember.SetRange("Secondary Identification", identifier.AsValue.AsText);
                    end;
                end;
            'PAYROLL_NO':
                SearchMember.SetRange("Payroll/Staff No.", identifier.AsValue.AsText);
            else
        end;

        IF SearchMember.HasFilter and SearchMember.FindFirst() then begin

            SearchMemberImageData.Reset;
            SearchMemberImageData.SetRange("Member No", SearchMember."No.");
            IF SearchMemberImageData.FindFirst then begin
                // Signature
                SearchMemberImageData.CalcFields(Signature);
                TempBlob.FromRecord(SearchMemberImageData, SearchMemberImageData.FieldNo(Signature));
                TempBlob.CreateInStream(InStr);
                Datum.Add('signature', Base64Convert.ToBase64(InStr));
            end else begin
                Datum.Add('signature', '');
            end;

            Datum.Add('signature_extension', 'PNG');

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Member’s signature has been fetched successfully');
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberNOKList(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        NOKList: Record "Next of KIN";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        case identifier_type.AsValue.AsText of
            'MSISDN':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("Transactional Mobile Number", identifier.AsValue.AsText);
                    SearchMember.SetRange("Phone No.", identifier.AsValue.AsText);
                end;
            'MEMBER_NO', 'GROUP_NO':
                SearchMember.SetRange("No.", identifier.AsValue.AsText);
            'EMAIL':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("E-Mail", identifier.AsValue.AsText);
                    SearchMember.SetRange("Office E-Mail", identifier.AsValue.AsText);
                end;
            'ID_NO':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"ID Number");
                    SearchMember.SetRange("Primary Identification", identifier.AsValue.AsText);

                    if not SearchMember.FindFirst then begin
                        SearchMember.Reset;
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"ID Number");
                        SearchMember.SetRange("Secondary Identification", identifier.AsValue.AsText);
                    end;
                end;
            'PAYROLL_NO':
                SearchMember.SetRange("Payroll/Staff No.", identifier.AsValue.AsText);
            else
        end;

        IF SearchMember.HasFilter and SearchMember.FindFirst() then begin
            NOKList.Reset;
            NOKList.SetRange("Record ID", SearchMember."No.");
            NOKList.SetRange(Removed, false);

            IF NOKList.FindSet then begin
                repeat begin
                    Datum.Add('name', NOKList.Name);
                    Datum.Add('relationship', NOKList.Relationship);
                    Datum.Add('allocation', NOKList.Allocation);
                    Datum.Add('status', 'Approved');
                    Datum.Add('address', NOKList.Address);
                    Datum.Add('phone_number', NOKList.Telephone);
                    Datum.Add('id_type', Format(NOKList."Identification Type"));
                    Datum.Add('id_number', NOKList.Identification);
                    Datum.Add('email_address', NOKList.Email);
                    Datum.Add('is_deceased', NOKList.Deceased);
                    Datum.Add('is_beneficiary', NOKList."Is a Beneficiary");
                    Datum.Add('is_next_of_kin', NOKList."Is Next of Kin");
                    Datum.Add('is_nominee', NOKList."Is Nominee");
                    Datum.Add('is_contact_person', NOKList."Is Contact Person");
                    Datum.Add('is_removed', NOKList.Removed);

                    Data.Add(Datum);

                    // Reset
                    Datum.ReadFrom('{}');
                end until NOKList.Next = 0;
            end;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Member’s Next of Kin list has been fetched successfully');
            ResponseObject.Add('data', Data);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetAccountsList(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        SavingsAccountList: Record "Savings Accounts";
        SavingsProduct: Record "Product Factory";

        IsWithdrawable: Boolean;
        IsDepositable: Boolean;
        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        case identifier_type.AsValue.AsText of
            'MSISDN':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("Transactional Mobile Number", identifier.AsValue.AsText);
                    SearchMember.SetRange("Phone No.", identifier.AsValue.AsText);
                end;
            'MEMBER_NO', 'GROUP_NO':
                SearchMember.SetRange("No.", identifier.AsValue.AsText);
            'EMAIL':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("E-Mail", identifier.AsValue.AsText);
                    SearchMember.SetRange("Office E-Mail", identifier.AsValue.AsText);
                end;
            'ID_NO':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"ID Number");
                    SearchMember.SetRange("Primary Identification", identifier.AsValue.AsText);

                    if not SearchMember.FindFirst then begin
                        SearchMember.Reset;
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"ID Number");
                        SearchMember.SetRange("Secondary Identification", identifier.AsValue.AsText);
                    end;
                end;
            'PAYROLL_NO':
                SearchMember.SetRange("Payroll/Staff No.", identifier.AsValue.AsText);
            else
        end;

        IF SearchMember.HasFilter and SearchMember.FindFirst() then begin
            SavingsAccountList.Reset;
            SavingsAccountList.SetRange("Member No.", SearchMember."No.");
            SavingsAccountList.SetFilter("Product Category", '<>%1&<>%2', SavingsAccountList."Product Category"::"Unallocated Fund", SavingsAccountList."Product Category"::"Entrance Fee");

            SavingsAccountList.SetAutoCalcFields(
                "Balance (LCY)",
                "Authorised Over Draft",
                "Uncleared Cheques",
                "ATM Transactions",
                "Lien Placed",
                "Coop Transactions",
                "One Month Installment",
                "Sort Order"
            );

            SavingsAccountList.SetCurrentKey("Sort Order");
            SavingsAccountList.SetAscending("Sort Order", true);

            IF SavingsAccountList.FindSet then begin
                repeat begin
                    IsDepositable := false;
                    IsWithdrawable := false;

                    Datum.Add('account_number', SavingsAccountList."No.");

                    SavingsProduct.Reset;
                    SavingsProduct.SetRange("Product ID", SavingsAccountList."Product Type");

                    if SavingsProduct.FindFirst and (SavingsProduct."USSD Product Name" <> '') then begin
                        Datum.Add('account_name', SavingsProduct."USSD Product Name");
                    end else begin
                        Datum.Add('account_name', SavingsAccountList."Product Name");
                    end;

                    Datum.Add('account_type', SavingsAccountList."Global Dimension 2 Code");
                    Datum.Add('account_status', Format(SavingsAccountList.Status).ToUpper);
                    Datum.Add('currency', SavingsAccountList."Currency Code");

                    SavingsAccountList.CalcFields("Balance (LCY)");
                    Datum.Add('book_balance', SavingsAccountList."Balance (LCY)");
                    if SavingsAccountList."Product Category" = SavingsAccountList."Product Category"::"Share Capital" then begin
                        Datum.Add('available_balance', SavingsAccountList."Balance (LCY)");
                    end else begin
                        Datum.Add('available_balance', GlobalFunctions.GetSavingsAccountAvailableBalance(SavingsAccountList, false));
                    end;

                    if SavingsProduct.FindFirst then begin
                        if (SavingsProduct."Channels Ext. Transfer Options" = SavingsProduct."Channels Ext. Transfer Options"::"All - Deposit + Withdrawal") OR
                    (SavingsProduct."Channels Ext. Transfer Options" = SavingsProduct."Channels Ext. Transfer Options"::"Withdrawals Only") then begin
                            Datum.Add('can_withdraw', 'YES');
                            IsWithdrawable := true;
                        end else begin
                            Datum.Add('can_withdraw', 'NO');
                        end;
                        Datum.Add('max_withdrawable_amount', GlobalFunctions.GetSavingsAccountAvailableBalance(SavingsAccountList, false));

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
                        // Variation allowed?
                        Datum.Add('allow_variation', SavingsProduct."Variation Allowed");
                    end;

                    if IsDepositable and IsWithdrawable then begin
                        Datum.Add('actions', 'Deposits & Withdrawals');
                    end else begin
                        if IsDepositable then begin
                            Datum.Add('actions', 'Deposits');
                        end else if IsWithdrawable then begin
                            Datum.Add('actions', 'Withdrawals');
                        end else begin
                            Datum.Add('actions', 'NONE');
                        end;
                    end;

                    case SavingsAccountList."Product Category" of
                        SavingsAccountList."Product Category"::"Benevolent (BBF)",
                        SavingsAccountList."Product Category"::Risk:
                            Datum.Add('show_balance', false);
                        else
                            Datum.Add('show_balance', true);
                    end;

                    Datum.Add('monthly_contribution', SavingsAccountList."Monthly Contribution");
                    Datum.Add('prorata',
                CustomCuesCodeunit.Prorata(SavingsAccountList."Member No.", SavingsAccountList."Product Type")
                );

                    Data.Add(Datum);

                    // Reset
                    Datum.ReadFrom('{}');
                end until SavingsAccountList.Next = 0;
            end;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Member’s accounts list has been fetched successfully');
            ResponseObject.Add('data', Data);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetAccountDetails(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        account_number: JsonToken;

        SearchMember: Record Members;
        DimensionValues: Record "Dimension Value";
        SavingsAccount: Record "Savings Accounts";
        SavingsProduct: Record "Product Factory";

        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('account_number', account_number);

        SearchMember.Reset;

        case identifier_type.AsValue.AsText of
            'MSISDN':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("Transactional Mobile Number", identifier.AsValue.AsText);
                    SearchMember.SetRange("Phone No.", identifier.AsValue.AsText);
                end;
            'MEMBER_NO', 'GROUP_NO':
                SearchMember.SetRange("No.", identifier.AsValue.AsText);
            'EMAIL':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("E-Mail", identifier.AsValue.AsText);
                    SearchMember.SetRange("Office E-Mail", identifier.AsValue.AsText);
                end;
            'ID_NO':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"ID Number");
                    SearchMember.SetRange("Primary Identification", identifier.AsValue.AsText);

                    if not SearchMember.FindFirst then begin
                        SearchMember.Reset;
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"ID Number");
                        SearchMember.SetRange("Secondary Identification", identifier.AsValue.AsText);
                    end;
                end;
            'PAYROLL_NO':
                SearchMember.SetRange("Payroll/Staff No.", identifier.AsValue.AsText);
            else
        end;

        IF SearchMember.HasFilter and SearchMember.FindFirst() then begin
            SavingsAccount.Reset;

            SavingsAccount.SetRange("Member No.", SearchMember."No.");
            SavingsAccount.SetRange("No.", account_number.AsValue.AsText);

            if SavingsAccount.FindFirst then begin
                Datum.Add('account_number', SavingsAccount."No.");

                SavingsProduct.Reset;
                SavingsProduct.SetRange("Product ID", SavingsAccount."Product Type");

                if SavingsProduct.FindFirst and (SavingsProduct."USSD Product Name" <> '') then begin
                    Datum.Add('account_name', SavingsProduct."USSD Product Name");
                end else begin
                    Datum.Add('account_name', SavingsAccount."Product Name");
                end;

                Datum.Add('account_type', SavingsAccount."Global Dimension 2 Code");
                Datum.Add('account_status', Format(SavingsAccount.Status).ToUpper);
                Datum.Add('currency', SavingsAccount."Currency Code");

                SavingsAccount.CalcFields("Balance (LCY)");
                Datum.Add('book_balance', SavingsAccount."Balance (LCY)");
                if SavingsAccount."Product Category" = SavingsAccount."Product Category"::"Share Capital" then begin
                    Datum.Add('available_balance', SavingsAccount."Balance (LCY)");
                end else begin
                    Datum.Add('available_balance', GlobalFunctions.GetSavingsAccountAvailableBalance(SavingsAccount, true));
                end;

                SavingsAccount.CalcFields(
                    "Debit Amount",
                    "Credit Amount"
                );

                Datum.Add('credits', SavingsAccount."Credit Amount");
                Datum.Add('debits', SavingsAccount."Debit Amount");

                Datum.Add('monthly_contribution', SavingsAccount."Monthly Contribution");
                Datum.Add('prorata',
                CustomCuesCodeunit.Prorata(SavingsAccount."Member No.", SavingsAccount."Product Type")
                );

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Member’s account details have been fetched successfully');
            end else begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Account NOT found!');
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetAccountStatement(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        account_number: JsonToken;
        start_date: JsonToken;
        end_date: JsonToken;
        page: JsonToken;
        page_count: JsonToken;

        SearchMember: Record Members;
        SavingsAccount: Record "Savings Accounts";
        SavingsLedgerEntry: Record "Savings Ledger Entry";

        RunningBal: Decimal;
        TotalCredits: Decimal;
        TotalDebits: Decimal;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        Count: Integer;
        FirstRow: Integer;
        LastRow: Integer;
        TotalFoundRecords: Integer;

        ResponseObject: JsonObject;
        Entry: JsonObject;
        Entries: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('account_number', account_number);
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);
        Payload.Get('page', page);
        Payload.Get('page_count', page_count);

        SearchMember.Reset;

        case identifier_type.AsValue.AsText of
            'MSISDN':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("Transactional Mobile Number", identifier.AsValue.AsText);
                    SearchMember.SetRange("Phone No.", identifier.AsValue.AsText);
                end;
            'MEMBER_NO', 'GROUP_NO':
                SearchMember.SetRange("No.", identifier.AsValue.AsText);
            'EMAIL':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("E-Mail", identifier.AsValue.AsText);
                    SearchMember.SetRange("Office E-Mail", identifier.AsValue.AsText);
                end;
            'ID_NO':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"ID Number");
                    SearchMember.SetRange("Primary Identification", identifier.AsValue.AsText);

                    if not SearchMember.FindFirst then begin
                        SearchMember.Reset;
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"ID Number");
                        SearchMember.SetRange("Secondary Identification", identifier.AsValue.AsText);
                    end;
                end;
            'PAYROLL_NO':
                SearchMember.SetRange("Payroll/Staff No.", identifier.AsValue.AsText);
            else
        end;

        IF SearchMember.HasFilter and SearchMember.FindFirst() then begin
            SavingsAccount.Reset;

            SavingsAccount.SetRange("Member No.", SearchMember."No.");
            SavingsAccount.SetRange("No.", account_number.AsValue.AsText);

            if SavingsAccount.FindFirst then begin
                Count := 0;
                FirstRow := ((page.AsValue.AsInteger - 1) * page_count.AsValue.AsInteger) + 1;
                LastRow := page.AsValue.AsInteger * page_count.AsValue.AsInteger;

                SavingsLedgerEntry.Reset;
                SavingsLedgerEntry.SetCurrentkey("Entry No.");
                SavingsLedgerEntry.Ascending(false);
                SavingsLedgerEntry.SetRange("Customer No.", SavingsAccount."No.");

                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));

                SavingsLedgerEntry.SetFilter("Posting Date", '>=%1&<=%2', StartDate, EndDate);

                IF SavingsLedgerEntry.FindSet then begin
                    TotalFoundRecords := SavingsLedgerEntry.Count;
                    SavingsAccount.CalcFields("Balance (LCY)", "Authorised Over Draft", "Uncleared Cheques", "ATM Transactions", "Lien Placed");

                    repeat begin
                        Count += 1;

                        if (Count >= FirstRow) and (Count <= LastRow) then begin
                            RunningBal := GlobalFunctions.GetRunningBalance(SavingsLedgerEntry."Entry No.", SavingsLedgerEntry."Customer No.");

                            Entry.Add('entry_number', SavingsLedgerEntry."Entry No.");
                            Entry.Add('transaction_reference', SavingsLedgerEntry."Document No.");
                            Entry.Add('posting_date', Format(SavingsLedgerEntry."Posting Date"));
                            Entry.Add('description', SavingsLedgerEntry.Description);
                            Entry.Add('amount', Abs(SavingsLedgerEntry."Amount (LCY)"));
                            Entry.Add('running_balance', RunningBal);

                            IF SavingsLedgerEntry.Amount < 0 then begin
                                Entry.Add('entry_type', 'Credit');
                            end else begin
                                Entry.Add('entry_type', 'Debit');
                            end;

                            Entries.Add(Entry);
                            // Reset
                            Entry.ReadFrom('{}');
                        end;
                    end until (Count = LastRow) or (SavingsLedgerEntry.Next = 0);
                end;

                // Total Debits + Credits
                SavingsLedgerEntry.Reset;
                SavingsLedgerEntry.SetRange("Customer No.", SavingsAccount."No.");
                // Dont show reversed entries
                SavingsLedgerEntry.setrange(reversed, false);
                SavingsLedgerEntry.SetFilter("Posting Date", '>=%1&<=%2', StartDate, EndDate);
                SavingsLedgerEntry.SetCurrentkey("Entry No.");
                SavingsLedgerEntry.Ascending(true);

                IF SavingsLedgerEntry.FindSet then begin
                    Count := 0;
                    TotalCredits := 0;
                    TotalDebits := 0;

                    repeat begin
                        if Count = 0 then begin
                            RunningBal := GlobalFunctions.GetRunningBalance(SavingsLedgerEntry."Entry No.", SavingsLedgerEntry."Customer No.");
                            IF SavingsLedgerEntry.Amount < 0 then begin
                                RunningBal -= Abs(SavingsLedgerEntry."Amount (LCY)");
                            end else begin
                                RunningBal += Abs(SavingsLedgerEntry."Amount (LCY)");
                            end;
                        end;

                        IF SavingsLedgerEntry.Amount < 0 then begin
                            TotalCredits += Abs(SavingsLedgerEntry."Amount (LCY)");
                        end else begin
                            TotalDebits += Abs(SavingsLedgerEntry."Amount (LCY)");
                        end;

                        Count += 1;
                    end until SavingsLedgerEntry.Next = 0;
                end;

                Datum.Add('records', Entries);
                Datum.Add('page', page);
                Datum.Add('page_count', page_count);
                Datum.Add('total_records', TotalFoundRecords);
                Datum.Add('credits', TotalCredits);
                Datum.Add('debits', TotalDebits);
                Datum.Add('opening_balance', RunningBal);

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Member’s Account Statement has been fetched successfully');
            end else begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Account NOT found!');
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetAccountStatementReport(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        account_number: JsonToken;
        start_date: JsonToken;
        end_date: JsonToken;
        file_type: JsonToken;

        SearchMember: Record Members;
        SavingsAccount: Record "Savings Accounts";

        XMLDoc: XmlDocument;
        ReportParameters: Text;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        Entry: JsonObject;
        Entries: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('account_number', account_number);
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);
        Payload.Get('file_type', file_type);

        SearchMember.Reset;

        case identifier_type.AsValue.AsText of
            'MSISDN':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("Transactional Mobile Number", identifier.AsValue.AsText);
                    SearchMember.SetRange("Phone No.", identifier.AsValue.AsText);
                end;
            'MEMBER_NO', 'GROUP_NO':
                SearchMember.SetRange("No.", identifier.AsValue.AsText);
            'EMAIL':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("E-Mail", identifier.AsValue.AsText);
                    SearchMember.SetRange("Office E-Mail", identifier.AsValue.AsText);
                end;
            'ID_NO':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"ID Number");
                    SearchMember.SetRange("Primary Identification", identifier.AsValue.AsText);

                    if not SearchMember.FindFirst then begin
                        SearchMember.Reset;
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"ID Number");
                        SearchMember.SetRange("Secondary Identification", identifier.AsValue.AsText);
                    end;
                end;
            'PAYROLL_NO':
                SearchMember.SetRange("Payroll/Staff No.", identifier.AsValue.AsText);
            else
        end;

        IF SearchMember.HasFilter and SearchMember.FindFirst() then begin
            SavingsAccount.Reset;

            SavingsAccount.SetRange("Member No.", SearchMember."No.");
            SavingsAccount.SetRange("No.", account_number.AsValue.AsText);

            if SavingsAccount.FindSet then begin
                XmlDocument.ReadFrom(
                    '<ReportParameters name="Savings Statement" id="' + Format(Report::"Savings Statement") +
                    '"><Options><Field name="StartDate">' + start_date.AsValue.AsText +
                    '</Field><Field name="EndDate">' + end_date.AsValue.AsText +
                    '</Field><Field name="StatementCharge">false</Field><Field name="AccountwithLien">false</Field></Options><DataItems><DataItem name="SavingsAccounts">VERSION(1) SORTING(Field1) WHERE(Field1=1(' + Format(SavingsAccount."No.") +
                    '))</DataItem><DataItem name="SavingsLedgerEntry">VERSION(1) SORTING(Field3,Field4,Field11)</DataItem></DataItems></ReportParameters>', XmlDoc);

                XmlDoc.WriteTo(ReportParameters);

                RecRef.GetTable(SavingsAccount);

                BlobOutStream := TempBlob.CreateOutStream;
                case file_type.AsValue.AsText of
                    'PDF':
                        Report.SaveAs(Report::"Savings Statement", ReportParameters, ReportFormat::Pdf, BlobOutStream, RecRef);
                    'XLSX':
                        Report.SaveAs(Report::"Savings Statement", ReportParameters, ReportFormat::Excel, BlobOutStream, RecRef);
                end;

                BlobInStream := TempBlob.CreateInStream;
                FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

                Datum.Add('file', FileContentsB64);
                Datum.Add('file_type', file_type);

                case file_type.AsValue.AsText of
                    'PDF':
                        Datum.Add('file_name', SearchMember."No." + ' - ' + SavingsAccount."No." + ' Account Statement.pdf');
                    'XLSX':
                        Datum.Add('file_name', SearchMember."No." + ' - ' + SavingsAccount."No." + ' Account Statement.xlsx');
                end;

                Datum.Add('file_size', StrLen(FileContentsB64));

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Member’s Account Statement report has been exported successfully');
            end else begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Account NOT found!');
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure ValidateAccount(Payload: JsonObject): Text
    var
        account_number: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        SavingsAccount: Record "Savings Accounts";
        SavingsProduct: Record "Product Factory";
        AccountOwner: Record Members;

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Datum: JsonObject;
        Response: Text;

        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('account_number', account_number);
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            SavingsAccount.Reset;
            SavingsAccount.FilterGroup := -1;
            SavingsAccount.SetRange("No.", account_number.AsValue.AsText);
            SavingsAccount.SetRange("Old Account No", account_number.AsValue.AsText);

            SavingsAccount.SetLoadFields(
                "Product Type", Name, "No.", "Product Name", Status, "Member No."
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
                Datum.Add('account_balance', GlobalFunctions.GetSavingsAccountAvailableBalance(SavingsAccount, true));

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
                end else begin
                    MemberDetails.Add('full_name', '');
                    MemberDetails.Add('mobile_number', '');
                    MemberDetails.Add('id_number', '');
                end;
                Datum.Add('member_details', MemberDetails);

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('data', Datum);
            end else begin
                ResponseObject.Add('status', 'ERROR');
                Datum.Add('error_message', 'Account with number ' + account_number.AsValue.AsText + ' NOT found!');
                ResponseObject.Add('data', Datum);
            end;
        end else begin
            ResponseObject.Add('status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('data', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoansList(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        LoanAccountsList: Record Loans;
        SavingsProduct: Record "Product Factory";
        LoanRepaymentSchedule: Record "Ideal Repayment Schedule";
        CheckoffLines: Record "Checkoff Advice Line";
        MobileTransLines: Record "Mobile Transaction Types Lines";
        TotalCharges: Decimal;
        TotalChargesIFT: Decimal;
        MobileTransTypes: Record "Mobile Transaction Types";
        currCharges: List of [decimal];

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        case identifier_type.AsValue.AsText of
            'MSISDN':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("Transactional Mobile Number", identifier.AsValue.AsText);
                    SearchMember.SetRange("Phone No.", identifier.AsValue.AsText);
                end;
            'MEMBER_NO', 'GROUP_NO':
                SearchMember.SetRange("No.", identifier.AsValue.AsText);
            'EMAIL':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("E-Mail", identifier.AsValue.AsText);
                    SearchMember.SetRange("Office E-Mail", identifier.AsValue.AsText);
                end;
            'ID_NO':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"ID Number");
                    SearchMember.SetRange("Primary Identification", identifier.AsValue.AsText);

                    if not SearchMember.FindFirst then begin
                        SearchMember.Reset;
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"ID Number");
                        SearchMember.SetRange("Secondary Identification", identifier.AsValue.AsText);
                    end;
                end;
            'PAYROLL_NO':
                SearchMember.SetRange("Payroll/Staff No.", identifier.AsValue.AsText);
            else
        end;

        IF SearchMember.HasFilter and SearchMember.FindFirst() then begin
            LoanAccountsList.Reset;
            LoanAccountsList.SetRange("Member No.", SearchMember."No.");
            LoanAccountsList.SetRange(Posted, true);
            LoanAccountsList.SetFilter("Total Loan Balance", '>%1', 0);

            IF LoanAccountsList.FindSet then begin
                MobileTransTypes.Reset;
                MobileTransTypes.SetRange(Type, MobileTransTypes.Type::"Loan Repayment");
                if MobileTransTypes.FindFirst then begin
                    MobileTransLines.Reset();
                    MobileTransLines.SetRange("Transaction Type", MobileTransTypes.Code);
                    MobileTransLines.SetFilter("Account No.", '<>%1', '');
                    if MobileTransLines.Findset() then begin
                        TotalCharges := 0;
                        repeat
                            currCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, LoanAccountsList."Outstanding Balance");
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
                            currCharges := SkyMbankingTrans.GetMpesaTransCharges(MobileTransLines, LoanAccountsList."Outstanding Balance");
                            TotalChargesIFT += currCharges.Get(1);
                        until MobileTransLines.next = 0;
                    end;
                end;

                repeat begin
                    LoanAccountsList.CalcFields(
                        "Outstanding Balance",
                        "Outstanding Interest",
                        "Daily Interest",
                        "Loan Amount",
                        "Repayment Advised"
                    );

                    Datum.Add('loan_number', LoanAccountsList."Loan No.");
                    Datum.Add('loan_type', LoanAccountsList."Loan Product Type Name");
                    Datum.Add('loan_type_id', LoanAccountsList."Loan Product Type");
                    Datum.Add('loan_source', Format(LoanAccountsList."Source Unit"));
                    Datum.Add('outstanding_balance', LoanAccountsList."Outstanding Balance");
                    Datum.Add('installments', LoanAccountsList.Installments);
                    Datum.Add('loan_status', Format(LoanAccountsList.Status));

                    if LoanAccountsList."Repayment Advised" <> 0 then begin
                        CheckoffLines.Reset;
                        CheckoffLines.SetRange("Loan No.", LoanAccountsList."Loan No.");
                        CheckoffLines.SetCurrentKey("Entry No");
                        CheckoffLines.SetAscending("Entry No", false);
                        if CheckoffLines.FindFirst then begin
                            Datum.Add('repayment_amount', CheckoffLines."Amount On");
                        end else begin
                            Datum.Add('repayment_amount', LoanAccountsList.Repayment);
                        end;
                    end else begin
                        Datum.Add('repayment_amount', LoanAccountsList.Repayment);
                    end;

                    Datum.Add('initial_repayment_amount', LoanAccountsList.Repayment);

                    Datum.Add('currency', 'KES');
                    Datum.Add('loan_principal', LoanAccountsList."Approved Amount");
                    Datum.Add('total_loan_amount', LoanAccountsList."Outstanding Balance" + LoanAccountsList."Outstanding Interest" + LoanAccountsList."Daily Interest");

                    LoanRepaymentSchedule.Reset;
                    LoanRepaymentSchedule.SetFilter("Repayment Date", '>%1', Today);
                    LoanRepaymentSchedule.SetRange("Loan No.", LoanAccountsList."Loan No.");
                    if LoanRepaymentSchedule.FindFirst then begin
                        Datum.Add('next_repayment_date', GlobalFunctions.FormatISODate(LoanRepaymentSchedule."Repayment Date"));
                    end else begin
                        Datum.Add('next_repayment_date', '');
                    end;

                    Datum.Add('expected_date_of_completion', GlobalFunctions.FormatISODate(LoanAccountsList."Expected Date of Completion"));

                    SavingsProduct.Reset;
                    SavingsProduct.SetRange("Product ID", LoanAccountsList."Loan Product Type");
                    if SavingsProduct.FindFirst then begin
                        Datum.Add('is_mobile_loan', SavingsProduct."Mobile Loan");
                        Datum.Add('minimum_guarantors', SavingsProduct."Minimum Guarantors");
                        Datum.Add('maximum_guarantors', SavingsProduct."Maximum Guarantors");
                    end;

                    Datum.Add('loan_repayment_charges', TotalCharges);
                    Datum.Add('total_repayment', LoanAccountsList."Outstanding Balance" + TotalCharges);

                    Datum.Add('loan_repayment_charges_ift', TotalChargesIFT);
                    Datum.Add('total_repayment_ift', LoanAccountsList."Outstanding Balance" + TotalChargesIFT);

                    Data.Add(Datum);

                    // Reset
                    Datum.ReadFrom('{}');
                end until LoanAccountsList.Next = 0;
            end;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Member’s loans list has been fetched successfully');
            ResponseObject.Add('data', Data);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanDetails(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        loan_number: JsonToken;

        SearchMember: Record Members;
        DimensionValues: Record "Dimension Value";
        TheLoan: Record Loans;
        LoanRepaymentSchedule: Record "Ideal Repayment Schedule";
        CheckoffLines: Record "Checkoff Advice Line";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('loan_number', loan_number);

        SearchMember.Reset;

        case identifier_type.AsValue.AsText of
            'MSISDN':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("Transactional Mobile Number", identifier.AsValue.AsText);
                    SearchMember.SetRange("Phone No.", identifier.AsValue.AsText);
                end;
            'MEMBER_NO', 'GROUP_NO':
                SearchMember.SetRange("No.", identifier.AsValue.AsText);
            'EMAIL':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("E-Mail", identifier.AsValue.AsText);
                    SearchMember.SetRange("Office E-Mail", identifier.AsValue.AsText);
                end;
            'ID_NO':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"ID Number");
                    SearchMember.SetRange("Primary Identification", identifier.AsValue.AsText);

                    if not SearchMember.FindFirst then begin
                        SearchMember.Reset;
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"ID Number");
                        SearchMember.SetRange("Secondary Identification", identifier.AsValue.AsText);
                    end;
                end;
            'PAYROLL_NO':
                SearchMember.SetRange("Payroll/Staff No.", identifier.AsValue.AsText);
            else
        end;

        IF SearchMember.HasFilter and SearchMember.FindFirst() then begin
            TheLoan.Reset;

            TheLoan.SetRange("Member No.", SearchMember."No.");
            TheLoan.SetRange("Loan No.", loan_number.AsValue.AsText);

            if TheLoan.FindFirst then begin
                TheLoan.CalcFields(
                        "Outstanding Balance",
                        "Loan Amount",
                        "Outstanding Interest",
                        "Daily Interest",
                        "Loans Category-SASRA",
                        "Repayment Advised"
                    );

                Datum.Add('loan_number', TheLoan."Loan No.");
                Datum.Add('loan_type', TheLoan."Loan Product Type Name");
                Datum.Add('loan_source', Format(TheLoan."Source Unit"));
                Datum.Add('application_date', GlobalFunctions.FormatISODate(TheLoan."Application Date"));
                Datum.Add('posting_date', GlobalFunctions.FormatISODate(TheLoan."Disbursement Date"));
                Datum.Add('outstanding_balance', TheLoan."Outstanding Balance");
                Datum.Add('loan_principal', TheLoan."Approved Amount");
                Datum.Add('outstanding_interest', TheLoan."Outstanding Interest");
                Datum.Add('daily_interest', TheLoan."Daily Interest");
                Datum.Add('total_loan_amount', TheLoan."Outstanding Balance" + TheLoan."Outstanding Interest" + TheLoan."Daily Interest");
                Datum.Add('installments', TheLoan.Installments);
                Datum.Add('loan_status', Format(TheLoan.Status));

                if TheLoan."Repayment Advised" <> 0 then begin
                    CheckoffLines.Reset;
                    CheckoffLines.SetRange("Loan No.", TheLoan."Loan No.");
                    CheckoffLines.SetCurrentKey("Entry No");
                    CheckoffLines.SetAscending("Entry No", false);
                    if CheckoffLines.FindFirst then begin
                        Datum.Add('repayment_amount', CheckoffLines."Amount On");
                    end else begin
                        Datum.Add('repayment_amount', TheLoan.Repayment);
                    end;
                end else begin
                    Datum.Add('repayment_amount', TheLoan.Repayment);
                end;

                Datum.Add('initial_repayment_amount', TheLoan.Repayment);

                Datum.Add('loan_category', Format(TheLoan."Loans Category-SASRA"));
                Datum.Add('currency', 'KES');

                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetFilter("Repayment Date", '>%1', Today);
                LoanRepaymentSchedule.SetRange("Loan No.", TheLoan."Loan No.");
                if LoanRepaymentSchedule.FindFirst then begin
                    Datum.Add('next_repayment_date', GlobalFunctions.FormatISODate(LoanRepaymentSchedule."Repayment Date"));
                end else begin
                    Datum.Add('next_repayment_date', '');
                end;

                Datum.Add('expected_date_of_completion', GlobalFunctions.FormatISODate(TheLoan."Expected Date of Completion"));

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Member’s loan details have been fetched successfully');
            end else begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Loan NOT found!');
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanStatement(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        loan_number: JsonToken;
        start_date: JsonToken;
        end_date: JsonToken;
        page: JsonToken;
        page_count: JsonToken;

        SearchMember: Record Members;
        TheLoan: Record Loans;
        CreditLedgerEntry: Record "Credit Ledger Entry";

        RunningBal: Decimal;
        TotalCredits: Decimal;
        TotalDebits: Decimal;

        StartDateTimeParts: List of [Text];
        StartDate: Date;
        EndDateTimeParts: List of [Text];
        EndDate: Date;

        Count: Integer;
        FirstRow: Integer;
        LastRow: Integer;
        TotalFoundRecords: Integer;
        RunningBalance: Decimal;

        ResponseObject: JsonObject;
        Entry: JsonObject;
        Entries: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('loan_number', loan_number);
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);
        Payload.Get('page', page);
        Payload.Get('page_count', page_count);

        SearchMember.Reset;

        case identifier_type.AsValue.AsText of
            'MSISDN':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("Transactional Mobile Number", identifier.AsValue.AsText);
                    SearchMember.SetRange("Phone No.", identifier.AsValue.AsText);
                end;
            'MEMBER_NO', 'GROUP_NO':
                SearchMember.SetRange("No.", identifier.AsValue.AsText);
            'EMAIL':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("E-Mail", identifier.AsValue.AsText);
                    SearchMember.SetRange("Office E-Mail", identifier.AsValue.AsText);
                end;
            'ID_NO':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"ID Number");
                    SearchMember.SetRange("Primary Identification", identifier.AsValue.AsText);

                    if not SearchMember.FindFirst then begin
                        SearchMember.Reset;
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"ID Number");
                        SearchMember.SetRange("Secondary Identification", identifier.AsValue.AsText);
                    end;
                end;
            'PAYROLL_NO':
                SearchMember.SetRange("Payroll/Staff No.", identifier.AsValue.AsText);
            else
        end;

        IF SearchMember.HasFilter and SearchMember.FindFirst() then begin
            TheLoan.Reset;

            TheLoan.SetRange("Member No.", SearchMember."No.");
            TheLoan.SetRange("Loan No.", loan_number.AsValue.AsText);

            if TheLoan.FindFirst then begin
                Count := 0;
                FirstRow := ((page.AsValue.AsInteger - 1) * page_count.AsValue.AsInteger) + 1;
                LastRow := page.AsValue.AsInteger * page_count.AsValue.AsInteger;

                CreditLedgerEntry.Reset;
                CreditLedgerEntry.SetCurrentkey("Entry No.");
                CreditLedgerEntry.Ascending(false);
                CreditLedgerEntry.SetRange("Loan No", TheLoan."Loan No.");
                CreditLedgerEntry.setrange(reversed, false);
                CreditLedgerEntry.SetFilter("Transaction Type", '<>%1', CreditLedgerEntry."Transaction Type"::Bills);

                StartDateTimeParts := start_date.AsValue.AsText.Split(' ');
                EndDateTimeParts := end_date.AsValue.AsText.Split(' ');

                Evaluate(StartDate, StartDateTimeParts.Get(1));
                Evaluate(EndDate, EndDateTimeParts.Get(1));

                CreditLedgerEntry.SetFilter("Posting Date", '>=%1&<=%2', StartDate, EndDate);

                IF CreditLedgerEntry.FindSet then begin
                    TotalFoundRecords := CreditLedgerEntry.Count;

                    repeat begin
                        Count += 1;

                        if (Count >= FirstRow) and (Count <= LastRow) then begin
                            RunningBal := GlobalFunctions.GetLoanRunningBal(CreditLedgerEntry."Entry No.", TheLoan."Loan No.");

                            Entry.Add('entry_number', CreditLedgerEntry."Entry No.");
                            Entry.Add('transaction_reference', CreditLedgerEntry."Document No.");
                            Entry.Add('posting_date', Format(CreditLedgerEntry."Posting Date"));
                            Entry.Add('description', CreditLedgerEntry.Description);
                            Entry.Add('amount', Abs(CreditLedgerEntry."Amount (LCY)"));
                            Entry.Add('running_balance', RunningBal);

                            IF CreditLedgerEntry.Amount < 0 then begin
                                Entry.Add('entry_type', 'Debit');
                            end else begin
                                Entry.Add('entry_type', 'Credit');
                            end;

                            Entries.Add(Entry);
                            // Reset
                            Entry.ReadFrom('{}');
                        end;
                    end until (Count = LastRow) or (CreditLedgerEntry.Next = 0);
                end;

                // Total Debits + Credits
                CreditLedgerEntry.Reset;
                CreditLedgerEntry.SetRange("Loan No", TheLoan."Loan No.");
                CreditLedgerEntry.setrange(reversed, false);
                CreditLedgerEntry.SetFilter("Transaction Type", '<>%1', CreditLedgerEntry."Transaction Type"::Bills);
                CreditLedgerEntry.SetCurrentkey("Entry No.");
                CreditLedgerEntry.Ascending(true);

                IF CreditLedgerEntry.FindSet then begin
                    Count := 0;
                    TotalCredits := 0;
                    TotalDebits := 0;

                    repeat begin
                        if Count = 0 then begin
                            RunningBal := GlobalFunctions.GetLoanRunningBal(CreditLedgerEntry."Entry No.", TheLoan."Loan No.");
                            IF CreditLedgerEntry.Amount < 0 then begin
                                RunningBal += Abs(CreditLedgerEntry."Amount (LCY)");
                            end else begin
                                RunningBal -= Abs(CreditLedgerEntry."Amount (LCY)");
                            end;
                        end;

                        IF CreditLedgerEntry.Amount < 0 then begin
                            TotalDebits += Abs(CreditLedgerEntry."Amount (LCY)");
                        end else begin
                            TotalCredits += Abs(CreditLedgerEntry."Amount (LCY)");
                        end;

                        Count += 1;
                    end until CreditLedgerEntry.Next = 0;
                end;

                Datum.Add('records', Entries);
                Datum.Add('page', page);
                Datum.Add('page_count', page_count);
                Datum.Add('total_records', TotalFoundRecords);
                Datum.Add('credits', TotalCredits);
                Datum.Add('debits', TotalDebits);
                Datum.Add('opening_balance', RunningBal);

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Member’s Loan Statement has been fetched successfully');
            end else begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Loan NOT found!');
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanStatementReport(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        loan_number: JsonToken;
        start_date: JsonToken;
        end_date: JsonToken;
        file_type: JsonToken;

        SearchMember: Record Members;
        TheLoan: Record Loans;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        XMLDoc: XmlDocument;
        ReportParameters: Text;

        ResponseObject: JsonObject;
        Entry: JsonObject;
        Entries: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('loan_number', loan_number);
        Payload.Get('start_date', start_date);
        Payload.Get('end_date', end_date);
        Payload.Get('file_type', file_type);

        SearchMember.Reset;

        case identifier_type.AsValue.AsText of
            'MSISDN':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("Transactional Mobile Number", identifier.AsValue.AsText);
                    SearchMember.SetRange("Phone No.", identifier.AsValue.AsText);
                end;
            'MEMBER_NO', 'GROUP_NO':
                SearchMember.SetRange("No.", identifier.AsValue.AsText);
            'EMAIL':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("E-Mail", identifier.AsValue.AsText);
                    SearchMember.SetRange("Office E-Mail", identifier.AsValue.AsText);
                end;
            'ID_NO':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"ID Number");
                    SearchMember.SetRange("Primary Identification", identifier.AsValue.AsText);

                    if not SearchMember.FindFirst then begin
                        SearchMember.Reset;
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"ID Number");
                        SearchMember.SetRange("Secondary Identification", identifier.AsValue.AsText);
                    end;
                end;
            'PAYROLL_NO':
                SearchMember.SetRange("Payroll/Staff No.", identifier.AsValue.AsText);
            else
        end;

        IF SearchMember.HasFilter and SearchMember.FindFirst() then begin
            TheLoan.Reset;

            TheLoan.SetRange("Member No.", SearchMember."No.");
            TheLoan.SetRange("Loan No.", loan_number.AsValue.AsText);

            if TheLoan.FindSet then begin
                // TODO: Handle start-end date filter
                XmlDocument.ReadFrom(
                    '<ReportParameters name="Member Loan Statement II" id="' + Format(Report::"Member Loan Statement II") +
                    '"><DataItems><DataItem name="Members">VERSION(1) SORTING(Field1) WHERE(Field1=1(' + Format(SearchMember."No.") +
                    '))</DataItem><DataItem name="Loans">VERSION(1) SORTING(Field1) WHERE(Field1=1(' + Format(TheLoan."Loan No.") +
                    '))</DataItem><DataItem name="loan">VERSION(1) SORTING(Field1)</DataItem><DataItem name="LoansI">VERSION(1) SORTING(Field1) WHERE(Field1=1(' + Format(TheLoan."Loan No.") +
                    '))</DataItem><DataItem name="loanI">VERSION(1) SORTING(Field1)</DataItem></DataItems></ReportParameters>', XmlDoc);

                XmlDoc.WriteTo(ReportParameters);

                RecRef.GetTable(SearchMember);

                BlobOutStream := TempBlob.CreateOutStream;
                case file_type.AsValue.AsText of
                    'PDF':
                        Report.SaveAs(Report::"Member Loan Statement II", ReportParameters, ReportFormat::Pdf, BlobOutStream, RecRef);
                    'XLSX':
                        Report.SaveAs(Report::"Member Loan Statement II", ReportParameters, ReportFormat::Excel, BlobOutStream, RecRef);
                end;

                BlobInStream := TempBlob.CreateInStream;
                FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

                Datum.Add('file', FileContentsB64);
                Datum.Add('file_type', file_type);

                case file_type.AsValue.AsText of
                    'PDF':
                        Datum.Add('file_name', SearchMember."No." + ' - ' + TheLoan."Loan No." + ' Loan Statement.pdf');
                    'XLSX':
                        Datum.Add('file_name', SearchMember."No." + ' - ' + TheLoan."Loan No." + ' Loan Statement.xlsx');
                end;

                Datum.Add('file_size', StrLen(FileContentsB64));

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Member’s Loan Statement report has been exported successfully');
            end else begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Loan NOT found!');
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanGuarantors(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        lnNumber: JsonToken;

        SearchMember: Record Members;
        Loans: Record "Loans";
        LoanGuarantorsSecurity: Record "Loan Guarantors and Security";
        MemberRec: Record Members;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Clear(Datum);
        Clear(ResponseObject);
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('loan_number', lnNumber);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            Loans.Reset();
            Loans.SetRange(Loans."Member No.", SearchMember."No.");
            Loans.SetRange(Loans."Loan No.", lnNumber.AsValue().AsText());

            if Loans.FindFirst() then begin
                LoanGuarantorsSecurity.Reset();
                LoanGuarantorsSecurity.SetRange(LoanGuarantorsSecurity."Loan No", lnNumber.AsValue.AsText);
                LoanGuarantorsSecurity.SetRange(LoanGuarantorsSecurity."Guarantor Type", LoanGuarantorsSecurity."Guarantor Type"::Guarantor);
                LoanGuarantorsSecurity.SetRange(LoanGuarantorsSecurity.Substituted, false);
                LoanGuarantorsSecurity.SetFilter(LoanGuarantorsSecurity."Outstanding Balance", '>0');
                LoanGuarantorsSecurity.SetRange(LoanGuarantorsSecurity."Member Guaranteed", SearchMember."No.");


                if LoanGuarantorsSecurity.Find('-') then begin
                    ResponseText := 'SUCCESS';
                    ResponseDescription := 'Member''s loans guarantors list has been fetched successfully';
                    repeat
                        Clear(Datum);
                        Datum.Add('member_number', LoanGuarantorsSecurity."Member No");
                        Datum.Add('name', LoanGuarantorsSecurity.Name);
                        Datum.Add('amount_guaranteed', Format(LoanGuarantorsSecurity."Amount Guaranteed"));

                        // filter to find the member
                        MemberRec.Reset();
                        MemberRec.SetRange("No.", LoanGuarantorsSecurity."Member No");
                        if MemberRec.FindFirst() then begin
                            Datum.Add('phone_number', MemberRec."Phone No.");
                            Datum.Add('status', Format(MemberRec.Status));
                        end;

                        Data.Add(Datum);

                    until LoanGuarantorsSecurity.Next() = 0;
                    ResponseObject.Add('data', Data);
                end else begin
                    ResponseText := 'SUCCESS';
                    ResponseDescription := 'No loans guarantors list found';
                end;
            end else begin
                ResponseText := 'FAILED';
                ResponseDescription := 'No loan found for the given member';
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        ResponseObject.Add('status', ResponseText);
        ResponseObject.Add('status_description', ResponseDescription);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoansGuaranteed(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        LoanGuarantorsList: Record "Loan Guarantors and Security";
        Loan: Record Loans;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        case identifier_type.AsValue.AsText of
            'MSISDN':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("Transactional Mobile Number", identifier.AsValue.AsText);
                    SearchMember.SetRange("Phone No.", identifier.AsValue.AsText);
                end;
            'MEMBER_NO', 'GROUP_NO':
                SearchMember.SetRange("No.", identifier.AsValue.AsText);
            'EMAIL':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("E-Mail", identifier.AsValue.AsText);
                    SearchMember.SetRange("Office E-Mail", identifier.AsValue.AsText);
                end;
            'ID_NO':
                begin
                    SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"ID Number");
                    SearchMember.SetRange("Primary Identification", identifier.AsValue.AsText);

                    if not SearchMember.FindFirst then begin
                        SearchMember.Reset;
                        SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"ID Number");
                        SearchMember.SetRange("Secondary Identification", identifier.AsValue.AsText);
                    end;
                end;
            'PAYROLL_NO':
                SearchMember.SetRange("Payroll/Staff No.", identifier.AsValue.AsText);
            else
        end;

        IF SearchMember.HasFilter and SearchMember.FindFirst() then begin
            LoanGuarantorsList.Reset;
            LoanGuarantorsList.SetRange("Member No", SearchMember."No.");
            LoanGuarantorsList.SetFilter("Total Loan Balance", '>0');
            LoanGuarantorsList.SetRange(Substituted, false);

            IF LoanGuarantorsList.FindSet then begin
                repeat begin
                    Datum.Add('member_number', LoanGuarantorsList."Member No");
                    Datum.Add('name', SearchMember.Name);
                    Datum.Add('phone_number', SearchMember."Phone No.");
                    Datum.Add('loan_number', LoanGuarantorsList."Loan No");

                    Loan.Reset;
                    Loan.SetRange("Loan No.", LoanGuarantorsList."Loan No");

                    if Loan.FindFirst then begin
                        Loan.CalcFields("Loans Category-SASRA");

                        Datum.Add('loan_product_code', Loan."Loan Product Type");
                        Datum.Add('loan_type', Loan."Loan Product Type Name");
                        Datum.Add('loan_category', Format(Loan."Loans Category-SASRA"));
                        Datum.Add('loan_expected_date_of_completion', Loan."Expected Date of Completion");
                    end else begin
                        Datum.Add('loan_product_code', '');
                        Datum.Add('loan_type', '');
                        Datum.Add('loan_category', '');
                        Datum.Add('loan_expected_date_of_completion', '');
                    end;

                    Datum.Add('loanee_name', LoanGuarantorsList."Loanee Name");
                    Datum.Add('loanee_member_number', LoanGuarantorsList."Member Guaranteed");
                    Datum.Add('amount_guaranteed', LoanGuarantorsList."Amount Guaranteed");

                    LoanGuarantorsList.CalcFields("Total Loan Balance");

                    Datum.Add('loan_balance', LoanGuarantorsList."Total Loan Balance");
                    Datum.Add('application_date', Loan."Application Date");

                    Data.Add(Datum);

                    // Reset
                    Datum.ReadFrom('{}');
                end until LoanGuarantorsList.Next = 0;
            end;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Member’s loans guaranteed list has been fetched successfully');
            ResponseObject.Add('data', Data);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanTypes(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        MemberRec: Record Members;
        ProductFactory: Record "Product Factory";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Clear(Datum);
        Clear(ResponseObject);
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            ProductFactory.SetRange(Status, ProductFactory.Status::Active);
            ProductFactory.SetRange("Product Class Type", ProductFactory."Product Class Type"::Loan);
            ProductFactory.SetRange("Nature of Loan Type", ProductFactory."Nature of Loan Type"::Normal);
            // ProductFactory.SetRange("Is CRM Product", true);

            if SearchMember."Employer Code" = 'RETIREE' then begin
                // Pension only 
                ProductFactory.SetFilter("Salary Income Types", '%1|%2', ProductFactory."Salary Income Types"::Pension, ProductFactory."Salary Income Types"::Dividend);
            end else begin
                // Salaried
                ProductFactory.SetFilter("Salary Income Types", '%1|%2', ProductFactory."Salary Income Types"::Salary, ProductFactory."Salary Income Types"::Dividend);
            end;

            if ProductFactory.FindSet then begin
                ResponseText := 'SUCCESS';
                ResponseDescription := 'SACCO loan types list has been fetched successfully';
                repeat
                    Clear(Datum);
                    Datum.Add('loan_code', ProductFactory."Product ID");
                    Datum.Add('product_name', ProductFactory."Product Description");
                    Datum.Add('minimum_guarantors', ProductFactory."Minimum Guarantors");
                    Datum.Add('maximum_guarantors', ProductFactory."Maximum Guarantors");
                    Datum.Add('source', ProductFactory."Source of Funds");
                    Datum.Add('source_unit', Format(ProductFactory."Source Unit"));
                    Datum.Add('maximum_amount', Format(ProductFactory."Maximum Loan Amount"));
                    Datum.Add('minimum_amount', Format(ProductFactory."Minimum Loan Amount"));
                    Datum.Add('maximum_installments', ProductFactory."Ordinary Default Intallments");
                    Datum.Add('is_mobile_loan', ProductFactory."Mobile Loan");
                    Datum.Add('repayment_mode', Format(ProductFactory."Repay Mode"));
                    Datum.Add('requires_topup', ProductFactory."Allow Topup");

                    Data.Add(Datum);
                until ProductFactory.Next = 0;
                ResponseObject.Add('data', Data);
            end else begin
                ResponseText := 'SUCCESS';
                ResponseDescription := 'No loans types list found';
            end;

            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanCalcParams(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        LnCode: JsonToken;


        SearchMember: Record Members;
        MemberRec: Record Members;
        ProductFactory: Record "Product Factory";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Clear(Datum);
        Clear(ResponseObject);
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('loan_code', LnCode);


        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            ProductFactory.Reset();
            ProductFactory.SetRange("Product ID", LnCode.AsValue().AsText());
            ProductFactory.SetRange(ProductFactory."Product Class Type", ProductFactory."Product Class Type"::Loan);
            // ProductFactory.SetRange("Nature of Loan Type", ProductFactory."Nature of Loan Type"::Normal);

            if ProductFactory.FindFirst() then begin
                ResponseText := 'SUCCESS';
                ResponseDescription := 'Loan calculator parameters have been fetched successfully';

                Clear(Datum);
                Datum.Add('loan_code', ProductFactory."Product ID");
                Datum.Add('product_name', ProductFactory."Product Description");
                Datum.Add('repayment_frequency', Format(ProductFactory."Repayment Frequency"));
                Datum.Add('maximum_loan_amount', ProductFactory."Maximum Loan Amount");
                Datum.Add('interest_rate', ProductFactory."Interest Rate (Min.)");
                Datum.Add('interest_rate_monthly', ProductFactory."Interest Rate (Min.)" / 12);
                Datum.Add('maximum_installments', ProductFactory."Ordinary Default Intallments");
                Datum.Add('minimum_number_of_guarantors', ProductFactory."Minimum Guarantors");
                Datum.Add('maximum_number_of_guarantors', ProductFactory."Maximum Guarantors");
                Datum.Add('recovery_mode', Format(ProductFactory."Repay Mode"));
                Datum.Add('source', Format(ProductFactory."Source of Funds"));
                Datum.Add('interest_calculation_method', Format(ProductFactory."Interest Calculation Method"));
                Datum.Add('is_mobile_loan', ProductFactory."Mobile Loan");
                Datum.Add('repayment_mode', Format(ProductFactory."Repay Mode"));
                Datum.Add('minimum_guarantors', ProductFactory."Minimum Guarantors");
                Datum.Add('maximum_guarantors', ProductFactory."Maximum Guarantors");
                Datum.Add('requires_installments', ProductFactory."Allow Topup");

                Data.Add(Datum);
                ResponseObject.Add('data', Data);
            end else begin
                ResponseText := 'SUCCESS';
                ResponseDescription := 'No loan parameters list found';
            end;
        end;

        ResponseObject.Add('status', ResponseText);
        ResponseObject.Add('status_description', ResponseDescription);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanPurposes(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        MobileLoanPurposes: Record "Loan Purpose";

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
            MobileLoanPurposes.Reset;
            // MobileLoanPurposes.SetRange("Available On Mobile", true);

            IF MobileLoanPurposes.FindSet then begin
                repeat begin
                    Clear(Datum);

                    Datum.Add('code', MobileLoanPurposes.Code);
                    Datum.Add('description', MobileLoanPurposes.Description);

                    Data.Add(Datum);
                end until MobileLoanPurposes.Next = 0;
            end;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Get Loan purposes list has been fetched successfully');
            ResponseObject.Add('data', Data);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetDividendPayslipPeriods(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        DividendProgression: record "Dividend Progression";
        CurrentYear: Integer;
        MaxYearsBack: Integer;
        MemberRec: Record Members;
        DividendSlipYearsBuffer: Record "Dividend Slip Years Buffer";

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
            CurrentYear := Date2DMY(Today, 3);
            MaxYearsBack := CurrentYear - 10;

            repeat begin
                Clear(Datum);

                DividendProgression.Reset;

                DividendProgression.SetRange("Member No", SearchMember."No.");
                DividendProgression.SetRange(Year, CurrentYear);
                // DividendProgression.SetRange(Posted, true);

                if DividendProgression.FindFirst then begin
                    Datum.Add('period', CurrentYear);
                    Data.Add(Datum);
                end;

                CurrentYear := CurrentYear - 1;
            end until CurrentYear = MaxYearsBack;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'SACCO dividend payslip periods list has been fetched successfully');
            ResponseObject.Add('data', Data);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetDividendPayslipReport(Payload: JsonObject): Text
    var
        period: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: record Members;
        DividendProgression: record "Dividend Progression";

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('period', period);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            DividendProgression.Reset;

            DividendProgression.SetRange("Member No", SearchMember."No.");
            DividendProgression.SetRange(Year, period.AsValue.AsInteger);

            IF DividendProgression.FindSet then begin
                RecRef.GetTable(DividendProgression);

                BlobOutStream := TempBlob.CreateOutStream;
                Report.SaveAs(Report::"Dividend Slip B64", '', ReportFormat::Pdf, BlobOutStream, RecRef);

                BlobInStream := TempBlob.CreateInStream;
                FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

                Datum.Add('file', FileContentsB64);
                Datum.Add('file_type', 'PDF');
                Datum.Add('file_name', SearchMember."No." + ' - ' + Format(period.AsValue.AsInteger) + ' Dividends Report.pdf');
                Datum.Add('file_size', StrLen(FileContentsB64));

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Request is successful');
                ResponseObject.Add('data', Datum);
            end else begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Dividends for the given period ' + Format(period.AsValue.AsInteger) + ' not found');
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetTransactionCharges(Payload: JsonObject): Text
    var
        account_number: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;
        charge_action: JsonToken;
        amount: JsonToken;
        receiver_identifier: JsonToken;

        SearchMember: Record Members;
        ChargesInfo: List of [decimal];
        SkyMbankingTrans: Codeunit "Sky M-Banking Transactions";

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Datum: JsonObject;
        Response: Text;

        ResponseText: Text;
        ResponseDescription: Text;

        ReceiverIdentifierExists: Boolean;
    begin
        Payload.Get('account_number', account_number);
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO
        Payload.Get('identifier', identifier);
        Payload.Get('charge_action', charge_action);
        Payload.Get('amount', amount);
        ReceiverIdentifierExists := Payload.Get('receiver_identifier', receiver_identifier);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            // ChargesInfo := SkyMbankingTrans.GetTransChargesPreview(charge_action.AsValue.AsText, amount.AsValue.AsDecimal, account_number.AsValue.AsText, SearchMember);
            if ReceiverIdentifierExists then begin
                ChargesInfo := SkyMbankingTrans.GetTransChargesPreview(charge_action.AsValue.AsText, amount.AsValue.AsDecimal, account_number.AsValue.AsText, SearchMember, receiver_identifier.AsValue.AsText);
            end else begin
                ChargesInfo := SkyMbankingTrans.GetTransChargesPreview(charge_action.AsValue.AsText, amount.AsValue.AsDecimal, account_number.AsValue.AsText, SearchMember, '');
            end;
            Datum.Add('charge_amount', ChargesInfo.Get(1) - ChargesInfo.Get(2));
            Datum.Add('excise_duty', ChargesInfo.Get(2));
            Datum.Add('total_charges', (ChargesInfo.Get(1)));

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Request is successful');
            ResponseObject.Add('data', Datum);
        end else begin
            ResponseObject.Add('status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure InternalFundsTransfer(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        source_account: JsonToken;
        destination_account: JsonToken;
        amount: JsonToken;
        api_request_id: JsonToken;

        SearchMember: record Members;
        MpesaTrans: Record "Sky M-Banking Trans. Buffer";
        SourceSavingsAccount: Record "Savings Accounts";
        IsSourceAccActive: Boolean;
        IsDestAccLoan: Boolean;
        IsDestinationAccActive: Boolean;
        DestinationSavingsAccount: Record "Savings Accounts";
        DestinationLoanAccount: Record Loans;
        SavingsProduct: Record "Product Factory";

        MobileTransTypes: Record "Mobile Transaction Types";
        MobileTransLines: Record "Mobile Transaction Types Lines";
        TotalCharges: Decimal;
        currCharges: List of [decimal];

        IsSharesTrading: Boolean;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('api_request_id', api_request_id);
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('source_account', source_account);
        Payload.Get('destination_account', destination_account);
        Payload.Get('amount', amount);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            if DestinationLoanAccount.Get(destination_account.AsValue.AsText) then begin
                IsDestAccLoan := true;
            end;

            if not IsDestAccLoan then begin
                // if not GlobalFunctions.CheckMemberSubflagTransactionAbility(SearchMember."No.") then begin
                //     // Support shares trading
                //     if SearchMember.Subflag <> SearchMember.Subflag::Withdrawal then begin
                //         ResponseObject.Add('status', 'BLOCKED');
                //         ResponseObject.Add('status_description', 'The member is NOT allowed to transact. Current sub-flag status is ' + Format(SearchMember.Subflag));

                //         AddDateTimeToResponse(ResponseObject);

                //         ResponseObject.WriteTo(Response);

                //         exit(Response);
                //     end;
                // end;
            end;

            if amount.AsValue.AsDecimal <= 0 then begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', 'Transaction amount must be greater than zero');

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);

                exit(Response);
            end;

            if source_account.AsValue.AsText = destination_account.AsValue.AsText then begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', 'Source account and destination account must be different');

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);

                exit(Response);
            end;

            // DUPLICATE / IFT_REQUEST_EXISTS
            MpesaTrans.Reset;
            MpesaTrans.SetRange(MpesaTrans."Originator ID", api_request_id.AsValue.AsText);
            if MpesaTrans.FindFirst then begin
                ResponseObject.Add('status', 'IFT_REQUEST_EXISTS');
                ResponseObject.Add('status_description', 'This transaction already exists. Originator ID = ' + MpesaTrans."Originator ID");


                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // Source Account
            SourceSavingsAccount.Reset;
            SourceSavingsAccount.SetRange("No.", source_account.AsValue.AsText);
            if not SourceSavingsAccount.FindFirst then begin
                // ACCOUNT_NOT_FOUND
                ResponseObject.Add('status', 'ACCOUNT_NOT_FOUND');
                ResponseObject.Add('status_description', 'Account with identifier number ' + source_account.AsValue.AsText + ' does not exist!');

                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end else begin
                // Is withdrawable?
                SavingsProduct.Reset;
                SavingsProduct.SetRange("Product ID", SourceSavingsAccount."Product Type");

                if SavingsProduct.FindFirst then begin
                    // Determine if it is shares trading process
                    if SavingsProduct."Product Category" = SavingsProduct."Product Category"::"Share Capital" then begin
                        IsSharesTrading := true;
                    end;

                    if (SavingsProduct."Channels Int. Transfer Options" = SavingsProduct."Channels Int. Transfer Options"::"Deposit Only") OR
                (SavingsProduct."Channels Int. Transfer Options" = SavingsProduct."Channels Int. Transfer Options"::None)
                then begin
                        ResponseObject.Add('status', 'INVALID_ACCOUNT');
                        ResponseObject.Add('status_description', 'Account with identifier number ' + source_account.AsValue.AsText + ' is NOT withdrawable!');

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
                end;

                // Does it belong to the member?
                if SourceSavingsAccount."Member No." <> SearchMember."No." then begin
                    ResponseObject.Add('status', 'INVALID_ACCOUNT');
                    ResponseObject.Add('status_description', 'Account with identifier number ' + source_account.AsValue.AsText + ' does NOT belong to the given member');

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
                    ResponseObject.Add('status', 'ACCOUNT_NOT_ACTIVE');
                    ResponseObject.Add('status_description', 'Account with identifier number ' + source_account.AsValue.AsText + ' is NOT active. Current status is ' + Format(SourceSavingsAccount.Status));

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;

                // BLOCKED
                if (SourceSavingsAccount.Blocked = SourceSavingsAccount.Blocked::All) OR
                (SourceSavingsAccount.Blocked = SourceSavingsAccount.Blocked::Debit) then begin
                    ResponseObject.Add('status', 'BLOCKED');
                    ResponseObject.Add('status_description', 'Account with identifier number ' + source_account.AsValue.AsText + ' is blocked from withdrawal transactions.');

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;

                // INSUFFICIENT_BAL
                if amount.AsValue.AsDecimal > GlobalFunctions.GetSavingsAccountAvailableBalance(SourceSavingsAccount, true) then begin
                    ResponseObject.Add('status', 'INSUFFICIENT_BAL');
                    ResponseObject.Add('status_description', 'Account has insufficient balance to complete the transaction.');

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end;

            // Destination Account
            if IsDestAccLoan then begin
                // Loan
                DestinationLoanAccount.Reset;
                DestinationLoanAccount.SetRange("Loan No.", destination_account.AsValue.AsText);
                if not DestinationLoanAccount.FindFirst then begin
                    // ACCOUNT_NOT_FOUND
                    ResponseObject.Add('status', 'ACCOUNT_NOT_FOUND');
                    ResponseObject.Add('status_description', 'Loan account with identifier number ' + destination_account.AsValue.AsText + ' does not exist!');

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
                        ResponseObject.Add('status', 'DEST_ACCOUNT_NOT_ACTIVE');
                        ResponseObject.Add('status_description', 'Loan account with identifier number ' + destination_account.AsValue.AsText + ' is NOT approved. Current status is ' + Format(DestinationLoanAccount.Status));

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
                end;
            end else begin
                // Savings
                DestinationSavingsAccount.Reset;
                DestinationSavingsAccount.SetRange("No.", destination_account.AsValue.AsText);
                if not DestinationSavingsAccount.FindFirst then begin
                    // ACCOUNT_NOT_FOUND
                    ResponseObject.Add('status', 'ACCOUNT_NOT_FOUND');
                    ResponseObject.Add('status_description', 'Destination account with identifier number ' + destination_account.AsValue.AsText + ' does not exist!');

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end else begin
                    // Is depositable?
                    SavingsProduct.Reset;
                    SavingsProduct.SetRange("Product ID", DestinationSavingsAccount."Product Type");

                    if SavingsProduct.FindFirst then begin
                        // Destination account must be share capital for shares trading process!
                        if IsSharesTrading then begin
                            if SavingsProduct."Product Category" <> SavingsProduct."Product Category"::"Share Capital" then begin
                                ResponseObject.Add('status', 'INVALID_ACCOUNT');
                                ResponseObject.Add('status_description', 'Destination account with identifier number ' + destination_account.AsValue.AsText + ' must be a share capital account!');

                                AddDateTimeToResponse(ResponseObject);

                                ResponseObject.WriteTo(Response);
                                exit(Response);
                            end;
                        end;

                        if (SavingsProduct."Channels Int. Transfer Options" = SavingsProduct."Channels Int. Transfer Options"::"Withdrawals Only") OR
                    (SavingsProduct."Channels Int. Transfer Options" = SavingsProduct."Channels Int. Transfer Options"::None)
                    then begin
                            ResponseObject.Add('status', 'INVALID_ACCOUNT');
                            ResponseObject.Add('status_description', 'Destination account with identifier number ' + destination_account.AsValue.AsText + ' does NOT allow deposits!');

                            AddDateTimeToResponse(ResponseObject);

                            ResponseObject.WriteTo(Response);
                            exit(Response);
                        end;
                    end;

                    // BLOCKED
                    if (DestinationSavingsAccount.Blocked = DestinationSavingsAccount.Blocked::All) OR
                    (DestinationSavingsAccount.Blocked = DestinationSavingsAccount.Blocked::Credit) then begin
                        ResponseObject.Add('status', 'BLOCKED');
                        ResponseObject.Add('status_description', 'Destination account with identifier number ' + destination_account.AsValue.AsText + ' is blocked from deposit transactions.');

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
                end;
            end;

            // Process the request
            MpesaTrans.Init;

            if IsDestAccLoan then begin
                MpesaTrans."Transaction Type" := MpesaTrans."Transaction Type"::"Pay Loan From Account";
            end else begin
                if SourceSavingsAccount."Product Type" = 'KSS' then begin
                    MpesaTrans."Transaction Type" := MpesaTrans."Transaction Type"::"Kesasa Account Transfer";
                end else begin
                    MpesaTrans."Transaction Type" := MpesaTrans."Transaction Type"::"Account Transfer";
                end;

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
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', 'Transaction amount must be greater than ' + Format(TotalCharges));

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);

                    exit(Response);
                end;

            end;

            MpesaTrans."API Request ID" := api_request_id.AsValue.AsText;
            MpesaTrans."Transaction ID" := GlobalFunctions.CleanGuid;

            MpesaTrans."Originator ID" := api_request_id.AsValue.AsText;
            MpesaTrans."Identifier Type" := identifier_type.AsValue.AsText;
            MpesaTrans.Identifier := identifier.AsValue.AsText;

            MpesaTrans."Savings Account" := source_account.AsValue.AsText;
            if IsDestAccLoan then begin
                MpesaTrans."Loan No." := destination_account.AsValue.AsText;
                MpesaTrans."Loan Account" := DestinationLoanAccount."Loan Account";
            end else begin
                MpesaTrans."Destination Account" := destination_account.AsValue.AsText;
            end;

            MpesaTrans."Transaction Amount" := amount.AsValue.AsDecimal;

            if IsDestAccLoan then begin
                MpesaTrans."Transaction Description" := 'IFT request from source acc. ' + source_account.AsValue.AsText + ' to loan acc. ' + destination_account.AsValue.AsText;
            end else begin
                MpesaTrans."Transaction Description" := 'IFT request from source acc. ' + source_account.AsValue.AsText + ' to dest acc. ' + destination_account.AsValue.AsText;
            end;

            MpesaTrans."Transaction Source Reference" := api_request_id.AsValue.AsText;
            MpesaTrans."Request Application" := 'MEMBERS PORTAL';
            MpesaTrans."Source Application" := 'MEMBERS PORTAL';

            MpesaTrans."Transaction Date Time" := CurrentDateTime;
            MpesaTrans."Transaction Date" := DT2Date(MpesaTrans."Transaction Date Time");
            MpesaTrans."Transaction Time" := DT2Time(MpesaTrans."Transaction Date Time");

            MpesaTrans."Transaction Status" := MpesaTrans."Transaction Status"::CONFIRMED;
            MpesaTrans.Posted := false;

            if MpesaTrans.Insert(true) then begin
                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Internal Funds Transfer request received successfully and is being processed');

                Datum.Add('transaction_reference', MpesaTrans."Transaction ID");
                Datum.Add('transaction_status', 'SUCCESS');
                Datum.Add('transaction_status_description', 'Internal Funds Transfer request received successfully');

                ResponseObject.Add('data', Datum);
            end else begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', 'Unable to process the transaction at the moment');
            end;

        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanRepaymentScheduleReport(Payload: JsonObject): Text
    var
        loan_number: JsonToken;
        file_type: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;

        TheLoan: record Loans;
        SearchMember: record Members;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
        ActualSchedule: Codeunit ActualLoanSchedule;
        LoanProcess: Codeunit "Loans Process";
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('loan_number', loan_number);
        Payload.Get('file_type', file_type);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheLoan.Reset;
            TheLoan.SetRange("Loan No.", loan_number.AsValue.AsText);

            IF TheLoan.FindFirst then begin
                RecRef.GetTable(TheLoan);

                //ActualSchedule.GenerateLoanSchedule(TheLoan);
                LoanProcess.GenerateSchedule(TheLoan, True);
                BlobOutStream := TempBlob.CreateOutStream;
                Report.SaveAs(Report::"Ideal Repayment Schedule", '', ReportFormat::Pdf, BlobOutStream, RecRef);

                BlobInStream := TempBlob.CreateInStream;
                FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

                Datum.Add('file', FileContentsB64);
                Datum.Add('file_type', 'PDF');
                Datum.Add('file_name', SearchMember."No." + ' - ' + TheLoan."Loan No." + ' Loan Repayment Schedule.pdf');
                Datum.Add('file_size', StrLen(FileContentsB64));

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Request is successful');
                ResponseObject.Add('data', Datum);
            end else begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Loan with number ' + loan_number.AsValue.AsText + ' NOT found');
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberReligions(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        HRLookup: Record "HR Lookup Values";

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
            HRLookup.Reset;

            HRLookup.SetRange(Type, HRLookup.Type::Religion);

            IF HRLookup.FindSet then begin
                repeat begin
                    Clear(Datum);

                    Datum.Add('code', HRLookup.Code);
                    Datum.Add('description', HRLookup.Description);

                    Data.Add(Datum);
                end until HRLookup.Next = 0;
            end;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Get member religions list has been fetched successfully');
            ResponseObject.Add('data', Data);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetMemberNationalities(): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        Countries: Record "Country/Region";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Countries.Reset;

        IF Countries.FindSet then begin
            repeat begin
                Clear(Datum);

                Datum.Add('code', Countries.Code);
                Datum.Add('name', Countries.Name);

                Data.Add(Datum);
            end until Countries.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('status_description', 'Get member nationalities list has been fetched successfully');
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
        ResponseObject.Add('status_description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CreateMemberApplication(Payload: JsonObject): Text
    var
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
        // payroll_staff_no: JsonToken;
        primary_identification_type: JsonToken;
        secondary_identification_type: JsonToken;
        religion: JsonToken;
        primary_identification: JsonToken;
        secondary_identification: JsonToken;
        // passport_expiry_date: JsonToken;
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
        // type_of_application: JsonToken;
        // principle_member: JsonToken;
        is_self_employed: JsonToken;
        // crm_application_no: JsonToken;
        salutation: JsonToken;
        // account_profile: JsonToken;
        // account_type: JsonToken;
        member_class: JsonToken;
        // is_from_another_sacco: JsonToken;
        // crm_created_by: JsonToken;
        // activity_code: JsonToken;
        // branch_code: JsonToken;
        // country_of_operation: JsonToken;
        // work_station: JsonToken;
        // employment_designation: JsonToken;
        // delegates_zone: JsonToken;
        date_of_contribution_commencement: JsonToken;
        contribution_amount: JsonToken;
        // crm_notes: JsonToken;
        // crm_originating_branch: JsonToken;
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
        // iprs_verified: JsonToken;
        photo: JsonToken;
        signature: JsonToken;
        id_front: JsonToken;
        id_back: JsonToken;

        // files: JsonToken;
        // file: JsonToken;
        // file_name: JsonToken;
        // file_contents: JsonToken;

        KeyExists: Boolean;

        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        NewNo: Code[20];
        NewNoSeriesCode: Code[20];
        // CRMNewNo: Code[20];
        // CRMNewNoSeriesCode: Code[20];

        TheMemberApplicationDocuments: Record "Channel Application Documents";
        EDMSFunctions: Codeunit "EDMS Functions";
        EDMSFileTypes: enum "EDMS File Types";

        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob2: Codeunit "Temp Blob";
        OutStr2: OutStream;
        Base64Convert2: Codeunit "Base64 Convert";
        TempBlob3: Codeunit "Temp Blob";
        OutStr3: OutStream;
        Base64Convert3: Codeunit "Base64 Convert";
        TempBlob4: Codeunit "Temp Blob";
        OutStr4: OutStream;
        Base64Convert4: Codeunit "Base64 Convert";
        StoreImageRef: FieldRef;
        StoreRecRef: RecordRef;
        StoreImageRef2: FieldRef;
        StoreRecRef2: RecordRef;
        StoreImageRef3: FieldRef;
        StoreRecRef3: RecordRef;
        StoreImageRef4: FieldRef;
        StoreRecRef4: RecordRef;

        RecRef: RecordRef;
        BlobInStream: InStream;
        Base64Convert5: Codeunit "Base64 Convert";
        TempBlob5: Codeunit "Temp Blob";
        FileContentsB64: Text;
        XmlDoc: XmlDocument;
        ReportParameters: Text;

        theApp: Record "Member Application";

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
        // KeyExists := Payload.Get('payroll_staff_no', payroll_staff_no);
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
        // KeyExists := Payload.Get('type_of_application', type_of_application);
        // KeyExists := Payload.Get('principle_member', principle_member);
        KeyExists := Payload.Get('is_self_employed', is_self_employed);
        // KeyExists := Payload.Get('crm_application_no', crm_application_no);
        KeyExists := Payload.Get('salutation', salutation);
        // KeyExists := Payload.Get('account_profile', account_profile);
        // KeyExists := Payload.Get('account_type', account_type);
        KeyExists := Payload.Get('member_class', member_class);
        // KeyExists := Payload.Get('is_from_another_sacco', is_from_another_sacco);
        // KeyExists := Payload.Get('crm_created_by', crm_created_by);
        // KeyExists := Payload.Get('branch_code', branch_code);
        // KeyExists := Payload.Get('activity_code', activity_code);
        // KeyExists := Payload.Get('country_of_operation', country_of_operation);
        // KeyExists := Payload.Get('work_station', work_station);
        // KeyExists := Payload.Get('employment_designation', employment_designation);
        // KeyExists := Payload.Get('delegates_zone', delegates_zone);
        KeyExists := Payload.Get('date_of_contribution_commencement', date_of_contribution_commencement);
        KeyExists := Payload.Get('contribution_amount', contribution_amount);
        // KeyExists := Payload.Get('crm_notes', crm_notes);
        // KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);
        // KeyExists := Payload.Get('passport_expiry_date', passport_expiry_date);
        KeyExists := Payload.Get('nok_beneficiary_nominee_info', nok_beneficiary_nominee_info);
        // KeyExists := Payload.Get('iprs_verified', iprs_verified);

        KeyExists := Payload.Get('photo', photo);
        KeyExists := Payload.Get('signature', signature);
        KeyExists := Payload.Get('id_front', id_front);
        KeyExists := Payload.Get('id_back', id_back);

        // KeyExists := Payload.Get('files', files);

        Response := ValidateMembershipRegistrationFields(Payload);
        if Response <> '' then begin
            Exit(Response);
        end;

        MemberApplication.Init();

        SeriesSetup.Get;
        SeriesSetup.TestField(SeriesSetup."Member Application Nos.");
        SeriesSetup."Member Application Nos." := NoSeriesMgt.GetNextNo(SeriesSetup."Member Application Nos.");
        // NoSeriesMgt.InitSeries(SeriesSetup."Member Application Nos.", SeriesSetup."Member Application Nos.", 0D, NewNo, NewNoSeriesCode);

        MemberApplication."No." := NewNo;
        MemberApplication."No. Series" := NewNoSeriesCode;

        // MemberApplication."Allocated Officer" := relationship_manager.AsValue.AsText;
        // MemberApplication."Type of Application" := "Type of Application".FromInteger(type_of_application.AsValue.AsInteger);
        // IF ((MemberApplication."Type of Application" = "Type of Application"::Readmission) OR (MemberApplication."Type of Application" = "Type of Application"::Nominee)) then begin
        //     MemberApplication."Principle Member" := principle_member.AsValue.AsText;
        //     MemberApplication."Old Member No." := principle_member.AsValue.AsText;

        //     MemberImages.Reset;

        //     MemberImages.SetRange("Member No", principle_member.AsValue.AsText);

        //     if MemberImages.FindFirst then begin
        //         MemberApplication.Signature := MemberImages.Signature;
        //         MemberApplication.Picture := MemberImages.Picture;
        //     end;
        // end;

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

        MemberApplication."First Name" := first_name.AsValue.AsText.Trim();
        MemberApplication."Middle Name" := middle_name.AsValue.AsText.Trim();
        MemberApplication."Other Names" := other_names.AsValue.AsText.Trim();
        MemberApplication."Home Address" := permanent_address.AsValue.AsText.Trim();
        MemberApplication."Current Address" := current_address.AsValue.AsText.Trim();
        MemberApplication.Nationality := nationality.AsValue.AsText.Trim();
        MemberApplication."Phone No." := phone_no.AsValue.AsText.Trim();
        MemberApplication.Validate("Phone No.");


        if MemberApplication.Nationality = 'KE' then begin
            if (transactional_mobile_no.AsValue.AsText <> '') then begin
                if GlobalFunctions.ValidateKenyanPhoneNumber(transactional_mobile_no.AsValue.AsText) then begin
                    MemberApplication."Transactional Mobile Number" := transactional_mobile_no.AsValue.AsText.Trim();
                    MemberApplication.Validate("Transactional Mobile Number");
                end else begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', 'Transactional mobile number MUST be in the format of 254xxxxxxxxx');
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);

                    exit(Response);
                end;
            end;
        end;

        if not employer_code.AsValue.IsNull then begin
            if employer_code.AsValue.AsText.Trim() <> '' then begin
                MemberApplication."Employer Code" := CopyStr(employer_code.AsValue.AsText.Trim(), 1, 20);
            end;
            // MemberApplication.Validate("Employer Code");
        end;

        MemberApplication."Member Class" := 'MEMBER';
        // MemberApplication.Validate("Member Class");

        if date_of_birth.AsValue.AsText <> '' then begin
            MemberApplication."Date of Birth" := date_of_birth.AsValue.AsDate;
            if MemberApplication."Member Class" <> '' then begin
                MemberApplication."Member Class" := 'A';
            end;
            MemberApplication.Validate("Date of Birth");
        end;
        MemberApplication."E-Mail" := email_address.AsValue.AsText.Trim();
        MemberApplication.Validate("E-Mail");
        // MemberApplication."Payroll/Staff No." := payroll_staff_no.AsValue.AsText.Trim();
        // MemberApplication.Validate("Payroll/Staff No.");
        MemberApplication."Primary Identification Type" := "Identification Type".FromInteger(primary_identification_type.AsValue.AsInteger);
        MemberApplication.Validate("Primary Identification Type");

        MemberApplication."Secondary Identification Type" := "Identification Type".FromInteger(secondary_identification_type.AsValue.AsInteger);
        MemberApplication.Religion := religion.AsValue.AsText.Trim();
        MemberApplication."Primary Identification" := primary_identification.AsValue.AsText.Trim();
        MemberApplication.Validate("Primary Identification");
        MemberApplication."Secondary Identification" := secondary_identification.AsValue.AsText.Trim();
        MemberApplication.Validate("Secondary Identification");

        MemberApplication."Marital Status" := "Marital Status".FromInteger(marital_status.AsValue.AsInteger);
        MemberApplication.Gender := "Gender".FromInteger(_gender.AsValue.AsInteger);
        MemberApplication."Terms of Employment" := "Terms Of Employment".FromInteger(terms_of_employment.AsValue.AsInteger);
        MemberApplication."Post Code" := post_code.AsValue.AsText.Trim();
        MemberApplication.City := city.AsValue.AsText.Trim();
        MemberApplication.County := county.AsValue.AsText.Trim();
        MemberApplication."Sub-County" := sub_county.AsValue.AsText.Trim();

        MemberApplication."Bank Code" := bank_code.AsValue.AsText.Trim();
        MemberApplication.Validate("Bank Code");
        MemberApplication."Branch Code" := bank_branch_code.AsValue.AsText.Trim();
        MemberApplication.Validate("Branch Code");

        MemberApplication."Member Segment" := '';
        MemberApplication."Bank Account No." := bank_account_no.AsValue.AsText.Trim();
        MemberApplication."P.I.N Number" := kra_pin_number.AsValue.AsText.Trim();
        MemberApplication.Validate("P.I.N Number");

        MemberApplication."Recruited by Type" := "Recruited By".FromInteger(recruited_by_type.AsValue.AsInteger);
        MemberApplication."Recruited By" := recruited_by.AsValue.AsText.Trim();
        // MemberApplication.Validate("Recruited By");

        MemberApplication."Self Employed" := is_self_employed.AsValue.AsBoolean;
        MemberApplication.Salutation := salutation.AsValue.AsText.Trim();
        MemberApplication."Account Profile" := MemberApplication."Account Profile"::"Normal Member";
        // MemberApplication."From Another Sacco" := is_from_another_sacco.AsValue.AsBoolean;
        MemberApplication."Created By" := 'MEMBER PORTAL';
        MemberApplication."Office Telephone No." := office_telephone_no.AsValue.AsText.Trim();
        // MemberApplication."Country Of Operation" := country_of_operation.AsValue.AsText.Trim();
        MemberApplication."Country Of Operation" := 'KE';
        // MemberApplication."Work Station" := work_station.AsValue.AsText.Trim();
        // MemberApplication."Employment Designation" := employment_designation.AsValue.AsText.Trim();
        // MemberApplication."Delegates Zone" := delegates_zone.AsValue.AsText.Trim();
        // MemberApplication.Validate("Delegates Zone");

        // MemberApplication."CRM Application No." := crm_application_no.AsValue.AsText.Trim();
        MemberApplication."CRM Created By" := 'MEMBER PORTAL';
        // MemberApplication."CRM Originating Branch" := crm_originating_branch.AsValue.AsText.Trim();
        // MemberApplication."CRM Notes" := crm_notes.AsValue.AsText.Trim();

        if date_of_contribution_commencement.AsValue.AsText <> '' then begin
            MemberApplication."Contribution Start Date" := date_of_contribution_commencement.AsValue.AsDate;
            if MemberApplication."Contribution Start Date" < Today then begin
                MemberApplication."Contribution Start Date" := Today;
            end;
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
        // MemberApplication."Global Dimension 1 Code" := branch_code.AsValue.AsText.Trim();
        // MemberApplication.Validate("Global Dimension 1 Code");
        // MemberApplication."Global Dimension 2 Code" := activity_code.AsValue.AsText.Trim();
        // MemberApplication.Validate("Global Dimension 2 Code");
        MemberApplication."Global Dimension 1 Code" := 'ONLINE';
        MemberApplication."Global Dimension 2 Code" := 'RECORDS';

        MemberApplication.Validate("First Name");
        MemberApplication.Validate("Middle Name");
        MemberApplication.Validate("Other Names");

        if date_of_birth.AsValue.AsText <> '' then begin
            MemberApplication."Date of Birth" := date_of_birth.AsValue.AsDate;
        end;

        // if passport_expiry_date.AsValue.AsText <> '' then begin
        //     MemberApplication."Passport Expiry Date" := passport_expiry_date.AsValue.AsDate;
        // end;

        MemberApplication."Source Aplication" := MemberApplication."Source Aplication"::"Members Portal";

        // if not iprs_verified.AsValue.IsNull then begin
        //     MemberApplication."IPRS Verified" := iprs_verified.AsValue.AsBoolean;
        // end else begin
        // MemberApplication."IPRS Verified" := true;
        // end;

        MemberApplication."Sent Back to CRM" := false;

        if not photo.AsValue.IsNull then begin
            if photo.AsValue.AsText <> '' then begin
                // Clear(OutStr);
                TempBlob.CreateOutStream(OutStr);
                Base64Convert.FromBase64(photo.AsValue.AsText, OutStr);

                Clear(MemberApplication.Picture);
                StoreRecRef.Open(52185691);
                StoreImageRef := StoreRecRef.Field(MemberApplication.FieldNo(Picture));

                TempBlob.ToFieldRef(StoreImageRef);
                StoreImageRef.TestField();

                MemberApplication.Picture := StoreImageRef.Value;
                MemberApplication.TestField(Picture);
            end;
        end;

        if not signature.AsValue.IsNull then begin
            if signature.AsValue.AsText <> '' then begin
                // Clear(OutStr2);
                TempBlob2.CreateOutStream(OutStr2);
                Base64Convert2.FromBase64(signature.AsValue.AsText, OutStr2);

                // Clear(MemberApplication.Signature);
                // Clear(StoreRecRef2);
                StoreRecRef2.Open(52185691);
                // Clear(StoreImageRef2);
                StoreImageRef2 := StoreRecRef2.Field(MemberApplication.FieldNo(Signature));

                TempBlob2.ToFieldRef(StoreImageRef2);
                StoreImageRef2.TestField();

                MemberApplication.Signature := StoreImageRef2.Value;
                MemberApplication.TestField(Signature);
            end;
        end;

        if not id_front.AsValue.IsNull then begin
            if id_front.AsValue.AsText <> '' then begin
                // Clear(OutStr2);
                TempBlob3.CreateOutStream(OutStr3);
                Base64Convert3.FromBase64(id_front.AsValue.AsText, OutStr3);

                // Clear(MemberApplication.Signature);
                // Clear(StoreRecRef2);
                StoreRecRef3.Open(52185691);
                // Clear(StoreImageRef2);
                StoreImageRef3 := StoreRecRef3.Field(MemberApplication.FieldNo("ID Card Front"));

                TempBlob3.ToFieldRef(StoreImageRef3);
                StoreImageRef3.TestField();

                MemberApplication."ID Card Front" := StoreImageRef3.Value;
                MemberApplication.TestField("ID Card Front");
            end;
        end;

        if not id_back.AsValue.IsNull then begin
            if id_back.AsValue.AsText <> '' then begin
                // Clear(OutStr2);
                TempBlob4.CreateOutStream(OutStr4);
                Base64Convert4.FromBase64(id_back.AsValue.AsText, OutStr4);

                // Clear(MemberApplication.Signature);
                // Clear(StoreRecRef2);
                StoreRecRef4.Open(52185691);
                // Clear(StoreImageRef2);
                StoreImageRef4 := StoreRecRef4.Field(MemberApplication.FieldNo("ID Card Back"));

                TempBlob4.ToFieldRef(StoreImageRef4);
                StoreImageRef4.TestField();

                MemberApplication."ID Card Back" := StoreImageRef4.Value;
                MemberApplication.TestField("ID Card Back");
            end;
        end;

        IF MemberApplication.Insert(true) then begin
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
                    // NextofKinApplication."No." := Index + 1;

                    NextofKinApplication."Identification Type" := "Identification Type".FromInteger(nok_beneficiary_nominee_identification_type.AsValue.AsInteger);
                    NextofKinApplication.Identification := nok_beneficiary_nominee_identification_value.AsValue.AsText.Trim();
                    NextofKinApplication.Name := nok_beneficiary_nominee_full_names.AsValue.AsText.Trim();
                    NextofKinApplication.Relationship := nok_beneficiary_nominee_relationship.AsValue.AsText.Trim();
                    if nok_beneficiary_nominee_date_of_birth.AsValue.AsText <> '' then begin
                        NextofKinApplication."Date of Birth" := nok_beneficiary_nominee_date_of_birth.AsValue.AsDate;
                    end;
                    NextofKinApplication.Address := nok_beneficiary_nominee_address.AsValue.AsText.Trim();
                    NextofKinApplication.Telephone := nok_beneficiary_nominee_mobile_no.AsValue.AsText.Trim();
                    NextofKinApplication.Email := nok_beneficiary_nominee_email_address.AsValue.AsText.Trim();
                    NextofKinApplication."Is Next of Kin" := nok_beneficiary_nominee_is_next_of_kin.AsValue.AsBoolean;
                    NextofKinApplication."Is a Beneficiary" := nok_beneficiary_nominee_is_beneficiary.AsValue.AsBoolean;
                    NextofKinApplication."Is Contact Person" := nok_beneficiary_nominee_is_contact_person.AsValue.AsBoolean;
                    NextofKinApplication."Is Nominee" := nok_beneficiary_nominee_is_nominee.AsValue.AsBoolean;
                    NextofKinApplication.Allocation := nok_beneficiary_nominee_allocation.AsValue.AsDecimal;

                    KeyExists := NextofKinApplication.Insert(true);

                    NextofKinApplication.Reset();
                    Clear(NextofKinApplication);
                end;
            end;

            if KeyExists then begin

                // foreach file in files.AsArray() do begin
                //     file.AsObject.Get('name', file_name);

                //     if EDMSFunctions.GetFileTypeFromFileName(file_name.AsValue.AsText) = EDMSFileTypes::" " then begin
                //         ResponseObject.Add('status', 'ERROR');
                //         ResponseObject.Add('status_description', 'Unsupported file type for uploading the file = ' + file_name.AsValue.AsText);

                //         AddDateTimeToResponse(ResponseObject);
                //         ResponseObject.WriteTo(Response);

                //         exit(Response);
                //     end;
                // end;

                // Clear(TempBlob);
                // Clear(OutStr);
                // Clear(Base64Convert);
                // Clear(StoreRecRef);
                // Clear(StoreImageRef);

                // foreach file in files.AsArray() do begin
                //     file.AsObject.Get('name', file_name);
                //     file.AsObject.Get('contents', file_contents);

                //     TheMemberApplicationDocuments.Reset;
                //     Clear(TheMemberApplicationDocuments);
                //     TheMemberApplicationDocuments.Init;

                //     TheMemberApplicationDocuments."Application Type" := TheMemberApplicationDocuments."Application Type"::"Member Application";
                //     TheMemberApplicationDocuments."Application No." := MemberApplication."No.";
                //     TheMemberApplicationDocuments."Document Name" := file_name.AsValue.AsText.Trim();

                //     // B64 to Blob
                //     TempBlob.CreateOutStream(OutStr);
                //     Base64Convert.FromBase64(file_contents.AsValue.AsText, OutStr);
                //     Clear(TheMemberApplicationDocuments.Document);

                //     StoreRecRef.Open(52186564);
                //     StoreImageRef := StoreRecRef.Field(TheMemberApplicationDocuments.FieldNo(Document));

                //     TempBlob.ToFieldRef(StoreImageRef);
                //     StoreImageRef.TestField();

                //     TheMemberApplicationDocuments.Document := StoreImageRef.Value;
                //     TheMemberApplicationDocuments."Document Extension" := EDMSFunctions.GetFileTypeFromFileName(file_name.AsValue.AsText);

                //     TheMemberApplicationDocuments.Insert(true);
                //     // Commit;

                // Clear(TempBlob);
                // Clear(OutStr);
                // Clear(Base64Convert);
                // Clear(StoreRecRef);
                // Clear(StoreImageRef);
                // end;

                theApp.Reset;
                theApp.SetRange("No.", MemberApplication."No.");
                if theApp.FindFirst then begin
                    Clear(TempBlob);
                    Clear(OutStr);
                    Clear(Base64Convert);
                    Clear(StoreRecRef);
                    Clear(StoreImageRef);

                    // Generated member application form
                    TheMemberApplicationDocuments.Reset;
                    Clear(TheMemberApplicationDocuments);
                    TheMemberApplicationDocuments.Init;

                    TheMemberApplicationDocuments."Application Type" := TheMemberApplicationDocuments."Application Type"::"Member Application";
                    TheMemberApplicationDocuments."Application No." := MemberApplication."No.";
                    TheMemberApplicationDocuments."Document Name" := StrSubstNo('%1-MemberApplicationForm.pdf', MemberApplication."No.");

                    XmlDocument.ReadFrom(
                        StrSubstNo(
                            '<ReportParameters name="Online M Application Report" id="%1"><DataItems><DataItem name="Member Application">VERSION(1) SORTING(Field1) WHERE(Field1=1(%2))</DataItem><DataItem name="Next of KIN Application">VERSION(1) SORTING(Field1,Field15)</DataItem></DataItems></ReportParameters>',
                            Report::"Online M Application Report",
                            MemberApplication."No."
                        ),
                        XmlDoc
                    );
                    XmlDoc.WriteTo(ReportParameters);

                    // B64 to Blob
                    TempBlob.CreateOutStream(OutStr);
                    Clear(TheMemberApplicationDocuments.Document);

                    StoreRecRef.Open(52186564);
                    StoreImageRef := StoreRecRef.Field(TheMemberApplicationDocuments.FieldNo(Document));
                    RecRef.GetTable(theApp);
                    Report.SaveAs(Report::"Online M Application Report", ReportParameters, ReportFormat::Pdf, OutStr, RecRef);

                    TempBlob.ToFieldRef(StoreImageRef);
                    StoreImageRef.TestField();

                    TheMemberApplicationDocuments.Document := StoreImageRef.Value;
                    TheMemberApplicationDocuments."Document Extension" := TheMemberApplicationDocuments."Document Extension"::PDF;

                    TheMemberApplicationDocuments.Insert(true);
                    // Commit;

                    Clear(TempBlob);
                    Clear(OutStr);
                    Clear(Base64Convert);
                    Clear(StoreRecRef);
                    Clear(StoreImageRef);
                end;

            end;

            MemberApplication.Reset();

            MemberApplication.SetRange("No.", NewNo);
            ResponseData.Add('application_number', MemberApplication."No.");
            ResponseData.Add('application_status', Format(MemberApplication.Status));

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Membership application request has been created successfully.');
            ResponseObject.Add('data', ResponseData);
            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
        end else begin
            // ResponseObject.Add('status', 'ERROR');
            // ResponseObject.Add('status_description', 'Unable to create membership application.');
            // ResponseObject.Add('errors', Errors);
            // AddDateTimeToResponse(ResponseObject);

            // ResponseObject.WriteTo(Response);

            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', GetLastErrorText(true));
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
        end;

        exit(Response);
    end;

    local procedure ValidateMemberApplication(Payload: JsonObject): Text
    var
        first_name: JsonToken;
        middle_name: JsonToken;
        other_names: JsonToken;
        current_address: JsonToken;
        permanent_address: JsonToken;
        phone_no: JsonToken;
        transactional_mobile_no: JsonToken;
        // employer_code: JsonToken;
        date_of_birth: JsonToken;
        email_address: JsonToken;
        nationality: JsonToken;
        // payroll_staff_no: JsonToken;
        primary_identification_type: JsonToken;
        secondary_identification_type: JsonToken;
        religion: JsonToken;
        primary_identification: JsonToken;
        secondary_identification: JsonToken;
        // passport_expiry_date: JsonToken;
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
        // type_of_application: JsonToken;
        // principle_member: JsonToken;
        is_self_employed: JsonToken;
        // crm_application_no: JsonToken;
        salutation: JsonToken;
        // account_profile: JsonToken;
        // account_type: JsonToken;
        // member_class: JsonToken;
        // is_from_another_sacco: JsonToken;
        // crm_created_by: JsonToken;
        // activity_code: JsonToken;
        // branch_code: JsonToken;
        // country_of_operation: JsonToken;
        // work_station: JsonToken;
        // employment_designation: JsonToken;
        // delegates_zone: JsonToken;
        date_of_contribution_commencement: JsonToken;
        contribution_amount: JsonToken;
        // crm_notes: JsonToken;
        // crm_originating_branch: JsonToken;
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
        // iprs_verified: JsonToken;
        photo: JsonToken;
        signature: JsonToken;
        id_front: JsonToken;
        id_back: JsonToken;

        KeyExists: Boolean;

        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        NewNo: Code[20];
        NewNoSeriesCode: Code[20];
        // CRMNewNo: Code[20];
        // CRMNewNoSeriesCode: Code[20];

        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob2: Codeunit "Temp Blob";
        OutStr2: OutStream;
        Base64Convert2: Codeunit "Base64 Convert";
        TempBlob3: Codeunit "Temp Blob";
        OutStr3: OutStream;
        Base64Convert3: Codeunit "Base64 Convert";
        TempBlob4: Codeunit "Temp Blob";
        OutStr4: OutStream;
        Base64Convert4: Codeunit "Base64 Convert";
        StoreImageRef: FieldRef;
        StoreRecRef: RecordRef;
        StoreImageRef2: FieldRef;
        StoreRecRef2: RecordRef;
        StoreImageRef3: FieldRef;
        StoreRecRef3: RecordRef;
        StoreImageRef4: FieldRef;
        StoreRecRef4: RecordRef;

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
        KeyExists := Payload.Get('first_name', first_name);
        KeyExists := Payload.Get('middle_name', middle_name);
        KeyExists := Payload.Get('other_names', other_names);
        KeyExists := Payload.Get('current_address', current_address);
        KeyExists := Payload.Get('permanent_address', permanent_address);
        KeyExists := Payload.Get('phone_no', phone_no);
        KeyExists := Payload.Get('transactional_mobile_no', transactional_mobile_no);
        // KeyExists := Payload.Get('employer_code', employer_code);
        KeyExists := Payload.Get('date_of_birth', date_of_birth);
        KeyExists := Payload.Get('email_address', email_address);
        KeyExists := Payload.Get('nationality', nationality);
        // KeyExists := Payload.Get('payroll_staff_no', payroll_staff_no);
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
        // KeyExists := Payload.Get('type_of_application', type_of_application);
        // KeyExists := Payload.Get('principle_member', principle_member);
        KeyExists := Payload.Get('is_self_employed', is_self_employed);
        // KeyExists := Payload.Get('crm_application_no', crm_application_no);
        KeyExists := Payload.Get('salutation', salutation);
        // KeyExists := Payload.Get('account_profile', account_profile);
        // KeyExists := Payload.Get('account_type', account_type);
        // KeyExists := Payload.Get('member_class', member_class);
        // KeyExists := Payload.Get('is_from_another_sacco', is_from_another_sacco);
        // KeyExists := Payload.Get('crm_created_by', crm_created_by);
        // KeyExists := Payload.Get('branch_code', branch_code);
        // KeyExists := Payload.Get('activity_code', activity_code);
        // KeyExists := Payload.Get('country_of_operation', country_of_operation);
        // KeyExists := Payload.Get('work_station', work_station);
        // KeyExists := Payload.Get('employment_designation', employment_designation);
        // KeyExists := Payload.Get('delegates_zone', delegates_zone);
        KeyExists := Payload.Get('date_of_contribution_commencement', date_of_contribution_commencement);
        KeyExists := Payload.Get('contribution_amount', contribution_amount);
        // KeyExists := Payload.Get('crm_notes', crm_notes);
        // KeyExists := Payload.Get('crm_originating_branch', crm_originating_branch);
        // KeyExists := Payload.Get('passport_expiry_date', passport_expiry_date);
        KeyExists := Payload.Get('nok_beneficiary_nominee_info', nok_beneficiary_nominee_info);
        // KeyExists := Payload.Get('iprs_verified', iprs_verified);

        KeyExists := Payload.Get('photo', photo);
        KeyExists := Payload.Get('signature', signature);
        KeyExists := Payload.Get('id_front', id_front);
        KeyExists := Payload.Get('id_back', id_back);

        Response := ValidateMembershipRegistrationFields(Payload);
        if Response <> '' then begin
            Exit(Response);
        end;

        MemberApplication.Init();

        SeriesSetup.Get;
        SeriesSetup.TestField(SeriesSetup."Member Application Nos.");
        SeriesSetup."Member Application Nos." := NoSeriesMgt.GetNextNo(SeriesSetup."Member Application Nos.");
        // NoSeriesMgt.InitSeries(SeriesSetup."Member Application Nos.", SeriesSetup."Member Application Nos.", 0D, NewNo, NewNoSeriesCode);

        MemberApplication."No." := NewNo;
        MemberApplication."No. Series" := NewNoSeriesCode;

        // MemberApplication."Allocated Officer" := relationship_manager.AsValue.AsText.Trim();
        // MemberApplication."Type of Application" := "Type of Application".FromInteger(type_of_application.AsValue.AsInteger);
        // IF ((MemberApplication."Type of Application" = "Type of Application"::Readmission) OR (MemberApplication."Type of Application" = "Type of Application"::Nominee)) then begin
        //     MemberApplication."Principle Member" := principle_member.AsValue.AsText.Trim();
        //     MemberApplication."Old Member No." := principle_member.AsValue.AsText.Trim();

        //     MemberImages.Reset;

        //     MemberImages.SetRange("Member No", principle_member.AsValue.AsText);

        //     if MemberImages.FindFirst then begin
        //         MemberApplication.Signature := MemberImages.Signature;
        //         MemberApplication.Picture := MemberImages.Picture;
        //     end;
        // end;

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

        MemberApplication."First Name" := first_name.AsValue.AsText.Trim();
        MemberApplication."Middle Name" := middle_name.AsValue.AsText.Trim();
        MemberApplication."Other Names" := other_names.AsValue.AsText.Trim();
        MemberApplication."Home Address" := permanent_address.AsValue.AsText.Trim();
        MemberApplication."Current Address" := current_address.AsValue.AsText.Trim();
        MemberApplication.Nationality := nationality.AsValue.AsText.Trim();
        MemberApplication."Phone No." := phone_no.AsValue.AsText.Trim();
        MemberApplication.Validate("Phone No.");


        if MemberApplication.Nationality = 'KE' then begin
            if (transactional_mobile_no.AsValue.AsText <> '') then begin
                if GlobalFunctions.ValidateKenyanPhoneNumber(transactional_mobile_no.AsValue.AsText) then begin
                    MemberApplication."Transactional Mobile Number" := transactional_mobile_no.AsValue.AsText.Trim();
                    ;
                    MemberApplication.Validate("Transactional Mobile Number");
                end else begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', 'Transactional mobile number MUST be in the format of 254xxxxxxxxx');
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);

                    exit(Response);
                end;
            end;
        end;

        // MemberApplication."Employer Code" := employer_code.AsValue.AsText;
        // MemberApplication.Validate("Employer Code");
        MemberApplication."Member Class" := 'MEMBER';
        // MemberApplication.Validate("Member Class");

        if date_of_birth.AsValue.AsText <> '' then begin
            MemberApplication."Date of Birth" := date_of_birth.AsValue.AsDate;
            if MemberApplication."Member Class" <> '' then begin
                MemberApplication."Member Class" := 'A';
            end;
            MemberApplication.Validate("Date of Birth");
        end;
        MemberApplication."E-Mail" := email_address.AsValue.AsText.Trim();
        ;
        MemberApplication.Validate("E-Mail");
        // MemberApplication."Payroll/Staff No." := payroll_staff_no.AsValue.AsText.Trim();;
        // MemberApplication.Validate("Payroll/Staff No.");
        MemberApplication."Primary Identification Type" := "Identification Type".FromInteger(primary_identification_type.AsValue.AsInteger);
        MemberApplication.Validate("Primary Identification Type");

        MemberApplication."Secondary Identification Type" := "Identification Type".FromInteger(secondary_identification_type.AsValue.AsInteger);
        MemberApplication.Religion := religion.AsValue.AsText.Trim();
        ;
        MemberApplication."Primary Identification" := primary_identification.AsValue.AsText.Trim();
        ;
        MemberApplication.Validate("Primary Identification");
        MemberApplication."Secondary Identification" := secondary_identification.AsValue.AsText.Trim();
        ;
        MemberApplication.Validate("Secondary Identification");

        MemberApplication."Marital Status" := "Marital Status".FromInteger(marital_status.AsValue.AsInteger);
        MemberApplication.Gender := "Gender".FromInteger(_gender.AsValue.AsInteger);
        MemberApplication."Terms of Employment" := "Terms Of Employment".FromInteger(terms_of_employment.AsValue.AsInteger);
        MemberApplication."Post Code" := post_code.AsValue.AsText.Trim();
        MemberApplication.City := city.AsValue.AsText.Trim();
        MemberApplication.County := county.AsValue.AsText.Trim();
        MemberApplication."Sub-County" := sub_county.AsValue.AsText.Trim();

        MemberApplication."Bank Code" := bank_code.AsValue.AsText.Trim();
        MemberApplication.Validate("Bank Code");
        MemberApplication."Branch Code" := bank_branch_code.AsValue.AsText.Trim();
        MemberApplication.Validate("Branch Code");

        MemberApplication."Member Segment" := '';
        MemberApplication."Bank Account No." := bank_account_no.AsValue.AsText.Trim();
        MemberApplication."P.I.N Number" := kra_pin_number.AsValue.AsText.Trim();
        MemberApplication.Validate("P.I.N Number");

        MemberApplication."Recruited by Type" := "Recruited By".FromInteger(recruited_by_type.AsValue.AsInteger);
        MemberApplication."Recruited By" := recruited_by.AsValue.AsText.Trim();
        // MemberApplication.Validate("Recruited By");

        MemberApplication."Self Employed" := is_self_employed.AsValue.AsBoolean;
        MemberApplication.Salutation := salutation.AsValue.AsText.Trim();
        MemberApplication."Account Profile" := MemberApplication."Account Profile"::"Normal Member";
        // MemberApplication."From Another Sacco" := is_from_another_sacco.AsValue.AsBoolean;
        MemberApplication."Created By" := 'MEMBER PORTAL';
        MemberApplication."Office Telephone No." := office_telephone_no.AsValue.AsText.Trim();
        // MemberApplication."Country Of Operation" := country_of_operation.AsValue.AsText.Trim();
        MemberApplication."Country Of Operation" := 'KE';
        // MemberApplication."Work Station" := work_station.AsValue.AsText.Trim();
        // MemberApplication."Employment Designation" := employment_designation.AsValue.AsText.Trim();
        // MemberApplication."Delegates Zone" := delegates_zone.AsValue.AsText.Trim();
        // MemberApplication.Validate("Delegates Zone");

        // MemberApplication."CRM Application No." := crm_application_no.AsValue.AsText.Trim();
        MemberApplication."CRM Created By" := 'MEMBER PORTAL';
        // MemberApplication."CRM Originating Branch" := crm_originating_branch.AsValue.AsText.Trim();
        // MemberApplication."CRM Notes" := crm_notes.AsValue.AsText.Trim();

        if date_of_contribution_commencement.AsValue.AsText <> '' then begin
            MemberApplication."Contribution Start Date" := date_of_contribution_commencement.AsValue.AsDate;
            if MemberApplication."Contribution Start Date" < Today then begin
                MemberApplication."Contribution Start Date" := Today;
            end;
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
        // MemberApplication."Global Dimension 1 Code" := branch_code.AsValue.AsText;
        // MemberApplication.Validate("Global Dimension 1 Code");
        // MemberApplication."Global Dimension 2 Code" := activity_code.AsValue.AsText;
        // MemberApplication.Validate("Global Dimension 2 Code");
        MemberApplication."Global Dimension 1 Code" := 'ONLINE';
        MemberApplication."Global Dimension 2 Code" := 'RECORDS';

        MemberApplication.Validate("First Name");
        MemberApplication.Validate("Middle Name");
        MemberApplication.Validate("Other Names");

        if date_of_birth.AsValue.AsText <> '' then begin
            MemberApplication."Date of Birth" := date_of_birth.AsValue.AsDate;
        end;

        // if passport_expiry_date.AsValue.AsText <> '' then begin
        //     MemberApplication."Passport Expiry Date" := passport_expiry_date.AsValue.AsDate;
        // end;

        MemberApplication."Source Aplication" := MemberApplication."Source Aplication"::"Members Portal";

        // if not iprs_verified.AsValue.IsNull then begin
        //     MemberApplication."IPRS Verified" := iprs_verified.AsValue.AsBoolean;
        // end else begin
        // MemberApplication."IPRS Verified" := true;
        // end;

        MemberApplication."Sent Back to CRM" := false;

        // Response

        ResponseData.Add('validated', true);

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('status_description', 'Membership application validated successfully');
        ResponseObject.Add('data', ResponseData);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure ValidateMembershipRegistrationFields(Payload: JsonObject): Text
    var
        phone_no: JsonToken;
        transactional_mobile_no: JsonToken;
        email_address: JsonToken;
        kra_pin_number: JsonToken;
        primary_identification_type: JsonToken;
        secondary_identification_type: JsonToken;
        primary_identification: JsonToken;
        secondary_identification: JsonToken;

        Members: Record Members;
        MemberApplications: Record "Member Application";

        ResponseData: JsonObject;
        ResponseObject: JsonObject;
        Response: Text;
    begin
        Payload.Get('phone_no', phone_no);
        Payload.Get('transactional_mobile_no', transactional_mobile_no);
        Payload.Get('email_address', email_address);
        Payload.Get('kra_pin_number', kra_pin_number);
        Payload.Get('primary_identification_type', primary_identification_type);
        Payload.Get('secondary_identification_type', secondary_identification_type);
        Payload.Get('primary_identification', primary_identification);
        Payload.Get('secondary_identification', secondary_identification);


        // Phone number validation
        Members.Reset;
        Members.SetRange("Phone No.", phone_no.AsValue.AsText);
        Members.SetLoadFields("No.");

        if Members.FindFirst then begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', 'Phone number already belongs to an existing member!');
            ResponseObject.Add('data', ResponseData);
            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        MemberApplications.Reset;
        MemberApplications.SetRange("Phone No.", phone_no.AsValue.AsText);
        MemberApplications.SetFilter(Status,
                    '=%1|%2|%3',
                    MemberApplications.Status::Open,
                    MemberApplications.Status::Pending,
                    MemberApplications.Status::Approved);
        MemberApplications.SetLoadFields("No.");

        if MemberApplications.FindFirst then begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', 'Phone number has already been used in an ongoing member application!');
            ResponseObject.Add('data', ResponseData);
            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // Transactional number validation
        if transactional_mobile_no.AsValue.AsText <> '' then begin
            Members.Reset;
            Members.SetRange("Transactional Mobile Number", transactional_mobile_no.AsValue.AsText);
            Members.SetLoadFields("No.");

            if Members.FindFirst then begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', 'Transactional mobile number already belongs to an existing member!');
                ResponseObject.Add('data', ResponseData);
                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            MemberApplications.Reset;
            MemberApplications.SetRange("Transactional Mobile Number", transactional_mobile_no.AsValue.AsText);
            MemberApplications.SetFilter(Status,
                        '=%1|%2|%3',
                        MemberApplications.Status::Open,
                        MemberApplications.Status::Pending,
                        MemberApplications.Status::Approved);
            MemberApplications.SetLoadFields("No.");

            if MemberApplications.FindFirst then begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', 'Transactional mobile number has already been used in an ongoing member application!');
                ResponseObject.Add('data', ResponseData);
                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end;

        // Email Address validation
        Members.Reset;
        Members.SetRange("E-Mail", email_address.AsValue.AsText);
        Members.SetLoadFields("No.");

        if Members.FindFirst then begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', 'Email Address already belongs to an existing member!');
            ResponseObject.Add('data', ResponseData);
            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        MemberApplications.Reset;
        MemberApplications.SetRange("E-Mail", email_address.AsValue.AsText);
        MemberApplications.SetFilter(Status,
                    '=%1|%2|%3',
                    MemberApplications.Status::Open,
                    MemberApplications.Status::Pending,
                    MemberApplications.Status::Approved);
        MemberApplications.SetLoadFields("No.");

        if MemberApplications.FindFirst then begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', 'Email Address has already been used in an ongoing member application!');
            ResponseObject.Add('data', ResponseData);
            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // K.R.A Pin Number
        if kra_pin_number.AsValue.AsText <> '' then begin
            Members.Reset;
            Members.SetRange("P.I.N Number", kra_pin_number.AsValue.AsText);
            Members.SetLoadFields("No.");

            if Members.FindFirst then begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', 'KRA PIN Number already belongs to an existing member!');
                ResponseObject.Add('data', ResponseData);
                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            MemberApplications.Reset;
            MemberApplications.SetRange("P.I.N Number", kra_pin_number.AsValue.AsText);
            MemberApplications.SetFilter(Status,
                        '=%1|%2|%3',
                        MemberApplications.Status::Open,
                        MemberApplications.Status::Pending,
                        MemberApplications.Status::Approved);
            MemberApplications.SetLoadFields("No.");

            if MemberApplications.FindFirst then begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', 'KRA PIN Number has already been used in an ongoing member application!');
                ResponseObject.Add('data', ResponseData);
                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end;

        // Primary Identification
        MemberApplications.Reset();
        MemberApplications.SetRange(Created, false);
        MemberApplications.SetFilter(Status,
        '%1|%2|%3',
        MemberApplications.Status::Open,
        MemberApplications.Status::Pending,
        MemberApplications.Status::Approved);
        MemberApplications.SetRange("Primary Identification Type", "Identification Type".FromInteger(primary_identification_type.AsValue.AsInteger));
        MemberApplications.SetRange("Primary Identification", primary_identification.AsValue.AsText);
        MemberApplications.SetLoadFields("No.", "Primary Identification Type");
        if MemberApplications.FindFirst then begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description',
            StrSubstNo(
                '%1 = %2 value already exists in an ongoing member application',
                Format("Identification Type".FromInteger(primary_identification_type.AsValue.AsInteger)),
                primary_identification.AsValue.AsText
                )
            );
            ResponseObject.Add('data', ResponseData);
            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        Members.Reset();
        Members.SetRange("Primary Identification Type", "Identification Type".FromInteger(primary_identification_type.AsValue.AsInteger));
        Members.SetRange("Primary Identification", primary_identification.AsValue.AsText);
        Members.SetLoadFields("No.");
        if Members.FindFirst then begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description',
            StrSubstNo(
                '%1 = %2 value already exists',
                Format("Identification Type".FromInteger(primary_identification_type.AsValue.AsInteger)),
                primary_identification.AsValue.AsText
                )
            );
            ResponseObject.Add('data', ResponseData);
            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // Secondary Identification
        if secondary_identification.AsValue.AsText <> '' then begin
            MemberApplications.Reset();
            MemberApplications.SetRange(Created, false);
            MemberApplications.SetFilter(Status,
            '%1|%2|%3',
            MemberApplications.Status::Open,
            MemberApplications.Status::Pending,
            MemberApplications.Status::Approved);
            MemberApplications.SetRange("Secondary Identification Type", "Identification Type".FromInteger(secondary_identification_type.AsValue.AsInteger));
            MemberApplications.SetRange("Secondary Identification", secondary_identification.AsValue.AsText);
            MemberApplications.SetLoadFields("No.", "Secondary Identification Type");
            if MemberApplications.FindFirst then begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description',
                StrSubstNo(
                    '%1 = %2 value already exists in an ongoing member application',
                    Format("Identification Type".FromInteger(secondary_identification_type.AsValue.AsInteger)),
                    secondary_identification.AsValue.AsText
                    )
                );
                ResponseObject.Add('data', ResponseData);
                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            Members.Reset();
            Members.SetRange("Secondary Identification Type", "Identification Type".FromInteger(secondary_identification_type.AsValue.AsInteger));
            Members.SetRange("Secondary Identification", secondary_identification.AsValue.AsText);
            Members.SetLoadFields("No.");
            if Members.FindFirst then begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description',
                StrSubstNo(
                    '%1 = %2 value already exists',
                    Format("Identification Type".FromInteger(secondary_identification_type.AsValue.AsInteger)),
                    secondary_identification.AsValue.AsText
                    )
                );
                ResponseObject.Add('data', ResponseData);
                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end;

        exit(Response);
    end;

    // STAFF
    local procedure GetStaffPayslipPeriods(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        year: JsonToken;

        SearchMember: Record Members;
        PayslipPeriods: Record "PR Payroll Periods";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('year', year);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            if not IsMemberAStaff(SearchMember) then begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' is not a staff employee!');
            end else begin
                PayslipPeriods.Reset;
                // PayslipPeriods.SetRange(Open, false);
                PayslipPeriods.SetRange(Closed, true);
                PayslipPeriods.SetRange("Period Year", year.AsValue.AsInteger);

                if PayslipPeriods.FindSet then begin
                    repeat begin
                        Clear(Datum);

                        Datum.Add('code', PayslipPeriods."Date Opened");
                        Datum.Add('period_month', PayslipPeriods."Period Month");
                        Datum.Add('period_year', PayslipPeriods."Period Year");
                        Datum.Add('period_name', PayslipPeriods."Period Name");
                        Datum.Add('date_opened', PayslipPeriods."Date Opened");

                        Data.Add(Datum);
                    end until PayslipPeriods.Next = 0;
                end;

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Payslip periods list has been fetched successfully');
                ResponseObject.Add('data', Data);
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetStaffPayslipReport(Payload: JsonObject): Text
    var
        period: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: record Members;
        PRSalaries: record "PR Salary Card";
        Employee: record "HR Employees";

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('period', period);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            if not IsMemberAStaff(SearchMember) then begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' is not a staff employee!');
            end else begin
                Employee.Reset;
                Employee.SetRange("Member No.", SearchMember."No.");
                Employee.FindFirst;

                PRSalaries.Reset;

                PRSalaries.SetRange("Employee Code", Employee."No.");
                PRSalaries.SetRange("Period Filter", period.AsValue.AsDate);

                IF PRSalaries.FindSet then begin
                    RecRef.GetTable(PRSalaries);

                    BlobOutStream := TempBlob.CreateOutStream;
                    Report.SaveAs(Report::"Self Service Slip Portal", '', ReportFormat::Pdf, BlobOutStream, RecRef);

                    BlobInStream := TempBlob.CreateInStream;
                    FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

                    Datum.Add('file', FileContentsB64);
                    Datum.Add('file_type', 'PDF');
                    Datum.Add('file_name', Employee."No." + ' - ' + Format(period.AsValue.AsDate) + ' Payslip Report.pdf');
                    Datum.Add('file_size', StrLen(FileContentsB64));

                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Request is successful');
                    ResponseObject.Add('data', Datum);
                end else begin
                    ResponseObject.Add('status', 'NOT_FOUND');
                    ResponseObject.Add('status_description', 'Payslip for the given period ' + GlobalFunctions.FormatISODate(period.AsValue.AsDate) + ' not found');
                end;
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetStaffP9Periods(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        PayslipPeriods: Record "PR Payroll Periods";
        CurrentYear: Integer;
        MaxYearsBack: Integer;

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
            if not IsMemberAStaff(SearchMember) then begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' is not a staff employee!');
            end else begin
                CurrentYear := Date2DMY(Today, 3);
                MaxYearsBack := CurrentYear - 10;

                repeat begin
                    Clear(Datum);

                    PayslipPeriods.Reset;
                    PayslipPeriods.SetRange("Period Year", CurrentYear);

                    if PayslipPeriods.FindFirst then begin
                        Datum.Add('code', PayslipPeriods."Period Year");
                        Datum.Add('period_year', PayslipPeriods."Period Year");

                        Data.Add(Datum);
                    end;

                    CurrentYear := CurrentYear - 1;
                end until CurrentYear = MaxYearsBack;

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'P9 periods list has been fetched successfully');
                ResponseObject.Add('data', Data);
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetStaffP9Report(Payload: JsonObject): Text
    var
        period: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: record Members;
        PRSalaries: record "PR Employee P9 Info";
        Employee: record "HR Employees";

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('period', period);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            if not IsMemberAStaff(SearchMember) then begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' is not a staff employee!');
            end else begin
                Employee.Reset;
                Employee.SetRange("Member No.", SearchMember."No.");
                Employee.FindFirst;

                PRSalaries.Reset;

                PRSalaries.SetRange("Employee Code", Employee."No.");
                PRSalaries.SetRange("Period Year", period.AsValue.AsInteger);

                IF PRSalaries.FindSet then begin
                    RecRef.GetTable(PRSalaries);

                    BlobOutStream := TempBlob.CreateOutStream;
                    Report.SaveAs(Report::"P9 Portal", '', ReportFormat::Pdf, BlobOutStream, RecRef);

                    BlobInStream := TempBlob.CreateInStream;
                    FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

                    Datum.Add('file', FileContentsB64);
                    Datum.Add('file_type', 'PDF');
                    Datum.Add('file_name', Employee."No." + ' - ' + Format(period.AsValue.AsInteger) + ' P9 Report.pdf');
                    Datum.Add('file_size', StrLen(FileContentsB64));

                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Request is successful');
                    ResponseObject.Add('data', Datum);
                end else begin
                    ResponseObject.Add('status', 'NOT_FOUND');
                    ResponseObject.Add('status_description', 'P9 report for the given period ' + Format(period.AsValue.AsInteger) + ' not found');
                end;
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetStaffLeaveTypes(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        StaffLeaveTypes: Record "HR Leave Types";

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
            if not IsMemberAStaff(SearchMember) then begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' is not a staff employee!');
            end else begin
                StaffLeaveTypes.Reset;

                if SearchMember.Gender = SearchMember.Gender::Male then begin
                    StaffLeaveTypes.SetFilter(
                        Gender,
                        '=%1|%2',
                        StaffLeaveTypes.Gender::Both, StaffLeaveTypes.Gender::Male
                    );
                end;
                if SearchMember.Gender = SearchMember.Gender::Female then begin
                    StaffLeaveTypes.SetFilter(
                        Gender,
                        '=%1|%2',
                        StaffLeaveTypes.Gender::Both, StaffLeaveTypes.Gender::Female
                    );
                end;

                StaffLeaveTypes.SetFilter(Days, '>%1', 0);

                if StaffLeaveTypes.FindSet then begin
                    repeat begin
                        Clear(Datum);

                        Datum.Add('code', StaffLeaveTypes.Code);
                        Datum.Add('description', StaffLeaveTypes.Description);
                        Datum.Add('days', StaffLeaveTypes.Days);
                        Datum.Add('leave_type', Format(StaffLeaveTypes."Leave type Enum"));

                        Data.Add(Datum);
                    end until StaffLeaveTypes.Next = 0;
                end;

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Staff leave types list has been fetched successfully');
                ResponseObject.Add('data', Data);
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetStaffLeaveReliever(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        TheEmployee: record "HR Employees";
        Relievers: record "HR Employees";

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
            if not IsMemberAStaff(SearchMember) then begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' is not a staff employee!');
            end else begin
                TheEmployee.Reset;
                TheEmployee.SetRange("Member No.", SearchMember."No.");
                TheEmployee.FindFirst;

                // Job Id = 
                // Job Title =
                // Salary Grade = 
                // 

                Relievers.Reset;
                Relievers.SetRange(Status, Relievers.Status::Active);
                Relievers.SetFilter("No.", '<>%1', TheEmployee."No.");
                Relievers.SetRange("Global Dimension 1 Code", TheEmployee."Global Dimension 1 Code");
                // Relievers.SetRange("Responsibility Center", TheEmployee."Responsibility Center");

                if Relievers.FindSet then begin
                    repeat begin
                        Clear(Datum);

                        Datum.Add('employee_no', Relievers."No.");
                        Datum.Add('employee_name', Relievers.Initials + ' ' + Relievers."Full Name");
                        Datum.Add('employee_email', Relievers."E-Mail");
                        Datum.Add('gender', Format(Relievers.Gender));

                        Data.Add(Datum);
                    end until Relievers.Next = 0;
                end;

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Staff leave reliever list has been fetched successfully');
                ResponseObject.Add('data', Data);
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetStaffLeaveStatistics(Payload: JsonObject): Text
    var
        period: JsonToken;
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: record Members;
        TheEmployee: record "HR Employees";
        StaffLeaveTypes: Record "HR Leave Types";
        TheLeaveApplications: Record "HR Leave Application";

        ResponseObject: JsonObject;
        Data: JsonArray;
        LeaveTypeDatum: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            if not IsMemberAStaff(SearchMember) then begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' is not a staff employee!');
            end else begin
                TheEmployee.Reset;
                TheEmployee.SetRange("Member No.", SearchMember."No.");
                TheEmployee.SetRange("Date Filter",
                    DMY2Date(1, 1, Date2DMY(Today, 3)),
                    Today
                );

                TheEmployee.SetAutoCalcFields(
                    "Total Leave Taken",
                    "Reimbursed Leave Days",
                    "Allocated Leave Days",
                    "Annual Leave Account",
                    "Compassionate Leave Acc.",
                    "Maternity Leave Acc.",
                    "Paternity Leave Acc.",
                    "Sick Leave Acc.",
                    "Study Leave Acc"
                );
                TheEmployee.FindFirst;

                Datum.Add('total_leave_taken', TheEmployee."Total Leave Taken");
                // Datum.Add('reimbursed_leave_days', TheEmployee."Reimbursed Leave Days");
                // Datum.Add('allocated_leave_days', TheEmployee."Allocated Leave Days");

                StaffLeaveTypes.Reset;
                if SearchMember.Gender = SearchMember.Gender::Male then begin
                    StaffLeaveTypes.SetFilter(
                        Gender,
                        '=%1|%2',
                        StaffLeaveTypes.Gender::Both, StaffLeaveTypes.Gender::Male
                    );
                end;
                if SearchMember.Gender = SearchMember.Gender::Female then begin
                    StaffLeaveTypes.SetFilter(
                        Gender,
                        '=%1|%2',
                        StaffLeaveTypes.Gender::Both, StaffLeaveTypes.Gender::Female
                    );
                end;

                StaffLeaveTypes.SetFilter(Days, '>%1', 0);
                StaffLeaveTypes.SetRange(Active, true);
                if StaffLeaveTypes.FindSet then begin
                    repeat begin
                        Clear(LeaveTypeDatum);

                        LeaveTypeDatum.Add('code', StaffLeaveTypes.Code);
                        LeaveTypeDatum.Add('description', StaffLeaveTypes.Description);
                        LeaveTypeDatum.Add('leave_type', Format(StaffLeaveTypes."Leave type Enum"));

                        case StaffLeaveTypes."Leave type Enum" of
                            StaffLeaveTypes."Leave type Enum"::Annual:
                                begin
                                    if TheEmployee."Annual Leave Account" = 0 then begin
                                        LeaveTypeDatum.Add('total_days', StaffLeaveTypes.Days);
                                    end else begin
                                        LeaveTypeDatum.Add('total_days', TheEmployee."Annual Leave Account");
                                    end;
                                end;
                            StaffLeaveTypes."Leave type Enum"::Compassionate:
                                begin
                                    if TheEmployee."Compassionate Leave Acc." = 0 then begin
                                        LeaveTypeDatum.Add('total_days', StaffLeaveTypes.Days);
                                    end else begin
                                        LeaveTypeDatum.Add('total_days', TheEmployee."Compassionate Leave Acc.");
                                    end;
                                end;
                            StaffLeaveTypes."Leave type Enum"::Maternity:
                                begin
                                    if TheEmployee."Maternity Leave Acc." = 0 then begin
                                        LeaveTypeDatum.Add('total_days', StaffLeaveTypes.Days);
                                    end else begin
                                        LeaveTypeDatum.Add('total_days', TheEmployee."Maternity Leave Acc.");
                                    end;
                                end;
                            StaffLeaveTypes."Leave type Enum"::Paternity:
                                begin
                                    if TheEmployee."Paternity Leave Acc." = 0 then begin
                                        LeaveTypeDatum.Add('total_days', StaffLeaveTypes.Days);
                                    end else begin
                                        LeaveTypeDatum.Add('total_days', TheEmployee."Paternity Leave Acc.");
                                    end;
                                end;
                            StaffLeaveTypes."Leave type Enum"::"Sick Leave":
                                begin
                                    if TheEmployee."Sick Leave Acc." = 0 then begin
                                        LeaveTypeDatum.Add('total_days', StaffLeaveTypes.Days);
                                    end else begin
                                        LeaveTypeDatum.Add('total_days', TheEmployee."Sick Leave Acc.");
                                    end;
                                end;
                            StaffLeaveTypes."Leave type Enum"::"Study Leave":
                                begin
                                    if TheEmployee."Study Leave Acc" = 0 then begin
                                        LeaveTypeDatum.Add('total_days', StaffLeaveTypes.Days);
                                    end else begin
                                        LeaveTypeDatum.Add('total_days', TheEmployee."Study Leave Acc");
                                    end;
                                end;
                            else
                                LeaveTypeDatum.Add('total_days', 0);
                        end;

                        // Spent Days
                        TheLeaveApplications.Reset;
                        TheLeaveApplications.SetRange("Leave Type", StaffLeaveTypes.Code);
                        TheLeaveApplications.SetFilter("Start Date", '>=%1', DMY2Date(1, 1, Date2DMY(Today, 3)));
                        TheLeaveApplications.SetFilter("End Date", '<=%1', DMY2Date(31, 12, Date2DMY(Today, 3)));

                        TheLeaveApplications.CalcSums("Days Approved");
                        LeaveTypeDatum.Add('spent_days', TheLeaveApplications."Days Approved");

                        Data.Add(LeaveTypeDatum);
                    end until StaffLeaveTypes.Next = 0;
                end;

                Datum.Add('leave_types', Data);

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Staff leave types list has been fetched successfully');
                ResponseObject.Add('data', Datum);
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CreateStaffLeaveApplicationRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        leave_type: JsonToken;
        days_applied: JsonToken;
        start_date: JsonToken;
        reliever: JsonToken;

        SearchMember: record Members;
        Employee: record "HR Employees";
        theLeaveApplication: Record "HR Leave Application";
        HRSetup: Record "HR Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('leave_type', leave_type);
        Payload.Get('start_date', start_date);
        Payload.Get('days_applied', days_applied);
        Payload.Get('reliever', reliever);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            if not IsMemberAStaff(SearchMember) then begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' is not a staff employee!');
            end else begin
                Employee.Reset;
                Employee.SetRange("Member No.", SearchMember."No.");
                Employee.FindFirst;

                theLeaveApplication.Init;

                HRSetup.Get;
                HRSetup.TestField(HRSetup."Leave Application Nos.");
                theLeaveApplication."Application Code" := NoSeriesMgt.GetNextNo(HRSetup."Leave Application Nos.");
                // NoSeriesMgt.InitSeries(HRSetup."Leave Application Nos.", '', 0D, theLeaveApplication."Application Code", theLeaveApplication."No series");

                theLeaveApplication."Source of Application" := theLeaveApplication."Source of Application"::"Staff Portal";
                theLeaveApplication."Applicant Staff No." := Employee."No.";
                theLeaveApplication.Validate("Applicant Staff No.");

                theLeaveApplication."Leave Type" := leave_type.AsValue.AsText;
                theLeaveApplication.Validate("Leave Type");
                theLeaveApplication."Start Date" := start_date.AsValue.AsDate;
                theLeaveApplication.Validate("Start Date");
                Evaluate(theLeaveApplication."Days Applied", days_applied.AsValue.AsText);
                //theLeaveApplication."Days Applied" := days_applied.AsValue.AsInteger;
                theLeaveApplication.Validate("Days Applied");
                theLeaveApplication.Reliever := reliever.AsValue.AsText;
                theLeaveApplication."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                theLeaveApplication."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                theLeaveApplication.Validate(Reliever);

                // theLeaveApplication.Status := theLeaveApplication.Status::"Pending Approval";
                // theLeaveApplication.Validate(Status);

                if theLeaveApplication.Insert(true) then begin
                    VarVariant := theLeaveApplication;
                    // if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                    CustomApprovals.OnSendDocForApproval(VarVariant);

                    Datum.Add('application_no', theLeaveApplication."Application Code");

                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Request is successful');
                    ResponseObject.Add('data', Datum);
                end else begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', GetLastErrorText(true));
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);

                    exit(Response);
                end;
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetStaffLeaveApplicationRequests(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        TheEmployee: record "HR Employees";
        LeaveApplications: Record "HR Leave Application";
        StaffLeaveTypes: Record "HR Leave Types";

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
            if not IsMemberAStaff(SearchMember) then begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' is not a staff employee!');
            end else begin
                TheEmployee.Reset;
                TheEmployee.SetRange("Member No.", SearchMember."No.");
                TheEmployee.FindFirst;

                LeaveApplications.Reset;
                LeaveApplications.SetRange("Applicant Staff No.", TheEmployee."No.");

                if LeaveApplications.FindSet then begin
                    repeat begin
                        Clear(Datum);

                        Datum.Add('application_no', LeaveApplications."Application Code");
                        Datum.Add('employee_no', LeaveApplications."Applicant Staff No.");
                        Datum.Add('leave_type', LeaveApplications."Leave Type");

                        StaffLeaveTypes.Get(LeaveApplications."Leave Type");
                        Datum.Add('leave_name', StaffLeaveTypes.Description);

                        Datum.Add('days_applied', LeaveApplications."Days Applied");
                        Datum.Add('start_date', GlobalFunctions.FormatISODate(LeaveApplications."Start Date"));
                        Datum.Add('end_date', GlobalFunctions.FormatISODate(LeaveApplications."End Date"));
                        Datum.Add('return_date', GlobalFunctions.FormatISODate(LeaveApplications."Return Date"));
                        Datum.Add('status', Format(LeaveApplications.Status).ToUpper);
                        Datum.Add('reliever_no', LeaveApplications.Reliever);
                        Datum.Add('reliever_name', LeaveApplications."Reliever Name");
                        Datum.Add('posted', LeaveApplications.Posted);
                        Datum.Add('date_posted', GlobalFunctions.FormatISODate(LeaveApplications."Date Posted"));
                        Datum.Add('time_posted', GlobalFunctions.FormatISOTime(LeaveApplications."Time Posted"));

                        Data.Add(Datum);
                    end until LeaveApplications.Next = 0;
                end;

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Staff leave application request list has been fetched successfully');
                ResponseObject.Add('data', Data);
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CancelStaffLeaveApplicationRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;

        SearchMember: record Members;
        Employee: record "HR Employees";
        TheLeaveApplication: Record "HR Leave Application";

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
            if not IsMemberAStaff(SearchMember) then begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' is not a staff employee!');
            end else begin
                Employee.Reset;
                Employee.SetRange("Member No.", SearchMember."No.");
                Employee.FindFirst;

                TheLeaveApplication.Reset;
                TheLeaveApplication.SetRange("Application Code", application_no.AsValue.AsText);
                TheLeaveApplication.SetRange("Applicant Staff No.", Employee."No.");
                TheLeaveApplication.SetFilter(Status, '%1|%2', TheLeaveApplication.Status::New, TheLeaveApplication.Status::"Pending Approval");

                if TheLeaveApplication.FindFirst then begin
                    TheLeaveApplication.Status := TheLeaveApplication.Status::Cancelled;
                    if TheLeaveApplication.Modify(true) then begin
                        ResponseObject.Add('status', 'SUCCESS');
                        ResponseObject.Add('status_description', 'Staff leave application request has been cancelled successfully');
                    end else begin
                        ResponseObject.Add('status', 'ERROR');
                        ResponseObject.Add('status_description', GetLastErrorText(true));
                        AddDateTimeToResponse(ResponseObject);
                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
                end else begin
                    ResponseObject.Add('status', 'NOT_FOUND');
                    ResponseObject.Add('status_description', 'The leave application ' + application_no.AsValue.AsText + ' is NOT available for cancellation');
                end;
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetStaffLeaveCalculationRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        leave_type_code: JsonToken;
        start_date: JsonToken;
        days_applied: JsonToken;

        StartDate: Date;
        EndDate: Date;
        ReturnDate: Date;
        DaysApplied: Decimal;

        SearchMember: record Members;
        Employee: record "HR Employees";
        TheLeaveApplication: Record "HR Leave Application";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('leave_type_code', leave_type_code);
        Payload.Get('start_date', start_date);
        Payload.Get('days_applied', days_applied);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            if not IsMemberAStaff(SearchMember) then begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' is not a staff employee!');
            end else begin
                Employee.Reset;
                Employee.SetRange("Member No.", SearchMember."No.");
                Employee.FindFirst;

                Evaluate(StartDate, start_date.AsValue.AsText);

                if TheLeaveApplication.DetermineIfIsNonWorking(StartDate) then begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', 'The leave start date MUST be a working day.');
                end else begin
                    DaysApplied := days_applied.AsValue.AsDecimal;
                    ReturnDate := TheLeaveApplication.DetermineLeaveReturnDate(StartDate, DaysApplied);
                    EndDate := TheLeaveApplication.DeterminethisLeaveEndDate(ReturnDate);

                    // if Date2DMY(Today, 3) < Date2DMY(ReturnDate, 3) then begin
                    //     ResponseObject.Add('status', 'ERROR');
                    //     ResponseObject.Add('status_description', 'Leave application must be done within the current year ' + Format(Date2DMY(Today, 3)));
                    // end else begin
                    Datum.Add('leave_type_code', leave_type_code);
                    Datum.Add('start_date', start_date);
                    Datum.Add('days_applied', days_applied);
                    Datum.Add('end_date', GlobalFunctions.FormatISODate(EndDate));
                    Datum.Add('return_date', GlobalFunctions.FormatISODate(ReturnDate));

                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Request is successful');
                    ResponseObject.Add('data', Datum);
                    // end;
                end;
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    // LOAN APPLICATIONS
    local procedure GetNetSalaryAmount(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        loan_type_id: JsonToken;

        SearchMember: Record Members;
        MobileLoanProduct: Record "Product Factory";

        SalAvg: decimal;
        SalaryAmount: decimal;
        Incomsal: Enum "Salary Income Types";
        SalaryAccount: record "Savings Accounts";
        FosaAccount: Text;
        SalaryLines: Record "Salary Lines";
        ProdFac: record "Product Factory";
        STOAmount: decimal;
        LoanRec: decimal;

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Datum: JsonObject;
        Response: Text;

        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('loan_type_id', loan_type_id);

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            SalAvg := 0;
            SalaryAmount := 0;
            FosaAccount := SkyMbankingTrans.GetMemberFosaAcc(SearchMember);

            if ProdFac.Get(loan_type_id.AsValue.AsText) then begin
                SalaryAccount.Reset;
                SalaryAccount.SetRange("No.", FosaAccount);
                if SalaryAccount.FindFirst then begin
                    SalAvg := GlobalFunctions.GetSmallestSalary(SalaryAccount."No.", Incomsal::Salary);
                    STOAmount := SkyMbankingTrans.ComputeSTODeductions(SalaryAccount."No.");
                    LoanRec := SkyMbankingTrans.ComputeLoanDeductions(SalaryAccount."Member No.");

                    IF (SalaryAccount.Status <> SalaryAccount.Status::Active) OR (SalaryAccount.Blocked <> SalaryAccount.Blocked::" ") THEN BEGIN
                        Datum.Add('net_salary', 0);
                    END else begin
                        //Get last salary amount
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("Member No.", SalaryAccount."Member No.");
                        SalaryLines.SETRANGE(Posted, TRUE);

                        if format(ProdFac."Salary Period") <> '' then begin
                            SalaryLines.SETRANGE("Posting Date", CALCDATE(('-' + format(ProdFac."Salary Period")), TODAY), TODAY);
                        end;

                        SalaryLines.SetLoadFields(Amount);
                        IF SalaryLines.FINDLAST THEN BEGIN
                            SalaryAmount := SalaryLines.Amount - (STOAmount + LoanRec);
                        END;
                        SalAvg := SalAvg - (STOAmount + LoanRec);
                        IF SalaryAmount > SalAvg THEN
                            SalaryAmount := SalAvg;

                        Datum.Add('net_salary', SalaryAmount);
                    end;
                end else begin
                    Datum.Add('net_salary', 0);
                end;
            end else begin
                Datum.Add('net_salary', 0);
            end;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('data', Datum);
        end else begin
            ResponseObject.Add('status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('data', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure ValidateGuarantorEligibilityRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        member_no: JsonToken;
        loan_type_id: JsonToken;

        TheMember: Record Members;
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
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('member_no', member_no);
        Payload.Get('loan_type_id', loan_type_id);

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, TheMember, ResponseText, ResponseDescription) then begin
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
                if SearchMember."No." = TheMember."No." then begin
                    ResponseObject.Add('status', 'ERROR');
                    Datum.Add('error_message', 'You may NOT add yourself as a guarantor. Select the self guarantorship option to add yourself as a guarantor');
                    ResponseObject.Add('data', Datum);
                end else begin
                    SalaryAmount := GuarantorSalaryEligibility(loan_type_id.AsValue.AsText, SearchMember, 0, FailReason);

                    if SalaryAmount <= 0 then begin
                        Datum.Add('eligible', false);
                        Datum.Add('eligible_fail_reason', FailReason);
                    end else begin
                        Datum.Add('eligible', true);
                        Datum.Add('eligible_fail_reason', '');
                    end;

                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('data', Datum);
                end;
            end else begin
                SearchMember.Reset;
                SearchMember.SetRange("No.", member_no.asValue.Astext);

                IF SearchMember.FindFirst then begin
                    ResponseObject.Add('status', 'ERROR');
                    Datum.Add('error_message', 'Member with no. ' + member_no.AsValue.AsText + ' NOT eligible.');
                    ResponseObject.Add('data', Datum);
                end else begin
                    ResponseObject.Add('status', 'ERROR');
                    Datum.Add('error_message', 'Member with no. ' + member_no.AsValue.AsText + ' NOT found!');
                    ResponseObject.Add('data', Datum);
                end;
            end;
        end else begin
            ResponseObject.Add('status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('data', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure GetMobileLoanQualificationAmount(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        loan_type_id: JsonToken;
        installments: JsonToken;

        SearchMember: Record Members;
        MobileLoanProduct: Record "Product Factory";
        ProductSupportedClasses: Record "Product Supported Classes";
        BlockedEmployers: Record "Blocked Employers";
        MblLoanException: Record "Mobile Loan Exceptions";
        // IsFosaMLoanProduct: Boolean;
        TopUpLoan: Record Loans;
        TotalTopUp: Decimal;

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Datum: JsonObject;
        Response: Text;

        ResponseText: Text;
        ResponseDescription: Text;

        SalaryAmount: Decimal;
        EligibilityFailReason: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('loan_type_id', loan_type_id);
        // IsFosaMLoanProduct := Payload.Get('installments', installments);

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            MobileLoanProduct.Reset;
            MobileLoanProduct.SetRange("Product ID", loan_type_id.AsValue.AsText);

            MobileLoanProduct.SetLoadFields(
                "Product ID", "Product Description", "Minimum Loan Amount", "Mobile Max. Loan Amount", "Maximum Loan Amount", "Mobile Loan", "FosaLoan Multiplier", "Allow Topup"
            );

            if MobileLoanProduct.FindFirst then begin

                ProductSupportedClasses.Reset();
                ProductSupportedClasses.SetRange("Product ID", MobileLoanProduct."Product ID");
                ProductSupportedClasses.SetRange("Class Category", SearchMember."Member Class");
                if ProductSupportedClasses.IsEmpty() then begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', StrSubstNo('This loan product is not available to %1 members.', SearchMember."Member Class"));
                    ResponseObject.Add('response_payload', Datum);
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;

                BlockedEmployers.Reset();
                BlockedEmployers.SetRange("Product ID", MobileLoanProduct."Product ID");
                BlockedEmployers.SetRange("Employer Code", SearchMember."Employer Code");
                if not BlockedEmployers.IsEmpty() then begin
                    MblLoanException.Reset();
                    MblLoanException.SetRange("Member No.", SearchMember."No.");
                    MblLoanException.SetRange("Product ID", MobileLoanProduct."Product ID");
                    if MblLoanException.IsEmpty() then begin
                        ResponseObject.Add('request_status', 'ERROR');
                        Datum.Add('error_message', 'This loan product is not available to members of your employer.');
                        ResponseObject.Add('response_payload', Datum);
                        AddDateTimeToResponse(ResponseObject);
                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
                end;

                Datum.Add('loan_type_id', MobileLoanProduct."Product ID");
                Datum.Add('loan_name', MobileLoanProduct."Product Description");

                if MobileLoanProduct."Mobile Loan" then begin
                    if MobileLoanProduct."Allow Topup" then begin
                        // if IsFosaMLoanProduct then begin
                        Datum.Add('eligible_amount', SkyMbankingTrans.GetLoansQualifyAmount2(SearchMember."No.", MobileLoanProduct."Product ID"/*, installments.AsValue.AsInteger*/, EligibilityFailReason));
                        // end else begin
                        //     Datum.Add('eligible_amount', SkyMbankingTrans.GetLoansQualifyAmount(SearchMember."No.", MobileLoanProduct."Product ID", 0, EligibilityFailReason));
                        // end;
                    end else begin
                        Datum.Add('eligible_amount', SkyMbankingTrans.GetLoansQualifyAmount(SearchMember."No.", MobileLoanProduct."Product ID", 0, EligibilityFailReason));
                    end;
                end else begin
                    if MobileLoanProduct."Source Unit" = MobileLoanProduct."Source Unit"::FOSA then begin
                        SalaryAmount := GuarantorSalaryEligibility(loan_type_id.AsValue.AsText, SearchMember);
                        Datum.Add('eligible_amount', SalaryAmount * MobileLoanProduct."FosaLoan Multiplier");
                    end else begin
                        Datum.Add('eligible_amount', 0);
                    end;
                end;

                if MobileLoanProduct."Allow Topup" then begin
                    TotalTopUp := MobileLoanProduct."Minimum Loan Amount";

                    TopUpLoan.Reset;
                    TopUpLoan.SetRange("Member No.", SearchMember."No.");
                    TopUpLoan.SetRange("Loan Product Type", MobileLoanProduct."Product ID");
                    TopUpLoan.SetFilter("Outstanding Balance", '>0');
                    TopUpLoan.SetRange(Posted, true);

                    TopUpLoan.SetLoadFields("Loan No.", "Outstanding Balance", "Outstanding Interest", "Daily Interest");
                    TopUpLoan.SetAutoCalcFields("Outstanding Balance", "Outstanding Interest", "Daily Interest");

                    if TopUpLoan.FindSet then begin
                        TotalTopUp := 0;

                        repeat begin
                            TotalTopUp += TopUpLoan."Outstanding Balance" + TopUpLoan."Outstanding Interest" + TopUpLoan."Daily Interest";
                        end until TopUpLoan.Next = 0;

                        if TotalTopUp < MobileLoanProduct."Minimum Loan Amount" then begin
                            TotalTopUp := MobileLoanProduct."Minimum Loan Amount";
                        end;
                    end;

                    Datum.Add('loan_type_min_amount', TotalTopUp);
                end else begin
                    Datum.Add('loan_type_min_amount', MobileLoanProduct."Minimum Loan Amount");
                end;

                if MobileLoanProduct."Mobile Max. Loan Amount" <> 0 then begin
                    Datum.Add('loan_type_max_amount', MobileLoanProduct."Mobile Max. Loan Amount");
                end else
                    if MobileLoanProduct."Maximum Loan Amount" <> 0 then begin
                        Datum.Add('loan_type_max_amount', MobileLoanProduct."Maximum Loan Amount");
                    end else begin
                        Datum.Add('loan_type_max_amount', 0);
                    end;


                Datum.Add('eligibility_fail_reason', EligibilityFailReason);

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('data', Datum);
            end else begin
                ResponseObject.Add('status', 'ERROR');
                Datum.Add('error_message', 'Loan product with ID = ' + loan_type_id.AsValue.AsText + ' NOT found!');
                ResponseObject.Add('data', Datum);
            end;
        end else begin
            ResponseObject.Add('status', 'ERROR');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('data', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);
        exit(Response);
    end;

    local procedure GetLoanApplicationProducts(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        MemberRec: Record Members;
        ProductFactory: Record "Product Factory";
        ProductSupportedClasses: Record "Product Supported Classes";


        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
        EligibleClass: JsonArray;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            ProductFactory.Reset;
            ProductFactory.SetRange("Product Class Type", ProductFactory."Product Class Type"::Loan);
            ProductFactory.SetRange(Status, ProductFactory.Status::Active);
            // ProductFactory.SetRange("Mobile Loan", true);
            ProductFactory.SetRange("Is CRM Product", true);
            // ProductFactory.SetRange("Is USSD Product", false);
            ProductFactory.SetFilter("Source Unit", '<>%1', ProductFactory."Source Unit"::"HR LOANS");

            if SearchMember."Employer Code" = 'RETIREE' then begin
                // Pension only 
                ProductFactory.SetRange("Salary Income Types", ProductFactory."Salary Income Types"::Pension);
            end else begin
                // Salaried
                ProductFactory.SetRange("Salary Income Types", ProductFactory."Salary Income Types"::Salary);
            end;

            if ProductFactory.FindSet then begin
                repeat begin
                    Clear(EligibleClass);

                    ProductSupportedClasses.Reset();
                    ProductSupportedClasses.SetRange(
                        "Product ID",
                        ProductFactory."Product ID"
                    );

                    if ProductSupportedClasses.FindSet() then begin
                        repeat
                            EligibleClass.Add(
                                Format(ProductSupportedClasses."Class Category")
                            );
                        until ProductSupportedClasses.Next() = 0;
                    end;

                    Clear(Datum);

                    Datum.Add('loan_code', ProductFactory."Product ID");
                    Datum.Add('product_id', ProductFactory."Product ID");
                    Datum.Add('product_name', ProductFactory."Product Description");
                    Datum.Add('minimum_guarantors', ProductFactory."Minimum Guarantors");
                    Datum.Add('maximum_guarantors', ProductFactory."Maximum Guarantors");
                    Datum.Add('minimum_amount', ProductFactory."Minimum Loan Amount");
                    Datum.Add('maximum_amount', ProductFactory."Maximum Loan Amount");
                    Datum.Add('repayment_frequency', Format(ProductFactory."Repayment Frequency"));
                    Datum.Add('min_interest_rate', Format(ProductFactory."Interest Rate (Min.)"));
                    Datum.Add('min_interest_rate_monthly', Format(ProductFactory."Interest Rate (Min.)" / 12));
                    Datum.Add('maximum_installments', ProductFactory."Ordinary Default Intallments");
                    Datum.Add('interest_calculation_method', Format(ProductFactory."Interest Calculation Method"));
                    Datum.Add('is_mobile_loan', ProductFactory."Mobile Loan");
                    Datum.Add('repayment_mode', Format(ProductFactory."Repay Mode"));
                    Datum.Add('source', ProductFactory."Source of Funds");
                    Datum.Add('source_unit', Format(ProductFactory."Source Unit"));
                    Datum.Add('requires_installments', ProductFactory."Allow Topup");
                    Datum.Add('eligible_member_class', EligibleClass);

                    Data.Add(Datum);
                end until ProductFactory.Next = 0;
            end;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Loan application product list has been fetched successfully');
            ResponseObject.Add('data', Data);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
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


    local procedure CreateLoanApplicationRequest(Payload: JsonObject): Text
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

        // // id_front_file: JsonToken;
        // id_front_file_name: JsonToken;
        // id_front_file_contents: JsonToken;
        // // id_back_file: JsonToken;
        // id_back_file_name: JsonToken;
        // id_back_file_contents: JsonToken;
        // // payslip_file: JsonToken;
        // payslip_file_name: JsonToken;
        // payslip_file_contents: JsonToken;

        loans_to_be_cleared: JsonToken;
        loan_to_be_cleared: JsonToken;

        guarantors: JsonToken;
        guarantor: JsonToken;
        guarantor_member_number: JsonToken;

        files: JsonToken;
        file: JsonToken;
        file_name: JsonToken;
        file_contents: JsonToken;

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

        KeyExists: Boolean;
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        Base64Convert: Codeunit "Base64 Convert";

        StoreImageRef: FieldRef;
        StoreRecRef: RecordRef;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
        FailReason: Text;
        BalGuara: Decimal;
        LoanGuara: record "Loan Guarantors and Security";
        SavAcc: record "Savings Accounts";
        GenSetup: record "General Set-Up";
        MaxSelfGuar: Decimal;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('loan_product', loan_product);
        Payload.Get('loan_purpose', loan_purpose);
        Payload.Get('installments', installments);
        Payload.Get('requested_amount', requested_amount);
        Payload.Get('guarantors', guarantors);
        Payload.Get('sasra_main_sector', sasra_main_sector);
        Payload.Get('sasra_sub_sector_1', sasra_sub_sector_1);
        Payload.Get('sasra_sub_sector_2', sasra_sub_sector_2);
        Payload.Get('is_self_guarantee', is_self_guarantee);
        Payload.Get('loans_to_be_cleared', loans_to_be_cleared);

        KeyExists := Payload.Get('files', files);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            // Create Mobile Loan Application request
            MobileLoanProduct.Reset;
            MobileLoanProduct.SetRange("Product ID", loan_product.AsValue.AsText);
            MobileLoanProduct.SetRange("Mobile Loan", true);
            MobileLoanProduct.SetLoadFields("Product ID");

            if MobileLoanProduct.FindFirst then begin
                exit(MobileLoanApplication(Payload))
            end;

            // Non mobile loan application

            TheLoanApplication.Init;
            TheLoanApplication."Member No." := SearchMember."No.";
            TheLoanApplication."Loan Product Type" := loan_product.AsValue.AsText;
            TheLoanApplication."Loan Purpose" := loan_purpose.AsValue.AsText;
            TheLoanApplication.Installments := installments.AsValue.AsInteger;
            TheLoanApplication."Requested Amount" := requested_amount.AsValue.AsDecimal;
            TheLoanApplication."Source Application" := TheLoanApplication."Source Application"::"Member Portal";
            TheLoanApplication."Main Sector" := sasra_main_sector.AsValue.AsText;
            TheLoanApplication."Sub Sector Level1" := sasra_sub_sector_1.AsValue.AsText;
            TheLoanApplication."Sub Sector Level2" := sasra_sub_sector_2.AsValue.AsText;

            if is_self_guarantee.IsValue then begin
                TheLoanApplication."Is Self Guarantee" := is_self_guarantee.AsValue.AsBoolean;
            end;

            if GlobalFunctions.IsFOSALoanProduct(loan_product.AsValue.AsText) then begin
                TheLoanApplication."Is Self Guarantee" := false;
            end;

            // Validate loan guarantors
            foreach guarantor in guarantors.AsArray do begin
                if TheLoanApplication."Is Self Guarantee" then begin
                    ResponseObject.Add('status', 'ERROR');
                    Datum.Add('error_message', 'You may NOT add a list of guarantors for self guaranteed loan application');
                    ResponseObject.Add('data', Datum);

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
                        ResponseObject.Add('status', 'ERROR');
                        Datum.Add('error_message', 'Member with no. ' + guarantor_member_number.AsValue.AsText + ' is NOT eligible for guarantorship due to deposits requirements!' + FailReason);
                        ResponseObject.Add('data', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
                end;
            end;


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
                    ResponseObject.Add('status', 'ERROR');
                    Datum.Add('error_message', 'The requested amount is insufficient to top up the requested loan(s)');
                    ResponseObject.Add('data', Datum);

                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end;

            if GlobalFunctions.IsFOSALoanProduct(loan_product.AsValue.AsText) then begin
                TheLoanApplication."Is Self Guarantee" := false;
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
                    // Commit;
                end;

                // -------------------------------------------------------------------------------------------------------------------------

                if TheLoanApplication."Is Self Guarantee" then begin
                    //Controls for self guarantorship to mirror loans
                    //Balance guaranteed loans
                    MaxSelfGuar := 0;
                    BalGuara := 0;
                    LoanGuara.Reset;
                    LoanGuara.setrange("Member No", SearchMember."No.");
                    LoanGuara.setrange(substituted, false);
                    LoanGuara.CalcFields("Loan Type", "Outstanding Balance");
                    LoanGuara.setfilter("Loan Type", '<>%1&<>%2', 'STD', 'SCL');
                    LoanGuara.SetFilter("Outstanding Balance", '>0');
                    if LoanGuara.Find('-') then begin
                        LoanGuara.CalcSums("Amount Guaranteed");
                        BalGuara := BalGuara + LoanGuara."Amount Guaranteed";
                    end;
                    //SelfGuaBal:=0;
                    SavAcc.Reset;
                    SavAcc.SetRange(SavAcc."Member No.", SearchMember."No.");
                    SavAcc.SetRange(SavAcc."Product Type", '1');
                    if SavAcc.Find('-') then begin
                        SavAcc.CalcFields(SavAcc."Balance (LCY)");
                        GenSetup.Get;
                        if GenSetup."Self Guarantee %" > 0 then
                            MaxSelfGuar := (SavAcc."Balance (LCY)" * GenSetup."Self Guarantee %" * 0.01) - BalGuara
                        else
                            MaxSelfGuar := SavAcc."Balance (LCY)" - BalGuara;
                        if MaxSelfGuar < 0 then MaxSelfGuar := 0;
                        if requested_amount.AsValue.AsDecimal > MaxSelfGuar then begin
                            ResponseObject.Add('status', 'ERROR');
                            Datum.Add('error_message', 'The requested amount is more than availabe deposit balance for self guarantee. Maximum self guarantorship amount is KES ' +
                              Format(MaxSelfGuar));
                            ResponseObject.Add('data', Datum);

                            AddDateTimeToResponse(ResponseObject);

                            ResponseObject.WriteTo(Response);
                            exit(Response);
                        end;
                    end;
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

                // -------------------------------------------------------------------------------------------------------------------------

                Datum.Add('application_no', TheLoanApplication."Application No.");

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Loan application request has been created successfully');
                ResponseObject.Add('data', Datum);
            end else begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', GetLastErrorText(true));
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    procedure UploadLoanFileToEDMS(Rec: Record "Sky Channels Loan Applications"; FileName: Text; FileContentsB64: Text)
    var
        EDMSFunctions: Codeunit "EDMS Functions";

        ApplicantMember: Record Members;

        IDNumber: Text;
        ApplicationType: Label 'LA'; // Loan Application
        PFNumber: Text;
    begin
        ApplicantMember.Reset;

        ApplicantMember.SetRange("No.", Rec."Member No.");

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

            Rec.CalcFields("Loan Product Name");

            EDMSFunctions.EDMSLoanFileUpload(
              IDNumber,
                ApplicantMember.Name,
                Rec."Loan Product Name",
                PfNumber,
                ApplicantMember."No.",
                Rec."Application No.",
                Rec."Application No.",
                FileName,
                FileContentsB64, false
            );
        end;
    end;

    local procedure MobileLoanApplication(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        loan_product: JsonToken;
        loan_purpose: JsonToken;
        installments: JsonToken;
        requested_amount: JsonToken;

        KeyExists: Boolean;

        SearchMember: Record Members;
        MobileLoanProduct: Record "Product Factory";
        TheLoan: Record Loans;
        MobileLoanPurpose: Text;
        theSMS: Text;
        theReference: Text;
        SkySMS: Codeunit SendSms;
        SMSSource: Enum "SMS Source";
        TheLoanPurposes: Record "Loan Purpose";

        ResponseObject: JsonObject;
        MemberDetails: JsonObject;
        Datum: JsonObject;
        Response: Text;

        ResponseText: Text;
        ResponseDescription: Text;
        EligibilityFailReason: Text;
        TotalTopUp: Decimal;
        TopUpLoan: Record Loans;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('loan_product', loan_product);
        Payload.Get('loan_purpose', loan_purpose);
        Payload.Get('installments', installments);
        Payload.Get('requested_amount', requested_amount);

        MobileLoanPurpose := '';
        TheLoanPurposes.Reset;
        TheLoanPurposes.SetRange("Available On Mobile", true);
        if TheLoanPurposes.FindFirst then begin
            MobileLoanPurpose := TheLoanPurposes.Code;
        end;
        if KeyExists then begin
            MobileLoanPurpose := loan_purpose.AsValue.AsText;
        end;

        theReference := GlobalFunctions.CleanGuid;

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            MobileLoanProduct.Reset;
            MobileLoanProduct.SetRange("Product ID", loan_product.AsValue.AsText);
            MobileLoanProduct.SetRange("Mobile Loan", true);

            MobileLoanProduct.SetLoadFields(
                "Product ID", "Mobile Max. Loan Amount", "Minimum Loan Amount",
                "Allow Topup"
            );

            if MobileLoanProduct.FindFirst then begin
                // Check loan Limit
                if MobileLoanProduct."Allow Topup" then begin
                    if MobileLoanProduct."Allow Topup" then begin
                        if SkyMbankingTrans.GetLoansQualifyAmount2(SearchMember."No.", MobileLoanProduct."Product ID"/*, installments.AsValue.AsInteger*/, EligibilityFailReason) < requested_amount.AsValue.AsDecimal then begin
                            ResponseObject.Add('status', 'ERROR');
                            Datum.Add('error_message', 'Loan amount exceeds the maximum limit allowed for the member of ' + Format(SkyMbankingTrans.GetLoansQualifyAmount2(SearchMember."No.", MobileLoanProduct."Product ID"/*, installments.AsValue.AsInteger*/, EligibilityFailReason)));
                            ResponseObject.Add('data', Datum);

                            AddDateTimeToResponse(ResponseObject);

                            ResponseObject.WriteTo(Response);
                            exit(Response);
                        end;

                        // Validate minimum top up
                        TotalTopUp := 0;

                        TopUpLoan.Reset;
                        TopUpLoan.SetRange("Member No.", SearchMember."No.");
                        TopUpLoan.SetRange("Loan Product Type", MobileLoanProduct."Product ID");
                        TopUpLoan.SetFilter("Outstanding Balance", '>0');
                        TopUpLoan.SetRange(Posted, true);

                        TopUpLoan.SetLoadFields("Loan No.", "Outstanding Balance", "Outstanding Interest", "Daily Interest");
                        TopUpLoan.SetAutoCalcFields("Outstanding Balance", "Outstanding Interest", "Daily Interest");

                        if TopUpLoan.FindSet then begin
                            repeat begin
                                TotalTopUp += TopUpLoan."Outstanding Balance" + TopUpLoan."Outstanding Interest" + TopUpLoan."Daily Interest";
                            end until TopUpLoan.Next = 0;

                            if TotalTopUp < MobileLoanProduct."Minimum Loan Amount" then begin
                                TotalTopUp := MobileLoanProduct."Minimum Loan Amount";
                            end;
                        end;

                        if TotalTopUp <> 0 then begin
                            if requested_amount.AsValue.AsDecimal < TotalTopUp then begin
                                ResponseObject.Add('status', 'ERROR');
                                Datum.Add('error_message', 'Loan amount must be above the minimum amount of KES ' + Format(TotalTopUp));
                                ResponseObject.Add('data', Datum);

                                AddDateTimeToResponse(ResponseObject);

                                ResponseObject.WriteTo(Response);
                                exit(Response);
                            end;
                        end;
                    end else begin
                        if SkyMbankingTrans.GetLoansQualifyAmount(SearchMember."No.", MobileLoanProduct."Product ID", 0, EligibilityFailReason) < requested_amount.AsValue.AsDecimal then begin
                            ResponseObject.Add('status', 'ERROR');
                            Datum.Add('error_message', 'Loan amount exceeds the maximum limit allowed for the member of ' + Format(SkyMbankingTrans.GetLoansQualifyAmount(SearchMember."No.", MobileLoanProduct."Product ID", 0, EligibilityFailReason)));
                            ResponseObject.Add('data', Datum);

                            AddDateTimeToResponse(ResponseObject);

                            ResponseObject.WriteTo(Response);
                            exit(Response);
                        end;
                    end;

                    // Check Max Appliable Amount for loan
                    if requested_amount.AsValue.AsDecimal > MobileLoanProduct."Mobile Max. Loan Amount" then begin
                        ResponseObject.Add('status', 'ERROR');
                        Datum.Add('error_message', 'Loan amount exceeds the maximum limit allowed for the loan product of ' + Format(MobileLoanProduct."Mobile Max. Loan Amount"));
                        ResponseObject.Add('data', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
                    // Check Min Appliable Amount for loan
                    if requested_amount.AsValue.AsDecimal < MobileLoanProduct."Minimum Loan Amount" then begin
                        ResponseObject.Add('status', 'ERROR');
                        Datum.Add('error_message', 'Loan amount is less than the minimum limit allowed for the loan product of ' + Format(MobileLoanProduct."Minimum Loan Amount"));
                        ResponseObject.Add('data', Datum);

                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
                    // if Conditions are met then create loan application
                    if MobileLoanProduct."Allow Topup" then begin
                        if SkyMbankingTrans.BufferLoanApplication2(
                        SearchMember."No.", MobileLoanProduct."Product ID",
                        requested_amount.AsValue.AsDecimal,
                        theReference,
                        MobileLoanPurpose,
                        installments.AsValue.AsInteger) then begin

                            Datum.Add('transaction_reference', theReference);

                            // TheLoan.Reset;

                            // TheLoan.SetRange("Member No.", SearchMember."No.");
                            // TheLoan.SetRange("Loan Product Type", MobileLoanProduct."Product ID");
                            // TheLoan.SetRange(Posted, false);
                            // TheLoan.SetRange("Requested Amount", requested_amount.AsValue.AsDecimal);
                            // TheLoan.SetRange("Loanee Message", theReference);

                            // TheLoan.SetLoadFields(
                            //     "Loan No.",
                            //     "Loan Product Type Name",
                            //     "Requested Amount"
                            // );

                            // if TheLoan.FindFirst then begin
                            //     Datum.Add('loan_serial_number', TheLoan."Loan No.");
                            // end else begin
                            Datum.Add('loan_serial_number', theReference);
                            //end;

                            Datum.Add('loan_type_id', MobileLoanProduct."Product ID");
                            Datum.Add('loan_name', MobileLoanProduct."Product Description");
                            Datum.Add('amount', requested_amount.AsValue.AsDecimal);

                            ResponseObject.Add('status', 'SUCCESS');
                            ResponseObject.Add('data', Datum);


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
                            //         theReference,
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
                            //             theReference,
                            //             'CBS'
                            //         );
                            //     end
                            // end;
                        end else begin
                            ResponseObject.Add('status', 'FAILED');
                            Datum.Add('error_message', 'Loan creation failed');
                            ResponseObject.Add('data', Datum);
                        end;
                    end else begin
                        if SkyMbankingTrans.BufferLoanApplication(
                        SearchMember."No.", MobileLoanProduct."Product ID",
                        requested_amount.AsValue.AsDecimal,
                        theReference,
                        MobileLoanPurpose) then begin

                            Datum.Add('transaction_reference', theReference);

                            // TheLoan.Reset;

                            // TheLoan.SetRange("Member No.", SearchMember."No.");
                            // TheLoan.SetRange("Loan Product Type", MobileLoanProduct."Product ID");
                            // TheLoan.SetRange(Posted, false);
                            // TheLoan.SetRange("Requested Amount", requested_amount.AsValue.AsDecimal);
                            // TheLoan.SetRange("Loanee Message", theReference);

                            // TheLoan.SetLoadFields(
                            //     "Loan No.",
                            //     "Loan Product Type Name",
                            //     "Requested Amount"
                            // );

                            // if TheLoan.FindFirst then begin
                            //     Datum.Add('loan_serial_number', TheLoan."Loan No.");
                            // end else begin
                            Datum.Add('loan_serial_number', '');
                            // end;

                            Datum.Add('loan_type_id', MobileLoanProduct."Product ID");
                            Datum.Add('loan_name', MobileLoanProduct."Product Description");
                            Datum.Add('amount', requested_amount.AsValue.AsDecimal);

                            ResponseObject.Add('status', 'SUCCESS');
                            ResponseObject.Add('data', Datum);


                            // // SMS
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
                            //         theReference,
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
                            //             theReference,
                            //             'CBS'
                            //         );
                            //     end
                            // end;
                        end else begin
                            ResponseObject.Add('status', 'FAILED');
                            Datum.Add('error_message', 'Loan creation failed');
                            ResponseObject.Add('data', Datum);
                        end;
                    end;
                end else begin
                    ResponseObject.Add('status', 'ERROR');
                    Datum.Add('error_message', 'Loan product with ID = ' + loan_product.AsValue.AsText + ' NOT available for mobile application!');
                    ResponseObject.Add('data', Datum);
                end;
            end else begin
                ResponseObject.Add('status', 'ERROR');
                Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
                ResponseObject.Add('data', Datum);
            end;

            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;
    end;

    local procedure GetLoanApplicationRequests(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        TheGuarantor: Record Members;
        TheLoanApplications: Record "Sky Channels Loan Applications";
        GuarantorRequests: Record "Sky Loan Guarantor Requests";
        TheLoanProduct: Record "Product Factory";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Guarantors: JsonArray;
        Guarantor: JsonObject;
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
            // TheLoanApplications.SetFilter(Status, '=%1|%2', TheLoanApplications.Status::Open, TheLoanApplications.Status::"Pending Approval");

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
                    Datum.Add('should_add_more_guarantors', TheLoanApplications.ShouldAddMoreGuarantors);

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
                            Guarantor.Add('member_name', GuarantorRequests."Member Name");

                            TheGuarantor.Reset;
                            if TheGuarantor.Get(GuarantorRequests."Member No.") then begin
                                Guarantor.Add('phone_number', TheGuarantor."Phone No.");
                            end;

                            Guarantor.Add('request_status', Format(GuarantorRequests.Status));
                            Guarantor.Add('request_status_date_time', GlobalFunctions.FormatISODateTime(GuarantorRequests."Status Date Time"));

                            Guarantors.Add(Guarantor);
                        end until GuarantorRequests.Next = 0;
                    end;

                    Datum.Add('guarantorship_requests', Guarantors);

                    if TheLoanProduct.Get(TheLoanApplications."Loan Product Type") then begin
                        Datum.Add('expected_guarantors', TheLoanProduct."Minimum Guarantors");
                        Datum.Add('maximum_guarantors', TheLoanProduct."Maximum Guarantors");
                    end;

                    Data.Add(Datum);
                end until TheLoanApplications.Next = 0;
            end;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Loan application request list has been fetched successfully');
            ResponseObject.Add('data', Data);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanApplicationRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;

        SearchMember: Record Members;
        TheGuarantor: Record Members;
        TheLoanApplications: Record "Sky Channels Loan Applications";
        GuarantorRequests: Record "Sky Loan Guarantor Requests";
        TheLoanProduct: Record "Product Factory";

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
            // TheLoanApplications.SetFilter(Status, '=%1|%2', TheLoanApplications.Status::Open, TheLoanApplications.Status::"Pending Approval");
            TheLoanApplications.SetRange("Application No.", application_no.AsValue.AsText);

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
                Datum.Add('should_add_more_guarantors', TheLoanApplications.ShouldAddMoreGuarantors);

                GuarantorRequests.Reset;
                GuarantorRequests.SetRange("Loan Application No.", TheLoanApplications."Application No.");
                if GuarantorRequests.FindSet then begin
                    repeat begin
                        Clear(Guarantor);

                        GuarantorRequests.CalcFields("Member Name");
                        Guarantor.Add('entry_no', GuarantorRequests."Entry No.");
                        Guarantor.Add('member_number', GuarantorRequests."Member No.");
                        Guarantor.Add('member_name', GuarantorRequests."Member Name");
                        TheGuarantor.Reset;
                        if TheGuarantor.Get(GuarantorRequests."Member No.") then begin
                            Guarantor.Add('phone_number', TheGuarantor."Phone No.");
                        end;
                        Guarantor.Add('request_status', Format(GuarantorRequests.Status));
                        Guarantor.Add('request_status_date_time', GlobalFunctions.FormatISODateTime(GuarantorRequests."Status Date Time"));

                        Guarantors.Add(Guarantor);
                    end until GuarantorRequests.Next = 0;
                end;

                Datum.Add('guarantorship_requests', Guarantors);

                if TheLoanProduct.Get(TheLoanApplications."Loan Product Type") then begin
                    Datum.Add('expected_guarantors', TheLoanProduct."Minimum Guarantors");
                    Datum.Add('maximum_guarantors', TheLoanProduct."Maximum Guarantors");
                end;
            end else begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', StrSubstNo('Loan application request %1 NOT found', application_no.AsValue.AsText));
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Loan application request has been fetched successfully');
            ResponseObject.Add('data', Datum);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure EditLoanApplicationRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;
        requested_amount: JsonToken;

        files: JsonToken;
        file: JsonToken;
        file_name: JsonToken;
        file_contents: JsonToken;

        SearchMember: record Members;
        TheLoanApplication: Record "Sky Channels Loan Applications";

        TheLoanApplicationDocuments: Record "Channel Application Documents";
        EDMSFunctions: Codeunit "EDMS Functions";
        EDMSFileTypes: enum "EDMS File Types";

        KeyExists: Boolean;
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        Base64Convert: Codeunit "Base64 Convert";

        StoreImageRef: FieldRef;
        StoreRecRef: RecordRef;

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
        KeyExists := Payload.Get('files', files);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            TheLoanApplication.Reset;

            TheLoanApplication.SetRange("Application No.", application_no.AsValue.AsText);
            TheLoanApplication.SetRange(Status, TheLoanApplication.Status::Open);

            if TheLoanApplication.FindFirst then begin
                TheLoanApplication."Requested Amount" := requested_amount.AsValue.AsInteger;

                if KeyExists then begin

                    foreach file in files.AsArray() do begin
                        file.AsObject.Get('name', file_name);

                        if EDMSFunctions.GetFileTypeFromFileName(file_name.AsValue.AsText) = EDMSFileTypes::" " then begin
                            ResponseObject.Add('status', 'ERROR');
                            ResponseObject.Add('status_description', 'Unsupported file type for uploading the file = ' + file_name.AsValue.AsText);

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

                if TheLoanApplication.Modify(true) then begin
                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Loan application request has been updated successfully');
                end else begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', GetLastErrorText(true));
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end else begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'The loan application ' + application_no.AsValue.AsText + ' is NOT available for update');
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CancelLoanApplicationRequest(Payload: JsonObject): Text
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
                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Loan application request has been cancelled successfully');
                end else begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', GetLastErrorText(true));
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end else begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'The loan application ' + application_no.AsValue.AsText + ' is NOT available for cancellation');
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure ManageLoanGuarantorsRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;
        action: JsonToken;
        guarantor_member_number: JsonToken;

        SearchMember: Record Members;
        TheLoanGuarantorshipRequest: Record "Sky Loan Guarantor Requests";
        TheLoanApplication: Record "Sky Channels Loan Applications";

        SalaryAmount: decimal;
        GuarantorMember: Record Members;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;

        FailReason: Text;
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
                            // Validate loan guarantors

                            SalaryAmount := 0;

                            GuarantorMember.Reset;
                            GuarantorMember.SetRange("No.", guarantor_member_number.AsValue.AsText);
                            if GuarantorMember.FindFirst then begin
                                SalaryAmount := GuarantorSalaryEligibility(TheLoanApplication."Loan Product Type", GuarantorMember, 0, FailReason);

                                if SalaryAmount <= 0 then begin
                                    ResponseObject.Add('status', 'ERROR');
                                    Datum.Add('error_message', 'Member with no. ' + guarantor_member_number.AsValue.AsText + ' is NOT eligible for guarantorship due to salary requirements!' + FailReason);
                                    ResponseObject.Add('data', Datum);

                                    AddDateTimeToResponse(ResponseObject);

                                    ResponseObject.WriteTo(Response);
                                    exit(Response);
                                end;
                            end;

                            TheLoanGuarantorshipRequest.Reset;
                            TheLoanGuarantorshipRequest.Init;

                            TheLoanGuarantorshipRequest."Member No." := guarantor_member_number.AsValue.AsText;

                            TheLoanGuarantorshipRequest.Status := TheLoanGuarantorshipRequest.Status::Open;
                            TheLoanGuarantorshipRequest."Status Date Time" := CurrentDateTime;
                            TheLoanGuarantorshipRequest."Loan Application No." := TheLoanApplication."Application No.";

                            if TheLoanGuarantorshipRequest.Insert(true) then begin
                                ResponseObject.Add('status', 'SUCCESS');
                                ResponseObject.Add('status_description', 'Loan guarantor has been added successfully');
                            end else begin
                                ResponseObject.Add('status', 'ERROR');
                                ResponseObject.Add('status_description', GetLastErrorText(true));
                                AddDateTimeToResponse(ResponseObject);
                                ResponseObject.WriteTo(Response);
                                exit(Response);
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
                                    Commit;
                                    // Attempt to push the loan application
                                    TheLoanApplication.CreateLoanApplication(true);

                                    ResponseObject.Add('status', 'SUCCESS');
                                    ResponseObject.Add('status_description', 'Loan guarantor has been removed successfully');
                                end else begin
                                    ResponseObject.Add('status', 'ERROR');
                                    ResponseObject.Add('status_description', GetLastErrorText(true));
                                    AddDateTimeToResponse(ResponseObject);
                                    ResponseObject.WriteTo(Response);
                                    exit(Response);
                                end;
                            end else begin
                                ResponseObject.Add('status', 'NOT_FOUND');
                                ResponseObject.Add('status_description', 'Loan guarantorship request NOT found');
                            end;
                        end;
                    else
                end;
            end else begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', StrSubstNo('Loan application with no %1 NOT found', application_no.AsValue.AsText));
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanGuarantorshipRequests(Payload: JsonObject): Text
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
            // TheLoanGuarantorshipRequests.SetRange(Status, TheLoanGuarantorshipRequests.Status::Open);

            if TheLoanGuarantorshipRequests.FindSet then begin
                repeat begin
                    Clear(Datum);

                    TheLoanApplications.Reset;
                    TheLoanApplications.SetRange("Application No.", TheLoanGuarantorshipRequests."Loan Application No.");
                    if TheLoanApplications.FindFirst then begin
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
                    end;

                end until TheLoanGuarantorshipRequests.Next = 0;
            end;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Loan guarantorship request list has been fetched successfully');
            ResponseObject.Add('data', Data);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanGuarantorshipRequest(Payload: JsonObject): Text
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
            // TheLoanGuarantorshipRequests.SetRange(Status, TheLoanGuarantorshipRequests.Status::Open);
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

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Loan guarantorship request has been fetched successfully');
                ResponseObject.Add('data', Datum);
            end else begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', StrSubstNo('Loan guarantorship request with number %1 is NOT found', application_no.AsValue.AsText));
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure ActionLoanGuarantorshipRequest(Payload: JsonObject): Text
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
                        ResponseObject.Add('status', 'ERROR');
                        ResponseObject.Add('status_description', 'Unsupported action. Supported actions are: ACCEPT and REJECT');
                        AddDateTimeToResponse(ResponseObject);
                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
                end;

                if TheLoanGuarantorshipRequests.Modify(true) then begin
                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Loan guarantorship request has been actioned successfully');
                end else begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', 'Unable to action the loan guarantorship request at the moment');
                end;
            end else begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Loan guarantorship request NOT found');
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CreateLoanGuarantorSubstitutionRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        member_loan: JsonToken;
        new_guarantors: JsonToken;
        new_guarantor: JsonToken;
        new_guarantor_member_number: JsonToken;
        new_guarantor_amount: JsonToken;
        new_guarantor_substituted_member_number: JsonToken;
        member_comments: JsonToken;

        KeyExists: Boolean;

        LoaneeMember: Record Members;
        LoaneeLoan: Record Loans;
        LoanGuarantorSubstitution: Record "Sky Guarantor Sub Applications";
        TheLoanGuarantorSubstitution: Record "Sky Guarantor Sub Applications";
        LoanGuarantors: Record "Sky Guarantor Sub Requests";
        NewLoanGuarantorSavingsAccount: Record "Savings Accounts";
        LGSec: Record "Loan Guarantors and Security";
        Comment: Record "Loan Appraisal Comments";
        SalaryAmount: decimal;
        GuarantorMember: Record Members;

        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
        FailReason: Text;
    begin
        KeyExists := Payload.Get('identifier_type', identifier_type);
        KeyExists := Payload.Get('identifier', identifier);
        KeyExists := Payload.Get('member_loan', member_loan);
        KeyExists := Payload.Get('new_guarantors', new_guarantors);
        KeyExists := Payload.Get('member_comments', member_comments);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, LoaneeMember, ResponseText, ResponseDescription) then begin
            LoaneeLoan.Reset;
            LoaneeLoan.SetRange("Member No.", LoaneeMember."No.");
            LoaneeLoan.SetRange("Loan No.", member_loan.AsValue.AsText);
            LoaneeLoan.SetRange(Posted, true);

            IF LoaneeLoan.FindFirst then begin
                LoanGuarantorSubstitution.Init;

                LoanGuarantorSubstitution."Loan No." := LoaneeLoan."Loan No.";
                LoanGuarantorSubstitution."Member No." := LoaneeLoan."Member No.";
                LoanGuarantorSubstitution."Loan Product Type" := LoaneeLoan."Loan Product Type";

                LoanGuarantorSubstitution."Loan Account No." := LoaneeLoan."Loan Account";
                LoanGuarantorSubstitution.Name := LoaneeLoan."Member Name";
                LoanGuarantorSubstitution.Status := LoanGuarantorSubstitution.Status::Open;
                LoanGuarantorSubstitution."Source Application" := LoanGuarantorSubstitution."Source Application"::"Member Portal";

                // Validate existing requests...
                TheLoanGuarantorSubstitution.Reset;
                TheLoanGuarantorSubstitution.SetRange("Loan No.", LoaneeLoan."Loan No.");
                TheLoanGuarantorSubstitution.SetFilter(
                    Status,
                    '=%1|%2',
                    TheLoanGuarantorSubstitution.Status::Open,
                    TheLoanGuarantorSubstitution.Status::"Pending Approval");

                if TheLoanGuarantorSubstitution.FindFirst then begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description',
                    StrSubstNo('There is an ongoing loan guarantor substitution request %1 at status %2',
                    TheLoanGuarantorSubstitution."No.",
                    TheLoanGuarantorSubstitution.Status)
                    );
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;

                LoanGuarantorSubstitution."Loanee Comments" := member_comments.AsValue.AsText;

                IF LoanGuarantorSubstitution.Insert(true) then begin
                    // Validate loan guarantors
                    foreach new_guarantor in new_guarantors.AsArray do begin
                        new_guarantor.AsObject.Get('member_number', new_guarantor_member_number);

                        SalaryAmount := 0;

                        GuarantorMember.Reset;
                        GuarantorMember.SetRange("No.", new_guarantor_member_number.AsValue.AsText);
                        if GuarantorMember.FindFirst then begin
                            SalaryAmount := GuarantorSalaryEligibility(LoaneeLoan."Loan Product Type", GuarantorMember, 0, FailReason);

                            if SalaryAmount <= 0 then begin
                                ResponseObject.Add('status', 'ERROR');
                                ResponseData.Add('error_message', 'Member with no. ' + new_guarantor_member_number.AsValue.AsText + ' is NOT eligible for guarantorship due to salary requirements!');
                                ResponseObject.Add('data', ResponseData);

                                AddDateTimeToResponse(ResponseObject);

                                ResponseObject.WriteTo(Response);
                                exit(Response);
                            end;
                        end;
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
                        Clear(LoanGuarantors);
                        LoanGuarantors.Init;

                        LoanGuarantors."Application No." := LoanGuarantorSubstitution."No.";

                        NewLoanGuarantorSavingsAccount.SetRange("Member No.", new_guarantor_member_number.AsValue.AsText);
                        NewLoanGuarantorSavingsAccount.SetRange("Can Guarantee Loan", true);

                        if LoaneeLoan."Source Unit" = LoaneeLoan."Source Unit"::"BUSINESS LOANS" then begin
                            NewLoanGuarantorSavingsAccount.SetRange("Product Category", NewLoanGuarantorSavingsAccount."Product Category"::"Business Deposits");
                        end else begin
                            NewLoanGuarantorSavingsAccount.SetRange("Product Category", NewLoanGuarantorSavingsAccount."Product Category"::"BOSA Deposits");
                        end;

                        IF NewLoanGuarantorSavingsAccount.FindFirst then begin
                            LoanGuarantors."Savings Account No." := NewLoanGuarantorSavingsAccount."No.";
                            LoanGuarantors."Member No." := NewLoanGuarantorSavingsAccount."Member No.";
                        end else begin
                            ResponseObject.Add('status', 'ERROR');
                            ResponseObject.Add('status_description', StrSubstNo('Guarantor with member number %1 does NOT have a savings account', new_guarantor_member_number.AsValue.AsText));
                            AddDateTimeToResponse(ResponseObject);
                            ResponseObject.WriteTo(Response);
                            exit(Response);
                        end;

                        LoanGuarantors."Loan No." := LoaneeLoan."Loan No.";
                        LoanGuarantors."Substituted Member No." := new_guarantor_substituted_member_number.AsValue.AsText;
                        LoanGuarantors."Amount Guaranteed" := new_guarantor_amount.AsValue.AsDecimal;

                        LoanGuarantors.Insert(true);
                        // Commit;
                    end;

                    ResponseData.Add('application_number', LoanGuarantorSubstitution."No.");
                    ResponseData.Add('application_status', Format(LoanGuarantorSubstitution.Status));

                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Loan guarantor substitution with application number ' + LoanGuarantorSubstitution."No." + ' has been created successfully.');
                    ResponseObject.Add('data', ResponseData);
                end else begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', GetLastErrorText(true));
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end else begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', StrSubstNo('Unknown loan with loan number ' + member_loan.AsValue.AsText));
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    // local procedure CreateLoanGuarantorSubstitutionRequest(Payload: JsonObject): Text
    // var
    //     identifier_type: JsonToken;
    //     identifier: JsonToken;
    //     member_loan: JsonToken;
    //     new_guarantors: JsonToken;
    //     new_guarantor: JsonToken;
    //     new_guarantor_member_number: JsonToken;
    //     new_guarantor_amount: JsonToken;
    //     new_guarantor_substituted_member_number: JsonToken;
    //     member_comments: JsonToken;

    //     KeyExists: Boolean;

    //     SeriesSetup: Record "Credit Nos. Series";
    //     NoSeriesMgt: Codeunit NoSeriesManagement;
    //     NewNo: Code[20];
    //     NewNoSeriesCode: Code[20];

    //     LoaneeMember: Record Members;
    //     LoaneeLoan: Record Loans;
    //     LoanGuarantorSubstitution: Record "Guarantors Substitution";
    //     TheLoanGuarantorSubstitution: Record "Guarantors Substitution";
    //     LoanGuarantors: Record "Loan Guarantors Sub";
    //     SubstitutedLoanGuarantor: Record "Loan Guarantors Sub";
    //     NewLoanGuarantorSavingsAccount: Record "Savings Accounts";
    //     LGSec: Record "Loan Guarantors and Security";
    //     Comment: Record "Loan Appraisal Comments";
    //     ResponseObject: JsonObject;
    //     ResponseData: JsonObject;
    //     Errors: JsonArray;
    //     Response: Text;
    //     ResponseText: Text;
    //     ResponseDescription: Text;
    // begin
    //     KeyExists := Payload.Get('identifier_type', identifier_type);
    //     KeyExists := Payload.Get('identifier', identifier);
    //     KeyExists := Payload.Get('member_loan', member_loan);
    //     KeyExists := Payload.Get('new_guarantors', new_guarantors);
    //     KeyExists := Payload.Get('member_comments', member_comments);

    //     if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, LoaneeMember, ResponseText, ResponseDescription) then begin
    //         LoaneeLoan.Reset;
    //         LoaneeLoan.SetRange("Member No.", LoaneeMember."No.");
    //         LoaneeLoan.SetRange("Loan No.", member_loan.AsValue.AsText);
    //         LoaneeLoan.SetRange(Posted, true);

    //         IF LoaneeLoan.FindFirst then begin
    //             LoanGuarantorSubstitution.Init;

    //             SeriesSetup.Get;
    //             SeriesSetup.TestField(SeriesSetup."Guarantors Substitution");
    //             NoSeriesMgt.InitSeries(SeriesSetup."Guarantors Substitution", SeriesSetup."Guarantors Substitution", 0D, NewNo, NewNoSeriesCode);

    //             LoanGuarantorSubstitution."No." := NewNo;
    //             LoanGuarantorSubstitution."No. Series" := NewNoSeriesCode;

    //             LoanGuarantorSubstitution."Loan No." := LoaneeLoan."Loan No.";
    //             LoanGuarantorSubstitution."Member No." := LoaneeLoan."Member No.";
    //             LoanGuarantorSubstitution.Validate("Loan No.");

    //             LoanGuarantorSubstitution."Loan Account No." := LoaneeLoan."Loan Account";
    //             LoanGuarantorSubstitution.Name := LoaneeLoan."Member Name";
    //             LoanGuarantorSubstitution.Status := LoanGuarantorSubstitution.Status::Open;
    //             LoanGuarantorSubstitution."Source Application" := LoanGuarantorSubstitution."Source Application"::"Member Portal";

    //             // Validate existing requests...
    //             TheLoanGuarantorSubstitution.Reset;
    //             TheLoanGuarantorSubstitution.SetRange("Loan No.", LoaneeLoan."Loan No.");
    //             TheLoanGuarantorSubstitution.SetFilter(
    //                 Status,
    //                 '=%1|%2',
    //                 TheLoanGuarantorSubstitution.Status::Open,
    //                 TheLoanGuarantorSubstitution.Status::Pending);
    //             TheLoanGuarantorSubstitution.SetFilter("No.", '<>%1', NewNo);

    //             if TheLoanGuarantorSubstitution.FindFirst then begin
    //                 ResponseObject.Add('status', 'ERROR');
    //                 ResponseObject.Add('status_description',
    //                 StrSubstNo('There is an ongoing loan guarantor substitution request %1 at status %2',
    //                 TheLoanGuarantorSubstitution."No.",
    //                 TheLoanGuarantorSubstitution.Status)
    //                 );
    //                 AddDateTimeToResponse(ResponseObject);
    //                 ResponseObject.WriteTo(Response);
    //                 exit(Response);
    //             end;

    //             IF LoanGuarantorSubstitution.Insert(true) then begin
    //                 LoanGuarantorSubstitution."Captured By" := 'Members Portal';
    //                 LoanGuarantorSubstitution."CRM Application No." := LoanGuarantorSubstitution."No.";
    //                 LoanGuarantorSubstitution."CRM No. Series" := 'Members Portal';
    //                 LoanGuarantorSubstitution."CRM Created By" := 'Members Portal';

    //                 LoanGuarantorSubstitution.Modify;

    //                 // CRM Comments/Notes
    //                 if member_comments.AsValue.AsText <> '' then begin
    //                     Comment.Init;

    //                     Comment."Loan No." := LoaneeLoan."Loan No.";
    //                     Comment.Comment := GlobalFunctions.FormatISODateTime(CurrentDateTime) + ' - ' + member_comments.AsValue.AsText;
    //                     Comment.Appraiser := LoaneeMember.Name;
    //                     Comment."Entry Date" := Today;
    //                     Comment."Entry Time" := Time;
    //                     Comment.Commented := true;

    //                     Comment.Insert(false);
    //                 end;

    //                 foreach new_guarantor in new_guarantors.AsArray do begin
    //                     // {
    //                     //     "guarantor_member_number": "MB002",
    //                     //     "amount": 100.00,
    //                     //     "substituted_member_number": "MB0001"
    //                     // }
    //                     KeyExists := new_guarantor.SelectToken('new_guarantor_member_number', new_guarantor_member_number);
    //                     KeyExists := new_guarantor.SelectToken('new_guarantor_amount', new_guarantor_amount);
    //                     KeyExists := new_guarantor.SelectToken('substituted_guarantor_member_number', new_guarantor_substituted_member_number);

    //                     LoanGuarantors.Reset;
    //                     LoanGuarantors.Init;

    //                     LoanGuarantors."No." := NewNo;

    //                     NewLoanGuarantorSavingsAccount.SetRange("Member No.", new_guarantor_member_number.AsValue.AsText);
    //                     NewLoanGuarantorSavingsAccount.SetRange("Can Guarantee Loan", true);

    //                     if LoaneeLoan."Source Unit" = LoaneeLoan."Source Unit"::"BUSINESS LOANS" then begin
    //                         NewLoanGuarantorSavingsAccount.SetRange("Product Category", NewLoanGuarantorSavingsAccount."Product Category"::"Business Deposits");
    //                     end else begin
    //                         NewLoanGuarantorSavingsAccount.SetRange("Product Category", NewLoanGuarantorSavingsAccount."Product Category"::"BOSA Deposits");
    //                     end;

    //                     IF NewLoanGuarantorSavingsAccount.FindFirst then begin
    //                         LoanGuarantors."Savings Account No." := NewLoanGuarantorSavingsAccount."No.";
    //                         LoanGuarantors.Validate("Savings Account No.");
    //                         LoanGuarantors."Member No" := NewLoanGuarantorSavingsAccount."Member No.";
    //                     end else begin
    //                         ResponseObject.Add('status', 'ERROR');
    //                         ResponseObject.Add('status_description', StrSubstNo('Guarantor with member number %1 does NOT have a savings account', new_guarantor_member_number.AsValue.AsText));
    //                         AddDateTimeToResponse(ResponseObject);
    //                         ResponseObject.WriteTo(Response);
    //                         exit(Response);
    //                     end;

    //                     LoanGuarantors."Loan No" := LoaneeLoan."Loan No.";

    //                     LoanGuarantors.Validate("Member No");

    //                     LGSec.Reset;
    //                     LGSec.SetRange("Loan No", LoaneeLoan."Loan No.");
    //                     LGSec.SetRange("Member No", new_guarantor_substituted_member_number.AsValue.AsText);

    //                     if LGSec.FindFirst then begin
    //                         LoanGuarantors."Guarantor Type" := LoanGuarantors."Guarantor Type"::Guarantor;
    //                         LoanGuarantors."Member Substituted" := LGSec."Savings Account No./Member No.";
    //                         LoanGuarantors.Validate("Member Substituted");

    //                         SubstitutedLoanGuarantor.Reset;
    //                         SubstitutedLoanGuarantor.SetRange("Loan No", LoanGuarantors."Loan No");
    //                         SubstitutedLoanGuarantor.SetRange("Savings Account No.", LoanGuarantors."Member Substituted");

    //                         if SubstitutedLoanGuarantor.FindFirst then begin
    //                             SubstitutedLoanGuarantor.Substituted := true;
    //                             SubstitutedLoanGuarantor.Modify(false);
    //                         end;
    //                     end else begin
    //                         ResponseObject.Add('status', 'ERROR');
    //                         ResponseObject.Add('status_description', StrSubstNo('Guarantor with member number %1 does NOT have a savings account', new_guarantor_substituted_member_number.AsValue.AsText));
    //                         AddDateTimeToResponse(ResponseObject);
    //                         ResponseObject.WriteTo(Response);
    //                         exit(Response);
    //                     end;

    //                     LoanGuarantors.Substituted := false;
    //                     LoanGuarantors.Validate(Substituted);

    //                     LoanGuarantors."Amount Guaranteed" := new_guarantor_amount.AsValue.AsDecimal;
    //                     LoanGuarantors."SMS Sent" := false;

    //                     LoanGuarantors.Insert(true);
    //                 end;

    //                 // Handle CRM branch assigmnent
    //                 LoanGuarantorSubstitution."Global Dimension 1 Code" := LoaneeMember."Global Dimension 1 Code";
    //                 LoanGuarantorSubstitution."Global Dimension 2 Code" := LoaneeMember."Global Dimension 2 Code";

    //                 LoanGuarantorSubstitution.Modify;

    //                 LoanGuarantorSubstitution.Reset;

    //                 LoanGuarantorSubstitution.SetRange("No.", NewNo);
    //                 ResponseData.Add('application_number', LoanGuarantorSubstitution."No.");
    //                 ResponseData.Add('application_status', Format(LoanGuarantorSubstitution.Status));

    //                 ResponseObject.Add('status', 'SUCCESS');
    //                 ResponseObject.Add('status_description', 'Loan guarantor substitution with application number ' + LoanGuarantorSubstitution."No." + ' has been created successfully.');
    //                 ResponseObject.Add('data', ResponseData);
    //             end else begin
    //                 ResponseObject.Add('status', 'ERROR');
    //                 ResponseObject.Add('status_description', GetLastErrorText(true));
    //                 AddDateTimeToResponse(ResponseObject);
    //                 ResponseObject.WriteTo(Response);
    //                 exit(Response);
    //             end;
    //         end else begin
    //             ResponseObject.Add('status', 'ERROR');
    //             ResponseObject.Add('status_description', StrSubstNo('Unknown loan with loan number ' + member_loan.AsValue.AsText));
    //             AddDateTimeToResponse(ResponseObject);
    //             ResponseObject.WriteTo(Response);
    //             exit(Response);
    //         end;
    //     end else begin
    //         ResponseObject.Add('status', ResponseText);
    //         ResponseObject.Add('status_description', ResponseDescription);
    //     end;

    //     AddDateTimeToResponse(ResponseObject);
    //     ResponseObject.WriteTo(Response);

    //     exit(Response);
    // end;

    // local procedure GetLoanGuarantorSubstitutionRequests(Payload: JsonObject): Text
    // var
    //     identifier_type: JsonToken;
    //     identifier: JsonToken;

    //     KeyExists: Boolean;

    //     LoanGuarantorSubstitutionRequests: Record "Guarantors Substitution";
    //     LoanGuarantors: Record "Loan Guarantors Sub";
    //     SubstitutedLoanGuarantor: Record "Loan Guarantors Sub";
    //     SLA: record "Defined SLA";
    //     Comment: record "Comments";
    //     LoaneeLoan: Record Loans;
    //     LoaneeMember: Record Members;
    //     LoanGuarantorsList: Record "Loan Guarantors and Security";

    //     new_guarantors: JsonArray;
    //     new_guarantor: JsonObject;
    //     ResponseObject: JsonObject;
    //     Data: JsonArray;
    //     Datum: JsonObject;
    //     Response: Text;
    //     ResponseText: Text;
    //     ResponseDescription: Text;
    //     StatusComment: Text;
    //     AddToList: Boolean;
    // begin
    //     KeyExists := Payload.Get('identifier_type', identifier_type);
    //     KeyExists := Payload.Get('identifier', identifier);

    //     if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, LoaneeMember, ResponseText, ResponseDescription) then begin

    //         LoanGuarantorSubstitutionRequests.Reset;
    //         LoanGuarantorSubstitutionRequests.SetCurrentKey(Date);
    //         LoanGuarantorSubstitutionRequests.SetAscending(Date, false);

    //         LoanGuarantorSubstitutionRequests.SetRange("Member No.", LoaneeMember."No.");
    //         LoanGuarantorSubstitutionRequests.SetFilter(Status,
    //         '=%1|%2',
    //         LoanGuarantorSubstitutionRequests.Status::Open, LoanGuarantorSubstitutionRequests.Status::Pending);

    //         IF LoanGuarantorSubstitutionRequests.FindSet then begin
    //             repeat begin
    //                 Clear(Datum);
    //                 Clear(new_guarantors);

    //                 Datum.Add('application_no', LoanGuarantorSubstitutionRequests."No.");
    //                 Datum.Add('loan_no', LoanGuarantorSubstitutionRequests."Loan No.");
    //                 Datum.Add('name', LoanGuarantorSubstitutionRequests.Name);

    //                 LoaneeLoan.Reset;
    //                 LoaneeLoan.SetRange("Loan No.", LoanGuarantorSubstitutionRequests."Loan No.");
    //                 if LoaneeLoan.FindFirst then begin
    //                     Datum.Add('member_number', LoaneeLoan."Member No.");
    //                     Datum.Add('loan_name', LoaneeLoan."Loan Product Type Name");
    //                 end else begin
    //                     Datum.Add('member_number', '');
    //                     Datum.Add('loan_name', '');
    //                 end;

    //                 Datum.Add('account_status', Format(LoanGuarantorSubstitutionRequests."Account Status"));
    //                 Datum.Add('status', Format(LoanGuarantorSubstitutionRequests.Status));

    //                 Comment.reset();
    //                 Comment.SetRange("Header No.", LoanGuarantorSubstitutionRequests."No.");
    //                 If Comment.FindLast() then begin
    //                     StatusComment := Comment.Comment;
    //                 end;

    //                 Datum.Add('status_comment', StatusComment);

    //                 LoanGuarantors.Reset;
    //                 LoanGuarantors.SetRange("Loan No", LoanGuarantorSubstitutionRequests."Loan No.");
    //                 LoanGuarantors.SetRange("No.", LoanGuarantorSubstitutionRequests."No.");

    //                 IF LoanGuarantors.FindSet then begin
    //                     repeat begin
    //                         Clear(new_guarantor);
    //                         AddToList := false;

    //                         LoanGuarantorsList.Reset;
    //                         LoanGuarantorsList.SetRange("Loan No", LoanGuarantors."Loan No");
    //                         LoanGuarantorsList.SetRange("Member No", LoanGuarantors."Member No");

    //                         new_guarantor.Add('entry_no', LoanGuarantors."No.");
    //                         new_guarantor.Add('loan_no', LoanGuarantors."Loan No");
    //                         new_guarantor.Add('guarantor_name', LoanGuarantors.Name);
    //                         new_guarantor.Add('guarantor_member_number', LoanGuarantors."Member No");

    //                         LoanGuarantors.CalcFields("Outstanding Balance");
    //                         new_guarantor.Add('number_of_loans_guaranteed', LoanGuarantors."No Of Loans Guaranteed");

    //                         new_guarantor.Add('amount_guaranteed', LoanGuarantors."Amount Guaranteed");

    //                         new_guarantor.Add('outstanding_balance', LoanGuarantors."Outstanding Balance");

    //                         new_guarantor.Add('is_substituted', LoanGuarantors.Substituted);
    //                         new_guarantor.Add('substituted_guarantor', LoanGuarantors."Member Substituted");


    //                         new_guarantor.Add('member_no', LoanGuarantors."Member No");
    //                         new_guarantor.Add('name', LoanGuarantors.Name);
    //                         new_guarantor.Add('id_number', LoanGuarantors."ID No.");
    //                         new_guarantor.Add('staff_payroll_no', LoanGuarantors."Staff/Payroll No.");

    //                         if LoanGuarantors."Member Substituted" <> '' then begin
    //                             SubstitutedLoanGuarantor.Reset;
    //                             SubstitutedLoanGuarantor.SetRange("Loan No", LoanGuarantors."Loan No");
    //                             SubstitutedLoanGuarantor.SetRange("Savings Account No.", LoanGuarantors."Member Substituted");

    //                             if SubstitutedLoanGuarantor.FindFirst then begin
    //                                 new_guarantor.Add('substituted_member_no', SubstitutedLoanGuarantor."Member No");
    //                                 new_guarantor.Add('substituted_member_name', SubstitutedLoanGuarantor.Name);

    //                                 AddToList := true;
    //                             end else begin
    //                                 new_guarantor.Add('substituted_member_no', '');
    //                                 new_guarantor.Add('substituted_member_name', '');
    //                             end;
    //                         end else begin
    //                             new_guarantor.Add('substituted_member_no', '');
    //                             new_guarantor.Add('substituted_member_name', '');
    //                         end;

    //                         if LoanGuarantorsList.FindFirst then begin
    //                             new_guarantor.Add('number_of_major_loans_guaranteed', LoanGuarantorsList."No Of Major Loans Guaranteed");
    //                             new_guarantor.Add('number_of_minor_loans_guaranteed', LoanGuarantorsList."No Of Minor Loans Guaranteed");

    //                             new_guarantor.Add('total_loan_balance', LoanGuarantorsList."Total Loan Balance");

    //                             new_guarantor.Add('is_self_guarantee', LoanGuarantorsList."Self Guarantee");

    //                             new_guarantor.Add('date_substituted', LoanGuarantorsList."Date Substituted");
    //                         end else begin
    //                             new_guarantor.Add('number_of_major_loans_guaranteed', 0);
    //                             new_guarantor.Add('number_of_minor_loans_guaranteed', 0);

    //                             new_guarantor.Add('total_loan_balance', 0);

    //                             new_guarantor.Add('is_self_guarantee', false);

    //                             new_guarantor.Add('date_substituted', 0D);
    //                         end;

    //                         if LoanGuarantors.Substituted or AddToList then begin
    //                             new_guarantors.Add(new_guarantor);
    //                         end;
    //                     end until LoanGuarantors.Next = 0;
    //                 end;

    //                 Datum.Add('guarantors', new_guarantors);

    //                 Data.Add(Datum);
    //             end until LoanGuarantorSubstitutionRequests.Next = 0;

    //             ResponseObject.Add('status', 'SUCCESS');
    //             ResponseObject.Add('status_description', 'Request is successful');
    //             ResponseObject.Add('data', Data);
    //             AddDateTimeToResponse(ResponseObject);
    //         end else begin
    //             ResponseObject.Add('status', 'SUCCESS');
    //             ResponseObject.Add('status_description', 'Request is successful');
    //             ResponseObject.Add('data', Data);
    //             AddDateTimeToResponse(ResponseObject);
    //         end;
    //     end else begin
    //         ResponseObject.Add('status', ResponseText);
    //         ResponseObject.Add('status_description', ResponseDescription);
    //     end;

    //     ResponseObject.WriteTo(Response);

    //     exit(Response);
    // end;

    // local procedure CancelLoanGuarantorSubstitutionRequest(Payload: JsonObject): Text
    // var
    //     identifier_type: JsonToken;
    //     identifier: JsonToken;
    //     application_no: JsonToken;

    //     SearchMember: record Members;
    //     LoanGuarantorSubstitutionRequest: Record "Guarantors Substitution";
    //     LoanGuarantors: Record "Loan Guarantors Sub";

    //     ResponseObject: JsonObject;
    //     Datum: JsonObject;
    //     Response: Text;
    //     ResponseText: Text;
    //     ResponseDescription: Text;
    // begin
    //     Payload.Get('identifier_type', identifier_type);
    //     Payload.Get('identifier', identifier);
    //     Payload.Get('application_no', application_no);

    //     if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
    //         LoanGuarantorSubstitutionRequest.Reset;

    //         LoanGuarantorSubstitutionRequest.SetRange("No.", application_no.AsValue.AsText);
    //         LoanGuarantorSubstitutionRequest.SetRange(Status, LoanGuarantorSubstitutionRequest.Status::Open);

    //         if LoanGuarantorSubstitutionRequest.FindFirst then begin
    //             // LoanGuarantors.Reset;
    //             // LoanGuarantors.SetRange("No.", LoanGuarantorSubstitutionRequest."No.");
    //             // LoanGuarantors.DeleteAll(true);

    //             LoanGuarantorSubstitutionRequest.Status := LoanGuarantorSubstitutionRequest.Status::Cancelled;
    //             if LoanGuarantorSubstitutionRequest.Modify(true) then begin
    //                 ResponseObject.Add('status', 'SUCCESS');
    //                 ResponseObject.Add('status_description', 'Loan guarantor substitution request has been cancelled successfully');
    //             end else begin
    //                 ResponseObject.Add('status', 'ERROR');
    //                 ResponseObject.Add('status_description', GetLastErrorText(true));
    //                 AddDateTimeToResponse(ResponseObject);
    //                 ResponseObject.WriteTo(Response);
    //                 exit(Response);
    //             end;
    //         end else begin
    //             ResponseObject.Add('status', 'NOT_FOUND');
    //             ResponseObject.Add('status_description', 'The loan guarantor substitution request ' + application_no.AsValue.AsText + ' is NOT available for cancellation');
    //         end;
    //     end else begin
    //         ResponseObject.Add('status', ResponseText);
    //         ResponseObject.Add('status_description', ResponseDescription);
    //     end;

    //     AddDateTimeToResponse(ResponseObject);
    //     ResponseObject.WriteTo(Response);

    //     exit(Response);
    // end;
    local procedure GetLoanGuarantorSubstitutionRequests(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        TheGuarantor: Record Members;
        TheLoanApplications: Record "Sky Guarantor Sub Applications";
        GuarantorRequests: Record "Sky Guarantor Sub Requests";
        TheLoanProduct: Record "Product Factory";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Guarantors: JsonArray;
        Guarantor: JsonObject;
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
            // TheLoanApplications.SetFilter(Status, '=%1|%2', TheLoanApplications.Status::Open, TheLoanApplications.Status::"Pending Approval");

            if TheLoanApplications.FindSet then begin
                repeat begin
                    Clear(Datum);

                    TheLoanApplications.CalcFields(
                        "Loan Product Name",
                        "Member Name"
                    );
                    Datum.Add('application_no', TheLoanApplications."No.");
                    Datum.Add('member_no', TheLoanApplications."Member No.");
                    Datum.Add('member_name', TheLoanApplications."Member Name");
                    Datum.Add('application_date_time', GlobalFunctions.FormatISODateTime(TheLoanApplications."Application Date Time"));
                    Datum.Add('loan_product_type', TheLoanApplications."Loan Product Type");
                    Datum.Add('loan_product_name', TheLoanApplications."Loan Product Name");
                    Datum.Add('status', Format(TheLoanApplications.Status));

                    GuarantorRequests.Reset;
                    GuarantorRequests.SetRange("Application No.", TheLoanApplications."No.");
                    if GuarantorRequests.FindSet then begin
                        repeat begin
                            Clear(Guarantor);

                            GuarantorRequests.CalcFields("Member Name", "Substituted Member Name");
                            Guarantor.Add('entry_no', GuarantorRequests."Entry No.");
                            Guarantor.Add('member_number', GuarantorRequests."Member No.");
                            Guarantor.Add('member_name', GuarantorRequests."Member Name");

                            TheGuarantor.Reset;
                            if TheGuarantor.Get(GuarantorRequests."Member No.") then begin
                                Guarantor.Add('phone_number', TheGuarantor."Phone No.");
                            end;

                            Guarantor.Add('substituted_member_number', GuarantorRequests."Substituted Member No.");
                            Guarantor.Add('substituted_member_name', GuarantorRequests."Substituted Member Name");

                            Guarantor.Add('amount_guaranteed', GuarantorRequests."Amount Guaranteed");

                            Guarantor.Add('request_status', Format(GuarantorRequests.Status));
                            Guarantor.Add('request_status_date_time', GlobalFunctions.FormatISODateTime(GuarantorRequests."Status Date Time"));

                            Guarantors.Add(Guarantor);
                        end until GuarantorRequests.Next = 0;
                    end;

                    Datum.Add('guarantorship_requests', Guarantors);

                    if TheLoanProduct.Get(TheLoanApplications."Loan Product Type") then begin
                        Datum.Add('expected_guarantors', TheLoanProduct."Minimum Guarantors");
                        Datum.Add('maximum_guarantors', TheLoanProduct."Maximum Guarantors");
                    end;

                    Data.Add(Datum);
                end until TheLoanApplications.Next = 0;
            end;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Loan guarantor substitution application request list has been fetched successfully');
            ResponseObject.Add('data', Data);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CancelLoanGuarantorSubstitutionRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;

        SearchMember: record Members;
        TheLoanApplication: Record "Sky Guarantor Sub Applications";
        TheLoanGuarantorshipRequests: Record "Sky Guarantor Sub Requests";

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

            TheLoanApplication.SetRange("No.", application_no.AsValue.AsText);
            TheLoanApplication.SetRange(Status, TheLoanApplication.Status::Open);

            if TheLoanApplication.FindFirst then begin
                TheLoanGuarantorshipRequests.Reset;

                TheLoanGuarantorshipRequests.SetRange("Application No.", TheLoanApplication."No.");
                if TheLoanGuarantorshipRequests.FindSet then begin
                    repeat begin
                        TheLoanGuarantorshipRequests.Delete(true);
                    end until TheLoanGuarantorshipRequests.Next = 0;
                end;

                if TheLoanApplication.Delete(true) then begin
                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Loan application request has been cancelled successfully');
                end else begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', GetLastErrorText(true));
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end else begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'The loan application ' + application_no.AsValue.AsText + ' is NOT available for cancellation');
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure ManageLoanGuarantorshipSubstitutionRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;
        action: JsonToken;
        guarantor_member_number: JsonToken;

        SearchMember: Record Members;
        TheLoanGuarantorshipRequest: Record "Sky Guarantor Sub Requests";
        TheLoanApplication: Record "Sky Guarantor Sub Applications";

        SalaryAmount: decimal;
        GuarantorMember: Record Members;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;

        FailReason: Text;
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
                            // Validate loan guarantors

                            SalaryAmount := 0;

                            GuarantorMember.Reset;
                            GuarantorMember.SetRange("No.", guarantor_member_number.AsValue.AsText);
                            if GuarantorMember.FindFirst then begin
                                SalaryAmount := GuarantorSalaryEligibility(TheLoanApplication."Loan Product Type", GuarantorMember, 0, FailReason);

                                if SalaryAmount <= 0 then begin
                                    ResponseObject.Add('status', 'ERROR');
                                    Datum.Add('error_message', 'Member with no. ' + guarantor_member_number.AsValue.AsText + ' is NOT eligible for guarantorship due to salary requirements!');
                                    ResponseObject.Add('data', Datum);

                                    AddDateTimeToResponse(ResponseObject);

                                    ResponseObject.WriteTo(Response);
                                    exit(Response);
                                end;
                            end;

                            TheLoanGuarantorshipRequest.Reset;
                            TheLoanGuarantorshipRequest.Init;

                            TheLoanGuarantorshipRequest."Member No." := guarantor_member_number.AsValue.AsText;

                            TheLoanGuarantorshipRequest.Status := TheLoanGuarantorshipRequest.Status::Open;
                            TheLoanGuarantorshipRequest."Status Date Time" := CurrentDateTime;
                            TheLoanGuarantorshipRequest."Application No." := TheLoanApplication."No.";

                            if TheLoanGuarantorshipRequest.Insert(true) then begin
                                ResponseObject.Add('status', 'SUCCESS');
                                ResponseObject.Add('status_description', 'Loan guarantor has been added successfully');
                            end else begin
                                ResponseObject.Add('status', 'ERROR');
                                ResponseObject.Add('status_description', GetLastErrorText(true));
                                AddDateTimeToResponse(ResponseObject);
                                ResponseObject.WriteTo(Response);
                                exit(Response);
                            end;
                        end;
                    'REMOVE':
                        begin
                            TheLoanGuarantorshipRequest.Reset;

                            TheLoanGuarantorshipRequest.SetRange("Member No.", guarantor_member_number.AsValue.AsText);
                            TheLoanGuarantorshipRequest.SetRange(Status, TheLoanGuarantorshipRequest.Status::Open);
                            TheLoanGuarantorshipRequest.SetRange("Application No.", TheLoanApplication."No.");

                            if TheLoanGuarantorshipRequest.FindFirst then begin
                                if TheLoanGuarantorshipRequest.Delete(true) then begin
                                    ResponseObject.Add('status', 'SUCCESS');
                                    ResponseObject.Add('status_description', 'Loan guarantor has been removed successfully');
                                end else begin
                                    ResponseObject.Add('status', 'ERROR');
                                    ResponseObject.Add('status_description', GetLastErrorText(true));
                                    AddDateTimeToResponse(ResponseObject);
                                    ResponseObject.WriteTo(Response);
                                    exit(Response);
                                end;
                            end else begin
                                ResponseObject.Add('status', 'NOT_FOUND');
                                ResponseObject.Add('status_description', 'Loan guarantorship request NOT found');
                            end;
                        end;
                    else
                end;
            end else begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', StrSubstNo('Loan application with no %1 NOT found', application_no.AsValue.AsText));
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanGuarantorshipSubstitutionRequests(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        TheLoanGuarantorshipRequests: Record "Sky Guarantor Sub Requests";
        TheLoanApplications: Record "Sky Guarantor Sub Applications";

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
            // TheLoanGuarantorshipRequests.SetRange(Status, TheLoanGuarantorshipRequests.Status::Open);

            if TheLoanGuarantorshipRequests.FindSet then begin
                repeat begin
                    Clear(Datum);

                    TheLoanApplications.Reset;
                    TheLoanApplications.SetRange("No.", TheLoanGuarantorshipRequests."Application No.");
                    if TheLoanApplications.FindFirst then begin
                        TheLoanApplications.CalcFields(
                        "Loan Product Name",
                        "Member Name"
                        );

                        Datum.Add('entry_no', TheLoanGuarantorshipRequests."Entry No.");
                        Datum.Add('application_no', TheLoanApplications."No.");
                        Datum.Add('member_no', TheLoanApplications."Member No.");
                        Datum.Add('member_name', TheLoanApplications."Member Name");
                        Datum.Add('application_date_time', GlobalFunctions.FormatISODateTime(TheLoanApplications."Application Date Time"));
                        Datum.Add('loan_product_type', TheLoanApplications."Loan Product Type");
                        Datum.Add('loan_product_name', TheLoanApplications."Loan Product Name");
                        Datum.Add('status', Format(TheLoanGuarantorshipRequests.Status));
                        Datum.Add('status_date', GlobalFunctions.FormatISODateTime(TheLoanGuarantorshipRequests."Status Date Time"));

                        Data.Add(Datum);
                    end;

                end until TheLoanGuarantorshipRequests.Next = 0;
            end;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Loan guarantorship substitution request list has been fetched successfully');
            ResponseObject.Add('data', Data);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanGuarantorshipSubstitutionRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;

        SearchMember: Record Members;
        TheLoanGuarantorshipRequests: Record "Sky Guarantor Sub Requests";
        TheLoanApplications: Record "Sky Guarantor Sub Applications";

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
            // TheLoanGuarantorshipRequests.SetRange(Status, TheLoanGuarantorshipRequests.Status::Open);
            TheLoanGuarantorshipRequests.SetRange("Application No.", application_no.AsValue.AsText);

            if TheLoanGuarantorshipRequests.FindFirst then begin
                TheLoanApplications.Get(TheLoanGuarantorshipRequests."Application No.");
                TheLoanApplications.CalcFields(
                    "Loan Product Name",
                    "Member Name"
                );

                Datum.Add('entry_no', TheLoanGuarantorshipRequests."Entry No.");
                Datum.Add('application_no', TheLoanApplications."No.");
                Datum.Add('member_no', TheLoanApplications."Member No.");
                Datum.Add('member_name', TheLoanApplications."Member Name");
                Datum.Add('application_date_time', GlobalFunctions.FormatISODateTime(TheLoanApplications."Application Date Time"));
                Datum.Add('loan_product_type', TheLoanApplications."Loan Product Type");
                Datum.Add('loan_product_name', TheLoanApplications."Loan Product Name");
                Datum.Add('status', Format(TheLoanGuarantorshipRequests.Status));
                Datum.Add('status_date', GlobalFunctions.FormatISODateTime(TheLoanGuarantorshipRequests."Status Date Time"));

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Loan guarantorship request has been fetched successfully');
                ResponseObject.Add('data', Datum);
            end else begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', StrSubstNo('Loan guarantorship request with number %1 is NOT found', application_no.AsValue.AsText));
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure ActionLoanGuarantorshipSubstitutionRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;
        action: JsonToken;

        SearchMember: Record Members;
        TheLoanGuarantorshipRequests: Record "Sky Guarantor Sub Requests";

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
            TheLoanGuarantorshipRequests.SetRange("Application No.", application_no.AsValue.AsText);

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
                        ResponseObject.Add('status', 'ERROR');
                        ResponseObject.Add('status_description', 'Unsupported action. Supported actions are: ACCEPT and REJECT');
                        AddDateTimeToResponse(ResponseObject);
                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
                end;

                if TheLoanGuarantorshipRequests.Modify(true) then begin
                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Loan guarantorship request has been actioned successfully');
                end else begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', 'Unable to action the loan guarantorship request at the moment');
                end;
            end else begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Loan guarantorship request NOT found');
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    // Variations - Loan
    local procedure CreateLoanVariationRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        loan_no: JsonToken;
        new_deduction_amount: JsonToken;
        comments: JsonToken;

        KeyExists: Boolean;

        Variations: Record "Product Variations";

        SearchMember: record Members;
        EditMemberLoan: Record Loans;
        Comment: Record "Loan Appraisal Comments";
        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('loan_no', loan_no);
        Payload.Get('new_deduction_amount', new_deduction_amount);
        KeyExists := Payload.Get('comments', comments);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            EditMemberLoan.Reset();
            EditMemberLoan.SetRange("Member No.", SearchMember."No.");
            EditMemberLoan.SetRange("Loan No.", loan_no.AsValue.AsText);
            EditMemberLoan.SetRange(Posted, true);

            IF EditMemberLoan.FindFirst then begin
                Variations.Init;

                Variations."Variation Type" := Variations."Variation Type"::Loan;

                Variations."No." := '';
                Variations."No. Series" := '';
                Variations."CRM Notes" := '';
                Variations."CRM Originating Branch" := 'ONLINE';
                Variations."CRM Created By" := 'MEMBER PORTAL';

                Variations."Member No." := SearchMember."No.";
                Variations."Account No" := EditMemberLoan."Loan No.";
                Variations.Validate("Member No.");

                Variations."Account No" := EditMemberLoan."Loan No.";
                Variations.Validate("Account No");
                Variations."Amount On" := new_deduction_amount.AsValue.AsDecimal;
                Variations.Validate("Amount On");

                Variations."Application Date" := Today;
                Variations.Validate("Application Date");

                Variations.Status := Variations.Status::Open;

                if Variations."Amount On" > EditMemberLoan.Repayment then begin
                    // Vary upwards
                    Variations."Variation Action" := Variations."Variation Action"::"Vary Rate Upwards";
                end else begin
                    Variations."Variation Action" := Variations."Variation Action"::"Vary Rate Downwards";
                end;

                Variations."Source Application" := Variations."Source Application"::"Member Portal";

                IF Variations.Insert(true) then begin
                    Variations."CRM Application No." := Variations."No.";
                    Variations."CRM No. Series" := Variations."No. Series";
                    Variations.Modify();

                    // User comments
                    if comments.AsValue.AsText <> '' then begin
                        Comment.Init;

                        Comment."Loan No." := Variations."No.";
                        Comment.Comment := GlobalFunctions.FormatISODateTime(CurrentDateTime) + ' - ' + comments.AsValue.AsText;
                        Comment.Appraiser := SearchMember.Name;
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
                    Variations."Global Dimension 1 Code" := SearchMember."Global Dimension 1 Code";
                    Variations.Modify;

                    ResponseData.Add('application_number', Variations."No.");
                    ResponseData.Add('application_status', Format(Variations.Status));

                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Loan variation application with application number ' + Variations."No." + ' has been created successfully.');
                    ResponseObject.Add('data', ResponseData);
                end else begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', GetLastErrorText(true));
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end else begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', StrSubstNo('Unknown loan with loan number = %1', loan_no.asValue.AsText));
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanVariationRequests(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        Variations: Record "Product Variations";

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
            Variations.Reset;
            Variations.SetRange("Member No.", SearchMember."No.");
            Variations.SetRange("Variation Type", Variations."Variation Type"::Loan);
            // Variations.SetFilter(Status, '=%1|%2', Variations.Status::Open, Variations.Status::"Pending Approval");
            Variations.SetFilter("Source Application", '=%1|%2', Variations."Source Application"::"Member Portal", Variations."Source Application"::"Mobile Banking");

            Variations.SetCurrentKey("Application Date", "Application Time");
            Variations.SetAscending("Application Date", false);
            Variations.SetAscending("Application Time", false);

            if Variations.FindSet then begin
                repeat begin
                    Clear(Datum);

                    Datum.Add('application_no', Variations."No.");
                    Datum.Add('member_no', Variations."Member No.");
                    Datum.Add('member_name', Variations."Member Name");
                    Datum.Add('reference', Variations.Reference);
                    Datum.Add('status', Format(Variations.Status));
                    Datum.Add('is_posted', Variations.Posted);
                    Datum.Add('loan_no', Variations."Account No");
                    Datum.Add('product_type', Variations."Product Type");
                    Datum.Add('product_name', Variations."Product Name");
                    Datum.Add('new_deduction_amount', Variations."Amount On");
                    Datum.Add('current_deduction_amount', Variations."Amount Off");
                    Datum.Add('application_date', GlobalFunctions.FormatISODate(Variations."Application Date"));
                    Datum.Add('variation_action', Format(Variations."Variation Action"));

                    Data.Add(Datum);
                end until Variations.Next = 0;
            end;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Loan variation request list has been fetched successfully');
            ResponseObject.Add('data', Data);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CancelLoanVariationRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;

        SearchMember: Record Members;
        LoanVariation: Record "Product Variations";

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
            LoanVariation.Reset;

            LoanVariation.SetRange("No.", application_no.AsValue.AsText);
            LoanVariation.SetRange("Member No.", SearchMember."No.");
            LoanVariation.SetRange(Status, LoanVariation.Status::Open);

            if LoanVariation.FindFirst then begin
                LoanVariation.Status := LoanVariation.Status::Cancelled;
                LoanVariation."CRM Notes" := 'Variation request cancelled through member portal';

                if LoanVariation.Modify(true) then begin
                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Loan variation request has been cancelled successfully');
                end else begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', GetLastErrorText(true));
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end else begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'The Loan variation ' + application_no.AsValue.AsText + ' is NOT available for cancellation');
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    // Variations - Deposit
    local procedure GetMemberMinDepositLimitRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        MemberClasses: Record "Member Classes";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        StaffDetails: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, CUSTOMER_NO, NATIONAL_ID, PASSPORT_NO, GROWER_NO
        Payload.Get('identifier', identifier);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            MemberClasses.Reset;
            MemberClasses.SetRange("No.", SearchMember."Member Class");
            if MemberClasses.FindFirst then begin
                Datum.Add('min_bosa_deposit', MemberClasses."Default BOSA Deposit");
            end else begin
                Datum.Add('min_bosa_deposit', 0);
            end;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Request is successful');
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        ResponseObject.Add('data', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CreateDepositVariationRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        account_no: JsonToken;
        new_contribution_amount: JsonToken;
        comments: JsonToken;

        KeyExists: Boolean;

        Variations: Record "Product Variations";

        SearchMember: record Members;
        EditMemberAccount: Record "Savings Accounts";
        Comment: Record "Loan Appraisal Comments";
        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Errors: JsonArray;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;

        ProrataAmt: Decimal;
        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('account_no', account_no);
        Payload.Get('new_contribution_amount', new_contribution_amount);
        KeyExists := Payload.Get('comments', comments);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            EditMemberAccount.Reset();
            EditMemberAccount.SetRange("Member No.", SearchMember."No.");
            EditMemberAccount.SetRange("No.", account_no.AsValue.AsText);

            IF EditMemberAccount.FindFirst then begin
                ProrataAmt := CustomCuesCodeunit.Prorata(EditMemberAccount."Member No.", EditMemberAccount."Product Type");
                if new_contribution_amount.AsValue.AsDecimal <= ProrataAmt then begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', 'New variation amount should not be below the prorata amount of KES ' + Format(ProrataAmt));
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;

                Variations.Init;

                Variations."Variation Type" := Variations."Variation Type"::Savings;

                Variations."No." := '';
                Variations."No. Series" := '';
                Variations."CRM Notes" := '';
                Variations."CRM Originating Branch" := 'ONLINE';
                Variations."CRM Created By" := 'MEMBER PORTAL';

                Variations."Member No." := SearchMember."No.";
                Variations."Account No" := EditMemberAccount."No.";
                Variations.Validate("Member No.");

                Variations."Account No" := EditMemberAccount."No.";
                Variations.Validate("Account No");
                Variations."Amount On" := new_contribution_amount.AsValue.AsDecimal;
                Variations.Validate("Amount On");

                Variations."Application Date" := Today;
                Variations.Validate("Application Date");

                Variations.Status := Variations.Status::Open;

                if Variations."Amount On" > EditMemberAccount."Monthly Contribution" then begin
                    // Vary upwards
                    Variations."Variation Action" := Variations."Variation Action"::"Vary Rate Upwards";
                end else begin
                    Variations."Variation Action" := Variations."Variation Action"::"Vary Rate Downwards";
                end;

                Variations."Source Application" := Variations."Source Application"::"Member Portal";

                IF Variations.Insert(true) then begin
                    Variations."CRM Application No." := Variations."No.";
                    Variations."CRM No. Series" := Variations."No. Series";
                    Variations.Modify();

                    // User comments
                    if comments.AsValue.AsText <> '' then begin
                        Comment.Init;

                        Comment."Loan No." := Variations."No.";
                        Comment.Comment := comments.AsValue.AsText;
                        Comment.Appraiser := SearchMember.Name;
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
                    Variations."Global Dimension 1 Code" := SearchMember."Global Dimension 1 Code";
                    Variations.Modify;

                    ResponseData.Add('application_number', Variations."No.");
                    ResponseData.Add('application_status', Format(Variations.Status));

                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Deposit variation application with application number ' + Variations."No." + ' has been created successfully.');
                    ResponseObject.Add('data', ResponseData);
                end else begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', GetLastErrorText(true));
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end else begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', StrSubstNo('Unknown account with account number = %1', account_no.asValue.AsText));
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetDepositVariationRequests(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        Variations: Record "Product Variations";

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
            Variations.Reset;
            Variations.SetRange("Member No.", SearchMember."No.");
            Variations.SetRange("Variation Type", Variations."Variation Type"::Savings);
            // Variations.SetFilter(Status, '=%1|%2', Variations.Status::Open, Variations.Status::"Pending Approval");
            Variations.SetFilter("Source Application", '=%1|%2', Variations."Source Application"::"Member Portal", Variations."Source Application"::"Mobile Banking");

            Variations.SetCurrentKey("Application Date", "Application Time");
            Variations.SetAscending("Application Date", false);
            Variations.SetAscending("Application Time", false);

            if Variations.FindSet then begin
                repeat begin
                    Clear(Datum);

                    Datum.Add('application_no', Variations."No.");
                    Datum.Add('member_no', Variations."Member No.");
                    Datum.Add('member_name', Variations."Member Name");
                    Datum.Add('reference', Variations.Reference);
                    Datum.Add('status', Format(Variations.Status));
                    Datum.Add('is_posted', Variations.Posted);
                    Datum.Add('account_no', Variations."Account No");
                    Datum.Add('product_type', Variations."Product Type");
                    Datum.Add('product_name', Variations."Product Name");
                    Datum.Add('new_contribution_amount', Variations."Amount On");
                    Datum.Add('current_contribution_amount', Variations."Amount Off");
                    Datum.Add('application_date', GlobalFunctions.FormatISODate(Variations."Application Date"));
                    Datum.Add('variation_action', Format(Variations."Variation Action"));

                    Data.Add(Datum);
                end until Variations.Next = 0;
            end;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Deposit variation request list has been fetched successfully');
            ResponseObject.Add('data', Data);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CancelDepositVariationRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;

        SearchMember: Record Members;
        DepositVariation: Record "Product Variations";

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
            DepositVariation.Reset;

            DepositVariation.SetRange("No.", application_no.AsValue.AsText);
            DepositVariation.SetRange("Member No.", SearchMember."No.");
            DepositVariation.SetRange(Status, DepositVariation.Status::Open);

            if DepositVariation.FindFirst then begin
                DepositVariation.Status := DepositVariation.Status::Cancelled;
                DepositVariation."CRM Notes" := 'Variation request cancelled through member portal';

                if DepositVariation.Modify(true) then begin
                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Deposit variation request has been cancelled successfully');
                end else begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', GetLastErrorText(true));
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end else begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'The deposit variation ' + application_no.AsValue.AsText + ' is NOT available for cancellation');
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    // NOK
    local procedure GetNOKIdentificationTypes(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: record members;
        Index: Integer;
        Max: Integer;

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

            repeat begin
                Clear(Datum);
                Max += 1;

                Datum.Add('code', Max);
                Datum.Add('type_name', Format("Identification Type".FromInteger(Max)));

                Data.Add(Datum);
            end until Max = 5;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'NOK types list has been fetched successfully');
            ResponseObject.Add('data', Data);

        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetNokRelationships(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: record members;
        NOKRelationships: Record "Relationship Types";

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

            NOKRelationships.Reset;

            IF NOKRelationships.FindSet then begin
                repeat begin
                    if NOKRelationships.Relation <> 'SELF' then begin
                        Clear(Datum);

                        Datum.Add('code', NOKRelationships.Relation);
                        Datum.Add('relationship', NOKRelationships.Relation);
                        Datum.Add('min_age', NOKRelationships."Min. Age");
                        Datum.Add('max_age', NOKRelationships."Max. Age");

                        Data.Add(Datum);
                    end;
                end until NOKRelationships.Next = 0;
            end;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'NOK relationships list has been fetched successfully');
            ResponseObject.Add('data', Data);

        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CreateNextOfKinApplicationRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
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

        SearchMember: record Members;
        NextofKinApplication: Record "Next of KIN Application";
        DepApplication: Record "Dependancies Applications";
        theApp: Record "Dependancies Applications";

        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        NewNo: Code[20];
        NewNoSeriesCode: Code[20];

        KeyExists: Boolean;
        Index: Integer;

        TheLoanApplicationDocuments: Record "Channel Application Documents";
        EDMSFunctions: Codeunit "EDMS Functions";
        EDMSFileTypes: enum "EDMS File Types";

        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        Base64Convert: Codeunit "Base64 Convert";

        XmlDoc: XmlDocument;
        ReportParameters: Text;

        StoreImageRef: FieldRef;
        StoreRecRef: RecordRef;
        RecRef: RecordRef;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('nok_beneficiary_nominee_info', nok_beneficiary_nominee_info);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            // Next of Kin, Nominee, BBF
            IF nok_beneficiary_nominee_info.IsArray then begin
                DepApplication.Init;

                SeriesSetup.Get;
                SeriesSetup.TestField(SeriesSetup."Dependancy Application Nos.");
                SeriesSetup."Dependancy Application Nos." := NoSeriesMgt.GetNextNo(SeriesSetup."Dependancy Application Nos.");

                // NoSeriesMgt.InitSeries(SeriesSetup."Dependancy Application Nos.", SeriesSetup."Dependancy Application Nos.", 0D, NewNo, NewNoSeriesCode);

                DepApplication."No." := NewNo;
                DepApplication."No. Series" := NewNoSeriesCode;
                DepApplication."Source Application" := DepApplication."Source Application"::"Member Portal";

                DepApplication."Application Date" := Today;
                DepApplication."Application Time" := Time;
                DepApplication."Account Type" := DepApplication."Account Type"::"Single Member Account";
                DepApplication."Member No." := SearchMember."No.";
                DepApplication.Validate("Member No.");
                DepApplication.Description := 'Member Portal Create NOK Request';
                DepApplication."M-Smart No" := '';
                DepApplication."Auto Assign Task" := false;

                DepApplication.Status := DepApplication.Status::Open;

                if DepApplication.Insert(true) then begin
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
                        // NextofKinApplication."No." := Index + 1;

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

                        KeyExists := NextofKinApplication.Insert(true);

                        NextofKinApplication.Reset();
                        Clear(NextofKinApplication);
                    end;

                    DepApplication."Global Dimension 1 Code" := '143';
                    DepApplication."Global Dimension 2 Code" := 'BOSA';
                    DepApplication."Responsibility Center" := 'RECORDS';
                    DepApplication.Modify;

                    theApp.Reset;
                    theApp.SetRange("No.", DepApplication."No.");

                    if theApp.FindFirst then begin
                        // EDMS
                        TheLoanApplicationDocuments.Reset;
                        Clear(TheLoanApplicationDocuments);
                        TheLoanApplicationDocuments.Init;

                        TheLoanApplicationDocuments."Application Type" := TheLoanApplicationDocuments."Application Type"::"Dependancy Application";
                        TheLoanApplicationDocuments."Application No." := DepApplication."No.";
                        TheLoanApplicationDocuments."Document Name" := StrSubstNo('%1-DependancyApplicationForm.pdf', DepApplication."No.");

                        XmlDocument.ReadFrom(
                            StrSubstNo(
                                '<ReportParameters name="Member Portal Dependancy App" id="%1"><DataItems><DataItem name="DependanciesApplications">VERSION(1) SORTING(Field1) WHERE(Field1=1(%2))</DataItem><DataItem name="NOK">VERSION(1) SORTING(Field1,Field15)</DataItem></DataItems></ReportParameters>',
                                Report::"Member Portal Dependancy App",
                                DepApplication."No."
                            ),
                            XmlDoc
                        );
                        XmlDoc.WriteTo(ReportParameters);

                        // Blob
                        TempBlob.CreateOutStream(OutStr);
                        Clear(TheLoanApplicationDocuments.Document);
                        StoreRecRef.Open(52186564);
                        StoreImageRef := StoreRecRef.Field(TheLoanApplicationDocuments.FieldNo(Document));
                        RecRef.GetTable(theApp);
                        Report.SaveAs(Report::"Member Portal Dependancy App", ReportParameters, ReportFormat::Pdf, OutStr, RecRef);
                        TempBlob.ToFieldRef(StoreImageRef);
                        StoreImageRef.TestField();

                        TheLoanApplicationDocuments.Document := StoreImageRef.Value;
                        TheLoanApplicationDocuments."Document Extension" := EDMSFunctions.GetFileTypeFromFileName(TheLoanApplicationDocuments."Document Name");

                        TheLoanApplicationDocuments.Insert(true);

                        Clear(TempBlob);
                        Clear(OutStr);
                        Clear(Base64Convert);
                        Clear(StoreRecRef);
                        Clear(StoreImageRef);
                        Clear(RecRef);
                    end;

                    Datum.Add('application_no', DepApplication."No.");

                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Request is successful');
                    ResponseObject.Add('data', Datum);
                end else begin
                    ResponseObject.Add('status', 'ERROR');
                    Datum.Add('error_message', 'Unable to initiate dependency application at the moment');
                    ResponseObject.Add('response_payload', Datum);
                end;
            end else begin
                ResponseObject.Add('status', 'ERROR');
                Datum.Add('error_message', 'Expecting an array/list of next of kin beneficiaries information');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure UpdateNextOfKinApplicationRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
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
        nok_beneficiary_nominee_mark_for_deletion: JsonToken;
        nok_beneficiary_nominee_nok_id: JsonToken;
        nok_beneficiary_nominee_allocation: JsonToken;

        SearchMember: record Members;
        NextofKinApplication: Record "Next of KIN Application";
        theApp: Record "Next of KIN Application";
        DepApplication: Record "Dependancies Applications";
        theApp2: Record "Dependancies Applications";
        NextOfKin: Record "Next of Kin";

        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        NewNo: Code[20];
        NewNoSeriesCode: Code[20];

        KeyExists: Boolean;
        Index: Integer;

        TheLoanApplicationDocuments: Record "Channel Application Documents";
        EDMSFunctions: Codeunit "EDMS Functions";
        EDMSFileTypes: enum "EDMS File Types";

        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        Base64Convert: Codeunit "Base64 Convert";

        XmlDoc: XmlDocument;
        ReportParameters: Text;

        StoreImageRef: FieldRef;
        StoreRecRef: RecordRef;
        RecRef: RecordRef;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('nok_beneficiary_nominee_info', nok_beneficiary_nominee_info);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            // Next of Kin, Nominee, BBF
            IF nok_beneficiary_nominee_info.IsArray then begin
                DepApplication.Init;

                SeriesSetup.Get;
                SeriesSetup.TestField(SeriesSetup."Dependancy Application Nos.");
                SeriesSetup."Dependancy Application Nos." := NoSeriesMgt.GetNextNo(SeriesSetup."Dependancy Application Nos.");
                // NoSeriesMgt.InitSeries(SeriesSetup."Dependancy Application Nos.", SeriesSetup."Dependancy Application Nos.", 0D, NewNo, NewNoSeriesCode);

                DepApplication."No." := NewNo;
                DepApplication."No. Series" := NewNoSeriesCode;
                DepApplication."Source Application" := DepApplication."Source Application"::"Member Portal";

                DepApplication."Application Date" := Today;
                DepApplication."Application Time" := Time;
                DepApplication."Account Type" := DepApplication."Account Type"::"Single Member Account";
                DepApplication."Member No." := SearchMember."No.";
                DepApplication.Validate("Member No.");
                DepApplication.Description := 'Member Portal Update NOK Request';
                DepApplication."M-Smart No" := '';
                DepApplication."Auto Assign Task" := false;

                DepApplication.Status := DepApplication.Status::Open;
                // DepApplication."Dependancy Update" := true;

                if DepApplication.Insert(true) then begin
                    for Index := 0 to (nok_beneficiary_nominee_info.AsArray.Count - 1) do begin
                        KeyExists := nok_beneficiary_nominee_info.AsArray.Get(Index, nok_beneficiary_nominee);

                        KeyExists := nok_beneficiary_nominee.AsObject.Get('nok_id', nok_beneficiary_nominee_nok_id);
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
                        KeyExists := nok_beneficiary_nominee.AsObject.Get('mark_for_deletion', nok_beneficiary_nominee_mark_for_deletion);
                        KeyExists := nok_beneficiary_nominee.AsObject.Get('allocation', nok_beneficiary_nominee_allocation);

                        NextofKinApplication.SetRange("Record ID", NewNo);
                        NextofKinApplication.SetRange(Identification, nok_beneficiary_nominee_nok_id.AsValue.AsText);
                        if NextofKinApplication.FindFirst() then begin
                            // Update
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
                            NextofKinApplication.Removed := nok_beneficiary_nominee_mark_for_deletion.AsValue.AsBoolean;

                            KeyExists := NextofKinApplication.Modify(true);

                            NextofKinApplication.Reset();
                        end else begin
                            // Create
                            NextofKinApplication.Init();

                            NextofKinApplication."Record ID" := NewNo;
                            // NextofKinApplication."No." := Index + 1;

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

                            KeyExists := NextofKinApplication.Insert(true);

                            NextofKinApplication.Reset();
                        end;

                        Clear(NextofKinApplication);
                    end;

                    DepApplication."Global Dimension 1 Code" := '143';
                    DepApplication."Global Dimension 2 Code" := 'BOSA';
                    DepApplication."Responsibility Center" := 'RECORDS';
                    DepApplication.Modify;

                    theApp2.Reset;
                    theApp2.SetRange("No.", DepApplication."No.");

                    if theApp2.FindFirst then begin
                        // EDMS
                        TheLoanApplicationDocuments.Reset;
                        Clear(TheLoanApplicationDocuments);
                        TheLoanApplicationDocuments.Init;

                        TheLoanApplicationDocuments."Application Type" := TheLoanApplicationDocuments."Application Type"::"Dependancy Application";
                        TheLoanApplicationDocuments."Application No." := DepApplication."No.";
                        TheLoanApplicationDocuments."Document Name" := StrSubstNo('%1-DependancyApplicationForm.pdf', DepApplication."No.");

                        XmlDocument.ReadFrom(
                            StrSubstNo(
                                '<ReportParameters name="Member Portal Dependancy App" id="%1"><DataItems><DataItem name="DependanciesApplications">VERSION(1) SORTING(Field1) WHERE(Field1=1(%2))</DataItem><DataItem name="NOK">VERSION(1) SORTING(Field1,Field15)</DataItem></DataItems></ReportParameters>',
                                Report::"Member Portal Dependancy App",
                                DepApplication."No."
                            ),
                            XmlDoc
                        );
                        XmlDoc.WriteTo(ReportParameters);

                        // Blob
                        TempBlob.CreateOutStream(OutStr);
                        Clear(TheLoanApplicationDocuments.Document);
                        StoreRecRef.Open(52186564);
                        StoreImageRef := StoreRecRef.Field(TheLoanApplicationDocuments.FieldNo(Document));
                        RecRef.GetTable(theApp2);
                        Report.SaveAs(Report::"Member Portal Dependancy App", ReportParameters, ReportFormat::Pdf, OutStr, RecRef);
                        TempBlob.ToFieldRef(StoreImageRef);
                        StoreImageRef.TestField();

                        TheLoanApplicationDocuments.Document := StoreImageRef.Value;
                        TheLoanApplicationDocuments."Document Extension" := EDMSFunctions.GetFileTypeFromFileName(TheLoanApplicationDocuments."Document Name");

                        TheLoanApplicationDocuments.Insert(true);

                        Clear(TempBlob);
                        Clear(OutStr);
                        Clear(Base64Convert);
                        Clear(StoreRecRef);
                        Clear(StoreImageRef);
                        Clear(RecRef);
                    end;

                    Datum.Add('application_no', DepApplication."No.");

                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Request is successful');
                    ResponseObject.Add('data', Datum);
                end else begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', 'Unable to initiate dependency application at the moment');
                    ResponseObject.Add('response_payload', Datum);
                end;
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Expecting an array/list of next of kin beneficiaries information');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'NOT_FOUND');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure DeleteNextOfKinApplicationRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        nok_beneficiary_nominee_info: JsonToken;
        nok_beneficiary_nominee: JsonToken;
        nok_beneficiary_nominee_nok_id: JsonToken;

        SearchMember: record Members;
        NextofKinApplication: Record "Next of KIN Application";
        DepApplication: Record "Dependancies Applications";
        NextOfKin: Record "Next of Kin";

        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        NewNo: Code[20];
        NewNoSeriesCode: Code[20];

        KeyExists: Boolean;
        Index: Integer;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('nok_beneficiary_nominee_info', nok_beneficiary_nominee_info);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            // Next of Kin, Nominee, BBF
            IF nok_beneficiary_nominee_info.IsArray then begin
                DepApplication.Init;

                SeriesSetup.Get;
                SeriesSetup.TestField(SeriesSetup."Dependancy Application Nos.");
                SeriesSetup."Dependancy Application Nos." := NoSeriesMgt.GetNextNo(SeriesSetup."Dependancy Application Nos.");
                // NoSeriesMgt.InitSeries(SeriesSetup."Dependancy Application Nos.", SeriesSetup."Dependancy Application Nos.", 0D, NewNo, NewNoSeriesCode);

                DepApplication."No." := NewNo;
                DepApplication."No. Series" := NewNoSeriesCode;
                DepApplication."Source Application" := DepApplication."Source Application"::"Member Portal";

                DepApplication."Application Date" := Today;
                DepApplication."Application Time" := Time;
                DepApplication."Account Type" := DepApplication."Account Type"::"Single Member Account";
                DepApplication."Member No." := SearchMember."No.";
                DepApplication.Validate("Member No.");
                DepApplication.Description := 'Member Portal Remove NOK Request';
                DepApplication."M-Smart No" := '';
                DepApplication."Auto Assign Task" := false;

                DepApplication.Status := DepApplication.Status::Open;
                // DepApplication."Dependancy Update" := true;

                if DepApplication.Insert(true) then begin
                    for Index := 0 to (nok_beneficiary_nominee_info.AsArray.Count - 1) do begin
                        KeyExists := nok_beneficiary_nominee_info.AsArray.Get(Index, nok_beneficiary_nominee);

                        KeyExists := nok_beneficiary_nominee.AsObject.Get('nok_id', nok_beneficiary_nominee_nok_id);
                        // KeyExists := nok_beneficiary_nominee.AsObject.Get('allocation', nok_beneficiary_nominee_allocation);

                        NextofKinApplication.SetRange("Record ID", NewNo);
                        NextofKinApplication.SetRange(Identification, nok_beneficiary_nominee_nok_id.AsValue.AsText);
                        if NextofKinApplication.FindFirst() then begin
                            // Update for Deletion
                            NextofKinApplication.Removed := true;

                            KeyExists := NextofKinApplication.Modify(true);

                            NextofKinApplication.Reset();
                        end;

                        Clear(NextofKinApplication);
                    end;

                    DepApplication."Global Dimension 1 Code" := '143';
                    DepApplication."Global Dimension 2 Code" := 'BOSA';
                    DepApplication."Responsibility Center" := 'RECORDS';
                    DepApplication.Modify;

                    Datum.Add('application_no', DepApplication."No.");

                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Request is successful');
                    ResponseObject.Add('data', Datum);
                end else begin
                    ResponseObject.Add('request_status', 'ERROR');
                    Datum.Add('error_message', 'Unable to initiate dependency application at the moment');
                    ResponseObject.Add('response_payload', Datum);
                end;
            end else begin
                ResponseObject.Add('request_status', 'ERROR');
                Datum.Add('error_message', 'Expecting an array/list of next of kin beneficiaries information');
                ResponseObject.Add('response_payload', Datum);
            end;
        end else begin
            ResponseObject.Add('request_status', 'NOT_FOUND');
            Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
            ResponseObject.Add('response_payload', Datum);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetNextOfKinApplicationRequests(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        TheDependencyApplications: Record "Dependancies Applications";

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
            TheDependencyApplications.Reset;
            TheDependencyApplications.SetRange("Member No.", SearchMember."No.");
            TheDependencyApplications.SetFilter(Status, '=%1|%2', TheDependencyApplications.Status::Open, TheDependencyApplications.Status::Pending);
            TheDependencyApplications.SetRange("Source Application", TheDependencyApplications."Source Application"::"Member Portal");

            if TheDependencyApplications.FindSet then begin
                repeat begin
                    Clear(Datum);

                    TheDependencyApplications.CalcFields(
                        Name
                    );

                    Datum.Add('application_no', TheDependencyApplications."No.");
                    Datum.Add('member_no', TheDependencyApplications."Member No.");
                    Datum.Add('member_name', TheDependencyApplications.Name);
                    Datum.Add('application_date', GlobalFunctions.FormatISODate(TheDependencyApplications."Application Date"));
                    Datum.Add('application_time', GlobalFunctions.FormatISOTime(TheDependencyApplications."Application Time"));
                    Datum.Add('status', Format(TheDependencyApplications.Status));
                    Datum.Add('description', TheDependencyApplications.Description);

                    Data.Add(Datum);
                end until TheDependencyApplications.Next = 0;
            end;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Next of kin application request list has been fetched successfully');
            ResponseObject.Add('data', Data);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetNextOfKinApplicationRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;

        SearchMember: Record Members;
        TheDependencyApplications: Record "Dependancies Applications";
        NextofKinApplication: Record "Next of KIN Application";

        nok_beneficiary_nominee_info: JsonArray;
        nok_beneficiary_nominee: JsonObject;

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
            TheDependencyApplications.Reset;
            TheDependencyApplications.SetRange("Member No.", SearchMember."No.");
            TheDependencyApplications.SetFilter(Status, '=%1|%2', TheDependencyApplications.Status::Open, TheDependencyApplications.Status::Pending);
            TheDependencyApplications.SetRange("Source Application", TheDependencyApplications."Source Application"::"Member Portal");
            TheDependencyApplications.SetRange("No.", application_no.AsValue.AsText);

            if TheDependencyApplications.FindFirst then begin
                TheDependencyApplications.CalcFields(
                    Name
                );
                Datum.Add('application_no', TheDependencyApplications."No.");
                Datum.Add('member_no', TheDependencyApplications."Member No.");
                Datum.Add('member_name', TheDependencyApplications.Name);
                Datum.Add('application_date', GlobalFunctions.FormatISODate(TheDependencyApplications."Application Date"));
                Datum.Add('application_time', GlobalFunctions.FormatISOTime(TheDependencyApplications."Application Time"));
                Datum.Add('description', TheDependencyApplications.Description);
                Datum.Add('status', Format(TheDependencyApplications.Status));

                NextofKinApplication.Reset;
                NextofKinApplication.SetRange("Record ID", TheDependencyApplications."No.");
                NextofKinApplication.SetRange("From Member Register", false);

                if NextofKinApplication.FindSet then begin
                    repeat begin
                        Clear(nok_beneficiary_nominee);

                        nok_beneficiary_nominee.Add('identification_type', Format(NextofKinApplication."Identification Type"));
                        nok_beneficiary_nominee.Add('identification_value', NextofKinApplication.Identification);
                        nok_beneficiary_nominee.Add('full_names', NextofKinApplication.Name);
                        nok_beneficiary_nominee.Add('relationship', NextofKinApplication.Relationship);
                        nok_beneficiary_nominee.Add('date_of_birth', GlobalFunctions.FormatISODate(NextofKinApplication."Date of Birth"));
                        nok_beneficiary_nominee.Add('address', NextofKinApplication.Address);
                        nok_beneficiary_nominee.Add('mobile_no', NextofKinApplication.Telephone);
                        nok_beneficiary_nominee.Add('email_address', NextofKinApplication.Email);
                        nok_beneficiary_nominee.Add('is_next_of_kin', NextofKinApplication."Is Next of Kin");
                        nok_beneficiary_nominee.Add('is_beneficiary', NextofKinApplication."Is a Beneficiary");
                        nok_beneficiary_nominee.Add('is_contact_person', NextofKinApplication."Is Contact Person");
                        nok_beneficiary_nominee.Add('is_nominee', NextofKinApplication."Is Nominee");
                        nok_beneficiary_nominee.Add('mark_for_deletion', NextofKinApplication.Removed);

                        nok_beneficiary_nominee_info.Add(nok_beneficiary_nominee);
                    end until NextofKinApplication.Next = 0;
                end;

                Datum.Add('nok_beneficiary_nominee_info', nok_beneficiary_nominee_info);

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Dependency application request has been fetched successfully');
                ResponseObject.Add('data', Datum);
            end else begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', 'Dependency application request ' + application_no.AsValue.AsText + ' NOT found');
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CancelNextOfKinApplicationRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;

        SearchMember: Record Members;
        TheDependencyApplication: Record "Dependancies Applications";
        NextofKinApplication: Record "Next of KIN Application";

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
            TheDependencyApplication.Reset;

            TheDependencyApplication.SetRange("No.", application_no.AsValue.AsText);
            TheDependencyApplication.SetRange(Status, TheDependencyApplication.Status::Open);

            if TheDependencyApplication.FindFirst then begin
                // NextofKinApplication.Reset;

                // NextofKinApplication.SetRange("Record ID", TheDependencyApplication."No.");
                // NextofKinApplication.SetRange("From Member Register", false);

                // if NextofKinApplication.FindSet then begin
                //     repeat begin
                //         NextofKinApplication.Delete(true);
                //     end until NextofKinApplication.Next = 0;
                // end;

                TheDependencyApplication.Status := TheDependencyApplication.Status::Cancelled;
                if TheDependencyApplication.Modify(true) then begin
                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Dependency application request has been cancelled successfully');
                end else begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', GetLastErrorText(true));
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end else begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'The dependency application ' + application_no.AsValue.AsText + ' is NOT available for cancellation');
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
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

            TheSTOAccounts.SetAutoCalcFields(
            "Balance (LCY)",
            "Authorised Over Draft",
            "Uncleared Cheques",
            "ATM Transactions",
            "Lien Placed",
            "Coop Transactions",
            "One Month Installment"
        );

            if TheSTOAccounts.FindSet then begin
                repeat begin
                    Clear(Datum);

                    Datum.Add('account_no', TheSTOAccounts."No.");
                    Datum.Add('account_name', TheSTOAccounts.Name);
                    Datum.Add('account_type', TheSTOAccounts."Product Name");
                    Datum.Add('status', Format(TheSTOAccounts.Status));
                    Datum.Add('available_balance', GlobalFunctions.GetSavingsAccountAvailableBalance(TheSTOAccounts, false));

                    Data.Add(Datum);
                end until TheSTOAccounts.Next = 0;
            end;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'STO source accounts list has been fetched successfully');
            ResponseObject.Add('data', Data);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
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

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'STO income types list has been fetched successfully');
            ResponseObject.Add('data', Data);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
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
        // NoSeriesMgt: Codeunit NoSeriesManagement;
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
            TheSTORequest."No." := NoSeriesMgt.GetNextNo(SeriesSetup."Standing Order Nos.");
            // NoSeriesMgt.InitSeries(SeriesSetup."Standing Order Nos.", '', 0D, TheSTORequest."No.", TheSTORequest."No. Series");

            TheSTORequest."Source Account Type" := TheSTORequest."Source Account Type"::Savings;

            TheMemberFosaAccount.Reset;
            TheMemberFosaAccount.SetRange("Product Category", TheMemberFosaAccount."Product Category"::"FOSA Account");
            TheMemberFosaAccount.SetRange("Member No.", SearchMember."No.");

            if TheMemberFosaAccount.FindFirst then begin
                TheSTORequest."Source Account No." := TheMemberFosaAccount."No.";
                TheSTORequest.Validate("Source Account No.");
            end else begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', 'FOSA source account cannot be found!');
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            TheSTORequest.Description := description.AsValue.AsText;
            TheSTORequest.Amount := amount.AsValue.AsDecimal;

            case income_type.AsValue.AsText of
                'SALARY':
                    TheSTORequest."Income Type" := TheSTORequest."Income Type"::Salary;
                'PERIODIC':
                    TheSTORequest."Income Type" := TheSTORequest."Income Type"::Periodic;
                'PENSION':
                    TheSTORequest."Income Type" := TheSTORequest."Income Type"::Pension;
                else
                    TheSTORequest."Income Type" := TheSTORequest."Income Type"::Salary;
            end;

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
            TheSTORequest."Source Application" := TheSTORequest."Source Application"::"Member Portal";

            if TheSTORequest.Insert(true) then begin

                TheSTORequest."Standing Order Type" := TheSTORequest."Standing Order Type"::Internal;
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
                            ResponseObject.Add('status', 'ERROR');
                            ResponseObject.Add('status_description', StrSubstNo('Destination loan account %1 NOT found', destination_account_no.AsValue.AsText));
                            AddDateTimeToResponse(ResponseObject);
                            ResponseObject.WriteTo(Response);
                            exit(Response);
                        end;
                    end;

                    TheSTOLines.Amount := destination_amount.AsValue.AsDecimal;
                    TheSTOLines.Validate(Amount);

                    TheSTOLines."Member No" := TheSTORequest."Member No.";

                    TheSTOLines.Insert(true);
                    Clear(TheSTOLines);
                end;

                Datum.Add('application_no', TheSTORequest."No.");

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'STO application request is successful');
                ResponseObject.Add('data', Datum);
            end else begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', GetLastErrorText(true));
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
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
        TheSTOLines: Record "Standing Order Lines";
        TheMemberFosaAccount: Record "Savings Accounts";
        TheMemberLoanAccount: Record "Credit Accounts";
        TheMemberLoan: Record Loans;

        Destinations: JsonArray;
        Destination: JsonObject;

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
            TheSTORequests.SetFilter(Status, '<>%1', TheSTORequests.Status::Rejected);
            // TheSTORequests.SetFilter(Status, '=%1|%2', TheSTORequests.Status::Open, TheSTORequests.Status::Pending);
            // TheSTORequests.SetFilter("Source Application", '=%1|%2', TheSTORequests."Source Application"::"Member Portal", TheSTORequests."Source Application"::"Mobile Banking");

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

                    Data.Add(Datum);

                    Clear(Destinations);
                end until TheSTORequests.Next = 0;
            end;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'STO application request list has been fetched successfully');
            ResponseObject.Add('data', Data);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
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
            // TheSTORequests.SetFilter(Status, '=%1|%2', TheSTORequests.Status::Open, TheSTORequests.Status::Pending);
            // TheSTORequests.SetFilter("Source Application", '=%1|%2', TheSTORequests."Source Application"::"Member Portal", TheSTORequests."Source Application"::"Mobile Banking");

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
            end else begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', StrSubstNo('STO application request %1 NOT found', application_no.AsValue.AsText));
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'STO application request has been fetched successfully');
            ResponseObject.Add('data', Datum);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
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
                // TheSTOLines.Reset;

                // TheSTOLines.SetRange("Document No.", TheSTORequests."No.");
                // if TheSTOLines.FindSet then begin
                //     repeat begin
                //         TheSTOLines.Delete(true);
                //     end until TheSTOLines.Next = 0;
                // end;

                TheSTORequests.Status := TheSTORequests.Status::Cancelled;
                if TheSTORequests.Modify(true) then begin
                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'STO application request has been cancelled successfully');
                end else begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', GetLastErrorText(true));
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end else begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'The STO application ' + application_no.AsValue.AsText + ' is NOT available for cancellation');
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    // Store Requisitions
    local procedure GetStoreRequisitionItems(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        TheAvailableItems: record Item;

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

            if not IsMemberAStaff(SearchMember) then begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' is not a staff employee!');
            end else begin

                TheAvailableItems.Reset;
                TheAvailableItems.SetFilter(Inventory, '>0');
                TheAvailableItems.SetAutoCalcFields(
                    Inventory
                );

                if TheAvailableItems.FindSet then begin
                    repeat begin
                        Clear(Datum);

                        Datum.Add('item_no', TheAvailableItems."No.");
                        Datum.Add('item_description', TheAvailableItems.Description);
                        Datum.Add('inventory', TheAvailableItems.Inventory);
                        Datum.Add('unit_of_measure', TheAvailableItems."Base Unit of Measure");
                        Datum.Add('unit_price', TheAvailableItems."Unit Price");
                        Datum.Add('unit_cost', TheAvailableItems."Unit Cost");

                        Data.Add(Datum);
                    end until TheAvailableItems.Next = 0;
                end;

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Store Items list has been fetched successfully');
                ResponseObject.Add('data', Data);

            end;

        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CreateStoreRequisitionRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        description_of_request: JsonToken;
        reason_of_request: JsonToken;
        required_date: JsonToken;

        requisition_items: JsonToken;
        requisition_item: JsonToken;
        requisition_item_code: JsonToken;
        requisition_item_remarks: JsonToken;
        requisition_item_quantity: JsonToken;

        SearchMember: record Members;
        TheStoreRequisition: record "Store Requistion Header";
        GenLedgerSetup: record "Purchases & Payables Setup";
        Employee: record "HR Employees";
        TheStoreRequisitionLine: Record "Store Requistion Lines";

        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
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
        Payload.Get('description_of_request', description_of_request);
        Payload.Get('reason_of_request', reason_of_request);
        Payload.Get('required_date', required_date);
        Payload.Get('requisition_items', requisition_items);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin

            if not IsMemberAStaff(SearchMember) then begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' is not a staff employee!');
            end else begin
                Employee.Reset;
                Employee.SetRange("Member No.", SearchMember."No.");
                Employee.FindFirst;

                TheStoreRequisition.Init;

                TheStoreRequisition."Source of Application" := TheStoreRequisition."Source of Application"::"Staff Portal";

                GenLedgerSetup.Get;
                GenLedgerSetup.TestField("Stores Requisition No");
                TheStoreRequisition."No." := NoSeriesMgt.GetNextNo(GenLedgerSetup."Stores Requisition No");
                // NoSeriesMgt.InitSeries(GenLedgerSetup."Stores Requisition No", '', 0D, TheStoreRequisition."No.", TheStoreRequisition."No. Series");

                TheStoreRequisition."Request date" := Today;
                TheStoreRequisition.Validate("Request date");

                TheStoreRequisition."Function Name" := description_of_request.AsValue.AsText;
                TheStoreRequisition."Request Description" := reason_of_request.AsValue.AsText;
                TheStoreRequisition."Required Date" := required_date.AsValue.AsDate;

                TheStoreRequisition."Issuing Store" := '143';
                TheStoreRequisition.Status := TheStoreRequisition.Status::Open;
                TheStoreRequisition."User ID" := Employee."User ID";

                if TheStoreRequisition.Insert(true) then begin
                    TheStoreRequisition."Employee No." := Employee."No.";
                    TheStoreRequisition."User ID" := Employee."User ID";
                    TheStoreRequisition."Responsibility Center" := Employee."Responsibility Center";
                    TheStoreRequisition."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    TheStoreRequisition."Shortcut Dimension 2 Code" := Employee."Global Dimension 2 Code";

                    TheStoreRequisition.Modify;

                    foreach requisition_item in requisition_items.AsArray do begin
                        requisition_item.AsObject.Get('item_code', requisition_item_code);
                        requisition_item.AsObject.Get('item_quantity', requisition_item_quantity);
                        requisition_item.AsObject.Get('item_remarks', requisition_item_remarks);

                        Clear(TheStoreRequisitionLine);
                        TheStoreRequisitionLine.Init;

                        TheStoreRequisitionLine.Type := TheStoreRequisitionLine.Type::Item;
                        TheStoreRequisitionLine."Requistion No" := TheStoreRequisition."No.";

                        TheStoreRequisitionLine."No." := requisition_item_code.AsValue.AsText;
                        TheStoreRequisitionLine.Validate("No.");

                        TheStoreRequisitionLine."Quantity Requested" := requisition_item_quantity.AsValue.AsDecimal;
                        TheStoreRequisitionLine.Validate("Quantity Requested");

                        TheStoreRequisitionLine."Description 2" := requisition_item_remarks.AsValue.AsText;

                        TheStoreRequisitionLine.Insert(true);
                        // Commit;
                    end;

                    Datum.Add('application_no', TheStoreRequisition."No.");

                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Store requisition request is successful');
                    ResponseObject.Add('data', Datum);
                end else begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', GetLastErrorText(true));
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;

            end;

        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetStoreRequisitionRequests(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        TheStoreRequisitions: record "Store Requistion Header";
        Employee: record "HR Employees";

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

            if not IsMemberAStaff(SearchMember) then begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' is not a staff employee!');
            end else begin
                Employee.Reset;
                Employee.SetRange("Member No.", SearchMember."No.");
                Employee.FindFirst;

                TheStoreRequisitions.Reset;
                TheStoreRequisitions.SetRange("Employee No.", Employee."No.");
                TheStoreRequisitions.SetFilter(Status, '=%1', TheStoreRequisitions.Status::Open, TheStoreRequisitions.Status::"Pending Approval");
                TheStoreRequisitions.SetFilter("Source of Application", '=%1', TheStoreRequisitions."Source of Application"::"Staff Portal");

                TheStoreRequisitions.SetAutoCalcFields(
                    TotalAmount
                );

                if TheStoreRequisitions.FindSet then begin
                    repeat begin
                        Clear(Datum);

                        Datum.Add('application_no', TheStoreRequisitions."No.");
                        Datum.Add('request_date', GlobalFunctions.FormatISODate(TheStoreRequisitions."Request date"));
                        Datum.Add('required_date', GlobalFunctions.FormatISODate(TheStoreRequisitions."Required date"));
                        Datum.Add('description_of_request', TheStoreRequisitions."Function Name");
                        Datum.Add('reason_of_request', TheStoreRequisitions."Request Description");
                        Datum.Add('status', Format(TheStoreRequisitions.Status));
                        Datum.Add('amount', TheStoreRequisitions.TotalAmount);
                        Datum.Add('issuing_store', TheStoreRequisitions."Issuing Store");

                        Data.Add(Datum);
                    end until TheStoreRequisitions.Next = 0;
                end;

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Store requisition request list has been fetched successfully');
                ResponseObject.Add('data', Data);
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetStoreRequisitionRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;

        SearchMember: Record Members;
        TheStoreRequisition: record "Store Requistion Header";
        Employee: record "HR Employees";
        TheStoreRequisitionLine: Record "Store Requistion Lines";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        RequisitionItems: JsonArray;
        RequisitionItem: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('application_no', application_no);

        SearchMember.Reset;
        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin

            if not IsMemberAStaff(SearchMember) then begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' is not a staff employee!');
            end else begin
                Employee.Reset;
                Employee.SetRange("Member No.", SearchMember."No.");
                Employee.FindFirst;

                TheStoreRequisition.Reset;

                TheStoreRequisition.SetRange("No.", application_no.AsValue.AsText);
                TheStoreRequisition.SetRange("Employee No.", Employee."No.");
                TheStoreRequisition.SetFilter(Status, '=%1|%2', TheStoreRequisition.Status::Open, TheStoreRequisition.Status::"Pending Approval");
                TheStoreRequisition.SetFilter("Source of Application", '=%1', TheStoreRequisition."Source of Application"::"Staff Portal");

                TheStoreRequisition.SetAutoCalcFields(
                    TotalAmount
                );

                if TheStoreRequisition.FindFirst then begin
                    Datum.Add('application_no', TheStoreRequisition."No.");
                    Datum.Add('request_date', GlobalFunctions.FormatISODate(TheStoreRequisition."Request date"));
                    Datum.Add('required_date', GlobalFunctions.FormatISODate(TheStoreRequisition."Required date"));
                    Datum.Add('description_of_request', TheStoreRequisition."Function Name");
                    Datum.Add('reason_of_request', TheStoreRequisition."Request Description");
                    Datum.Add('status', Format(TheStoreRequisition.Status));
                    Datum.Add('amount', TheStoreRequisition.TotalAmount);
                    Datum.Add('issuing_store', TheStoreRequisition."Issuing Store");

                    TheStoreRequisitionLine.Reset;
                    TheStoreRequisitionLine.SetRange("Requistion No", TheStoreRequisition."No.");

                    if TheStoreRequisitionLine.FindSet then begin
                        repeat begin
                            Clear(RequisitionItem);

                            RequisitionItem.Add('item_code', TheStoreRequisitionLine."No.");
                            RequisitionItem.Add('item_description', TheStoreRequisitionLine.Description);
                            RequisitionItem.Add('item_type', Format(TheStoreRequisitionLine.Type));
                            RequisitionItem.Add('item_quantity', TheStoreRequisitionLine."Quantity Requested");
                            RequisitionItem.Add('item_remarks', TheStoreRequisitionLine."Description 2");
                            RequisitionItem.Add('item_unit_of_measure', TheStoreRequisitionLine."Unit of Measure");
                            RequisitionItem.Add('item_unit_cost', TheStoreRequisitionLine."Unit Cost");
                            RequisitionItem.Add('item_line_amount', TheStoreRequisitionLine."Line Amount");

                            RequisitionItems.Add(RequisitionItem);
                        end until TheStoreRequisitionLine.Next = 0;
                    end;

                    Datum.Add('requisition_items', RequisitionItem);
                end else begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', StrSubstNo('Store requisition request %1 NOT found', application_no.AsValue.AsText));
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end;
            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Store requisition request has been fetched successfully');
            ResponseObject.Add('data', Datum);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CancelStoreRequisitionRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        application_no: JsonToken;

        SearchMember: Record Members;
        TheStoreRequisition: record "Store Requistion Header";
        TheStoreRequisitionLine: Record "Store Requistion Lines";

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

            if not IsMemberAStaff(SearchMember) then begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' is not a staff employee!');
            end else begin
                TheStoreRequisition.Reset;

                TheStoreRequisition.SetRange("No.", application_no.AsValue.AsText);
                TheStoreRequisition.SetRange(Status, TheStoreRequisition.Status::Open);

                if TheStoreRequisition.FindFirst then begin
                    // TheSTOLines.Reset;

                    // TheSTOLines.SetRange("Document No.", TheSTORequests."No.");
                    // if TheSTOLines.FindSet then begin
                    //     repeat begin
                    //         TheSTOLines.Delete(true);
                    //     end until TheSTOLines.Next = 0;
                    // end;

                    TheStoreRequisition.Status := TheStoreRequisition.Status::Cancelled;
                    if TheStoreRequisition.Modify(true) then begin
                        ResponseObject.Add('status', 'SUCCESS');
                        ResponseObject.Add('status_description', 'Store requisition application request has been cancelled successfully');
                    end else begin
                        ResponseObject.Add('status', 'ERROR');
                        ResponseObject.Add('status_description', GetLastErrorText(true));
                        AddDateTimeToResponse(ResponseObject);
                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
                end else begin
                    ResponseObject.Add('status', 'NOT_FOUND');
                    ResponseObject.Add('status_description', 'The Store requisition application ' + application_no.AsValue.AsText + ' is NOT available for cancellation');
                end;
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure LoanCalculator(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        loan_product: JsonToken;
        requested_amount: JsonToken;
        basic_salary: JsonToken;
        total_earnings: JsonToken;
        total_deductions: JsonToken;
        net_salary: JsonToken;
        installments: JsonToken;
        top_ups: JsonToken;

        loan_top_up: JsonToken;

        SearchMember: Record Members;

        ProductFactory: Record "Product Factory";
        DisposableIncome: Decimal;
        Thirdbasic: Decimal;
        SavingsAcc: Record "Savings Accounts";
        MemberDeposits: Decimal;
        LoansREc: record Loans;
        SavAcc: record "Savings Accounts";
        TariffDetails: Record "Tiered Charges Lines";
        SelfGuaranteedBal: Decimal;
        LoansTopup: Record "Loans Top up";
        LoansTopupTmp: Record "Loans Top up" temporary;
        offseBa: Boolean;
        RelatedProduct: Record "Related Product";
        ProductsToBridge: Record "Loan Products to Bridge";
        MultP: Integer;
        TheLoan: record loans;
        // RelatedBal: Decimal;
        // CurrLoanBal: Decimal;
        OffsetBalance: Decimal;
        Deposit_Multiplier: Decimal;
        // SalaryQualification: Decimal;
        DepositQualification: Decimal;
        EligibleAmount: Decimal;
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Integer;
        TotalMRepay: decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        TotalComputedCharges: Decimal;
        ChargeExtraComms: Boolean;
        TotalCleared: Decimal;
        PCharges: Record "Loan Product Charges";
        TotalMonthlyRepayment: Decimal;

        TotalLoansCount: Integer;
        TotalTopUpCount: Integer;

        SalAvg: decimal;
        SalaryAmount: decimal;
        Incomsal: Enum "Salary Income Types";
        SalaryAccount: record "Savings Accounts";
        FosaAccount: Text;
        SalaryLines: Record "Salary Lines";
        STOAmount: decimal;
        LoanRec: decimal;

        // LoansProcess: Codeunit "Loans Process";
        NetTakeHome: Decimal;
        EstMonthlyRepayment: Decimal;
        KeyExists: Boolean;

        RSchedule: Record "Loan Repayment Schedule-Calc" temporary;
        // TotalMonthlyLoanDeductions: Decimal;

        repayment_schedule: JsonArray;
        repayment: JsonObject;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('loan_product', loan_product);
        Payload.Get('requested_amount', requested_amount);
        Payload.Get('installments', installments);
        Payload.Get('basic_salary', basic_salary);
        Payload.Get('total_earnings', total_earnings);
        Payload.Get('total_deductions', total_deductions);
        Payload.Get('top_ups', top_ups);
        KeyExists := Payload.Get('net_salary', net_salary);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            if not ProductFactory.Get(loan_product.AsValue.AsText) then begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', StrSubstNo('Unknown loan product = %1', loan_product.AsValue.AsText));
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // Temporary Loans to be cleared
            foreach loan_top_up in top_ups.AsArray do begin
                if TheLoan.Get(loan_top_up.AsValue.AsText) then begin
                    ProductsToBridge.Reset;
                    ProductsToBridge.SetRange("Product Code", ProductFactory."Product ID");
                    ProductsToBridge.SetRange("Product To Bridge", TheLoan."Loan Product Type");
                    if not ProductsToBridge.FindFirst then begin
                        ResponseObject.Add('status', 'ERROR');
                        ResponseObject.Add('status_description',
                            StrSubstNo('Loan no %1 (%2) is not eligible for top up using loan %3',
                            TheLoan."Loan No.",
                            TheLoan."Loan Product Type Name",
                            ProductFactory."Product Description")
                        );
                        AddDateTimeToResponse(ResponseObject);
                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;

                    LoansTopupTmp.Init;

                    LoansTopupTmp."Loan No." := '';
                    LoansTopupTmp."Client Code" := SearchMember."No.";
                    LoansTopupTmp."Loan Top Up" := loan_top_up.AsValue.AsText;

                    TheLoan.CalcFields(
                        "Outstanding Balance"
                    );
                    LoansTopupTmp."Outstanding Balance" := TheLoan."Outstanding Balance";
                    LoansTopupTmp."Loan Type" := TheLoan."Loan Product Type";
                    LoansTopupTmp."Loan Product Type Name" := TheLoan."Loan Product Type Name";

                    LoansTopupTmp.Validate("Loan Top Up");
                    LoansTopupTmp.Validate("Principle Top Up");
                    LoansTopupTmp.Validate("Interest Top Up");

                    LoansTopupTmp.Insert;
                end;
            end;
            TotalTopUpCount := top_ups.AsArray.Count;

            EligibleAmount := requested_amount.AsValue.AsDecimal;
            offseBa := false;

            // LoansREc.Reset;
            // LoansREc.SetRange(LoansREc."Member No.", SearchMember."No.");
            // LoansREc.SetRange(LoansREc.Posted, true);
            // LoansREc.SetFilter("Outstanding Balance", '>0');
            // LoansREc.SetLoadFields("Outstanding Balance");
            // LoansREc.SetAutoCalcFields("Outstanding Balance");
            // if LoansREc.FindSet then begin
            //     TotalLoansCount := LoansREc.Count;
            //     repeat
            //         if HighestLoanAmount < LoansREc."Outstanding Balance" then begin
            //             HighestLoanAmount := LoansREc."Outstanding Balance";
            //         end;
            //     until LoansREc.Next = 0;
            // end;

            DisposableIncome := 0;
            Thirdbasic := 0;
            SavingsAcc.Reset();
            SavingsAcc.SetRange("Member No.", SearchMember."No.");
            SavingsAcc.SetRange("Product Category", SavingsAcc."Product Category"::"BOSA Deposits");
            SavingsAcc.SetLoadFields("Balance (LCY)");
            if SavingsAcc.FindFirst then begin
                SavingsAcc.CalcFields(SavingsAcc."Balance (LCY)");
                MemberDeposits := SavingsAcc."Balance (LCY)";
            end;

            if KeyExists then begin
                DisposableIncome := net_salary.AsValue.AsDecimal;
            end else begin
                // Check if SACCO processes salary
                SalAvg := 0;
                SalaryAmount := 0;
                FosaAccount := SkyMbankingTrans.GetMemberFosaAcc(SearchMember);

                SalaryAccount.Reset;
                SalaryAccount.SetRange("No.", FosaAccount);
                if SalaryAccount.FindFirst then begin
                    if SearchMember."Employer Code" = 'RETIREE' then begin
                        SalAvg := GlobalFunctions.GetSmallestSalary(SalaryAccount."No.", Incomsal::Pension);
                    end else begin
                        SalAvg := GlobalFunctions.GetSmallestSalary(SalaryAccount."No.", Incomsal::Salary);
                    end;

                    STOAmount := SkyMbankingTrans.ComputeSTODeductions(SalaryAccount."No.");
                    LoanRec := SkyMbankingTrans.ComputeLoanDeductions(SalaryAccount."Member No.");

                    IF (SalaryAccount.Status <> SalaryAccount.Status::Active) OR (SalaryAccount.Blocked <> SalaryAccount.Blocked::" ") THEN BEGIN
                        SalaryAmount := 0;
                    END else begin
                        //Get last salary amount
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("Member No.", SalaryAccount."Member No.");
                        SalaryLines.SETRANGE(Posted, TRUE);

                        if format(ProductFactory."Salary Period") <> '' then begin
                            SalaryLines.SETRANGE("Posting Date", CALCDATE(('-' + format(ProductFactory."Salary Period")), TODAY), TODAY);
                        end;

                        SalaryLines.SetLoadFields(Amount);
                        IF SalaryLines.FINDLAST THEN BEGIN
                            SalaryAmount := SalaryLines.Amount - (STOAmount + LoanRec);
                        END;
                        SalAvg := SalAvg - (STOAmount + LoanRec);
                        IF SalaryAmount > SalAvg THEN
                            SalaryAmount := SalAvg;
                    end;
                end else begin
                    SalaryAmount := 0;
                end;

                if SalaryAmount <= 0 then begin
                    Thirdbasic := (1 / 3) * basic_salary.AsValue.AsDecimal;
                    DisposableIncome := ((basic_salary.AsValue.AsDecimal + total_earnings.AsValue.AsDecimal) - (total_deductions.AsValue.AsDecimal + Thirdbasic));
                end else begin
                    Thirdbasic := (1 / 3) * basic_salary.AsValue.AsDecimal;
                    DisposableIncome := SalaryAmount;
                end;
            end;

            LoansREc.Reset;
            LoansREc.SetRange(LoansREc."Member No.", SearchMember."No.");
            LoansREc.SetRange(LoansREc.Posted, true);
            LoansREc.SetFilter("Outstanding Balance", '>0');
            LoansREc.SetRange("Source Unit", LoansREc."Source Unit"::BOSA);
            LoansREc.SetLoadFields("Outstanding Balance");
            if LoansREc.FindSet then begin
                repeat
                    LoansREc.CalcFields(LoansREc."Outstanding Balance");
                    SelfGuaranteedBal += LoansREc."Outstanding Balance";
                until LoansREc.Next = 0;
            end;

            ProductsToBridge.Reset;
            ProductsToBridge.SetRange("Product Code", ProductFactory."Product ID");
            if ProductsToBridge.FindSet then begin
                repeat
                    //Topped up loans related product
                    foreach loan_top_up in top_ups.AsArray do begin
                        LoansTopupTmp.Reset;
                        LoansTopupTmp.SetRange("Client Code", SearchMember."No.");
                        LoansTopupTmp.SetRange("Loan Type", ProductsToBridge."Product To Bridge");
                        LoansTopupTmp.SetRange("Loan Top Up", loan_top_up.AsValue.AsText);
                        if LoansTopupTmp.FindSet then begin
                            repeat
                                TotalMonthlyRepayment += LoansTopupTmp."Monthly Repayment";
                                OffsetBalance += LoansTopupTmp."Outstanding Balance";
                            until LoansTopupTmp.Next = 0;

                            offseBa := true;
                        end;
                    end;
                until RelatedProduct.Next = 0;
            end;

            // foreach loan_top_up in top_ups.AsArray do begin
            //     LoansTopupTmp.Reset;
            //     LoansTopupTmp.SetRange("Client Code", SearchMember."No.");
            //     // LoansTopupTmp.SetRange("Loan Type", RelatedProduct."Related Product Code");
            //     LoansTopupTmp.SetRange("Loan Top Up", loan_top_up.AsValue.AsText);
            //     if LoansTopupTmp.FindSet then begin
            //         repeat
            //             TotalMonthlyRepayment += LoansTopupTmp."Monthly Repayment";
            //             OffsetBalance += LoansTopupTmp."Outstanding Balance";
            //         until LoansTopupTmp.Next = 0;

            //         offseBa := true;
            //     end;
            // end;

            if (TotalTopUpCount = TotalLoansCount) OR (TotalLoansCount = 0) then begin
                // Ordinary Deposit Multiplier -  Top Up All Loan & Fresh Loan
                Deposit_Multiplier := (MemberDeposits + 0) * ProductFactory."Ordinary Deposits Multiplier";
            end else begin
                // Subsequent Deposit Multiplier - Running Loans & Top Up Partial Loan
                Deposit_Multiplier := (MemberDeposits + 0) * ProductFactory."Subsequent Multiplier";
            end;

            if ProductFactory."Source Unit" = ProductFactory."Source Unit"::"HR LOANS" then
                DepositQualification := ProductFactory."Staff Salary Multiplier" * MemberDeposits
            else
                DepositQualification := Deposit_Multiplier;


            if offseBa = true then
                DepositQualification := (Deposit_Multiplier - SelfGuaranteedBal) + OffsetBalance
            else
                DepositQualification := DepositQualification - SelfGuaranteedBal;

            // if DepositQualification < 0 then begin
            //     DepositQualification := 0;
            // end;

            DisposableIncome += TotalMonthlyRepayment;

            // Salary Qualification
            // if ProductFactory."Source Unit" = ProductFactory."Source Unit"::"HR LOANS" then begin
            //     SalaryQualification := DisposableIncome * ProductFactory."Staff Salary Multiplier"
            // end else begin
            //     if requested_amount.AsValue.AsDecimal < HighestLoanAmount then begin

            //         if ProductFactory."Loan Exclusive Factor" <> '' then begin
            //             SavAcc.Reset;
            //             SavAcc.SetRange("Member No.", SearchMember."No.");
            //             SavAcc.SetRange("Product Category", SavAcc."Product Category"::"BOSA Deposits");
            //             if SavAcc.Find('-') then begin
            //                 SavAcc.CalcFields(Balance);
            //                 TariffDetails.Reset;
            //                 TariffDetails.SetRange(TariffDetails.Code, ProductFactory."Loan Exclusive Factor");
            //                 if TariffDetails.FindSet then begin
            //                     repeat
            //                         if (SavAcc.Balance >= TariffDetails."Lower Limit") and (SavAcc.Balance <= TariffDetails."Upper Limit") then begin
            //                             if TariffDetails."Use Percentage" = true then begin
            //                                 SalaryQualification := DisposableIncome * TariffDetails.Percentage * 0.01;
            //                                 break;
            //                             end else begin
            //                                 SalaryQualification := TariffDetails."Charge Amount" * DisposableIncome;
            //                                 break;
            //                             end;
            //                         end;
            //                     until TariffDetails.Next = 0;
            //                 end;
            //             end;
            //         end;

            //     end else begin

            //         if ProductFactory."Loan Prorata Factor" <> '' then begin
            //             SavAcc.Reset;
            //             SavAcc.SetRange("Member No.", SearchMember."No.");
            //             SavAcc.SetRange("Product Category", SavAcc."Product Category"::"BOSA Deposits");
            //             if SavAcc.Find('-') then begin
            //                 SavAcc.CalcFields(Balance);
            //                 TariffDetails.Reset;
            //                 TariffDetails.SetRange(TariffDetails.Code, ProductFactory."Loan Prorata Factor");
            //                 if TariffDetails.FindSet then begin
            //                     repeat
            //                         if (SavAcc.Balance >= TariffDetails."Lower Limit") and (SavAcc.Balance <= TariffDetails."Upper Limit") then begin
            //                             if TariffDetails."Use Percentage" = true then begin
            //                                 SalaryQualification := DisposableIncome * TariffDetails.Percentage * 0.01;
            //                                 break;
            //                             end else begin
            //                                 SalaryQualification := TariffDetails."Charge Amount" * DisposableIncome;
            //                                 break;
            //                             end;
            //                         end;
            //                     until TariffDetails.Next = 0;
            //                 end;
            //             end;
            //         end;

            //     end;
            // end;

            // if SalaryQualification < DepositQualification then
            //     EligibleAmount := SalaryQualification
            // else

            EligibleAmount := DepositQualification;

            if requested_amount.AsValue.AsDecimal < EligibleAmount then
                EligibleAmount := requested_amount.AsValue.AsDecimal;

            // Compute Net Take Home
            ProductsToBridge.Reset;
            ProductsToBridge.SetRange("Product Code", ProductFactory."Product ID");
            if ProductsToBridge.FindSet then begin
                repeat
                    foreach loan_top_up in top_ups.AsArray do begin
                        LoansTopupTmp.Reset;
                        LoansTopupTmp.SetRange("Client Code", SearchMember."No.");
                        LoansTopupTmp.SetRange("Loan Type", ProductsToBridge."Product To Bridge");
                        LoansTopupTmp.SetRange("Loan Top Up", loan_top_up.AsValue.AsText);
                        if LoansTopupTmp.FindSet then begin
                            repeat
                                if LoansTopupTmp."Additional Top Up Commission" = true then
                                    ChargeExtraComms := true;

                                TotalCleared := TotalCleared + LoansTopupTmp."Principle Top Up" + LoansTopupTmp."Interest Top Up";

                                PCharges.Reset;
                                PCharges.SetRange(PCharges."Product Code", loan_product.AsValue.AsText);
                                PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Top up");
                                if PCharges.FindSet then begin
                                    repeat

                                        if (PCharges."Use Percentage" = true) and (PCharges."Charging Option" = PCharges."charging option"::"On Approved Amount") then begin
                                            if ChargeExtraComms = true then
                                                TotalComputedCharges := TotalComputedCharges + (EligibleAmount * ((PCharges.Percentage + PCharges."Additional Charge %") / 100))
                                            else
                                                TotalComputedCharges := TotalComputedCharges + (EligibleAmount * (PCharges.Percentage / 100))
                                        end else
                                            if (PCharges."Use Percentage" = true) and (PCharges."Charging Option" = PCharges."charging option"::"On Net Amount") then begin
                                                if ChargeExtraComms = true then
                                                    TotalComputedCharges := TotalComputedCharges + ((LoansTopupTmp."Principle Top Up" + LoansTopupTmp."Interest Top Up") * ((PCharges.Percentage + PCharges."Additional Charge %") / 100))
                                                else
                                                    TotalComputedCharges := TotalComputedCharges + ((LoansTopupTmp."Principle Top Up" + LoansTopupTmp."Interest Top Up") * (PCharges.Percentage / 100))
                                            end else
                                                TotalComputedCharges := TotalComputedCharges + PCharges."Charge Amount";
                                    until PCharges.Next = 0;
                                end;
                            until LoansTopupTmp.Next = 0;
                        end;
                    end;
                until RelatedProduct.Next = 0;
            end;

            // foreach loan_top_up in top_ups.AsArray do begin
            //     LoansTopupTmp.Reset;
            //     LoansTopupTmp.SetRange("Client Code", SearchMember."No.");
            //     // LoansTopupTmp.SetRange("Loan Type", RelatedProduct."Related Product Code");
            //     LoansTopupTmp.SetRange("Loan Top Up", loan_top_up.AsValue.AsText);
            //     if LoansTopupTmp.FindSet then begin
            //         repeat
            //             if LoansTopupTmp."Additional Top Up Commission" = true then
            //                 ChargeExtraComms := true;

            //             TotalCleared := TotalCleared + LoansTopupTmp."Principle Top Up" + LoansTopupTmp."Interest Top Up";

            //             PCharges.Reset;
            //             PCharges.SetRange(PCharges."Product Code", loan_product.AsValue.AsText);
            //             PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Top up");
            //             if PCharges.FindSet then begin
            //                 repeat

            //                     if (PCharges."Use Percentage" = true) and (PCharges."Charging Option" = PCharges."charging option"::"On Approved Amount") then begin
            //                         if ChargeExtraComms = true then
            //                             TotalComputedCharges := TotalComputedCharges + (EligibleAmount * ((PCharges.Percentage + PCharges."Additional Charge %") / 100))
            //                         else
            //                             TotalComputedCharges := TotalComputedCharges + (EligibleAmount * (PCharges.Percentage / 100))
            //                     end else
            //                         if (PCharges."Use Percentage" = true) and (PCharges."Charging Option" = PCharges."charging option"::"On Net Amount") then begin
            //                             if ChargeExtraComms = true then
            //                                 TotalComputedCharges := TotalComputedCharges + ((LoansTopupTmp."Principle Top Up" + LoansTopupTmp."Interest Top Up") * ((PCharges.Percentage + PCharges."Additional Charge %") / 100))
            //                             else
            //                                 TotalComputedCharges := TotalComputedCharges + ((LoansTopupTmp."Principle Top Up" + LoansTopupTmp."Interest Top Up") * (PCharges.Percentage / 100))
            //                         end else
            //                             TotalComputedCharges := TotalComputedCharges + PCharges."Charge Amount";
            //                 until PCharges.Next = 0;
            //             end;
            //         until LoansTopupTmp.Next = 0;
            //     end;
            // end;

            // General Charges
            PCharges.Reset;
            PCharges.SetRange(PCharges."Product Code", loan_product.AsValue.AsText);
            PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::General);
            if PCharges.FindSet then begin
                repeat
                    if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                        TotalComputedCharges += (EligibleAmount * PCharges.Percentage / 100)
                    else
                        if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                            TotalComputedCharges += PCharges."Charge Amount"
                        else
                            if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin

                                PCharges.TestField(PCharges."Staggered Charge Code");

                                TariffDetails.Reset;
                                TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                if TariffDetails.FindSet then begin
                                    repeat
                                        if (EligibleAmount >= TariffDetails."Lower Limit") and (EligibleAmount <= TariffDetails."Upper Limit") then begin
                                            if TariffDetails."Use Percentage" = true then begin
                                                TotalComputedCharges += (EligibleAmount * TariffDetails.Percentage * 0.01);
                                            end else begin
                                                TotalComputedCharges += TariffDetails."Charge Amount";
                                            end;
                                        end;
                                    until TariffDetails.Next = 0;
                                end;
                            end;
                until PCharges.Next = 0;
            end;

            if ProductFactory."Maximum Loan Amount" > 0 then begin
                if EligibleAmount > ProductFactory."Maximum Loan Amount" then begin
                    EligibleAmount := ProductFactory."Maximum Loan Amount";
                end;
            end;

            NetTakeHome := EligibleAmount - (TotalCleared + TotalComputedCharges);

            if NetTakeHome <= 0 then begin
                EligibleAmount := 0;
            end;

            // Repayment Schedule
            if EligibleAmount > 0 then begin
                LoanAmount := EligibleAmount;//"Approved Amount";
                InterestRate := ProductFactory."Interest Rate (Min.)";
                RepayPeriod := installments.AsValue.AsInteger;
                InitialInstal := installments.AsValue.AsInteger;
                LBalance := EligibleAmount;//"Approved Amount";
                RunDate := CalcDate('1M', Today);

                InstalNo := 0;
                //Repayment Frequency
                repeat
                    InstalNo := InstalNo + 1;
                    //kma
                    if InterestRate = 0 then ProductFactory."Interest Calculation Method" := ProductFactory."Interest Calculation Method"::"Straight Line";

                    if ProductFactory."Interest Calculation Method" = ProductFactory."Interest Calculation Method"::Amortised then begin
                        TotalMRepay := Round((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                        LInterest := Round(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                        LPrincipal := TotalMRepay - LInterest;
                    end;

                    if ProductFactory."Interest Calculation Method" = ProductFactory."Interest Calculation Method"::"Straight Line" then begin
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LoanAmount;
                    end;

                    if ProductFactory."Interest Calculation Method" = ProductFactory."Interest Calculation Method"::"Reducing Balance" then begin
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LBalance;
                    end;

                    if ProductFactory."Interest Calculation Method" = ProductFactory."Interest Calculation Method"::"Reducing Flat" then begin
                        LPrincipal := Round(LoanAmount / RepayPeriod, 1.0, '>');
                        LInterest := Round(((LoanAmount * InterestRate / 12 / 100) + (LPrincipal * InterestRate / 12 / 100)) / 2, 1.0, '>');
                        // LoansR.Repayment := LPrincipal + LInterest;
                    end;

                    LBalance := LBalance - LPrincipal;

                    Clear(repayment);

                    repayment.Add('installment_no', InstalNo);
                    repayment.Add('repayment_date', GlobalFunctions.FormatISODate(RunDate));
                    repayment.Add('loan_product', ProductFactory."Product Description");
                    repayment.Add('monthly_repayment', ROUND(LInterest + LPrincipal, 0.01, '>'));
                    repayment.Add('monthly_interest', ROUND(LInterest, 0.01, '>'));
                    repayment.Add('monthly_principal', ROUND(LPrincipal, 0.01, '>'));
                    if LBalance < 0 then begin
                        repayment.Add('loan_balance', 0);
                    end else begin
                        repayment.Add('loan_balance', ROUND(LBalance, 0.01, '>'));
                    end;



                    //Repayment Frequency
                    if ProductFactory."Repayment Frequency" = ProductFactory."Repayment Frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else
                        if ProductFactory."Repayment Frequency" = ProductFactory."Repayment Frequency"::Weekly then
                            RunDate := CalcDate('1W', RunDate)
                        else
                            if ProductFactory."Repayment Frequency" = ProductFactory."Repayment Frequency"::Monthly then
                                RunDate := CalcDate('1M', RunDate)
                            else
                                if ProductFactory."Repayment Frequency" = ProductFactory."Repayment Frequency"::Quarterly then
                                    RunDate := CalcDate('1Q', RunDate)
                                else
                                    // if ProductFactory."Repayment Frequency" = ProductFactory."Repayment Frequency"::"Bi-Annual" then
                                    //     RunDate := CalcDate('6M', RunDate)
                                    // else
                                    if ProductFactory."Repayment Frequency" = ProductFactory."Repayment Frequency"::Yearly then
                                        RunDate := CalcDate('1Y', RunDate);


                    repayment_schedule.Add(repayment);

                    EstMonthlyRepayment := LInterest + LPrincipal;
                until LBalance < 1;
            end;

            // LoansREc.Reset;
            // LoansREc.SetRange(LoansREc."Member No.", SearchMember."No.");
            // LoansREc.SetRange(LoansREc.Posted, true);
            // LoansREc.SetFilter("Outstanding Balance", '>0');
            // LoansREc.SetLoadFields(Repayment);
            // if LoansREc.FindSet then begin
            //     repeat
            //         TotalMonthlyLoanDeductions += LoansREc.Repayment;
            //     until LoansREc.Next = 0;
            // end;

            // TotalMonthlyLoanDeductions += LInterest + LPrincipal;

            // Response
            Datum.Add('member_no', SearchMember."No.");
            Datum.Add('member_name', SearchMember.Name);
            Datum.Add('loan_product', ProductFactory."Product ID");
            Datum.Add('loan_product_name', ProductFactory."Product Description");
            Datum.Add('requested_amount', requested_amount);
            Datum.Add('eligible_amount', ROUND(EligibleAmount, 0.01, '>'));
            Datum.Add('monthly_repayment', ROUND(EstMonthlyRepayment, 0.01, '>'));
            Datum.Add('interest_rate', ProductFactory."Interest Rate (Min.)");
            Datum.Add('interest_rate_monthly', Format(ProductFactory."Interest Rate (Min.)" / 12));
            Datum.Add('interest_calculation_method', Format(ProductFactory."Interest Calculation Method"));
            Datum.Add('installments', installments);
            Datum.Add('max_installments', ProductFactory."Ordinary Default Intallments");
            Datum.Add('total_charges', ROUND(TotalComputedCharges, 0.01, '>'));
            Datum.Add('total_top_up', ROUND(OffsetBalance, 0.01, '>'));
            Datum.Add('net_income', ROUND(DisposableIncome, 0.01, '>'));

            Datum.Add('third_of_basic', ROUND(Thirdbasic, 0.01, '>'));
            // Datum.Add('salary_qualification', ROUND(SalaryQualification, 0.01, '>'));
            Datum.Add('salary_qualification', '0');
            Datum.Add('deposit_qualification', ROUND(DepositQualification, 0.01, '>'));
            Datum.Add('take_home', ROUND(NetTakeHome, 0.01, '>'));
            Datum.Add('bosa_loans_balance', ROUND(SelfGuaranteedBal, 0.01, '>'));
            Datum.Add('repayment_schedule', repayment_schedule);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Loan calculator fetched successfully');
            ResponseObject.Add('data', Datum);
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure LoanCalculatorMNS(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        loan_product: JsonToken;
        requested_amount: JsonToken;
        basic_salary: JsonToken;
        total_earnings: JsonToken;
        total_deductions: JsonToken;
        net_salary: JsonToken;
        installments: JsonToken;
        top_ups: JsonToken;

        loan_top_up: JsonToken;

        SearchMember: Record Members;

        ProductFactory: Record "Product Factory";
        DisposableIncome: Decimal;
        Thirdbasic: Decimal;
        SavingsAcc: Record "Savings Accounts";
        MemberDeposits: Decimal;
        LoansREc: record Loans;
        SavAcc: record "Savings Accounts";
        TariffDetails: Record "Tiered Charges Lines";
        SelfGuaranteedBal: Decimal;
        LoansTopup: Record "Loans Top up";
        LoansTopupTmp: Record "Loans Top up" temporary;
        offseBa: Boolean;
        RelatedProduct: Record "Related Product";
        MultP: Integer;
        TheLoan: record loans;
        // RelatedBal: Decimal;
        // CurrLoanBal: Decimal;
        OffsetBalance: Decimal;
        Deposit_Multiplier: Decimal;
        SalaryQualification: Decimal;
        DepositQualification: Decimal;
        EligibleAmount: Decimal;
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Integer;
        TotalMRepay: decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        TotalComputedCharges: Decimal;
        ChargeExtraComms: Boolean;
        TotalCleared: Decimal;
        PCharges: Record "Loan Product Charges";
        HighestLoanAmount: Decimal;
        TotalMonthlyRepayment: Decimal;

        TotalLoansCount: Integer;
        TotalTopUpCount: Integer;

        // LoansProcess: Codeunit "Loans Process";
        NetTakeHome: Decimal;
        EstMonthlyRepayment: Decimal;
        KeyExists: Boolean;

        RSchedule: Record "Loan Repayment Schedule-Calc" temporary;
        // TotalMonthlyLoanDeductions: Decimal;

        repayment_schedule: JsonArray;
        repayment: JsonObject;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('loan_product', loan_product);
        Payload.Get('requested_amount', requested_amount);
        Payload.Get('installments', installments);
        Payload.Get('basic_salary', basic_salary);
        Payload.Get('total_earnings', total_earnings);
        Payload.Get('total_deductions', total_deductions);
        Payload.Get('top_ups', top_ups);
        KeyExists := Payload.Get('net_salary', net_salary);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            if not ProductFactory.Get(loan_product.AsValue.AsText) then begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', StrSubstNo('Unknown loan product = %1', loan_product.AsValue.AsText));
                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;

            // Temporary Loans to be cleared
            foreach loan_top_up in top_ups.AsArray do begin
                if TheLoan.Get(loan_top_up.AsValue.AsText) then begin
                    RelatedProduct.Reset;
                    RelatedProduct.SetRange("Product Code", ProductFactory."Product ID");
                    RelatedProduct.SetRange("Related Product Code", TheLoan."Loan Product Type");
                    if not RelatedProduct.FindFirst then begin
                        ResponseObject.Add('status', 'ERROR');
                        ResponseObject.Add('status_description',
                            StrSubstNo('Loan no %1 (%2) is not eligible for top up using loan %3',
                            TheLoan."Loan No.",
                            TheLoan."Loan Product Type Name",
                            ProductFactory."Product Description")
                        );
                        AddDateTimeToResponse(ResponseObject);
                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;

                    LoansTopupTmp.Init;

                    LoansTopupTmp."Loan No." := '';
                    LoansTopupTmp."Client Code" := SearchMember."No.";
                    LoansTopupTmp."Loan Top Up" := loan_top_up.AsValue.AsText;

                    TheLoan.CalcFields(
                        "Outstanding Balance"
                    );
                    LoansTopupTmp."Outstanding Balance" := TheLoan."Outstanding Balance";
                    LoansTopupTmp."Loan Type" := TheLoan."Loan Product Type";
                    LoansTopupTmp."Loan Product Type Name" := TheLoan."Loan Product Type Name";

                    LoansTopupTmp.Validate("Loan Top Up");
                    LoansTopupTmp.Validate("Principle Top Up");
                    LoansTopupTmp.Validate("Interest Top Up");

                    LoansTopupTmp.Insert;
                end;
            end;
            TotalTopUpCount := top_ups.AsArray.Count;

            EligibleAmount := requested_amount.AsValue.AsDecimal;
            offseBa := false;

            LoansREc.Reset;
            LoansREc.SetRange(LoansREc."Member No.", SearchMember."No.");
            LoansREc.SetRange(LoansREc.Posted, true);
            LoansREc.SetFilter("Outstanding Balance", '>0');
            LoansREc.SetLoadFields("Outstanding Balance");
            LoansREc.SetAutoCalcFields("Outstanding Balance");
            if LoansREc.FindSet then begin
                TotalLoansCount := LoansREc.Count;
                repeat
                    if HighestLoanAmount < LoansREc."Outstanding Balance" then begin
                        HighestLoanAmount := LoansREc."Outstanding Balance";
                    end;
                until LoansREc.Next = 0;
            end;

            DisposableIncome := 0;
            Thirdbasic := 0;
            SavingsAcc.Reset();
            SavingsAcc.SetRange("Member No.", SearchMember."No.");
            SavingsAcc.SetRange("Product Category", SavingsAcc."Product Category"::"BOSA Deposits");
            SavingsAcc.SetLoadFields("Balance (LCY)");
            if SavingsAcc.FindFirst then begin
                SavingsAcc.CalcFields(SavingsAcc."Balance (LCY)");
                MemberDeposits := SavingsAcc."Balance (LCY)";
            end;

            if KeyExists then begin
                DisposableIncome := net_salary.AsValue.AsDecimal;
            end else begin
                Thirdbasic := (1 / 3) * basic_salary.AsValue.AsDecimal;
                DisposableIncome := ((basic_salary.AsValue.AsDecimal + total_earnings.AsValue.AsDecimal) - (total_deductions.AsValue.AsDecimal + Thirdbasic));
            end;

            LoansREc.Reset;
            LoansREc.SetRange(LoansREc."Member No.", SearchMember."No.");
            LoansREc.SetRange(LoansREc.Posted, true);
            LoansREc.SetFilter("Outstanding Balance", '>0');
            LoansREc.SetRange("Source Unit", LoansREc."Source Unit"::BOSA);
            LoansREc.SetLoadFields("Outstanding Balance");
            if LoansREc.FindSet then begin
                repeat
                    LoansREc.CalcFields(LoansREc."Outstanding Balance");
                    SelfGuaranteedBal += LoansREc."Outstanding Balance";
                until LoansREc.Next = 0;
            end;

            RelatedProduct.Reset;
            RelatedProduct.SetRange("Product Code", ProductFactory."Product ID");
            if RelatedProduct.FindSet then begin
                repeat
                    //Topped up loans related product
                    foreach loan_top_up in top_ups.AsArray do begin
                        LoansTopupTmp.Reset;
                        LoansTopupTmp.SetRange("Client Code", SearchMember."No.");
                        LoansTopupTmp.SetRange("Loan Type", RelatedProduct."Related Product Code");
                        LoansTopupTmp.SetRange("Loan Top Up", loan_top_up.AsValue.AsText);
                        if LoansTopupTmp.FindSet then begin
                            repeat
                                TotalMonthlyRepayment += LoansTopupTmp."Monthly Repayment";
                                OffsetBalance += LoansTopupTmp."Outstanding Balance";
                            until LoansTopupTmp.Next = 0;

                            offseBa := true;
                        end;
                    end;
                until RelatedProduct.Next = 0;
            end;

            if (TotalTopUpCount = TotalLoansCount) OR (TotalLoansCount = 0) then begin
                // Ordinary Deposit Multiplier -  Top Up All Loan & Fresh Loan
                Deposit_Multiplier := (MemberDeposits + 0) * ProductFactory."Ordinary Deposits Multiplier";
            end else begin
                // Subsequent Deposit Multiplier - Running Loans & Top Up Partial Loan
                Deposit_Multiplier := (MemberDeposits + 0) * ProductFactory."Subsequent Multiplier";
            end;

            if ProductFactory."Source Unit" = ProductFactory."Source Unit"::"HR LOANS" then
                DepositQualification := ProductFactory."Staff Salary Multiplier" * MemberDeposits
            else
                DepositQualification := Deposit_Multiplier;


            if offseBa = true then
                DepositQualification := (Deposit_Multiplier - SelfGuaranteedBal) + OffsetBalance
            else
                DepositQualification := DepositQualification - SelfGuaranteedBal;

            // if DepositQualification < 0 then begin
            //     DepositQualification := 0;
            // end;

            DisposableIncome += TotalMonthlyRepayment;

            // Salary Qualification
            if ProductFactory."Source Unit" = ProductFactory."Source Unit"::"HR LOANS" then begin
                SalaryQualification := DisposableIncome * ProductFactory."Staff Salary Multiplier"
            end else begin
                if requested_amount.AsValue.AsDecimal < HighestLoanAmount then begin

                    if ProductFactory."Loan Exclusive Factor" <> '' then begin
                        SavAcc.Reset;
                        SavAcc.SetRange("Member No.", SearchMember."No.");
                        SavAcc.SetRange("Product Category", SavAcc."Product Category"::"BOSA Deposits");
                        if SavAcc.Find('-') then begin
                            SavAcc.CalcFields(Balance);
                            TariffDetails.Reset;
                            TariffDetails.SetRange(TariffDetails.Code, ProductFactory."Loan Exclusive Factor");
                            if TariffDetails.FindSet then begin
                                repeat
                                    if (SavAcc.Balance >= TariffDetails."Lower Limit") and (SavAcc.Balance <= TariffDetails."Upper Limit") then begin
                                        if TariffDetails."Use Percentage" = true then begin
                                            SalaryQualification := DisposableIncome * TariffDetails.Percentage * 0.01;
                                            break;
                                        end else begin
                                            SalaryQualification := TariffDetails."Charge Amount" * DisposableIncome;
                                            break;
                                        end;
                                    end;
                                until TariffDetails.Next = 0;
                            end;
                        end;
                    end;

                end else begin

                    if ProductFactory."Loan Prorata Factor" <> '' then begin
                        SavAcc.Reset;
                        SavAcc.SetRange("Member No.", SearchMember."No.");
                        SavAcc.SetRange("Product Category", SavAcc."Product Category"::"BOSA Deposits");
                        if SavAcc.Find('-') then begin
                            SavAcc.CalcFields(Balance);
                            TariffDetails.Reset;
                            TariffDetails.SetRange(TariffDetails.Code, ProductFactory."Loan Prorata Factor");
                            if TariffDetails.FindSet then begin
                                repeat
                                    if (SavAcc.Balance >= TariffDetails."Lower Limit") and (SavAcc.Balance <= TariffDetails."Upper Limit") then begin
                                        if TariffDetails."Use Percentage" = true then begin
                                            SalaryQualification := DisposableIncome * TariffDetails.Percentage * 0.01;
                                            break;
                                        end else begin
                                            SalaryQualification := TariffDetails."Charge Amount" * DisposableIncome;
                                            break;
                                        end;
                                    end;
                                until TariffDetails.Next = 0;
                            end;
                        end;
                    end;

                end;
            end;

            if SalaryQualification < DepositQualification then
                EligibleAmount := SalaryQualification
            else
                EligibleAmount := DepositQualification;
            if requested_amount.AsValue.AsDecimal < EligibleAmount then
                EligibleAmount := requested_amount.AsValue.AsDecimal;

            // Compute Net Take Home
            RelatedProduct.Reset;
            RelatedProduct.SetRange("Product Code", ProductFactory."Product ID");
            if RelatedProduct.FindSet then begin
                repeat
                    foreach loan_top_up in top_ups.AsArray do begin
                        LoansTopupTmp.Reset;
                        LoansTopupTmp.SetRange("Client Code", SearchMember."No.");
                        LoansTopupTmp.SetRange("Loan Type", RelatedProduct."Related Product Code");
                        LoansTopupTmp.SetRange("Loan Top Up", loan_top_up.AsValue.AsText);
                        if LoansTopupTmp.FindSet then begin
                            repeat
                                if LoansTopupTmp."Additional Top Up Commission" = true then
                                    ChargeExtraComms := true;

                                TotalCleared := TotalCleared + LoansTopupTmp."Principle Top Up" + LoansTopupTmp."Interest Top Up";

                                PCharges.Reset;
                                PCharges.SetRange(PCharges."Product Code", loan_product.AsValue.AsText);
                                PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Top up");
                                if PCharges.FindSet then begin
                                    repeat

                                        if (PCharges."Use Percentage" = true) and (PCharges."Charging Option" = PCharges."charging option"::"On Approved Amount") then begin
                                            if ChargeExtraComms = true then
                                                TotalComputedCharges := TotalComputedCharges + (EligibleAmount * ((PCharges.Percentage + PCharges."Additional Charge %") / 100))
                                            else
                                                TotalComputedCharges := TotalComputedCharges + (EligibleAmount * (PCharges.Percentage / 100))
                                        end else
                                            if (PCharges."Use Percentage" = true) and (PCharges."Charging Option" = PCharges."charging option"::"On Net Amount") then begin
                                                if ChargeExtraComms = true then
                                                    TotalComputedCharges := TotalComputedCharges + ((LoansTopupTmp."Principle Top Up" + LoansTopupTmp."Interest Top Up") * ((PCharges.Percentage + PCharges."Additional Charge %") / 100))
                                                else
                                                    TotalComputedCharges := TotalComputedCharges + ((LoansTopupTmp."Principle Top Up" + LoansTopupTmp."Interest Top Up") * (PCharges.Percentage / 100))
                                            end else
                                                TotalComputedCharges := TotalComputedCharges + PCharges."Charge Amount";
                                    until PCharges.Next = 0;
                                end;
                            until LoansTopupTmp.Next = 0;
                        end;
                    end;
                until RelatedProduct.Next = 0;
            end;
            // General Charges
            PCharges.Reset;
            PCharges.SetRange(PCharges."Product Code", loan_product.AsValue.AsText);
            PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::General);
            if PCharges.FindSet then begin
                repeat
                    if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                        TotalComputedCharges += (EligibleAmount * PCharges.Percentage / 100)
                    else
                        if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                            TotalComputedCharges += PCharges."Charge Amount"
                        else
                            if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin

                                PCharges.TestField(PCharges."Staggered Charge Code");

                                TariffDetails.Reset;
                                TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                                if TariffDetails.FindSet then begin
                                    repeat
                                        if (EligibleAmount >= TariffDetails."Lower Limit") and (EligibleAmount <= TariffDetails."Upper Limit") then begin
                                            if TariffDetails."Use Percentage" = true then begin
                                                TotalComputedCharges += (EligibleAmount * TariffDetails.Percentage * 0.01);
                                            end else begin
                                                TotalComputedCharges += TariffDetails."Charge Amount";
                                            end;
                                        end;
                                    until TariffDetails.Next = 0;
                                end;
                            end;
                until PCharges.Next = 0;
            end;

            NetTakeHome := EligibleAmount - (TotalCleared + TotalComputedCharges);

            if NetTakeHome <= 0 then begin
                EligibleAmount := 0;
            end;

            // Repayment Schedule
            if EligibleAmount > 0 then begin
                LoanAmount := EligibleAmount;//"Approved Amount";
                InterestRate := ProductFactory."Interest Rate (Min.)";
                RepayPeriod := installments.AsValue.AsInteger;
                InitialInstal := installments.AsValue.AsInteger;
                LBalance := EligibleAmount;//"Approved Amount";
                RunDate := CalcDate('1M', Today);

                InstalNo := 0;
                //Repayment Frequency
                repeat
                    InstalNo := InstalNo + 1;
                    //kma
                    if InterestRate = 0 then ProductFactory."Interest Calculation Method" := ProductFactory."Interest Calculation Method"::"Straight Line";

                    if ProductFactory."Interest Calculation Method" = ProductFactory."Interest Calculation Method"::Amortised then begin
                        TotalMRepay := Round((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                        LInterest := Round(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                        LPrincipal := TotalMRepay - LInterest;
                    end;

                    if ProductFactory."Interest Calculation Method" = ProductFactory."Interest Calculation Method"::"Straight Line" then begin
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LoanAmount;
                    end;

                    if ProductFactory."Interest Calculation Method" = ProductFactory."Interest Calculation Method"::"Reducing Balance" then begin
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LBalance;
                    end;

                    if ProductFactory."Interest Calculation Method" = ProductFactory."Interest Calculation Method"::"Reducing Flat" then begin
                        LPrincipal := Round(LoanAmount / RepayPeriod, 1.0, '>');
                        LInterest := Round(((LoanAmount * InterestRate / 12 / 100) + (LPrincipal * InterestRate / 12 / 100)) / 2, 1.0, '>');
                        // LoansR.Repayment := LPrincipal + LInterest;
                    end;

                    LBalance := LBalance - LPrincipal;

                    Clear(repayment);

                    repayment.Add('installment_no', InstalNo);
                    repayment.Add('repayment_date', GlobalFunctions.FormatISODate(RunDate));
                    repayment.Add('loan_product', ProductFactory."Product Description");
                    repayment.Add('monthly_repayment', ROUND(LInterest + LPrincipal, 0.01, '>'));
                    repayment.Add('monthly_interest', ROUND(LInterest, 0.01, '>'));
                    repayment.Add('monthly_principal', ROUND(LPrincipal, 0.01, '>'));
                    if LBalance < 0 then begin
                        repayment.Add('loan_balance', 0);
                    end else begin
                        repayment.Add('loan_balance', ROUND(LBalance, 0.01, '>'));
                    end;



                    //Repayment Frequency
                    if ProductFactory."Repayment Frequency" = ProductFactory."Repayment Frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else
                        if ProductFactory."Repayment Frequency" = ProductFactory."Repayment Frequency"::Weekly then
                            RunDate := CalcDate('1W', RunDate)
                        else
                            if ProductFactory."Repayment Frequency" = ProductFactory."Repayment Frequency"::Monthly then
                                RunDate := CalcDate('1M', RunDate)
                            else
                                if ProductFactory."Repayment Frequency" = ProductFactory."Repayment Frequency"::Quarterly then
                                    RunDate := CalcDate('1Q', RunDate)
                                else
                                    // if ProductFactory."Repayment Frequency" = ProductFactory."Repayment Frequency"::"Bi-Annual" then
                                    //     RunDate := CalcDate('6M', RunDate)
                                    // else
                                    if ProductFactory."Repayment Frequency" = ProductFactory."Repayment Frequency"::Yearly then
                                        RunDate := CalcDate('1Y', RunDate);


                    repayment_schedule.Add(repayment);

                    EstMonthlyRepayment := LInterest + LPrincipal;
                until LBalance < 1;
            end;

            // LoansREc.Reset;
            // LoansREc.SetRange(LoansREc."Member No.", SearchMember."No.");
            // LoansREc.SetRange(LoansREc.Posted, true);
            // LoansREc.SetFilter("Outstanding Balance", '>0');
            // LoansREc.SetLoadFields(Repayment);
            // if LoansREc.FindSet then begin
            //     repeat
            //         TotalMonthlyLoanDeductions += LoansREc.Repayment;
            //     until LoansREc.Next = 0;
            // end;

            // TotalMonthlyLoanDeductions += LInterest + LPrincipal;

            // Response
            Datum.Add('member_no', SearchMember."No.");
            Datum.Add('member_name', SearchMember.Name);
            Datum.Add('loan_product', ProductFactory."Product ID");
            Datum.Add('loan_product_name', ProductFactory."Product Description");
            Datum.Add('requested_amount', requested_amount);
            Datum.Add('eligible_amount', ROUND(EligibleAmount, 0.01, '>'));
            Datum.Add('monthly_repayment', ROUND(EstMonthlyRepayment, 0.01, '>'));
            Datum.Add('interest_rate', ProductFactory."Interest Rate (Min.)");
            Datum.Add('interest_rate_monthly', Format(ProductFactory."Interest Rate (Min.)" / 12));
            Datum.Add('interest_calculation_method', Format(ProductFactory."Interest Calculation Method"));
            Datum.Add('installments', installments);
            Datum.Add('max_installments', ProductFactory."Ordinary Default Intallments");
            Datum.Add('total_charges', ROUND(TotalComputedCharges, 0.01, '>'));
            Datum.Add('total_top_up', ROUND(OffsetBalance, 0.01, '>'));
            Datum.Add('net_income', ROUND(DisposableIncome, 0.01, '>'));

            Datum.Add('third_of_basic', ROUND(Thirdbasic, 0.01, '>'));
            Datum.Add('salary_qualification', ROUND(SalaryQualification, 0.01, '>'));
            Datum.Add('deposit_qualification', ROUND(DepositQualification, 0.01, '>'));
            Datum.Add('take_home', ROUND(NetTakeHome, 0.01, '>'));
            Datum.Add('bosa_loans_balance', ROUND(SelfGuaranteedBal, 0.01, '>'));
            Datum.Add('repayment_schedule', repayment_schedule);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Loan calculator fetched successfully');
            ResponseObject.Add('data', Datum);
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    // Staff Loans
    local procedure GetStaffLoanApplicationProducts(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        ProductFactory: Record "Product Factory";

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
            if not IsMemberAStaff(SearchMember) then begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' is not a staff employee!');
            end else begin
                ProductFactory.Reset;
                ProductFactory.SetRange("Product Class Type", ProductFactory."Product Class Type"::Loan);
                ProductFactory.SetRange(Status, ProductFactory.Status::Active);
                ProductFactory.SetRange("Source Unit", ProductFactory."Source Unit"::"HR LOANS");
                // Skip overdue loans product
                ProductFactory.SetFilter("Product ID", '<>113&<>110&<>125&<>128&<>140');

                if ProductFactory.FindSet then begin
                    repeat begin
                        Clear(Datum);

                        Datum.Add('product_id', ProductFactory."Product ID");
                        Datum.Add('product_name', ProductFactory."Product Description");
                        Datum.Add('minimum_amount', ProductFactory."Minimum Loan Amount");
                        Datum.Add('maximum_amount', ProductFactory."Maximum Loan Amount");
                        Datum.Add('repayment_frequency', Format(ProductFactory."Repayment Frequency"));
                        Datum.Add('min_interest_rate', Format(ProductFactory."Interest Rate (Min.)"));
                        Datum.Add('min_interest_rate_monthly', Format(ProductFactory."Interest Rate (Min.)" / 12));
                        Datum.Add('maximum_installments', ProductFactory."Ordinary Default Intallments");
                        Datum.Add('interest_calculation_method', Format(ProductFactory."Interest Calculation Method"));
                        Datum.Add('is_mobile_loan', ProductFactory."Mobile Loan");
                        Datum.Add('repayment_mode', Format(ProductFactory."Repay Mode"));
                        Datum.Add('requires_topup', ProductFactory."Allow Topup");

                        Data.Add(Datum);
                    end until ProductFactory.Next = 0;
                end;

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Staff Loan application product list has been fetched successfully');
                ResponseObject.Add('data', Data);
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetLoanSectors(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;

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
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
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
            ResponseObject.Add('status_description', 'Request is successful');
            ResponseObject.Add('data', Data);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure CreateStaffLoanApplicationRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;
        loan_product: JsonToken;
        requested_amount: JsonToken;
        installments: JsonToken;
        loan_purpose: JsonToken;
        sasra_main_sector: JsonToken;
        sasra_sub_sector_1: JsonToken;
        sasra_sub_sector_2: JsonToken;

        SearchMember: record Members;
        Employee: record "HR Employees";
        theLoanApplication: Record "Self Loan Application";
        NewLoans: Record Loans;

        CreditProcess: Codeunit "Loans Process";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);
        Payload.Get('loan_product', loan_product);
        Payload.Get('requested_amount', requested_amount);
        Payload.Get('installments', installments);
        Payload.Get('loan_purpose', loan_purpose);
        Payload.Get('sasra_main_sector', sasra_main_sector);
        Payload.Get('sasra_main_sector', sasra_main_sector);
        Payload.Get('sasra_sub_sector_1', sasra_sub_sector_1);
        Payload.Get('sasra_sub_sector_2', sasra_sub_sector_2);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            if not IsMemberAStaff(SearchMember) then begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' is not a staff employee!');
            end else begin
                Employee.Reset;
                Employee.SetRange("Member No.", SearchMember."No.");
                Employee.FindFirst;

                theLoanApplication.Init;

                theLoanApplication."Application Code" := '';
                theLoanApplication."Applicant Staff No." := Employee."No.";
                theLoanApplication.Validate("Applicant Staff No.");
                theLoanApplication."Member Name" := SearchMember.Name;

                theLoanApplication."Loan Type" := loan_product.AsValue.AsText;
                theLoanApplication.Validate("Loan Type");
                theLoanApplication.Installments := installments.AsValue.AsInteger;
                theLoanApplication.Validate(Installments);
                theLoanApplication."Requested Amount" := requested_amount.AsValue.AsDecimal;
                theLoanApplication.Validate("Requested Amount");
                theLoanApplication.Validate(Interest);

                if Employee."User ID" <> '' then begin
                    theLoanApplication."Applicant User ID" := Employee."User ID";
                end;

                theLoanApplication."Purpose of Loan" := loan_purpose.AsValue.AsText;

                theLoanApplication."Main Sector" := sasra_main_sector.AsValue.AsText;
                theLoanApplication.Validate("Main Sector");
                theLoanApplication."Sub Sector Level1" := sasra_sub_sector_1.AsValue.AsText;
                theLoanApplication.Validate("Sub Sector Level1");
                theLoanApplication."Sub Sector Level2" := sasra_sub_sector_2.AsValue.AsText;
                theLoanApplication.Validate("Sub Sector Level2");

                theLoanApplication.Status := theLoanApplication.Status::New;
                // theLoanApplication.Status := theLoanApplication.Status::"Pending Approval";

                if theLoanApplication."Loan Type" = '114' then begin
                    NewLoans.Reset;
                    NewLoans.SetRange(NewLoans."Member No.", theLoanApplication."Member No.");
                    NewLoans.SetRange(NewLoans."Loan Product Type", '104');
                    NewLoans.SetRange(Posted, true);
                    NewLoans.SetFilter("Outstanding Balance", '>%1', 0);
                    if not NewLoans.Find('-') then begin
                        ResponseObject.Add('status', 'ERROR');
                        ResponseObject.Add('status_description', 'You may only apply for refinancing loan for an existing mortgage loan');
                        AddDateTimeToResponse(ResponseObject);
                        ResponseObject.WriteTo(Response);
                        exit(Response);
                    end;
                end;

                NewLoans.Reset;
                NewLoans.SetRange(NewLoans."Member No.", theLoanApplication."Member No.");
                NewLoans.SetRange(NewLoans."Loan Product Type", theLoanApplication."Loan Type");
                NewLoans.SetRange(NewLoans.Posted, false);
                NewLoans.SetFilter(Status, '%1|%2|%3', NewLoans.status::Open, NewLoans.status::Pending, NewLoans.status::Approved);
                if NewLoans.Find('-') then begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', StrSubstNo('Application failed, You have %1 loan of %2 that is still being processed.', NewLoans."Loan Product Type Name", NewLoans."Requested Amount"));
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;

                if theLoanApplication.Insert(true) then begin
                    CreditProcess.SubmitHRLoans(theLoanApplication);
                    theLoanApplication.Submitted := true;
                    theLoanApplication."Submitted By" := UserId;
                    theLoanApplication."Date Submitted" := Today;
                    theLoanApplication."Time Submitted" := Time;

                    Datum.Add('application_no', theLoanApplication."Application Code");

                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Request is successful');
                    ResponseObject.Add('data', Datum);
                end else begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', GetLastErrorText(true));
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetStaffLoanApplicationRequests(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: Record Members;
        TheLoanApplications: Record "Self Loan Application";
        TheLoanProduct: Record "Product Factory";
        Employee: record "HR Employees";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Guarantors: JsonArray;
        Guarantor: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            if not IsMemberAStaff(SearchMember) then begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' is not a staff employee!');
            end else begin
                Employee.Reset;
                Employee.SetRange("Member No.", SearchMember."No.");
                Employee.FindFirst;

                TheLoanApplications.Reset;
                TheLoanApplications.SetRange("Applicant Staff No.", Employee."No.");
                TheLoanApplications.SetFilter(Status, '=%1|%2', TheLoanApplications.Status::New, TheLoanApplications.Status::"Pending Approval");

                if TheLoanApplications.FindSet then begin
                    repeat begin
                        Clear(Datum);

                        Datum.Add('application_no', TheLoanApplications."Application Code");
                        Datum.Add('member_no', TheLoanApplications."Member No.");
                        Datum.Add('member_name', Employee."Full Name");
                        Datum.Add('application_date', GlobalFunctions.FormatISODate(TheLoanApplications."Application Date"));
                        Datum.Add('loan_product_type', TheLoanApplications."Loan Type");
                        Datum.Add('loan_product_name', TheLoanApplications."Loan Product Type Name");
                        Datum.Add('requested_amount', TheLoanApplications."Requested Amount");

                        Datum.Add('loan_purpose', TheLoanApplications."Purpose of Loan");
                        Datum.Add('installments', TheLoanApplications.Installments);
                        Datum.Add('status', Format(TheLoanApplications.Status));

                        Data.Add(Datum);
                    end until TheLoanApplications.Next = 0;
                end;

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Loan application request list has been fetched successfully');
                ResponseObject.Add('data', Data);
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    // Share Certificate
    local procedure GetShareCertificateReport(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        SearchMember: record Members;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);

        if MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            RecRef.GetTable(SearchMember);

            BlobOutStream := TempBlob.CreateOutStream;
            Report.SaveAs(Report::"Share Capital Certificate", '', ReportFormat::Pdf, BlobOutStream, RecRef);

            BlobInStream := TempBlob.CreateInStream;
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            Datum.Add('file', FileContentsB64);
            Datum.Add('file_type', 'PDF');
            Datum.Add('file_name', SearchMember."No." + ' - Share Certificate.pdf');
            Datum.Add('file_size', StrLen(FileContentsB64));

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Request is successful');
            ResponseObject.Add('data', Datum);
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
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

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'Fixed deposit accounts list has been fetched successfully');
            ResponseObject.Add('data', Data);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

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

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'FD Account maturity instructions list has been fetched successfully');
            ResponseObject.Add('data', Data);
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

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
                    ResponseObject.Add('status', 'SUCCESS');
                    ResponseObject.Add('status_description', 'Fixed deposit maturity request has been updated successfully');
                end else begin
                    ResponseObject.Add('status', 'ERROR');
                    ResponseObject.Add('status_description', GetLastErrorText(true));
                    AddDateTimeToResponse(ResponseObject);
                    ResponseObject.WriteTo(Response);
                    exit(Response);
                end;
            end else begin
                ResponseObject.Add('status', 'NOT_FOUND');
                ResponseObject.Add('status_description', 'The fixed deposit account ' + account_no.AsValue.AsText + ' is NOT available for update');
            end;
        end else begin
            ResponseObject.Add('status', ResponseText);
            ResponseObject.Add('status_description', ResponseDescription);
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    // Signature Edit
    local procedure CreateMemberEditSignatureRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        // Record fields
        signature: JsonToken;
        comments: JsonToken;

        KeyExists: boolean;

        SearchMember: Record Members;
        MemberImagesTable: Record "Image Data";
        TmpMemberTable: Record "Image Data" temporary;

        SystemEdits: Record "System Edits";
        SystemEditsCodeunit: Codeunit "System Editss";
        Action: Option SetFilter,PostChanges;
        RecRef: RecordRef;
        NewRecRef: RecordRef;
        EditsHelper: Record "Edits Helper";
        DocRecRef: RecordRef;
        XmlDoc: XmlDocument;
        ReportParameters: text;

        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        StoreImageRef: FieldRef;
        StoreRecRef: RecordRef;

        EDMSFileTypes: enum "EDMS File Types";
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('signature', signature);

        KeyExists := Payload.Get('comments', comments);

        // Validations
        if signature.AsValue.AsText = '' then begin
            Error('Signature is required!');
        end;

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            // Check ongoing applications
            SystemEdits.Reset;
            SystemEdits.SetRange("Request Source", SystemEdits."Request Source"::"M-Portal");
            SystemEdits.SetRange("M-Portal No", SearchMember."No.");
            SystemEdits.SetRange("Table ID", Database::"Image Data");
            SystemEdits.SetRange(Comments, 'Member Portal Signature Edit');
            SystemEdits.SetFilter(
                Status,
                '=%1|%2',
                SystemEdits.Status::Open,
                SystemEdits.Status::Pending
            );

            if SystemEdits.FindFirst then begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', StrSubstNo('There is an ongoing member signature edit request %1 at status %2', SystemEdits."No.", SystemEdits.Status));
                ResponseObject.Add('data', Datum);

                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);

                exit(Response);
            end;

            SystemEdits.Reset;
            Clear(SystemEdits);
            SystemEdits.Init;

            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."System Edits");
            SystemEdits."No." := SeriesSetup."System Edits";
            // NoSeriesMgt.InitSeries(SeriesSetup."System Edits", '', 0D, SystemEdits."No.", SystemEdits."No. Series");

            SystemEdits."Table ID" := database::"Image Data";
            SystemEdits.Validate("Table ID");

            SystemEdits.Comments := 'Member Portal Signature Edit';
            SystemEdits.Status := SystemEdits.Status::Open;
            SystemEdits."Request Source" := SystemEdits."Request Source"::"M-Portal";
            SystemEdits."M-Portal No" := SearchMember."No.";

            if KeyExists then begin
                if comments.AsValue.AsText <> '' then begin
                    SystemEdits.Comments := CopyStr(comments.AsValue.AsText, 1, 250);
                end;
            end;

            IF SystemEdits.Insert(true) then begin
                SystemEdits."Innitiating Officer" := 'MEMBER PORTAL';
                SystemEdits.Modify(true);

                SystemEditsCodeunit.SetFilters(SystemEdits."Table ID", SystemEdits."No.", false, SearchMember."No.");

                TmpMemberTable.Init();

                MemberImagesTable.Reset;
                MemberImagesTable.SetRange("Member No", SearchMember."No.");
                if MemberImagesTable.FindFirst then begin
                    TmpMemberTable.Copy(MemberImagesTable);
                end;

                TmpMemberTable."Member No" := SearchMember."No.";
                TmpMemberTable."ID Number" := SearchMember."Primary Identification";

                TempBlob.CreateOutStream(BlobOutStream);
                Base64Convert.FromBase64(signature.AsValue.AsText, BlobOutStream);
                Clear(TmpMemberTable.Signature);
                StoreRecRef.Open(52185702);
                StoreImageRef := StoreRecRef.Field(TmpMemberTable.FieldNo(Signature));
                TempBlob.ToFieldRef(StoreImageRef);
                StoreImageRef.TestField();

                TmpMemberTable.Signature := StoreImageRef.Value;
                TmpMemberTable.Insert;

                RecRef.Open(SystemEdits."Table ID");
                RecRef.Copy(MemberImagesTable);
                NewRecRef.Open(SystemEdits."Table ID");
                NewRecRef.Copy(TmpMemberTable);
                SystemEditsCodeunit.SetFilterFields(SystemEdits."Table ID", SystemEdits."No.", Action::SetFilter, RecRef, NewRecRef);

                EditsHelper.Init();
                EditsHelper."Record No." := SearchMember."No.";
                EditsHelper."Edits Header No." := SystemEdits."No.";
                EditsHelper."Edit Type" := EditsHelper."Edit Type"::Records;
                EditsHelper.Insert();

                SearchMember."Marked For Edits" := true;
                SearchMember.Modify();

                Datum.Add('application_no', SystemEdits."No.");

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Member edit request is successful');
                ResponseObject.Add('data', Datum);
            end else begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', 'Member edit error!');
                ResponseObject.Add('data', Datum);
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    // Picture Edit
    local procedure CreateMemberEditPictureRequest(Payload: JsonObject): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        // Record fields
        picture: JsonToken;
        comments: JsonToken;

        KeyExists: boolean;

        SearchMember: Record Members;
        MemberImagesTable: Record "Image Data";
        TmpMemberTable: Record "Image Data" temporary;

        SystemEdits: Record "System Edits";
        SystemEditsCodeunit: Codeunit "System Editss";
        Action: Option SetFilter,PostChanges;
        RecRef: RecordRef;
        NewRecRef: RecordRef;
        EditsHelper: Record "Edits Helper";
        DocRecRef: RecordRef;
        XmlDoc: XmlDocument;
        ReportParameters: text;

        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FileContentsB64: Text;

        StoreImageRef: FieldRef;
        StoreRecRef: RecordRef;

        EDMSFileTypes: enum "EDMS File Types";
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
        ResponseText: Text;
        ResponseDescription: Text;
    begin
        Payload.Get('identifier_type', identifier_type); // MSISDN, MEMBER_NO, EMAIL, ID_NO, PAYROLL_NO
        Payload.Get('identifier', identifier);
        Payload.Get('picture', picture);

        KeyExists := Payload.Get('comments', comments);

        // Validations
        if picture.AsValue.AsText = '' then begin
            Error('Picture is required!');
        end;

        SearchMember.Reset;

        IF MemberExists(identifier_type.AsValue.AsText, identifier.AsValue.AsText, SearchMember, ResponseText, ResponseDescription) then begin
            // Check ongoing applications
            SystemEdits.Reset;
            SystemEdits.SetRange("Request Source", SystemEdits."Request Source"::"M-Portal");
            SystemEdits.SetRange("M-Portal No", SearchMember."No.");
            SystemEdits.SetRange("Table ID", Database::"Image Data");
            SystemEdits.SetRange(Comments, 'Member Portal Picture Edit');
            SystemEdits.SetFilter(
                Status,
                '=%1|%2',
                SystemEdits.Status::Open,
                SystemEdits.Status::Pending
            );

            if SystemEdits.FindFirst then begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', StrSubstNo('There is an ongoing member picture edit request %1 at status %2', SystemEdits."No.", SystemEdits.Status));
                ResponseObject.Add('data', Datum);

                AddDateTimeToResponse(ResponseObject);
                ResponseObject.WriteTo(Response);

                exit(Response);
            end;

            SystemEdits.Reset;
            Clear(SystemEdits);
            SystemEdits.Init;

            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."System Edits");
            SystemEdits."No." := NoSeriesMgt.GetNextNo(SeriesSetup."System Edits");
            // NoSeriesMgt.InitSeries(SeriesSetup."System Edits", '', 0D, SystemEdits."No.", SystemEdits."No. Series");

            SystemEdits."Table ID" := database::"Image Data";
            SystemEdits.Validate("Table ID");

            SystemEdits.Comments := 'Member Portal Picture Edit';
            SystemEdits.Status := SystemEdits.Status::Open;
            SystemEdits."Request Source" := SystemEdits."Request Source"::"M-Portal";
            SystemEdits."M-Portal No" := SearchMember."No.";

            if KeyExists then begin
                if comments.AsValue.AsText <> '' then begin
                    SystemEdits.Comments := CopyStr(comments.AsValue.AsText, 1, 250);
                end;
            end;

            IF SystemEdits.Insert(true) then begin
                SystemEdits."Innitiating Officer" := 'MEMBER PORTAL';
                SystemEdits.Modify(true);

                SystemEditsCodeunit.SetFilters(SystemEdits."Table ID", SystemEdits."No.", false, SearchMember."No.");

                TmpMemberTable.Init();

                MemberImagesTable.Reset;
                MemberImagesTable.SetRange("Member No", SearchMember."No.");
                if MemberImagesTable.FindFirst then begin
                    TmpMemberTable.Copy(MemberImagesTable);
                end;

                TmpMemberTable."Member No" := SearchMember."No.";
                TmpMemberTable."ID Number" := SearchMember."Primary Identification";

                TempBlob.CreateOutStream(BlobOutStream);
                Base64Convert.FromBase64(picture.AsValue.AsText, BlobOutStream);
                Clear(TmpMemberTable.Picture);
                StoreRecRef.Open(52185702);
                StoreImageRef := StoreRecRef.Field(TmpMemberTable.FieldNo(Picture));
                TempBlob.ToFieldRef(StoreImageRef);
                StoreImageRef.TestField();

                TmpMemberTable.Picture := StoreImageRef.Value;
                TmpMemberTable.Insert;

                RecRef.Open(SystemEdits."Table ID");
                RecRef.Copy(MemberImagesTable);
                NewRecRef.Open(SystemEdits."Table ID");
                NewRecRef.Copy(TmpMemberTable);
                SystemEditsCodeunit.SetFilterFields(SystemEdits."Table ID", SystemEdits."No.", Action::SetFilter, RecRef, NewRecRef);

                EditsHelper.Init();
                EditsHelper."Record No." := SearchMember."No.";
                EditsHelper."Edits Header No." := SystemEdits."No.";
                EditsHelper."Edit Type" := EditsHelper."Edit Type"::Records;
                EditsHelper.Insert();

                SearchMember."Marked For Edits" := true;
                SearchMember.Modify();

                Datum.Add('application_no', SystemEdits."No.");

                ResponseObject.Add('status', 'SUCCESS');
                ResponseObject.Add('status_description', 'Member edit request is successful');
                ResponseObject.Add('data', Datum);
            end else begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', 'Member edit error!');
                ResponseObject.Add('data', Datum);
            end;
        end else begin
            ResponseObject.Add('status', 'NOT_FOUND');
            ResponseObject.Add('status_description', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    // COMMON
    local procedure ComputeCharges(ApprovedAmt: Decimal; ProdType: Code[20]; LoanNo: Code[50]; CurrValue: Decimal; MemberNo: Text; var TotalComputedCharges: Decimal): Decimal
    var
        ChargeExtraComms: Boolean;
        TopUp: Record "Loans Top up";
        PCharges: Record "Loan Product Charges";
        TariffDetails: Record "Tiered Charges Lines";
        TotalCleared: Decimal;
        OtherComms: Decimal;
        OtherCommitments: record "Other Commitements Clearance";
        LoanApps: Record Loans;
        Difference: Decimal;
    begin
        TotalComputedCharges := 0;
        ChargeExtraComms := false;
        TotalCleared := 0;

        TopUp.Reset;
        TopUp.SetRange(TopUp."Loan No.", LoanNo);
        TopUp.SetRange("Client Code", MemberNo);
        if TopUp.FindSet then begin
            repeat
                if TopUp."Additional Top Up Commission" = true then
                    ChargeExtraComms := true;

                TotalCleared := TotalCleared + TopUp."Principle Top Up" + TopUp."Interest Top Up";

                PCharges.Reset;
                PCharges.SetRange(PCharges."Product Code", ProdType);
                PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"Top up");
                if PCharges.FindSet then begin
                    repeat

                        if (PCharges."Use Percentage" = true) and (PCharges."Charging Option" = PCharges."charging option"::"On Approved Amount") then begin
                            if ChargeExtraComms = true then
                                TotalComputedCharges := TotalComputedCharges + (ApprovedAmt * ((PCharges.Percentage + PCharges."Additional Charge %") / 100))
                            else
                                TotalComputedCharges := TotalComputedCharges + (ApprovedAmt * (PCharges.Percentage / 100))
                        end else
                            if (PCharges."Use Percentage" = true) and (PCharges."Charging Option" = PCharges."charging option"::"On Net Amount") then begin
                                if ChargeExtraComms = true then
                                    TotalComputedCharges := TotalComputedCharges + ((TopUp."Principle Top Up" + TopUp."Interest Top Up") * ((PCharges.Percentage + PCharges."Additional Charge %") / 100))
                                else
                                    TotalComputedCharges := TotalComputedCharges + ((TopUp."Principle Top Up" + TopUp."Interest Top Up") * (PCharges.Percentage / 100))
                            end else
                                TotalComputedCharges := TotalComputedCharges + PCharges."Charge Amount";
                    until PCharges.Next = 0;
                end;
            until TopUp.Next = 0;
        end;

        // General Charges
        PCharges.Reset;
        PCharges.SetRange(PCharges."Product Code", ProdType);
        PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::General);
        if PCharges.FindSet then begin
            repeat
                if (PCharges."Charge Method" = PCharges."charge method"::"% of Amount") then
                    TotalComputedCharges += (ApprovedAmt * PCharges.Percentage / 100)
                else
                    if PCharges."Charge Method" = PCharges."charge method"::"Flat Amount" then
                        TotalComputedCharges += PCharges."Charge Amount"
                    else
                        if PCharges."Charge Method" = PCharges."charge method"::Staggered then begin

                            PCharges.TestField(PCharges."Staggered Charge Code");

                            TariffDetails.Reset;
                            TariffDetails.SetRange(TariffDetails.Code, PCharges."Staggered Charge Code");
                            if TariffDetails.FindSet then begin
                                repeat
                                    if (ApprovedAmt >= TariffDetails."Lower Limit") and (ApprovedAmt <= TariffDetails."Upper Limit") then begin
                                        if TariffDetails."Use Percentage" = true then begin
                                            TotalComputedCharges += (ApprovedAmt * TariffDetails.Percentage * 0.01);
                                        end else begin
                                            TotalComputedCharges += TariffDetails."Charge Amount";
                                        end;
                                    end;
                                until TariffDetails.Next = 0;
                            end;
                        end;
            until PCharges.Next = 0;
        end;

        // OtherComms := 0;
        // OtherCommitments.Reset;
        // OtherCommitments.SetRange(OtherCommitments."Loan No.", LoanNo);
        // if OtherCommitments.FindSet then begin
        //     repeat
        //         TotalCleared := TotalCleared + OtherCommitments.Amount;
        //         PCharges.Reset;
        //         PCharges.SetRange(PCharges."Product Code", ProdType);
        //         PCharges.SetRange(PCharges."Charge Type", PCharges."charge type"::"External Loan");
        //         if PCharges.FindSet then begin
        //             repeat
        //                 if (PCharges."Use Percentage" = true) then begin
        //                     if ChargeExtraComms = true then
        //                         TotalComputedCharges := TotalComputedCharges + (OtherCommitments.Amount * ((PCharges.Percentage + PCharges."Additional Charge %") / 100))
        //                     else
        //                         TotalComputedCharges := TotalComputedCharges + (OtherCommitments.Amount * (PCharges.Percentage / 100))
        //                 end else
        //                     TotalComputedCharges := TotalComputedCharges + OtherCommitments.Amount;

        //             until PCharges.Next = 0;

        //         end;
        //     until OtherCommitments.Next = 0;
        // end;

        Difference := ApprovedAmt - (TotalComputedCharges + TotalCleared + CurrValue);

        exit(Difference);

    end;

    local procedure MemberExists(identifier_type: Text; identifier: Text; var SearchMember: Record Members; var ResponseText: Text; var ResponseDescription: Text): Boolean
    begin
        SearchMember.Reset;

        case identifier_type of
            'MSISDN':
                begin
                    SearchMember.FilterGroup := -1;
                    SearchMember.SetRange("Transactional Mobile Number", identifier);
                    SearchMember.SetRange("Phone No.", identifier);
                end;
            'CUSTOMER_NO', 'MEMBER_NO', 'GROUP_NO':
                SearchMember.SetRange("No.", identifier);
            'NATIONAL_ID':
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
                begin
                    SearchMember.SetRange("Payroll/Staff No.", identifier);
                end;
            else begin
                ResponseText := 'ERROR';
                ResponseDescription := 'Identifier type ' + identifier_type + ' is not valid';
                exit(false);
            end;
        end;

        if SearchMember.HasFilter and SearchMember.FindFirst() then begin
            ResponseText := 'SUCCESS';
            ResponseDescription := 'Member with ' + identifier_type + ' ' + identifier + ' found';
            exit(true);
        end else begin
            ResponseText := 'FAILED';
            ResponseDescription := 'Member with ' + identifier_type + ' ' + identifier + ' cannot be found';
            exit(false);
        end;
    end;

    local procedure IsMemberAStaff(Member: Record Members): Boolean;
    var
        EmployeeTable: Record "HR Employees";
    begin
        EmployeeTable.Reset;

        EmployeeTable.SetRange("Member No.", Member."No.");

        exit(EmployeeTable.FindFirst);
    end;

    local procedure UnsupportedAction(RequestAction: Text): Text
    var
        ResponseObject: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        ResponseObject.Add('status', 'ERROR');
        ResponseObject.Add('status_description', 'The requested action ' + RequestAction + ' is NOT supported.');
        ResponseObject.Add('errors', Errors);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure AddDateTimeToResponse(var ResponseObject: JsonObject)
    begin
        ResponseObject.Add('date_time', GlobalFunctions.FormatISODateTime(CurrentDateTime));
    end;

    local procedure GuarantorSalaryEligibility(LoanTypeID: Text; SearchMember: Record Members): Decimal
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
    begin
        SalAvg := 0;
        SalaryAmount := 0;
        FosaAccount := SkyMbankingTrans.GetMemberFosaAcc(SearchMember);

        if ProdFac.Get(LoanTypeID) then begin
            if ProdFac."Source Unit" = ProdFac."Source Unit"::FOSA then begin

                SalaryAccount.Reset;
                SalaryAccount.SetRange("No.", FosaAccount);
                if SalaryAccount.FindFirst then begin
                    SalaryType := ProdFac."Salary Income Types";
                    SalAvg := GlobalFunctions.GetSmallestSalary(SalaryAccount."No.", SalaryType);
                    STOAmount := SkyMbankingTrans.ComputeSTODeductions(SalaryAccount."No.");
                    LoanRec := SkyMbankingTrans.ComputeLoanDeductions(SalaryAccount."Member No.");

                    IF (SalaryAccount.Status <> SalaryAccount.Status::Active) OR (SalaryAccount.Blocked <> SalaryAccount.Blocked::" ") THEN BEGIN
                        SalaryAmount := 0;
                    END else begin
                        //Get last salary amount
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("Member No.", SalaryAccount."Member No.");
                        SalaryLines.SETRANGE(Posted, TRUE);
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

            end;

            if ProdFac."Source Unit" = ProdFac."Source Unit"::BOSA then begin

                BosaAccount := SkyMbankingTrans.GetMemberDepositsAcc(SearchMember);

                SalaryAccount.Reset;
                SalaryAccount.SetRange("No.", BosaAccount);
                if SalaryAccount.FindFirst then begin
                    SalaryAmount := GlobalFunctions.GetSavingsAccountAvailableGuarantorshipBalance(SalaryAccount, true)
                end;

            end;
        end;


        if SalaryAmount < 0 then begin
            exit(0);
        end;
        exit(SalaryAmount);
    end;

    var
        VendorName: Label 'Sky World Limited';
        SignatoriesRec: Record "Account Signatories";
        GlobalFunctions: Codeunit "Global Functions";
        EDMSFunctions: Codeunit "EDMS Functions";
        BranchDimensionCode: Label 'BRANCH';
        SkyMbankingTrans: Codeunit "Sky M-Banking Transactions";
}