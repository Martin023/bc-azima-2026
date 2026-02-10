codeunit 52186599 "Base API"
{
    procedure HandleRequest(Request: Text): Text
    var
        RequestParser: JsonObject;
        RequestAction: JsonToken;
        RequestPayload: JsonToken;
    begin
        // Request variable
        // {
        //     "action": "GET_MEMBER_DETAILS",
        //     "payload": {
        //         "api_request_id": "df3e7cf5-1e4b-41ef-a22f-e755be665432",
        //         "identifier_type": "MSISDN",
        //         "identifier": "254712345678",
        //         "password": "5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8"
        //     }
        // }
        RequestParser.ReadFrom(Request);
        RequestParser.SelectToken('$.action', RequestAction);
        RequestParser.SelectToken('$.payload', RequestPayload);

        // API actions here
        case RequestAction.AsValue().AsText() of
            'GET_MEMBER_DETAILS':
                exit(GetMemberDetails(RequestPayload.AsObject));
            'GET_USERS':
                exit(GetUsers(RequestPayload.AsObject));
            else
                exit(UnsupportedAction(RequestAction.AsValue.AsText))
        end;
    end;

    local procedure GetMemberDetails(Payload: JsonObject): Text
    var
        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Response: Text;
    begin
        // Payload
        //
        // {
        //     "api_request_id": "df3e7cf5-1e4b-41ef-a22f-e755be665432",
        //     "identifier_type": "MSISDN",
        //     "identifier": "254712345678",
        //     "password": "5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8"
        // }

        // Process payload here...

        // SUCCESS Response
        //
        // {
        //     "status": "SUCCESS",
        //     "status_description": "Member Details Fetched Successfully",
        //     "data": {
        //         "name": "Carlton Moseti",
        //         "address": "Westlands Nairobi"
        //     }
        // }

        // ERROR Response
        // 
        // {
        //     "status": "ERROR",
        //     "status_description": "Error message...",
        //     "errors": []
        // }

        ResponseData.Add('name', 'Carlton Moseti');
        ResponseData.Add('address', 'Westlands Nairobi');

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('status_description', 'Member Details Fetched Successfully');
        ResponseObject.Add('data', ResponseData);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetUsers(Payload: JsonObject): Text
    var
        page: JsonToken;
        page_size: JsonToken;

        Offset: Integer;
        Counter: Integer;

        Users: record User;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        // Payload variable
        //
        // {
        //     "page": 1,
        //     "page_size": 25
        // }

        // Process payload here...
        if not Payload.SelectToken('page', page) then begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('description', 'Page number value is missing in the request');
            // ResponseObject.Add('data', Data);
            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;

        if not Payload.SelectToken('page_size', page_size) then begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('description', 'Page size value is missing in the request');
            // ResponseObject.Add('data', Data);
            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;

        // Pagination
        Users.Reset;

        if Users.FindSet then begin
            Offset := (page.AsValue.AsInteger - 1) * page_size.AsValue.AsInteger;
            Users.Next(Offset); // Skip records
            Counter := 0;

            repeat begin
                Clear(Datum);

                Datum.Add('username', Users."User Name");
                Datum.Add('full_names', Users."Full Name");

                Data.Add(Datum);
                Counter += 1;
            end until (Users.Next = 0) or (Counter = page_size.AsValue.AsInteger);
        end;


        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure UnsupportedAction(RequestAction: Text): Text
    var
        ResponseObject: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        ResponseObject.Add('status', 'ERROR');
        ResponseObject.Add('description', 'The requested action ' + RequestAction + ' is NOT supported.');
        ResponseObject.Add('errors', Errors);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure AddDateTimeToResponse(var ResponseObject: JsonObject)
    begin
        ResponseObject.Add('date_time', FORMAT(CurrentDateTime, 0, '<Day,2>-<Month,2>-<Year> <Hours24,2>:<Minutes,2>:<Seconds,2>'));
    end;
}