table 52185449 "Shares Successful"
{

    fields
    {
        field(1; No; Code[30])
        {
        }
        field(2; "Market Id"; Code[30])
        {
        }
        field(3; "Bid Id"; Code[30])
        {
        }
        field(4; Owner; Code[30])
        {
        }
        field(5; Bidder; Code[30])
        {
        }
        field(6; "No of Shares"; Decimal)
        {
        }
        field(7; Price; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

