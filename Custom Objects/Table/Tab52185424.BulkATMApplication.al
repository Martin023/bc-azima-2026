table 52185424 "Bulk ATM Application"
{
    Caption = 'Bulk ATM Application';
    DrillDownPageId = "Bulk Atm List";
    LookupPageId = "Bulk Atm List";
    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
            trigger OnValidate()
            begin
                if "No" <> xRec."No" then begin
                    SeriesSetup.Get;
                    SeriesSetup.TestField("Bulk ATM Application");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Captured By"; Code[20])
        {
            Caption = 'Captured By';
        }
        field(3; "Date Captured"; Date)
        {
            Caption = 'Date Captured';
        }
        // field(4; Unit; Text[50])
        // {
        //     Caption = 'Unit';
        // }
        field(5; Comments; Text[200])
        {
            Caption = 'Comments';
        }
        field(6; Status; Enum "Workflow Status Main Flags")
        {
            Caption = 'Status';
        }
        field(7; "Posted"; Boolean)
        {
            Caption = 'Posted ';
        }
        field(8; "Posted By "; Code[20])
        {
            Caption = 'Posted By ';
        }
        field(9; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(10; "No. Series"; Code[50])
        {
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()

    var
        UserSetup: Record "User Setup";
    begin
        if "No" = '' then begin

            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Bulk ATM Application");

            if NoSeries.AreRelated(SeriesSetup."Bulk ATM Application", xRec."No. Series") then
                "No. Series" := xRec."No. Series" else
                "No. Series" := SeriesSetup."Bulk ATM Application";
            Rec."No" := NoSeries.GetNextNo("No. Series", WorkDate());
        end;

        "Captured By" := UserId;
        "Date Captured" := today;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
        end;
    end;

    var
        SeriesSetup: Record "Credit Nos. Series";
        NoSeries: Codeunit "No. Series";
}

