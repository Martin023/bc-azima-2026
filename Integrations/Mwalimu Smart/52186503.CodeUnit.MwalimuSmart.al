// codeunit 52186503 "Mwalimu Smart Integration"
// {
//     procedure HandleRequest(Request: Text): Text
//     var
//         RequestParser: JsonObject;
//         RequestAction: JsonToken;
//         RequestAPIId: JsonToken;
//         RequestPayload: JsonToken;
//         TokenExists: Boolean;
//     begin
//         RequestParser.ReadFrom(Request);
//         RequestParser.SelectToken('$.action', RequestAction);
//         RequestParser.SelectToken('$.api_request_id', RequestAPIId);
//         TokenExists := RequestParser.SelectToken('$.payload', RequestPayload);

//         // API actions here
//         case RequestAction.AsValue().AsText() of
//             'BC_SEARCH_MEMBER':
//                 exit(SearchMember(RequestPayload.AsObject, RequestAPIId));
//             'BC_MEMBER_APPLICATION_STATUS_CALLBACK':
//                 exit(RegisterMemberApplicationStatusCallback(RequestPayload.AsObject, RequestAPIId));
//             'BC_GET_EMPLOYER_INSTITUTIONS':
//                 exit(GetEmployerInstitutions);
//             'BC_GET_DELEGATE_BRANCHES':
//                 exit(GetDelegateBranches);
//             'BC_GET_FOSA_BRANCHES':
//                 exit(GetFOSABranches);
//             'BC_GET_COUNTRIES':
//                 exit(GetCountries);
//             'BC_GET_POST_CODES':
//                 exit(GetPostCodes);
//             'BC_GET_NOK_BEN_NOM_RELATIONSHIPS':
//                 exit(GetNokRelationships);
//             'BC_GET_MEMBER_NATIONALITIES':
//                 exit(GetMemberNationalities);
//             'BC_GET_MEMBER_RELIGIONS':
//                 exit(GetMemberReligions);
//             'BC_GET_MEMBER_COUNTIES':
//                 exit(GetMemberCounties);
//             'BC_GET_MEMBER_BANK_CODES':
//                 exit(GetMemberBankCodes);
//             'BC_GET_MEMBER_BANK_BRANCHES':
//                 exit(GetMemberBankBranches(RequestPayload.AsObject, RequestAPIId));
//             'BC_GET_MEMBER_CLASSES':
//                 exit(GetMemberClasses);
//             'BC_GET_MEMBER_SALUTATIONS':
//                 exit(GetMemberSalutations);

//             'BC_SEND_MEMBER_DATA':
//                 exit(SendMemberData(RequestPayload.AsObject, RequestAPIId));
//             'BC_GET_MEMBER_DATA':
//                 exit(GetMemberData(RequestPayload.AsObject, RequestAPIId));
//             'BC_UPDATE_MEMBER_DATA':
//                 exit(UpdateMemberData(RequestPayload.AsObject, RequestAPIId));

//             'BC_SEND_MEMBER_EDIT_DATA':
//                 exit(SendEditMemberData(RequestPayload.AsObject, RequestAPIId));
//             'BC_GET_MEMBER_EDIT_DATA':
//                 exit(GetEditMemberData(RequestPayload.AsObject, RequestAPIId));
//             'BC_UPDATE_MEMBER_EDIT_DATA':
//                 exit(UpdateEditMemberData(RequestPayload.AsObject, RequestAPIId));

//             'BC_GET_LOAN_PRODUCTS':
//                 exit(GetLoanProducts);
//             'BC_GET_LOAN_SECTORS':
//                 exit(GetLoanSectors);
//             'BC_GET_LOAN_PURPOSES':
//                 exit(GetLoanPurposes);
//             'BC_SEND_LOAN_DATA':
//                 exit(SendLoanData(RequestPayload.AsObject, RequestAPIId));
//             'BC_GET_LOAN_DATA':
//                 exit(GetLoanData(RequestPayload.AsObject, RequestAPIId));
//             'BC_UPDATE_LOAN_DATA':
//                 exit(UpdateLoanData(RequestPayload.AsObject, RequestAPIId));
//             'BC_GET_BUSINESS_LOAN_PRODUCTS':
//                 exit(GetBusinessLoanProducts);
//             'BC_SEND_BUSINESS_LOAN_DATA':
//                 exit(SendBusinessLoanData(RequestPayload.AsObject, RequestAPIId));
//             'BC_CHECK_MEMBER_HAS_BUSINESS_ACCOUNT':
//                 exit(CheckMemberHasBusinessAccount(RequestPayload.AsObject, RequestAPIId));
//             'BC_SEND_BUSINESS_ACCOUNT_MEMBERSHIP_REQUEST':
//                 exit(SendBusinessAccountMembershipRequest(RequestPayload.AsObject, RequestAPIId));
//             'BC_GET_MEMBER_GROUP':
//                 exit(GetMemberGroup(RequestPayload.AsObject, RequestAPIId));
//             'BC_GET_GROUP_DETAILS':
//                 exit(GetGroupDetails(RequestPayload.AsObject, RequestAPIId));
//             'BC_GET_CUSTOMER_COLLATERALS':
//                 exit(GetCustomerCollaterals(RequestPayload.AsObject, RequestAPIId));
//             'BC_CREATE_CUSTOMER_COLLATERAL':
//                 exit(CreateCustomerCollateral(RequestPayload.AsObject, RequestAPIId));
//             'BC_GET_LOAN_REPAYMENT_SCHEDULE':
//                 exit(GetLoanRepaymentSchedule(RequestPayload.AsObject, RequestAPIId));
//             'BC_RETRIEVE_MEMBER_ACCOUNTS':
//                 exit(RetrieveMemberAccounts(RequestPayload.AsObject, RequestAPIId));
//             'BC_CHECK_LOAN_APPLICATION':
//                 exit(CheckLoanApplication(RequestPayload.AsObject, RequestAPIId));
//             'BC_RETRIEVE_MEMBER_LOANS':
//                 exit(RetrieveMemberLoans(RequestPayload.AsObject, RequestAPIId));
//             'BC_RETRIEVE_MEMBER_ACCOUNT_TRANSACTIONS':
//                 exit(RetrieveMemberAccountTransactions(RequestPayload.AsObject, RequestAPIId));
//             'BC_RETRIEVE_MEMBER_LOAN_TRANSACTIONS':
//                 exit(RetrieveMemberLoanTransactions(RequestPayload.AsObject, RequestAPIId));
//             'BC_PT_ACCOUNT_REPAY_LOAN':
//                 exit(AccountRepayLoan(RequestPayload.AsObject, RequestAPIId));
//             'BC_GET_GUARANTOR_VALIDATION':
//                 exit(GetGuarantorValidation(RequestPayload.AsObject, RequestAPIId));
//             'BC_LOAN_APPLICATION_STATUS_CALLBACK':
//                 exit(RegisterLoanApplicationStatusCallback(RequestPayload.AsObject, RequestAPIId));

//             'BC_GET_DOCUMENT_TYPES':
//                 exit(GetDocuments);
//             'BC_UPLOAD_DOCUMENTS':
//                 exit(UploadDocuments(RequestPayload.AsObject, RequestAPIId));

//             'BC_GET_LOAN_QUALIFICATION_AMOUNT':
//                 exit(GetLoanProductQualificationAmount(RequestPayload.AsObject, RequestAPIId))
//             else
//                 exit(UnsupportedAction(RequestAction.AsValue.AsText))
//         end;
//     end;

//     local procedure SearchMember(Payload: JsonObject; APIRequestID: JsonToken): Text
//     var
//         identifier_type: JsonToken;
//         identifier: JsonToken;

//         SearchMember: Record Members;
//         SearchMemberApplication: Record "Member Application";

//         ResponseObject: JsonObject;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         Payload.Get('identifier_type', identifier_type); // id_number, passport_number, member_number, phone_number, kra_pin
//         Payload.Get('identifier', identifier);

//         SearchMember.Reset;

//         case identifier_type.AsValue.AsText of
//             'phone_number':
//                 SearchMember.SetRange("Phone No.", identifier.AsValue.AsText);
//             'member_number':
//                 SearchMember.SetRange("No.", identifier.AsValue.AsText);
//             'id_number':
//                 begin
//                     SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"ID Number");
//                     SearchMember.SetRange("Primary Identification", identifier.AsValue.AsText);

//                     if not SearchMember.FindFirst then begin
//                         SearchMember.Reset;
//                         SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"ID Number");
//                         SearchMember.SetRange("Secondary Identification", identifier.AsValue.AsText);
//                     end;
//                 end;
//             'passport_number':
//                 begin
//                     SearchMember.SetRange("Primary Identification Type", SearchMember."Primary Identification Type"::"Passport No");
//                     SearchMember.SetRange("Primary Identification", identifier.AsValue.AsText);

//                     if not SearchMember.FindFirst then begin
//                         SearchMember.Reset;
//                         SearchMember.SetRange("Secondary Identification Type", SearchMember."Secondary Identification Type"::"Passport No");
//                         SearchMember.SetRange("Secondary Identification", identifier.AsValue.AsText);
//                     end;
//                 end;
//             'kra_pin':
//                 SearchMember.SetRange("P.I.N Number", identifier.AsValue.AsText);
//             else
//         end;

//         IF SearchMember.FindFirst then begin
//             SearchMember.CalcFields(
//                 "Employer Name", "Any Physical Disability", "Branch Name"
//             );

//             Datum.Add('member_number', SearchMember."No.");

//             if SearchMember."Primary Identification Type" = SearchMember."Primary Identification Type"::"ID Number" then begin
//                 Datum.Add('id_number', SearchMember."Primary Identification");
//             end else
//                 if SearchMember."Secondary Identification Type" = SearchMember."Secondary Identification Type"::"ID Number" then begin
//                     Datum.Add('id_number', SearchMember."Secondary Identification");
//                 end else begin
//                     Datum.Add('id_number', '');
//                 end;

//             Datum.Add('kra_pin', SearchMember."P.I.N Number");

//             if SearchMember."Primary Identification Type" = SearchMember."Primary Identification Type"::"Passport No" then begin
//                 Datum.Add('passport_number', SearchMember."Primary Identification");
//             end else
//                 if SearchMember."Secondary Identification Type" = SearchMember."Secondary Identification Type"::"Passport No" then begin
//                     Datum.Add('passport_number', SearchMember."Secondary Identification");
//                 end else begin
//                     Datum.Add('passport_number', '');
//                 end;

//             if SearchMember."Primary Identification Type" = SearchMember."Primary Identification Type"::"Huduma/Maisha Number" then begin
//                 Datum.Add('huduma_number', SearchMember."Primary Identification");
//             end else
//                 if SearchMember."Secondary Identification Type" = SearchMember."Secondary Identification Type"::"Huduma/Maisha Number" then begin
//                     Datum.Add('huduma_number', SearchMember."Secondary Identification");
//                 end else begin
//                     Datum.Add('huduma_number', '');
//                 end;

//             Datum.Add('citizenship', SearchMember.Nationality);
//             Datum.Add('language', '');
//             Datum.Add('full_name', SearchMember.Name);
//             Datum.Add('date_of_birth', GlobalFunctions.FormatISODate(SearchMember."Date of Birth"));
//             Datum.Add('phone', SearchMember."Phone No.");
//             Datum.Add('email', SearchMember."E-Mail");
//             Datum.Add('tsc_or_pf_number', SearchMember."Payroll/Staff No.");
//             Datum.Add('staff_number', SearchMember."Payroll/Staff No.");
//             Datum.Add('employer_code', SearchMember."Employer Code");
//             Datum.Add('employer_name', SearchMember."Employer Name");
//             Datum.Add('po_box_code', SearchMember."Post Code");
//             Datum.Add('po_box_town', SearchMember.City);
//             Datum.Add('status', Format(SearchMember.Status).ToUpper);
//             Datum.Add('sub_flag', Format(SearchMember.Subflag));
//             // Datum.Add('is_onboarded_through_mwalimu_smart', false); // TODO ...
//             Datum.Add('onboarded_at', GlobalFunctions.FormatISODate(SearchMember."Registration Date"));
//             Datum.Add('has_physical_disability', SearchMember."Any Physical Disability");
//             Datum.Add('branch_name', SearchMember."Branch Name");

//             ResponseObject.Add('result_code', 0);
//             ResponseObject.Add('result_message', 'Success');
//         end else begin
//             ResponseObject.Add('result_code', 400);
//             ResponseObject.Add('result_message', 'Member NOT found');
//             Datum.Add('error_message', 'Member with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
//         end;

//         ResponseObject.Add('data', Datum);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure RegisterMemberApplicationStatusCallback(Payload: JsonObject; APIRequestID: JsonToken): Text
//     var
//         attach_by: JsonToken;
//         attach_value: JsonToken;
//         callback_url: JsonToken;

//         SearchMemberApplication: Record "Member Application";

//         ResponseObject: JsonObject;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         Payload.Get('attach_by', attach_by); // id_number, passport_number, *member_number, phone_number
//         Payload.Get('attach_value', attach_value);
//         Payload.Get('callback_url', callback_url);

//         SearchMemberApplication.Reset;

//         case attach_by.AsValue.AsText of
//             'phone_number':
//                 SearchMemberApplication.SetRange("Phone No.", attach_value.AsValue.AsText);
//             'member_number':
//                 SearchMemberApplication.SetRange("No.", attach_value.AsValue.AsText);
//             'id_number':
//                 begin
//                     SearchMemberApplication.SetRange("Primary Identification Type", SearchMemberApplication."Primary Identification Type"::"ID Number");
//                     SearchMemberApplication.SetRange("Primary Identification", attach_value.AsValue.AsText);

//                     if not SearchMemberApplication.FindFirst then begin
//                         SearchMemberApplication.Reset;
//                         SearchMemberApplication.SetRange("Secondary Identification Type", SearchMemberApplication."Secondary Identification Type"::"ID Number");
//                         SearchMemberApplication.SetRange("Secondary Identification", attach_value.AsValue.AsText);
//                     end;
//                 end;
//             'passport_number':
//                 begin
//                     SearchMemberApplication.SetRange("Primary Identification Type", SearchMemberApplication."Primary Identification Type"::"Passport No");
//                     SearchMemberApplication.SetRange("Primary Identification", attach_value.AsValue.AsText);

//                     if not SearchMemberApplication.FindFirst then begin
//                         SearchMemberApplication.Reset;
//                         SearchMemberApplication.SetRange("Secondary Identification Type", SearchMemberApplication."Secondary Identification Type"::"Passport No");
//                         SearchMemberApplication.SetRange("Secondary Identification", attach_value.AsValue.AsText);
//                     end;
//                 end;
//             else
//         end;

//         IF SearchMemberApplication.FindFirst then begin
//             SearchMemberApplication."Mwalimu Smart Callback URL" := callback_url.AsValue.AsText;

//             SearchMemberApplication.Modify;

//             ResponseObject.Add('result_code', 0);
//             ResponseObject.Add('result_message', 'Success');
//         end else begin
//             ResponseObject.Add('result_code', 400);
//             ResponseObject.Add('result_message', 'Member application NOT found');

//             Datum.Add('error_message', 'Member application with identification ' + attach_by.AsValue.AsText + ' = ' + attach_value.AsValue.AsText + ' NOT found!');
//             ResponseObject.Add('data', Datum);
//         end;

//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure GetEmployerInstitutions(): Text
//     var
//         CustomerEmployers: Record Customer;

//         ResponseObject: JsonObject;
//         Data: JsonArray;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         CustomerEmployers.Reset;

//         CustomerEmployers.SetRange("Account Type", CustomerEmployers."Account Type"::Employer);
//         IF CustomerEmployers.FindSet then begin
//             repeat begin
//                 Datum.Add('code', CustomerEmployers."No.");
//                 Datum.Add('name', CustomerEmployers.Name);

//                 Data.Add(Datum);

//                 // Reset
//                 Datum.ReadFrom('{}');
//             end until CustomerEmployers.Next = 0;
//         end;

//         ResponseObject.Add('result_code', 0);
//         ResponseObject.Add('result_message', 'Success');
//         ResponseObject.Add('data', Data);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure GetDelegateBranches(): Text
//     var
//         ElectoralZones: Record "Electoral Zones";

//         ResponseObject: JsonObject;
//         Data: JsonArray;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         ElectoralZones.Reset;

//         // ElectoralZones.SetRange(Type, Format(ElectoralZones.Type::"Electral Zone"));

//         IF ElectoralZones.FindSet then begin
//             repeat begin
//                 Datum.Add('code', ElectoralZones.Code);
//                 Datum.Add('name', ElectoralZones."Electoral Zone Name");

//                 Data.Add(Datum);

//                 // Reset
//                 Datum.ReadFrom('{}');
//             end until ElectoralZones.Next = 0;
//         end;

//         ResponseObject.Add('result_code', 0);
//         ResponseObject.Add('result_message', 'Success');
//         ResponseObject.Add('data', Data);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure GetFOSABranches(): Text
//     var
//         DimensionValues: Record "Dimension Value";

//         ResponseObject: JsonObject;
//         Data: JsonArray;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         DimensionValues.Reset;
//         DimensionValues.SetRange("Dimension Code", 'BRANCH');

//         IF DimensionValues.FindSet then begin
//             repeat begin
//                 Datum.Add('code', DimensionValues.Code);
//                 Datum.Add('name', DimensionValues.Name);

//                 Data.Add(Datum);

//                 // Reset
//                 Datum.ReadFrom('{}');
//             end until DimensionValues.Next = 0;
//         end;

//         ResponseObject.Add('result_code', 0);
//         ResponseObject.Add('result_message', 'Success');
//         ResponseObject.Add('data', Data);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure GetCountries(): Text
//     var
//         Countries: Record "Country/Region";

//         ResponseObject: JsonObject;
//         Data: JsonArray;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         Countries.Reset;

//         IF Countries.FindSet then begin
//             repeat begin
//                 Datum.Add('code', Countries.Code);
//                 Datum.Add('name', Countries.Name);
//                 Datum.Add('iso_code', Countries."ISO Code");
//                 Datum.Add('iso_numeric_code', Countries."ISO Numeric Code");
//                 Datum.Add('eu_country_code', Countries."EU Country/Region Code");
//                 Datum.Add('intrastat_code', Countries."Intrastat Code");
//                 Datum.Add('address_format', Format(Countries."Address Format"));
//                 Datum.Add('contact_address_format', Format(Countries."Contact Address Format"));

//                 Data.Add(Datum);

//                 // Reset
//                 Datum.ReadFrom('{}');
//             end until Countries.Next = 0;
//         end;

//         ResponseObject.Add('result_code', 0);
//         ResponseObject.Add('result_message', 'Success');
//         ResponseObject.Add('data', Data);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure GetPostCodes(): Text
//     var
//         PostCodes: Record "Post Code";

//         ResponseObject: JsonObject;
//         Data: JsonArray;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         PostCodes.Reset;

//         IF PostCodes.FindSet then begin
//             repeat begin
//                 Datum.Add('code', PostCodes.Code);
//                 Datum.Add('city', PostCodes.City);
//                 Datum.Add('search_city', PostCodes."Search City");
//                 Datum.Add('country_region_code', PostCodes."Country/Region Code");
//                 Datum.Add('county', PostCodes.County);
//                 Datum.Add('time_zone', PostCodes."Time Zone");

//                 Data.Add(Datum);

//                 // Reset
//                 Datum.ReadFrom('{}');
//             end until PostCodes.Next = 0;
//         end;

//         ResponseObject.Add('result_code', 0);
//         ResponseObject.Add('result_message', 'Success');
//         ResponseObject.Add('data', Data);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure GetNokRelationships(): Text
//     var
//         NOKRelationships: Record "Relationship Types";

//         ResponseObject: JsonObject;
//         Data: JsonArray;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         NOKRelationships.Reset;

//         IF NOKRelationships.FindSet then begin
//             repeat begin
//                 Datum.Add('code', NOKRelationships.Relation);
//                 Datum.Add('relation', NOKRelationships.Relation);
//                 Datum.Add('min_age', NOKRelationships."Min. Age");
//                 Datum.Add('max_age', NOKRelationships."Max. Age");
//                 Datum.Add('maximum_count_allowed', NOKRelationships."BBF Max. Allowed");

//                 Data.Add(Datum);

//                 // Reset
//                 Datum.ReadFrom('{}');
//             end until NOKRelationships.Next = 0;
//         end;

//         ResponseObject.Add('result_code', 0);
//         ResponseObject.Add('result_message', 'Success');
//         ResponseObject.Add('data', Data);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure GetMemberNationalities(): Text
//     var
//         Countries: Record "Country/Region";

//         ResponseObject: JsonObject;
//         Data: JsonArray;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         Countries.Reset;

//         IF Countries.FindSet then begin
//             repeat begin
//                 Datum.Add('code', Countries.Code);
//                 Datum.Add('name', Countries.Name);

//                 Data.Add(Datum);

//                 // Reset
//                 Datum.ReadFrom('{}');
//             end until Countries.Next = 0;
//         end;

//         ResponseObject.Add('result_code', 0);
//         ResponseObject.Add('result_message', 'Success');
//         ResponseObject.Add('data', Data);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure GetMemberReligions(): Text
//     var
//         HRLookup: Record "HR Lookup Values";

//         ResponseObject: JsonObject;
//         Data: JsonArray;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         HRLookup.Reset;

//         HRLookup.SetRange(Type, HRLookup.Type::Religion);

//         IF HRLookup.FindSet then begin
//             repeat begin
//                 Datum.Add('code', HRLookup.Code);
//                 Datum.Add('name', HRLookup.Description);

//                 Data.Add(Datum);

//                 // Reset
//                 Datum.ReadFrom('{}');
//             end until HRLookup.Next = 0;
//         end;

//         ResponseObject.Add('result_code', 0);
//         ResponseObject.Add('result_message', 'Success');
//         ResponseObject.Add('data', Data);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure GetMemberCounties(): Text
//     var
//         Counties: Record "Segment/County/Dividend/Signat";

//         ResponseObject: JsonObject;
//         Data: JsonArray;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         Counties.Reset;

//         Counties.SetRange(Type, Counties.Type::County);

//         IF Counties.FindSet then begin
//             repeat begin
//                 Datum.Add('code', Counties.Code);
//                 Datum.Add('name', Counties.Description);

//                 Data.Add(Datum);

//                 // Reset
//                 Datum.ReadFrom('{}');
//             end until Counties.Next = 0;
//         end;

//         ResponseObject.Add('result_code', 0);
//         ResponseObject.Add('result_message', 'Success');
//         ResponseObject.Add('data', Data);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure GetMemberBankCodes(): Text
//     var
//         BankCodes: Record "Bank Code Structure";

//         ResponseObject: JsonObject;
//         Data: JsonArray;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         BankCodes.Reset;

//         BankCodes.SetRange("Parent Code", '');

//         IF BankCodes.FindSet then begin
//             repeat begin
//                 Datum.Add('code', BankCodes.Code);
//                 Datum.Add('name', BankCodes.Name);

//                 Data.Add(Datum);

//                 // Reset
//                 Datum.ReadFrom('{}');
//             end until BankCodes.Next = 0;
//         end;

//         ResponseObject.Add('result_code', 0);
//         ResponseObject.Add('result_message', 'Success');
//         ResponseObject.Add('data', Data);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure GetMemberBankBranches(Payload: JsonObject; RequestAPIId: JsonToken): Text
//     var
//         bank_code: JsonToken;

//         BankCodes: Record "Bank Code Structure";

//         ResponseObject: JsonObject;
//         Data: JsonArray;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         Payload.Get('bank_code', bank_code);

//         BankCodes.Reset;
//         BankCodes.SetRange("Parent Code", bank_code.AsValue.AsText);

//         IF BankCodes.FindSet then begin
//             repeat begin
//                 Datum.Add('code', BankCodes.Code);
//                 Datum.Add('name', BankCodes.Name);

//                 Data.Add(Datum);

//                 // Reset
//                 Datum.ReadFrom('{}');
//             end until BankCodes.Next = 0;
//         end;

//         ResponseObject.Add('result_code', 0);
//         ResponseObject.Add('result_message', 'Success');
//         ResponseObject.Add('data', Data);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure GetMemberClasses(): Text
//     var
//         MemberClasses: Record "Member Classes";

//         ResponseObject: JsonObject;
//         Data: JsonArray;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         MemberClasses.Reset;

//         IF MemberClasses.FindSet then begin
//             repeat begin
//                 Datum.Add('no', MemberClasses."No.");
//                 Datum.Add('entrance_fee', MemberClasses."Entrance Fee");
//                 Datum.Add('share_capital', MemberClasses."Share Capital");
//                 Datum.Add('max_installment', MemberClasses."Max. Installment");
//                 Datum.Add('default_share_capital', MemberClasses."Default Share Capital");
//                 Datum.Add('default_bosa_deposit', MemberClasses."Default BOSA Deposit");
//                 Datum.Add('bbf_joining_fee', MemberClasses."BBF Joining Fee");
//                 Datum.Add('is_checkoff', MemberClasses.Checkoff);
//                 Datum.Add('can_take_loan', MemberClasses."Can Take Loan");
//                 Datum.Add('acronym', MemberClasses.Acronym);
//                 Datum.Add('min_age', Format(MemberClasses."Minimum Age"));
//                 Datum.Add('member_class', Format(MemberClasses."Member Class"));

//                 Data.Add(Datum);

//                 // Reset
//                 Datum.ReadFrom('{}');
//             end until MemberClasses.Next = 0;
//         end;

//         ResponseObject.Add('result_code', 0);
//         ResponseObject.Add('result_message', 'Success');
//         ResponseObject.Add('data', Data);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure GetMemberSalutations(): Text
//     var
//         Salutations: Record "Salutation Tittles";

//         ResponseObject: JsonObject;
//         Data: JsonArray;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         Salutations.Reset;

//         Salutations.SetRange(Type, Salutations.Type::Tittle);

//         IF Salutations.FindSet then begin
//             repeat begin
//                 Datum.Add('code', Salutations.Code);
//                 Datum.Add('name', Salutations.Description);

//                 Data.Add(Datum);

//                 // Reset
//                 Datum.ReadFrom('{}');
//             end until Salutations.Next = 0;
//         end;

