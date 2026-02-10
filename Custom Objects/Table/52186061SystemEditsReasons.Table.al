table 52186061 "System Edit Reasons"
{

    DrillDownPageId = "System Edits Reasons";
    LookupPageId = "System Edits Reasons";
    fields
    {
        field(1; "Code"; Code[50])
        {
        }
        field(3; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility CenterBR";
        }
        field(2; Description; Text[200])
        {

        }
    }

    keys
    {
        key(Key1; "Code", "Responsibility Center")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, "Responsibility Center", Description)
        {

        }
    }

    var

}

