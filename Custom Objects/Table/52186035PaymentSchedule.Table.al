table 52186035 "Payment Schedule"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Lease No"; Code[20])
        {
        }
        field(3; "Invoice Date"; Date)
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; Paid; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Line No", "Lease No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

