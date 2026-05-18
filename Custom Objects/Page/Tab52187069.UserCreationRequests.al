table 52187070 "User Creation Requests"
{
    Caption = 'User Creation Requests';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Request ID"; Code[20])
        {
            Caption = 'Request ID';
            Editable = false;

            trigger OnValidate()
            begin
                if "Request ID" <> xRec."Request ID" then begin
                    SeriesSetup.Get();
                    SeriesSetup.TestField("User Creation");

                    NoSeriesMgt.TestManual(SeriesSetup."User Creation");
                    "No.Series" := '';
                end;
            end;
        }

        field(2; "Request Type"; Option)
        {
            Caption = 'Request Type';

            OptionMembers =
                "Staff Account","Vendor Account","Change Rights","Deactivate User";

            OptionCaption =
                'Staff Account,Vendor Account,Change Rights,Deactivate User';
        }

        field(3; "Requester User ID"; Code[50])
        {
            Caption = 'Requester User ID';
            Editable = false;
        }

        field(4; "User Name"; Code[100])
        {
            Caption = 'Username';
        }

        field(5; "Authentication Email"; Text[100])
        {
            Caption = 'Authentication Email';
        }

        field(6; "Contact Email"; Text[100])
        {
            Caption = 'Contact Email';
        }

        field(7; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }

        field(8; "Request Date"; DateTime)
        {
            Caption = 'Request Date';
            Editable = false;
        }

        field(9; Status; Enum "Workflow Status Main Flags")
        {
            Caption = 'Status';
            Editable = false;
        }

        field(10; "Staff No."; Code[20])
        {
            Caption = 'Staff No.';
            TableRelation = "HR Employees";

            trigger OnValidate()
            begin
                PopulateEmployeeDetails();
            end;
        }

        field(11; "Full Name"; Text[100])
        {
            Caption = 'Full Name';
            Editable = false;
        }

        field(12; Department; Code[30])
        {
            Caption = 'Department';
            Editable = false;
        }

        field(13; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            Editable = false;
        }

        field(14; "Employment Type"; Code[50])
        {
            Caption = 'Employment Type';
            Editable = false;
        }

        field(15; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
        }

        field(16; "Approval Stage"; Option)
        {
            Caption = 'Approval Stage';

            OptionMembers =
                Open,HODApproval,ICTManagerApproval,ICTAction,Completed,Rejected;

            OptionCaption =
                'Open,HOD Approval,ICT Manager Approval,ICT Action,Completed,Rejected';
        }

        field(17; "Business Central Access"; Boolean)
        {
            Caption = 'Business Central Access';
        }

        field(18; "Core Banking Access"; Boolean)
        {
            Caption = 'Core Banking Access';
        }

        field(19; "AD Account Required"; Boolean)
        {
            Caption = 'AD Account Required';
        }

        field(20; "Email Account Required"; Boolean)
        {
            Caption = 'Email Account Required';
        }

        field(21; "Internet Access"; Boolean)
        {
            Caption = 'Internet Access';
        }

        field(22; "Intranet Access"; Boolean)
        {
            Caption = 'Intranet Access';
        }

        field(23; "Shared Folder Access"; Boolean)
        {
            Caption = 'Shared Folder Access';
        }

        field(24; "Server Access"; Boolean)
        {
            Caption = 'Server Access';
        }

        field(25; "Risk Level"; Option)
        {
            Caption = 'Risk Level';

            OptionMembers =
                Low,Medium,High;

            OptionCaption =
                'Low,Medium,High';
        }

        field(26; "SoD Conflict"; Boolean)
        {
            Caption = 'SoD Conflict';
            Editable = false;
        }

        field(27; "Business Justification"; Text[250])
        {
            Caption = 'Business Justification';
        }

        field(28; "Turnaround Time (Hours)"; Integer)
        {
            Caption = 'Turnaround Time (Hours)';
        }

        field(29; "Due Date Time"; DateTime)
        {
            Caption = 'Due Date Time';
        }

        field(30; "Completion Date Time"; DateTime)
        {
            Caption = 'Completion Date Time';
        }

        field(31; "Date Captured"; Date)
        {
            Caption = 'Date Captured';
            Editable = false;
        }

        field(32; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }

        field(33; "Last Modified By"; Code[50])
        {
            Caption = 'Last Modified By';
            Editable = false;
        }

        field(34; "No.Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
        }

        field(35; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
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
            SeriesSetup.TestField("User Creation");

            "Request ID" := NoSeriesMgt.GetNextNo(SeriesSetup."User Creation");
        end;

        "Date Captured" := Today;
        "Request Date" := CurrentDateTime;
        "Created By" := UserId;
        "Requester User ID" := UserId;
        "Approval Stage" := "Approval Stage"::Open;
    end;

    trigger OnModify()
    begin
        "Last Modified By" := UserId;
    end;

    local procedure PopulateEmployeeDetails()
    begin
        if "Staff No." = '' then
            exit;

        HREmployees.Reset();
        HREmployees.SetRange("No.", "Staff No.");

        if HREmployees.FindFirst() then begin

            "Full Name" := HREmployees."Full Name";

            Department := HREmployees."Global Dimension 1 Code";

            "Department Name" := HREmployees."Department Name";

            "Phone No." := HREmployees."Cell Phone Number";

            "Employment Type" := HREmployees."Contract Type";

            "Responsibility Center" := HREmployees."Responsibility Center";
        end;
    end;

    var
        HREmployees: Record "HR Employees";
        SeriesSetup: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit "No. Series";
        UserSetup: Record "User Setup";
}