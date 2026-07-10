table 52185567 "Trigger Survey Setup"
{
    Caption = 'Trigger Survey Setup';
    DataClassification = ToBeClassified;

    LookupPageId = "Trigger Survey Setup";
    DrillDownPageId = "Trigger Survey Setup";

    fields
    {
        field(1; EntryNo; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
            Caption = 'Entry No.';
            Editable = false;
        }

        field(2; ProductID; Integer)
        {
            Caption = 'Product ID';
        }
        field(3; PublishID; Integer)
        {
            Caption = 'Publish ID';
        }
        field(4; ChannelCode; Integer)
        {
            Caption = 'Channel Code';
        }

        field(5; SurveyType; Code[50])
        {
            Editable = false;
            InitValue = 'REQUEST';
            Caption = 'Survey Type';
        }

        field(6; SurveyAction; Code[50])
        {
            Editable = false;
            InitValue = 'PUSH';
            Caption = 'Survey Action';
        }

        field(7; SurveyCommand; Code[50])
        {
            Editable = false;
            InitValue = 'RequestSurveySendSMS';
            Caption = 'Survey Command';
        }

        field(8; SurveySensitivity; Code[50])
        {
            Editable = false;
            InitValue = 'NORMAL';
            Caption = 'Survey Sensitivity';
        }

        field(9; TriggerMode; Code[50])
        {
            Editable = false;
            InitValue = 'SYSTEM_PROCESS';
            Caption = 'Trigger Mode';
        }

        field(10; TriggerType; Code[50])
        {
            Caption = 'Trigger Type';
        }

        field(11; TriggerName; Text[150])
        {
            Caption = 'Trigger Name';
        }
        field(12; TriggerDescription; Text[500])
        {
            Caption = 'Trigger Description';
        }

        field(13; TriggerOtherDetails; Text[500])
        {
            Editable = false;
            InitValue = '';
            Caption = 'Trigger Other Details';
        }

        field(14; SurveyCategory; Code[50])
        {
            Caption = 'Survey Category';
        }

        field(15; SurveyPriority; Integer)
        {
            Editable = false;
            InitValue = 220;
            Caption = 'Survey Priority';
        }

        field(16; SurveyOtherDetails; Text[500])
        {
            Editable = false;
            InitValue = '';
            Caption = 'Survey Other Details';
        }

        field(26; "Sky Survey Type"; enum "Sky Survey Triggers")
        {
            DataClassification = ToBeClassified;
        }

        field(27; "Is Enabled?"; Boolean)
        {
            DataClassification = ToBeClassified;
            InitValue = false;
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
        field(102; ModifiedAt; DateTime)
        {
            Caption = 'Modified At';
            Editable = false;
        }
        field(103; ModifiedBy; Code[50])
        {
            Caption = 'Modified By';
            Editable = false;
        }
    }

    keys
    {
        key(PK; EntryNo)
        {
            Clustered = true;
        }

        key(TriggerTypeUnique; TriggerType)
        {
            Unique = true;
        }

    }

    trigger OnInsert()
    var
        myInt: Integer;
    begin
        CreatedAt := CurrentDateTime;
        CreatedBy := UserId;
    end;

    trigger OnModify()
    var
        myInt: Integer;
    begin
        ModifiedAt := CurrentDateTime;
        ModifiedBy := UserId;
    end;
}