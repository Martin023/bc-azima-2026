table 52186799 "Debt Collectors Header"
{
    Caption = 'Loan Reversal Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; code[50])
        {
            Editable = false;
        }
        field(2; "Debt Collector No."; Code[30])
        {
            TableRelation = Vendor."No." where("Vendor Type" = const("External Debt Collectors"));

            trigger OnValidate()
            begin
                CalcFields("Debt Collector Name");
            end;
        }
        field(3; "Debt Collector Name"; Text[100])
        {

            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No." = field("Debt Collector No.")));
        }

        field(5; "Entered By"; Code[50])
        {
            Editable = false;

        }
        field(6; "Entry Time"; DateTime)
        {
            Editable = false;
        }
        field(7; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
            end;
        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
            end;
        }
        field(9; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility CenterBR";
            Editable = false;
        }
        field(10; Closed; Boolean)
        {
            Editable = false;
        }
        field(11; "No. Series"; Code[20])
        {
        }
        field(12; Status; enum "Workflow Status Main Flags")
        {

            Editable = false;
        }
        field(13; "Responsible Officer"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."User ID" where("Record ID" = field("No.")));
        }
        field(14; "Supervisor ID"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."Supervisor ID" where("Record ID" = field("No.")));
        }
        field(15; "Date Closed"; DateTime)
        {
            Editable = false;
        }
        field(16; "Closed By"; Code[100])
        {
            Editable = false;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        SubDepartments: Enum "Sub Module";
        GlobalFunctions: Codeunit "Global Functions";
        CRMEdit: Record "CRM Member Edit";
    begin
        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."External Debt Collectors");
            "No." := NoSeriesMgt.GetNextNo(SeriesSetup."External Debt Collectors");
            // NoSeriesMgt.InitSeries(SeriesSetup."External Debt Collectors", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Entered By" := UserId;
        "Entry Time" := CurrentDateTime;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            UserSetup.TestField("Responsibility Centre");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end else
            Error('You must be set up in user setup');

        GlobalFunctions.InsertUserTasks(DepartMent::DMU, SubDepartmentS::"Debt Collectors", Rec."No.", UserId);

    end;

    var
        RecoveryHeader: Record "Loan Recovery Header";
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        UserSetup: Record "User Setup";
        DepartMent: Enum "Responsibility Center Enum";

}
