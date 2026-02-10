table 52185752 "Account Access Log"
{

    fields
    {
        field(1; Sno; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Account No."; Code[50])
        {
            Editable = false;
        }
        field(3; Date; Date)
        {
            Editable = false;
        }
        field(4; Time; Time)
        {
            Editable = false;
        }
        field(5; "Info Source"; Option)
        {
            Editable = false;
            OptionMembers = ,"Savings Card","Report","Member Card";
        }
        field(6; "User Id"; Code[50])
        {
            Editable = false;
        }
        field(7; Source; Option)
        {
            Editable = false;
            OptionCaption = ',Member,Account';
            OptionMembers = ,Member,Account;
        }
        field(8; "Account Status"; Text[20])
        {
            Editable = false;
            Caption = 'Account Status';
        }

    }

    keys
    {
        key(Key1; Sno)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

