table 52185427 "Loan Schedule Error Log"
{
    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement= true;
        }
        field(2; "Loan No."; Code[20])
        {
        }
        field(3; "Error"; Text[1000])
        {
            
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

