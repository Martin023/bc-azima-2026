table 52186048 "ISO-Defined Data Elements"
{

    fields
    {
        field(1; "Data Element"; Integer)
        {
        }
        field(2; Type; Text[50])
        {
        }
        field(3; Usage; Text[250])
        {
        }
        field(4; Length; Integer)
        {
        }
        field(5; "Variable Field"; Integer)
        {
        }
        field(6; "Variable Field Length"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Data Element")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

