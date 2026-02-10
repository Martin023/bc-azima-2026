table 52186100 "DCS CRB Data"
{

    fields
    {
        field(1; NationalID; Code[20])
        {
        }
        field(2; "Account Type"; Code[20])
        {
        }
        field(3; "Account Ref"; Code[20])
        {
        }
        field(4; "Listing Sector"; Code[20])
        {
        }
        field(5; "Credit Score"; Decimal)
        {
        }
        field(6; "Loan Amount"; Decimal)
        {
        }
        field(7; "Overdue Amount"; Decimal)
        {
        }
        field(8; "Days in Arrears"; Integer)
        {
        }
        field(9; "Last Query Date"; Date)
        {
        }
        field(10; "Last Query Time"; Time)
        {
        }
        field(11; "Query Reason"; Code[10])
        {
        }
        field(12; "Date of Listing"; Date)
        {
        }
        field(13; "Mobile Phone No"; Code[20])
        {
        }
        field(14; "Has Error"; Boolean)
        {
        }
        field(15; "Has Fraud"; Boolean)
        {
        }
        field(16; "Deliquency Code"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; NationalID, "Account Type", "Account Ref")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