//         ResponseObject.Add('result_code', 0);
//         ResponseObject.Add('result_message', 'Success');
//         ResponseObject.Add('data', Data);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure SendMemberData(Payload: JsonObject; RequestAPIId: JsonToken): Text
//     var
//         first_name: JsonToken;
//         middle_name: JsonToken;
//         other_names: JsonToken;
//         current_address: JsonToken;
//         permanent_address: JsonToken;
//         phone: JsonToken;
//         transactional_mobile_no: JsonToken;
//         employer_code: JsonToken;
//         employer_name: JsonToken;
//         date_of_birth: JsonToken;
//         email: JsonToken;
//         citizenship: JsonToken;
//         payroll_staff_no: JsonToken;
//         primary_identification_type: JsonToken;
//         secondary_identification_type: JsonToken;
//         religion: JsonToken;
//         primary_identification: JsonToken;
//         secondary_identification: JsonToken;
//         marital_status: JsonToken;
//         _gender: JsonToken;
//         terms_of_employment: JsonToken;
//         post_code: JsonToken;
//         city: JsonToken;
//         county: JsonToken;
//         bank_code: JsonToken;
//         bank_branch_code: JsonToken;
//         bank_account_no: JsonToken;
//         kra_pin: JsonToken;
//         type_of_application: JsonToken;
//         principle_member: JsonToken;
//         is_self_employed: JsonToken;
//         salutation: JsonToken;
//         account_profile: JsonToken;
//         member_class: JsonToken;
//         is_from_another_sacco: JsonToken;
//         country_of_operation: JsonToken;
//         work_station: JsonToken;
//         employment_designation: JsonToken;
//         delegate_branch: JsonToken;
//         fosa_branch: JsonToken;
//         date_of_contribution_commencement: JsonToken;
//         contribution_amount: JsonToken;
//         nok_beneficiary_nominee_info: JsonToken;
//         nok_beneficiary_nominee: JsonToken;
//         nok_beneficiary_nominee_identification_type: JsonToken;
//         nok_beneficiary_nominee_identification_value: JsonToken;
//         nok_beneficiary_nominee_full_names: JsonToken;
//         nok_beneficiary_nominee_relationship: JsonToken;
//         nok_beneficiary_nominee_date_of_birth: JsonToken;
//         nok_beneficiary_nominee_address: JsonToken;
//         nok_beneficiary_nominee_mobile_no: JsonToken;
//         nok_beneficiary_nominee_email_address: JsonToken;
//         nok_beneficiary_nominee_is_next_of_kin: JsonToken;
//         nok_beneficiary_nominee_is_beneficiary: JsonToken;
//         nok_beneficiary_nominee_is_contact_person: JsonToken;
//         nok_beneficiary_nominee_is_nominee: JsonToken;
//         nok_beneficiary_nominee_allocation: JsonToken;
//         tsc_or_pf_number: JsonToken;
//         should_issue_atm_card: JsonToken;
//         should_register_mobile_banking: JsonToken;
//         loyalty_measure_recruited_by: JsonToken;
//         loyalty_measure_id_number: JsonToken;
//         status_change_callback_url: JsonToken;

//         photo: JsonToken;
//         signature: JsonToken;

//         // MSmart
//         id_serial_number: JsonToken;
//         language: JsonToken;
//         is_user_disabled: JsonToken;
//         fosa_contact_person_full_name: JsonToken;
//         fosa_contact_person_relationship: JsonToken;
//         fosa_contact_person_phone: JsonToken;
//         fosa_contact_person_po_box_code: JsonToken;
//         fosa_contact_person_po_box_town: JsonToken;
//         fosa_contact_person_po_box_town_code: JsonToken;
//         declaration_relation: JsonToken;
//         declaration_id_number: JsonToken;
//         id_card_issued_at: JsonToken;
//         id_card_place_of_birth: JsonToken;
//         id_card_place_of_live: JsonToken;
//         id_card_address: JsonToken;

//         TempBlob: Codeunit "Temp Blob";
//         OutStr: OutStream;
//         Base64Convert: Codeunit "Base64 Convert";
//         TempBlob2: Codeunit "Temp Blob";
//         OutStr2: OutStream;
//         Base64Convert2: Codeunit "Base64 Convert";

//         StoreImageRef: FieldRef;
//         StoreRecRef: RecordRef;
//         StoreImageRef2: FieldRef;
//         StoreRecRef2: RecordRef;

//         KeyExists: Boolean;

//         SeriesSetup: Record "Credit Nos. Series";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         NewNo: Code[20];
//         NewNoSeriesCode: Code[20];
//         Recruiter: Record Members;
//         RegistrationProcess: codeunit "Registration Process";

//         NewMember: Record members;

//         MemberApplication: Record "Member Application";
//         NextofKinApplication: Record "Next of KIN Application";
//         MemberImages: Record "Image Data";
//         NextOfKin: Record "Next of KIN";
//         Index: Integer;
//         ResponseObject: JsonObject;
//         ResponseData: JsonObject;
//         Errors: JsonArray;
//         Response: Text;
//     begin
//         KeyExists := Payload.Get('first_name', first_name);
//         KeyExists := Payload.Get('middle_name', middle_name);
//         KeyExists := Payload.Get('other_names', other_names);
//         KeyExists := Payload.Get('current_address', current_address);
//         KeyExists := Payload.Get('permanent_address', permanent_address);
//         KeyExists := Payload.Get('phone', phone);
//         KeyExists := Payload.Get('transactional_mobile_no', transactional_mobile_no);
//         KeyExists := Payload.Get('employer_code', employer_code);
//         KeyExists := Payload.Get('employer_name', employer_name);
//         KeyExists := Payload.Get('date_of_birth', date_of_birth);
//         KeyExists := Payload.Get('email', email);
//         KeyExists := Payload.Get('citizenship', citizenship);
//         KeyExists := Payload.Get('payroll_staff_no', payroll_staff_no);
//         KeyExists := Payload.Get('primary_identification_type', primary_identification_type);
//         KeyExists := Payload.Get('secondary_identification_type', secondary_identification_type);
//         KeyExists := Payload.Get('religion', religion);
//         KeyExists := Payload.Get('primary_identification', primary_identification);
//         KeyExists := Payload.Get('secondary_identification', secondary_identification);
//         KeyExists := Payload.Get('marital_status', marital_status);
//         KeyExists := Payload.Get('gender', _gender);
//         KeyExists := Payload.Get('terms_of_employment', terms_of_employment);
//         KeyExists := Payload.Get('post_code', post_code);
//         KeyExists := Payload.Get('city', city);
//         KeyExists := Payload.Get('county', county);
//         KeyExists := Payload.Get('bank_code', bank_code);
//         KeyExists := Payload.Get('bank_branch_code', bank_branch_code);
//         KeyExists := Payload.Get('bank_account_no', bank_account_no);
//         KeyExists := Payload.Get('kra_pin', kra_pin);
//         KeyExists := Payload.Get('loyalty_measure_recruited_by', loyalty_measure_recruited_by);
//         KeyExists := Payload.Get('loyalty_measure_id_number', loyalty_measure_id_number);
//         KeyExists := Payload.Get('is_self_employed', is_self_employed);
//         KeyExists := Payload.Get('salutation', salutation);
//         KeyExists := Payload.Get('account_profile', account_profile);
//         KeyExists := Payload.Get('member_class', member_class);
//         KeyExists := Payload.Get('is_from_another_sacco', is_from_another_sacco);
//         KeyExists := Payload.Get('country_of_operation', country_of_operation);
//         KeyExists := Payload.Get('work_station', work_station);
//         KeyExists := Payload.Get('employment_designation', employment_designation);
//         KeyExists := Payload.Get('delegate_branch', delegate_branch);
//         KeyExists := Payload.Get('fosa_branch', fosa_branch);
//         KeyExists := Payload.Get('date_of_contribution_commencement', date_of_contribution_commencement);
//         KeyExists := Payload.Get('contribution_amount', contribution_amount);
//         KeyExists := Payload.Get('nok_beneficiary_nominee_info', nok_beneficiary_nominee_info);
//         KeyExists := Payload.Get('tsc_or_pf_number', tsc_or_pf_number);
//         KeyExists := Payload.Get('should_issue_atm_card', should_issue_atm_card);
//         KeyExists := Payload.Get('should_register_mobile_banking', should_register_mobile_banking);
//         KeyExists := Payload.Get('status_change_callback_url', status_change_callback_url);

//         KeyExists := Payload.Get('type_of_application', type_of_application);
//         KeyExists := Payload.Get('principle_member', principle_member);

//         KeyExists := Payload.Get('photo', photo);
//         KeyExists := Payload.Get('signature', signature);

//         MemberApplication.Init();

//         SeriesSetup.Get;
//         SeriesSetup.TestField(SeriesSetup."Member Application Nos.");
//         NoSeriesMgt.InitSeries(SeriesSetup."Member Application Nos.", SeriesSetup."Member Application Nos.", 0D, NewNo, NewNoSeriesCode);

//         MemberApplication."No." := NewNo;
//         MemberApplication."No. Series" := NewNoSeriesCode;

//         MemberApplication."Type of Application" := "Type of Application".FromInteger(type_of_application.AsValue.AsInteger);

//         MemberApplication."First Name" := first_name.AsValue.AsText;
//         MemberApplication."Middle Name" := middle_name.AsValue.AsText;
//         MemberApplication."Other Names" := other_names.AsValue.AsText;
//         MemberApplication."Home Address" := permanent_address.AsValue.AsText;
//         MemberApplication."Current Address" := current_address.AsValue.AsText;
//         MemberApplication.Nationality := citizenship.AsValue.AsText;
//         MemberApplication."Phone No." := phone.AsValue.AsText;
//         MemberApplication.Validate("Phone No.");

//         if MemberApplication.Nationality = 'KE' then begin
//             if transactional_mobile_no.AsValue.AsText <> '' then begin
//                 if GlobalFunctions.ValidateKenyanPhoneNumber(transactional_mobile_no.AsValue.AsText) then begin
//                     MemberApplication."Transactional Mobile Number" := transactional_mobile_no.AsValue.AsText;
//                     MemberApplication.Validate("Transactional Mobile Number");
//                 end else begin
//                     Error('Transactional mobile number MUST be in the format of 254xxxxxxxxx');
//                 end;
//             end;
//         end;

//         if not employer_name.AsValue.IsNull then begin
//             MemberApplication."Employer Name" := employer_name.AsValue.AsText;
//         end;

//         if employer_code.AsValue.AsText <> '' then begin
//             MemberApplication."Employer Code" := employer_code.AsValue.AsText;
//             MemberApplication.Validate("Employer Code");
//         end;

//         MemberApplication."Member Class" := member_class.AsValue.AsText;
//         MemberApplication.Validate("Member Class");
//         if date_of_birth.AsValue.AsText <> '' then begin
//             MemberApplication."Date of Birth" := date_of_birth.AsValue.AsDate;
//             MemberApplication.Validate("Date of Birth");
//         end;
//         MemberApplication."E-Mail" := email.AsValue.AsText;
//         MemberApplication.Validate("E-Mail");
//         MemberApplication."Office E-Mail" := email.AsValue.AsText;
//         MemberApplication."Payroll/Staff No." := payroll_staff_no.AsValue.AsText;
//         MemberApplication.Validate("Payroll/Staff No.");
//         MemberApplication."Primary Identification Type" := "Identification Type".FromInteger(primary_identification_type.AsValue.AsInteger);
//         MemberApplication.Validate("Primary Identification Type");
//         MemberApplication."Primary Identification" := primary_identification.AsValue.AsText;
//         MemberApplication.Validate("Primary Identification");
//         MemberApplication."Secondary Identification" := secondary_identification.AsValue.AsText;
//         MemberApplication.Validate("Secondary Identification");

//         MemberApplication."Secondary Identification Type" := "Identification Type".FromInteger(secondary_identification_type.AsValue.AsInteger);
//         MemberApplication.Religion := religion.AsValue.AsText;
//         MemberApplication."Marital Status" := "Marital Status".FromInteger(marital_status.AsValue.AsInteger);
//         MemberApplication.Gender := "Gender".FromInteger(_gender.AsValue.AsInteger);
//         MemberApplication."Terms of Employment" := "Terms Of Employment".FromInteger(terms_of_employment.AsValue.AsInteger);
//         MemberApplication."Post Code" := post_code.AsValue.AsText;
//         MemberApplication.City := city.AsValue.AsText;
//         MemberApplication.County := county.AsValue.AsText;
//         MemberApplication."Bank Code" := bank_code.AsValue.AsText;
//         MemberApplication.Validate("Bank Code");
//         MemberApplication."Branch Code" := bank_branch_code.AsValue.AsText;
//         MemberApplication.Validate("Branch Code");

//         MemberApplication."Member Segment" := '';
//         MemberApplication."Bank Account No." := bank_account_no.AsValue.AsText;
//         MemberApplication."P.I.N Number" := kra_pin.AsValue.AsText;
//         MemberApplication.Validate("P.I.N Number");

//         case loyalty_measure_recruited_by.AsValue.AsText of
//             'STAFF':
//                 MemberApplication."Recruited by Type" := MemberApplication."Recruited by Type"::Staff;
//             'MEMBER':
//                 MemberApplication."Recruited by Type" := MemberApplication."Recruited by Type"::Others;
//             else
//                 MemberApplication."Recruited by Type" := MemberApplication."Recruited by Type"::Self;
//         end;

//         Recruiter.Reset;
//         Recruiter.SetFilter("Primary Identification Type", '=%1', Recruiter."Primary Identification Type"::"ID Number");
//         Recruiter.SetRange("Primary Identification", loyalty_measure_id_number.AsValue.AsText);

//         if Recruiter.FindFirst then begin
//             MemberApplication."Recruited By" := Recruiter."No.";
//             MemberApplication."Recruited By Name" := Recruiter.Name;
//         end else begin
//             Recruiter.Reset;
//             Recruiter.SetFilter("Secondary Identification Type", '=%1', Recruiter."Secondary Identification Type"::"ID Number");
//             Recruiter.SetRange("Secondary Identification", loyalty_measure_id_number.AsValue.AsText);

//             if Recruiter.FindFirst then begin
//                 MemberApplication."Recruited By" := Recruiter."No.";
//                 MemberApplication."Recruited By Name" := Recruiter.Name;
//             end else begin
//                 MemberApplication."Recruited By" := loyalty_measure_id_number.AsValue.AsText;
//                 MemberApplication."Recruited By Name" := '';
//             end;
//         end;
//         MemberApplication.Validate("Recruited By");

//         MemberApplication."Self Employed" := is_self_employed.AsValue.AsBoolean;
//         MemberApplication.Salutation := salutation.AsValue.AsText;
//         MemberApplication."Account Profile" := account_profile.AsValue.AsInteger;
//         // MemberApplication.Validate("Member Class");
//         MemberApplication."From Another Sacco" := is_from_another_sacco.AsValue.AsBoolean;
//         MemberApplication."Created By" := 'MWALIMU SMART';
//         MemberApplication."Office Telephone No." := phone.AsValue.AsText;
//         // MemberApplication."Transactional Mobile Number" := phone.AsValue.AsText;
//         MemberApplication."Country Of Operation" := country_of_operation.AsValue.AsText;
//         MemberApplication."Work Station" := work_station.AsValue.AsText;
//         MemberApplication."Employment Designation" := employment_designation.AsValue.AsText;
//         MemberApplication."Delegates Zone" := delegate_branch.AsValue.AsText;
//         MemberApplication.Validate("Delegates Zone");
//         MemberApplication."TSC Number" := tsc_or_pf_number.AsValue.AsText;
//         // MemberApplication."Source Aplication" := MemberApplication."Source Aplication"::"Mwalimu Smart";
//         MemberApplication."Request for ATM" := should_issue_atm_card.AsValue.AsBoolean;
//         MemberApplication."Request Mobile Banking" := should_register_mobile_banking.AsValue.AsBoolean;
//         MemberApplication."Request Mwalimu Smart" := true;

//         if date_of_contribution_commencement.AsValue.AsText <> '' then begin
//             MemberApplication."Contribution Start Date" := date_of_contribution_commencement.AsValue.AsDate;
//             MemberApplication.Validate("Contribution Start Date");
//         end;
//         if (not contribution_amount.AsValue.IsNull) then begin
//             MemberApplication."Contribution Amount" := contribution_amount.AsValue.AsDecimal;
//             MemberApplication.Validate("Contribution Amount");
//         end else begin
//             MemberApplication."Contribution Amount" := 0;
//         end;

//         MemberApplication.Status := MemberApplication.Status::Approved;
//         MemberApplication."Account Type" := MemberApplication."Account Type"::"Single Member Account";
//         MemberApplication.Validate("Account Type");
//         MemberApplication."Responsibility Center" := GlobalFunctions.GetCRMOriginationLandingDepartment(CRMOriginationType::"Member Application");
//         MemberApplication."Application Date" := DT2Date(CurrentDateTime);
//         MemberApplication."Global Dimension 1 Code" := fosa_branch.AsValue.AsText;
//         MemberApplication.Validate("Global Dimension 1 Code");
//         MemberApplication."Global Dimension 2 Code" := GlobalFunctions.GetCRMOriginationLandingDepartment(CRMOriginationType::"Member Application");
//         // MemberApplication.Validate("Global Dimension 2 Code");
//         MemberApplication."Mwalimu Smart Callback URL" := status_change_callback_url.AsValue.AsText;

//         MemberApplication.Validate("First Name");
//         MemberApplication.Validate("Middle Name");
//         MemberApplication.Validate("Other Names");

//         if date_of_birth.AsValue.AsText <> '' then begin
//             MemberApplication."Date of Birth" := date_of_birth.AsValue.AsDate;
//         end;

//         MemberApplication."CRM Created By" := 'MWALIMU SMART';
//         MemberApplication."CRM Originating Branch" := 'ONLINE';

//         MemberApplication."Type of Application" := "Type of Application".FromInteger(type_of_application.AsValue.AsInteger);
//         IF ((MemberApplication."Type of Application" = "Type of Application"::Readmission) OR (MemberApplication."Type of Application" = "Type of Application"::Nominee)) then begin
//             MemberApplication."Principle Member" := principle_member.AsValue.AsText;
//             // MemberApplication.Validate("Principle Member");
//             MemberApplication."Old Member No." := principle_member.AsValue.AsText;

//             MemberImages.Reset;

//             MemberImages.SetRange("Member No", principle_member.AsValue.AsText);

//             if MemberImages.FindFirst then begin
//                 MemberApplication.Signature := MemberImages.Signature;
//                 MemberApplication.Picture := MemberImages.Picture;
//             end;
//         end;

//         if not photo.AsValue.IsNull then begin
//             if photo.AsValue.AsText <> '' then begin
//                 // Clear(OutStr);
//                 TempBlob.CreateOutStream(OutStr);
//                 Base64Convert.FromBase64(photo.AsValue.AsText, OutStr);

//                 Clear(MemberApplication.Picture);
//                 StoreRecRef.Open(52185691);
//                 StoreImageRef := StoreRecRef.Field(MemberApplication.FieldNo(Picture));

//                 TempBlob.ToFieldRef(StoreImageRef);
//                 StoreImageRef.TestField();

//                 MemberApplication.Picture := StoreImageRef.Value;
//                 MemberApplication.TestField(Picture);
//             end;
//         end;

//         if not signature.AsValue.IsNull then begin
//             if signature.AsValue.AsText <> '' then begin
//                 // Clear(OutStr2);
//                 TempBlob2.CreateOutStream(OutStr2);
//                 Base64Convert2.FromBase64(signature.AsValue.AsText, OutStr2);

//                 // Clear(MemberApplication.Signature);
//                 // Clear(StoreRecRef2);
//                 StoreRecRef2.Open(52185691);
//                 // Clear(StoreImageRef2);
//                 StoreImageRef2 := StoreRecRef2.Field(MemberApplication.FieldNo(Signature));

//                 TempBlob2.ToFieldRef(StoreImageRef2);
//                 StoreImageRef2.TestField();

//                 MemberApplication.Signature := StoreImageRef2.Value;
//                 MemberApplication.TestField(Signature);
//             end;
//         end;

//         MemberApplication.Status := MemberApplication.Status::Open;
//         MemberApplication."IPRS Verified" := true;

//         IF MemberApplication.Insert(true) then begin
//             IF nok_beneficiary_nominee_info.IsArray then begin
//                 // Next of Kin, Nominee, BBF
//                 for Index := 0 to (nok_beneficiary_nominee_info.AsArray.Count - 1) do begin
//                     KeyExists := nok_beneficiary_nominee_info.AsArray.Get(Index, nok_beneficiary_nominee);

//                     KeyExists := nok_beneficiary_nominee.AsObject.Get('identification_type', nok_beneficiary_nominee_identification_type);
//                     KeyExists := nok_beneficiary_nominee.AsObject.Get('identification_value', nok_beneficiary_nominee_identification_value);
//                     KeyExists := nok_beneficiary_nominee.AsObject.Get('full_names', nok_beneficiary_nominee_full_names);
//                     KeyExists := nok_beneficiary_nominee.AsObject.Get('relationship', nok_beneficiary_nominee_relationship);
//                     KeyExists := nok_beneficiary_nominee.AsObject.Get('date_of_birth', nok_beneficiary_nominee_date_of_birth);
//                     KeyExists := nok_beneficiary_nominee.AsObject.Get('address', nok_beneficiary_nominee_address);
//                     KeyExists := nok_beneficiary_nominee.AsObject.Get('mobile_no', nok_beneficiary_nominee_mobile_no);
//                     KeyExists := nok_beneficiary_nominee.AsObject.Get('email_address', nok_beneficiary_nominee_email_address);
//                     KeyExists := nok_beneficiary_nominee.AsObject.Get('is_next_of_kin', nok_beneficiary_nominee_is_next_of_kin);
//                     KeyExists := nok_beneficiary_nominee.AsObject.Get('is_beneficiary', nok_beneficiary_nominee_is_beneficiary);
//                     KeyExists := nok_beneficiary_nominee.AsObject.Get('is_contact_person', nok_beneficiary_nominee_is_contact_person);
//                     KeyExists := nok_beneficiary_nominee.AsObject.Get('is_nominee', nok_beneficiary_nominee_is_nominee);
//                     KeyExists := nok_beneficiary_nominee.AsObject.Get('allocation', nok_beneficiary_nominee_allocation);

//                     NextofKinApplication.Init();

//                     NextofKinApplication."Record ID" := NewNo;
//                     NextofKinApplication."No." := Index + 1;

//                     NextofKinApplication."Identification Type" := "Identification Type".FromInteger(nok_beneficiary_nominee_identification_type.AsValue.AsInteger);
//                     NextofKinApplication.Identification := nok_beneficiary_nominee_identification_value.AsValue.AsText;
//                     NextofKinApplication.Name := nok_beneficiary_nominee_full_names.AsValue.AsText;
//                     NextofKinApplication.Relationship := nok_beneficiary_nominee_relationship.AsValue.AsText;
//                     if nok_beneficiary_nominee_date_of_birth.AsValue.AsText <> '' then begin
//                         NextofKinApplication."Date of Birth" := nok_beneficiary_nominee_date_of_birth.AsValue.AsDate;
//                     end;
//                     NextofKinApplication.Address := nok_beneficiary_nominee_address.AsValue.AsText;
//                     NextofKinApplication.Telephone := nok_beneficiary_nominee_mobile_no.AsValue.AsText;
//                     NextofKinApplication.Email := nok_beneficiary_nominee_email_address.AsValue.AsText;
//                     NextofKinApplication."Is Next of Kin" := nok_beneficiary_nominee_is_next_of_kin.AsValue.AsBoolean;
//                     NextofKinApplication."Is a Beneficiary" := nok_beneficiary_nominee_is_beneficiary.AsValue.AsBoolean;
//                     NextofKinApplication."Is Contact Person" := nok_beneficiary_nominee_is_contact_person.AsValue.AsBoolean;
//                     NextofKinApplication."Is Nominee" := nok_beneficiary_nominee_is_nominee.AsValue.AsBoolean;
//                     NextofKinApplication.Allocation := nok_beneficiary_nominee_allocation.AsValue.AsDecimal;
//                     NextofKinApplication.Deceased := NextofKin.Deceased;
//                         NextofKinApplication.Removed := NextofKin.Removed;

//                     KeyExists := NextofKinApplication.Insert(true);

//                     NextofKinApplication.Reset();
//                 end;
//             end;

//             // Next of Kin - Initialize for readmission
//             if MemberApplication."Type of Application" = "Type of Application"::Readmission then begin

//                 NextOfKin.Reset;
//                 NextOfKin.SetRange("Record ID", MemberApplication."Principle Member");

//                 if NextOfKin.FindSet then begin
//                     repeat begin
//                         NextofKinApplication.Init();

//                         NextofKinApplication."Record ID" := NewNo;
//                         NextofKinApplication."No." := Index + 1;

//                         NextofKinApplication."Identification Type" := NextOfKin."Identification Type";
//                         NextofKinApplication.Identification := NextOfKin.Identification;
//                         NextofKinApplication.Name := NextOfKin.Name;
//                         NextofKinApplication.Relationship := NextOfKin.Relationship;
//                         NextofKinApplication."Date of Birth" := NextOfKin."Date of Birth";
//                         NextofKinApplication.Address := NextofKin.Address;
//                         NextofKinApplication.Telephone := NextofKin.Telephone;
//                         NextofKinApplication.Email := NextofKin.Email;
//                         NextofKinApplication."Is Next of Kin" := NextofKin."Is Next of Kin";
//                         NextofKinApplication."Is a Beneficiary" := NextofKin."Is a Beneficiary";
//                         NextofKinApplication."Is Contact Person" := NextofKin."Is Contact Person";
//                         NextofKinApplication."Is Nominee" := NextofKin."Is Nominee";
//                         NextofKinApplication.Allocation := NextofKin.Allocation;

//                         KeyExists := NextofKinApplication.Insert(true);

//                         NextofKinApplication.Reset();
//                     end until NextOfKin.Next = 0;
//                 end;
//             end;

//             // Autocreate the member pending verification
//             RegistrationProcess.MemberRegistration(MemberApplication, false);

//             NewMember.Reset;
//             NewMember.SetRange("Application No.", MemberApplication."No.");

//             if NewMember.FindFirst then begin
//                 NewMember.Status := NewMember.Status::Open;
//                 NewMember.Subflag := NewMember.Subflag::"Pending Verification";

//                 ResponseData.Add('member_no', NewMember."No.");

//                 NewMember.Modify;
//             end else begin
//                 ResponseData.Add('member_no', '');
//             end;

//             MemberApplication.Reset();

//             MemberApplication.SetRange("No.", NewNo);
//             ResponseData.Add('application_status', Format(MemberApplication.Status));
//             ResponseData.Add('crm_no', MemberApplication."No.");

//             ResponseObject.Add('result_code', 0);
//             ResponseObject.Add('result_message', 'Membership application with application number ' + MemberApplication."No." + ' has been created successfully.');
//             ResponseObject.Add('data', ResponseData);
//             AddDateTimeToResponse(ResponseObject);

