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
            TableRelation = "HR Perspectives Setup"."Perspective No";
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                CalcFields("Perspective Description");
            end;
        }
        field(4; "Perspective Description"; Text[250])
        {
            CalcFormula = Lookup("HR Perspectives Setup".Description WHERE("Perspective No" = FIELD("Perspective Code")));
            Caption = 'Perspective Description';
            FieldClass = FlowField;
        }
        field(5; "Perspective Type"; Option)
        {
            CalcFormula = Lookup("HR Perspectives Setup"."Perspective type" WHERE("Perspective No" = FIELD("Perspective Code")));
            Caption = 'Perspective Type';
            FieldClass = FlowField;
            OptionCaption = ' ,Internal Service Delivery,Financial Stewardship,Training and Development,Customer Sales';
            OptionMembers = " ","Internal Service Delivery","Financial Stewardship","Training and Development","Customer Sales";
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
                if ("Targeted Score" <> 0) and ("Achieved Score" <> 0) then
                    Score := "Achieved Score" / "Targeted Score" * 100;
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