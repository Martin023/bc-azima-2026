table 52185953 "Contract Line"
{

    fields
    {
        field(1; "Document No."; Code[50])
        {
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(3; Detail; Text[200])
        {
        }
        field(4; Description; Text[200])
        {
        }
        field(5; "Amount Awarded"; Decimal)
        {
        }
        field(50000; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Service,Item,Fixed Asset,Other';
            OptionMembers = " ",Service,Item,"Fixed Asset",Other;
        }
        field(50001; "From Date"; Date)
        {
        }
        field(50002; "To Date"; Date)
        {
        }
        field(50003; "Item Code"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

