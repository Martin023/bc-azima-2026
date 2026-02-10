table 52185515 "HR Appraisal Period"
{

    fields
    {
        field(1; "Appraisal Period"; Date)
        {
        }
        field(2; "Appraisal Period Description"; Text[100])
        {
        }
        field(3; "Appraisal Type"; Option)
        {
             OptionCaption = 'Target Setting,Quarter 1, Quarter 2,Quarter 3,End Year Evalauation';
            OptionMembers = "Target Setting","Quarter 1","Quarter 2","Quarter 3",,"End Year Evalauation";
        }
        field(4; Closed; Boolean)
        {
            editable=false;
        }
        field(5; "Date opened"; Date)
        {
        }
        field(6; "Date closed"; Date)
        {
        }
        field(7; "Appraisal Month"; Integer)
        {
        }
        field(8; "Appraisal Year"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Appraisal Period")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

