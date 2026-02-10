table 52186112 "Sectoral Classification"
{
    DrillDownPageID = "Sectoral Classification";
    LookupPageID = "Sectoral Classification";

    fields
    {
        field(1; "Sector Code"; Code[20])
        {
        }
        field(2; "Sector Description"; Text[100])
        {
        }
        field(3; "Parent Sector"; Code[20])
        {
        }
        field(4; "Sector Level"; Option)
        {
            OptionMembers = "Main Sector","Sub Sector Level 1","Sub Sector Level 2";
        }

    }

    keys
    {
        key(Key1; "Sector Code")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
        fieldgroup(DropDown; "Sector Code", "Sector Level", "Sector Description")
        {

        }
    }
}