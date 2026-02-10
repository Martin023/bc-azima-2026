table 52185965 "Cases Noitification"
{

    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; Mention; Text[100])
        {
        }
        field(3; Judgment; Text[100])
        {
        }
        field(4; Hearing; Text[100])
        {
        }
        field(5; "Action Required"; Text[100])
        {
        }
        field(6; "Hearing Date"; Date)
        {
        }
        field(7; "Expiry Date For Leases"; Date)
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

