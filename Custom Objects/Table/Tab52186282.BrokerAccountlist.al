table 52186282 "Broker Account list"
{
    Caption = 'Broker Account list';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Broker Name"; Text[100])
        {
            Caption = 'Broker Name';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
