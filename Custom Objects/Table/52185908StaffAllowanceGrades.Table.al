table 52185908 "Staff Allowance Grades"
{

    fields
    {
        field(1; "Grade Code"; Code[10])
        {
        }
        field(2; "Grade Description"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Grade Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

