table 52185578 "Portfolio Manager"
{
    Caption = 'Portfolio Manager';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Portfolio Manager List";

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
            Editable = false;
        }
        field(2; "Sales Representative"; Code[20])
        {
            Caption = 'Sales Representative';
        }
        field(3; "Sales Rep Name"; Text[1000])
        {
            Editable = false;
            Caption = 'Sales Rep Name';
        }
        field(4; "No.of Members"; Integer)
        {
            Editable = false;
            Caption = 'No.of Members';
        }
        field(5; "Date"; Date)
        {
            Editable = false;
            Caption = 'Date';
        }
        field(6; Transfered; Boolean)
        {
            Editable = false;
            Caption = 'Transfered';
        }
        field(7; Comments; Text[1000])
        {
            Caption = 'Comments';
        }
        field(8; Status; Enum "ABS Blob Access Tier")
        {
            Editable = false;
            Caption = 'Status';
        }
        field(9; "Created By"; Code[30])
        {
            Editable = false;
            Caption = 'Created By';
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }

    trigger Oninsert()
    begin
        if No = '' then begin
            MembNoSeries.Get;
            MembNoSeries.testfield(MembNoSeries."Portfolio Manager");
            No := NoSeriesMgt.GetNextNo(MembNoSeries."Portfolio Manager");
            Date := Today();
            "Created By" := UserId();
        end;
    end;

    var
        NoSeriesMgt: Codeunit "No. Series";
        MembNoSeries: Record "Credit Nos. Series";
}
