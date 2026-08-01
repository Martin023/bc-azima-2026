codeunit 52185459  "HR Email Dispatcher"
{

    procedure Send(
        EventCode: Code[50];
        RecipientRole: Option;
        RecipientEmployeeNo: Code[20];
        SourceDocNo: Code[50];
        TokenVals: Text
    )
    var
        Template: Record "HR Email Template";
        HREmp: Record "HR Employees";
        RecipientEmail: Text;
    begin
        if not Template.Get(EventCode, RecipientRole) then
            exit;

        if not Template.Enabled then
            exit;

        RecipientEmail := '';
        if RecipientEmployeeNo <> '' then
            if HREmp.Get(RecipientEmployeeNo) then
                RecipientEmail := HREmp."E-Mail";

        if RecipientEmail = '' then begin
            LogEntry(EventCode, RecipientRole, '', SourceDocNo, Template.Subject, 1,
                'NO EMAIL ADDRESS ON EMPLOYEE RECORD ' + RecipientEmployeeNo);
            exit;
        end;

        SendInternal(Template, RecipientEmail, SourceDocNo, TokenVals, EventCode, RecipientRole);
    end;

    procedure SendToAddress(
        EventCode: Code[50];
        RecipientRole: Option;
        RecipientEmail: Text;
        SourceDocNo: Code[50];
        TokenVals: Text
    )
    var
        Template: Record "HR Email Template";
    begin
        // VARIANT: CALLER SUPPLIES EMAIL DIRECTLY — NO EMPLOYEE LOOKUP
        if not Template.Get(EventCode, RecipientRole) then
            exit;

        if not Template.Enabled then
            exit;

        if RecipientEmail = '' then begin
            LogEntry(EventCode, RecipientRole, '', SourceDocNo, Template.Subject, 1,
                'NO RECIPIENT EMAIL PROVIDED');
            exit;
        end;

        SendInternal(Template, RecipientEmail, SourceDocNo, TokenVals, EventCode, RecipientRole);
    end;

    local procedure SendInternal(
        Template: Record "HR Email Template";
        RecipientEmail: Text;
        SourceDocNo: Code[50];
        TokenVals: Text;
        EventCode: Code[50];
        RecipientRole: Option
    )
    var
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        ResolvedSubject: Text;
        ResolvedBody: Text;
        RawBody: Text;
        CCList: List of [Text];
        CCAddress: Text;
    begin
        RawBody := Template.GetBody();

        // RESOLVE ALL TOKENS
        ResolvedSubject := ResolveAllTokens(Template.Subject, EventCode, TokenVals, SourceDocNo);
        ResolvedBody := ResolveAllTokens(RawBody, EventCode, TokenVals, SourceDocNo);

        EmailMsg.Create(RecipientEmail, ResolvedSubject, ResolvedBody, true);

        if Template."CC Email" <> '' then begin
            // SEMICOLON-SEPARATED LIST — LOOP AND ADD EACH CC ADDRESS
            CCList := Template."CC Email".Split(';');
            foreach CCAddress in CCList do begin
                CCAddress := CCAddress.Trim();
                if CCAddress <> '' then
                    EmailMsg.AddRecipient(Enum::"Email Recipient Type"::Cc, CCAddress);
            end;
        end;

        if Email.Send(EmailMsg, Enum::"Email Scenario"::Default) then
            LogEntry(EventCode, RecipientRole, RecipientEmail, SourceDocNo, ResolvedSubject, 0, '')
        else
            LogEntry(EventCode, RecipientRole, RecipientEmail, SourceDocNo, ResolvedSubject, 1,
                GetLastErrorText());
    end;

    local procedure ResolveAllTokens(
        RawText: Text;
        EventCode: Code[50];
        TokenVals: Text;
        SourceDocNo: Code[50]
    ): Text
    var
        Resolved: Text;
        Vars: Record "HR Email Template Variables";
        TokenValue: Text;
    begin
        Resolved := RawText;

        Vars.Reset();
        Vars.SetRange("Event Code", EventCode);
        if not Vars.FindSet() then
            exit(Resolved);

        repeat
            TokenValue := '';

            if Vars."System Defined" then
                // CATEGORY A — VALUE COMES FROM TokenVals KEY=VALUE STRING
                TokenValue := GetTokenValue(TokenVals, Vars.Token)
            else begin
                // CATEGORY B — VALUE RESOLVED FROM SOURCE TABLE/FIELD VIA RECORDREF
                if (Vars."Source Table No." <> 0) and (Vars."Source Field No." <> 0) then
                    TokenValue := ResolveFromRecord(Vars."Source Table No.", Vars."Source Field No.", SourceDocNo);
            end;

            if TokenValue <> '' then
                Resolved := Resolved.Replace(Vars.Token, TokenValue);

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

        // USE || AS DELIMITER — SAFE AGAINST SEMICOLONS IN VALUES (E.G. REASONS, NAMES)
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

    local procedure ResolveFromRecord(TableNo: Integer; FieldNo: Integer; SourceDocNo: Code[50]): Text
    var
        RecRef: RecordRef;
        FldRef: FieldRef;
        KeyRef: KeyRef;
        KeyFldRef: FieldRef;
        AllObjRec: Record AllObj;
    begin
        if SourceDocNo = '' then
            exit('');

        if TableNo <= 0 then
            exit('');

        // CHECK TABLE EXISTS BEFORE OPENING
        AllObjRec.Reset();
        AllObjRec.SetRange("Object Type", AllObjRec."Object Type"::Table);
        AllObjRec.SetRange("Object ID", TableNo);
        if not AllObjRec.FindFirst() then
            exit('');

        if not AllObjRec.FindFirst() then
            exit('');

        RecRef.Open(TableNo);

        // FIND RECORD BY PRIMARY KEY FIRST FIELD = SourceDocNo
        KeyRef := RecRef.KeyIndex(1);
        if KeyRef.FieldCount >= 1 then begin
            KeyFldRef := KeyRef.FieldIndex(1);
            KeyFldRef.SetRange(SourceDocNo);
            if RecRef.FindFirst() then begin
                FldRef := RecRef.Field(FieldNo);
                RecRef.Close();
                exit(Format(FldRef.Value));
            end;
        end;

        RecRef.Close();
        exit('');
    end;

    local procedure LogEntry(
        EventCode: Code[50];
        RecipientRole: Option;
        SentTo: Text;
        SourceDocNo: Code[50];
        SubjectSent: Text;
        StatusOpt: Option;
        ErrorText: Text
    )
    var
        Log: Record "HR Email Notification Log";
    begin
        Log.Init();
        Log."Event Code" := EventCode;
        Log."Recipient Role" := RecipientRole;
        Log."Sent To" := CopyStr(SentTo, 1, MaxStrLen(Log."Sent To"));
        Log."Source Document No." := CopyStr(SourceDocNo, 1, MaxStrLen(Log."Source Document No."));
        Log."Subject Sent" := CopyStr(SubjectSent, 1, MaxStrLen(Log."Subject Sent"));
        Log.Status := StatusOpt;
        Log."Error Text" := CopyStr(ErrorText, 1, MaxStrLen(Log."Error Text"));
        Log."Sent Date" := Today;
        Log."Sent Time" := Time;
        Log."Sent By" := UserId;
        Log.Insert();
    end;
}
