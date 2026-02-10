table 52186092 "DCS Customer Credit Score"
{

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            TableRelation = "Social Listening Sites App.";
        }
        field(2; "Product Code"; Code[20])
        {
            TableRelation = "Product Factory"."Product ID";
        }
        field(3; "Parameter Code"; Code[20])
        {
            TableRelation = "DCS Parameter".Code;
        }
        field(4; Score; Decimal)
        {
        }
        field(5; "Calculated Success"; Decimal)
        {
        }
        field(6; "Calculated Failure"; Decimal)
        {
        }
        field(7; "Requested Amount"; Decimal)
        {
        }
        field(8; "Qualifying Amount"; Decimal)
        {
        }
        field(9; RequestTime; DateTime)
        {
        }
        field(10; "General Output"; Text[100])
        {
        }
        field(11; "Application Priority"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Customer No.", "Product Code", "Parameter Code")
        {
            Clustered = true;
        }
        key(Key2; "Application Priority")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        RequestTime := CurrentDateTime;
    end;
}

