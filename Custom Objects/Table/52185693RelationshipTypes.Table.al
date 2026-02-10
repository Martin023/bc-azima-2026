table 52185693 "Relationship Types"
{
    LookupPageID = "Relationship Types";

    fields
    {
        field(1; Relation; Code[30])
        {
        }
        field(2; "Min. Age"; Integer)
        {

        }
        field(3; "Max. Age"; Integer)
        {

        }
        field(4; "BBF Max. Allowed"; Integer)
        {
        }
        field(5;"Welfare Claim Amount";decimal)
        {
            
        }
        field(6;Self;Boolean)
        {
            
        }
        
        
    }

    keys
    {
        key(Key1; Relation)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

