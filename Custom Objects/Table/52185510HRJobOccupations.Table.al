table 52185510 "HR Job Occupations"
{

    fields
    {
        field(2; "Employee No."; Code[20])
        {
            TableRelation = "HR Succession Job Rotation"."Line No.";

            trigger OnValidate()
            begin
                HREmp.Get("Employee No.");

                CalcFields("First Name");
                CalcFields("Middle Name");
                CalcFields("Last Name");
                //Email:=HREmp."E-Mail";
                //"Date of Join":=  HREmp."Date of Join";
                HREmp."Job Title" := "Job Id";
                HREmp.Validate(HREmp."Job Title");
                HREmp.Modify;
            end;
        }
        field(3; "First Name"; Text[30])
        {
            CalcFormula = Lookup("HR Succession Job Rotation"."Plan No.");
            FieldClass = FlowField;
        }
        field(4; "Middle Name"; Text[30])
        {
            CalcFormula = Lookup("HR Succession Job Rotation"."Plan No.");
            FieldClass = FlowField;
        }
        field(5; "Last Name"; Text[30])
        {
            CalcFormula = Lookup("HR Succession Job Rotation"."Plan No.");
            FieldClass = FlowField;
        }
        field(6; Extension; Text[30])
        {
            FieldClass = Normal;
        }
        field(7; Email; Text[30])
        {
            FieldClass = Normal;
        }
        field(8; "Date of Join"; Date)
        {
            FieldClass = Normal;
        }
        field(9; Department; Code[20])
        {
            FieldClass = Normal;
        }
        field(55; "Job Desc"; Text[50])
        {
            CalcFormula = Lookup("HRDisciplinary Case Withdrawal"."Employee No." WHERE("No." = FIELD("Job Id")));
            FieldClass = FlowField;
        }
        field(56; "Job Id"; Code[100])
        {
            TableRelation = "Vendor Invoice Disc."."Service Charge";
        }
    }

    keys
    {
        key(Key1; "Job Id", "Employee No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HREmp: Record "HR Succession Job Rotation";
        HRJobs: Record "HR Jobs";
}

