table 52185660 "HR Lateness Ledger"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Employee No."; Code[10])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                HrEmp.Get("Employee No.");
                "First Name" := HrEmp."First Name";
                "Middle Name" := HrEmp."Middle Name";
                "Last Name" := HrEmp."Last Name";
            end;
        }
        field(3; Date; Date)
        {
        }
        field(4; "Date of Entry"; DateTime)
        {
            Editable = false;
        }
        field(5; Time; Time)
        {
        }
        field(6; Absent; Boolean)
        {
        }
        field(7; "First Name"; Text[30])
        {
        }
        field(8; "Middle Name"; Text[30])
        {
        }
        field(9; "Last Name"; Text[30])
        {
        }
        field(10; "User Id"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", Date)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Date of Entry" := CurrentDateTime;
        "User Id" := UserId;
    end;

    var
        HrEmp: Record "HR Employees";
}

