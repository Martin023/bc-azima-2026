table 52185669 "HR Leave Reliver"
{

    fields
    {
        field(1; "leave No"; Code[20])
        {
        }
        field(2; Employee; Code[10])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(3; "Reliver Code"; Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                hrempl.Reset;
                hrempl.SetRange(hrempl."No.", "Reliver Code");
                if hrempl.Find('-') then
                    "Reliver Name" := hrempl."First Name" + ' ' + hrempl."Middle Name" + ' ' + hrempl."Last Name";
            end;
        }
        field(4; "Reliver Name"; Text[100])
        {
        }
        field(5; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(6; Duties; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "leave No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        hrempl: Record "HR Employees";
}

