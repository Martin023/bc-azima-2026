table 52187233 "Nominee Form Request"
{
    Caption = 'Nominee Form Request';
    DataClassification = ToBeClassified;
    LookupPageId = "Nominee Request Form List";
    DrillDownPageId = "Nominee Request Form List";


    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    MembNoSeries.Get;
                    NoSeriesMgt.TestManual(MembNoSeries."Nominee Form Req No");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No."; Code[50])
        {
            Caption = 'Member No.';
            TableRelation = Members."No.";
            trigger OnValidate()
            begin
                Members.Reset();
                Members.Get("Member No.");
                Members.SetRange("No.", Members."No.");
                if Members.Find('-') then
                    "Member Name" := Members.Name;
                "ID Number" := Members."Primary Identification";
            end;
        }
        field(3; "Member Name"; Code[100])
        {
            Caption = 'Member Name';
        }
        field(4; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
        field(5; "Created On"; DateTime)
        {
            Caption = 'Created On';
        }
        field(6; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility CenterBR".Code;
        }
        field(7; Status; Enum "Workflow Status Main Flags")
        {
            Caption = 'Status';
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(10; "User ID"; Code[20])
        {

        }
        field(11; "No. Series"; Code[20])
        {

        }
        field(12; Dispatched; Boolean)
        {

        }
        field(13; "Id Number"; Code[20])
        {

        }
        field(14; "Dispatched On"; DateTime)
        {

        }
        field(15; "Dispatched By"; Code[20])
        {

        }
        field(16; "Dispatch Comment"; Text[2000])
        {

        }
        field(17; "Send/Forward to"; Code[50])
        {
            TableRelation = "Responsibility CenterBR";
        }

        field(18; "Originating Department"; Code[50])
        {
            Editable = false;
        }
        field(19; "Current Department"; Code[50])
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
    begin
        if "No." = '' then begin
            MembNoSeries.Get;
            MembNoSeries.TestField(MembNoSeries."Nominee Form Req No");
            "No." := NoSeriesMgt.GetNextNo(MembNoSeries."Nominee Form Req No");
            // NoSeriesMgt.InitSeries(MembNoSeries."Nominee Form Req No", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "User ID" := UserId;
        "Created By" := userID;
        "Created On" := CurrentDateTime;
        "User ID" := UserId;
        "Created By" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
            UserSetup.TestField("Responsibility Centre");
            "Originating Department" := UserSetup."Responsibility Centre";
            "Current Department" := UserSetup."Responsibility Centre";
            CFPage.InsertTracker("No.", "Originating Department", true, UserId, CurrentDateTime);
        end;
    end;


    var
        GenLedgerSetup: Record "Cash Office Setup";
        NoSeriesMgt: Codeunit "No. Series";
        Usersetup: Record "User Setup";
        MembNoSeries: Record "Credit Nos. Series";
        Members: Record "Members";
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;

}
