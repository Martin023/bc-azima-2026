table 52185529 "HR Employees Supervisees"
{

    fields
    {
        field(1; "Supervisor No."; Code[30])
        {
            NotBlank = false;
            TableRelation = "HR Succession Job Rotation"."Line No.";
        }
        field(2; "Supervisee No."; Code[30])
        {
            NotBlank = false;
            TableRelation = "HR Succession Job Rotation"."Line No.";
        }
        field(3; Department; Text[50])
        {
            NotBlank = false;

        }
        field(4; From; Date)
        {
            NotBlank = false;
        }
        field(5; "To"; Date)
        {
        }
        field(7; "Job Title"; Text[150])
        {
            TableRelation = "HR Jobs"."Job Description";
        }
        field(8; "Key Experience"; Text[150])
        {
        }
        field(16; Comment; Text[200])
        {
            Editable = true;
            FieldClass = Normal;
        }
        field(50000; "Number of Supervisees"; Integer)
        {
            CalcFormula = Count("HR Employees Supervisees" WHERE("Supervisor No." = FIELD("Supervisor No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Supervisor No.", From)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "HR Succession Job Rotation";
        OK: Boolean;
}

