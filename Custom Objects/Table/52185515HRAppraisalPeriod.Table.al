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
        field(3; "Appraisal Cycle Stage"; Option)
        {
            OptionCaption = 'Target Setting,Evaluation Review,Year-End Review';
            OptionMembers = "Target Setting","Evaluation Review","Year-End Review";
        }
        field(4; Closed; Boolean)
        {
            editable = false;
        }
        field(5; "Date Opened"; Date)
        {
        }
        field(6; "Date Closed"; Date)
        {
        }
        field(7; "Appraisal Year"; Integer)
        {
        }
        field(8; "Review Sequence No"; Integer)
        {
        }
        field(9; "Period Start Date"; Date)
        {
        }
        field(10; "Period End Date"; Date)
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

