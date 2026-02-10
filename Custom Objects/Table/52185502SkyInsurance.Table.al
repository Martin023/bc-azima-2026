table 52185502 "Sky Insurance"
{
    DrillDownPageId = "Insurance List";
    LookupPageId = "Insurance List";

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Session ID"; Code[50])
        {
        }
        field(3; Purpose; Code[50])
        {
        }
        field(4; Email; Text[30])
        {
        }
        field(5; "Phone Number"; Code[15])
        {
        }
        field(6; "Entry Time"; Time)
        {
        }
        field(7; "Entry Date"; Date)
        {
        }
        field(8; Names; Text[50])
        {
        }
        field(9; Actioned; Boolean)
        {
        }
        field(10; "Actioned By"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

