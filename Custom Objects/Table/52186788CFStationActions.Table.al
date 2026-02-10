table 52186788 "CF Station Actions"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Department; Code[20])
        {
            TableRelation = "Responsibility CenterBR";
        }
        field(3; "Allowed Action"; Enum "CF Station Actions")
        {

        } 
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

}

