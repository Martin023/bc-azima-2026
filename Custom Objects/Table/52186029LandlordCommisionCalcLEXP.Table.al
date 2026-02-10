table 52186029 "Landlord Commision Calc LEXP"
{

    fields
    {
        field(1; "No."; Integer)
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Posting Date"; Date)
        {
        }
        field(4; Description; Text[100])
        {
        }
        field(5; "Lease No."; Code[20])
        {
        }
        field(6; "Tenant No."; Code[20])
        {
        }
        field(7; Amount; Decimal)
        {
        }
        field(8; Supplier; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

