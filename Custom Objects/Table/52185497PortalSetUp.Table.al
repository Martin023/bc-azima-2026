table 52185497 "Portal SetUp"
{

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Portal Url"; Text[100])
        {
        }
        field(3; "Member Type"; Option)
        {
            OptionMembers = All,Staff,"Non-Staff";
        }
        field(4; "SMS Type"; Option)
        {
            OptionMembers = Informational,Password;
        }
        field(5; "Delegate Quorum"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

