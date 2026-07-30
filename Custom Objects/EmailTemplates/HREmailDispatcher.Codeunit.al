codeunit 52185459 "HR Email Dispatcher"
{
    procedure Send(
        EventCode: Code[50];
        RecipientRole: Option;
        RecipientEmployeeNo: Code[20];
        SourceDocNo: Code[50];
        Vars: array[10] of Text
    )
    var
        Template: Record "HR Email Template";
        HREmp: Record "HR Employees";
        RecipientEmail: Text;
        ResolvedSubject: Text;
        ResolvedBody: Text;
    begin
        // NO TEMPLATE — SILENT EXIT
        if not Template.Get(EventCode, RecipientRole) then
            exit;

        // DISABLED — SILENT EXIT
        if not Template.Enabled then
            exit;

        // RESOLVE RECIPIENT EMAIL
        RecipientEmail := '';
        if RecipientEmployeeNo <> '' then begin
            if HREmp.Get(RecipientEmployeeNo) then
                RecipientEmail := HREmp."E-Mail";
        end;

        if RecipientEmail = '' then begin
            LogEntry(EventCode, RecipientRole, '', SourceDocNo, Template.Subject, 1,
                'NO EMAIL ADDRESS ON EMPLOYEE RECORD ' + RecipientEmployeeNo);
            exit;
        end;

        // RESOLVE SUBJECT AND BODY — USE REPLACE NOT STRSUB TO AVOID HTML CONFLICTS
        ResolvedSubject := ResolvePlaceholders(Template.Subject, Vars);
        ResolvedBody := ResolvePlaceholders(Template.GetBody(), Vars);

        // SEND
        SendEmail(
            RecipientEmail,
            Template."CC Email",
            ResolvedSubject,
            ResolvedBody,
            EventCode,
            RecipientRole,
            SourceDocNo
        );
    end;

    procedure SendToAddress(
        EventCode: Code[50];
        RecipientRole: Option;
        RecipientEmail: Text;
        SourceDocNo: Code[50];
        Vars: array[10] of Text
    )
    var
        Template: Record "HR Email Template";
        ResolvedSubject: Text;
        ResolvedBody: Text;
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

        ResolvedSubject := ResolvePlaceholders(Template.Subject, Vars);
        ResolvedBody := ResolvePlaceholders(Template.GetBody(), Vars);

        SendEmail(
            RecipientEmail,
            Template."CC Email",
            ResolvedSubject,
            ResolvedBody,
            EventCode,
            RecipientRole,
            SourceDocNo
        );
    end;

    local procedure SendEmail(
        RecipientEmail: Text;
        CCEmail: Text;
        ResolvedSubject: Text;
        ResolvedBody: Text;
        EventCode: Code[50];
        RecipientRole: Option;
        SourceDocNo: Code[50]
    )
    var
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
    begin
        EmailMsg.Create(RecipientEmail, ResolvedSubject, ResolvedBody, true);

        if CCEmail <> '' then
            EmailMsg.AddRecipient(Enum::"Email Recipient Type"::Cc, CCEmail);

        if Email.Send(EmailMsg, Enum::"Email Scenario"::Default) then
            LogEntry(EventCode, RecipientRole, RecipientEmail, SourceDocNo, ResolvedSubject, 0, '')
        else
            LogEntry(EventCode, RecipientRole, RecipientEmail, SourceDocNo, ResolvedSubject, 1,
                GetLastErrorText());
    end;

    local procedure ResolvePlaceholders(RawText: Text; Vars: array[10] of Text): Text
    var
        Resolved: Text;
        i: Integer;
    begin
        Resolved := RawText;
        for i := 1 to 10 do begin
            if Vars[i] <> '' then
                Resolved := Resolved.Replace('%' + Format(i), Vars[i]);
        end;
        exit(Resolved);
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
