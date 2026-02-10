table 52186233 "Portal Member App Handlers"
{

    fields
    {
        field(1; "Payroll Number"; Code[50])
        {
            TableRelation = "HR Employees"."No." WHERE(Status = CONST(Active),
                                                        "Contract Type" = CONST('PERMANENT'),
                                                        "Global Dimension 1 Code" = CONST('MKTNG'));

            trigger OnValidate()
            begin
                "Member Number" := '';

                Department := '';

                if HREmployees.Get("Payroll Number") then begin
                    Members.Reset;
                    Members.SetRange("Payroll/Staff No.", HREmployees."No.");
                    if Members.FindFirst then begin

                        "Member Number" := Members."No.";
                        Department := HREmployees."Job Title";
                    end;
                end;
            end;
        }
        field(2; "Member Number"; Code[20])
        {
            TableRelation = Members."No.";
        }
        field(3; Name; Text[100])
        {
            CalcFormula = Lookup(Members.Name WHERE("No." = FIELD("Member Number")));
            FieldClass = FlowField;
        }
        field(4; Department; Code[50])
        {
        }
        field(5; Status; Option)
        {
            OptionMembers = Active,Inactive;
        }
    }

    keys
    {
        key(Key1; "Payroll Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        UserSetup: Record "User Setup";
        HREmployees: Record "HR Employees";
        Members: Record Members;
}

