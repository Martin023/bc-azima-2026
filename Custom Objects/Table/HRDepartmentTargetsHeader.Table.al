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
        field(10; "Financial Targeted Score"; Decimal)
        {
            CalcFormula = Sum("HR Department Target Line"."Targeted Score" WHERE("Perspective Type" = FILTER("Financial Stewardship"),
                                                                                  "Department Target No" = FIELD("Target No")));
            Caption = 'Financial Targeted Score';
            FieldClass = FlowField;
        }
        field(11; "Customer Target Score"; Decimal)
        {
            CalcFormula = Sum("HR Department Target Line"."Targeted Score" WHERE("Perspective Type" = FILTER("Customer Sales"),
                                                                                  "Department Target No" = FIELD("Target No")));
            Caption = 'Customer Target Score';
            FieldClass = FlowField;
        }
        field(12; "Training Target Score"; Decimal)
        {
            CalcFormula = Sum("HR Department Target Line"."Targeted Score" WHERE("Perspective Type" = FILTER("Training and Development"),
                                                                                  "Department Target No" = FIELD("Target No")));
            Caption = 'Training Target Score';
            FieldClass = FlowField;
        }
        field(13; "Service Delivery Target Score"; Decimal)
        {
            CalcFormula = Sum("HR Department Target Line"."Targeted Score" WHERE("Perspective Type" = FILTER("Internal Service Delivery"),
                                                                                  "Department Target No" = FIELD("Target No")));
            Caption = 'Service Delivery Target Score';
            FieldClass = FlowField;
        }
        field(14; "Financial Achieved Score"; Decimal)
        {
            CalcFormula = Sum("HR Department Target Line"."Achieved Score" WHERE("Perspective Type" = FILTER("Financial Stewardship"),
                                                                                  "Department Target No" = FIELD("Target No")));
            Caption = 'Financial Achieved Score';
            FieldClass = FlowField;
        }
        field(15; "Customer Achieved Score"; Decimal)
        {
            CalcFormula = Sum("HR Department Target Line"."Achieved Score" WHERE("Perspective Type" = FILTER("Customer Sales"),
                                                                                  "Department Target No" = FIELD("Target No")));
            Caption = 'Customer Achieved Score';
            FieldClass = FlowField;
        }
        field(16; "Training Achieved Score"; Decimal)
        {
            CalcFormula = Sum("HR Department Target Line"."Achieved Score" WHERE("Perspective Type" = FILTER("Training and Development"),
                                                                                  "Department Target No" = FIELD("Target No")));
            Caption = 'Training Achieved Score';
            FieldClass = FlowField;
        }
        field(17; "Service Delivery Achieved"; Decimal)
        {
            CalcFormula = Sum("HR Department Target Line"."Achieved Score" WHERE("Perspective Type" = FILTER("Internal Service Delivery"),
                                                                                  "Department Target No" = FIELD("Target No")));
            Caption = 'Service Delivery Achieved';
            FieldClass = FlowField;
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
}