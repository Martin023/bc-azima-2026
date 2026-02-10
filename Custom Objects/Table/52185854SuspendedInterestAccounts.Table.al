table 52185854 "Suspended Interest Accounts"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Loan No."; Code[20])
        {
        }
        field(3; "Credit Account"; Code[30])
        {
        }
        field(5; "Loan Product"; Code[20])
        {
        }
        field(6; "Interest Date"; Date)
        {
        }
        field(7; "Interest Amount"; Decimal)
        {
        }
        field(8; "Loan Product type"; Code[10])
        {
            Editable = false;
            TableRelation = "Product Factory";
        }
        field(9; "Issued Date"; Date)
        {
            Editable = false;
        }
        field(10; "Loans Category-SASRA"; Enum "Loan Sasra categories")
        {
            // CalcFormula = Lookup("SASRA Categorization"."Loans Category-SASRA" WHERE("Loan No." = FIELD("Loan No.")));
            // FieldClass = FlowField;
            // OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            // OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
        }
        field(11; "Transferred to income Ac"; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

