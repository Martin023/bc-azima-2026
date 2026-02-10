table 52186102 "DCS Data Source"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Source Name"; Text[100])
        {
        }
        field(3; "API Private Key"; Code[100])
        {
        }
        field(4; "API Public Key"; Code[100])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

