table 52186034 Zones
{
    DrillDownPageID = "Terminate Lease-Active";
    LookupPageID = "Terminate Lease-Active";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Zone Name"; Text[50])
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

