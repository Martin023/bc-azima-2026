table 52186507 "EDMS Scanned Apps. Log"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Type of Application"; enum "CRM Originations")
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Application No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Member No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Scanned; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Created By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Originating Branch"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}