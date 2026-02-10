table 52185945 "Contract Documents"
{

    fields
    {
        field(1; "Document Type"; Code[50])
        {
        }
        field(2; Description; Text[150])
        {
        }
        field(3; "File Location"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Document Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