//             ResponseObject.WriteTo(Response);
//         end else begin
//             // ResponseObject.Add('status', 'ERROR');
//             // ResponseObject.Add('description', 'Unable to create membership application.');
//             // ResponseObject.Add('errors', Errors);
//             // AddDateTimeToResponse(ResponseObject);

//             // ResponseObject.WriteTo(Response);

//             Error('Unable to create membership application.');
//         end;

//         exit(Response);
//     end;

//     local procedure GetMemberData(Payload: JsonObject; RequestAPIId: JsonToken): Text
//     var
//         application_number: JsonToken;

//         SearchMember: Record "Member Application";
//         ApplicationComments: Record Comments;
//         BankCode: Record "Bank Code Structure";
//         ElectoralZone: Record "Electoral Zones";
//         Country: Record "Country/Region";
//         County: Record "Segment/County/Dividend/Signat";
//         // SearchMemberImageData: Record "Image Data";

//         NextofKinApplication: Record "Next of KIN Application";

//         Base64Convert: Codeunit "Base64 Convert";
//         TempBlob: Codeunit "Temp Blob";
//         InStr: InStream;

//         NOKs: JsonArray;
//         NOK: JsonObject;

//         ResponseObject: JsonObject;
//         Datum: JsonObject;
//         Comments: JsonArray;
//         Comment: JsonObject;
//         Response: Text;
//     begin
//         Payload.Get('crm_no', application_number);

//         SearchMember.Reset;
//         SearchMember.SetRange("No.", application_number.AsValue.AsText);

//         IF SearchMember.FindFirst() then begin
//             SearchMember.CalcFields(
//                 "Supervisor ID",
//                 "Responsible Officer",
//                 "Employer Name",
//                 "Branch Name",
//                 "Activity Name",
//                 Picture,
//                 Signature);

//             Datum.Add('crm_no', SearchMember."No.");
//             Datum.Add('first_name', SearchMember."First Name");
//             Datum.Add('middle_name', SearchMember."Middle Name");
//             Datum.Add('other_names', SearchMember."Other Names");
//             Datum.Add('current_address', SearchMember."Current Address");
//             Datum.Add('permanent_address', SearchMember."Home Address");
//             Datum.Add('phone', SearchMember."Phone No.");
//             Datum.Add('transactional_mobile_no', SearchMember."Transactional Mobile Number");
//             Datum.Add('employer_code', SearchMember."Employer Code");
//             Datum.Add('employer_name', SearchMember."Employer Name");
//             Datum.Add('date_of_birth', GlobalFunctions.FormatISODate(SearchMember."Date of Birth"));
//             Datum.Add('email', SearchMember."E-Mail");
//             Datum.Add('citizenship', SearchMember.Nationality);
//             Datum.Add('payroll_staff_no', SearchMember."Payroll/Staff No.");
//             Datum.Add('primary_identification_type', SearchMember."Primary Identification Type".AsInteger);
//             Datum.Add('primary_identification_type_desc', Format(SearchMember."Primary Identification Type"));
//             Datum.Add('primary_identification', SearchMember."Primary Identification");
//             Datum.Add('secondary_identification_type', SearchMember."Secondary Identification Type".AsInteger);
//             Datum.Add('secondary_identification_type_desc', Format(SearchMember."Secondary Identification Type"));
//             Datum.Add('secondary_identification', SearchMember."Secondary Identification");
//             Datum.Add('religion', SearchMember.Religion);
//             Datum.Add('marital_status', SearchMember."Marital Status".AsInteger);
//             Datum.Add('marital_status_desc', Format(SearchMember."Marital Status"));
//             Datum.Add('gender', SearchMember.Gender.AsInteger);
//             Datum.Add('gender_desc', Format(SearchMember.Gender));
//             Datum.Add('terms_of_employment', SearchMember."Terms of Employment".AsInteger);
//             Datum.Add('terms_of_employment_desc', Format(SearchMember."Terms of Employment"));
//             Datum.Add('post_code', SearchMember."Post Code");
//             Datum.Add('city', SearchMember.City);
//             Datum.Add('county', SearchMember.County);
//             County.Reset;
//             County.SetRange(Type, County.Type::County);
//             if County.FindFirst then begin
//                 Datum.Add('county_desc', County.Description);
//             end else begin
//                 Datum.Add('county_desc', '');
//             end;
//             Datum.Add('sub_county', SearchMember."Sub-County");
//             County.Reset;
//             County.SetRange(Type, County.Type::"Sub-County");
//             if County.FindFirst then begin
//                 Datum.Add('sub_county_desc', County.Description);
//             end else begin
//                 Datum.Add('sub_county_desc', '');
//             end;
//             Datum.Add('bank_code', SearchMember."Bank Code");
//             BankCode.Reset;
//             BankCode.SetRange("Parent Code", '');
//             BankCode.SetRange(Code, SearchMember."Bank Code");
//             if BankCode.FindFirst then begin
//                 Datum.Add('bank_code_desc', BankCode.Name);
//             end else begin
//                 Datum.Add('bank_code_desc', '');
//             end;
//             Datum.Add('bank_branch_code', SearchMember."Branch Code");
//             BankCode.Reset;
//             BankCode.SetRange("Parent Code", SearchMember."Bank Code");
//             BankCode.SetRange(Code, SearchMember."Branch Code");
//             if BankCode.FindFirst then begin
//                 Datum.Add('bank_branch_code_desc', BankCode.Name);
//             end else begin
//                 Datum.Add('bank_branch_code_desc', '');
//             end;
//             Datum.Add('bank_account_no', SearchMember."Bank Account No.");
//             Datum.Add('kra_pin', SearchMember."P.I.N Number");
//             Datum.Add('loyalty_measure_recruited_by', SearchMember."Recruited By Type".AsInteger);
//             Datum.Add('loyalty_measure_recruited_by_desc', Format(SearchMember."Recruited By Type"));
//             Datum.Add('loyalty_measure_id_number', SearchMember."Recruited By");
//             Datum.Add('loyalty_measure_id_number_name', SearchMember."Recruited By Name");
//             Datum.Add('is_self_employed', SearchMember."Self Employed");
//             Datum.Add('salutation', SearchMember.Salutation);
//             Datum.Add('account_profile', SearchMember."Account Profile");
//             Datum.Add('account_profile_desc', Format(SearchMember."Account Profile"));
//             Datum.Add('member_class', SearchMember."Member Class");
//             Datum.Add('is_from_another_sacco', SearchMember."From Another Sacco");
//             Datum.Add('country_of_operation', SearchMember."Country Of Operation");
//             Country.Reset;
//             Country.SetRange(Code, SearchMember."Country Of Operation");
//             if Country.FindFirst then begin
//                 Datum.Add('country_of_operation_desc', Country.Name);
//             end else begin
//                 Datum.Add('country_of_operation_desc', '');
//             end;
//             Datum.Add('work_station', SearchMember."Work Station");
//             Datum.Add('employment_designation', SearchMember."Employment Designation");
//             Datum.Add('delegate_branch', SearchMember."Delegates Zone");

//             ElectoralZone.Reset;
//             ElectoralZone.SetRange(Code, SearchMember."Delegates Zone");

//             if ElectoralZone.FindFirst then begin
//                 Datum.Add('delegate_branch_desc', ElectoralZone."Electoral Zone Name");
//             end else begin
//                 Datum.Add('delegate_branch_desc', '');
//             end;
//             Datum.Add('fosa_branch', SearchMember."Global Dimension 1 Code");
//             Datum.Add('fosa_branch_name', SearchMember."Branch Name");
//             Datum.Add('activity_code', SearchMember."Global Dimension 2 Code");
//             Datum.Add('activity_name', SearchMember."Activity Name");
//             Datum.Add('date_of_contribution_commencement', SearchMember."Contribution Start Date");
//             Datum.Add('contribution_amount', SearchMember."Contribution Amount");
//             Datum.Add('tsc_or_pf_number', SearchMember."TSC Number");
//             Datum.Add('should_issue_atm_card', SearchMember."Request for ATM");
//             Datum.Add('should_register_mobile_banking', SearchMember."Request Mobile Banking");
//             Datum.Add('status_change_callback_url', SearchMember."Mwalimu Smart Callback URL");
//             Datum.Add('type_of_application', SearchMember."Type of Application".AsInteger);
//             Datum.Add('type_of_application_desc', Format(SearchMember."Type of Application"));
//             Datum.Add('principle_member', SearchMember."Principle Member");

//             // Picture
//             TempBlob.FromRecord(SearchMember, SearchMember.FieldNo(Picture));
//             TempBlob.CreateInStream(InStr);
//             Datum.Add('photo', Base64Convert.ToBase64(InStr));

//             // Signature
//             TempBlob.FromRecord(SearchMember, SearchMember.FieldNo(Signature));
//             TempBlob.CreateInStream(InStr);
//             Datum.Add('signature', Base64Convert.ToBase64(InStr));

//             NextofKinApplication.Reset;
//             NextofKinApplication.SetRange("Record ID", SearchMember."No.");

//             if NextofKinApplication.FindSet then begin
//                 repeat begin
//                     NOK.Add('identification_type', NextofKinApplication."Identification Type".AsInteger);
//                     NOK.Add('identification_type_desc', Format(NextofKinApplication."Identification Type"));
//                     NOK.Add('identification_value', NextofKinApplication.Identification);
//                     NOK.Add('full_names', NextofKinApplication.Name);
//                     NOK.Add('relationship', NextofKinApplication.Relationship);
//                     NOK.Add('date_of_birth', NextofKinApplication."Date of Birth");
//                     NOK.Add('address', NextofKinApplication.Address);
//                     NOK.Add('mobile_no', NextofKinApplication.Telephone);
//                     NOK.Add('email_address', NextofKinApplication.Email);
//                     NOK.Add('is_next_of_kin', NextofKinApplication."Is Next of Kin");
//                     NOK.Add('is_beneficiary', NextofKinApplication."Is a Beneficiary");
//                     NOK.Add('is_contact_person', NextofKinApplication."Is Contact Person");
//                     NOK.Add('is_nominee', NextofKinApplication."Is Nominee");
//                     NOK.Add('allocation', NextofKinApplication.Allocation);

//                     NOKs.Add(NOK);

//                     // Reset
//                     NOK.ReadFrom('{}');
//                 end until NextofKinApplication.Next = 0;
//             end;
//             Datum.Add('nok_beneficiary_nominee_info', NOKs);


//             // SearchMember.CalcFields("Member No.");
//             // Datum.Add('member_no', SearchMember."Member No.");

//             // Datum.Add('name', SearchMember.Name);
//             // Datum.Add('passport_expiry_date', SearchMember."Passport Expiry Date");
//             // Datum.Add('office_telephone_number', SearchMember."Office Telephone No.");
//             // Datum.Add('currency_code', SearchMember."Currency Code");
//             // Datum.Add('status', SearchMember.Status.AsInteger);
//             // Datum.Add('status_desc', Format(SearchMember.Status));

//             // Datum.Add('group_account_no', SearchMember."Group Account No.");
//             // Datum.Add('account_type', SearchMember."Account Type");
//             // Datum.Add('account_type_desc', Format(SearchMember."Account Type"));
//             // Datum.Add('created_by', SearchMember."Created By");
//             // Datum.Add('old_member_no', SearchMember."Old Member No.");
//             // Datum.Add('company_registration_no', SearchMember."Company Registration No.");
//             // Datum.Add('responsible_officer', SearchMember."Responsible Officer");
//             // Datum.Add('supervisor_id', SearchMember."Supervisor ID");
//             // Datum.Add('allocated_officer', SearchMember."Allocated Officer");
//             // Datum.Add('allocated_officer_name', SearchMember."Allocated Officer Name");
//             // Datum.Add('is_sent_back_to_crm', SearchMember."Sent Back to CRM");
//             // Datum.Add('permanent_address', SearchMember."Home Address");
//             // Datum.Add('source_of_application', SearchMember."Source Aplication");
//             // Datum.Add('source_of_application_desc', Format(SearchMember."Source Aplication")); 

//             Datum.Add('is_sent_back_to_msmart', SearchMember."Sent Back to M-Smart");
//             Datum.Add('created_at', SearchMember.SystemCreatedAt);
//             Datum.Add('modified_at', SearchMember.SystemModifiedAt);
//         end else begin
//             Error('Member application with number %1 NOT found.', application_number.AsValue.AsText);
//         end;

//         ResponseObject.Add('status', 'SUCCESS');
//         ResponseObject.Add('description', 'Request is successful');
//         ResponseObject.Add('data', Datum);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure UpdateMemberData(Payload: JsonObject; RequestAPIId: JsonToken): Text
//     var
//         crm_no: JsonToken;
//         first_name: JsonToken;
//         middle_name: JsonToken;
//         other_names: JsonToken;
//         current_address: JsonToken;
//         permanent_address: JsonToken;
//         phone: JsonToken;
//         transactional_mobile_no: JsonToken;
//         employer_code: JsonToken;
//         employer_name: JsonToken;
//         date_of_birth: JsonToken;
//         email: JsonToken;
//         citizenship: JsonToken;
//         payroll_staff_no: JsonToken;
//         primary_identification_type: JsonToken;
//         secondary_identification_type: JsonToken;
//         religion: JsonToken;
//         primary_identification: JsonToken;
//         secondary_identification: JsonToken;
//         marital_status: JsonToken;
//         _gender: JsonToken;
//         terms_of_employment: JsonToken;
//         post_code: JsonToken;
//         city: JsonToken;
//         county: JsonToken;
//         bank_code: JsonToken;
//         bank_branch_code: JsonToken;
//         bank_account_no: JsonToken;
//         kra_pin: JsonToken;
//         type_of_application: JsonToken;
//         principle_member: JsonToken;
//         is_self_employed: JsonToken;
//         salutation: JsonToken;
//         account_profile: JsonToken;
//         member_class: JsonToken;
//         is_from_another_sacco: JsonToken;
//         country_of_operation: JsonToken;
//         work_station: JsonToken;
//         employment_designation: JsonToken;
//         delegate_branch: JsonToken;
//         fosa_branch: JsonToken;
//         date_of_contribution_commencement: JsonToken;
//         contribution_amount: JsonToken;
//         nok_beneficiary_nominee_info: JsonToken;
//         nok_beneficiary_nominee: JsonToken;
//         nok_beneficiary_nominee_identification_type: JsonToken;
//         nok_beneficiary_nominee_identification_value: JsonToken;
//         nok_beneficiary_nominee_full_names: JsonToken;
//         nok_beneficiary_nominee_relationship: JsonToken;
//         nok_beneficiary_nominee_date_of_birth: JsonToken;
//         nok_beneficiary_nominee_address: JsonToken;
//         nok_beneficiary_nominee_mobile_no: JsonToken;
//         nok_beneficiary_nominee_email_address: JsonToken;
//         nok_beneficiary_nominee_is_next_of_kin: JsonToken;
//         nok_beneficiary_nominee_is_beneficiary: JsonToken;
//         nok_beneficiary_nominee_is_contact_person: JsonToken;
//         nok_beneficiary_nominee_is_nominee: JsonToken;
//         nok_beneficiary_nominee_allocation: JsonToken;
//         tsc_or_pf_number: JsonToken;
//         should_issue_atm_card: JsonToken;
//         should_register_mobile_banking: JsonToken;
//         loyalty_measure_recruited_by: JsonToken;
//         loyalty_measure_id_number: JsonToken;
//         status_change_callback_url: JsonToken;

//         photo: JsonToken;
//         signature: JsonToken;

//         // MSmart
//         id_serial_number: JsonToken;
//         language: JsonToken;
//         is_user_disabled: JsonToken;
//         fosa_contact_person_full_name: JsonToken;
//         fosa_contact_person_relationship: JsonToken;
//         fosa_contact_person_phone: JsonToken;
//         fosa_contact_person_po_box_code: JsonToken;
//         fosa_contact_person_po_box_town: JsonToken;
//         fosa_contact_person_po_box_town_code: JsonToken;
//         declaration_relation: JsonToken;
//         declaration_id_number: JsonToken;
//         id_card_issued_at: JsonToken;
//         id_card_place_of_birth: JsonToken;
//         id_card_place_of_live: JsonToken;
//         id_card_address: JsonToken;

//         TempBlob: Codeunit "Temp Blob";
//         OutStr: OutStream;
//         Base64Convert: Codeunit "Base64 Convert";
//         TempBlob2: Codeunit "Temp Blob";
//         OutStr2: OutStream;
//         Base64Convert2: Codeunit "Base64 Convert";

//         StoreImageRef: FieldRef;
//         StoreRecRef: RecordRef;
//         StoreImageRef2: FieldRef;
//         StoreRecRef2: RecordRef;

//         KeyExists: Boolean;

//         Recruiter: Record Members;

//         MemberApplication: Record "Member Application";
//         NextofKinApplication: Record "Next of KIN Application";
//         MemberImages: Record "Image Data";
//         NextOfKin: Record "Next of KIN";
//         Index: Integer;
//         ResponseObject: JsonObject;
//         ResponseData: JsonObject;
//         Errors: JsonArray;
//         Response: Text;
//     begin
//         KeyExists := Payload.Get('crm_no', crm_no);
//         KeyExists := Payload.Get('first_name', first_name);
//         KeyExists := Payload.Get('middle_name', middle_name);
//         KeyExists := Payload.Get('other_names', other_names);
//         KeyExists := Payload.Get('current_address', current_address);
//         KeyExists := Payload.Get('permanent_address', permanent_address);
//         KeyExists := Payload.Get('phone', phone);
//         KeyExists := Payload.Get('transactional_mobile_no', transactional_mobile_no);
//         KeyExists := Payload.Get('employer_code', employer_code);
//         KeyExists := Payload.Get('employer_name', employer_name);
//         KeyExists := Payload.Get('date_of_birth', date_of_birth);
//         KeyExists := Payload.Get('email', email);
//         KeyExists := Payload.Get('citizenship', citizenship);
//         KeyExists := Payload.Get('payroll_staff_no', payroll_staff_no);
//         KeyExists := Payload.Get('primary_identification_type', primary_identification_type);
//         KeyExists := Payload.Get('secondary_identification_type', secondary_identification_type);
//         KeyExists := Payload.Get('religion', religion);
//         KeyExists := Payload.Get('primary_identification', primary_identification);
//         KeyExists := Payload.Get('secondary_identification', secondary_identification);
//         KeyExists := Payload.Get('marital_status', marital_status);
//         KeyExists := Payload.Get('gender', _gender);
//         KeyExists := Payload.Get('terms_of_employment', terms_of_employment);
//         KeyExists := Payload.Get('post_code', post_code);
//         KeyExists := Payload.Get('city', city);
//         KeyExists := Payload.Get('county', county);
//         KeyExists := Payload.Get('bank_code', bank_code);
//         KeyExists := Payload.Get('bank_branch_code', bank_branch_code);
//         KeyExists := Payload.Get('bank_account_no', bank_account_no);
//         KeyExists := Payload.Get('kra_pin', kra_pin);
//         KeyExists := Payload.Get('loyalty_measure_recruited_by', loyalty_measure_recruited_by);
//         KeyExists := Payload.Get('loyalty_measure_id_number', loyalty_measure_id_number);
//         KeyExists := Payload.Get('is_self_employed', is_self_employed);
//         KeyExists := Payload.Get('salutation', salutation);
//         KeyExists := Payload.Get('account_profile', account_profile);
//         KeyExists := Payload.Get('member_class', member_class);
//         KeyExists := Payload.Get('is_from_another_sacco', is_from_another_sacco);
//         KeyExists := Payload.Get('country_of_operation', country_of_operation);
//         KeyExists := Payload.Get('work_station', work_station);
//         KeyExists := Payload.Get('employment_designation', employment_designation);
//         KeyExists := Payload.Get('delegate_branch', delegate_branch);
//         KeyExists := Payload.Get('fosa_branch', fosa_branch);
//         KeyExists := Payload.Get('date_of_contribution_commencement', date_of_contribution_commencement);
//         KeyExists := Payload.Get('contribution_amount', contribution_amount);
//         KeyExists := Payload.Get('nok_beneficiary_nominee_info', nok_beneficiary_nominee_info);
//         KeyExists := Payload.Get('tsc_or_pf_number', tsc_or_pf_number);
//         KeyExists := Payload.Get('should_issue_atm_card', should_issue_atm_card);
//         KeyExists := Payload.Get('should_register_mobile_banking', should_register_mobile_banking);
//         KeyExists := Payload.Get('status_change_callback_url', status_change_callback_url);

//         KeyExists := Payload.Get('type_of_application', type_of_application);
//         KeyExists := Payload.Get('principle_member', principle_member);

//         KeyExists := Payload.Get('photo', photo);
//         KeyExists := Payload.Get('signature', signature);

//         MemberApplication.Reset;

//         MemberApplication.SetRange("No.", crm_no.AsValue.AsText);
//         MemberApplication.SetRange("Sent Back to M-Smart", true);

//         if MemberApplication.FindFirst then begin
//             MemberApplication."Type of Application" := "Type of Application".FromInteger(type_of_application.AsValue.AsInteger);
//             IF ((MemberApplication."Type of Application" = "Type of Application"::Readmission) OR (MemberApplication."Type of Application" = "Type of Application"::Nominee)) then begin
//                 MemberApplication."Principle Member" := principle_member.AsValue.AsText;
//                 // MemberApplication.Validate("Principle Member");
//                 MemberApplication."Old Member No." := principle_member.AsValue.AsText;

//                 MemberImages.Reset;

//                 MemberImages.SetRange("Member No", principle_member.AsValue.AsText);

//                 if MemberImages.FindFirst then begin
//                     MemberApplication.Signature := MemberImages.Signature;
//                     MemberApplication.Picture := MemberImages.Picture;
//                 end;
//             end;

//             if not photo.AsValue.IsNull then begin
//                 if photo.AsValue.AsText <> '' then begin
//                     Clear(OutStr);
//                     TempBlob.CreateOutStream(OutStr);
//                     Base64Convert.FromBase64(photo.AsValue.AsText, OutStr);

//                     Clear(MemberApplication.Picture);
//                     StoreRecRef.Open(52185691);
//                     StoreImageRef := StoreRecRef.Field(MemberApplication.FieldNo(Picture));

//                     TempBlob.ToFieldRef(StoreImageRef);
//                     StoreImageRef.TestField();

//                     MemberApplication.Picture := StoreImageRef.Value;
//                     MemberApplication.TestField(Picture);
//                 end else begin
//                     Clear(MemberApplication.Picture);
//                 end;
//             end else begin
//                 Clear(MemberApplication.Picture);
//             end;

//             if not signature.AsValue.IsNull then begin
//                 if signature.AsValue.AsText <> '' then begin
//                     Clear(OutStr2);
//                     TempBlob2.CreateOutStream(OutStr2);
//                     Base64Convert2.FromBase64(signature.AsValue.AsText, OutStr2);

//                     Clear(MemberApplication.Signature);
//                     Clear(StoreRecRef2);
//                     StoreRecRef2.Open(52185691);
//                     Clear(StoreImageRef2);
//                     StoreImageRef2 := StoreRecRef2.Field(MemberApplication.FieldNo(Signature));

//                     TempBlob2.ToFieldRef(StoreImageRef2);
//                     StoreImageRef2.TestField();

//                     MemberApplication.Signature := StoreImageRef2.Value;
//                     MemberApplication.TestField(Signature);
//                 end else begin
//                     Clear(MemberApplication.Signature);
//                 end;
//             end else begin
//                 Clear(MemberApplication.Signature);
//             end;

//             MemberApplication."First Name" := first_name.AsValue.AsText;
//             MemberApplication."Middle Name" := middle_name.AsValue.AsText;
//             MemberApplication."Other Names" := other_names.AsValue.AsText;
//             MemberApplication."Home Address" := permanent_address.AsValue.AsText;
//             MemberApplication."Current Address" := current_address.AsValue.AsText;
//             MemberApplication.Nationality := citizenship.AsValue.AsText;
//             MemberApplication."Phone No." := phone.AsValue.AsText;
//             MemberApplication.Validate("Phone No.");

//             if MemberApplication.Nationality = 'KE' then begin
//                 if transactional_mobile_no.AsValue.AsText <> '' then begin
//                     if GlobalFunctions.ValidateKenyanPhoneNumber(transactional_mobile_no.AsValue.AsText) then begin
//                         MemberApplication."Transactional Mobile Number" := transactional_mobile_no.AsValue.AsText;
//                         MemberApplication.Validate("Transactional Mobile Number");
//                     end else begin
//                         Error('Transactional mobile number MUST be in the format of 254xxxxxxxxx');
//                     end;
//                 end;
//             end;

//             if not employer_name.AsValue.IsNull then begin
//                 MemberApplication."Employer Name" := employer_name.AsValue.AsText;
//             end;

//             if employer_code.AsValue.AsText <> '' then begin
//                 MemberApplication."Employer Code" := employer_code.AsValue.AsText;
//                 MemberApplication.Validate("Employer Code");
//             end;

//             MemberApplication."Member Class" := member_class.AsValue.AsText;
//             MemberApplication.Validate("Member Class");

//             if date_of_birth.AsValue.AsText <> '' then begin
//                 MemberApplication."Date of Birth" := date_of_birth.AsValue.AsDate;
//                 MemberApplication.Validate("Date of Birth");
//             end;
//             MemberApplication."E-Mail" := email.AsValue.AsText;
//             MemberApplication.Validate("E-Mail");

//             MemberApplication."Office E-Mail" := email.AsValue.AsText;
//             MemberApplication."Payroll/Staff No." := payroll_staff_no.AsValue.AsText;
//             MemberApplication.Validate("Payroll/Staff No.");
//             MemberApplication."Primary Identification Type" := "Identification Type".FromInteger(primary_identification_type.AsValue.AsInteger);
//             MemberApplication.Validate("Primary Identification Type");
//             MemberApplication."Secondary Identification Type" := "Identification Type".FromInteger(secondary_identification_type.AsValue.AsInteger);
//             MemberApplication.Religion := religion.AsValue.AsText;
//             MemberApplication."Primary Identification" := primary_identification.AsValue.AsText;
//             MemberApplication.Validate("Primary Identification");
//             MemberApplication."Secondary Identification" := secondary_identification.AsValue.AsText;
//             MemberApplication.Validate("Secondary Identification");
//             MemberApplication."Marital Status" := "Marital Status".FromInteger(marital_status.AsValue.AsInteger);
//             MemberApplication.Gender := "Gender".FromInteger(_gender.AsValue.AsInteger);
//             MemberApplication."Terms of Employment" := "Terms Of Employment".FromInteger(terms_of_employment.AsValue.AsInteger);
//             MemberApplication."Post Code" := post_code.AsValue.AsText;
//             MemberApplication.City := city.AsValue.AsText;
//             MemberApplication.County := county.AsValue.AsText;
//             MemberApplication."Bank Code" := bank_code.AsValue.AsText;
//             MemberApplication.Validate("Bank Code");
//             MemberApplication."Branch Code" := bank_branch_code.AsValue.AsText;
//             MemberApplication.Validate("Branch Code");
//             MemberApplication."Member Segment" := '';
//             MemberApplication."Bank Account No." := bank_account_no.AsValue.AsText;
//             MemberApplication."P.I.N Number" := kra_pin.AsValue.AsText;
//             MemberApplication.Validate("P.I.N Number");

