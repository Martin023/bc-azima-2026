table 52185767 "M-SACCO Guarantors"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Msacco Loans Entry No"; Code[50])
        {
        }
        field(3; "Guarontor Telephone No"; Code[50])
        {
        }
        field(4; "Guarontor Account No"; Code[50])
        {
        }
        field(5; "Guarontor Name"; Text[100])
        {
        }
        field(6; "Applicant Telephone No"; Code[50])
        {
        }
        field(7; Posted; Boolean)
        {
        }
        field(8; "Date Received"; DateTime)
        {
        }
        field(9; "Loan No"; Code[20])
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

