table 52185607 prNHIF
{

    fields
    {
        field(1; "Tier Code"; Code[10])
        {
            SQLDataType = Integer;
        }
        field(2; "NHIF Tier"; Decimal)
        {
        }
        field(3; Amount; Decimal)
        {
        }
        field(4; "Lower Limit"; Decimal)
        {
        }
        field(5; "Upper Limit"; Decimal)
        {
        }
        
         field(6; "NHIF Employee"; Decimal)
        {
            Description = '[NHIF]';
        }
         field(7; "NHIF Based on"; Option)
        {
            Description = '[NHIF] - Gross,Basic,Taxable Pay';
            OptionMembers = Gross,Basic,"Taxable Pay";
        }
        field(8;banded;boolean)
        {
            
        }
        field(9;"Max Allowable Limit";decimal)
        {

        }
        field(10;"Amount on Max Allowable Limit";decimal)
        {

        }
    }

    keys
    {
        key(Key1; "Tier Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

