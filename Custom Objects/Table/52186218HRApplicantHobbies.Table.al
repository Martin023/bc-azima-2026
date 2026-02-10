table 52186218 "HR Applicant Hobbies"
{

    fields
    {
        field(1; "Job Application No"; Code[20])
        {
            // //TableRelation = Table39003905.Field1;
        }
        field(2; Hobby; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Job Application No", Hobby)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

