table 52187160 "Product SLA Setup"
{
    Caption = 'Product SLA Setup';
    DataClassification = ToBeClassified;

    LookupPageId = "Product SLA Setup List";
    DrillDownPageId = "Product SLA Setup List";

    DataCaptionFields = "SLA Code", Description, "SLA Timeline";

    fields
    {
        field(1; "SLA Code"; Code[20])
        {
            Caption = 'SLA Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "SLA Timeline"; Duration)
        {
            Caption = 'SLA Timeline';
        }
        field(4; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(5; "Created At"; DateTime)
        {
            Caption = 'Created At';
            Editable = false;
        }
        field(6; "Updated By"; Code[50])
        {
            Caption = 'Updated By';
            Editable = false;
        }
        field(7; "Updated At"; DateTime)
        {
            Caption = 'Updated At';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "SLA Code")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        TestField("SLA Code");
        TestField(Description);
        TestField("SLA Timeline");

        "Created By" := UserId;
        "Created At" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        TestField("SLA Code");
        TestField(Description);
        TestField("SLA Timeline");

        "Updated By" := UserId;
        "Updated At" := CurrentDateTime;
    end;
}