//             case loyalty_measure_recruited_by.AsValue.AsText of
//                 'STAFF':
//                     MemberApplication."Recruited by Type" := MemberApplication."Recruited by Type"::Staff;
//                 'MEMBER':
//                     MemberApplication."Recruited by Type" := MemberApplication."Recruited by Type"::Others;
//                 else
//                     MemberApplication."Recruited by Type" := MemberApplication."Recruited by Type"::Self;
//             end;

//             Recruiter.Reset;
//             Recruiter.SetFilter("Primary Identification Type", '=%1', Recruiter."Primary Identification Type"::"ID Number");
//             Recruiter.SetFilter("Primary Identification", '=%1', loyalty_measure_id_number.AsValue.AsText);

//             if Recruiter.FindFirst then begin
//                 MemberApplication."Recruited By" := Recruiter."No.";
//                 MemberApplication."Recruited By Name" := Recruiter.Name;
//             end else begin
//                 Recruiter.Reset;
//                 Recruiter.SetFilter("Secondary Identification Type", '=%1', Recruiter."Secondary Identification Type"::"ID Number");
//                 Recruiter.SetFilter("Secondary Identification", '=%1', loyalty_measure_id_number.AsValue.AsText);

//                 if Recruiter.FindFirst then begin
//                     MemberApplication."Recruited By" := Recruiter."No.";
//                     MemberApplication."Recruited By Name" := Recruiter.Name;
//                 end else begin
//                     MemberApplication."Recruited By" := loyalty_measure_id_number.AsValue.AsText;
//                     MemberApplication."Recruited By Name" := '';
//                 end;
//             end;
//             MemberApplication.Validate("Recruited By");

//             MemberApplication."Self Employed" := is_self_employed.AsValue.AsBoolean;
//             MemberApplication.Salutation := salutation.AsValue.AsText;
//             MemberApplication."Account Profile" := account_profile.AsValue.AsInteger;
//             // MemberApplication.Validate("Member Class");
//             MemberApplication."From Another Sacco" := is_from_another_sacco.AsValue.AsBoolean;
//             MemberApplication."Created By" := 'MWALIMU SMART';
//             MemberApplication."Office Telephone No." := phone.AsValue.AsText;
//             // MemberApplication."Transactional Mobile Number" := phone.AsValue.AsText;
//             MemberApplication."Country Of Operation" := country_of_operation.AsValue.AsText;
//             MemberApplication."Work Station" := work_station.AsValue.AsText;
//             MemberApplication."Employment Designation" := employment_designation.AsValue.AsText;
//             MemberApplication."Delegates Zone" := delegate_branch.AsValue.AsText;
//             MemberApplication.Validate("Delegates Zone");
//             MemberApplication."TSC Number" := tsc_or_pf_number.AsValue.AsText;
//             // MemberApplication."Source Aplication" := MemberApplication."Source Aplication"::"Mwalimu Smart";
//             MemberApplication."Request for ATM" := should_issue_atm_card.AsValue.AsBoolean;
//             MemberApplication."Request Mobile Banking" := should_register_mobile_banking.AsValue.AsBoolean;
//             MemberApplication."Request Mwalimu Smart" := true;

//             if date_of_contribution_commencement.AsValue.AsText <> '' then begin
//                 MemberApplication."Contribution Start Date" := date_of_contribution_commencement.AsValue.AsDate;
//                 MemberApplication.Validate("Contribution Start Date");
//             end;
//             if (not contribution_amount.AsValue.IsNull) then begin
//                 MemberApplication."Contribution Amount" := contribution_amount.AsValue.AsDecimal;
//                 MemberApplication.Validate("Contribution Amount");
//             end else begin
//                 MemberApplication."Contribution Amount" := 0;
//             end;

//             MemberApplication.Status := MemberApplication.Status::Approved;
//             MemberApplication."Account Type" := MemberApplication."Account Type"::"Single Member Account";
//             MemberApplication.Validate("Account Type");
//             MemberApplication."Responsibility Center" := GlobalFunctions.GetCRMOriginationLandingDepartment(CRMOriginationType::"Member Application");
//             MemberApplication."Application Date" := DT2Date(CurrentDateTime);
//             MemberApplication."Global Dimension 1 Code" := fosa_branch.AsValue.AsText;
//             MemberApplication.Validate("Global Dimension 1 Code");
//             MemberApplication."Global Dimension 2 Code" := GlobalFunctions.GetCRMOriginationLandingDepartment(CRMOriginationType::"Member Application");
//             // MemberApplication.Validate("Global Dimension 2 Code");
//             MemberApplication."Mwalimu Smart Callback URL" := status_change_callback_url.AsValue.AsText;

//             MemberApplication."Sent Back to M-Smart" := false;

//             MemberApplication.Validate("First Name");
//             MemberApplication.Validate("Middle Name");
//             MemberApplication.Validate("Other Names");

//             if date_of_birth.AsValue.AsText <> '' then begin
//                 MemberApplication."Date of Birth" := date_of_birth.AsValue.AsDate;
//             end;

//             MemberApplication."Sent Back to M-Smart" := false;
//             MemberApplication.Status := MemberApplication.Status::Open;
//             MemberApplication."IPRS Verified" := true;

//             IF MemberApplication.Modify(true) then begin
//                 IF nok_beneficiary_nominee_info.IsArray then begin
//                     NextofKinApplication.Reset();

//                     NextofKinApplication.SetRange("Record ID", MemberApplication."No.");

//                     if NextofKinApplication.FindSet then begin
//                         repeat begin
//                             KeyExists := NextofKinApplication.Delete(true);
//                         end until NextofKinApplication.Next = 0;
//                     end;

//                     // Next of Kin, Nominee, BBF
//                     for Index := 0 to (nok_beneficiary_nominee_info.AsArray.Count - 1) do begin
//                         KeyExists := nok_beneficiary_nominee_info.AsArray.Get(Index, nok_beneficiary_nominee);

//                         KeyExists := nok_beneficiary_nominee.AsObject.Get('identification_type', nok_beneficiary_nominee_identification_type);
//                         KeyExists := nok_beneficiary_nominee.AsObject.Get('identification_value', nok_beneficiary_nominee_identification_value);
//                         KeyExists := nok_beneficiary_nominee.AsObject.Get('full_names', nok_beneficiary_nominee_full_names);
//                         KeyExists := nok_beneficiary_nominee.AsObject.Get('relationship', nok_beneficiary_nominee_relationship);
//                         KeyExists := nok_beneficiary_nominee.AsObject.Get('date_of_birth', nok_beneficiary_nominee_date_of_birth);
//                         KeyExists := nok_beneficiary_nominee.AsObject.Get('address', nok_beneficiary_nominee_address);
//                         KeyExists := nok_beneficiary_nominee.AsObject.Get('mobile_no', nok_beneficiary_nominee_mobile_no);
//                         KeyExists := nok_beneficiary_nominee.AsObject.Get('email_address', nok_beneficiary_nominee_email_address);
//                         KeyExists := nok_beneficiary_nominee.AsObject.Get('is_next_of_kin', nok_beneficiary_nominee_is_next_of_kin);
//                         KeyExists := nok_beneficiary_nominee.AsObject.Get('is_beneficiary', nok_beneficiary_nominee_is_beneficiary);
//                         KeyExists := nok_beneficiary_nominee.AsObject.Get('is_contact_person', nok_beneficiary_nominee_is_contact_person);
//                         KeyExists := nok_beneficiary_nominee.AsObject.Get('is_nominee', nok_beneficiary_nominee_is_nominee);
//                         KeyExists := nok_beneficiary_nominee.AsObject.Get('allocation', nok_beneficiary_nominee_allocation);

//                         NextofKinApplication.Init();

//                         NextofKinApplication."Record ID" := MemberApplication."No.";
//                         NextofKinApplication."No." := Index + 1;

//                         NextofKinApplication."Identification Type" := "Identification Type".FromInteger(nok_beneficiary_nominee_identification_type.AsValue.AsInteger);
//                         NextofKinApplication.Identification := nok_beneficiary_nominee_identification_value.AsValue.AsText;
//                         NextofKinApplication.Name := nok_beneficiary_nominee_full_names.AsValue.AsText;
//                         NextofKinApplication.Relationship := nok_beneficiary_nominee_relationship.AsValue.AsText;
//                         if nok_beneficiary_nominee_date_of_birth.AsValue.AsText <> '' then begin
//                             NextofKinApplication."Date of Birth" := nok_beneficiary_nominee_date_of_birth.AsValue.AsDate;
//                         end;
//                         NextofKinApplication.Address := nok_beneficiary_nominee_address.AsValue.AsText;
//                         NextofKinApplication.Telephone := nok_beneficiary_nominee_mobile_no.AsValue.AsText;
//                         NextofKinApplication.Email := nok_beneficiary_nominee_email_address.AsValue.AsText;
//                         NextofKinApplication."Is Next of Kin" := nok_beneficiary_nominee_is_next_of_kin.AsValue.AsBoolean;
//                         NextofKinApplication."Is a Beneficiary" := nok_beneficiary_nominee_is_beneficiary.AsValue.AsBoolean;
//                         NextofKinApplication."Is Contact Person" := nok_beneficiary_nominee_is_contact_person.AsValue.AsBoolean;
//                         NextofKinApplication."Is Nominee" := nok_beneficiary_nominee_is_nominee.AsValue.AsBoolean;
//                         NextofKinApplication.Allocation := nok_beneficiary_nominee_allocation.AsValue.AsDecimal;
//                         NextofKinApplication.Deceased := NextofKin.Deceased;
//                         NextofKinApplication.Removed := NextofKin.Removed;

//                         KeyExists := NextofKinApplication.Insert(true);

//                         NextofKinApplication.Reset();
//                     end;
//                 end;

//                 // Next of Kin - Initialize for readmission
//                 if MemberApplication."Type of Application" = "Type of Application"::Readmission then begin

//                     NextOfKin.Reset;
//                     NextOfKin.SetRange("Record ID", MemberApplication."Principle Member");

//                     if NextOfKin.FindSet then begin
//                         repeat begin
//                             NextofKinApplication.Init();

//                             NextofKinApplication."Record ID" := MemberApplication."No.";
//                             NextofKinApplication."No." := Index + 1;

//                             NextofKinApplication."Identification Type" := NextOfKin."Identification Type";
//                             NextofKinApplication.Identification := NextOfKin.Identification;
//                             NextofKinApplication.Name := NextOfKin.Name;
//                             NextofKinApplication.Relationship := NextOfKin.Relationship;
//                             NextofKinApplication."Date of Birth" := NextOfKin."Date of Birth";
//                             NextofKinApplication.Address := NextofKin.Address;
//                             NextofKinApplication.Telephone := NextofKin.Telephone;
//                             NextofKinApplication.Email := NextofKin.Email;
//                             NextofKinApplication."Is Next of Kin" := NextofKin."Is Next of Kin";
//                             NextofKinApplication."Is a Beneficiary" := NextofKin."Is a Beneficiary";
//                             NextofKinApplication."Is Contact Person" := NextofKin."Is Contact Person";
//                             NextofKinApplication."Is Nominee" := NextofKin."Is Nominee";
//                             NextofKinApplication.Allocation := NextofKin.Allocation;

//                             KeyExists := NextofKinApplication.Insert(true);

//                             NextofKinApplication.Reset();
//                         end until NextOfKin.Next = 0;
//                     end;
//                 end;

//                 MemberApplication.Reset();

//                 ResponseData.Add('application_status', Format(MemberApplication.Status));
//                 ResponseData.Add('crm_no', MemberApplication."No.");

//                 ResponseObject.Add('result_code', 0);
//                 ResponseObject.Add('result_message', 'Membership application with application number ' + MemberApplication."No." + ' has been updated successfully.');
//                 ResponseObject.Add('data', ResponseData);
//                 AddDateTimeToResponse(ResponseObject);

//                 ResponseObject.WriteTo(Response);
//             end else begin
//                 // ResponseObject.Add('status', 'ERROR');
//                 // ResponseObject.Add('description', 'Unable to create membership application.');
//                 // ResponseObject.Add('errors', Errors);
//                 // AddDateTimeToResponse(ResponseObject);

//                 // ResponseObject.WriteTo(Response);

//                 Error('Internal Error. Unable to update membership application.');
//             end;
//         end else begin
//             Error('Membership application with number %1 NOT found or is NOT available for editing', crm_no.AsValue.AsText);
//         end;

//         exit(Response);
//     end;

//     local procedure SendEditMemberData(Payload: JsonObject; RequestAPIId: JsonToken): Text
//     var
//         member_number: JsonToken;
//         type_of_edit: JsonToken;
//         additional_information: JsonToken;

//         KeyExists: Boolean;

//         EditMember: Record Members;
//         MSmartMemberEdit: Record "M-Smart Member Edit";
//         ResponseObject: JsonObject;
//         ResponseData: JsonObject;
//         Errors: JsonArray;
//         Response: Text;
//     begin
//         KeyExists := Payload.Get('member_number', member_number);
//         KeyExists := Payload.Get('type_of_edit', type_of_edit);
//         KeyExists := Payload.Get('additional_information', additional_information);

//         EditMember.Reset();

//         EditMember.SetRange("No.", member_number.asValue.AsText);

//         IF EditMember.FindFirst then begin
//             MSmartMemberEdit.Init();

//             MSmartMemberEdit."Member No." := EditMember."No.";
//             MSmartMemberEdit.Validate("Member No.");

//             MSmartMemberEdit."Type of Edit" := type_of_edit.AsValue.AsInteger;
//             MSmartMemberEdit."Edit Information" := additional_information.AsValue.AsText;
//             MSmartMemberEdit."Change Complete" := False;

//             MSmartMemberEdit.Status := MSmartMemberEdit.Status::Open;

//             MSmartMemberEdit."Responsibility Center" := Format("Responsibility Center Enum"::RECORDS);

//             IF MSmartMemberEdit.Insert(true) then begin
//                 // CRM Comments/Notes
//                 GlobalFunctions.InsertCommentRecord(
//                     MSmartMemberEdit."No.",
//                     additional_information.AsValue.AsText,
//                     'MWALIMU SMART',
//                     MSmartMemberEdit."Global Dimension 1 Code",
//                     MSmartMemberEdit."Global Dimension 2 Code",
//                     MSmartMemberEdit."Responsibility Center",
//                     false
//                 );

//                 EDMSFunctions.EDMSScannedLog(
//                     MSmartMemberEdit."No.",
//                     "CRM Originations"::"Member Edit",
//                     MSmartMemberEdit."Member No.",
//                     'MWALIMU SMART',
//                     'ONLINE'
//                 );

//                 ResponseData.Add('application_status', Format(MSmartMemberEdit.Status));
//                 ResponseData.Add('application_number', MSmartMemberEdit."No.");

//                 ResponseObject.Add('status', 'SUCCESS');
//                 ResponseObject.Add('description', 'Member edit application with application number ' + MSmartMemberEdit."No." + ' has been created successfully.');
//                 ResponseObject.Add('data', ResponseData);
//                 AddDateTimeToResponse(ResponseObject);

//                 ResponseObject.WriteTo(Response);
//             end else begin

//                 // ResponseObject.Add('status', 'ERROR');
//                 // ResponseObject.Add('description', 'Unable to create member edit application.');
//                 // ResponseObject.Add('errors', Errors);
//                 // AddDateTimeToResponse(ResponseObject);

//                 // ResponseObject.WriteTo(Response);

//                 Error('Unable to create member edit application.');
//             end;
//         end else begin
//             Error('Unknown member with member number = %1', member_number.asValue.AsText);
//         end;

//         exit(Response);
//     end;

//     local procedure UpdateEditMemberData(Payload: JsonObject; RequestAPIId: JsonToken): Text
//     var
//         application_no: JsonToken;
//         member_number: JsonToken;
//         type_of_edit: JsonToken;
//         additional_information: JsonToken;

//         KeyExists: Boolean;

//         EditMember: Record Members;
//         MSmartMemberEdit: Record "M-Smart Member Edit";
//         ResponseObject: JsonObject;
//         ResponseData: JsonObject;
//         Errors: JsonArray;
//         Response: Text;
//     begin
//         KeyExists := Payload.Get('crm_no', application_no);
//         KeyExists := Payload.Get('member_number', member_number);
//         KeyExists := Payload.Get('type_of_edit', type_of_edit);
//         KeyExists := Payload.Get('additional_information', additional_information);

//         EditMember.Reset();

//         EditMember.SetRange("No.", member_number.asValue.AsText);

//         IF EditMember.FindFirst then begin
//             MSmartMemberEdit.Reset;

//             MSmartMemberEdit.SetRange("No.", application_no.AsValue.AsText);
//             MSmartMemberEdit.SetRange("Sent Back to M-Smart", true);

//             if MSmartMemberEdit.FindFirst then begin
//                 MSmartMemberEdit."Member No." := EditMember."No.";
//                 MSmartMemberEdit.Validate("Member No.");

//                 MSmartMemberEdit."Type of Edit" := type_of_edit.AsValue.AsInteger;
//                 MSmartMemberEdit."Edit Information" := additional_information.AsValue.AsText;
//                 MSmartMemberEdit."Change Complete" := False;

//                 MSmartMemberEdit.Status := MSmartMemberEdit.Status::Open;
//                 MSmartMemberEdit."Sent Back to M-Smart" := false;

//                 MSmartMemberEdit."Responsibility Center" := Format("Responsibility Center Enum"::RECORDS);

//                 IF MSmartMemberEdit.Modify(true) then begin
//                     // CRM Comments/Notes
//                     GlobalFunctions.InsertCommentRecord(
//                         MSmartMemberEdit."No.",
//                         additional_information.AsValue.AsText,
//                         'MWALIMU SMART',
//                         MSmartMemberEdit."Global Dimension 1 Code",
//                         MSmartMemberEdit."Global Dimension 2 Code",
//                         MSmartMemberEdit."Responsibility Center",
//                         false
//                     );

//                     ResponseData.Add('application_status', Format(MSmartMemberEdit.Status));
//                     ResponseData.Add('application_number', MSmartMemberEdit."No.");

//                     ResponseObject.Add('status', 'SUCCESS');
//                     ResponseObject.Add('description', 'Member edit application with application number ' + MSmartMemberEdit."No." + ' has been updated successfully.');
//                     ResponseObject.Add('data', ResponseData);
//                     AddDateTimeToResponse(ResponseObject);

//                     ResponseObject.WriteTo(Response);
//                 end else begin

//                     // ResponseObject.Add('status', 'ERROR');
//                     // ResponseObject.Add('description', 'Unable to create member edit application.');
//                     // ResponseObject.Add('errors', Errors);
//                     // AddDateTimeToResponse(ResponseObject);

//                     // ResponseObject.WriteTo(Response);

//                     Error('Unable to create member edit application.');
//                 end;
//             end else begin
//                 Error('Member edit application with number %1 NOT available for editing.', application_no.AsValue.AsText);
//             end;

//         end else begin
//             Error('Unknown member with member number = %1', member_number.asValue.AsText);
//         end;

//         exit(Response);
//     end;

//     local procedure GetEditMemberData(Payload: JsonObject; RequestAPIId: JsonToken): Text
//     var
//         application_number: JsonToken;

//         MSmartMemberEdit: Record "M-Smart Member Edit";
//         ApplicationComments: Record Comments;

//         Comments: JsonArray;
//         Comment: JsonObject;

//         ResponseObject: JsonObject;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         Payload.Get('crm_no', application_number);

//         MSmartMemberEdit.Reset;
//         MSmartMemberEdit.SetRange("No.", application_number.AsValue.AsText);

//         IF MSmartMemberEdit.FindFirst() then begin
//             MSmartMemberEdit.CalcFields(
//             "Responsible Officer",
//             "Member Name",
//             "Supervisor ID"
//             );

//             Datum.Add('crm_no', MSmartMemberEdit."No.");
//             Datum.Add('member_no', MSmartMemberEdit."Member No.");
//             Datum.Add('member_name', MSmartMemberEdit."Member Name");
//             Datum.Add('type_of_edit', Format(MSmartMemberEdit."Type of Edit"));
//             Datum.Add('edit_information', MSmartMemberEdit."Edit Information");
//             Datum.Add('application_date', MSmartMemberEdit."Application Date");
//             Datum.Add('responsible_officer', MSmartMemberEdit."Responsible Officer");
//             Datum.Add('created_by', MSmartMemberEdit."Created By");
//             Datum.Add('supervisor_id', MSmartMemberEdit."Supervisor ID");
//             Datum.Add('is_change_complete', MSmartMemberEdit."Change Complete");
//             Datum.Add('status', Format(MSmartMemberEdit.Status));
//             Datum.Add('is_sent_back_to_msmart', MSmartMemberEdit."Sent Back to M-Smart");

//             ApplicationComments.Reset;

//             ApplicationComments.SetRange("Header No.", MSmartMemberEdit."No.");
//             ApplicationComments.SetCurrentKey("Entry No.");
//             ApplicationComments.SetAscending("Entry No.", false);

//             if ApplicationComments.FindSet then begin
//                 repeat begin
//                     Comment.Add('comment', ApplicationComments.Comment);
//                     Comment.Add('commented_by', ApplicationComments."Commented By");
//                     Comment.Add('date_time', GlobalFunctions.FormatISODateTime(ApplicationComments.Date));
//                     Comment.Add('is_read', ApplicationComments."Viewd By Somebody Else");

//                     Comments.Add(Comment);

//                     // Reset
//                     Comment.ReadFrom('{}');
//                 end until ApplicationComments.Next = 0;
//             end;

//             Datum.Add('comments', Comments);

//             Datum.Add('created_at', MSmartMemberEdit.SystemCreatedAt);
//             Datum.Add('modified_at', MSmartMemberEdit.SystemModifiedAt);
//         end else begin
//             Error('Member edit application with number %1 NOT found.', application_number.AsValue.AsText);
//         end;

//         ResponseObject.Add('status', 'SUCCESS');
//         ResponseObject.Add('description', 'Request is successful');
//         ResponseObject.Add('data', Datum);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure GetLoanProducts(): Text
//     var
//         ActiveLoanProducts: Record "Product Factory";

//         TieredChargesLines: Record "Tiered Charges Lines";

//         ProrataBands: JsonArray;
//         ProrataBand: JsonObject;

//         ResponseObject: JsonObject;
//         Data: JsonArray;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         ActiveLoanProducts.Reset;

//         ActiveLoanProducts.SetRange("Product Class Type", ActiveLoanProducts."Product Class Type"::Loan);
//         // ActiveLoanProducts.SetRange(Status, ActiveLoanProducts.Status::Active);

//         IF ActiveLoanProducts.FindSet then begin
//             repeat begin

//                 Datum.Add('product_id', ActiveLoanProducts."Product ID");
//                 Datum.Add('loan_name', ActiveLoanProducts."Product Description");
//                 Datum.Add('product_class_type', Format(ActiveLoanProducts."Product Class Type"));
//                 Datum.Add('min_guarantors', ActiveLoanProducts."Minimum Guarantors");
//                 Datum.Add('max_guarantors', ActiveLoanProducts."Maximum Guarantors");
//                 Datum.Add('min_loan_amount', ActiveLoanProducts."Minimum Loan Amount");
//                 Datum.Add('max_loan_amount', ActiveLoanProducts."Maximum Loan Amount");
//                 Datum.Add('interest_calculation_method', Format(ActiveLoanProducts."Interest Calculation Method"));
//                 Datum.Add('installments', ActiveLoanProducts."Ordinary Default Intallments");
//                 Datum.Add('category', Format(ActiveLoanProducts.Category));
//                 Datum.Add('loan_span', Format(ActiveLoanProducts."Loan Span"));
//                 Datum.Add('repayment_mode', Format(ActiveLoanProducts."Repay Mode"));
//                 Datum.Add('source_unit', Format(ActiveLoanProducts."Source Unit"));
//                 Datum.Add('loan_front', Format(ActiveLoanProducts."Source Unit"));
//                 Datum.Add('status', Format(ActiveLoanProducts.Status));
//                 Datum.Add('min_interest_rate', ActiveLoanProducts."Interest Rate (Min.)");
//                 Datum.Add('interest_rate', ActiveLoanProducts."Interest Rate (Min.)");
//                 Datum.Add('max_interest_rate', ActiveLoanProducts."Interest Rate (Max.)");
//                 Datum.Add('deposit_multiplier', ActiveLoanProducts."Ordinary Deposits Multiplier");
//                 Datum.Add('net_salary_multiplier', ActiveLoanProducts."Net Salary Multiplier %");
//                 Datum.Add('salary_period', Format(ActiveLoanProducts."Salary Period"));
//                 Datum.Add('requires_salary_processing', ActiveLoanProducts."Requires Salary Processing");
//                 Datum.Add('saye_multiplier', ActiveLoanProducts."FosaLoan Multiplier");

//                 Datum.Add('minimum_repayment_duration', 1);
//                 Datum.Add('maximum_repayment_duration', ActiveLoanProducts."Ordinary Default Intallments");

//                 Datum.Add('minimum_balance_fosa', ActiveLoanProducts."Minimum Balance");
//                 Datum.Add('minimum_balance_percentage_fosa', ActiveLoanProducts."Account Minimum Balance[%]");

//                 Datum.Add('minimum_balance_bosa', ActiveLoanProducts."Minimum Deposit Balance");
//                 Datum.Add('minimum_balance_percentage_bosa', ActiveLoanProducts."Minimum Dep. Contribution %");

//                 Datum.Add('minimum_balance_business', ActiveLoanProducts."Minimum Deposit Balance");
//                 Datum.Add('minimum_balance_percentage_business', ActiveLoanProducts."Minimum Dep. Contribution %");

//                 if ActiveLoanProducts."Minimum Deposit Tiered" = true then begin
//                     if ActiveLoanProducts."Minimum Deposit Tiered Code" <> '' then begin
//                         TieredChargesLines.Reset;

//                         TieredChargesLines.SetCurrentKey("Lower Limit");
//                         TieredChargesLines.SetAscending("Lower Limit", true);
//                         TieredChargesLines.SetRange(Code, ActiveLoanProducts."Minimum Deposit Tiered Code");

