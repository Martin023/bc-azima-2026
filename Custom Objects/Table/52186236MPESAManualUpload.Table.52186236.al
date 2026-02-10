table 52186236 "M-PESA Manual Upload"
{

    fields
    {
        field(1; "Entry Code"; Code[20])
        {
        }
        field(2; "Transaction ID"; Code[20])
        {
        }
        field(3; "Transaction Date"; DateTime)
        {
        }
        field(4; Transaction; Text[30])
        {
        }
        field(5; Description; Text[100])
        {
        }
        field(6; "Account No"; Code[50])
        {
        }
        field(7; Amount; Decimal)
        {
        }
        field(8; "Phone No"; Code[30])
        {
        }
        field(9; "Request Application"; Text[30])
        {
        }
        field(10; "Request Correlation ID"; Text[30])
        {
        }
        field(11; "Source Application"; Text[30])
        {
        }
        field(12; "Destination Acc"; Text[30])
        {
        }
        field(13; "Destination Name"; Text[30])
        {
        }
        field(14; "Destination Org"; Text[30])
        {
        }
        field(15; "Client Phone Number"; Code[30])
        {
        }
        field(16; "Customer Name"; Text[50])
        {
        }
        field(17; Validate; Boolean)
        {
        }
        field(18; Post; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Entry Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

