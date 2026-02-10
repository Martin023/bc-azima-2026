table 52186040 "Permission Requisition Lines"
{

    fields
    {
        field(1; "Header No"; Code[20])
        {
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Systems Affected"; Code[20])
        {
            TableRelation = "Systems Affected"."Systems Affected";

            trigger OnValidate()
            begin
                "Global Dimension 1 Code" := '';
                // "Global Dimension 2 Code" := '';
                "Responsibility Center" := '';
                Category := '';
                "Reason For Request" := '';
                "Employee No" := '';
                "Employee Name" := '';
                if PermissionRequisition.Get("Header No") then begin
                    HREmployees.Reset;
                    HREmployees.SetRange("No.", PermissionRequisition."Staff No");
                    if HREmployees.FindFirst then begin
                        "Global Dimension 1 Code" := HREmployees."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := HREmployees."Global Dimension 2 Code";
                        "Responsibility Center" := HREmployees."Responsibility Center";
                    end;
                end;
            end;
        }
        field(4; Category; Text[50])
        {
            // TableRelation = "User Group".Code;
            //TableRelation = "Reason For Request".Category WHERE("System Affected" = FIELD("Systems Affected"));
            //TableRelation = "Permission Set Buffer";

            trigger OnValidate()
            begin
                "Reason For Request" := '';
                "Employee No" := '';
                "Employee Name" := '';
            end;
        }
        field(5; "Reason For Request"; Text[250])
        {

            trigger OnValidate()
            begin
                "Employee No" := '';
                "Employee Name" := '';
            end;
        }
        field(6; "Employee No"; Code[30])
        {
            TableRelation = "HR Employees"."No." WHERE(Status = CONST(Active),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Code"));

            trigger OnValidate()
            begin
                TestField("Systems Affected");
                "Employee Name" := '';
                HREmployees.Reset;
                HREmployees.SetRange("No.", "Employee No");
                if HREmployees.FindFirst then "Employee Name" := HREmployees."Full Name";
            end;
        }
        field(7; "Employee Name"; Text[100])
        {
            FieldClass = Normal;
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(10; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(11; Granted; Boolean)
        {

            trigger OnValidate()
            begin
                "Granted\Denied By" := UserId;
                TestField("Header No");
                if PermissionRequisition.Get("Header No") then begin
                    if PermissionRequisition.Status <> PermissionRequisition.Status::"Pending Approval" then
                        Error('Document status must be %1', Format(PermissionRequisition.Status::"Pending Approval"));
                end;
            end;
        }
        field(12; "Granted\Denied By"; Code[20])
        {
            Editable = false;
        }
        field(13; Role; Code[50])
        {
            // TableRelation = "User Group Member"."User Group Code";

            //TableRelation = "Permission Set Buffer";
        }
        field(14; "Start Date"; Date)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Rec."Start Date" < TODAY then
                    Error('Start Date must be greater than or equal to %1', Format(TODAY));
            end;

        }
        field(15; "End Date"; Date)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Rec."End Date" < Rec."Start Date" then
                    Error('End Date must be greater than or equal to %1', Format(Rec."Start Date"));
                
            end;
        }
    }

    keys
    {
        key(Key1; "Header No", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HREmployees: Record "HR Employees";
        PermissionRequisition: Record "Permission Requisition";
        PermissionSet: Record "Permission Set Buffer";

}

