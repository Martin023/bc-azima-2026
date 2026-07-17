codeunit 52186561 "CRB Metropol API"
{
    TableNo = "Job Queue Entry";
    trigger OnRun()
    var
        CRBDPIInformation: Record "CRB DPI File Submissions";
        CRBMonthlyICEInformation: Record "CRB Monthly ICE File Subm.";
        CRBMonthlyNonICEInformation: Record "CRB Monthly NICE File Subm.";
        TheLoan: Record Loans;
        TheLoanee: Record Members;
        TheParameterObj: JsonObject;
        TheType: JsonToken;

        theCRBLogBuffer: Record "CRB Log Buffer";
        theCreditLedgerEntry: Record "Credit Ledger Entry";
        theProduct: Record "Product Factory";
        SendSMS: Codeunit SendSms;
        Source: Enum "SMS Source";
    begin
        // Insert CRB transaction logs first
        theCRBLogBuffer.Reset;
        theCRBLogBuffer.SetRange("Is Processed?", false);
        theCRBLogBuffer.SetAscending("Entry No.", true);
        if theCRBLogBuffer.FindSet then begin
            repeat begin
                theCreditLedgerEntry.Reset;
                theCreditLedgerEntry.SetRange("Entry No.", theCRBLogBuffer."Credit Ledger Entry No.");
                theCreditLedgerEntry.SetLoadFields("Loan No", "Document No.", "Transaction Type", Amount, "Posting Date");

                if theCreditLedgerEntry.FindFirst then begin
                    theLoan.Reset;
                    theLoan.SetRange("Loan No.", theCreditLedgerEntry."Loan No");
                    theLoan.SetLoadFields(
                        "Loan No.", "Loan Product Type"
                    );

                    if theLoan.FindFirst then begin
                        theProduct.Reset;
                        theProduct.SetRange("Product ID", theLoan."Loan Product Type");
                        theProduct.SetLoadFields("Repay Mode");

                        if theProduct.FindFirst then begin
                            if theProduct."Repay Mode" <> theProduct."Repay Mode"::Dividend then begin
                                // CRB - Metropol
                                LogDailyPaymentInformationFile(theLoan."Loan No.", theCreditLedgerEntry);
                            end;
                        end;
                    end;

                    theCRBLogBuffer."Is Processed?" := true;
                    theCRBLogBuffer.Modify;
                    Commit;
                end;
            end until theCRBLogBuffer.Next = 0;
        end;

        if Rec."Parameter String" = '' then begin

            // Daily Payment Information
            CRBDPIInformation.Reset;
            CRBDPIInformation.SetRange("Is Sent", false);
            CRBDPIInformation.SetRange("CRB Institution", theCRBInstitution);

            if CRBDPIInformation.FindSet then begin
                repeat begin
                    TheLoan.Reset;

                    TheLoan.SetRange("Loan No.", CRBDPIInformation."Loan No.");
                    TheLoan.SetLoadFields(
                        "Member No.", "Loan Rescheduled", "Moratorium Loan"
                    );

                    if TheLoan.FindFirst then begin
                        TheLoanee.Reset;
                        TheLoanee.SetRange("No.", TheLoan."Member No.");
                        TheLoanee.SetLoadFields(Subflag, Status);
                        TheLoanee.FindFirst;

                        TheLoan.CalcFields(
                            "Total Loan Balance",
                            "Loan Amount",
                            "Days In Arrears",
                            "Interest Paid",
                            "Principle Paid",
                            "Daily Interest"
                        );

                        CRBDPIInformation."Current Balance" := Format(((TheLoan."Total Loan Balance" + TheLoan."Daily Interest") * 100) div 1).Replace(',', '');
                        CRBDPIInformation."Installments in Arrears" := (TheLoan."Days In Arrears" div 30) + 1;
                        CRBDPIInformation."Days in Arrears" := TheLoan."Days In Arrears";

                        if TheLoan."Total Loan Balance" <= 0 then begin
                            CRBDPIInformation."Current Balance" := '0';
                            CRBDPIInformation."Installments in Arrears" := 0;
                            CRBDPIInformation."Days in Arrears" := 0;
                        end;

                        CRBDPIInformation."Account Status" := 'F';

                        if (TheLoan."Total Loan Balance" <= 0) then begin
                            if (TheLoanee.Subflag = TheLoanee.Subflag::Defaulter) then begin
                                CRBDPIInformation."Account Status" := 'J';
                            end else begin
                                CRBDPIInformation."Account Status" := 'H';
                            end;
                        end;

                        if TheLoan."Loan Rescheduled" then begin
                            CRBDPIInformation."Account Status" := 'G';
                        end;

                        if TheLoan."Moratorium Loan" then begin
                            CRBDPIInformation."Account Status" := 'M';
                        end;

                        if TheLoanee.Status = TheLoanee.Status::Deceased then begin
                            CRBDPIInformation."Account Status" := 'L';
                        end;

                        CRBDPIInformation.Modify;

                        DataSubmissionJSONDPI4(CRBDPIInformation);
                    end;

                end until CRBDPIInformation.Next = 0;
            end;

            // if Date2DMY(Today, 1) <= 5 then begin
            // Monthly - ICE
            CRBMonthlyICEInformation.Reset;
            CRBMonthlyICEInformation.SetRange("Is Sent", false);
            CRBMonthlyICEInformation.SetRange("CRB Institution", theCRBInstitution);

            if CRBMonthlyICEInformation.FindSet then begin
                repeat begin

                    DataSubmissionJSONMICE4(CRBMonthlyICEInformation);

                end until CRBMonthlyICEInformation.Next = 0;
            end;

            // Monthly - Non ICE
            CRBMonthlyNonICEInformation.Reset;
            CRBMonthlyNonICEInformation.SetRange("Is Sent", false);
            CRBMonthlyNonICEInformation.SetRange("CRB Institution", theCRBInstitution);

            if CRBMonthlyNonICEInformation.FindSet then begin
                repeat begin

                    DataSubmissionJSONMNonICE4(CRBMonthlyNonICEInformation);

                end until CRBMonthlyNonICEInformation.Next = 0;
            end;
            // end;

            // Force CRB submission for 03:00AM everyday
            // Rec.Status := Rec.Status::Ready;
            // Rec."Earliest Start Date/Time" := CreateDateTime(CalcDate('1D'), 030000T);
            // Rec."Starting Time" := 030000T;
            // Rec."User ID" := UserId;

            // Rec.Modify;
            // Rec.ScheduleTask();
        end else begin
            TheParameterObj.ReadFrom(Rec."Parameter String");
            TheParameterObj.SelectToken('$.type', TheType);

            case TheType.AsValue.AsText of
                'DAILY':
                    begin

                        // Daily Payment Information
                        CRBDPIInformation.Reset;
                        CRBDPIInformation.SetRange("Is Sent", false);
                        CRBDPIInformation.SetRange("CRB Institution", theCRBInstitution);

                        if CRBDPIInformation.FindSet then begin
                            repeat begin
                                TheLoan.Reset;

                                TheLoan.SetRange("Loan No.", CRBDPIInformation."Loan No.");
                                TheLoan.SetLoadFields(
                                    "Member No.", "Loan Rescheduled", "Moratorium Loan"
                                );

                                if TheLoan.FindFirst then begin
                                    TheLoanee.Reset;
                                    TheLoanee.SetRange("No.", TheLoan."Member No.");
                                    TheLoanee.SetLoadFields(Subflag, Status);
                                    TheLoanee.FindFirst;

                                    TheLoan.CalcFields(
                                        "Total Loan Balance",
                                        "Loan Amount",
                                        "Days In Arrears",
                                        "Interest Paid",
                                        "Principle Paid",
                                        "Daily Interest"
                                    );

                                    CRBDPIInformation."Current Balance" := Format(((TheLoan."Total Loan Balance" + TheLoan."Daily Interest") * 100) div 1).Replace(',', '');
                                    CRBDPIInformation."Installments in Arrears" := (TheLoan."Days In Arrears" div 30) + 1;
                                    CRBDPIInformation."Days in Arrears" := TheLoan."Days In Arrears";

                                    if TheLoan."Total Loan Balance" <= 0 then begin
                                        CRBDPIInformation."Current Balance" := '0';
                                        CRBDPIInformation."Installments in Arrears" := 0;
                                        CRBDPIInformation."Days in Arrears" := 0;
                                    end;

                                    CRBDPIInformation."Account Status" := 'F';

                                    if (TheLoan."Total Loan Balance" <= 0) then begin
                                        if (TheLoanee.Subflag = TheLoanee.Subflag::Defaulter) then begin
                                            CRBDPIInformation."Account Status" := 'J';
                                        end else begin
                                            CRBDPIInformation."Account Status" := 'H';
                                        end;
                                    end;

                                    if TheLoan."Loan Rescheduled" then begin
                                        CRBDPIInformation."Account Status" := 'G';
                                    end;

                                    if TheLoan."Moratorium Loan" then begin
                                        CRBDPIInformation."Account Status" := 'M';
                                    end;

                                    if TheLoanee.Status = TheLoanee.Status::Deceased then begin
                                        CRBDPIInformation."Account Status" := 'L';
                                    end;

                                    CRBDPIInformation.Modify;

                                    DataSubmissionJSONDPI4(CRBDPIInformation);
                                end;

                            end until CRBDPIInformation.Next = 0;
                        end;

                    end;
                'MONTHLY':
                    begin
                        // Monthly - ICE
                        CRBMonthlyICEInformation.Reset;
                        CRBMonthlyICEInformation.SetRange("Is Sent", false);
                        CRBMonthlyICEInformation.SetRange("CRB Institution", theCRBInstitution);

                        if CRBMonthlyICEInformation.FindSet then begin
                            repeat begin

                                DataSubmissionJSONMICE4(CRBMonthlyICEInformation);

                            end until CRBMonthlyICEInformation.Next = 0;
                        end;

                        // Monthly - Non ICE
                        CRBMonthlyNonICEInformation.Reset;
                        CRBMonthlyNonICEInformation.SetRange("Is Sent", false);
                        CRBMonthlyNonICEInformation.SetRange("CRB Institution", theCRBInstitution);

                        if CRBMonthlyNonICEInformation.FindSet then begin
                            repeat begin

                                DataSubmissionJSONMNonICE4(CRBMonthlyNonICEInformation);

                            end until CRBMonthlyNonICEInformation.Next = 0;
                        end;
                    end;
                else
            end;
        end;

        // Insert CRB transaction logs lastly
        theCRBLogBuffer.Reset;
        theCRBLogBuffer.SetRange("Is Processed?", false);
        theCRBLogBuffer.SetAscending("Entry No.", true);
        if theCRBLogBuffer.FindSet then begin
            repeat begin
                theCreditLedgerEntry.Reset;
                theCreditLedgerEntry.SetRange("Entry No.", theCRBLogBuffer."Credit Ledger Entry No.");
                theCreditLedgerEntry.SetLoadFields("Loan No", "Document No.", "Transaction Type", Amount, "Posting Date");

                if theCreditLedgerEntry.FindFirst then begin
                    theLoan.Reset;
                    theLoan.SetRange("Loan No.", theCreditLedgerEntry."Loan No");
                    theLoan.SetLoadFields(
                        "Loan No.", "Loan Product Type"
                    );

                    if theLoan.FindFirst then begin
                        theProduct.Reset;
                        theProduct.SetRange("Product ID", theLoan."Loan Product Type");
                        theProduct.SetLoadFields("Repay Mode");

                        if theProduct.FindFirst then begin
                            if theProduct."Repay Mode" <> theProduct."Repay Mode"::Dividend then begin
                                // CRB - Metropol
                                LogDailyPaymentInformationFile(theLoan."Loan No.", theCreditLedgerEntry);
                            end;
                        end;
                    end;

                    theCRBLogBuffer."Is Processed?" := true;
                    theCRBLogBuffer.Modify;
                    Commit;
                end;
            end until theCRBLogBuffer.Next = 0;
        end;

        // SMS
        // SendSMS.SendSms(
        //     Source::DMU,
        //     '254722863636',
        //     StrSubstNo('CRB Metropol submission has been completed on %1', CurrentDateTime),
        //     'CRB',
        //     '',
        //     false,
        //     250,
        //     false,
        //     'BC',
        //     '',
        //     'BC'
        // );
    end;

    procedure ManualSubmitDPI()
    var
        JobQueueEntry: Record "Job Queue Entry";
        TheParameterObj: JsonObject;
        TheParameterString: Text;
    begin
        JobQueueEntry.Reset;

        JobQueueEntry.SetRange("Object ID to Run", Codeunit::"CRB Metropol API");
        JobQueueEntry.SetRange(Status, JobQueueEntry.Status::"In Process");

        if JobQueueEntry.FindSet then begin
            Error('There is an ongoing CRB Metropol submission process running at the moment. Count = %1', JobQueueEntry.Count);
        end else begin

            JobQueueEntry.Init;

            JobQueueEntry.ID := CreateGuid();
            JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
            JobQueueEntry."Object ID to Run" := Codeunit::"CRB Metropol API";
            JobQueueEntry.Description := 'CRB Metropol Manual Submission';
            JobQueueEntry."Job Queue Category Code" := '';
            JobQueueEntry."Recurring Job" := false;
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry."Earliest Start Date/Time" := CurrentDateTime;
            JobQueueEntry."Starting Time" := Time;

            TheParameterObj.Add('type', 'DAILY');
            TheParameterObj.WriteTo(TheParameterString);

            JobQueueEntry."Parameter String" := TheParameterString;

            if JobQueueEntry.Insert(true) then begin
                JobQueueEntry.ScheduleTask();
                JobQueueEntry.Reset();

                Message('CRB Metropol Manual Submission process initiated successfully in the background');
            end else begin
                Error('Unable to initiate CRB Metropol Manual Submission at the moment');
            end;
        end;
    end;

    procedure ManualSubmitMNICE()
    var
        JobQueueEntry: Record "Job Queue Entry";
        TheParameterObj: JsonObject;
        TheParameterString: Text;
    begin
        JobQueueEntry.Reset;

        JobQueueEntry.SetRange("Object ID to Run", Codeunit::"CRB Metropol API");
        JobQueueEntry.SetRange(Status, JobQueueEntry.Status::"In Process");

        if JobQueueEntry.FindSet then begin
            Error('There is an ongoing CRB Metropol submission process running at the moment. Count = %1', JobQueueEntry.Count);
        end else begin

            JobQueueEntry.Init;

            JobQueueEntry.ID := CreateGuid();
            JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
            JobQueueEntry."Object ID to Run" := Codeunit::"CRB Metropol API";
            JobQueueEntry.Description := 'CRB Metropol Manual Submission';
            JobQueueEntry."Job Queue Category Code" := '';
            JobQueueEntry."Recurring Job" := false;
            JobQueueEntry.Status := JobQueueEntry.Status::Ready;
            JobQueueEntry."Earliest Start Date/Time" := CurrentDateTime;
            JobQueueEntry."Starting Time" := Time;

            TheParameterObj.Add('type', 'MONTHLY');
            TheParameterObj.WriteTo(TheParameterString);

            JobQueueEntry."Parameter String" := TheParameterString;

            if JobQueueEntry.Insert(true) then begin
                JobQueueEntry.ScheduleTask();
                JobQueueEntry.Reset();

                Message('CRB Metropol Manual Submission process initiated successfully in the background');
            end else begin
                Error('Unable to initiate CRB Metropol Manual Submission at the moment');
            end;
        end;
    end;

    local procedure ComputeHeaders(
        var HttpHeaderObj: HttpClient;
        var CRBMetropolAPISetupTable: Record "CRB Metropol API Setup";
        var PayloadStr: Text)
    var
        pubKey: Text;
        privKey: Text;
        year: Text;
        month: Text;
        day: Text;
        formattedTimestamp: Text;
        hash: Text;
        hasher: Codeunit "Cryptography Management";
        HashAlgo: enum "Hash Algorithm";

        TZDuration: Duration;

        TypeHelper: Codeunit "Type Helper";
        InputTime: Time;
        Hour: Integer;
        Minute: Integer;
        Second: Integer;
        Milliseconds: Integer;
    begin
        year := Format(DATE2DMY(Today, 3));
        month := Format(DATE2DMY(Today, 2)).PadLeft(2, '0');
        day := Format(DATE2DMY(Today, 1)).PadLeft(2, '0');

        TZDuration := 1000 * 60 * 60 * 3; // GMT + 3

        InputTime := Time - TZDuration;
        TypeHelper.GetHMSFromTime(Hour, Minute, Second, InputTime);

        Milliseconds := InputTime - 000000T;

        formattedTimestamp := year + month + day +
        Format(Hour) + Format(Minute) + Format(Second) + Format(Milliseconds);

        hash := hasher.GenerateHash(
            CRBMetropolAPISetupTable."Private Key" +
            PayloadStr +
            CRBMetropolAPISetupTable."Public Key" +
            formattedTimestamp,
            HashAlgo::SHA256.AsInteger()).ToLower();

        HttpHeaderObj.DefaultRequestHeaders.Add('X-METROPOL-REST-API-TIMESTAMP', formattedTimestamp);
        HttpHeaderObj.DefaultRequestHeaders.Add('X-METROPOL-REST-API-HASH', hash);
        HttpHeaderObj.DefaultRequestHeaders.Add('X-METROPOL-REST-API-KEY', CRBMetropolAPISetupTable."Public Key");
    end;

    procedure LoginDataSubmission(ShowSuccessMessage: Boolean)
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
        AccessToken: JsonToken;
        ExpiresIn: JsonToken;
        APICode: JsonToken;
        APICodeDescription: JsonToken;
        ResponseMessage: JsonToken;
        CRBMetropolAPISetupTable: Record "CRB Metropol API Setup";
        CRBMetropolAPILogsTable: Record "BC API Logs";

        URL: Text[250];
        Authorization: Text;
        Base64Convert: Codeunit "Base64 Convert";

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
        IF CRBMetropolAPISetupTable.FindFirst then begin
            IF CRBMetropolAPISetupTable.Status = CRBMetropolAPISetupTable.Status::Inactive then begin
                Message('CRB Metropol Login API status: %1', Format(CRBMetropolAPISetupTable.Status));
                exit;
            end;
            // 2. Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');

            Authorization := CRBMetropolAPISetupTable."Public Key - DS" + ':' + CRBMetropolAPISetupTable."Private Key - DS";
            Authorization := Base64Convert.ToBase64(Authorization);

            Client.DefaultRequestHeaders.Add('Authorization', 'Basic ' + Authorization);

            URL := CRBMetropolAPISetupTable."Base URL - DS" +
                ':' +
                Format(CRBMetropolAPISetupTable."Port - DS") +
                '/api/' +
                CRBMetropolAPISetupTable."API Version - DS" +
                '/datasubmission/authenticate?grant_type=client_credentials';

            URL := CRBMetropolAPISetupTable."The Proxy" + URL;

            IsSuccessful := Client.Post(URL, Content, Response);
            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // { 
                    //     "expires_in":3599, 
                    //     "token_type":"bearer", 
                    //     "access_token":"eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOlsiZGF0YS1zdWJtaXNzaW9uLWFwaSJdLCJzY29wZSI6WyJyZWFkIiwid3JpdGUiXSwiZXhwIjoxNTQzNDEyNTA3LCJqdGkiOiJjMzY1ODBkYi0wMGU3LTQxMTQtYTAxNC1iMWE4NTdiOGI3YzUiLCJjbGllbnRfaWQiOiJENG5uOHdkS05ZTWF3RVNsTWhiS0padlZRV1NBYm1rcyJ9.qhfRrrj3Sl3ID0UFvjbCR5vCZeotVBkwpMdUYnE54Ow" 
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    ResponseParser.SelectToken('$.access_token', AccessToken);
                    ResponseParser.SelectToken('$.expires_in', ExpiresIn);

                    LoginToken := AccessToken.AsValue.AsText;
                    LoginTokenExpiry := CurrentDateTime + (1000 * ExpiresIn.AsValue.AsInteger);

                    IF ShowSuccessMessage then begin
                        Message('CRB Metropol API login status : %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                        Message('LoginToken : %1 ', LoginToken);
                    end;
                end else begin
                    // Errors - 403, 404, etc
                    CRBMetropolAPILogsTable.Init;
                    CRBMetropolAPILogsTable."Request URL" := URL;
                    CRBMetropolAPILogsTable."Vendor Name" := VendorName;

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
                    CRBMetropolAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    CRBMetropolAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    CRBMetropolAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    CRBMetropolAPILogsTable."Response Headers" := '';
                    CRBMetropolAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    CRBMetropolAPILogsTable.Miscellaneous := '';
                    CRBMetropolAPILogsTable.Insert;

                    Message('CRB Metropol API Login API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                CRBMetropolAPILogsTable.Init;
                CRBMetropolAPILogsTable."Request URL" := URL;
                CRBMetropolAPILogsTable."Vendor Name" := VendorName;

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
                CRBMetropolAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                CRBMetropolAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                CRBMetropolAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRBMetropolAPILogsTable."Response Headers" := '';
                CRBMetropolAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                CRBMetropolAPILogsTable.Miscellaneous := 'CRB Metropol API Login has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRBMetropolAPILogsTable.Insert;

                Message('CRB Metropol API Login has failed. Status %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;
        end else begin
            CRBMetropolAPILogsTable.Init;
            CRBMetropolAPILogsTable."Request URL" := 'NOT_SET';
            CRBMetropolAPILogsTable."Vendor Name" := VendorName;
            CRBMetropolAPILogsTable."Request Headers" := 'N/A';
            CRBMetropolAPILogsTable."Request Data" := 'N/A';
            CRBMetropolAPILogsTable."Response Status Code" := 'N/A';
            CRBMetropolAPILogsTable."Response Headers" := 'N/A';
            CRBMetropolAPILogsTable."Response Data" := 'N/A';
            CRBMetropolAPILogsTable.Miscellaneous := 'Unable to initiate login. API credentials have NOT been set on the ' + CRBMetropolAPISetupTable.TableName + ' table. Kindly contact the system administrator.';
            CRBMetropolAPILogsTable.Insert;

            // Message('Unable to initiate login. API credentials have NOT been set on the %1 table. Kindly contact the system administrator.', CRMAPISetupTable.TableName);
        end;
    end;

    procedure DataSubmissionJSONDPI4(var CRBDPIInformation: Record "CRB DPI File Submissions")
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
        Success: JsonToken;
        BatchNo: JsonToken;
        ExpiresIn: JsonToken;
        APICode: JsonToken;
        APICodeDescription: JsonToken;
        ResponseMessage: JsonToken;
        CRBMetropolAPISetupTable: Record "CRB Metropol API Setup";
        CRBMetropolAPILogsTable: Record "BC API Logs";

        Data: JsonArray;
        Datum: JsonObject;

        URL: Text;
        Authorization: Text;
        Base64Convert: Codeunit "Base64 Convert";

        Index: Integer;
        HeaderKeys: List of [Text];
        HeaderKey: Text;
        HeaderValues: List of [Text];
        HeaderValuesIndex: Integer;
        HeaderValuesText: Text;
        HeaderValue: Text;
        HeaderText: Text;
    begin
        LoginDataSubmission(false);

        if LoginToken <> '' then begin
            CRBMetropolAPISetupTable.FindFirst();

            // 2. Prepare the payload data
            // { 
            //     "data_ref":"DP", 
            //     "institution_ref":"B", 
            //     "is_final_submission":true, 
            //     "submission_date":"yyyyMMdd", 
            //     "submission_type":"D", 
            //     "template_version":"4", 
            //     "callback_url":"string", 
            //     "data":[ 
            //         { 
            //             "account_number":"string", 
            //             "account_status":"string", 
            //             "client_type":"string", 
            //             "company_name":"string", 
            //             "currency_facility":"string", 
            //             "current_balance":"string", 
            //             "days_arrears":"string", 
            //             "forename1":"string", 
            //             "forename2":"string", 
            //             "forename3":"string", 
            //             "installment_arrears":"string", 
            //             "original_amount":"string", 
            //             "payment_amount":"string", 
            //             "payment_date":"string", 
            //             "primary_id_doc_no":"string", 
            //             "primary_id_doc_type":"string", 
            //             "snapshot_date":"string", 
            //             "surname":"string" 
            //         }
            //     ]
            // }
            PayloadObject.Add('data_ref', 'DP');
            PayloadObject.Add('institution_ref', 'B');
            PayloadObject.Add('is_final_submission', true);
            PayloadObject.Add('submission_date', GFunc.FormatCRBDate(Today));
            PayloadObject.Add('submission_type', 'D');
            PayloadObject.Add('template_version', '4');
            PayloadObject.Add('callback_url', 'https://www.azimasacco.com');

            Datum.Add('account_number', CRBDPIInformation."Account Number");
            Datum.Add('account_status', CRBDPIInformation."Account Status");
            Datum.Add('client_type', CRBDPIInformation."Client Type");
            Datum.Add('company_name', CRBDPIInformation."Company Name");
            Datum.Add('currency_facility', CRBDPIInformation."Currency of Facility");
            Datum.Add('current_balance', CRBDPIInformation."Current Balance");
            Datum.Add('days_arrears', Format(CRBDPIInformation."Days in Arrears"));
            Datum.Add('forename1', CRBDPIInformation."Forename 1");
            Datum.Add('forename2', CRBDPIInformation."Forename 2");
            Datum.Add('forename3', CRBDPIInformation."Forename 3");
            Datum.Add('installment_arrears', Format(CRBDPIInformation."Installments in Arrears"));
            Datum.Add('original_amount', CRBDPIInformation."Original Amount");
            Datum.Add('payment_amount', CRBDPIInformation."Payment Amount");
            Datum.Add('payment_date', CRBDPIInformation."Payment Date");
            Datum.Add('primary_id_doc_no', CRBDPIInformation."Primary Id Doc No.");
            Datum.Add('primary_id_doc_type', CRBDPIInformation."Primary Id Doc Type");
            Datum.Add('snapshot_date', CRBDPIInformation."Snapshot Date");
            Datum.Add('surname', CRBDPIInformation.Surname);

            Data.Add(Datum);
            PayloadObject.Add('data', Data);

            PayloadObject.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // 3. Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');

            Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + LoginToken);

            URL := CRBMetropolAPISetupTable."Base URL - DS" +
                ':' +
                Format(CRBMetropolAPISetupTable."Port - DS") +
                '/api/' +
                CRBMetropolAPISetupTable."API Version - DS" +
                '/datasubmission/submit/data';

            URL := CRBMetropolAPISetupTable."The Proxy" + URL;

            IsSuccessful := Client.Post(URL, Content, Response);
            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // { 
                    //     "success":true, 
                    //     "has_error":false, 
                    //     "api_code":1010, 
                    //     "api_code_description":"Data Submitted Successful", 
                    //     "trx_id":"PREG-QTQY-20190227" 
                    // }
                    // { 
                    //     "success":false, 
                    //     "has_error":true, 
                    //     "api_code":1000, 
                    //     "api_code_description":"reason for failure described here", 
                    //     "trx_id":"f4fe8309-f39f-11e8-9683-55658ca4e102" 
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    ResponseParser.SelectToken('$.success', Success);
                    ResponseParser.SelectToken('$.trx_id', BatchNo);

                    if Success.AsValue.AsBoolean = true then begin
                        CRBDPIInformation."Batch No." := BatchNo.AsValue.AsText;
                        CRBDPIInformation."Is Sent" := true;
                        CRBDPIInformation."API Response" := ResponseText;
                        CRBDPIInformation."API Status" := Response.HttpStatusCode;

                        CRBDPIInformation.Modify(true);
                        Commit;

                        exit;
                    end else begin
                        CRBDPIInformation."Is Sent" := true;
                        CRBDPIInformation."API Response" := ResponseText;
                        CRBDPIInformation."API Status" := Response.HttpStatusCode;

                        CRBDPIInformation.Modify(true);
                        Commit;

                        CRBMetropolAPILogsTable.Init;
                        CRBMetropolAPILogsTable."Request URL" := URL;
                        CRBMetropolAPILogsTable."Vendor Name" := VendorName;

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
                        CRBMetropolAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                        CRBMetropolAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                        CRBMetropolAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                        CRBMetropolAPILogsTable."Response Headers" := '';
                        CRBMetropolAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                        CRBMetropolAPILogsTable.Miscellaneous := '';
                        CRBMetropolAPILogsTable.Insert;

                        Message('CRB Metropol DPI Submission API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);

                    end;
                end else begin
                    // Errors - 403, 404, etc
                    CRBMetropolAPILogsTable.Init;
                    CRBMetropolAPILogsTable."Request URL" := URL;
                    CRBMetropolAPILogsTable."Vendor Name" := VendorName;

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
                    CRBMetropolAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    CRBMetropolAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    CRBMetropolAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    CRBMetropolAPILogsTable."Response Headers" := '';
                    CRBMetropolAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    CRBMetropolAPILogsTable.Miscellaneous := '';
                    CRBMetropolAPILogsTable.Insert;

                    Message('CRB Metropol DPI Submission API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                CRBMetropolAPILogsTable.Init;
                CRBMetropolAPILogsTable."Request URL" := URL;
                CRBMetropolAPILogsTable."Vendor Name" := VendorName;

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
                CRBMetropolAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                CRBMetropolAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                CRBMetropolAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRBMetropolAPILogsTable."Response Headers" := '';
                CRBMetropolAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                CRBMetropolAPILogsTable.Miscellaneous := 'CRB Metropol API Login has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRBMetropolAPILogsTable.Insert;

                Message('CRB Metropol API Login has failed. Status %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;

        end else begin
            // Error
            Message('Unable to submit CRB Metropol data at the moment. Kindly contact the administrator');
        end;
    end;

    procedure DataSubmissionJSONMICE4(var CRBMonthlyICEInformation: Record "CRB Monthly ICE File Subm.")
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
        Success: JsonToken;
        ExpiresIn: JsonToken;
        APICode: JsonToken;
        APICodeDescription: JsonToken;
        ResponseMessage: JsonToken;
        CRBMetropolAPISetupTable: Record "CRB Metropol API Setup";
        CRBMetropolAPILogsTable: Record "BC API Logs";

        Data: JsonArray;
        Datum: JsonObject;

        URL: Text;
        Authorization: Text;
        Base64Convert: Codeunit "Base64 Convert";

        Index: Integer;
        HeaderKeys: List of [Text];
        HeaderKey: Text;
        HeaderValues: List of [Text];
        HeaderValuesIndex: Integer;
        HeaderValuesText: Text;
        HeaderValue: Text;
        HeaderText: Text;

        BatchNo: JsonToken;
    begin
        LoginDataSubmission(false);

        if LoginToken <> '' then begin
            CRBMetropolAPISetupTable.FindFirst();

            // 2. Prepare the payload data
            // { 
            //     "data_ref":"CE", 
            //     "institution_ref":"string", 
            //     "is_final_submission":true, 
            //     "submission_date":"yyyyMMdd", 
            //     "submission_type":"M", 
            //     "template_version":"4", 
            //     "callback_url":"string", 
            //     "data":[ 
            //         { 
            //             "account_closure_reason":"string", 
            //             "account_indicator":"string", 
            //             "account_number":"string", 
            //             "account_product_type":"string", 
            //             "account_status":"string", 
            //             "account_status_date":"string", 
            //             "current_balance_kes":"string", 
            //             "client_number":"string", 
            //             "consumer_email":"string", 
            //             "currency_facility":"string", 
            //             "current_balance":"string", 
            //             "date_account_opened":"string", 
            //             "days_arrears":"string", 
            //             "deferred_payment_amount":"string", 
            //             "deferred_payment_date":"string", 
            //             "disbursement_date":"string", 
            //             "dob":"string", 
            //             "employer_name":"string", 
            //             "employment_date":"string", 
            //             "employment_type":"string", 
            //             "forename1":"string", 
            //             "forename2":"string", 
            //             "forename3":"string", 
            //             "gender":"string", 
            //             "group_id":"string", 
            //             "home_telephone_number":"string", 
            //             "income_amount":"string", 
            //             "industry_type":"string", 
            //             "installment_amount":"string", 
            //             "installment_arrears":"string",
            //             "installment_due_date":"string", 
            //             "latest_payment_amount":"string", 
            //             "latest_payment_date":"string", 
            //             "lenders_branch_code":"string", 
            //             "lenders_branch_name":"string", 
            //             "lenders_registered_name":"string", 
            //             "lenders_trading_name":"string", 
            //             "location_country":"string", 
            //             "location_town":"string", 
            //             "marital_status":"string", 
            //             "mobile_telephone_number":"string", 
            //             "nationality":"string", 
            //             "old_account_number":"string", 
            //             "original_amount":"string", 
            //             "other_id_doc_no":"string", 
            //             "other_id_doc_type":"string", 
            //             "overdue_balance":"string", 
            //             "overdue_date":"string", 
            //             "passport_country_code":"string", 
            //             "payment_frequency":"string", 
            //             "physical_address1":"string", 
            //             "physical_address2":"string", 
            //             "pin_number":"string", 
            //             "plot_number":"string", 
            //             "post_code":"string", 
            //             "postal_address1":"string", 
            //             "postal_address2":"string", 
            //             "postal_location_country":"string", 
            //             "postal_location_town":"string", 
            //             "primary_id_doc_no":"string", 
            //             "primary_id_doc_type":"string", 
            //             "prudential_risk_classification":"string", 
            //             "repayment_period":"string", 
            //             "type_of_residency":"string", 
            //             "secondary_id_doc_no":"string", 
            //             "secondary_id_doc_type":"string", 
            //             "security_type":"string", 
            //             "surname":"string", 
            //             "trading_as":"string", 
            //             "work_telephone_number":"string" 
            //         }
            //     ]
            // }
            PayloadObject.Add('data_ref', 'CE');
            PayloadObject.Add('institution_ref', 'B');
            PayloadObject.Add('is_final_submission', true);
            PayloadObject.Add('submission_date', GFunc.FormatCRBDate(Today));
            PayloadObject.Add('submission_type', 'M');
            PayloadObject.Add('template_version', '4');
            PayloadObject.Add('callback_url', 'https://test.azimasacco.coop');

            Datum.Add('account_closure_reason', CRBMonthlyICEInformation."Account Closure Reason");
            Datum.Add('account_indicator', CRBMonthlyICEInformation."Account Joint/Single Indicator");
            Datum.Add('account_number', CRBMonthlyICEInformation."Account Number");
            Datum.Add('account_product_type', CRBMonthlyICEInformation."Account Product Type");
            Datum.Add('account_status', CRBMonthlyICEInformation."Account Status");
            Datum.Add('account_status_date', CRBMonthlyICEInformation."Account Status Date");
            Datum.Add('current_balance_kes', CRBMonthlyICEInformation."Current Balance in KES");
            Datum.Add('client_number', CRBMonthlyICEInformation."Client Number");
            Datum.Add('consumer_email', CRBMonthlyICEInformation."Consumer E-Mail");
            Datum.Add('currency_facility', CRBMonthlyICEInformation."Currency of Facility");
            Datum.Add('current_balance', CRBMonthlyICEInformation."Current Balance");
            Datum.Add('date_account_opened', CRBMonthlyICEInformation."Date Account Opened");
            Datum.Add('days_arrears', Format(CRBMonthlyICEInformation."Number of Days in Arrears"));
            Datum.Add('deferred_payment_amount', CRBMonthlyICEInformation."Deferred Payment Amount");
            Datum.Add('deferred_payment_date', CRBMonthlyICEInformation."Deferred Payment Date");
            Datum.Add('disbursement_date', CRBMonthlyICEInformation."Disbursement Date");
            Datum.Add('dob', CRBMonthlyICEInformation."Date of Birth");
            Datum.Add('employer_name', CRBMonthlyICEInformation."Employer Name");
            Datum.Add('employment_date', CRBMonthlyICEInformation."Employment Date");
            Datum.Add('employment_type', CRBMonthlyICEInformation."Employment Type");
            Datum.Add('forename1', CRBMonthlyICEInformation."Forename 1");
            Datum.Add('forename2', CRBMonthlyICEInformation."Forename 2");
            Datum.Add('forename3', CRBMonthlyICEInformation."Forename 3");
            Datum.Add('gender', CRBMonthlyICEInformation.Gender);
            Datum.Add('group_id', CRBMonthlyICEInformation."Group ID");
            Datum.Add('home_telephone_number', CRBMonthlyICEInformation."Home Telephone No.");
            Datum.Add('income_amount', CRBMonthlyICEInformation."Income Amount");
            Datum.Add('industry_type', CRBMonthlyICEInformation."Occupational Industry Type");
            Datum.Add('installment_amount', CRBMonthlyICEInformation."Next Instalment Amount");
            Datum.Add('installment_arrears', Format(CRBMonthlyICEInformation."No. of Installments in Arrears"));
            Datum.Add('installment_due_date', CRBMonthlyICEInformation."Instalment Due Date");
            Datum.Add('latest_payment_amount', CRBMonthlyICEInformation."Last Payment Amount");
            Datum.Add('latest_payment_date', CRBMonthlyICEInformation."Date of Latest Payment");
            Datum.Add('lenders_branch_code', CRBMonthlyICEInformation."Lenders Branch Code");
            Datum.Add('lenders_branch_name', CRBMonthlyICEInformation."Lenders Branch Name");
            Datum.Add('lenders_registered_name', CRBMonthlyICEInformation."Lenders Registered Name");
            Datum.Add('lenders_trading_name', CRBMonthlyICEInformation."Lenders Trading Name");
            Datum.Add('location_country', CRBMonthlyICEInformation."Location Country");
            Datum.Add('location_town', CRBMonthlyICEInformation."Location Town");
            Datum.Add('marital_status', CRBMonthlyICEInformation."Marital Status");
            Datum.Add('mobile_telephone_number', CRBMonthlyICEInformation."Mobile Telephone No.");
            Datum.Add('nationality', CRBMonthlyICEInformation.Nationality);
            Datum.Add('old_account_number', CRBMonthlyICEInformation."Old Account Number");
            Datum.Add('original_amount', CRBMonthlyICEInformation."Original Amount");
            Datum.Add('other_id_doc_no', CRBMonthlyICEInformation."Other Id Doc No.");
            Datum.Add('other_id_doc_type', CRBMonthlyICEInformation."Other Id Doc Type");
            Datum.Add('overdue_balance', CRBMonthlyICEInformation."Overdue Balance");
            Datum.Add('overdue_date', CRBMonthlyICEInformation."Overdue Date");
            Datum.Add('passport_country_code', CRBMonthlyICEInformation."Passport Country Code");
            Datum.Add('payment_frequency', CRBMonthlyICEInformation."Payment Frequency");
            Datum.Add('physical_address1', CRBMonthlyICEInformation."Physical Address 1");
            Datum.Add('physical_address2', CRBMonthlyICEInformation."Physical Address 2");
            Datum.Add('pin_number', CRBMonthlyICEInformation."PIN Number");
            Datum.Add('plot_number', CRBMonthlyICEInformation."Plot Number");
            Datum.Add('post_code', CRBMonthlyICEInformation."Post Code");
            Datum.Add('postal_address1', CRBMonthlyICEInformation."Postal Address 1");
            Datum.Add('postal_address2', CRBMonthlyICEInformation."Postal Address 2");
            Datum.Add('postal_location_country', CRBMonthlyICEInformation."Postal Location Country");
            Datum.Add('postal_location_town', CRBMonthlyICEInformation."Postal Location Town");
            Datum.Add('primary_id_doc_no', CRBMonthlyICEInformation."Primary Id Doc No.");
            Datum.Add('primary_id_doc_type', CRBMonthlyICEInformation."Primary Id Doc Type");
            Datum.Add('prudential_risk_classification', CRBMonthlyICEInformation."Prudential Risk Classification");
            Datum.Add('repayment_period', Format(CRBMonthlyICEInformation."Repayment Period"));
            Datum.Add('type_of_residency', CRBMonthlyICEInformation."Type of Residency");
            Datum.Add('secondary_id_doc_no', CRBMonthlyICEInformation."Secondary Id Doc No.");
            Datum.Add('secondary_id_doc_type', CRBMonthlyICEInformation."Secondary Id Doc Type");
            Datum.Add('security_type', CRBMonthlyICEInformation."Type of Security");
            Datum.Add('surname', CRBMonthlyICEInformation.Surname);
            Datum.Add('trading_as', CRBMonthlyICEInformation."Trading As");
            Datum.Add('work_telephone_number', CRBMonthlyICEInformation."Work Telephone No.");

            Data.Add(Datum);
            PayloadObject.Add('data', Data);

            PayloadObject.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // 3. Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');

            Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + LoginToken);

            URL := CRBMetropolAPISetupTable."Base URL - DS" +
                ':' +
                Format(CRBMetropolAPISetupTable."Port - DS") +
                '/api/' +
                CRBMetropolAPISetupTable."API Version - DS" +
                '/datasubmission/submit/data';

            URL := CRBMetropolAPISetupTable."The Proxy" + URL;

            IsSuccessful := Client.Post(URL, Content, Response);
            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // { 
                    //     "success":true, 
                    //     "has_error":false, 
                    //     "api_code":1010, 
                    //     "api_code_description":"Data Submitted Successful", 
                    //     "trx_id":"PREG-QTQY-20190227" 
                    // }
                    // { 
                    //     "success":false, 
                    //     "has_error":true, 
                    //     "api_code":1000, 
                    //     "api_code_description":"reason for failure described here", 
                    //     "trx_id":"f4fe8309-f39f-11e8-9683-55658ca4e102" 
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    ResponseParser.SelectToken('$.success', Success);
                    ResponseParser.SelectToken('$.trx_id', BatchNo);

                    if Success.AsValue.AsBoolean = true then begin
                        CRBMonthlyICEInformation."Batch No." := BatchNo.AsValue.AsText;
                        CRBMonthlyICEInformation."Is Sent" := true;
                        CRBMonthlyICEInformation."API Response" := ResponseText;
                        CRBMonthlyICEInformation."API Status" := Response.HttpStatusCode;

                        CRBMonthlyICEInformation.Modify(true);
                        Commit;

                        exit;
                    end else begin
                        CRBMonthlyICEInformation."Is Sent" := true;
                        CRBMonthlyICEInformation."API Response" := ResponseText;
                        CRBMonthlyICEInformation."API Status" := Response.HttpStatusCode;

                        CRBMonthlyICEInformation.Modify(true);
                        Commit;

                        CRBMetropolAPILogsTable.Init;
                        CRBMetropolAPILogsTable."Request URL" := URL;
                        CRBMetropolAPILogsTable."Vendor Name" := VendorName;

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
                        CRBMetropolAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                        CRBMetropolAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                        CRBMetropolAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                        CRBMetropolAPILogsTable."Response Headers" := '';
                        CRBMetropolAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                        CRBMetropolAPILogsTable.Miscellaneous := '';
                        CRBMetropolAPILogsTable.Insert;

                        Message('CRB Metropol MICE Submission API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);

                    end;
                end else begin
                    // Errors - 403, 404, etc
                    CRBMetropolAPILogsTable.Init;
                    CRBMetropolAPILogsTable."Request URL" := URL;
                    CRBMetropolAPILogsTable."Vendor Name" := VendorName;

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
                    CRBMetropolAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    CRBMetropolAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    CRBMetropolAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    CRBMetropolAPILogsTable."Response Headers" := '';
                    CRBMetropolAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    CRBMetropolAPILogsTable.Miscellaneous := '';
                    CRBMetropolAPILogsTable.Insert;

                    Message('CRB Metropol MICE Submission API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                CRBMetropolAPILogsTable.Init;
                CRBMetropolAPILogsTable."Request URL" := URL;
                CRBMetropolAPILogsTable."Vendor Name" := VendorName;

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
                CRBMetropolAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                CRBMetropolAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                CRBMetropolAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRBMetropolAPILogsTable."Response Headers" := '';
                CRBMetropolAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                CRBMetropolAPILogsTable.Miscellaneous := 'CRB Metropol API Login has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRBMetropolAPILogsTable.Insert;

                Message('CRB Metropol API Login has failed. Status %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;

        end else begin
            // Error
            Message('Unable to submit CRB Metropol data at the moment. Kindly contact the administrator');
        end;
    end;

    procedure DataSubmissionJSONMNonICE4(var CRBMonthlyICEInformation: Record "CRB Monthly NICE File Subm.")
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
        Success: JsonToken;
        ExpiresIn: JsonToken;
        APICode: JsonToken;
        APICodeDescription: JsonToken;
        ResponseMessage: JsonToken;
        CRBMetropolAPISetupTable: Record "CRB Metropol API Setup";
        CRBMetropolAPILogsTable: Record "BC API Logs";

        Data: JsonArray;
        Datum: JsonObject;

        URL: Text;
        Authorization: Text;
        Base64Convert: Codeunit "Base64 Convert";

        Index: Integer;
        HeaderKeys: List of [Text];
        HeaderKey: Text;
        HeaderValues: List of [Text];
        HeaderValuesIndex: Integer;
        HeaderValuesText: Text;
        HeaderValue: Text;
        HeaderText: Text;

        BatchNo: JsonToken;
    begin
        LoginDataSubmission(false);

        if LoginToken <> '' then begin
            CRBMetropolAPISetupTable.FindFirst();

            // 2. Prepare the payload data
            // { 
            //     "data_ref":"CI", 
            //     "institution_ref":"string", 
            //     "is_final_submission":true, 
            //     "submission_date":"yyyyMMdd", 
            //     "submission_type":"M", 
            //     "template_version":"4", 
            //     "callback_url":"string", 
            //     "data":[ 
            //         { 
            //             "account_closure_reason":"string", 
            //             "account_holder_type":"string", 
            //             "account_indicator":"string", 
            //             "account_number":"string", 
            //             "account_product_type":"string", 
            //             "account_status":"string",
            //             "account_status_date":"string", 
            //             "current_balance_kes":"string", 
            //             "annual_turnover":"string", 
            //             "client_number":"string", 
            //             "company_type":"string", 
            //             "country":"string", 
            //             "currency_facility":"string", 
            //             "current_balance":"string", 
            //             "date_account_opened":"string", 
            //             "days_arrears":"string", 
            //             "deferred_payment_amount":"string", 
            //             "deferred_payment_date":"string", 
            //             "disbursement_date":"string", 
            //             "industry_code":"string", 
            //             "installment_amount":"string", 
            //             "installment_arrears":"string", 
            //             "installment_due_date":"string", 
            //             "latest_payment_amount":"string", 
            //             "latest_payment_date":"string", 
            //             "lenders_branch_code":"string", 
            //             "lenders_branch_name":"string", 
            //             "lenders_registered_name":"string", 
            //             "lenders_trading_name":"string", 
            //             "main_telephone_number":"string", 
            //             "nationality":"string", 
            //             "number_of_shares":"string", 
            //             "old_account_number":"string", 
            //             "original_amount":"string", 
            //             "other_telephone_number":"string", 
            //             "overdue_balance":"string", 
            //             "overdue_date":"string", 
            //             "payment_frequency":"string", 
            //             "physical_address1":"string", 
            //             "physical_address2":"string", 
            //             "physical_location_country":"string", 
            //             "physical_location_town":"string", 
            //             "pin_number":"string", 
            //             "plot_number":"string", 
            //             "post_code":"string", 
            //             "postal_address1":"string", 
            //             "postal_address2":"string", 
            //             "previous_registration_number":"string", 
            //             "prudential_risk_classification":"string", 
            //             "registered_name":"string", 
            //             "registration_date":"string",
            //             "registration_number":"string", 
            //             "repayment_period":"string", 
            //             "security_type":"string", 
            //             "town":"string", 
            //             "trading_name":"string", 
            //             "trading_status":"string", 
            //             "trading_status_date":"string", 
            //             "vat_number":"string" 
            //         }
            //     ]
            // }
            PayloadObject.Add('data_ref', 'CI');
            PayloadObject.Add('institution_ref', 'B');
            PayloadObject.Add('is_final_submission', true);
            PayloadObject.Add('submission_date', GFunc.FormatCRBDate(Today));
            PayloadObject.Add('submission_type', 'M');
            PayloadObject.Add('template_version', '4');
            PayloadObject.Add('callback_url', 'https://test.azimasacco.coop');

            Datum.Add('account_closure_reason', CRBMonthlyICEInformation."Account Closure Reason");
            Datum.Add('account_holder_type', CRBMonthlyICEInformation."Account Product Type");
            Datum.Add('account_indicator', CRBMonthlyICEInformation."Account Joint/Single Indicator");
            Datum.Add('account_number', CRBMonthlyICEInformation."Account Number");
            Datum.Add('account_product_type', CRBMonthlyICEInformation."Account Product Type");
            Datum.Add('account_status', CRBMonthlyICEInformation."Account Status");
            Datum.Add('account_status_date', CRBMonthlyICEInformation."Account Status Date");
            Datum.Add('current_balance_kes', CRBMonthlyICEInformation."Current Balance in KES");
            Datum.Add('annual_turnover', CRBMonthlyICEInformation."Annual Turnover Amount");
            Datum.Add('client_number', CRBMonthlyICEInformation."Client Number");
            Datum.Add('company_type', CRBMonthlyICEInformation."Company Type");
            Datum.Add('country', CRBMonthlyICEInformation.Country);
            Datum.Add('currency_facility', CRBMonthlyICEInformation."Currency of Facility");
            Datum.Add('current_balance', CRBMonthlyICEInformation."Current Balance");
            Datum.Add('date_account_opened', CRBMonthlyICEInformation."Date Account Opened");
            Datum.Add('days_arrears', Format(CRBMonthlyICEInformation."Number of Days in Arrears"));
            Datum.Add('deferred_payment_amount', CRBMonthlyICEInformation."Deferred Payment Amount");
            Datum.Add('deferred_payment_date', CRBMonthlyICEInformation."Deferred Payment Date");
            Datum.Add('disbursement_date', CRBMonthlyICEInformation."Disbursement Date");
            Datum.Add('industry_code', CRBMonthlyICEInformation."Industry Code");
            Datum.Add('installment_amount', CRBMonthlyICEInformation."Next Instalment Amount");
            Datum.Add('installment_arrears', Format(CRBMonthlyICEInformation."No. of Installments in Arrears"));
            Datum.Add('installment_due_date', CRBMonthlyICEInformation."Instalment Due Date");
            Datum.Add('latest_payment_amount', CRBMonthlyICEInformation."Last Payment Amount");
            Datum.Add('latest_payment_date', CRBMonthlyICEInformation."Date of Latest Payment");
            Datum.Add('lenders_branch_code', CRBMonthlyICEInformation."Lenders Branch Code");
            Datum.Add('lenders_branch_name', CRBMonthlyICEInformation."Lenders Branch Name");
            Datum.Add('lenders_registered_name', CRBMonthlyICEInformation."Lenders Registered Name");
            Datum.Add('lenders_trading_name', CRBMonthlyICEInformation."Lenders Trading Name");
            Datum.Add('main_telephone_number', CRBMonthlyICEInformation."Main Telephone No.");
            Datum.Add('nationality', CRBMonthlyICEInformation.Nationality);
            Datum.Add('number_of_shares', Format(CRBMonthlyICEInformation."Number of Stakeholders"));
            Datum.Add('old_account_number', CRBMonthlyICEInformation."Old Account Number");
            Datum.Add('original_amount', CRBMonthlyICEInformation."Original Amount");
            Datum.Add('other_telephone_number', CRBMonthlyICEInformation."Other Telephone No.");
            Datum.Add('overdue_balance', CRBMonthlyICEInformation."Overdue Balance");
            Datum.Add('overdue_date', CRBMonthlyICEInformation."Overdue Date");
            Datum.Add('payment_frequency', CRBMonthlyICEInformation."Payment Frequency");
            Datum.Add('physical_address1', CRBMonthlyICEInformation."Physical Address 1");
            Datum.Add('physical_address2', CRBMonthlyICEInformation."Physical Address 2");
            Datum.Add('pin_number', CRBMonthlyICEInformation."PIN Number");
            Datum.Add('plot_number', CRBMonthlyICEInformation."Plot Number");
            Datum.Add('post_code', CRBMonthlyICEInformation."Post Code");
            Datum.Add('postal_address1', CRBMonthlyICEInformation."Postal Address 1");
            Datum.Add('postal_address2', CRBMonthlyICEInformation."Postal Address 2");
            Datum.Add('physical_location_country', CRBMonthlyICEInformation."Physical Location Country");
            Datum.Add('physical_location_town', CRBMonthlyICEInformation."Physical Location Town");
            Datum.Add('previous_registration_number', CRBMonthlyICEInformation."Previous Registration Number");
            Datum.Add('prudential_risk_classification', CRBMonthlyICEInformation."Prudential Risk Classification");
            Datum.Add('registered_name', CRBMonthlyICEInformation."Registered Name");
            Datum.Add('registration_date', CRBMonthlyICEInformation."Registration Date");
            Datum.Add('registration_number', CRBMonthlyICEInformation."Registration Number");
            Datum.Add('repayment_period', Format(CRBMonthlyICEInformation."Repayment Period"));
            Datum.Add('security_type', CRBMonthlyICEInformation."Type of Security");
            Datum.Add('town', CRBMonthlyICEInformation.Town);
            Datum.Add('trading_name', CRBMonthlyICEInformation."Trading Name");
            Datum.Add('trading_status', CRBMonthlyICEInformation."Trading Status");
            Datum.Add('trading_status_date', CRBMonthlyICEInformation."Trading Status Date");
            Datum.Add('vat_number', CRBMonthlyICEInformation."VAT Number");

            Data.Add(Datum);
            PayloadObject.Add('data', Data);

            PayloadObject.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // 3. Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');

            Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + LoginToken);

            URL := CRBMetropolAPISetupTable."Base URL - DS" +
                ':' +
                Format(CRBMetropolAPISetupTable."Port - DS") +
                '/api/' +
                CRBMetropolAPISetupTable."API Version - DS" +
                '/datasubmission/submit/data';

            URL := CRBMetropolAPISetupTable."The Proxy" + URL;

            IsSuccessful := Client.Post(URL, Content, Response);
            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // { 
                    //     "success":true, 
                    //     "has_error":false, 
                    //     "api_code":1010, 
                    //     "api_code_description":"Data Submitted Successful", 
                    //     "trx_id":"PREG-QTQY-20190227" 
                    // }
                    // { 
                    //     "success":false, 
                    //     "has_error":true, 
                    //     "api_code":1000, 
                    //     "api_code_description":"reason for failure described here", 
                    //     "trx_id":"f4fe8309-f39f-11e8-9683-55658ca4e102" 
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    ResponseParser.SelectToken('$.success', Success);
                    ResponseParser.SelectToken('$.trx_id', BatchNo);

                    if Success.AsValue.AsBoolean = true then begin
                        CRBMonthlyICEInformation."Batch No." := BatchNo.AsValue.AsText;
                        CRBMonthlyICEInformation."Is Sent" := true;
                        CRBMonthlyICEInformation."API Response" := ResponseText;
                        CRBMonthlyICEInformation."API Status" := Response.HttpStatusCode;

                        CRBMonthlyICEInformation.Modify(true);
                        Commit;

                        exit;
                    end else begin
                        CRBMonthlyICEInformation."Is Sent" := true;
                        CRBMonthlyICEInformation."API Response" := ResponseText;
                        CRBMonthlyICEInformation."API Status" := Response.HttpStatusCode;

                        CRBMonthlyICEInformation.Modify(true);
                        Commit;

                        CRBMetropolAPILogsTable.Init;
                        CRBMetropolAPILogsTable."Request URL" := URL;
                        CRBMetropolAPILogsTable."Vendor Name" := VendorName;

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
                        CRBMetropolAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                        CRBMetropolAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                        CRBMetropolAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                        CRBMetropolAPILogsTable."Response Headers" := '';
                        CRBMetropolAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                        CRBMetropolAPILogsTable.Miscellaneous := '';
                        CRBMetropolAPILogsTable.Insert;

                        Message('CRB Metropol MICE Submission API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);

                    end;
                end else begin
                    // Errors - 403, 404, etc
                    CRBMetropolAPILogsTable.Init;
                    CRBMetropolAPILogsTable."Request URL" := URL;
                    CRBMetropolAPILogsTable."Vendor Name" := VendorName;

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
                    CRBMetropolAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    CRBMetropolAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    CRBMetropolAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    CRBMetropolAPILogsTable."Response Headers" := '';
                    CRBMetropolAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    CRBMetropolAPILogsTable.Miscellaneous := '';
                    CRBMetropolAPILogsTable.Insert;

                    Message('CRB Metropol MICE Submission API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                CRBMetropolAPILogsTable.Init;
                CRBMetropolAPILogsTable."Request URL" := URL;
                CRBMetropolAPILogsTable."Vendor Name" := VendorName;

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
                CRBMetropolAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                CRBMetropolAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                CRBMetropolAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRBMetropolAPILogsTable."Response Headers" := '';
                CRBMetropolAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                CRBMetropolAPILogsTable.Miscellaneous := 'CRB Metropol API Login has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRBMetropolAPILogsTable.Insert;

                Message('CRB Metropol API Login has failed. Status %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;

        end else begin
            // Error
            Message('Unable to submit CRB Metropol data at the moment. Kindly contact the administrator');
        end;
    end;

    procedure ReportType4(
        ShowSuccessMessage: Boolean;
        report_type: Enum "CRB Metropol Report Types";
        identity_number: Text;
        loan_amount: Integer;
        identity_type: Enum "CRB Metropol Identity Types";
        report_reason: Enum "CRB Metropol Report Reasons"
    ): Text;
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
        HasError: JsonToken;
        APICode: JsonToken;
        APICodeDescription: JsonToken;
        TheReport: JsonToken;
        ResponseMessage: JsonToken;
        CRBMetropolAPISetupTable: Record "CRB Metropol API Setup";
        CRBMetropolAPILogsTable: Record "BC API Logs";

        URL: Text;

        Index: Integer;
        HeaderKeys: List of [Text];
        HeaderKey: Text;
        HeaderValues: List of [Text];
        HeaderValuesIndex: Integer;
        HeaderValuesText: Text;
        HeaderValue: Text;
        HeaderText: Text;
    begin
        // 1. Check if API credentials have been set on the table
        IF CRBMetropolAPISetupTable.FindFirst then begin
            IF CRBMetropolAPISetupTable.Status = CRBMetropolAPISetupTable.Status::Inactive then begin
                Message('CRB Metropol Report 4 API status: %1', Format(CRBMetropolAPISetupTable.Status));
                exit;
            end;
            // 2. Prepare the payload data
            // {
            //     "report_type":4,
            //     "identity_number":"660000066",
            //     "identity_type":"001",
            //     "loan_amount":2000,
            //     "report_reason":1
            // }
            PayloadObject.Add('report_type', report_type.AsInteger());
            PayloadObject.Add('identity_number', identity_number);
            PayloadObject.Add('identity_type', Format(identity_type.AsInteger()).PadLeft(3, '0'));
            PayloadObject.Add('loan_amount', loan_amount);
            PayloadObject.Add('report_reason', report_reason.AsInteger());

            PayloadObject.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // 3. Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');

            // Authorization header
            ComputeHeaders(
                Client,
                CRBMetropolAPISetupTable,
                Payload
            );

            URL := CRBMetropolAPISetupTable."Base URL" +
                ':' +
                Format(CRBMetropolAPISetupTable.Port) +
                '/' +
                CRBMetropolAPISetupTable."API Version" +
                '/report/pdf';

            URL := CRBMetropolAPISetupTable."The Proxy" + URL;

            IsSuccessful := Client.Post(URL, Content, Response);
            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // { 
                    //    "has_error":false, 
                    //    "api_code":null, 
                    //    "api_code_description":null, 
                    //    "trx_id":"6579d9a5-368f-4c8a-9125-db5a7d24f0b6", 
                    //    "identity_number":12345678, 
                    //    "identity_type":"001", 
                    //    "reference_number":"3484BDKG394942", 
                    //    "encoding":"base64", 
                    //    "report":"Binary encoded data",
                    //    "report_reason":1
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    ResponseParser.SelectToken('$.has_error', HasError);

                    if HasError.AsValue.AsBoolean = false then begin
                        ResponseParser.SelectToken('$.report', TheReport);

                        IF ShowSuccessMessage then begin
                            Message('CRB Metropol Report 4 API status : %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                        end;

                        exit(TheReport.AsValue.AsText);
                    end else begin
                        ResponseParser.SelectToken('$.api_code', APICode);
                        ResponseParser.SelectToken('$.api_code_description', APICodeDescription);

                        Message('FAILED. CRB Metropol API Response status %1 = %2.',
                        APICode.AsValue.AsText,
                        APICodeDescription.AsValue.AsText);

                        CRBMetropolAPILogsTable.Init;
                        CRBMetropolAPILogsTable."Request URL" := URL;
                        CRBMetropolAPILogsTable."Vendor Name" := VendorName;

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
                        CRBMetropolAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                        CRBMetropolAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                        CRBMetropolAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                        CRBMetropolAPILogsTable."Response Headers" := '';
                        CRBMetropolAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                        CRBMetropolAPILogsTable.Miscellaneous := '';
                        CRBMetropolAPILogsTable.Insert;
                    end;
                end else begin
                    // Errors - 403, 404, etc
                    CRBMetropolAPILogsTable.Init;
                    CRBMetropolAPILogsTable."Request URL" := URL;
                    CRBMetropolAPILogsTable."Vendor Name" := VendorName;

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
                    CRBMetropolAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    CRBMetropolAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    CRBMetropolAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    CRBMetropolAPILogsTable."Response Headers" := '';
                    CRBMetropolAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    CRBMetropolAPILogsTable.Miscellaneous := '';
                    CRBMetropolAPILogsTable.Insert;

                    Message('CRB Metropol Report 4 API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                CRBMetropolAPILogsTable.Init;
                CRBMetropolAPILogsTable."Request URL" := URL;
                CRBMetropolAPILogsTable."Vendor Name" := VendorName;

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
                CRBMetropolAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                CRBMetropolAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                CRBMetropolAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRBMetropolAPILogsTable."Response Headers" := '';
                CRBMetropolAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                CRBMetropolAPILogsTable.Miscellaneous := 'CRB Metropol Report 4 API has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRBMetropolAPILogsTable.Insert;

                Message('CRB Metropol Report 4 API has failed. Status %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;
        end else begin
            CRBMetropolAPILogsTable.Init;
            CRBMetropolAPILogsTable."Request URL" := 'NOT_SET';
            CRBMetropolAPILogsTable."Vendor Name" := VendorName;
            CRBMetropolAPILogsTable."Request Headers" := 'N/A';
            CRBMetropolAPILogsTable."Request Data" := 'N/A';
            CRBMetropolAPILogsTable."Response Status Code" := 'N/A';
            CRBMetropolAPILogsTable."Response Headers" := 'N/A';
            CRBMetropolAPILogsTable."Response Data" := 'N/A';
            CRBMetropolAPILogsTable.Miscellaneous := 'Unable to initiate login. API credentials have NOT been set on the ' + CRBMetropolAPISetupTable.TableName + ' table. Kindly contact the system administrator.';
            CRBMetropolAPILogsTable.Insert;

            // Message('Unable to initiate login. API credentials have NOT been set on the %1 table. Kindly contact the system administrator.', CRMAPISetupTable.TableName);
        end;
    end;

    // QUEUE Functions
    local procedure LogDailyPaymentInformationFile(
        LoanNo: Text;
        var TheCreditLedgerEntry: Record "Credit Ledger Entry"
    )
    var
        TheLoan: Record Loans;
        TheLoanee: Record Members;
        TheCRBSubmission: Record "CRB DPI File Submissions";
        TheMonthlyCRBICESubmission: Record "CRB Monthly ICE File Subm.";
        TheMonthlyCRBNICESubmission: Record "CRB Monthly NICE File Subm.";
        TheCLEntries: Record "Credit Ledger Entry";
        TotalPayment: Decimal;
        RunBal: decimal;
    begin
        TheLoan.Reset;

        TheLoan.SetRange("Loan No.", LoanNo);
        TheLoan.SetLoadFields(
            "Loan No.", "Member No.", "Approved Amount",
            "Loan Rescheduled", "Moratorium Loan"
        );

        if TheLoan.FindFirst then begin
            TheLoanee.Reset;

            TheLoanee.SetRange("No.", TheLoan."Member No.");
            TheLoanee.SetLoadFields(
                "No.", "Account Type", Subflag, Status,
                "Other Names", "First Name", "Middle Name",
                "Primary Identification Type", "Primary Identification",
                "Secondary Identification Type", "Secondary Identification",
                Name
            );
            if TheLoanee.FindFirst then begin
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

                if ((TheLoan."Actively Attached" > 0) or (TheLoan."Actively Attached II" > 0)) then begin
                    // Attached loan listing
                    if TheLoanee."Account Type" = TheLoanee."Account Type"::"Single Member Account" then begin
                        TheMonthlyCRBICESubmission.Reset;
                        TheMonthlyCRBICESubmission.SetRange("Loan No.", TheLoan."Loan No.");

                        if not TheMonthlyCRBICESubmission.FindFirst then begin
                            LogMonthlyICEFile(
                                TheLoan."Loan No.",
                                true,
                                TheCreditLedgerEntry."Posting Date"
                            );
                        end;

                        exit;
                    end else begin
                        TheMonthlyCRBNICESubmission.Reset;
                        TheMonthlyCRBNICESubmission.SetRange("Loan No.", TheLoan."Loan No.");

                        if not TheMonthlyCRBNICESubmission.FindFirst then begin
                            LogMonthlyNICEFile(
                                TheLoan."Loan No.",
                                true,
                                TheCreditLedgerEntry."Posting Date"
                            );
                        end;

                        exit;
                    end;
                end;

                TheCRBSubmission.Reset;

                TheCRBSubmission.SetRange("Loan No.", TheCreditLedgerEntry."Loan No");
                TheCRBSubmission.SetRange("CL Document No", TheCreditLedgerEntry."Document No.");
                TheCRBSubmission.SetRange("Log Date", TheCreditLedgerEntry."Posting Date");
                TheCRBSubmission.SetRange("CRB Institution", theCRBInstitution);

                if TheCRBSubmission.FindFirst then begin
                    // Modify
                    TheCLEntries.Reset;
                    TheCLEntries.SetRange("Loan No", TheCreditLedgerEntry."Loan No");
                    TheCLEntries.SetRange("Document No.", TheCreditLedgerEntry."Document No.");
                    TheCLEntries.SetRange("Posting Date", TheCreditLedgerEntry."Posting Date");
                    TheCLEntries.SetFilter(
                        "Transaction Type",
                        '=%1|%2',
                        TheCreditLedgerEntry."Transaction Type"::Repayment,
                        TheCreditLedgerEntry."Transaction Type"::"Interest Paid"
                    );

                    TotalPayment := 0;

                    if TheCLEntries.FindSet then begin
                        repeat begin
                            TotalPayment += TheCLEntries.Amount;
                        end until TheCLEntries.Next = 0;
                    end;

                    RunBal := LoanRunningBalance(TheCreditLedgerEntry."Entry No.", TheLoan."Loan No.");

                    TheCRBSubmission."Original Amount" := Format((TheLoan."Approved Amount" * 100) div 1).Replace(',', '');
                    TheCRBSubmission."Payment Amount" := Format((-(TotalPayment) * 100) div 1).Replace(',', '');
                    // TheCRBSubmission."Current Balance" := Format(((TheLoan."Total Loan Balance" + TheLoan."Daily Interest") * 100) div 1).Replace(',', '');
                    TheCRBSubmission."Current Balance" := Format(((RunBal + TheLoan."Daily Interest") * 100) div 1).Replace(',', '');
                    TheCRBSubmission."Installments in Arrears" := (TheLoan."Days In Arrears" div 30) + 1;
                    TheCRBSubmission."Days in Arrears" := TheLoan."Days In Arrears";

                    if TheLoan."Days In Arrears" <= 0 then begin
                        TheCRBSubmission."Installments in Arrears" := 0;
                    end;

                    if RunBal <= 0 then begin
                        TheCRBSubmission."Current Balance" := '0';
                        TheCRBSubmission."Installments in Arrears" := 0;
                        TheCRBSubmission."Days in Arrears" := 0;
                    end;

                    TheCRBSubmission."Account Status" := 'F';

                    if RunBal <= 0 then begin
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
                    // New Insert
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
                                TheLoan."Loan No.",
                                false,
                                TheCreditLedgerEntry."Posting Date"
                            );
                            exit;
                        end else begin
                            LogMonthlyNICEFile(
                                TheLoan."Loan No.",
                                false,
                                TheCreditLedgerEntry."Posting Date"
                            );
                            exit;
                        end;
                    end else begin
                        TheCRBSubmission."Payment Amount" := Format((-(TheCreditLedgerEntry.Amount) * 100) div 1).Replace(',', '');
                    end;

                    RunBal := LoanRunningBalance(TheCreditLedgerEntry."Entry No.", TheLoan."Loan No.");

                    TheCRBSubmission."Payment Date" := GFunc.FormatCRBDate(TheCreditLedgerEntry."Posting Date");
                    // TheCRBSubmission."Current Balance" := Format(((TheLoan."Total Loan Balance" + TheLoan."Daily Interest") * 100) div 1).Replace(',', '');
                    TheCRBSubmission."Current Balance" := Format(((RunBal + TheLoan."Daily Interest") * 100) div 1).Replace(',', '');
                    TheCRBSubmission."Installments in Arrears" := (TheLoan."Days In Arrears" div 30) + 1;
                    TheCRBSubmission."Days in Arrears" := TheLoan."Days In Arrears";

                    if TheLoan."Days In Arrears" <= 0 then begin
                        TheCRBSubmission."Installments in Arrears" := 0;
                    end;

                    if RunBal <= 0 then begin
                        TheCRBSubmission."Current Balance" := '0';
                        TheCRBSubmission."Installments in Arrears" := 0;
                        TheCRBSubmission."Days in Arrears" := 0;
                    end;

                    TheCRBSubmission."Account Status" := 'F';

                    if RunBal <= 0 then begin
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
    end;

    local procedure LogMonthlyICEFile(
        LoanNo: Text;
        CurrentlyAttached: Boolean;
        PostingDate: Date
    )
    var
        TheLoan: Record Loans;
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
        TheLoan.Reset;

        TheLoan.SetRange("Loan No.", LoanNo);
        TheLoan.SetLoadFields(
            "Loan No.", "Member No.", "Loan Product Type",
            "Application Date", "Disbursement Date",
            "Approved Amount", "Requested Amount",
            "Currency Code", "Expected Date of Completion",
            "Loans Category-SASRA", "Loan Rescheduled", Installments,
            Repayment
        );

        if TheLoan.FindFirst then begin
            TheLoanee.Reset;

            TheLoanee.SetRange("No.", TheLoan."Member No.");
            TheLoanee.SetLoadFields(
                "No.", "Other Names", "First Name", "Middle Name",
                "Primary Identification Type", "Primary Identification",
                "Date of Birth", Gender, "Marital Status", "Phone No.",
                "P.I.N Number", "E-Mail", Status
            );
            if TheLoanee.FindFirst then begin

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

                // THE CRB Submission
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
                TheCRBSubmission."Location Town" := theLocationTown;
                TheCRBSubmission."Location Country" := 'KE';

                TheCRBSubmission."Type of Residency" := '';
                TheCRBSubmission."PIN Number" := TheLoanee."P.I.N Number";
                TheCRBSubmission."Consumer E-Mail" := TheLoanee."E-Mail";

                if TheCRBSubmission."PIN Number" = '' then begin
                    TheCRBSubmission."PIN Number" := '';
                end;

                if TheCRBSubmission."Consumer E-Mail" = '' then begin
                    TheCRBSubmission."Consumer E-Mail" := 'info@azimasacco.coop';
                end;

                TheCRBSubmission."Employer Name" := CopyStr(TheLoanee."Employer Name", 1, 50);
                TheCRBSubmission."Occupational Industry Type" := '011';
                TheCRBSubmission."Employment Date" := '';
                TheCRBSubmission."Employment Type" := '';
                TheCRBSubmission."Income Amount" := '12000000';

                TheCRBSubmission."Lenders Registered Name" := theCompanyName;
                TheCRBSubmission."Lenders Trading Name" := theCompanyName;
                TheCRBSubmission."Lenders Branch Code" := theLenderBranchCode;
                TheCRBSubmission."Lenders Branch Name" := theCompanyName;

                TheCRBSubmission."Account Joint/Single Indicator" := 'S';

                TheProduct.Reset;
                TheProduct.SetRange("Product ID", theLoan."Loan Product Type");
                TheProduct.SetLoadFields("Nature of Loan Type");
                if TheProduct.FindFirst then begin
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
                    TheCRBSubmission."Instalment Due Date" := GFunc.DateFormatCRB(CalcDate('CM', PostingDate));
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
                if TheLoan."Moratorium Loan" then begin
                    TheCRBSubmission."Account Status" := 'M';
                end;
                if TheLoanee.Status = TheLoanee.Status::Deceased then begin
                    TheCRBSubmission."Account Status" := 'L';
                end;

                TheCRBSubmission."Account Status Date" := GFunc.FormatCRBDate(PostingDate);
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
    end;

    local procedure LogMonthlyNICEFile(
        LoanNo: Text;
        CurrentlyAttached: Boolean;
        PostingDate: Date
    )
    var
        TheLoan: Record Loans;
        TheLoanee: Record Members;
        TheCRBSubmission: Record "CRB Monthly NICE File Subm.";
        TheProduct: Record "Product Factory";
        OutInt: Decimal;
        OutBal: Decimal;
        TotalBal: Decimal;
        ActualLoanSchedule: Codeunit ActualLoanSchedule;
        RecoveryHeader: Record "Loan Recovery Header";
        Schedule: Record "Ideal Repayment Schedule";
        NextExpectedRepaymentDate: Date;
    begin
        TheLoan.Reset;

        TheLoan.SetRange("Loan No.", LoanNo);
        TheLoan.SetLoadFields(
            "Loan No.", "Member No.", "Loan Product Type",
            "Application Date", "Disbursement Date",
            "Approved Amount", "Requested Amount",
            "Currency Code", "Expected Date of Completion",
            "Loans Category-SASRA", "Loan Rescheduled", Installments,
            Repayment
        );

        if TheLoan.FindFirst then begin
            TheLoanee.Reset;

            TheLoanee.SetRange("No.", TheLoan."Member No.");
            TheLoanee.SetLoadFields(
                "No.", Name, "Registration Date", "Company Registration No.", "Current Address",
                "P.I.N Number", "Phone No.", "Home Address", Status
            );
            if TheLoanee.FindFirst then begin

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
                TheCRBSubmission."Trading Status Date" := GFunc.FormatCRBDate(PostingDate);

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

                TheProduct.Reset;
                TheProduct.SetRange("Product ID", theLoan."Loan Product Type");
                TheProduct.SetLoadFields("Nature of Loan Type");
                if TheProduct.FindFirst then begin
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
                    TheCRBSubmission."Instalment Due Date" := GFunc.DateFormatCRB(CalcDate('CM', PostingDate));
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
                if TheLoan."Moratorium Loan" then begin
                    TheCRBSubmission."Account Status" := 'M';
                end;
                if TheLoanee.Status = TheLoanee.Status::Deceased then begin
                    TheCRBSubmission."Account Status" := 'L';
                end;

                TheCRBSubmission."Account Status Date" := GFunc.FormatCRBDate(PostingDate);
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
    end;

    [EventSubscriber(ObjectType::Table, Database::"Credit Ledger Entry", 'OnAfterInsertEvent', '', true, true)]
    local procedure SubscribeToCreditLedgerEntryInsertEvent(var Rec: Record "Credit Ledger Entry")
    var
        theCRBLogBuffer: Record "CRB Log Buffer";
    begin
        if (
            (Rec."Transaction Type" = Rec."Transaction Type"::Loan) or
            (Rec."Transaction Type" = Rec."Transaction Type"::Repayment) or
            (Rec."Transaction Type" = Rec."Transaction Type"::"Interest Paid")
        ) then begin
            // Log CRB for processing later...
            theCRBLogBuffer.Init;
            theCRBLogBuffer."Credit Ledger Entry No." := Rec."Entry No.";
            theCRBLogBuffer."Is Processed?" := false;
            theCRBLogBuffer.Insert(true);
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

    local procedure LoanRunningBalance(EntryNo: Integer; LoanNo: Code[30]) RunBal: Decimal
    var
        CreditLedgerEntry: Record "Credit Ledger Entry";
    begin
        CreditLedgerEntry.Reset;
        CreditLedgerEntry.SetRange("Loan No", LoanNo);
        CreditLedgerEntry.SetFilter("Entry No.", '<=%1', EntryNo);

        CreditLedgerEntry.SetLoadFields(Amount);
        if CreditLedgerEntry.FindFirst then begin
            CreditLedgerEntry.CalcSums(Amount);
            RunBal := CreditLedgerEntry.Amount;
        end;
    end;

    var
        LoginToken: Text;
        LoginTokenExpiry: DateTime;
        VendorName: Label 'CRB Metropol';
        GFunc: Codeunit "Global Functions";
        theCRBInstitution: Label 'METROPOL';
        theCompanyName: Label 'AZIMA SACCO SOCIETY LIMITED';
        theLocationTown: Label 'THIKA';
        theLenderBranchCode: Label 'N173001';
}