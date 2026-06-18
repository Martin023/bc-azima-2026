table 52185702 "Image Data"
{

    fields
    {
        field(1; "ID Number"; Code[20])
        {
        }
        field(2; Picture; Blob)
        {
            SubType = Bitmap;
          
        }
        field(3; Signature; Blob)
        {
            SubType = Bitmap;            
        }
        field(4; "Member No"; Code[20])
        {
            Description = 'LookUp to Member Table';
            TableRelation = Members;
        }
        field(5; FingerOne; BLOB)
        {
            SubType = Memo;
        }
        field(6; FingerTwo; BLOB)
        {
            SubType = Memo;
        }
        field(7; FingerThree; BLOB)
        {
            SubType = Memo;
        }
        field(8; FingerFour; BLOB)
        {
            SubType = Memo;
        }
        field(9; "ID Card Front"; BLOB)
        {
            SubType = Bitmap;
        }
        field(10; "ID Card Back"; BLOB)
        {
            SubType = Bitmap;
        }
        field(11;"Old Member No."; Code[20])
        {
            Description = 'LookUp to Member Table';
            TableRelation = Members;
        }

    }

    keys
    {
        key(Key1; "Member No", "Old Member No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

