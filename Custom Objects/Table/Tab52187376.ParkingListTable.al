table 52187376 "Parking List Table"
{
    Caption = 'MSN Parking List Table';
    DataClassification = ToBeClassified;
    LookupPageId ="MNS Parking Space List";
    DrillDownPageID = "MNS Parking Space List";
    
    fields
    {
        field(1; "No"; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate()
            begin
                if "No" <> xRec."No" then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."Parking Creation No.");
                    "No. Series" := '';
                end;
            end;

        }
        field(2; "Parking Area"; Option)
        {
            Caption = 'Parking Area';
            OptionMembers = "", B1, B2, B3;        
        }
        field(3; "Parking Slot Number"; Integer)
        {
            Caption = 'Parking Slot Number';
        }
        field(4; "Parking Slot Status"; Option)
        {
            Caption = 'Parking Slot Status';
            OptionMembers = Available, Occupied;
        }
        field(5; "No. Series"; Code [20])
        {
        }
        field(6; "Created By"; Code[50])
        {

        }
        field(7; "Captured at"; Date)
        {

        }
        field(8; Status; Enum "Workflow Status Main Flags")
        {

        }
        field(9; Comments; Text[250])
        {
            
        }
        field(10; Created; Boolean)
        {
            Caption = 'Created';
        }
        field(11; "Created At"; Date)
        {
            Caption = 'Created Date';
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin

            end;
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin

            end;
        }
        field(14; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(15; "User ID"; Code[50])
        {
        }
        field(16; "Available B1"; Integer)
        {
            Caption = 'Available B1';
        }
        field(17; "Available B2"; Integer)
        {
            Caption = 'Available B2';
        }
        field(18; "Available B3"; Integer)
        {
            Caption = 'Available B3';
        }
    }
    keys
    {
        key(PK; "No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    Var
        UserSetup: Record "User Setup";
        SeriesSetup: Record "Credit Nos. Series";
    begin
        if "No" = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Parking Creation No.");
            NoSeriesMgt.InitSeries(SeriesSetup."Parking Creation No.", xRec."No. Series", 0D, "No", "No. Series");
        end;
        Rec."Created At" := Today;
        Rec."Created By" := UserId;
        //Rec.Created := false;

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
    NoSeriesMgt: Codeunit NoSeriesManagement;
    XValue: code[50];
    RecordID: Code[50];
    SeriesSetup: Record "Credit Nos. Series";
    ParkingList: Record "Parking List Table";
}
