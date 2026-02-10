table 52185661 "prNet Pay"
{

    fields
    {
        field(1; "Employee Code"; Code[10])
        {
        }
        field(2; Amount; Decimal)
        {
        }
        field(3; "Amount LCY"; Decimal)
        {
        }
        field(4; Currency; Code[10])
        {
        }
        field(5; "Payroll Period"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Payroll Period")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

