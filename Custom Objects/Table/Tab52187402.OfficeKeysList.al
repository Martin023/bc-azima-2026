table 52187402 "Office Keys List"
{
    Caption = 'Office Keys List';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Key Details";
    LookupPageId = "Key Details";
    
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."Key No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(5; "Key Category"; Option)
        {
            OptionMembers = " ", "Office", "Meeting Room", "Store", "Others";
            OptionCaption = ' , Office, Meeting Room, Store, Others';
        }
        field(2; "Key Number"; Code[20])
        {
            Caption = 'Key Number';
        }
        field(3; Department; Text[200] )
        {
            Caption = 'Department';
            TableRelation = "Responsibility CenterBR";
        }
        field(4; "Office/Store/Room Name"; Text[50])
        {
            Caption = 'Office/Store/Room Name';
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin

            end;
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin

            end;
        }
        field(7; Status; Enum "Workflow Status Main Flags")
        {
            Caption = 'Status';
        }
        field(22; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility CenterBR";
        }
        field(10; "Key Status"; Option)
        {
            OptionMembers =  Creation,Created,Inactive,Available,Issued;
        }
        field(11; "Created at"; DateTime)
        {
            Caption = 'Created at';
        }
        field(12; "Created By"; Code[20])
        {
            Caption = 'Created By';
        }
        field(13; "No. Series"; Code[20])
        {
            Caption = 'No Series';
        }  
        field(14; Floor; Code[20])
        {
            TableRelation = "Floor Codes";
            Trigger OnValidate()
            begin

            end;

        }
        field(15; "User ID"; Code [50]){}
        field(16; "Other Key Category"; Text[50]){}
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
        fieldgroup(Dropdown; "No.", "Key Category", "Department", "Office/Store/Room Name")
        {
        }
    }
    Trigger OnInsert()
    begin

        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Key No.");
            "No." := NoSeriesMgt.GetNextNo(SeriesSetup."Key No.");
            // NoSeriesMgt.InitSeries(SeriesSetup."Key No.", xRec."No. Series", 0D, "No.", "No. Series");
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
        NoSeriesMgt: Codeunit "No. Series";
        HREmployees: Record "HR Employees";
        //OfficeKeysList: Record "Office Keys List";
        UserSetup: Record "User Setup";
}
