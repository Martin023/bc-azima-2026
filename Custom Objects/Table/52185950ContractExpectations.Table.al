table 52185950 "Contract Expectations"
{

    fields
    {
        field(1; "Expectation Code"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Expectation Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

