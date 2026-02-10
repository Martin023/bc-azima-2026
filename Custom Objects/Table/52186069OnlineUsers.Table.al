table 52186069 "Online Users"
{
    DrillDownPageId = "Online Users";
    LookupPageId = "Online Users";

    fields
    {
        field(1; "ID Number"; Text[50])
        {
        }
        field(2; Password; Text[50])
        {
        }
        field(5; "Date Created"; DateTime)
        {
        }
        field(6; "Changed Password"; Boolean)
        {
        }
        field(7; Usertype; Text[30])
        {
        }
        field(8; "Last Login"; DateTime)
        {
        }
        field(10; Blocked; Boolean)
        {
        }
        field(11; "BOSA No"; Text[30])
        {
        }
        field(12; "FOSA No"; Text[30])
        {
        }
        field(13; "Micro No"; Text[30])
        {
        }
        field(14; Token; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "ID Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

