table 52185711 "Dividend Simulation Lines"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
        }
        field(2; "G/L Account"; Code[20])
        {
        }
        field(3; "Start Date"; Date)
        {
        }
        field(4; "End Date"; Date)
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; "Weighted Amount"; Decimal)
        {
        }
        field(7; "No."; Code[20])
        {
            TableRelation = "Dividend Simulation Header"."No.";
        }
        field(8; "Product Type"; Code[10])
        {
        }
        field(9; "Document No."; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Document No.", "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

