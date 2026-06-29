table 52185486 "Sales Route Plans"
{
    Caption = 'Sales Route Plans';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Sales Routes Plan List";

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
            Editable = false;
        }
        field(2; Target; Text[1000])
        {
            Caption = 'Activities/Target';

        }
        field(3; "Place to visit"; Code[50])
        {
            Caption = 'Place to visit';
        }
        field(4; Achievements; Text[1000])
        {
            Caption = 'Achievements';
            Editable = false;
            // FieldClass = flowfield;
            // CalcFormula = count("Route Achievements" where("Header No" = field(No)));
        }
        field(5; Leads; Integer)
        {
            Caption = 'Leads';
            Editable = false;
            FieldClass = flowfield;
            CalcFormula = count("Sales Leads Lines" where("Header No" = field(No)));
        }
        field(6; Status; Enum "Workflow Status Main Flags")
        {
            Caption = 'Status';
        }
        field(7; "Sales Representative"; Code[50])
        {
            Caption = 'Sales Representative';
            Tablerelation = "Marketing Teams Header"."Payroll No.";
        }
        field(8; "Route Date"; Date)
        {
            Caption = 'Route Date';
        }
        field(9; Day; Text[30])
        {
            Editable = false;
            Caption = 'Day';
        }
        field(10; "BDE Comments"; Text[1000])
        {
            Caption = 'BM/MO Comments';

        }
        field(11; "Created By"; Code[100])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(12; "Created Date"; Date)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(13; "Approved By"; Code[100])
        {
            Caption = 'Approved By';
            Editable = false;
        }
        field(14; "Approved Date"; Date)
        {
            Caption = 'Approved Date';
            Editable = false;
        }
        field(15; "Route End Date"; Date)
        {
            Caption = 'Route End Date';
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
    begin

        if No = '' then begin
            MembNoSeries.Get;
            MembNoSeries.TestField("Sales Route No.");
            No := NoSeries.GetNextNo(MembNoSeries."Sales Route No.");
            // NoSeriesMgt.InitSeries(ProdFac."Loan Nos", xRec."No. Series", 0D, "Loan No.", "No. Series");
        end;

        "Created By" := UserId;
        "Created Date" := Today;
        Status := Status::Open;
    end;

    var
        MembNoSeries: Record "Credit Nos. Series";
        NoSeries: Codeunit "No. Series";
}
