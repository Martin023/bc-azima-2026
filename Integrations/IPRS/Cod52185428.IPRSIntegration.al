codeunit 52185428 "IPRS Integration"
{
    procedure ValidateMemberApplication(var MemberApplication: Record "Member Application")
    var
        IdNumber: Text;
        IPRSResponse: Text;
        IPRSResponseParser: JsonObject;

        TokenData: JsonToken;
    begin
        if MemberApplication."Primary Identification Type" = MemberApplication."Primary Identification Type"::"ID Number" then begin
            IdNumber := MemberApplication."Primary Identification";
        end;
        if IdNumber = '' then begin
            if MemberApplication."Secondary Identification Type" = MemberApplication."Secondary Identification Type"::"ID Number" then begin
                IdNumber := MemberApplication."Secondary Identification";
            end;
        end;

        if IdNumber = '' then begin
            Error('Member application %1 does not have required ID number data', MemberApplication."No.");
        end;

        IPRSResponse := CallIPRSIDDetails(IdNumber);
        if IPRSResponse <> '' then begin
            // {
            //     "identifier_type": "NATIONAL_ID",
            //     "identifier": "123456789",
            //     "full_name": "JOHN DOE TEST",
            //     "surname": "TEST",
            //     "first_name": "JOHN",
            //     "other_name": "DOE",
            //     "national_id_serial_number": "987654321"
            // }
            IPRSResponseParser.ReadFrom(IPRSResponse);

            IPRSResponseParser.SelectToken('$.full_name', TokenData);
            MemberApplication."IPRS Full Names" := TokenData.AsValue.AsText;
            Clear(TokenData);

            IPRSResponseParser.SelectToken('$.identifier', TokenData);
            MemberApplication."IPRS ID" := TokenData.AsValue.AsText;
            Clear(TokenData);

            IPRSResponseParser.SelectToken('$.identifier_type', TokenData);
            MemberApplication."IPRS ID Type" := TokenData.AsValue.AsText;
            Clear(TokenData);

            IPRSResponseParser.SelectToken('$.national_id_serial_number', TokenData);
            MemberApplication."IPRS ID Serial No" := TokenData.AsValue.AsText;
            Clear(TokenData);

            MemberApplication."IPRS Verified" := true;
            MemberApplication."IPRS Verified At" := CurrentDateTime;
            MemberApplication.Modify;
        end;
    end;

    procedure ValidateMember(var Member: Record "Members")
    var
        IdNumber: Text;
        IPRSResponse: Text;
        IPRSResponseParser: JsonObject;

        TokenData: JsonToken;
    begin
        if Member."Primary Identification Type" = Member."Primary Identification Type"::"ID Number" then begin
            IdNumber := Member."Primary Identification";
        end;
        if IdNumber = '' then begin
            if Member."Secondary Identification Type" = Member."Secondary Identification Type"::"ID Number" then begin
                IdNumber := Member."Secondary Identification";
            end;
        end;

        if IdNumber = '' then begin
            Error('Member number %1 does not have required ID number data', Member."No.");
        end;

        IPRSResponse := CallIPRSIDDetails(IdNumber);
        if IPRSResponse <> '' then begin
            // {
            //     "identifier_type": "NATIONAL_ID",
            //     "identifier": "123456789",
            //     "full_name": "JOHN DOE TEST",
            //     "surname": "TEST",
            //     "first_name": "JOHN",
            //     "other_name": "DOE",
            //     "national_id_serial_number": "987654321"
            // }
            IPRSResponseParser.ReadFrom(IPRSResponse);

            IPRSResponseParser.SelectToken('$.full_name', TokenData);
            Member."IPRS Full Names" := TokenData.AsValue.AsText;
            Clear(TokenData);

            IPRSResponseParser.SelectToken('$.identifier', TokenData);
            Member."IPRS ID" := TokenData.AsValue.AsText;
            Clear(TokenData);

            IPRSResponseParser.SelectToken('$.identifier_type', TokenData);
            Member."IPRS ID Type" := TokenData.AsValue.AsText;
            Clear(TokenData);

            IPRSResponseParser.SelectToken('$.national_id_serial_number', TokenData);
            Member."IPRS ID Serial No" := TokenData.AsValue.AsText;
            Clear(TokenData);

            Member."IPRS Verified" := true;
            Member."IPRS Verified At" := CurrentDateTime;
            Member.Modify;
        end;
    end;

    local procedure CallIPRSIDDetails(
        IdNumber: Text
    ): Text
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
        HasError: Boolean;
        TheError: JsonToken;
        Success: JsonToken;
        BatchNo: JsonToken;
        ExpiresIn: JsonToken;
        APICode: JsonToken;
        APICodeDescription: JsonToken;
        ResponseMessage: JsonToken;
        IPRSAPISetupTable: Record "IPRS API Setup";
        IPRSAPILogsTable: Record "BC API Logs";

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
        if IPRSAPISetupTable.FindFirst then begin
            if IPRSAPISetupTable.Status <> IPRSAPISetupTable.Status::Active then begin
                Error('IPRS service is disabled at the moment. Please contact your ICT administrator');
                exit('');
            end;

            // 2. Prepare the payload data
            // {
            //     "derived_register_type": "IPRS",
            //     "identifier_type": "NATIONAL_ID",
            //     "identifier" : "123456789",
            //     "category" : "MEMBER_ONBOARDING"
            // }
            PayloadObject.Add('derived_register_type', 'IPRS');
            PayloadObject.Add('identifier_type', 'NATIONAL_ID');
            PayloadObject.Add('identifier', IdNumber);
            PayloadObject.Add('category', 'MEMBER_ONBOARDING');

            PayloadObject.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // 3. Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');

            URL := IPRSAPISetupTable."Base URL" + '/rest/derived-register';

            IsSuccessful := Client.Post(URL, Content, Response);
            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // {
                    //     "identifier_type": "NATIONAL_ID",
                    //     "identifier": "123456789",
                    //     "full_name": "JOHN DOE TEST",
                    //     "surname": "TEST",
                    //     "first_name": "JOHN",
                    //     "other_name": "DOE",
                    //     "national_id_serial_number": "987654321"
                    // }

                    // {
                    //     "id": "4f911742de7c9e5ed5dedfa83b72745e59561a5ca0d95f309f48ad251564dcfd",
                    //     "timestamp": "2025-02-28 16:20:57",
                    //     "status": 400,
                    //     "error": "Unknown identifier type 'NATIONAL_ID-'",
                    //     "errors": null,
                    //     "message": "",
                    //     "path": "/iprs/api/rest/derived-register",
                    //     "method": "POST"
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    HasError := ResponseParser.SelectToken('$.error', TheError);

                    if HasError then begin
                        Error('IPRS Error: %1', TheError.AsValue.AsText);
                        exit('');
                    end else begin
                        exit(ResponseText);
                    end;
                end else begin
                    // Errors - 403, 404, etc
                    IPRSAPILogsTable.Init;
                    IPRSAPILogsTable."Request URL" := URL;
                    IPRSAPILogsTable."Vendor Name" := VendorName;

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
                    IPRSAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    IPRSAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    IPRSAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    IPRSAPILogsTable."Response Headers" := '';
                    IPRSAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    IPRSAPILogsTable.Miscellaneous := '';
                    IPRSAPILogsTable.Insert;
                end;
            end else begin
                IPRSAPILogsTable.Init;
                IPRSAPILogsTable."Request URL" := URL;
                IPRSAPILogsTable."Vendor Name" := VendorName;

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
                IPRSAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                IPRSAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                IPRSAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                IPRSAPILogsTable."Response Headers" := '';
                IPRSAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                IPRSAPILogsTable.Miscellaneous := 'IPRS API Login has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                IPRSAPILogsTable.Insert;

                Message('IPRS API request has failed. Status %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;
        end else begin
            Error('IPRS service has not been setup. Contact ICT administrator for further assistance');
        end;
        exit('');
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
        VendorName: label 'Sky World Limited';
}
