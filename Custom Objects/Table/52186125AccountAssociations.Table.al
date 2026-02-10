table 52186125 "Account Associations"
{

    fields
    {
        field(1; EntyNo; Integer)
        {
        }
        field(2; "Account No."; Code[20])
        {
        }
        field(3; Description; Text[30])
        {
        }
        field(4; "ID No."; Code[20])
        {
        }
        field(5; "Member No."; Code[20])
        {
        }
        field(6; Type; Code[20])
        {
        }
        field(7; "Account Name"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; EntyNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

