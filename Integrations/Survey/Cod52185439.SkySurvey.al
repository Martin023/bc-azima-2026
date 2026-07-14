codeunit 52185439 "Sky Survey"
{
    trigger OnRun()
    var
        GFunc: Codeunit "Global Functions";
    begin
        CreateSurvey(
            GFunc.CleanGuid,
            "Sky Survey Triggers"::MEMBER_APPLICATION,
            '254722863636',
            'Carlton Moseti',
            'SWLTST001',
            true,
            CurrentDateTime
        );

        CreateSurvey(
            GFunc.CleanGuid,
            "Sky Survey Triggers"::MEMBER_APPLICATION,
            '254713000249',
            'Derek Mutende',
            'SWLTST001',
            true,
            CurrentDateTime
        );

        CreateSurvey(
            GFunc.CleanGuid,
            "Sky Survey Triggers"::MEMBER_VARIATION,
            '254722863636',
            'Carlton Moseti',
            'SWLTST001',
            true,
            CurrentDateTime
        );

        CreateSurvey(
            GFunc.CleanGuid,
            "Sky Survey Triggers"::MEMBER_VARIATION,
            '254713000249',
            'Derek Mutende',
            'SWLTST001',
            true,
            CurrentDateTime
        );
    end;

    procedure CreateSurvey(
        RecordRef: Text;
        TriggerType: enum "Sky Survey Triggers";
        SurveyParticipantPhoneNo: Text;
        SurveyParticipantFullNames: Text;
        BatchRef: Text;
        ScheduleSurvey: Boolean;
        DateScheduled: DateTime
    ): Boolean
    var
        SkySurvey: Record "Survey Logs";
        SkySurveyTriggers: enum "Sky Survey Triggers";

        TriggerSurveySetup: Record "Trigger Survey Setup";
    begin
        TriggerSurveySetup.Reset;
        TriggerSurveySetup.SetRange("Sky Survey Type", TriggerType);
        TriggerSurveySetup.SetRange("Is Enabled?", true);

        if TriggerSurveySetup.FindFirst then begin
            // TODO: Remove on Go Live
            case TriggerType of
                TriggerType::MEMBER_APPLICATION, TriggerType::MEMBER_VARIATION:
                    begin
                        if not (SurveyParticipantPhoneNo in [
                            '254713000249',
                            '254722863636']) then begin
                            SurveyParticipantPhoneNo := '254713317980';
                        end;
                    end;
            end;

            SkySurvey.Init;
            SkySurvey."Sky Survey Type" := TriggerType;

            SkySurvey.OriginatorID := RecordRef;
            SkySurvey.StatusCode := SkySurvey.StatusCode::QUEUED;
            SkySurvey.Validate(StatusCode);
            SkySurvey.StatusDate := CurrentDateTime;

            SkySurvey.ProductID := TriggerSurveySetup.ProductID;
            SkySurvey.PublishID := TriggerSurveySetup.PublishID;
            SkySurvey.ChannelCode := TriggerSurveySetup.ChannelCode;

            SkySurvey.SurveyType := 'REQUEST';
            SkySurvey.SurveyAction := 'PUSH';
            SkySurvey.SurveyCommand := 'RequestSurveySendSMS';
            SkySurvey.SurveySensitivity := 'NORMAL';
            SkySurvey.TriggerMode := 'SYSTEM_PROCESS';

            SkySurvey.TriggerType := TriggerSurveySetup.TriggerType;
            SkySurvey.TriggerName := TriggerSurveySetup.TriggerName;
            SkySurvey.TriggerDescription := TriggerSurveySetup.TriggerDescription;
            SkySurvey.TriggerOtherDetails := TriggerSurveySetup.TriggerOtherDetails;

            SkySurvey.SystemUserIdentifier := UserId;
            SkySurvey.Validate(SystemUserIdentifier);
            SkySurvey.SystemUserOtherDetails := '';

            SkySurvey.ParticipantIdentifierType := 'MSISDN';
            SkySurvey.SurveyParticipantIdentifier := SurveyParticipantPhoneNo;
            SkySurvey.SurveyParticipantFullName := SurveyParticipantFullNames;
            SkySurvey.SurveyParticipantOtherDetails := '';

            SkySurvey.SurveyBatchReference := BatchRef;
            SkySurvey.SurveySourceReference := RecordRef;
            SkySurvey.SurveySourceApplication := 'CBS';

            SkySurvey.SurveyCategory := TriggerSurveySetup.SurveyCategory;
            SkySurvey.SurveyPriority := TriggerSurveySetup.SurveyPriority;
            SkySurvey.SurveyDateCreated := CurrentDateTime;

            if ScheduleSurvey then begin
                SkySurvey.SurveyScheduled := 'YES';
                SkySurvey.SurveyDateScheduled := DateScheduled;
            end else begin
                SkySurvey.SurveyScheduled := 'NO';
            end;

            SkySurvey.SurveyOtherDetails := '';

            exit(SkySurvey.Insert(true));
        end else begin
            exit(false);
        end;
    end;

    local procedure GenerateSurveyXML(SkySurvey: Record "Survey Logs") theXml: Text;
    var
        GFunc: Codeunit "Global Functions";
    begin
        theXml := '<SURVEY ORIGINATOR_ID="' + SkySurvey.OriginatorID +
        '" PRODUCT_ID="' + Format(SkySurvey.ProductID) +
        '" PUBLISH_ID="' + Format(SkySurvey.PublishID) +
        '" CHANNEL_CODE="' + Format(SkySurvey.ChannelCode) +
        '" TYPE="' + Format(SkySurvey.SurveyType) +
        '" ACTION="' + Format(SkySurvey.SurveyAction) +
        '" COMMAND="' + Format(SkySurvey.SurveyCommand) +
        '" SENSITIVITY="' + Format(SkySurvey.SurveySensitivity) +
        '"><TRIGGER MODE="' + Format(SkySurvey.TriggerMode) +
        '"><SYSTEM_PROCESS ID="' + Format(SkySurvey.SurveySourceReference) +
        '"><TYPE>' + Format(SkySurvey.TriggerType) +
        '</TYPE><NAME>' + Format(SkySurvey.TriggerName) +
        '</NAME><DESCRIPTION>' + Format(SkySurvey.TriggerDescription) +
        '</DESCRIPTION><OTHER_DETAILS/></SYSTEM_PROCESS><SYSTEM_USER><IDENTIFIER TYPE="SYSTEM_USER_ID">' + Format(SkySurvey.SystemUserIdentifier) +
        '</IDENTIFIER><FULL_NAME>' + Format(SkySurvey.SystemUserName) +
        '</FULL_NAME><DEPARTMENT>' + Format(SkySurvey.SystemUserDepartment) +
        '</DEPARTMENT><OTHER_DETAILS></OTHER_DETAILS></SYSTEM_USER><OTHER_DETAILS/></TRIGGER><PARTICIPANT><IDENTIFIER TYPE="' + Format(SkySurvey.ParticipantIdentifierType) +
        '">' + Format(SkySurvey.SurveyParticipantIdentifier) +
        '</IDENTIFIER><FULL_NAME>' + Format(SkySurvey.SurveyParticipantFullName) +
        '</FULL_NAME><OTHER_DETAILS/></PARTICIPANT><BATCH_REFERENCE>' + Format(SkySurvey.SurveyBatchReference) +
        '</BATCH_REFERENCE><SOURCE><REFERENCE>' + Format(SkySurvey.SurveySourceReference) +
        '</REFERENCE><APPLICATION>' + Format(SkySurvey.SurveySourceApplication) +
        '</APPLICATION></SOURCE><CATEGORY>' + Format(SkySurvey.SurveyCategory) +
        '</CATEGORY><PRIORITY>' + Format(SkySurvey.SurveyPriority) +
        '</PRIORITY><SCHEDULE>' + Format(SkySurvey.SurveyScheduled) +
        '</SCHEDULE><DATE_SCHEDULED>' + GFunc.FormatISODateTime(SkySurvey.SurveyDateScheduled) +
        '</DATE_SCHEDULED><DATE_CREATED>' + GFunc.FormatISODateTime(SkySurvey.CreatedAt) +
        '</DATE_CREATED><OTHER_DETAILS></OTHER_DETAILS></SURVEY>';

        exit(theXml);
    end;

    procedure FetchSurveys(SurveyCount: Integer): Text;
    var
        SkySurvey: Record "Survey Logs";
        Count: Integer;

        Response: Text;
        theXml: Text;
        GFunc: Codeunit "Global Functions";
    begin
        SkySurvey.Reset;
        SkySurvey.SetRange(StatusCode, SkySurvey.StatusCode::QUEUED);
        if SkySurvey.FindSet then begin
            Count := 0;

            repeat begin

                theXml += GenerateSurveyXML(SkySurvey);
                // Message(theXml);

                SkySurvey.StatusCode := SkySurvey.StatusCode::SENT;
                SkySurvey.Validate(StatusCode);
                SkySurvey.Modify(true);

                Count += 1;
            end until (SkySurvey.Next = 0) or (Count = SurveyCount);
        end;

        Response := '<MESSAGES DATE_TIME="' + GFunc.FormatISODateTime(CurrentDateTime) +
        '" VERSION="1.01"><RESPONSE CODE="' + Format(102) +
        '" NAME="' + Format('SUCCESS') +
        '" REFERENCE="' + Format(GFunc.CleanGuid) +
        '">Get Survey Requests Request Successful.</RESPONSE><SURVEYS>' +
        theXml +
        '</SURVEYS></MESSAGES>';

        exit(Response);
    end;
}
