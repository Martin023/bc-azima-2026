table 52185671 "PR Employee Allowances"
{

    fields
    {
        field(1; "Job Grade"; Code[10])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = FILTER(Grade));
        }
        field(8; County; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('BRANCH'));
        }
        field(9; "Transaction Code"; Code[10])
        {
            TableRelation = "PR Transaction Codes"."Transaction Code";

            trigger OnValidate()
            begin
                TransCode.Reset;
                TransCode.SetRange(TransCode."Transaction Code", "Transaction Code");
                if TransCode.Find('-') then
                    Description := TransCode."Transaction Name";
            end;
        }
        field(10; Amount; Decimal)
        {
        }
        field(11; Description; Text[100])
        {
            CalcFormula = Lookup("prTransaction Codes"."Transaction Name" WHERE("Transaction Code" = FIELD("Transaction Code")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Job Grade", County, "Transaction Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        TransCode: Record "PR Transaction Codes";
}

