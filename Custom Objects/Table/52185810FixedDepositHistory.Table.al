table 52185810 "Fixed Deposit History"
{

    fields
    {
        field(1; No; Integer)
        {
        }
        field(2; "Account No."; Code[20])
        {
            TableRelation = "Savings Accounts"."No." WHERE("Product Category" = CONST("Fixed Deposit"));
        }
        field(3; "Registration Date"; Date)
        {
        }
        field(4; "Fixed Deposit Type"; Code[20])
        {
            TableRelation = "Fixed Deposit Type";
        }
        field(5; "FD Maturity Date"; Date)
        {
        }
        field(6; "Neg. Interest Rate"; Decimal)
        {
        }
        field(7; "FD Duration"; DateFormula)
        {
        }
        field(8; "FD Maturity Instructions"; Option)
        {
            OptionCaption = ' ,Transfer all to Savings,Renew Principal,Renew Principal & Interest';
            OptionMembers = " ","Transfer all to Savings","Renew Principal","Renew Principal & Interest";
        }
        field(9; "Interest Earned"; Decimal)
        {
            Editable = false;
        }
        field(10; "Fixed Amount"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; No, "Account No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

