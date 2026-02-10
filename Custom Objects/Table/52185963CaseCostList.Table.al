table 52185963 "Case Cost List"
{
    DrillDownPageID = "Case Cost List";
    LookupPageID = "Case Cost List";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Case Item"; Code[30])
        {
            TableRelation = Damages."No.";

            trigger OnValidate()
            begin
                /*"Cost Item Description":='';
                LookUpVal.RESET;
                LookUpVal.SETRANGE(LookUpVal.Type,LookUpVal.Type::"Training Cost Item");
                LookUpVal.SETRANGE(LookUpVal.Code,"Cost Item");
                IF LookUpVal.FIND('-') THEN
                "Cost Item Description":=LookUpVal.Description;
                */
                Damgs.Reset;
                Damgs.SetRange(Damgs."No.", "Case Item");
                if Damgs.Find('-') then
                    Description := Damgs.Description;

            end;
        }
        field(3; Cost; Decimal)
        {
        }
        field(4; Description; Text[100])
        {
            Editable = true;
        }
        field(5; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Code", "Line No", "Case Item")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Damgs: Record Damages;
}

