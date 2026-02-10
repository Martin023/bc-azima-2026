table 52185966 "HR Employee Change Log"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Date Modified"; Date)
        {
        }
        field(3; "Time Modified"; Time)
        {
        }
        field(4; "Modified by"; Code[20])
        {
        }
        field(5; "Old Value"; Text[30])
        {
        }
        field(6; "New Value"; Text[30])
        {
        }
        field(7; "Reason for Change"; Text[100])
        {
        }
        field(8; "Payroll Acountant Notified"; Boolean)
        {
        }
        field(9; "Field Changed"; Text[50])
        {
        }
        field(10; "Staff No."; Code[20])
        {
        }
        field(11; "Staff Name"; Text[100])
        {
            CalcFormula = Lookup("HR Employees"."Full Name" WHERE("No." = FIELD("Staff No.")));
            FieldClass = FlowField;
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

    trigger OnDelete()
    begin
        Error('Operation not allowed');
    end;

    trigger OnModify()
    begin
        Error('Operation not allowed');
    end;

    trigger OnRename()
    begin
        Error('Operation not allowed');
    end;
}

