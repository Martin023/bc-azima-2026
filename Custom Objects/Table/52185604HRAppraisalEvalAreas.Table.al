table 52185604 "HR Appraisal Eval Areas"
{

    fields
    {
        field(1; "Assign To"; Code[20])
        {
            TableRelation = "HR Jobs";

            trigger OnValidate()
            begin
                "Assigned To" := ' ';
                Jobs.Reset;
                Jobs.SetRange(Jobs."Job ID", "Assign To");
                if Jobs.Find('-') then
                    "Assigned To" := Jobs."Job Description";
            end;
        }
        field(2; "Code"; Code[20])
        {
            NotBlank = false;

            trigger OnValidate()
            var
                HRAppEvalAreas: Record "HR Appraisal Eval Areas";
            begin
                HRAppEvalAreas.Reset;
                HRAppEvalAreas.SetRange(HRAppEvalAreas.Code, Code);
                if HRAppEvalAreas.Find('-') then begin
                    Error('Code [%1] already exist, Please use another code', Code);
                end;
            end;
        }
        field(3; "Line No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(4; "Categorize As"; Option)
        {
            OptionCaption = ' ,Employee''s Subordinates,Employee''s Peers,External Sources,Job Specific,Self Evaluation';
            OptionMembers = " ","Employee's Subordinates","Employee's Peers","External Sources","Job Specific","Self Evaluation";
        }
        field(5; "Sub Category"; code[40])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = FILTER(Competency));
        }
        field(6; Description; Text[250])
        {
            NotBlank = false;
        }
        field(7; "Include in Evaluation Form"; Boolean)
        {
        }
        field(8; "External Source Type"; Option)
        {
            OptionCaption = ' ,Vendor,Customer';
            OptionMembers = " ",Vendor,Customer;
        }
        field(9; "External Source Code"; Code[10])
        {
            TableRelation = IF ("External Source Type" = CONST(Customer)) Customer."No."
            ELSE
            IF ("External Source Type" = CONST(Vendor)) Vendor."No.";
        }
        field(10; "External Source Name"; Text[100])
        {
            FieldClass = Normal;
        }
        field(11; "Assigned To"; Text[100])
        {
            Editable = false;
        }
        field(12; Blocked; Boolean)
        {
        }
        field(13; "Appraisal Period"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = FILTER("Appraisal Period"),
                                                           Closed = CONST(false));
        }
        field(14; "Unit of Measure"; Code[20])
        {
            TableRelation = "Human Resource Unit of Measure".Code;
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Jobs: Record "HR Jobs";
}