//                         if TieredChargesLines.FindSet then begin
//                             repeat begin
//                                 ProrataBand.Add('lower_limit', TieredChargesLines."Lower Limit");
//                                 ProrataBand.Add('upper_limit', TieredChargesLines."Upper Limit");
//                                 ProrataBand.Add('flat_charge_amount', TieredChargesLines."Charge Amount");
//                                 ProrataBand.Add('uses_percentage', TieredChargesLines."Use Percentage");
//                                 ProrataBand.Add('percentage', TieredChargesLines.Percentage);

//                                 ProrataBands.Add(ProrataBand);

//                                 // Reset
//                                 ProrataBand.ReadFrom('{}');
//                             end until TieredChargesLines.Next = 0;
//                         end;
//                     end;
//                 end;

//                 Datum.Add('prorata_bands', ProrataBands);

//                 Data.Add(Datum);

//                 // Reset
//                 ProrataBands.ReadFrom('[]');
//                 Datum.ReadFrom('{}');
//             end until ActiveLoanProducts.Next = 0;
//         end;

//         ResponseObject.Add('result_code', 0);
//         ResponseObject.Add('result_message', 'Request is successful');
//         ResponseObject.Add('data', Data);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure GetLoanSectors(): Text
//     var
//         LoanSectorsMain: Record "Sectoral Classification";
//         LoanSectorsSub1: Record "Sectoral Classification";
//         LoanSectorsSub2: Record "Sectoral Classification";

//         ResponseObject: JsonObject;

//         Data: JsonArray;
//         DataSub1: JsonArray;
//         DataSub2: JsonArray;

//         Datum: JsonObject;
//         DatumSub1: JsonObject;
//         DatumSub2: JsonObject;

//         Response: Text;
//     begin
//         // Main Sector
//         LoanSectorsMain.Reset;

//         LoanSectorsMain.SetRange("Sector Level", LoanSectorsMain."Sector Level"::"Main Sector");

//         IF LoanSectorsMain.FindSet then begin
//             repeat begin
//                 Datum.Add('sector_code', LoanSectorsMain."Sector Code");
//                 Datum.Add('sector_description', LoanSectorsMain."Sector Description");
//                 Datum.Add('parent_sector', LoanSectorsMain."Parent Sector");
//                 Datum.Add('sector_level', Format(LoanSectorsMain."Sector Level"));

//                 // Sub Sector 1
//                 LoanSectorsSub1.Reset;
//                 LoanSectorsSub1.SetRange("Sector Level", LoanSectorsMain."Sector Level"::"Sub Sector Level 1");
//                 LoanSectorsSub1.SetRange("Parent Sector", LoanSectorsMain."Sector Code");

//                 IF LoanSectorsSub1.FindSet then begin
//                     repeat begin
//                         DatumSub1.Add('sector_code', LoanSectorsSub1."Sector Code");
//                         DatumSub1.Add('sector_description', LoanSectorsSub1."Sector Description");
//                         DatumSub1.Add('parent_sector', LoanSectorsSub1."Parent Sector");
//                         DatumSub1.Add('sector_level', Format(LoanSectorsSub1."Sector Level"));

//                         // Sub Sector 2
//                         LoanSectorsSub2.Reset;
//                         LoanSectorsSub2.SetRange("Sector Level", LoanSectorsMain."Sector Level"::"Sub Sector Level 2");
//                         LoanSectorsSub2.SetRange("Parent Sector", LoanSectorsSub1."Sector Code");

//                         IF LoanSectorsSub2.FindSet then begin
//                             repeat begin
//                                 DatumSub2.Add('sector_code', LoanSectorsSub2."Sector Code");
//                                 DatumSub2.Add('sector_description', LoanSectorsSub2."Sector Description");
//                                 DatumSub2.Add('parent_sector', LoanSectorsSub2."Parent Sector");
//                                 DatumSub2.Add('sector_level', Format(LoanSectorsSub2."Sector Level"));

//                                 DataSub2.Add(DatumSub2);

//                                 // Reset
//                                 DatumSub2.ReadFrom('{}');
//                             end until LoanSectorsSub2.Next = 0;
//                         end;

//                         DatumSub1.Add('sub_sectors', DataSub2);
//                         DataSub1.Add(DatumSub1);

//                         // Reset
//                         DatumSub1.ReadFrom('{}');
//                         DataSub2.ReadFrom('[]');
//                     end until LoanSectorsSub1.Next = 0;
//                 end;

//                 Datum.Add('sub_sectors', DataSub1);
//                 Data.Add(Datum);

//                 // Reset
//                 Datum.ReadFrom('{}');
//                 DataSub1.ReadFrom('[]');
//             end until LoanSectorsMain.Next = 0;
//         end;

//         ResponseObject.Add('result_code', 0);
//         ResponseObject.Add('result_message', 'Request is successful');
//         ResponseObject.Add('data', Data);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure GetLoanPurposes(): Text
//     var
//         LoanPurposes: Record "Loan Purpose";

//         ResponseObject: JsonObject;
//         Data: JsonArray;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         LoanPurposes.Reset;

//         IF LoanPurposes.FindSet then begin
//             repeat begin

//                 Datum.Add('code', LoanPurposes.Code);
//                 Datum.Add('description', LoanPurposes.Description);

//                 Data.Add(Datum);

//                 // Reset
//                 Datum.ReadFrom('{}');
//             end until LoanPurposes.Next = 0;
//         end;

//         ResponseObject.Add('result_code', 0);
//         ResponseObject.Add('result_message', 'Request is successful');
//         ResponseObject.Add('data', Data);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure SendLoanData(Payload: JsonObject; RequestAPIId: JsonToken): Text
//     var
//         member_number: JsonToken;
//         loan_product_type: JsonToken;
//         loan_requested_amount: JsonToken;
//         loan_duration: JsonToken;
//         loan_purpose: JsonToken;
//         guarantors: JsonToken;
//         sasra_main_sector: JsonToken;
//         sasra_sub_sector_1: JsonToken;
//         sasra_sub_sector_2: JsonToken;
//         status_change_callback_url: JsonToken;

//         guarantor: JsonToken;
//         guarantor_member_number: JsonToken;
//         guarantor_amount: JsonToken;

//         collaterals: JsonToken;
//         collateral: JsonToken;

//         appraisal_basic_salary: JsonToken;
//         appraisal_total_allowances: JsonToken;
//         appraisal_total_deductions: JsonToken;

//         loans_top_ups: JsonToken;
//         loans_top_up: JsonToken;

//         KeyExists: Boolean;

//         LoanApplication: Record Loans;
//         LoanProduct: Record "Product Factory";
//         Member: Record Members;
//         GuarantorsApplication: Record "Loan Guarantors and Security";
//         GuarantorSavingsAccount: Record "Savings Accounts";
//         LoanCollateral: Record "Securities Register";
//         AppraisalDetailsSetup: Record "Appraisal Salary Set-up";
//         AppraisalSalDetails: Record "Appraisal Salary Details";
//         LoansToBeCleared: Record "Loans Top up";
//         SavingsAccount: Record "Savings Accounts";
//         ResponseObject: JsonObject;
//         ResponseData: JsonObject;
//         Errors: JsonArray;
//         Response: Text;

//         LoanSS: Record Loans;
//     begin
//         KeyExists := Payload.Get('member_number', member_number);
//         KeyExists := Payload.Get('loan_product_type', loan_product_type);
//         KeyExists := Payload.Get('loan_requested_amount', loan_requested_amount);
//         KeyExists := Payload.Get('loan_duration', loan_duration);
//         KeyExists := Payload.Get('loan_purpose', loan_purpose);
//         KeyExists := Payload.Get('sasra_main_sector', sasra_main_sector);
//         KeyExists := Payload.Get('sasra_sub_sector_1', sasra_sub_sector_1);
//         KeyExists := Payload.Get('sasra_sub_sector_2', sasra_sub_sector_2);
//         KeyExists := Payload.Get('status_change_callback_url', status_change_callback_url);

//         KeyExists := Payload.Get('guarantors', guarantors);
//         KeyExists := Payload.Get('collaterals', collaterals);
//         KeyExists := Payload.Get('loans_top_ups', loans_top_ups);

//         Member.Reset;
//         Member.SetRange("No.", member_number.AsValue.AsText);

//         if Member.FindFirst then begin
//             LoanApplication.Init();

//             LoanApplication."Member No." := member_number.AsValue.AsText;
//             LoanApplication.Validate("Member No."); //

//             LoanApplication."Application Date" := DT2Date(CurrentDateTime);
//             LoanApplication.Validate("Application Date");

//             LoanApplication."Loan Product Type" := loan_product_type.AsValue.AsText;
//             LoanProduct.Reset;
//             LoanProduct.SetRange("Product ID", LoanApplication."Loan Product Type");

//             if LoanProduct.FindFirst then begin
//                 LoanApplication."Source Unit" := LoanProduct."Source Unit";
//                 LoanApplication."Loan Product Type Name" := LoanProduct."Product Description";
//             end else begin
//                 LoanApplication."Source Unit" := LoanApplication."Source Unit"::BOSA;
//                 LoanApplication."Loan Product Type Name" := '';
//             end;

//             // Validate existing loans
//             LoanSS.reset;
//             LoanSS.setrange(LoanSS."Member No.", LoanApplication."Member No.");
//             LoanSS.SetFilter(Status, '%1|%2', LoanSS.Status::Open, LoanSS.Status::Pending);
//             LoanSS.SetRange(LoanSS."Source Unit", LoanApplication."Source Unit");
//             if LoanSS.FindFirst() then begin
//                 if LoanSS."Loan No." <> LoanApplication."Loan No." then begin
//                     ResponseObject.Add('result_code', 400);
//                     ResponseObject.Add('result_message', StrSubstNo('Member has an existing loan application %1 in status: %2', LoanSS."Loan No.", LoanSS.Status));
//                     ResponseObject.Add('data', ResponseData);
//                     AddDateTimeToResponse(ResponseObject);

//                     ResponseObject.WriteTo(Response);

//                     exit(Response);
//                 end;
//             end;

//             LoanApplication."Source" := LoanApplication.Source::CREDIT;
//             LoanApplication.Validate("Loan Product Type");

//             LoanApplication.Status := LoanApplication.Status::Open;

//             case LoanApplication."Source Unit" of
//                 LoanApplication."Source Unit"::BOSA:
//                     begin
//                         LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::BOSA);
//                     end;
//                 LoanApplication."Source Unit"::FOSA:
//                     begin
//                         LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::FOSA);
//                     end;
//                 LoanApplication."Source Unit"::"BUSINESS LOANS":
//                     begin
//                         LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::BLOANS);
//                     end;
//                 LoanApplication."Source Unit"::"HR LOANS":
//                     begin
//                         LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::HR);
//                     end;
//                 else
//                     LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::BOSA);
//             end;

//             LoanApplication."Purpose of Loan" := loan_purpose.AsValue.AsText;
//             LoanApplication."Loan Appl.form No." := '';
//             LoanApplication."Comment for Exemptions" := '';

//             LoanApplication."CRM Application No." := '';
//             LoanApplication."CRM Created By" := 'MWALIMU SMART';
//             LoanApplication."CRM Originating Branch" := 'ONLINE';
//             LoanApplication."CRM Notes" := '';

//             LoanApplication.Installments := loan_duration.AsValue.AsInteger;
//             LoanApplication.Validate(Installments);

//             LoanApplication."Main Sector" := sasra_main_sector.AsValue.AsText;
//             LoanApplication.Validate("Main Sector");
//             LoanApplication."Sub Sector Level1" := sasra_sub_sector_1.AsValue.AsText;
//             LoanApplication.Validate("Sub Sector Level1");
//             LoanApplication."Sub Sector Level2" := sasra_sub_sector_2.AsValue.AsText;
//             LoanApplication.Validate("Sub Sector Level2");

//             LoanApplication."Member Name" := Member.Name;
//             LoanApplication.Validate("Member No.");

//             LoanApplication."Captured By" := 'MWALIMU SMART';
//             LoanApplication."Mwalimu Smart Callback URL" := status_change_callback_url.AsValue.AsText;
//             LoanApplication."Source Aplication" := LoanApplication."Source Aplication"::"Mwalimu Smart";

//             LoanApplication."Requested Amount" := loan_requested_amount.AsValue.AsInteger;
//             LoanApplication.Validate("Requested Amount");

//             IF LoanApplication.Insert(true) then begin
//                 LoanApplication."CRM Application No." := LoanApplication."Loan No.";
//                 LoanApplication."CRM No. Series" := LoanApplication."No. Series";

//                 LoanApplication."Global Dimension 2 Code" := LoanProduct."Global Dimension 2 Code";
//                 LoanApplication."Global Dimension 1 Code" := Member."Global Dimension 1 Code";
//                 LoanApplication.Modify;

//                 // Appraisal Information
//                 KeyExists := Payload.SelectToken('$.appraisal.basic_salary', appraisal_basic_salary);
//                 KeyExists := Payload.SelectToken('$.appraisal.total_allowances', appraisal_total_allowances);
//                 KeyExists := Payload.SelectToken('$.appraisal.total_deductions', appraisal_total_deductions);

//                 AppraisalDetailsSetup.Reset;
//                 if AppraisalDetailsSetup.Find('-') then begin
//                     repeat
//                         AppraisalSalDetails.Init;
//                         AppraisalSalDetails."Loan No" := LoanApplication."Loan No.";
//                         AppraisalSalDetails."Client Code" := Member."No.";
//                         AppraisalSalDetails.Code := AppraisalDetailsSetup.Code;
//                         AppraisalSalDetails.Description := AppraisalDetailsSetup.Description;
//                         AppraisalSalDetails.Type := AppraisalDetailsSetup.Type;

//                         case AppraisalSalDetails.Type of
//                             AppraisalSalDetails.Type::Basic:
//                                 begin
//                                     if not appraisal_basic_salary.AsValue.IsNull then begin
//                                         AppraisalSalDetails.Amount := appraisal_basic_salary.AsValue.AsDecimal;
//                                     end else begin
//                                         AppraisalSalDetails.Amount := 0;
//                                     end;
//                                 end;
//                             AppraisalSalDetails.Type::"Other Allowances":
//                                 begin
//                                     if not appraisal_total_allowances.AsValue.IsNull then begin
//                                         AppraisalSalDetails.Amount := appraisal_total_allowances.AsValue.AsDecimal;
//                                     end else begin
//                                         AppraisalSalDetails.Amount := 0;
//                                     end;
//                                 end;
//                             AppraisalSalDetails.Type::Deductions:
//                                 begin
//                                     if not appraisal_total_deductions.AsValue.IsNull then begin
//                                         AppraisalSalDetails.Amount := appraisal_total_deductions.AsValue.AsDecimal;
//                                     end else begin
//                                         AppraisalSalDetails.Amount := 0;
//                                     end;
//                                 end;
//                             else
//                                 AppraisalSalDetails.Amount := 0;
//                         end;

//                         AppraisalSalDetails.Insert(true);
//                     until AppraisalDetailsSetup.Next = 0;
//                 end;

//                 // Loans top ups
//                 if loans_top_ups.IsArray then begin
//                     foreach loans_top_up in loans_top_ups.AsArray do begin
//                         LoansToBeCleared.Init;

//                         LoansToBeCleared."Loan No." := LoanApplication."Loan No.";
//                         LoansToBeCleared."Client Code" := LoanApplication."Member No.";
//                         LoansToBeCleared."Loan Top Up" := loans_top_up.AsValue.AsText;

//                         LoansToBeCleared.Validate("Loan Top Up");
//                         LoansToBeCleared.Validate("Principle Top Up");
//                         LoansToBeCleared.Validate("Interest Top Up");

//                         LoansToBeCleared.Insert(true);
//                     end;
//                 end;

//                 // TODO: 3. Support loan buy-off process during loan application.


//                 // Guarantors
//                 foreach guarantor in guarantors.AsArray do begin
//                     guarantor.AsObject.Get('member_number', guarantor_member_number);
//                     guarantor.AsObject.Get('amount', guarantor_amount);

//                     GuarantorsApplication.Init();

//                     GuarantorsApplication."Source Application" := GuarantorsApplication."Source Application"::"Mwalimu Smart";

//                     GuarantorSavingsAccount.Reset;
//                     GuarantorSavingsAccount.SetRange("Member No.", guarantor_member_number.AsValue.AsText);
//                     GuarantorSavingsAccount.SetFilter("Product Category", '=%1', GuarantorSavingsAccount."Product Category"::"BOSA Deposits");

//                     IF GuarantorSavingsAccount.FindFirst then begin
//                         GuarantorsApplication."Loan No" := LoanApplication."Loan No.";

//                         if LoanApplication."Source Unit" = LoanApplication."Source Unit"::FOSA then begin
//                             GuarantorsApplication."Amount Guaranteed" := guarantor_amount.AsValue.AsDecimal;
//                             // GuarantorsApplication.Validate("Amount Guaranteed");
//                         end;

//                         GuarantorsApplication."Guarantor Type" := GuarantorsApplication."Guarantor Type"::Guarantor;
//                         GuarantorsApplication.Validate("Guarantor Type");

//                         GuarantorsApplication."Staff/Payroll No." := GuarantorSavingsAccount."Payroll/Staff No.";
//                         // GuarantorsApplication.Validate("Staff/Payroll No.");

//                         GuarantorsApplication.Name := GuarantorSavingsAccount.Name;
//                         GuarantorsApplication.Date := DT2Date(CurrentDateTime);
//                         GuarantorsApplication."Member No" := GuarantorSavingsAccount."Member No.";

//                         GuarantorsApplication."Savings Account No./Member No." := GuarantorSavingsAccount."No.";
//                         GuarantorsApplication.Validate("Savings Account No./Member No.");

//                         if LoanApplication."Source Unit" = LoanApplication."Source Unit"::FOSA then begin
//                             GuarantorsApplication."Amount Guaranteed" := guarantor_amount.AsValue.AsDecimal;
//                             // GuarantorsApplication.Validate("Amount Guaranteed");
//                         end;

//                         KeyExists := GuarantorsApplication.Insert();
//                     end;

//                     GuarantorsApplication.Reset();
//                 end;

//                 // Collaterals
//                 foreach collateral in collaterals.AsArray do begin
//                     LoanCollateral.Reset;
//                     LoanCollateral.SetRange("Account No.", LoanApplication."Member No.");
//                     LoanCollateral.SetRange("No.", collateral.AsValue.AsText);

//                     IF LoanCollateral.FindFirst then begin
//                         GuarantorsApplication.Init();

//                         GuarantorsApplication."Loan No" := LoanApplication."Loan No.";

//                         GuarantorsApplication."Guarantor Type" := GuarantorsApplication."Guarantor Type"::Collateral;
//                         GuarantorsApplication.Validate("Guarantor Type");

//                         GuarantorsApplication."Savings Account No./Member No." := LoanApplication."Member No.";
//                         // GuarantorsApplication.Validate("Savings Account No./Member No.");

//                         GuarantorsApplication."Collateral Reg. No." := LoanCollateral."No.";
//                         GuarantorsApplication.Validate("Collateral Reg. No.");

//                         GuarantorsApplication.Date := DT2Date(CurrentDateTime);
//                         GuarantorsApplication."Member No" := LoanApplication."Member No.";

//                         KeyExists := GuarantorsApplication.Insert();
//                     end;

//                     // LIEN ----------------------------------------------------------------

//                     SavingsAccount.Reset;

//                     SavingsAccount.SetRange(Status, SavingsAccount.Status::Active);
//                     SavingsAccount.SetRange("Member No.", LoanApplication."Member No.");
//                     SavingsAccount.SetFilter("Product Category", '=%1|%2', SavingsAccount."Product Category"::"BOSA Deposits", SavingsAccount."Product Category"::"Business Deposits");
//                     SavingsAccount.SetFilter("Lien Placed", '>%1', 0);
//                     SavingsAccount.SetRange("No.", collateral.AsValue.AsText);

//                     IF SavingsAccount.FindFirst then begin
//                         GuarantorsApplication.Init();

//                         GuarantorsApplication."Loan No" := LoanApplication."Loan No.";

//                         GuarantorsApplication."Guarantor Type" := GuarantorsApplication."Guarantor Type"::Lien;
//                         GuarantorsApplication.Validate("Guarantor Type");

//                         GuarantorsApplication."Savings Account No./Member No." := SavingsAccount."No.";
//                         // GuarantorsApplication.Validate("Savings Account No./Member No.");

//                         GuarantorsApplication.Date := DT2Date(CurrentDateTime);
//                         GuarantorsApplication."Member No" := LoanApplication."Member No.";

//                         KeyExists := GuarantorsApplication.Insert();
//                     end;

//                     GuarantorsApplication.Reset();
//                 end;

//                 LoanApplication.Reset();

//                 LoanApplication.SetRange("Loan No.", LoanApplication."Loan No.");
//                 ResponseData.Add('application_status', Format(LoanApplication.Status));
//                 ResponseData.Add('crm_no', LoanApplication."Loan No.");

//                 ResponseObject.Add('result_code', 0);
//                 ResponseObject.Add('result_message', 'Loan application with application number ' + LoanApplication."Loan No." + ' has been created successfully.');
//                 ResponseObject.Add('data', ResponseData);
//                 AddDateTimeToResponse(ResponseObject);

//                 ResponseObject.WriteTo(Response);
//             end else begin
//                 // ResponseObject.Add('status', 'ERROR');
//                 // ResponseObject.Add('description', 'Unable to create loan application.');
//                 // ResponseObject.Add('errors', Errors);
//                 // AddDateTimeToResponse(ResponseObject);

//                 // ResponseObject.WriteTo(Response);

//                 Error('Internal Error. Unable to create loan application.');
//             end;
//         end else begin
//             ResponseObject.Add('result_code', 400);
//             ResponseObject.Add('result_message', 'Unknown member with member number ' + member_number.AsValue.AsText);
//             ResponseObject.Add('data', ResponseData);
//             AddDateTimeToResponse(ResponseObject);

//             ResponseObject.WriteTo(Response);

//             // Error('Unknown member with member number ' + member_number.AsValue.AsText);
//         end;

//         exit(Response);
//     end;

//     local procedure GetLoanData(Payload: JsonObject; RequestAPIId: JsonToken): Text
//     var
//         application_number: JsonToken;

//         SearchLoan: Record Loans;
//         GuarantorsApplication: Record "Loan Guarantors and Security";
//         ApplicationComments: Record "Loan Appraisal Comments";
//         LoansTopUp: Record "Loans Top up";

//         Comments: JsonArray;
//         Comment: JsonObject;
//         Guarantors: JsonArray;
//         Guarantor: JsonObject;
//         LoansToBeCleared: JsonArray;
//         LoanToBeCleared: JsonObject;
//         Collaterals: JsonArray;
//         Collateral: JsonObject;

//         Appraisal: JsonObject;
//         AppraisalSalDetails: Record "Appraisal Salary Details";

//         ResponseObject: JsonObject;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         Payload.Get('crm_no', application_number);

//         SearchLoan.Reset;
//         SearchLoan.SetRange("Loan No.", application_number.AsValue.AsText);

//         IF SearchLoan.FindFirst() then begin
//             SearchLoan.CalcFields(
//             "Responsible Officer",
//             "Total Balance",
//             "Last Repayment Date",
//             "Total TopUp",
//             "Total Loan Balance",
//             "Last Pay Date",
//             "Loan Amount",
//             "Interest Paid",
//             "Principle Paid",
//             "Days In Arrears",
//             "Total Disbursed"
//             );

//             Datum.Add('crm_no', SearchLoan."Loan No.");
//             Datum.Add('member_number', SearchLoan."Member No.");
//             // Datum.Add('member_name', SearchLoan."Member Name");
//             Datum.Add('loan_product_type', SearchLoan."Loan Product Type");
//             // Datum.Add('loan_product_name', SearchLoan."Loan Product Type Name");
//             Datum.Add('loan_requested_amount', SearchLoan."Requested Amount");
//             Datum.Add('loan_duration', SearchLoan.Installments);
//             Datum.Add('loan_purpose', SearchLoan."Purpose of Loan");

//             // Datum.Add('total_balance', SearchLoan."Total Balance");
//             // Datum.Add('last_repayment_date', SearchLoan."Last Repayment Date");
//             // Datum.Add('topup_amount', SearchLoan."Total TopUp");
//             // Datum.Add('total_loan_balance', SearchLoan."Total Loan Balance");
//             // Datum.Add('last_payment_date', SearchLoan."Last Pay Date");
//             // Datum.Add('loan_amount', SearchLoan."Loan Amount");
//             // Datum.Add('total_interest_paid', SearchLoan."Interest Paid");
//             // Datum.Add('total_principle_paid', SearchLoan."Principle Paid");
//             // Datum.Add('days_in_arrears', SearchLoan."Days In Arrears");
//             // Datum.Add('total_disbursed_amount', SearchLoan."Total Disbursed");

//             Datum.Add('sasra_main_sector', SearchLoan."Main Sector");
//             // Datum.Add('sasra_main_sector_desc', SearchLoan."Main Sector Description");
//             Datum.Add('sasra_sub_sector_1', SearchLoan."Sub Sector Level1");
//             // Datum.Add('sasra_sub_sector_1_desc', SearchLoan."Sub Sector Level1 Description");
//             Datum.Add('sasra_sub_sector_2', SearchLoan."Sub Sector Level2");
//             // Datum.Add('sasra_sub_sector_2_desc', SearchLoan."Sub Sector Level2 Description");
//             Datum.Add('status_change_callback_url', SearchLoan."Mwalimu Smart Callback URL");

//             // Datum.Add('self_guarantee', SearchLoan."Self Guarantee");
//             // Datum.Add('application_date', GlobalFunctions.FormatDate(SearchLoan."Application Date"));
//             // Datum.Add('source_unit', SearchLoan."Source Unit");
//             // Datum.Add('source_unit_desc', Format(SearchLoan."Source Unit"));
//             // Datum.Add('captured_by', SearchLoan."Captured By");
//             // Datum.Add('status', SearchLoan.Status);
//             // Datum.Add('status_desc', Format(SearchLoan.Status));
//             // Datum.Add('responsible_officer', SearchLoan."Responsible Officer");
//             // Datum.Add('supervisor_id', SearchLoan."Approved By");
//             // Datum.Add('crm_application_no', SearchLoan."CRM Application No.");
//             // Datum.Add('crm_created_by', SearchLoan."CRM Created By");
//             // Datum.Add('crm_originating_branch', SearchLoan."CRM Originating Branch");
//             // Datum.Add('crm_notes', SearchLoan."CRM Notes");
//             Datum.Add('is_sent_back_to_msmart', SearchLoan."Sent Back to M-Smart");
//             // Datum.Add('posted', SearchLoan.Posted);
//             // Datum.Add('posted_by', SearchLoan."Posted By");
//             // Datum.Add('source_of_application', SearchLoan."Source Aplication");
//             // Datum.Add('source_of_application_desc', Format(SearchLoan."Source Aplication"));
//             // Datum.Add('loan_priority', SearchLoan."CRM Priority");
//             // Datum.Add('loan_priority_desc', Format(SearchLoan."CRM Priority"));

