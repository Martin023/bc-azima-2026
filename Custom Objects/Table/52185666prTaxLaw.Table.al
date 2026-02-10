table 52185666 "prTax Law"
{

    fields
    {
        field(10; "Code"; Code[10])
        {
        }
        field(20; Description; Text[30])
        {
        }
        field(30; "Period Type"; Option)
        {
            OptionCaption = 'Annual,Monthly';
            OptionMembers = Annual,Monthly;
        }
        field(40; "Max. % of Basic (Overtime)"; Decimal)
        {
        }
        field(50; "Basic Limit (Overtime)"; Decimal)
        {
            Caption = 'Monthly Basic Limit (Overtime)';
        }
        field(60; "Non-graduating Overtime Tax"; Boolean)
        {
        }
        field(70; "Bonus Limit (%)"; Decimal)
        {
            Caption = 'Annual Bonus Limit (%)';
        }
        field(80; "Bonus Limit (Amount)"; Decimal)
        {
            Caption = 'Annual Bonus Limit (Amount)';
        }
        field(90; "Non-Resident Tax Rate"; Decimal)
        {
            Caption = 'Non-Resident Tax Rate (%)';
            Editable = false;
        }
        field(200; Blocked; Boolean)
        {
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

