codeunit 52185464 "Global SMS Dispatcher"
{
    InherentEntitlements = X;
    InherentPermissions = X;

    procedure Send(EventCode: Code[50]; RecipientPhone: Text[20]; TokenValues: Text): Boolean
    var
        Template: Record "Global SMS Template";
        ResolvedMessage: Text;
        TokenResolver: Codeunit "Global SMS Token Resolver";
        SendSMS: Codeunit SendSms;
        NotConfiguredErr: Label 'SMS Template for event "%1" is not configured. Please configure in Global SMS Templates.';
        DisabledErr: Label 'SMS for event "%1" is currently disabled.';
    begin
        // VALIDATE INPUTS
        if EventCode = '' then
            exit(false);
        if RecipientPhone = '' then
            exit(false);

        // GET TEMPLATE
        if not Template.Get(EventCode) then
            Error(NotConfiguredErr, EventCode);

        // CHECK IF ENABLED
        if not Template.Enabled then begin
            Message(DisabledErr, EventCode);
            exit(false);
        end;

        // CHECK IF MESSAGE BODY EXISTS
        if Template."Message Body" = '' then
            Error(NotConfiguredErr, EventCode);

        // RESOLVE TOKENS
        ResolvedMessage := TokenResolver.ResolveTokens(Template."Message Body", TokenValues);

        // SEND SMS
        SendSMS.SendSms(
            Template."SMS Source",
            RecipientPhone,
            ResolvedMessage,
            '',
            '',
            true,
            0,
            false,
            'CBS',
            '',
            'CBS'
        );

        exit(true);
    end;

    procedure SendWithDictionary(EventCode: Code[50]; RecipientPhone: Text[20]; TokenDict: Dictionary of [Text, Text]): Boolean
    var
        Template: Record "Global SMS Template";
        ResolvedMessage: Text;
        TokenResolver: Codeunit "Global SMS Token Resolver";
        SendSMS: Codeunit SendSms;
        NotConfiguredErr: Label 'SMS Template for event "%1" is not configured. Please configure in Global SMS Templates.';
        DisabledErr: Label 'SMS for event "%1" is currently disabled.';
    begin
        // VALIDATE INPUTS
        if EventCode = '' then
            exit(false);
        if RecipientPhone = '' then
            exit(false);

        // GET TEMPLATE
        if not Template.Get(EventCode) then
            Error(NotConfiguredErr, EventCode);

        // CHECK IF ENABLED
        if not Template.Enabled then begin
            Message(DisabledErr, EventCode);
            exit(false);
        end;

        // CHECK IF MESSAGE BODY EXISTS
        if Template."Message Body" = '' then
            Error(NotConfiguredErr, EventCode);

        // RESOLVE TOKENS
        ResolvedMessage := TokenResolver.ResolveTokensWithDictionary(Template."Message Body", TokenDict);

        // SEND SMS
        SendSMS.SendSms(
            Template."SMS Source",
            RecipientPhone,
            ResolvedMessage,
            '',
            '',
            true,
            0,
            false,
            'CBS',
            '',
            'CBS'
        );

        exit(true);
    end;

    procedure IsConfigured(EventCode: Code[50]): Boolean
    var
        Template: Record "Global SMS Template";
    begin
        if not Template.Get(EventCode) then
            exit(false);

        exit((Template."Message Body" <> '') and Template.Enabled);
    end;

    procedure GetPreview(EventCode: Code[50]): Text
    var
        TokenResolver: Codeunit "Global SMS Token Resolver";
    begin
        exit(TokenResolver.PreviewMessage(EventCode));
    end;
}
