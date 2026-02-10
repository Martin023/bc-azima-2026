codeunit 52186514 "EDMS Functions"
{
    procedure EDMSLogin(ShowSuccessMessage: Boolean)
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
        EDMSAPISetupTable: Record "EDMS API Setup";
        EDMSAPILogsTable: Record "BC API Logs";

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
        IF EDMSAPISetupTable.FindFirst then begin
            IF EDMSAPISetupTable.Status = EDMSAPISetupTable.Status::Inactive then begin
                Message('EDMS Login API status: %1', Format(EDMSAPISetupTable.Status));
                exit;
            end;
            // 2. Prepare the payload data
            // {
            //     "sourceIp": "{{src_ip}}",
            //     "encryptKey": "{{encrypt_key}}",
            //     "userName": "{{user_name}}",
            //     "passcode": "{{pass_code}}"
            // }
            PayloadObject.Add('sourceIp', EDMSAPISetupTable."Source IP");
            PayloadObject.Add('encryptKey', EDMSAPISetupTable."Encrypt Key");
            PayloadObject.Add('userName', EDMSAPISetupTable.Username);
            PayloadObject.Add('passcode', EDMSAPISetupTable.Passcode);

            PayloadObject.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // 3. Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');

            IsSuccessful := Client.Post(EDMSAPISetupTable."Base URL" + '/getToken', Content, Response);
            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // {
                    //     "Response": {
                    //         "Token": "45430f1e8985973f37c0ae4b0af6f4e4b67f50236902f509e8e9b1669c811265"
                    //     }
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    ResponseParser.SelectToken('$.Response.Token', Token);

                    if Token.AsValue.AsText = 'Authentication failed' then begin

                        // {
                        //     "Response": {
                        //         "Token": "Authentication failed"
                        //     }
                        // }
                        Message('FAILED. EDMS Login Response status %1.', Token.AsValue.AsText);

                        EDMSAPILogsTable.Init;
                        EDMSAPILogsTable."Request URL" := EDMSAPISetupTable."Base URL" + '/getToken';
                        EDMSAPILogsTable."Vendor Name" := VendorName;

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
                        EDMSAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                        EDMSAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                        EDMSAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                        EDMSAPILogsTable."Response Headers" := '';
                        EDMSAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                        EDMSAPILogsTable.Miscellaneous := '';
                        EDMSAPILogsTable.Insert;

                    end else begin
                        LoginToken := Token.AsValue.AsText;

                        IF ShowSuccessMessage then begin
                            Message('EDMS Login API status : %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                        end;
                    end;
                end else begin
                    // Errors - 403, 404, etc
                    EDMSAPILogsTable.Init;
                    EDMSAPILogsTable."Request URL" := EDMSAPISetupTable."Base URL" + '/getToken';
                    EDMSAPILogsTable."Vendor Name" := VendorName;

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
                    EDMSAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    EDMSAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    EDMSAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    EDMSAPILogsTable."Response Headers" := '';
                    EDMSAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    EDMSAPILogsTable.Miscellaneous := '';
                    EDMSAPILogsTable.Insert;

                    Message('EDMS Login API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                EDMSAPILogsTable.Init;
                EDMSAPILogsTable."Request URL" := EDMSAPISetupTable."Base URL" + '/getToken';
                EDMSAPILogsTable."Vendor Name" := VendorName;

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
                EDMSAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                EDMSAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                EDMSAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                EDMSAPILogsTable."Response Headers" := '';
                EDMSAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                EDMSAPILogsTable.Miscellaneous := 'EDMS API Login has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                EDMSAPILogsTable.Insert;

                Message('EDMS API Login has failed. Status %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;
        end else begin
            EDMSAPILogsTable.Init;
            EDMSAPILogsTable."Request URL" := 'NOT_SET';
            EDMSAPILogsTable."Vendor Name" := VendorName;
            EDMSAPILogsTable."Request Headers" := 'N/A';
            EDMSAPILogsTable."Request Data" := 'N/A';
            EDMSAPILogsTable."Response Status Code" := 'N/A';
            EDMSAPILogsTable."Response Headers" := 'N/A';
            EDMSAPILogsTable."Response Data" := 'N/A';
            EDMSAPILogsTable.Miscellaneous := 'Unable to initiate login. API credentials have NOT been set on the ' + EDMSAPISetupTable.TableName + ' table. Kindly contact the system administrator.';
            EDMSAPILogsTable.Insert;

            // Message('Unable to initiate login. API credentials have NOT been set on the %1 table. Kindly contact the system administrator.', CRMAPISetupTable.TableName);
        end;
    end;

    procedure EDMSMemberFileUpload(
        idNumber: Text;
        memberName: Text;
        applicationType: Text;
        pfNumber: Text;
        memberNumber: Text;
        applicationNumber: Text;
        fileName: Text;
        fileB64Contents: Text
    )
    var
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        Response: HttpResponseMessage;
        ResponseText: Text;
        HttpStatusCode: Integer;
        EDMSFileUploadRecord: JsonObject;
        Note: JsonObject;
        Payload: Text;

        DocDatum: JsonObject;
        DocData: JsonArray;

        response_response: JsonToken;

        ResponseParser: JsonObject;
        ResponseKeyExists: Boolean;
        ResponseStatus: JsonToken;
        ResponseMessage: JsonToken;

        EDMSAPISetupTable: Record "EDMS API Setup";
        EDMSAPILogsTable: Record "BC API Logs";
        EDMSFileTypes: enum "EDMS File Types";

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
        EDMSLogin(false);

        // 2. Check login token
        IF LoginToken <> '' then begin
            // 3. Prepare the payload data
            // {
            //     "token": "{{token}}",
            //     "userName": "{{user_name}}",
            //     "idNumber": "09944574",
            //     "memberName": "SARAH NJERI SNK",
            //     "applicationType": "Member Application",
            //     "pfNumber": "23464574",
            //     "memberNumber": "MAP000138",
            //     "crmNumber": "MAP000138",
            //     "docData": [
            //         {
            //             "imageNameWithExt": "MAP000138 - 1.pdf",
            //             "base64Image": ""
            //         }
            //     ]
            // }

            // Fetch EDMS API credentials
            EDMSAPISetupTable.FindFirst();

            EDMSFileUploadRecord.Add('token', LoginToken);
            EDMSFileUploadRecord.Add('userName', EDMSAPISetupTable.Username);

            // if StrLen(idNumber) > 8 then begin
            //     EDMSFileUploadRecord.Add('idNumber', idNumber.Substring(1, 8));
            // end else begin
            //     EDMSFileUploadRecord.Add('idNumber', idNumber.Substring(1, StrLen(idNumber)));
            // end;
            EDMSFileUploadRecord.Add('idNumber', idNumber);

            EDMSFileUploadRecord.Add('memberName', memberName);
            EDMSFileUploadRecord.Add('applicationType', applicationType);
            EDMSFileUploadRecord.Add('pfNumber', pfNumber);
            EDMSFileUploadRecord.Add('memberNumber', memberNumber);
            EDMSFileUploadRecord.Add('crmNumber', applicationNumber);

            case GetFileTypeFromFileName(fileName) of
                "EDMS File Types"::PDF:
                    fileName := applicationType + ' - ' + applicationNumber + '.pdf';
                "EDMS File Types"::PNG:
                    fileName := applicationType + ' - ' + applicationNumber + '.png';
                "EDMS File Types"::JPEG:
                    fileName := applicationType + ' - ' + applicationNumber + '.jpg';
                "EDMS File Types"::TIF:
                    fileName := applicationType + ' - ' + applicationNumber + '.tif';
                "EDMS File Types"::TIFF:
                    fileName := applicationType + ' - ' + applicationNumber + '.tiff';
            end;
            DocDatum.Add('imageNameWithExt', fileName);
            DocDatum.Add('base64Image', fileB64Contents);
            DocData.Add(DocDatum);
            EDMSFileUploadRecord.Add('docData', DocData);

            EDMSFileUploadRecord.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');
            // Authorization header
            Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + LoginToken);

            IsSuccessful := Client.Post(EDMSAPISetupTable."Base URL" + '/memberFile', Content, Response);

            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // {
                    //     "response": []
                    // }
                    ResponseParser.ReadFrom(ResponseText);

                    if ResponseParser.SelectToken('$.response[0].error!', response_response) then begin
                        Message('EDMS member file(s) upload FAILED. Response = %1', response_response.AsValue.AsText);
                    end else begin
                        Message('EDMS member file(s) upload SUCCESS');
                    end;
                end else begin
                    // Errors - 403, 404, etc
                    EDMSAPILogsTable.Init;
                    EDMSAPILogsTable."Request URL" := EDMSAPISetupTable."Base URL" + '/memberFile';
                    EDMSAPILogsTable."Vendor Name" := VendorName;

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
                    EDMSAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    EDMSAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    EDMSAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    EDMSAPILogsTable."Response Headers" := '';
                    EDMSAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    EDMSAPILogsTable.Miscellaneous := '';
                    EDMSAPILogsTable.Insert;

                    Message('EDMS Member File Upload API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                EDMSAPILogsTable.Init;
                EDMSAPILogsTable."Request URL" := EDMSAPISetupTable."Base URL" + '/memberFile';
                EDMSAPILogsTable."Vendor Name" := VendorName;

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
                EDMSAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                EDMSAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                EDMSAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                EDMSAPILogsTable."Response Headers" := '';
                EDMSAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                EDMSAPILogsTable.Miscellaneous := 'EDMS API update has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                EDMSAPILogsTable.Insert;

                // Message('EDMS Member File Upload API has failed. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;


        end else begin
            // Error
            // Message('Unable to upload EDMS member file at the moment. Kindly contact the administrator');
        end;
    end;

    procedure EDMSLoanFileUpload(
        idNumber: Text;
        clientName: Text;
        accountType: Text;
        pfNumber: Text;
        memberNumber: Text;
        applicationNumber: Text;
        accountNumber: Text;

        fileName: Text;
        fileB64Contents: Text;
        maintainFileName: Boolean
    )
    var
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        Response: HttpResponseMessage;
        ResponseText: Text;
        HttpStatusCode: Integer;
        EDMSFileUploadRecord: JsonObject;
        Note: JsonObject;
        Payload: Text;

        DocDatum: JsonObject;
        DocData: JsonArray;

        response_response: JsonToken;

        ResponseParser: JsonObject;
        ResponseKeyExists: Boolean;
        ResponseStatus: JsonToken;
        ResponseMessage: JsonToken;

        EDMSAPISetupTable: Record "EDMS API Setup";
        EDMSAPILogsTable: Record "BC API Logs";

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
        EDMSLogin(false);

        // 2. Check login token
        IF LoginToken <> '' then begin
            // 3. Prepare the payload data
            // {
            //     "token": "{{token}}",
            //     "userName": "{{user_name}}",
            //     "idNumber": "14641898",
            //     "clientName": "LYDIA MUTHONI NJOROGE",
            //     "accountType": "LOAN APPLICATION",
            //     "pfNumber": "700760",
            //     "memberNumber": "059017",
            //     "crmNumber": "LN000348",
            //     "accountNumber": "LN000348",
            //     "docData": [
            //         {
            //             "imageNameWithExt": "MAP000138 - 1.pdf",
            //             "base64Image": ""
            //         }
            //     ]
            // }

            // Fetch EDMS API credentials
            EDMSAPISetupTable.FindFirst();

            EDMSFileUploadRecord.Add('token', LoginToken);
            EDMSFileUploadRecord.Add('userName', EDMSAPISetupTable.Username);
            EDMSFileUploadRecord.Add('idNumber', idNumber);
            EDMSFileUploadRecord.Add('clientName', clientName);
            EDMSFileUploadRecord.Add('accountType', accountType);
            EDMSFileUploadRecord.Add('pfNumber', pfNumber);
            EDMSFileUploadRecord.Add('memberNumber', memberNumber);
            EDMSFileUploadRecord.Add('crmNumber', applicationNumber);
            EDMSFileUploadRecord.Add('accountNumber', accountNumber);

            if not maintainFileName then begin
                case GetFileTypeFromFileName(fileName) of
                    "EDMS File Types"::PDF:
                        fileName := accountType + ' - ' + applicationNumber + '.pdf';
                    "EDMS File Types"::PNG:
                        fileName := accountType + ' - ' + applicationNumber + '.png';
                    "EDMS File Types"::JPEG:
                        fileName := accountType + ' - ' + applicationNumber + '.jpg';
                    "EDMS File Types"::TIF:
                        fileName := accountType + ' - ' + applicationNumber + '.tif';
                    "EDMS File Types"::TIFF:
                        fileName := accountType + ' - ' + applicationNumber + '.tiff';
                end;
            end;

            DocDatum.Add('imageNameWithExt', fileName);
            DocDatum.Add('base64Image', fileB64Contents);
            DocData.Add(DocDatum);
            EDMSFileUploadRecord.Add('docData', DocData);

            EDMSFileUploadRecord.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');
            // Authorization header
            Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + LoginToken);

            IsSuccessful := Client.Post(EDMSAPISetupTable."Base URL" + '/loanFile', Content, Response);

            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // {
                    //     "response": []
                    // }
                    ResponseParser.ReadFrom(ResponseText);

                    if ResponseParser.SelectToken('$.edms Response[0].error!', response_response) then begin
                        Message('EDMS loan file(s) upload FAILED. Response = %1', response_response.AsValue.AsText);
                    end else begin
                        Message('EDMS loan file(s) upload SUCCESS');
                    end;
                end else begin
                    // Errors - 403, 404, etc
                    EDMSAPILogsTable.Init;
                    EDMSAPILogsTable."Request URL" := EDMSAPISetupTable."Base URL" + '/loanFile';
                    EDMSAPILogsTable."Vendor Name" := VendorName;

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
                    EDMSAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    EDMSAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    EDMSAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    EDMSAPILogsTable."Response Headers" := '';
                    EDMSAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    EDMSAPILogsTable.Miscellaneous := '';
                    EDMSAPILogsTable.Insert;

                    Message('EDMS Loan File Upload API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                EDMSAPILogsTable.Init;
                EDMSAPILogsTable."Request URL" := EDMSAPISetupTable."Base URL" + '/loanFile';
                EDMSAPILogsTable."Vendor Name" := VendorName;

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
                EDMSAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                EDMSAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                EDMSAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                EDMSAPILogsTable."Response Headers" := '';
                EDMSAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                EDMSAPILogsTable.Miscellaneous := 'EDMS API update has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                EDMSAPILogsTable.Insert;

                Message('EDMS Loan File Upload API has failed. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;


        end else begin
            // Error
            // Message('Unable to upload EDMS loan file at the moment. Kindly contact the administrator');
        end;
    end;

    procedure EDMSFileList(applicationNo: Text; EDMSDataClass: Text)
    var
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        Response: HttpResponseMessage;
        ResponseText: Text;
        HttpStatusCode: Integer;
        EDMSFileUploadRecord: JsonObject;
        Note: JsonObject;
        Payload: Text;

        response_response: JsonToken;
        response_body: JsonToken;
        edms_file_key: Text;
        edms_file: JsonToken;
        edms_file_id: JsonToken;
        edms_file_name: JsonToken;


        ResponseParser: JsonObject;
        ResponseKeyExists: Boolean;
        ResponseStatus: JsonToken;
        ResponseMessage: JsonToken;

        EDMSAPISetupTable: Record "EDMS API Setup";
        EDMSAPILogsTable: Record "BC API Logs";
        EDMSFilesTable: Record "EDMS Files";

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
        EDMSLogin(false);

        // 2. Check login token
        IF LoginToken <> '' then begin
            // 3. Prepare the payload data
            // {
            //     "token":"{{token}}",
            //     "userName":"{{user_name}}",
            //     "CrmNumber": "MAP000138"
            // }

            // Fetch EDMS API credentials
            EDMSAPISetupTable.FindFirst();

            EDMSFileUploadRecord.Add('token', LoginToken);
            EDMSFileUploadRecord.Add('userName', EDMSAPISetupTable.Username);
            // EDMSFileUploadRecord.Add('CrmNumber', applicationNo);
            EDMSFileUploadRecord.Add('searchParam', applicationNo);

            EDMSFileUploadRecord.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');
            // Authorization header
            Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + LoginToken);

            IsSuccessful := Client.Post(EDMSAPISetupTable."Base URL" + '/imageList', Content, Response);

            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // {
                    //     "response": []
                    // }
                    ResponseParser.ReadFrom(ResponseText);

                    if ResponseParser.SelectToken('$.Response.Error', response_response) then begin
                        Message('EDMS file list retrievial has FAILED. Response = %1', response_response.AsValue.AsText);
                    end else begin
                        // {
                        //     "Response": {
                        //         "body": {
                        //             "image1": {
                        //                 "imageID": "151",
                        //                 "imageName": "MAP000113 - 2.pdf"
                        //             },
                        //             "image0": {
                        //                 "imageID": "150",
                        //                 "imageName": "MAP000138 - 1.pdf"
                        //             }
                        //         },
                        //         "header": {
                        //             "MemberNumber": "MAP000138",
                        //             "CrmNumber": "MAP000138",
                        //             "MemberName": "SARAH NJERI SNK",
                        //             "IdNumber": "09944574"
                        //         }
                        //     },
                        //     "CrmNumber": "MAP000138",
                        //     "userName": "SkyWorld",
                        //     "token": "ffcf0d9a00e20541a3e305ebabda811fe4d9153dd149871910da6fb732e11a8d"
                        // }

                        ResponseParser.SelectToken('$.Response.body', response_body);

                        if response_body.IsObject then begin

                            foreach edms_file_key in response_body.AsObject.Keys do begin
                                response_body.AsObject.Get(edms_file_key, edms_file);

                                if edms_file.IsObject then begin
                                    edms_file.AsObject.Get('imageID', edms_file_id);
                                    edms_file.AsObject.Get('imageName', edms_file_name);

                                    // Update/Insert into EDMS table
                                    EDMSFilesTable.Reset;
                                    EDMSFilesTable.SetRange("Application No.", applicationNo);
                                    EDMSFilesTable.SetRange("EDMS Document ID", edms_file_id.AsValue.AsText);

                                    if EDMSFilesTable.FindFirst then begin
                                        // Update
                                        EDMSFilesTable."EDMS Document ID" := edms_file_id.AsValue.AsText;
                                        EDMSFilesTable."EDMS Document Name" := edms_file_name.AsValue.AsText;
                                        EDMSFilesTable."EDMS Document Link" := '';
                                        EDMSFilesTable."EDMS File Type" := GetFileTypeFromFileName(edms_file_name.AsValue.AsText);
                                        EDMSFilesTable."Updated By" := UserId;

                                        case EDMSDataClass of
                                            Format("EDMS Data Classes"::BusinessLoansFile):
                                                EDMSFilesTable."EDMS Data Class Name" := "EDMS Data Classes"::BusinessLoansFile;
                                            Format("EDMS Data Classes"::MemberFile):
                                                EDMSFilesTable."EDMS Data Class Name" := "EDMS Data Classes"::MemberFile;
                                            else
                                                EDMSFilesTable."EDMS Data Class Name" := "EDMS Data Classes"::" ";
                                        end;

                                        EDMSFilesTable.Modify(true);
                                    end else begin
                                        // Insert
                                        EDMSFilesTable.Init;

                                        EDMSFilesTable."Application No." := applicationNo;
                                        EDMSFilesTable."EDMS Document ID" := edms_file_id.AsValue.AsText;
                                        EDMSFilesTable."EDMS Document Name" := edms_file_name.AsValue.AsText;
                                        EDMSFilesTable."EDMS Document Link" := '';
                                        EDMSFilesTable."EDMS File Type" := GetFileTypeFromFileName(edms_file_name.AsValue.AsText);
                                        EDMSFilesTable."Created By" := UserId;
                                        EDMSFilesTable."Updated By" := UserId;

                                        case EDMSDataClass of
                                            Format("EDMS Data Classes"::BusinessLoansFile):
                                                EDMSFilesTable."EDMS Data Class Name" := "EDMS Data Classes"::BusinessLoansFile;
                                            Format("EDMS Data Classes"::MemberFile):
                                                EDMSFilesTable."EDMS Data Class Name" := "EDMS Data Classes"::MemberFile;
                                            else
                                                EDMSFilesTable."EDMS Data Class Name" := "EDMS Data Classes"::" ";
                                        end;

                                        EDMSFilesTable.Insert(true);
                                    end;
                                end else begin
                                    // Error('Unexpected EDMS file list response for edms_file')
                                    Message('Unexpected EDMS file list response for edms_file')
                                end;
                            end;

                        end else begin
                            // Error('Unexpected EDMS file list response for response_body')
                            Message('Unexpected EDMS file list response for response_body')
                        end;
                    end;
                end else begin
                    // Errors - 403, 404, etc
                    EDMSAPILogsTable.Init;
                    EDMSAPILogsTable."Request URL" := EDMSAPISetupTable."Base URL" + '/imageList';
                    EDMSAPILogsTable."Vendor Name" := VendorName;

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
                    EDMSAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    EDMSAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    EDMSAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    EDMSAPILogsTable."Response Headers" := '';
                    EDMSAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    EDMSAPILogsTable.Miscellaneous := '';
                    EDMSAPILogsTable.Insert;

                    Message('EDMS File list API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                EDMSAPILogsTable.Init;
                EDMSAPILogsTable."Request URL" := EDMSAPISetupTable."Base URL" + '/imageList';
                EDMSAPILogsTable."Vendor Name" := VendorName;

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
                EDMSAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                EDMSAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                EDMSAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                EDMSAPILogsTable."Response Headers" := '';
                EDMSAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                EDMSAPILogsTable.Miscellaneous := 'EDMS API update has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                EDMSAPILogsTable.Insert;

                Message('EDMS File list API has failed. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;


        end else begin
            // Error
            Message('Unable to retrieve EDMS file list at the moment. Kindly contact the administrator');
        end;
    end;

    procedure EDMSFileView(documentID: Text) FileData: Text;
    var
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        Response: HttpResponseMessage;
        ResponseText: Text;
        HttpStatusCode: Integer;
        EDMSFileUploadRecord: JsonObject;
        Note: JsonObject;
        Payload: Text;

        response_response: JsonToken;
        docData: JsonToken;


        ResponseParser: JsonObject;
        ResponseKeyExists: Boolean;
        ResponseStatus: JsonToken;
        ResponseMessage: JsonToken;

        EDMSAPISetupTable: Record "EDMS API Setup";
        EDMSAPILogsTable: Record "BC API Logs";

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
        EDMSLogin(false);

        // 2. Check login token
        IF LoginToken <> '' then begin
            // 3. Prepare the payload data
            // {
            //     "token":"{{token}}",
            //     "userName":"{{user_name}}",
            //     "DocId":"150"
            // }

            // Fetch EDMS API credentials
            EDMSAPISetupTable.FindFirst();

            EDMSFileUploadRecord.Add('token', LoginToken);
            EDMSFileUploadRecord.Add('userName', EDMSAPISetupTable.Username);
            EDMSFileUploadRecord.Add('DocId', documentID);

            EDMSFileUploadRecord.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');
            // Authorization header
            Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + LoginToken);

            IsSuccessful := Client.Post(EDMSAPISetupTable."Base URL" + '/imageView', Content, Response);

            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // {
                    //     "response": []
                    // }
                    ResponseParser.ReadFrom(ResponseText);

                    if ResponseParser.SelectToken('$.error 500', response_response) then begin
                        Message('EDMS file retrievial has FAILED. Response = %1', response_response.AsValue.AsText);
                    end else begin
                        // {
                        //     "Response": {
                        //         "DocumentData": {
                        //             "docData": "B64"
                        //         }
                        //     }
                        // }
                        ResponseParser.SelectToken('$.Response.DocumentData.docData', docData);

                        if docData.IsValue then begin
                            FileData := docData.AsValue.AsText;
                        end else begin
                            Error('Unexpected EDMS file response for docData')
                        end;
                    end;
                end else begin
                    // Errors - 403, 404, etc
                    EDMSAPILogsTable.Init;
                    EDMSAPILogsTable."Request URL" := EDMSAPISetupTable."Base URL" + '/imageView';
                    EDMSAPILogsTable."Vendor Name" := VendorName;

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
                    EDMSAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    EDMSAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    EDMSAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    EDMSAPILogsTable."Response Headers" := '';
                    EDMSAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    EDMSAPILogsTable.Miscellaneous := '';
                    EDMSAPILogsTable.Insert;

                    Message('EDMS File list API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                EDMSAPILogsTable.Init;
                EDMSAPILogsTable."Request URL" := EDMSAPISetupTable."Base URL" + '/imageView';
                EDMSAPILogsTable."Vendor Name" := VendorName;

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
                EDMSAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                EDMSAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                EDMSAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                EDMSAPILogsTable."Response Headers" := '';
                EDMSAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                EDMSAPILogsTable.Miscellaneous := 'EDMS API update has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                EDMSAPILogsTable.Insert;

                Message('EDMS File list API has failed. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;


        end else begin
            // Error
            Message('Unable to retrieve EDMS file at the moment. Kindly contact the administrator');
        end;

        exit(FileData);
    end;
    // -------------------------------------------------------------------------------------------------------------------------------
    procedure PickPDFFile(var TempBlob: Codeunit "Temp Blob") FileName: Text;
    var
        FileManagement: Codeunit "File Management";
    begin
        exit(FileManagement.BLOBImportWithFilter(TempBlob, 'Import', '', 'PDF Files (*.pdf)|*.pdf', '*.pdf'));
    end;

    procedure PickImageFile(var TempBlob: Codeunit "Temp Blob") FileName: Text;
    var
        FileManagement: Codeunit "File Management";
    begin
        exit(FileManagement.BLOBImportWithFilter(TempBlob, 'Import', '', 'Image Files (*.jpg;*.jpeg;*.png;*.tif;*.tiff)|*.jpg;*.jpeg;*.png;*.tif;*.tiff', '*.jpg;*.jpeg;*.png;*.tif;*.tiff'));
    end;

    procedure PickEDMSFile(var TempBlob: Codeunit "Temp Blob") FileName: Text;
    var
        FileManagement: Codeunit "File Management";
    begin
        exit(FileManagement.BLOBImportWithFilter(TempBlob, 'Import', '', 'Files (*.jpg;*.jpeg;*.png;*.tif;*.tiff;*.pdf)|*.jpg;*.jpeg;*.png;*.tif;*.tiff;*.pdf', '*.jpg;*.jpeg;*.png;*.tif;*.tiff;*.pdf'));
    end;

    procedure GetFileTypeFromFileName(fileName: Text) fileType: enum "EDMS File Types"
    var
        // regexPDF: Label '/^.+\.pdf$/gmi';
        regexPDF: Label '^.+\.(pdf|PDF)$';
        regexJPEG: Label '^.+\.(jpg|jpeg)$';
        regexPNG: Label '^.+\.(png|PNG)$';
        regexTIF: Label '^.+\.(tif|TIF)$';
        regexTIFF: Label '^.+\.(tiff|TIFF)$';

        regex: Codeunit Regex;
    begin
        fileType := fileType::" ";

        if regex.IsMatch(fileName, regexPDF) then begin
            fileType := fileType::PDF;
            exit(fileType);
        end;

        if regex.IsMatch(fileName, regexJPEG) then begin
            fileType := fileType::JPEG;
            exit(fileType);
        end;

        if regex.IsMatch(fileName, regexPNG) then begin
            fileType := fileType::PNG;
            exit(fileType);
        end;

        if regex.IsMatch(fileName, regexTIF) then begin
            fileType := fileType::TIF;
            exit(fileType);
        end;

        if regex.IsMatch(fileName, regexTIFF) then begin
            fileType := fileType::TIFF;
            exit(fileType);
        end;

        exit(fileType);
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

    procedure EDMSScannedLog(
        ApplicationNo: Text;
        AppType: enum "CRM Originations";
        MemberNo: Text;
        CRMCreatedBy: Text;
        CRMBranch: Text
    )
    var
        EDMSLog: Record "EDMS Scanned Apps. Log";
    begin
        EDMSLog.Init;

        EDMSLog."Type of Application" := AppType;
        EDMSLog."Application No." := ApplicationNo;
        EDMSLog."Member No." := MemberNo;
        EDMSLog."Created By" := CRMCreatedBy;
        EDMSLog."Creation Date" := Today;
        EDMSLog."Originating Branch" := CRMBranch;

        EDMSLog.Insert;
    end;

    procedure CheckApplicationHasScannedDocuments(ApplicationNo: Text)
    var
        EDMSFilesTable: record "EDMS Files";
    begin
        EDMSLogin(false);

        if LoginToken <> '' then begin
            // Fetch documents from EDMS
            EDMSFileList(ApplicationNo, '');

            // Check if document list has been populated
            EDMSFilesTable.Reset;
            EDMSFilesTable.SetRange("Application No.", ApplicationNo);
            EDMSFilesTable.SetLoadFields("Application No.");

            if EDMSFilesTable.FindSet then begin
                if EDMSFilesTable.Count = 0 then begin
                    Error('Application of no. %1 does NOT have the attached EDMS scanned documents linked to it.', ApplicationNo);
                end;
            end else begin
                Error('Application of no. %1 does NOT have the attached EDMS scanned documents linked to it.', ApplicationNo);
            end;
        end;
    end;

    var
        LoginToken: Text;
        VendorName: Label 'Unimax';

}