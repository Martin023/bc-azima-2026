table 52186038 "Salary Agreement Counter"
{

    fields
    {
        field(1; "Recruted By"; Code[50])
        {
        }
        field(2; "Recruted By Name"; Text[50])
        {
        }
        field(3; "Count"; Integer)
        {
        }
        field(4; "Branch Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Recruted By")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

