table 52186207 "HR Medical Scheme Rates"
{

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Medical Scheme No."; Code[30])
        {
        }
        field(3; Type; Option)
        {
            OptionCaption = ',Inpatient,Outpatient';
            OptionMembers = ,Inpatient,Outpatient;
        }
        field(4; Limit; Decimal)
        {
        }
        field(5; M; Decimal)
        {
        }
        field(6; "M+1"; Decimal)
        {
        }
        field(7; "M+2"; Decimal)
        {
        }
        field(8; "M+3"; Decimal)
        {
        }
        field(9; "M+4"; Decimal)
        {
        }
        field(10; "M+5"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Medical Scheme No.", Type, Limit)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

