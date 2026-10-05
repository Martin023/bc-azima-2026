codeunit 52185977 "Global Bulk SMS Sender"
{
    procedure SendCampaign(CampaignNo: Code[20])
    var
        Header: Record "Global Bulk SMS Header";
        Line: Record "Global Bulk SMS Line";
        GlobalTokenEngine: Codeunit "Global Token Engine";
        SentCount: Integer;
        FailedCount: Integer;
        SkippedCount: Integer;
        TotalCount: Integer;
    begin
        if CampaignNo = '' then
            Error('Campaign No. cannot be blank.');

        if not Header.Get(CampaignNo) then
            Error('Campaign %1 does not exist.', CampaignNo);

        Header.CalcFields("Total Recipients", "Pending Count");

        if Header."Total Recipients" = 0 then
            Error('Campaign has no recipients. Generate recipients before sending.');

        if Header."Pending Count" = 0 then
            Error('No pending recipients to send. All recipients have already been processed.');

        if not Confirm('Send SMS to %1 pending recipient(s) for campaign %2?', true, Header."Pending Count", Header."Campaign Name") then
            exit;

        Header.SetStatusSending();

        GlobalTokenEngine.ResolveLinesForCampaign(CampaignNo);

        Line.SetRange("Campaign No.", CampaignNo);
        Line.SetRange(Status, Line.Status::Pending);

        if Line.FindSet() then begin
            TotalCount := Line.Count();

            repeat
                if SendSingleLine(Line) then
                    SentCount += 1
                else begin
                    if Line.Status = Line.Status::Failed then
                        FailedCount += 1
                    else if Line.Status = Line.Status::Skipped then
                        SkippedCount += 1;
                end;

                if (SentCount mod 10) = 0 then
                    Commit();

            until Line.Next() = 0;
        end;

        Commit();

        Header.Get(CampaignNo);
        Header.SetStatusCompleted();

        Message('Campaign sending completed.\Sent: %1\Failed: %2\Skipped: %3\Total: %4',
                SentCount, FailedCount, SkippedCount, TotalCount);
    end;

    local procedure SendSingleLine(var Line: Record "Global Bulk SMS Line"): Boolean
    var
        GlobalSMSDispatcher: Codeunit "Global SMS Dispatcher";
        ErrorText: Text;
        SMSSent: Boolean;
    begin
        if Line."Phone No." = '' then begin
            Line.SkipLine('Phone number is blank');
            exit(false);
        end;

        if Line."Personalized Message" = '' then begin
            Line.SkipLine('Personalized message is blank');
            exit(false);
        end;

        if StrLen(Line."Personalized Message") < 10 then begin
            Line.SkipLine('Message too short');
            exit(false);
        end;

        SMSSent := false;

        if not GlobalSMSDispatcher.IsConfigured('GLOBAL_BULK_SMS') then begin
            SMSSent := SendViaGlobalDispatcher(Line."Phone No.", Line."Personalized Message", Line."Token Values");
        end else begin
            SMSSent := GlobalSMSDispatcher.Send('GLOBAL_BULK_SMS', Line."Phone No.", Line."Token Values");
        end;

        if SMSSent then begin
            Line.MarkAsSent();
            exit(true);
        end else begin
            ErrorText := 'SMS sending failed - check dispatcher configuration and phone number format';
            Line.MarkAsFailed(ErrorText);
            exit(false);
        end;
    end;

    local procedure SendViaGlobalDispatcher(PhoneNo: Code[20]; MessageText: Text; TokenValues: Text): Boolean
    var
        SendSMS: Codeunit SendSms;
        SMSSource: Enum "SMS Source";
    begin
        if PhoneNo = '' then
            exit(false);

        if MessageText = '' then
            exit(false);

        SendSMS.SendSms(
            SMSSource::BULK_SMS,
            PhoneNo,
            MessageText,
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

    procedure ResendFailed(CampaignNo: Code[20])
    var
        Header: Record "Global Bulk SMS Header";
        Line: Record "Global Bulk SMS Line";
        FailedCount: Integer;
    begin
        if CampaignNo = '' then
            Error('Campaign No. cannot be blank.');

        if not Header.Get(CampaignNo) then
            Error('Campaign %1 does not exist.', CampaignNo);

        Line.SetRange("Campaign No.", CampaignNo);
        Line.SetRange(Status, Line.Status::Failed);

        if Line.IsEmpty() then
            Error('No failed recipients to resend.');

        FailedCount := Line.Count();

        if not Confirm('Reset %1 failed recipient(s) and resend?', true, FailedCount) then
            exit;

        if Line.FindSet() then
            repeat
                Line.ResetForRetry();
            until Line.Next() = 0;

        Commit();

        SendCampaign(CampaignNo);
    end;

    procedure CancelSending(CampaignNo: Code[20])
    var
        Header: Record "Global Bulk SMS Header";
        Line: Record "Global Bulk SMS Line";
        PendingCount: Integer;
    begin
        if CampaignNo = '' then
            Error('Campaign No. cannot be blank.');

        if not Header.Get(CampaignNo) then
            Error('Campaign %1 does not exist.', CampaignNo);

        if not (Header.Status in [Header.Status::Ready, Header.Status::Sending]) then
            Error('Can only cancel campaigns with status Ready or Sending.');

        Line.SetRange("Campaign No.", CampaignNo);
        Line.SetRange(Status, Line.Status::Pending);

        if Line.IsEmpty() then begin
            Message('No pending recipients to cancel.');
            exit;
        end;

        PendingCount := Line.Count();

        if not Confirm('Mark %1 pending recipient(s) as skipped?', true, PendingCount) then
            exit;

        if Line.FindSet() then
            repeat
                Line.SkipLine('Sending cancelled by user');
            until Line.Next() = 0;

        Commit();

        Header.Get(CampaignNo);
        Header.SetStatusCancelled();

        Message('Campaign cancelled. %1 recipients marked as skipped.', PendingCount);
    end;

    procedure GetProgress(CampaignNo: Code[20]): Text
    var
        Header: Record "Global Bulk SMS Header";
        ProgressText: Text;
    begin
        if CampaignNo = '' then
            exit('');

        if not Header.Get(CampaignNo) then
            exit('');

        Header.CalcFields("Total Recipients", "Sent Count", "Failed Count", "Pending Count");

        if Header."Total Recipients" = 0 then
            exit('No recipients');

        ProgressText := StrSubstNo('Total: %1, Sent: %2, Failed: %3, Pending: %4',
                                   Header."Total Recipients",
                                   Header."Sent Count",
                                   Header."Failed Count",
                                   Header."Pending Count");

        exit(ProgressText);
    end;

    procedure GetSendingStatus(CampaignNo: Code[20]): Text
    var
        Header: Record "Global Bulk SMS Header";
    begin
        if CampaignNo = '' then
            exit('Unknown');

        if not Header.Get(CampaignNo) then
            exit('Not Found');

        exit(Format(Header.Status));
    end;

    procedure ValidateBeforeSend(CampaignNo: Code[20]): Text
    var
        Header: Record "Global Bulk SMS Header";
        Line: Record "Global Bulk SMS Line";
        ErrorText: Text;
        InvalidPhoneCount: Integer;
        BlankMessageCount: Integer;
    begin
        if CampaignNo = '' then
            exit('Campaign No. is blank');

        if not Header.Get(CampaignNo) then
            exit('Campaign does not exist');

        if Header."Message Template" = '' then
            ErrorText := ErrorText + 'Message Template is blank. ';

        Header.CalcFields("Total Recipients");

        if Header."Total Recipients" = 0 then
            ErrorText := ErrorText + 'No recipients generated. ';

        Line.SetRange("Campaign No.", CampaignNo);
        Line.SetRange(Status, Line.Status::Pending);

        if Line.FindSet() then
            repeat
                if Line."Phone No." = '' then
                    InvalidPhoneCount += 1;

                if Line."Personalized Message" = '' then
                    BlankMessageCount += 1;
            until Line.Next() = 0;

        if InvalidPhoneCount > 0 then
            ErrorText := ErrorText + StrSubstNo('%1 recipient(s) have blank phone numbers. ', InvalidPhoneCount);

        if BlankMessageCount > 0 then
            ErrorText := ErrorText + StrSubstNo('%1 recipient(s) have blank messages. ', BlankMessageCount);

        exit(ErrorText);
    end;

    procedure TestSendSingle(CampaignNo: Code[20]; TestMemberNo: Code[20]): Boolean
    var
        Header: Record "Global Bulk SMS Header";
        Member: Record Members;
        GlobalTokenEngine: Codeunit "Global Token Engine";
        ResolvedMessage: Text;
        TokenValues: Text;
        SMSSent: Boolean;
    begin
        if CampaignNo = '' then
            Error('Campaign No. cannot be blank.');

        if TestMemberNo = '' then
            Error('Test Member No. cannot be blank.');

        if not Header.Get(CampaignNo) then
            Error('Campaign %1 does not exist.', CampaignNo);

        if not Member.Get(TestMemberNo) then
            Error('Member %1 does not exist.', TestMemberNo);

        if Member."Phone No." = '' then
            Error('Member %1 has no phone number.', TestMemberNo);

        ResolvedMessage := GlobalTokenEngine.ResolveAllTokens(Header."Message Template", TestMemberNo, CampaignNo);

        TokenValues := GlobalTokenEngine.BuildTokenValuesString(TestMemberNo, CampaignNo);

        if not Confirm('Send test SMS to %1 (%2)?\Message: %3', true, Member.Name, Member."Phone No.", ResolvedMessage) then
            exit(false);

        SMSSent := SendViaGlobalDispatcher(Member."Phone No.", ResolvedMessage, TokenValues);

        if SMSSent then begin
            Message('Test SMS sent successfully to %1.', Member.Name);
            exit(true);
        end else begin
            Message('Test SMS failed to send. Check dispatcher configuration and phone number.');
            exit(false);
        end;
    end;

    procedure GetEstimatedCost(CampaignNo: Code[20]): Decimal
    var
        Header: Record "Global Bulk SMS Header";
        Line: Record "Global Bulk SMS Line";
        TotalCost: Decimal;
        SMSCount: Integer;
        MessageLength: Integer;
        SMSPerMessage: Integer;
        CostPerSMS: Decimal;
    begin
        CostPerSMS := 1.0;

        if CampaignNo = '' then
            exit(0);

        if not Header.Get(CampaignNo) then
            exit(0);

        Line.SetRange("Campaign No.", CampaignNo);
        Line.SetRange(Status, Line.Status::Pending);

        if Line.FindSet() then
            repeat
                MessageLength := StrLen(Line."Personalized Message");

                if MessageLength = 0 then
                    MessageLength := StrLen(Header."Message Template");

                if MessageLength <= 160 then
                    SMSPerMessage := 1
                else if MessageLength <= 306 then
                    SMSPerMessage := 2
                else if MessageLength <= 459 then
                    SMSPerMessage := 3
                else
                    SMSPerMessage := 4;

                SMSCount += SMSPerMessage;
            until Line.Next() = 0;

        TotalCost := SMSCount * CostPerSMS;

        exit(TotalCost);
    end;
}
