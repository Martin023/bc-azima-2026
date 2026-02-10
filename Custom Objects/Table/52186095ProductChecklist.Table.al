table 52186095 "Product Checklist"
{

    fields
    {
        field(1; "Product Code"; Code[20])
        {
        }
        field(2; "Mandatory Requirement"; Option)
        {
            OptionCaption = ' ,Salary,Business Income,Member Deposits,Collateral or Guarantors';
            OptionMembers = " ",Salary,"Business Income","Member Deposits","Collateral or Guarantors";
        }
    }

    keys
    {
        key(Key1; "Product Code", "Mandatory Requirement")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

