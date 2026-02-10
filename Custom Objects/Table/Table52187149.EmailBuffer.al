table 52187149 "Sky Email Buffer"
{
    DataClassification = ToBeClassified;
    //DrillDownPageId = "Sky Email Buffer";

    fields
    {
        field(1; "originator_id"; Code[100])
        {
            Caption = 'originator_id';
            Editable = false;
        }
        field(2; "status_code"; Code[20])
        {
            Editable = false;
        }
        field(3; status_name; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; status_description; Code[500])
        {
            DataClassification = ToBeClassified;
        }
        field(5; status_date; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(6; sender_email_name; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(7; sender_email_address; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(8; receiver_email_addresses; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "email_type"; Text[50])
        {
            Caption = 'Email Type';
            // OptionMembers = " ",INBOUND_EMAIL,OUTBOUND_EMAIL;
        }


        field(10; email_subject; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "email_content_type"; Text[50])
        {
            Caption = 'email_content_type';
            // OptionMembers = " ",TEXT,HTML;
        }

        field(12; "sensitivity"; Text[20])
        {
            Caption = 'sensitivity';
            // OptionMembers = NORMAL,PERSONAL,PRIVATE,CONFIDENTIAL;
        }

        field(13; "category"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(14; "priority"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "send_count"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; request_application; text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(17; request_correlation_id; text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(18; source_application; text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(19; source_reference; text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "schedule_email"; Text[5])
        {
            Caption = 'schedule_email';
            // OptionMembers = YES,NO;
        }
        field(21; date_scheduled; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(22; send_integrity_hash; text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(23; general_flag; text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(24; date_created; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(25; email_message_body; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(26; attachments; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(27; bc_date; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    trigger OnInsert()
    begin
        bc_date := Today;
    end;
}