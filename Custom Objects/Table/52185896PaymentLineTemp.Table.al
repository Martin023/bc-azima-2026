table 52185896 "Payment Line Temp"
{

    fields
    {
        field(1; "Document No"; Code[20])
        {
        }
        field(2; "Member No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Document No", "Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

