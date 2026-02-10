table 52187037 "MKey Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Header No."; Code[30])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2; "Member No. "; Code[30])
        {
            TableRelation = Members;
            trigger OnValidate()
            var
                Members: Record Members;
            begin
                CalcFields("Member Name");
                if Members.Get("Member No. ") then begin
                    "Old Payroll Number" := Members."Payroll/Staff No.";
                    "Old Employer Code" := Members."Employer Code";
                    "Old Employer Name" := Members."Employer Name";
                end;
            end;
        }
        field(3; "Member Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Member No. ")));
        }
        field(4; "Old Employer Code"; Code[50])
        {
            TableRelation = Customer WHERE("Account Type" = CONST(Employer));
            trigger OnValidate()
            begin
                CalcFields("Old Employer Name")
            end;

        }
        field(5; "Old Employer Name"; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Old Employer Code")));
        }
        field(6; "Old Payroll Number"; Code[50])
        {

        }
        field(7; "New Employer Code"; Code[50])
        {
            TableRelation = Customer WHERE("Account Type" = CONST(Employer));
            trigger OnValidate()
            begin
                CalcFields("New Employer Name")
            end;
        }
        field(8; "New Employer Name"; Code[100])
        {

            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("New Employer Code")));
        }
        field(9; "New Payroll Number"; Code[50])
        {

        }

    }
    keys
    {
        key(PK; "Header No.", "Member No. ")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        UserSetUp: Record "User Setup";
    begin

    end;


}
