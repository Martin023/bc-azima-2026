table 52187221 "Legal Upcoming Matters"
{
    Caption = 'Legal Upcoming Matters';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Upcoming Matters";
    LookupPageId = "Upcoming Matters";
    
    fields
    {
        field(1; "Record ID"; Code[20])
        {
            Caption = 'Record ID';
        }
        field(2; Matter; Text[200])
        {
            Caption = 'Matter';
        }
        field(3; "Shceduled Date"; Date)
        {
            Caption = 'Shceduled Date';
        }
        field(4; "Captured By"; Code[50])
        {
            Caption = 'Captured By';
        }
        field(5; "Captured On"; DateTime)
        {
            Caption = 'Captured On';
        }
        field(6; "No"; Code[20])
        {
            Caption = 'No';
        }
        field(7; "Line No"; Integer)
        {
            Autoincrement = true;
        }
        field(8; "Matter Status"; Option)
        {
            OptionMembers = Upcoming, Closed, Cancelled;
        }
        field(10; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(11; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(12; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility CenterBR".Code;
        }
        field(13; "Case Number"; Code[100])
        {
            Caption = 'Case Number';
        }
    }
    keys
    {
        key(PK; "Record ID", "Line No")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    
    begin
        Rec."Captured On" := CURRENTDATETIME;
        Rec."Captured By" := UserId;
        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;
    end;

    var
    UserSetup: Record "User Setup";
}
