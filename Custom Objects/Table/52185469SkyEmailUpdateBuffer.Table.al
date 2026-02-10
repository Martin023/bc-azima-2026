table 52185469 "Sky Email Update Buffer"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Member No."; Code[20])
        {
        }
        field(3; Name; Text[200])
        {
        }
        field(4; Email; Text[200])
        {
        }
        field(5; Validated; Boolean)
        {
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "Posted By"; Code[100])
        {
        }
        field(8; "Date Posted"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