//             // ApplicationComments.Reset;

//             // ApplicationComments.SetRange("Loan No.", SearchLoan."Loan No.");
//             // ApplicationComments.SetCurrentKey("Entry No.");
//             // ApplicationComments.SetAscending("Entry No.", false);

//             // if ApplicationComments.FindSet then begin
//             //     repeat begin
//             //         Comment.Add('comment', ApplicationComments.Comment);
//             //         Comment.Add('commented_by', ApplicationComments.Appraiser);
//             //         Comment.Add('date_time', GlobalFunctions.FormatISODateTime(ApplicationComments.SystemCreatedAt));

//             //         Comment.Add('is_read', ApplicationComments.Commented);

//             //         Comments.Add(Comment);

//             //         // Reset
//             //         Comment.ReadFrom('{}');
//             //     end until ApplicationComments.Next = 0;
//             // end;
//             // Datum.Add('comments', Comments);

//             // Appraisal Information
//             AppraisalSalDetails.Reset;
//             AppraisalSalDetails.SetRange("Loan No", SearchLoan."Loan No.");

//             if AppraisalSalDetails.FindSet then begin
//                 Appraisal.Add('basic_salary', 0);
//                 Appraisal.Add('total_allowances', 0);
//                 Appraisal.Add('total_deductions', 0);

//                 repeat begin
//                     case AppraisalSalDetails.Type of
//                         AppraisalSalDetails.Type::Basic:
//                             Appraisal.Replace('basic_salary', AppraisalSalDetails.Amount);
//                         AppraisalSalDetails.Type::"Other Allowances":
//                             Appraisal.Replace('total_allowances', AppraisalSalDetails.Amount);
//                         AppraisalSalDetails.Type::Deductions:
//                             Appraisal.Replace('total_deductions', AppraisalSalDetails.Amount);
//                     end;
//                 end until AppraisalSalDetails.Next = 0;
//             end;
//             Datum.Add('appraisal', Appraisal);

//             // Guarantors
//             GuarantorsApplication.Reset;
//             GuarantorsApplication.SetRange("Loan No", SearchLoan."Loan No.");
//             GuarantorsApplication.SetRange("Guarantor Type", GuarantorsApplication."Guarantor Type"::Guarantor);

//             if GuarantorsApplication.FindSet then begin
//                 repeat begin
//                     Guarantor.Add('member_number', GuarantorsApplication."Member No");
//                     Guarantor.Add('amount', GuarantorsApplication."Amount Guaranteed");

//                     Guarantors.Add(Guarantor);

//                     // Reset
//                     Guarantor.ReadFrom('{}');
//                 end until GuarantorsApplication.Next = 0;
//             end;
//             Datum.Add('guarantors', Guarantors);

//             // Loans topups
//             LoansTopUp.Reset;
//             LoansTopUp.SetRange("Loan No.", SearchLoan."Loan No.");

//             if LoansTopUp.FindSet then begin
//                 repeat begin
//                     // LoanToBeCleared.Add('loan_number', LoansTopUp."Loan No.");
//                     // LoanToBeCleared.Add('loan_top_up', LoansTopUp."Loan Top Up");
//                     // LoanToBeCleared.Add('member_number', LoansTopUp."Client Code");
//                     // LoanToBeCleared.Add('loan_type', LoansTopUp."Loan Type");
//                     // LoanToBeCleared.Add('loan_product_type', LoansTopUp."Loan Product Type Name");
//                     // LoanToBeCleared.Add('principle_top_up', LoansTopUp."Principle Top Up");
//                     // LoanToBeCleared.Add('interest_top_up', LoansTopUp."Interest Top Up");
//                     // LoanToBeCleared.Add('total_top_up', LoansTopUp."Total Top Up");

//                     // LoansToBeCleared.Add(LoanToBeCleared);

//                     // // Reset
//                     // LoanToBeCleared.ReadFrom('{}');

//                     LoansToBeCleared.Add(LoansTopUp."Loan Top Up");
//                 end until LoansTopUp.Next = 0;
//             end;
//             Datum.Add('loans_top_ups', LoansToBeCleared);

//             // Collaterals
//             GuarantorsApplication.Reset;
//             GuarantorsApplication.SetRange("Loan No", SearchLoan."Loan No.");
//             GuarantorsApplication.SetRange("Guarantor Type", GuarantorsApplication."Guarantor Type"::Collateral);

//             if GuarantorsApplication.FindSet then begin
//                 repeat begin
//                     // Guarantor.Add('member_number', GuarantorsApplication."Member No");
//                     // Guarantor.Add('amount', GuarantorsApplication."Amount Guaranteed");

//                     // Guarantors.Add(Guarantor);

//                     // // Reset
//                     // Guarantor.ReadFrom('{}');

//                     Collaterals.Add(GuarantorsApplication."Collateral Reg. No.");
//                 end until GuarantorsApplication.Next = 0;
//             end;
//             Datum.Add('collaterals', Collaterals);

//             Datum.Add('created_at', SearchLoan.SystemCreatedAt);
//             Datum.Add('modified_at', SearchLoan.SystemModifiedAt);
//         end else begin
//             Error('Loan application with number %1 NOT found.', application_number.AsValue.AsText);
//         end;

//         ResponseObject.Add('status', 'SUCCESS');
//         ResponseObject.Add('description', 'Request is successful');
//         ResponseObject.Add('data', Datum);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure UpdateLoanData(Payload: JsonObject; RequestAPIId: JsonToken): Text
//     var
//         crm_no: JsonToken;
//         member_number: JsonToken;
//         loan_product_type: JsonToken;
//         loan_requested_amount: JsonToken;
//         loan_duration: JsonToken;
//         loan_purpose: JsonToken;
//         guarantors: JsonToken;
//         sasra_main_sector: JsonToken;
//         sasra_sub_sector_1: JsonToken;
//         sasra_sub_sector_2: JsonToken;
//         status_change_callback_url: JsonToken;

//         guarantor: JsonToken;
//         guarantor_member_number: JsonToken;
//         guarantor_amount: JsonToken;

//         collaterals: JsonToken;
//         collateral: JsonToken;

//         appraisal_basic_salary: JsonToken;
//         appraisal_total_allowances: JsonToken;
//         appraisal_total_deductions: JsonToken;

//         loans_top_ups: JsonToken;
//         loans_top_up: JsonToken;

//         KeyExists: Boolean;

//         LoanApplication: Record Loans;
//         LoanProduct: Record "Product Factory";
//         Member: Record Members;
//         GuarantorsApplication: Record "Loan Guarantors and Security";
//         GuarantorSavingsAccount: Record "Savings Accounts";
//         LoanCollateral: Record "Securities Register";
//         AppraisalDetailsSetup: Record "Appraisal Salary Set-up";
//         AppraisalSalDetails: Record "Appraisal Salary Details";
//         LoansToBeCleared: Record "Loans Top up";
//         SavingsAccount: Record "Savings Accounts";
//         ResponseObject: JsonObject;
//         ResponseData: JsonObject;
//         Errors: JsonArray;
//         Response: Text;
//     begin
//         KeyExists := Payload.Get('crm_no', crm_no);
//         KeyExists := Payload.Get('member_number', member_number);
//         KeyExists := Payload.Get('loan_product_type', loan_product_type);
//         KeyExists := Payload.Get('loan_requested_amount', loan_requested_amount);
//         KeyExists := Payload.Get('loan_duration', loan_duration);
//         KeyExists := Payload.Get('loan_purpose', loan_purpose);
//         KeyExists := Payload.Get('sasra_main_sector', sasra_main_sector);
//         KeyExists := Payload.Get('sasra_sub_sector_1', sasra_sub_sector_1);
//         KeyExists := Payload.Get('sasra_sub_sector_2', sasra_sub_sector_2);
//         KeyExists := Payload.Get('status_change_callback_url', status_change_callback_url);

//         KeyExists := Payload.Get('guarantors', guarantors);
//         KeyExists := Payload.Get('collaterals', collaterals);
//         KeyExists := Payload.Get('loans_top_ups', loans_top_ups);

//         LoanApplication.Reset;

//         LoanApplication.SetRange("Loan No.", crm_no.AsValue.AsText);
//         LoanApplication.SetRange("Member No.", member_number.AsValue.AsText);
//         LoanApplication.SetRange("Sent Back to M-Smart", true);

//         if LoanApplication.FindFirst then begin
//             Member.Reset;
//             Member.SetRange("No.", LoanApplication."Member No.");

//             if Member.FindFirst then begin
//                 LoanApplication."Member No." := member_number.AsValue.AsText;
//                 LoanApplication.Validate("Member No."); //

//                 LoanApplication."Application Date" := DT2Date(CurrentDateTime);
//                 LoanApplication.Validate("Application Date");

//                 LoanApplication."Loan Product Type" := loan_product_type.AsValue.AsText;
//                 LoanProduct.Reset;
//                 LoanProduct.SetRange("Product ID", LoanApplication."Loan Product Type");

//                 if LoanProduct.FindFirst then begin
//                     LoanApplication."Source Unit" := LoanProduct."Source Unit";
//                     LoanApplication."Loan Product Type Name" := LoanProduct."Product Description";
//                 end else begin
//                     LoanApplication."Source Unit" := LoanApplication."Source Unit"::BOSA;
//                     LoanApplication."Loan Product Type Name" := '';
//                 end;

//                 LoanApplication."Source" := LoanApplication.Source::CREDIT;
//                 LoanApplication.Validate("Loan Product Type");

//                 LoanApplication.Status := LoanApplication.Status::Open;

//                 case LoanApplication."Source Unit" of
//                     LoanApplication."Source Unit"::BOSA:
//                         begin
//                             LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::BOSA);
//                         end;
//                     LoanApplication."Source Unit"::FOSA:
//                         begin
//                             LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::FOSA);
//                         end;
//                     LoanApplication."Source Unit"::"BUSINESS LOANS":
//                         begin
//                             LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::BLOANS);
//                         end;
//                     LoanApplication."Source Unit"::"HR LOANS":
//                         begin
//                             LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::HR);
//                         end;
//                     else
//                         LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::BOSA);
//                 end;

//                 LoanApplication."Purpose of Loan" := loan_purpose.AsValue.AsText;
//                 LoanApplication."Loan Appl.form No." := '';
//                 LoanApplication."Comment for Exemptions" := '';

//                 LoanApplication."CRM Application No." := '';
//                 LoanApplication."CRM Created By" := 'MWALIMU SMART';
//                 LoanApplication."CRM Originating Branch" := 'ONLINE';
//                 LoanApplication."CRM Notes" := '';

//                 LoanApplication.Installments := loan_duration.AsValue.AsInteger;
//                 LoanApplication.Validate(Installments);

//                 LoanApplication."Main Sector" := sasra_main_sector.AsValue.AsText;
//                 LoanApplication.Validate("Main Sector");
//                 LoanApplication."Sub Sector Level1" := sasra_sub_sector_1.AsValue.AsText;
//                 LoanApplication.Validate("Sub Sector Level1");
//                 LoanApplication."Sub Sector Level2" := sasra_sub_sector_2.AsValue.AsText;
//                 LoanApplication.Validate("Sub Sector Level2");

//                 LoanApplication."Member Name" := Member.Name;
//                 LoanApplication.Validate("Member No.");

//                 LoanApplication."Captured By" := 'MWALIMU SMART';
//                 LoanApplication."Mwalimu Smart Callback URL" := status_change_callback_url.AsValue.AsText;
//                 LoanApplication."Source Aplication" := LoanApplication."Source Aplication"::"Mwalimu Smart";

//                 LoanApplication."Requested Amount" := loan_requested_amount.AsValue.AsInteger;
//                 LoanApplication.Validate("Requested Amount");

//                 LoanApplication."Sent Back to M-Smart" := false;

//                 IF LoanApplication.Modify(true) then begin
//                     // Appraisal Information
//                     KeyExists := Payload.SelectToken('$.appraisal.basic_salary', appraisal_basic_salary);
//                     KeyExists := Payload.SelectToken('$.appraisal.total_allowances', appraisal_total_allowances);
//                     KeyExists := Payload.SelectToken('$.appraisal.total_deductions', appraisal_total_deductions);

//                     AppraisalSalDetails.Reset;
//                     AppraisalSalDetails.SetRange("Loan No", LoanApplication."Loan No.");

//                     if AppraisalSalDetails.FindSet then begin
//                         repeat begin
//                             case AppraisalSalDetails.Type of
//                                 AppraisalSalDetails.Type::Basic:
//                                     begin
//                                         if not appraisal_basic_salary.AsValue.IsNull then begin
//                                             AppraisalSalDetails.Amount := appraisal_basic_salary.AsValue.AsDecimal;
//                                         end else begin
//                                             AppraisalSalDetails.Amount := 0;
//                                         end;
//                                     end;
//                                 AppraisalSalDetails.Type::"Other Allowances":
//                                     begin
//                                         if not appraisal_total_allowances.AsValue.IsNull then begin
//                                             AppraisalSalDetails.Amount := appraisal_total_allowances.AsValue.AsDecimal;
//                                         end else begin
//                                             AppraisalSalDetails.Amount := 0;
//                                         end;
//                                     end;
//                                 AppraisalSalDetails.Type::Deductions:
//                                     begin
//                                         if not appraisal_total_deductions.AsValue.IsNull then begin
//                                             AppraisalSalDetails.Amount := appraisal_total_deductions.AsValue.AsDecimal;
//                                         end else begin
//                                             AppraisalSalDetails.Amount := 0;
//                                         end;
//                                     end;
//                                 else
//                                     AppraisalSalDetails.Amount := 0;
//                             end;

//                             AppraisalSalDetails."Modified By" := UserId;
//                             AppraisalSalDetails.Modify(true);
//                         end until AppraisalSalDetails.Next = 0;
//                     end;


//                     // Loans top ups
//                     if loans_top_ups.IsArray then begin
//                         LoansToBeCleared.Reset();

//                         LoansToBeCleared.SetRange("Loan No.", LoanApplication."Loan No.");

//                         if LoansToBeCleared.FindSet then begin
//                             repeat begin
//                                 KeyExists := LoansToBeCleared.Delete(true);
//                             end until LoansToBeCleared.Next = 0;
//                         end;

//                         foreach loans_top_up in loans_top_ups.AsArray do begin
//                             LoansToBeCleared.Init;

//                             LoansToBeCleared."Loan No." := LoanApplication."Loan No.";
//                             LoansToBeCleared."Client Code" := LoanApplication."Member No.";
//                             LoansToBeCleared."Loan Top Up" := loans_top_up.AsValue.AsText;

//                             LoansToBeCleared.Validate("Loan Top Up");
//                             LoansToBeCleared.Validate("Principle Top Up");
//                             LoansToBeCleared.Validate("Interest Top Up");

//                             LoansToBeCleared.Insert(true);
//                         end;
//                     end;

//                     // Guarantors
//                     GuarantorsApplication.Reset();

//                     GuarantorsApplication.SetRange("Loan No", LoanApplication."Loan No.");

//                     if GuarantorsApplication.FindSet then begin
//                         repeat begin
//                             KeyExists := GuarantorsApplication.Delete(true);
//                         end until GuarantorsApplication.Next = 0;
//                     end;

//                     foreach guarantor in guarantors.AsArray do begin
//                         guarantor.AsObject.Get('member_number', guarantor_member_number);
//                         guarantor.AsObject.Get('amount', guarantor_amount);

//                         GuarantorsApplication.Init();

//                         GuarantorSavingsAccount.Reset;
//                         GuarantorSavingsAccount.SetRange("Member No.", guarantor_member_number.AsValue.AsText);
//                         GuarantorSavingsAccount.SetFilter("Product Category", '=%1', GuarantorSavingsAccount."Product Category"::"BOSA Deposits");

//                         IF GuarantorSavingsAccount.FindFirst then begin
//                             GuarantorsApplication."Loan No" := LoanApplication."Loan No.";

//                             GuarantorsApplication."Guarantor Type" := GuarantorsApplication."Guarantor Type"::Guarantor;
//                             GuarantorsApplication.Validate("Guarantor Type");

//                             GuarantorsApplication."Staff/Payroll No." := GuarantorSavingsAccount."Payroll/Staff No.";
//                             // GuarantorsApplication.Validate("Staff/Payroll No.");

//                             if LoanApplication."Source Unit" = LoanApplication."Source Unit"::FOSA then begin
//                                 GuarantorsApplication."Amount Guaranteed" := guarantor_amount.AsValue.AsDecimal;
//                                 // GuarantorsApplication.Validate("Amount Guaranteed");
//                             end;

//                             GuarantorsApplication.Name := GuarantorSavingsAccount.Name;
//                             GuarantorsApplication.Date := DT2Date(CurrentDateTime);
//                             GuarantorsApplication."Member No" := GuarantorSavingsAccount."Member No.";

//                             GuarantorsApplication."Savings Account No./Member No." := GuarantorSavingsAccount."No.";
//                             GuarantorsApplication.Validate("Savings Account No./Member No.");

//                             KeyExists := GuarantorsApplication.Insert();
//                         end;

//                         GuarantorsApplication.Reset();
//                     end;

//                     // Collaterals
//                     foreach collateral in collaterals.AsArray do begin
//                         LoanCollateral.Reset;
//                         LoanCollateral.SetRange("Account No.", LoanApplication."Member No.");
//                         LoanCollateral.SetRange("No.", collateral.AsValue.AsText);

//                         IF LoanCollateral.FindFirst then begin
//                             GuarantorsApplication.Init();

//                             GuarantorsApplication."Loan No" := LoanApplication."Loan No.";

//                             GuarantorsApplication."Guarantor Type" := GuarantorsApplication."Guarantor Type"::Collateral;
//                             GuarantorsApplication.Validate("Guarantor Type");

//                             GuarantorsApplication."Savings Account No./Member No." := LoanApplication."Member No.";
//                             // GuarantorsApplication.Validate("Savings Account No./Member No.");

//                             GuarantorsApplication."Collateral Reg. No." := LoanCollateral."No.";
//                             GuarantorsApplication.Validate("Collateral Reg. No.");

//                             GuarantorsApplication.Date := DT2Date(CurrentDateTime);
//                             GuarantorsApplication."Member No" := LoanApplication."Member No.";

//                             KeyExists := GuarantorsApplication.Insert();
//                         end;

//                         // LIEN ----------------------------------------------------------------

//                         SavingsAccount.Reset;

//                         SavingsAccount.SetRange(Status, SavingsAccount.Status::Active);
//                         SavingsAccount.SetRange("Member No.", LoanApplication."Member No.");
//                         SavingsAccount.SetFilter("Product Category", '=%1|%2', SavingsAccount."Product Category"::"BOSA Deposits", SavingsAccount."Product Category"::"Business Deposits");
//                         SavingsAccount.SetFilter("Lien Placed", '>%1', 0);
//                         SavingsAccount.SetRange("No.", collateral.AsValue.AsText);

//                         IF SavingsAccount.FindFirst then begin
//                             GuarantorsApplication.Init();

//                             GuarantorsApplication."Loan No" := LoanApplication."Loan No.";

//                             GuarantorsApplication."Guarantor Type" := GuarantorsApplication."Guarantor Type"::Lien;
//                             GuarantorsApplication.Validate("Guarantor Type");

//                             GuarantorsApplication."Savings Account No./Member No." := SavingsAccount."No.";
//                             // GuarantorsApplication.Validate("Savings Account No./Member No.");

//                             GuarantorsApplication.Date := DT2Date(CurrentDateTime);
//                             GuarantorsApplication."Member No" := LoanApplication."Member No.";

//                             KeyExists := GuarantorsApplication.Insert();
//                         end;

//                         GuarantorsApplication.Reset();
//                     end;

//                     LoanApplication.Reset();

//                     LoanApplication.SetRange("Loan No.", LoanApplication."Loan No.");
//                     ResponseData.Add('application_status', Format(LoanApplication.Status));
//                     ResponseData.Add('crm_no', LoanApplication."Loan No.");

//                     ResponseObject.Add('result_code', 0);
//                     ResponseObject.Add('result_message', 'Loan application with application number ' + LoanApplication."Loan No." + ' has been updated successfully.');
//                     ResponseObject.Add('data', ResponseData);
//                     AddDateTimeToResponse(ResponseObject);

//                     ResponseObject.WriteTo(Response);
//                 end else begin
//                     // ResponseObject.Add('status', 'ERROR');
//                     // ResponseObject.Add('description', 'Unable to create loan application.');
//                     // ResponseObject.Add('errors', Errors);
//                     // AddDateTimeToResponse(ResponseObject);

//                     // ResponseObject.WriteTo(Response);

//                     Error('Internal Error. Unable to update loan application.');
//                 end;
//             end else begin
//                 Error('Internal Error. Unable to fetch loan application member details.');
//             end;
//             ;
//         end else begin
//             Error('Loan with application number %1 is NOT available for editing', crm_no.AsValue.AsText);
//         end;

//         exit(Response);
//     end;

//     local procedure GetBusinessLoanProducts(): Text
//     var
//         ActiveLoanProducts: Record "Product Factory";

//         ResponseObject: JsonObject;
//         Data: JsonArray;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         ActiveLoanProducts.Reset;

//         ActiveLoanProducts.SetRange("Product Class Type", ActiveLoanProducts."Product Class Type"::Loan);
//         ActiveLoanProducts.SetRange(Status, ActiveLoanProducts.Status::Active);
//         ActiveLoanProducts.SetRange("Source Unit", ActiveLoanProducts."Source Unit"::"BUSINESS LOANS");

//         IF ActiveLoanProducts.FindSet then begin
//             repeat begin

//                 Datum.Add('product_id', ActiveLoanProducts."Product ID");
//                 Datum.Add('loan_name', ActiveLoanProducts."Product Description");
//                 Datum.Add('product_class_type', Format(ActiveLoanProducts."Product Class Type"));
//                 Datum.Add('min_guarantors', ActiveLoanProducts."Minimum Guarantors");
//                 Datum.Add('max_guarantors', ActiveLoanProducts."Maximum Guarantors");
//                 Datum.Add('min_loan_amount', ActiveLoanProducts."Minimum Loan Amount");
//                 Datum.Add('max_loan_amount', ActiveLoanProducts."Maximum Loan Amount");
//                 Datum.Add('interest_calculation_method', Format(ActiveLoanProducts."Interest Calculation Method"));
//                 Datum.Add('installments', ActiveLoanProducts."Ordinary Default Intallments");
//                 Datum.Add('category', Format(ActiveLoanProducts.Category));
//                 Datum.Add('loan_span', Format(ActiveLoanProducts."Loan Span"));
//                 Datum.Add('repayment_mode', Format(ActiveLoanProducts."Repay Mode"));
//                 Datum.Add('source_unit', Format(ActiveLoanProducts."Source Unit"));
//                 Datum.Add('status', Format(ActiveLoanProducts.Status));

//                 Data.Add(Datum);

//                 // Reset
//                 Datum.ReadFrom('{}');
//             end until ActiveLoanProducts.Next = 0;
//         end;

//         ResponseObject.Add('result_code', 0);
//         ResponseObject.Add('result_message', 'Request is successful');
//         ResponseObject.Add('data', Data);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure SendBusinessLoanData(Payload: JsonObject; RequestAPIId: JsonToken): Text
//     var
//         member_number: JsonToken;
//         loan_product_type: JsonToken;
//         loan_requested_amount: JsonToken;
//         loan_duration: JsonToken;
//         loan_purpose: JsonToken;
//         guarantors: JsonToken;
//         sasra_main_sector: JsonToken;
//         sasra_sub_sector_1: JsonToken;
//         sasra_sub_sector_2: JsonToken;
//         status_change_callback_url: JsonToken;

//         guarantor: JsonToken;
//         guarantor_member_number: JsonToken;
//         guarantor_amount: JsonToken;

//         collaterals: JsonToken;
//         collateral: JsonToken;

//         KeyExists: Boolean;

//         LoanApplication: Record Loans;
//         LoanProduct: Record "Product Factory";
//         Member: Record Members;
//         GuarantorsApplication: Record "Loan Guarantors and Security";
//         GuarantorSavingsAccount: Record "Savings Accounts";
//         LoanCollateral: Record "Securities Register";
//         ResponseObject: JsonObject;
//         ResponseData: JsonObject;
//         Errors: JsonArray;
//         Response: Text;
//     begin
//         KeyExists := Payload.Get('member_number', member_number);
//         KeyExists := Payload.Get('loan_product_type', loan_product_type);
//         KeyExists := Payload.Get('loan_requested_amount', loan_requested_amount);
//         KeyExists := Payload.Get('loan_duration', loan_duration);
//         KeyExists := Payload.Get('loan_purpose', loan_purpose);
//         KeyExists := Payload.Get('sasra_main_sector', sasra_main_sector);
//         KeyExists := Payload.Get('sasra_sub_sector_1', sasra_sub_sector_1);
//         KeyExists := Payload.Get('sasra_sub_sector_2', sasra_sub_sector_2);
//         KeyExists := Payload.Get('status_change_callback_url', status_change_callback_url);

//         KeyExists := Payload.Get('guarantors', guarantors);
//         KeyExists := Payload.Get('collaterals', collaterals);

//         Member.Reset;
//         Member.SetRange("No.", member_number.AsValue.AsText);

//         if Member.FindFirst then begin
//             LoanApplication.Init();

//             LoanApplication."Member No." := member_number.AsValue.AsText;
//             LoanApplication.Validate("Member No."); //

//             LoanApplication."Application Date" := DT2Date(CurrentDateTime);
//             LoanApplication.Validate("Application Date");

//             LoanApplication."Loan Product Type" := loan_product_type.AsValue.AsText;
//             LoanProduct.Reset;
//             LoanProduct.SetRange("Product ID", LoanApplication."Loan Product Type");

//             if LoanProduct.FindFirst then begin
//                 LoanApplication."Source Unit" := LoanProduct."Source Unit";
//                 LoanApplication."Loan Product Type Name" := LoanProduct."Product Description";
//             end else begin
//                 LoanApplication."Source Unit" := LoanApplication."Source Unit"::"BUSINESS LOANS";
//                 LoanApplication."Loan Product Type Name" := '';
//             end;

//             LoanApplication."Source" := LoanApplication.Source::MICRO;
//             LoanApplication.Validate("Loan Product Type");

//             LoanApplication.Status := LoanApplication.Status::Open;

