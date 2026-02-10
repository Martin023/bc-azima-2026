table 52186188 "HR Shift Management"
{
    // DrillDownPageID = "HR Shift Management List";
    // LookupPageID = "HR Shift Management List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Editable = false;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Start Date/Time"; DateTime)
        {

            trigger OnValidate()
            begin
                if "End Date/Time" <> 0DT then
                    fnCalculateDuration;
            end;
        }
        field(4; "End Date/Time"; DateTime)
        {

            trigger OnValidate()
            begin
                if "Start Date/Time" <> 0DT then
                    fnCalculateDuration;
            end;
        }
        field(5; Duration; Duration)
        {
            Editable = false;
        }
        field(6; "Allow Late"; Boolean)
        {
        }
        field(7; "Shift Type"; Option)
        {
            OptionMembers = " ","Early Morning","Mid Morning",Afternoon,Evening;
        }
        field(8; "Shift Pattern"; Option)
        {
            OptionCaption = ' ,Daily,Weekly,Monthly,Yearly';
            OptionMembers = " ",Daily,Weekly,Monthly,Yearly;
        }
        field(9; "No. Series"; Code[20])
        {
        }
        field(10; "Assigned Employees"; Integer)
        {
            CalcFormula = Count("HR Shift Schedule Lines" WHERE("Shift Code" = FIELD(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; Status; Option)
        {
            OptionMembers = Open,"On Going",Closed;
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
            HRSetup.TestField(HRSetup."Shift Nos");
            NoSeriesMgt.InitSeries(HRSetup."Shift Nos", xRec."No. Series", 0D, Code, "No. Series");
        end;
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    local procedure fnCalculateDuration()
    begin
        Duration := "End Date/Time" - "Start Date/Time";
    end;
}

