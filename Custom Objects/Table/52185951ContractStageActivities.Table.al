table 52185951 "Contract Stage Activities"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; Stage; Code[20])
        {
        }
        field(15; "Contract Line Type"; Code[10])
        {
            NotBlank = true;
            TableRelation = "Contract Lines Types"."Contract Line Type";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

