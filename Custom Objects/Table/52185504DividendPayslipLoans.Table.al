table 52185504 "Dividend Payslip Loans"
{

    fields
    {
        field(1; "Loan No"; Code[30])
        {
        }
        field(2; Balance; Decimal)
        {
        }
        field(3; Name; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Loan No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

