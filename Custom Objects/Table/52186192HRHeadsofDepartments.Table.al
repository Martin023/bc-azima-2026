table 52186192 "HR Heads of Departments"
{

    fields
    {
        
        /*
        field(1; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                "Global Dimension 1 Name" := '';
                DimensionValue.Reset;
                DimensionValue.SetRange(DimensionValue.Code, "Global Dimension 1 Code");
                if DimensionValue.Find('-') then begin
                    "Global Dimension 1 Name" := DimensionValue.Name;
                end;
            end;
        }
        */
        field(2; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                "Global Dimension 2 Name" := '';
                DimensionValue.Reset;
                DimensionValue.SetRange(DimensionValue.Code, "Global Dimension 2 Code");
                if DimensionValue.Find('-') then begin
                    "Global Dimension 2 Name" := DimensionValue.Name;
                end;
            end;
        }
        /*
        field(3; "Global Dimension 1 Name"; Text[100])
        {
            Editable = false;
        }
        */
        field(4; "Global Dimension 2 Name"; Text[100])
        {
            CaptionClass = '1,1,2';
            Editable = false;
        }
        field(5; "Employee No."; Code[20])
        {
            TableRelation = "HR Employees"."No." WHERE(Status = CONST(Active));

            trigger OnValidate()
            begin
                "Employee Name" := '';
                "User ID" := '';
                "E-Mail Address" := '';
                "Responsibility center" := '';

                HREmp.Reset;
                HREmp.Get("Employee No.");
                begin
                    "Employee Name" := HREmp."Full Name";
                    HREmp.TestField(HREmp."User ID");
                    HREmp.TestField(HREmp."Company E-Mail");
                    "User ID" := HREmp."User ID";
                    "E-Mail Address" := HREmp."Company E-Mail";
                    "Responsibility center" := HREmp."Responsibility Center";
                end;
            end;
        }
        field(6; "Employee Name"; Text[100])
        {
            Editable = false;
        }
        field(7; "User ID"; Code[50])
        {
            Editable = false;
        }
        field(8; "E-Mail Address"; Text[60])
        {
            Editable = false;
        }
        field(9;"Responsibility center";Code[60])
        {
            Caption = 'Department';
            TableRelation = "Responsibility CenterBR".Code;
            
            trigger OnValidate()
            var
                RespCenter: Record "Responsibility CenterBR";
            begin
                if "Responsibility center" <> '' then begin
                    if RespCenter.Get("Responsibility center") then begin
                        // Department validated
                    end;
                end;
            end;
        }
        //APPROVAL WORKFLOW FIELDS ADDED
        field(10; Status; Enum "Workflow Status Main Flags")
        {
            Caption = 'Status';
            Editable = false;
        }
        field(11; "Created By"; Code[100])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(12; "Created Date"; Date)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(13; "Approved By"; Code[100])
        {
            Caption = 'Approved By';
            Editable = false;
        }
        field(14; "Approved Date"; Date)
        {
            Caption = 'Approved Date';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Responsibility center", "Employee No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    //TRIGGERS FOR AUDIT TRAIL
    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created Date" := Today;
        Status := Status::Open;
    end;

    var
        DimensionValue: Record "Dimension Value";
        HREmp: Record "HR Employees";
        UserSetup: Record "User Setup";

    //HELPER PROCEDURES FOR DEPARTMENT TARGETS INTEGRATION
    procedure CheckHODAccess(UserID: Code[50]; DepartmentCode: Code[20]): Boolean
    var
        HREmp: Record "HR Employees";
        HRHOD: Record "HR Heads of Departments";
    begin
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserID);
        if HREmp.Find('-') then begin
            HRHOD.Reset;
            HRHOD.SetRange(HRHOD."Employee No.", HREmp."No.");
            HRHOD.SetRange(HRHOD."Responsibility center", DepartmentCode);
            if HRHOD.Find('-') then
                exit(true);
        end;
        exit(false);
    end;

    procedure GetHODDepartments(UserID: Code[50]): Text
    var
        HREmp: Record "HR Employees";
        HRHOD: Record "HR Heads of Departments";
        DepartmentList: Text;
    begin
        DepartmentList := '';
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserID);
        if HREmp.Find('-') then begin
            HRHOD.Reset;
            HRHOD.SetRange(HRHOD."Employee No.", HREmp."No.");
            if HRHOD.Find('-') then begin
                repeat
                    if DepartmentList = '' then
                        DepartmentList := HRHOD."Responsibility center"
                    else
                        DepartmentList := DepartmentList + '|' + HRHOD."Responsibility center";
                until HRHOD.Next = 0;
            end;
        end;
        exit(DepartmentList);
    end;

    procedure IsHOD(UserID: Code[50]): Boolean
    var
        HREmp: Record "HR Employees";
        HRHOD: Record "HR Heads of Departments";
    begin
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserID);
        if HREmp.Find('-') then begin
            HRHOD.Reset;
            HRHOD.SetRange(HRHOD."Employee No.", HREmp."No.");
            if HRHOD.Find('-') then
                exit(true);
        end;
        exit(false);
    end;

    procedure GetHODEmployeeNo(UserID: Code[50]): Code[20]
    var
        HREmp: Record "HR Employees";
    begin
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserID);
        if HREmp.Find('-') then
            exit(HREmp."No.");
        exit('');
    end;
}

