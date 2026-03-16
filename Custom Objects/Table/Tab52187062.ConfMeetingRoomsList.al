table 52187062 "Conf & Meeting Rooms List"
{
    Caption = 'Conf & Meeting Rooms List';
    DataClassification = ToBeClassified;
    // LookuppageID = "Mwalimu Conf & Mtng Rooms List";
    // DrilldownPageID = "Mwalimu Conf & Mtng Rooms List";
    
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                MembNoSeries.Get;
                NoSeriesMgt.TestManual(MembNoSeries."Conference Creation Nos.");
                "No. Series" := '';
            end;
            end;
        }
        field(2; "Room Name"; Text[100])
        {
            Caption = 'Room Name';
        }
        field(3; "Room Status"; Option)
        {
            Caption = 'Rooms Status';
            OptionMembers = "Available", "Booked", "Closed";
        }
        field(4; "Floor Location"; Code[20])
        {
            Caption = 'Floor Location';
            //OptionMembers = "Ground Floor", "M1", "M2", "Floor 1", "Floor 2";
            //TableRelation = Floor."Floor Code" WHERE("No." = FIELD("Property No."));
            //TableRelation = Floor."Floor Code";
            TableRelation = "Floor Codes";    
        }
        field(5; "Global Dimension 1 Code"; Code[20])
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

        }
        field(8; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
        field(9; "Created At"; Date)
        {
            Caption = 'Created Date';
        }
        field(10; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility CenterBR";
        }
        field(11; "No. Series"; Code[20])
        {
            Caption = 'No Series';
        }
        field(12; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(13; Department; Text[200] )
        {
            Caption = 'Department';
            TableRelation = "Responsibility CenterBR";
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
        fieldgroup(Dropdown; "No.", "Room Name", "Floor Location", "Room Status")
        {
        }
    
    }
    
    trigger OnInsert()

    Var
        UserSetup: Record "User Setup";
        SeriesSetup: Record "Credit Nos. Series";
    begin
        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Conference Creation Nos.");
            "No." := NoSeriesMgt.GetNextNo(SeriesSetup."Conference Creation Nos.");
            // NoSeriesMgt.InitSeries(SeriesSetup."Conference Creation Nos.", xRec."No. Series", 0D, "No.", "No. Series");

        end;
        "Created By" := userID;
        "Created at" := Today;

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
        MembNoSeries: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit "No. Series";
        XValue: code[50];
        RecordID: Code[50];
}
