table 52185664 prLatenessLedger
{
    DrillDownPageID = prLatenessLedger;
    LookupPageID = prLatenessLedger;

    fields
    {
        field(1; "Employee Code"; Code[30])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(2; "Transaction Code"; Code[30])
        {
            TableRelation = "PR Transaction Codes"."Transaction Code";
        }
        field(4; "Payroll Period"; Date)
        {
            TableRelation = "PR Payroll Periods"."Date Opened" WHERE(Closed = CONST(false));
        }
        field(5; "No. Of Days"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Transaction Code", "Payroll Period")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

