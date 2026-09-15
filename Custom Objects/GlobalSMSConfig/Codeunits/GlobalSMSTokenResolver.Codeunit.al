codeunit 52185468 "Global SMS Token Resolver"
{
    InherentEntitlements = X;
    InherentPermissions = X;

    procedure ResolveTokens(MessageBody: Text; TokenValues: Text): Text
    var
        TokenRegistry: Record "Global SMS Token Registry";
        ResolvedMessage: Text;
        TokenValue: Text;
    begin
        ResolvedMessage := MessageBody;

        // LOOP THROUGH ALL TOKENS IN REGISTRY
        TokenRegistry.Reset();
        if TokenRegistry.FindSet() then
            repeat
                TokenValue := ExtractTokenValue(TokenValues, TokenRegistry.Token);

                if TokenValue <> '' then
                    ResolvedMessage := ResolvedMessage.Replace(TokenRegistry.Token, TokenValue);
            until TokenRegistry.Next() = 0;

        exit(ResolvedMessage);
    end;

    procedure ResolveTokensWithDictionary(MessageBody: Text; TokenDict: Dictionary of [Text, Text]): Text
    var
        ResolvedMessage: Text;
        TokenKeys: List of [Text];
        TokenKey: Text;
        TokenValue: Text;
        i: Integer;
    begin
        ResolvedMessage := MessageBody;

        // GET ALL KEYS FROM DICTIONARY
        TokenKeys := TokenDict.Keys();

        // LOOP THROUGH KEYS AND REPLACE TOKENS
        for i := 1 to TokenKeys.Count() do begin
            TokenKey := TokenKeys.Get(i);
            TokenValue := TokenDict.Get(TokenKey);

            // ENSURE TOKEN HAS SQUARE BRACKETS
            if not TokenKey.StartsWith('[') then
                TokenKey := '[' + TokenKey + ']';

            TokenKey := UpperCase(TokenKey);

            if TokenValue <> '' then
                ResolvedMessage := ResolvedMessage.Replace(TokenKey, TokenValue);
        end;

        exit(ResolvedMessage);
    end;

    local procedure ExtractTokenValue(TokenValues: Text; Token: Code[50]): Text
    var
        Pairs: List of [Text];
        Pair: Text;
        KeyName: Text;
        KeyValue: Text;
        EqPos: Integer;
    begin
        KeyName := Token;
        KeyName := KeyName.Replace('[', '');
        KeyName := KeyName.Replace(']', '');

        if UpperCase(KeyName) = 'TRANSACTION_BREAKDOWN' then
            exit(BuildTransactionBreakdown(TokenValues));

        if TokenValues = '' then
            exit('');

        Pairs := TokenValues.Split('||');
        foreach Pair in Pairs do begin
            EqPos := StrPos(Pair, '=');
            if EqPos > 0 then begin
                if UpperCase(CopyStr(Pair, 1, EqPos - 1)) = UpperCase(KeyName) then begin
                    KeyValue := CopyStr(Pair, EqPos + 1);
                    exit(KeyValue);
                end;
            end;
        end;

        exit('');
    end;

    local procedure BuildTransactionBreakdown(TokenValues: Text): Text
    var
        TransactionNo: Code[20];
        CTransLines: Record "Cashier Transaction Lines";
        SavingsACC: Record "Savings Accounts";
        Loans: Record Loans;
        Breakdown: Text;
        LineText: Text;
        LineCount: Integer;
        TotalLines: Integer;
    begin
        TransactionNo := ExtractTokenValue(TokenValues, '[TRANSACTION_NO]');
        if TransactionNo = '' then
            exit('');

        Breakdown := '';
        LineCount := 0;

        CTransLines.Reset;
        CTransLines.SetRange("Transaction No", TransactionNo);
        TotalLines := CTransLines.Count;

        if CTransLines.FindSet then begin
            repeat
                LineText := '';
                LineCount += 1;

                case CTransLines.Type of
                    CTransLines.Type::Savings:
                        begin
                            if SavingsACC.Get(CTransLines."Account No") then
                                LineText := 'KES ' + Format(CTransLines.Amount, 0, '<Precision,2:2><Standard Format,0>') +
                                           ' to ' + SavingsACC."Product Name";
                        end;

                    CTransLines.Type::Credit:
                        begin
                            if Loans.Get(CTransLines."Loan No") then
                                LineText := 'KES ' + Format(CTransLines.Amount, 0, '<Precision,2:2><Standard Format,0>') +
                                           ' to Loan ' + CTransLines."Loan No";
                        end;
                end;

                if LineText <> '' then begin
                    if Breakdown <> '' then begin
                        if LineCount = TotalLines then
                            Breakdown += ' and '
                        else
                            Breakdown += ', ';
                    end;
                    Breakdown += LineText;
                end;

            until CTransLines.Next = 0;
        end;

        exit(Breakdown);
    end;

    procedure BuildTokenString(var TokenDict: Dictionary of [Text, Text]): Text
    var
        TokenValues: Text;
        TokenKeys: List of [Text];
        TokenKey: Text;
        i: Integer;
    begin
        // CONVERT DICTIONARY TO STRING FORMAT
        TokenKeys := TokenDict.Keys();

        for i := 1 to TokenKeys.Count() do begin
            TokenKey := TokenKeys.Get(i);
            TokenValues += TokenKey + '=' + TokenDict.Get(TokenKey) + '||';
        end;

        // REMOVE TRAILING ||
        if TokenValues.EndsWith('||') then
            TokenValues := CopyStr(TokenValues, 1, StrLen(TokenValues) - 2);

        exit(TokenValues);
    end;

    procedure PreviewMessage(EventCode: Code[50]): Text
    var
        Template: Record "Global SMS Template";
        TokenUsage: Record "SMS Template Token Usage";
        TokenRegistry: Record "Global SMS Token Registry";
        PreviewMessage: Text;
    begin
        // GENERATE PREVIEW MESSAGE WITH SAMPLE VALUES
        if not Template.Get(EventCode) then
            exit('Template not found');

        PreviewMessage := Template."Message Body";

        TokenUsage.SetRange("Event Code", EventCode);
        if TokenUsage.FindSet() then
            repeat
                if TokenRegistry.Get(TokenUsage.Token) then
                    if TokenRegistry."Sample Value" <> '' then
                        PreviewMessage := PreviewMessage.Replace(TokenRegistry.Token, TokenRegistry."Sample Value");
            until TokenUsage.Next() = 0;

        exit(PreviewMessage);
    end;
}
