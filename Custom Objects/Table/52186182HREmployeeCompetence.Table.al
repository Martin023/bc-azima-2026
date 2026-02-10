table 52186182 "HR Employee Competence"
{

    fields
    {
        field(1; "Competence Code"; Code[20])
        {
            // TableRelation = "HR Lookup Values".Code WHERE (Type = FILTER ("30"));

            trigger OnValidate()
            begin
                HRlookup.Reset;
                HRlookup.SetRange(HRlookup.Code, "Competence Code");
                if HRlookup.Find('-') then begin
                    Description := HRlookup.Description;
                end;
            end;
        }
        field(2; "Employee No"; Code[10])
        {
        }
        field(3; Description; Text[100])
        {
        }
        field(4; "Competency Score"; Decimal)
        {
        }
        field(5; "Line No"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Competence Code", "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HRlookup: Record "HR Lookup Values";
}

