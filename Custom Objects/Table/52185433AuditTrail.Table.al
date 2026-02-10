table 52185433 "Audit Trail"
{

    fields
    {
        field(1; "Delegate No"; Code[10])
        {
        }
        field(3; Description; Text[250])
        {
        }
        field(4; Date; DateTime)
        {
        }
        field(5; DateVerified; DateTime)
        {
        }
    }

    keys
    {
        key(Key1; "Delegate No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

