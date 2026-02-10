table 52185831 "SMS Setup"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; "Member Creation"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(3; "Deposit Confirmation"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(4; "Cash Withdrawal"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(5; "Loan Application"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(6; "Loan Guarantors"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(7; "Loan Posted"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(8; "Loan defaulted"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(9; "Salary Posted"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(10; "Fixed Deposit Maturity"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(11; "InterAccount Transfer"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(12; "Account Status"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(13; "Status Order Creation"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(14; "EFT Effected"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(15; "ATM Application Failed"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(16; "ATM Collection"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(17; MSACCO; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(18; SMS; Boolean)
        {
        }
        field(19; "E-Mail"; Boolean)
        {
        }
        field(20; "Subscription Type"; Option)
        {
            OptionCaption = ' ,Push,Subscribe';
            OptionMembers = " ",Push,Subscribe;
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

