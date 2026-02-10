table 52187080 "Dividend Provision"
{
    LookupPageID = "Dividend Provision";

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Account No"; Code[20])
        {
            TableRelation = "Savings Accounts";
        }
        field(3; "Processing Date"; Date)
        {
        }
        field(4; "Dividend Calc. Method"; Option)
        {
            OptionCaption = ' ,Flat Rate,Prorated';
            OptionMembers = " ","Flat Rate",Prorated;
        }
        field(5; "Product Type"; Code[10])
        {
        }
        field(6; "Product Name"; Text[50])
        {
        }
        field(7; "Member No"; Code[20])
        {
            TableRelation = Members;
        }
        field(8; "Qualifying Shares"; Decimal)
        {
        }
        field(9; Shares; Decimal)
        {
        }
        field(10; "Gross Dividends"; Decimal)
        {
        }
        field(11; "Witholding Tax"; Decimal)
        {
        }
        field(12; "Net Dividends"; Decimal)
        {
        }
        field(13; "Start Date"; Date)
        {
        }
        field(14; "End Date"; Date)
        {
        }
        field(15; "Payment Mode"; Code[20])
        {
        }
        field(16; "Employer Code"; Code[10])
        {
            TableRelation = Customer."No." WHERE("Account Type" = FILTER(Employer));
        }
        field(17; Year; Integer)
        {
        }
        field(18; Month; Integer)
        {
        }
        field(19; Posted; Boolean)
        {
        }
        field(20; "Dividends No."; Code[20])
        {
        }
        field(21; "Payable Account"; Code[20])
        {
        }
        field(22; "Expense Account"; Code[20])
        {
        }
        field(23; "Interest Rate"; Decimal)
        {
        }



    }

    keys
    {
        key(Key1; "Account No", "Product Type", Year, Month)
        {
            Clustered = true;
        }
        key(Key2; "Member No")
        {
        }
    }

    fieldgroups
    {
    }
}

