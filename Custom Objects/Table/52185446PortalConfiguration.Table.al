table 52185446 "Portal Configuration"
{

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Min Price"; Decimal)
        {
        }
        field(3; "Max Price"; Decimal)
        {
        }
        field(4; "Min Shares"; Decimal)
        {
        }
        field(5; "Max Shares"; Decimal)
        {
        }
        field(6; "Trading Frequency"; Text[30])
        {
        }
        field(7; "Trading Day"; Text[30])
        {
        }
        field(8; "Floating Charges"; Decimal)
        {
        }
        field(9; "Bidding Charges"; Decimal)
        {
        }
        field(10; "Charging Type"; Option)
        {
            OptionCaption = ',Fixed,Percentage';
            OptionMembers = ,"Fixed",Percentage;
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

