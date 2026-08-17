table 52185925 "HR SMS Template"
{
    Caption = 'HR SMS Template';
    DataClassification = CustomerContent;
    DrillDownPageId = "HR SMS Template List";
    LookupPageId = "HR SMS Template List";

    fields
    {
        field(1; "Event Code"; Code[50])
        {
            Caption = 'Event Code';
            NotBlank = true;
        }
        field(2; "Recipient Role"; Option)
        {
            Caption = 'Recipient Role';
            OptionCaption = 'Applicant,Reliever,Supervisor,HOD,CEO,Custom';
            OptionMembers = Applicant,Reliever,Supervisor,HOD,CEO,Custom;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(4; Body; Text[320])
        {
            Caption = 'Message Body';
            // MAX 320 CHARS — COVERS MULTI-PART SMS. USE TOKENS E.G. [EMPLOYEE_NAME]
        }
        field(5; Enabled; Boolean)
        {
            Caption = 'Enabled';
            InitValue = true;
        }
        field(6; "SMS Source"; Enum "SMS Source")
        {
            Caption = 'SMS Source';
            // CONTROLS PRIORITY AND CATEGORY IN THE SKY SMS QUEUE
        }
        field(7; "Created By"; Code[100])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(8; "Created Date"; Date)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(9; "Modified By"; Code[100])
        {
            Caption = 'Modified By';
            Editable = false;
        }
        field(10; "Modified Date"; Date)
        {
            Caption = 'Modified Date';
            Editable = false;
        }
        field(11; "Send to CC"; Boolean)
        {
            Caption = 'Send to CC';
            DataClassification = CustomerContent;
            InitValue = false;
        }
        field(12; "CC Phone Numbers"; Text[250])
        {
            Caption = 'CC Phone Numbers';
            DataClassification = CustomerContent;
            ToolTip = 'Comma-separated phone numbers for CC recipients (e.g., 0722123456,0733456789,0711222333)';
        }
        field(13; "CC Body"; Text[320])
        {
            Caption = 'CC Message Body';
            DataClassification = CustomerContent;
            ToolTip = 'Optional alternative message for CC recipients. Leave empty to use main body. Uses same tokens as main body.';
        }
    }

    keys
    {
        key(Key1; "Event Code", "Recipient Role")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created Date" := Today;
    end;

    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modified Date" := Today;
    end;
}
