table 52185839 "Loan History"
{

    fields
    {
        field(1; "Loan No."; Code[50])
        {
        }
        field(2; "Loan Product Type"; Code[10])
        {
        }
        field(3; "Loan Status"; Enum "Loan Sasra categories")
        {
        }
        field(4; "Outstanding Interest"; Decimal)
        {
        }
        field(5; "Outstanding Balance"; Decimal)
        {
        }
        field(6; "Outanding Bill"; Decimal)
        {
        }
        field(7; "Loan Application No."; Code[50])
        {
        }
        field(8; "Loan Issued Date"; Date)
        {
        }
        field(9; "Loan Expiry Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Loan No.", "Loan Application No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

