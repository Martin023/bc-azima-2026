table 52185939 "Contract Cycle"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Probability Calculation"; Option)
        {
            OptionCaption = 'Multiply,Add,Chances of Success %,Completed %';
            OptionMembers = Multiply,Add,"Chances of Success %","Completed %";
        }
        field(4; Blocked; Boolean)
        {
        }
        field(5; "No. of Opportunities"; Integer)
        {
        }
        field(6; "Estimated Value (LCY)"; Decimal)
        {
        }
        field(7; "Calcd. Current Value (LCY)"; Decimal)
        {
        }
        field(8; Comment; Boolean)
        {
        }
        field(9; "Date Filter"; Date)
        {
        }
        field(10; Cycles; Option)
        {
            OptionMembers = " ",Initiation,Progress,Stalled,Completed,Closed;
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

