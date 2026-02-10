table 52186136 "Withdrawal Reason"
{
    DrillDownPageID = "Withdrawal Reason";
    LookupPageID = "Withdrawal Reason";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Code", Description)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