//             LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::BLOANS);

//             LoanApplication."Purpose of Loan" := loan_purpose.AsValue.AsText;
//             LoanApplication."Loan Appl.form No." := '';
//             LoanApplication."Comment for Exemptions" := '';

//             LoanApplication."CRM Application No." := '';
//             LoanApplication."CRM Created By" := '';
//             LoanApplication."CRM Originating Branch" := '';
//             LoanApplication."CRM Notes" := '';

//             LoanApplication.Installments := loan_duration.AsValue.AsInteger;
//             LoanApplication.Validate(Installments);

//             LoanApplication."Main Sector" := sasra_main_sector.AsValue.AsText;
//             LoanApplication.Validate("Main Sector");
//             LoanApplication."Sub Sector Level1" := sasra_sub_sector_1.AsValue.AsText;
//             LoanApplication.Validate("Sub Sector Level1");
//             LoanApplication."Sub Sector Level2" := sasra_sub_sector_2.AsValue.AsText;
//             LoanApplication.Validate("Sub Sector Level2");

//             LoanApplication."Member Name" := Member.Name;
//             LoanApplication.Validate("Member No.");

//             LoanApplication."Captured By" := 'MWALIMU SMART';
//             LoanApplication."Mwalimu Smart Callback URL" := status_change_callback_url.AsValue.AsText;
//             LoanApplication."Source Aplication" := LoanApplication."Source Aplication"::"Mwalimu Smart";

//             LoanApplication."Requested Amount" := loan_requested_amount.AsValue.AsInteger;
//             LoanApplication.Validate("Requested Amount");

//             IF LoanApplication.Insert(true) then begin
//                 LoanApplication."CRM Application No." := LoanApplication."Loan No.";
//                 LoanApplication."CRM No. Series" := LoanApplication."No. Series";
//                 LoanApplication.Modify();

//                 // Guarantors
//                 foreach guarantor in guarantors.AsArray do begin
//                     guarantor.AsObject.Get('member_number', guarantor_member_number);
//                     guarantor.AsObject.Get('amount', guarantor_amount);

//                     GuarantorsApplication.Init();

//                     GuarantorSavingsAccount.Reset;
//                     GuarantorSavingsAccount.SetRange("Member No.", guarantor_member_number.AsValue.AsText);
//                     GuarantorSavingsAccount.SetFilter("Product Category", '=%1', GuarantorSavingsAccount."Product Category"::"BOSA Deposits");

//                     IF GuarantorSavingsAccount.FindFirst then begin
//                         GuarantorsApplication."Loan No" := LoanApplication."Loan No.";

//                         GuarantorsApplication."Guarantor Type" := GuarantorsApplication."Guarantor Type"::Guarantor;
//                         GuarantorsApplication.Validate("Guarantor Type");

//                         GuarantorsApplication."Staff/Payroll No." := GuarantorSavingsAccount."Payroll/Staff No.";
//                         // GuarantorsApplication.Validate("Staff/Payroll No.");

//                         // GuarantorsApplication."Amount Guaranteed" := guarantor_amount.AsValue.AsDecimal;
//                         // GuarantorsApplication.Validate("Amount Guaranteed");

//                         GuarantorsApplication.Name := GuarantorSavingsAccount.Name;
//                         GuarantorsApplication.Date := DT2Date(CurrentDateTime);
//                         GuarantorsApplication."Member No" := GuarantorSavingsAccount."Member No.";

//                         GuarantorsApplication."Savings Account No./Member No." := GuarantorSavingsAccount."No.";
//                         GuarantorsApplication.Validate("Savings Account No./Member No.");

//                         KeyExists := GuarantorsApplication.Insert();
//                     end;

//                     GuarantorsApplication.Reset();
//                 end;

//                 // Collaterals
//                 foreach collateral in collaterals.AsArray do begin
//                     LoanCollateral.Reset;
//                     LoanCollateral.SetRange("Account No.", LoanApplication."Member No.");
//                     LoanCollateral.SetRange("No.", collateral.AsValue.AsText);

//                     IF LoanCollateral.FindFirst then begin
//                         GuarantorsApplication.Init();

//                         GuarantorsApplication."Loan No" := LoanApplication."Loan No.";

//                         GuarantorsApplication."Guarantor Type" := GuarantorsApplication."Guarantor Type"::Collateral;
//                         GuarantorsApplication.Validate("Guarantor Type");

//                         GuarantorsApplication."Savings Account No./Member No." := LoanApplication."Member No.";
//                         // GuarantorsApplication.Validate("Savings Account No./Member No.");

//                         GuarantorsApplication."Collateral Reg. No." := LoanCollateral."No.";
//                         GuarantorsApplication.Validate("Collateral Reg. No.");

//                         GuarantorsApplication.Date := DT2Date(CurrentDateTime);
//                         GuarantorsApplication."Member No" := LoanApplication."Member No.";

//                         KeyExists := GuarantorsApplication.Insert();
//                     end;

//                     GuarantorsApplication.Reset();
//                 end;

//                 // LoanApplication."Global Dimension 1 Code" := '';
//                 LoanApplication."Global Dimension 2 Code" := Format("Responsibility Center Enum"::MICRO);
//                 LoanApplication."Responsibility Center" := Format("Responsibility Center Enum"::BLOANS);

//                 LoanApplication.Modify;

//                 LoanApplication.Reset();

//                 LoanApplication.SetRange("Loan No.", LoanApplication."Loan No.");
//                 ResponseData.Add('application_status', Format(LoanApplication.Status));
//                 ResponseData.Add('crm_no', LoanApplication."Loan No.");

//                 ResponseObject.Add('result_code', 0);
//                 ResponseObject.Add('result_message', 'Loan application with application number ' + LoanApplication."Loan No." + ' has been created successfully.');
//                 ResponseObject.Add('data', ResponseData);
//                 AddDateTimeToResponse(ResponseObject);

//                 ResponseObject.WriteTo(Response);
//             end else begin
//                 // ResponseObject.Add('status', 'ERROR');
//                 // ResponseObject.Add('description', 'Unable to create loan application.');
//                 // ResponseObject.Add('errors', Errors);
//                 // AddDateTimeToResponse(ResponseObject);

//                 // ResponseObject.WriteTo(Response);

//                 Error('Internal Error. Unable to create loan application.');
//             end;
//         end else begin
//             // ResponseObject.Add('status', 'ERROR');
//             // ResponseObject.Add('description', 'Unknown member with member number ' + member_number.AsValue.AsText);
//             // ResponseObject.Add('errors', Errors);
//             // AddDateTimeToResponse(ResponseObject);

//             // ResponseObject.WriteTo(Response);

//             Error('Unknown member with member number ' + member_number.AsValue.AsText);
//         end;

//         exit(Response);
//     end;

//     local procedure SendBusinessAccountMembershipRequest(Payload: JsonObject; RequestAPIId: JsonToken): Text
//     var
//         member_number: JsonToken;
//         type_of_business: JsonToken;
//         business_location: JsonToken;
//         wholesale_retail: JsonToken;
//         current_capital: JsonToken;
//         no_of_employees: JsonToken;
//         annual_turnover: JsonToken;

//         KeyExists: Boolean;

//         BLAApplication: Record "B/S Loan Account Application";
//         Member: Record Members;
//         ResponseObject: JsonObject;
//         ResponseData: JsonObject;
//         Errors: JsonArray;
//         Response: Text;
//     begin
//         KeyExists := Payload.Get('member_number', member_number);
//         KeyExists := Payload.Get('type_of_business', type_of_business);
//         KeyExists := Payload.Get('business_location', business_location);
//         KeyExists := Payload.Get('wholesale_retail', wholesale_retail);
//         KeyExists := Payload.Get('current_capital', current_capital);
//         KeyExists := Payload.Get('no_of_employees', no_of_employees);
//         KeyExists := Payload.Get('annual_turnover', annual_turnover);

//         Member.Reset;
//         Member.SetRange("No.", member_number.AsValue.AsText);

//         if Member.FindFirst then begin
//             BLAApplication.Init();

//             BLAApplication."Member No." := member_number.AsValue.AsText;
//             BLAApplication.Validate("Member No.");
//             BLAApplication."Application Type" := BLAApplication."Application Type"::New;
//             BLAApplication."Application Date" := DT2Date(CurrentDateTime);

//             BLAApplication."Type of Business" := "Business Type".FromInteger(type_of_business.AsValue.AsInteger);
//             BLAApplication."Business Location" := business_location.AsValue.AsText;
//             BLAApplication."Wholesale/Retail" := wholesale_retail.AsValue.AsInteger;
//             BLAApplication."Current Capital" := current_capital.AsValue.AsDecimal;
//             BLAApplication."No. of Employees" := no_of_employees.AsValue.AsInteger;
//             BLAApplication."Annual Turnover" := annual_turnover.AsValue.AsDecimal;

//             IF BLAApplication.Insert(true) then begin
//                 BLAApplication."Created By" := 'MWALIMU SMART';
//                 BLAApplication."Global Dimension 2 Code" := Format("Responsibility Center Enum"::MICRO);
//                 BLAApplication."Responsibility Center" := Format("Responsibility Center Enum"::BLOANS);

//                 BLAApplication.Modify(true);

//                 ResponseData.Add('application_status', Format(BLAApplication.Status));
//                 ResponseData.Add('crm_no', BLAApplication."No.");

//                 ResponseObject.Add('result_code', 0);
//                 ResponseObject.Add('result_message', 'Business account application with application number ' + BLAApplication."No." + ' has been created successfully.');
//                 ResponseObject.Add('data', ResponseData);
//                 AddDateTimeToResponse(ResponseObject);

//                 ResponseObject.WriteTo(Response);
//             end else begin
//                 Error('Internal Error. Unable to create business account application.');
//             end;
//         end else begin
//             Error('Unknown member with member number ' + member_number.AsValue.AsText);
//         end;

//         exit(Response);
//     end;

//     local procedure RegisterLoanApplicationStatusCallback(Payload: JsonObject; APIRequestID: JsonToken): Text
//     var
//         attach_by: JsonToken;
//         attach_value: JsonToken;
//         callback_url: JsonToken;

//         SearchLoan: Record Loans;

//         ResponseObject: JsonObject;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         Payload.Get('attach_by', attach_by);
//         Payload.Get('attach_value', attach_value);
//         Payload.Get('callback_url', callback_url);

//         SearchLoan.Reset;

//         SearchLoan.SetRange("Loan No.", attach_value.AsValue.AsText);

//         IF SearchLoan.FindFirst then begin
//             SearchLoan."Mwalimu Smart Callback URL" := callback_url.AsValue.AsText;

//             SearchLoan.Modify;

//             ResponseObject.Add('result_code', 0);
//             ResponseObject.Add('result_message', 'Success');
//         end else begin
//             ResponseObject.Add('result_code', 400);
//             ResponseObject.Add('result_message', 'Loan application NOT found');

//             Datum.Add('error_message', 'Loan application with identification ' + attach_by.AsValue.AsText + ' = ' + attach_value.AsValue.AsText + ' NOT found!');
//             ResponseObject.Add('data', Datum);
//         end;

//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure CheckMemberHasBusinessAccount(Payload: JsonObject; APIRequestID: JsonToken): Text
//     var
//         member_number: JsonToken;

//         SearchMember: Record Members;

//         ResponseObject: JsonObject;
//         Response: Text;
//     begin
//         Payload.Get('member_number', member_number);

//         SearchMember.Reset;

//         SearchMember.SetRange("No.", member_number.AsValue.AsText);
//         SearchMember.SetFilter("Has Joined Business Loans", '<>%1', false);

//         IF SearchMember.FindFirst then begin
//             ResponseObject.Add('result_code', 0);
//             ResponseObject.Add('result_message', 'Success');
//             ResponseObject.Add('data', true);
//         end else begin
//             ResponseObject.Add('result_code', 400);
//             ResponseObject.Add('result_message', 'Member NOT found or does NOT have a business account');
//             ResponseObject.Add('data', false);
//         end;

//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure GetMemberGroup(Payload: JsonObject; APIRequestID: JsonToken): Text
//     var
//         member_number: JsonToken;

//         SearchMember: Record Members;
//         AccountSignatories: Record "Account Signatories";
//         GroupAccount: Record Members;
//         GroupMembers: Record "Account Signatories";

//         groups: JsonArray;
//         group: JsonObject;
//         members: JsonArray;
//         member: JsonObject;
//         ResponseObject: JsonObject;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         Payload.Get('member_number', member_number);

//         SearchMember.Reset;
//         SearchMember.SetRange("No.", member_number.AsValue.AsText);

//         IF SearchMember.FindFirst then begin
//             AccountSignatories.Reset;

//             AccountSignatories.SetRange("Member No.", SearchMember."No.");

//             IF AccountSignatories.FindSet then begin
//                 repeat begin
//                     group.Add('code', AccountSignatories."Account No");

//                     GroupAccount.Reset;
//                     GroupAccount.SetRange("No.", AccountSignatories."Account No");
//                     if GroupAccount.FindFirst then begin
//                         group.Add('name', GroupAccount.Name);
//                     end else begin
//                         group.Add('name', '');
//                     end;

//                     GroupMembers.Reset;
//                     GroupMembers.SetRange("Account No", AccountSignatories."Account No");

//                     if GroupMembers.FindSet then begin
//                         repeat begin
//                             member.Add('member_number', GroupMembers."Member No.");
//                             member.Add('id_number', GroupMembers."ID Number");
//                             member.Add('member_full_name', GroupMembers.Names);
//                             member.Add('position', Format(GroupMembers.Type));

//                             members.Add(member);

//                             // Reset
//                             member.ReadFrom('{}');
//                         end until GroupMembers.Next = 0;
//                     end;
//                     group.Add('members', members);

//                     groups.Add(group);

//                     // Reset
//                     group.ReadFrom('{}');
//                     members.ReadFrom('[]');
//                 end until AccountSignatories.Next = 0;
//             end;

//             ResponseObject.Add('result_code', 0);
//             ResponseObject.Add('result_message', 'Success');
//             Datum.Add('group', groups);
//         end else begin
//             ResponseObject.Add('result_code', 400);
//             ResponseObject.Add('result_message', 'Member NOT found');
//             Datum.Add('error_message', 'Member with number ' + member_number.AsValue.AsText + ' NOT found!');
//         end;

//         ResponseObject.Add('data', Datum);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure GetGroupDetails(Payload: JsonObject; APIRequestID: JsonToken): Text
//     var
//         group_code: JsonToken;

//         GroupMember: Record Members;
//         GroupMembers: Record "Account Signatories";

//         group: JsonObject;
//         members: JsonArray;
//         member: JsonObject;
//         ResponseObject: JsonObject;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         Payload.Get('group_code', group_code);

//         GroupMember.Reset;
//         GroupMember.SetRange("No.", group_code.AsValue.AsText);
//         // GroupMember.SetFilter("Account Type", '=%1|%2', GroupMember."Account Type"::"Business Loan Account", GroupMember."Account Type"::"Chama Investment");

//         IF GroupMember.FindFirst then begin
//             group.Add('code', GroupMember."No.");
//             group.Add('name', GroupMember.Name);

//             GroupMembers.Reset;
//             GroupMembers.SetRange("Account No", GroupMember."No.");

//             if GroupMembers.FindSet then begin
//                 repeat begin
//                     member.Add('member_number', GroupMembers."Member No.");
//                     member.Add('id_number', GroupMembers."ID Number");
//                     member.Add('member_full_name', GroupMembers.Names);
//                     member.Add('position', Format(GroupMembers.Type));

//                     members.Add(member);

//                     // Reset
//                     member.ReadFrom('{}');
//                 end until GroupMembers.Next = 0;
//             end;
//             group.Add('members', members);

//             ResponseObject.Add('result_code', 0);
//             ResponseObject.Add('result_message', 'Success');
//             Datum.Add('group', group);
//         end else begin
//             ResponseObject.Add('result_code', 400);
//             ResponseObject.Add('result_message', 'Member NOT found');
//             Datum.Add('error_message', 'Group with number ' + group_code.AsValue.AsText + ' NOT found!');
//         end;

//         ResponseObject.Add('data', Datum);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure CreateCustomerCollateral(Payload: JsonObject; RequestAPIId: JsonToken): Text
//     var
//         member_number: JsonToken;
//         reference_no: JsonToken;
//         collateral_type: JsonToken;
//         collateral_value: JsonToken;
//         last_valuation_date: JsonToken;
//         valuer_name: JsonToken;

//         KeyExists: Boolean;

//         CustomerCollateral: Record "Securities Register";
//         Member: Record Members;
//         ResponseObject: JsonObject;
//         ResponseData: JsonObject;
//         Errors: JsonArray;
//         Response: Text;
//     begin
//         KeyExists := Payload.Get('member_number', member_number);
//         KeyExists := Payload.Get('reference_no', reference_no);
//         KeyExists := Payload.Get('collateral_type', collateral_type);
//         KeyExists := Payload.Get('collateral_value', collateral_value);
//         KeyExists := Payload.Get('last_valuation_date', last_valuation_date);
//         KeyExists := Payload.Get('valuer_name', valuer_name);

//         Member.Reset;
//         Member.SetRange("No.", member_number.AsValue.AsText);

//         if Member.FindFirst then begin
//             CustomerCollateral.Init();

//             CustomerCollateral."Account No." := member_number.AsValue.AsText;
//             CustomerCollateral.Validate("Account No.");
//             // CustomerCollateral."Reference No" := reference_no.AsValue.AsText;
//             CustomerCollateral."Collateral Ref No." := reference_no.AsValue.AsText;
//             CustomerCollateral."Collateral Type" := collateral_type.AsValue.AsInteger;
//             CustomerCollateral."Collateral Value" := collateral_value.AsValue.AsDecimal;
//             CustomerCollateral.Validate("Collateral Value");
//             CustomerCollateral."Last Valuation Date" := last_valuation_date.AsValue.AsDate;
//             CustomerCollateral.Validate("Last Valuation Date");
//             CustomerCollateral."Valuer Name" := valuer_name.AsValue.AsText;

//             IF CustomerCollateral.Insert(true) then begin
//                 CustomerCollateral."Captured By" := 'MWALIMU SMART';
//                 CustomerCollateral."Global Dimension 2 Code" := Format("Responsibility Center Enum"::LEGAL);
//                 CustomerCollateral."Responsibility Center" := Format("Responsibility Center Enum"::LEGAL);

//                 CustomerCollateral.Modify(true);

//                 ResponseData.Add('application_status', Format(CustomerCollateral.Status));
//                 ResponseData.Add('crm_no', CustomerCollateral."No.");

//                 ResponseObject.Add('result_code', 0);
//                 ResponseObject.Add('result_message', 'Collateral registration application with application number ' + CustomerCollateral."No." + ' has been created successfully.');
//                 ResponseObject.Add('data', ResponseData);
//                 AddDateTimeToResponse(ResponseObject);

//                 ResponseObject.WriteTo(Response);
//             end else begin
//                 Error('Internal Error. Unable to create collateral application.');
//             end;
//         end else begin
//             Error('Unknown member with member number ' + member_number.AsValue.AsText);
//         end;

//         exit(Response);
//     end;

//     local procedure GetCustomerCollaterals(Payload: JsonObject; APIRequestID: JsonToken): Text
//     var
//         member_number: JsonToken;

//         SearchMember: Record Members;
//         MemberCollaterals: Record "Securities Register";
//         LoanSecurities: Record "Loan Guarantors and Security";
//         GroupAccount: Record Members;
//         GroupMembers: Record "Account Signatories";
//         SavingsAccount: record "Savings Accounts";

//         TotalUsedValue: Decimal;
//         SavingsAccountAvailableBalance: Decimal;

//         collaterals: JsonArray;
//         collateral: JsonObject;
//         usages: JsonArray;
//         usage: JsonObject;
//         ResponseObject: JsonObject;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         Payload.Get('member_number', member_number);

//         SearchMember.Reset;
//         SearchMember.SetRange("No.", member_number.AsValue.AsText);

//         IF SearchMember.FindFirst then begin
//             MemberCollaterals.Reset;

//             MemberCollaterals.SetRange("Account No.", SearchMember."No.");

//             IF MemberCollaterals.FindSet then begin
//                 repeat begin
//                     // "usage": [
//                     //     {
//                     //         "loan_account_number": "000000",
//                     //         "used_value": 10000
//                     //     },

//                     collateral.Add('no', MemberCollaterals."No.");
//                     collateral.Add('ref_no', MemberCollaterals."Collateral Ref No.");
//                     collateral.Add('name', MemberCollaterals."Collateral Name");
//                     collateral.Add('nature', Format(MemberCollaterals."Collateral Type"));
//                     collateral.Add('specific_nature', Format(MemberCollaterals."Collateral Type"));
//                     collateral.Add('value', MemberCollaterals."Collateral Value");

//                     LoanSecurities.Reset;
//                     LoanSecurities.SetRange("Collateral Reg. No.", MemberCollaterals."No.");
//                     LoanSecurities.SetFilter("Guarantor Type", '=%1', LoanSecurities."Guarantor Type"::Collateral);

//                     if LoanSecurities.FindSet then begin
//                         repeat begin
//                             usage.Add('loan_account_number', LoanSecurities."Loan No");
//                             usage.Add('used_value', LoanSecurities."Amount Guaranteed");

//                             TotalUsedValue += LoanSecurities."Amount Guaranteed";

//                             usages.Add(usage);

//                             // Reset
//                             usage.ReadFrom('{}');
//                         end until LoanSecurities.Next = 0;
//                     end;

//                     collateral.Add('used_value', TotalUsedValue);
//                     collateral.Add('unused_value', MemberCollaterals."Collateral Value" - TotalUsedValue);

//                     collateral.Add('usage', usages);
//                     collateral.Add('status', Format(MemberCollaterals.Status));

//                     collaterals.Add(collateral);

//                     // Reset
//                     collateral.ReadFrom('{}');
//                     usages.ReadFrom('[]');

//                     TotalUsedValue := 0;
//                 end until MemberCollaterals.Next = 0;
//             end;

//             // -------------------------------------------------------------------------------------
//             SavingsAccount.Reset;

//             SavingsAccount.SetRange(Status, SavingsAccount.Status::Active);
//             SavingsAccount.SetRange("Member No.", SearchMember."No.");
//             SavingsAccount.SetFilter("Product Category", '=%1|%2', SavingsAccount."Product Category"::"BOSA Deposits", SavingsAccount."Product Category"::"Business Deposits");
//             SavingsAccount.SetFilter("Lien Placed", '>%1', 0);

//             IF SavingsAccount.FindSet then begin
//                 repeat begin
//                     SavingsAccountAvailableBalance := GlobalFunctions.GetSavingsAccountAvailableBalance(SavingsAccount, true);
//                     SavingsAccount.CalcFields("Balance (LCY)");

//                     collateral.Add('no', SavingsAccount."No.");
//                     collateral.Add('ref_no', SavingsAccount."No.");
//                     collateral.Add('name', SavingsAccount."Product Name");
//                     collateral.Add('nature', Format(MemberCollaterals."Collateral Type"::"Marketable Securities"));
//                     collateral.Add('specific_nature', Format(SavingsAccount."Product Category"));
//                     collateral.Add('value', SavingsAccountAvailableBalance);

//                     LoanSecurities.Reset;
//                     LoanSecurities.SetRange("Savings Account No./Member No.", SavingsAccount."No.");
//                     LoanSecurities.SetFilter("Guarantor Type", '=%1', LoanSecurities."Guarantor Type"::Lien);

//                     if LoanSecurities.FindSet then begin
//                         repeat begin
//                             usage.Add('loan_account_number', LoanSecurities."Loan No");
//                             usage.Add('used_value', LoanSecurities."Amount Guaranteed");

//                             TotalUsedValue += LoanSecurities."Amount Guaranteed";

//                             usages.Add(usage);

//                             // Reset
//                             usage.ReadFrom('{}');
//                         end until LoanSecurities.Next = 0;
//                     end;

//                     collateral.Add('used_value', TotalUsedValue);
//                     collateral.Add('unused_value', SavingsAccountAvailableBalance - TotalUsedValue);

//                     collateral.Add('usage', usages);
//                     collateral.Add('status', Format(SavingsAccount.Status));

//                     collaterals.Add(collateral);

//                     // Reset
//                     collateral.ReadFrom('{}');
//                     usages.ReadFrom('[]');

//                     TotalUsedValue := 0;
//                 end until SavingsAccount.Next = 0;
//             end;

//             ResponseObject.Add('result_code', 0);
//             ResponseObject.Add('result_message', 'Success');
//             ResponseObject.Add('data', collaterals);
//         end else begin
//             ResponseObject.Add('result_code', 400);
//             ResponseObject.Add('result_message', 'Member NOT found');
//             Datum.Add('error_message', 'Member with number ' + member_number.AsValue.AsText + ' NOT found!');
//             ResponseObject.Add('data', Datum);
//         end;

//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure GetLoanRepaymentSchedule(Payload: JsonObject; APIRequestID: JsonToken): Text
//     var
//         loan_number: JsonToken;

//         SearchLoan: Record Loans;
//         LoanRepaymentSchedule: Record "Ideal Repayment Schedule";

//         schedules: JsonArray;
//         schedule: JsonObject;
//         ResponseObject: JsonObject;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         Payload.Get('loan_number', loan_number);

//         SearchLoan.Reset;
//         SearchLoan.SetRange("Loan No.", loan_number.AsValue.AsText);

//         IF SearchLoan.FindFirst then begin
//             LoanRepaymentSchedule.Reset;

//             LoanRepaymentSchedule.SetRange("Loan No.", SearchLoan."Loan No.");
//             LoanRepaymentSchedule.SetCurrentKey("Repayment Date");

//             if LoanRepaymentSchedule.FindSet then begin
//                 repeat begin
//                     schedule.Add('month', GlobalFunctions.FormatISODate(LoanRepaymentSchedule."Repayment Date"));
//                     schedule.Add('amount', LoanRepaymentSchedule."Monthly Repayment");
//                     schedule.Add('interest', LoanRepaymentSchedule."Monthly Interest");
//                     schedule.Add('principal', LoanRepaymentSchedule."Principal Repayment");

//                     schedules.Add(schedule);

//                     // Reset
//                     schedule.ReadFrom('{}');
//                 end until LoanRepaymentSchedule.Next = 0;
//             end;

//             ResponseObject.Add('result_code', 0);
//             ResponseObject.Add('result_message', 'Success');
//             ResponseObject.Add('data', schedules);
//         end else begin
//             ResponseObject.Add('result_code', 400);
//             ResponseObject.Add('result_message', 'Loan NOT found');
//             Datum.Add('error_message', 'Loan with number ' + loan_number.AsValue.AsText + ' NOT found!');
//             ResponseObject.Add('data', Datum);
//         end;

