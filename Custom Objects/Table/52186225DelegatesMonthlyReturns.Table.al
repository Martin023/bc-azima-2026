table 52186225 "Delegates Monthly Returns"
{

    fields
    {
        field(1; "Header No"; Code[30])
        {
        }
        field(2; Caption; Text[50])
        {
        }
        field(3; "Caption Type"; Code[50])
        {
        }
        field(4; "Total Branch Members"; Integer)
        {
        }
        field(5; "Records Submitted"; Integer)
        {
            CalcFormula = Count("Delegates Returns Lines" WHERE("Header No" = FIELD("Header No"),
                                                                 "Caption Type" = FIELD("Caption Type")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Header No", "Caption Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

