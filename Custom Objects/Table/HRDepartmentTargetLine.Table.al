table 52185484 "HR Department Target Line"
{
    Caption = 'HR Department Target Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(2; "Department Target No"; Code[20])
        {
            Caption = 'Department Target No';
            TableRelation = "HR Department Targets Header"."Target No";
        }
        field(3; "Perspective Code"; Integer)
        {
            Caption = 'Perspective Code';
            TableRelation = "HR Perspectives Setup"."Perspective No" WHERE(Active = CONST(true));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                CalcFields("Perspective Name", "Scoring Method", "Result Label");
            end;
        }
        field(4; "Perspective Name"; Text[100])
        {
            CalcFormula = Lookup("HR Perspectives Setup"."Perspective Name" WHERE("Perspective No" = FIELD("Perspective Code")));
            Caption = 'Perspective Name';
            FieldClass = FlowField;
            Editable = false;
        }
        field(5; "Scoring Method"; Option)
        {
            CalcFormula = Lookup("HR Perspectives Setup"."Scoring Method" WHERE("Perspective No" = FIELD("Perspective Code")));
            Caption = 'Scoring Method';
            FieldClass = FlowField;
            OptionCaption = 'Standard,Inverted';
            OptionMembers = Standard,Inverted;
            Editable = false;
        }
        field(18; "Result Label"; Text[50])
        {
            CalcFormula = Lookup("HR Perspectives Setup"."Result Label" WHERE("Perspective No" = FIELD("Perspective Code")));
            Caption = 'Result Label';
            FieldClass = FlowField;
            Editable = false;
        }
        field(6; Objective; Text[250])
        {
            Caption = 'Objective';
        }
        field(7; Strategy; Text[250])
        {
            Caption = 'Strategy';
        }
        field(8; Measures; Text[250])
        {
            Caption = 'Measures';
        }
        field(9; Baseline; Decimal)
        {
            Caption = 'Baseline';
        }
        field(10; "Targeted Score"; Decimal)
        {
            Caption = 'Targeted Score';

            trigger OnValidate()
            begin
                "Unachieved Targets" := "Targeted Score" - "Achieved Score";
                Change := "Targeted Score" - Baseline;
            end;
        }
        field(11; Change; Decimal)
        {
            Caption = 'Change';
        }
        field(12; "Achieved Score"; Decimal)
        {
            Caption = 'Achieved Score';

            trigger OnValidate()
            begin
                "Unachieved Targets" := "Targeted Score" - "Achieved Score";
                
                CalcFields("Scoring Method");
                
                if "Scoring Method" = "Scoring Method"::Inverted then begin
                    if "Achieved Score" <> 0 then
                        Score := 100 - "Achieved Score"
                    else
                        Score := 100;
                end else begin
                    if ("Targeted Score" <> 0) and ("Achieved Score" <> 0) then
                        Score := ("Achieved Score" / "Targeted Score") * 100
                    else
                        Score := 0;
                end;
            end;
        }
        field(13; "Unachieved Targets"; Decimal)
        {
            Caption = 'Unachieved Targets';
        }
        field(14; Score; Decimal)
        {
            Caption = 'Score';
        }
        field(15; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(16; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(17; Comments; Text[250])
        {
            Caption = 'Comments';
        }
    }

    keys
    {
        key(Key1; "Line No", "Department Target No", "Perspective Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}