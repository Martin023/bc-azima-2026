table 52185617 "prBank SFI"
{

    fields
    {
        field(1; "Line Code"; Code[10])
        {
        }
        field(2; "SFI Header"; Text[150])
        {
        }
        field(3; "SFI Body"; Text[150])
        {
        }
        field(4; "SFI Footer"; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; "Line Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

