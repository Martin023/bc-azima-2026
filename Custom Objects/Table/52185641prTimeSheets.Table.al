table 52185641 prTimeSheets
{

    fields
    {
        field(1; "Schedule Code"; Text[30])
        {
        }
        field(2; "Primary File Path"; Text[150])
        {
        }
        field(3; "Secondary File Path"; Text[150])
        {
        }
        field(4; "Delete After Import"; Boolean)
        {
        }
        field(323; Test; Option)
        {
            OptionMembers = ,Testing;
        }
    }

    keys
    {
        key(Key1; "Schedule Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

