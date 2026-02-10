table 52185583 "HR Training App Lines"
{
    // DrillDownPageID = "HR Training Application Lines";
    // LookupPageID = "HR Training Application Lines";

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Application No."; Code[20])
        {
        }
        field(3; "Employee No."; Code[20])
        {
            Editable = false;
            TableRelation = IF (Type = CONST(Employees)) "HR Employees"
            ELSE
            IF (Type = CONST(Delegates)) "Delegate Officials"."Member Number";

            trigger OnValidate()
            var
                Delegates: record "Delegate Officials";
                HrLeave: record "HR Leave Application";
                HrTraining: record "HR Training App Lines";
                HrTrainHeader: record "HR Training App Header";
                Members: record Members;

            begin
                Name := '';
                "Job ID" := '';
                "Job Title" := '';
                if rec.Type = rec.Type::Employees then
                    HREmployees.Reset;
                if HREmployees.Get("Employee No.") then begin
                    Name := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
                    "Job ID" := HREmployees.Position;
                    "Job Title" := HREmployees."Job Title";
                    "Participant Email" := HREmployees."Company E-Mail";

                end else
                    if rec.Type = rec.Type::Delegates then begin
                        Delegates.reset();
                        Delegates.setrange("Member Number", rec."Employee No.");
                        if Delegates.Find('-') then begin
                            if Members.get("Employee No.") then
                                Name := Members.Name;
                            "Job ID" := Delegates.Position;
                            //"Job Title" := Delegates.Position;
                            //"Participant Email" := HREmployees."Company E-Mail";

                        end;

                    end;

                // hrleave.Reset();
                // Hrleave.setrange(Hrleave.status, Hrleave.status::Approved);
                // if hrleave.FindSet() then begin
                //     HrTrainHeader.reset();
                //     HrTrainHeader.SetRange("Date Filter", HrLeave."Start Date", HrLeave."Return Date");
                //     if HrTrainHeader.Find('-') then begin
                //         Repeat
                //             HrTraining.reset();
                //             HrTraining.setrange("Application No.", HrTrainHeader."Application No");
                //             HrTraining.setrange("Employee No.", HrLeave."Applicant Staff No.");
                //             if HrTraining.Find('-') then begin
                //                 Message('%1 is on leave', HrTraining."Employee No.");
                //             end
                //         Until HrTraining.next = 0;
                //     end
                //end;

            end;
        }
        field(4; Name; Text[50])
        {
        }
        field(5; Objectives; Text[250])
        {
        }
        field(6; "Job ID"; Code[100])
        {
            TableRelation = "HR Jobs"."Job ID";
            trigger OnValidate()
            var
                hrjobs: Record "HR Jobs";
            begin
                hrjobs.reset();
                hrjobs.SetRange("Job ID", rec."Job ID");
                if hrjobs.FindSet() then
                    "Job Title" := hrjobs."Job Description";

            end;
        }
        field(7; "Job Title"; Text[50])
        {
            Editable = false;
        }
        field(8; Notified; Boolean)
        {
        }
        field(9; Suggested; Boolean)
        {
            Editable = false;
        }
        field(10; "Participant Email"; Text[100])
        {
            Editable = false;
        }
        field(11; "On Leave"; boolean)
        {
            trigger OnValidate()
            begin

            end;
        }
        field(12; Remarks; Text[100])
        {

        }
        field(13; Type; Option)
        {
            OptionMembers = ,Employees,Delegates;
        }
    }

    keys
    {
        key(Key1; "Line No.", "Application No.", "Employee No.")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
    }

    var
        HREmployees: Record "HR Employees";
        LeaveApplication: record "HR Leave Application";
}

