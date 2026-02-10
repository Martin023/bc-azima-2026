table 52186189 "HR Shift Schedule Header"
{
    // DrillDownPageID = "HR Shift Schedule Header List";
    // LookupPageID = "HR Shift Schedule Header List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Editable = false;
        }
        field(2; "Shift Code"; Code[20])
        {
            TableRelation = "HR Shift Management".Code;
        }
        field(3; "Assigned Employees"; Integer)
        {
            CalcFormula = Count("HR Shift Schedule Lines" WHERE(Code = FIELD(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "No. Series"; Code[20])
        {
        }
        field(5; Description; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if Code = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Shift Schedule Nos");
            NoSeriesMgt.InitSeries(HRSetup."Shift Schedule Nos", xRec."No. Series", 0D, Code, "No. Series");
        end;
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

