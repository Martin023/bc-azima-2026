table 52185448 "Shares Bid"
{

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Member; Code[30])
        {
        }
        field(3; "ID No"; Code[30])
        {
        }
        field(4; "No of Shares"; Decimal)
        {
        }
        field(5; Price; Decimal)
        {
        }
        field(6; Successful; Decimal)
        {
        }
        field(7; Status; Option)
        {
            OptionCaption = ',Application';
            OptionMembers = ,Application;
        }
        field(8; "Application Date"; DateTime)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

