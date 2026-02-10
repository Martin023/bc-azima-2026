table 52185629 "prJournal Analyzers"
{

    fields
    {
        field(1; "Analysis Code"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Is Used"; Boolean)
        {
        }
        field(4; Mandatory; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Analysis Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

