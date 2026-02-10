table 52187071 "User Termination"
{
    Caption = 'User Termination';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Request ID"; Code[30])
        {
            Caption = 'Reques tID';
            Editable = false;
            trigger OnValidate()
            begin
                if "Request ID" <> xRec."Request ID" then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."User Termination");
                    "No.Series" := '';
                end;
            end;
        }
        field(25; "Employment Type"; Code[30])
        {
            Editable = false;
        }
        field(26; Department; Code[30])
        {
            Editable = false;
        }

        field(27; "Phone No"; Code[30])
        {
            Editable = false;
        }
        field(28; "Full Name"; Code[30])
        {
            Editable = false;
        }
        field(11; "No.Series"; Code[10])
        {
            Editable = false;
        }
        field(10; "Staff No"; Code[30])
        {
            Editable = true;
            TableRelation = "HR Employees";

            trigger OnValidate()
            begin
                HREmployees.Reset;
                HREmployees.SetRange("No.", "Staff No");
                if HREmployees.Find('-') then begin
                    if HREmployees."User ID" <> '' then begin
                        Department := HREmployees."Global Dimension 1 Code";
                        "Phone No" := HREmployees."Cell Phone Number";
                        "Full Name" := HREmployees."Full Name";
                        "Employment Type" := HREmployees."Contract Type";
                        "User Name" := HREmployees."User ID";
                    end else
                        Error('This user has no UserID on the Hr Employee');
                end;
            end;
        }
        field(2; "Requester User ID"; Code[20])
        {
            Caption = 'Requester User ID';
            Editable = false;

        }
        field(3; "Target User ID"; Code[20])
        {
            Caption = 'Target User ID';
        }
        field(4; "Reason"; Text[250])
        {
            Caption = 'Reason';
        }
        field(5; "Request Date"; Date)
        {
            Caption = 'Request Date';
            Editable = false;

        }
        field(7; "Termination Reason"; Text[250])
        {
            Caption = 'Termination Reason';
            NotBlank = true;
        }
        field(13; "Terminate"; Boolean)
        {
            Caption = 'Terminate';
        }
        field(14; "Activate"; Boolean)
        {
            Caption = 'Activate';
        }
        field(12; "User Name"; Text[250])
        {
            Caption = 'User Name';
            NotBlank = true;

        }
        field(6; "Status"; Enum "Workflow Status Main Flags")
        {
            Caption = 'Status';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Request ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Request ID" = '' then begin

            SeriesSetup.Get();
            SeriesSetup.TestField(SeriesSetup."User Termination");
            NoSeriesMgt.InitSeries(SeriesSetup."User Termination", xRec."No.Series", 0D, "Request ID", "No.Series");
        end;

        "Request Date" := Today;

    end;

    trigger OnModify()
    begin
        "Request Date" := Today;
        //User := UserId;
        UserSetup.Reset;
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst then begin
            "Requester User ID" := UserId;
            Modify;
        end;
        Modify
    end;

    var
        HREmployees: Record "HR Employees";
        SeriesSetup: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        users: Record User;


}
