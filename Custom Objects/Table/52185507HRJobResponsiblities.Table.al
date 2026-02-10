table 52185507 "HR Job Responsiblities"
{
    // DrillDownPageID = "HR Job Responsiblities Lines";
    // LookupPageID = "HR Job Responsiblities Lines";

    fields
    {
        field(1; "Job ID"; Code[50])
        {
            Editable = false;
            TableRelation = "HR Jobs"."Job ID";
        }
        field(2; "Responsibility Description"; Text[250])
        {
        }
        field(3; Remarks; Text[150])
        {
        }
        field(4; "Responsibility Code"; Code[20])
        {

            trigger OnValidate()
            begin
                HRAppEvalArea.Reset;
                HRAppEvalArea.SetRange(HRAppEvalArea.Code, "Responsibility Code");
                if HRAppEvalArea.Find('-') then begin
                    Remarks := HRAppEvalArea."Measure No";
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Job ID", "Responsibility Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HRAppEvalArea: Record "HR OSMeasure Line";
}

