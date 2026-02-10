table 52186206 "Performance Attributes1"
{

    fields
    {
        field(1; Attribute; Code[50])
        {
        }
        field(2; Description; Text[250])
        {
        }
        field(3; Target; Decimal)
        {
        }
        field(4; Weight; Decimal)
        {
        }
        field(5; "Additonal Comments"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; Attribute)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

