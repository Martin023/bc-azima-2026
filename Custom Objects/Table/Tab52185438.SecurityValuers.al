table 52185438 "Security Valuers"
{
    Caption = 'Security Valuers';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            AutoIncrement = true;
        }
        field(2; "Security No."; Code[50])
        {
            Caption = 'Security No.';
        }
        field(3; "Valuer Name"; Text[200])
        {
            Caption = 'Valuer Name';
        }
        field(4; "Valuer Address"; Code[120])
        {
            Caption = 'Valuer Address';
        }
        field(5; "Valuer Contact"; Code[50])
        {
            Caption = 'Valuer Contact';
        }
    }
    keys
    {
        key(PK; "No.", "Security No.")
        {
            Clustered = true;
        }
    }
}