//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure RetrieveMemberAccounts(Payload: JsonObject; APIRequestID: JsonToken): Text
//     var
//         member_number: JsonToken;

//         SearchMember: Record Members;
//         MemberAccounts: Record "Savings Accounts";
//         CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
//         DimensionValue: Record "Dimension Value";

//         accounts: JsonArray;
//         account: JsonObject;
//         ResponseObject: JsonObject;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         Payload.Get('member_number', member_number);

//         SearchMember.Reset;
//         SearchMember.SetRange("No.", member_number.AsValue.AsText);

//         IF SearchMember.FindFirst then begin
//             MemberAccounts.Reset;

//             MemberAccounts.SetRange("Member No.", SearchMember."No.");
//             MemberAccounts.SetCurrentKey(Balance);
//             MemberAccounts.SetAscending(Balance, false);

//             if MemberAccounts.FindSet then begin
//                 repeat begin
//                     // {
//                     //     "branch": "Nairobi",
//                     //     "balance": 100000,
//                     //     "opened_at": "2023-11-10 08:10"
//                     // }
//                     account.Add('account_number', MemberAccounts."No.");
//                     account.Add('product_type', MemberAccounts."Product Type");
//                     account.Add('product_name', MemberAccounts."Product Name");
//                     account.Add('status', Format(MemberAccounts.Status));

//                     account.Add('branch', MemberAccounts."Global Dimension 1 Code");

//                     DimensionValue.Reset;
//                     DimensionValue.SetRange("Dimension Code", 'BRANCH');
//                     DimensionValue.SetRange(Code, MemberAccounts."Global Dimension 1 Code");
//                     if DimensionValue.FindFirst then begin
//                         account.Add('branch_name', DimensionValue.Name);
//                     end else begin
//                         account.Add('branch_name', '');
//                     end;

//                     account.Add('balance', GlobalFunctions.GetSavingsAccountAvailableBalance(MemberAccounts, true));

//                     if MemberAccounts."Registration Date" <> 0D then begin
//                         account.Add('opened_at', GlobalFunctions.FormatISODate(MemberAccounts."Registration Date"));
//                     end else begin
//                         account.Add('opened_at', GlobalFunctions.FormatISODate(DT2Date(MemberAccounts.SystemCreatedAt)));
//                     end;

//                     account.Add('prorata', CustomCuesCodeunit.Prorata(MemberAccounts."Member No.", MemberAccounts."Product Type"));

//                     accounts.Add(account);

//                     // Reset
//                     account.ReadFrom('{}');
//                 end until MemberAccounts.Next = 0;
//             end;

//             ResponseObject.Add('result_code', 0);
//             ResponseObject.Add('result_message', 'Success');
//             ResponseObject.Add('data', accounts);
//         end else begin
//             ResponseObject.Add('result_code', 400);
//             ResponseObject.Add('result_message', 'Member NOT found');
//             Datum.Add('error_message', 'Member with number ' + member_number.AsValue.AsText + ' NOT found!');
//             ResponseObject.Add('data', Datum);
//         end;

//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure CheckLoanApplication(Payload: JsonObject; APIRequestID: JsonToken): Text
//     var
//         member_number: JsonToken;
//         product_id: JsonToken;

//         Loan: Record Loans;

//         group: JsonObject;
//         ResponseObject: JsonObject;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         Payload.Get('member_number', member_number);
//         Payload.Get('product_id', product_id);

//         Loan.Reset;
//         Loan.SetFilter(Status, '=%1|%2', Loan.Status::Open, Loan.Status::Pending);
//         // Loan.SetRange("Loan Product Type", product_id.AsValue.AsText);
//         Loan.SetRange("Member No.", member_number.AsValue.AsText);

//         IF Loan.FindFirst then begin
//             group.Add('has_ongoing_application', true);
//             group.Add('the_application', Loan."Loan No.");
//         end else begin
//             group.Add('has_ongoing_application', false);
//             group.Add('the_application', '');
//         end;

//         ResponseObject.Add('result_code', 0);
//         ResponseObject.Add('result_message', 'Success');

//         ResponseObject.Add('data', group);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure RetrieveMemberLoans(Payload: JsonObject; APIRequestID: JsonToken): Text
//     var
//         member_number: JsonToken;

//         SearchMember: Record Members;
//         MemberLoans: Record Loans;

//         loans: JsonArray;
//         loan: JsonObject;
//         ResponseObject: JsonObject;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         Payload.Get('member_number', member_number);

//         SearchMember.Reset;
//         SearchMember.SetRange("No.", member_number.AsValue.AsText);

//         IF SearchMember.FindFirst then begin
//             // Loan application
//             MemberLoans.Reset;

//             MemberLoans.SetRange("Member No.", SearchMember."No.");
//             MemberLoans.SetFilter(Status, '=%1|%2', MemberLoans.Status::Open, MemberLoans.Status::Pending);

//             if MemberLoans.FindSet then begin
//                 repeat begin
//                     loan.Add('account_number', MemberLoans."Loan No.");
//                     loan.Add('product_code', MemberLoans."Loan Product Type");
//                     loan.Add('product_name', MemberLoans."Loan Product Type Name");
//                     loan.Add('requested_amount', MemberLoans."Requested Amount");

//                     MemberLoans.CalcFields(
//                         "Outstanding Bills",
//                         "Outstanding Balance",
//                         "Last Pay Date",
//                         "Last Repayment Date",
//                         "Loans Category-SASRA");
//                     loan.Add('overdue_amount', MemberLoans."Outstanding Bills");
//                     loan.Add('unpaid_amount', MemberLoans."Outstanding Balance");
//                     loan.Add('outstanding_balance', MemberLoans."Outstanding Balance");

//                     loan.Add('duration_in_months', MemberLoans.Installments);
//                     loan.Add('last_installment_amount', MemberLoans.Repayment);

//                     if MemberLoans."Last Pay Date" <> 0D then begin
//                         loan.Add('last_installment_paid_at', GlobalFunctions.FormatISODate(MemberLoans."Last Pay Date"));
//                     end else
//                         if MemberLoans."Last Repayment Date" <> 0D then begin
//                             loan.Add('last_installment_paid_at', GlobalFunctions.FormatISODate(MemberLoans."Last Repayment Date"));
//                         end else begin
//                             loan.Add('last_installment_paid_at', GlobalFunctions.FormatISODate(MemberLoans."Expected Date of Completion"));
//                         end;

//                     loan.Add('status', Format(MemberLoans.Status));
//                     loan.Add('loan_performance', Format(MemberLoans."Loans Category-SASRA"));
//                     loan.Add('disbursed_at', GlobalFunctions.FormatISODate(MemberLoans."Disbursement Date"));

//                     loans.Add(loan);

//                     // Reset
//                     loan.ReadFrom('{}');
//                 end until MemberLoans.Next = 0;
//             end;

//             // Loans
//             MemberLoans.Reset;

//             MemberLoans.SetRange("Member No.", SearchMember."No.");
//             MemberLoans.SetFilter("Outstanding Balance", '>0');

//             if MemberLoans.FindSet then begin
//                 repeat begin
//                     loan.Add('account_number', MemberLoans."Loan No.");
//                     loan.Add('product_code', MemberLoans."Loan Product Type");
//                     loan.Add('product_name', MemberLoans."Loan Product Type Name");
//                     loan.Add('requested_amount', MemberLoans."Requested Amount");

//                     MemberLoans.CalcFields(
//                         "Outstanding Bills",
//                         "Outstanding Balance",
//                         "Last Pay Date",
//                         "Last Repayment Date",
//                         "Loans Category-SASRA");
//                     loan.Add('overdue_amount', MemberLoans."Outstanding Bills");
//                     loan.Add('unpaid_amount', MemberLoans."Outstanding Balance");
//                     loan.Add('outstanding_balance', MemberLoans."Outstanding Balance");

//                     loan.Add('duration_in_months', MemberLoans.Installments);
//                     loan.Add('last_installment_amount', MemberLoans.Repayment);

//                     if MemberLoans."Last Pay Date" <> 0D then begin
//                         loan.Add('last_installment_paid_at', GlobalFunctions.FormatISODate(MemberLoans."Last Pay Date"));
//                     end else
//                         if MemberLoans."Last Repayment Date" <> 0D then begin
//                             loan.Add('last_installment_paid_at', GlobalFunctions.FormatISODate(MemberLoans."Last Repayment Date"));
//                         end else begin
//                             loan.Add('last_installment_paid_at', GlobalFunctions.FormatISODate(MemberLoans."Expected Date of Completion"));
//                         end;

//                     loan.Add('status', Format(MemberLoans.Status));
//                     loan.Add('loan_performance', Format(MemberLoans."Loans Category-SASRA"));
//                     loan.Add('disbursed_at', GlobalFunctions.FormatISODate(MemberLoans."Disbursement Date"));

//                     loans.Add(loan);

//                     // Reset
//                     loan.ReadFrom('{}');
//                 end until MemberLoans.Next = 0;
//             end;

//             ResponseObject.Add('result_code', 0);
//             ResponseObject.Add('result_message', 'Success');
//             ResponseObject.Add('data', loans);
//         end else begin
//             ResponseObject.Add('result_code', 400);
//             ResponseObject.Add('result_message', 'Member NOT found');
//             Datum.Add('error_message', 'Member with number ' + member_number.AsValue.AsText + ' NOT found!');
//             ResponseObject.Add('data', Datum);
//         end;

//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure RetrieveMemberAccountTransactions(Payload: JsonObject; APIRequestID: JsonToken): Text
//     var
//         account_number: JsonToken;
//         from: JsonToken;
//         _to: JsonToken;

//         SavingsAccount: Record "Savings Accounts";
//         SavingsLedgerEntry: Record "Savings Ledger Entry";

//         StartDateTimeParts: List of [Text];
//         StartDate: Date;
//         EndDateTimeParts: List of [Text];
//         EndDate: Date;

//         transactions: JsonArray;
//         transaction: JsonObject;
//         ResponseObject: JsonObject;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         Payload.Get('account_number', account_number);
//         Payload.Get('from', from);
//         Payload.Get('to', _to);

//         SavingsAccount.Reset;
//         SavingsAccount.SetRange("No.", account_number.AsValue.AsText);

//         IF SavingsAccount.FindFirst then begin
//             SavingsLedgerEntry.Reset;
//             SavingsLedgerEntry.SetCurrentkey("Entry No.");
//             SavingsLedgerEntry.Ascending(false);
//             SavingsLedgerEntry.SetRange("Customer No.", SavingsAccount."No.");

//             StartDateTimeParts := from.AsValue.AsText.Split(' ');
//             EndDateTimeParts := _to.AsValue.AsText.Split(' ');

//             Evaluate(StartDate, StartDateTimeParts.Get(1));
//             Evaluate(EndDate, EndDateTimeParts.Get(1));

//             SavingsLedgerEntry.SetFilter("Posting Date", '>=%1&<=%2', StartDate, EndDate);

//             IF SavingsLedgerEntry.FindSet then begin
//                 SavingsAccount.CalcFields("Balance (LCY)", "Authorised Over Draft", "Uncleared Cheques", "ATM Transactions", "Lien Placed");

//                 repeat begin
//                     transaction.Add('transaction_code', SavingsLedgerEntry."Document No.");

//                     if SavingsLedgerEntry."Amount (LCY)" < 0 then begin
//                         transaction.Add('operation', 'Credit');
//                     end else begin
//                         transaction.Add('operation', 'Debit');
//                     end;
//                     transaction.Add('amount', SavingsLedgerEntry."Amount (LCY)" * -1);

//                     transaction.Add('description', SavingsLedgerEntry.Description);
//                     // transaction.Add('transaction_date', GlobalFunctions.FormatISODate(SavingsLedgerEntry."Posting Date"));
//                     // transaction.Add('transaction_time', Format(SavingsLedgerEntry."Posting Time"));
//                     transaction.Add('running_balance', GlobalFunctions.GetRunningBalance(SavingsLedgerEntry."Entry No.", SavingsLedgerEntry."Customer No."));
//                     transaction.Add('timestamp', GlobalFunctions.FormatISODateTime(SavingsLedgerEntry.SystemCreatedAt));


//                     transactions.Add(transaction);
//                     // Reset
//                     transaction.ReadFrom('{}');
//                 end until (SavingsLedgerEntry.Next = 0);
//             end;

//             ResponseObject.Add('result_code', 0);
//             ResponseObject.Add('result_message', 'Success');
//             ResponseObject.Add('data', transactions);
//         end else begin
//             ResponseObject.Add('result_code', 400);
//             ResponseObject.Add('result_message', 'Account NOT found');
//             Datum.Add('error_message', 'Account with number ' + account_number.AsValue.AsText + ' NOT found!');
//             ResponseObject.Add('data', Datum);
//         end;

//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure RetrieveMemberLoanTransactions(Payload: JsonObject; APIRequestID: JsonToken): Text
//     var
//         loan_number: JsonToken;
//         from: JsonToken;
//         _to: JsonToken;

//         LoanAccount: Record Loans;
//         CreditLedgerEntry: Record "Credit Ledger Entry";

//         StartDateTimeParts: List of [Text];
//         StartDate: Date;
//         EndDateTimeParts: List of [Text];
//         EndDate: Date;

//         transactions: JsonArray;
//         transaction: JsonObject;
//         ResponseObject: JsonObject;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         Payload.Get('loan_number', loan_number);
//         Payload.Get('from', from);
//         Payload.Get('to', _to);

//         LoanAccount.Reset;
//         LoanAccount.SetRange("Loan No.", loan_number.AsValue.AsText);

//         IF LoanAccount.FindFirst then begin
//             CreditLedgerEntry.Reset;
//             CreditLedgerEntry.SetCurrentkey("Entry No.");
//             CreditLedgerEntry.Ascending(false);
//             CreditLedgerEntry.SetRange("Loan No", LoanAccount."Loan No.");
//             CreditLedgerEntry.SetFilter("Transaction Type", '<>%1', CreditLedgerEntry."Transaction Type"::Bills);

//             StartDateTimeParts := from.AsValue.AsText.Split(' ');
//             EndDateTimeParts := _to.AsValue.AsText.Split(' ');

//             Evaluate(StartDate, StartDateTimeParts.Get(1));
//             Evaluate(EndDate, EndDateTimeParts.Get(1));

//             CreditLedgerEntry.SetFilter("Posting Date", '>=%1&<=%2', StartDate, EndDate);

//             IF CreditLedgerEntry.FindSet then begin

//                 repeat begin
//                     transaction.Add('transaction_code', CreditLedgerEntry."Document No.");

//                     if CreditLedgerEntry."Amount (LCY)" > 0 then begin
//                         transaction.Add('operation', 'Credit');
//                     end else begin
//                         transaction.Add('operation', 'Debit');
//                     end;
//                     transaction.Add('amount', CreditLedgerEntry."Amount (LCY)");

//                     transaction.Add('description', CreditLedgerEntry.Description);
//                     // transaction.Add('transaction_date', GlobalFunctions.FormatISODate(SavingsLedgerEntry."Posting Date"));
//                     // transaction.Add('transaction_time', Format(SavingsLedgerEntry."Posting Time"));
//                     Transaction.Add('running_balance', GlobalFunctions.GetLoanRunningBal(CreditLedgerEntry."Entry No.", LoanAccount."Loan No."));
//                     transaction.Add('timestamp', GlobalFunctions.FormatISODateTime(CreditLedgerEntry.SystemCreatedAt));


//                     transactions.Add(transaction);
//                     // Reset
//                     transaction.ReadFrom('{}');
//                 end until (CreditLedgerEntry.Next = 0);
//             end;

//             ResponseObject.Add('result_code', 0);
//             ResponseObject.Add('result_message', 'Success');
//             ResponseObject.Add('data', transactions);
//         end else begin
//             ResponseObject.Add('result_code', 400);
//             ResponseObject.Add('result_message', 'Loan NOT found');
//             Datum.Add('error_message', 'Loan with number ' + loan_number.AsValue.AsText + ' NOT found!');
//             ResponseObject.Add('data', Datum);
//         end;

//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure AccountRepayLoan(Payload: JsonObject; APIRequestID: JsonToken): Text
//     var
//         member_number: JsonToken;
//         account_number: JsonToken;
//         amount: JsonToken;
//         loan_number: JsonToken;

//         SearchMember: Record Members;
//         MemberAccount: Record "Savings Accounts";
//         MemberLoan: Record Loans;

//         ResponseObject: JsonObject;
//         Response: Text;
//     begin
//         // {
//         //     "member_number": "0000000",
//         //     "repay_from_account_number": "254712345678",
//         //     "amount": 10000,
//         //     "repay_to_loan_account_number": "0000000"
//         // }
//         Payload.Get('member_number', member_number);
//         Payload.Get('repay_from_account_number', account_number);
//         Payload.Get('amount', amount);
//         Payload.Get('repay_to_loan_account_number', loan_number);

//         SearchMember.Reset;
//         SearchMember.SetRange("No.", member_number.AsValue.AsText);

//         IF SearchMember.FindFirst then begin
//             MemberAccount.Reset;
//             MemberAccount.SetRange("Member No.", SearchMember."No.");
//             MemberAccount.SetRange("No.", account_number.AsValue.AsText);

//             if MemberAccount.FindFirst then begin
//                 MemberLoan.Reset;
//                 MemberLoan.SetRange("Member No.", SearchMember."No.");
//                 MemberLoan.SetRange("Loan No.", loan_number.AsValue.AsText);
//                 MemberLoan.SetFilter("Outstanding Balance", '>0');

//                 if MemberLoan.FindFirst then begin
//                     // TODO: Repayment logic...
//                     // 1. Verify balance
//                     // 2. Log the transaction
//                     // 3. Post the transaction

//                     ResponseObject.Add('result_code', 0);
//                     ResponseObject.Add('result_message', 'Success');
//                 end else begin
//                     ResponseObject.Add('result_code', 400);
//                     ResponseObject.Add('result_message', 'Loan NOT found or does NOT belong to the given member');
//                 end;
//             end else begin
//                 ResponseObject.Add('result_code', 400);
//                 ResponseObject.Add('result_message', 'Source account NOT found or does NOT belong to the given member');
//             end;
//         end else begin
//             ResponseObject.Add('result_code', 400);
//             ResponseObject.Add('result_message', 'Member NOT found');
//         end;

//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure GetGuarantorValidation(Payload: JsonObject; APIRequestID: JsonToken): Text
//     var
//         member_number: JsonToken;

//         SearchMember: Record Members;
//         Guarantors: Record "Loan Guarantors and Security";
//         ProductFactory: Record "Product Factory";

//         loans: JsonArray;
//         loan: JsonObject;
//         usages: JsonArray;
//         usage: JsonObject;
//         ResponseObject: JsonObject;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         Payload.Get('member_number', member_number);

//         SearchMember.Reset;
//         SearchMember.SetRange("No.", member_number.AsValue.AsText);

//         IF SearchMember.FindFirst then begin
//             Guarantors.Reset;
//             Guarantors.SetRange("Member No", SearchMember."No.");
//             Guarantors.SetRange("Guarantor Type", Guarantors."Guarantor Type"::Guarantor);
//             Guarantors.SetFilter("Outstanding Balance", '>0');

//             if Guarantors.FindSet then begin
//                 repeat begin
//                     loan.Add('member_guaranteed', Guarantors."Loanee Name");
//                     loan.Add('loan_no', Guarantors."Loan No");

//                     Guarantors.CalcFields("Loan Type");
//                     loan.Add('loan_product_code', Guarantors."Loan Type");

//                     ProductFactory.Reset;
//                     ProductFactory.SetRange("Product ID", Guarantors."Loan Type");
//                     if ProductFactory.FindFirst then begin
//                         loan.Add('loan_product_name', ProductFactory."Product Description");
//                     end else begin
//                         loan.Add('loan_product_name', Guarantors."Loan Type");
//                     end;

//                     loan.Add('amount_guaranteed', Guarantors."Amount Guaranteed");
//                     Guarantors.CalcFields("Outstanding Balance");
//                     loan.Add('loan_balance', Guarantors."Outstanding Balance");

//                     loans.Add(loan);

//                     loan.ReadFrom('{}');
//                 end until Guarantors.Next = 0;
//             end;

//             ResponseObject.Add('result_code', 0);
//             ResponseObject.Add('result_message', 'Success');
//             ResponseObject.Add('data', loans);
//         end else begin
//             ResponseObject.Add('result_code', 400);
//             ResponseObject.Add('result_message', 'Member NOT found');
//             Datum.Add('error_message', 'Member with number ' + member_number.AsValue.AsText + ' NOT found!');
//             ResponseObject.Add('data', Datum);
//         end;

//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure UploadDocuments(Payload: JsonObject; RequestAPIId: JsonToken): Text
//     var
//         member_number: JsonToken;
//         document_type: JsonToken;

//         KeyExists: Boolean;

//         MSmartDocumentsSetup: Record "M-Smart Documents Setup";
//         MSmartDocuments: Record "M-Smart Documents";
//         Member: Record Members;
//         ResponseObject: JsonObject;
//         ResponseData: JsonObject;
//         Errors: JsonArray;
//         Response: Text;
//     begin
//         KeyExists := Payload.Get('member_number', member_number);
//         KeyExists := Payload.Get('document_type', document_type);

//         MSmartDocumentsSetup.Reset;
//         MSmartDocumentsSetup.SetRange("Document Type", "M-Smart Documents".FromInteger(document_type.AsValue.AsInteger));

//         if not MSmartDocumentsSetup.FindFirst then begin
//             Error('Document of type: %1 has NOT been setup for uploads from Mwalimu Smart', document_type.AsValue.AsInteger);
//         end;

//         Member.Reset;
//         Member.SetRange("No.", member_number.AsValue.AsText);

//         if Member.FindFirst then begin
//             MSmartDocuments.Init();

//             MSmartDocuments."Member No." := Member."No.";
//             MSmartDocuments.Validate("Member No.");
//             MSmartDocuments."Document Type" := "M-Smart Documents".FromInteger(document_type.AsValue.AsInteger);

//             MSmartDocuments.Status := MSmartDocuments.Status::Open;
//             MSmartDocuments."Landing Department" := MSmartDocumentsSetup."Landing Department";

//             IF MSmartDocuments.Insert(true) then begin
//                 ResponseData.Add('application_status', Format(MSmartDocuments.Status));
//                 ResponseData.Add('crm_no', MSmartDocuments."No.");

//                 ResponseObject.Add('result_code', 0);
//                 ResponseObject.Add('result_message', 'Document(s) with application number ' + MSmartDocuments."No." + ' have been initiated successfully.');
//                 ResponseObject.Add('data', ResponseData);
//                 AddDateTimeToResponse(ResponseObject);

//                 ResponseObject.WriteTo(Response);
//             end else begin
//                 Error('Internal Error. Unable to initiate document application.');
//             end;
//         end else begin
//             Error('Unknown member with member number ' + member_number.AsValue.AsText);
//         end;

//         exit(Response);
//     end;

//     local procedure GetDocuments(): Text
//     var
//         MSmartDocumentsSetup: Record "M-Smart Documents Setup";

//         ResponseObject: JsonObject;
//         Data: JsonArray;
//         Datum: JsonObject;
//         Response: Text;
//     begin
//         MSmartDocumentsSetup.Reset;

//         if MSmartDocumentsSetup.FindSet then begin
//             repeat begin

//                 Datum.Add('document_id', MSmartDocumentsSetup."Document Type".AsInteger());
//                 Datum.Add('document_type', Format(MSmartDocumentsSetup."Document Type"));

//                 Data.Add(Datum);

//                 // Reset
//                 Datum.ReadFrom('{}');

//             end until MSmartDocumentsSetup.Next = 0;
//         end;


//         ResponseObject.Add('result_code', 0);
//         ResponseObject.Add('result_message', 'Request is successful');
//         ResponseObject.Add('data', Data);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure GetLoanProductQualificationAmount(Payload: JsonObject; APIRequestID: JsonToken): Text
//     var
//         member_number: JsonToken;
//         loan_product: JsonToken;

//         SearchMember: Record Members;
//         ActiveLoanProducts: Record "Product Factory";

//         LoansProcess: Codeunit "Loans Process";
//         SkyMbankingTrans: Codeunit "Sky M-Banking Transactions";

//         ResponseObject: JsonObject;
//         Response: Text;
//         EligibilityFailReason: Text;
//     begin
//         Payload.Get('member_number', member_number);
//         Payload.Get('loan_product', loan_product);

//         SearchMember.Reset;

//         SearchMember.SetRange("No.", member_number.AsValue.AsText);

//         IF SearchMember.FindFirst then begin
//             ActiveLoanProducts.Reset;

//             ActiveLoanProducts.SetRange("Product Class Type", ActiveLoanProducts."Product Class Type"::Loan);
//             ActiveLoanProducts.SetRange("Product ID", loan_product.AsValue.AsText);

//             if ActiveLoanProducts.FindFirst then begin
//                 ResponseObject.Add('result_code', 0);
//                 ResponseObject.Add('result_message', 'Success');
//                 ResponseObject.Add('data', SkyMbankingTrans.GetLoansQualifyAmount(member_number.AsValue.AsText, loan_product.AsValue.AsText,EligibilityFailReason));
//             end else begin
//                 ResponseObject.Add('result_code', 400);
//                 ResponseObject.Add('result_message', 'Loan Product NOT found');
//                 ResponseObject.Add('data', false);
//             end;
//         end else begin
//             ResponseObject.Add('result_code', 400);
//             ResponseObject.Add('result_message', 'Member NOT found');
//             ResponseObject.Add('data', false);
//         end;

//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure UnsupportedAction(RequestAction: Text): Text
//     var
//         ResponseObject: JsonObject;
//         Errors: JsonArray;
//         Response: Text;
//     begin
//         ResponseObject.Add('status', 'ERROR');
//         ResponseObject.Add('description', 'The requested action ' + RequestAction + ' is NOT supported.');
//         ResponseObject.Add('errors', Errors);
//         AddDateTimeToResponse(ResponseObject);

//         ResponseObject.WriteTo(Response);

//         exit(Response);
//     end;

//     local procedure AddDateTimeToResponse(var ResponseObject: JsonObject)
//     begin
//         ResponseObject.Add('date_time', GlobalFunctions.FormatISODateTime(CurrentDateTime));
//     end;

//     var
//         BranchDimensionCode: Label 'BRANCH';
//         VendorName: Label 'Mwalimu Smart - Malakoff';
//         GlobalFunctions: Codeunit "Global Functions";
//         CRMOriginationType: Enum "CRM Originations";
//         EDMSFunctions: Codeunit "EDMS Functions";
// }