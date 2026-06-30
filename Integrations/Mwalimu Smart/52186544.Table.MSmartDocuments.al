table 52186544 "M-Smart Documents"
{
    Caption = 'M-Smart Documents';
    DataClassification = SystemMetadata;
    DataPerCompany = false;

    // LookupPageId = "M-Smart Documents List";
    // DrillDownPageId = "M-Smart Documents List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."M-Smart Documents Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "No. Series"; Code[20])
        {
            Editable = false;
        }
        field(3; "Member No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;
            Editable = false;

            trigger OnValidate()
            begin
                CalcFields("Member Name");
            end;
        }
        field(4; "Member Name"; Text[80])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Member No.")));
        }
        field(5; "Document Type"; Enum "M-Smart Documents")
        {
            Caption = 'Document Type';
            Editable = false;
        }
        field(6; "Landing Department"; Enum "Responsibility Center Enum")
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("M-Smart Documents Setup"."Landing Department" where("Document Type" = field("Document Type")));
        }
        field(7; Status; Enum "Workflow Status Main Flags")
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Last Updated By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Last Updated At"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Responsible Officer"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."User ID" where("Record ID" = field("No.")));
        }
        field(11; "Supervisor ID"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."Supervisor ID" where("Record ID" = field("No.")));
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
        GlobalFunctions: Codeunit "Global Functions";
        DepartMent: Enum "Responsibility Center Enum";
        SubDepartments: Enum "Sub Module";
    begin
        if "No." = '' then begin

            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."M-Smart Documents Nos.");
            "No." := NoSeriesMgt.GetNextNo(SeriesSetup."M-Smart Documents Nos.");
            // NoSeriesMgt.InitSeries(SeriesSetup."M-Smart Documents Nos.", xRec."No. Series", 0D, "No.", "No. Series");

        end;

        if "Landing Department" = "Landing Department"::RECORDS then begin
            if not GlobalFunctions.AssignUserTasks(DepartMent::RECORDS, SubDepartments::"Member Edits(M-Smart)", "No.") then
                Message('Auto asign of tasks to users has failed. Please make sure that you have present users or contact your system administrator');
        end;

    end;

    trigger OnModify()
    begin
        "Last Updated By" := UserId;
        "Last Updated At" := CurrentDateTime;
    end;

    var
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
}
