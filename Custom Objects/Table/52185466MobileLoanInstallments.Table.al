table 52185466 "Mobile Loan Installments"
{

    fields
    {
        field(1; Product; Code[20])
        {
        }
        field(2; Installments; Integer)
        {
        }
        field(3; Caption; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; Product, Installments)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

