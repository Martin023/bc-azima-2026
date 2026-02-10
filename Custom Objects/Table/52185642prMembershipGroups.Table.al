table 52185642 "prMembership Groups"
{
    DrillDownPageID = "prMembership Groups";
    LookupPageID = "prMembership Groups";

    fields
    {
        field(1; "Group No"; Code[10])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Comments; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Group No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

