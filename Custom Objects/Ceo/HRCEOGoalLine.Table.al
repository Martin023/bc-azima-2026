table 52185769 "HR CEO Goal Line"
{
    Caption = 'HR CEO Goal Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Goal No."; Code[20])
        {
            Caption = 'Goal No.';
            TableRelation = "HR CEO Goals Header"."Goal No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        field(3; "Perspective Code"; Integer)
        {
            Caption = 'Perspective Code';
            TableRelation = "HR Perspectives Setup"."Perspective No" WHERE(Active = CONST(true));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                CalcFields("Perspective Name");
            end;
        }
        field(4; "Perspective Name"; Text[100])
        {
            Caption = 'Perspective Name';
            CalcFormula = Lookup("HR Perspectives Setup"."Perspective Name" WHERE("Perspective No" = FIELD("Perspective Code")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(5; Objective; Text[250])
        {
            Caption = 'Objective';
        }
        field(6; Strategy; Text[250])
        {
            Caption = 'Strategy';
        }
        field(7; Measures; Text[250])
        {
            Caption = 'Measures / KPI';
        }
        field(8; Baseline; Decimal)
        {
            Caption = 'Baseline';
        }
        field(9; "Targeted Score"; Decimal)
        {
            Caption = 'Targeted Score';

            trigger OnValidate()
            begin
                Change := "Targeted Score" - Baseline;
            end;
        }
        field(10; Change; Decimal)
        {
            Caption = 'Change';
            Editable = false;
        }
        field(11; "Applies To"; Option)
        {
            Caption = 'Applies To';
            OptionCaption = 'All HODs,Specific HODs';
            OptionMembers = "All HODs","Specific HODs";
        }
        field(12; Comments; Text[250])
        {
            Caption = 'Comments';
        }
        field(13; "HOD Assignments"; Integer)
        {
            Caption = 'HOD Assignments';
            CalcFormula = Count("HR CEO Goal HOD Assignment" WHERE("Goal No." = FIELD("Goal No."),
                                                                    "Goal Line No." = FIELD("Line No.")));
            FieldClass = FlowField;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Goal No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
