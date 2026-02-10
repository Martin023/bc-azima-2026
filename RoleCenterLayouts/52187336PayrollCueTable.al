table 52187336 "Payroll Activities Cue"
{


    fields
    {
        field(1; PrimaryKey; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; SalaryList; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("HR Employees");

        }
        field(3; "Bank Accounts"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("pr Bank Accounts");
        }
        field(4; "Employee Allowances"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("PR Employee Allowances");
        }
        field(5; "Pending Leave Allowances"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Leave Allowances" where(Paid = filter(false)));
        }

    }

    keys
    {
        key(PrimaryKey; PrimaryKey)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;



}