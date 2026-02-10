table 52185684 "Tariff Codes"
{
    DrillDownPageID = "Tariff Codes";
    LookupPageID = "Tariff Codes";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; Percentage; Decimal)
        {
        }
        field(4; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; "To Use"; Option)
        {
            OptionCaption = ' ,Percentage,Amount';
            OptionMembers = " ",Percentage,Amount;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

