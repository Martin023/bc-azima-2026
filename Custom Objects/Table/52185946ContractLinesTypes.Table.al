table 52185946 "Contract Lines Types"
{

    fields
    {
        field(1; "Contract Line Code"; Code[20])
        {
            TableRelation = "Contract Documents"."Document Type";
        }
        field(2; Description; Text[50])
        {
        }
        field(3; Type; Option)
        {
            OptionCaption = ' ,Fixed Assets,Services,Transport,Services Provided';
            OptionMembers = " ","Fixed Assets",Services,Transport,"Services Provided";
        }
        field(4; "Contract Line Type"; Code[10])
        {
        }
        field(5; "Contract Cycle"; Code[10])
        {
            TableRelation = "Contract Cycle".Code;
        }
    }

    keys
    {
        key(Key1; "Contract Line Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

