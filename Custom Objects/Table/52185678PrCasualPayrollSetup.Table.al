table 52185678 "PrCasual Payroll Setup"
{

    fields
    {
        field(1; "Setup Code"; Code[20])
        {
        }
        field(5; "Normal Hours Rate per Hour"; Decimal)
        {
        }
        field(10; "Overtime Hours Rate per Hour"; Decimal)
        {
        }
        field(15; "PHs and Weekends Rate per Hour"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Setup Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

