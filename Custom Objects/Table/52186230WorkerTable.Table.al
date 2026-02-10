table 52186230 "Worker Table"
{

    fields
    {
        field(1; "Loan No"; Code[50])
        {
        }
        field(2; "Member No"; Code[50])
        {
        }
        field(3; "Total Balance"; Decimal)
        {
        }
        field(4; File; BLOB)
        {
            SubType = Memo;
        }
    }

    keys
    {
        key(Key1; "Loan No", "Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

