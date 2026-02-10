table 52185431 "Sub Classes"
{
LookupPageId = "Sub Classes";
DrillDownPageId = "Sub Classes";
    fields
    {
        field(1; "Main Class"; Code[50])
        {
            TableRelation = "Member Classes"."No.";
            
        }
        field(2; "Sub Class"; Code[50])
        {
            
        }
    }
    keys
    {
        key(Key1; "Main Class","Sub Class")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}

