table 52186141 "Loan Categorization"
{
    LookupPageId = "Loan Categorization";
    DrillDownPageId = "Loan Categorization";

    fields
    {
        field(1; "C_Code"; Code[20])
        {
        }
        field(2; "Description"; Text[50])
        {
        }

    }

    keys
    {
        key(Key1; "C_Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


}

