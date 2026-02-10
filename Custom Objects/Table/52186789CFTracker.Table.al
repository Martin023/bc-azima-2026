table 52186789 "CF Tracker"
{
    DrillDownPageId = "CF Tracker List";

    fields
    {

        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Header No."; Code[50])
        {
            Editable = false;
        }
        field(3; "At Department"; Code[20])
        {
            TableRelation = "Responsibility CenterBR";
            Editable = false;
        }
        field(4; "Current Department"; Boolean)
        {
            Editable = false;
        }
        field(5; "Forwarded By"; Code[100])
        {
            Editable = false;
        }
        field(6; "Time Forwarded"; DateTime)
        {
            Editable = false;
        }
        field(10; "Viewed By Recepient"; Boolean)
        {
            Editable = false;
        }
        field(11; "Previous Departmant"; Code[20])
        {
            Editable = false;
        }
        field(12; "Checked By"; code[50])
        {
            caption = 'Checked By(At previous dept)';
            Editable = false;
        }

    }

    keys
    {
        key(Key1; "Entry No.", "Header No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

}

