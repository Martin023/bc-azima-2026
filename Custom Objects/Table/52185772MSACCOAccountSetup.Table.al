table 52185772 "M-SACCO Account Setup"
{

    fields
    {
        field(1; "Account Type"; Code[30])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Bank Account No"; Code[10])
        {
            TableRelation = "Bank Account";
        }
        field(4; "Vendor No"; Code[10])
        {
            TableRelation = Vendor;
        }
        field(5; ChargeAmount; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Account Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

