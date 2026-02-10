table 52186044 "Asset Register Setup"
{
    DrillDownPageID = "Asset Register Setup";
    LookupPageID = "Asset Register Setup";

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Type; Option)
        {
            OptionCaption = ' ,Manufacturer,System Software,Applications,Processor Type,Memory Size';
            OptionMembers = " ",Manufacturer,"System Software",Applications,"Processor Type","Memory Size";
        }
        field(3; Description; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Line No", Description)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

