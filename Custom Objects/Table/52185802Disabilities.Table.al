table 52185802 Disabilities
{
   

    fields
    {
        field(1; "Code"; Code[50])
        {
            Description = 'Lookup to Delegate groups';
            Editable = false;
            TableRelation = "Delegate Groups".Code;
        }
        field(2; Description; Code[50])
        {
            
        }
       
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }
}

