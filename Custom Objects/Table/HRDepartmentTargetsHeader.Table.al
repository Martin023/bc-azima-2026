table 52185496 "HR Department Targets Header"
{
    Caption = 'HR Department Targets Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Target No"; Code[20])
        {
            Caption = 'Target No';

            trigger OnValidate()
            begin
                if "Target No" <> xRec."Target No" then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Appraisal Nos");
                    "No Series" := '';
                end;
            end;
        }
        // COMMENTED OUT - WRONG REFERENCE (LINKED TO BRANCH INSTEAD OF DEPARTMENT)
        // GLOBAL DIMENSION 1 = BRANCH (HQ, WESTLANDS, ETC), NOT DEPARTMENT
        /*
        field(2; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                DimensionValue.Reset;
                DimensionValue.SetRange(DimensionValue.Code, "Department Code");
                DimensionValue.SetRange(DimensionValue."Global Dimension No.", 1);
                if DimensionValue.Find('-') then begin
                    "Department Name" := DimensionValue.Name;
                end;
            end;
        }
        */
        field(3; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            Editable = false;
        }
        field(4; "Appraisal Period"; Date)
        {
            Caption = 'Appraisal Period';
            TableRelation = "HR Appraisal Period"."Appraisal Period";
        }
        field(5; "Appraisal Year"; Integer)
        {
            Caption = 'Appraisal Year';
            Editable = true;
        }
        field(6; "Target Date"; Date)
        {
            Caption = 'Target Date';  
        }
        field(7; "HOD Employee No"; Code[20])
        {
            Caption = 'HOD Employee No';
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                HREmp.Reset;
                if HREmp.Get("HOD Employee No") then
                    "HOD Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            end;
        }
        field(8; "HOD Name"; Text[200])
        {
            Caption = 'HOD Name';
            Editable = false;
        }
        field(9; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Closed';
            OptionMembers = Open,"Pending Approval",Approved,Closed;
        } 
        field(18; "Unachieved Targets"; Decimal)
        {
            CalcFormula = Sum("HR Department Target Line"."Unachieved Targets" WHERE("Department Target No" = FIELD("Target No")));
            Caption = 'Unachieved Targets';
            FieldClass = FlowField;
        }
        field(19; "Created By"; Code[100])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(20; "Created Date"; Date)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(21; "Approved By"; Code[100])
        {
            Caption = 'Approved By';
            Editable = false;
        }
        field(22; "Approved Date"; Date)
        {
            Caption = 'Approved Date';
            Editable = false;
        }
        field(23; "No Series"; Code[30])
        {
            Caption = 'No Series';
        }
        field(24; "Responsibility Center"; Code[20])
        {
            Caption = 'Department';
            TableRelation = "Responsibility CenterBR".Code;
            Editable = true;
            
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
        field(25; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(26; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(27; "Targets Assigned"; Boolean)
        {
            Caption = 'Targets Assigned';
            CalcFormula = Exist("HR Employee Target Assignment" WHERE("Department Target No" = FIELD("Target No")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(28; "Total Assignments"; Integer)
        {
            Caption = 'Total Assignments';
            CalcFormula = Count("HR Employee Target Assignment" WHERE("Department Target No" = FIELD("Target No")));
            FieldClass = FlowField;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Target No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Target No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Appraisal Nos");
            "Target No" := NoSeriesMgt.GetNextNo(HRSetup."Appraisal Nos");
        end;

        "Target Date" := Today;
        "Created By" := UserId;
        "Created Date" := Today;
        Status := Status::Open;
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit "No. Series";
        HREmp: Record "HR Employees";
        DimensionValue: Record "Dimension Value";

    procedure AssignLineToEmployees(LineNo: Integer)
    var
        DeptLine: Record "HR Department Target Line";
        Employee: Record "HR Employees";
        TempEmployee: Record "HR Employees" temporary;
        EmployeeSelection: Page "Employee Selection List";
        Assignment: Record "HR Employee Target Assignment";
        AssignmentCount: Integer;
    begin
        TestField("Target No");
        TestField("Responsibility Center");

        DeptLine.Reset;
        DeptLine.SetRange("Department Target No", "Target No");
        DeptLine.SetRange("Line No", LineNo);
        if not DeptLine.FindFirst then
            Error('Department target line %1 not found.', LineNo);

        Employee.Reset;
        Employee.SetRange("Responsibility Center", "Responsibility Center");
        Employee.SetRange(Status, Employee.Status::Active);
        if not Employee.FindFirst then
            Error('No active employees found in department %1', "Department Name");

        Employee.Reset;
        Employee.SetRange("Responsibility Center", "Responsibility Center");
        Employee.SetRange(Status, Employee.Status::Active);
        EmployeeSelection.SetTableView(Employee);
        EmployeeSelection.LookupMode(true);
        
        if EmployeeSelection.RunModal = ACTION::LookupOK then begin
            EmployeeSelection.GetSelectedEmployees(TempEmployee);
            
            if TempEmployee.FindSet then begin
                AssignmentCount := 0;
                repeat
                    if not AssignmentExists(DeptLine, TempEmployee."No.") then begin
                        Clear(Assignment);
                        Assignment.Init;
                        Assignment."Department Target No" := "Target No";
                        Assignment.Validate("Department Target No");
                        Assignment."Target Line No" := DeptLine."Line No";
                        Assignment.Validate("Target Line No");
                        Assignment."Employee No" := TempEmployee."No.";
                        Assignment.Validate("Employee No");
                        Assignment.Insert(true);
                        AssignmentCount += 1;
                    end;
                until TempEmployee.Next = 0;

                if AssignmentCount > 0 then
                    Message('%1 employee(s) assigned successfully.', AssignmentCount)
                else
                    Message('No new assignments created. Selected employees may already have this target assigned.');
            end else begin
                Error('No employees selected. Please select employees by clicking on rows (Ctrl+Click for multiple).');
            end;
        end;
    end;

    local procedure AssignmentExists(DeptLine: Record "HR Department Target Line"; EmployeeNo: Code[20]): Boolean
    var
        Assignment: Record "HR Employee Target Assignment";
    begin
        Assignment.Reset;
        Assignment.SetRange("Department Target No", DeptLine."Department Target No");
        Assignment.SetRange("Target Line No", DeptLine."Line No");
        Assignment.SetRange("Employee No", EmployeeNo);
        Assignment.SetRange("Appraisal Year", "Appraisal Year");
        exit(not Assignment.IsEmpty);
    end;

    procedure AssignAllLinesToEmployee(EmployeeNo: Code[20])
    var
        DeptLine: Record "HR Department Target Line";
        Assignment: Record "HR Employee Target Assignment";
        AssignmentCount: Integer;
    begin
        TestField("Target No");
        TestField("Responsibility Center");

        if EmployeeNo = '' then
            Error('Please specify an employee.');

        DeptLine.Reset;
        DeptLine.SetRange("Department Target No", "Target No");
        if DeptLine.FindSet then begin
            AssignmentCount := 0;
            repeat
                if not AssignmentExists(DeptLine, EmployeeNo) then begin
                    Assignment.Init;
                    Assignment."Department Target No" := "Target No";
                    Assignment.Validate("Department Target No");
                    Assignment."Target Line No" := DeptLine."Line No";
                    Assignment.Validate("Target Line No");
                    Assignment."Employee No" := EmployeeNo;
                    Assignment.Validate("Employee No");
                    Assignment.Insert(true);
                    AssignmentCount += 1;
                end;
            until DeptLine.Next = 0;

            if AssignmentCount > 0 then
                Message('%1 target line(s) assigned to employee %2.', AssignmentCount, EmployeeNo)
            else
                Message('No new assignments created. Employee may already have all targets assigned.');
        end else begin
            Error('No target lines found for this department target.');
        end;
    end;
}