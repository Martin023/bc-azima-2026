table 52185662 "prEmployee Banks Temp"
{

    fields
    {
        field(1; "Employee Code"; Code[10])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(2; "Bank Code"; Code[50])
        {
            TableRelation = "PR Bank Branches"."Branch Code";
        }
        field(3; "Branch Code"; Code[50])
        {
            TableRelation = "PR Bank Branches"."Branch Name" WHERE("Branch Code" = FIELD("Bank Code"));
        }
        field(5; "Account No"; Text[50])
        {
        }
        field(7; Amount; Decimal)
        {
            Description = 'Refers to Amount to be transfered to this A/C';
            InitValue = 0;
        }
        field(8; Currency; Code[10])
        {
            TableRelation = Currency.Code;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Bank Code", Currency)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

