table 52185720 "Bank Code Structure"
{
    DrillDownPageID = "Bank Code Structure";
    LookupPageID = "Bank Code Structure";

    fields
    {
        field(1; Code; Code[20])
        {
            NotBlank = true;
        }
        field(2; Name; Text[150])
        {
        }
        field(3; Type; Option)
        {
            OptionMembers = "Main Bank",Branch;
        }
        field(4; "Parent Code"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, Name)
        {
        }
    }
}

