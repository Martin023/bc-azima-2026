table 52185513 "HR Employee Target Assignment"
{
    Caption = 'HR Employee Target Assignment';
    DataClassification = CustomerContent;
    DrillDownPageId = "HR Employee Target Assignments";
    LookupPageId = "HR Employee Target Assignments";

    fields
    {
        field(1; "Assignment No"; Code[20])
        {
            Caption = 'Assignment No';

            trigger OnValidate()
            begin
                if "Assignment No" <> xRec."Assignment No" then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Target Assignment Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Department Target No"; Code[20])
        {
            Caption = 'Department Target No';
            TableRelation = "HR Department Targets Header"."Target No";

            trigger OnValidate()
            var
                DeptHeader: Record "HR Department Targets Header";
            begin
                if "Department Target No" <> '' then begin
                    if DeptHeader.Get("Department Target No") then begin
                        "Responsibility Center" := DeptHeader."Responsibility Center";
                        Validate("Responsibility Center");
                        "Appraisal Period" := DeptHeader."Appraisal Period";
                        "Appraisal Year" := DeptHeader."Appraisal Year";
                        "Review Sequence No" := DeptHeader."Review Sequence No";
                        "Appraisal Cycle Stage" := DeptHeader."Appraisal Cycle Stage";
                        "HOD Employee No" := DeptHeader."HOD Employee No";
                        "HOD Name" := DeptHeader."HOD Name";
                    end;
                end;
            end;
        }
        field(3; "Responsibility Center"; Code[20])
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
        field(4; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            Editable = false;
        }
        field(5; "Target Line No"; Integer)
        {
            Caption = 'Target Line No';
            TableRelation = "HR Department Target Line"."Line No" WHERE("Department Target No" = FIELD("Department Target No"));

            trigger OnValidate()
            var
                DeptLine: Record "HR Department Target Line";
            begin
                if ("Department Target No" <> '') and ("Target Line No" <> 0) then begin
                    DeptLine.Reset;
                    DeptLine.SetRange("Department Target No", "Department Target No");
                    DeptLine.SetRange("Line No", "Target Line No");
                    if DeptLine.FindFirst then begin
                        "Perspective Code" := DeptLine."Perspective Code";
                        Validate("Perspective Code");
                        Objective := DeptLine.Objective;
                        Strategy := DeptLine.Strategy;
                        Measures := DeptLine.Measures;
                        Baseline := DeptLine.Baseline;
                        "Targeted Score" := DeptLine."Targeted Score";
                    end;
                end;
            end;
        }
        field(6; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            TableRelation = "HR Employees"."No." WHERE(Status = CONST(Active));

            trigger OnValidate()
            var
                HREmp: Record "HR Employees";
            begin
                "Employee Name" := '';
                if "Employee No" <> '' then begin
                    if HREmp.Get("Employee No") then begin
                        "Employee Name" := HREmp."Full Name";
                        ValidateEmployeeDepartment();
                    end;
                end;
            end;
        }
        field(7; "Employee Name"; Text[200])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(8; "Perspective Code"; Integer)
        {
            Caption = 'Perspective Code';
            TableRelation = "HR Perspectives Setup"."Perspective No" WHERE(Active = CONST(true));
            ValidateTableRelation = false;
            Editable = false;

            trigger OnValidate()
            begin
                CalcFields("Perspective Name", "Scoring Method", "Result Label");
            end;
        }
        field(9; "Perspective Name"; Text[100])
        {
            Caption = 'Perspective Name';
            CalcFormula = Lookup("HR Perspectives Setup"."Perspective Name" WHERE("Perspective No" = FIELD("Perspective Code")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(10; "Scoring Method"; Option)
        {
            Caption = 'Scoring Method';
            CalcFormula = Lookup("HR Perspectives Setup"."Scoring Method" WHERE("Perspective No" = FIELD("Perspective Code")));
            FieldClass = FlowField;
            OptionCaption = 'Standard,Inverted';
            OptionMembers = Standard,Inverted;
            Editable = false;
        }
        field(30; "Result Label"; Text[50])
        {
            CalcFormula = Lookup("HR Perspectives Setup"."Result Label" WHERE("Perspective No" = FIELD("Perspective Code")));
            Caption = 'Result Label';
            FieldClass = FlowField;
            Editable = false;
        }
        field(11; Objective; Text[250])
        {
            Caption = 'Objective';
            Editable = false;
        }
        field(12; Strategy; Text[250])
        {
            Caption = 'Strategy';
            Editable = false;
        }
        field(13; Measures; Text[250])
        {
            Caption = 'Measures';
            Editable = false;
        }
        field(14; Baseline; Decimal)
        {
            Caption = 'Baseline';
            Editable = false;
        }
        field(15; "Targeted Score"; Decimal)
        {
            Caption = 'Targeted Score';
            Editable = false;
        }
        field(16; "Assigned By"; Code[100])
        {
            Caption = 'Assigned By';
            Editable = false;
        }
        field(17; "Assigned Date"; Date)
        {
            Caption = 'Assigned Date';
            Editable = false;
        }
        field(18; "Appraisal Period"; Date)
        {
            Caption = 'Appraisal Period';
            TableRelation = "HR Appraisal Period"."Appraisal Period";
            Editable = false;
        }
        field(19; "Appraisal Year"; Integer)
        {
            Caption = 'Appraisal Year';
            Editable = false;
        }
        field(33; "Review Sequence No"; Integer)
        {
            Caption = 'Review Sequence No';
            Editable = false;
        }
        field(34; "Appraisal Cycle Stage"; Option)
        {
            Caption = 'Appraisal Cycle Stage';
            OptionCaption = 'Target Setting,Evaluation Review,Year-End Review';
            OptionMembers = "Target Setting","Evaluation Review","Year-End Review";
            Editable = false;
        }
        field(20; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Assigned,Accepted,Incorporated';
            OptionMembers = Assigned,Accepted,Incorporated;
            Editable = false;
        }
        field(21; "Incorporated Into Appraisal No"; Code[20])
        {
            Caption = 'Incorporated Into Appraisal No';
            TableRelation = "HR Individual Targets Header"."Appraisal No";
            Editable = false;
        }
        field(22; "Incorporated Date"; Date)
        {
            Caption = 'Incorporated Date';
            Editable = false;
        }
        field(23; "HOD Employee No"; Code[20])
        {
            Caption = 'HOD Employee No';
            TableRelation = "HR Employees"."No.";
            Editable = false;
        }
        field(24; "HOD Name"; Text[200])
        {
            Caption = 'HOD Name';
            Editable = false;
        }
        field(25; "Employee Accepted"; Boolean)
        {
            Caption = 'Employee Accepted';
            Editable = true;

            trigger OnValidate()
            begin
                if "Employee Accepted" then begin
                    if Status = Status::Assigned then
                        Status := Status::Accepted;
                end;
            end;
        }
        field(26; "Employee Comments"; Text[250])
        {
            Caption = 'Employee Comments';
            Editable = true;
        }
        field(27; "Created By"; Code[100])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(28; "Created Date"; Date)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(29; "No. Series"; Code[30])
        {
            Caption = 'No. Series';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Assignment No")
        {
            Clustered = true;
        }
        key(Key2; "Department Target No", "Employee No", "Target Line No")
        {
        }
        key(Key3; "Employee No", Status)
        {
        }
        key(Key4; "Responsibility Center", "Employee No")
        {
        }
        key(Key5; "Appraisal Year", "Employee No", Status)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Assignment No", "Employee No", "Employee Name", Objective)
        {
        }
    }

    trigger OnInsert()
    var
        EmployeeNotification: Notification;
        HREmp: Record "HR Employees";
    begin
        if "Assignment No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Target Assignment Nos.");
            "Assignment No" := NoSeriesMgt.GetNextNo(HRSetup."Target Assignment Nos.");
        end;

        TestField("Department Target No");
        TestField("Employee No");
        TestField("Target Line No");

        ValidateEmployeeDepartment();

        "Assigned Date" := Today;
        "Assigned By" := UserId;
        "Created By" := UserId;
        "Created Date" := Today;
        Status := Status::Assigned;

        Message('Target "%1" assigned to employee %2 (%3)', 
            Objective, "Employee Name", "Employee No");
    end;

    trigger OnDelete()
    begin
        if Status = Status::Incorporated then
            Error('Cannot delete assignment that has been incorporated into appraisal %1', "Incorporated Into Appraisal No");
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit "No. Series";

    procedure ValidateEmployeeDepartment()
    var
        HREmp: Record "HR Employees";
    begin
        if ("Employee No" = '') or ("Responsibility Center" = '') then
            exit;

        if not HREmp.Get("Employee No") then
            Error('Employee %1 does not exist.', "Employee No");

        if HREmp."Responsibility Center" <> "Responsibility Center" then
            Error('Employee %1 (%2) does not belong to department %3. Employee department is %4.',
                "Employee No", "Employee Name", "Department Name", HREmp."Responsibility Center");
    end;

    procedure CheckDuplicateAssignment()
    var
        Assignment: Record "HR Employee Target Assignment";
    begin
        Assignment.Reset;
        Assignment.SetRange("Department Target No", "Department Target No");
        Assignment.SetRange("Target Line No", "Target Line No");
        Assignment.SetRange("Employee No", "Employee No");
        Assignment.SetRange("Appraisal Year", "Appraisal Year");
        Assignment.SetFilter("Assignment No", '<>%1', "Assignment No");
        if not Assignment.IsEmpty then
            Error('This target line has already been assigned to employee %1 (%2) for year %3.',
                "Employee No", "Employee Name", "Appraisal Year");
    end;

    procedure MarkAsAccepted()
    begin
        TestField(Status, Status::Assigned);
        "Employee Accepted" := true;
        Status := Status::Accepted;
        Modify;
        Message('Assignment accepted successfully.');
    end;
}
