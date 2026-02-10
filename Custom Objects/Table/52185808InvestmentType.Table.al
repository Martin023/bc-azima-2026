table 52185808 "Investment Type"
{
    DrillDownPageID = "Investment Type";
    LookupPageID = "Investment Type";
    

    fields
    {
        field(1; "Code"; Code[30])
        {
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
        }
        field(3; Type; Option)
        {
            OptionCaption = 'Money Market,Bond';
            OptionMembers = "Money Market",Bond;
        }
        field(4; Interest; Decimal)
        {
        }
        field(5; "Repayment Frequency"; DateFormula)
        {
        }
        field(6; "Deposit Type"; Option)
        {
            OptionCaption = ' ,Fixed,Call,Treasury Bills,Shares,Bonds';
            OptionMembers = " ","Fixed",Call,"Treasury Bills",Shares,Bonds;
        }
        field(7; "Accrued Interest G/L Acc"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(8; "Interest Income G/L Acc"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

