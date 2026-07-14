codeunit 52186505 "BC Portal"
{
    procedure HandleRequest(Request: Text): Text
    var
        RequestParser: JsonObject;
        RequestAction: JsonToken;
        RequestAPIId: JsonToken;
        RequestPayload: JsonToken;

        KeyExists: Boolean;
    begin
        RequestParser.ReadFrom(Request);
        RequestParser.SelectToken('$.action', RequestAction);
        RequestParser.SelectToken('$.api_request_id', RequestAPIId);
        KeyExists := RequestParser.SelectToken('$.payload', RequestPayload);

        // API actions here
        case RequestAction.AsValue().AsText() of
            'CHECK_USER_LOGIN':
                exit(CheckUserLogin(RequestPayload.AsObject, RequestAPIId));
            'GET_EMPLOYEES':
                exit(GetEmployees());
            'GET_EMPLOYEE':
                exit(GetEmployee(RequestPayload.AsObject, RequestAPIId));
            'SEARCH_EMPLOYEE':
                exit(GetEmployee(RequestPayload.AsObject, RequestAPIId));
            'TRIGGER_GENERATE_DAILY_INTEREST':
                exit(GenerateDailyInterest(RequestPayload.AsObject, RequestAPIId));
            'TRIGGER_CRB_SUBMISSION_METROPOL':
                exit(TriggerCRBSubmissionMetropol(RequestPayload.AsObject, RequestAPIId));
            else
                exit(UnsupportedAction(RequestAction.AsValue.AsText))
        end;
    end;

    local procedure CheckUserLogin(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        staff_number: JsonToken;

        HRLeaveApp: Record "HR Leave Application";
        HRStaff: Record "HR Employees";
        ActiveSession: Record "Active Session";
        UserSetup: Record "User Setup";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('staff_number', staff_number);

        HRStaff.Reset;
        HRStaff.SetRange("No.", staff_number.AsValue.AsText);
        if HRStaff.FindFirst then begin
            //Staff Not Active
            if HRStaff.Status <> HRStaff.Status::Active then begin
                ResponseObject.Add('request_status', 'SUCCESS');
                Datum.Add('can_login', false);
                Datum.Add('reason', 'The staff is not active. Current status is ' + format(HRStaff.Status));

                ResponseObject.Add('response_payload', Datum);
                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);

                exit(Response);
            end;

            HRLeaveApp.Reset;
            HRLeaveApp.SetRange(HRLeaveApp."Applicant Staff No.", HRStaff."No.");
            HRLeaveApp.SetRange(HRLeaveApp.Status, HRLeaveApp.Status::Approved);
            //check for leave overlap
            if HRLeaveApp.Find('-') then begin
                REPEAT
                    IF (today > HRLeaveApp."Start Date") and (today < HRLeaveApp."Return Date") and (not IsEmployeeRecalledToday(HRLeaveApp)) THEN begin
                        // ERROR('The staff is on leave. Return Date is %1!', HRLeaveApp."Return Date");
                        ResponseObject.Add('request_status', 'SUCCESS');
                        Datum.Add('can_login', false);
                        Datum.Add('reason', 'The staff is on leave. Return Date is ' + GlobalFunctions.FormatISODate(HRLeaveApp."Return Date"));

                        ResponseObject.Add('response_payload', Datum);
                        AddDateTimeToResponse(ResponseObject);

                        ResponseObject.WriteTo(Response);

                        exit(Response);
                    end;
                UNTIL HRLeaveApp.NEXT = 0;
            end;

            //Restrict double login of users
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", HRStaff."User ID");
            IF UserSetup.FIND('-') THEN BEGIN
                ActiveSession.reset;
                ActiveSession.SETRANGE("User ID", HRStaff."User ID");
                ActiveSession.SETRANGE("Client Type", ActiveSession."Client Type"::"Web Client");
                IF ActiveSession.COUNT > UserSetup."No. Active Session" THEN BEGIN
                    ResponseObject.Add('request_status', 'SUCCESS');
                    Datum.Add('can_login', false);
                    Datum.Add('reason', 'You are already logged in ' + Format(ActiveSession.COUNT) + ' times in other Machine(s).');

                    ResponseObject.Add('response_payload', Datum);
                    AddDateTimeToResponse(ResponseObject);

                    ResponseObject.WriteTo(Response);

                    exit(Response);
                end;
            END else begin
                ResponseObject.Add('request_status', 'SUCCESS');
                Datum.Add('can_login', false);
                Datum.Add('reason', 'You have not been set as a valid user.');
                ResponseObject.Add('response_payload', Datum);
                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);

                exit(Response);
            end;

            // Session Cleanup - Multiple Tabs issue
            ActiveSession.reset;
            ActiveSession.SETRANGE("User ID", HRStaff."User ID");
            ActiveSession.DeleteAll;
            Commit;

            ResponseObject.Add('request_status', 'SUCCESS');
            Datum.Add('can_login', true);
            Datum.Add('reason', 'Login is permitted');
        end else begin
            ResponseObject.Add('request_status', 'NOT_FOUND');
            Datum.Add('can_login', false);
            Datum.Add('error_message', 'User with identification ' + staff_number.AsValue.AsText + ' NOT found!');
        end;

        ResponseObject.Add('response_payload', Datum);
        AddDateTimeToResponse(ResponseObject);
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure IsEmployeeRecalledToday(HRLeaveApp: Record "HR Leave Application"): Boolean
    var
        RecallLine: Record "HR Leave Recall Lines";
    begin
        RecallLine.Reset;
        RecallLine.SetRange("Leave Application Code", HRLeaveApp."Application Code");
        RecallLine.SetRange(Posted, true);
        if RecallLine.FindSet then
            repeat
                if (Today >= RecallLine."Recall Date") and (Today <= RecallLine.CalculateRecallEndDate(RecallLine."Recall Date", RecallLine."Days Recalled", HRLeaveApp)) then
                    exit(true);
            until RecallLine.Next = 0;

        exit(false);
    end;

    local procedure GetEmployees(): Text
    var
        HREmployees: Record "HR Employees";

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        HREmployees.Reset;

        HREmployees.SetRange(Status, HREmployees.Status::Active);

        IF HREmployees.FindSet then begin
            repeat begin
                Datum.Add('employee_no', HREmployees."No.");
                Datum.Add('name', HREmployees."Full Name");
                Datum.Add('staff_number', HREmployees."No.");
                Datum.Add('gender', Format(HREmployees.Gender));
                Datum.Add('user_id', HREmployees."User ID");
                Datum.Add('status', Format(HREmployees.Status));

                Data.Add(Datum);

                // Reset
                Datum.ReadFrom('{}');
            end until HREmployees.Next = 0;
        end;

        ResponseObject.Add('request_status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('response_payload', Data);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetEmployee(Payload: JsonObject; APIRequestID: JsonToken): Text
    var
        identifier_type: JsonToken;
        identifier: JsonToken;

        HRStaff: Record "HR Employees";

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Response: Text;
    begin
        Payload.Get('identifier_type', identifier_type);
        Payload.Get('identifier', identifier);

        HRStaff.Reset;

        case identifier_type.AsValue.AsText of //"EMPLOYEE_NO/STAFF_NO"
            'EMPLOYEE_NO', 'STAFF_NO':
                HRStaff.SetRange("No.", identifier.AsValue.AsText);
            else
                HRStaff.SetRange("No.", identifier.AsValue.AsText);
        end;

        if HRStaff.FindFirst then begin
            Datum.Add('employee_no', HRStaff."No.");
            Datum.Add('name', HRStaff."Full Name");
            Datum.Add('staff_number', HRStaff."No.");
            Datum.Add('gender', Format(HRStaff.Gender));
            Datum.Add('user_id', HRStaff."User ID");
            Datum.Add('status', Format(HRStaff.Status));

            ResponseObject.Add('request_status', 'SUCCESS');
        end else begin
            ResponseObject.Add('request_status', 'NOT_FOUND');
            Datum.Add('error_message', 'Staff with identification ' + identifier_type.AsValue.AsText + ' = ' + identifier.AsValue.AsText + ' NOT found!');
        end;

        ResponseObject.Add('response_payload', Datum);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GenerateDailyInterest(Payload: JsonObject; APIRequestID: JsonToken): Text;
    var
        LoansProcess: Codeunit "Loans Process";

        run_date: JsonToken;
        TheRunDate: Date;
    begin
        Payload.Get('run_date', run_date);

        Evaluate(TheRunDate, run_date.AsValue.AsText);

        LoansProcess.ComputeDaillyLoanInterestSVCs(TheRunDate);

        exit('OK');
    end;

    local procedure TriggerCRBSubmissionMetropol(Payload: JsonObject; APIRequestID: JsonToken): Text;
    var
        CRBMetropol: Codeunit "CRB Metropol API";
        JQEntry: Record "Job Queue Entry";

        run_date: JsonToken;
        TheRunDate: Date;
    begin
        // Payload.Get('run_date', run_date);

        CRBMetropol.Run(JQEntry);

        exit('OK');
    end;

    // ------------------------------------------------------------------------------------------------------------------------------------------------------------

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
        ResponseObject.Add('date_time', GlobalFunctions.FormatISODateTime(CurrentDateTime));
    end;

    var
        VendorName: Label 'BC Portal - Sky World Limited';
        GlobalFunctions: Codeunit "Global Functions";
}