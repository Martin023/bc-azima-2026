table 52185830 "Email Status"
{

    fields
    {
        field(1; "Entry No"; Code[10])
        {
        }
        field(2; "Member No"; Code[20])
        {
        }
        field(3; Period; Date)
        {
        }
        field(4; Date; Date)
        {
        }
        field(5; Sent; Boolean)
        {
        }
        field(6; "Member Name"; Text[100])
        {
        }
        field(7; "User ID"; Code[50])
        {
        }
        field(8; Time; Time)
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

