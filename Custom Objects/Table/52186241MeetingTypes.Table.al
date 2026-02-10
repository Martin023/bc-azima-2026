table 52186241 "Meeting Types"
{

    fields
    {
        field(1; "Code"; Code[50])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; Intervals; Option)
        {
            OptionMembers = Quarterly,Annual;
        }
        field(4; "Processing Fee"; Decimal)
        {
            TableRelation = "Transaction Types";
        }
        field(5; "Allowed Creation Channel"; Option)
        {
            OptionMembers = "BC CBS","Web Portal";
        }
        field(6; "Only Officials"; Boolean)
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
        fieldgroup(DropDown; Code,Description,Intervals)
        {

        }
    }
}

