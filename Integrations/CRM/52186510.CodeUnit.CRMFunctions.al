codeunit 52186510 "CRM Functions"
{
    procedure CRMLogin(ShowSuccessMessage: Boolean)
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
        Status: JsonToken;
        Token: JsonToken;
        ResponseMessage: JsonToken;
        CRMAPISetupTable: Record "CRM API Setup";
        CRMAPILogsTable: Record "BC API Logs";

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
        IF CRMAPISetupTable.FindFirst() then begin
            IF CRMAPISetupTable.Status = CRMAPISetupTable.Status::Inactive then begin
                Message('CRM Login API status: %1', Format(CRMAPISetupTable.Status));
                exit;
            end;
            // 2. Prepare the payload data
            // {
            //    "Name": "{{app_name}}",
            //    "AppId": "{{app_id}}"
            // }
            PayloadObject.Add('Name', CRMAPISetupTable."Get Token Name");
            PayloadObject.Add('AppId', CRMAPISetupTable."App ID");

            PayloadObject.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // 3. Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');

            IsSuccessful := Client.Post(CRMAPISetupTable."Base URL" + '/GetToken', Content, Response);
            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // {
                    //     "Status": "SUCCESS",
                    //     "Token": "eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2OTk2MTI2NTcsImlzcyI6IkJDIiwiYXVkIjoiYjgwYmQ0MzYtYTk3Ni1lZTExLTgxNzktMDAyMjQ4OWZkZDJiIn0.xOtomiq4a2yv2xkLlyzsDPVb3WcZGl75g6tMoEus2FQ",
                    //     "ExpiryDate": "2023-11-10T10:37:37.1410717Z",
                    //     "Message": null
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    ResponseParser.Get('Status', Status);
                    ResponseParser.Get('Message', ResponseMessage);

                    if Status.AsValue.AsText = 'SUCCESS' then begin
                        ResponseParser.Get('Token', Token);
                        LoginToken := Token.AsValue.AsText;

                        IF ShowSuccessMessage then begin
                            Message('CRM Login API status : %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                        end;
                    end else begin
                        // {
                        //     "Status": "ERROR",
                        //     "Token": null,
                        //     "ExpiryDate": "0001-01-01T00:00:00",
                        //     "Message": "Invalid Application Details"
                        // }
                        Message('FAILED. CRM Login Response status %1. Message: %2', Status.AsValue.AsText, ResponseMessage.AsValue.AsText);

                        CRMAPILogsTable.Init;
                        CRMAPILogsTable."Request URL" := CRMAPISetupTable."Base URL" + '/GetToken';
                        CRMAPILogsTable."Vendor Name" := VendorName;

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
                        CRMAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                        CRMAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                        CRMAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                        CRMAPILogsTable."Response Headers" := '';
                        CRMAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                        CRMAPILogsTable.Miscellaneous := '';
                        CRMAPILogsTable.Insert;
                    end;
                end else begin
                    // Errors - 403, 404, etc
                    CRMAPILogsTable.Init;
                    CRMAPILogsTable."Request URL" := CRMAPISetupTable."Base URL" + '/GetToken';
                    CRMAPILogsTable."Vendor Name" := VendorName;

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
                    CRMAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    CRMAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    CRMAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    CRMAPILogsTable."Response Headers" := '';
                    CRMAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    CRMAPILogsTable.Miscellaneous := '';
                    CRMAPILogsTable.Insert;

                    Message('CRM Login API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                CRMAPILogsTable.Init;
                CRMAPILogsTable."Request URL" := CRMAPISetupTable."Base URL" + '/GetToken';
                CRMAPILogsTable."Vendor Name" := VendorName;

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
                CRMAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                CRMAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                CRMAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRMAPILogsTable."Response Headers" := '';
                CRMAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                CRMAPILogsTable.Miscellaneous := 'CRM API Login has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRMAPILogsTable.Insert;

                Message('CRM API Login has failed. Status %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;
        end else begin
            CRMAPILogsTable.Init;
            CRMAPILogsTable."Request URL" := 'NOT_SET';
            CRMAPILogsTable."Vendor Name" := VendorName;
            CRMAPILogsTable."Request Headers" := 'N/A';
            CRMAPILogsTable."Request Data" := 'N/A';
            CRMAPILogsTable."Response Status Code" := 'N/A';
            CRMAPILogsTable."Response Headers" := 'N/A';
            CRMAPILogsTable."Response Data" := 'N/A';
            CRMAPILogsTable.Miscellaneous := 'Unable to initiate login. API credentials have NOT been set on the ' + CRMAPISetupTable.TableName + ' table. Kindly contact the system administrator.';
            CRMAPILogsTable.Insert;

            // Message('Unable to initiate login. API credentials have NOT been set on the %1 table. Kindly contact the system administrator.', CRMAPISetupTable.TableName);
        end;
    end;

    procedure CRMMemberApplicationUpdate(
        CRMApplicationNo: Text;
        MemberNo: Text;
        MemberStatus: Text; //' ,New,Active,Dormant,Frozen,Withdrawal Applicant,Withdrawn,Deceased,Defaulter,Closed,Withdrawn Shareholder'
        MemberApplicationStatus: Text; //'Open,Pending,Approved,Rejected,Created';
        Description: Text;
        UpdateComment: Text
    )
    var
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        Response: HttpResponseMessage;
        ResponseText: Text;
        HttpStatusCode: Integer;
        CRMMemberApplicationUpdateRecord: JsonObject;
        Note: JsonObject;
        Payload: Text;

        ResponseParser: JsonObject;
        ResponseKeyExists: Boolean;
        ResponseStatus: JsonToken;
        ResponseMessage: JsonToken;

        CRMAPISetupTable: Record "CRM API Setup";
        CRMAPILogsTable: Record "BC API Logs";

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
        CRMLogin(false);

        // 2. Check login token
        IF LoginToken <> '' then begin
            // 3. Prepare the payload data
            // {
            //     "crmapplicationno":"MA-000000010",
            //     "memberno":"",
            //     "memberstatus":"",
            //     "applicationstatus":"Approved",
            //     "description":"The application was successful",
            //     "note":{
            //         "updateComment":""
            //     }
            // }
            CRMMemberApplicationUpdateRecord.Add('crmapplicationno', CRMApplicationNo);
            CRMMemberApplicationUpdateRecord.Add('memberno', MemberNo);
            CRMMemberApplicationUpdateRecord.Add('memberstatus', MemberStatus);
            CRMMemberApplicationUpdateRecord.Add('applicationstatus', MemberApplicationStatus);
            CRMMemberApplicationUpdateRecord.Add('description', Description);

            Note.Add('updateComment', UpdateComment);
            CRMMemberApplicationUpdateRecord.Add('note', Note);

            CRMMemberApplicationUpdateRecord.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // Fetch CRM API credentials
            CRMAPISetupTable.FindFirst();

            // Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');
            // Authorization header
            Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + LoginToken);

            IsSuccessful := Client.Post(CRMAPISetupTable."Base URL" + '/crmmember', Content, Response);

            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // {
                    //     "Status": "SUCCESS",
                    //     "Message": "Member Updated Successfully",
                    //     "RecordId": "00148"
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    ResponseKeyExists := ResponseParser.Get('Status', ResponseStatus);
                    ResponseKeyExists := ResponseParser.Get('Message', ResponseMessage);


                    if ResponseStatus.AsValue.AsText = 'SUCCESS' then begin
                        // CRM API Update success
                        Message('CRM Member Application Update SUCCESS. CRM response message: %1', ResponseMessage.AsValue.AsText);
                    end else begin
                        // {
                        //     "Status": "ERROR",
                        //     "Message": "A record that has the attribute values Member Number already exists. The entity key memberno requires that this set of attributes contains unique values. Select unique values and try again.",
                        //     "RecordId": null
                        // }
                        Message('CRM Member Application Update FAILED. CRM response message: %1', ResponseMessage.AsValue.AsText);
                    end;

                end else begin
                    // Errors - 403, 404, etc
                    CRMAPILogsTable.Init;
                    CRMAPILogsTable."Request URL" := CRMAPISetupTable."Base URL" + '/crmmember';
                    CRMAPILogsTable."Vendor Name" := VendorName;

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
                    CRMAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    CRMAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    CRMAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    CRMAPILogsTable."Response Headers" := '';
                    CRMAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    CRMAPILogsTable.Miscellaneous := '';
                    CRMAPILogsTable.Insert;

                    Message('CRM Member Application Update API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                CRMAPILogsTable.Init;
                CRMAPILogsTable."Request URL" := CRMAPISetupTable."Base URL" + '/crmmember';
                CRMAPILogsTable."Vendor Name" := VendorName;

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
                CRMAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                CRMAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                CRMAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRMAPILogsTable."Response Headers" := '';
                CRMAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                CRMAPILogsTable.Miscellaneous := 'CRM API update has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRMAPILogsTable.Insert;

                Message('CRM Member Application Update API has failed. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;


        end else begin
            // Error
            // Message('Unable to submit CRM member application update at the moment. Kindly contact the administrator.');
        end;
    end;

    procedure CRMLoanApplicationUpdate(
        CRMApplicationNumber: Text;
        LoanNumber: Text;
        DisbursedAmount: Text;
        DisbursementDate: Text;
        LoanApplicationStatus: Text;
        UpdateComment: Text
    )
    var
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        Response: HttpResponseMessage;
        ResponseText: Text;
        HttpStatusCode: Integer;
        CRMLoanApplicationUpdateRecord: JsonObject;
        Note: JsonObject;
        Payload: Text;

        ResponseParser: JsonObject;
        ResponseKeyExists: Boolean;
        ResponseStatus: JsonToken;
        ResponseMessage: JsonToken;

        CRMAPISetupTable: Record "CRM API Setup";
        CRMAPILogsTable: Record "BC API Logs";

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
        CRMLogin(false);

        // 2. Check login token
        IF LoginToken <> '' then begin
            // 3. Prepare the payload data
            // {
            //     "loannumber": "6555456",
            //     "applicationno": "LA-000000001",
            //     "disbursedamount": "500000",
            //     "disbursementdate": "2023-10-23",
            //     "loanapplicationstatus": "Appraisal",
            //     "loanstatus": "Active"
            //     "note":{
            //         "updateComment":""
            //     }
            // }
            CRMLoanApplicationUpdateRecord.Add('loannumber', LoanNumber);
            CRMLoanApplicationUpdateRecord.Add('applicationno', CRMApplicationNumber);
            CRMLoanApplicationUpdateRecord.Add('disbursedamount', DisbursedAmount);
            CRMLoanApplicationUpdateRecord.Add('disbursementdate', DisbursementDate);
            CRMLoanApplicationUpdateRecord.Add('loanapplicationstatus', LoanApplicationStatus);
            CRMLoanApplicationUpdateRecord.Add('loanstatus', '');

            Note.Add('updateComment', UpdateComment);
            CRMLoanApplicationUpdateRecord.Add('note', Note);

            CRMLoanApplicationUpdateRecord.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // Fetch CRM API credentials
            CRMAPISetupTable.FindFirst();

            // Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');
            // Authorization header
            Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + LoginToken);

            IsSuccessful := Client.Post(CRMAPISetupTable."Base URL" + '/loanapplication', Content, Response);

            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // {
                    //     "Status": "SUCCESS",
                    //     "Message": "Loan Application Updated Successfully",
                    //     "RecordId": "6555456"
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    ResponseKeyExists := ResponseParser.Get('Status', ResponseStatus);
                    ResponseKeyExists := ResponseParser.Get('Message', ResponseMessage);


                    if ResponseStatus.AsValue.AsText = 'SUCCESS' then begin
                        // CRM API Update success
                        Message('CRM Loan Application Update SUCCESS. CRM response message: %1', ResponseMessage.AsValue.AsText);
                    end else begin
                        // {
                        //     "Status": "ERROR",
                        //     "Message": "A record that has the attribute values Member Number already exists. The entity key memberno requires that this set of attributes contains unique values. Select unique values and try again.",
                        //     "RecordId": null
                        // }
                        Message('CRM Loan Application Update FAILED. CRM response message: %1', ResponseMessage.AsValue.AsText);
                    end;

                end else begin
                    // Errors - 403, 404, etc
                    CRMAPILogsTable.Init;
                    CRMAPILogsTable."Request URL" := CRMAPISetupTable."Base URL" + '/loanapplication';
                    CRMAPILogsTable."Vendor Name" := VendorName;

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
                    CRMAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    CRMAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    CRMAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    CRMAPILogsTable."Response Headers" := '';
                    CRMAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    CRMAPILogsTable.Miscellaneous := '';
                    CRMAPILogsTable.Insert;

                    Message('CRM Loan Application Update API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                CRMAPILogsTable.Init;
                CRMAPILogsTable."Request URL" := CRMAPISetupTable."Base URL" + '/loanapplication';
                CRMAPILogsTable."Vendor Name" := VendorName;

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
                CRMAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                CRMAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                CRMAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRMAPILogsTable."Response Headers" := '';
                CRMAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                CRMAPILogsTable.Miscellaneous := 'CRM API update has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRMAPILogsTable.Insert;

                Message('CRM Loan Application Update API has failed. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;


        end else begin
            // Error
            // Message('Unable to submit CRM loan application update at the moment. Kindly contact the administrator.');
        end;
    end;

    procedure CRMClaimApplicationUpdate(
        ClaimType: Text; // "BBF Claim","Insurance Claim","Delegate Claim"
        CRMApplicationNumber: Text;
        ApplicationStatus: Text;
        Description: Text;
        BranchName: Text;
        UpdateComment: Text
    )
    var
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        Response: HttpResponseMessage;
        ResponseText: Text;
        HttpStatusCode: Integer;
        CRMApplicationUpdateRecord: JsonObject;
        ClaimantBankInfo: JsonObject;
        Note: JsonObject;
        Payload: Text;

        ResponseParser: JsonObject;
        ResponseKeyExists: Boolean;
        ResponseStatus: JsonToken;
        ResponseMessage: JsonToken;

        CRMAPISetupTable: Record "CRM API Setup";
        CRMAPILogsTable: Record "BC API Logs";

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
        CRMLogin(false);

        // 2. Check login token
        IF LoginToken <> '' then begin
            // 3. Prepare the payload data
            // {
            //     "applicationno":"CM-000000001",
            //     "description":"The process is underway",
            //     "deathcertificate":"",
            //     "branch":"Eldoret",
            //     "applicationstatus":"Approved",
            //     "dateofdeath":"",
            //     "claimtype":"BBF Claim",
            //     "claimantidentification":"",
            //     "deceasedidentification":"",
            //     "claimantbankinfo":{
            //         "bankaccountno":"",
            //         "bankbranch":"",
            //         "bankname":""
            //     },
            //     "note":{
            //         "updateComment":""
            //     }
            // }
            CRMApplicationUpdateRecord.Add('applicationno', CRMApplicationNumber);
            CRMApplicationUpdateRecord.Add('description', Description);
            CRMApplicationUpdateRecord.Add('deathcertificate', '');
            CRMApplicationUpdateRecord.Add('branch', BranchName);
            CRMApplicationUpdateRecord.Add('applicationstatus', ApplicationStatus);
            CRMApplicationUpdateRecord.Add('dateofdeath', '');
            CRMApplicationUpdateRecord.Add('claimtype', ClaimType);
            CRMApplicationUpdateRecord.Add('claimantidentification', '');
            CRMApplicationUpdateRecord.Add('deceasedidentification', '');

            ClaimantBankInfo.Add('bankaccountno', '');
            ClaimantBankInfo.Add('bankbranch', '');
            ClaimantBankInfo.Add('bankname', '');

            CRMApplicationUpdateRecord.Add('claimantbankinfo', ClaimantBankInfo);

            Note.Add('updateComment', UpdateComment);
            CRMApplicationUpdateRecord.Add('note', Note);

            CRMApplicationUpdateRecord.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // Fetch CRM API credentials
            CRMAPISetupTable.FindFirst();

            // Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');
            // Authorization header
            Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + LoginToken);

            IsSuccessful := Client.Post(CRMAPISetupTable."Base URL" + '/claimsapplication', Content, Response);

            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // {
                    //     "Status": "SUCCESS",
                    //     "Message": "Claim Updated Successfully",
                    //     "RecordId": "CM-000000001"
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    ResponseKeyExists := ResponseParser.Get('Status', ResponseStatus);
                    ResponseKeyExists := ResponseParser.Get('Message', ResponseMessage);


                    if ResponseStatus.AsValue.AsText = 'SUCCESS' then begin
                        // CRM API Update success
                        Message('CRM ' + ClaimType + ' Update SUCCESS. CRM response message: %1', ResponseMessage.AsValue.AsText);
                    end else begin
                        // {
                        //     "Status": "ERROR",
                        //     "Message": "A record that has the attribute values Member Number already exists. The entity key memberno requires that this set of attributes contains unique values. Select unique values and try again.",
                        //     "RecordId": null
                        // }
                        Message('CRM ' + ClaimType + ' Update FAILED. CRM response message: %1', ResponseMessage.AsValue.AsText);
                    end;

                end else begin
                    // Errors - 403, 404, etc
                    CRMAPILogsTable.Init;
                    CRMAPILogsTable."Request URL" := CRMAPISetupTable."Base URL" + '/claimsapplication';
                    CRMAPILogsTable."Vendor Name" := VendorName;

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
                    CRMAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    CRMAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    CRMAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    CRMAPILogsTable."Response Headers" := '';
                    CRMAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    CRMAPILogsTable.Miscellaneous := '';
                    CRMAPILogsTable.Insert;

                    Message('CRM ' + ClaimType + ' Update API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                CRMAPILogsTable.Init;
                CRMAPILogsTable."Request URL" := CRMAPISetupTable."Base URL" + '/claimsapplication';
                CRMAPILogsTable."Vendor Name" := VendorName;

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
                CRMAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                CRMAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                CRMAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRMAPILogsTable."Response Headers" := '';
                CRMAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                CRMAPILogsTable.Miscellaneous := 'CRM API update has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRMAPILogsTable.Insert;

                Message('CRM ' + ClaimType + ' Update API has failed. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;


        end else begin
            // Error
            // Message('Unable to submit CRM BBF claims application update at the moment. Kindly contact the administrator.');
        end;
    end;

    procedure CRMVariationRequestUpdate(
        CRMApplicationNumber: Text;
        ApplicationStatus: Text;
        UpdateComment: Text
    )
    var
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        Response: HttpResponseMessage;
        ResponseText: Text;
        HttpStatusCode: Integer;
        CRMLoanApplicationUpdateRecord: JsonObject;
        Note: JsonObject;
        Payload: Text;

        ResponseParser: JsonObject;
        ResponseKeyExists: Boolean;
        ResponseStatus: JsonToken;
        ResponseMessage: JsonToken;

        CRMAPISetupTable: Record "CRM API Setup";
        CRMAPILogsTable: Record "BC API Logs";

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
        CRMLogin(false);

        // 2. Check login token
        IF LoginToken <> '' then begin
            // 3. Prepare the payload data
            // {
            //     "applicationNo":"",
            //     "applicationStatus":"Approved",
            //     "note":{
            //         "updateComment":"update from BC on this member"
            //     }
            // }
            CRMLoanApplicationUpdateRecord.Add('applicationNo', CRMApplicationNumber);
            CRMLoanApplicationUpdateRecord.Add('applicationStatus', ApplicationStatus);

            Note.Add('updateComment', UpdateComment);
            CRMLoanApplicationUpdateRecord.Add('note', Note);

            CRMLoanApplicationUpdateRecord.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // Fetch CRM API credentials
            CRMAPISetupTable.FindFirst();

            // Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');
            // Authorization header
            Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + LoginToken);

            IsSuccessful := Client.Post(CRMAPISetupTable."Base URL" + '/VariationRequest', Content, Response);

            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // {
                    //     "Status": "SUCCESS",
                    //     "Message": "Loan Application Updated Successfully",
                    //     "RecordId": "6555456"
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    ResponseKeyExists := ResponseParser.Get('Status', ResponseStatus);
                    ResponseKeyExists := ResponseParser.Get('Message', ResponseMessage);


                    if ResponseStatus.AsValue.AsText = 'SUCCESS' then begin
                        // CRM API Update success
                        Message('CRM Variation Update API SUCCESS. CRM response message: %1', ResponseMessage.AsValue.AsText);
                    end else begin
                        // {
                        //     "Status": "ERROR",
                        //     "Message": "A record that has the attribute values Member Number already exists. The entity key memberno requires that this set of attributes contains unique values. Select unique values and try again.",
                        //     "RecordId": null
                        // }
                        Message('CRM Variation Update API FAILED. CRM response message: %1', ResponseMessage.AsValue.AsText);
                    end;

                end else begin
                    // Errors - 403, 404, etc
                    CRMAPILogsTable.Init;
                    CRMAPILogsTable."Request URL" := CRMAPISetupTable."Base URL" + '/VariationRequest';
                    CRMAPILogsTable."Vendor Name" := VendorName;

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
                    CRMAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    CRMAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    CRMAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    CRMAPILogsTable."Response Headers" := '';
                    CRMAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    CRMAPILogsTable.Miscellaneous := '';
                    CRMAPILogsTable.Insert;

                    Message('CRM Variation Update API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                CRMAPILogsTable.Init;
                CRMAPILogsTable."Request URL" := CRMAPISetupTable."Base URL" + '/VariationRequest';
                CRMAPILogsTable."Vendor Name" := VendorName;

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
                CRMAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                CRMAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                CRMAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRMAPILogsTable."Response Headers" := '';
                CRMAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                CRMAPILogsTable.Miscellaneous := 'CRM API update has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRMAPILogsTable.Insert;

                Message('CRM Variation Update API has failed. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;


        end else begin
            // Error
            // Message('Unable to submit CRM variation update at the moment. Kindly contact the administrator.');
        end;
    end;

    procedure CRMShareTransferRequestUpdate(
        CRMApplicationNumber: Text;
        ApplicationStatus: Text;
        UpdateComment: Text
    )
    var
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        Response: HttpResponseMessage;
        ResponseText: Text;
        HttpStatusCode: Integer;
        CRMLoanApplicationUpdateRecord: JsonObject;
        Note: JsonObject;
        Payload: Text;

        ResponseParser: JsonObject;
        ResponseKeyExists: Boolean;
        ResponseStatus: JsonToken;
        ResponseMessage: JsonToken;

        CRMAPISetupTable: Record "CRM API Setup";
        CRMAPILogsTable: Record "BC API Logs";

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
        CRMLogin(false);

        // 2. Check login token
        IF LoginToken <> '' then begin
            // 3. Prepare the payload data
            // {
            //     "applicationNo":"",
            //     "applicationStatus":"Approved",
            //     "note":{
            //         "updateComment":"update from BC on this member"
            //     }
            // }
            CRMLoanApplicationUpdateRecord.Add('applicationNo', CRMApplicationNumber);
            CRMLoanApplicationUpdateRecord.Add('applicationStatus', ApplicationStatus);

            Note.Add('updateComment', UpdateComment);
            CRMLoanApplicationUpdateRecord.Add('note', Note);

            CRMLoanApplicationUpdateRecord.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // Fetch CRM API credentials
            CRMAPISetupTable.FindFirst();

            // Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');
            // Authorization header
            Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + LoginToken);

            IsSuccessful := Client.Post(CRMAPISetupTable."Base URL" + '/MemberShares', Content, Response);

            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // {
                    //     "Status": "SUCCESS",
                    //     "Message": "Loan Application Updated Successfully",
                    //     "RecordId": "6555456"
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    ResponseKeyExists := ResponseParser.Get('Status', ResponseStatus);
                    ResponseKeyExists := ResponseParser.Get('Message', ResponseMessage);


                    if ResponseStatus.AsValue.AsText = 'SUCCESS' then begin
                        // CRM API Update success
                        Message('CRM Share Transfer Update SUCCESS. CRM response message: %1', ResponseMessage.AsValue.AsText);
                    end else begin
                        // {
                        //     "Status": "ERROR",
                        //     "Message": "A record that has the attribute values Member Number already exists. The entity key memberno requires that this set of attributes contains unique values. Select unique values and try again.",
                        //     "RecordId": null
                        // }
                        Message('CRM Share Transfer Update FAILED. CRM response message: %1', ResponseMessage.AsValue.AsText);
                    end;

                end else begin
                    // Errors - 403, 404, etc
                    CRMAPILogsTable.Init;
                    CRMAPILogsTable."Request URL" := CRMAPISetupTable."Base URL" + '/MemberShares';
                    CRMAPILogsTable."Vendor Name" := VendorName;

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
                    CRMAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    CRMAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    CRMAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    CRMAPILogsTable."Response Headers" := '';
                    CRMAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    CRMAPILogsTable.Miscellaneous := '';
                    CRMAPILogsTable.Insert;

                    Message('CRM Share Transfer API Update Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                CRMAPILogsTable.Init;
                CRMAPILogsTable."Request URL" := CRMAPISetupTable."Base URL" + '/MemberShares';
                CRMAPILogsTable."Vendor Name" := VendorName;

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
                CRMAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                CRMAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                CRMAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRMAPILogsTable."Response Headers" := '';
                CRMAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                CRMAPILogsTable.Miscellaneous := 'CRM API update has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRMAPILogsTable.Insert;

                Message('CRM Share Transfer API Update has failed. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;


        end else begin
            // Error
            // Message('Unable to submit CRM variation update at the moment. Kindly contact the administrator.');
        end;
    end;

    procedure CRMMemberAccountUpdate(
        CRMApplicationNumber: Text;
        memberNo: Text;
        accountNo: Text;
        balance: Decimal;
        lastTransactionDate: Text;
        accountCategory: Text;
        accountType: Integer;
        ApplicationStatus: Text;
        UpdateComment: Text
    )
    var
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        Response: HttpResponseMessage;
        ResponseText: Text;
        HttpStatusCode: Integer;
        CRMLoanApplicationUpdateRecord: JsonObject;
        Note: JsonObject;
        Payload: Text;

        ResponseParser: JsonObject;
        ResponseKeyExists: Boolean;
        ResponseStatus: JsonToken;
        ResponseMessage: JsonToken;

        CRMAPISetupTable: Record "CRM API Setup";
        CRMAPILogsTable: Record "BC API Logs";

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
        CRMLogin(false);

        // 2. Check login token
        IF LoginToken <> '' then begin
            // 3. Prepare the payload data
            // {
            //     "memberNo": "151962",
            //     "accountNo": "30115196200",
            //     "balance": 0,
            //     "lastTransactionDate": "2024-01-02",
            //     "accountCategory": "FOSA Account",
            //     "accountType": "4",
            //     "applicationNo": "",
            //     "applicationStatus": "New",
            //     "note": {
            //         "updateComment": "update from BC on this member account"
            //     }
            // }
            CRMLoanApplicationUpdateRecord.Add('memberNo', memberNo);
            CRMLoanApplicationUpdateRecord.Add('accountNo', accountNo);
            CRMLoanApplicationUpdateRecord.Add('balance', balance);
            CRMLoanApplicationUpdateRecord.Add('lastTransactionDate', lastTransactionDate);
            CRMLoanApplicationUpdateRecord.Add('accountCategory', accountCategory);
            CRMLoanApplicationUpdateRecord.Add('accountType', Format(accountType));
            CRMLoanApplicationUpdateRecord.Add('applicationNo', CRMApplicationNumber);
            CRMLoanApplicationUpdateRecord.Add('applicationStatus', ApplicationStatus);

            Note.Add('updateComment', UpdateComment);
            CRMLoanApplicationUpdateRecord.Add('note', Note);

            CRMLoanApplicationUpdateRecord.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // Fetch CRM API credentials
            CRMAPISetupTable.FindFirst();

            // Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');
            // Authorization header
            Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + LoginToken);

            IsSuccessful := Client.Post(CRMAPISetupTable."Base URL" + '/MemberAccount', Content, Response);

            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // {
                    //     "Status": "SUCCESS",
                    //     "Message": "Loan Application Updated Successfully",
                    //     "RecordId": "6555456"
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    ResponseKeyExists := ResponseParser.Get('Status', ResponseStatus);
                    ResponseKeyExists := ResponseParser.Get('Message', ResponseMessage);


                    if ResponseStatus.AsValue.AsText = 'SUCCESS' then begin
                        // CRM API Update success
                        Message('CRM Member Account Update SUCCESS. CRM response message: %1', ResponseMessage.AsValue.AsText);
                    end else begin
                        // {
                        //     "Status": "ERROR",
                        //     "Message": "A record that has the attribute values Member Number already exists. The entity key memberno requires that this set of attributes contains unique values. Select unique values and try again.",
                        //     "RecordId": null
                        // }
                        Message('CRM Member Account Update FAILED. CRM response message: %1', ResponseMessage.AsValue.AsText);
                    end;

                end else begin
                    // Errors - 403, 404, etc
                    CRMAPILogsTable.Init;
                    CRMAPILogsTable."Request URL" := CRMAPISetupTable."Base URL" + '/MemberAccount';
                    CRMAPILogsTable."Vendor Name" := VendorName;

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
                    CRMAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    CRMAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    CRMAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    CRMAPILogsTable."Response Headers" := '';
                    CRMAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    CRMAPILogsTable.Miscellaneous := '';
                    CRMAPILogsTable.Insert;

                    Message('CRM Member Account Update API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                CRMAPILogsTable.Init;
                CRMAPILogsTable."Request URL" := CRMAPISetupTable."Base URL" + '/MemberAccount';
                CRMAPILogsTable."Vendor Name" := VendorName;

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
                CRMAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                CRMAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                CRMAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRMAPILogsTable."Response Headers" := '';
                CRMAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                CRMAPILogsTable.Miscellaneous := 'CRM API update has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRMAPILogsTable.Insert;

                Message('CRM Member Account Update API has failed. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;


        end else begin
            // Error
            // Message('Unable to submit CRM member account update at the moment. Kindly contact the administrator.');
        end;
    end;

    procedure CRMMemberEditUpdate(EditMember: Record Members)
    var
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        Response: HttpResponseMessage;
        ResponseText: Text;
        HttpStatusCode: Integer;
        CRMMemberApplicationUpdateRecord: JsonObject;
        Note: JsonObject;
        Payload: Text;

        ResponseParser: JsonObject;
        ResponseKeyExists: Boolean;
        ResponseStatus: JsonToken;
        ResponseMessage: JsonToken;

        CRMAPISetupTable: Record "CRM API Setup";
        CRMAPILogsTable: Record "BC API Logs";

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
        CRMLogin(false);

        // 2. Check login token
        IF LoginToken <> '' then begin
            // 3. Prepare the payload data
            CRMMemberApplicationUpdateRecord.Add('firstname', EditMember."First Name");
            CRMMemberApplicationUpdateRecord.Add('lastname', EditMember."Other Names");
            CRMMemberApplicationUpdateRecord.Add('fullname', EditMember.Name);
            CRMMemberApplicationUpdateRecord.Add('email', EditMember."E-Mail");
            CRMMemberApplicationUpdateRecord.Add('middlename', EditMember."Middle Name");
            CRMMemberApplicationUpdateRecord.Add('address', EditMember."Current Address");
            CRMMemberApplicationUpdateRecord.Add('phoneno', EditMember."Phone No.");
            CRMMemberApplicationUpdateRecord.Add('employercode', EditMember."Employer Code");
            CRMMemberApplicationUpdateRecord.Add('dateofbirth', Format(EditMember."Date of Birth"));
            CRMMemberApplicationUpdateRecord.Add('nationality', EditMember.Nationality);
            CRMMemberApplicationUpdateRecord.Add('payrollstaffno', EditMember."Payroll/Staff No.");
            CRMMemberApplicationUpdateRecord.Add('religion', EditMember.Religion);
            CRMMemberApplicationUpdateRecord.Add('identificationtype', Format(EditMember."Primary Identification Type"));
            CRMMemberApplicationUpdateRecord.Add('identificationno', EditMember."Primary Identification");
            CRMMemberApplicationUpdateRecord.Add('krapinnumber', EditMember."P.I.N Number");
            CRMMemberApplicationUpdateRecord.Add('mobileno', EditMember."Office Telephone No.");
            CRMMemberApplicationUpdateRecord.Add('maritalstatus', Format(EditMember."Marital Status"));
            CRMMemberApplicationUpdateRecord.Add('gender', Format(EditMember.Gender));
            CRMMemberApplicationUpdateRecord.Add('termsofemployment', Format(EditMember."Terms of Employment"));
            CRMMemberApplicationUpdateRecord.Add('postalcode', EditMember."Post Code");
            CRMMemberApplicationUpdateRecord.Add('city', EditMember.City);
            CRMMemberApplicationUpdateRecord.Add('county', EditMember.County);
            CRMMemberApplicationUpdateRecord.Add('membersegment', EditMember."Member Segment");
            CRMMemberApplicationUpdateRecord.Add('typeofbusiness', 0);
            CRMMemberApplicationUpdateRecord.Add('otherbusinesstype', '');
            CRMMemberApplicationUpdateRecord.Add('ownershiptype', 0);
            CRMMemberApplicationUpdateRecord.Add('natureofbusiness', '');
            CRMMemberApplicationUpdateRecord.Add('companyregistrationno', EditMember."Company Registration No.");
            CRMMemberApplicationUpdateRecord.Add('dateofbusinessregistered', Format(EditMember."Registration Date"));
            CRMMemberApplicationUpdateRecord.Add('businessgrouplocation', EditMember."Country Of Operation");
            CRMMemberApplicationUpdateRecord.Add('isgroupaccount', EditMember."Has Joined Business Loans");
            CRMMemberApplicationUpdateRecord.Add('groupaccountno', EditMember."Group Account No.");
            CRMMemberApplicationUpdateRecord.Add('recruitedbytype', EditMember."Recruited by Type".AsInteger());
            CRMMemberApplicationUpdateRecord.Add('recruitedby', EditMember."Recruited By Name");
            CRMMemberApplicationUpdateRecord.Add('relationshipmanager', '');
            CRMMemberApplicationUpdateRecord.Add('accountcategory', Format(EditMember."Account Category"));
            CRMMemberApplicationUpdateRecord.Add('typeofapplication', EditMember."Type of Application".AsInteger());
            CRMMemberApplicationUpdateRecord.Add('accounttype', EditMember."Account Type");
            CRMMemberApplicationUpdateRecord.Add('isselfemployed', EditMember."Self Employed");
            CRMMemberApplicationUpdateRecord.Add('memberclass', EditMember."Member Class");
            CRMMemberApplicationUpdateRecord.Add('crmapplicationno', EditMember."CRM Application No.");
            CRMMemberApplicationUpdateRecord.Add('salutation', EditMember.Salutation);
            CRMMemberApplicationUpdateRecord.Add('pfnumber', EditMember."Payroll/Staff No.");
            CRMMemberApplicationUpdateRecord.Add('accountprofile', Format(EditMember."Account Profile"));
            CRMMemberApplicationUpdateRecord.Add('branch', EditMember."Branch Code");
            CRMMemberApplicationUpdateRecord.Add('memberstatus', Format(EditMember.Status));
            CRMMemberApplicationUpdateRecord.Add('Passportexpirydate', '');
            CRMMemberApplicationUpdateRecord.Add('yearofincorporation', '');
            CRMMemberApplicationUpdateRecord.Add('country', EditMember."Country Of Operation");
            CRMMemberApplicationUpdateRecord.Add('applymobilebanking', true);
            CRMMemberApplicationUpdateRecord.Add('applyatm', true);
            CRMMemberApplicationUpdateRecord.Add('applymwalimuhela', true);
            CRMMemberApplicationUpdateRecord.Add('applymwalimusmart', true);
            CRMMemberApplicationUpdateRecord.Add('memberno', EditMember."No.");
            CRMMemberApplicationUpdateRecord.Add('applicationstatus', Format(EditMember.Status));
            CRMMemberApplicationUpdateRecord.Add('description', '');
            CRMMemberApplicationUpdateRecord.Add('grouptype', EditMember."Account Type");
            CRMMemberApplicationUpdateRecord.Add('secondaryidentificationtype', EditMember."Secondary Identification Type".AsInteger());
            // CRMMemberApplicationUpdateRecord.Add('secondaryidentificationno', EditMember."Secondary Identification");

            Note.Add('updateComment', '');
            CRMMemberApplicationUpdateRecord.Add('note', Note);

            CRMMemberApplicationUpdateRecord.WriteTo(Payload);

            Content.WriteFrom(Payload);

            // Fetch CRM API credentials
            CRMAPISetupTable.FindFirst();

            // Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'application/json');
            if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            ContentHeaders.Add('Content-Encoding', 'UTF8');
            // Authorization header
            Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + LoginToken);

            IsSuccessful := Client.Post(CRMAPISetupTable."Base URL" + '/crmmember', Content, Response);

            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // {
                    //     "Status": "SUCCESS",
                    //     "Message": "Member Updated Successfully",
                    //     "RecordId": "00148"
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    ResponseKeyExists := ResponseParser.Get('Status', ResponseStatus);
                    ResponseKeyExists := ResponseParser.Get('Message', ResponseMessage);


                    if ResponseStatus.AsValue.AsText = 'SUCCESS' then begin
                        // CRM API Update success
                        Message('CRM Member Edit Update API SUCCESS. CRM response message: %1', ResponseMessage.AsValue.AsText);
                    end else begin
                        // {
                        //     "Status": "ERROR",
                        //     "Message": "A record that has the attribute values Member Number already exists. The entity key memberno requires that this set of attributes contains unique values. Select unique values and try again.",
                        //     "RecordId": null
                        // }
                        Message('CRM Member Edit Update API FAILED. CRM response message: %1', ResponseMessage.AsValue.AsText);
                    end;

                end else begin
                    // Errors - 403, 404, etc
                    CRMAPILogsTable.Init;
                    CRMAPILogsTable."Request URL" := CRMAPISetupTable."Base URL" + '/crmmember';
                    CRMAPILogsTable."Vendor Name" := VendorName;

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
                    CRMAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    CRMAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                    CRMAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    CRMAPILogsTable."Response Headers" := '';
                    CRMAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    CRMAPILogsTable.Miscellaneous := '';
                    CRMAPILogsTable.Insert;

                    Message('CRM Member Edit Update API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                CRMAPILogsTable.Init;
                CRMAPILogsTable."Request URL" := CRMAPISetupTable."Base URL" + '/crmmember';
                CRMAPILogsTable."Vendor Name" := VendorName;

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
                CRMAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                CRMAPILogsTable."Request Data" := TrimAndTruncateString(Payload, 2048);
                CRMAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRMAPILogsTable."Response Headers" := '';
                CRMAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                CRMAPILogsTable.Miscellaneous := 'CRM API update has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRMAPILogsTable.Insert;

                Message('CRM Member Edit Update API has failed. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;


        end else begin
            // Error
            // Message('Unable to submit CRM member application update at the moment. Kindly contact the administrator.');
        end;
    end;

    procedure CRMGetCaseDetails(CaseNo: Text) ResponseData: JsonToken
    var
        Client: HttpClient;
        // Content: HttpContent;
        // ContentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        Response: HttpResponseMessage;
        ResponseText: Text;
        HttpStatusCode: Integer;

        ResponseParser: JsonObject;
        ResponseKeyExists: Boolean;
        ResponseStatus: JsonToken;
        ResponseMessage: JsonToken;
        ResponseError: JsonToken;

        CRMAPISetupTable: Record "CRM API Setup";
        CRMAPILogsTable: Record "BC API Logs";

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
        CRMLogin(false);

        // 2. Check login token
        IF LoginToken <> '' then begin
            // Fetch CRM API credentials
            CRMAPISetupTable.FindFirst();

            // Prepare the headers
            // Content.GetHeaders(ContentHeaders);
            // if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            // ContentHeaders.Add('Content-Type', 'application/json');
            // if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            // ContentHeaders.Add('Content-Encoding', 'UTF8');

            // Authorization header
            Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + LoginToken);

            IsSuccessful := Client.Get(CRMAPISetupTable."Base URL" + '/GetCaseDetails?caseno=' + CaseNo, Response);

            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // {
                    //     "StatusCode": 200,
                    //     "Message": "Success",
                    //     "Error": null,
                    //     "ResponseData": {
                    //         "casetitle": "Arrears deducted erroneously.",
                    //         "caseno": "CRMCASE29",
                    //         "membername": "JAMES NYAMAHI MUGANDAH",
                    //         "memberno": "071695",
                    //         "category": "Service Related Complain",
                    //         "subcategory": "Refunds",
                    //         "department": "FINANCE",
                    //         "origin": "WhatsApp",
                    //         "originatingbranch": "UPPERHILL",
                    //         "description": "Erroneous deduction of arrears amounts."
                    //     }
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    ResponseKeyExists := ResponseParser.Get('StatusCode', ResponseStatus);
                    ResponseKeyExists := ResponseParser.Get('Message', ResponseMessage);
                    ResponseKeyExists := ResponseParser.Get('ResponseData', ResponseData);
                    ResponseKeyExists := ResponseParser.Get('Error', ResponseError);


                    if ResponseStatus.AsValue.AsInteger = 200 then begin
                        exit(ResponseData);
                    end else begin
                        // {
                        //     "StatusCode": 400,
                        //     "Message": "ERROR",
                        //     "Error": "Invalid Token",
                        //     "ResponseData": null
                        // }
                        //
                        // {
                        //     "StatusCode": 0,
                        //     "Message": null,
                        //     "Error": null,
                        //     "ResponseData": null
                        // }
                        if ResponseStatus.AsValue.AsInteger = 0 then begin
                            Message('CRM Case with no %1 NOT found', CaseNo);
                        end else begin
                            Message('CRM Get Case API FAILED. CRM response message: %1. %2 - %3',
                                ResponseStatus.AsValue.AsInteger,
                                ResponseError.AsValue.AsText,
                                ResponseMessage.AsValue.AsText);
                        end;
                    end;

                end else begin
                    // Errors - 403, 404, etc
                    CRMAPILogsTable.Init;
                    CRMAPILogsTable."Request URL" := CRMAPISetupTable."Base URL" + '/GetCaseDetails?caseno=' + CaseNo;
                    CRMAPILogsTable."Vendor Name" := VendorName;

                    HeaderText := '';
                    HeaderValuesText := '';
                    // HeaderKeys := ContentHeaders.Keys();
                    for Index := 1 to HeaderKeys.Count do begin
                        HeaderKeys.Get(Index, HeaderKey);
                        // ContentHeaders.GetValues(HeaderKey, HeaderValues);

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
                    CRMAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    CRMAPILogsTable."Request Data" := '';
                    CRMAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    CRMAPILogsTable."Response Headers" := '';
                    CRMAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    CRMAPILogsTable.Miscellaneous := '';
                    CRMAPILogsTable.Insert;

                    Message('CRM Get Case API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                CRMAPILogsTable.Init;
                CRMAPILogsTable."Request URL" := CRMAPISetupTable."Base URL" + '/GetCaseDetails?caseno=' + CaseNo;
                CRMAPILogsTable."Vendor Name" := VendorName;

                HeaderText := '';
                HeaderValuesText := '';
                // HeaderKeys := ContentHeaders.Keys();
                for Index := 1 to HeaderKeys.Count do begin
                    HeaderKeys.Get(Index, HeaderKey);
                    // ContentHeaders.GetValues(HeaderKey, HeaderValues);

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
                CRMAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                CRMAPILogsTable."Request Data" := '';
                CRMAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRMAPILogsTable."Response Headers" := '';
                CRMAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                CRMAPILogsTable.Miscellaneous := 'CRM API update has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRMAPILogsTable.Insert;

                Message('CRM Get Case API has failed. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;


        end else begin
            // Error
            // Message('Unable to submit CRM member application update at the moment. Kindly contact the administrator.');
        end;
    end;

    procedure CRMGetParcelDetails(ParcelNo: Text) ResponseData: JsonToken
    var
        Client: HttpClient;
        // Content: HttpContent;
        // ContentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        Response: HttpResponseMessage;
        ResponseText: Text;
        HttpStatusCode: Integer;

        ResponseParser: JsonObject;
        ResponseKeyExists: Boolean;
        ResponseStatus: JsonToken;
        ResponseMessage: JsonToken;
        ResponseError: JsonToken;

        CRMAPISetupTable: Record "CRM API Setup";
        CRMAPILogsTable: Record "BC API Logs";

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
        CRMLogin(false);

        // 2. Check login token
        IF LoginToken <> '' then begin
            // Fetch CRM API credentials
            CRMAPISetupTable.FindFirst();

            // Prepare the headers
            // Content.GetHeaders(ContentHeaders);
            // if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            // ContentHeaders.Add('Content-Type', 'application/json');
            // if ContentHeaders.Contains('Content-Encoding') then ContentHeaders.Remove('Content-Encoding');
            // ContentHeaders.Add('Content-Encoding', 'UTF8');
            // Authorization header
            Client.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + LoginToken);

            IsSuccessful := Client.Get(CRMAPISetupTable."Base URL" + '/getparceldetails?parcelno=' + ParcelNo, Response);

            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // 200 - OK
                    // {
                    //     "StatusCode": 200,
                    //     "Message": "Success",
                    //     "Error": null,
                    //     "ResponseData": {
                    //         "sourcetype": "Individual",
                    //         "membername": "ESTHER OMBAJO MALO",
                    //         "memberno": "026222",
                    //         "corporatename": null,
                    //         "parceltype": "Payments",
                    //         "datereceived": "2024-03-20T05:00:00Z",
                    //         "description": "TGH",
                    //         "receivedby": "MNS CE Test User 2",
                    //         "followupdepartment": "CUSTOMER CARE",
                    //         "parcelno": "CRMPR1"
                    //     }
                    // }
                    ResponseParser.ReadFrom(ResponseText);
                    ResponseKeyExists := ResponseParser.Get('StatusCode', ResponseStatus);
                    ResponseKeyExists := ResponseParser.Get('Message', ResponseMessage);
                    ResponseKeyExists := ResponseParser.Get('ResponseData', ResponseData);
                    ResponseKeyExists := ResponseParser.Get('Error', ResponseError);

                    if ResponseStatus.AsValue.AsInteger = 200 then begin
                        exit(ResponseData);
                    end else begin
                        // {
                        //     "StatusCode": 400,
                        //     "Message": "ERROR",
                        //     "Error": "Invalid Token",
                        //     "ResponseData": null
                        // }
                        //
                        // {
                        //     "StatusCode": 0,
                        //     "Message": null,
                        //     "Error": null,
                        //     "ResponseData": null
                        // }
                        if ResponseStatus.AsValue.AsInteger = 0 then begin
                            Message('CRM Parcel with no %1 NOT found', ParcelNo);
                        end else begin
                            Message('CRM Get Parcel API FAILED. CRM response message: %1. %2 - %3',
                                ResponseStatus.AsValue.AsInteger,
                                ResponseError.AsValue.AsText,
                                ResponseMessage.AsValue.AsText);
                        end;
                    end;

                end else begin
                    // Errors - 403, 404, etc
                    CRMAPILogsTable.Init;
                    CRMAPILogsTable."Request URL" := CRMAPISetupTable."Base URL" + '/getparceldetails?parcelno=' + ParcelNo;
                    CRMAPILogsTable."Vendor Name" := VendorName;

                    HeaderText := '';
                    HeaderValuesText := '';
                    // HeaderKeys := ContentHeaders.Keys();
                    for Index := 1 to HeaderKeys.Count do begin
                        HeaderKeys.Get(Index, HeaderKey);
                        // ContentHeaders.GetValues(HeaderKey, HeaderValues);

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
                    CRMAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                    CRMAPILogsTable."Request Data" := '';
                    CRMAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                    CRMAPILogsTable."Response Headers" := '';
                    CRMAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                    CRMAPILogsTable.Miscellaneous := '';
                    CRMAPILogsTable.Insert;

                    Message('CRM Get Parcel API Status. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                end;
            end else begin
                CRMAPILogsTable.Init;
                CRMAPILogsTable."Request URL" := CRMAPISetupTable."Base URL" + '/getparceldetails?parcelno=' + ParcelNo;
                CRMAPILogsTable."Vendor Name" := VendorName;

                HeaderText := '';
                HeaderValuesText := '';
                // HeaderKeys := ContentHeaders.Keys();
                for Index := 1 to HeaderKeys.Count do begin
                    HeaderKeys.Get(Index, HeaderKey);
                    // ContentHeaders.GetValues(HeaderKey, HeaderValues);

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
                CRMAPILogsTable."Request Headers" := TrimAndTruncateString(HeaderText.Trim, 2048);

                CRMAPILogsTable."Request Data" := '';
                CRMAPILogsTable."Response Status Code" := FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRMAPILogsTable."Response Headers" := '';
                CRMAPILogsTable."Response Data" := TrimAndTruncateString(ResponseText, 2048);
                CRMAPILogsTable.Miscellaneous := 'CRM API update has failed. ' + FORMAT(Response.HttpStatusCode) + ' - ' + Response.ReasonPhrase;
                CRMAPILogsTable.Insert;

                Message('CRM Get Parcel API has failed. %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
            end;
        end else begin
            // Error
            // Message('Unable to submit CRM member application update at the moment. Kindly contact the administrator.');
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
        VendorName: Label 'Sky World';

}