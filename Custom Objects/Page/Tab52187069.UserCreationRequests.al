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
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."User Creation");
                    "No.Series" := '';
                end;
            end;
        }
        field(2; "Requester User ID"; Code[20])
        {
            Caption = 'Requester User ID';
            Editable = false;

            trigger OnValidate()
            begin
                UserSetup.Reset();
                UserSetup.SetRange("User ID", UserId);
                if UserSetup.FindFirst() then
                    "Requester User ID" := UserSetup."User ID";

            end;

        }
        field(3; "User name"; Code[50])
        {
            Caption = 'Username';
        }
        field(4; "Contact Email"; Code[50])
        {
            Caption = 'Contact Email';
        }
        field(5; "Request Date"; DateTime)
        {
            Caption = 'Request Date';

        }
        field(6; "Status"; Enum "Workflow Status Main Flags")
        {
            Caption = 'Status';
            Editable = false;
        }

        field(7; Departments; Text[250])
        {
            Caption = 'Departments';
            Editable = false;
        }
        field(9; "Phone No"; Text[250])
        {
            Caption = 'Phone No';
        }
        field(12; "Date Captured"; Date)
        {
            Editable = false;
        }
        field(15; "Employment Type"; Code[30])
        {
            Editable = false;
        }
        field(16; "Full Name"; Text[80])
        {
            Editable = false;
        }
        field(11; "No.Series"; Code[10])
        {
            Editable = false;
        }
        field(17; "Expiry Date"; DateTime)
        {
            Editable = true;
        }
        field(18; "Authentication Email"; Code[10])
        {
            Editable = true;
        }
        field(20; Department; Code[10])
        {
            Editable = false;
        }
        field(14; "Staff No"; Code[20])
        {
            Editable = true;
            TableRelation = "HR Employees";

            trigger OnValidate()
            begin
                HREmployees.Reset;
                HREmployees.SetRange("No.", "Staff No");
                if HREmployees.Find('-') then begin
                    Departments := HREmployees."Global Dimension 1 Code";
                    "Phone No" := HREmployees."Cell Phone Number";
                    "Full Name" := HREmployees."Full Name";
                    "Employment Type" := HREmployees."Contract Type";
                    UserSetup.Reset();
                    UserSetup.SetRange("User ID", UserId);
                    if UserSetup.FindFirst() then
                        "Requester User ID" := UserSetup."User ID";
                end;
            end;

        }
        field(13; User; Code[50])
        {
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
    //HERE
    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Request ID" = '' then begin

            SeriesSetup.Get();
            SeriesSetup.TestField(SeriesSetup."User Creation");
            // NoSeriesMgt.InitSeries(SeriesSetup."User Creation", xRec."No.Series", 0D, "Request ID", "No.Series");

            "Request ID" := NoSeriesMgt.GetNextNo(SeriesSetup."User Creation");
        end;

        "Date Captured" := Today;
        //"Request Date" := "Date Captured";

    end;

    trigger OnModify()
    begin
        "Date Captured" := Today;
        //"Request Date" := "Date Captured";
        User := UserId;
        UserSetup.Reset;
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst then begin
            //"Branch Code" := UserSetup."Global Dimension 2 Code";
            //"Responsibility Center":=UserSetup."Responsibility Centre";
            Modify;
        end;
        //Category:=Category::"1";
        Modify
    end;

    //HERE

    var
        HREmployees: Record "HR Employees";
        SeriesSetup: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit "No. Series";
        UserSetup: Record "User Setup";
}
