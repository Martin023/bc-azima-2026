table 52186242 "Allowed Allowances"
{

    fields
    {
        field(1; "Meeting Type Code"; Code[50])
        {
        }
        field(2; "Allowance Code"; Code[50])
        {
            TableRelation = "Delegates Tariff".Code;
            trigger OnValidate()
            var
            begin
                CalcFields(Description, "G/L Account", "Charge Code");
            end;

        }
        field(3; Amount; Decimal)
        {
            // FieldClass = FlowField;
            Editable = true;
            //CalcFormula = lookup("Delegates Tariff".Amount where(Code = field("Allowance Code")));
        }

        field(5; Description; Text[100])
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Delegates Tariff".Description where(Code = field("Allowance Code")));
        }
        field(6; "G/L Account"; Code[50])
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Delegates Tariff"."Account No." where(Code = field("Allowance Code")));
        }
        field(7; "Charge Code"; Code[50])
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Delegates Tariff"."Transaction Type" where(Code = field("Allowance Code")));
        }
        field(8; Position; Code[20])
        {
            TableRelation = "Salutation Tittles".Code where(Type = filter(Position|"Delegate Member"));
        }
    }

    keys
    {
        key(Key1; "Meeting Type Code", "Allowance Code", Position)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        MeetingTypes: Record "Meeting Types";
        AllowedAllowances: Record "Allowed Allowances";
}

