table 52186103 "Agent Tariff Details"
{

    fields
    {
        field(1; "Code"; Code[20])
        {

        }
        field(2; "Lower Limit"; Decimal)
        {
        }
        field(3; "Upper Limit"; Decimal)
        {
        }
        field(4; "Charge Amount"; Decimal)
        {
        }
        field(5; "Agent Comm"; Decimal)
        {
        }
        field(6; "Vendor Comm"; Decimal)
        {
        }
        field(7; "Sacco Comm"; Decimal)
        {
        }
        field(8; "Charge Excise Duty"; Boolean)
        {
        }
        field(9; "SMS Charge"; Decimal)
        {
        }
        field(10; "Loans Category-SASRA"; Enum "Loan Sasra categories")
        {

        }
    }

    keys
    {
        key(Key1; "Code", "Lower Limit")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

