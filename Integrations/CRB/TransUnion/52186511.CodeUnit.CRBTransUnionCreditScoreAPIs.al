codeunit 52186511 "CRB TransUnion CreditScore API"
{
    procedure GetServerInfo(ShowSuccessMessage: Boolean)
    var
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        Response: HttpResponseMessage;
        ResponseText: Text;
        HttpStatusCode: Integer;
        Payload: Text;
        CRBTransUnionTable: Record "CRB Trans Union API Setup";
        CRBTransUnionLogsTable: Record "BC API Logs";

        Authorization: Text;
        Base64Convert: Codeunit "Base64 Convert";
        SoapResponseXML: XmlDocument;
        SoapRoot: XmlElement;
        XPathText: Text;
        SoapNode: XmlNode;
        SoapNSMgr: XmlNamespaceManager;

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
        IF CRBTransUnionTable.FindFirst() then begin
            IF CRBTransUnionTable.Status = CRBTransUnionTable.Status::Inactive then begin
                Message('CRB Transunion API status: %1', Format(CRBTransUnionTable.Status));
                exit;
            end;

            // 2. Prepare the payload data
            // <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.crbws.transunion.ke.co/">
            //     <soapenv:Header/>
            //     <soapenv:Body>
            //         <ws:getServerInfo>
            //             <!--Optional:-->
            //             <username></username>
            //             <!--Optional:-->
            //             <password></password>
            //             <!--Optional:-->
            //             <code></code>
            //             <!--Optional:-->
            //             <infinityCode></infinityCode>
            //         </ws:getServerInfo>
            //     </soapenv:Body>
            // </soapenv:Envelope>
            Payload :=
            '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="' + CRBTransUnionTable."WS - XML NS" + '">' +
            '    <soapenv:Header/>' +
            '    <soapenv:Body>' +
            '        <ws:getServerInfo>' +
            '            <username>' + CRBTransUnionTable."WS - Username" + '</username>' +
            '            <password>' + CRBTransUnionTable."WS - Password" + '</password>' +
            '            <code>' + CRBTransUnionTable."WS - Code" + '</code>' +
            '            <infinityCode>' + CRBTransUnionTable."WS - Infinity Code" + '</infinityCode>' +
            '        </ws:getServerInfo>' +
            '    </soapenv:Body>' +
            '</soapenv:Envelope>'
            ;

            Content.WriteFrom(Payload);

            // 3. Prepare the headers
            Content.GetHeaders(ContentHeaders);
            if ContentHeaders.Contains('SOAPAction') then ContentHeaders.Remove('SOAPAction');
            ContentHeaders.Add('SOAPAction', '');
            if ContentHeaders.Contains('Content-Type') then ContentHeaders.Remove('Content-Type');
            ContentHeaders.Add('Content-Type', 'text/xml');

            Authorization := CRBTransUnionTable."WS - Basic Username" + ':' + CRBTransUnionTable."WS - Basic Password";
            Authorization := Base64Convert.ToBase64(Authorization);

            Client.DefaultRequestHeaders.Add('Authorization', 'Basic ' + Authorization);

            IsSuccessful := Client.Post(CRBTransUnionTable."WS - URL", Content, Response);
            IF IsSuccessful then begin
                Response.Content.ReadAs(ResponseText);
                if Response.IsSuccessStatusCode then begin
                    // <S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
                    //     <SOAP-ENV:Header/>
                    //     <S:Body>
                    //         <ns2:getServerInfoResponse xmlns:ns2="http://ws.crbws.transunion.ke.co/">
                    //             <return>
                    //                 <country>Kenya</country>
                    //                 <protocol>SOAP</protocol>
                    //                 <responseCode>100</responseCode>
                    //                 <version>1.3</version>
                    //             </return>
                    //         </ns2:getServerInfoResponse>
                    //     </S:Body>
                    // </S:Envelope>

                    IF ShowSuccessMessage then begin
                        Message('CRB Trans Union API status : %1 - %2', Response.HttpStatusCode, Response.ReasonPhrase);
                        Message(ResponseText);
                    end;

                    if XmlDocument.ReadFrom(ResponseText, SoapResponseXML) then begin
                        SoapNSMgr.NameTable(SoapResponseXML.NameTable);
                        SoapNSMgr.AddNamespace('S', 'http://schemas.xmlsoap.org/soap/envelope/');
                        SoapNSMgr.AddNamespace('ns2', CRBTransUnionTable."WS - XML NS");

                        if SoapResponseXML.GetRoot(SoapRoot) then begin
                            XPathText := '//S:Envelope/S:Body/ns2:getServerInfoResponse/return/version';
                            if SoapRoot.SelectSingleNode(XPathText, SoapNSMgr, SoapNode) then begin
                                Message('Version = %1', SoapNode.AsXmlElement.InnerText);
                            end;
                        end;
                    end;
                end else begin
                    // Errors - 403, 404, etc
                    CRBTransUnionLogsTable.Init;
                    CRBTransUnionLogsTable."Request URL" := CRBTransUnionTable."WS - URL";
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
                CRBTransUnionLogsTable."Request URL" := CRBTransUnionTable."WS - URL";
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
}
