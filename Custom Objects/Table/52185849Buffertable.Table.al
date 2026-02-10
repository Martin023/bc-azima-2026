table 52185849 "Buffer table"
{

    fields
    {
        field(1; "Doc No"; Text[250])
        {
        }
        field(2; "Entry No"; Integer)
        {
        }
        field(3; "Counter Variable"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Doc No", "Entry No", "Counter Variable")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

