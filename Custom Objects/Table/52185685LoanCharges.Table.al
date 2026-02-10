table 52185685 "Loan Charges"
{
    DrillDownPageID = "Loan Charges";
    LookupPageID = "Loan Charges";

    fields
    {
        field(1; "Charge Code"; Code[20])
        {
        }
        field(2; "Charge Description"; Text[70])
        {
        }
        field(3; "Charge Amount"; Decimal)
        {
        }
        field(4; "Use Percentage"; Boolean)
        {
        }
        field(5; Percentage; Decimal)
        {
        }
        field(6; "Charge Type"; Option)
        {
            OptionCaption = 'General,Top up,External Loan,Boosting,Asset Finance';
            OptionMembers = General,"Top up","External Loan",Boosting,"Asset Finance";
        }
        field(7; "Charging Option"; Option)
        {
            OptionMembers = ,"On Approved Amount","On Net Amount";
        }
        field(8; "Effect Excise Duty"; Option)
        {
            OptionCaption = 'No,Yes';
            OptionMembers = No,Yes;
        }
        field(9; "Charge Method"; Option)
        {
            OptionCaption = 'Flat Amount,% of Amount,Staggered';
            OptionMembers = "Flat Amount","% of Amount",Staggered;
        }
        field(10; "Staggered Charge Code"; Code[20])
        {
            TableRelation = "Tiered Charges Header";
        }
    }

    keys
    {
        key(Key1; "Charge Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Charge Code", "Charge Description")
        {

        }
    }
}

