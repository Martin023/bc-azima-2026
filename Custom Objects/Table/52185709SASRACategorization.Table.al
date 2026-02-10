table 52185709 "SASRA Categorization"
{

    fields
    {
        field(1; "Loan No."; Code[50])
        {
        }
        field(2; "Loans Category-SASRA"; Enum "Loan Sasra categories")
        {
            // OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            // OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
        }
        field(3; "Loan Age"; Integer)
        {
        }
        field(4; "Days In Arreas"; Decimal)
        {
        }
        field(5; "Installments In Fall Off"; Integer)
        {
        }
        field(6; "Amount In Arears SACCO"; Decimal)
        {
        }
        field(7; "Amount In Arears SASRA"; Decimal)
        {
        }
        field(8; "Installments In Arrears"; Decimal)
        {

        }
    }

    keys
    {
        key(Key1; "Loan No.")
        {
            Clustered = true;
            SumIndexFields = "Installments In Fall Off", "Amount In Arears SASRA";
        }
    }

    fieldgroups
    {
    }
}

