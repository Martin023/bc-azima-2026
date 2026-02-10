table 52185513 "HR Job Training Needs"
{

    fields
    {
        field(1; "CODE"; Code[50])
        {
            Description = 'Primary Key';

            trigger OnValidate()
            begin
                /*
                HrJobs.RESET;
                IF HrJobs.GET(CODE) THEN BEGIN
                Description:=HrJobs.Description;
                 END;
                */

            end;
        }
        field(2; "Job ID"; Code[50])
        {
            TableRelation = "HR Jobs"."Job ID";
        }
        field(3; Description; Text[250])
        {
        }
        field(4; "Training Group"; Code[50])
        {
            TableRelation = "Project Partners";
        }
        field(5; "No of Participants"; Code[10])
        {
            TableRelation = "Project Partners";
        }
    }

    keys
    {
        key(Key1; "CODE", "Job ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HrJobs: Record "HR Jobs";
}

