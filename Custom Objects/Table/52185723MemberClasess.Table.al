table 52185723 "Member Classes"
{
    LookupPageID = "Member Clasess";

    fields
    {
        field(1; "No."; Code[10])
        {
        }
        field(5; "Entrance Fee"; Decimal)
        {
        }
        field(6; "Share Capital"; Decimal)
        {
        }
        field(7; "Max. Installment"; Integer)
        {
        }
        field(8; "Default Share Capital"; Decimal)
        {
        }
        field(9; "Default BOSA Deposit"; Decimal)
        {
        }
        field(10; Checkoff; Boolean)
        {
        }
        field(11; "Can Take Loan"; Boolean)
        {
        }
        field(12; "Auto Generate Staff No"; Boolean)
        {
        }
        field(13; Acronym; Code[10])
        {
        }
        field(14; Remarks; Text[100])
        {
        }
        field(15; "Minimum Age"; Integer)
        { }
        field(16; "Member Class"; Enum "Member Classes")
        {
        }
        field(17; "Employer Code"; Code[30])
        {
            TableRelation = Customer WHERE("Account Type" = CONST(Employer));
        }
        field(18; "BBF Joining Fee"; Decimal)
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

