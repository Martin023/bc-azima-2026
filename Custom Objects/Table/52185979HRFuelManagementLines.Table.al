table 52185979 "HR Fuel Management Lines"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; "Vehicle Registration No."; Code[10])
        {
        }
        field(3; "Type Of Payment"; Code[10])
        {
        }
        field(4; "Total Cost"; Decimal)
        {
        }
        field(5; Driver; Code[10])
        {
        }
        field(6; "Vehicle Fueled"; Boolean)
        {
        }
        field(7; "Vehicle Name"; Text[50])
        {
        }
        field(8; Performance; Text[30])
        {
        }
        field(9; "Source of Fueling"; Code[10])
        {
        }
        field(10; "Fuel Cost"; Decimal)
        {
        }
        field(11; "Type of Fuel"; Code[10])
        {
        }
        field(12; "Fuel Consumed"; Decimal)
        {
        }
        field(13; "Date/Time"; DateTime)
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

