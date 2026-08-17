codeunit 52185460 "HR SMS Dispatcher"
{
    procedure Send(
        EventCode: Code[50];
        RecipientRole: Option;
        RecipientEmployeeNo: Code[20];
        SourceDocNo: Code[50];
        TokenVals: Text
    )
    var
        Template: Record "HR SMS Template";
        HREmp: Record "HR Employees";
        PhoneNo: Text[20];
    begin
        if not Template.Get(EventCode, RecipientRole) then
            exit;

        if not Template.Enabled then
            exit;

        PhoneNo := '';
        if RecipientEmployeeNo <> '' then
            if HREmp.Get(RecipientEmployeeNo) then begin
                PhoneNo := HREmp."Cell Phone Number";
                if PhoneNo = '' then
                    PhoneNo := HREmp."Cellular Phone Number";
                if PhoneNo = '' then
                    PhoneNo := HREmp."Work Phone Number";
                if PhoneNo = '' then
                    PhoneNo := HREmp."Home Phone Number";
            end;

        if PhoneNo = '' then begin
            LogEntry(EventCode, RecipientRole, '', SourceDocNo, '', TokenVals, 1,
                'NO PHONE NUMBER FOUND ON EMPLOYEE ' + RecipientEmployeeNo +
                '. SET Cell Phone Number, Cellular Phone Number, Work Phone Number OR Home Phone Number ON THE EMPLOYEE CARD.',
                0, false, false, false);
            exit;
        end;

        ExecuteSend(Template, PhoneNo, SourceDocNo, TokenVals, EventCode, RecipientRole, 0, false, false);
    end;

    procedure Retry(LogEntryNo: Integer)
    var
        LogEntry2: Record "HR SMS Notification Log";
        Template: Record "HR SMS Template";
    begin
        if not LogEntry2.Get(LogEntryNo) then
            Error('LOG ENTRY %1 NOT FOUND.', LogEntryNo);

        if not (LogEntry2.Status in [LogEntry2.Status::Failed, LogEntry2.Status::"Retry Failed"]) then
            Error('THIS ENTRY DID NOT FAIL. USE RESEND FOR ENTRIES THAT WERE SENT SUCCESSFULLY.');

        if not Template.Get(LogEntry2."Event Code", LogEntry2."Recipient Role") then
            Error('TEMPLATE NOT FOUND FOR EVENT "%1" / ROLE "%2". VERIFY THE TEMPLATE EXISTS.',
                LogEntry2."Event Code", LogEntry2."Recipient Role");

        if not Template.Enabled then
            Error('TEMPLATE IS DISABLED. ENABLE THE TEMPLATE BEFORE RETRYING.');

        if LogEntry2."Token Values" = '' then
            Error('THIS ENTRY HAS NO STORED TOKEN VALUES — IT WAS CREATED BEFORE TOKEN STORAGE WAS INTRODUCED. USE RESEND INSTEAD, WHICH WILL SEND THE CURRENT TEMPLATE BODY AS-IS.');

        ExecuteSend(Template, LogEntry2."Sent To", LogEntry2."Source Document No.",
            LogEntry2."Token Values", LogEntry2."Event Code", LogEntry2."Recipient Role",
            LogEntryNo, true, false);

        LogEntry2."Retry Count" += 1;
        LogEntry2."Last Retry DateTime" := CurrentDateTime;
        LogEntry2.Modify();
    end;

    procedure Resend(LogEntryNo: Integer)
    var
        LogEntry2: Record "HR SMS Notification Log";
        Template: Record "HR SMS Template";
    begin
        if not LogEntry2.Get(LogEntryNo) then
            Error('LOG ENTRY %1 NOT FOUND.', LogEntryNo);

        if not Template.Get(LogEntry2."Event Code", LogEntry2."Recipient Role") then
            Error('TEMPLATE NOT FOUND FOR EVENT "%1" / ROLE "%2". VERIFY THE TEMPLATE EXISTS.',
                LogEntry2."Event Code", LogEntry2."Recipient Role");

        if not Template.Enabled then
            if not Confirm('TEMPLATE IS DISABLED. RESEND ANYWAY?', false) then
                exit;

        if not Confirm('RESEND THIS SMS TO %1?', true, LogEntry2."Sent To") then
            exit;

        ExecuteSend(Template, LogEntry2."Sent To", LogEntry2."Source Document No.",
            LogEntry2."Token Values", LogEntry2."Event Code", LogEntry2."Recipient Role",
            LogEntryNo, false, true);

        LogEntry2."Last Retry DateTime" := CurrentDateTime;
        LogEntry2.Modify();
    end;

    local procedure ExecuteSend(
        Template: Record "HR SMS Template";
        PhoneNo: Text[20];
        SourceDocNo: Code[50];
        TokenVals: Text;
        EventCode: Code[50];
        RecipientRole: Option;
        ParentEntryNo: Integer;
        IsRetry: Boolean;
        IsResend: Boolean
    )
    var
        SmsCU: Codeunit SendSms;
        ResolvedBody: Text;
        SuccessStatus: Option;
        FailStatus: Option;
    begin
        ResolvedBody := ResolveTokens(Template.Body, EventCode, TokenVals);

        if IsRetry then begin
            SuccessStatus := 2; // Retry Succeeded
            FailStatus := 3;    // Retry Failed
        end else if IsResend then begin
            SuccessStatus := 4; // Resent
            FailStatus := 1;    // Failed
        end else begin
            SuccessStatus := 0; // Sent
            FailStatus := 1;    // Failed
        end;

        SmsCU.SendSms(
            Template."SMS Source",
            PhoneNo,
            ResolvedBody,
            SourceDocNo,
            '',
            false,
            0,
            false,
            'HR',
            SourceDocNo,
            'HR_MODULE'
        );

        // SENDMSS DOES NOT RETURN A BOOLEAN — LOG AS SENT SINCE IT WRITES TO THE QUEUE
        LogEntry(EventCode, RecipientRole, PhoneNo, SourceDocNo, ResolvedBody,
            TokenVals, SuccessStatus, '', ParentEntryNo, IsRetry, IsResend, false);
        
        // PROCESS CC RECIPIENTS IF ENABLED
        if Template."Send to CC" and (Template."CC Phone Numbers" <> '') and not IsRetry and not IsResend then
            SendToCC(Template, SourceDocNo, TokenVals, EventCode, RecipientRole);
    end;

    local procedure SendToCC(
        Template: Record "HR SMS Template";
        SourceDocNo: Code[50];
        TokenVals: Text;
        EventCode: Code[50];
        RecipientRole: Option
    )
    var
        SmsCU: Codeunit SendSms;
        CCPhones: List of [Text];
        CCPhone: Text;
        NormalizedPhone: Text[20];
        CCBody: Text;
    begin
        // PARSE COMMA-SEPARATED PHONE NUMBERS
        CCPhones := Template."CC Phone Numbers".Split(',');
        
        // DETERMINE CC BODY: USE CC BODY IF CONFIGURED, OTHERWISE USE MAIN BODY
        if Template."CC Body" <> '' then
            CCBody := ResolveTokens(Template."CC Body", EventCode, TokenVals)
        else
            CCBody := ResolveTokens(Template.Body, EventCode, TokenVals);
        
        // SEND TO EACH CC RECIPIENT
        foreach CCPhone in CCPhones do begin
            CCPhone := DelChr(CCPhone, '=', ' '); // TRIM SPACES
            
            if CCPhone <> '' then begin
                NormalizedPhone := ValidateAndNormalizePhone(CCPhone);
                
                if NormalizedPhone <> '' then begin
                    // VALID PHONE - SEND SMS
                    SmsCU.SendSms(
                        Template."SMS Source",
                        NormalizedPhone,
                        CCBody,
                        SourceDocNo,
                        '',
                        false,
                        0,
                        false,
                        'HR',
                        SourceDocNo,
                        'HR_MODULE'
                    );
                    
                    // LOG AS SENT WITH CC FLAG
                    LogEntry(EventCode, RecipientRole, NormalizedPhone, SourceDocNo, CCBody,
                        TokenVals, 0, '', 0, false, false, true);
                end else begin
                    // INVALID PHONE FORMAT - LOG AS FAILED
                    LogEntry(EventCode, RecipientRole, CCPhone, SourceDocNo, '',
                        TokenVals, 1, 'INVALID PHONE FORMAT: ' + CCPhone, 0, false, false, true);
                end;
            end;
        end;
    end;

    local procedure ValidateAndNormalizePhone(Phone: Text[20]): Text[20]
    var
        CleanPhone: Text[20];
        PhoneLen: Integer;
    begin
        // REMOVE NON-NUMERIC CHARACTERS (EXCEPT + AT START)
        CleanPhone := DelChr(Phone, '=', ' -()');
        
        // REMOVE + IF PRESENT
        if (StrLen(CleanPhone) > 0) and (CopyStr(CleanPhone, 1, 1) = '+') then
            CleanPhone := CopyStr(CleanPhone, 2);
        
        PhoneLen := StrLen(CleanPhone);
        
        // VALIDATE AND NORMALIZE TO 254XXXXXXXXX FORMAT
        if PhoneLen = 12 then begin
            // ALREADY 254XXXXXXXXX
            if CopyStr(CleanPhone, 1, 3) = '254' then
                exit(CleanPhone);
        end else if PhoneLen = 10 then begin
            // 0XXXXXXXXX -> 254XXXXXXXXX
            if CopyStr(CleanPhone, 1, 1) = '0' then
                exit('254' + CopyStr(CleanPhone, 2, 9));
        end else if PhoneLen = 9 then begin
            // XXXXXXXXX -> 254XXXXXXXXX (ASSUMING STARTS WITH 7)
            if CopyStr(CleanPhone, 1, 1) = '7' then
                exit('254' + CleanPhone);
        end;
        
        // INVALID FORMAT
        exit('');
    end;

    local procedure ResolveTokens(RawBody: Text; EventCode: Code[50]; TokenVals: Text): Text
    var
        Resolved: Text;
        Vars: Record "HR SMS Template Variables";
        TokenValue: Text;
    begin
        Resolved := RawBody;

        Vars.Reset();
        Vars.SetRange("Event Code", EventCode);
        Vars.SetRange("System Defined", true);
        if not Vars.FindSet() then
            exit(Resolved);

        repeat
            TokenValue := GetTokenValue(TokenVals, Vars.Token);
            if TokenValue <> '' then
                Resolved := Resolved.Replace(Format(Vars.Token), TokenValue);
        until Vars.Next() = 0;

        exit(Resolved);
    end;

    local procedure GetTokenValue(TokenVals: Text; Token: Code[50]): Text
    var
        Pairs: List of [Text];
        Pair: Text;
        KeyName: Text;
        EqPos: Integer;
        PairKey: Text;
        PairVal: Text;
    begin
        if TokenVals = '' then
            exit('');

        KeyName := Token;
        KeyName := KeyName.Replace('[', '');
        KeyName := KeyName.Replace(']', '');

        Pairs := TokenVals.Split('||');
        foreach Pair in Pairs do begin
            EqPos := StrPos(Pair, '=');
            if EqPos > 0 then begin
                PairKey := CopyStr(Pair, 1, EqPos - 1);
                PairVal := CopyStr(Pair, EqPos + 1);
                if UpperCase(PairKey) = UpperCase(KeyName) then
                    exit(PairVal);
            end;
        end;

        exit('');
    end;

    local procedure LogEntry(
        EventCode: Code[50];
        RecipientRole: Option;
        SentTo: Text;
        SourceDocNo: Code[50];
        MessageSent: Text;
        TokenVals: Text;
        StatusOpt: Option;
        ErrorText: Text;
        ParentEntryNo: Integer;
        IsRetry: Boolean;
        IsResend: Boolean;
        IsCC: Boolean
    )
    var
        Log: Record "HR SMS Notification Log";
    begin
        Log.Init();
        Log."Event Code" := EventCode;
        Log."Recipient Role" := RecipientRole;
        Log."Sent To" := CopyStr(SentTo, 1, MaxStrLen(Log."Sent To"));
        Log."Source Document No." := CopyStr(SourceDocNo, 1, MaxStrLen(Log."Source Document No."));
        Log."Message Sent" := CopyStr(MessageSent, 1, MaxStrLen(Log."Message Sent"));
        Log."Token Values" := CopyStr(TokenVals, 1, MaxStrLen(Log."Token Values"));
        Log.Status := StatusOpt;
        Log."Error Text" := CopyStr(ErrorText, 1, MaxStrLen(Log."Error Text"));
        Log."Sent Date" := Today;
        Log."Sent Time" := Time;
        Log."Sent By" := UserId;
        Log."Parent Entry No." := ParentEntryNo;
        Log."Is Retry" := IsRetry;
        Log."Is Resend" := IsResend;
        Log."Is CC" := IsCC;
        Log.Insert();
    end;
}
