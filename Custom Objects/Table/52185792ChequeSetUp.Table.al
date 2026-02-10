table 52185792 "Cheque Set Up"
{
    DrillDownPageID = "Cheque Set Up";
    LookupPageID = "Cheque Set Up";

    fields
    {
        field(1; "Cheque Code"; Code[30])
        {
        }
        field(2; "Number Of Leaf"; Code[20])
        {
        }
        field(3; Amount; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Cheque Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Cheque Code", "Number Of Leaf", Amount)
        {
        }
    }
}

