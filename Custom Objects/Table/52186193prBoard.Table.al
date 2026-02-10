table 52186193 prBoard
{

    fields
    {
        field(1; "Line No"; Integer)
        {
        }
        field(2; "Member No."; Code[10])
        {
            TableRelation = "Board members"."No.";
        }
        field(3; "Code"; Code[10])
        {
        }
        field(4; Date; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Line No", "Member No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

