table 52186094 "VB Payment Option"
{

    fields
    {
        field(1; "Repayment Code"; Code[20])
        {
        }
        field(2; "Repayment Option"; Option)
        {
            OptionCaption = 'Normal Monthly,Lump Sum,Full';
            OptionMembers = "Normal Monthly","Lump Sum",Full;
        }
        field(3; "Interest Computation"; Option)
        {
            OptionCaption = 'Current,Scheduled';
            OptionMembers = Current,Scheduled;

            trigger OnValidate()
            begin
                if ("Interest Computation" = "Interest Computation"::Scheduled) and ("Repayment Option" = "Repayment Option"::"Normal Monthly") then
                    Error('This Computation option cannot be selected for %1 Option', "Repayment Option"::"Normal Monthly");
            end;
        }
    }

    keys
    {
        key(Key1; "Repayment Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

