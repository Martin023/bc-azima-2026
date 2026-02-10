table 52185437 "Pictures and Signtures"
{

    fields
    {
        field(1; "Member No"; Code[20])
        {
        }
        field(2; "Picture No"; Code[20])
        {
        }
        field(3; "Signature No"; Text[30])
        {
        }
        field(4; Picture; BLOB)
        {
            SubType = Bitmap;
        }
        field(5; Signature; BLOB)
        {
            SubType = Bitmap;
        }
    }

    keys
    {
        key(Key1; "Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

