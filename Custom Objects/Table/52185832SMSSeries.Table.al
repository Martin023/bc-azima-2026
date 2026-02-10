table 52185832 "SMS Series"
{
    DrillDownPageID = "SMS Series";
    LookupPageID = "SMS Series";

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; "Message Body"; Text[130])
        {
        }
        field(4; "Email Body"; Text[250])
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

