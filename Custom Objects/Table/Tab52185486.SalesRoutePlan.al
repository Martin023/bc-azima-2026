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
        field(2; Desription; Text[1000])
        {
            Caption = 'Desription';
        }
        field(3; "Place to visit"; Code[50])
        {
            Caption = 'Place to visit';
        }
        field(4; Achievements; Integer)
        {
            Caption = 'Achievements';
            Editable = false;
        }
        field(5; Leads; Integer)
        {
            Caption = 'Leads';
            Editable = false;
        }
        field(6; Status; Option)
        {
            OptionMembers = Active,Closed;
            Caption = 'Status';
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
    end;

    var
        MembNoSeries: Record "Credit Nos. Series";
        NoSeries: Codeunit "No. Series";
}
