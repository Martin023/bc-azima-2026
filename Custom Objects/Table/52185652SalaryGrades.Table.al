table 52185652 "Salary Grades"
{
    DrillDownPageID = "Salary Grades List";
    LookupPageID = "Salary Grades List";

    fields
    {
        field(1; "Salary Grade"; Code[20])
        {
        }
        field(2; "Salary Amount"; Decimal)
        {
        }
        field(8; Allowance; Decimal)
        {

        }
        field(3; Description; Text[100])
        {
        }
        field(4; "Pays NHF"; Boolean)
        {
        }
        field(5; "Pays NSITF"; Boolean)
        {
        }
        field(6; "Minimum Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                "Maxmum Amount" := 0;
                Modify
            end;
        }
        field(7; "Maxmum Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Maxmum Amount" < "Minimum Amount" then
                    Error('Maximum amount cannot be less than the minimum amount')
            end;
        }
        field(9; SalaryPeriod; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(39003940; "Employee Group"; code[20])
        {
            TableRelation = "Employee Group";
            trigger OnValidate()
            var
                EmployeeGroup: record "Employee Group";
            begin
                EmployeeGroup.reset();
                EmployeeGroup.setrange("Employee Group", rec."Employee Group");
                if EmployeeGroup.FindFirst() then
                    rec."Leave Days" := EmployeeGroup."Leave days";
                    rec.modify(true);

            end;
        }
        field(10; "Leave Days"; decimal)
        {

        }

    }

    keys
    {
        key(Key1; "Salary Grade")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

