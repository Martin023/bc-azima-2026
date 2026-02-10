table 52186043 "Reason For Request"
{
    DrillDownPageID = "Reason For Request";
    LookupPageID = "Reason For Request";

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Category; Text[150])
        {
        }
        field(3; "System Affected"; Code[10])
        {
            TableRelation = "Systems Affected"."Systems Affected";
        }
        field(4; "Reason for Request"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Line No", Category, "Reason for Request")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

