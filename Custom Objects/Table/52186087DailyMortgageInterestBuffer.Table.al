table 52186087 "Daily Mortgage Interest Buffer"
{

    fields
    {
        field(1; "Loan No"; Code[20])
        {
        }
        field(2; "Loan Type"; Code[10])
        {
        }
        field(3; "Member No"; Code[10])
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; "Interest Date"; Date)
        {
        }
        field(6; Posted; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Loan No", "Interest Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

