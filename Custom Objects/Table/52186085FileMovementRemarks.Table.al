table 52186085 "File Movement Remarks"
{
    LookupPageID = "File MVT Remarks";
    DrillDownPageId = "File MVT Remarks";

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; Description; CODE[50])
        {
        }
        field(3; Stage; option)
        {
            OptionMembers = "File Location",Archives;
        }
        field(4; "Responsibility Centre"; Code[20])
        {
            TableRelation = "Responsibility CenterBR";
        }
    }

    keys
    {
        key(Key1; "No.", Description)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

