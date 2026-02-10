table 52186054 "Online Loan Guarantors"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Loan Application No"; Integer)
        {
        }
        field(3; "Guarantor No."; Text[100])
        {
        }
        field(4; "Guarantor Names"; Text[100])
        {
        }
        field(5; "Guarantor Email"; Text[100])
        {
        }
        field(6; "Guarantor ID No"; Text[100])
        {
        }
        field(7; "Guarantor Amount"; Decimal)
        {
        }
        field(8; "Guarantor Phone"; Text[50])
        {
        }
        field(9; Approved; Boolean)
        {
        }
        field(10; "Approval Status"; Boolean)
        {
        }
        field(11; "Applicant No"; Text[50])
        {
        }
        field(12; "Applicant Name"; Text[150])
        {
        }
        field(13; "Applicant Mobile"; Text[100])
        {
        }
        field(14; "Loan Type"; Text[30])
        {
        }
        field(15; "Loan Description"; Text[100])
        {
        }
        field(16; "Self Guarantee"; Boolean)
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

