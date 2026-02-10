table 52186831 "Overtime Need Request Lines"
{
    Caption = 'Overtime Need Request Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Need No"; Code[20])
        {
            Caption = 'Need No';
        }
        field(2; "Staff No"; Code[40])
        {
            TableRelation = "HR Employees"."No.";
            trigger OnValidate()
            var
                HrEmployees: record "HR Employees";
            begin
                HrEmployees.reset();
                HrEmployees.setrange("No.", rec."Staff No");
                if HrEmployees.find('-') then begin
                    "Staff Name" := HrEmployees.FullName;
                    "responsibility centre" := HrEmployees."Responsibility Center";
                end;
            end;
        }
        field(3; "Staff Name"; Text[250])
        {
            Caption = 'Staff Name';
        }
        field(4; "responsibility centre"; Code[40])
        {
            Caption = 'responsibility centre';
        }
         field(5; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
    }
    keys
    {
        key(PK;"Line No.", "Need No")
        {
            Clustered = true;
        }
    }
}
