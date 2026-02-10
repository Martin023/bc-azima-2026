table 52185856 "Bank Transfer Modes"
{
    LookupPageID = "Bank Transfer Modes";

    fields
    {
        field(1; "Document No."; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Transaction Type"; Code[20])
        {
            TableRelation = "Transaction Types" WHERE(Type = CONST("Bank Transfer Mode"));
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

