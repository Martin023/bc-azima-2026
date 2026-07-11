table 52185566 "Survey Logs"
{
    Caption = 'Survey Logs';
    DataClassification = ToBeClassified;

    LookupPageId = "Survey Logs";
    DrillDownPageId = "Survey Logs";

    fields
    {
        field(1; EntryNo; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
            Caption = 'Entry No.';
            Editable = false;
        }

        field(2; OriginatorID; Code[50])
        {
            Caption = 'Originator ID';
            Editable = false;
        }
        field(3; StatusCode; enum "Survey Status")
        {
            InitValue = 10;
            Caption = 'Status Code';
            Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                StatusName := Format(StatusCode);
                StatusDescription := StatusName;
            end;
        }

        field(4; StatusName; Code[50])
        {
            Caption = 'Status Name';
            Editable = false;
        }

        field(5; StatusDate; DateTime)
        {
            Caption = 'Status Date';
            Editable = false;
        }

        field(6; StatusDescription; Text[150])
        {
            InitValue = '';
            Caption = 'Status Description';
            Editable = false;
        }

        field(7; ProductID; Integer)
        {
            Caption = 'Product ID';
            Editable = false;
        }
        field(8; PublishID; Integer)
        {
            Caption = 'Publish ID';
            Editable = false;
        }
        field(9; ChannelCode; Integer)
        {
            Caption = 'Channel Code';
            Editable = false;
        }

        field(10; SurveyType; Code[50])
        {
            InitValue = 'REQUEST';
            Caption = 'Survey Type';
            Editable = false;
        }

        field(11; SurveyAction; Code[50])
        {
            InitValue = 'PUSH';
            Caption = 'Survey Action';
            Editable = false;
        }

        field(12; SurveyCommand; Text[50])
        {
            InitValue = 'RequestSurveySendSMS';
            Caption = 'Survey Command';
            Editable = false;
        }

        field(13; SurveySensitivity; Code[50])
        {
            InitValue = 'NORMAL';
            Caption = 'Survey Sensitivity';
            Editable = false;
        }

        field(14; TriggerMode; Code[50])
        {
            InitValue = 'SYSTEM_PROCESS';
            Caption = 'Trigger Mode';
            Editable = false;
        }

        field(15; TriggerType; Code[50])
        {
            Caption = 'Trigger Type';
            Editable = false;
        }
        field(16; TriggerName; Text[150])
        {
            Caption = 'Trigger Name';
            Editable = false;
        }
        field(17; TriggerDescription; Text[500])
        {
            Caption = 'Trigger Description';
            Editable = false;
        }

        field(18; TriggerOtherDetails; Text[500])
        {
            InitValue = '';
            Caption = 'Trigger Other Details';
            Editable = false;
        }

        field(19; SystemUserIdentifier; Code[50])
        {
            Caption = 'System User Identifier';
            Editable = false;
            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
                if UserSetup.Get(SystemUserIdentifier) then begin
                    SystemUserName := UserSetup."Full Name";
                    SystemUserDepartment := UserSetup."Global Dimension 2 Code";
                end else begin
                    SystemUserName := UserId;
                    SystemUserDepartment := UserId;
                end;
            end;
        }
        field(20; SystemUserName; Text[50])
        {
            Caption = 'System User Name';
            Editable = false;
        }
        field(21; SystemUserDepartment; Text[50])
        {
            Caption = 'System User Department';
            Editable = false;
        }

        field(22; SystemUserOtherDetails; Text[500])
        {
            InitValue = '';
            Caption = 'System User Other Details';
            Editable = false;
        }

        /* 
            Shortened field name to comply with Business Central's 30-character limit and avoid future compiler errors.
        */
        field(23; ParticipantIdentifierType; Code[50])
        {
            InitValue = 'MSISDN';
            Caption = 'Survey Participant Identifier Type';
            Editable = false;
        }

        field(24; SurveyParticipantIdentifier; Code[50])
        {
            Caption = 'Survey Participant Identifier';
            Editable = false;
        }
        field(25; SurveyParticipantFullName; Text[150])
        {
            Caption = 'Survey Participant Full Name';
            Editable = false;
        }

        field(26; SurveyParticipantOtherDetails; Text[500])
        {
            InitValue = '';
            Caption = 'Survey Participant Other Details';
            Editable = false;
        }

        field(27; SurveyBatchReference; Code[50])
        {
            InitValue = '';
            Caption = 'Survey Batch Reference';
            Editable = false;
        }
        field(28; SurveySourceReference; Code[50])
        {
            Caption = 'Survey Source Reference';
            Editable = false;
        }

        field(29; SurveySourceApplication; Code[50])
        {
            InitValue = 'CBS';
            Caption = 'Survey Source Application';
            Editable = false;
        }

        field(30; SurveyCategory; Code[50])
        {
            Caption = 'Survey Category';
            Editable = false;
        }

        field(31; SurveyPriority; Integer)
        {
            InitValue = 220;
            Caption = 'Survey Priority';
            Editable = false;
        }

        field(32; SurveyDateCreated; DateTime)
        {
            Caption = 'Survey Date Created';
            Editable = false;
        }

        field(33; SurveyScheduled; Code[10])
        {
            Caption = 'Survey Scheduled';
            Editable = false;
            InitValue = 'NO'; //YES
        }

        field(34; SurveyDateScheduled; DateTime)
        {
            Caption = 'Survey Date Scheduled';
            Editable = false;
        }

        field(35; SurveyOtherDetails; Text[500])
        {
            InitValue = '';
            Caption = 'Survey Other Details';
            Editable = false;
        }

        field(100; CreatedAt; DateTime)
        {
            Caption = 'Created At';
            Editable = false;
        }
        field(101; CreatedBy; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(102; "Sky Survey Type"; enum "Sky Survey Triggers")
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; EntryNo)
        {
            Clustered = true;
        }

        key(OriginatorUnique; OriginatorID)
        {
            Unique = true;
        }

        key(StatusIdx; StatusCode, StatusDate) { }
        key(ParticipantIdx; SurveyParticipantIdentifier) { }
    }

    trigger OnInsert()
    var
        myInt: Integer;
    begin
        CreatedAt := CurrentDateTime;
        CreatedBy := UserId;
    end;
}
