table 52185592 "HR Promo. Recommend Header"
{
    // DrillDownPageID = "HR Promotion Recommend List";
    // LookupPageID = "HR Promotion Recommend List";

    fields
    {
        field(1; No; Code[20])
        {

            trigger OnValidate()
            begin

                HREmployees.Reset;
                SetRange(No, HREmployees."No.");
                if HREmployees.FindFirst then begin
                    "Employee Name" := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
                end;
            end;
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                HREmployees.Reset;
                HREmployees.SetRange(HREmployees."No.", "Employee No.");
                if HREmployees.Find('-') then begin
                    "Employee Name" := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
                    "Shortcut Dimension code1" := HREmployees."Department Code";
                    "Shortcut Dimension code2" := HREmployees.Office;
                    "Job Title" := HREmployees."Job Title";
                    "Salary Grade" := HREmployees."Salary Grade";
                    "Salary Notch" := HREmployees."Salary Notch/Step";
                end else begin
                    "Employee Name" := '';
                    "Shortcut Dimension code1" := '';
                    "Shortcut Dimension code2" := '';
                    "Job Title" := '';
                    "Salary Grade" := '';
                    "Salary Notch" := '';
                end;
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
        }
        field(4; "Shortcut Dimension code1"; Code[20])
        {
            TableRelation = "Dimension Value".Code;
        }
        field(5; "Shortcut Dimension code2"; Code[20])
        {
            TableRelation = "Dimension Value".Code;
        }
        field(6; Date; Date)
        {
        }
        field(7; Reason; Text[250])
        {
        }
        field(8; Status; Option)
        {
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(9; "No Series"; Code[20])
        {
        }
        field(10; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center B".Code;
        }
        field(11; Competencies; Text[250])
        {
        }
        field(12; "Development Areas"; Text[250])
        {
        }
        field(13; "Job Title"; Text[50])
        {
        }
        field(14; "Salary Grade"; Code[20])
        {
        }
        field(15; "New Job ID"; Code[20])
        {
            TableRelation = "HR Jobs"."Job ID";

            trigger OnValidate()
            begin
                Jobs.Reset;
                Jobs.SetRange(Jobs."Job ID", "New Job ID");
                if Jobs.Find('-') then
                    "New Job Title" := Jobs."Job Description"
                else
                    "New Job Title" := '';
            end;
        }
        field(16; "New Job Title"; Text[50])
        {
        }
        field(17; "New Salary Grade"; Code[20])
        {
            TableRelation = "Salary Grades"."Salary Grade";
        }
        field(18; "New Salary Notch"; Code[20])
        {
            TableRelation = "Salary Notch"."Salary Notch" WHERE("Salary Grade" = FIELD("New Salary Grade"));
        }
        field(19; Promoted; Boolean)
        {
        }
        field(20; "Salary Notch"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if No = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Employee Promotion No.");
            No := NoSeriesMgt.GetNextNo(HRSetup."Employee Promotion No.");
            // NoSeriesMgt.InitSeries(HRSetup."Employee Promotion No.", xRec."No Series", 0D, No, "No Series");
        end;
    end;

    var
        HRSetup: Record "HR Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        HREmployees: Record "HR Employees";
        Jobs: Record "HR Jobs";
}

