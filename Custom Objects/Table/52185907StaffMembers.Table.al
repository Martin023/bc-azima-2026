table 52185907 "Staff Members"
{

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Member,"Non-Member";
        }
        field(3; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members WHERE("Account Category" = FILTER(Member | "Staff Member"));

            trigger OnValidate()
            begin

                "ID No." := '';
                Name := '';
                "Savings Account" := '';

                if Members.Get("Member No.") then begin
                    Name := Members.Name;
                    "ID No." := Members."Primary Identification";
                    "Staff No" := Members."Payroll/Staff No.";
                end;
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("Member No.", "Member No.");
                SavingsAccounts.SetRange("Loan Disbursement Account", true);
                if SavingsAccounts.FindFirst then begin
                    "Savings Account" := SavingsAccounts."No.";
                end;
                Employees.Reset;
                Employees.SetRange("No.", "Staff No");
                if Employees.FindFirst then begin
                    "Allowance Grade" := Employees.Grade;
                end;
            end;
        }
        field(4; Name; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Active,"Non-Active";

            trigger OnValidate()
            begin
                "Status Change Date" := Today;
                "Status Changed By" := UserId;
                TestField("Allowance Grade");
            end;
        }
        field(6; "Status Change Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Status Changed By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "ID No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Savings Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Table39004285 WHERE (Field61 = FIELD ("Member No."));
        }
        field(10; "Allowance Grade"; Code[20])
        {
            TableRelation = "Staff Allowance Grades";
        }
        field(11; "Staff No"; Code[20])
        {
        }
        field(12; "Staff Membrs"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Member No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Members: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        Employees: Record Employee;
}

