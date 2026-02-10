table 52186223 "Installments Tracker"
{

    fields
    {
        field(1; "Code"; Guid)
        {
        }
        field(2; Intallments; Integer)
        {
        }
        field(3; Installments2; Integer)
        {
        }
        field(4; "Product Code"; Code[30])
        {
        }
        field(5; Date; Date)
        {
        }
        field(6; Time; Time)
        {
        }
        field(7; "Phone Number"; Text[30])
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

