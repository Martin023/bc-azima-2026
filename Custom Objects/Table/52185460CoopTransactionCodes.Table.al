table 52185460 "Coop Transaction Codes"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; Terminal; Code[30])
        {
        }
        field(4; Channel; Code[30])
        {
        }
        field(5; "Daily Limit"; Decimal)
        {
        }
        field(6; "Coop Bank Account"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(7; "Posting Description"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Code", Terminal, Channel)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

