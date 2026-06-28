table 52185632 "Marketing Teams Header"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Marketing Teams Header";

    fields
    {
        field(1; "Payroll No."; Code[50])
        {
            TableRelation = "HR Employees"."No.";
            Caption = 'Payroll Staff No';
            trigger OnValidate()
            var
                SalesRep: Record "Marketing Teams Header";
                Members: Record Members;
                HREmployees: Record "HR Employees";
            begin
                SalesRep.Reset();
                SalesRep.setRange("Payroll No.", "Payroll No.");
                if SalesRep.findFirst() then
                    Error('This Sales rep already exists!');

                IF HREmployees.Get("Payroll No.") THEN BEGIN
                    Rec."Member No." := HREmployees."Member No.";
                    Rec."Member Name" := HREmployees."Full Name";
                    Rec."ID Number" := HREmployees."ID Number";
                    Rec."Branch Code" := HREmployees."Global Dimension 1 Code";
                    Rec."Status" := HREmployees.Status;
                    Rec."Registered By" := UserId;
                END;

            end;

        }
        field(2; "Member No."; Code[20])
        {
            Caption = 'Member No';
            Editable = false;
        }
        field(3; "Member Name"; Text[2048])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(4; Phone; Code[20])
        {
            Caption = 'Phone';
            trigger OnValidate()
            var
                Members: Record Members;
            begin
                if Members.get("Member No.") then
                    Phone := Members."Transactional Mobile Number";
            end;
        }
        field(5; "ID Number"; code[20])
        {
            Caption = 'ID Number';
            Editable = false;
        }
        field(6; "Branch Code"; Code[50])
        {
            Caption = 'Branch Code';
            // Editable = false;
        }
        field(7; "Status"; Option)
        {
            OptionMembers = New,"Pending Approval",Active,InActive,Suspended,Probation,interdicted,Rejected;
            Editable = false;
            Caption = 'Status';
        }
        field(8; "Registered By"; Code[200])
        {
            Caption = 'Registered By';
        }
        field(9; Created; Boolean)
        {
            Caption = 'Created';
        }
        field(10; Retainer; Decimal)
        {
            Caption = 'Retainer';
        }


    }

    keys
    {
        key(PK; "Payroll No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Payroll No.", "Member Name", "ID Number", "Member No.", Phone)
        {

        }
    }
}
