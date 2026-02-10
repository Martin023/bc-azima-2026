table 52185495 "Password History"
{

    fields
    {
        field(2; "Member Number"; Code[30])
        {
        }
        field(3; "Phone Number"; Text[30])
        {
        }
        field(4; Password; Text[250])
        {
        }
        field(5; "E-Mail"; Text[50])
        {
        }
        field(6; "Current Password"; Boolean)
        {
        }
        field(7; "Account Number"; Code[30])
        {
        }
        field(8; "Entry No"; Integer)
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

