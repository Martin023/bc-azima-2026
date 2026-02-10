table 52185911 "Value Posting"
{

    fields
    {
        field(1; UserID; Code[50])
        {
            TableRelation = User."User Name";
        }
        field(2; "Value Posting"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; UserID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

