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
                // PRIMARY: CELL PHONE NUMBER (FIELD 39003907)
                PhoneNo := HREmp."Cell Phone Number";
                // FALLBACK 1: CELLULAR PHONE NUMBER (FIELD 14)
                if PhoneNo = '' then
                    PhoneNo := HREmp."Cellular Phone Number";
                // FALLBACK 2: WORK PHONE NUMBER (FIELD 15)
                if PhoneNo = '' then
                    PhoneNo := HREmp."Work Phone Number";
                // FALLBACK 3: HOME PHONE NUMBER (FIELD 13)
                if PhoneNo = '' then
                    PhoneNo := HREmp."Home Phone Number";
            end;

        if PhoneNo = '' then begin
            LogEntry(EventCode, RecipientRole, '', SourceDocNo, '', 1,
                'NO PHONE NUMBER FOUND ON EMPLOYEE ' + RecipientEmployeeNo +
                '. SET Cell Phone Number, Cellular Phone Number, Work Phone Number OR Home Phone Number ON THE EMPLOYEE CARD.');
            exit;
        end;

        SendInternal(Template, PhoneNo, SourceDocNo, TokenVals, EventCode, RecipientRole);
    end;

    local procedure SendInternal(
        Template: Record "HR SMS Template";
        PhoneNo: Text[20];
        SourceDocNo: Code[50];
        TokenVals: Text;
        EventCode: Code[50];
        RecipientRole: Option
    )
    var
        SmsCU: Codeunit SendSms;
        ResolvedBody: Text;
    begin
        ResolvedBody := ResolveTokens(Template.Body, EventCode, TokenVals);

        // CALL THE EXISTING SKY SMS CODEUNIT — WRITES TO Sky SMS Messages QUEUE
        // PARAMETERS: Source, Phone, Message, Reference, AccNo, Chargeable,
        //             Priority, ChargeMember, RequestApp, CorrelationID, SourceApp
        SmsCU.SendSms(
            Template."SMS Source",
            PhoneNo,
            ResolvedBody,
            SourceDocNo,
            '',         // NO ACCOUNT TO CHARGE
            false,      // NOT CHARGEABLE
            0,          // PRIORITY — SendSms MAPS UNKNOWN SOURCES TO 250
            false,      // DO NOT CHARGE MEMBER
            'HR',
            SourceDocNo,
            'HR_MODULE'
        );

        LogEntry(EventCode, RecipientRole, PhoneNo, SourceDocNo, ResolvedBody, 0, '');
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

        // STRIP BRACKETS FROM TOKEN TO GET PLAIN KEY
        KeyName := Token;
        KeyName := KeyName.Replace('[', '');
        KeyName := KeyName.Replace(']', '');

        // || DELIMITER — SAFE AGAINST SEMICOLONS IN VALUES
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
        StatusOpt: Option;
        ErrorText: Text
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
        Log.Status := StatusOpt;
        Log."Error Text" := CopyStr(ErrorText, 1, MaxStrLen(Log."Error Text"));
        Log."Sent Date" := Today;
        Log."Sent Time" := Time;
        Log."Sent By" := UserId;
        Log.Insert();
    end;
}
