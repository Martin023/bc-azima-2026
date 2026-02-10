table 52185852 "BBF Entitlement"
{
    DrillDownPageID = "BBF Entitlement List";
    LookupPageID = "BBF Entitlement List";

    fields
    {
        field(1; "Relationship Type"; Text[80])
        {
            TableRelation = "Relationship Types";
        }
        field(2; "Start Date"; Date)
        {

        }
        field(3; "End Date"; Date)
        {

        }
        field(4; Amount; Decimal)
        {
        }
        field(5; "Claim Option"; Option)
        {
            OptionMembers = "Dependant","Member";
        }
        field(6; "Claim Type"; Option)
        {
            OptionMembers = " ","BBF - Dependant Claim","BBF - Principle Claim","Risk Claim","BBF - Insurance Claim";

        }
        field(7; "SACCO Max. Allowed"; Integer)
        {
        }
        field(8; "Insurance Max. Allowed"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Relationship Type", "Start Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Relations: Record "Relationship Types";
}

