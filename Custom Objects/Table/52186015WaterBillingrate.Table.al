table 52186015 "Water Billing rate"
{
    DrillDownPageID = "Water Billing rates";
    LookupPageID = "Water Billing rates";

    fields
    {
        field(1; "Tier Code"; Code[10])
        {
        }
        field(2; "Bill Rate tier"; Decimal)
        {
        }
        field(5; Rate; Decimal)
        {
        }
        field(6; Distribution; Decimal)
        {
        }
        field(50008; "Type of Tarrif"; Option)
        {
            Description = 'Defines the tarrif for the customer, result to different rates';
            OptionCaption = ' ,Domestic and Commercial,EPZA and Industrial,Gated Community';
            OptionMembers = " ","Domestic and Commercial","EPZA and Industrial","Gated Community";
        }
    }

    keys
    {
        key(Key1; "Tier Code", "Type of Tarrif")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

