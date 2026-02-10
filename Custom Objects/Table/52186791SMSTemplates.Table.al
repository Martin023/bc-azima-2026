table 52186791 "DMU SMS Templates"
{
    LookupPageId = "SMS Templates";
    DrillDownPageId = "SMS Templates";
    fields
    {
        field(1; "Code"; Code[50])
        {
        }
        field(2; Description; Text[250])
        {
        }
        field(3; "Text SMS"; Text[1000])
        {
           
        }
        field(4; "Notice Type"; Option)
        {
            OptionMembers = SMS,Email,Letter;
            ValuesAllowed = SMS,Email;
        }
        field(5; Recepient; Option)
        {
            OptionMembers = "Lonee","Guarantor";

        }
        field(6; "Notice Category"; Option)
        {
            OptionMembers = "First Notice","Second Notice","CRB Notice","CRB Listing Notice","Arrears Alert";

        }
        field(7; "SMS Days Intervals"; Integer)
        {

        }
        field(8; "Days in Arrears"; Integer)
        {
            
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

}

