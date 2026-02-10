table 52186046 "ATM Alerts"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
        }
        field(2; "Date Time"; DateTime)
        {
        }
        field(3; Subject; Code[30])
        {
        }
        field(4; Description; Text[250])
        {
        }
        field(5; "Description Address"; Text[100])
        {
        }
        field(6; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Pending,Sent';
            OptionMembers = Pending,Sent;
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

