codeunit 52185459 "HR Email Dispatcher"
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
            LogEntry(EventCode, RecipientRole, '', SourceDocNo, Template.Subject,
                TokenVals, 1, 'NO EMAIL ADDRESS ON EMPLOYEE RECORD ' + RecipientEmployeeNo,
                0, false, false);
            exit;
        end;

        ExecuteSend(Template, RecipientEmail, SourceDocNo, TokenVals, EventCode, RecipientRole, 0, false, false);
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
        if not Template.Get(EventCode, RecipientRole) then
            exit;

        if not Template.Enabled then
            exit;

        if RecipientEmail = '' then begin
            LogEntry(EventCode, RecipientRole, '', SourceDocNo, Template.Subject,
                TokenVals, 1, 'NO RECIPIENT EMAIL PROVIDED', 0, false, false);
            exit;
        end;

        ExecuteSend(Template, RecipientEmail, SourceDocNo, TokenVals, EventCode, RecipientRole, 0, false, false);
    end;

    procedure Retry(LogEntryNo: Integer)
    var
        LogEntry2: Record "HR Email Notification Log";
        Template: Record "HR Email Template";
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
        LogEntry2: Record "HR Email Notification Log";
        Template: Record "HR Email Template";
    begin
        if not LogEntry2.Get(LogEntryNo) then
            Error('LOG ENTRY %1 NOT FOUND.', LogEntryNo);

        if not Template.Get(LogEntry2."Event Code", LogEntry2."Recipient Role") then
            Error('TEMPLATE NOT FOUND FOR EVENT "%1" / ROLE "%2". VERIFY THE TEMPLATE EXISTS.',
                LogEntry2."Event Code", LogEntry2."Recipient Role");

        if not Template.Enabled then
            if not Confirm('TEMPLATE IS DISABLED. RESEND ANYWAY?', false) then
                exit;

        if not Confirm('RESEND THIS NOTIFICATION TO %1?', true, LogEntry2."Sent To") then
            exit;

        ExecuteSend(Template, LogEntry2."Sent To", LogEntry2."Source Document No.",
            LogEntry2."Token Values", LogEntry2."Event Code", LogEntry2."Recipient Role",
            LogEntryNo, false, true);

        LogEntry2."Last Retry DateTime" := CurrentDateTime;
        LogEntry2.Modify();
    end;

    local procedure ExecuteSend(
        Template: Record "HR Email Template";
        RecipientEmail: Text;
        SourceDocNo: Code[50];
        TokenVals: Text;
        EventCode: Code[50];
        RecipientRole: Option;
        ParentEntryNo: Integer;
        IsRetry: Boolean;
        IsResend: Boolean
    )
    var
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        ResolvedSubject: Text;
        ResolvedBody: Text;
        CCList: List of [Text];
        CCAddress: Text;
        SuccessStatus: Option;
        FailStatus: Option;
        SendOk: Boolean;
        ErrTxt: Text;
    begin
        ResolvedSubject := ResolveAllTokens(Template.Subject, EventCode, TokenVals, SourceDocNo);
        ResolvedBody := ResolveAllTokens(Template.GetBody(), EventCode, TokenVals, SourceDocNo);

        EmailMsg.Create(RecipientEmail, ResolvedSubject, ResolvedBody, true);

        if Template."CC Email" <> '' then begin
            CCList := Template."CC Email".Split(';');
            foreach CCAddress in CCList do begin
                CCAddress := CCAddress.Trim();
                if CCAddress <> '' then
                    EmailMsg.AddRecipient(Enum::"Email Recipient Type"::Cc, CCAddress);
            end;
        end;

        if IsRetry then begin
            SuccessStatus := 2;
            FailStatus := 3;
        end else if IsResend then begin
            SuccessStatus := 4;
            FailStatus := 1;
        end else begin
            SuccessStatus := 0;
            FailStatus := 1;
        end;

        // TRAP EMAIL PLATFORM ERRORS — EMAIL FAILURE MUST NOT BLOCK APPROVAL OR OTHER TRANSACTIONS
        SendOk := false;
        ErrTxt := '';
        if not Email.Send(EmailMsg, Enum::"Email Scenario"::Default) then begin
            ErrTxt := GetLastErrorText();
            if ErrTxt = '' then
                ErrTxt := 'EMAIL SEND RETURNED FALSE. VERIFY BC EMAIL ACCOUNT IS CONFIGURED UNDER SETUP > EMAIL > EMAIL ACCOUNTS.';
        end else
            SendOk := true;

        if SendOk then
            LogEntry(EventCode, RecipientRole, RecipientEmail, SourceDocNo,
                ResolvedSubject, TokenVals, SuccessStatus, '', ParentEntryNo, IsRetry, IsResend)
        else
            LogEntry(EventCode, RecipientRole, RecipientEmail, SourceDocNo,
                ResolvedSubject, TokenVals, FailStatus, ErrTxt, ParentEntryNo, IsRetry, IsResend);
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
                TokenValue := GetTokenValue(TokenVals, Vars.Token)
            else
                if (Vars."Source Table No." <> 0) and (Vars."Source Field No." <> 0) then
                    TokenValue := ResolveFromRecord(Vars."Source Table No.", Vars."Source Field No.", SourceDocNo);

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

        AllObjRec.Reset();
        AllObjRec.SetRange("Object Type", AllObjRec."Object Type"::Table);
        AllObjRec.SetRange("Object ID", TableNo);
        if not AllObjRec.FindFirst() then
            exit('');

        RecRef.Open(TableNo);
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
        TokenVals: Text;
        StatusOpt: Option;
        ErrorText: Text;
        ParentEntryNo: Integer;
        IsRetry: Boolean;
        IsResend: Boolean
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
        Log."Token Values" := CopyStr(TokenVals, 1, MaxStrLen(Log."Token Values"));
        Log.Status := StatusOpt;
        Log."Error Text" := CopyStr(ErrorText, 1, MaxStrLen(Log."Error Text"));
        Log."Sent Date" := Today;
        Log."Sent Time" := Time;
        Log."Sent By" := UserId;
        Log."Parent Entry No." := ParentEntryNo;
        Log."Is Retry" := IsRetry;
        Log."Is Resend" := IsResend;
        Log.Insert();
    end;
}
