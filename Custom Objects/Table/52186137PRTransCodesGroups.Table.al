table 52186137 "PR Trans Codes Groups"
{
    Caption = 'PR Transaction Code Groups';

    fields
    {
        field(1; "Group Code"; Code[20])
        {
        }
        field(2; "Group Description"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Group Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PRTransCode: Record "PR Transaction Codes";
}

