table 52185473 "Dividend Header"
{
    Caption = 'Dividend Header List';
    DataClassification = ToBeClassified;
    LookUpPageID = "Dividend Header List";
    DrillDownPageId = "Dividend Header List";

    fields
    {
        field(1; "No."; Code[30])
        {
            Caption = 'No.';
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    DividendSetUp.Get();
                    NoSeriesMgt.TestManual(DividendSetUp."Div Header No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Year; Integer)
        {
            Caption = 'Year';
        }
        field(3; "Created By"; Code[30])
        {
            Caption = 'Created By';
        }
        field(4; "Created On"; Date)
        {
            Caption = 'CreatedOn';
        }
        field(5; "Global Dimension 1 Code"; Code[30])
        {
            Caption = 'Branch Code';
        }
        field(6; "Global Dimension 2 Code"; Code[30])
        {
            Caption = 'Activity Code';
        }
        field(7; "Responsibility Center"; Code[30])
        {
            Caption = 'Responsibility Center';
        }
        field(8; Status; Enum "Workflow Status Main Flags")
        {
            Caption = 'Status';
        }
        field(9; "No. Series"; Code[20])
        {
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
    var
        DepartMent: Enum "Responsibility Center Enum";

    begin
        if "No." = '' then begin
            DividendSetUp.Get;
            DividendSetUp.TestField(DividendSetUp."Div Header No.");
            "No." := NoSeriesMgt.GetNextNo(DividendSetUp."Div Header No.");
            if "No." = '' then
                Error('No. Series for Dividend Header is not setup. Please contact system administrator.');
        end;

        "Created On" := Today;
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
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        UserSetup: Record "User Setup";
        DividendSetUp: Record "Dividend SetUp";
}
