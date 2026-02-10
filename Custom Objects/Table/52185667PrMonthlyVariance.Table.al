table 52185667 "PrMonthly Variance"
{

    fields
    {
        field(1; "Trans Code"; Code[10])
        {
        }
        field(2; "Employee code"; Code[10])
        {
        }
        field(3; Period; Integer)
        {
        }
        field(4; "Curr Amount"; Decimal)
        {
        }
        field(5; "Prev Amount"; Decimal)
        {
        }
        field(6; Variance; Decimal)
        {
        }
        field(7; "lineNo."; Integer)
        {
            AutoIncrement=true;
        }
        field(8; "Trans Name"; Text[40])
        {
        }
        field(9; "User Name"; Text[30])
        {
        }
        field(10; "Current Period"; Date)
        {
        }
        field(11; "Previous Period"; Date)
        {
        }
        field(12; "Employee Name"; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; "lineNo.")
        {
            Clustered = true;
        }
        key(Key2; "Employee code")
        {
        }
        key(Key3; "Curr Amount")
        {
        }
        key(Key4; "Trans Code")
        {
        }
    }

    fieldgroups
    {
    }
}

