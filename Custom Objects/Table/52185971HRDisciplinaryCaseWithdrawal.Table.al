table 52185971 "HRDisciplinary Case Withdrawal"
{

    fields
    {
        field(1; "No."; Code[30])
        {
        }
        field(2; "Employee No."; Code[30])
        {
            Editable = false;
            TableRelation = "HR Employees"."No.";

            trigger OnLookup()
            begin
                HREmployees.Reset;
                SetRange("Employee No.", HREmployees."No.");
                if HREmployees.FindFirst then begin
                    "Employee Name" := HREmployees."First Name";
                end;
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
            Editable = false;
        }
        field(4; "Disciplinary Case No."; Code[30])
        {
            TableRelation = "HR Disciplinary Cases NCA"."Case Number" WHERE("Disciplinary Stage Status" = FILTER(<> Closed));

            trigger OnValidate()
            begin
                Disc.Reset;
                Disc.SetRange(Disc."Case Number", "Disciplinary Case No.");
                if Disc.Find('-') then
                    "Case Description" := Disc."Description of Complaint";
            end;
        }
        field(5; "Case Description"; Text[250])
        {
            Editable = false;
        }
        field(7; "Reason for Withdrawal"; Text[250])
        {
        }
        field(8; Region; Code[30])
        {
            Editable = false;
        }
        field(9; Department; Code[30])
        {
            Editable = false;
        }
        field(10; "Responsibility Center"; Code[30])
        {
            Editable = false;
            TableRelation = "Responsibility Center".Code;
        }
        field(11; Status; Option)
        {
            Editable = false;
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(12; "No Series"; Code[30])
        {
        }
        field(13; "User ID"; Code[50])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //No. Series
        if "No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Disciplinary Withdrawal Nos.");
            "No." := NoSeriesMgt.GetNextNo(HRSetup."Disciplinary Withdrawal Nos.");
            // NoSeriesMgt.InitSeries(HRSetup."Disciplinary Withdrawal Nos.", xRec."No Series", 0D, "No.", "No Series");
        end;

        HREmployees.Reset;
        HREmployees.SetRange(HREmployees."User ID", UserId);
        if HREmployees.Find('-') then begin
            "Employee Name" := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
            "Employee No." := HREmployees."No.";
            "User ID" := HREmployees."User ID";
            Region := HREmployees."Global Dimension 1 Code";
            Department := HREmployees."Global Dimension 2 Code";
            "Responsibility Center" := HREmployees."Responsibility Center";
        end;
    end;

    var
        HREmployees: Record "HR Employees";
        HRSetup: Record "HR Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        Disc: Record "HR Disciplinary Cases NCA";
}

