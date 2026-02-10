codeunit 52186513 "Mwalimu Smart Functions"
{
    procedure TestUptime()
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
        ResponseMessage: JsonToken;
        MSmartAPISetupTable: Record "M-Smart API Setup";
        MSmartAPILogsTable: Record "BC API Logs";

        // TestURL: label 'http://192.168.4.25:8002/api/v1/user-status-change?uuid=d47b0b63-407d-4002-927d-7737ba9b9ab7';
        TestURL: Text;
        Base64Converter: Codeunit "Base64 Convert";

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
        IF MSmartAPISetupTable.FindFirst then begin
            IF MSmartAPISetupTable.Status = MSmartAPISetupTable.Status::Inactive then begin
                Message('M-Smart API status: %1', Format(MSmartAPISetupTable.Status));
                exit;
            end;
            // 2. Prepare the payload data
            // {
            //     "id_number": "000001",
            //     "member_number": "00001",
            //     "status": "ACTIVE",
            //     "sub_flag": "ACTIVE",
            //     "reason": "reason"
            // }
            PayloadObject.Add('id_number', '000001');
            PayloadObject.Add('member_number', '00001');
            PayloadObject.Add('status', 'ACTIVE');
            PayloadObject.Add('sub_flag', 'ACTIVE');
            PayloadObject.Add('reason', 'reason');

            PayloadObject.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // 3. Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');

            // Authorization header
            Client.DefaultRequestHeaders.Add('Authorization', 'Basic ' + Base64Converter.ToBase64(MSmartAPISetupTable."Auth User" + ':' + MSmartAPISetupTable."Auth Pass"));

            TestURL := MSmartAPISetupTable."Base URL" + '/api/v1/user-status-change?uuid=d47b0b63-407d-4002-927d-7737ba9b9ab7';

            IsSuccessful := Client.Post(TestURL, Content, Response);
            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // {
                    //     "code": 0,
                    //     "msg": "success"
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    // ResponseParser.SelectToken('$.code', Token);
                    Message('M-Smart API status : %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                    Message(ResponseText);
                end else begin
                    // Errors - 403, 404, etc
                    MSmartAPILogsTable.Init;
                    MSmartAPILogsTable."Request URL" := TestURL;
                    MSmartAPILogsTable."Vendor Name" := VendorName;

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
                    MSmartAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    MSmartAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    MSmartAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    MSmartAPILogsTable."Response Headers" := '';
                    MSmartAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    MSmartAPILogsTable.Miscellaneous := '';
                    MSmartAPILogsTable.Insert;

                    Message('M-Smart API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                MSmartAPILogsTable.Init;
                MSmartAPILogsTable."Request URL" := TestURL;
                MSmartAPILogsTable."Vendor Name" := VendorName;

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
                MSmartAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                MSmartAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                MSmartAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                MSmartAPILogsTable."Response Headers" := '';
                MSmartAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                MSmartAPILogsTable.Miscellaneous := 'M-Smart API Login has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                MSmartAPILogsTable.Insert;

                Message('M-Smart API has failed. Status %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;
        end else begin
            MSmartAPILogsTable.Init;
            MSmartAPILogsTable."Request URL" := 'NOT_SET';
            MSmartAPILogsTable."Vendor Name" := VendorName;
            MSmartAPILogsTable."Request Headers" := 'N/A';
            MSmartAPILogsTable."Request Data" := 'N/A';
            MSmartAPILogsTable."Response Status Code" := 'N/A';
            MSmartAPILogsTable."Response Headers" := 'N/A';
            MSmartAPILogsTable."Response Data" := 'N/A';
            MSmartAPILogsTable.Miscellaneous := 'Unable to initiate login. API credentials have NOT been set on the ' + MSmartAPISetupTable.TableName + ' table. Kindly contact the system administrator.';
            MSmartAPILogsTable.Insert;

            // Message('Unable to initiate login. API credentials have NOT been set on the %1 table. Kindly contact the system administrator.', CRMAPISetupTable.TableName);
        end;
    end;

    procedure UserStatusChange(
        Member: Record "Member Application";
        Reason: Text;
        ShowSuccessMessage: Boolean
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
        Token: JsonToken;
        ResponseMessage: JsonToken;
        MSmartAPISetupTable: Record "M-Smart API Setup";
        MSmartAPILogsTable: Record "BC API Logs";
        NewMember: Record Members;

        Base64Converter: Codeunit "Base64 Convert";

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
        IF MSmartAPISetupTable.FindFirst then begin
            IF MSmartAPISetupTable.Status = MSmartAPISetupTable.Status::Inactive then begin
                Message('M-Smart API status: %1', Format(MSmartAPISetupTable.Status));
                exit;
            end;
            // 2. Prepare the payload data
            // {
            //     "id_number": "000001",
            //     "member_number": "00001",
            //     "status": "ACTIVE",
            //     "sub_flag": "ACTIVE",
            //     "reason": "reason"
            // }
            NewMember.Reset();

            NewMember.SetFilter("Application No.", Member."No.");

            IF NewMember.FindFirst() then begin
                if NewMember."Primary Identification Type" = NewMember."Primary Identification Type"::"ID Number" then begin
                    PayloadObject.Add('id_number', NewMember."Primary Identification");
                end else if NewMember."Secondary Identification Type" = NewMember."Secondary Identification Type"::"ID Number" then begin
                    PayloadObject.Add('id_number', NewMember."Secondary Identification");
                end else begin
                    PayloadObject.Add('id_number', NewMember."Primary Identification");
                end;

                PayloadObject.Add('member_number', NewMember."No.");
                PayloadObject.Add('status', Format(NewMember.Status).ToUpper);
                PayloadObject.Add('sub_flag', Format(NewMember.Subflag).ToUpper);
                PayloadObject.Add('reason', Reason);

            end else begin
                if Member."Primary Identification Type" = Member."Primary Identification Type"::"ID Number" then begin
                    PayloadObject.Add('id_number', Member."Primary Identification");
                end else if Member."Secondary Identification Type" = Member."Secondary Identification Type"::"ID Number" then begin
                    PayloadObject.Add('id_number', Member."Secondary Identification");
                end else begin
                    PayloadObject.Add('id_number', Member."Primary Identification");
                end;

                PayloadObject.Add('member_number', Member."No.");
                PayloadObject.Add('status', Format(Member.Status).ToUpper);
                PayloadObject.Add('sub_flag', Format(Member.Status).ToUpper);
                PayloadObject.Add('reason', Reason);
            end;

            PayloadObject.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // 3. Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');

            // Authorization header
            Client.DefaultRequestHeaders.Add('Authorization', 'Basic ' + Base64Converter.ToBase64(MSmartAPISetupTable."Auth User" + ':' + MSmartAPISetupTable."Auth Pass"));

            IsSuccessful := Client.Post(MSmartAPISetupTable."Base URL" + Member."Mwalimu Smart Callback URL", Content, Response);
            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // {
                    //     "code": 0,
                    //     "msg": "success"
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    ResponseParser.SelectToken('$.code', Token);

                    IF ShowSuccessMessage then begin
                        Message('M-Smart API status : %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                    end;
                end else begin
                    // Errors - 403, 404, etc
                    MSmartAPILogsTable.Init;
                    MSmartAPILogsTable."Request URL" := Member."Mwalimu Smart Callback URL";
                    MSmartAPILogsTable."Vendor Name" := VendorName;

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
                    MSmartAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    MSmartAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    MSmartAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    MSmartAPILogsTable."Response Headers" := '';
                    MSmartAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    MSmartAPILogsTable.Miscellaneous := '';
                    MSmartAPILogsTable.Insert;

                    Message('M-Smart API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                MSmartAPILogsTable.Init;
                MSmartAPILogsTable."Request URL" := Member."Mwalimu Smart Callback URL";
                MSmartAPILogsTable."Vendor Name" := VendorName;

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
                MSmartAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                MSmartAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                MSmartAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                MSmartAPILogsTable."Response Headers" := '';
                MSmartAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                MSmartAPILogsTable.Miscellaneous := 'M-Smart API Login has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                MSmartAPILogsTable.Insert;

                Message('M-Smart API has failed. Status %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;
        end else begin
            MSmartAPILogsTable.Init;
            MSmartAPILogsTable."Request URL" := 'NOT_SET';
            MSmartAPILogsTable."Vendor Name" := VendorName;
            MSmartAPILogsTable."Request Headers" := 'N/A';
            MSmartAPILogsTable."Request Data" := 'N/A';
            MSmartAPILogsTable."Response Status Code" := 'N/A';
            MSmartAPILogsTable."Response Headers" := 'N/A';
            MSmartAPILogsTable."Response Data" := 'N/A';
            MSmartAPILogsTable.Miscellaneous := 'Unable to initiate login. API credentials have NOT been set on the ' + MSmartAPISetupTable.TableName + ' table. Kindly contact the system administrator.';
            MSmartAPILogsTable.Insert;

            // Message('Unable to initiate login. API credentials have NOT been set on the %1 table. Kindly contact the system administrator.', CRMAPISetupTable.TableName);
        end;
    end;

    procedure LoanStatusChange(
        Loan: Record Loans;
        var MSmartCorrections: Record "M-Smart Loan Corrections";
        ShowSuccessMessage: Boolean
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
        Token: JsonToken;
        ResponseMessage: JsonToken;
        MSmartAPISetupTable: Record "M-Smart API Setup";
        MSmartAPILogsTable: Record "BC API Logs";

        Base64Converter: Codeunit "Base64 Convert";

        Corrections: JsonArray;
        Correction: JsonObject;

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
        IF MSmartAPISetupTable.FindFirst then begin
            IF MSmartAPISetupTable.Status = MSmartAPISetupTable.Status::Inactive then begin
                Message('M-Smart API status: %1', Format(MSmartAPISetupTable.Status));
                exit;
            end;
            // 2. Prepare the payload data
            // {
            //     "loan_account_number": "ACCNO",
            //     "status": "ACTIVE",
            //     "sub_flag": "ACTIVE"
            //     "corrections": [
            //          {
            //              "correction_type":"",
            //              "correction_remark":"",
            //              "target_member_number":"",
            //          }
            //      ]
            // }
            PayloadObject.Add('loan_account_number', Loan."Loan No.");
            PayloadObject.Add('status', Format(Loan.Status).ToUpper);
            PayloadObject.Add('sub_flag', Format(Loan.Status).ToUpper);

            // Corrections
            MSmartCorrections.SetRange("Application No.", Loan."Loan No.");
            if MSmartCorrections.FindSet then begin
                repeat begin
                    case MSmartCorrections."Correction Type" of
                        MSmartCorrections."Correction Type"::add_document:
                            Correction.Add('correction_type', 'add_document');
                        MSmartCorrections."Correction Type"::add_guarantor:
                            Correction.Add('correction_type', 'add_guarantor');
                        MSmartCorrections."Correction Type"::guarantor_signature:
                            Correction.Add('correction_type', 'guarantor_signature');
                        MSmartCorrections."Correction Type"::reduce_amount:
                            Correction.Add('correction_type', 'reduce_amount');
                        MSmartCorrections."Correction Type"::reduce_duration:
                            Correction.Add('correction_type', 'reduce_duration');
                        else
                    end;

                    Correction.Add('correction_remark', MSmartCorrections.Remarks);
                    Correction.Add('target_member_number', MSmartCorrections."Guarantor Member No.");

                    Corrections.Add(Correction);

                    // Reset
                    Correction.ReadFrom('{}');
                end until MSmartCorrections.Next = 0;
            end;
            PayloadObject.Add('corrections', Corrections);

            PayloadObject.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // 3. Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');

            // Authorization header
            Client.DefaultRequestHeaders.Add('Authorization', 'Basic ' + Base64Converter.ToBase64(MSmartAPISetupTable."Auth User" + ':' + MSmartAPISetupTable."Auth Pass"));

            IsSuccessful := Client.Post(MSmartAPISetupTable."Base URL" + Loan."Mwalimu Smart Callback URL", Content, Response);
            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // {
                    //     "code": 0,
                    //     "msg": "success"
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    ResponseParser.SelectToken('$.code', Token);

                    IF ShowSuccessMessage then begin
                        Message('M-Smart API status : %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                    end;
                end else begin
                    // Errors - 403, 404, etc
                    MSmartAPILogsTable.Init;
                    MSmartAPILogsTable."Request URL" := Loan."Mwalimu Smart Callback URL";
                    MSmartAPILogsTable."Vendor Name" := VendorName;

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
                    MSmartAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    MSmartAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    MSmartAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    MSmartAPILogsTable."Response Headers" := '';
                    MSmartAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    MSmartAPILogsTable.Miscellaneous := '';
                    MSmartAPILogsTable.Insert;

                    Message('M-Smart API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                MSmartAPILogsTable.Init;
                MSmartAPILogsTable."Request URL" := Loan."Mwalimu Smart Callback URL";
                MSmartAPILogsTable."Vendor Name" := VendorName;

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
                MSmartAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                MSmartAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                MSmartAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                MSmartAPILogsTable."Response Headers" := '';
                MSmartAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                MSmartAPILogsTable.Miscellaneous := 'M-Smart API Login has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                MSmartAPILogsTable.Insert;

                Message('M-Smart API has failed. Status %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;
        end else begin
            MSmartAPILogsTable.Init;
            MSmartAPILogsTable."Request URL" := 'NOT_SET';
            MSmartAPILogsTable."Vendor Name" := VendorName;
            MSmartAPILogsTable."Request Headers" := 'N/A';
            MSmartAPILogsTable."Request Data" := 'N/A';
            MSmartAPILogsTable."Response Status Code" := 'N/A';
            MSmartAPILogsTable."Response Headers" := 'N/A';
            MSmartAPILogsTable."Response Data" := 'N/A';
            MSmartAPILogsTable.Miscellaneous := 'Unable to initiate login. API credentials have NOT been set on the ' + MSmartAPISetupTable.TableName + ' table. Kindly contact the system administrator.';
            MSmartAPILogsTable.Insert;

            // Message('Unable to initiate login. API credentials have NOT been set on the %1 table. Kindly contact the system administrator.', CRMAPISetupTable.TableName);
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
        VendorName: Label 'Malakoff';
}