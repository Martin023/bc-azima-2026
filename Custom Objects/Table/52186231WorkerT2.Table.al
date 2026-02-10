table 52186231 "Worker T 2"
{

    fields
    {
        field(1; "Member No"; Code[30])
        {
        }
        field(2; Name; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

