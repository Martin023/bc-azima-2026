table 52186011 "Lease Bill Lines"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
        }
        field(2; "Lease No."; Code[20])
        {
        }
        field(3; "Charge No."; Code[20])
        {
        }
        field(4; "Charge Name"; Text[100])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; GLAccount; Decimal)
        {
        }
        field(7; "Invoice No."; Code[20])
        {
        }
        field(8; "Date Invoiced"; Date)
        {
        }
        field(9; "Invoiced By"; Code[20])
        {
        }
        field(10; "Global Dimension 1 Code"; Code[20])
        {
        }
        field(11; "Global Dimension 2 Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

