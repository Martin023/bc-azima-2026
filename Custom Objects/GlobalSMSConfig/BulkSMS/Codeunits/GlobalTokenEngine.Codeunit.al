codeunit 52185976 "Global Token Engine"
{
    procedure ResolveAllTokens(MessageTemplate: Text; MemberNo: Code[20]; CampaignNo: Code[20]): Text
    var
        GlobalTokenResolver: Codeunit "Global SMS Token Resolver";
        ResolvedMessage: Text;
        TokenValues: Text;
    begin
        if MessageTemplate = '' then
            Error('Message Template cannot be blank.');

        if MemberNo = '' then
            Error('Member No. cannot be blank when resolving tokens.');

        ResolvedMessage := MessageTemplate;

        TokenValues := BuildTokenValuesString(MemberNo, CampaignNo);

        ResolvedMessage := GlobalTokenResolver.ResolveTokens(ResolvedMessage, TokenValues);

        ResolvedMessage := ResolveCustomTokens(ResolvedMessage, MemberNo, CampaignNo);

        exit(ResolvedMessage);
    end;

    local procedure ResolveCustomTokens(MessageTemplate: Text; MemberNo: Code[20]; CampaignNo: Code[20]): Text
    var
        TokenMap: Record "Global Bulk SMS Token Map";
        ResolvedMessage: Text;
        TokenValue: Text;
    begin
        ResolvedMessage := MessageTemplate;

        if CampaignNo = '' then
            exit(ResolvedMessage);

        TokenMap.SetRange("Campaign No.", CampaignNo);

        if TokenMap.FindSet() then
            repeat
                if ResolvedMessage.Contains(TokenMap."Token Code") then begin
                    TokenValue := GetCustomTokenValue(TokenMap, MemberNo);
                    ResolvedMessage := ResolvedMessage.Replace(TokenMap."Token Code", TokenValue);
                end;
            until TokenMap.Next() = 0;

        exit(ResolvedMessage);
    end;

    local procedure GetCustomTokenValue(TokenMap: Record "Global Bulk SMS Token Map"; MemberNo: Code[20]): Text
    var
        TokenValue: Text;
    begin
        if MemberNo = '' then
            Error('Member No. cannot be blank for token %1.', TokenMap."Token Code");

        TokenValue := TokenMap.GetFieldValue(MemberNo);

        if TokenValue = '' then
            TokenValue := '(N/A)';

        exit(TokenValue);
    end;

    procedure BuildTokenValuesString(MemberNo: Code[20]; CampaignNo: Code[20]): Text
    var
        Member: Record Members;
        TokenMap: Record "Global Bulk SMS Token Map";
        TokenValues: Text;
        TokenValue: Text;
        TokenName: Text;
    begin
        if MemberNo = '' then
            Error('Member No. cannot be blank.');

        if not Member.Get(MemberNo) then
            Error('Member %1 does not exist.', MemberNo);

        TokenValues := 'MEMBER_NAME=' + Member.Name + '||' +
                      'MEMBER_NO=' + Member."No." + '||' +
                      'PHONE_NO=' + Member."Phone No." + '||' +
                      'DATE=' + Format(Today, 0, '<Day,2>-<Month Text,3>-<Year4>') + '||' +
                      'TIME=' + Format(Time, 0, '<Hours24,2>:<Minutes,2>') + '||' +
                      'COMPANY_NAME=' + CompanyName;

        if CampaignNo <> '' then begin
            TokenMap.SetRange("Campaign No.", CampaignNo);

            if TokenMap.FindSet() then
                repeat
                    TokenName := TokenMap."Token Code";
                    TokenName := TokenName.Replace('[', '');
                    TokenName := TokenName.Replace(']', '');

                    TokenValue := GetCustomTokenValue(TokenMap, MemberNo);

                    TokenValues := TokenValues + '||' + TokenName + '=' + TokenValue;
                until TokenMap.Next() = 0;
        end;

        exit(TokenValues);
    end;

    procedure ResolveLinesForCampaign(CampaignNo: Code[20]): Integer
    var
        Header: Record "Global Bulk SMS Header";
        Line: Record "Global Bulk SMS Line";
        ProcessedCount: Integer;
        FailedCount: Integer;
    begin
        if CampaignNo = '' then
            Error('Campaign No. cannot be blank.');

        if not Header.Get(CampaignNo) then
            Error('Campaign %1 does not exist.', CampaignNo);

        if Header."Message Template" = '' then
            Error('Message Template cannot be blank for campaign %1.', CampaignNo);

        Line.SetRange("Campaign No.", CampaignNo);
        Line.SetRange(Status, Line.Status::Pending);

        if Line.IsEmpty() then
            Error('No pending recipients found for campaign %1.', CampaignNo);

        if Line.FindSet() then
            repeat
                if ResolveSingleLine(Line, Header."Message Template") then
                    ProcessedCount += 1
                else
                    FailedCount += 1;
            until Line.Next() = 0;

        if FailedCount > 0 then
            Message('%1 lines resolved successfully. %2 lines failed token resolution.', ProcessedCount, FailedCount)
        else
            Message('%1 lines resolved successfully.', ProcessedCount);

        exit(ProcessedCount);
    end;

    local procedure ResolveSingleLine(var Line: Record "Global Bulk SMS Line"; MessageTemplate: Text): Boolean
    var
        ResolvedMessage: Text;
        TokenValues: Text;
    begin
        if Line."Member No." = '' then begin
            Line.SkipLine('Member No. is blank');
            exit(false);
        end;

        ResolvedMessage := ResolveAllTokens(MessageTemplate, Line."Member No.", Line."Campaign No.");

        TokenValues := BuildTokenValuesString(Line."Member No.", Line."Campaign No.");

        Line."Personalized Message" := CopyStr(ResolvedMessage, 1, MaxStrLen(Line."Personalized Message"));
        Line."Token Values" := CopyStr(TokenValues, 1, MaxStrLen(Line."Token Values"));
        Line.Modify(true);

        exit(true);
    end;

    procedure GetAvailableFields(TableID: Integer): Dictionary of [Text, Text]
    var
        RecRef: RecordRef;
        FldRef: FieldRef;
        FieldDict: Dictionary of [Text, Text];
        i: Integer;
    begin
        if TableID = 0 then
            Error('Table ID cannot be zero.');

        RecRef.Open(TableID);

        for i := 1 to RecRef.FieldCount() do begin
            FldRef := RecRef.FieldIndex(i);

            if FldRef.Class = FieldClass::Normal then
                if not FieldDict.ContainsKey(FldRef.Name) then
                    FieldDict.Add(FldRef.Name, FldRef.Caption);
        end;

        RecRef.Close();

        if FieldDict.Count() = 0 then
            Error('No fields found in table %1.', TableID);

        exit(FieldDict);
    end;

    procedure GetAvailableFlowFields(TableID: Integer): Dictionary of [Text, Text]
    var
        RecRef: RecordRef;
        FldRef: FieldRef;
        FieldDict: Dictionary of [Text, Text];
        i: Integer;
    begin
        if TableID = 0 then
            Error('Table ID cannot be zero.');

        RecRef.Open(TableID);

        for i := 1 to RecRef.FieldCount() do begin
            FldRef := RecRef.FieldIndex(i);

            if FldRef.Class = FieldClass::FlowField then
                if not FieldDict.ContainsKey(FldRef.Name) then
                    FieldDict.Add(FldRef.Name, FldRef.Caption);
        end;

        RecRef.Close();

        exit(FieldDict);
    end;

    procedure GetAvailableTables(): Dictionary of [Integer, Text]
    var
        TableDict: Dictionary of [Integer, Text];
    begin
        TableDict.Add(Database::Members, 'Members');
        TableDict.Add(Database::"Savings Accounts", 'Savings Accounts');
        TableDict.Add(Database::Loans, 'Loans');

        exit(TableDict);
    end;

    procedure TestTokenResolution(MessageTemplate: Text; TestMemberNo: Code[20]; CampaignNo: Code[20]): Text
    var
        Member: Record Members;
        ResolvedMessage: Text;
    begin
        if MessageTemplate = '' then
            Error('Message Template cannot be blank.');

        if TestMemberNo = '' then
            Error('Test Member No. cannot be blank.');

        if not Member.Get(TestMemberNo) then
            Error('Member %1 does not exist.', TestMemberNo);

        ResolvedMessage := ResolveAllTokens(MessageTemplate, TestMemberNo, CampaignNo);

        exit(ResolvedMessage);
    end;

    procedure ValidateTokensInMessage(MessageTemplate: Text; CampaignNo: Code[20]): Text
    var
        GlobalTokenRegistry: Record "Global SMS Token Registry";
        TokenMap: Record "Global Bulk SMS Token Map";
        ErrorText: Text;
        Position: Integer;
        EndPosition: Integer;
        TokenCode: Text;
        TokenFound: Boolean;
    begin
        if MessageTemplate = '' then
            exit('Message Template is blank');

        Position := 1;

        while Position <= StrLen(MessageTemplate) do begin
            if MessageTemplate[Position] = '[' then begin
                EndPosition := Position + 1;

                while (EndPosition <= StrLen(MessageTemplate)) and (MessageTemplate[EndPosition] <> ']') do
                    EndPosition += 1;

                if EndPosition <= StrLen(MessageTemplate) then begin
                    TokenCode := CopyStr(MessageTemplate, Position, EndPosition - Position + 1);
                    TokenCode := UpperCase(TokenCode);

                    TokenFound := false;

                    GlobalTokenRegistry.SetRange(Token, TokenCode);
                    if not GlobalTokenRegistry.IsEmpty() then
                        TokenFound := true;

                    if not TokenFound then
                        if CampaignNo <> '' then begin
                            TokenMap.SetRange("Campaign No.", CampaignNo);
                            TokenMap.SetRange("Token Code", TokenCode);
                            if not TokenMap.IsEmpty() then
                                TokenFound := true;
                        end;

                    if not TokenFound then
                        ErrorText := ErrorText + StrSubstNo('Token %1 is not defined. ', TokenCode);

                    Position := EndPosition;
                end;
            end;

            Position += 1;
        end;

        exit(ErrorText);
    end;

    procedure GetSampleResolvedMessages(CampaignNo: Code[20]; SampleCount: Integer): List of [Text]
    var
        Header: Record "Global Bulk SMS Header";
        Line: Record "Global Bulk SMS Line";
        MessageList: List of [Text];
        ResolvedMessage: Text;
        Counter: Integer;
    begin
        if CampaignNo = '' then
            Error('Campaign No. cannot be blank.');

        if not Header.Get(CampaignNo) then
            Error('Campaign %1 does not exist.', CampaignNo);

        if SampleCount <= 0 then
            SampleCount := 5;

        Line.SetRange("Campaign No.", CampaignNo);

        if Line.FindSet() then
            repeat
                Counter += 1;

                ResolvedMessage := ResolveAllTokens(Header."Message Template", Line."Member No.", CampaignNo);
                MessageList.Add(Line."Member Name" + ': ' + ResolvedMessage);

                if Counter >= SampleCount then
                    break;
            until Line.Next() = 0;

        if MessageList.Count() = 0 then
            MessageList.Add('No recipients found for preview.');

        exit(MessageList);
    end;
}
