table 52185491 "Sky New Members Buffer"
{

    fields
    {
        field(4; Phone; Text[30])
        {
        }
        field(5; "ID No"; Integer)
        {
        }
        field(6; "Date of Birth"; Date)
        {
        }
        field(7; "Montly Amount"; Decimal)
        {
        }
        field(8; "Next of Kin"; Text[50])
        {
        }
        field(9; Relationship; Text[30])
        {
        }
        field(10; "NOK ID No"; Integer)
        {
        }
        field(11; "NOK Phone"; Text[30])
        {
        }
        field(12; "Start Date"; Text[30])
        {
        }
        field(13; Created; Boolean)
        {
        }
        field(14; Erroneous; Boolean)
        {
        }
        field(15; "Error Message"; Text[50])
        {
        }
        field(16; "Created By"; Code[30])
        {
        }
        field(17; "Created At"; DateTime)
        {
        }
        field(18; "First Name"; Text[30])
        {
        }
        field(19; "Second Name"; Text[30])
        {
        }
        field(20; "Last Name"; Text[30])
        {
        }
        field(21; "Service Number"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "ID No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

