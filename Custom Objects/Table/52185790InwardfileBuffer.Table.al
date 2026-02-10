table 52185790 "Inward file Buffer"
{

    fields
    {
        field(1; "Clearing System"; Code[20])
        {
        }
        field(2; "Serial No"; Code[20])
        {
        }
        field(3; "Transaction Code"; Code[20])
        {
        }
        field(4; "Branch Code"; Code[20])
        {
        }
        field(5; "Account No"; Code[20])
        {
        }
        field(6; "Branch Code 2"; Code[20])
        {
        }
        field(7; "Cheque No"; Code[20])
        {
        }
        field(8; Currency; Code[20])
        {
        }
        field(9; Amount; Decimal)
        {
        }
        field(10; "Date Code1"; Code[20])
        {
        }
        field(11; "Date Code2"; Code[20])
        {
        }
        field(12; "Bank Code"; Code[20])
        {
        }
        field(13; "Unused 1"; Code[20])
        {
        }
        field(14; "Unused 2"; Code[20])
        {
        }
        field(15; "Unused 3"; Code[20])
        {
        }
        field(16; "Bank Code 2"; Code[20])
        {
        }
        field(17; "Branch Code 3"; Code[20])
        {
        }
        field(18; "Unused 4"; Code[20])
        {
        }
        field(19; "Unused 5"; Code[20])
        {
        }
        field(20; "Unused 6"; Code[20])
        {
        }
        field(21; "Unused 7"; Code[20])
        {
        }
        field(22; CurrentUserID; Code[100])
        {
        }
        field(23; Primary; Integer)
        {
        }
        field(24; "Transaction Code2"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Transaction Code", "Serial No", "Clearing System")
        {
            Clustered = true;
        }
        key(Key2; "Clearing System")
        {
        }
    }

    fieldgroups
    {
    }
}

