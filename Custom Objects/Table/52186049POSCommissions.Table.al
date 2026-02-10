table 52186049 "POS Commissions"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Lower Limit"; Decimal)
        {
        }
        field(3; "Upper Limit"; Decimal)
        {
        }
        field(4; "Charge Amount"; Decimal)
        {
        }
        field(5; "Sacco charge"; Decimal)
        {
        }
        field(6; "Bank charge"; Decimal)
        {
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

