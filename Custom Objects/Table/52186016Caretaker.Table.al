table 52186016 Caretaker
{
    // DrillDownPageID = "Caretaker List";
    // LookupPageID = "Caretaker List";

    fields
    {
        field(1; "Property No"; Code[30])
        {
            TableRelation = "Property Details"."No.";
        }
        field(2; "Caretaker No"; Code[30])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                HrEmployee.Reset;
                HrEmployee.SetRange(HrEmployee."No.", "Caretaker No");
                if HrEmployee.Find('-') then begin
                    "Caretaker Name" := HrEmployee."First Name" + ' ' + HrEmployee."Middle Name";
                    "Cell Phone No." := HrEmployee."Phone No.";
                    "Email address" := HrEmployee."E-Mail";
                    "Postal Address" := HrEmployee."Post Code";
                    City := HrEmployee.City;
                end;
            end;
        }
        field(3; "Caretaker Name"; Text[50])
        {
        }
        field(4; "Cell Phone No."; Text[30])
        {
        }
        field(5; "Email address"; Text[50])
        {
        }
        field(6; "Postal Address"; Code[50])
        {
        }
        field(7; City; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Property No", "Caretaker No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HrEmployee: Record Employee;
}

