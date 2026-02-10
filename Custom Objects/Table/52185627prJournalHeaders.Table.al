table 52185627 "prJournal Headers"
{

    fields
    {
        field(1; "Trans Period"; Integer)
        {
        }
        field(2; "Trans Year"; Integer)
        {
        }
        field(3; "Country Code"; Code[10])
        {
        }
        field(4; "Journal Type"; Code[10])
        {
        }
        field(5; "Trans Date"; Date)
        {
        }
        field(6; "Currency Code"; Code[10])
        {
        }
        field(7; "JV Ref"; Code[10])
        {
        }
        field(8; Narrative; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Trans Period")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

