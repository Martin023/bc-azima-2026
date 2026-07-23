table 52185755 "HR CEO Goal HOD Assignment"
{
    Caption = 'HR CEO Goal HOD Assignment';
    DataClassification = CustomerContent;
    DrillDownPageId = "HR CEO Goal HOD Assignments";
    LookupPageId = "HR CEO Goal HOD Assignments";

    fields
    {
        field(1; "Assignment No."; Code[20])
        {
            Caption = 'Assignment No.';

            trigger OnValidate()
            begin
                if "Assignment No." <> xRec."Assignment No." then begin
                    HRSetup.Get();
                    NoSeriesMgt.TestManual(HRSetup."Target Assignment Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Goal No."; Code[20])
        {
            Caption = 'Goal No.';
            TableRelation = "HR CEO Goals Header"."Goal No.";

            trigger OnValidate()
            var
                GoalHeader: Record "HR CEO Goals Header";
            begin
                if "Goal No." <> '' then begin
                    if GoalHeader.Get("Goal No.") then begin
                        "Appraisal Period" := GoalHeader."Appraisal Period";
                        "Appraisal Year" := GoalHeader."Appraisal Year";
                        "Review Sequence No." := GoalHeader."Review Sequence No.";
                        "Appraisal Cycle Stage" := GoalHeader."Appraisal Cycle Stage";
                        "CEO Employee No." := GoalHeader."CEO Employee No.";
                        "CEO Name" := GoalHeader."CEO Name";
                    end;
                end;
            end;
        }
        field(3; "Goal Line No."; Integer)
        {
            Caption = 'Goal Line No.';
            TableRelation = "HR CEO Goal Line"."Line No." WHERE("Goal No." = FIELD("Goal No."));

            trigger OnValidate()
            var
                GoalLine: Record "HR CEO Goal Line";
            begin
                if ("Goal No." <> '') and ("Goal Line No." <> 0) then begin
                    GoalLine.Reset();
                    GoalLine.SetRange("Goal No.", "Goal No.");
                    GoalLine.SetRange("Line No.", "Goal Line No.");
                    if GoalLine.FindFirst() then begin
                        "Perspective Code" := GoalLine."Perspective Code";
                        Objective := GoalLine.Objective;
                        Strategy := GoalLine.Strategy;
                        Measures := GoalLine.Measures;
                        Baseline := GoalLine.Baseline;
                        "Targeted Score" := GoalLine."Targeted Score";
                    end;
                end;
            end;
        }
        field(4; "HOD Employee No."; Code[20])
        {
            Caption = 'HOD Employee No.';
            TableRelation = "HR Employees"."No." WHERE(Status = CONST(Active));

            trigger OnValidate()
            var
                HREmp: Record "HR Employees";
                HRHOD: Record "HR Heads of Departments";
            begin
                "HOD Name" := '';
                "Responsibility Center" := '';
                "Department Name" := '';

                if "HOD Employee No." <> '' then begin
                    if HREmp.Get("HOD Employee No.") then begin
                        "HOD Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                        // PULL DEPT FROM HOD REGISTER
                        HRHOD.Reset();
                        HRHOD.SetRange("Employee No.", "HOD Employee No.");
                        if HRHOD.FindFirst() then begin
                            "Responsibility Center" := HRHOD."Responsibility center";
                            Validate("Responsibility Center");
                        end;
                    end;
                end;
            end;
        }
        field(5; "HOD Name"; Text[200])
        {
            Caption = 'HOD Name';
            Editable = false;
        }
        field(6; "Responsibility Center"; Code[20])
        {
            Caption = 'Department';
            TableRelation = "Responsibility CenterBR".Code;
            Editable = false;

            trigger OnValidate()
            var
                RespCenter: Record "Responsibility CenterBR";
            begin
                "Department Name" := '';
                if "Responsibility Center" <> '' then begin
                    if RespCenter.Get("Responsibility Center") then
                        "Department Name" := RespCenter.Name;
                end;
            end;
        }
        field(7; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            Editable = false;
        }
        field(8; "Perspective Code"; Integer)
        {
            Caption = 'Perspective Code';
            TableRelation = "HR Perspectives Setup"."Perspective No" WHERE(Active = CONST(true));
            ValidateTableRelation = false;
            Editable = false;
        }
        field(9; "Perspective Name"; Text[100])
        {
            Caption = 'Perspective Name';
            CalcFormula = Lookup("HR Perspectives Setup"."Perspective Name" WHERE("Perspective No" = FIELD("Perspective Code")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(10; Objective; Text[250])
        {
            Caption = 'Objective';
            Editable = false;
        }
        field(11; Strategy; Text[250])
        {
            Caption = 'Strategy';
            Editable = false;
        }
        field(12; Measures; Text[250])
        {
            Caption = 'Measures / KPI';
            Editable = false;
        }
        field(13; Baseline; Decimal)
        {
            Caption = 'Baseline';
            Editable = false;
        }
        field(14; "Targeted Score"; Decimal)
        {
            Caption = 'Targeted Score';
            Editable = false;
        }
        field(15; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Assigned,Acknowledged,Incorporated';
            OptionMembers = Assigned,Acknowledged,Incorporated;
        }
        field(16; "HOD Acknowledged"; Boolean)
        {
            Caption = 'HOD Acknowledged';

            trigger OnValidate()
            begin
                if "HOD Acknowledged" then begin
                    if Status = Status::Assigned then begin
                        Status := Status::Acknowledged;
                        "Acknowledged Date" := Today;
                        "Acknowledged By" := UserId;
                    end;
                end else begin
                    // ALLOW UNACKNOWLEDGE ONLY IF NOT YET INCORPORATED
                    if Status = Status::Incorporated then
                        Error('CANNOT UN-ACKNOWLEDGE A GOAL THAT HAS BEEN INCORPORATED INTO A DEPARTMENT TARGET.');
                    Status := Status::Assigned;
                    "Acknowledged Date" := 0D;
                    "Acknowledged By" := '';
                end;
            end;
        }
        field(17; "Acknowledged By"; Code[100])
        {
            Caption = 'Acknowledged By';
            Editable = false;
        }
        field(18; "Acknowledged Date"; Date)
        {
            Caption = 'Acknowledged Date';
            Editable = false;
        }
        field(19; "Incorporated Into Target No."; Code[20])
        {
            Caption = 'Incorporated Into Target No.';
            TableRelation = "HR Department Targets Header"."Target No";
            Editable = false;
        }
        field(20; "Incorporated Date"; Date)
        {
            Caption = 'Incorporated Date';
            Editable = false;
        }
        field(21; "HOD Comments"; Text[250])
        {
            Caption = 'HOD Comments';
        }
        field(22; "Assigned By"; Code[100])
        {
            Caption = 'Assigned By';
            Editable = false;
        }
        field(23; "Assigned Date"; Date)
        {
            Caption = 'Assigned Date';
            Editable = false;
        }
        field(24; "Appraisal Period"; Date)
        {
            Caption = 'Appraisal Period';
            TableRelation = "HR Appraisal Period"."Appraisal Period";
            Editable = false;
        }
        field(25; "Appraisal Year"; Integer)
        {
            Caption = 'Appraisal Year';
            Editable = false;
        }
        field(26; "Review Sequence No."; Integer)
        {
            Caption = 'Review Sequence No.';
            Editable = false;
        }
        field(27; "Appraisal Cycle Stage"; Option)
        {
            Caption = 'Appraisal Cycle Stage';
            OptionCaption = 'Target Setting,Evaluation Review,Year-End Review';
            OptionMembers = "Target Setting","Evaluation Review","Year-End Review";
            Editable = false;
        }
        field(28; "CEO Employee No."; Code[20])
        {
            Caption = 'CEO Employee No.';
            TableRelation = "HR Employees"."No.";
            Editable = false;
        }
        field(29; "CEO Name"; Text[200])
        {
            Caption = 'CEO Name';
            Editable = false;
        }
        field(30; "No. Series"; Code[30])
        {
            Caption = 'No. Series';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Assignment No.")
        {
            Clustered = true;
        }
        key(Key2; "Goal No.", "Goal Line No.", "HOD Employee No.")
        {
        }
        key(Key3; "HOD Employee No.", Status)
        {
        }
        key(Key4; "Appraisal Year", "HOD Employee No.", Status)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Assignment No.", "HOD Employee No.", "HOD Name", Objective)
        {
        }
    }

    trigger OnInsert()
    begin
        if "Assignment No." = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Target Assignment Nos.");
            "Assignment No." := NoSeriesMgt.GetNextNo(HRSetup."Target Assignment Nos.");
            "No. Series" := HRSetup."Target Assignment Nos.";
        end;

        TestField("Goal No.");
        TestField("Goal Line No.");
        TestField("HOD Employee No.");

        CheckDuplicateAssignment();

        "Assigned By" := UserId;
        "Assigned Date" := Today;
        Status := Status::Assigned;
    end;

    trigger OnDelete()
    begin
        if Status = Status::Incorporated then
            Error('CANNOT DELETE AN ASSIGNMENT ALREADY INCORPORATED INTO DEPARTMENT TARGET %1.', "Incorporated Into Target No.");
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit "No. Series";

    procedure CheckDuplicateAssignment()
    var
        Existing: Record "HR CEO Goal HOD Assignment";
    begin
        Existing.Reset();
        Existing.SetRange("Goal No.", "Goal No.");
        Existing.SetRange("Goal Line No.", "Goal Line No.");
        Existing.SetRange("HOD Employee No.", "HOD Employee No.");
        Existing.SetFilter("Assignment No.", '<>%1', "Assignment No.");
        if not Existing.IsEmpty then
            Error('GOAL LINE %1 HAS ALREADY BEEN ASSIGNED TO HOD %2 (%3).', "Goal Line No.", "HOD Name", "HOD Employee No.");
    end;

    procedure MarkAsIncorporated(DeptTargetNo: Code[20])
    begin
        TestField(Status, Status::Acknowledged);
        Status := Status::Incorporated;
        "Incorporated Into Target No." := DeptTargetNo;
        "Incorporated Date" := Today;
        Modify();
    end;
}
