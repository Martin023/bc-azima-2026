table 52186144 "Statement Requests"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Member No"; Text[30])
        {
        }
        field(3; "Email Address"; Text[100])
        {
        }
        field(4; Posted; Boolean)
        {
            Editable = false;
        }
        field(5; "Date Requested"; Date)
        {
        }
        field(6; "FOSA/BOSA"; Option)
        {
            OptionCaption = 'FOSA,BOSA';
            OptionMembers = FOSA,BOSA;
        }
        field(7; Skipped; Boolean)
        {
            Editable = false;
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

