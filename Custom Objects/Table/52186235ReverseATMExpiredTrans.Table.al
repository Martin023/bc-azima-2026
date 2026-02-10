table 52186235 "Reverse ATM Expired Trans"
{

    fields
    {
        field(1; "Trace ID"; Code[50])
        {
        }
        field(2; "Account Number"; Code[50])
        {
        }
        field(3; Amount; Decimal)
        {
        }
        field(4; Name; Text[100])
        {
            CalcFormula = Lookup("Savings Accounts".Name WHERE("No." = FIELD("Account Number")));
            FieldClass = FlowField;
        }
        field(5; Actioned; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Trace ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

