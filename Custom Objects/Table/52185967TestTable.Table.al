table 52185967 TestTable
{

    fields
    {
        field(1; "Staff No."; Code[20])
        {
        }
        field(2; "Full Name"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Staff No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

