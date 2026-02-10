table 52187364 "Key Request Table"
{
    Caption = 'Key Request Table';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Key Request List";
    LookupPageId = "Key Request List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."Key Request No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Staff Number"; Code[20])
        {
            Caption = 'Staff Number';
            TableRelation = "HR Employees"."No.";
            trigger OnValidate()
            begin
                //HREmployees.RESET;
                //HREmployees.GET;
                HREmployees.RESET;
                HREmployees.SetRange("No.", "Staff Number");
                IF HREmployees.Find('-') then begin
                    Name := HREmployees."Full Name";
                end;
            end;
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(4; "Department Code"; Code[20])
        {
            Caption = 'Department';
            TableRelation = "Responsibility CenterBR";
        }
        field(5; "Purpose of Request"; Text[50])
        {
            Caption = 'Purpose of Request';
        }
        field(6; "Key Status"; Option)
        {
            OptionMembers = Open,Requested,Issued,Received,Returned,Dispatched,Closed;
            Caption = 'Key Status';
        }
        field(7; "Department Name"; Text[80])
        {
            Caption = 'Department Name';
            TableRelation = "Responsibility CenterBR";
        }

        field(8; "Key No."; Code[100])
        {
            Caption = 'Key No.';
            TableRelation = "Office Keys List"."No.";
            trigger OnValidate()
            begin
                OfficeKeysList.RESET;
                OfficeKeysList.Get("Key No.");
                OfficeKeysList.SetRange("Key Number","Key No.");
                OfficeKeysList.Setrange("Key Status", OfficeKeysList."Key Status"::Created);
                if OfficeKeysList."Key Number" <> '' then begin
                "Key Room Name" := OfficeKeysList."Office/Store/Room Name";
                end;
            end;
        }
        field(9; "Key Room Name"; Text[50])
        {
            Caption = 'Key Name';
        }
        field(10; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(11; "Date of Request"; Date)
        {
        }
        field(13; "Date of Issue"; DateTime)
        {
        }
        field(14; "Created by"; Code[50])
        {
            Caption = 'Created by';
            TableRelation = "User Setup"."User ID";
        }
        field(15; "Created at"; DateTime)
        {
            Caption = 'Created at';
        }
        field(16; "Originating Branch"; Code[20])
        {
            Caption = 'Originating Branch';
        }
        // field(17; "Department"; Code[20])
        // {
        //     Caption = 'Department Code';
        // }
        field(19; Status; Enum "Workflow Status Main Flags")
        {
            Caption = 'Status';
        }
        field(22; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility CenterBR";
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin

            end;
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin

            end;
        }
        field(25; "User ID"; Code[50])
        {
            Caption = 'User ID';
            //TableRelation = "User Setup"."User ID";
        }
        field(26; "Name of Room/Office"; Text[50])
        {
            Caption = 'Name of Room/Office';
        }
        field(27; "Date Received"; DateTime)
        {
            Caption = 'Date Received';
        }
        field(28; "Date Returned"; DateTime)
        {
            Caption = 'Date Returned';
        }
        field(29; Dispatched; Boolean)
        {
            Caption = 'Dispatched';
        }
        field(30; Received; Boolean)
        {
            Caption = 'Received';
        }
        field(31; "Dispatched By"; Code[50])
        {
            Caption = 'Dispatched By';
            //TableRelation = "User Setup"."User ID";
        }
        field(32; Returned; Boolean)
        {
            Caption = 'Returned';
        }
        field(33; Closed; Boolean)
        {
            Caption = 'Closed';
        }
        field(34; "Date Closed"; DateTime)
        {
            Caption = 'Date Closed';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(Dropdown; "No.", "Staff Number", Name)
        {
            
        }
    }
    Trigger OnInsert()
    begin

        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Key Request No.");
            NoSeriesMgt.InitSeries(SeriesSetup."Key Request No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Rec."Created at" := CURRENTDATETIME;
        Rec."Created By" := UserId;

        "User ID" := UserId;
        "Created By" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;
    end;

    var
        seriessetup: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HREmployees: Record "HR Employees";
        OfficeKeysList: Record "Office Keys List";
        UserSetup : Record "User Setup";
}
