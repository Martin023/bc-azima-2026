table 52186052 "Online Special Request"
{

    fields
    {
        field(1; "Application No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Application Date"; DateTime)
        {
        }
        field(3; "Member No"; Text[30])
        {
        }
        field(4; "Request Type"; Option)
        {
            OptionCaption = ' ,Cheque,ATM Card,MSACCO,Dividends,ATM Card Disable,ATM Card Replacement';
            OptionMembers = " ",Cheque,"ATM Card",MSACCO,Dividends,"ATM Card Disable","ATM Card Replacement";
        }
        field(5; "Account No"; Text[30])
        {
        }
        field(6; "Id No"; Text[30])
        {
        }
        field(11; "Cheque Type"; Text[30])
        {
        }
        field(12; "Cheque Leaves"; Integer)
        {
        }
        field(13; Status; Option)
        {
            OptionCaption = 'Pending,Processing,Approved';
            OptionMembers = Pending,Processing,Approved;
        }
        field(14; Reason; Text[250])
        {
        }
        field(17; Amount; Decimal)
        {
        }
        field(18; Narration; Text[250])
        {
        }
        field(19; User; Text[30])
        {
        }
        field(20; Posted; Boolean)
        {
        }
        field(21; "Date Posted"; Date)
        {
        }
        field(22; "Re-Opened By"; Code[30])
        {
        }
        field(23; "Date Re-opened"; DateTime)
        {
        }
        field(24; "Closed By"; Code[30])
        {
        }
        field(25; "Date Closed"; DateTime)
        {
        }
        field(26; "Delegated To"; Code[30])
        {
        }
        field(27; "Date Delegated"; DateTime)
        {
        }
        field(28; "Delegated By"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "Application No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

