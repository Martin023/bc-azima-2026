table 52186101 "DCS CRB Account Type"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Type Name"; Text[100])
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

