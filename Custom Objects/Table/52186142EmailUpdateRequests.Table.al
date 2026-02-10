table 52186142 "Email Update Requests"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Member No"; Text[30])
        {
        }
        field(3; Email; Text[100])
        {
        }
        field(4; Posted; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

