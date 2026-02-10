table 52185447 "Shares Market"
{

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Member; Code[30])
        {
        }
        field(3; "No of Shares"; Decimal)
        {
        }
        field(4; "Min Price"; Decimal)
        {
        }
        field(5; "Max Price"; Decimal)
        {
        }
        field(6; "Available Shares"; Decimal)
        {
        }
        field(7; "Remaining Shares"; Decimal)
        {
        }
        field(9; "Created by"; Text[30])
        {
        }
        field(10; "Created Date"; DateTime)
        {
        }
        field(11; "Modified By"; Text[30])
        {
        }
        field(12; "Modified Date"; DateTime)
        {
        }
        field(13; "Id No"; Code[30])
        {
        }
        field(14; Status; Option)
        {
            OptionCaption = ',Application';
            OptionMembers = ,Application;
        }
        field(15; Shares; Decimal)
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

