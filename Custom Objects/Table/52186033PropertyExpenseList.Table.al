table 52186033 "Property Expense List"
{

    fields
    {
        field(1; "Expense Code"; Code[10])
        {
        }
        field(2; "Expense Description"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Expense Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

