table 52186070 "Online Tokens"
{

    fields
    {
        field(1; No; Integer)
        {
        }
        field(2; IdNo; Text[200])
        {
        }
        field(3; MemberNo; Text[200])
        {
        }
        field(4; Token; Text[200])
        {
        }
        field(5; "Date Created"; DateTime)
        {
        }
        field(6; Category; Text[200])
        {
        }
        field(7; Verified; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

