table 52186220 "Posting Times"
{

    fields
    {
        field(1; ID; Text[30])
        {
        }
        field(2; "Transaction ID"; Text[30])
        {
        }
        field(3; Stage; Integer)
        {
        }
        field(4; "Log Time"; DateTime)
        {
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

