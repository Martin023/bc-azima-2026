table 52186170 "Travelling Officers"
{
    Caption = 'Travelling Officers';
    DataClassification = ToBeClassified;
    DrilldowNpageID = "Travelling Officers";

    fields
    {
        field(1; "Record No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = "Vehicle Movement";
        }
        field(5; "No."; Integer)
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(2; "Staff Number"; Code[20])
        {
            Caption = 'Staff Number';
            TableRelation = "HR Employees"."No.";
            trigger OnValidate()
            begin
                HREmployees.Reset();
                HREmployees.SetRange("No.", "Staff Number");
                if HREmployees.FindFirst() then begin 
                "Officer's Name" := HREmployees."Full Name";
                "Responsibility Center" := HREmployees."Responsibility Center";
                end;
            end;
        }
        field(3; "Officer's Name"; Text[100])
        {
            Caption = 'Officer''s Name';
        }
        field(4; "Responsibility Center"; Text[100])
        {
            Caption = 'Department';
        }
    }
    keys
    {
        key(PK; "Record No.","No.")
        {
            Clustered = true;
        }
    }

    var
    HREmployees: Record "HR Employees";
    VehicleMovement: Record "Vehicle Movement";
}
