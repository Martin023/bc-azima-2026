table 52185996 Stages
{

    fields
    {
        field(1; Stage; Code[20])
        {
        }
        field(2; Duration; Integer)
        {
        }
        field(3; Description; Text[60])
        {
        }
        field(15; "Contract Line Type"; Code[10])
        {
            NotBlank = true;
            //TableRelation = Table39006053.Field4;
        }
    }

    keys
    {
        key(Key1; Stage)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

