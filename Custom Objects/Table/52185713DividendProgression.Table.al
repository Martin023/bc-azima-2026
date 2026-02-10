table 52185713 "Dividend Progression"
{
    LookupPageID = "Dividend Progression";
    DrillDownPageId = "Dividend Progression";

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
        field(6; "Product Name"; Text[100])
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
        field(16; "Employer Code"; Code[100])
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
        field(20; "Month Name"; Text[30])
        { }
        field(21; "Forfeited"; Boolean)
        { }

    }

    keys
    {
        key(Key1; "Account No", "Product Type", Year, Month, "Entry No.")
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

