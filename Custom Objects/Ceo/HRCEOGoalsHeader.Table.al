table 52185673 "HR CEO Goals Header"
{
    Caption = 'HR CEO Goals Header';
    DataClassification = CustomerContent;
    DrillDownPageId = "HR CEO Goals List";
    LookupPageId = "HR CEO Goals List";

    fields
    {
        field(1; "Goal No."; Code[20])
        {
            Caption = 'Goal No.';

            trigger OnValidate()
            begin
                if "Goal No." <> xRec."Goal No." then begin
                    HRSetup.Get();
                    NoSeriesMgt.TestManual(HRSetup."Appraisal Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Title; Text[100])
        {
            Caption = 'Title';
        }
        field(3; "Appraisal Period"; Date)
        {
            Caption = 'Appraisal Period';
            TableRelation = "HR Appraisal Period"."Appraisal Period";

            trigger OnValidate()
            var
                AppraisalPeriodRec: Record "HR Appraisal Period";
            begin
                if "Appraisal Period" <> 0D then begin
                    if AppraisalPeriodRec.Get("Appraisal Period") then begin
                        "Appraisal Year" := AppraisalPeriodRec."Appraisal Year";
                        "Review Sequence No." := AppraisalPeriodRec."Review Sequence No";
                        "Appraisal Cycle Stage" := AppraisalPeriodRec."Appraisal Cycle Stage";
                        "Period Start Date" := AppraisalPeriodRec."Period Start Date";
                        "Period End Date" := AppraisalPeriodRec."Period End Date";
                        "Appraisal Period Description" := AppraisalPeriodRec."Appraisal Period Description";
                    end;
                end;
            end;
        }
        field(4; "Appraisal Year"; Integer)
        {
            Caption = 'Appraisal Year';
            Editable = false;
        }
        field(5; "Review Sequence No."; Integer)
        {
            Caption = 'Review Sequence No.';
            Editable = false;
        }
        field(6; "Appraisal Cycle Stage"; Option)
        {
            Caption = 'Appraisal Cycle Stage';
            OptionCaption = 'Target Setting,Evaluation Review,Year-End Review';
            OptionMembers = "Target Setting","Evaluation Review","Year-End Review";
            Editable = false;
        }
        field(7; "Period Start Date"; Date)
        {
            Caption = 'Period Start Date';
            Editable = false;
        }
        field(8; "Period End Date"; Date)
        {
            Caption = 'Period End Date';
            Editable = false;
        }
        field(9; "Appraisal Period Description"; Text[100])
        {
            Caption = 'Period Description';
            Editable = false;
        }
        field(10; "CEO Employee No."; Code[20])
        {
            Caption = 'CEO Employee No.';
            TableRelation = "HR Employees"."No.";
            Editable = false;
        }
        field(11; "CEO Name"; Text[200])
        {
            Caption = 'CEO Name';
            Editable = false;
        }
        field(12; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Approved,Closed';
            OptionMembers = Open,Approved,Closed;
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
        field(15; "Created By"; Code[100])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(16; "Created Date"; Date)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(17; "No. Series"; Code[30])
        {
            Caption = 'No. Series';
            Editable = false;
        }
        field(18; "Total HOD Assignments"; Integer)
        {
            Caption = 'Total HOD Assignments';
            CalcFormula = Count("HR CEO Goal HOD Assignment" WHERE("Goal No." = FIELD("Goal No.")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(19; "Total Goal Lines"; Integer)
        {
            Caption = 'Total Goal Lines';
            CalcFormula = Count("HR CEO Goal Line" WHERE("Goal No." = FIELD("Goal No.")));
            FieldClass = FlowField;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Goal No.")
        {
            Clustered = true;
        }
        key(Key2; "Appraisal Year", "Review Sequence No.")
        {
        }
    }

    trigger OnInsert()
    var
        HREmp: Record "HR Employees";
    begin
        if "Goal No." = '' then begin
            HRSetup.Get();
            HRSetup.TestField("Appraisal Nos");
            "Goal No." := NoSeriesMgt.GetNextNo(HRSetup."Appraisal Nos");
            "No. Series" := HRSetup."Appraisal Nos";
        end;

        "Created By" := UserId;
        "Created Date" := Today;
        Status := Status::Open;

        HREmp.Reset();
        HREmp.SetRange("User ID", UserId);
        if HREmp.FindFirst() then begin
            "CEO Employee No." := HREmp."No.";
            "CEO Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
        end;
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit "No. Series";
}
