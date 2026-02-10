table 52185432 "ATM Nos"
{

    fields
    {
        field(4; "Loan Namber"; Code[30])
        {
        }
        field(5; "EMployer LN"; Code[30])
        {
        }
        field(6; tt; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Loan Namber")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

