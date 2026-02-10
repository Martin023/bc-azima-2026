table 52186010 "Lease Charge Review"
{
    LookupPageId = "Lease Charge Review View";
    DrillDownPageId = "Lease Charge Review View";

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Lease No."; Code[20])
        {
        }
        field(3; "Charge No."; Code[20])
        {
        }
        field(4; "Charge Name"; Text[100])
        {
        }
        field(5; "Old Amount[Rate]"; Decimal)
        {
        }
        field(6; "Effect Date"; Date)
        {
        }
        field(7; "New [Review Amount]"; Decimal)
        {
        }
        field(8; Effected; Boolean)
        {
        }
        field(9; "Effected Date"; Date)
        {
        }
        field(10; "Effected By"; Code[20])
        {
        }
        field(11; Select; Boolean)
        {
        }
        field(12; "New [Rate Amount]"; Decimal)
        {
        }
        field(13; "Old Amount[Review Amount]"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Line No.", "Charge No.")
        {
            Clustered = true;
        }
        key(Key2; "Charge No.")
        {
        }
    }

    fieldgroups
    {
    }
}

