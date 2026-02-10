/*
codeunit 52186501 "CRB TransUnion API"
{
    Description = 'APIs to integrate to CRB - Trans Union';
    trigger OnRun()
    begin
    end;

    procedure Login(ShowSuccessMessage: Boolean)
    var
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        Response: HttpResponseMessage;
        ResponseText: Text;
        HttpStatusCode: Integer;
        PayloadObject: JsonObject;
        Payload: Text;
        ResponseParser: JsonObject;
        Token: JsonToken;
        CRBTransUnionTable: Record "CRB Trans Union API Setup";
        CRBTransUnionLogsTable: Record "BC API Logs";

        Index: Integer;
        HeaderKeys: List of [Text];
        HeaderKey: Text;
        HeaderValues: List of [Text];
        HeaderValuesIndex: Integer;
        HeaderValuesText: Text;
        HeaderValue: Text;
        HeaderText: Text;
    begin
        LoginToken := '';

        // 1. Check if API credentials have been set on the table
        IF CRBTransUnionTable.FindFirst() then begin
            // 2. Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');

            // 3. Prepare the payload data
            // {
            //     "infinityCode": "{{infinityCode}}",
            //     "password": "{{password}}",
            //     "username": "{{username}}"
            // }
            PayloadObject.Add('infinityCode', CRBTransUnionTable."Infinity Code");
            PayloadObject.Add('password', CRBTransUnionTable.Password);
            PayloadObject.Add('username', CRBTransUnionTable.Username);

            PayloadObject.WriteTo(Payload);

            Content.WriteFrom(Payload);

            IsSuccessful := Client.Post(CRBTransUnionTable."Base URL" + '/login', Content, Response);
            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // {
                    // "token": "TOKEN_VALUE",
                    // "expiresAfter": "1800000",
                    // "status": "Ok"
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    ResponseParser.Get('token', Token);

                    LoginToken := Token.AsValue.AsText;

                    IF ShowSuccessMessage then begin
                        Message('CRB Trans Union API status : %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                    end;
                end else begin
                    // Errors - 403, 404, etc
                    CRBTransUnionLogsTable.Init;
                    CRBTransUnionLogsTable."Request URL" := CRBTransUnionTable."Base URL" + '/login';
                    CRBTransUnionLogsTable."Vendor Name" := VendorName;

                    HeaderText := '';
                    HeaderValuesText := '';
                    HeaderKeys := ContentHeaders.Keys();
                    for Index := 1 to HeaderKeys.Count do begin
                        HeaderKeys.Get(Index, HeaderKey);
                        ContentHeaders.GetValues(HeaderKey, HeaderValues);

                        HeaderValuesText := '';
                        for HeaderValuesIndex := 1 to HeaderValues.Count do begin
                            IF HeaderValuesText = '' then begin
                                HeaderValuesText := HeaderValues.Get(HeaderValuesIndex);
                            end else begin
                                HeaderValuesText := HeaderValuesText + ',' + HeaderValues.Get(HeaderValuesIndex);
                            end;

                            HeaderValues.Remove(HeaderValues.Get(HeaderValuesIndex));
                        end;

                        HeaderText := HeaderText + HeaderKey + ': ' + HeaderValuesText + ' | ';
                    end;
                    CRBTransUnionLogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    CRBTransUnionLogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    CRBTransUnionLogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    CRBTransUnionLogsTable."Response Headers" := '';
                    CRBTransUnionLogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    CRBTransUnionLogsTable.Miscellaneous := '';
                    CRBTransUnionLogsTable.Insert;

                    Message('CRB Trans Union API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                CRBTransUnionLogsTable.Init;
                CRBTransUnionLogsTable."Request URL" := CRBTransUnionTable."Base URL" + '/login';
                CRBTransUnionLogsTable."Vendor Name" := VendorName;

                HeaderText := '';
                HeaderValuesText := '';
                HeaderKeys := ContentHeaders.Keys();
                for Index := 1 to HeaderKeys.Count do begin
                    HeaderKeys.Get(Index, HeaderKey);
                    ContentHeaders.GetValues(HeaderKey, HeaderValues);

                    HeaderValuesText := '';
                    for HeaderValuesIndex := 1 to HeaderValues.Count do begin
                        IF HeaderValuesText = '' then begin
                            HeaderValuesText := HeaderValues.Get(HeaderValuesIndex);
                        end else begin
                            HeaderValuesText := HeaderValuesText + ',' + HeaderValues.Get(HeaderValuesIndex);
                        end;

                        HeaderValues.Remove(HeaderValues.Get(HeaderValuesIndex));
                    end;

                    HeaderText := HeaderText + HeaderKey + ': ' + HeaderValuesText + ' | ';
                end;
                CRBTransUnionLogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                CRBTransUnionLogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                CRBTransUnionLogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRBTransUnionLogsTable."Response Headers" := '';
                CRBTransUnionLogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                CRBTransUnionLogsTable.Miscellaneous := 'CRB Trans Union API Login has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRBTransUnionLogsTable.Insert;

                Message('CRB Trans Union API Login has failed. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;
        end else begin
            CRBTransUnionLogsTable.Init;
            CRBTransUnionLogsTable."Request URL" := 'NOT_SET';
            CRBTransUnionLogsTable."Vendor Name" := VendorName;
            CRBTransUnionLogsTable."Request Headers" := 'N/A';
            CRBTransUnionLogsTable."Request Data" := 'N/A';
            CRBTransUnionLogsTable."Response Status Code" := 'N/A';
            CRBTransUnionLogsTable."Response Headers" := 'N/A';
            CRBTransUnionLogsTable."Response Data" := 'N/A';
            CRBTransUnionLogsTable.Miscellaneous := 'Unable to initiate login. API credentials have NOT been set on the ' + CRBTransUnionTable.TableName + ' table. Kindly contact the system administrator.';
            CRBTransUnionLogsTable.Insert;

            Message('Unable to initiate login. API credentials have NOT been set on the %1 table. Kindly contact the system administrator.', CRBTransUnionTable.TableName);
        end;
    end;

    procedure DailyPaymentInformation(
        AccountNumber: Text;
        AccountStatus: Text;
        ClientType: Text;
        CompanyName: Text;
        CurrencyOfFacility: Text;
        CurrentBalance: Integer;
        DaysInArrears: Integer;
        Forename1: Text;
        Forename2: Text;
        Forename3: Text;
        InstallmentsInArrears: Integer;
        OriginalAmount: Integer;
        PaymentAmount: Integer;
        PaymentDate: Text;
        PrimaryIdentificationDocNumber: Text;
        PrimaryIdentificationDocumentType: Text;
        SnapshotDate: Text;
        Surname: Text)
    var
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        Response: HttpResponseMessage;
        ResponseText: Text;
        HttpStatusCode: Integer;
        PayloadObject: JsonObject;
        Payload: Text;
        ResponseParser: JsonObject;
        ResponseCode: JsonToken;
        ResponseMessage: JsonToken;
        DailyPaymentInformationRecord: JsonObject;
        RecordErrors: JsonToken;
        RecordError: JsonToken;
        CRBTransUnionTable: Record "CRB Trans Union API Setup";
        CRBTransUnionLogsTable: Record "BC API Logs";
        ErrorCode: JsonToken;
        ErrorMessage: JsonToken;
        FieldName: JsonToken;
        FieldValue: JsonToken;
        MultilineErrorMessages: Text;

        Index: Integer;
        HeaderKeys: List of [Text];
        HeaderKey: Text;
        HeaderValues: List of [Text];
        HeaderValuesIndex: Integer;
        HeaderValuesText: Text;
        HeaderValue: Text;
        HeaderText: Text;
    begin
        // 1. Login
        Login(false);

        // 2. Check login token
        IF NOT (LoginToken = '') then begin
            // 3. Prepare the payload data
            // {
            //     "dailyPaymentInformationRecord": {
            //         "accountNumber": "As234546",
            //         "accountStatus": "A",
            //         "clientType": "A",
            //         "companyName": "",
            //         "currencyOfFacility": "KES",
            //         "currentBalance": 1000,
            //         "daysInArrears": 0,
            //         "forename1": "test",
            //         "forename2": "testb",
            //         "forename3": "testc",
            //         "installmentsInArrears": 0,
            //         "originalAmount": 100000,
            //         "paymentAmount": 5000,
            //         "paymentDate": "20200202",
            //         "primaryIdentificationDocNumber": "1",
            //         "primaryIdentificationDocumentType": "001",
            //         "snapshotDate": "20200202",
            //         "surname": "test"
            //     },
            //     "recordType": "DP"
            // }
            DailyPaymentInformationRecord.Add('accountNumber', AccountNumber);
            DailyPaymentInformationRecord.Add('accountStatus', AccountStatus);
            DailyPaymentInformationRecord.Add('clientType', ClientType);
            DailyPaymentInformationRecord.Add('companyName', CompanyName);
            DailyPaymentInformationRecord.Add('currencyOfFacility', CurrencyOfFacility);
            DailyPaymentInformationRecord.Add('currentBalance', CurrentBalance);
            DailyPaymentInformationRecord.Add('daysInArrears', DaysInArrears);
            DailyPaymentInformationRecord.Add('forename1', Forename1);
            DailyPaymentInformationRecord.Add('forename2', Forename2);
            DailyPaymentInformationRecord.Add('forename3', Forename3);
            DailyPaymentInformationRecord.Add('installmentsInArrears', InstallmentsInArrears);
            DailyPaymentInformationRecord.Add('originalAmount', OriginalAmount);
            DailyPaymentInformationRecord.Add('paymentAmount', PaymentAmount);
            DailyPaymentInformationRecord.Add('paymentDate', PaymentDate);
            DailyPaymentInformationRecord.Add('primaryIdentificationDocNumber', PrimaryIdentificationDocNumber);
            DailyPaymentInformationRecord.Add('primaryIdentificationDocumentType', PrimaryIdentificationDocumentType);
            DailyPaymentInformationRecord.Add('snapshotDate', SnapshotDate);
            DailyPaymentInformationRecord.Add('surname', Surname);

            PayloadObject.Add('dailyPaymentInformationRecord', DailyPaymentInformationRecord);
            PayloadObject.Add('recordType', 'DP');

            PayloadObject.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // Fetch TransUnion credentials
            CRBTransUnionTable.FindFirst();

            // Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');
            // Authorization header
            Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + LoginToken);

            IsSuccessful := Client.Post(CRBTransUnionTable."Base URL" + '/data/ke/update/dailypaymentinformation', Content, Response);

            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // {
                    //     "message": "Success",
                    //     "responseCode": 200,
                    //     "callbackId": "61899e9e-9af2-49f2-8892-03a1cbf49e1c",
                    //     "recordErrors": []
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    ResponseParser.Get('responseCode', ResponseCode);
                    ResponseParser.Get('message', ResponseMessage);


                    if ResponseCode.AsValue.AsInteger = 200 then begin
                        // API success
                        Message('SUCCESS. CRB data has been submitted successfully to TransUnion!');
                    end else begin
                        // {
                        //     "message": "Failed validation, check errors",
                        //     "responseCode": 600,
                        //     "callbackId": "84a8f340-d3fb-44bf-8ec3-5872b70c6023",
                        //     "recordErrors": [
                        //         {
                        //             "accountNumber": "As234546",
                        //             "errorMessage": "Field requires more than one characters",
                        //             "fieldName": "Forename 3",
                        //             "fieldValue": "a ",
                        //             "errorCode": "ENF011"
                        //         },
                        //         {
                        //             "accountNumber": "As234546",
                        //             "errorMessage": "A name must be composed of only alphabetic characters, ', -, . and must be at least 2 characters long",
                        //             "fieldName": "Surname",
                        //             "fieldValue": "test1",
                        //             "errorCode": "ENF027"
                        //         }
                        //     ]
                        // }
                        Message('FAILED. CRB data has NOT been submitted. Response code %1 - %2',
                        ResponseCode.AsValue.AsInteger,
                        ResponseMessage.AsValue.AsText);

                        ResponseParser.Get('recordErrors', RecordErrors);

                        For Index := 1 to RecordErrors.AsArray.Count do begin
                            RecordErrors.AsArray.Get(Index - 1, RecordError);

                            RecordError.AsObject.Get('errorMessage', ErrorMessage);
                            RecordError.AsObject.Get('fieldName', FieldName);
                            RecordError.AsObject.Get('fieldValue', FieldValue);
                            RecordError.AsObject.Get('errorCode', ErrorCode);

                            MultilineErrorMessages := MultilineErrorMessages +
                            '(' + ErrorCode.AsValue.AsText + ') ' +
                            FieldName.AsValue.AsText + ' - ' +
                            ErrorMessage.AsValue.AsText + '. Current value is ' +
                            FieldValue.AsValue.AsText + '\';
                        end;

                        Message(MultilineErrorMessages);
                    end;

                end else begin
                    // Errors - 403, 404, etc
                    CRBTransUnionLogsTable.Init;
                    CRBTransUnionLogsTable."Request URL" := CRBTransUnionTable."Base URL" + '/data/ke/update/dailypaymentinformation';
                    CRBTransUnionLogsTable."Vendor Name" := VendorName;

                    HeaderText := '';
                    HeaderValuesText := '';
                    HeaderKeys := ContentHeaders.Keys();
                    for Index := 1 to HeaderKeys.Count do begin
                        HeaderKeys.Get(Index, HeaderKey);
                        ContentHeaders.GetValues(HeaderKey, HeaderValues);

                        HeaderValuesText := '';
                        for HeaderValuesIndex := 1 to HeaderValues.Count do begin
                            IF HeaderValuesText = '' then begin
                                HeaderValuesText := HeaderValues.Get(HeaderValuesIndex);
                            end else begin
                                HeaderValuesText := HeaderValuesText + ',' + HeaderValues.Get(HeaderValuesIndex);
                            end;

                            HeaderValues.Remove(HeaderValues.Get(HeaderValuesIndex));
                        end;

                        HeaderText := HeaderText + HeaderKey + ': ' + HeaderValuesText + ' | ';
                    end;
                    CRBTransUnionLogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    CRBTransUnionLogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    CRBTransUnionLogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    CRBTransUnionLogsTable."Response Headers" := '';
                    CRBTransUnionLogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    CRBTransUnionLogsTable.Miscellaneous := '';
                    CRBTransUnionLogsTable.Insert;

                    Message('CRB Trans Union API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                CRBTransUnionLogsTable.Init;
                CRBTransUnionLogsTable."Request URL" := CRBTransUnionTable."Base URL" + '/data/ke/update/dailypaymentinformation';
                CRBTransUnionLogsTable."Vendor Name" := VendorName;

                HeaderText := '';
                HeaderValuesText := '';
                HeaderKeys := ContentHeaders.Keys();
                for Index := 1 to HeaderKeys.Count do begin
                    HeaderKeys.Get(Index, HeaderKey);
                    ContentHeaders.GetValues(HeaderKey, HeaderValues);

                    HeaderValuesText := '';
                    for HeaderValuesIndex := 1 to HeaderValues.Count do begin
                        IF HeaderValuesText = '' then begin
                            HeaderValuesText := HeaderValues.Get(HeaderValuesIndex);
                        end else begin
                            HeaderValuesText := HeaderValuesText + ',' + HeaderValues.Get(HeaderValuesIndex);
                        end;

                        HeaderValues.Remove(HeaderValues.Get(HeaderValuesIndex));
                    end;

                    HeaderText := HeaderText + HeaderKey + ': ' + HeaderValuesText + ' | ';
                end;
                CRBTransUnionLogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                CRBTransUnionLogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                CRBTransUnionLogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRBTransUnionLogsTable."Response Headers" := '';
                CRBTransUnionLogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                CRBTransUnionLogsTable.Miscellaneous := 'CRB Trans Union API daily submission has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRBTransUnionLogsTable.Insert;

                Message('CRB Trans Union API daily submission has failed. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;


        end else begin
            // Error
            Error('Unable to submit CRB daily payment information at the moment. Kindly contact the administrator.');
        end;
    end;

    procedure TestDailyPaymentInformation()
    begin
        // {
        //     "recordType":"DP",
        //     "dailyPaymentInformationRecord":{
        //         "accountNumber":"As234546",
        //         "accountStatus":"A",
        //         "clientType":"A",
        //         "companyName":"",
        //         "currencyOfFacility":"KES",
        //         "currentBalance":1000,
        //         "daysInArrears":0,
        //         "forename1":"test",
        //         "forename2":"testb",
        //         "forename3":"testc",
        //         "installmentsInArrears":0,
        //         "originalAmount":100000,
        //         "paymentAmount":5000,
        //         "paymentDate":"20200202",
        //         "primaryIdentificationDocNumber":"1",
        //         "primaryIdentificationDocumentType":"001",
        //         "snapshotDate":"20200202",
        //         "surname":"test"
        //     }
        // }
        DailyPaymentInformation(
            'As234546',
            'A',
            'A',
            '',
            'KES',
            1000,
            0,
            'test',
            'testb',
            'testc',
            0,
            100000,
            5000,
            '20200202',
            '1',
            '001',
            '20200202',
            'test'
        );
    end;

    procedure MobileFacilityInformation(
        AccountNumber: Text;
        AccountProductType: Text;
        AccountStatus: Text;
        AccountStatusDate: Text;
        AmountInKenyaShillings: Integer;
        ClientNumber: Text;
        CurrencyOfFacility: Text;
        CurrentBalance: Integer;
        DateOfBirth: Text;
        DateOfLatestPayment: Text;
        DisbursementDate: Text;
        Forename1: Text;
        Forename2: Text;
        Forename3: Text;
        Gender: Text;
        InstalmentAmount: Integer;
        InstalmentDueDate: Text;
        LastPaymentAmount: Integer;
        MobilePhoneNumber: Text;
        Nationality: Text;
        NumberOfDaysInArrears: Integer;
        NumberOfInstalmentsInArrears: Integer;
        OriginalAmount: Integer;
        OverdueBalance: Integer;
        OverdueDate: Text;
        PrimaryIdentificationDocumentNumber: Text;
        PrimaryIdentificationDocumentType: Text;
        PrudentialRiskClassification: Text;
        RepaymentPeriod: Integer;
        Surname: Text;
        TradingAs: Text
        )
    var
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        Response: HttpResponseMessage;
        ResponseText: Text;
        HttpStatusCode: Integer;
        PayloadObject: JsonObject;
        Payload: Text;
        ResponseParser: JsonObject;
        ResponseCode: JsonToken;
        ResponseMessage: JsonToken;
        MobileFacilityRecord: JsonObject;
        RecordErrors: JsonToken;
        RecordError: JsonToken;
        CRBTransUnionTable: Record "CRB Trans Union API Setup";
        CRBTransUnionLogsTable: Record "BC API Logs";
        ErrorCode: JsonToken;
        ErrorMessage: JsonToken;
        FieldName: JsonToken;
        FieldValue: JsonToken;
        MultilineErrorMessages: Text;

        Index: Integer;
        HeaderKeys: List of [Text];
        HeaderKey: Text;
        HeaderValues: List of [Text];
        HeaderValuesIndex: Integer;
        HeaderValuesText: Text;
        HeaderValue: Text;
        HeaderText: Text;
    begin
        // 1. Login
        Login(false);

        // 2. Check login token
        IF NOT (LoginToken = '') then begin
            // 3. Prepare the payload data
            // {
            //     "mobileFacilityRecord": {
            //         "accountNumber": "MOB1",
            //         "accountProductType": "I",
            //         "accountStatus": "B",
            //         "accountStatusDate": "20230303",
            //         "amountInKenyaShillings": 100000,
            //         "clientNumber": "CLIENT001",
            //         "currencyOfFacility": "KES",
            //         "currentBalance": 50000,
            //         "dateOfBirth": "19900101",
            //         "dateOfLatestPayment": "20220101",
            //         "disbursementDate": "20210101",
            //         "forename1": "Test",
            //         "forename2": "John",
            //         "forename3": "Test",
            //         "gender": "M",
            //         "instalmentAmount": 10000,
            //         "instalmentDueDate": "20230101",
            //         "lastPaymentAmount": 2000,
            //         "mobilePhoneNumber": "254722000000",
            //         "nationality": "KE",
            //         "numberOfDaysInArrears": 30,
            //         "numberOfInstalmentsInArrears": 1,
            //         "originalAmount": 1000000,
            //         "overdueBalance": 800000,
            //         "overdueDate": "20230131",
            //         "primaryIdentificationDocumentNumber": "123456789",
            //         "primaryIdentificationDocumentType": "001",
            //         "prudentialRiskClassification": "C",
            //         "repaymentPeriod": 48,
            //         "surname": "Test",
            //         "tradingAs": "BIZ"
            //     },
            //     "recordType": "DP"
            // }
            MobileFacilityRecord.Add('accountProductType', AccountProductType);
            MobileFacilityRecord.Add('accountStatusDate', AccountStatusDate);
            MobileFacilityRecord.Add('amountInKenyaShillings', AmountInKenyaShillings);
            MobileFacilityRecord.Add('clientNumber', ClientNumber);
            MobileFacilityRecord.Add('dateOfBirth', DateOfBirth);
            MobileFacilityRecord.Add('dateOfLatestPayment', DateOfLatestPayment);
            MobileFacilityRecord.Add('disbursementDate', DisbursementDate);
            MobileFacilityRecord.Add('gender', Gender);
            MobileFacilityRecord.Add('instalmentAmount', InstalmentAmount);
            MobileFacilityRecord.Add('instalmentDueDate', InstalmentDueDate);
            MobileFacilityRecord.Add('lastPaymentAmount', LastPaymentAmount);
            MobileFacilityRecord.Add('mobilePhoneNumber', MobilePhoneNumber);
            MobileFacilityRecord.Add('nationality', Nationality);
            MobileFacilityRecord.Add('numberOfDaysInArrears', NumberOfDaysInArrears);
            MobileFacilityRecord.Add('numberOfInstalmentsInArrears', NumberOfInstalmentsInArrears);
            MobileFacilityRecord.Add('overdueBalance', OverdueBalance);
            MobileFacilityRecord.Add('overdueDate', OverdueDate);
            MobileFacilityRecord.Add('primaryIdentificationDocumentNumber', PrimaryIdentificationDocumentNumber);
            MobileFacilityRecord.Add('prudentialRiskClassification', PrudentialRiskClassification);
            MobileFacilityRecord.Add('repaymentPeriod', RepaymentPeriod);
            MobileFacilityRecord.Add('tradingAs', TradingAs);
            MobileFacilityRecord.Add('accountNumber', AccountNumber);
            MobileFacilityRecord.Add('accountStatus', AccountStatus);
            MobileFacilityRecord.Add('currencyOfFacility', CurrencyOfFacility);
            MobileFacilityRecord.Add('currentBalance', CurrentBalance);
            MobileFacilityRecord.Add('forename1', Forename1);
            MobileFacilityRecord.Add('forename2', Forename2);
            MobileFacilityRecord.Add('forename3', Forename3);
            MobileFacilityRecord.Add('originalAmount', OriginalAmount);
            MobileFacilityRecord.Add('primaryIdentificationDocumentType', PrimaryIdentificationDocumentType);
            MobileFacilityRecord.Add('surname', Surname);

            PayloadObject.Add('mobileFacilityRecord', MobileFacilityRecord);
            PayloadObject.Add('recordType', 'DP');

            PayloadObject.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // Fetch TransUnion credentials
            CRBTransUnionTable.FindFirst();

            // Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');
            // Authorization header
            Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + LoginToken);

            IsSuccessful := Client.Post(CRBTransUnionTable."Base URL" + '/data/ke/update/mobilefacilityinformation', Content, Response);

            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // {
                    //     "message": "Success",
                    //     "responseCode": 200,
                    //     "callbackId": "61899e9e-9af2-49f2-8892-03a1cbf49e1c",
                    //     "recordErrors": []
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    ResponseParser.Get('responseCode', ResponseCode);
                    ResponseParser.Get('message', ResponseMessage);


                    if ResponseCode.AsValue.AsInteger = 200 then begin
                        // API success
                        Message('SUCCESS. CRB data has been submitted successfully to TransUnion!');
                    end else begin
                        // {
                        //     "message": "Failed validation, check errors",
                        //     "responseCode": 600,
                        //     "callbackId": "84a8f340-d3fb-44bf-8ec3-5872b70c6023",
                        //     "recordErrors": [
                        //         {
                        //             "accountNumber": "As234546",
                        //             "errorMessage": "Field requires more than one characters",
                        //             "fieldName": "Forename 3",
                        //             "fieldValue": "a ",
                        //             "errorCode": "ENF011"
                        //         },
                        //         {
                        //             "accountNumber": "As234546",
                        //             "errorMessage": "A name must be composed of only alphabetic characters, ', -, . and must be at least 2 characters long",
                        //             "fieldName": "Surname",
                        //             "fieldValue": "test1",
                        //             "errorCode": "ENF027"
                        //         }
                        //     ]
                        // }
                        Message('FAILED. CRB data has NOT been submitted. Response code %1 - %2',
                        ResponseCode.AsValue.AsInteger,
                        ResponseMessage.AsValue.AsText);

                        ResponseParser.Get('recordErrors', RecordErrors);

                        For Index := 1 to RecordErrors.AsArray.Count do begin
                            RecordErrors.AsArray.Get(Index - 1, RecordError);

                            RecordError.AsObject.Get('errorMessage', ErrorMessage);
                            RecordError.AsObject.Get('fieldName', FieldName);
                            RecordError.AsObject.Get('fieldValue', FieldValue);
                            RecordError.AsObject.Get('errorCode', ErrorCode);

                            MultilineErrorMessages := MultilineErrorMessages +
                            '(' + ErrorCode.AsValue.AsText + ') ' +
                            FieldName.AsValue.AsText + ' - ' +
                            ErrorMessage.AsValue.AsText + '. Current value is ' +
                            FieldValue.AsValue.AsText + '\';
                        end;

                        Message(MultilineErrorMessages);
                    end;

                end else begin
                    // Errors - 403, 404, etc
                    CRBTransUnionLogsTable.Init;
                    CRBTransUnionLogsTable."Request URL" := CRBTransUnionTable."Base URL" + '/data/ke/update/mobilefacilityinformation';
                    CRBTransUnionLogsTable."Vendor Name" := VendorName;

                    HeaderText := '';
                    HeaderValuesText := '';
                    HeaderKeys := ContentHeaders.Keys();
                    for Index := 1 to HeaderKeys.Count do begin
                        HeaderKeys.Get(Index, HeaderKey);
                        ContentHeaders.GetValues(HeaderKey, HeaderValues);

                        HeaderValuesText := '';
                        for HeaderValuesIndex := 1 to HeaderValues.Count do begin
                            IF HeaderValuesText = '' then begin
                                HeaderValuesText := HeaderValues.Get(HeaderValuesIndex);
                            end else begin
                                HeaderValuesText := HeaderValuesText + ',' + HeaderValues.Get(HeaderValuesIndex);
                            end;

                            HeaderValues.Remove(HeaderValues.Get(HeaderValuesIndex));
                        end;

                        HeaderText := HeaderText + HeaderKey + ': ' + HeaderValuesText + ' | ';
                    end;
                    CRBTransUnionLogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    CRBTransUnionLogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    CRBTransUnionLogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    CRBTransUnionLogsTable."Response Headers" := '';
                    CRBTransUnionLogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    CRBTransUnionLogsTable.Miscellaneous := '';
                    CRBTransUnionLogsTable.Insert;

                    Message('CRB Trans Union API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                CRBTransUnionLogsTable.Init;
                CRBTransUnionLogsTable."Request URL" := CRBTransUnionTable."Base URL" + '/data/ke/update/mobilefacilityinformation';
                CRBTransUnionLogsTable."Vendor Name" := VendorName;

                HeaderText := '';
                HeaderValuesText := '';
                HeaderKeys := ContentHeaders.Keys();
                for Index := 1 to HeaderKeys.Count do begin
                    HeaderKeys.Get(Index, HeaderKey);
                    ContentHeaders.GetValues(HeaderKey, HeaderValues);

                    HeaderValuesText := '';
                    for HeaderValuesIndex := 1 to HeaderValues.Count do begin
                        IF HeaderValuesText = '' then begin
                            HeaderValuesText := HeaderValues.Get(HeaderValuesIndex);
                        end else begin
                            HeaderValuesText := HeaderValuesText + ',' + HeaderValues.Get(HeaderValuesIndex);
                        end;

                        HeaderValues.Remove(HeaderValues.Get(HeaderValuesIndex));
                    end;

                    HeaderText := HeaderText + HeaderKey + ': ' + HeaderValuesText + ' | ';
                end;
                CRBTransUnionLogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                CRBTransUnionLogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                CRBTransUnionLogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRBTransUnionLogsTable."Response Headers" := '';
                CRBTransUnionLogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                CRBTransUnionLogsTable.Miscellaneous := 'CRB Trans Union API daily submission has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRBTransUnionLogsTable.Insert;

                Message('CRB Trans Union API daily submission has failed. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;


        end else begin
            // Error
            Error('Unable to submit CRB daily payment information at the moment. Kindly contact the administrator.');
        end;
    end;

    procedure TestMobileFacilityInformation()
    begin
        MobileFacilityInformation(
            'MOB1',
            'I',
            'B',
            '20230303',
            100000,
            'CLIENT001',
            'KES',
            50000,
            '19900101',
            '20220101',
            '20210101',
            'Test',
            'John',
            'Test',
            'M',
            10000,
            '20230101',
            2000,
            '254722000000',
            'KE',
            30,
            1,
            1000000,
            800000,
            '20230131',
            '123456789',
            '001',
            'C',
            48,
            'Test',
            'BIZ'
        );
    end;

    // QUEUE Functions
    local procedure LogDailyPaymentInformationFile(
        TheLoan: Record Loans;
        var TheCreditLedgerEntry: Record "Credit Ledger Entry"
    )
    var
        TheLoanee: Record Members;
        TheCRBSubmission: Record "CRB DPI File Submissions";
        TheMonthlyCRBICESubmission: Record "CRB Monthly ICE File Subm.";
        TheMonthlyCRBNICESubmission: Record "CRB Monthly NICE File Subm.";
        TheCLEntries: Record "Credit Ledger Entry";
        TotalPayment: Decimal;
    begin
        if TheLoanee.Get(TheLoan."Member No.") then begin
            TheLoan.CalcFields(
                "Total Loan Balance",
                "Loan Amount",
                "Actively Attached",
                "Actively Attached II",
                "Days In Arrears",
                "Interest Paid",
                "Principle Paid",
                "Daily Interest"
            );

            if (TheLoan."Actively Attached" > 0) or (TheLoan."Actively Attached II" > 0) then begin
                // Attached loan listing
                if TheLoanee."Account Type" = TheLoanee."Account Type"::"Single Member Account" then begin
                    TheMonthlyCRBICESubmission.Reset;
                    TheMonthlyCRBICESubmission.SetRange("Loan No.", TheLoan."Loan No.");

                    if not TheMonthlyCRBICESubmission.FindFirst then begin
                        LogMonthlyICEFile(
                            TheLoan,
                            TheCreditLedgerEntry,
                            true
                        );
                    end;

                    exit;
                end else begin
                    TheMonthlyCRBNICESubmission.Reset;
                    TheMonthlyCRBNICESubmission.SetRange("Loan No.", TheLoan."Loan No.");

                    if not TheMonthlyCRBNICESubmission.FindFirst then begin
                        LogMonthlyNICEFile(
                            TheLoan,
                            TheCreditLedgerEntry,
                            true
                        );
                    end;

                    exit;
                end;
            end;

            TheCRBSubmission.Reset;

            TheCRBSubmission.SetRange("Loan No.", TheCreditLedgerEntry."Loan No");
            TheCRBSubmission.SetRange("CL Document No", TheCreditLedgerEntry."Document No.");
            TheCRBSubmission.SetRange("Log Date", Today);
            TheCRBSubmission.SetRange("CRB Institution", theCRBInstitution);

            if TheCRBSubmission.FindFirst then begin
                // Modify
                TheCLEntries.Reset;
                TheCLEntries.SetRange("Loan No", TheCreditLedgerEntry."Loan No");
                TheCLEntries.SetRange("Document No.", TheCreditLedgerEntry."Document No.");
                TheCLEntries.SetRange("Posting Date", Today);

                TotalPayment := 0;

                if TheCLEntries.FindSet then begin
                    repeat begin
                        TotalPayment += TheCLEntries.Amount;
                    end until TheCLEntries.Next = 0;
                end;

                TheCRBSubmission."Original Amount" := Format((TheLoan."Approved Amount" * 100) div 1).Replace(',', '');
                TheCRBSubmission."Payment Amount" := Format((-(TotalPayment) * 100) div 1).Replace(',', '');
                TheCRBSubmission."Current Balance" := Format(((TheLoan."Total Loan Balance" + TheLoan."Daily Interest") * 100) div 1).Replace(',', '');
                TheCRBSubmission."Installments in Arrears" := (TheLoan."Days In Arrears" div 30) + 1;
                TheCRBSubmission."Days in Arrears" := TheLoan."Days In Arrears";

                if TheLoan."Days In Arrears" <= 0 then begin
                    TheCRBSubmission."Installments in Arrears" := 0;
                end;

                if TheLoan."Total Loan Balance" <= 0 then begin
                    TheCRBSubmission."Current Balance" := '0';
                    TheCRBSubmission."Installments in Arrears" := 0;
                    TheCRBSubmission."Days in Arrears" := 0;
                end;

                TheCRBSubmission."Account Status" := 'F';

                if (TheLoan."Total Loan Balance" <= 0) then begin
                    if (TheLoanee.Subflag = TheLoanee.Subflag::Defaulter) then begin
                        TheCRBSubmission."Account Status" := 'J';
                    end else begin
                        TheCRBSubmission."Account Status" := 'H';
                    end;
                end;

                if TheLoan."Loan Rescheduled" then begin
                    TheCRBSubmission."Account Status" := 'G';
                end;

                if TheLoan."Moratorium Loan" then begin
                    TheCRBSubmission."Account Status" := 'M';
                end;

                if TheLoanee.Status = TheLoanee.Status::Deceased then begin
                    TheCRBSubmission."Account Status" := 'L';
                end;

                TheCRBSubmission.Modify();
            end else begin
                TheCRBSubmission.Init();

                TheCRBSubmission."CL Document No" := TheCreditLedgerEntry."Document No.";

                TheCRBSubmission."Loan No." := TheLoan."Loan No.";
                TheCRBSubmission.Validate("Loan No.");
                TheCRBSubmission."CRB Institution" := theCRBInstitution;
                TheCRBSubmission."Snapshot Date" := GFunc.FormatCRBDate(Today);

                if TheLoanee."Account Type" = TheLoanee."Account Type"::"Single Member Account" then begin
                    TheCRBSubmission."Client Type" := 'A';
                    TheCRBSubmission.Surname := TheLoanee."Other Names";
                    TheCRBSubmission."Forename 1" := TheLoanee."First Name";
                    TheCRBSubmission."Forename 2" := TheLoanee."Middle Name";
                    TheCRBSubmission."Forename 3" := TheLoanee."Other Names";

                    if (TheLoanee."Other Names" = '') or (StrLen(TheLoanee."Other Names") = 1) then begin
                        TheCRBSubmission.Surname := TheLoanee."Middle Name";
                        TheCRBSubmission."Forename 3" := '';
                    end;

                    TheCRBSubmission."Company Name" := '';

                    case TheLoanee."Primary Identification Type" of
                        TheLoanee."Primary Identification Type"::"ID Number":
                            begin
                                TheCRBSubmission."Primary Id Doc Type" := '001';
                                TheCRBSubmission."Primary Id Doc No." := TheLoanee."Primary Identification";
                            end;
                        TheLoanee."Primary Identification Type"::"Passport No":
                            begin
                                TheCRBSubmission."Primary Id Doc Type" := '002';
                                TheCRBSubmission."Primary Id Doc No." := TheLoanee."Primary Identification";
                            end;
                        TheLoanee."Primary Identification Type"::"Service Number":
                            begin
                                TheCRBSubmission."Primary Id Doc Type" := '004';
                                TheCRBSubmission."Primary Id Doc No." := TheLoanee."Primary Identification";
                            end;
                        else
                            case TheLoanee."Secondary Identification Type" of
                                TheLoanee."Secondary Identification Type"::"ID Number":
                                    begin
                                        TheCRBSubmission."Primary Id Doc Type" := '001';
                                        TheCRBSubmission."Primary Id Doc No." := TheLoanee."Secondary Identification";
                                    end;
                                TheLoanee."Secondary Identification Type"::"Passport No":
                                    begin
                                        TheCRBSubmission."Primary Id Doc Type" := '002';
                                        TheCRBSubmission."Primary Id Doc No." := TheLoanee."Secondary Identification";
                                    end;
                                TheLoanee."Secondary Identification Type"::"Service Number":
                                    begin
                                        TheCRBSubmission."Primary Id Doc Type" := '004';
                                        TheCRBSubmission."Primary Id Doc No." := TheLoanee."Secondary Identification";
                                    end;
                                else begin
                                    TheCRBSubmission."Primary Id Doc Type" := '003';
                                    TheCRBSubmission."Primary Id Doc No." := TheLoanee."Primary Identification";
                                end;
                            end;
                    end;
                end else begin
                    TheCRBSubmission."Client Type" := 'B';
                    TheCRBSubmission.Surname := '';
                    TheCRBSubmission."Forename 1" := '';
                    TheCRBSubmission."Forename 2" := '';
                    TheCRBSubmission."Forename 3" := '';
                    TheCRBSubmission."Company Name" := TheLoanee.Name;
                    TheCRBSubmission."Primary Id Doc Type" := '005';
                    TheCRBSubmission."Primary Id Doc No." := TheLoanee."Primary Identification";
                end;

                TheCRBSubmission."Account Number" := TheLoan."Loan No.";
                TheCRBSubmission."Currency of Facility" := 'KES';
                TheCRBSubmission."Original Amount" := Format((TheLoan."Approved Amount" * 100) div 1).Replace(',', '');

                if TheCreditLedgerEntry."Transaction Type" = TheCreditLedgerEntry."Transaction Type"::Loan then begin
                    // New loan listing
                    if TheLoanee."Account Type" = TheLoanee."Account Type"::"Single Member Account" then begin
                        LogMonthlyICEFile(
                            TheLoan,
                            TheCreditLedgerEntry,
                            false
                        );
                        exit;
                    end else begin
                        LogMonthlyNICEFile(
                            TheLoan,
                            TheCreditLedgerEntry,
                            false
                        );
                        exit;
                    end;
                end else begin
                    TheCRBSubmission."Payment Amount" := Format((-(TheCreditLedgerEntry.Amount) * 100) div 1).Replace(',', '');
                end;

                TheCRBSubmission."Payment Date" := GFunc.FormatCRBDate(Today);
                TheCRBSubmission."Current Balance" := Format(((TheLoan."Total Loan Balance" + TheLoan."Daily Interest") * 100) div 1).Replace(',', '');
                TheCRBSubmission."Installments in Arrears" := (TheLoan."Days In Arrears" div 30) + 1;
                TheCRBSubmission."Days in Arrears" := TheLoan."Days In Arrears";

                if TheLoan."Days In Arrears" <= 0 then begin
                    TheCRBSubmission."Installments in Arrears" := 0;
                end;

                if TheLoan."Total Loan Balance" < 0 then begin
                    TheCRBSubmission."Current Balance" := '0';
                    TheCRBSubmission."Installments in Arrears" := 0;
                    TheCRBSubmission."Days in Arrears" := 0;
                end;

                TheCRBSubmission."Account Status" := 'F';

                if (TheLoan."Total Loan Balance" <= 0) then begin
                    if (TheLoanee.Subflag = TheLoanee.Subflag::Defaulter) then begin
                        TheCRBSubmission."Account Status" := 'J';
                    end else begin
                        TheCRBSubmission."Account Status" := 'H';
                    end;
                end;

                if TheLoan."Loan Rescheduled" then begin
                    TheCRBSubmission."Account Status" := 'G';
                end;

                if TheLoan."Moratorium Loan" then begin
                    TheCRBSubmission."Account Status" := 'M';
                end;

                if TheLoanee.Status = TheLoanee.Status::Deceased then begin
                    TheCRBSubmission."Account Status" := 'L';
                end;

                TheCRBSubmission.Insert(true);
            end;
        end;
    end;

    local procedure LogMonthlyICEFile(
        TheLoan: Record Loans;
        var TheCreditLedgerEntry: Record "Credit Ledger Entry";
        CurrentlyAttached: Boolean
    )
    var
        TheLoanee: Record Members;
        TheCRBSubmission: Record "CRB Monthly ICE File Subm.";
        TheProduct: Record "Product Factory";
        OutInt: Decimal;
        OutBal: Decimal;
        TotalBal: Decimal;
        ActualLoanSchedule: Codeunit ActualLoanSchedule;
        RecoveryHeader: Record "Loan Recovery Header";
        Schedule: Record "Ideal Repayment Schedule";
        NextExpectedRepaymentDate: Date;
    begin
        if TheLoanee.Get(TheLoan."Member No.") then begin

            TheLoanee.CalcFields(
                "Employer Name"
            );
            TheLoan.CalcFields(
                "Loan Amount",
                "Total Loan Balance",
                "Amount In Arreas SASRA",
                "Last Pay Date",
                "Days In Arrears",
                "Loans Category-SASRA",
                "Daily Interest"
            );

            RecoveryHeader.GetLoanBalances(TheLoan."Loan No.", OutInt, OutBal, TotalBal);
            // Attached loans
            if CurrentlyAttached then begin
                OutInt := 0;
                OutBal := 0;
                TotalBal := 0;
                ActualLoanSchedule.GetAttachedLoanBalance(TheLoan, OutInt, OutBal);
                TotalBal := OutInt + OutBal;
            end;

            if TotalBal <= 0 then begin
                exit;
            end;

            TheCRBSubmission.Init();

            TheCRBSubmission."Loan No." := TheLoan."Loan No.";
            TheCRBSubmission.Validate("Loan No.");
            TheCRBSubmission."CRB Institution" := theCRBInstitution;

            TheCRBSubmission.Surname := TheLoanee."Other Names";
            TheCRBSubmission."Forename 1" := TheLoanee."First Name";
            TheCRBSubmission."Forename 2" := TheLoanee."Middle Name";
            TheCRBSubmission."Forename 3" := TheLoanee."Other Names";

            if (TheLoanee."Other Names" = '') or (StrLen(TheLoanee."Other Names") = 1) then begin
                TheCRBSubmission.Surname := TheLoanee."Middle Name";
                TheCRBSubmission."Forename 3" := '';
            end;

            case TheLoanee."Primary Identification Type" of
                TheLoanee."Primary Identification Type"::"ID Number":
                    begin
                        TheCRBSubmission."Primary Id Doc Type" := '001';
                        TheCRBSubmission."Primary Id Doc No." := TheLoanee."Primary Identification";
                    end;
                TheLoanee."Primary Identification Type"::"Passport No":
                    begin
                        TheCRBSubmission."Primary Id Doc Type" := '002';
                        TheCRBSubmission."Primary Id Doc No." := TheLoanee."Primary Identification";
                    end;
                TheLoanee."Primary Identification Type"::"Service Number":
                    begin
                        TheCRBSubmission."Primary Id Doc Type" := '004';
                        TheCRBSubmission."Primary Id Doc No." := TheLoanee."Primary Identification";
                    end;
                else
                    case TheLoanee."Secondary Identification Type" of
                        TheLoanee."Secondary Identification Type"::"ID Number":
                            begin
                                TheCRBSubmission."Primary Id Doc Type" := '001';
                                TheCRBSubmission."Primary Id Doc No." := TheLoanee."Secondary Identification";
                            end;
                        TheLoanee."Secondary Identification Type"::"Passport No":
                            begin
                                TheCRBSubmission."Primary Id Doc Type" := '002';
                                TheCRBSubmission."Primary Id Doc No." := TheLoanee."Secondary Identification";
                            end;
                        TheLoanee."Secondary Identification Type"::"Service Number":
                            begin
                                TheCRBSubmission."Primary Id Doc Type" := '004';
                                TheCRBSubmission."Primary Id Doc No." := TheLoanee."Secondary Identification";
                            end;
                        else begin
                            TheCRBSubmission."Primary Id Doc Type" := '003';
                            TheCRBSubmission."Primary Id Doc No." := TheLoanee."Primary Identification";
                        end;
                    end;
            end;

            if StrLen(TheCRBSubmission."Primary Id Doc No.") = 4 then begin
                TheCRBSubmission."Primary Id Doc No." := '0' + TheCRBSubmission."Primary Id Doc No.";
            end;

            TheCRBSubmission."Trading As" := '';
            TheCRBSubmission."Date of Birth" := GFunc.FormatCRBDate(TheLoanee."Date of Birth");
            TheCRBSubmission."Client Number" := TheLoanee."No.";
            TheCRBSubmission."Account Number" := TheLoan."Loan No.";
            TheCRBSubmission."Old Account Number" := '';

            TheCRBSubmission.Gender := 'M';
            if TheLoanee.Gender = TheLoanee.Gender::Female then begin
                TheCRBSubmission.Gender := 'F';
            end;

            TheCRBSubmission.Nationality := 'KE';

            TheCRBSubmission."Marital Status" := 'S';
            case TheLoanee."Marital Status" of
                TheLoanee."Marital Status"::Married:
                    TheCRBSubmission."Marital Status" := 'M';
                TheLoanee."Marital Status"::Divorced:
                    TheCRBSubmission."Marital Status" := 'D';
                TheLoanee."Marital Status"::Widow, TheLoanee."Marital Status"::Widower:
                    TheCRBSubmission."Marital Status" := 'W';
                else
            end;

            TheCRBSubmission."Secondary Id Doc Type" := '';
            TheCRBSubmission."Secondary Id Doc No." := '';

            TheCRBSubmission."Other Id Doc Type" := '';
            TheCRBSubmission."Other Id Doc No." := '';

            TheCRBSubmission."Passport Country Code" := '';

            TheCRBSubmission."Mobile Telephone No." := TheLoanee."Phone No.";
            TheCRBSubmission."Home Telephone No." := '';
            TheCRBSubmission."Work Telephone No." := '';

            TheCRBSubmission."Postal Address 1" := '';
            TheCRBSubmission."Postal Address 2" := '';
            TheCRBSubmission."Postal Location Town" := '';
            TheCRBSubmission."Postal Location Country" := '';
            TheCRBSubmission."Post Code" := '';

            TheCRBSubmission."Physical Address 1" := '';
            TheCRBSubmission."Physical Address 2" := '';
            TheCRBSubmission."Plot Number" := '';
            TheCRBSubmission."Location Town" := 'NAIROBI';
            TheCRBSubmission."Location Country" := 'KE';

            TheCRBSubmission."Type of Residency" := '';
            TheCRBSubmission."PIN Number" := TheLoanee."P.I.N Number";
            TheCRBSubmission."Consumer E-Mail" := TheLoanee."E-Mail";

            if TheCRBSubmission."PIN Number" = '' then begin
                TheCRBSubmission."PIN Number" := 'N/A';
            end;

            if TheCRBSubmission."Consumer E-Mail" = '' then begin
                TheCRBSubmission."Consumer E-Mail" := 'info@mwalimunational.coop';
            end;

            TheCRBSubmission."Employer Name" := TheLoanee."Employer Name";
            TheCRBSubmission."Occupational Industry Type" := '011';
            TheCRBSubmission."Employment Date" := '';
            TheCRBSubmission."Employment Type" := '';
            TheCRBSubmission."Income Amount" := '12000000';

            TheCRBSubmission."Lenders Registered Name" := theCompanyName;
            TheCRBSubmission."Lenders Trading Name" := theCompanyName;
            TheCRBSubmission."Lenders Branch Code" := theLenderBranchCode;
            TheCRBSubmission."Lenders Branch Name" := theCompanyName;

            TheCRBSubmission."Account Joint/Single Indicator" := 'S';

            if TheProduct.Get(theLoan."Loan Product Type") then begin
                if TheProduct."Nature of Loan Type" = TheProduct."Nature of Loan Type"::Defaulter then begin
                    TheCRBSubmission."Account Joint/Single Indicator" := 'J';
                end;
            end;
            TheCRBSubmission."Account Product Type" := 'H';
            TheCRBSubmission."Date Account Opened" := GFunc.FormatCRBDate(TheLoan."Application Date");
            TheCRBSubmission."Disbursement Date" := GFunc.FormatCRBDate(TheLoan."Disbursement Date");

            TheCRBSubmission."Original Amount" := Format((TheLoan."Approved Amount" * 100) div 1).Replace(',', '');
            if TheLoan."Approved Amount" <= 0 then begin
                TheCRBSubmission."Original Amount" := Format((TheLoan."Requested Amount" * 100) div 1).Replace(',', '');
            end;

            TheCRBSubmission."Currency of Facility" := TheLoan."Currency Code";
            TheCRBSubmission."Current Balance in KES" := Format(((TotalBal) * 100) div 1).Replace(',', '');
            TheCRBSubmission."Current Balance" := Format(((TotalBal) * 100) div 1).Replace(',', '');

            TheCRBSubmission."Overdue Balance" := Format((TheLoan."Amount In Arreas SASRA" * 100) div 1).Replace(',', '');
            if TheCRBSubmission."Overdue Balance" = '0' then begin
                TheCRBSubmission."Overdue Date" := '';
            end;
            TheCRBSubmission."Number of Days in Arrears" := TheLoan."Days In Arrears";
            TheCRBSubmission."No. of Installments in Arrears" := (TheLoan."Days In Arrears" div 30) + 1;
            if TheCRBSubmission."Number of Days in Arrears" = 0 then begin
                TheCRBSubmission."No. of Installments in Arrears" := 0;
                // Schedule.Reset();
                // Schedule.SetFilter("Repayment Date", '>=%1', Today);
                // Schedule.SetRange("Loan No.", TheLoan."Loan No.");
                // if Schedule.FindFirst() then begin
                //     TheCRBSubmission."Instalment Due Date" := GFunc.DateFormatCRB(Schedule."Repayment Date");
                // end;
                TheCRBSubmission."Instalment Due Date" := GFunc.DateFormatCRB(CalcDate('CM', Today));
            end else begin
                TheCRBSubmission."Overdue Date" := GFunc.FormatCRBDate(
                    CalcDate('-' + Format(TheLoan."Days In Arrears", 0, '<Integer>') + 'D', Today)
                );
                TheCRBSubmission."Instalment Due Date" := TheCRBSubmission."Overdue Date";

                NextExpectedRepaymentDate := CalcDate('-' + Format(TheCRBSubmission."Number of Days in Arrears", 0, '<Integer>') + 'D', Today);
                if NextExpectedRepaymentDate < TheLoan."Disbursement Date" then begin
                    NextExpectedRepaymentDate := CalcDate('1M+CM', TheLoan."Disbursement Date");
                    TheCRBSubmission."Instalment Due Date" := GFunc.DateFormatCRB(NextExpectedRepaymentDate);
                end;
            end;

            if TheLoan."Expected Date of Completion" <> 0D then
                TheCRBSubmission."Instalment Due Date" := GFunc.DateFormatCRB(TheLoan."Expected Date of Completion");

            TheCRBSubmission."Prudential Risk Classification" := 'A';
            case TheLoan."Loans Category-SASRA" of
                TheLoan."Loans Category-SASRA"::Watch:
                    TheCRBSubmission."Prudential Risk Classification" := 'B';
                TheLoan."Loans Category-SASRA"::Substandard:
                    TheCRBSubmission."Prudential Risk Classification" := 'C';
                TheLoan."Loans Category-SASRA"::Doubtful:
                    TheCRBSubmission."Prudential Risk Classification" := 'D';
                TheLoan."Loans Category-SASRA"::Loss:
                    TheCRBSubmission."Prudential Risk Classification" := 'E';
            end;

            TheCRBSubmission."Account Status" := 'F';

            if TheLoan."Loan Rescheduled" then begin
                TheCRBSubmission."Account Status" := 'G';
            end;
            if TheLoanee.Status = TheLoanee.Status::Deceased then begin
                TheCRBSubmission."Account Status" := 'L';
            end;

            TheCRBSubmission."Account Status Date" := GFunc.FormatCRBDate(Today);
            TheCRBSubmission."Account Closure Reason" := '';
            TheCRBSubmission."Repayment Period" := TheLoan.Installments;
            TheCRBSubmission."Deferred Payment Date" := '';
            TheCRBSubmission."Deferred Payment Amount" := '0';
            TheCRBSubmission."Payment Frequency" := 'M';
            if TheLoan."Application Date" = 0D then begin
                TheCRBSubmission."Date Account Opened" := GFunc.FormatCRBDate(TheLoan."Disbursement Date");
            end;
            TheCRBSubmission."Disbursement Date" := GFunc.FormatCRBDate(TheLoan."Disbursement Date");

            TheCRBSubmission."Next Instalment Amount" := Format((TheLoan.Repayment * 100) div 1).Replace(',', '');
            TheCRBSubmission."Date of Latest Payment" := '';
            TheCRBSubmission."Last Payment Amount" := '0';
            TheCRBSubmission."Type of Security" := 'U';

            TheCRBSubmission."Group ID" := '';

            TheCRBSubmission."Currency of Facility" := 'KES';

            TheCRBSubmission.Insert(true);
        end;
    end;

    local procedure LogMonthlyNICEFile(
        TheLoan: Record Loans;
        var TheCreditLedgerEntry: Record "Credit Ledger Entry";
        CurrentlyAttached: Boolean
    )
    var
        TheLoanee: Record Members;
        TheCRBSubmission: Record "CRB Monthly NICE File Subm.";
        TheProduct: Record "Product Factory";
        OutInt: Decimal;
        OutBal: Decimal;
        TotalBal: Decimal;
        ActualLoanSchedule: Codeunit ActualLoanSchedule;
        RecoveryHeader: Record "Loan Recovery Header";
        Schedule: Record "Ideal Repayment Schedule";
    begin
        if TheLoanee.Get(TheLoan."Member No.") then begin

            TheLoanee.CalcFields(
                "Employer Name"
            );
            TheLoan.CalcFields(
                "Loan Amount",
                "Total Loan Balance",
                "Amount In Arreas SASRA",
                "Last Pay Date",
                "Days In Arrears",
                "Loans Category-SASRA",
                "Daily Interest"
            );

            RecoveryHeader.GetLoanBalances(TheLoan."Loan No.", OutInt, OutBal, TotalBal);
            // Attached loans
            if CurrentlyAttached then begin
                OutInt := 0;
                OutBal := 0;
                TotalBal := 0;
                ActualLoanSchedule.GetAttachedLoanBalance(TheLoan, OutInt, OutBal);
                TotalBal := OutInt + OutBal;
            end;

            if TotalBal <= 0 then begin
                exit;
            end;

            TheCRBSubmission.Init();

            TheCRBSubmission."Loan No." := TheLoan."Loan No.";
            TheCRBSubmission.Validate("Loan No.");
            TheCRBSubmission."CRB Institution" := theCRBInstitution;

            TheCRBSubmission."Registered Name" := TheLoanee.Name;
            TheCRBSubmission."Trading Name" := TheLoanee.Name;
            TheCRBSubmission."Registration Date" := GFunc.FormatCRBDate(TheLoanee."Registration Date");
            TheCRBSubmission."Registration Number" := TheLoanee."Company Registration No.";
            TheCRBSubmission."Previous Registration Number" := '';

            TheCRBSubmission."Client Number" := TheLoanee."No.";
            TheCRBSubmission."Account Number" := TheLoan."Loan No.";
            TheCRBSubmission."Old Account Number" := '';

            TheCRBSubmission."Company Type" := 'D';
            TheCRBSubmission."Industry Code" := '006';
            TheCRBSubmission.Nationality := 'KE';
            TheCRBSubmission."Annual Turnover Amount" := '0';

            TheCRBSubmission."Postal Address 1" := '';
            TheCRBSubmission."Postal Address 2" := '';
            TheCRBSubmission."Post Code" := '';

            TheCRBSubmission."Physical Address 1" := TheLoanee."Current Address";
            TheCRBSubmission."Physical Address 2" := '';
            TheCRBSubmission."Plot Number" := '';

            TheCRBSubmission."PIN Number" := TheLoanee."P.I.N Number";
            TheCRBSubmission."VAT Number" := '';
            TheCRBSubmission."Number of Stakeholders" := 1;

            TheCRBSubmission."Trading Status" := '002';
            TheCRBSubmission."Trading Status Date" := GFunc.FormatCRBDate(Today);

            TheCRBSubmission."Main Telephone No." := TheLoanee."Phone No.";
            TheCRBSubmission."Other Telephone No." := '';

            TheCRBSubmission.Town := '';
            TheCRBSubmission.Country := 'KE';
            TheCRBSubmission."Physical Location Town" := TheLoanee."Home Address";
            TheCRBSubmission."Physical Location Country" := 'KE';

            TheCRBSubmission."Lenders Registered Name" := theCompanyName;
            TheCRBSubmission."Lenders Trading Name" := theCompanyName;
            TheCRBSubmission."Lenders Branch Code" := theLenderBranchCode;
            TheCRBSubmission."Lenders Branch Name" := theCompanyName;

            TheCRBSubmission."Account Joint/Single Indicator" := 'S';

            if TheProduct.Get(theLoan."Loan Product Type") then begin
                if TheProduct."Nature of Loan Type" = TheProduct."Nature of Loan Type"::Defaulter then begin
                    TheCRBSubmission."Account Joint/Single Indicator" := 'J';
                end;
            end;

            TheCRBSubmission."Class of Organization" := 'B';
            TheCRBSubmission."Account Product Type" := 'H';
            TheCRBSubmission."Date Account Opened" := GFunc.FormatCRBDate(TheLoan."Application Date");
            TheCRBSubmission."Disbursement Date" := GFunc.FormatCRBDate(TheLoan."Disbursement Date");

            TheCRBSubmission."Original Amount" := Format((TheLoan."Approved Amount" * 100) div 1).Replace(',', '');
            if TheLoan."Approved Amount" <= 0 then begin
                TheCRBSubmission."Original Amount" := Format((TheLoan."Requested Amount" * 100) div 1).Replace(',', '');
            end;

            TheCRBSubmission."Currency of Facility" := TheLoan."Currency Code";
            TheCRBSubmission."Current Balance in KES" := Format(((TotalBal) * 100) div 1).Replace(',', '');
            TheCRBSubmission."Current Balance" := Format(((TotalBal) * 100) div 1).Replace(',', '');

            TheCRBSubmission."Overdue Balance" := Format((TheLoan."Amount In Arreas SASRA" * 100) div 1).Replace(',', '');
            TheCRBSubmission."Overdue Date" := GFunc.FormatCRBDate(TheLoan."Last Pay Date");
            if TheCRBSubmission."Overdue Balance" = '0' then begin
                TheCRBSubmission."Overdue Date" := '';
            end;
            TheCRBSubmission."Number of Days in Arrears" := TheLoan."Days In Arrears";
            TheCRBSubmission."No. of Installments in Arrears" := (TheLoan."Days In Arrears" div 30) + 1;
            if TheCRBSubmission."Number of Days in Arrears" = 0 then begin
                TheCRBSubmission."No. of Installments in Arrears" := 0;
                Schedule.Reset();
                Schedule.SetFilter("Repayment Date", '>=%1', Today);
                Schedule.SetRange("Loan No.", TheLoan."Loan No.");
                if Schedule.FindFirst() then begin
                    TheCRBSubmission."Instalment Due Date" := GFunc.DateFormatCRB(Schedule."Repayment Date");
                end;
            end else begin
                TheCRBSubmission."Overdue Date" := GFunc.FormatCRBDate(
                    CalcDate('-' + Format(TheLoan."Days In Arrears", 0, '<Integer>') + 'D', Today)
                );
                TheCRBSubmission."Instalment Due Date" := TheCRBSubmission."Overdue Date";
            end;

            if TheLoan."Expected Date of Completion" <> 0D then
                TheCRBSubmission."Instalment Due Date" := GFunc.DateFormatCRB(TheLoan."Expected Date of Completion");

            TheCRBSubmission."Prudential Risk Classification" := 'A';
            case TheLoan."Loans Category-SASRA" of
                TheLoan."Loans Category-SASRA"::Watch:
                    TheCRBSubmission."Prudential Risk Classification" := 'B';
                TheLoan."Loans Category-SASRA"::Substandard:
                    TheCRBSubmission."Prudential Risk Classification" := 'C';
                TheLoan."Loans Category-SASRA"::Doubtful:
                    TheCRBSubmission."Prudential Risk Classification" := 'D';
                TheLoan."Loans Category-SASRA"::Loss:
                    TheCRBSubmission."Prudential Risk Classification" := 'E';
            end;

            TheCRBSubmission."Account Status" := 'F';

            if TheLoan."Loan Rescheduled" then begin
                TheCRBSubmission."Account Status" := 'G';
            end;
            if TheLoanee.Status = TheLoanee.Status::Deceased then begin
                TheCRBSubmission."Account Status" := 'L';
            end;

            TheCRBSubmission."Account Status Date" := GFunc.FormatCRBDate(Today);
            TheCRBSubmission."Account Closure Reason" := '';
            TheCRBSubmission."Repayment Period" := TheLoan.Installments;
            TheCRBSubmission."Deferred Payment Date" := '';
            TheCRBSubmission."Deferred Payment Amount" := '0';
            TheCRBSubmission."Payment Frequency" := 'M';
            if TheLoan."Application Date" = 0D then begin
                TheCRBSubmission."Date Account Opened" := GFunc.FormatCRBDate(TheLoan."Disbursement Date");
            end;
            TheCRBSubmission."Disbursement Date" := GFunc.FormatCRBDate(TheLoan."Disbursement Date");

            TheCRBSubmission."Next Instalment Amount" := Format((TheLoan.Repayment * 100) div 1).Replace(',', '');
            TheCRBSubmission."Date of Latest Payment" := '';
            TheCRBSubmission."Last Payment Amount" := '0';
            TheCRBSubmission."Type of Security" := 'U';

            TheCRBSubmission."Currency of Facility" := 'KES';

            TheCRBSubmission.Insert(true);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Credit Ledger Entry", 'OnAfterInsertEvent', '', true, true)]
    local procedure SubscribeToCreditLedgerEntryInsertEvent(var Rec: Record "Credit Ledger Entry")
    var
        theLoan: Record Loans;
        theProduct: Record "Product Factory";
    begin
        if theLoan.Get(Rec."Loan No")
        and (
            (Rec."Transaction Type" = Rec."Transaction Type"::Loan) or
            (Rec."Transaction Type" = Rec."Transaction Type"::Repayment) or
            (Rec."Transaction Type" = Rec."Transaction Type"::"Interest Paid")
        )
         then begin

            if theProduct.Get(theLoan."Loan Product Type") then begin
                // if ((theLoan.Defaulted = false)) then begin
                if theProduct."Repay Mode" <> theProduct."Repay Mode"::Dividend then begin
                    // CRB - Transunion
                    LogDailyPaymentInformationFile(theLoan, Rec);
                end;
                // end;
            end;

        end;
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
        VendorName: Label 'CRB TransUnion';
        GFunc: Codeunit "Global Functions";
        theCRBInstitution: Label 'TRANSUNION';
        theCompanyName: Label 'MWALIMU NATIONAL SACCO LTD';
        theLocationTown: Label 'NAIROBI';
        theLenderBranchCode: Label 'N084001';
}
*/