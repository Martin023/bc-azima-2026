table 52186226 "Delegates Returns Lines"
{
    DrillDownPageID = "Return Lines List";
    LookupPageID = "Return Lines List";

    fields
    {
        field(1; "Header No"; Code[30])
        {
        }
        field(2; "Caption Type"; Code[50])
        {
        }
        field(3; "Phone Number"; Text[14])
        {
        }
        field(4; "ID/Personal/Member Number"; Code[20])
        {
        }
        field(5; Name; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Header No", "Caption Type", "Phone Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

