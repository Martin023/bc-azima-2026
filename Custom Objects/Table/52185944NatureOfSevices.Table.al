table 52185944 "Nature Of Sevices"
{
    DrillDownPageID = "Nature Of Services";
    LookupPageID = "Nature Of Services";

    fields
    {
        field(1; "Service Code"; Code[50])
        {
        }
        field(2; "Service Name"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Service Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ContractCycle: Record "Contract Cycle";
}

