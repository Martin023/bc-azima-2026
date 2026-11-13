table 85501 "Dividend Slip Years Buffer"
{

    fields
    {
        field(1; Year; Integer)
        {
        }
    }

    keys
    {
        key(Key1; Year)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

