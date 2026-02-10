table 52186055 "Salary Thru FOSA Update"
{

    fields
    {
        field(1; "Account No."; Code[20])
        {
            TableRelation = "Savings Accounts"."No.";
        }
        field(2; "Date Unmarked"; Date)
        {
        }
        field(3; "Last Salary Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Account No.", "Date Unmarked")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

