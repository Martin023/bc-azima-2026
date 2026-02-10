table 52185800 "Tiered Charges Header"
{
    DrillDownPageID = "Tiered Charges List";
    LookupPageID = "Tiered Charges List";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

