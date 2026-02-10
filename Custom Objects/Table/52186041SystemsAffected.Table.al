table 52186041 "Systems Affected"
{
    DrillDownPageID = "Systems Affected";
    LookupPageID = "Systems Affected";

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Systems Affected"; Code[20])
        {
        }
        field(3; "Reason For Request"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Line No", "Systems Affected")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

