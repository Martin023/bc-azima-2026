table 52186190 "HR Shift Schedule Lines"
{
    // DrillDownPageID = "HR Shift Schedule Lines";
    // LookupPageID = "HR Shift Schedule Lines";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Editable = false;
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                HREmployees.Reset;
                if HREmployees.Get("Employee No.") then begin
                    "Employee No." := HREmployees."No.";
                    "Full Name" := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
                    "Global Dimension 1 Code" := HREmployees."Department Code";
                    "Global Dimension 2 Code" := HREmployees.Office;
                    //"Responsibility Center":=HREmployees."Responsibility Center";
                end;
            end;
        }
        field(3; "Clock In Time"; DateTime)
        {

            trigger OnValidate()
            begin
                if "Clock Out Time" <> 0DT then
                    fnCalculateDuration;
            end;
        }
        field(4; "Clock Out Time"; DateTime)
        {

            trigger OnValidate()
            begin
                if "Clock In Time" <> 0DT then
                    fnCalculateDuration;
            end;
        }
        field(5; Duration; Duration)
        {
            Editable = false;
        }
        field(6; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(7; "Full Name"; Text[30])
        {
            Editable = false;
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(10; "Responsibility Center"; Code[20])
        {
            Editable = false;
            TableRelation = "Responsibility Center B".Code;
        }
        field(11; "Shift Code"; Code[20])
        {
            CalcFormula = Lookup("HR Shift Schedule Header"."Shift Code" WHERE(Code = FIELD(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HREmployees: Record "HR Employees";

    local procedure fnCalculateDuration()
    begin
        Duration := "Clock Out Time" - "Clock In Time";
    end;
}

